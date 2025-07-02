Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D1F5C8303C
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 11:21:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWvVf-0007VM-Pz; Wed, 02 Jul 2025 07:20:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kosasihwilliam4@gmail.com>)
 id 1uWvVY-0007Sc-Fy; Wed, 02 Jul 2025 07:20:08 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kosasihwilliam4@gmail.com>)
 id 1uWvVV-0002GT-UI; Wed, 02 Jul 2025 07:20:07 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-234bfe37cccso80705455ad.0; 
 Wed, 02 Jul 2025 04:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751455203; x=1752060003; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FkWfQ1CcufARevD0crlAL/PMguTtM1aqN7M4uHH1bEM=;
 b=i6ovtHgi8XMwK/KOn1rXf/FwA5PLab52XNu4EH18YpDBDgfkQ7gI1YxxGoAquvwoPl
 C65pnfJKtcSYi6nTTYkP9niXymax2RoWr1y3KXeI55sB35FqUfvJMHEtkh5JNVY2oH4J
 O0HDs1NJDMh1/hrY1+HZ0E+b0PrnATGlG/K45tVFAJwwFu0jzeYo2+YEVHRO46jOCrid
 vjOIO9MljJQFO1a57NnTVNZQvvqKkQeldbrX8IpjbQzrDJ1BH3uEc3/A1m7OMI46Ze+m
 w8/zXh2ljj9oy8J3Dwz1uCOzWXTWngjmwXDWheNOhP2knNKe6VAV4hN05GTE477NMaOB
 YbrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751455203; x=1752060003;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FkWfQ1CcufARevD0crlAL/PMguTtM1aqN7M4uHH1bEM=;
 b=hPY06mCs+cPsEOAcQ+BclxZsWN6hog53sVDk9QbCHNWD3pQfyT7STXD0tkJzkJiSd+
 9Cu5SRZts081szrc/dZf/+kUj2qc2e4enTX8JM35lnS9RQRZu5/nWpkbVH5KkgplyYRg
 hAUB3SVwOs75ZTkvWybYRMDGtQAkh2fdjw/AmC+fnUJRCamGNlGBiKfqalGhxhbvfSMH
 Vz5W96xCDmpM12M4lq+Fe9bWDw34YFW4Z+Mi4/nYmBvYeAujePdnyJeeaKJbMYrRUmi+
 rwevzGnBGgAx10OTfN+DtmmY6Ak8rmqzS9FBN9vXE6x+rtbypruuM7cMpyZ6hOVv0Bb3
 v6GA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXKW1Tgplf/e7uW3cdmaTr5tomCLOMh7Cb53rnxQ85CJfbuGzGB9h7volG8BdMRjiGMSH5xL814jA==@nongnu.org
X-Gm-Message-State: AOJu0YyvlTQEONbkresJmcxWuTQ64dlKLamTRvl2AoZtQ4aSbgQlfbXx
 aA6PNxwii2r9sIv39SuUn2fPdZFDDCrwYNjohGbKGaLy+qPUI2ri8O+mhGoBizZ5a9g=
X-Gm-Gg: ASbGncvzrooNVsLGt4218nte/sP/FJQr3EszQUEVFRNK5JIPQZQWZfoszTACNmcu0WP
 dGyfhNdDAW4uCrvfWOoMWxaBFQL8o2YitmrwVyeJQEXV+h/9qJIWSZlms7buRnOVx0bRtYurQfS
 JmRk5HHXvTKQ2C3zYP/C4MMezjKbDG8l0C1zjROFPhS3i3XN1iCAw+6q1jTAdUT//8Cm6WTqMHq
 uPa4R8ZGq45YcCLSQi71hDUFpu4SM1nhdsBrksH7rk/p2gLdnXHjFAbqwjzbt9hn3u9kNYaRJE9
 jQrfAKP9ARz0JA57CR+sUMVV81q+z+gb4QKvF3CmQVbgSO1OO29gT6ACFR31aaKZsalc5zuDyTs
 U8ID0pbFZgPffmOwTlCiY3BwUeoTbaCMTprS4DfbVe0Q=
X-Google-Smtp-Source: AGHT+IGSnZqRB2lHLFyUQ+fs/OEy1aripPg8ByNO/rXp1zgPGkl9E3HwDBSt1G/cvC/47nvqSJJaeA==
X-Received: by 2002:a17:902:db05:b0:235:2403:779f with SMTP id
 d9443c01a7336-23c6e5f4c50mr33718285ad.29.1751455203481; 
 Wed, 02 Jul 2025 04:20:03 -0700 (PDT)
Received: from localhost (pa49-178-74-199.pa.nsw.optusnet.com.au.
 [49.178.74.199]) by smtp.gmail.com with UTF8SMTPSA id
 41be03b00d2f7-b362cef26dfsm3355840a12.46.2025.07.02.04.20.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Jul 2025 04:20:03 -0700 (PDT)
From: William Kosasih <kosasihwilliam4@gmail.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 William Kosasih <kosasihwilliam4@gmail.com>
Subject: [PATCH v3 01/12] target/arm: Bring VLSTM/VLLDM helper store/load
 closer to the ARM pseudocode
Date: Wed,  2 Jul 2025 20:49:43 +0930
Message-ID: <20250702111954.128563-2-kosasihwilliam4@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250702111954.128563-1-kosasihwilliam4@gmail.com>
References: <20250702111954.128563-1-kosasihwilliam4@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=kosasihwilliam4@gmail.com; helo=mail-pl1-x62c.google.com
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

