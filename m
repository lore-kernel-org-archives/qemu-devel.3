Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0314C0219E
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 20:48:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thae8-0004kF-8I; Mon, 10 Feb 2025 15:44:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1thadw-0004KO-U0
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 15:44:40 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1thads-0003zw-7c
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 15:44:34 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4362f61757fso48072155e9.2
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2025 12:44:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739220270; x=1739825070; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=03rJTTNBd3cp6/LXAuK3umtC787I9nHxNQm0tFuSG4M=;
 b=A92mH0LR4g9mJfC1/VhBrEYe2gta+kP7iWAdZDW+8ilgUOMfIu4kc77CDMbhJ9S9Ce
 wdn81iAhJr5cl1UA+nvd/NRjGCOE17iqXAAEhM5jM1c1Xe3eCEDH8GjV7RBUDCPXSHB5
 Sbwtkba+SppRhh9pf8lt8pcaMg/9TLznF28r/nU5GnVBKWKQVq+iZe0OJhB8O5WdMfgf
 BsKhN5mVxUdvznRIGZoFVrRyOrkv/+mOtMkVcwftj3UGbYNge21uJOGBN5cjb0SJE/Cy
 FMObjxVb5naiEnUguhFeK24n/6RoeInGV/4otjt3UniGARBbkyhWjCwRaK4kc2nH7Ox8
 veZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739220270; x=1739825070;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=03rJTTNBd3cp6/LXAuK3umtC787I9nHxNQm0tFuSG4M=;
 b=R8PxG/yg0joBS+vjvn2PUDOov/ERF2oFmMBfreh+RZlkDnVzvKaMOSIIXZ3q//HHRi
 XfvrU8XfuPxmNN+dGL69eI6owNIEvSMhlbqesSpa2qrid4dOGxHMcHSvAoPuyQGLmRVE
 u36rh0Lklyf+ZlZX00Rz+rRMKxQN36QzagPO++Lvgi6zR05iET2veUrspvKK/Yz2hFi4
 a2cd4hSexxxlGCYveta5WXif0gUTmUrKl8KjB+RJWqISv9STONsRZihxFMC3iq7miOsD
 bEXon3GVJCfoKvJt4lyOs/SjURy3B/e9Wnnn2esL9lUQCDZjNVtlSdQPodXTs5Zgdqsk
 +5yg==
X-Gm-Message-State: AOJu0YyMju0otDynscsKqpBGuAuApLigsbyvoleHHSHVoYH6ZQ9eFjhX
 RHBpj26YAfr/h7Ry6mwQEaSwyZA4UG+CLmiSXY8VmAq0g16MPV0ZVC0WEmwstsIY0iwfg12D9f/
 1M3Q=
X-Gm-Gg: ASbGncuFawHB4RqaEJScF5piVAn9tnSFXGkm7+8pvH2lVMKj9gB/hYYcsx3mkc2uBsh
 qLeWFMAsNn1e5sRk2wONr9+32Cjdxvzz4jFJWU7LGWr/9AyTadj9aztJoMB6ySC5DcWgiyyXzn7
 0ZBd7CBydEPG5zsZwpTlw84k0UPeAmJrCQQn7JREpwXvVL82Fz5Ao4REnf+3fDesgJF51ShvyOt
 3QbcJyQZ181i82OEVQO/Wzw+t5U4Rlq0cKSDJhS/W+LILH7ALemRWTTkHPOBQOV2zO2zyXou2wY
 HejkbhC+gNh7eL2c/eqTJVZaYf/bFfz9RHWB97WU48p8dKMmt72/PyhnxOgsY7NqSA==
X-Google-Smtp-Source: AGHT+IHdJ9XZ6pS0aortmibAQ65AuQtCaIwrlV8T7OI01bs8lowikxC2ggiq6RNqq2bRgjq3sBlonw==
X-Received: by 2002:a05:600c:500b:b0:439:48d9:d8b0 with SMTP id
 5b1f17b1804b1-43948d9dd41mr37756095e9.16.1739220270286; 
 Mon, 10 Feb 2025 12:44:30 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4392fc7ceacsm90186975e9.20.2025.02.10.12.44.28
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 10 Feb 2025 12:44:29 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Subject: [PULL 28/32] tests/functional: Allow microblaze tests to take a
 machine name argument
Date: Mon, 10 Feb 2025 21:42:00 +0100
Message-ID: <20250210204204.54407-29-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250210204204.54407-1-philmd@linaro.org>
References: <20250210204204.54407-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

Make microblaze tests a bit more generic.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20250206131052.30207-14-philmd@linaro.org>
---
 tests/functional/test_microblaze_s3adsp1800.py   | 7 +++++--
 tests/functional/test_microblazeel_s3adsp1800.py | 7 +++++--
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/tests/functional/test_microblaze_s3adsp1800.py b/tests/functional/test_microblaze_s3adsp1800.py
index fac364b1ea9..c4226f49cf3 100755
--- a/tests/functional/test_microblaze_s3adsp1800.py
+++ b/tests/functional/test_microblaze_s3adsp1800.py
@@ -20,8 +20,8 @@ class MicroblazeMachine(QemuSystemTest):
          'day17.tar.xz'),
         '3ba7439dfbea7af4876662c97f8e1f0cdad9231fc166e4861d17042489270057')
 
-    def test_microblaze_s3adsp1800_be(self):
-        self.set_machine('petalogix-s3adsp1800')
+    def do_ballerina_be_test(self, machine):
+        self.set_machine(machine)
         self.archive_extract(self.ASSET_IMAGE_BE)
         self.vm.set_console()
         self.vm.add_args('-kernel',
@@ -34,5 +34,8 @@ def test_microblaze_s3adsp1800_be(self):
         # message, that's why we don't test for a later string here. This
         # needs some investigation by a microblaze wizard one day...
 
+    def test_microblaze_s3adsp1800_legacy_be(self):
+        self.do_ballerina_be_test('petalogix-s3adsp1800')
+
 if __name__ == '__main__':
     QemuSystemTest.main()
diff --git a/tests/functional/test_microblazeel_s3adsp1800.py b/tests/functional/test_microblazeel_s3adsp1800.py
index 5d353dba5d2..715ef3f79ac 100755
--- a/tests/functional/test_microblazeel_s3adsp1800.py
+++ b/tests/functional/test_microblazeel_s3adsp1800.py
@@ -21,9 +21,9 @@ class MicroblazeelMachine(QemuSystemTest):
         ('http://www.qemu-advent-calendar.org/2023/download/day13.tar.gz'),
         'b9b3d43c5dd79db88ada495cc6e0d1f591153fe41355e925d791fbf44de50c22')
 
-    def test_microblazeel_s3adsp1800_le(self):
+    def do_xmaton_le_test(self, machine):
         self.require_netdev('user')
-        self.set_machine('petalogix-s3adsp1800')
+        self.set_machine(machine)
         self.archive_extract(self.ASSET_IMAGE_LE)
         self.vm.set_console()
         self.vm.add_args('-kernel', self.scratch_file('day13', 'xmaton.bin'))
@@ -38,5 +38,8 @@ def test_microblazeel_s3adsp1800_le(self):
                 'tftp -g -r xmaton.png 10.0.2.2 ; md5sum xmaton.png',
                 '821cd3cab8efd16ad6ee5acc3642a8ea')
 
+    def test_microblaze_s3adsp1800_legacy_le(self):
+        self.do_xmaton_le_test('petalogix-s3adsp1800')
+
 if __name__ == '__main__':
     QemuSystemTest.main()
-- 
2.47.1


