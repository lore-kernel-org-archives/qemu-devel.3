Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66574EB2711
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 20:16:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpu9P-00080N-T7; Tue, 10 Feb 2026 15:16:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vpu9I-0007gL-4G
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 15:15:52 -0500
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vpu9F-00089T-UT
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 15:15:51 -0500
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-c698873a1deso562809a12.0
 for <qemu-devel@nongnu.org>; Tue, 10 Feb 2026 12:15:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770754548; x=1771359348; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=H0/6jyx5lBSzvidGPzp44soUpJA5ox0vbl/G+VGissc=;
 b=HIVBLZ68sYoPn99PhpnZQaA3jH/3pyz3p+wiC72j3bN1JtAyjDM4bDTIXcRDvOJTut
 QavWbV/1SKTMmOtUvaTLhPLXP72DXMQhHAlt7LT/Qm075Wat3ELRGRTDaIw/1NKhyJfO
 wsH7JkAl7X+tQ7j1SpX1YTDTnExlMohatvzLRU9JMjniSRVVgMIu2wSf8qMwec66wPgR
 +FA63V6XH7IOpVfpteUztNTS92vwgNg7XV477IfroTh/To4EVwrE2h0rlLaBEGBLgHVS
 iephecWKNMgOVw69PGZ8apS9mLfQ0vn27j/shIhQuOnYZ+2oL4prwdZJhDuwNkIZXMht
 k5pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770754548; x=1771359348;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=H0/6jyx5lBSzvidGPzp44soUpJA5ox0vbl/G+VGissc=;
 b=cFIVQsPwsNycm5tflr04qc9gzkXCttvQChwgNT8eNI8MuG04mhk1lVjAuEzQoPfPTZ
 OUI7DCRdJOioVCNo1d+aj5mTD0500jgieL667U8jJ9U+E6Sz+ncw4eY7f9bMymxl5Jcb
 qamSsNk7320G/i4Pg2mbYVjKhjhfXf+c7H7YHRcPkQlIZEJqhIVlqsrfF5gkh+5KvSHr
 5Nr7BFA/BdzudotSHHcrqsr6BfWhW6KSITwY+jJgKF6djF1PyzHlrgASyhAu7j0vaa2a
 iE6c6Wrx+KPw+sODQCFNXDhc7BSHFTPwP+jZ1DlUH1B9r7uAytpDoIY7B9Zh86ptCCkt
 6MYw==
X-Gm-Message-State: AOJu0YwTiJgVLYJYzMEQNnTEdjk0H8ondFfTXayhfxkE1r1NeTCiXdBx
 r6irtEQEjaWDN2Od0OkGQSCi+VWzA9nt/LM1fCr3e+bDwbNIs7EE52vocVOy9otPgAVcJw9zpgY
 LV5++
X-Gm-Gg: AZuq6aJUMmi6JrGWs7VIG+yN+t3bOi4QtVSMkxG3VUP+ZUkflWxx5MlQaCyRt3n7Fw+
 xFKuo983WnXkGUSpM1nSQN+rJpG0lNlDUBVlMkY0N89YIiqP81HKQxCJ/84AGJ1F2yxK8Ijzkjw
 CWyPP1Hu4JHFZYEm9DcuHto3MnjdkH3q1yMdAD0+TnLKwQC6SZShOojI2kWSSZZ6HEsR+6Kqf+C
 KpCvypsXPmFbF+0pjIcmhmnWOm6cJHnWndH6aCNxYYxmebQXZb4oU0eOZjwAHNNheB9fiCTK9fB
 VckObumLYay14cVNElGGkIiBh04uL1VjLdFSbOLLyzqOXadegD726x4RyDTlOTwvTkUXplRPm/e
 /Ju1rCYG19x1r0fsJ1OlV8kIob48WR4ERDnSA1raw3s5uzidGErwclzplkovEcdAG8kNc5pbdp7
 deF9KFgfuUaYRiOZk+n8U9VhyD4voNGqB7rByYee3FaXHDTK0SPXJVsk/10/rUhBdWdWzDno6Yi
 Kdq
X-Received: by 2002:a17:902:da91:b0:2a0:c5a6:c8df with SMTP id
 d9443c01a7336-2a9516cd2fbmr174890375ad.21.1770754547963; 
 Tue, 10 Feb 2026 12:15:47 -0800 (PST)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ab0b392cb5sm38523225ad.70.2026.02.10.12.15.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Feb 2026 12:15:47 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: anjo@rev.ng, Jim MacArthur <jim.macarthur@linaro.org>, kvm@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v3 03/12] target/arm: extract helper-sve.h from helper.h
