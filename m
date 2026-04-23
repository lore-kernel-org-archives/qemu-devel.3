Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15762F589DA
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 13:53:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFuSx-0000ra-3A; Thu, 23 Apr 2026 09:51:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFuSs-0000ou-Hp
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 09:51:34 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFuSn-00062D-L5
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 09:51:34 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-488ff90d6c7so54339065e9.2
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 06:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776952288; x=1777557088; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TV5SHzMGyuCZLfuGlO0hhVjuqtuLPymTcSzN76BqbEE=;
 b=yP5ooZwIdoBIWhA9Ib9jOE4izNvpinPCie2GUVNgMx8JlT+3NsgSMO/V3OZr+o17Fv
 KYotqr3EhWml3PB8VhVoouY2eUY/NRk5LsQOukthO7GhlOWqMGIhZP5N2CllAg/NmCWF
 iFk/dEjboXMLlMnVCUgbMZ7xU8KbgjXVXfRTHXTgSOuwLhlxek8FxY+7xmQmcp6YslEj
 xw0yuEjsvKnnpifJreoR/ALrjRwULXxziZwSNI462bvh3Bm2TPGIleXNCeikQJKzU02u
 DErszQveW6CrClTr2h4A+hcvNVI62PcN/lXxVwEMJQSeBamn9TQKvF2gJAzH+ftA93I3
 zN1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776952288; x=1777557088;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TV5SHzMGyuCZLfuGlO0hhVjuqtuLPymTcSzN76BqbEE=;
 b=ZyY6MgJKYlW8FKMT0Bl5N9nAz5M/IzJFNhvezd/2JlA1c1vmF1VpOUQRN9jaPr/Etr
 hSPyZ/PvBcZuz7wCpuoAilFolI2APdE8f7lA5E1wSSd1RDBj/ezKpAQdejUSJx9/x6mX
 60L1MEWjQ+x2u2ObiUSyWWIeq/NcAWIJeXdDI+kfpgm+SIWsTko3NIeFp0NAyDFLv/dc
 i2oE7GT6hNWaHvsZXea7WrpVtW2pAos1mmSd+oMSHyRUnW51r8K7w/tJLrhJVqDmiRmP
 hGBkTwv97UG3vI1gV4bkHP16dZwWz3Fs8oLB0HLc+sfaRCnaO33ZcMuiegSKSKfCuqDz
 qmQA==
X-Gm-Message-State: AOJu0YyUGTDB/dozYm1pFL8qggjDN7jn+tzVatMoZHAfjrGCoOOQlVvY
 z5dO+UaJuM8jsUCT09bRTcvrE27JFiHffacQW9YmdBxnZjlFBrfe1hAKd8duMOKgyvkbjldr6ln
 0RUkIvnc=
X-Gm-Gg: AeBDieunzXGfJxC+Mrl4nPvNKzglYgzMhrnc6gQUNqXG1DUKULxfLo2LRc+TDbKr6EC
 Sqse03eXxoPIur51x/MAZMvHonBtyQJ4RmGuwWA7MbAYWMJ3xR3cLEDUz68fIqcQ+XZ0AT8qyHm
 Sdh25S1/k11vvLmdNvsEEDuGb0VcLDOF03kDTw8TftQ7TRdEzdBnKO5Glvca5YDA9RzhQjGSL71
 662v9tHSHbYv1LyooEoOB9P0VlNrlT5Sd6pOiiQ38WIgVxhjIwl27MDVPBXp5yxJDbxHyeviXMz
 R0aYl5lfowd6C5XAEH9a4tYVZkidVhywl7X0EA/WbTZ/WdCME3XoY1qYTQ0HtuMCaAoTKZhG0Dv
 blDs3liCnlo1o9XfhGbrBbEIqXo08KPVqkH1OKnWJUXsfHRYR0vmkZzUzIN+6N6kbOw7SyQ2mQW
 gVjjXthAZ5wq3CpmunpAULVrMiq3FSE6BeGZoCh/n/HBq1I1+p9cvcExbvCdhajq/jXTvTaH1ue
 JOTlipXjls=
X-Received: by 2002:a05:600c:6296:b0:483:64b4:79da with SMTP id
 5b1f17b1804b1-488fb7923a9mr359383085e9.26.1776952287743; 
 Thu, 23 Apr 2026 06:51:27 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4dc24cfsm52929644f8f.16.2026.04.23.06.51.25
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 23 Apr 2026 06:51:26 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, qemu-s390x@nongnu.org,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 David Hildenbrand <david@kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Halil Pasic <pasic@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>,
 Eric Farman <farman@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 6/9] target/s390x: Compile vec_helper.c as common unit
Date: Thu, 23 Apr 2026 15:50:32 +0200
Message-ID: <20260423135035.50126-7-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260423135035.50126-1-philmd@linaro.org>
References: <20260423135035.50126-1-philmd@linaro.org>
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

In order do build vec_helper.c as a common unit we need to
replace:

  "accel/tcg/cpu-ldst.h" -> "accel/tcg/cpu-ldst-common.h"

