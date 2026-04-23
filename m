Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C294F589D9
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 14:13:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFunU-0001XY-Fk; Thu, 23 Apr 2026 10:12:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFunT-0001VN-1H
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 10:12:51 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFunR-0004PT-AH
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 10:12:50 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-43d70c30767so4505989f8f.0
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 07:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776953567; x=1777558367; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=OeFbCXCewHEghQGiJERNNCufpU6I3WkPGfyvHxn8d58=;
 b=KS7tz3UTuxPhQOw4w+wT6xBFZhVYOFN/4XoQHdkrQmET2GeDFZ4O5TvmVXjwiVhs4s
 2atThJ3I+7GnK7ZDpJC5rjeK4NOUs0xJtfKGVKDwU8AytctM0QC/qT3LxAQ8WiQiMivC
 hhvtjCey6L84MVpsSzkyUJ0ezG5mSDfzAgZyLZbb1ScO7DQwGVsBCG97HR1XwdwoFpDF
 heiFZLAVQmw1Kkaw2Ve0fux8vugZI+4Ptti3t8BEnGcebE5sKklSZxbvEq+/FE4bp+HG
 7ilGlxhFcBYgPWTUOE9T44om9GJebJ66mOh9hh9ezxNxCPzgF3O/bi3NqywL+igfn0dV
 qGHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776953567; x=1777558367;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OeFbCXCewHEghQGiJERNNCufpU6I3WkPGfyvHxn8d58=;
 b=rkUlz6Qdl+nHj30QFznj6vRakFzn78LinLkbpOMAsgtdS7kSXjmvPW9CS2h3BoRlQC
 1Q5Tl1Ey2C6fpQfdtNwu9H0Dma6J48Qkh1wYdonoqEbMBQDWwU6YRl+GdkVXw5dsdxS5
 zoyVH84wLwpfy4pYBukegVFO3C0G2YYq9zp1yAWXsH19hHrXS1iTcIJ89xm23qiKX+hR
 VoBz5NwhTlDzXjl4gdqOxcMFwNWsJHWhPiaD3Q60CCXFKz9HyPfWR8ToSa4kXIBWerFX
 a+VtJawf98LSfzHpJg7pU1Bi/IF1YiITJUfNqUf/uMxSDIboRBn8hSnpHuBbHv38b4r5
 MHzg==
X-Gm-Message-State: AOJu0YypWGMMj4Auw3xC3NxWhZexcRYVmYdSrbD6Tlxg5UjdFHCt2+U2
 Cq1t2P+5hdJOuCdlBjRWPQzoc0Ioc8uFYhFQwT+hH6PpxPINqlwqkrY/IPOD804yIkrLX9UK3bN
 2qv1kY9M=
X-Gm-Gg: AeBDietMAuex1xN11qwZ/24vHbdEOaOmsEfSELYPO1QL01Oh6SB7r8jm5gtj3UNzdlP
 sCHNjDQ8ZeLriVxoxM/SJpvldxIWtRbGQEbWJ0ZaXbi2whE1sgDGuJBlz/Vi4UiJYzYNujYAEg2
 Ikpr1aaYCh7OhTSOee6ZLxXFsO45R1B4XKZZaqPw1KnN8Qospk7Ml/zSjQ9V3f2FECMEUA1/zo9
 m7AsVEHwS/5w20bdS5H8vhHj3tdyRco1rpbQe5LJWtX7aTpHEq/AK82WblvBbke4ArahVCeihMy
 jo5SBhR1ycjWHs+riOUPwleFsMw023y3P7mENQJPYFboUPBzV/S62T+B8gG7SxSAcFa9v/+F5d7
 MD4aSaFPRAHkfF89FkxzK+ouFd5LvxudQ5fQ7mYDIiByWa0ppALxmQ7N0+gP0jZ2MBOyYVSZ3lV
 saVIdl2JQOPsjDhr7r0zSFuTxNQBCb+5orY+A7/2i0K0H3MjiFHwlbc/krA/s3cA9CHd7eCaKgy
 g3AZ8irM/Q=
X-Received: by 2002:a05:6000:2b11:b0:43d:33cc:f1b7 with SMTP id
 ffacd0b85a97d-43fe4044691mr26828663f8f.11.1776953567097; 
 Thu, 23 Apr 2026 07:12:47 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4e46898sm56691016f8f.27.2026.04.23.07.12.45
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 23 Apr 2026 07:12:46 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Eric Farman <farman@linux.ibm.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>,
 David Hildenbrand <david@kernel.org>, qemu-s390x@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH] target/s390x: Leverage 128-bit vector type in VLL / VSTL
 opcodes
Date: Thu, 23 Apr 2026 16:12:45 +0200
Message-ID: <20260423141245.51344-1-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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

