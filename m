Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A324AE7716E
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2024 00:14:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJLyT-0007rs-40; Thu, 05 Dec 2024 19:13:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yfliu2008@qq.com>)
 id 1tJLyR-0007rN-7H; Thu, 05 Dec 2024 19:13:35 -0500
Received: from out162-62-57-252.mail.qq.com ([162.62.57.252])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yfliu2008@qq.com>)
 id 1tJLyN-0001EA-08; Thu, 05 Dec 2024 19:13:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1733443992; bh=VM1yTaO/UfEilYgwYBtb/LjM4Tn0jXZ6q1mwW/Qsebg=;
 h=From:To:Cc:Subject:Date;
 b=pfD5LS7iLv4wac+eDL9V2WbJ/wxEW48jQQJct5Oiu88HmMl2xi39dGrfHX1JKXLJX
 UilOuqgQdE3o66dkp2kGNPVYgEXVz35IEqZffywn32W4SoUL0JIfpf6vIiK2mj59IG
 ZJVSr6/ql0EeTzCGUHE4DGP1R5W06UCkGgA9Lb/U=
Received: from qq.com ([61.139.23.192])
 by newxmesmtplogicsvrszc25-0.qq.com (NewEsmtp) with SMTP
 id 34AB8670; Fri, 06 Dec 2024 08:13:10 +0800
X-QQ-mid: xmsmtpt1733443990tkwz5m40u
Message-ID: <tencent_D006B250779A0740A99BB51DA4A8F95EBF07@qq.com>
X-QQ-XMAILINFO: OeJ9zRfntlNP8oWIkKnTZFXf8VnE/xtwACw4SdjqrcC1Ab6p1mrRV0XAWgsF2v
 OKAc6vQyMZIPBs9cT7S5FToFCvQ/xCqmdcNhkzjsrT0mYXdy8pY8fJB2cTRsTh2szqWkWouZwP0X
 muwhxzVaXTkRCPksPkuA0ucDtfRQp7ZxzO2RUzRwp+Yq2H0Mi7m2BVYKevI0+51D1KR8/tH9G9IY
 f1yezizC5ueu8yddqxALFMyIcB9FL7t1oL2qpxcSK/3MMIXcf3Rocu5mZpiYwJHrX7OJeH/3MrDJ
 bBvR7lLbgQ2scIN6oRo79xkHoXwdhqJAm1IA4T/snoghEwSQexNYkrWEEiV1yRsV7uSluiU6Q8zV
 Ol40bU6WDwl4zzYTBAmZoSRf9pQASYYPha0y8hJ/a84wcIzKyDsE5GGJKhxewrPJek/JBR1LTyEj
 wu5TMv1/C8ApiQox1Bw6evhvZLj5EOkCYJh9Iw3KeI74AS7LG+LfSOwnzFQBNRxY04cw3Suipran
 O+9CLdzZJIJgQVRkNYR2tF+j1i1ocLM4NZKPHv/OjFLeJmqUx9LEe6AuiE+3GF9kyPVh5LvnuXdz
 2yKIO5e72/PlLz5MG7ftO3sigTHNs+AYa4C7zRQRRUyC55GmriLaZ1UEc2yPNYYfjCg2gflk2opf
 dKH9Z1TGZJ+KF3iw71oAaptijakrOxZ/Kjv8lb6/8RoU2GXCbqc0IjBXBVWPOVM4ALeiVgNC9sHZ
 nFQedAkv02sKlIxb+SjFNLdnR3GLg6dFlg3MkzpCYSmR/OHws2O5hKf7Hyfni9zsKaqESVkbrPb6
 qykMt7vTxHnogGW25D77zww3n/BobxCOIpD9/A3pcladwfUqFQRKtTkFbrsIuxno68hd8RGWTS+e
 dAHopqeJj4r7KJL1EopUQ2aDWjPORRG4port9RCQHMzDJ1fbuNDGxv1+fjwsBwGQb53Ihd61aG
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
From: Yanfeng Liu <yfliu2008@qq.com>
To: qemu-riscv@nongnu.org
Cc: qemu-devel@nongnu.org, alistair.francis@wdc.com, alex.bennee@linaro.org,
 Yanfeng Liu <yfliu2008@qq.com>
Subject: [PATCH v3] riscv/gdb: add V bit to priv register
Date: Fri,  6 Dec 2024 08:12:59 +0800
X-OQ-MSGID: <20241206001259.2974-1-yfliu2008@qq.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=162.62.57.252; envelope-from=yfliu2008@qq.com;
 helo=out162-62-57-252.mail.qq.com
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
per RiscV debug spec v1.0.0-rc3. Checked with gdb-multiarch v12.1.

Note that GDB may display `INVALID` tag for the value when V bit
is set, this doesn't affect accessing to the bit.

Signed-off-by: Yanfeng Liu <yfliu2008@qq.com>
---
 target/riscv/gdbstub.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/target/riscv/gdbstub.c b/target/riscv/gdbstub.c
index c07df972f1..8cc095cda3 100644
--- a/target/riscv/gdbstub.c
+++ b/target/riscv/gdbstub.c
@@ -213,7 +213,10 @@ static int riscv_gdb_get_virtual(CPUState *cs, GByteArray *buf, int n)
         RISCVCPU *cpu = RISCV_CPU(cs);
         CPURISCVState *env = &cpu->env;
 
-        return gdb_get_regl(buf, env->priv);
+        /* Per RiscV debug spec v1.0.0 rc3 */
+        target_ulong vbit = (env->virt_enabled) ? BIT(2) : 0;
+
+        return gdb_get_regl(buf, env->priv | vbit);
 #endif
     }
     return 0;
@@ -230,6 +233,8 @@ static int riscv_gdb_set_virtual(CPUState *cs, uint8_t *mem_buf, int n)
         if (env->priv == PRV_RESERVED) {
             env->priv = PRV_S;
         }
+        env->virt_enabled = (env->priv == PRV_M) ? 0 :
+                            ((ldtul_p(mem_buf) & BIT(2)) >> 2);
 #endif
         return sizeof(target_ulong);
     }
-- 
2.34.1


