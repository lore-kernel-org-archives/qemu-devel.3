Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0E5BC5AC7C
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2026 06:29:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wsE4N-00030f-WF; Fri, 07 Aug 2026 02:28:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <scherer.simon89@gmail.com>)
 id 1wsE4M-00030Q-Of
 for qemu-devel@nongnu.org; Fri, 07 Aug 2026 02:28:38 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <scherer.simon89@gmail.com>)
 id 1wsE4L-0003aj-3p
 for qemu-devel@nongnu.org; Fri, 07 Aug 2026 02:28:38 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-47f904e80eeso2485843f8f.1
 for <qemu-devel@nongnu.org>; Thu, 06 Aug 2026 23:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786084115; x=1786688915; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=BthZMi5aiboRYBSYsdordM+1qmYl7Da/2BBvfRJwpCU=;
 b=CKrtmBSuz7PwI2IsWaY0xnZz9i9YKNgrU/VeQu3TMiCrbZeZ0W82h6l1mXVUXKUlfV
 yxSoALr+n6SMl/bEoKg/+bX4MJEDOGvK/EWQ1pkf7HFKZ1toZpDAVXtnAxSy9T0xs9Bf
 mOm6nAKkEouokilc+7o8q26yYyDxrWwP+cwMjZuqGr2UwwV6+48QxUYfiLPQycErgC1r
 +69VbEzXPpJYQLB53m+Mkbb2gXoUJLBHTEywkWXL3v0yzfTpIKMBsG/qSB2hA1sRFtTU
 0qn+dFcwL9+GsNMyi0ZCKrur9/qB+uimyKN2xGJV4p9RuSU5/FEwUjwuV8CmSixbGW15
 poYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786084115; x=1786688915;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=BthZMi5aiboRYBSYsdordM+1qmYl7Da/2BBvfRJwpCU=;
 b=YqML3gh06GoljRVsk6ANGdjiBxZIfhgEMLOdbOuTEkbO3WKfZitkLuJBXtiXmPMQgt
 yElkyrItICWtzI8P6FrtacPZESD7PzOzOYPIDM3wUEE4NG+0qEK5m9CF8qK3PeNhWO3v
 bYodbZU2pSjTKRzZs4rXyzXbPsYAl/uR4H14eJhpCROS2C+lbyjxMxKU+AIrba7rSQ5c
 d/5TNhZAYgpWkDlVJKTfK5JWhdqOz4bnf/i8ZlXAL1lGCywaSN+1gbUZVvwpaYFQSwR9
 /zJznwIEnO2H2NSvgZ5aS/VdFsfG/V6Ww6AlcYjGgX9ck5k/5yoA/5O8c22bvmbx4vav
 9/JQ==
X-Gm-Message-State: AOJu0YxGa9q1wFNsY+Z+DHl5aXXY/OJ9SEMLlVnz8//JSIRAf+xaijks
 y4XXrXDkvYryf1VrCGzLdsvmJPG+OIYecdqrtYeFSSLvlwIJ9P/dYON6jhPRyKgpHtU=
X-Gm-Gg: AR+sD10OjE0TroEUIOUY+sOF0SFLM8qVZMcD+RVOoYnqDBFlEp3/vjnQpYc+6hBXqqE
 AhAlPAqJka0CuvLDQR12O2hHSVwvOezGG6gNMUgl/4qczzgcH5Bpf8p/v6psiHAUUnARLHm86BK
 87VilZj1Jk6WdnuH3+qSfD1mDCtpy19tsXil2DZYs6KvVpKbtHEGZtdL4F7NEaeutCzCuFyfiw7
 ymy5rgkBRKvJNqybUIM2xYAEJrm+srcz1ptT1mKT+Qc4r1vBNWabkvjt5pMGZirN6/jzfEIYq8J
 Z6wbFUeLLorG075VElFnxa2PqiApaznoGLNNiiSzYtXYuMeAf7zBxdPw23r8JRoj65exfGQ88OS
 /gYsE9pZSIUUbcoB2coWG/0xYg3SH5z2oqtl0mg7/BIL9i4B5CzB6eL6BAV+nQPJLGMp8gHYJnL
 XJgpBYGOOkwF9Iobi2QUHPHhSIJ3ODqnjFSmhSECbMP5iWkKbQhhdZ26iJqZBCqjkgmqtjH+OIy
 /c0wbRFbb9MYzP6K2M47V2QVSsF2vuDgPuk/ghverXOTd2HBkTkVg5zqBAGfKm1E90itl83LRU8
 7/HFYoLNXtYgrFPq8jCZd27LkUXk
