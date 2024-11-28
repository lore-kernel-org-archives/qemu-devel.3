Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3AA7D690E2
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2024 07:28:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGYve-0003CL-7j; Thu, 28 Nov 2024 02:27:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yfliu2008@qq.com>)
 id 1tGYvX-0003BQ-27; Thu, 28 Nov 2024 02:27:04 -0500
Received: from out162-62-57-210.mail.qq.com ([162.62.57.210])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yfliu2008@qq.com>)
 id 1tGYvL-0006Ms-PO; Thu, 28 Nov 2024 02:26:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1732778798; bh=Sz6/n21em2mOQ+wrKO+rxDoqrWHY7+lJTRf0i7BsglY=;
 h=From:To:Cc:Subject:Date;
 b=D6CDNyI9o+O9YzOpk83XnOeOrmIMGkPPFWusRbF1UT6Ov/zt/34bG3PqKxFnxhfnK
 g4gnJlTjUxENg0J+bfZkn27zdVQlqlPLb4mqIu65BDKfM4hbYXJ9PnY7P/mdD1CyfE
 P1ta3llC+MRKhfRwxhLSHJzdDIUC1nQZKB2rtpzo=
Received: from qq.com ([61.139.23.214])
 by newxmesmtplogicsvrszb21-0.qq.com (NewEsmtp) with SMTP
 id 55D8A671; Thu, 28 Nov 2024 15:21:29 +0800
X-QQ-mid: xmsmtpt1732778489t2o1igzzk
Message-ID: <tencent_B52B1EB0A504D6F690B6E6F3FD3AC9BCDC09@qq.com>
X-QQ-XMAILINFO: MyIXMys/8kCtONX4BHXX+F9csqGMb/bilzJ9iKYVWZeOdep80M2VxqxgMJtdTu
 g8l9IHRfAl7YwFgo/ghM/CFuH3VXj3aePnz4JYZfBKss4wLBeubBoyn4T5Y7knIGtInibVYz+lwc
 bQEmv0hv0FAjfipKE1ZLw6jDPYnVzqMBCLb9tTAkKzwWDmTydTGGuEhPpy6Zxdun/fLkiIKI1bM0
 gLCelErVTuyBe+Hp0ZP8pRJ2ub9q+RosRn21ETLj27jdRY147yl+5Telqe4E/3NOqlaynNqtXAM2
 7vp/+7lWYzOM4csHDPM5RTXgXc+bUwjoeZD6gDQMsjLt5KHK52yKyDvD6YBF8Sa8PylCJG7whq1a
 zibXQ2K0LjyQiTAyyxdhU7wUu8hCAXlheuxlKBX8gM73iz4WiIiBbhtXyxMmAI9r9wnvGjp/6RxZ
 CTA4VCSVaPDvVfJG4EixDSBuTC9aX1gUniKLKyky2MH9lHBRV2aD+UqSPJf9cgW5MEnR/bCGvH3X
 cWZMXi5u0LtxfKKlHkRjNM96050YxznQ30UoE5Jnn4xuzgpel3Oiwms0TEKwHIViD4AA4bvSI3NC
 xEw7l2LskI2YB+AnlRL/BtDi0V/mENbDQDmKNfSklyi6Muel3Mk6u512uaS8GnyEQNzi2p4+tfiZ
 12A4epxTI2znGSDVEx0+h3l32TThQnRJPqTnCfamZIufIwfnetW2QP8jKl5x57boBT739FlbabY7
 mi3a2djplC7vrGOfdYrW1gsOji/tBLCsZAczLKgNGCvk4g5v1wq2veP8R9CchBD2cJeVtUsl1d90
 Adop498P3MwPRzm33ZF2g68XI5Ss6CtVAX50QWYfEgHT4bR8zwTX/EWeJbTZRkk4fnRxz9KWNgDK
 HLTktaBY7z93kWB3a6nqR4i8Jj4ZxssOjYJvjeEsRplFsgqePSjZiGPDXU21kWQd6tVePo9tuG3U
 aYWjsLJBWFp0ZPQ1nZYP3bnuRhBFTK
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
From: Yanfeng Liu <yfliu2008@qq.com>
To: qemu-riscv@nongnu.org
Cc: qemu-devel@nongnu.org, alistair.francis@wdc.com,
 Yanfeng Liu <yfliu2008@qq.com>
