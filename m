Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40D70CD98F2
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2026 14:07:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waDOG-0005pU-St; Thu, 18 Jun 2026 10:06:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qinzhengxiang@foxmail.com>)
 id 1waDOE-0005nw-Ca; Thu, 18 Jun 2026 10:06:42 -0400
Received: from xmbghk7.mail.qq.com ([43.163.128.47])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qinzhengxiang@foxmail.com>)
 id 1waDOB-0004KX-4H; Thu, 18 Jun 2026 10:06:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
 s=s201512; t=1781791582;
 bh=JVwQUZinZjhp8BJ6JVx8fGyoS4ci/hRDRuReT8ctdss=;
 h=From:To:Cc:Subject:Date;
 b=vLfXG2alwf3zi6mnDv6gaJVIB/v7i4i9S0sB8ERPkLQtXhbHIc+BSDW1hW3Y63CXi
 jGaaJKC8Q3/4PI/ynY87K7uhyprZuVy2FfhT7WGdfqa9KKEh21XXDJjpd9AoZ4Rv+4
 ZQMNpgUJdWuHv38yTS8i9WilXwd8WWFxBMskBAtw=
Received: from GavinQin-Ubuntu24.. ([117.147.33.130])
 by newxmesmtplogicsvrszc50-0.qq.com (NewEsmtp) with SMTP
 id 186A4AD4; Thu, 18 Jun 2026 22:06:06 +0800
X-QQ-mid: xmsmtpt1781791566thyya5bpr
Message-ID: <tencent_4EF8937D817B836D3D911B9B05491B02950A@qq.com>
X-QQ-XMAILINFO: MDbayGdXPuoeOCGC2TVNtocRIU6n6T505sQSqkuNaS4gSlqXP9ksziwfRU/pJo
 5hTbnansmMzF35wOkf5VHV3VUB30dYAsuLrY1BfAzRS7U9cUTHM3EidgwbZXA6abtkoA+emeZFof
 9SBEc8wZXAJzdMAiK8dyNmYeiAkjj1UcFot2xuQU7v5knoOkDLXGZRxpXxPs89DoWh6zUgF7E7la
 eNPl/GhcFbF3ZSCe6rkv+gwzxutvdC1RXMBpPGbg8eUlhgseSEwOC0nC8/58RsGXRqDlIbpmmTJj
 FcRwpVB8Iub4s/Jg41RtV/LXS946uyFbaIHxnXHZ2NLpirHHFvobdkATeJGtasGqL7m5VAOgf/eS
 rteH0+MLxBhrTYuex4hUcA2jLvyIm0uaYGnXd6E4vYlWDTAN6ToDTtyU/q3daUZKSE5w+n83YKZi
 3WZcbpd1NqAH+GLgVI+UfiUPMJjt7bF5iUelXyxcEfVgUBTDD9oMQqbuSM2cF5DudrNbOksYP2pF
 L+CtgQrEmCppd/FxvjWYwBEzjbWqSxkOpiX3D0gHbOfBEvNEWNE0nNBJ85+YnC/XPFcyaB5i9l69
 A1Fy8p9zNsA2tgK39mkrgqQBnaNYa9PGPlAsG0AgHllQRLUzgLnlAgcOAHiGAafRrjMATfl8sTU9
 KZLoRZ4kITnx1qQgKMDHp077kvNMvm0ofCnU60fS4AIg1b3D0W2a3phOF9qnfqjSyPY3qYgcB2N9
 JHZL6lERkmsG4g4kG/fNeW7dBHsi7vA9VrXp7YHydlBoICJw9Lr4Ah89NKTv3xaBMasPm4lZKiQn
 g4Nz72RxNfC4OcLIGwyDVLE9HakZm2gBfPyO2F4cSszkVpBnBb1xweFIdVTX1YLu54RkU9a0cWAf
 PkUk1h+KBBsG10PqR19xecIJ+IZmc/HW9oQJ17MTjVXbfHhOvv2HJGKRXe92GePZAiGy6RvPwxBF
 eiQfUajIhkCvhcavZHQqm9RtS7FYGEC0cs2xPAdKSMTNb8dVQjE2JvwAtwfb9RAq4Kag2y47MCVN
 r9EHC0Juc0WHQdVza6Yg7FU8sD1khOyZ+cnOFzhxWI82EED89jeds8tI91bGtdq6U0pp15TuwhTz
 OWl9DBRR/46sV/rC6I2QZSYKmR7NqARcAsmUEN
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
From: ZhengXiang Qin <qinzhengxiang@foxmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, ZhengXiang Qin <qinzhengxiang@foxmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Subject: [PATCH v2] target/riscv: raise access fault for Zicbom MMIO-like
 accesses
Date: Thu, 18 Jun 2026 22:06:04 +0800
X-OQ-MSGID: <20260618140604.12093-1-qinzhengxiang@foxmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=43.163.128.47;
 envelope-from=qinzhengxiang@foxmail.com; helo=xmbghk7.mail.qq.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Signed-off-by: ZhengXiang Qin <qinzhengxiang@foxmail.com>
---
Changes since v1:
- Use a bit test for TLB_MMIO since probe_access_flags() returns a bitmask.
- Keep Reviewed-by tags from v1.

 target/riscv/op_helper.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
index 81873014cb..f23b060585 100644
--- a/target/riscv/op_helper.c
+++ b/target/riscv/op_helper.c
@@ -218,6 +218,7 @@ static void check_zicbom_access(CPURISCVState *env,
     void *phost;
     int ret;
 
+    target_ulong fault_addr = address;
     /* Mask off low-bits to align-down to the cache-block. */
     address &= ~(cbomlen - 1);
 
@@ -235,6 +236,10 @@ static void check_zicbom_access(CPURISCVState *env,
      */
     ret = probe_access_flags(env, address, cbomlen, MMU_DATA_LOAD,
                              mmu_idx, true, &phost, ra);
+    if (ret & TLB_MMIO) {
+        env->badaddr = fault_addr;
+        riscv_raise_exception(env, RISCV_EXCP_STORE_AMO_ACCESS_FAULT, ra);
+    }
     if (ret != TLB_INVALID_MASK) {
         /* Success: readable */
         return;
-- 
2.43.0


