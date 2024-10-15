Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A3F0CFC29A
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2024 12:08:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0gLP-0000zs-SC; Tue, 15 Oct 2024 08:08:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1t0gLO-0000z9-6f
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 08:08:06 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1t0gLM-00012z-CU
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 08:08:05 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-a86e9db75b9so768386466b.1
 for <qemu-devel@nongnu.org>; Tue, 15 Oct 2024 05:08:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728994082; x=1729598882; darn=nongnu.org;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=YMaAi26qcD0yRIS9JL2pxoifDAI0jDo3jYIVsqXWjJY=;
 b=BfyHdwYBRjKSrI/4FcbMSCgQEyhL7sHdHKCR3OMsjwrQjS1Oni+E9rXcbY9K9m52ZC
 2XlSngJRQU/IDLKLCdrTi/WP0Z72ZU8AWe0c61OmU0Vn+oq3Z3ebHVgcUhRupcQsG6aT
 e3ks/OiTlYtH4hVHEuC2CDYukfBwrPxR6mUV5lCqc9Heftzq0FCwjUu97Vl4QNo1xMf6
 CUkheEvnmKIFLIrpJdXA/24Q4ehWBZ5oCRt8OKXDw9FD2A7JctO1xkP7YmNHBd/rDi/l
 fp+6R+lCz6bFuMPvCJYYbIjB0V5AIjL1ipwJ0stfYpjez30tIy4oxcTpzxxPI+y1UDwZ
 FcnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728994082; x=1729598882;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YMaAi26qcD0yRIS9JL2pxoifDAI0jDo3jYIVsqXWjJY=;
 b=dP1GfD+A5EQf9ng99jcSF6Cum6a9ZG2ZeU8zBP51XVwkTdDLlPCq9PVpv+vMo7zRm6
 cy2oyxfq27hR4+tybysSa5r/s4pv350clQhWwhYVTr6hEP1+T3dcmdfDykXVDWJqbZyu
 vKj6z6q7sIkJmm3IooIZ069WhI+OJOmgK5FxmCQYJnjOpekRuRA9+2ttg9BjeAKgijBt
 i39gt67qc/h0QjY1rdcwf3mNK6nEu4fWEJg9bAYn48lOSC6153GDjiFc0CJUw0IbHuKl
 n8kTTzD6PeqhOQqQjEQpJCx2uhvG8O8nzDsReBw31Vu0Z1HIvJqX/3JpAoUsumEBmkyn
 Ai7g==
X-Gm-Message-State: AOJu0YzRE7pPYNkTSXWNoIfdOfESPEthQXDUFHiHoYuhgnDj7ilOjRKi
 91qMaidB4K34BlWi5q896z26D3Tm2MiI4Wk0Dnqm8Q58Gpngv9BZFfoVbWOqHJw=
X-Google-Smtp-Source: AGHT+IG9qa4ngQcpZkHZhoYB3m34IuiXOmHvop8iLoTQW+urBEDiUnH5hku1dyTZvM3IxDpaMBOa7A==
X-Received: by 2002:a17:907:d30d:b0:a9a:1437:3175 with SMTP id
 a640c23a62f3a-a9a1437347bmr425438866b.51.1728994081481; 
 Tue, 15 Oct 2024 05:08:01 -0700 (PDT)
Received: from [127.0.1.1] (adsl-113.37.6.2.tellas.gr. [37.6.2.113])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9a29817fb3sm64112466b.119.2024.10.15.05.08.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Oct 2024 05:08:00 -0700 (PDT)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Tue, 15 Oct 2024 15:07:36 +0300
Subject: [PATCH] rust/wrapper.h: define memory_order enum
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241015-rust-wrapper-stdatomic-v1-1-f22c0bd31140@linaro.org>
X-B4-Tracking: v=1; b=H4sIAAdbDmcC/x3MQQqEMAxA0atI1gZsVHDmKoOL0kYni9GSdFQQ7
 25x+Rb/n2Cswgbv6gTlTUzWpcDVFYSvX2ZGicVADXWucT3q3zLu6lNiRcvR5/UnAd0Q+4FeFKh
 rocRJeZLjGX/G67oBRX2eKGgAAAA=