Subject: [PATCH v2] riscv/gdb: add virt mode debug interface
Date: Thu, 28 Nov 2024 15:21:27 +0800
X-OQ-MSGID: <20241128072127.17246-1-yfliu2008@qq.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=162.62.57.210; envelope-from=yfliu2008@qq.com;
 helo=out162-62-57-210.mail.qq.com
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

This adds `virt` virtual register on debug interface so that users
can access current virtualization mode for debugging purposes.

Signed-off-by: Yanfeng Liu <yfliu2008@qq.com>
---
 gdb-xml/riscv-32bit-virtual.xml |  1 +
 gdb-xml/riscv-64bit-virtual.xml |  1 +
 target/riscv/gdbstub.c          | 18 ++++++++++++------
 3 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/gdb-xml/riscv-32bit-virtual.xml b/gdb-xml/riscv-32bit-virtual.xml
index 905f1c555d..d44b6ca2dc 100644
--- a/gdb-xml/riscv-32bit-virtual.xml
+++ b/gdb-xml/riscv-32bit-virtual.xml
@@ -8,4 +8,5 @@
 <!DOCTYPE feature SYSTEM "gdb-target.dtd">
 <feature name="org.gnu.gdb.riscv.virtual">
   <reg name="priv" bitsize="32"/>
+  <reg name="virt" bitsize="32"/>
 </feature>
diff --git a/gdb-xml/riscv-64bit-virtual.xml b/gdb-xml/riscv-64bit-virtual.xml
index 62d86c237b..7c9b63d5b6 100644
--- a/gdb-xml/riscv-64bit-virtual.xml
+++ b/gdb-xml/riscv-64bit-virtual.xml
@@ -8,4 +8,5 @@
 <!DOCTYPE feature SYSTEM "gdb-target.dtd">
 <feature name="org.gnu.gdb.riscv.virtual">
   <reg name="priv" bitsize="64"/>
+  <reg name="virt" bitsize="64"/>
 </feature>
diff --git a/target/riscv/gdbstub.c b/target/riscv/gdbstub.c
index c07df972f1..7399003e04 100644
--- a/target/riscv/gdbstub.c
+++ b/target/riscv/gdbstub.c
@@ -206,14 +206,14 @@ static int riscv_gdb_set_csr(CPUState *cs, uint8_t *mem_buf, int n)
 
 static int riscv_gdb_get_virtual(CPUState *cs, GByteArray *buf, int n)
 {
-    if (n == 0) {
+    if (n >= 0 && n <= 1) {
 #ifdef CONFIG_USER_ONLY
         return gdb_get_regl(buf, 0);
 #else
         RISCVCPU *cpu = RISCV_CPU(cs);
         CPURISCVState *env = &cpu->env;
 
-        return gdb_get_regl(buf, env->priv);
+        return gdb_get_regl(buf, n ? env->virt_enabled : env->priv);
 #endif
     }
     return 0;
@@ -221,14 +221,20 @@ static int riscv_gdb_get_virtual(CPUState *cs, GByteArray *buf, int n)
 
 static int riscv_gdb_set_virtual(CPUState *cs, uint8_t *mem_buf, int n)
 {
-    if (n == 0) {
+    if (n >= 0 && n <= 1) {
 #ifndef CONFIG_USER_ONLY
         RISCVCPU *cpu = RISCV_CPU(cs);
         CPURISCVState *env = &cpu->env;
 
-        env->priv = ldtul_p(mem_buf) & 0x3;
-        if (env->priv == PRV_RESERVED) {
-            env->priv = PRV_S;
+        if (n == 0) {
+            env->priv = ldtul_p(mem_buf) & 0x3;
+            if (env->priv == PRV_RESERVED) {
+                env->priv = PRV_S;
+            }
+        } else {
+            if (env->priv != PRV_M) {
+                env->virt_enabled = ldtul_p(mem_buf) & 0x1;
+            }
         }
 #endif
         return sizeof(target_ulong);
-- 
2.34.1


