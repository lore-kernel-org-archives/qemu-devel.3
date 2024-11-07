Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E855AD29FA5
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2024 01:24:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8rFs-0007K0-VS; Wed, 06 Nov 2024 20:24:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t8rFq-00079W-Fc
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 20:24:10 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t8rFo-0003H9-FX
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 20:24:10 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4315df7b43fso3599955e9.0
 for <qemu-devel@nongnu.org>; Wed, 06 Nov 2024 17:24:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730942647; x=1731547447; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hbUeKq8wIPtd30sIyAicGmI1dVV7JgXeFSyihDqJX1Q=;
 b=Jltnruu/Tvw4ppjVLOncpLlU0pZMRmfV1n33obXpESyhI2wOQTkCJm6zM57PDtohUV
 uIyzb6unpVAmyX9BqlHqQ+CswyXqkleNyFmEVLf+iI73GEtgEddGgWef3/YkFvWWiQrZ
 p5EQij8bC3y/LT51BtNUxVijynPcbUIpMUnhRJ+TRNeFtxRTTHeXg/129kyhtNQDHP68
 CZ6/zVYefBW1OByEj95QN4KnXpB+C0BX3RWphfHykXroSSDVkG2XooW17rTaSF7Aw/8c
 6x4bDf6/2fDLvPW486J8TwaGQ31Qm8nTVsvKdMlX03tf9xP31My2ItrMNdhEMLFtSiJF
 6V8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730942647; x=1731547447;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hbUeKq8wIPtd30sIyAicGmI1dVV7JgXeFSyihDqJX1Q=;
 b=gqhvTMzWY+mBqgGpk1F/yWtMwq5DI3q/9ZrvPBSN06Vx+MyKJAOlf5H3WqDYr55vdj
 7GMSN9bnnAr9eBeRz34m1aP3KOErMNlX0vhfsF8V4jZTap9+DHh0W4u0QEs3Ax2CaZMN
 N6TONUuFE5c9AnxCP4C7xc1s9pQZ1pcQDQnhKf4qXlz4QzTKlI9qqiJxYcHLozqLS5Xv
 TKM5saawFLbzE+aL7k1Kyv5iTr7aTEa5ameAqvkf2EzWpo9MTPoEh2qBRfTP9D7CAJRO
 vOrV12QK0p5Sq0q2+p8/BAODLZrFpiRF7fiRoaML/Ma9BepfQZIL92JxvvIToxhJVYwo
 jlsA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVedrjX1YKUtCqhldh6IpJa2cTQyygQy11saL26gFOdXIba2JfZa9Q/R2ZpLrS1kWbu4uShrhH3/yqO@nongnu.org
X-Gm-Message-State: AOJu0Yy/8r63yBFbXrj9SgORZW+bx9rVxNe5m2sWBlyu/DQREfcUaUap
 L+vnp/TdL4L1AF/qeEhuEG3HWwlGSMGkUzdLjHGYMQCu9zvs4CFPlBuTHM63HtM=
X-Google-Smtp-Source: AGHT+IEDTS2ZXrdGGGKSJnPDfSGs0osyy1UP13DntmHrRu071oY3JmBuOuCgpI102oPM03Q2DmuX+g==
X-Received: by 2002:a05:600c:46c8:b0:42c:b905:2bf9 with SMTP id
 5b1f17b1804b1-4319acb17a9mr387751405e9.16.1730942647051; 
 Wed, 06 Nov 2024 17:24:07 -0800 (PST)
Received: from localhost.localdomain ([154.14.63.34])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432aa70a23fsm44620855e9.33.2024.11.06.17.24.04
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 06 Nov 2024 17:24:05 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Anton Johansson <anjo@rev.ng>,
	qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Jason Wang <jasowang@redhat.com>, devel@lists.libvirt.org,
 qemu-ppc@nongnu.org, Alistair Francis <alistair@alistair23.me>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 16/16] tests/functional: Add microblaze cross-endianness
 tests
Date: Thu,  7 Nov 2024 01:22:22 +0000
Message-ID: <20241107012223.94337-17-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241107012223.94337-1-philmd@linaro.org>
References: <20241107012223.94337-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