X-Change-ID: 20241015-rust-wrapper-stdatomic-18d58292c243
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Thomas Huth <thuth@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
X-Mailer: b4 0.15-dev-12fc5
X-Developer-Signature: v=1; a=openpgp-sha256; l=4710;
 i=manos.pitsidianakis@linaro.org; h=from:subject:message-id;
 bh=FlpLRQ7vL7z8MnMcYb0Iw7EMyuukYv7xDzwj30y9JWk=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0VCYlFLUy9aQU5Bd0FLQVhjcHgzQi9mZ
 25RQWNzbVlnQm5EbHNmdFEyV1l6UCtrU0RVaGtQVlh3K2dBMEpKCmFCakg4WjZac05MVE1Ycitz
 cG1KQWpNRUFBRUtBQjBXSVFUTVhCdE9SS0JXODRkd0hSQjNLY2R3ZjM0SjBBVUMKWnc1Ykh3QUt
 DUkIzS2Nkd2YzNEowSVluRC85K0Fqb05uakxtKzk5T2JYYlZhYkpOSWR0OUcralp4OW9IWlMzSw
 p2c2JRaGYyVWZLY0kxWTBOY2NMWDFENzBGQldWOGpSSFBPN2c5WThQTmpRNTFRU0Z6enUxTVdGN
 XQyMnM3LzA2CldTS3ZSR2k0ejdYTXRpbnFNWUErY2hNVXViblpuUjNXUkNia2QwdGtWdEUvaVNl
 Nmo0V1dsR2dnd2ZldVEyM0EKOWJOZFNrUWpTWlhWOEZ3YnRPeDA4MGFySnF2VUlqVW51SzJia1h
 aQ2ZNb3gwaWM2d3grWjhVZTZRSkIxRy9pTwpSZ1NSNFN0UU92amRPODE4dkp2UEpvTUJMKzBYZG
 Z6emFqMTdJVzlxVHAwMVNKckxjOVY1ejRPYW9GMU9uZ3RCCklIQUo0cURWSzhpd2lvclU0WUNTW
 EVoeWJXdjcrZ1dOQnZKd2pIa2o5K2xBeHBTOTFLSUZjY005VGRodTArSTkKelo0TXZBY2NXK3BZ
 V21FeGpzbXdnM2hJNmFhQi84VGNlVFQyT3FMelU4U1ZDTVBQNExKdlVWbFpNRUxOTFBSRwprWGN
 Hd1pBRGMwb2swL3crbUxrZEhuS2wreW5sYTFHRGxMYVBVdkY0dmswcVh1SUhHRnZnWVVaZms0Zj
 ZQbmVaCnZtb3ViWG5BcGNpV1RrV0dSRStMdHZGd3VyN0UrMCtQQjhhbFc5Qy9kT2l4bXo3T1ljb
 E0zY0NVQ3pNcXFBMXcKNXRCK0h2dXlId2UyRTRhRlhLZFVrY1BNVkpCRjJvRC9ocU9QSFZFWlhW
 UFdFbEMrVTdTTUdreCtCaFJpbFNTLwpwOUpjTmt5SndBenlFQjJmYU1HdFZidlB3VHluTVJnMjJ
 mdkc2alp2SzJxYzBiSlA5L1RnRGJOdmY2S3p3NmVmClpWbVl3Zz09Cj1WRzhKCi0tLS0tRU5EIF
 BHUCBNRVNTQUdFLS0tLS0K
X-Developer-Key: i=manos.pitsidianakis@linaro.org; a=openpgp;
 fpr=7C721DF9DB3CC7182311C0BF68BC211D47B421E1
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ej1-x635.google.com
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

Add stub definition of memory_order enum in wrapper.h.

Creating Rust bindings from C code is done by passing the wrapper.h
header to `bindgen`. This fails when library dependencies that use
compiler headers are enabled, and the libclang that bindgen detects does
not match the expected clang version. So far this has only been observed
with the memory_order enum symbols from stdatomic.h. If we add the enum
definition to wrapper.h ourselves, the error does not happen.