The access is unaligned, we can easily replace the 2
consecutive 64-bit calls by a single 128-bit one.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
Based-on: <20260423135035.50126-1-philmd@linaro.org>
---
 target/s390x/tcg/vec.h        | 12 ++++++++++++
 target/s390x/tcg/vec_helper.c | 23 ++++++++++-------------
 2 files changed, 22 insertions(+), 13 deletions(-)

diff --git a/target/s390x/tcg/vec.h b/target/s390x/tcg/vec.h
index 8d095efcfc6..34413f7e029 100644
--- a/target/s390x/tcg/vec.h
+++ b/target/s390x/tcg/vec.h
@@ -13,8 +13,10 @@
 #define S390X_VEC_H
 
 #include "tcg/tcg.h"
+#include "qemu/int128.h"
 
 typedef union S390Vector {
+    Int128 quadword;
     uint64_t doubleword[2];
     uint32_t word[4];
     uint16_t halfword[8];
@@ -72,6 +74,11 @@ static inline uint64_t s390_vec_read_element64(const S390Vector *v, uint8_t enr)
     return v->doubleword[enr];
 }
 
+static inline Int128 s390_vec_read_element128(const S390Vector *v)
+{
+    return v->quadword;
+}
+
 static inline uint64_t s390_vec_read_element(const S390Vector *v, uint8_t enr,
                                              uint8_t es)
 {
@@ -117,6 +124,11 @@ static inline void s390_vec_write_element64(S390Vector *v, uint8_t enr,
     v->doubleword[enr] = data;
 }
 
+static inline void s390_vec_write_element128(S390Vector *v, Int128 data)
+{
+    v->quadword = data;
+}
+
 static inline void s390_vec_write_element(S390Vector *v, uint8_t enr,
                                           uint8_t es, uint64_t data)
 {
diff --git a/target/s390x/tcg/vec_helper.c b/target/s390x/tcg/vec_helper.c
index 98eecd9fde6..4d5529e1781 100644
--- a/target/s390x/tcg/vec_helper.c
+++ b/target/s390x/tcg/vec_helper.c
@@ -43,19 +43,17 @@ void HELPER(gvec_vbperm)(void *v1, const void *v2, const void *v3,
 
 void HELPER(vll)(CPUS390XState *env, void *v1, uint64_t addr, uint64_t bytes)
 {
-    const int mmu_idx = cpu_mmu_index(env_cpu(env), false);
+    int mmu_idx = cpu_mmu_index(env_cpu(env), false);
     const uintptr_t ra = GETPC();
     MemOpIdx oi;
 
     if (likely(bytes >= 16)) {
-        uint64_t t0, t1;
+        Int128 t;
 
-        oi = make_memop_idx(MO_BE | MO_64 | MO_UNALN, mmu_idx);
-        t0 = cpu_ldq_mmu(env, addr, oi, ra);
-        addr = wrap_address(env, addr + 8);
-        t1 = cpu_ldq_mmu(env, addr, oi, ra);
-        s390_vec_write_element64(v1, 0, t0);
-        s390_vec_write_element64(v1, 1, t1);
+        oi = make_memop_idx(MO_BE | MO_128 | MO_UNALN, mmu_idx);
+        addr = wrap_address(env, addr + 16);
+        t = cpu_ld16_mmu(env, addr, oi, ra);
+        s390_vec_write_element128(v1, t);
     } else {
         S390Vector tmp = {};
 
@@ -198,7 +196,7 @@ void HELPER(gvec_vperm)(void *v1, const void *v2, const void *v3,
 void HELPER(vstl)(CPUS390XState *env, const void *v1, uint64_t addr,
                   uint64_t bytes)
 {
-    const int mmu_idx = cpu_mmu_index(env_cpu(env), false);
+    int mmu_idx = cpu_mmu_index(env_cpu(env), false);
     const uintptr_t ra = GETPC();
     MemOpIdx oi;
 
@@ -206,10 +204,9 @@ void HELPER(vstl)(CPUS390XState *env, const void *v1, uint64_t addr,
     probe_write_access(env, addr, MIN(bytes, 16), GETPC());
 
     if (likely(bytes >= 16)) {
-        oi = make_memop_idx(MO_BE | MO_64 | MO_UNALN, mmu_idx);
-        cpu_stq_mmu(env, addr, s390_vec_read_element64(v1, 0), oi, ra);
-        addr = wrap_address(env, addr + 8);
-        cpu_stq_mmu(env, addr, s390_vec_read_element64(v1, 1), oi, ra);
+        oi = make_memop_idx(MO_BE | MO_128 | MO_UNALN, mmu_idx);
+        addr = wrap_address(env, addr + 16);
+        cpu_st16_mmu(env, addr, s390_vec_read_element128(v1), oi, ra);
     } else {
         oi = make_memop_idx(MO_8, mmu_idx);
 
-- 
2.53.0