X-Received: by 2002:a05:6000:29d5:b0:47f:6f89:7dae with SMTP id
 ffacd0b85a97d-47fec4e291dmr24678119f8f.6.1786084114907; 
 Thu, 06 Aug 2026 23:28:34 -0700 (PDT)
Received: from simon-macbookpro.tugraz.local (tug-swl-c122.tugraz.at.
 [129.27.234.122]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-480021e7b3fsm2727907f8f.20.2026.08.06.23.28.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2026 23:28:34 -0700 (PDT)
From: Simon Scherer <scherer.simon89@gmail.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, richard.henderson@linaro.org,
 Simon Scherer <scherer.simon89@gmail.com>
Subject: [PATCH v2] target/i386: Clear OF, SF, and AF for fcomi/fucomi
Date: Fri,  7 Aug 2026 08:28:31 +0200
Message-ID: <20260807062831.19618-1-scherer.simon89@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=scherer.simon89@gmail.com; helo=mail-wr1-x42c.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

helper_fcomi_ST0_FT0() and helper_fucomi_ST0_FT0() only cleared
CC_Z, CC_P, and CC_C before merging in the comparison result,
leaving CC_O, CC_S, and CC_A untouched from whatever they were
set to beforehand.

The Intel SDM documents FCOMI/FCOMIP/FUCOMI/FUCOMIP as setting OF,
SF, and AF to 0 unconditionally. The AMD manual doesn't mention them
at all. However, testing on multiple real Intel and AMD systems confirms
all three are unconditionally cleared regardless of the comparison
result or their prior value.

Since fcomi_ccval[] only ever contains CC_C, CC_Z, 0, or CC_Z|CC_P|CC_C,
and CC_O|CC_S|CC_Z|CC_A|CC_P|CC_C already covers every flag bit, CC_SRC
can be assigned from fcomi_ccval[ret + 1] directly instead of ORing it
into a masked cpu_cc_compute_all() result.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4133
Signed-off-by: Simon Scherer <scherer.simon89@gmail.com>
---
v2: Simplify per Richard Henderson's review: CC_O|CC_S|CC_A|CC_Z|CC_P|CC_C already covers
    every flag, so drop the now-pointless cpu_cc_compute_all() call and assign
    CC_SRC from fcomi_ccval[] directly.

 target/i386/tcg/fpu_helper.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/target/i386/tcg/fpu_helper.c b/target/i386/tcg/fpu_helper.c
index 978eb1411b..b812125efa 100644
--- a/target/i386/tcg/fpu_helper.c
+++ b/target/i386/tcg/fpu_helper.c
@@ -550,12 +550,11 @@ static const int fcomi_ccval[4] = {CC_C, CC_Z, 0, CC_Z | CC_P | CC_C};
 void helper_fcomi_ST0_FT0(CPUX86State *env)
 {
     int old_flags = save_exception_flags(env);
-    int eflags;
     FloatRelation ret;
 
     ret = floatx80_compare(ST0, FT0, &env->fp_status);
-    eflags = cpu_cc_compute_all(env) & ~(CC_Z | CC_P | CC_C);
-    CC_SRC = eflags | fcomi_ccval[ret + 1];
+    /* OF, SF, and AF are unconditionally cleared to 0 */
+    CC_SRC = fcomi_ccval[ret + 1];
     CC_OP = CC_OP_EFLAGS;
     merge_exception_flags(env, old_flags);
 }
@@ -563,12 +562,11 @@ void helper_fcomi_ST0_FT0(CPUX86State *env)
 void helper_fucomi_ST0_FT0(CPUX86State *env)
 {
     int old_flags = save_exception_flags(env);
-    int eflags;
     FloatRelation ret;
 
     ret = floatx80_compare_quiet(ST0, FT0, &env->fp_status);
-    eflags = cpu_cc_compute_all(env) & ~(CC_Z | CC_P | CC_C);
-    CC_SRC = eflags | fcomi_ccval[ret + 1];
+    /* OF, SF, and AF are unconditionally cleared to 0 */
+    CC_SRC = fcomi_ccval[ret + 1];
     CC_OP = CC_OP_EFLAGS;
     merge_exception_flags(env, old_flags);
 }
-- 
2.53.0


