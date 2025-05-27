Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43097C54F30
	for <qemu-devel@archiver.kernel.org>; Tue, 27 May 2025 17:05:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJxiu-0005dP-6P; Tue, 27 May 2025 13:04:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uJxir-0005cQ-2k
 for qemu-devel@nongnu.org; Tue, 27 May 2025 13:04:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uJxim-0006fv-RI
 for qemu-devel@nongnu.org; Tue, 27 May 2025 13:04:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748365451;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=V4aZkVQe1X/Spfd9+OxNGkT/25sWGd8bXwBhMt/jceI=;
 b=hdUVFvmhojavaqhx4XkCf5MDpxsbvBELuAEW3cY3w4k1dcWO4z2WVJCEJljXoF8SGJxrfr
 DLRkirMQ+SpLgvIjAiVCTtyKJQiIC1d8h0/+gpNfS1tEo2cHLQM0CP8dANzXvKS0kefmHo
 ZhjsmLEC3VASTMJn8V/v84filr4QI80=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-157-RMLwduUZNyaQ_qGidiggBw-1; Tue, 27 May 2025 13:04:09 -0400
X-MC-Unique: RMLwduUZNyaQ_qGidiggBw-1
X-Mimecast-MFC-AGG-ID: RMLwduUZNyaQ_qGidiggBw_1748365448
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-6045875e52fso2205767a12.2
 for <qemu-devel@nongnu.org>; Tue, 27 May 2025 10:04:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748365447; x=1748970247;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=V4aZkVQe1X/Spfd9+OxNGkT/25sWGd8bXwBhMt/jceI=;
 b=D2k787cDL4Y+/Z+GBVRzauRe88WRjR6yJgOiVAkO6IUv3i9oPkSSu+T1Af12lvrmRp
 KWhu+pTEs0xLxUgBDbF7H716OhsLxZ2vVIS2RgFHKnFsb5sE5LMjmlvYiH7Gs11GnvZX
 1XXV9fZ+M3cmKYtjsZVw5SlB1YDVb1CAUBQZlER7rrqkZzxb/VGHwmkFki5YuTnXUlWc
 WN1jDA8mN18KqbRChZCp+CO0uk1WVkOdR7RvgjOl7x2ZpfTAybDxOWL9kVNFAROxutS/
 9HhcqsrsIkd3MPVD3NP6rUoFGPfbYscPzL7PlAYKqz7NlgrCJkeghZhoSjQdRW5x0ykt
 HoYQ==
X-Gm-Message-State: AOJu0Yy60DdlXlmncGUG1ja4Jlu2LUrXPr7QrGjhzYfyOzNpvALyecua
 upJ72Pp+3xeFCcz0+E0pXfnfialgGqeX8hZX+t1ID9Qtk1cewBah2ifsc4PB0dSaVKm7HFoipAq
 Djk1Uaz76jVzviwHxwpnc+xXOcGgHxLMVFXwhZkZjwHWCLtiikcD1Wi1prDfzZ7oUm10XTDsGGH
 C2J7gNUYZHDZWTNdRS0u6il/CqqPfRUvVxza3ow6iV
X-Gm-Gg: ASbGncukvmIxCgVBDx6ux2WErU9mCA6Tf4SlVpZ++xZYl7DjFvZhwDy54SoJiaFkJR1
 3Xabq9GqoLBdhtFwouL5QEUjCepG0H/4Bmv3y6lg24fjxDM8kfztH/VrmAwjaqf/9UF+hYFoAZj
 N6R/ZXRil4X083wiYI2TRui4mPm+9AcXuMpyS2xX8RisgSJ68ZfZchJQ/zcqLjtN8xZo4paE3Wf
 lZCWMXzL0sRpQf6PfAqzMnvAQHYlWl3Nk72oIJ15e+SNupOOQLAe2Ra/Qk6Mw3o3VCJgIsR85Wo
 T41jUmsy85g4bw==
X-Received: by 2002:a05:6402:34c1:b0:5fb:ad3c:cee9 with SMTP id
 4fb4d7f45d1cf-602da8dde73mr11271226a12.28.1748365447540; 
 Tue, 27 May 2025 10:04:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF4LoKixDs5J+EI0OHKMItBHRlzlXmw17NtWfbttHNL5Snhm9R4B2QVYPR7W+KOFFeLnT+0Ow==