and update the cpu_ld/st_be_data_ra() API by cpu_ld/st_mmu() one.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
Unrelated but could VLL / VSTL leverage the Int128 type?
---
 target/s390x/tcg/vec_helper.c | 34 +++++++++++++++++++++++-----------
 target/s390x/tcg/meson.build  |  2 +-
 2 files changed, 24 insertions(+), 12 deletions(-)

diff --git a/target/s390x/tcg/vec_helper.c b/target/s390x/tcg/vec_helper.c
index 304745c971b..98eecd9fde6 100644
--- a/target/s390x/tcg/vec_helper.c
+++ b/target/s390x/tcg/vec_helper.c
@@ -16,7 +16,8 @@
 #include "tcg/tcg.h"
 #include "tcg/tcg-gvec-desc.h"
 #include "exec/helper-proto.h"
-#include "accel/tcg/cpu-ldst.h"
+#include "accel/tcg/cpu-ldst-common.h"
+#include "accel/tcg/cpu-mmu-index.h"
 
 void HELPER(gvec_vbperm)(void *v1, const void *v2, const void *v3,
                          uint32_t desc)
@@ -42,20 +43,26 @@ void HELPER(gvec_vbperm)(void *v1, const void *v2, const void *v3,
 
 void HELPER(vll)(CPUS390XState *env, void *v1, uint64_t addr, uint64_t bytes)
 {
+    const int mmu_idx = cpu_mmu_index(env_cpu(env), false);
+    const uintptr_t ra = GETPC();
+    MemOpIdx oi;
+
     if (likely(bytes >= 16)) {
         uint64_t t0, t1;
 
-        t0 = cpu_ldq_be_data_ra(env, addr, GETPC());
+        oi = make_memop_idx(MO_BE | MO_64 | MO_UNALN, mmu_idx);
+        t0 = cpu_ldq_mmu(env, addr, oi, ra);
         addr = wrap_address(env, addr + 8);
-        t1 = cpu_ldq_be_data_ra(env, addr, GETPC());
+        t1 = cpu_ldq_mmu(env, addr, oi, ra);
         s390_vec_write_element64(v1, 0, t0);
         s390_vec_write_element64(v1, 1, t1);
     } else {
         S390Vector tmp = {};
-        int i;
 
-        for (i = 0; i < bytes; i++) {
-            uint8_t byte = cpu_ldub_data_ra(env, addr, GETPC());
+        oi = make_memop_idx(MO_8, mmu_idx);
+        for (int i = 0; i < bytes; i++) {
+            uint8_t byte = cpu_ldb_mmu(env, addr, oi, ra);
+
 
             s390_vec_write_element8(&tmp, i, byte);
             addr = wrap_address(env, addr + 1);
@@ -191,20 +198,25 @@ void HELPER(gvec_vperm)(void *v1, const void *v2, const void *v3,
 void HELPER(vstl)(CPUS390XState *env, const void *v1, uint64_t addr,
                   uint64_t bytes)
 {
+    const int mmu_idx = cpu_mmu_index(env_cpu(env), false);
+    const uintptr_t ra = GETPC();
+    MemOpIdx oi;
+
     /* Probe write access before actually modifying memory */
     probe_write_access(env, addr, MIN(bytes, 16), GETPC());
 
     if (likely(bytes >= 16)) {
-        cpu_stq_be_data_ra(env, addr, s390_vec_read_element64(v1, 0), GETPC());
+        oi = make_memop_idx(MO_BE | MO_64 | MO_UNALN, mmu_idx);
+        cpu_stq_mmu(env, addr, s390_vec_read_element64(v1, 0), oi, ra);
         addr = wrap_address(env, addr + 8);
-        cpu_stq_be_data_ra(env, addr, s390_vec_read_element64(v1, 1), GETPC());
+        cpu_stq_mmu(env, addr, s390_vec_read_element64(v1, 1), oi, ra);
     } else {
-        int i;
+        oi = make_memop_idx(MO_8, mmu_idx);
 
-        for (i = 0; i < bytes; i++) {
+        for (int i = 0; i < bytes; i++) {
             uint8_t byte = s390_vec_read_element8(v1, i);
 
-            cpu_stb_data_ra(env, addr, byte, GETPC());
+            cpu_stb_mmu(env, addr, byte, oi, ra);
             addr = wrap_address(env, addr + 1);
         }
     }
diff --git a/target/s390x/tcg/meson.build b/target/s390x/tcg/meson.build
index d1c60135411..ed6441f6f44 100644
--- a/target/s390x/tcg/meson.build
+++ b/target/s390x/tcg/meson.build
@@ -3,7 +3,6 @@ s390x_ss.add(when: 'CONFIG_TCG', if_true: files(
   'int_helper.c',
   'mem_helper.c',
   'misc_helper.c',
-  'vec_helper.c',
 ))
 s390x_common_ss.add(when: 'CONFIG_TCG', if_true: files(
   'cc_helper.c',
@@ -11,6 +10,7 @@ s390x_common_ss.add(when: 'CONFIG_TCG', if_true: files(
   'fpu_helper.c',
   'translate.c',
   'vec_fpu_helper.c',
+  'vec_helper.c',
   'vec_int_helper.c',
   'vec_string_helper.c',
 ))
-- 
2.53.0


