Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A979C44506
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Jul 2026 08:47:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wippT-0001Oa-Rc; Sun, 12 Jul 2026 04:46:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yfliu2008@qq.com>)
 id 1wippQ-0001Ns-Gy; Sun, 12 Jul 2026 04:46:25 -0400
Received: from out162-62-57-64.mail.qq.com ([162.62.57.64])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yfliu2008@qq.com>)
 id 1wippH-0006W4-9N; Sun, 12 Jul 2026 04:46:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1783845959; bh=tIyBoHf8hCygG64lLbiB7PHGpQj5vYvBFiB0gG4+0mo=;
 h=From:To:Cc:Subject:Date;
 b=WE50viD/f+upav8kKFOGQg1F9QmSsLW/LBjlNIBPSluBvgS6CdUIXPdvq2bcHOBvl
 LAxrO1yCDamUyynxBY5q+iQ+wjWV9YCWFbNsAVkLy/CPIek25zCuvNTZjwJeBPs3uL
 oEivSJyhNsd/LvmQuSlOT9K6HC1+3DW/GAF6v3a4=
Received: from qq.com ([125.69.26.119])
 by newxmesmtplogicsvrszb51-0.qq.com (NewEsmtp) with SMTP
 id B788DC29; Sun, 12 Jul 2026 16:45:56 +0800
X-QQ-mid: xmsmtpt1783845956trs47i4pw
Message-ID: <tencent_E17E8F6494EE130F71527C6BCE481AF33E08@qq.com>
X-QQ-XMAILINFO: ORaMKMferCiA4x1ImdjLE6WMn4e5k0Qo3Omhia1aKi68X01F+j8PACFQXJ+OyX
 gWM2IfTY2Vyry+vyoCawPRJSA0a5+21J3V1xG0FMzxvF92+rVCiuIJ1DbOxk40BBIVMXj12Ti7r5
 UV9NUFwwGT2cXvhqdAOCEgDAzXN7toR/KvfQmtkPnIuWZaSGvb0mRxLNa+4P/X3TQ9ZnrPPpyRyL
 Z2rPdMdLmDPX5DOY+YQsc8RNpN3bLaL80XCkTCE+CPFiYxCkESAu+NT+K35qnvcRAAGxmmkKpoZJ
 dgoFLUavJIsddFLLMAhKrlH7sOu5MGqr85qfGVwo5gDalceOgtJUnNi1/2SUhoSHX5FleNYTUKxc
 x/P9C77AdQeDL/ntfqQCAFc31gwfbUGvrFAqzzj3LlSrdQvlpzCJLNrqQMbpdXpQaZMjyhzeRC4X
 zQ75lu40IMsyP5VMGahwRvMfTFE0JaV5IuWmjM3U3WG+0j9wT3T68/VBoKr4MJJ3UVmAQul42tAg
 //q69IpS6zAdhgaoDoFb22d+Bi7+WaGY2l1EExTw1pyU89pu3B1Qnsd047XY7D6y2dIF6V9TeQ62
 f1tUwIalZjt/Ddrd3q0GPFW84abipPYpebb7cTlhCTnqjWmr36NHS7KXHMgojpd+uYYoYlfbIo2C
 Je+TSbZIaZzawsETrMuU9CMo/B4OwdfmBUwtZqdieZFksJZ8iPROR1FUJ7lr70LBtOiZ8LOtabpH
 rz8O3pRM4ZwtHE2piDV6uMHBOBxG5RUXEXvHB7rPP+nFRQ+1sIQkpOlgUlmVI0TtFQRYg9DB4yvZ
 K9sa9QTqCFoeBMJHWZsC8hZltS+DXu1YyUe8MTzWeHdI1DClpP6iwoS9EL80EzwdffagQ9QFpvYK
 lFY/k7tS2vXeOW8A2gdLjxcSN47TDdQfiweSZ9FIKDfVWmUsU7p547THC/lKpovv4sRuWb9gVw4s
 bGrHHViD2zTcpfYjgNm72XD0uxe7jXPOvGNgVOvesDZ+rccyFYggW5PdEhypcE3xRILRWqEv97Xb
 m/0B0fReSfTSW/o3CPEEXgH90DMRMKrDy499xpItalF4Kcl+q9brimFj7MdEGBaUTmLL1OLw==
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
From: Yanfeng Liu <yfliu2008@qq.com>
To: qemu-riscv@nongnu.org
Cc: qemu-devel@nongnu.org, alex.bennee@linaro.org, erdnaxe@crans.org,
 pierrick.bouvier@oss.qualcomm.com, Yanfeng Liu <yfliu2008@qq.com>
Subject: [PATCH v1] uftrace: riscv privilege level
Date: Sun, 12 Jul 2026 16:45:53 +0800
X-OQ-MSGID: <20260712084553.2945-1-yfliu2008@qq.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=162.62.57.64; envelope-from=yfliu2008@qq.com;
 helo=out162-62-57-64.mail.qq.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HELO_STATIC_HOST=-0.001,
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

This adds RiscV virtual user and supervisor privilege levels to
uftrace plugin to avoid crashing with H extension guests.

Signed-off-by: Yanfeng Liu <yfliu2008@qq.com>
---
 contrib/plugins/uftrace.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/contrib/plugins/uftrace.c b/contrib/plugins/uftrace.c
index 9b0a4963ae..063e32220b 100644
--- a/contrib/plugins/uftrace.c
+++ b/contrib/plugins/uftrace.c
@@ -109,6 +109,8 @@ typedef enum {
     RISCV64_SUPERVISOR,
     RISCV64_RESERVED,
     RISCV64_MACHINE,
+    RISCV64_VUSER,
+    RISCV64_VSUPERVISOR,
     RISCV64_PRIVILEGE_LEVEL_MAX,
 } Riscv64PrivilegeLevel;
 
@@ -153,8 +155,10 @@ static void uftrace_write_map(bool system_emulation)
     const char *path = "./uftrace.data/sid-0.map";
 
     if (system_emulation && access(path, F_OK) == 0) {
-        /* do not erase existing map in system emulation, as a custom one might
-         * already have been generated by uftrace_symbols.py */
+        /*
+         * do not erase existing map in system emulation, as a custom one might
+         * already have been generated by uftrace_symbols.py
+         */
         return;
     }
 
@@ -706,6 +710,8 @@ static const char *riscv64_get_privilege_level_name(uint8_t pl)
     case RISCV64_SUPERVISOR: return "Supervisor";
     case RISCV64_RESERVED: return "Unknown";
     case RISCV64_MACHINE: return "Machine";
+    case RISCV64_VUSER: return "VUser";
+    case RISCV64_VSUPERVISOR: return "VSupervisor";
     default:
         g_assert_not_reached();
     }
@@ -986,7 +992,8 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
 
     score = qemu_plugin_scoreboard_new(sizeof(Cpu));
     qemu_plugin_register_vcpu_init_cb(id, vcpu_init, NULL);
-    qemu_plugin_register_atexit_cb(id, at_exit, (void *) info->system_emulation);
+    qemu_plugin_register_atexit_cb(id, at_exit,
+                                   (void *) info->system_emulation);
     qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans, NULL);
 
     return 0;
-- 
2.34.1


