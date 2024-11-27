Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BD3BD6ACDA
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2024 14:09:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGIiO-0003wM-Js; Wed, 27 Nov 2024 09:08:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlmgr@proulx.com>) id 1tGHw4-0000jN-Mr
 for qemu-devel@nongnu.org; Wed, 27 Nov 2024 08:18:29 -0500
Received: from havoc.proulx.com ([198.99.81.74])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlmgr@proulx.com>) id 1tGHw0-0000U0-R6
 for qemu-devel@nongnu.org; Wed, 27 Nov 2024 08:18:28 -0500
Received: by havoc.proulx.com (Postfix, from userid 1027)
 id 1640A13E5; Wed, 27 Nov 2024 06:18:16 -0700 (MST)
Authentication-Results: havoc.proulx.com;
 dkim=fail reason="signature verification failed" (1024-bit key;
 unprotected) header.d=qq.com header.i=@qq.com header.a=rsa-sha256
 header.s=s201512 header.b=GMs+1M5Z; dkim-atps=neutral
Resent-From: Mailing List Manager <mlmgr@proulx.com>
Resent-Date: Wed, 27 Nov 2024 06:18:16 -0700
Resent-Message-ID: <Z0ccGCVldrcMFU6Q@havoc.proulx.com>
Resent-To: qemu-devel@nongnu.org
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yfliu2008@qq.com>)
 id 1tGGuz-00043g-NU; Wed, 27 Nov 2024 07:13:20 -0500
Received: from xmbghk7.mail.qq.com ([43.163.128.44])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yfliu2008@qq.com>)
 id 1tGGuv-0006eG-QR; Wed, 27 Nov 2024 07:13:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1732709582; bh=8C5jjLpgV2BqCx4Ogm16oS7SNcrmmwr4or/rEmI2eOs=;
 h=Subject:From:To:Cc:Date;
 b=GMs+1M5ZL+WmrrgE/Y2UAkIytnVVuckpbqdTTyWUqZS52+f7XSNx57jJGnMqQVdAd
 2xv1/JapVdMtxOgTPkHAK/6cxW3VwKVu1yoszodcSsmnDVklT19haSAXViCxHCRNHQ
 vhuhj//Arbw2RZK7GG6c7Hc83BefvDgBnFc7NbS8=
Received: from [192.168.1.13] ([61.139.23.214])
 by newxmesmtplogicsvrszb20-0.qq.com (NewEsmtp) with SMTP
 id 21E2462F; Wed, 27 Nov 2024 20:08:30 +0800
X-QQ-mid: xmsmtpt1732709310ta0u1ekex
Message-ID: <tencent_6FF30F7E2E640BEE260FD6523B6BA5486908@qq.com>
X-QQ-XMAILINFO: MKNfDyfSZgoortjcUgJz49r8oUkumNqsHajsZnWShPsxbmi6ONJ7aa8Sd83Ifq
 c5cz6nDK69hFm8OzyPQ5/rik7gAA+8fTExmL9LsmG4ueWOCZWQsswh3WuKEVFIhQ7S0WjyP7PRCx
 kjo1j1wf5ygzeFPnvjAaMu10SpMkCpgsOSOv63g5c1UlWs4PlvRArmdcL7FTedAf+2BiOao//yO2
 6wyIbFtgddqPfzQPYu72gUn7duToqktXgHyZHPVMO4uYkoaqOap5cvxVEeSPoVaWux0wXHDOE2ja
 YCYWQ1bJRFqlaqk/+/7/rbejLus8VCY7ObdSDV9HCbeQRaxjkVWGvjn4pK7LSzn3Ys47OvCnD/tr
 1OXbdG98vr5ByVHrUe5vDCeeyVF9y4TsYhsKaFdtbPWzTBNt/1shzGgPkY6k+i5GzgEaiJ5T70IO
 /2nZrfY6RcqZEppxXGfmkTyl13R7V5dARFIzRO1jM9RXNumjWSASqb0B/T52laGY2U7frD4CCBVk
 IO687Go7AxIC39Av10iVOc/Dwu3J0zK4wBYnmkzfQtBG9tQt1lw6G5sM5vAXtS8AVJWRJx1xC/7L
 cGXw7E+GOBcjntpDR8RcS2wKM9S6Roj5bamOT5/BqSnXr5Wg8SF8XQgnNX/NQy8Ojswm22BZRy07
 P7w7mKQABEBSf/OQrYi3L9qjUByBWmTI6XfIuBdhyFMDoYOgxdZpbm4ElzEyfukXvLNuW+tFv8/l
 qM334OtzWEVJIwYuj2dyS9CLou+3OupHJYk9h686fnSsF/NDDg2+wiqzXwAwRHhHqy8XBxu/Q0FR
 5XZxBRhmuMaaH0oYwYt2/t2obF6YRJIJ4tKmUL8nv4sCt3Lt4a18c3G9V5DZaF2V2T3tnrZio0no
 u7AS3qYqjWTZf/Ae5dIZmYVY+BPXxUKa6ixSCsCfMJnQE88fgNV3nPgZr++tmqIiE+9Hr2PUyCTW
 IHZAq4QcenMEKlswWjJ8F+dVJe553E
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
X-OQ-MSGID: <c9bcdecdaac39da34ca1a64689ec4daf2d2e680a.camel@qq.com>
Subject: [PATCH] include virtualization mode as part of priv
From: Yanfeng <yfliu2008@qq.com>
To: qemu-devel@nongnu.org, qemu-riscv@nongnu.org
Cc: Daniel Henrique Barboza <dbarboza@ventanamicro.com>, Weiwei Li
 <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Alistair
 Francis <alistair.francis@wdc.com>
