Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65C29F589DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 14:15:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFuqP-0004Mi-QZ; Thu, 23 Apr 2026 10:15:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFuqI-0004Hp-A3
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 10:15:47 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFuqF-0007Dv-4x
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 10:15:45 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4891c0620bcso40576775e9.1
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 07:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776953741; x=1777558541; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=EMiZKnW464iYuxKCcLEJZ5twh56qmwlhp/zbGzm9asI=;
 b=GeMos1IeCfe5fFeod6VsRgZN+WsOSGITs3GnHbvQMEE7mHc4N7eFhXZP+KnD6R7Zfe
 HLOrP6B3KcZjm/W7V7wBOvLFZg9wCvto1y1zjNpL5qwgrNnD7PtpRiBRr1hxBk7sM2zS
 /0cCAJGavWFFgdLCJBcQ8VsIrS/C2hV0ycJ5N4sFjtWhP2gpKIAx2LvxoqjmluZ28pbC
 ttNTFPDJ+2Qlc4R0XKK7cmS+rXIu0jOgOgbx2OJ7hAv3zzbcyj/T3vBDcFmG6PTL3C3Z
 gn02XHS8Nzlf+1TO+6vU8ai/8KPBhYfynHMYz2bmJbBGdpJIuTJ9st4+JjCh6WUyB45y
 9gHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776953741; x=1777558541;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EMiZKnW464iYuxKCcLEJZ5twh56qmwlhp/zbGzm9asI=;
 b=rssjaAQea93242J+lcRhDPD9A611uxSBL7H3IWeGqcKpHFNXvNFnVpoF+S4JtgAf3W
 HcUgCQ1IxSs4ke6+Xqp1prRnweDK/K/BulaUrDwcwjUtoTSj7mR+bYAOolHSEAoIn6av
 Bv0qu2sme9br8xhpxmDj6XIGBDJqEc+QYVar+IhhXVtcF5iMPreFyinBSoZhJBt+oyS8
 2tZAMz2+w1ZSxER1gJ6CmX1uMxyYT1ZbXFmcs5Z3h/+WBaYVL2EGmEikWHI8NeU1oJ3U
 9ssmaH7OOMfwTL2aCuUn/+t+sTTDmynT5f1hKsunSob7iHWsD8OBrnUa5GT6Yq1mFj59
 hjxA==
X-Gm-Message-State: AOJu0Ywsj5ZbDxmVK7s7A47go7d/IhkTLvzbIToU6F7aP+Mo7bcHTL2e
 JOABp8RpzPuhf1+xVkzxDx7ZIu+tMMQbU8lCjpNzKDWuxEdS61b2FU2SVJKnZZJFUYSOV+/VHnU
 Ugahrwe4=
X-Gm-Gg: AeBDietikK2PDhX0RR8k6/dKfGo4F31CxMtxTGmLZCD6WVNRv19o5P+rpjAmzqVHjP7
 p+ciYfHK63f8a/O8HQr2kW4g9N+ukcmflZypHqBXBRi0SdoZn3f9foadO2kCPF8Lf9ug6YsYC5s
 noC2TVxzXxe/hz+Mo3cF0nL2b3NlVyD04eCHnRhDvj2zoSIFd/yY1IyHbVdw0zEWg5+aEMzVJ5W
 OaMK1MxeblBrldAVAGJNjC0294vA1d2WS0AQUfTBSx55INyAYwJdBsXJjmGRlnMq0v7VChxifWk
 F9Z9IVqu3TyTPNcI/aNVjBBLAXkcqLCpX5QP6i3xKhKbsUdXEhuoJfBqHGM24/QqhzcGl/tKomS
 aChyZ4rcW96m1tzPtaD6x9lu/a23s9HTHeqUYYtWAyb98QDY6y1TSca3jdjTgsqTIlw/riZU/DQ
 McPWZ+YIxbs/PJIwiFPF2fugwpJ0vXBHY4GwYf+aeoLo8t8+DAQcC6dpAH79ONQRWXyuZkP3fbf
 WncHFZFHVL7jc/cWeQPZg==
X-Received: by 2002:a05:600c:2e56:b0:488:d243:8da9 with SMTP id
 5b1f17b1804b1-488fb73b2d3mr237607835e9.1.1776953741150; 
 Thu, 23 Apr 2026 07:15:41 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-489207ebd3asm140785175e9.6.2026.04.23.07.15.39
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 23 Apr 2026 07:15:40 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Matthew Rosato <mjrosato@linux.ibm.com>,
 David Hildenbrand <david@kernel.org>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-s390x@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2] target/s390x: Leverage 128-bit vector type in VLL / VSTL
 opcodes
Date: Thu, 23 Apr 2026 16:15:38 +0200
Message-ID: <20260423141538.51583-1-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

The access is unaligned, we can easily replace the 2
consecutive 64-bit calls by a single 128-bit one.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
Based-on: <20260423135035.50126-1-philmd@linaro.org>
---
 target/s390x/tcg/vec.h        | 12 ++++++++++++
 target/s390x/tcg/vec_helper.c | 19 ++++++++-----------
 2 files changed, 20 insertions(+), 11 deletions(-)

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
index 98eecd9fde6..feb99f51c78 100644
--- a/target/s390x/tcg/vec_helper.c
+++ b/target/s390x/tcg/vec_helper.c
@@ -48,14 +48,12 @@ void HELPER(vll)(CPUS390XState *env, void *v1, uint64_t addr, uint64_t bytes)
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