Copy/paste the current tests, but call the opposite endianness
machines, testing:
- petalogix-s3adsp1800-le machine (little-endian CPU) on the
  qemu-system-microblaze binary (big-endian)
- petalogix-s3adsp1800-be machine (big-endian CPU) on the
  qemu-system-microblazeel binary (little-endian).

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 .../functional/test_microblaze_s3adsp1800.py  | 21 +++++++++++++++++++
 .../test_microblazeel_s3adsp1800.py           | 19 +++++++++++++++++
 2 files changed, 40 insertions(+)

diff --git a/tests/functional/test_microblaze_s3adsp1800.py b/tests/functional/test_microblaze_s3adsp1800.py
index 2b2f782270..7f5e8b6024 100755
--- a/tests/functional/test_microblaze_s3adsp1800.py
+++ b/tests/functional/test_microblaze_s3adsp1800.py
@@ -36,5 +36,26 @@ def test_microblaze_s3adsp1800_be(self):
         # message, that's why we don't test for a later string here. This
         # needs some investigation by a microblaze wizard one day...
 
+    ASSET_IMAGE_LE = Asset(
+        ('http://www.qemu-advent-calendar.org/2023/download/day13.tar.gz'),
+        'b9b3d43c5dd79db88ada495cc6e0d1f591153fe41355e925d791fbf44de50c22')
+
+    def test_microblaze_s3adsp1800_le(self):
+        self.require_netdev('user')
+        self.set_machine('petalogix-s3adsp1800-le')
+        file_path = self.ASSET_IMAGE_LE.fetch()
+        archive_extract(file_path, self.workdir)
+        self.vm.set_console()
+        self.vm.add_args('-kernel', self.workdir + '/day13/xmaton.bin')
+        self.vm.add_args('-nic', 'user,tftp=' + self.workdir + '/day13/')
+        self.vm.launch()
+        wait_for_console_pattern(self, 'QEMU Advent Calendar 2023')
+        time.sleep(0.1)
+        exec_command(self, 'root')
+        time.sleep(0.1)
+        exec_command_and_wait_for_pattern(self,
+                'tftp -g -r xmaton.png 10.0.2.2 ; md5sum xmaton.png',
+                '821cd3cab8efd16ad6ee5acc3642a8ea')
+
 if __name__ == '__main__':
     QemuSystemTest.main()
diff --git a/tests/functional/test_microblazeel_s3adsp1800.py b/tests/functional/test_microblazeel_s3adsp1800.py
index 1aee5149fb..60543009ba 100755
--- a/tests/functional/test_microblazeel_s3adsp1800.py
+++ b/tests/functional/test_microblazeel_s3adsp1800.py
@@ -38,5 +38,24 @@ def test_microblazeel_s3adsp1800_le(self):
                 'tftp -g -r xmaton.png 10.0.2.2 ; md5sum xmaton.png',
                 '821cd3cab8efd16ad6ee5acc3642a8ea')
 
+    ASSET_IMAGE_BE = Asset(
+        ('https://qemu-advcal.gitlab.io/qac-best-of-multiarch/download/'
+         'day17.tar.xz'),
+        '3ba7439dfbea7af4876662c97f8e1f0cdad9231fc166e4861d17042489270057')
+
+    def test_microblazeel_s3adsp1800_be(self):
+        self.set_machine('petalogix-s3adsp1800-be')
+        file_path = self.ASSET_IMAGE_BE.fetch()
+        archive_extract(file_path, self.workdir)
+        self.vm.set_console()
+        self.vm.add_args('-kernel', self.workdir + '/day17/ballerina.bin')
+        self.vm.launch()
+        wait_for_console_pattern(self, 'This architecture does not have '
+                                       'kernel memory protection')
+        # Note:
+        # The kernel sometimes gets stuck after the "This architecture ..."
+        # message, that's why we don't test for a later string here. This
+        # needs some investigation by a microblaze wizard one day...
+
 if __name__ == '__main__':
     QemuSystemTest.main()
-- 
2.45.2


