Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4462C79FB6
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 01:35:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4Tgh-0003KG-RM; Wed, 09 Sep 2026 21:34:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1x4Tgg-0003Jr-EY
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 21:34:50 -0400
Received: from mail-yx2-x10.google.com ([2607:f8b0:4864:41::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1x4Tge-00023B-Ur
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 21:34:50 -0400
Received: by mail-yx2-x10.google.com with SMTP id
 00721157ae682-85d4e39e3d8so16992907b3.0
 for <qemu-devel@nongnu.org>; Wed, 09 Sep 2026 18:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789004088; x=1789608888; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=N9dg2+CuYt9vAgXpGp5lrRa4+Jkl2SCWzcl0cPhTvZg=;
 b=hHvqcRW3cW+aq6BTEED2E204oGflO8rNmMQDxqFRQzUjxpaLuL7fbkeqc0VB+/R7oY
 Fw3IzON5HNyjTlbMMO5sBFbdB3fijiJqXqIbKX8tm44Dd5RHhfszawOrK6n35GnnFygy
 3foHiCQDV0KeiE/HxAJG7wNUFRru8T3y2LqZIDQHjBurlqSdJk9wAgfeukodUdX7vtTz
 BlAnjgIblhsMdriBOhby7AK0xgQeHZt4q6APcRQi0WU3UaCiKOhZ+IcHPxSsbSPd9hcT
 FVseOp631iEp8e/Zyf09UcXac2N+a4JUwNTFJvmP2N25pr5KOfXz/7mpmfNPTth7/h8P
 JlIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789004088; x=1789608888;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=N9dg2+CuYt9vAgXpGp5lrRa4+Jkl2SCWzcl0cPhTvZg=;
 b=oa2MLmfXGS/FTUbcGtn8UW2bLVAalzScDoSSh9TjkZvpyw9mnoijITHWC3uFfFFOnX
 WuDJg3GN3qWfPPdWO5C+grCFYTQvMLxpUz5vIEnOCSOrI/TRhzORQ3uRBEHkJioX6zxW
 WJ6dZ0NNKlSvSKoJlYLih9bhGaALiDVEJFgCCFyCJ6mV+0FDsbZoC43P41zX6NRO8CII
 UVaL9bLuGBP7JtWFYFv6hiRD3+TSJYayPj22UG7UepfiQGv5My/1r6oJcHNcR/orMvWh
 JU6b06xwI50paYeG17gEWh/R3KipVZL+bUo5XrT2LDlqXdXLBqZRHy4G4DwerjwnQ/OO
 qIuQ==
X-Gm-Message-State: AFuF++ni5fak4LBYPWQcPL9AHxGazw+eRRCca2df6ieUCJIGF7eWWxuE
 CAAHY3POCckYFcGCLKexbx7NKzkSgjHWwHKkKKW3o9zuDDd15GgWJXWwhkeOXqRT
X-Gm-Gg: AYBFou2p9XvN8g6cE0RferC3cA+G9uP8p0C3EqNegg4ZA507/R54WXdaF1bZePm7RrC
 h88hVarmahALnvaY0Q9dZovWB7IPMcG/tohwEvHiiecoMpEv7BIy7oxk2F+Tm77eI8X0sSt4ZnO
 iIJ0keihxXeoiLhqFOEEVde9n9VIGtXTGaaUjVYX+BviZS0vvl+r3Inr1OD4xj3WriFjhF+zNma
 H5FdN080YWd29/xI9oC4vvYqW6XGCpw337+QmgTIOL74fjI5C+QY7h8XAA2mOQZEGRAe/PyKpbg
 ZLleoWI2UdDLczSJehTaSYHNNBudZMuZ8v+bDJGEWsJyZY/haE7Z0xqtCI87qcFjWAbICindDw+
 ZsbZBVIICk3UFWrtkexDseUx8o1kI/T88m+MD5+SQ1l8Mo8L0Q9P2Uz19uPpX/scZIdLa+8JRIU
 IGnzeBILdToGYd6AOk3WEYNptvUlUUClgMvSjSWyX5J1Su/eMyGeCkGdxIG4bFIH/4BuQVE7k=
X-Received: by 2002:a05:690c:e3e5:b0:873:5c6b:a319 with SMTP id
 00721157ae682-88203ba7b53mr7230627b3.19.1789004087770; 
 Wed, 09 Sep 2026 18:34:47 -0700 (PDT)
Received: from localhost ([2600:1702:7a90:6f9f:8bc4:8aec:108d:7a04])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-8714bb0f0b6sm119288007b3.44.2026.09.09.18.34.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Sep 2026 18:34:47 -0700 (PDT)
From: Matt Turner <mattst88@gmail.com>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>, Laurent Vivier <laurent@vivier.eu>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 2/3] linux-user/i386: write the floating-point registers to a
 core dump
Date: Wed,  9 Sep 2026 21:34:41 -0400
Message-ID: <20260910013442.1517793-3-mattst88@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260910013442.1517793-1-mattst88@gmail.com>
References: <20260910013442.1517793-1-mattst88@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:41::10;
 envelope-from=mattst88@gmail.com; helo=mail-yx2-x10.google.com
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
opening one reported the x87 stack as unavailable.

Implement HAVE_ELF_CORE_FPREGS for i386: define target_elf_fpregset_t to
match the kernel's elf_fpregset_t, i.e. struct user_i387_struct from
arch/x86/include/asm/user_32.h, which is the legacy FSAVE image without
the trailing software status word that FSAVE does not write either.
cpu_x86_fsave_noinit() produces exactly that, already in target byte
order.

The SSE registers are still absent: the kernel dumps those in a separate
NT_PRXFPREG note, which the generic core dump code has no support for.

Checked with gdb on a core from a program that faults with 1.5 and 2.25
live on the x87 stack: "info float" reads both back, along with the tag
word and the instruction and operand pointers.

Signed-off-by: Matt Turner <mattst88@gmail.com>
---
 linux-user/i386/elfload.c    |  7 +++++++
 linux-user/i386/target_elf.h | 18 ++++++++++++++++++
 2 files changed, 25 insertions(+)

diff --git ./linux-user/i386/elfload.c ./linux-user/i386/elfload.c
index 2e10f38a41..3c8a65e35c 100644
--- ./linux-user/i386/elfload.c
+++ ./linux-user/i386/elfload.c
@@ -25,6 +25,13 @@ const char *get_elf_platform(CPUState *cs)
     return elf_platform[family - 3];
 }
 
