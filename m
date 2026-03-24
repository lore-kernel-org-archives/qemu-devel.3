Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9263AF54ACD
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2026 15:12:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w53Pi-0000g7-3I; Tue, 24 Mar 2026 11:11:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w53Pb-0000cV-Te
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 11:11:20 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w53Pa-0005Br-7Z
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 11:11:19 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-439d8dc4ae4so4843272f8f.2
 for <qemu-devel@nongnu.org>; Tue, 24 Mar 2026 08:11:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774365077; x=1774969877; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=IKbUTaFOqvDJxELefvnhulrQMMYMDi7DhugEoR6vIwo=;
 b=kp9fsaUzPTH2ItGY5PUOzW5T0uYrfRSLBTJdlhhOoL81d6IRQ8QztT84qvsY0rsymo
 jD00NIzxfNEkX/ZkTbEa5bF8GYWn338HkSD4KGrjyzSEzb1jLZFHWZdm7hy9n8W2o8Nx
 9BWrKxHUbRPZ/r3/J1j1dS5GmFYYYHebJzssPv5vwvTQ642Mz8LRw5lEyju12Vb0DHCl
 0VHl5jdg3rIitDZR7yyNZMtNqkO6rL4yTQezj4/wxiGDCDuEKgPgvo5tgSZt9gqjq936
 9E3cnchLthkFARLbLMdy0lwj8GSFJ5nUawLtL/T+3AQdXA8Gm0hcU3xrvTR2VGSgPmy6
 E1ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774365077; x=1774969877;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=IKbUTaFOqvDJxELefvnhulrQMMYMDi7DhugEoR6vIwo=;
 b=GDaaC2Qj6wQOSlgPzVINL2R+lFxYN0ATql85acwBhxvbpBzsmuFSegjY5TXIwhXV50
 jN9HPgirt+yQz1f3I8NrBrk/zfq+JoKD4jogQfXESOmkla21TKrPQJJirOZVOrBrcaDl
 yaEXuxYmeoBFmp2NI0OCRSm9GKiZ2D8CRdIvgjDdlqkvg5JHDe3m76zAtLtUU5xeayGw
 kZPNBdLW7Dn8v8K5Nuylq6xfTJPo1v9wHUJq2wfU8K5ephqTBAxmEgjChN+ES/T2BdJA
 2ACEPwnrDDnhRQ53vtcmuNozcroGusXNzGucQdf4q+0b1jOLZtuGDxV6LRFNUj40eCTY
 LGdA==
X-Gm-Message-State: AOJu0YwCP5qGMEA1TP52rR05J5W9HX9nVe6jRBJL7R7UDEx9E8PHi5cC
 NKtenvHC3AwZeke8sQdlLSnOsdfZrxt3E0iXm78AL4McSP9IJbovOqOHyCitPS7m3E3kF7xjOgL
 UD8AP46g=
X-Gm-Gg: ATEYQzxGSiK7rrTWlSKH5+7AtKnpwMZ523/Lmu6r+nYuFdnwmcU7tGhS/HoiqYCWzmg
 yqsjQ6Dnd5ss1rd4M5lo1CDmFkAzxDdmWYts9CuFwsxQxIRXFoxS9CxIx2kL3JAof1fXDQWxmYT
 cXG7/xl0d3kMclFfBBcu39jfFifOkhWHnNDzLX/GyojIHa5NvX4szxiYDAznA8jpmCqBgBIfX9i
 L0uj/tGY9K5oRwbd7VJJ9cV1QjJY6ELkPTNF7zfaVZ/L055aatgBdxrSR9hRCcZavLSG9T2Qls+
 1D3+XBX3c7IxXQgEhpTOnl9aZrsy+bEY9uaDkwUlX7wOsamJEwVnoIIET0GYRJI+fCRT9lXe/XP
 +6sWVnk6zmyQh2EmUmu/EAZshUGlKaaCZBb80TbtjlhSLjh8pjiby4d5ZxLA6/byg32/YEY3j/A
 MkDfcxvvaUPeAokHegGoY5OSxjsAorqX+02ivpdwDWg/vm6mXAR6C+O/LK5bOIfOvJzn6yxBuf9
 RF6DF9PPJbRsjybwZj20imi/tNHprM=
