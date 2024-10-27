Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1028FD13561
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Oct 2024 13:58:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t53lq-0001xx-5r; Sun, 27 Oct 2024 09:57:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1t53lp-0001xp-60
 for qemu-devel@nongnu.org; Sun, 27 Oct 2024 09:57:29 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1t53ln-0001rr-AF
 for qemu-devel@nongnu.org; Sun, 27 Oct 2024 09:57:28 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-5cbb0900c86so2342261a12.0
 for <qemu-devel@nongnu.org>; Sun, 27 Oct 2024 06:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730037444; x=1730642244; darn=nongnu.org;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=mGShBJo3gqs1r8OBjbwX8V+x22DpITrDS9TZv/hAJzM=;
 b=OtHxOemJBfSAC+d7xizC/U6x2nsTdlG+XXblA6aXGjCCFc641/yzUZB7k940aJXpvc
 P3s25EW2dD2fffynpceWCuhvoLB2SCW2+ALQCvVdo+jqk4EfqeJVSX8quSND86wRtPQ/
 yan8JM/5jYJAZqH3B1eJ23uomDTSdlhMf6Ym/AopQSryezsFUDSYvTkvZlkPoxq3vhFR
 tNw4G7dbSlB0/ZKnodPekGlw1Y0oqdL4aldj6vOailcb4comxZ0sdF2z7B2+9aJLDCHJ
 DFo3TUs6uhe33qqJq6uBxCSAwG7gJob8W90BzbxKNjcCv3GoFh0jhezGW9sZpd+8vijz
 bojA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730037444; x=1730642244;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mGShBJo3gqs1r8OBjbwX8V+x22DpITrDS9TZv/hAJzM=;
 b=gbO2+yLHLSy3xg4gD3Vx3DG6M0ymTffQNZ6SGnFlUL/IK0anR3zRoCyJIRC90Nt5Ao
 S+hNgc9LQ7KdbfTc8qrMRwoRBSVrMyQptk9gFrY3jrBSJcwBt8plqdyEWBFekPUcVxyk
 WCiUbfRlgGeROgvZiYOebVZnAGx+1vAr+GsG1bgUmaPlTyFGLUfyFWT1+B2+PhT7dW0x
 PGz1Xo3ebntlYIelnIb7aLIl8ismqPgYs/hs7vkgcHnXewldZX9bWtRhB9V2vBBMEOqV
 4IZwCMjkvCuyyQxi6qWjxgHvTiQJN2L7ggNY8ZzE0AzrlXef428gmUn+lvzimwQ3X7r7
 WOSw==
X-Gm-Message-State: AOJu0YytfXtmEu/C7o1brLWuZsjnJnlvczoVJGO7oCZreqgTVLAXtHqG
 fahVdETKrmUVmFE3EoRPDd33f+Pus5dL3kKvwrf8ThC+wkFJ4TjHEqfr3buoh2JewVklK/TLF0y
 Z0O0=
X-Google-Smtp-Source: AGHT+IGOhY9L6btUl9g4PgtA2aYUIHNBcKcHu8SKg8lT4kOGeTvgHw7p7tFeS9k72rW2EE1Q7a/esA==
X-Received: by 2002:a05:6402:42c1:b0:5cb:acfa:6225 with SMTP id
 4fb4d7f45d1cf-5cbbf947321mr3474035a12.25.1730037444407; 
 Sun, 27 Oct 2024 06:57:24 -0700 (PDT)
Received: from [127.0.1.1] (adsl-161.109.242.225.tellas.gr. [109.242.225.161])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5cbb63475casm2391554a12.88.2024.10.27.06.57.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Oct 2024 06:57:24 -0700 (PDT)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Sun, 27 Oct 2024 15:57:06 +0200
Subject: [PATCH v2] rust/wrapper.h: define memory_order enum
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241027-rust-wrapper-stdatomic-v2-1-dab27bbf93ea@linaro.org>
X-B4-Tracking: v=1; b=H4sIALFGHmcC/4WNQQ6CMBBFr0JmbU1ngARdeQ/DorYFJlFKphU1p
 He3cgGX7yX//Q2iF/YRztUG4leOHOYCdKjATmYevWJXGEhTgxpbJc+Y1EvMsnhRMTmTwoOtws6
 1HZ3IUlNDGS/iB37v4WtfeOKYgnz2nxV/9m9yRYVqILL65mrERl/uPBsJxyAj9DnnLzGE+tS9A
 AAA
