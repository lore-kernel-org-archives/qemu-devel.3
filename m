Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21581CC6B30
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 23:47:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xH8g5-0006yg-NX; Wed, 14 Oct 2026 19:46:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xH8g1-0006x1-AQ
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 19:46:29 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xH8fz-0006Qv-HQ
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 19:46:29 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69EMSUKM1013177
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 23:46:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=69Z1SGee62q
 epmCY5cuxjJ/sTl5Q4vAI9XjyBCU8DBA=; b=g/to7/Eg/ODsAhVzp9t62t3PqcJ
 W/SWy15vJ8MY4up9ZuR97BrbLRcjm0xRyfBZaDP3DzUzoauVuxxwU4dFbRHgK5VD
 rQlHPZ/NjCxM+hTJHqWn2OVA46yp/z4tPaWk7Njy750pSv3xe2hoqb9cSnJp3ts5
 Hj59J4WXCbFAhL+JEU+caidiO1wGXxfUz2Etzbl2WsyGtFwqW8bTObnrC/IOpd5P
 eKyDnKt8Zw2jXHVdbFSo1neqpvSTueWZfuGlVeCImiN3cPSgpj9eOK2uwKR2kqXU
 5+fRNph+1zLS9mb01YobgxkrBPupbzg/8sbvoLjSn7j9w1O7LvZJnCB3haw==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ha80ctuju-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 23:46:26 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-357e2bc3b1bso7483575eec.0
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 16:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792021585; x=1792626385; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=69Z1SGee62qepmCY5cuxjJ/sTl5Q4vAI9XjyBCU8DBA=;
 b=LOa7AaINq8UdEOsrUKynBKNa5hMTjUhhiclPkqtivUdbiDnoRQDBy15vpvJrepMCn2
 GF5AKubxUnTwMwlrNl9tccp2Ugthtbur8QPssi6CO1oDpw6jVZfrMxSu7Yh7RtgVcUnD
 Bh/kc8IcmG8z6QFwC3sfm1TAMVIBIEsVAgS0IItUCW51N3NAqPPhwmox5gWLVscp7Ulc
 /rg/D9jV2J0Zls7RJhXGndf2tEEDLa/zSV9HebSSue/k8EDRJIDAYmZeWvm/OzFBky9G
 JEAjf8WQA3KjHPbRzO48q7mZXcdGfGZ1tKvI80sIq3MO4n2Rjd1hrjSifWsfL0M7/v3N
 SuVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792021585; x=1792626385;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=69Z1SGee62qepmCY5cuxjJ/sTl5Q4vAI9XjyBCU8DBA=;
 b=JPanu0SF/j7sKnKn71BO0o586MkGcKRS8SvxybaEZlDG83+b/MUCby4DT3ymYLjIPa
 nyJkskkzU65zy7FyI7YeaAAKggjjkjbyDBbtOYHRPMA7e0nemFIaU2RAOI22l3HPGN2o
 q5lWesS1+N5tFVR89mxStfX4l9hmOiXSE/gKMWm5EJzDvFxzqyglQ9QsIgUGDtf7tbb2
 jhxrJ3n/iNuloYchHoEtCMLrQKHEethEjbSc5RozG9PbeXp39o/cuCGAkH5NNwc+C5vg
 qHjmLYG5pT8fvhw4Xfm7Z70RQfKItUL0FNo+lVgh/+HFV1i1qSt3xYuuuRO9B3iygJtL
 EQKg==
X-Gm-Message-State: AFq9FYIsizus258fNoTFF5OT6ayqbqrCg3NsL1GBizq8PN6tSNavOXRs
 /IuVOqnCkXsj1X6O9Y16dRtgFETjUDb/VfBXZQtJKa09kPwKe77FaOgdJXHb/TAWA4cQak4C1II
 IlpI+t+ZT8/CQwroQheu3MNCE00zasMeFg8hMLD66ex7txhsoo9kho9u36k/JVO1wvQ==
X-Gm-Gg: AYBFou1UnGMNCpQljduMdyKSGg+4/XkC4NrJO44qy9iWya9RXSwpC8KOqVXuPfLaeTq
 MD+FUohWcUWcfUP86cSxlx4cU4J7ZKSMY8vvBDT+hhXCkjaodYjhVgYyIZPOBQRMbkRhaIX3G5D
 sd3kd2Bbjc+wQ8r99Yjn4C6GSjwoW5+PmSDhQ37+3QaEjFOSIlkhBqfK/nzRMlv2uvYXkaquaHu
 Pq5koSlfj2bMEV4n3UtiXqdKNed45tYhP0BlizNcyUGCdso/tkJYtIL7W757gcKBGY59H80X5XU
 uvAKasTl1mfWpOYz22ELuVRar23lh3nlfTemvhc+C/vC4i9R5KdKkRM7hJFaV/KtmkdOP5100QU
 +uL64W2Vbv6Qaj9BFJsayfJZ2UKxLQOhibajwayJbZPehNYvv64KI6yMZ05sk
X-Received: by 2002:a05:7300:430b:b0:35f:2858:aa4b with SMTP id
 5a478bee46e88-35f2858ab4fmr856980eec.30.1792021585250; 
 Wed, 14 Oct 2026 16:46:25 -0700 (PDT)
X-Received: by 2002:a05:7300:430b:b0:35f:2858:aa4b with SMTP id
 5a478bee46e88-35f2858ab4fmr856948eec.30.1792021584712; 
 Wed, 14 Oct 2026 16:46:24 -0700 (PDT)
