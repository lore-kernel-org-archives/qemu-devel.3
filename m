Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C612FCD98DA
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 10:10:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZQiI-0004ke-HF; Tue, 16 Jun 2026 06:08:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wZQiH-0004k2-QB
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 06:08:09 -0400
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wZQiG-0003aY-A0
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 06:08:09 -0400
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-c858dc05ee3so2615922a12.2
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 03:08:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781604487; x=1782209287; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=84pgkHPEqKnO+5XQVV3HYQGTgjK8P0Ygb3uX514z88U=;
 b=RLo2ki+w1m9beydWsaI3C6qqf7W2lvRjxWZLY8sv5vibWkM87aB3pxv+0MHf1sLVvc
 jFmvt3H6bAwZdlsKoPjtw2WfXXkQirC+Jmb+EEmv4qyXLM5wChke1qf5WXXyPRTepBVD
 5emx65ceEI6yMsqyxfUKhjZuVxGhLFa+kNYWUT5YWfUfR6cX1VrC25tapp3eZaDlocyx
 dATb7hD+WtU1y8Nm9pYl2DIrOKRrhs73pfh2zPPkUNJWWHVSaVfC6f13AqesBRalqfU9
 JIRoie2r9LBYmIHWu9zojdkI68PF5QYsw49AfG9vvUcxwbKqUYFX9TmMHBGWkN8xg5z1
 RaVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781604487; x=1782209287;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=84pgkHPEqKnO+5XQVV3HYQGTgjK8P0Ygb3uX514z88U=;
 b=ZmU4zTHqY04h8lUGbmxYoyYjtICz0hNmAL9V4gQJ9CZVUaAGvl7jy/FyadtUXZ6sMY
 9fmZCGhLhInfay/RyMO1yAc0eIuObofmcgAvcmglj21T/YYbttUfjYVF68M7cpSG6Dm3
 u7r4FP1muzY1nY19REMZ4RoKQRDMrU3F5Vjq0DqKYpJqC9LgI5sVPcw43f/XDPtevUR2
 bvWayAZTtnAEp/4v+5VHRTwszZta8+0Hq+lsPq6pZtZLxAfx/6f/JTW5zypiMjXS6ZNb
 5dHbPM8KZsv0quHg0nqd/vQokMWEV1UU/Xo24KgJVCTbzlx701XZ5YZ1oj4s0VHsZkKY
 jdmw==
X-Gm-Message-State: AOJu0YyshTeTWunxj2BT2K703ywiVyQ7P4sN0UvQg/dq+46QYvy6Wm6M
 T0WYnnTzQXtMxjMs67zfm1Wa+Vg3gjrAmmeX4+j6KYl3kWFCQ77QNg7JCGIyLZZ+
X-Gm-Gg: Acq92OGEgUH4THrBvU9HdZEYLI1OFCMQifzPfu3baluJ/P8xVxAQwbVd5I452v0USJP
 9o44pBtDdoo+k6HCe0q794UpqzeoFJzh9+ddq3RRoSk8sfQaqtpLHHrM8Gvvh5uQSV9oyhXwWhf
 k5KYEhMELggJCjhpXEuaNoVkt2wTQyoXE82qI0Tksq3zilChL2/5luZ0aBXv59VBv/AL98QTF4M
 JPBVukaJLFxBxJbAmE08d1SKCTyCus0tK4eyTlAnax7uWwcSkSUvf2LduQZ8la2Y0z7W+T8xi8t
 a9+k/Amc1xnESKavSXto7FgSTL7N2XngcGhZ8R4csj4I9OyRt0qqU37+TJ0louoJPnjqpsxoe0F
 danVClXXL3/jxLcDqZsRpBD2kRhfr+nm1aiRe2lldlYHOn8TSbjCGzZaVnAlLgXguCeGSaj/SV+
 +uilm6zD56JqTd4aRXMvDJ4fvxJrsct0/GXkKt+ppu
X-Received: by 2002:a05:6a21:6492:b0:3b4:6c68:b100 with SMTP id
 adf61e73a8af0-3b7962c1131mr16386286637.19.1781604486978; 
 Tue, 16 Jun 2026 03:08:06 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c866519f0a6sm10916735a12.22.2026.06.16.03.08.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 03:08:06 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 44/83] target/riscv: De-indent some code in
 get_physical_address()
Date: Tue, 16 Jun 2026 20:04:47 +1000
Message-ID: <20260616100527.1939565-45-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616100527.1939565-1-alistair.francis@wdc.com>
References: <20260616100527.1939565-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x532.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

get_physical_address() is quite complex already. In order
to make the two next commits simplers, de-indent one if()
ladder. No logical change intended.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Message-ID: <20260527201348.29511-5-philmd@linaro.org>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu_helper.c | 33 ++++++++++++++++++---------------
 1 file changed, 18 insertions(+), 15 deletions(-)

diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index dc78fc1192..a8d4a1a4f4 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -1667,27 +1667,30 @@ static int get_physical_address(CPURISCVState *env, hwaddr *physical,
         hwaddr l = sxlen_bytes, addr1;
         mr = address_space_translate(cs->as, pte_addr, &addr1, &l,
                                      false, MEMTXATTRS_UNSPECIFIED);
-        if (memory_region_is_ram(mr)) {
-            target_ulong *pte_pa = qemu_map_ram_ptr(mr->ram_block, addr1);
-            target_ulong old_pte;
-            if (riscv_cpu_sxl(env) == MXL_RV32) {
-                old_pte = qatomic_cmpxchg((uint32_t *)pte_pa, cpu_to_le32(pte), cpu_to_le32(updated_pte));
-                old_pte = le32_to_cpu(old_pte);
-            } else {
-                old_pte = qatomic_cmpxchg(pte_pa, cpu_to_le64(pte), cpu_to_le64(updated_pte));
-                old_pte = le64_to_cpu(old_pte);
-            }
-            if (old_pte != pte) {
-                goto restart;
-            }
-            pte = updated_pte;
-        } else {
+        if (!memory_region_is_ram(mr)) {
             /*
              * Misconfigured PTE in ROM (AD bits are not preset) or
              * PTE is in IO space and can't be updated atomically.
              */
             return TRANSLATE_FAIL;
         }
+
+        target_ulong *pte_pa = qemu_map_ram_ptr(mr->ram_block, addr1);
+        target_ulong old_pte;
+
+        if (riscv_cpu_sxl(env) == MXL_RV32) {
+            old_pte = qatomic_cmpxchg((uint32_t *)pte_pa, cpu_to_le32(pte),
+                                      cpu_to_le32(updated_pte));
+            old_pte = le32_to_cpu(old_pte);
+        } else {
+            old_pte = qatomic_cmpxchg(pte_pa, cpu_to_le64(pte),
+                                      cpu_to_le64(updated_pte));
+            old_pte = le64_to_cpu(old_pte);
+        }
+        if (old_pte != pte) {
+            goto restart;
+        }
+        pte = updated_pte;
     }
 
     /* For superpage mappings, make a fake leaf PTE for the TLB's benefit. */
-- 
2.54.0


