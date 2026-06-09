Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F5D1CD6E79
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 09:56:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWtCD-0002BB-PO; Tue, 09 Jun 2026 05:56:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1wWtCC-00024w-5b
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 05:56:32 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1wWtCA-0005ex-1K
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 05:56:31 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8Cx3enu4idqizUSAA--.48339S3;
 Tue, 09 Jun 2026 17:54:54 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by front1 (Coremail) with SMTP id qMiowJDxSMHg4idqJrGgAA--.28412S14;
 Tue, 09 Jun 2026 17:54:54 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: Bibo Mao <maobibo@loongson.cn>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>
Subject: [PULL 12/14] target/loongarch: Add wrapper function get_csr_offset()
Date: Tue,  9 Jun 2026 17:28:22 +0800
Message-Id: <20260609092824.227250-13-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20260609092824.227250-1-gaosong@loongson.cn>
References: <20260609092824.227250-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJDxSMHg4idqJrGgAA--.28412S14
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

From: Bibo Mao <maobibo@loongson.cn>

Add wrapper function get_csr_offset(), it is to get offset from structure
CPULoongArchState. There is no function change, and it is used for future
LVZ feature.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
Reviewed-by: Philippe Mathieu-Daudé <philmd@mailo.com>
Tested-by: Song Gao <gaosong@loongson.cn>
Message-ID: <20260605083904.175636-1-maobibo@loongson.cn>
Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 target/loongarch/cpu.c                           |  4 ++--
 target/loongarch/csr.h                           |  4 ++++
 .../tcg/insn_trans/trans_privileged.c.inc        | 16 +++++++++++-----
 3 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index 8424f185f2..a8e51d977c 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -761,7 +761,7 @@ static void loongarch_cpu_dump_csr(CPUState *cs, FILE *f)
 {
 #ifndef CONFIG_USER_ONLY
     CPULoongArchState *env = cpu_env(cs);
-    CSRInfo *csr_info;
+    const CSRInfo *csr_info;
     int64_t *addr;
     int i, j, len, col = 0;
 
@@ -783,7 +783,7 @@ static void loongarch_cpu_dump_csr(CPUState *cs, FILE *f)
             qemu_fprintf(f, " CSR%03d:", col);
         }
 
-        addr = (void *)env + csr_info->offset;
+        addr = (void *)env + get_csr_offset(csr_info, 0);
         qemu_fprintf(f, " %s ", csr_info->name);
         len = strlen(csr_info->name);
         for (; len < 6; len++) {
diff --git a/target/loongarch/csr.h b/target/loongarch/csr.h
index 508a3214fc..ca988c21db 100644
--- a/target/loongarch/csr.h
+++ b/target/loongarch/csr.h
@@ -27,4 +27,8 @@ typedef struct {
 
 CSRInfo *get_csr(unsigned int csr_num);
 bool set_csr_flag(unsigned int csr_num, int flag);
+static inline unsigned int get_csr_offset(const CSRInfo *csr, int vm_level)
+{
+    return csr->offset;
+}
 #endif /* TARGET_LOONGARCH_CSR_H */
diff --git a/target/loongarch/tcg/insn_trans/trans_privileged.c.inc b/target/loongarch/tcg/insn_trans/trans_privileged.c.inc
index 2094d182ac..6728ce5ec9 100644
--- a/target/loongarch/tcg/insn_trans/trans_privileged.c.inc
+++ b/target/loongarch/tcg/insn_trans/trans_privileged.c.inc
@@ -106,6 +106,7 @@ static bool trans_csrrd(DisasContext *ctx, arg_csrrd *a)
     TCGv dest;
     const CSRInfo *csr;
     GenCSRRead readfn;
+    tcg_target_long offset;
 
     if (check_plv(ctx)) {
         return false;
@@ -121,7 +122,8 @@ static bool trans_csrrd(DisasContext *ctx, arg_csrrd *a)
         if (readfn) {
             readfn(dest, tcg_env);
         } else {
-            tcg_gen_ld_tl(dest, tcg_env, csr->offset);
+            offset = get_csr_offset(csr, 0);
+            tcg_gen_ld_tl(dest, tcg_env, offset);
         }
     }
     gen_set_gpr(a->rd, dest, EXT_NONE);
@@ -133,6 +135,7 @@ static bool trans_csrwr(DisasContext *ctx, arg_csrwr *a)
     TCGv dest, src1;
     const CSRInfo *csr;
     GenCSRWrite writefn;
+    tcg_target_long offset;
 
     if (check_plv(ctx)) {
         return false;
@@ -154,8 +157,9 @@ static bool trans_csrwr(DisasContext *ctx, arg_csrwr *a)
         writefn(dest, tcg_env, src1);
     } else {
         dest = tcg_temp_new();
-        tcg_gen_ld_tl(dest, tcg_env, csr->offset);
-        tcg_gen_st_tl(src1, tcg_env, csr->offset);
+        offset = get_csr_offset(csr, 0);
+        tcg_gen_ld_tl(dest, tcg_env, offset);
+        tcg_gen_st_tl(src1, tcg_env, offset);
     }
     gen_set_gpr(a->rd, dest, EXT_NONE);
     return true;
@@ -166,6 +170,7 @@ static bool trans_csrxchg(DisasContext *ctx, arg_csrxchg *a)
     TCGv src1, mask, oldv, newv, temp;
     const CSRInfo *csr;
     GenCSRWrite writefn;
+    tcg_target_long offset;
 
     if (check_plv(ctx)) {
         return false;
@@ -191,7 +196,8 @@ static bool trans_csrxchg(DisasContext *ctx, arg_csrxchg *a)
     newv = tcg_temp_new();
     temp = tcg_temp_new();
 
-    tcg_gen_ld_tl(oldv, tcg_env, csr->offset);
+    offset = get_csr_offset(csr, 0);
+    tcg_gen_ld_tl(oldv, tcg_env, offset);
     tcg_gen_and_tl(newv, src1, mask);
     tcg_gen_andc_tl(temp, oldv, mask);
     tcg_gen_or_tl(newv, newv, temp);
@@ -200,7 +206,7 @@ static bool trans_csrxchg(DisasContext *ctx, arg_csrxchg *a)
     if (writefn) {
         writefn(oldv, tcg_env, newv);
     } else {
-        tcg_gen_st_tl(newv, tcg_env, csr->offset);
+        tcg_gen_st_tl(newv, tcg_env, offset);
     }
     gen_set_gpr(a->rd, oldv, EXT_NONE);
     return true;
-- 
2.54.0


