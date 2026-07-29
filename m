Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 485A9C53219
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2026 15:41:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wp6Oh-0006BY-02; Wed, 29 Jul 2026 11:40:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1wp6Of-0006B4-OS
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 11:40:41 -0400
Received: from mail-wr1-f54.google.com ([209.85.221.54])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1wp6Oe-0001wS-8O
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 11:40:41 -0400
Received: by mail-wr1-f54.google.com with SMTP id
 ffacd0b85a97d-47f7854678bso583189f8f.3
 for <qemu-devel@nongnu.org>; Wed, 29 Jul 2026 08:40:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785339639; x=1785944439;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=T3QJvSJZGpsccP9EvkOCqQcE/jNtNeeQY/Ifg8+pe0I=;
 b=GIE1f8Qn0zmt3tVWcOopvCRWJlanE6gvm1Np7gVjoou2MCu4YJFZgNY4DwZBnbYSkM
 1iukn/f3ardNyW55sh1FeI7bUrfy8stgKLUwoJC4yfxIsp4ngjAthv4oU9FgpOf6y/j1
 jjZecXs2sli5iE99nHnPdX21nB/e8C+asTfUhFjl5srrrNdcTv4flSWMH44HXM5yoAZ8
 U/LMUuoXu9/r9g8HZD1d/BfT1Zkz3ugaTuTKhBkF5jh1Bjhv0Z5Cw2zeVZFr1d8wBrqj
 DqfzMzuW1yxsDQytoLbPCky2KS0e8tWuON+JW0UHn6q612UeZvv6/x9NQjSxH0M8HFAD
 14+g==
X-Gm-Message-State: AOJu0YzA1YLKUve7cmWIvcVRAx1daN3OkTBS6Yfih/eTGuYdt+3Yf9mh
 SirM95KAVFLBZmhOjIsWM+r5jmNCAKB6jg4fE1aSb9M0R2HqZDY7qifFEJ6HqK5W
X-Gm-Gg: AR+sD125W2MBI9dS2gT/zgQH5gJinG/hsa/jeoNgeA3VglSCIBWbdrHI4Q1AoikB7Cu
 XW3p+0WfbJY9znbs1QAlygkdU2SIaKpsiURZqYoOIzf6M6JYUStm+Lr3W6L2AzbVxI6Vt6kJf73
 VB4+vPnNVumot3Sef0At5W1Cmr2uKQ8puYnHsM4sAP1+Z3/F8xbsY7i2rMKzMu8TpdXmxLU8x/7
 7JG1fGqtIC4EaObsXg6MgOb9+EFIAo/K/7NbwSMbva2//4BmUjpelRd0owO0hKvCzowAZd+DMVX
 wNPddpiUGBQAbfU6Id8FRDbz49q0i9PHnB58sELL6AyRFFOEA1gNDPd1ckwnc4VqI3/NMwDIAov
 ARpNTivnVEj8M4ZME21JTEq5dEBA918xda6gidNVJdTjU7JyjeJSFswLau/TibLCDr5mSLjq3jE
 0rfinhdOEe6MRb/Vm7Da4mpHIFBLSbVE/JJ1M8NI/dMNyoSYlnq4QtwHFVszVqNjNS/sCNI3kIF
 dSeWcTsc7schK0GdNpr9kpi76rpzRZ4bJf0
X-Received: by 2002:a05:6000:1787:b0:47f:5371:1b15 with SMTP id
 ffacd0b85a97d-47fb1ee2366mr8768400f8f.26.1785339638711; 
 Wed, 29 Jul 2026 08:40:38 -0700 (PDT)
Received: from localhost (89-93-216-19.hfc.dyn.abo.bbox.fr. [89.93.216.19])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fb647a8d4sm9038598f8f.0.2026.07.29.08.40.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2026 08:40:38 -0700 (PDT)
Date: Wed, 29 Jul 2026 17:12:52 +0200
Subject: [PATCH 16/25] tests/functional: aspeed: optionally check the
 device tree model on boot
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260729-sanmiguel-bmc-locator-v1-16-c8f9a8d101f6@free.fr>
References: <20260729-sanmiguel-bmc-locator-v1-0-c8f9a8d101f6@free.fr>
In-Reply-To: <20260729-sanmiguel-bmc-locator-v1-0-c8f9a8d101f6@free.fr>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, 
 Jamin Lin <jamin_lin@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, 
 qemu-arm@nongnu.org, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Thomas Huth <th.huth+qemu@posteo.eu>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Emmanuel Blot <eblot@meta.com>, Emmanuel Blot <emmanuel.blot@free.fr>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785337964; l=1664;
 i=emmanuel.blot@free.fr; s=20260602; h=from:subject:message-id;
 bh=cY6O6mrVrai7NMYpMfMfQOtbJnyb/EZq8fgGv1TgVEA=;
 b=AQ838ecWOWwFlpkOwwRhntcyWOI8dzW7kvtPnC3tGjFbVBZtLn17rgPtFJ1xHgzM538PwMyl6
 BrrNfBaCySPCA6QAwmenQtUOHlmRsrLclEX5O3GhdNCEWK22+y8Xssl
X-Developer-Key: i=emmanuel.blot@free.fr; a=ed25519;
 pk=0qFrZ21FAAN8OfVsSoVcCFTk/NMYOWzxJz4paSAVm0g=
Received-SPF: pass client-ip=209.85.221.54; envelope-from=eblot.ml@gmail.com;
 helo=mail-wr1-f54.google.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Reply-to:  Emmanuel Blot <emmanuel.blot@free.fr>
From:  Emmanuel Blot via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Add an optional 'dt_model' argument to do_test_arm_aspeed_openbmc().
When
provided, the helper also waits for the kernel's "Machine model: ..."
line,
letting a test confirm the booted image actually matches the expected
board
device tree rather than only the SoC revision.

Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
---
 tests/functional/aspeed.py | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tests/functional/aspeed.py b/tests/functional/aspeed.py
index 076da1036c..08af6b4839 100644
--- a/tests/functional/aspeed.py
+++ b/tests/functional/aspeed.py
@@ -8,7 +8,8 @@
 class AspeedTest(LinuxKernelTest):
 
     def do_test_arm_aspeed_openbmc(self, machine, image, uboot='2019.04',
-                                   cpu_id='0x0', soc='AST2500 rev A1'):
+                                   cpu_id='0x0', soc='AST2500 rev A1',
+                                   dt_model=None):
         self.set_machine(machine)
         self.vm.set_console()
         self.vm.add_args('-drive', f'file={image},if=mtd,format=raw',
@@ -19,6 +20,8 @@ def do_test_arm_aspeed_openbmc(self, machine, image, uboot='2019.04',
         self.wait_for_console_pattern('## Loading kernel from FIT Image')
         self.wait_for_console_pattern('Starting kernel ...')
         self.wait_for_console_pattern(f'Booting Linux on physical CPU {cpu_id}')
+        if dt_model:
+            self.wait_for_console_pattern(f'Machine model: {dt_model}')
         self.wait_for_console_pattern(f'ASPEED {soc}')
         self.wait_for_console_pattern('/init as init process')
         self.wait_for_boot_complete()

-- 
2.50.1