X-Received: by 2002:a05:6000:310d:b0:43b:3b80:6776 with SMTP id
 ffacd0b85a97d-43b64262ebbmr26034105f8f.30.1774365076416; 
 Tue, 24 Mar 2026 08:11:16 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b64717e97sm40781916f8f.35.2026.03.24.08.11.14
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Mar 2026 08:11:14 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 02/11] linux-user/i386/signal.c: Correct definition of
 target_fpstate_32
Date: Tue, 24 Mar 2026 15:11:02 +0000
Message-ID: <20260324151111.237411-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260324151111.237411-1-peter.maydell@linaro.org>
References: <20260324151111.237411-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x432.google.com
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

Our definition of the target_fpstate_32 struct doesn't match the
kernel's version.  We only use this struct definition in the
definition of 'struct sigframe', where it is used in a field that is
present only for legacy reasons to retain the offset of the following
'extramask' field.  So really all that matters is its length, and we
do get that right; but our previous definition using
X86LegacySaveArea implicitly added an extra alignment constraint
(because X86LegacySaveArea is tagged as 16-aligned) which the real
target_fpstate_32 does not have.  Because we allocate and use a
'struct sigframe' on the guest's stack with the guest's alignment
requirements, this resulted in the undefined-behaviour sanitizer
complaining during 'make check-tcg' for i386-linux-user:

../../linux-user/i386/signal.c:471:35: runtime error: member access within misaligned address 0x1000c07f75ec for type 'struct sigframe', which requires 16 byte alignment
0x1000c07f75ec: note: pointer points here
  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
              ^

../../linux-user/i386/signal.c:808:5: runtime error: member access within misaligned address 0x1000c07f75f4 for type 'struct target_sigcontext_32', which requires 8 byte alignment
0x1000c07f75f4: note: pointer points here
  0a 00 00 00 33 00 00 00  00 00 00 00 2b 00 00 00  2b 00 00 00 40 05 80 40  f4 7f 10 08 58 05 80 40
              ^

and various similar errors.

Replace the use of X86LegacyXSaveArea with a set of fields that match
the kernel _fpstate_32 struct, and assert that the length is correct.
We could equally have used
   uint8_t legacy_area[512];
but following the kernel is probably less confusing overall.

Since in target/i386/cpu.h we assert that X86LegacySaveArea is 512
bytes, and in linux-user/i386/signal.c we assert that
target_fregs_state is (32 + 80) bytes, the new assertion confirms
that we didn't change the size of target_fpstate_32 here, only its
alignment requirements.

Cc: qemu-stable@nongnu.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260305161739.1775232-1-peter.maydell@linaro.org
---
 linux-user/i386/signal.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/linux-user/i386/signal.c b/linux-user/i386/signal.c
index 0f11dba831..b646fde431 100644
--- a/linux-user/i386/signal.c
+++ b/linux-user/i386/signal.c
@@ -60,10 +60,33 @@ struct target_fpx_sw_bytes {
 };
 QEMU_BUILD_BUG_ON(sizeof(struct target_fpx_sw_bytes) != 12*4);
 
+struct fpxreg {
+    uint16_t significand[4];
+    uint16_t exponent;
+    uint16_t padding[3];
+};
+
+struct xmmreg {
+    uint32_t element[4];
+};
+
+/*
+ * This corresponds to the kernel's _fpstate_32. Since we
+ * only use it for the fpstate_unused padding section in
+ * the target sigcontext, it doesn't actually matter what fields
+ * we define here as long as we get the size right.
+ */
 struct target_fpstate_32 {
     struct target_fregs_state fpstate;
-    X86LegacyXSaveArea fxstate;
+    uint32_t fxsr_env[6];
+    uint32_t mxcsr;
+    uint32_t reserved;
+    struct fpxreg fxsr_st[8];
+    struct xmmreg xmm[8];
+    uint32_t padding1[44];
+    uint32_t padding2[12]; /* aka sw_reserved */
 };
+QEMU_BUILD_BUG_ON(sizeof(struct target_fpstate_32) != 32 + 80 + 512);
 
 struct target_sigcontext_32 {
     uint16_t gs, __gsh;
-- 
2.43.0