Received: from debian.qualcomm.com (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-358de54fe47sm42506147eec.31.2026.10.14.16.46.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 16:46:23 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH 06/19] target/riscv: implement get_dump_info dump op
Date: Wed, 14 Oct 2026 23:45:52 +0000
Message-ID: <20261014234605.209084-7-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261014234605.209084-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261014234605.209084-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA5NCBTYWx0ZWRfX78a43W+se8W1
 3gg6I40vydAYhgSNUnMAicCaWogRSDW6LdBMycR02YYtZ3AdVGEfKoaslkLqfbeg9TjB8X7CF/d
 PRw6YjxFQzsq5l8d03vbRAsJwgLEcpg=
X-Proofpoint-GUID: JzsIn4ltu8Wx9jqJe6dn5aXQ0t2K6LUS
X-Proofpoint-ORIG-GUID: JzsIn4ltu8Wx9jqJe6dn5aXQ0t2K6LUS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA5NCBTYWx0ZWRfXx9uzzU9nN7Ep
 86VKDgzCPfr9L6/19y+k1fc/y6zeS0DOLVBdnkZG0albTp9FSYsGCvk3uZRATcyP8sjx2K3RL8f
 qJOgcZnQtev9SPoi9JdQEYdByjDfCxJf7kd26SYw/4gvO9V+qxWLpvvSZ+8j/QwqTwJykbSoMt4
 9Xqzp1RMBeuTByE9yX9Is3E0RTy54vyexeApt1dbiOppy3sF4A438IVhJWasFmouri6LfdbKsZH
 RtQeJEYCfaxFXXKDFJWc0yPt0pMJVjKqOPb+jHbB4QFHPMJKEOJ+e0prc+8MUnAqedwp46WyAz0
 dZmeyv5XxpXkFjCQbGL1PPholPKxZJhCewyKK33mEXG2JUSlw2MoPDU/dllFexXVyaeCZUhDpmX
 5QcQI+wjtHRL7jMNRL+ekkqWluCMVOk3QrnqTLo4QTsdJaSY90bHKbxL1ghsRez3p3SCp/DyVPw
 j1mR3mGB0iyfZNJidjA==
X-Authority-Analysis: v=2.4 cv=JegpPkKV c=1 sm=1 tr=0 ts=6ad01452 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=KFHBJy6n2imRmvZWk-EA:9 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 phishscore=0 suspectscore=0 priorityscore=1501
 bulkscore=0 lowpriorityscore=0 impostorscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610140094
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

For now, we keep the global cpu_get_dump_info symbol defined.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 target/riscv/arch_dump.c | 30 ++++++++++++++++++++----------
 target/riscv/cpu.c       |  1 +
 target/riscv/internals.h |  1 +
 3 files changed, 22 insertions(+), 10 deletions(-)

diff --git a/target/riscv/arch_dump.c b/target/riscv/arch_dump.c
index 12b68799070..7086d778b8e 100644
--- a/target/riscv/arch_dump.c
+++ b/target/riscv/arch_dump.c
@@ -20,6 +20,8 @@
 #include "cpu.h"
 #include "elf.h"
 #include "system/dump.h"
+#include "internals.h"
+#include "hw/core/dump-cpu-ops.h"
 
 /* struct user_regs_struct from arch/riscv/include/uapi/asm/ptrace.h */
 struct riscv64_user_regs {
@@ -161,17 +163,11 @@ int riscv_cpu_write_elf32_note(WriteCoreDumpFunction f, CPUState *cs,
     return ret;
 }
 
-int cpu_get_dump_info(ArchDumpInfo *info,
-                      const GuestPhysBlockList *guest_phys_blocks)
+static int riscv_get_dump_info(const CPUState *cs, ArchDumpInfo *info,
+                               const GuestPhysBlockList *guest_phys_blocks)
 {
-    RISCVCPU *cpu;
-    CPURISCVState *env;
-
-    if (first_cpu == NULL) {
-        return -1;
-    }
-    cpu = RISCV_CPU(first_cpu);
-    env = &cpu->env;
+    RISCVCPU *cpu = RISCV_CPU(cs);
+    CPURISCVState *env = &cpu->env;
 
     info->d_machine = EM_RISCV;
 
@@ -187,6 +183,20 @@ int cpu_get_dump_info(ArchDumpInfo *info,
     return 0;
 }
 
+const DumpCPUOps riscv_dump_ops = {
+    .get_dump_info = riscv_get_dump_info,
+};
+
+int cpu_get_dump_info(ArchDumpInfo *info,
+                      const GuestPhysBlockList *guest_phys_blocks)
+{
+    if (first_cpu == NULL) {
+        return -1;
+    }
+
+    return riscv_get_dump_info(first_cpu, info, guest_phys_blocks);
+}
+
 ssize_t cpu_get_note_size(int class, int machine, int nr_cpus)
 {
     size_t note_size;
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 63c709ac738..f177a4b0d8f 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -3048,6 +3048,7 @@ static void riscv_cpu_common_class_init(ObjectClass *c, const void *data)
     cc->disas_set_info = riscv_cpu_disas_set_info;
 #ifndef CONFIG_USER_ONLY
     cc->sysemu_ops = &riscv_sysemu_ops;
+    cc->dump_ops = &riscv_dump_ops;
     cc->get_arch_id = riscv_get_arch_id;
 #endif
     cc->gdb_arch_name = riscv_gdb_arch_name;
diff --git a/target/riscv/internals.h b/target/riscv/internals.h
index f17d011d22f..45755b65f86 100644
--- a/target/riscv/internals.h
+++ b/target/riscv/internals.h
@@ -207,6 +207,7 @@ bool riscv_cpu_has_work(CPUState *cs);
 #endif
 
 extern const struct SemihostingCPUOps riscv_semihosting_ops;
+extern const struct DumpCPUOps riscv_dump_ops;
 
 /* Zjpm addr masking routine */
 static inline target_ulong adjust_addr_body(CPURISCVState *env,
-- 
2.43.0


