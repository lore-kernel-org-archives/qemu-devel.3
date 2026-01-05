Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C803C79FB7
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Jan 2026 18:18:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vcp7a-0001AS-F9; Mon, 05 Jan 2026 13:16:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brookmangabriel@gmail.com>)
 id 1vcp7P-00015a-73
 for qemu-devel@nongnu.org; Mon, 05 Jan 2026 13:15:51 -0500
Received: from mail-qt1-x829.google.com ([2607:f8b0:4864:20::829])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <brookmangabriel@gmail.com>)
 id 1vcp79-00035q-NQ
 for qemu-devel@nongnu.org; Mon, 05 Jan 2026 13:15:39 -0500
Received: by mail-qt1-x829.google.com with SMTP id
 d75a77b69052e-4ee257e56aaso2309611cf.0
 for <qemu-devel@nongnu.org>; Mon, 05 Jan 2026 10:15:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1767636934; x=1768241734; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Ml7un2JYan4JZ2DqFFqoRcBOVZLlzSMUuwc+EQI1f+k=;
 b=BmSIoYKHZ11h9uRRVEEqRFavpEHotqqcEx/RTcCnZCJ5TwDyRnd70u8RHO43ieA6aX
 TatOU0ZmtXVVzLcNgcvX5PgKImwdSZTUdXNW04Un+Ox9ORLP1g6TIEJjKX5AzDHp4m/T
 gISy8ddmR9ijry+84jEc1oIRGKYna2msYWKn+3RX94F/s6uibCy0F2agU6aNgCU6x4QK
 CLf3v1viGAfyfSJKlHmIz2FyeVRN2snE2kmg37vZvrIT8ZeQq73f+AQ0xZWD9zJPmCeD
 fR7J+GWwtXaToDDYXDQ5mjxVZs4eXzMg9Zm/EMeRpuou7jFC3739DYTc2hBtEu0eyllQ
 on4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767636934; x=1768241734;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Ml7un2JYan4JZ2DqFFqoRcBOVZLlzSMUuwc+EQI1f+k=;
 b=cmAapLrkDBXLJkUrFrNLh3oTkCSrKaDT3nLyrdmk/Cc/ap//qc8ICjOXX9hMoxyBvk
 DHMujOlp1TG/fz1HND51O1ZyPwpHad+Dwx2InZ8UhFXpadHomS+zcq7Jf0yCOhOEam1p
 2pvq3rSOhwEWD1beFx91upgqfkvXRow3gzhDb0IoFOeS8nYd9F664qXXmVmgNohvcxfD
 aSNm+MVEXP5I78nCXK282l0CSRLRsAZf+vFvF8ZNBlLGXiRZm6kr2fGq+uvdGNudIp9N
 kJfsU/sS7k++PlsqpsLpGWTsMA8EHH9G+3lWDUNdkRfXFmOoX0EV9HewK15a9lZB2XnV
 XyyQ==
X-Gm-Message-State: AOJu0Yw+PZ+EQr/d6SWVNvl5/BkLnS8k7wd9G9GupNhebSrCqGPBg3Gg
 r9FRl3OOeUJ2edYxiP9PCfk/rDz/9wFktMQqGFTPtQfO/1fx/0RKfkWN
X-Gm-Gg: AY/fxX4BW1yLcpYzAAgKu25Qk2uV0Kl/fdqm9L9Eoc06IBBCuvlOLPTlt61ak9mDaGA
 KsryCGskNaFGxbZZI1CNE1XhR2VV39OVzrXIt8cONtICqMGs6MILeTdpnAOPAiGzHrBTFwKHsl+
 6TNgdT/Ae3g59xBA7S3DNiPukj8qvbFyRAgi7JuR8+yG2/BWkC36idyr1B5W1cAaiJO833Mq3Tg
 Nm/qZh1CrgXe8Xqz2hj0GbWkT/gT5ExyO+IO2MicNB50tctHbS/AsuhxqIg93HOtr29+Y3NKbE+
 ofzHAeLo811QCsX/k6YcwjcWPKUYW9DnVpCn99T2FN4rVWEidtcV1ydd0iaZ4BA8GznLRQXnQQa
 P4aCcYcVqsxP7Aq72maKleatzzaVj5cSoh40j4ym4ziiZnKwsUIqxWzwnWw4nWwx+zBn9o3dOPi
 Tn1le0cqpMGJXDo2aXvWervldH
X-Google-Smtp-Source: AGHT+IHr+x/IjT0QIT2CbklXqqMp8ADrlLfoRgJchHV/9VmUJ6XIgdqXs0tTLRVjaAcV9bbl8Nk/iQ==
X-Received: by 2002:ac8:5fc6:0:b0:4f1:b362:eed7 with SMTP id
 d75a77b69052e-4ffa854b3e4mr606101cf.42.1767636934288; 
 Mon, 05 Jan 2026 10:15:34 -0800 (PST)