X-Change-ID: 20241015-rust-wrapper-stdatomic-18d58292c243
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Gustavo Romero <gustavo.romero@linaro.org>, 
 Junjie Mao <junjie.mao@hotmail.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Thomas Huth <thuth@redhat.com>
X-Mailer: b4 0.15-dev-12fc5
X-Developer-Signature: v=1; a=openpgp-sha256; l=3325;
 i=manos.pitsidianakis@linaro.org; h=from:subject:message-id;
 bh=LJFcZD5aGAm8omxYouCKWnkrDg4wDSrkse6NQ7L0waQ=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0VCYlFLUy9aQU5Bd0FLQVhjcHgzQi9mZ
 25RQWNzbVlnQm5Ia2JDNCtJYmlQczlRaHd6eU80T0Z4UmtnWVJuCnZrS0Uwakh2Zmt0aDdKRTdi
 TGFKQWpNRUFBRUtBQjBXSVFUTVhCdE9SS0JXODRkd0hSQjNLY2R3ZjM0SjBBVUMKWng1R3dnQUt
 DUkIzS2Nkd2YzNEowRVBQRC85TnRtbG5RZWNaNVhtTFNsSlRTWnJ3NUVyOXVDcWhSNDBEQTRQMQ
 ptTWRDU3c1d1hQaVVPamZsb2Y2WXdMaWozRnNxN3VzdjdnMG42TytsaUVzQ0JnQ290azZlU2NWW
 XZCRjhkbDlzCmY5MXo0YWFjYXNpMEhueGxEMVZxUGxkK2ZPQjhoNDB0OE85N2x1c3FkY0FEZkdx
 U29oMVptYVYzSSt4NnR3SGQKT0RJNW5oTEE0SlVoMG5vY3NMY1dvd0JqY0lWVGI4Nm0zK1pFNDl
 1Nmc4TVJ3R0dvV3k1TThUbTFGVXJNOW0xTQozRFgrSTZuTG9GV0NTRHpBczl5U0d2UFNYUUM2dG
 lXeDhPRjBIZEZ2cWxpYytPeDRDVURZa2Q0WmNzWm51U1ZOClRFdDBTKzl4eWhHZWlPWUN2cm0wU
 Xd1eE5qWm5VYkZQbm1KaXpYK0pDOTQ0d3NiYjczcEZMVVlQNlVic0hRRDQKbGtEckhTU3VnaEM0
 OTRhdGNPNy9jZC9QS1pEQUtJWGdNR21WQmpkdU1QTVo4YXRtWnZwemdBWG1razRkUmJ2SQp5YlJ
 xVzVsdW5mMDdJejRZYnZ6TU1pT0xUdVZHUk1rOTN0c1ZsTWVCdGZSZHNKcGg1eDA1RVRROHBDcX
 c4di91CjBacDdvSC9jb0JnTU1OSFRxRlJQWVB2U0ZIOUU2cktrMlg5bGsrYmRFZmhsRzVXY2kxY
 jdURkk5M1FCcWoxTUMKVWRIQWZIamdLRWRHbWZ1VC9ybHBPQnZVdVBwU0RZQ0RSVWp4U3M4Lzlj
 bTFDelA0eElSWGYreUZ6aWNwTmNiSQpydm5IMFpXY3pBNzkwQ1lnN0txY3F3S3Yxc2l1YVZ0eWV
 GNFRLODNiZ1RDMGN3UWc5Wk40aFRCU2wxcXJGN1NuCkRqVTZZdz09Cj1aTkJICi0tLS0tRU5EIF
 BHUCBNRVNTQUdFLS0tLS0K
X-Developer-Key: i=manos.pitsidianakis@linaro.org; a=openpgp;
 fpr=7C721DF9DB3CC7182311C0BF68BC211D47B421E1
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ed1-x52c.google.com
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
Changes in v2:
- Restored warning print in `configure` script (thanks Paolo and Junjie)
- Link to v1: https://lore.kernel.org/r/20241015-rust-wrapper-stdatomic-v1-1-f22c0bd31140@linaro.org
---
 rust/wrapper.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

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
base-commit: cea8ac78545a83e1f01c94d89d6f5a3f6b5c05d2
change-id: 20241015-rust-wrapper-stdatomic-18d58292c243

--
γαῖα πυρί μιχθήτω