This patch brings the VLSTM and VLLDM helper functions closer to the ARM
pseudocode by adding MO_ALIGN to the MemOpIdx of the associated store
(`cpu_stl_mmu`) operations and load (`cpu_ldl_mmu`) operations.

Note that this is not a bug fix: an 8-byte alignment check already exists
and remains in place, enforcing stricter alignment than the 4 bytes
requirement in the individual loads and stores. This change merely makes the
helper implementations closer to the ARM pseudocode.

That said, as a side effect, the MMU index is now resolved once instead of
on every `cpu_*_data_ra` call, reducing redundant lookups

Signed-off-by: William Kosasih <kosasihwilliam4@gmail.com>
---
 target/arm/tcg/m_helper.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/target/arm/tcg/m_helper.c b/target/arm/tcg/m_helper.c
index 6614719832..251e12edf9 100644
--- a/target/arm/tcg/m_helper.c
+++ b/target/arm/tcg/m_helper.c
@@ -1048,6 +1048,9 @@ void HELPER(v7m_vlstm)(CPUARMState *env, uint32_t fptr)
     bool s = env->v7m.fpccr[M_REG_S] & R_V7M_FPCCR_S_MASK;
     bool lspact = env->v7m.fpccr[s] & R_V7M_FPCCR_LSPACT_MASK;
     uintptr_t ra = GETPC();
+    ARMMMUIdx mmu_idx = arm_mmu_idx(env);
+    MemOpIdx oi = make_memop_idx(MO_TEUL | MO_ALIGN,
+                                 arm_to_core_mmu_idx(mmu_idx));
 
     assert(env->v7m.secure);
 
@@ -1073,7 +1076,7 @@ void HELPER(v7m_vlstm)(CPUARMState *env, uint32_t fptr)
      * Note that we do not use v7m_stack_write() here, because the
      * accesses should not set the FSR bits for stacking errors if they
      * fail. (In pseudocode terms, they are AccType_NORMAL, not AccType_STACK
-     * or AccType_LAZYFP). Faults in cpu_stl_data_ra() will throw exceptions
+     * or AccType_LAZYFP). Faults in cpu_stl_mmu() will throw exceptions
      * and longjmp out.
      */
     if (!(env->v7m.fpccr[M_REG_S] & R_V7M_FPCCR_LSPEN_MASK)) {
@@ -1089,12 +1092,12 @@ void HELPER(v7m_vlstm)(CPUARMState *env, uint32_t fptr)
             if (i >= 16) {
                 faddr += 8; /* skip the slot for the FPSCR */
             }
-            cpu_stl_data_ra(env, faddr, slo, ra);
-            cpu_stl_data_ra(env, faddr + 4, shi, ra);
+            cpu_stl_mmu(env, faddr, slo, oi, ra);
+            cpu_stl_mmu(env, faddr + 4, shi, oi, ra);
         }
-        cpu_stl_data_ra(env, fptr + 0x40, vfp_get_fpscr(env), ra);
+        cpu_stl_mmu(env, fptr + 0x40, vfp_get_fpscr(env), oi, ra);
         if (cpu_isar_feature(aa32_mve, cpu)) {
-            cpu_stl_data_ra(env, fptr + 0x44, env->v7m.vpr, ra);
+            cpu_stl_mmu(env, fptr + 0x44, env->v7m.vpr, oi, ra);
         }
 
         /*
@@ -1121,6 +1124,9 @@ void HELPER(v7m_vlldm)(CPUARMState *env, uint32_t fptr)
 {
     ARMCPU *cpu = env_archcpu(env);
     uintptr_t ra = GETPC();
+    ARMMMUIdx mmu_idx = arm_mmu_idx(env);
+    MemOpIdx oi = make_memop_idx(MO_TEUL | MO_ALIGN,
+                                 arm_to_core_mmu_idx(mmu_idx));
 
     /* fptr is the value of Rn, the frame pointer we load the FP regs from */
     assert(env->v7m.secure);
@@ -1155,16 +1161,16 @@ void HELPER(v7m_vlldm)(CPUARMState *env, uint32_t fptr)
                 faddr += 8; /* skip the slot for the FPSCR and VPR */
             }
 
-            slo = cpu_ldl_data_ra(env, faddr, ra);
-            shi = cpu_ldl_data_ra(env, faddr + 4, ra);
+            slo = cpu_ldl_mmu(env, faddr, oi, ra);
+            shi = cpu_ldl_mmu(env, faddr + 4, oi, ra);
 
             dn = (uint64_t) shi << 32 | slo;
             *aa32_vfp_dreg(env, i / 2) = dn;
         }
-        fpscr = cpu_ldl_data_ra(env, fptr + 0x40, ra);
+        fpscr = cpu_ldl_mmu(env, fptr + 0x40, oi, ra);
         vfp_set_fpscr(env, fpscr);
         if (cpu_isar_feature(aa32_mve, cpu)) {
-            env->v7m.vpr = cpu_ldl_data_ra(env, fptr + 0x44, ra);
+            env->v7m.vpr = cpu_ldl_mmu(env, fptr + 0x44, oi, ra);
         }
     }
 
-- 
2.48.1


