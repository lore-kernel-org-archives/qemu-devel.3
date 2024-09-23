Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1D52CF9C5B
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2024 09:33:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ssfPY-0002Dv-2i; Mon, 23 Sep 2024 05:31:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1ssfPV-00025j-US; Mon, 23 Sep 2024 05:31:13 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1ssfPT-0006xg-9y; Mon, 23 Sep 2024 05:31:12 -0400
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-a8d2b24b7a8so940166866b.1; 
 Mon, 23 Sep 2024 02:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727083868; x=1727688668; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=w4QKCLTnYRmG6RbJry6AnrnojW0x9+VCIRXbxcRAKqY=;
 b=DHaLVgxo6VVLPM5cUV/BFL+h+bmrCxlWzDEJIEDvNeNGztLnwTe3OPvOjDXvkewEXH
 STdpYuhBWNDKT81u/xOFUbF3LiuEjeL+S7w9zL+g6fQu9LXPPZvcSvDy+l2Q8bTka/xn
 d5So9e5ZTFTNaMaWrsVuwI+eSKsI37oF3lAdgTkb0ac7aAR6nXIU2dyXYqJFpO/vn8j2
 iXGMVlhBE/sufw52RZVSee9NbKuwEwBmPxLTQnqdEju6KEXgWU94xv8Z82i6evheOpbT
 XlygGBO0M/DEkiYKWrpYqEM3Wh0DpwNZot2eeCNeiAH/frUTdvR230jhkrTFaI9Ae743
 7Mag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727083868; x=1727688668;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=w4QKCLTnYRmG6RbJry6AnrnojW0x9+VCIRXbxcRAKqY=;
 b=K0wD7zbc49WYyJXLv+hP7QB4/Zk8Zf5As7j4URU/IET8rEowNIywkO6wSXQglSZJjG
 f0fRuadVCybs0N7PTQ/9dXCKPU+0C2AEijE9KjcSvc2FVx3XVYeLMH2GJJVsRVijWXAt
 WtfH8Z1BUwWMKoFXoMx3qO6/vfOQZWFkR2g1U1sDV0EPAXywQ1kph1p4G3/GpGGtc6ml
 ZIDI0LMx/BNl3RZxNxu6Owq8paCX6QxFCCYkNOlyin+git7ya9hmy6UoZ9hMoCyPaQMa
 UYYNRTx9gXk5VqilaZiT0fzyUh+C3ODUx85+KwH0AMCRHtrnpI++Yn9AVpGfrrv6ogL9
 9vMA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUacCS3oRPF07xKBd1HRFhSclBHF7LF55jOASskpiInuQ5ia4xs26S89GyQwDtPeJ/t7Jq7uJ3hoCJY@nongnu.org,
 AJvYcCWiJ1+XNF8f896sujxWHilT8dW7hj0SUm4nvvNo9cTvLJuHf8bRv2Y1SZROTN25PG68Um+BzUB9kgU=@nongnu.org
X-Gm-Message-State: AOJu0YzNcHqRdY9nbP4ytIqiS55jQXCBWB2XN6wUSRECh1Lez5wBPkPu
 A5J33B6a4wGCzxizxVI5gFx39ehVo5TTJdnA468AK3voWu3IQHW3G8sb9w==
X-Google-Smtp-Source: AGHT+IGPr5k4lTfDwH8Hzdc+kNUjPn/92EN4rGVwxClEJG/iwvJPVOVc1ujyM8Ee/YYCEoDnxYji9Q==
X-Received: by 2002:a17:907:a0e:b0:a90:3494:2aa9 with SMTP id
 a640c23a62f3a-a90c1c363c1mr1628386966b.2.1727083868126; 
 Mon, 23 Sep 2024 02:31:08 -0700 (PDT)
Received: from archlinux.. (90-181-218-29.rco.o2.cz. [90.181.218.29])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a90612b3f6fsm1188747166b.107.2024.09.23.02.31.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Sep 2024 02:31:07 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Hanna Reitz <hreitz@redhat.com>, qemu-ppc@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Corey Minyard <cminyard@mvista.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-block@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>, Bin Meng <bmeng.cn@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH 05/23] hw/ppc/e500: Add missing device tree properties to i2c
 controller node
Date: Mon, 23 Sep 2024 11:29:58 +0200
Message-ID: <20240923093016.66437-6-shentey@gmail.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20240923093016.66437-1-shentey@gmail.com>
References: <20240923093016.66437-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x633.google.com
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

When compiling a decompiled device tree blob created with dumpdtb, dtc complains
with:

  /soc@e0000000/i2c@3000: incorrect #address-cells for I2C bus
  /soc@e0000000/i2c@3000: incorrect #size-cells for I2C bus

Fix this by adding the missing device tree properties.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 hw/ppc/e500.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
index 228287b457..e2a4f265a5 100644
--- a/hw/ppc/e500.c
+++ b/hw/ppc/e500.c
@@ -196,6 +196,8 @@ static void dt_i2c_create(void *fdt, const char *soc, const char *mpic,
     qemu_fdt_setprop_cells(fdt, i2c, "cell-index", 0);
     qemu_fdt_setprop_cells(fdt, i2c, "interrupts", irq0, 0x2);
     qemu_fdt_setprop_phandle(fdt, i2c, "interrupt-parent", mpic);
+    qemu_fdt_setprop_cell(fdt, i2c, "#size-cells", 0);
+    qemu_fdt_setprop_cell(fdt, i2c, "#address-cells", 1);
     qemu_fdt_setprop_string(fdt, "/aliases", alias, i2c);
 
     g_free(i2c);
-- 
2.46.1


