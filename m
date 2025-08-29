Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDB24CA1000
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 16:47:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNjy-0007mQ-RB; Sat, 30 Aug 2025 11:43:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1us7Wj-0002i3-4O
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 18:24:57 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1us7Wh-0002fo-AU
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 18:24:56 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-771fa8e4190so1831452b3a.1
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 15:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756506293; x=1757111093; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ralhvmUvXrh398W1CgVKuYzVQB39ukDZoh3ULpQX2JM=;
 b=rhafRtNJfK803LTWNg2mEvPEVfkk7EI4B6M+QMrQ7A80FMO7TgfViBNMcIZZhu5aX3
 Lp/Al6xEjgSyXwXqamEg/+r1i40o/T2mJsDRGnJ///cEAW4Xbes74DELG71NNlVQEYCh
 TDrArLf1ADLAu0Ga2mVYIfcqwuoI10oVqlsEd6gTrzxETdcRVw0ycxwkzXzUFg96UDjw
 71Los12pQYqhObAeHHcSQuBNm+lmO6uM6qgG1s1VRYBNLiLPJK72GlDMTIegTLSfA1wK
 KAGxBYPZRQ4yPK6BP1OWBhuRhKdYXRgD/HdLHQOZp46+eaxBgoBvi0+4+2hSFda5mbzD
 ESEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756506293; x=1757111093;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ralhvmUvXrh398W1CgVKuYzVQB39ukDZoh3ULpQX2JM=;
 b=W0+ylI9C4Mil0S+1QB2Cd8V3XUkK+b/7hhwtEXVM4hmTYxZHKsCNVWa1cexdmRHidK
 GFMNpFRdJpBMqV9iPLRs8Ae3lH2vZncB56RDGPEFPfjrPq9nzdCmAVwTGwX6MOhRTQp9
 rox+OjdVBRkPhMV2mGcB5g/3eB8hsNCixsb8ZWl8aQCKzs33/tseNQDIR9plwih+ewfc
 EypGwzlHCnYQ8O/ok+LsYaNGp9qaIeR0iUAnXsemc1sE7t9ALNjxi5RvEmE95N+34V2C
 2UKLpf7FbYSTVRcOPB5A0XwS3bulNRL0bep0eAqQaV4hKpA0qmfWRH3Wvz7q3ChC72U2
 pbYQ==
X-Gm-Message-State: AOJu0Yx2dSb0WRseZQEH6uTRvL0Rj9io8ovivrikAWi2biPPRfvBcLLf
 zBNlnlK1HKTL+dkxcY9Wx+ixFtpnCKaLiLSQJ6qDeuMCjpdGtkUDgLlor1KSiyJoCQtvO5VehCr
 JIV4MNNE=
X-Gm-Gg: ASbGncsnXt16pU7TaZBCXd6zMEYMmqezvThFQxLHctKLbcjmrEgDhM9iYXQhUkgbME/
 3kcWp30Ts1B0AI25P4joi0wmMJHi2eGH7wO3fnbuyUw36TthT5SpDsRohPp4bmgBEichVn72cys
 FiAO23BpFY1Gv9Oo1P9A27rZOrdQNHCKH86XUufJDw3mOLooPoBZj3A4mDHrDEHwL+jk1togD8m
 C6S5r6I/Zlw3YIUmMAm0dVkQMZQN8gf0yktIb9xuwUE0Um4en9hj7PbN0M05RcKVu7fNs7/VYOW
 t/Nsgb/yQVtDD3i+8PdhFqK0WzBNLdavALCswg7OT2BFIImwIiyvbGwgvXK2QFLd4qcEvs18mcq
 VWQeidkMm8Z63vepwQQzfbmqE0kOPFnYCei2yMyVFc9U7Fw74rx3jxGm4Gr1l
X-Google-Smtp-Source: AGHT+IEUm+Vr8+uu7r+yv1J+CGVwv26IAHiZbw8Ry0zjJa34Ut1v8SP96Jwvf9SqtqrbRru1Srh6mA==
X-Received: by 2002:a05:6a00:1956:b0:772:a60:6c04 with SMTP id
 d2e1a72fcca58-7723e1ee875mr353125b3a.2.1756506293548; 
 Fri, 29 Aug 2025 15:24:53 -0700 (PDT)
Received: from stoup.. (122-150-204-12.dyn.ip.vocus.au. [122.150.204.12])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7722a71c60bsm3302493b3a.103.2025.08.29.15.24.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 15:24:53 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 08/91] linux-user/aarch64: Convert target_elf_gregset_t to a
 struct
Date: Sat, 30 Aug 2025 08:23:04 +1000
Message-ID: <20250829222427.289668-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250829222427.289668-1-richard.henderson@linaro.org>
References: <20250829222427.289668-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/elfload.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 0180f6063f..da57c6c2ce 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -384,18 +384,17 @@ static const VdsoImageInfo *vdso_image_info(uint32_t elf_flags)
 #define ELF_CLASS       ELFCLASS64
 
 #define ELF_NREG    34
-typedef target_elf_greg_t  target_elf_gregset_t[ELF_NREG];
+typedef struct target_elf_gregset_t {
+    target_elf_greg_t regs[ELF_NREG];
+} target_elf_gregset_t;
 
-static void elf_core_copy_regs(target_elf_gregset_t *regs,
-                               const CPUARMState *env)
+static void elf_core_copy_regs(target_elf_gregset_t *r, const CPUARMState *env)
 {
-    int i;
-
-    for (i = 0; i < 32; i++) {
-        (*regs)[i] = tswapreg(env->xregs[i]);
+    for (int i = 0; i < 32; i++) {
+        r->regs[i] = tswapreg(env->xregs[i]);
     }
-    (*regs)[32] = tswapreg(env->pc);
-    (*regs)[33] = tswapreg(pstate_read((CPUARMState *)env));
+    r->regs[32] = tswapreg(env->pc);
+    r->regs[33] = tswapreg(pstate_read((CPUARMState *)env));
 }
 
 #define USE_ELF_CORE_DUMP
-- 
2.43.0