Received: from [192.168.1.204] ([185.213.193.254])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8907540e24csm3855706d6.25.2026.01.05.10.15.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Jan 2026 10:15:33 -0800 (PST)
From: Gabriel Brookman <brookmangabriel@gmail.com>
Date: Mon, 05 Jan 2026 11:14:55 -0700
Subject: [PATCH RFC v3 06/12] target/arm: add canonical and no-address tag
 logic
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260105-feat-mte4-v3-6-86a0d99ef2e4@gmail.com>
References: <20260105-feat-mte4-v3-0-86a0d99ef2e4@gmail.com>
In-Reply-To: <20260105-feat-mte4-v3-0-86a0d99ef2e4@gmail.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, 
 Gustavo Romero <gustavo.romero@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org, 
 Laurent Vivier <laurent@vivier.eu>, 
 Gabriel Brookman <brookmangabriel@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1767636923; l=3168;
 i=brookmangabriel@gmail.com; s=20251009; h=from:subject:message-id;
 bh=tIJl4Lc02rje7QgPc8RjqQ13vUOzyLWd41MME0JFBQ0=;
 b=/LQio/HGOHXTZjTFlmqyPvTkg0cmfFCRKQ/AzQEYUXMR7AT5ArmXBp3R6dd0eH89Fk5lbqwkO
 KQeuXP7eVHSDM7pg/QlMOIqdZB6MHItzkK0J/kjaApGjCzVFvakhgvy
X-Developer-Key: i=brookmangabriel@gmail.com; a=ed25519;
 pk=m9TtPDal6WzoHNnQiHHKf8dTrv3DUCPUUTujuo8vNrw=
Received-SPF: pass client-ip=2607:f8b0:4864:20::829;
 envelope-from=brookmangabriel@gmail.com; helo=mail-qt1-x829.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

This feature causes tag checks to compare logical address tags against
their canonical form rather than against allocation tags. Described in
the ARM ARM section "Logical Address Tagging".

Signed-off-by: Gabriel Brookman <brookmangabriel@gmail.com>
---
 target/arm/internals.h      | 29 +++++++++++++++++++++++++++++
 target/arm/tcg/mte_helper.c | 20 ++++++++++++++++++++
 2 files changed, 49 insertions(+)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index 9cd4bf74ef..31d37b80fb 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -1633,6 +1633,35 @@ static inline bool tcma_check(uint32_t desc, int bit55, int ptr_tag)
     return tcma && match;
 }
 
+/* Return whether or not the second nibble of a VA matches bit 55.  */
+static inline bool tag_is_canonical(int ptr_tag, int bit55)
+{
+    return ((ptr_tag + bit55) & 0xf) == 0;
+}
+
+/* Return true if mtx bits mean that the access is canonically checked.  */
+static inline bool mtx_check(CPUARMState *env, bool bit55)
+{
+    int mmu_idx;
+    uint64_t tcr, mtx_bit;
+
+    /* If mte4 is not implemented, then mtx is by definition not enabled */
+    if (!cpu_isar_feature(aa64_mte4, env_archcpu(env))) {
+        return false;
+    }
+
+    mmu_idx = arm_mmu_idx_el(env, arm_current_el(env));
+    tcr = regime_tcr(env, mmu_idx);
+
+    /*
+     * In two-range regimes, mtx is governed by bit 60 or 61 of TCR, and in
+     * one-range regimes, bit 33 is used.
+     */
+    mtx_bit = regime_has_2_ranges(mmu_idx) ? 60 + bit55 : 33;
+
+    return extract64(tcr, mtx_bit, 1);
+}
+
 /*
  * For TBI, ideally, we would do nothing.  Proper behaviour on fault is
  * for the tag to be present in the FAR_ELx register.  But for user-only
diff --git a/target/arm/tcg/mte_helper.c b/target/arm/tcg/mte_helper.c
index f0880991b6..6827d030dd 100644
--- a/target/arm/tcg/mte_helper.c
+++ b/target/arm/tcg/mte_helper.c
@@ -825,6 +825,14 @@ static int mte_probe_int(CPUARMState *env, uint32_t desc, uint64_t ptr,
         return 1;
     }
 
+    /*
+     * If mtx is enabled, then the access is MemTag_CanonicallyTagged,
+     * otherwise it is MemTag_AllocationTagged. See AArch64.CheckTag.
+     */
+    if (mtx_check(env, bit55)) {
+        return tag_is_canonical(ptr_tag, bit55);
+    }
+
     mmu_idx = FIELD_EX32(desc, MTEDESC, MIDX);
     type = FIELD_EX32(desc, MTEDESC, WRITE) ? MMU_DATA_STORE : MMU_DATA_LOAD;
     sizem1 = FIELD_EX32(desc, MTEDESC, SIZEM1);
@@ -961,6 +969,18 @@ uint64_t HELPER(mte_check_zva)(CPUARMState *env, uint32_t desc, uint64_t ptr)
         goto done;
     }
 
+    /*
+     * If mtx is enabled, then the access is MemTag_CanonicallyTagged,
+     * otherwise it is MemTag_AllocationTagged. See AArch64.CheckTag.
+     */
+    if (mtx_check(env, bit55)) {
+        if (tag_is_canonical(ptr_tag, bit55)) {
+            goto done;
+        }
+        mte_check_fail(env, desc, ptr, ra);
+    }
+
+
     /*
      * In arm_cpu_realizefn, we asserted that dcz > LOG2_TAG_GRANULE+1,
      * i.e. 32 bytes, which is an unreasonably small dcz anyway, to make

-- 
2.52.0