Date: Tue, 10 Feb 2026 12:15:31 -0800
Message-ID: <20260210201540.1405424-4-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260210201540.1405424-1-pierrick.bouvier@linaro.org>
References: <20260210201540.1405424-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x52f.google.com
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/helper-sve.h                            | 14 ++++++++++++++
 target/arm/helper.h                                |  1 -
 target/arm/tcg/{helper-sve.h => helper-sve-defs.h} |  0
 target/arm/tcg/gengvec64.c                         |  3 ++-
 target/arm/tcg/sve_helper.c                        |  3 +++
 target/arm/tcg/translate-a64.c                     |  1 +
 target/arm/tcg/translate-sme.c                     |  2 ++
 target/arm/tcg/translate-sve.c                     |  2 ++
 target/arm/tcg/vec_helper.c                        |  1 +
 9 files changed, 25 insertions(+), 2 deletions(-)
 create mode 100644 target/arm/helper-sve.h
 rename target/arm/tcg/{helper-sve.h => helper-sve-defs.h} (100%)

diff --git a/target/arm/helper-sve.h b/target/arm/helper-sve.h
new file mode 100644
index 00000000000..ae4f46c70a0
--- /dev/null
+++ b/target/arm/helper-sve.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#ifndef HELPER_SVE_H
+#define HELPER_SVE_H
+
+#include "exec/helper-proto-common.h"
+#include "exec/helper-gen-common.h"
+
+#define HELPER_H "tcg/helper-sve-defs.h"
+#include "exec/helper-proto.h.inc"
+#include "exec/helper-gen.h.inc"
+#undef HELPER_H
+
+#endif /* HELPER_SVE_H */
diff --git a/target/arm/helper.h b/target/arm/helper.h
index 79f8de1e169..2f724643d39 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -3,6 +3,5 @@
 #include "tcg/helper.h"
 
 #ifdef TARGET_AARCH64
-#include "tcg/helper-sve.h"
 #include "tcg/helper-sme.h"
 #endif
diff --git a/target/arm/tcg/helper-sve.h b/target/arm/tcg/helper-sve-defs.h
similarity index 100%
rename from target/arm/tcg/helper-sve.h
rename to target/arm/tcg/helper-sve-defs.h
diff --git a/target/arm/tcg/gengvec64.c b/target/arm/tcg/gengvec64.c
index c425d2b1490..c7bdd1ea82f 100644
--- a/target/arm/tcg/gengvec64.c
+++ b/target/arm/tcg/gengvec64.c
@@ -18,10 +18,11 @@
  */
 
 #include "qemu/osdep.h"
+#include "cpu.h"
+#include "helper-sve.h"
 #include "translate.h"
 #include "translate-a64.h"
 
-
 static void gen_rax1_i64(TCGv_i64 d, TCGv_i64 n, TCGv_i64 m)
 {
     tcg_gen_rotli_i64(d, m, 1);
diff --git a/target/arm/tcg/sve_helper.c b/target/arm/tcg/sve_helper.c
index 0600eea47c7..16e528e41a6 100644
--- a/target/arm/tcg/sve_helper.c
+++ b/target/arm/tcg/sve_helper.c
@@ -25,6 +25,7 @@
 #include "exec/target_page.h"
 #include "exec/tlb-flags.h"
 #include "helper-a64.h"
+#include "helper-sve.h"
 #include "tcg/tcg-gvec-desc.h"
 #include "fpu/softfloat.h"
 #include "tcg/tcg.h"
@@ -38,6 +39,8 @@
 #include "user/page-protection.h"
 #endif
 
+#define HELPER_H "tcg/helper-sve-defs.h"
+#include "exec/helper-info.c.inc"
 
 /* Return a value for NZCV as per the ARM PredTest pseudofunction.
  *
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 1a54337b6a8..31fb2ea9cc3 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -19,6 +19,7 @@
 #include "qemu/osdep.h"
 #include "exec/target_page.h"
 #include "helper-a64.h"
+#include "helper-sve.h"
 #include "translate.h"
 #include "translate-a64.h"
 #include "qemu/log.h"
diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index 091c56da4f4..463ece97ab8 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -18,6 +18,8 @@
  */
 
 #include "qemu/osdep.h"
+#include "cpu.h"
+#include "helper-sve.h"
 #include "translate.h"
 #include "translate-a64.h"
 
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index 64adb5c1ce3..c68a44aff8c 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -18,6 +18,8 @@
  */
 
 #include "qemu/osdep.h"
+#include "cpu.h"
+#include "helper-sve.h"
 #include "translate.h"
 #include "translate-a64.h"
 #include "fpu/softfloat.h"
diff --git a/target/arm/tcg/vec_helper.c b/target/arm/tcg/vec_helper.c
index 7451a283efa..bc64c8ff374 100644
--- a/target/arm/tcg/vec_helper.c
+++ b/target/arm/tcg/vec_helper.c
@@ -21,6 +21,7 @@
 #include "cpu.h"
 #include "exec/helper-proto.h"
 #include "helper-a64.h"
+#include "helper-sve.h"
 #include "tcg/tcg-gvec-desc.h"
 #include "fpu/softfloat.h"
 #include "qemu/int128.h"
-- 
2.47.3