X-Received: by 2002:a05:6402:34c1:b0:5fb:ad3c:cee9 with SMTP id
 4fb4d7f45d1cf-602da8dde73mr11271170a12.28.1748365447044; 
 Tue, 27 May 2025 10:04:07 -0700 (PDT)
Received: from [192.168.122.1] ([151.95.46.79])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6004d4f1be3sm18224012a12.5.2025.05.27.10.04.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 May 2025 10:04:06 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org
Subject: [PATCH 1/6] meson: update to version 1.8.1
Date: Tue, 27 May 2025 19:03:59 +0200
Message-ID: <20250527170404.1580482-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250527170404.1580482-1-pbonzini@redhat.com>
References: <20250527170404.1580482-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.907,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

This adds several improvements to Rust support, including
native clippy and rustdoc targets, the "objects" keyword,
and running doctests.

Require it only when Rust support is requested, to avoid
putting a strict requirement on all build platforms for the
sake of an experimental feature.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configure                                  |   8 ++++++++
 python/scripts/vendor.py                   |   4 ++--
 python/wheels/meson-1.5.0-py3-none-any.whl | Bin 959846 -> 0 bytes
 python/wheels/meson-1.8.1-py3-none-any.whl | Bin 0 -> 1013001 bytes
 pythondeps.toml                            |   2 +-
 tests/lcitool/mappings.yml                 |   6 +++++-
 6 files changed, 16 insertions(+), 4 deletions(-)
 delete mode 100644 python/wheels/meson-1.5.0-py3-none-any.whl
 create mode 100644 python/wheels/meson-1.8.1-py3-none-any.whl

diff --git a/configure b/configure
index 2ce8d29fac2..74b3865e51e 100755
--- a/configure
+++ b/configure
@@ -1178,6 +1178,14 @@ fi
 ##########################################
 # detect rust triple
 
+meson_version=$($meson --version)
+if test "$rust" != disabled && ! version_ge "$meson_version" 1.8.1; then
+  if test "$rust" = enabled; then
+    error_exit "Rust support needs Meson 1.8.1 or newer"
+  fi
+  echo "Rust needs Meson 1.8.1, disabling" 2>&1
+  rust=disabled
+fi
 if test "$rust" != disabled && has "$rustc" && $rustc -vV > "${TMPDIR1}/${TMPB}.out"; then
   rust_host_triple=$(sed -n 's/^host: //p' "${TMPDIR1}/${TMPB}.out")
 else
diff --git a/python/scripts/vendor.py b/python/scripts/vendor.py
index 0405e910b48..b47db00743a 100755
--- a/python/scripts/vendor.py
+++ b/python/scripts/vendor.py
@@ -41,8 +41,8 @@ def main() -> int:
     parser.parse_args()
 
     packages = {
-        "meson==1.5.0":
-        "52b34f4903b882df52ad0d533146d4b992c018ea77399f825579737672ae7b20",
+        "meson==1.8.1":
+        "374bbf71247e629475fc10b0bd2ef66fc418c2d8f4890572f74de0f97d0d42da",
     }
 
     vendor_dir = Path(__file__, "..", "..", "wheels").resolve()
diff --git a/pythondeps.toml b/pythondeps.toml
index 7eaaa0fed10..7884ab521d1 100644
--- a/pythondeps.toml
+++ b/pythondeps.toml
@@ -19,7 +19,7 @@
 
 [meson]
 # The install key should match the version in python/wheels/
-meson = { accepted = ">=1.5.0", installed = "1.5.0", canary = "meson" }
+meson = { accepted = ">=1.5.0", installed = "1.8.1", canary = "meson" }
 pycotap = { accepted = ">=1.1.0", installed = "1.3.1" }
 
 [docs]
diff --git a/tests/lcitool/mappings.yml b/tests/lcitool/mappings.yml
index 673baf39367..8f0e95e1c56 100644
--- a/tests/lcitool/mappings.yml
+++ b/tests/lcitool/mappings.yml
@@ -8,6 +8,10 @@ mappings:
 
   meson:
     OpenSUSELeap15:
+    # Use Meson from PyPI wherever Rust is enabled
+    Debian:
+    Fedora:
+    Ubuntu:
 
   python3:
     OpenSUSELeap15: python311-base
@@ -72,7 +76,7 @@ mappings:
 pypi_mappings:
   # Request more recent version
   meson:
-    default: meson==1.5.0
+    default: meson==1.8.1
 
   # Drop packages that need devel headers
   python3-numpy:
-- 
2.49.0


