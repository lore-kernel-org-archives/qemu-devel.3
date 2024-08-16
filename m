Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D7ECC531DC
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2024 16:08:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sezUV-0006mi-HF; Fri, 16 Aug 2024 12:07:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1sezUU-0006hm-DV
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 12:07:50 -0400
Received: from mail-lj1-x22f.google.com ([2a00:1450:4864:20::22f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1sezUS-0006dV-Ou
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 12:07:50 -0400
Received: by mail-lj1-x22f.google.com with SMTP id
 38308e7fff4ca-2f189a2a841so21180391fa.3
 for <qemu-devel@nongnu.org>; Fri, 16 Aug 2024 09:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1723824467; x=1724429267; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WNNXeelPOnbPZtUJAjYtFQG8OkFpC8YF3Gls2B+q2q0=;
 b=IN7VumV5XDI4F99GRyN3ucE71oxuR3ZTFAy4gVTuzO0g9MhDHd+QxD1OMd5KvBXukA
 TpsD0mFYZ7I0IpAW0TmZ3I3+bbHcdsMhu/FHYqIME0mg8pTk8B6pkx198ws6D8UVDvbf
 rTz12EMvE0UFDBMVAUTeLRig4esiXPFJZEvHeek1VHrE7PgF1EHWSJOfFKIAyzh0Msya
 g4wPSr3kA8fsQhPTtrUIyPeKdm4tJWwpFJucYgqYfLQLvjQQBFSyon30etjcUL2vE6os
 mn95CCH/p906pjD+dt7HPVGYDvurgbEL5nY255ar7MYj1zYr3L8WV61Bw5CXPDIC8oph
 y0eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723824467; x=1724429267;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WNNXeelPOnbPZtUJAjYtFQG8OkFpC8YF3Gls2B+q2q0=;
 b=VZeFgKwnBbSlZPlsnej1cZQoobeVbttDVAaVDDw9GhPZMEQB1aRlkhqs/LXDyR/MfZ
 hzWdue1iWzyWrXK/1sA3rlNuTnkb8Jcx1bodyEtX3v9ePwq60Sryo1rqpos1NVmlgOkl
 7jHXMlezXxl/KvYYQ4CZj/eC4OuMIiE+uDUbWoTQ2wKA5widdMr4GHJFWSFq4I29ByA9
 jPdq3kgefvry38VteDdquSa7NjXro40oCxEUY5tVOIov11dvWGR1tXNCWAjYQPWz1AzB
 vD37r0n/mTq2Thi0oqV2MBAHQGzOULH/uipjoH1wJE+3yic4vKX8efSxS4Q/Q7ZOAoX9
 4ejg==
X-Gm-Message-State: AOJu0YxNNfPRN9bNyT/vF1aBlTjh6f6VSOlajIngjHrU0fTRziJTIS3n
 SJNfhfNqYOdRFBwNGJ77v9oK2e8Ljr1wZRwJpy7aZWlowQukSrW16sbq5b7eapYZU3nr5IBZPqD
 AfaQ=
X-Google-Smtp-Source: AGHT+IE9kmK71F+E4nvvpaPavO+wwV+dXTaUNjLR3hOu4V8VzHEv9hVqPMeGFP9Lf3VBoHnY+m883Q==
X-Received: by 2002:a05:6512:4004:b0:52e:9beb:a2e2 with SMTP id
 2adb3069b0e04-5331c69777emr2664880e87.19.1723824465895; 
 Fri, 16 Aug 2024 09:07:45 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz.
 [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a838396c14fsm272659566b.211.2024.08.16.09.07.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Aug 2024 09:07:45 -0700 (PDT)
From: Andrew Jones <ajones@ventanamicro.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: palmer@dabbelt.com, alistair.francis@wdc.com, bmeng.cn@gmail.com,
 dbarboza@ventanamicro.com, Anup Patel <apatel@ventanamicro.com>
Subject: [PATCH for-9.1 1/2] Revert "hw/riscv/virt.c: imsics DT: add
 '#msi-cells'"
Date: Fri, 16 Aug 2024 18:07:45 +0200
Message-ID: <20240816160743.220374-5-ajones@ventanamicro.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240816160743.220374-4-ajones@ventanamicro.com>
References: <20240816160743.220374-4-ajones@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22f;
 envelope-from=ajones@ventanamicro.com; helo=mail-lj1-x22f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This reverts commit f42cdf2ea5b3a1dc369792d7acbf9cd3e5c90815.

Linux does not properly handle '#msi-cells=<0>' when searching for
MSI controllers for PCI devices which results in the devices being
unable to use MSIs. A patch for Linux has been sent[1] but until it,
or something like it, is merged and in distro kernels we should stop
adding the property. It's harmless to stop adding it since the
absence of the property and a value of zero for the property mean
the same thing according to the DT binding definition.

Link: https://lore.kernel.org/all/20240816124957.130017-2-ajones@ventanamicro.com/ # 1
Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
---
 hw/riscv/virt.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 9981e0f6c9b9..cef41c150aaf 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -552,7 +552,6 @@ static void create_fdt_one_imsic(RISCVVirtState *s, hwaddr base_addr,
                           FDT_IMSIC_INT_CELLS);
     qemu_fdt_setprop(ms->fdt, imsic_name, "interrupt-controller", NULL, 0);
     qemu_fdt_setprop(ms->fdt, imsic_name, "msi-controller", NULL, 0);
-    qemu_fdt_setprop_cell(ms->fdt, imsic_name, "#msi-cells", 0);
     qemu_fdt_setprop(ms->fdt, imsic_name, "interrupts-extended",
                      imsic_cells, ms->smp.cpus * sizeof(uint32_t) * 2);
     qemu_fdt_setprop(ms->fdt, imsic_name, "reg", imsic_regs,
-- 
2.45.2