Date: Wed, 27 Nov 2024 20:08:30 +0800
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
MIME-Version: 1.0
Received-SPF: pass client-ip=43.163.128.44; envelope-from=yfliu2008@qq.com;
 helo=xmbghk7.mail.qq.com
X-Spam_action: no action
X-Listhelper-Id: 20241127051414-23793
X-Bogosity: Spam, tests=bogofilter, spamicity=0.999999, version=1.2.5
X-CRM114-Status: UNSURE (  -4.95  )
Received-SPF: pass client-ip=198.99.81.74; envelope-from=mlmgr@proulx.com;
 helo=havoc.proulx.com
X-Spam_score_int: 16
X-Spam_score: 1.6
X-Spam_bar: +
X-Spam_report: (1.6 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.001, HK_RANDOM_ENVFROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SBL_CSS=3.335,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 27 Nov 2024 09:08:21 -0500
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


When debugging hypervisor extension based programs, it is convenient to see=
 the
current virtualization mode from GDB debugger.

This patch shares the virtualization mode as part of the existing "priv" vi=
rtual
register, or more specifically via bit(8).


>From 0d82561b11e1c2835f14ba5460cfff52f0087530 Mon Sep 17 00:00:00 2001
From: Yanfeng Liu <yfliu2008@qq.com>
Date: Mon, 18 Nov 2024 08:03:15 +0800
Subject: [PATCH] riscv/gdb: share virt mode via priv register

This shares virtualization mode together with privilege mode
via the `priv` virtual register over the debug interface.

Check logs with gdb-multiarch 12.1:

```
(gdb) info registers priv
priv           0x101	prv:1 [Supervisor]
(gdb) set $priv =3D 1
(gdb) info registers priv
priv           0x1	prv:1 [Supervisor]
(gdb) set $priv =3D 0x101
(gdb) info registers priv
priv           0x101	prv:1 [Supervisor]
(gdb)
```

Signed-off-by: Yanfeng Liu <yfliu2008@qq.com>
---
 target/riscv/cpu_bits.h |  4 ++++
 target/riscv/gdbstub.c  | 15 +++++++++++++--
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
index 385a2c67c2..cc6dece51a 100644
--- a/target/riscv/cpu_bits.h
+++ b/target/riscv/cpu_bits.h
@@ -623,6 +623,10 @@ typedef enum {
 #define PRV_RESERVED 2
 #define PRV_M 3
=20
+/* Share virtualization mode as part of priv register */
+#define PRV_V                (1 << 8)
+
+
 /* RV32 satp CSR field masks */
 #define SATP32_MODE         0x80000000
 #define SATP32_ASID         0x7fc00000
diff --git a/target/riscv/gdbstub.c b/target/riscv/gdbstub.c
index c07df972f1..d9e6ad969a 100644
--- a/target/riscv/gdbstub.c
+++ b/target/riscv/gdbstub.c
@@ -212,8 +212,14 @@ static int riscv_gdb_get_virtual(CPUState *cs, GByteAr=
ray
*buf, int n)
 #else
         RISCVCPU *cpu =3D RISCV_CPU(cs);
         CPURISCVState *env =3D &cpu->env;
+        target_ulong ret =3D env->priv;
=20
-        return gdb_get_regl(buf, env->priv);
+        /* include virtualization mode */
+
+        if (env->virt_enabled) {
+            ret |=3D PRV_V;
+        }
+        return gdb_get_regl(buf, ret);
 #endif
     }
     return 0;
@@ -225,11 +231,16 @@ static int riscv_gdb_set_virtual(CPUState *cs, uint8_=
t
*mem_buf, int n)
 #ifndef CONFIG_USER_ONLY
         RISCVCPU *cpu =3D RISCV_CPU(cs);
         CPURISCVState *env =3D &cpu->env;
+        target_ulong val =3D ldtul_p(mem_buf);
=20
-        env->priv =3D ldtul_p(mem_buf) & 0x3;
+        env->priv =3D val & 0x3;
         if (env->priv =3D=3D PRV_RESERVED) {
             env->priv =3D PRV_S;
         }
+
+        /* Update virtualization mode */
+
+        env->virt_enabled =3D (env->priv !=3D PRV_M && (val & PRV_V) !=3D =
0);
 #endif
         return sizeof(target_ulong);
     }
--=20
2.34.1




