Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77428C02194
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 13:14:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tg1fy-00065x-Dj; Thu, 06 Feb 2025 08:12:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tg1fj-0005r2-3e
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 08:11:59 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tg1fh-0008EK-5H
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 08:11:58 -0500
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-38dbcf418f5so339670f8f.1
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2025 05:11:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738847515; x=1739452315; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2lrz/Z9U2Uf5jpDeQ6Q5rMzyggw9C9+W1C5t50i9qAk=;
 b=GQwzIgtAAYkXR04+4dUt94hxV2Ur+ZcAsEoU8gReSCvMMGenXDFOUozVlWo1ZM0dNK
 Q4ITZ10nfcLSjyIQ8AQN/ODeq3DgpyoQGYLBQOtAW3wzT9Z3UX+Z66/vSStRb00TsKeq
 DOlFWX8pEGxtqLYhpt9tuKJISwqXq+uXSj59sOaQo1llZglplllj5DPaSow2UcVbb1gK
 lhV8lV8KtDti46kAZIRV+2Aqmts4tWm4Elmkv9A/kxIGVwUnI05M56hHNEMpGNHYDizU
 kP0fiIBfLTMpMmr3LLZ/64HrQg8lCyqTHGRlPv4Z/2tzFjrRSXOOElz7f+WeOGZbABn4
 Sh4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738847515; x=1739452315;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2lrz/Z9U2Uf5jpDeQ6Q5rMzyggw9C9+W1C5t50i9qAk=;
 b=A2vfQ7NVAR4eE8dYChmqX8d42YUKGnRiNrx77SZSZX49vn7p3IZg0GdPlzmu5DVeX9
 5HZ/YAe0QU8ns7LwkVg6zxY4d6U0n8gaL6TKZiEqRe7zC80f62TIzuHCKmfZvXBPZ4s+
 wNQYPKn6mu2C4gYhlEOH+wFhd5Dnn25CIzes5YRNbCBcSmWvqeVhAdwT4q8wAYdiy2ON
 36o0lLJfAcbYNfu5RL1LKCrOj0gULK6Wh3j8U97kXwpH6OVD3rc/aYXxZeDbNZIXpIlT
 bvdQZXSKvvcXzEhNnoaexMDZWeQVMJRg+jm/T+BxpfxLtkQ14a6Sy5SQX0ja3we0xT9i
 qfsw==
X-Gm-Message-State: AOJu0YxOc71Dh7Dwf2dufW1qtFI89c2qK0RbxYK/RHc6/GMA7nUWyG0I
 0bJkNYdgkgjP8hlgtQ8a2K+pEkqsZuAF1BLqkEmFJ8BxZNU7W5WimrOsjcYcJ8omBgDURPnfOwH
 kDL8=
X-Gm-Gg: ASbGncvjrVFOvnfX0ItpkHjXkwPxmzX+WL2mdoo6C24UrKf+hEohmAJZUtCm1arBjFH
 9ZhGwfL5T5yrGm/cGdMFz0eYJoBXSaH+Tfal4CQ3z0VWW6B+tUvclF0IQUdViDW0m8GvammH8/+
 v1kRrLxRnh/+mx/yZwmajQ60r9qaXW+Uor6ByVkoz5yh7zLzztj1IwGFtMKTlpReQo/O2jakJW8
 LwqGhQbtLfy1tfypbrcFfo3Dwn/n951ELbiEwNY/mANTCpuTQ8VfnYCKMggpmEOBtQJKntY1z4k
 VojxJnSqTQsGolnjpW6Ha88fYH/eRFtT5z72cAxGq8SRKvP+tF+DCnoPBlA2prFU0Q==
X-Google-Smtp-Source: AGHT+IE6Y5g24HN2J8//ddo24S65sFFsToY/ZOyNpNBzTc9l0UKqcyMYq8ZdUlvzKC9w+uYtYqUVkw==
X-Received: by 2002:adf:f342:0:b0:382:51ae:7569 with SMTP id
 ffacd0b85a97d-38db48a9824mr4189755f8f.18.1738847515103; 
 Thu, 06 Feb 2025 05:11:55 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4390daf4438sm56023825e9.25.2025.02.06.05.11.54
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 06 Feb 2025 05:11:54 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Anton Johansson <anjo@rev.ng>,
 Jason Wang <jasowang@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Alistair Francis <alistair@alistair23.me>, Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v5 12/16] tests/functional: Explicit endianness of microblaze
 assets
Date: Thu,  6 Feb 2025 14:10:48 +0100
Message-ID: <20250206131052.30207-13-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250206131052.30207-1-philmd@linaro.org>
References: <20250206131052.30207-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The archive used in test_microblaze_s3adsp1800.py (testing a
big-endian target) contains a big-endian kernel. Rename using
the _BE suffix.

Similarly, the archive in test_microblazeel_s3adsp1800 (testing
a little-endian target) contains a little-endian kernel. Rename
using _LE suffix.

These changes will help when adding cross-endian kernel tests.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 tests/functional/test_microblaze_s3adsp1800.py   | 6 +++---
 tests/functional/test_microblazeel_s3adsp1800.py | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/tests/functional/test_microblaze_s3adsp1800.py b/tests/functional/test_microblaze_s3adsp1800.py
index 2c4464bd05a..fac364b1ea9 100755
--- a/tests/functional/test_microblaze_s3adsp1800.py
+++ b/tests/functional/test_microblaze_s3adsp1800.py
@@ -15,14 +15,14 @@ class MicroblazeMachine(QemuSystemTest):
 
     timeout = 90
 
-    ASSET_IMAGE = Asset(
+    ASSET_IMAGE_BE = Asset(
         ('https://qemu-advcal.gitlab.io/qac-best-of-multiarch/download/'
          'day17.tar.xz'),
         '3ba7439dfbea7af4876662c97f8e1f0cdad9231fc166e4861d17042489270057')
 
-    def test_microblaze_s3adsp1800(self):
+    def test_microblaze_s3adsp1800_be(self):
         self.set_machine('petalogix-s3adsp1800')
-        self.archive_extract(self.ASSET_IMAGE)
+        self.archive_extract(self.ASSET_IMAGE_BE)
         self.vm.set_console()
         self.vm.add_args('-kernel',
                          self.scratch_file('day17', 'ballerina.bin'))
diff --git a/tests/functional/test_microblazeel_s3adsp1800.py b/tests/functional/test_microblazeel_s3adsp1800.py
index c382afe6bfa..5d353dba5d2 100755
--- a/tests/functional/test_microblazeel_s3adsp1800.py
+++ b/tests/functional/test_microblazeel_s3adsp1800.py
@@ -17,14 +17,14 @@ class MicroblazeelMachine(QemuSystemTest):
 
     timeout = 90
 
-    ASSET_IMAGE = Asset(
+    ASSET_IMAGE_LE = Asset(
         ('http://www.qemu-advent-calendar.org/2023/download/day13.tar.gz'),
         'b9b3d43c5dd79db88ada495cc6e0d1f591153fe41355e925d791fbf44de50c22')
 
-    def test_microblazeel_s3adsp1800(self):
+    def test_microblazeel_s3adsp1800_le(self):
         self.require_netdev('user')
         self.set_machine('petalogix-s3adsp1800')
-        self.archive_extract(self.ASSET_IMAGE)
+        self.archive_extract(self.ASSET_IMAGE_LE)
         self.vm.set_console()
         self.vm.add_args('-kernel', self.scratch_file('day13', 'xmaton.bin'))
         tftproot = self.scratch_file('day13')
-- 
2.47.1


