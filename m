Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E843BCD98C5
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2026 15:11:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZ8xs-0006s4-RH; Mon, 15 Jun 2026 11:11:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qinzhengxiang@foxmail.com>)
 id 1wZ7UH-0001CD-SL; Mon, 15 Jun 2026 09:36:26 -0400
Received: from xmbghk7.mail.qq.com ([43.163.128.43])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qinzhengxiang@foxmail.com>)
 id 1wZ7UF-0007SS-4P; Mon, 15 Jun 2026 09:36:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
 s=s201512; t=1781530569;
 bh=UjrlcJ6xMBvotNpSR8HB+emJXxSAUYxksdCOkudHz7s=;
 h=From:To:Cc:Subject:Date;
 b=SJwYXEyMx31LI/Ae42jpzzaoCZdwfRttro799BEHdOUPGMZvPZ0wrvUybKX2tlUPC
 0VCK7Wx54yKhGTIb0xscxi79kCQAJvumhJGlIyRqYROKSry3rHqaUcHe1xkh2P58s1
 HEVhK4d6ecSLtizUzFM1mLCsov9bGE0bChZ8rqNs=
Received: from GavinQin-Ubuntu24.. ([117.147.33.130])
 by newxmesmtplogicsvrsza63-0.qq.com (NewEsmtp) with SMTP
 id 62418AF6; Mon, 15 Jun 2026 21:24:36 +0800
X-QQ-mid: xmsmtpt1781529876t9amj5m01
Message-ID: <tencent_FB929239B227F05F30D62745E38BA01D4307@qq.com>
X-QQ-XMAILINFO: MtaEuttEGLYb+a5md2IZs35F6dn3uy9ngEOP+SrjV5AvfmU5MvuW5ynTldkoFa
 fMSvwS8OdrrmcFOn4VyKcOYjokTZYWsaKEIfl6qJM1wWvW8i58TLlckhvMlP7IGEaKlu1ydEKqHg
 4DxM0WSdBx1Rx+41MEcshMC440yShalwDeEVtuT3DuoDGYryJGuaX6791UdQccCn2CQzFkiotkKm
 lHrPvLrcFFSaLUL2mbDkduFhjapjKun3mqxvNV3Mm1iuaHmoAcXB6af09dxpKPyW2C6S8oTWeou8
 3iHc9qZ+GmCOa6lV+I84Ts44JzJsXn+HBdHnH5qAkp/V/p0u3R1iqChkBNVixPGEAX+rtITbJk6k
 ddaZfma2+Cf9tQ+ld31OflYPYCjrV+p8nveGE0vGPJM248avZ9ao3ZKbIeoXMUtPBkC88e0kqnTu
 PJ724crLNjvq4S/yUaKiTFV/6zu27qoyNsYute4S+GXj4d/RMzk5NX5KvhbYLqtbCVu0Ed52aKtp
 l4s6kGFyJrMEEB2D47wiEerm6N55jAM9moKdT54QRfZqfAaHCTK0rIpLFoGPfta6vtH8N3j5Rs9y
 6U2R57BAgBedAEGEQrTy54uXbsdRhvUAeBQPMz/G8/LAPrkCa+PrUV0fom0SfLtIxhhBw0NIOj50
 JoeJl/lXLqmmBLnhofFkA7pDLJ0sIp+ACcrfy/3L16KB5Aitcc051ZIPdCvIKRV9d6IKAylPRnjl
 /Mfyzfm5BfXfjuIzkWfdBjtpm3XNJNWIjNpgNl5IKcghWbbeazY5ZQVcAWytgFK2HFte70WYv6fW
 S+IKlxORNP+N/IxG1lzWxC22sXtuJWsazCjzbdDAW/j4nBAbB3uDuTU6Yie7PYy3WB9HYV4JqZp2
 7X6GuW8MvZO+1nA8f0xAS3k4o8rjWsup7i10cdz41ISeEuta0mJ9MRfXJGLJpt7Y8GHL29A1k1+d
 B8+byz6WmJA/3P8Ay4hLb6scZS6pKq8uM1qbfxZKgoh0BgqBcxPeUE0yg43muhC7vUYExBg2aKn7
 kmRb0CkEfvq2r6mVXdlINe7RUnlqIXkySXnSBf3UvKb6iVVPc5Jz1VEMULzNkuSykUT2B1qeKEN7
 C10J7XMz4ltazurYP4okR/b862b0OKMWmIU5mz2A5oUGMohxct2Q+HK1m3TW1c3N4+5/Q4r3u/M7
 9EQVGVF5LRWg8WH7umpCHuiecKXdT8SpxFsHxLbHg+ke4w1Q==
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
From: ZhengXiang Qin <qinzhengxiang@foxmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 liwei1518@gmail.com, daniel.barboza@oss.qualcomm.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 ZhengXiang Qin <qinzhengxiang@foxmail.com>
Subject: [PATCH] target/riscv: avoid abort when reading vtype before env->xl
 is set
Date: Mon, 15 Jun 2026 21:24:33 +0800
X-OQ-MSGID: <20260615132434.10623-1-qinzhengxiang@foxmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=43.163.128.43;
 envelope-from=qinzhengxiang@foxmail.com; helo=xmbghk7.mail.qq.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 15 Jun 2026 11:10:58 -0400
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

TCG plugins may read registers from the vcpu_init_cb() callback.  For
vtype, this reaches read_vtype() before env->xl has been initialized.

In that case read_vtype() currently hits g_assert_not_reached() because
env->xl is zero.  Fall back to the CPU's maximum XLEN only for this
early-init case.

Fixes: 638181a180bd ("core/cpu-common: initialise plugin state before thread creation")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3545
Signed-off-by: ZhengXiang Qin <qinzhengxiang@foxmail.com>
---
 target/riscv/csr.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 5514e0f455..6ade7ccb0b 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -936,7 +936,16 @@ static RISCVException read_vtype(CPURISCVState *env, int csrno,
                                  target_ulong *val)
 {
     uint64_t vill;
-    switch (env->xl) {
+    int xl = env->xl;
+    /*
+     * TCG plugins can read registers before env->xl is initialized.
+     * Fall back to the CPU's maximum XLEN in that early-init case.
+     */
+    if (xl == 0) {
+        xl = riscv_cpu_mxl(env);
+    }
+
+    switch (xl) {
     case MXL_RV32:
         vill = (uint32_t)env->vill << 31;
         break;
-- 
2.43.0


