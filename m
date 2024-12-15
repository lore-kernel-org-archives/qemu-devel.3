Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8856E7716A
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Dec 2024 21:38:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMwIk-0005Bo-Rw; Sun, 15 Dec 2024 16:37:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yfliu2008@qq.com>)
 id 1tMwIh-000596-Kz; Sun, 15 Dec 2024 16:37:20 -0500
Received: from out203-205-221-242.mail.qq.com ([203.205.221.242])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yfliu2008@qq.com>)
 id 1tMwIe-00015J-QP; Sun, 15 Dec 2024 16:37:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1734298612; bh=TJjZMs7FrhFO7tdzWpuWUKuaFUOpqZNElm73YzJdYRQ=;
 h=From:To:Cc:Subject:Date;
 b=Wu6gv/Iit/PFH7iWloIcv6OLm7NfYOUasfHBkPddZqg1C+pnrhK2IwCC8DvX7OaXg
 7CS8hWy2TR+7/b1Oii0pefeQERCMB7nQEz50Iai1XTJTyINuy9MRCpvYt5Ee8z2l6+
 n1zo3oS34XKiNfqgP/3UCA/y2RWP2OQtlKRH9Z64=
Received: from qq.com ([171.213.183.116])
 by newxmesmtplogicsvrszb20-0.qq.com (NewEsmtp) with SMTP
 id 9321843C; Mon, 16 Dec 2024 05:36:50 +0800
X-QQ-mid: xmsmtpt1734298610t0bi8nnlr
Message-ID: <tencent_1993B55C24DE7979BF34B200F78287002907@qq.com>
X-QQ-XMAILINFO: OGZxhFXqN7PJrgxZbfykKsvYPE36Ys8+B6nzHGT2OWpf1cEEihnjVrHL9z5pF2
 E9s5nHy3n5TsDag3VLkQDyIxPPXbiaMevp7tY16kwo6q8H8uI4kMZ5ZkgqFcTVtXTmJrSQC3mVGH
 voKM9XYHoz22D36ExidWnnag1zijJRSie9lNgk0F+SAUzAACCs2vKQvRNT+D11O41ayKNTMYy/pC
 XrAZtxr8gqRo9mZdMUWZNnzWkkPf159mTcDAjbFdbyb0ntnp7ookhlmKgILyb/suPAYsEx20rJE2
 PfeZwQeznJCfZH2brxUiNyE6gta6MC3hFSFXB0cP3uiS+5OAZPn5FrU0Cxz3fPEBgznDDWUd1DRL
 iXBPmZH7XSxfzNUeNIofM/caAhBiSOcsGeyn4lLcVB0ZI+ZXsIQBB+vrbopro1EhBXSkDls5ySaj
 L0M9Guqy7n0o0Bym17x1BTFeQJWIfB8RFg5ivZZ9e3P6Qzs80RTPbzDiE4aH0urCnRGLjkwoJnTp
 gul+HQLUQXa8/hlK1ap9KJ/CnS7zFm4VJpZ66yKiyQ98pSH8X9LcUuxgqvQQ+oX+RqNN4Sale4BJ
 sO1EGmcNaXVB9v1hVhNEMb7r9YOEZGTp7j0BH9hTPiic6SO4tMBhrDrSP0HHT84ddhHDtBrI3oiP
 aITYiEbHAOaKlotMMCMD22V6VVLj9QYNLUQKpNs19x/vTdDXNNgovjcwFghPkv99FDaRwUMb1wnc
 DgQdF4OD6dRrnps2eySGOC7zkW0lfpwmzRXAT4uB1v7ydj4VEhrh7Bebv6gdBV2pUIrNuYZXPL+i
 Mnms1jIRO8pB2ExgLUAwV+K16OV/fPjG9BrKu/CMItTWj5Lkip+fXYvflDXz7ANJ3eLAJR1r9iLJ
 1L00Y+sAqxd2pXRvk9fFQ8T15A3O/BR0s3NxtuMEiNarhYZQvylt4lLGq2fNzB6VsaaqC/IlxQ+V
 EE7ZrEM48=
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
From: Yanfeng Liu <yfliu2008@qq.com>
To: qemu-riscv@nongnu.org
Cc: qemu-devel@nongnu.org, alistair.francis@wdc.com, alex.bennee@linaro.org,
 mario.fleischmann@lauterbach.com, Yanfeng Liu <yfliu2008@qq.com>
Subject: [PATCH v4] riscv/gdbstub: add V bit to priv reg
Date: Mon, 16 Dec 2024 05:36:35 +0800
X-OQ-MSGID: <20241215213635.15902-1-yfliu2008@qq.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=203.205.221.242; envelope-from=yfliu2008@qq.com;
 helo=out203-205-221-242.mail.qq.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25,
 FREEMAIL_FROM=0.001, HELO_DYNAMIC_IPADDR=1.951, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 RDNS_DYNAMIC=0.982, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

This adds virtualization mode (V bit) as bit(2) of register `priv`
per RiscV debug spec v1.0.0-rc4. Checked with gdb-multiarch v12.1.

Note that GDB may display `INVALID` tag for `priv` reg when V bit
is set, this doesn't affect actual access to the bit though.

Signed-off-by: Yanfeng Liu <yfliu2008@qq.com>
---
 target/riscv/gdbstub.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/target/riscv/gdbstub.c b/target/riscv/gdbstub.c
index c07df972f1..18e88f416a 100644
--- a/target/riscv/gdbstub.c
+++ b/target/riscv/gdbstub.c
@@ -213,7 +213,10 @@ static int riscv_gdb_get_virtual(CPUState *cs, GByteArray *buf, int n)
         RISCVCPU *cpu = RISCV_CPU(cs);
         CPURISCVState *env = &cpu->env;
 
-        return gdb_get_regl(buf, env->priv);
+        /* Per RiscV debug spec v1.0.0 rc4 */
+        target_ulong vbit = (env->virt_enabled) ? BIT(2) : 0;
+
+        return gdb_get_regl(buf, env->priv | vbit);
 #endif
     }
     return 0;
@@ -226,10 +229,22 @@ static int riscv_gdb_set_virtual(CPUState *cs, uint8_t *mem_buf, int n)
         RISCVCPU *cpu = RISCV_CPU(cs);
         CPURISCVState *env = &cpu->env;
 
-        env->priv = ldtul_p(mem_buf) & 0x3;
-        if (env->priv == PRV_RESERVED) {
-            env->priv = PRV_S;
+        target_ulong new_priv = ldtul_p(mem_buf) & 0x3;
+        bool new_virt = 0;
+
+        if (new_priv == PRV_RESERVED) {
+            new_priv = PRV_S;
+        }
+
+        if (new_priv != PRV_M) {
+            new_virt = (ldtul_p(mem_buf) & BIT(2)) >> 2;
         }
+
+        if (riscv_has_ext(env, RVH) && new_virt != env->virt_enabled) {
+            riscv_cpu_swap_hypervisor_regs(env);
+        }
+
+        riscv_cpu_set_mode(env, new_priv, new_virt);
 #endif
         return sizeof(target_ulong);
     }
-- 
2.34.1


