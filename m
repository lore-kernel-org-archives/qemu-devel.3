Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26CAAC531DC
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2024 08:14:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1shPPA-00044a-07; Fri, 23 Aug 2024 04:12:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1shPP7-00042y-U4
 for qemu-devel@nongnu.org; Fri, 23 Aug 2024 04:12:18 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1shPP5-0004mz-O9
 for qemu-devel@nongnu.org; Fri, 23 Aug 2024 04:12:17 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-5bebd3b7c22so4428749a12.0
 for <qemu-devel@nongnu.org>; Fri, 23 Aug 2024 01:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724400733; x=1725005533; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=FzUpp6Fi1RnlgfSqrQ44A3uw7FwtxkcGzmQ+3Wqxx7k=;
 b=VfGX7eQKgTYpoDBsIaoKohwX+nqsmlaMk7lm5pBaaheV+FoDkXNJ639YmP+KyrF8fA
 WUlb9VTQqfSrBeibxawc+fbK0t3n3MXJLNEZc3GU6zR4/pqme0m2GkX2upNTyGh/NUJo
 2/af/Re6TTv9t9E90nFYt9NB5oxGO+ddkwn9XRs9vfcAvH7Q9WB/fSW9ZQUrFw/M/Kar
 AKFtlmoFSaIyE3FV6e5VzhYxwSDK8fnIWNMM2+S+p66SDdXUz28hsgjNJspjpODIfQe6
 b73d6Zw0wEVcXvdbP9k6ybf2CwMhNO2D516mDLt7CuecK7Q1gc0APIE5+1HxXhz434YH
 LQ6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724400733; x=1725005533;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FzUpp6Fi1RnlgfSqrQ44A3uw7FwtxkcGzmQ+3Wqxx7k=;
 b=rzoos2PVosRpqz6Xn/s0EkyGr7c+BggnHDOSjau6pxSxwRlhmhqhlFoIT/N3WXv0aK
 jg6q2fyW9vxe9Fk84vFpJ0KZqvU33tqO1V1JMZvTm42zfMtdSv/aVE7GxKVBnHwNUUKN
 vUNdsmz+qKm0TbMIAeQkC938e5GQfczwhI8Iu1douP6/HHCVeI4XUHpYkEXZxsy7evHL
 l8rRBO3rzR9QNedPHt40lF3m0CqJRDExFhXnLanDMgDzhv5RHR960rqsxVlQcJgP6K6N
 ehJVDfjS5TP9m5O7LB1TRhfNpHrE1WjDgxV7b4ZJ3yVIh8TLLptIGAlYx2h4+OSzOdfD
 ouYw==
X-Gm-Message-State: AOJu0YzTRP0wpy5uyerW3dQ6EEDFeUsODp4hh0PkCzmApWSwJQzqaibg
 uqAlsyngHxXOTxTvUaEshYYGEIQPXvVnixh0SBRk0UbP0fQE2DqUttt54K2Y9gI=
X-Google-Smtp-Source: AGHT+IHTEzjZQUZjZIqKMIjwNFCSnvI2zVOg9tl0Wp+8yfRDFug3yDoqdPdV+3jIsN5Y4SNuuRfKCA==
X-Received: by 2002:a17:907:9482:b0:a86:9cac:87a5 with SMTP id
 a640c23a62f3a-a869cac8900mr313391766b.19.1724400732866; 
 Fri, 23 Aug 2024 01:12:12 -0700 (PDT)
Received: from [127.0.1.1] (adsl-26.37.6.162.tellas.gr. [37.6.162.26])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a868ee6b390sm223620066b.0.2024.08.23.01.12.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Aug 2024 01:12:12 -0700 (PDT)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Fri, 23 Aug 2024 11:11:49 +0300
Subject: [PATCH v8 1/8] Require meson version 1.5.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240823-rust-pl011-v8-1-b9f5746bdaf3@linaro.org>
References: <20240823-rust-pl011-v8-0-b9f5746bdaf3@linaro.org>
In-Reply-To: <20240823-rust-pl011-v8-0-b9f5746bdaf3@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Gustavo Romero <gustavo.romero@linaro.org>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Peter Maydell <peter.maydell@linaro.org>, Junjie Mao <junjie.mao@intel.com>, 
 Zhao Liu <zhao1.liu@intel.com>
