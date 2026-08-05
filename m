Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFDD2C55ABA
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2026 17:16:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wrfD0-00042j-GD; Wed, 05 Aug 2026 13:15:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1wrfCy-00042X-QD
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 13:15:12 -0400
Received: from mail-yw1-x112e.google.com ([2607:f8b0:4864:20::112e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1wrfCx-0006Ew-Ac
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 13:15:12 -0400
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-81f36179d72so18875057b3.2
 for <qemu-devel@nongnu.org>; Wed, 05 Aug 2026 10:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785950110; x=1786554910; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=zBJkHE/+507IdXzI3/EkOVxmNpC2MjtV85OlC39+S8E=;
 b=K2omkSrk44KvRQUTZi4eSNp9gqYiqlLHjHSwDbM/H5zIoIlctOtJY0/AltyPNLytYl
 LRYN7SRBuQa/xJ6y7aKVY35ClHh733xENmJ7OY8qX+pSBu2Gati2oh/eNiSm48+xyn4x
 Co6h5AnKWI9bXD7/WZrzaIQL4vBADVDOR3jtX8VzkEIFBihkkNZdcp7MvOGfMth1S3ii
 xEO8muziwcqEgWLQmbxHipmFDjP0EhKAqEoTP9c7tPFP/9fkMGdZK7OTVv3l9sqGs8Jg
 cJJg9lfDSRaMw0+XQdk/7jqy//FpE5fI8AsrrtnpBL1GRWODfNL8jpVIkXf1NyKTLNxz
 6vFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785950110; x=1786554910;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zBJkHE/+507IdXzI3/EkOVxmNpC2MjtV85OlC39+S8E=;
 b=Aqxh5LJ9SP9skG4Dx5O6n0e5jW2xkvOSR6ga4sllfTpOIoBprfivfkR2LDej5Ij4eS
 xnVRIly6kOGD68IyxDs6mg+u8NExas0IIDwJJjgqfq0HQc5elZgcnfFe6UVPANHZDpq4
 t9vqUt+fCP4QiBtSPyfn3Cvtz3S74pV8v+mSFjPmqwCaor0pv5ZTMImkVVJZ+7fTHeuU
 zKwBof/6fm8cSC9FsejiZUYGdMb2NlLIlxFwzlZnGIg2lv5yc35UY655P1U/inw59ben
 lHnZSs04yAwdw/F90YGrmvOx0CGPxBb5ZfCLpZBFRyv/TLzuMyeHpwQMcEtfxZit99Cj
 qHgA==
X-Gm-Message-State: AOJu0Yw0mOgHHMHGyfxePuAjMHrbjCYcLIpxEQ7QgTNHnq07CXyNilAX
 G+wWaLNFvXMI550lLNhKtOTeka7uhV0giLmBlkf88Vg+gqhL/gJVMqqodLDFQi/zSnc=
X-Gm-Gg: AR+sD11gUODg5He3sRjyyELIMWq/uVJiEEcIwT1waR9L3XYlllMpydCennQylDgmQYC
 DDKSQ2lAVLnN+FLpK+7edYOSmKjA2zfWEn36P8UiL5UGt5sLrXRPQrPeb9mgTU68497BVr+YRhg
 f6+mYMH3XEYcYfwnGSNb8zCwkZf7Fsr4PuEhdw5/WfMcFTUv1FqmveBfeR4wuPcSOZMBotQeVfQ
 PlStE33pF6RvT7t6rG2d3U+Jye/mIeltteD4wh4sfFSYItDp4v1K5vPUM2n90uqp/y2cZoWQuXT
 cr6IQ8FGQBGcTuMH+YLMKQAThvuMT7BjT5iR3muUxYc8NOnh8mq9SqwpvGr+nObhkh1669lSdcc
 vIGfMuCZeQUhDUbS5feyXg5TsvPGcaE5TJPzDRaBxIpcb32KNxdmlv+jCOhr04Oo021bmgY4dsW
 3kBpM6USWQWAFHXKKRRPxH4SK86H40mvxP7zA/x0IoucJlet28j3yqed9A62iD
X-Received: by 2002:a05:690c:6887:b0:80e:38c5:bc17 with SMTP id
 00721157ae682-8201f0bcaf5mr44853357b3.7.1785950109822; 
 Wed, 05 Aug 2026 10:15:09 -0700 (PDT)
Received: from localhost ([2600:1702:7a90:6f9f:8bc4:8aec:108d:7a04])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-820132385dbsm24591967b3.16.2026.08.05.10.15.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Aug 2026 10:15:08 -0700 (PDT)
From: Matt Turner <mattst88@gmail.com>
To: qemu-devel@nongnu.org
Cc: Matt Turner <mattst88@gmail.com>, Laurent Vivier <laurent@vivier.eu>,
 Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH 1/5] linux-user/alpha: write the floating-point registers to a
 core dump
Date: Wed,  5 Aug 2026 13:15:03 -0400
Message-ID: <20260805171507.3119442-1-mattst88@gmail.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::112e;
 envelope-from=mattst88@gmail.com; helo=mail-yw1-x112e.google.com
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

A guest core carried only the general-purpose registers, so a debugger
opening one reported every floating-point register as unavailable --
including the arguments of the function that crashed.

Implement HAVE_ELF_CORE_FPREGS for Alpha: define target_elf_fpregset_t
to match the kernel's layout ($f0-$f30 plus the control register in the
slot $f31 would occupy) and fill it from elf_core_copy_fpregs().

Checked with lldb on a core from a program that faults with live values
in $f16 and $f17: both read back correctly, as does the control register.

Signed-off-by: Matt Turner <mattst88@gmail.com>
---
 linux-user/alpha/elfload.c    | 10 ++++++++++
 linux-user/alpha/target_elf.h | 11 +++++++++++
 2 files changed, 21 insertions(+)

diff --git ./linux-user/alpha/elfload.c ./linux-user/alpha/elfload.c
index 7be9e466b6..c2517516ad 100644
--- ./linux-user/alpha/elfload.c
+++ ./linux-user/alpha/elfload.c
@@ -32,3 +32,13 @@ const char *get_elf_cpu_model(uint32_t eflags)
 {
     return "ev67";
 }
+
+void elf_core_copy_fpregs(target_elf_fpregset_t *r, const CPUAlphaState *env)
+{
+    int i;
+
+    for (i = 0; i < 31; i++) {
+        r->fpr[i] = tswap64(env->fir[i]);
+    }
+    r->fpcr = tswap64(cpu_alpha_load_fpcr((CPUAlphaState *)env));
+}
diff --git ./linux-user/alpha/target_elf.h ./linux-user/alpha/target_elf.h
index dd90c6f783..5efe7f3174 100644
--- ./linux-user/alpha/target_elf.h
+++ ./linux-user/alpha/target_elf.h
@@ -19,6 +19,17 @@
  *   r0-r30 at indices 0-30, pc at 31, ps at 32.
  * r31 (hardwired zero) is not stored; pc occupies index 31.
  */
+/*
+ * The floating-point note holds $f0 through $f30 and then the control
+ * register in the slot $f31 would occupy; $f31 reads as zero.
+ */
+#define HAVE_ELF_CORE_FPREGS    1
+
+typedef struct target_elf_fpregset_t {
+    uint64_t fpr[31];    /* $f0-$f30 */
+    uint64_t fpcr;       /* the slot for $f31 */
+} target_elf_fpregset_t;
+
 typedef struct target_elf_gregset_t {
     abi_ulong regs[31];  /* integer registers r0-r30  [0..30] */
     abi_ulong pc;        /* program counter           [31]    */
-- 
2.54.0