Before this commit, if the mismatch happened the following error could
come up:

  /usr/include/liburing/barrier.h:72:10: error: use of undeclared identifier 'memory_order_release'
  /usr/include/liburing/barrier.h:75:9: error: use of undeclared identifier 'memory_order_acquire'
  /usr/include/liburing/barrier.h:75:9: error: use of undeclared identifier 'memory_order_acquire'
  /usr/include/liburing/barrier.h:68:9: error: use of undeclared identifier 'memory_order_relaxed'
  /usr/include/liburing/barrier.h:65:17: error: use of undeclared identifier 'memory_order_relaxed'
  /usr/include/liburing/barrier.h:75:9: error: use of undeclared identifier 'memory_order_acquire'
  /usr/include/liburing/barrier.h:75:9: error: use of undeclared identifier 'memory_order_acquire'
  /usr/include/liburing/barrier.h:72:10: error: use of undeclared identifier 'memory_order_release'
  panicked at [..]/.cargo/registry/src/index.crates.io-6f17d22bba15001f/bindgen-cli-0.70.1/main.rs:45:36:
  Unable to generate bindings

To fix this (on my system) I would have to export CLANG_PATH and
LIBCLANG_PATH:

  export CLANG_PATH=/bin/clang-17
  export LIBCLANG_PATH=/usr/lib/llvm-17/lib

With these changes applied, bindgen is successful with both the
environment variables set and unset.

Since we're not using those symbols in the bindings (they are only used
by dependencies) this does not affect the generated bindings in any way.

Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 configure      |  7 -------
 meson.build    |  7 -------
 rust/wrapper.h | 17 +++++++++++++++++
 3 files changed, 17 insertions(+), 14 deletions(-)

diff --git a/configure b/configure
index 72d1a94225051ff6e9da9e9256fc8c30aa728f67..83c7636c9a9711e3a1c860e0aac52249a909eaaf 100755
--- a/configure
+++ b/configure
@@ -2060,10 +2060,3 @@ echo ' "$@"' >>config.status
 chmod +x config.status
 
 rm -r "$TMPDIR1"
-
-if test "$rust" != disabled; then
-  echo '\nINFO: Rust bindings generation with `bindgen` might fail in some cases where'
-  echo 'the detected `libclang` does not match the expected `clang` version/target. In'
-  echo 'this case you must pass the path to `clang` and `libclang` to your build'
-  echo 'command invocation using the environment variables CLANG_PATH and LIBCLANG_PATH'
-fi
diff --git a/meson.build b/meson.build
index d26690ce204016d43848d8a73a2d4351a620c5c2..dd4908501037e23c4c6ab165c5809f623c93360b 100644
--- a/meson.build
+++ b/meson.build
@@ -3956,13 +3956,6 @@ if have_rust and have_system
     bindgen_args += ['--bitfield-enum', enum]
   endforeach
 
-  # TODO: Remove this comment when the clang/libclang mismatch issue is solved.
-  #
-  # Rust bindings generation with `bindgen` might fail in some cases where the
-  # detected `libclang` does not match the expected `clang` version/target. In
-  # this case you must pass the path to `clang` and `libclang` to your build
-  # command invocation using the environment variables CLANG_PATH and
-  # LIBCLANG_PATH
   bindings_rs = import('rust').bindgen(
     input: 'rust/wrapper.h',
     dependencies: common_ss.all_dependencies(),
diff --git a/rust/wrapper.h b/rust/wrapper.h
index 77e40213efb686d23f6b768b78602e4337623280..285d0eb6ad01e227a82f13e17c79390b4c34d37e 100644
--- a/rust/wrapper.h
+++ b/rust/wrapper.h
@@ -30,6 +30,23 @@
  * in order to generate C FFI compatible Rust bindings.
  */
 
+#ifndef __CLANG_STDATOMIC_H
+#define __CLANG_STDATOMIC_H
+/*
+ * Fix potential missing stdatomic.h error in case bindgen does not insert the
+ * correct libclang header paths on its own. We do not use stdatomic.h symbols
+ * in QEMU code, so it's fine to declare dummy types instead.
+ */
+typedef enum memory_order {
+  memory_order_relaxed,
+  memory_order_consume,
+  memory_order_acquire,
+  memory_order_release,
+  memory_order_acq_rel,
+  memory_order_seq_cst,
+} memory_order;
+#endif /* __CLANG_STDATOMIC_H */
+
 #include "qemu/osdep.h"
 #include "qemu/module.h"
 #include "qemu-io.h"

---
base-commit: c155d13167c6ace099e351e28125f9eb3694ae27
change-id: 20241015-rust-wrapper-stdatomic-18d58292c243

--
γαῖα πυρί μιχθήτω