X-Mailer: b4 0.15-dev-b8758
X-Developer-Signature: v=1; a=openpgp-sha256; l=2847;
 i=manos.pitsidianakis@linaro.org; h=from:subject:message-id;
 bh=gbp6ZWDM9aBE3sP/4abftjNYYPlmCRvIHyPSrr8nbBM=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0VCYlFLUy9aQU5Bd0FLQVhjcHgzQi9mZ
 25RQWNzbVlnQm15RVJYRXdCYURwTjNzUngzRDlKK3BqeXFFUk50CmhoWHVMTWxCamxuVnZtWVJP
 UmVKQWpNRUFBRUtBQjBXSVFUTVhCdE9SS0JXODRkd0hSQjNLY2R3ZjM0SjBBVUMKWnNoRVZ3QUt
 DUkIzS2Nkd2YzNEowTCtuRC85WHBZdDBUbU1PYXYrbDFibWRkOFRCMGdRUnk1RUcvU2RjT2xzZw
 pHYmNjb3U5RVIrV1JvUGR1N1B3c3huTXJvQ0R0MjJhc1dDZkZ4UFUrRXpKcjBkUldVR0hSWXhDL
 1NkekdQM0VhCkIrbmRISDNTSFNFRlM4b2JWbEFEVXhlaHIrSWE0UlJGYVVjVHlrZi9Ybm9XZVJ0
 Yi9WOGpubTA4UFVJUU53OFoKbFBBd0dpV3g5YXA2RnZ5STA0VVVkUlpPbFJrWFk5NldzbFMya29
 rc3RDZXk2blRjazFmMUFFQm1mWVNYK3ZmdwpxRlhNRnNPUXpLeGJTUWoyUytJNjVKM0VLblFkMV
 JwQ3FrOUVPdzVlOEVuZWo3SGcvM3V4N0RaSm1ibWw0d0lMCkZMSE5BM1g0TU13NVREUCtTZmNUM
 EZVazloQTNHWWhCYy9QaDNpWkRhVlRHZGY2QjB4eU5qMGttRlptVmh2NzgKQzNvWUlvZ2hQUzVX
 MnhWcUM4bWdqNEIxM3RBOVF6Y1pBS1N0YjZXeUI3NDEvRUE4RnFrcHZ4b1hacU1Dd1dOYQpFRmx
 XeFA4TTI0ZnFiUld2UmZ6M0RqRy9WTjJiRmxmdXlVSGZrcjFOd2NYOEt1MlExOFU3V2VEZVlxTE
 xGNlp2CllPM3hvNFc2TjZqbEo3YkFuTjdFdFZIRHFZbG1ZcUxEQ3FMaUpHM2ljSGdiVVlOc0Nmb
 Gk5dFJsd09HbXB2UlQKL2p3c3htWEpFRVRZSmsxK3V5c0xXeUNGSGQ4ZEMvdVpuQloxc2ZIaEhB
 MnI5ZHN5TWhUNlpFNFNYdDlxclFvVgpGMXNPZm1GUldDaUpsZTJuTEQ5K2hTdzNDbGZJenkwVFF
 Qci9JNFY1SGtaa0EvUlBmNUU3MXIxY29yaVBoNFlvClJSUWlKZz09Cj1xSnd2Ci0tLS0tRU5EIF
 BHUCBNRVNTQUdFLS0tLS0K
X-Developer-Key: i=manos.pitsidianakis@linaro.org; a=openpgp;
 fpr=7C721DF9DB3CC7182311C0BF68BC211D47B421E1
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ed1-x52d.google.com
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

From: Paolo Bonzini <pbonzini@redhat.com>

This is needed for Rust support.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 meson.build                                |   2 +-
 python/scripts/vendor.py                   |   4 ++--
 python/wheels/meson-1.2.3-py3-none-any.whl | Bin 964928 -> 0 bytes
 python/wheels/meson-1.5.0-py3-none-any.whl | Bin 0 -> 959846 bytes
 pythondeps.toml                            |   2 +-
 tests/lcitool/mappings.yml                 |   2 +-
 6 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/meson.build b/meson.build
index 81ecd4bae7..7eb4b8a41c 100644
--- a/meson.build
+++ b/meson.build
@@ -1,4 +1,4 @@
-project('qemu', ['c'], meson_version: '>=1.1.0',
+project('qemu', ['c'], meson_version: '>=1.5.0',
         default_options: ['warning_level=1', 'c_std=gnu11', 'cpp_std=gnu++11', 'b_colorout=auto',
                           'b_staticpic=false', 'stdsplit=false', 'optimization=2', 'b_pie=true'],
         version: files('VERSION'))
diff --git a/python/scripts/vendor.py b/python/scripts/vendor.py
index 07aff97cca..0405e910b4 100755
--- a/python/scripts/vendor.py
+++ b/python/scripts/vendor.py
@@ -41,8 +41,8 @@ def main() -> int:
     parser.parse_args()
 
     packages = {
-        "meson==1.2.3":
-        "4533a43c34548edd1f63a276a42690fce15bde9409bcf20c4b8fa3d7e4d7cac1",
+        "meson==1.5.0":
+        "52b34f4903b882df52ad0d533146d4b992c018ea77399f825579737672ae7b20",
     }
 
     vendor_dir = Path(__file__, "..", "..", "wheels").resolve()
diff --git a/python/wheels/meson-1.2.3-py3-none-any.whl b/python/wheels/meson-1.2.3-py3-none-any.whl
deleted file mode 100644
index a8b84e5f11..0000000000
Binary files a/python/wheels/meson-1.2.3-py3-none-any.whl and /dev/null differ
diff --git a/python/wheels/meson-1.5.0-py3-none-any.whl b/python/wheels/meson-1.5.0-py3-none-any.whl
new file mode 100644
index 0000000000..c7edeb37ad
Binary files /dev/null and b/python/wheels/meson-1.5.0-py3-none-any.whl differ
diff --git a/pythondeps.toml b/pythondeps.toml
index f6e590fdd8..a1c6ca9662 100644
--- a/pythondeps.toml
+++ b/pythondeps.toml
@@ -19,7 +19,7 @@
 
 [meson]
 # The install key should match the version in python/wheels/
-meson = { accepted = ">=1.1.0", installed = "1.2.3", canary = "meson" }
+meson = { accepted = ">=1.5.0", installed = "1.5.0", canary = "meson" }
 
 [docs]
 # Please keep the installed versions in sync with docs/requirements.txt
diff --git a/tests/lcitool/mappings.yml b/tests/lcitool/mappings.yml
index 03b974ad02..9721016e0d 100644
--- a/tests/lcitool/mappings.yml
+++ b/tests/lcitool/mappings.yml
@@ -63,7 +63,7 @@ mappings:
 pypi_mappings:
   # Request more recent version
   meson:
-    default: meson==0.63.2
+    default: meson==1.5.0
 
   # Drop packages that need devel headers
   python3-numpy:

-- 
2.44.0


