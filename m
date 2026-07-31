Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF6BCC54F54
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2026 12:40:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpmXE-0001qU-GZ; Fri, 31 Jul 2026 08:40:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1wpmXD-0001qE-AI
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 08:40:19 -0400
Received: from mail-wr1-f43.google.com ([209.85.221.43])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1wpmXB-0001Ra-M2
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 08:40:18 -0400
Received: by mail-wr1-f43.google.com with SMTP id
 ffacd0b85a97d-47f703a9e5dso465408f8f.0
 for <qemu-devel@nongnu.org>; Fri, 31 Jul 2026 05:40:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785501616; x=1786106416;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=T3QJvSJZGpsccP9EvkOCqQcE/jNtNeeQY/Ifg8+pe0I=;
 b=IcTiLfud4gpU/q7TPOjElpm75G12/e6f45dsiJD7G6uepS0ttv4c2d6daLSrgofbtq
 5DO6XPJw2yhWzcEG39BFS4nsZTu1w9mtEKl0KvlZPXf9Iqrn/pHvMLI2YaUeVEHQKce/
 baNCr1/P0isTFDwxkqSVZg4TtgsiDxW6KrnFUgh+0AGieKwObfKCvKmuFXA+tEH5ojMe
 RafiSfefDsWuCn81nLuIgR9ZEHs17RVu9APAQJ6CNvODLxc4bwNLemmw5/7kQ91q0Tg8
 VrPVB5fkI3/aH1FARNC5J8luEfgTV/ZFfuYGyLFgbqsM0ePIPGJsbUorfWTycO3qonSQ
 5KQg==
X-Gm-Message-State: AOJu0YxC3SGH7kIn7vPiiGUZuXmYo0YpifvVePMLgZ+VwzcTtplxsn+O
 kGwJDapu/pq7Er+inRoA/RRlf7bwuqFQmqnKrgxs2oXHRig2vJfe50BnIqTvjuDk
X-Gm-Gg: AR+sD11ognrnJ9XNShHNnTnnyqokIfBoRFEfDFUmOxefAW6kEcFg9yKe+mbOCPoMsGR
 E6F8DxSxBe4VUPeQp/JJkaCenai/pDYQcrbLzXM/BZ9+cOb9Q87QiRjnVSY7GDTexHGW4PoSKLY
 ulmzklw1VozB0s2pzqWB5oPxdLFViBsJ6TYVDNTHulYI0E4Ipr/flspw2GmRtcXT0kwc2Zb1YUN
 /9tQKF1yWzHcrQqqpg0PID84oVb+ekLCnW5g5IIq38kaIPnrPq+LekeN63J0DsHXZojRwBx802+
 k1KIDmJTFXc3pQFW/efpfH5kGazbPXHp9CMoALMYtrqICod3OAK1tzV9j/30Z54L0pIizVfs/ot
 DWd3tY6aLTHBRQCJZRmfLeWhQzQjBpbHdEWp0K6pANkypMpvebYCwdxzqtLdvc2hVMDVv02XfUv
 YSzcQaVnUKK0yIE4Ro0PH8cAvCnsdX1z5a7POtCClqYP35N6etNGuFKzDJ4k8XnPBJLuWuSgZVa
 uoJC0lPP544+9hj9XVuUyUllmAqraCJxwuu
X-Received: by 2002:adf:e006:0:20b0:47f:959f:f6a6 with SMTP id
 ffacd0b85a97d-47fd2b57ae2mr3448277f8f.54.1785501616176; 
 Fri, 31 Jul 2026 05:40:16 -0700 (PDT)
Received: from localhost (89-93-216-19.hfc.dyn.abo.bbox.fr. [89.93.216.19])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fd456a5a4sm4503816f8f.20.2026.07.31.05.40.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Jul 2026 05:40:15 -0700 (PDT)
Date: Fri, 31 Jul 2026 12:45:15 +0200
Subject: [PATCH v2 16/25] tests/functional: aspeed: optionally check the
 device tree model on boot
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260731-sanmiguel-bmc-locator-v2-16-1266926ba769@free.fr>
References: <20260731-sanmiguel-bmc-locator-v2-0-1266926ba769@free.fr>
In-Reply-To: <20260731-sanmiguel-bmc-locator-v2-0-1266926ba769@free.fr>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Steven Lee <steven_lee@aspeedtech.com>, 
 Jamin Lin <jamin_lin@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, 
 qemu-arm@nongnu.org, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Thomas Huth <th.huth+qemu@posteo.eu>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Emmanuel Blot <eblot@meta.com>, Emmanuel Blot <emmanuel.blot@free.fr>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785494708; l=1664;
 i=emmanuel.blot@free.fr; s=20260602; h=from:subject:message-id;
 bh=cY6O6mrVrai7NMYpMfMfQOtbJnyb/EZq8fgGv1TgVEA=;
 b=/dijBUnPE3iklNOoj7/qnWicCyiq0R+kAYriSGiWeH4hp4nDibVTzAMRCRdmBdACRnFdQMtUw
 myB8jxdCBluA4ENAeAHO1b/J7tYPxNg1k7aYe8wXMTbQA16iGckigqo
X-Developer-Key: i=emmanuel.blot@free.fr; a=ed25519;
 pk=0qFrZ21FAAN8OfVsSoVcCFTk/NMYOWzxJz4paSAVm0g=
Received-SPF: pass client-ip=209.85.221.43; envelope-from=eblot.ml@gmail.com;
 helo=mail-wr1-f43.google.com
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


