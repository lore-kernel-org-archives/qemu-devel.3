Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA88BCA9EC7
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Oct 2026 04:07:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xFkpV-0007ly-QX; Sun, 11 Oct 2026 00:06:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebasjosue84@gmail.com>)
 id 1xFkpS-0007l5-85
 for qemu-devel@nongnu.org; Sun, 11 Oct 2026 00:06:30 -0400
Received: from mail-vk1-xa2e.google.com ([2607:f8b0:4864:20::a2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <sebasjosue84@gmail.com>)
 id 1xFkpQ-0002Yy-9T
 for qemu-devel@nongnu.org; Sun, 11 Oct 2026 00:06:29 -0400
Received: by mail-vk1-xa2e.google.com with SMTP id
 71dfb90a1353d-5e4d95e3e55so327739e0c.2
 for <qemu-devel@nongnu.org>; Sat, 10 Oct 2026 21:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791691586; x=1792296386; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=D14PHYKTzv+vsB1RTM6RUy2ukdlwKgLV0dDbuBxWFyc=;
 b=jNtd6WH8mVpf2Qeicn70JRnl03gZi4ljrOWMuQ6bAxD1CaFm4okvuO2cp/hGs3uWGp
 G7+fPcc8A9OvsOc9gAqqnxttTElMxtP0EPs+mjTsVFKbEitsQB1wztLYavSr8gI5aT7a
 UsahzkKUxcWvfYhk9dXh3HR6oFjRGQ0uRlaKHur+XNsl8emS6ispuYK3/t+f73ZnbdBK
 u4Q+df4eFeGNDqTHAe+oPo/g9iajDsbBRoRm9b2Y2xAbaSnCJkCkF44+us8yQo6WinCT
 u5Cujy+RrNYgzJS7/fC2zPHwASgNTwT/YfFpk2z2mtG66KiYjklbs7rq9do/0kLfm+Gh
 1HsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791691586; x=1792296386;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=D14PHYKTzv+vsB1RTM6RUy2ukdlwKgLV0dDbuBxWFyc=;
 b=dFADAW6sXvPOMeToXbS/X7LrC4Q0Chu5oEJn2ZkXeMybbj7jFsRDmzLk4gXKAQmbug
 ym9w5I5teeERJw6azOg/DGVVJr1L1QDaADcSmmZmuXkyoVy0HXf7EbVhnbNRpRGbZkaj
 ERtHRnp6m0uTiFkTFvHcvhLscYB4Ohc9EHtni9SsvL9E/nB3GkwMfvi2my2oylIW7dOr
 S9yzbeLYWMiPZYNM5CvUaF342B2NFlEfjx9ysAziUCgZ03HBQUdHfP5llxlKU/PygXuZ
 JZQYpsjdGGG9f0nmdwHq/nvm7sSeeoBS0nZaWJ8wVqf6mAbI7oby0M+kqIpWAt3tOkhZ
 v6WA==
X-Gm-Message-State: AFq9FYIpPAFidyTE6w5G8EJhvel8uBzdT1WRLxG1tvxIb/mXjNhqiK3q
 zPPLrOzBvZpA7BvThK9TZssqZl6n2g/DlTzN2EjjV48JD4mp7svaZgr8FLGttb6roUtGDQ==
X-Gm-Gg: AYBFou0/e2mybKGfF+gIvlasjlfCcQF956NqM2yqZZVeoIMxOQmXPxtc9zOGRJeZU0A
 LcB/A72axy7uOXHXX4K6qIodiowivQqidiJaYuBf+0wthSuZWk1MfxJEBTw/uiX70TTCSqywghb
 EiXuKtXqFNiOAOlyuIwS3R6uaC6yPeSYu1vENcwSSyAHkmT9DxWID6kEY7VWQFTyB1H95uPPL+s
 +yHx5Oy0IPgrr6RgUF6Vk6/vc/sKdVnQo/KYVpfRPesTKaNDsYO2Ursw1odt6Z78MTJrzeUrtcc
 cBiliN2MyeAoieeQXK7gLpUbZ4b/BLnqvUbILAG61x+4GViou+4Trwx/P+/3jznW0eHF5UeBDCW
 nUR9jnIHeeRnjneHSxSnSKNEw9h6CwoghYFnO4Ewf9KZfjl71J9VdVvvgRFp/tlvVUEQW40Iq9t
 IzgdEFr1RyTNHgIvh5SX2P8A2rFSh8dHD0Yotm52x6Edvgq4MPfrWTgotuMD0uLwMXhgDMCkOvC
 Vkj+GOK/fughwJ5g8AMbH6A+G5SwxnD0tYQI6lymVKTiNgkFf6OkaGH9ROibHo=
X-Received: by 2002:a05:6102:5cca:b0:7c4:a0e4:1a79 with SMTP id
 ada2fe7eead31-7cb37317ab0mr1312754137.19.1791691586437; 
 Sat, 10 Oct 2026 21:06:26 -0700 (PDT)
Received: from localhost.localdomain ([186.151.100.62])
 by smtp.gmail.com with ESMTPSA id
 ada2fe7eead31-7cb354016d6sm4743918137.8.2026.10.10.21.06.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 10 Oct 2026 21:06:24 -0700 (PDT)
From: Sebastian Alba Vives <sebasjosue84@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 liwei1518@gmail.com, daniel.barboza@oss.qualcomm.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 richard.henderson@linaro.org, Sebastian Alba Vives <sebasjosue84@gmail.com>
Subject: [PATCH v2] target/riscv: pmp: clear the entire PMP state on reset
Date: Sat, 10 Oct 2026 22:06:17 -0600
Message-ID: <20261011040617.807504-1-sebasjosue84@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260916034331.2390427-1-sebasjosue84@gmail.com>
References: <20260916034331.2390427-1-sebasjosue84@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::a2e;
 envelope-from=sebasjosue84@gmail.com; helo=mail-vk1-xa2e.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

pmp_unlock_entries() bounded its loop with pmp_get_num_rules(), which
returns the number of entries whose A field is not OFF rather than the
number of implemented entries. With a sparse configuration the loop
stops early: with entries 0 and 1 OFF and entries 2 and 3 locked,
num_rules is 2, the loop covers i = 0 and i = 1, and entries 2 and 3
keep their lock and address-match bits across reset.

riscv_cpu_reset_hold() clears mseccfg, and with it RLB, before calling
this, so pmp_is_readonly() then silently discards every subsequent
pmpcfg write to those entries. The stale rules survive for the
lifetime of the machine.

Clearing only PMP_LOCK and PMP_AMATCH is not enough either. The priv
spec only mandates that the A and L fields be reset, but QEMU keeps
derived state next to the architectural registers: pmp_state.addr[]
and pmp_state.num_rules are recomputed from the pmpaddr and pmpcfg
write paths only, never at reset. pmp_is_in_range() compares against
addr[].sa and addr[].ea without consulting the A field, and the
partially-inside check in pmp_hart_has_privs() runs before the A
field is tested, so a range left over from before the reset can still
deny an access that straddles its boundary once the guest configures
any entry again.

Zero the whole structure instead. Zero is the correct reset value for
every field: a cfg_reg of 0 is A=OFF with no permissions, and a
num_rules of 0 restores the no-rules short cut. Rename the function
since it no longer only unlocks entries.

Fixes: 4bf501dc0118 ("target/riscv: pmp: Clear pmp/smepmp bits on reset")
Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Sebastian Alba Vives <sebasjosue84@gmail.com>
---
Changes in v2:
- Zero the whole env->pmp_state instead of masking PMP_LOCK and
  PMP_AMATCH over a bounded set of entries, as suggested by Richard.
  v1 also left pmp_state.addr[] and pmp_state.num_rules stale across
  reset, which the memset covers as well.

v1: https://lore.kernel.org/qemu-devel/20260916034331.2390427-1-sebasjosue84@gmail.com/

 target/riscv/cpu.c     | 4 ++--
 target/riscv/tcg/pmp.c | 9 ++-------
 target/riscv/tcg/pmp.h | 2 +-
 3 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index da4c1a090b..0b71196507 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1048,7 +1048,7 @@ static void riscv_cpu_reset_hold(Object *obj, ResetType type)
     }
 
     /*
-     * Clear mseccfg and unlock all the PMP entries upon reset.
+     * Clear mseccfg and the PMP state upon reset.
      * This is required as per the priv, smepmp, and other security
      * extension specifications that share this CSR, and is needed
      * to clear stale entries across reboots.
@@ -1060,7 +1060,7 @@ static void riscv_cpu_reset_hold(Object *obj, ResetType type)
         env->mseccfg = 0;
     }
 
-    pmp_unlock_entries(env);
+    pmp_reset(env);
 #endif /* ifdef CONFIG_TCG */
 #else
     env->priv = PRV_U;