+void elf_core_copy_fpregs(target_elf_fpregset_t *r, const CPUX86State *env)
+{
+    /* The FSAVE image exactly, stored in target byte order. */
+    QEMU_BUILD_BUG_ON(sizeof(*r) != 4 * 7 + 8 * 10);
+    cpu_x86_fsave_noinit((CPUX86State *)env, r, sizeof(*r));
+}
+
 void elf_core_copy_regs(target_elf_gregset_t *r, const CPUX86State *env)
 {
     r->pt.bx = tswapal(env->regs[R_EBX]);
diff --git ./linux-user/i386/target_elf.h ./linux-user/i386/target_elf.h
index eafac8f382..931ea23ffa 100644
--- ./linux-user/i386/target_elf.h
+++ ./linux-user/i386/target_elf.h
@@ -27,6 +27,24 @@ typedef struct target_elf_gregset_t {
     struct target_user_regs_struct pt;
 } target_elf_gregset_t;
 
+/*
+ * Matches the kernel's elf_fpregset_t, i.e. struct user_i387_struct from
+ * arch/x86/include/asm/user_32.h.  This is the legacy FSAVE image without
+ * the trailing software status word, which FSAVE does not write either.
+ */
+#define HAVE_ELF_CORE_FPREGS    1
+
+typedef struct target_elf_fpregset_t {
+    uint32_t cwd;             /* FPU control word                 */
+    uint32_t swd;             /* FPU status word                  */
+    uint32_t twd;             /* FPU tag word                     */
+    uint32_t fip;             /* FPU IP offset                    */
+    uint32_t fcs;             /* FPU IP selector                  */
+    uint32_t foo;             /* FPU operand pointer offset       */
+    uint32_t fos;             /* FPU operand pointer selector     */
+    uint32_t st_space[20];    /* 8 * 10 bytes for st0-st7         */
+} target_elf_fpregset_t;
+
 /*
  * This is used to ensure we don't load something for the wrong architecture.
  */
-- 
2.54.0


