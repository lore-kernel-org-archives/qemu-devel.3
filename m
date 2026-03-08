Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8086EA8543
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Mar 2026 22:38:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzMlf-0001Iy-KF; Sun, 08 Mar 2026 18:38:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzMlO-0000ZJ-2L
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 18:38:20 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzMlM-0003bd-IL
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 18:38:17 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-48534e9076fso4359345e9.0
 for <qemu-devel@nongnu.org>; Sun, 08 Mar 2026 15:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773009494; x=1773614294; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=GvUVBcZDjzFhxJC1/LgqFuCi6urkQ6s14SjPt7T3TEs=;
 b=R60U7aD8MD0ujRJAHECOeRRZK/GxpCipxoqNLU/VhQ8nGIe/h0gcBPQmkM2e51pWpL
 d5jd3kiFJu5g9ieOimQoXq57lf783aCzkcGl1FFzn7Xl8Sj/3hupcYhKabDFIOAztsDD
 GnaF65g5fPzVftiYqGyg+nPnkOq8MuD0akoZqT39nU1K7y0Jd1Q+doIs7W3TSTGkNyO4
 XgwMSrYhcTz+wXafqQ0jo5s4j6eYT5Wh2dcdMu69z5iDtb0bze3mwsAAC+1psQfh1LHB
 9THxAIZ4+1LZ6K+kTXBQfDiSpkEwu+bEGEas7mDQW11sktEW/2fdCz+Y2z+HmkOz2VM0
 +Eug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773009494; x=1773614294;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=GvUVBcZDjzFhxJC1/LgqFuCi6urkQ6s14SjPt7T3TEs=;
 b=BQylHMMZSSt8M/jwUJpl+hKcUNWdSO1mWwQbMQvItXuPebp4K5lY6JQMqvjdZw2THM
 sTMBVZbArvimplJ4uCDtIGCMFGxv2/eBrKODVCCQ1Y0iO7Eri0g/7Y/ujLDm2C/CKnwA
 oqSwuiunrelCKi1evikJtyC9zK13qxq7vGi8rXPHnwfJkAgfL5yu/o0JZfrkknfTCds2
 8CEdso/e4Z/HAdt6Fh1iU1ZOtIIN7dwStta35r+CIiZngYQVuqJ/it3mK5EEzzRD9d23
 wtQ6LDVHOe8K6X/AP/40T9j+3YqNpdAr2GiHTG1p1gQfksmydoxL8HWGNFF92IsijTEH
 PMvw==
X-Gm-Message-State: AOJu0YzErYkVWXlpiaz2Wi3kXMPucgc48Tb1B9LkporheZsYfwWfpEPm
 K9XE/LoOSVqKRnkISSHFY8qE2AdVSx3rxUCyaxhwvOQzF25ZEiapz19n9aKiUeM78BCnXxkSGpE
 5mveQNbk=
X-Gm-Gg: ATEYQzyU8vQDduCz0uxALPh5iegB/BjtudKgEii56caWTs8ywo71oFrLCbOcdN4lPhQ
 3uyDC+JMAW8X+i7jP5knkGZI5SCXVwe7w6+ilW+NSNIsiDJGemPaoPe5mHGSKzUQZzSDLvQwtTn
 4UEQ4hMrTPiVHTHQJtXDtXiKbvNxK/e3k73CHOsbxZK2JB3cfHN9YUE+Qp0T3dtdW21/wAulmtN
 bHm3pGkKW3cUik02xUDUqfhXfmdSGORGamkeiN3rcX6Tf6+AzDyCxi9GtlFb5BDGY53LkfNefoM
 aXWdzMBemjtCKq3NXaJXX0XZg5E8h3z0LGlQSHxDwlWDpjvQfCapN0r2IkK8VwLUcTZPeDtBLD2
 dgccvJcPChH/hzLvHUPgk15ILXBT9RUIJy5+DRMjEKLz1HC2XKF4I24CISqkRsxGY1gYbZJQlZA
 860upShWkCPgDCIa8RPWSLXnRZiS5mZTtrBGOZrllSWUmHeolwdDXvxDPQn5Sn39/FHXrPw9CTj
 GlMvQ==
X-Received: by 2002:a05:600c:c16d:b0:480:39ad:3b7c with SMTP id
 5b1f17b1804b1-485269582fbmr173229825e9.16.1773009494212; 
 Sun, 08 Mar 2026 15:38:14 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4853a498afbsm30116055e9.0.2026.03.08.15.38.13
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 08 Mar 2026 15:38:13 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 32/49] hw/char/{diva-gsp,
 serial-pci-multi}: Fix deinitialization order
Date: Sun,  8 Mar 2026 23:34:16 +0100
Message-ID: <20260308223433.25503-33-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260308223433.25503-1-philmd@linaro.org>
References: <20260308223433.25503-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

From: Bernhard Beschow <shentey@gmail.com>

The memory region is owned by the device being unrealized, so must be
removed from the mapping before unrealizing.

Fixes: d66bbea4e0d3 ("serial: add 2x + 4x pci variant")
Fixes: 274074708455 ("hw/char: Add emulation of Diva GSP PCI management boards")
Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Message-ID: <20260305220911.131508-3-shentey@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/char/diva-gsp.c         | 2 +-
 hw/char/serial-pci-multi.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/char/diva-gsp.c b/hw/char/diva-gsp.c
index 280d0413c6e..f9aa6e326d6 100644
--- a/hw/char/diva-gsp.c
+++ b/hw/char/diva-gsp.c
@@ -62,8 +62,8 @@ static void diva_pci_exit(PCIDevice *dev)
 
     for (i = 0; i < pci->ports; i++) {
         s = pci->state + i;
-        qdev_unrealize(DEVICE(s));
         memory_region_del_subregion(&pci->membar, &s->io);
+        qdev_unrealize(DEVICE(s));
         g_free(pci->name[i]);
     }
     qemu_free_irqs(pci->irqs, pci->ports);
diff --git a/hw/char/serial-pci-multi.c b/hw/char/serial-pci-multi.c
index 17796b93dd7..7782452018d 100644
--- a/hw/char/serial-pci-multi.c
+++ b/hw/char/serial-pci-multi.c
@@ -56,8 +56,8 @@ static void multi_serial_pci_exit(PCIDevice *dev)
 
     for (i = 0; i < pci->ports; i++) {
         s = pci->state + i;
-        qdev_unrealize(DEVICE(s));
         memory_region_del_subregion(&pci->iobar, &s->io);
+        qdev_unrealize(DEVICE(s));
         g_free(pci->name[i]);
     }
 }
-- 
2.53.0


