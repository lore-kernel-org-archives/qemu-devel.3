Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50C16CA5FE6
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Oct 2026 12:33:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDLJm-0006Ud-OG; Sun, 04 Oct 2026 08:27:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1xDLJk-0006Ta-Bz
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 08:27:48 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1xDLJh-000788-UM
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 08:27:48 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4a1688d7769so6422025e9.0
 for <qemu-devel@nongnu.org>; Sun, 04 Oct 2026 05:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791116864; x=1791721664; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6wgNCjnZg7PLB9EBi8rhxREYgokNtvLAhlvhjWMgxUE=;
 b=C/pZAwAWgdiFdV9CxscxazFAaqQrcdBpdLmgawXMOxRS3l7sKt2gBHtFFhmRewWNZH
 1y+jq0BTxDjUbJuyd7rAB0l5IZyW+1t8Nla0ofv+jqnJ0ACRHb6tipOybjcWFPa9ofb0
 VnUZh/nPUNbHOIJtMA/+J0rToKyr0JBOjyrv4oto0J3Mi8LGSBQb2HsaYzYIyZAoVLHI
 R4FRkw87P0wCEb1M2lg/x7xgzkmfJozHLmUnQp8luaHvuM9qhNjUGuqdLD4Q9cJDq9OW
 Rh2k1owmPiA4JFfQQYEshCvq3Zi4uZLADqKA4GT8mICbTwaBHo8YfkRHg+ZVQXE7Bi1u
 jRuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791116864; x=1791721664;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=6wgNCjnZg7PLB9EBi8rhxREYgokNtvLAhlvhjWMgxUE=;
 b=Lyacnr9Y8BJ3nJldxG4Bs52HEnTJVTBX+Ph9dvq76GnRDrGluiYi2FB3eBATe5mWjS
 sPQdUmEipbNRxuvLOdRUSzNard+9iG3+4/1KH9m5PEQ3yZ18CWdx/k4KjgpTGbf8nj/F
 2eoflwcJQv9PDEg3fc6w29IkzoovRzmqCPuzhr/RYK9LcQSo4jZCX3o9Rx3Ng1S/Pn1j
 bGr0X/7RchSPVxyTvMLl0ghYyJ9mgmZMqolTW7eY36zGL3NHcyExQToWZW3Nwa3AQ24J
 De9T2nMvPh4wT94/5mjiEH7BOoOariQkCihQttJOYFo9bHJKrcOnbh4xY6JmNKoU/jeK
 dKIw==
X-Gm-Message-State: AFuF++lILEShMyJS9ZPDgKC0e6ZCb8NV6ib2J+eoOkktLVMagveHSmp8
 BwNjAk8tO5qApVoy9Nm6YrTJhVRUHNDp07i5QM1uTD7dhoM57AMu8Lf4HV/wLQ==
X-Gm-Gg: AYBFou1V6hpCofY+DPjW9m2QNfbdfh+MODEunMWNOl36Vma8epNHummLPc4Bo5broP6
 FjWRvOsVkf/zPuRdWcAQu0ut84UjSIZRBdV0eRGSkeI4/i4ZB2Nrl67aKWSHRZddip+JzqD35te
 7MRE614gJU16/IRywsNDEK60NnThB1zgmnO7176uKJ7TGKx0MhvjIieDthIEqGMS9hKU8MP4mjf
 rUu+JZX1zr1DmWuBw+ykTxDpcjoA4xg0k+UBR3/DLwFL36tysAQuAjqqaKwXdnZqftu+0mx6R8Q
 F8XbkDrDTsilDd+eaiVxuQ+F+2/Txz3YFJ7+0EVIQC5vhECzjdODkMo+uPRnH9XFM7EqfCwHxaP
 dJBEQKSq6D3M7SnN0szz+lYj2PAXaPyhg+/Gbc692whYTv33aKeAPwWmuv3vdnHHi+nYJGbn5LW
 xpIY7Fn4QY3GFMfOTW6y6PuQo78RGeqfn3IlVhJB5Yg2ixdJgMi00sbDttroXpghecPMMirM4aA
 xsCSWf/lLbZDrkRTaCtgPpOOcw+B7i54YVWKA==
X-Received: by 2002:a05:600c:a00e:b0:4a1:706f:b40d with SMTP id
 5b1f17b1804b1-4a1706fb500mr18950465e9.7.1791116864448; 
 Sun, 04 Oct 2026 05:27:44 -0700 (PDT)
Received: from archlinux (pd95eda80.dip0.t-ipconnect.de. [217.94.218.128])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a027698f13sm242319975e9.1.2026.10.04.05.27.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Oct 2026 05:27:43 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Gaurav Sharma <gaurav.sharma_7@nxp.com>,
 Alistair Francis <alistair@alistair23.me>,
 Bernhard Beschow <shentey@gmail.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Jason Wang <jasowangio@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Bin Meng <bin.meng@processmission.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v2 08/30] hw/arm/mcimx6ul-evk: Have 512 MiB of RAM by default
Date: Sun,  4 Oct 2026 14:26:24 +0200
Message-ID: <20261004122647.3913-9-shentey@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261004122647.3913-1-shentey@gmail.com>
References: <20261004122647.3913-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Having 512 MiB of RAM matches real hardware. Fix the machine
default to make its use more ergonomic and less error-prone.

To reproduce the old default behavior for e.g. migration purposes,
`-m 128M` needs to be added to the command line.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 hw/arm/mcimx6ul-evk.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/arm/mcimx6ul-evk.c b/hw/arm/mcimx6ul-evk.c
index 40071d2c7b..4964cb9345 100644
--- a/hw/arm/mcimx6ul-evk.c
+++ b/hw/arm/mcimx6ul-evk.c
@@ -73,6 +73,7 @@ static void mcimx6ul_evk_machine_init(MachineClass *mc)
     mc->desc = "Freescale i.MX6UL Evaluation Kit (Cortex-A7)";
     mc->init = mcimx6ul_evk_init;
     mc->max_cpus = FSL_IMX6UL_NUM_CPUS;
+    mc->default_ram_size = 512 * MiB;
     mc->default_ram_id = "mcimx6ul-evk.ram";
     mc->auto_create_sdcard = true;
 }
-- 
2.56.0