diff --git a/target/riscv/tcg/pmp.c b/target/riscv/tcg/pmp.c
index 41b55519a8..437e0ff2af 100644
--- a/target/riscv/tcg/pmp.c
+++ b/target/riscv/tcg/pmp.c
@@ -199,14 +199,9 @@ static bool pmp_write_cfg(CPURISCVState *env, uint32_t pmp_index, uint8_t val)
     return false;
 }
 
-void pmp_unlock_entries(CPURISCVState *env)
+void pmp_reset(CPURISCVState *env)
 {
-    uint32_t pmp_num = pmp_get_num_rules(env);
-    int i;
-
-    for (i = 0; i < pmp_num; i++) {
-        env->pmp_state.pmp[i].cfg_reg &= ~(PMP_LOCK | PMP_AMATCH);
-    }
+    memset(&env->pmp_state, 0, sizeof(env->pmp_state));
 }
 
 static void pmp_decode_napot(hwaddr a, hwaddr *sa, hwaddr *ea)
diff --git a/target/riscv/tcg/pmp.h b/target/riscv/tcg/pmp.h
index 4c95c2767a..99546934fc 100644
--- a/target/riscv/tcg/pmp.h
+++ b/target/riscv/tcg/pmp.h
@@ -79,7 +79,7 @@ void pmp_update_rule_addr(CPURISCVState *env, uint32_t pmp_index);
 void pmp_update_rule_nums(CPURISCVState *env);
 uint32_t pmp_get_num_rules(CPURISCVState *env);
 int pmp_priv_to_page_prot(pmp_priv_t pmp_priv);
-void pmp_unlock_entries(CPURISCVState *env);
+void pmp_reset(CPURISCVState *env);
 
 #define MSECCFG_MML_ISSET(env) get_field(env->mseccfg, MSECCFG_MML)
 #define MSECCFG_MMWP_ISSET(env) get_field(env->mseccfg, MSECCFG_MMWP)
-- 
2.43.0


