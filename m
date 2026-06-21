Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85E50CD98F2
	for <qemu-devel@archiver.kernel.org>; Sun, 21 Jun 2026 12:48:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbHZv-0008MF-D1; Sun, 21 Jun 2026 08:47:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qinzhengxiang@foxmail.com>)
 id 1wbHZm-0008Lo-UT; Sun, 21 Jun 2026 08:47:04 -0400
Received: from out203-205-221-239.mail.qq.com ([203.205.221.239])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qinzhengxiang@foxmail.com>)
 id 1wbHZj-0001jt-WE; Sun, 21 Jun 2026 08:47:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
 s=s201512; t=1782046005;
 bh=hQAsJ+7y36xamJk5U9WYMNrhORFmFFXnHfR7QC7l+vs=;
 h=From:To:Cc:Subject:Date;
 b=RheXp3KNhZ2DpN8PINl5USvP/tTjcio5oMMBOlll3VdtsjZSeAxa2881athc4PZwz
 XExO4cHZ9mQ3P9ncZa7RV8cULv5BGHjpT7V/Lo5n7xHU9Td7vTn7SImiUZ8RfPZ1fr
 XjDnH2LZBRoJfkwBbQ5kzQQUpYCpXNK4pFsAy0DI=
Received: from GavinQin-Ubuntu24.. ([117.147.32.38])
 by newxmesmtplogicsvrszc50-0.qq.com (NewEsmtp) with SMTP
 id B8BB3048; Sun, 21 Jun 2026 20:46:11 +0800
X-QQ-mid: xmsmtpt1782045971tbvqpbib1
Message-ID: <tencent_CA380CBF4A98C990C07BC04A9E748C438309@qq.com>
X-QQ-XMAILINFO: MqswyhUqVe0CQv34ZXQ9fF2UjVvd6sXR5w29X0YAT/hb0zlGs+8ob9Rk9PjQ7Y
 Q9oOs2oGk3dmGNtF8tqqwrOG3Boh2+Qi4bzc9bU05YtNNpxEf38KIjEIRnoRXKQlCIwCfKf+rPWn
 ZzfUx5l5c+lk5vdXmRMWXMdgbHjs8fJYVTCEz1Nj65zbJ+crz5l45eIx1JA3A9aOzQKQFz9vevhd
 GKitxW7hSRaRJyxYVobPM9wQPG25e0m+GAAw6f46uqtqtw4zvLSHJt9aJQzNI8m/emJDAzjOi5BX
 iTCvjgmrQthJRKaFH0Q/Olo++3ZRfK/zsWtocWaNiRpuAwaTh1BD02y2gWnxBnYDiux7Wnb42T/q
 b8whza0KoH3ju3phxb0U7cKg4a22wqjGMNPiUcDyHepF+safL5CvdyF3U4iUNX7bxwitEeHfK1tC
 1+pZtcWZuuR0i8bUF4NFP1SkNhVzA/EY3RHG711GgZt5tLbpPy5ckiyq/ZhfaNbQUq9a7Ju83TCM
 Xk9+1aNgh5WuIawL77Cxan9WGPTraewns4txqWYTOWJjWZRxf/8NeUr4b6FIfWOKVIP3SZ0Z7X+0
 SUrXi1OXZXCRwLeW242dOHU03pp31kRF8tLd642SY0oWLpodPl9pa1PNJAFHQFVMtsaUj1UQn5Zm
 CQMx6vBmVTor3rMvfgsiXDa0kfn/M/S9O3ksMeP/VyIIQm2/mIzqjvyKJRJqrScmTDBIageTnDsQ
 XuiyBkvYSu9rH/TYAAw6UbzFcsBYLxxEgFuP9D0doI0lo24/pTwEB1kGddGPC0YFokpyCh7ThnjQ
 0Q3UmZit3SeV0BBcpZ9yfSoafPT910AcOtyYWQJfmmOFtKXeRhUM/ozoLsKlNgobMhcGcinaRMLH
 nVapAxPNGN+QK+eLajlIEa7OoKjOCTiHoKwsZiPMTMYotWNvf0gldOO+vky/ayCx5Y+Kdm9avTaI
 Ap2DglKMWd+PdWyAnKajW4K/+J/eA2Mt+4NtW0kN63JfiyxecbNkX9QTHOJvK0Le3cErbfLSaeEE
 k3OEuKcN5tEse7oI45qlBYDLPfLqJj/dvL55DOdHKANjJ652Gq+sCv/k00tn3RuWhjMmHnCHGK3V
 oiP1ATe2uitlmHK9a5NuguxOUNmC9/07mhfduNxVDhy33NRqk=
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
From: ZhengXiang Qin <qinzhengxiang@foxmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, ZhengXiang Qin <qinzhengxiang@foxmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Subject: [PATCH v3] target/riscv: raise access fault for Zicbom MMIO-like
 accesses
Date: Sun, 21 Jun 2026 20:46:09 +0800
X-OQ-MSGID: <20260621124609.11754-1-qinzhengxiang@foxmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=203.205.221.239;
 envelope-from=qinzhengxiang@foxmail.com; helo=out203-205-221-239.mail.qq.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HELO_STATIC_HOST=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

check_zicbom_access() currently treats any probe_access_flags() result
other than TLB_INVALID_MASK as a successful access. However, a result
with TLB_MMIO means that the target is MMIO-like and should not be
treated as a normal cache block management target.

Raise a store/AMO access fault for Zicbom accesses to MMIO-like regions
so that cbo.clean, cbo.flush and cbo.inval do not silently succeed on
non-cacheable/MMIO-like memory.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3501
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: ZhengXiang Qin <qinzhengxiang@foxmail.com>
---
Changes since v2:
- Add else before the success path for readability.
- Keep fault_addr as target_ulong since CPURISCVState::badaddr is target_ulong.
- Add Philippe's Reviewed-by tag.

Changes since v1:
- Use a bit test for TLB_MMIO since probe_access_flags() returns a bitmask.
- Keep Reviewed-by tags from v1.

 target/riscv/op_helper.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
index 81873014cb..50fd1b73ea 100644
--- a/target/riscv/op_helper.c
+++ b/target/riscv/op_helper.c
@@ -218,6 +218,7 @@ static void check_zicbom_access(CPURISCVState *env,
     void *phost;
     int ret;
 
+    target_ulong fault_addr = address;
     /* Mask off low-bits to align-down to the cache-block. */
     address &= ~(cbomlen - 1);
 
@@ -235,7 +236,10 @@ static void check_zicbom_access(CPURISCVState *env,
      */
     ret = probe_access_flags(env, address, cbomlen, MMU_DATA_LOAD,
                              mmu_idx, true, &phost, ra);
-    if (ret != TLB_INVALID_MASK) {
+    if (ret & TLB_MMIO) {
+        env->badaddr = fault_addr;
+        riscv_raise_exception(env, RISCV_EXCP_STORE_AMO_ACCESS_FAULT, ra);
+    } else if (ret != TLB_INVALID_MASK) {
         /* Success: readable */
         return;
     }
-- 
2.43.0


