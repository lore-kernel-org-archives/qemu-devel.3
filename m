Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 051D0CC6B30
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 23:47:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xH8g6-0006zZ-LP; Wed, 14 Oct 2026 19:46:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xH8g4-0006yP-H3
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 19:46:32 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xH8g1-0006RM-UG
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 19:46:31 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69EHQUJd840950
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 23:46:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=ndCxC9WMZDF
 ybX0JEOxU5gO0DC9kIH8dmfkT+wBA7k0=; b=Z/Dl1IFyZTi2kAyO/HiSUg2JH+M
 KPth9ez94V3orB6NHeweliG2t0NiU1m3f9LWfIuNaWBsze+1NBT6MvJbGVBX7lFl
 4xYuZIxW+kxvq8frDOiI5o0+HbsHA4f1VKHi8XwpTMSo1sMYKnM4UtHdjqSZkRRG
 rrgmBRDjLYJ5KeRbtgm3OfORaBGO9sx9giFo+KYv62hhdzXQmCYSKaTC+WJD90S/
 Eo4r1+GRI3+GYuvbDt7ZVWHaTd6rEJ7uhctYJBP8AFDWLkwT8C3j2/952lNeBIrz
 X2OR1fDuhYEn4iyqQV3F1QCKnYCchhDS+JpWz3F5CBOA3USJgfPfWSxBLOQ==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hae4ws6nm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 23:46:29 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-30c0d568830so9544856eec.1
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 16:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792021588; x=1792626388; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ndCxC9WMZDFybX0JEOxU5gO0DC9kIH8dmfkT+wBA7k0=;
 b=gMs/vopgrUHABnSifeX7VVD0tv50+zwkrAkN9ndcYPrYdAgivIcdEij261kFSgEke7
 WvuwQTvvEnOWxCBYRAXPHAwKMaMbb/BTjQk+gTCWYuGhcq6D4CwtKuPZj2vTEAwPA0OR
 UJD1T3SlISi0qXVhL8+vIRzoaeVEgRBF2zAkFcXMJoKLTgYgaeQwinwBHogB7NGEw1q7
 f3kY780CIKBhr1TiI7bzMDXWniGL6gGGPu9fEqG6jCesxb6bDKRoDySQE2DHdnx3VpU7
 fM8Sd35dLgvOTkFqgDvvT5LeQAu3ZNdINDw7KcANV6WVWNq1F5PKB4BIlOzPOkQ2e2xI
 Gqwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792021588; x=1792626388;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ndCxC9WMZDFybX0JEOxU5gO0DC9kIH8dmfkT+wBA7k0=;
 b=buKTZmgYoDY+kiebVVAsbvTs5rD2nEDga6o/q4oYxwgjlTsgjeoCmLYTMRH8wDu+c3
 0apHwZjbYDanDWnJ/vCcRz4bTPtxLROwnGAJzcpSRdLt0/QOUdCqH6CJTwqBW1j4i2ej
 +rKKnWf/c0O4oTY72dXOV1dkvkEMM605ExEpKjeM8wgz0Argg6AHZeHoZwntPtRLG93W
 ZOmgQgFGJk66fT9IEIHMwTcWZLFJkshaZ/dhguIK2bXuWB33T4m5aZY8Qu2l947rQF3+
 tz9hbAnJmaVcxjNzE+IaPj6OOrCW92hKsfg334F96sX/jpyIddPDxtwLocx9v62r/1gK
 HNDg==
X-Gm-Message-State: AFq9FYLjjoUAq5pQjGpqxDsAsWEXD1xmbXFm1LjdqwOR3MSIF0j7uIfk
 3fYqJ5E3zt1zLz/62ImO7mQAKmt2eFrsgLCrZFU97tR/kIJ5ScYHUzVDEmm1HR36bTtBsFq9V1t
 XPgpbSUUup1ct/KS8Y/HRpLUYEKYgPFFVAVPciRLa/Rp4ItO+5qxqmeyfUsQ4qwi7gw==
X-Gm-Gg: AYBFou0bZRqtHbwWOVhDZNxMjNjzhiUtVd+h1Z/TCWTbQU9rhc6m4VYjRwA04yYudYg
 FECM9xA+zrA62a2gCo+OatfSFfio5CYn1co0Wiw6TqCZyY/tScrJ5yTcPKbeqZ/7rzTyEA/mm+o
 bEoA0VIwcaKvSTB4N9fF8cghRC/J9uMIa5GxJ0vpXIEQPzOjVdsyXdgnIQx3vqcyD0gKVxGkn9U
 sdxbRniuEUhd2CZuP7VzNbQLnLb8GRB15mAZCvNpc7+LPFnbesScqh8VVAPY4FD+Ca3Bz1Jlo0F
 4rYGzHT2lrrrxT+1mvZwR88PC8W++S7TWTTMEuqaesf5IP4LgpPxv+YB2rNSuliu1q3eF3LAdfb
 XvC2vSgewKUt+kndG8Xyg54KzVI3v8MlkJnX0BrfpZ/IgWz1rUZDWbHLLZ4G1
X-Received: by 2002:a05:7301:f24:b0:351:595:750b with SMTP id
 5a478bee46e88-3537e2964f7mr25453499eec.36.1792021587833; 
 Wed, 14 Oct 2026 16:46:27 -0700 (PDT)
X-Received: by 2002:a05:7301:f24:b0:351:595:750b with SMTP id
 5a478bee46e88-3537e2964f7mr25453479eec.36.1792021587267; 
 Wed, 14 Oct 2026 16:46:27 -0700 (PDT)
Received: from debian.qualcomm.com (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-358de54fe47sm42506147eec.31.2026.10.14.16.46.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 16:46:26 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH 08/19] target/loongarch: implement get_dump_info dump op
Date: Wed, 14 Oct 2026 23:45:54 +0000
Message-ID: <20261014234605.209084-9-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261014234605.209084-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261014234605.209084-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA5NCBTYWx0ZWRfXwzqfg0rjRrNT
 pC6EgaYETAvCOnsuKLt3ZaEMr6b+7qeJ+0RV3pvAqwy5RQ8oeW6+WMFEDbH6Ceu0BSbN1a/cNZL
 LlG9gdin8McKCEvYhQzzoiG53DWpf9o=
X-Proofpoint-ORIG-GUID: R-esBWkghMTDgFbwhutKFqEa_4fnIZCu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA5NCBTYWx0ZWRfX7MRlkweJvxbR
 tE3UTDRq+Z8WShNIYtAOQX9Otbs3Y1T+6pd5rjsUCHT6HYpOZFRLJUno/+VIhn6BDkSKNKD3ToC
 KjRP1LZ7ogRyHXDEzqu7PpmYvTGv+auAMVAvbUIXBI//2oGbYKwlGxhrI1XLj+OFSyeY9RQZoEh
 Wa8vIKiU0U6c24QaxRNfYI9aYaoIfEHNd4AQp091GXGHgmlh35999/WxUdM2+TvzpzmYu9ybezN
 eHiKBowi+8qpuIToqT3lTVjHtdnWlp/F0F3QruNpeyBIqe8FNkFCoMnJjgeBvwzpoirM9uibV6Q
 LYsJx+yExAAbbLTdXwHaonYOQ1fAeo3HRzPDsVSfVajLCCcQPqDAx2NsVW9XS1V7bhSSys5gSuI
 38fL/3nsSODgxfr+HLn4mu+KI/Ga2Ig3SGSFwlogHfBifB/PL4cOROeClN83t3QmKQqDPBwr7ZW
 9b0wvwOEmorJBfKIiUQ==
X-Authority-Analysis: v=2.4 cv=E8BYNqdl c=1 sm=1 tr=0 ts=6ad01455 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=LSoX5LRO13wWvFjk7bEA:9 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-GUID: R-esBWkghMTDgFbwhutKFqEa_4fnIZCu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 suspectscore=0 malwarescore=0 spamscore=0
 bulkscore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0
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
 target/loongarch/arch_dump.c | 15 +++++++++++++--
 target/loongarch/cpu.c       |  1 +
 target/loongarch/internals.h |  2 ++
 3 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/target/loongarch/arch_dump.c b/target/loongarch/arch_dump.c
index 9d84faef969..83829a96875 100644
--- a/target/loongarch/arch_dump.c
+++ b/target/loongarch/arch_dump.c
@@ -22,6 +22,7 @@
 #include "elf.h"
 #include "system/dump.h"
 #include "internals.h"
+#include "hw/core/dump-cpu-ops.h"
 
 /* struct user_pt_regs from arch/loongarch/include/uapi/asm/ptrace.h */
 struct loongarch_user_regs {
@@ -142,8 +143,8 @@ int loongarch_cpu_write_elf64_note(WriteCoreDumpFunction f, CPUState *cs,
     return ret;
 }
 
-int cpu_get_dump_info(ArchDumpInfo *info,
-                      const GuestPhysBlockList *guest_phys_blocks)
+static int loongarch_get_dump_info(const CPUState *cs, ArchDumpInfo *info,
+                                   const GuestPhysBlockList *guest_phys_blocks)
 {
     info->d_machine = EM_LOONGARCH;
     info->d_endian = ELFDATA2LSB;
@@ -152,6 +153,16 @@ int cpu_get_dump_info(ArchDumpInfo *info,
     return 0;
 }
 
+const DumpCPUOps loongarch_dump_ops = {
+    .get_dump_info = loongarch_get_dump_info,
+};
+
+int cpu_get_dump_info(ArchDumpInfo *info,
+                      const GuestPhysBlockList *guest_phys_blocks)
+{
+    return loongarch_get_dump_info(first_cpu, info, guest_phys_blocks);
+}
+
 ssize_t cpu_get_note_size(int class, int machine, int nr_cpus)
 {
     size_t note_size = 0;
diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index 54c26998979..99b5ab59e00 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -882,6 +882,7 @@ static void loongarch_cpu_class_init(ObjectClass *c, const void *data)
     cc->get_arch_id = loongarch_cpu_get_arch_id;
     dc->vmsd = &vmstate_loongarch_cpu;
     cc->sysemu_ops = &loongarch_sysemu_ops;
+    cc->dump_ops = &loongarch_dump_ops;
 #endif
     cc->disas_set_info = loongarch_cpu_disas_set_info;
     cc->gdb_read_register = loongarch_cpu_gdb_read_register;
diff --git a/target/loongarch/internals.h b/target/loongarch/internals.h
index ff956823fd7..fac3ccd2afb 100644
--- a/target/loongarch/internals.h
+++ b/target/loongarch/internals.h
@@ -51,4 +51,6 @@ void loongarch_cpu_register_gdb_regs_for_features(CPUState *cs);
 int loongarch_cpu_write_elf64_note(WriteCoreDumpFunction f, CPUState *cpu,
                                    int cpuid, DumpState *s);
 
+extern const struct DumpCPUOps loongarch_dump_ops;
+
 #endif
-- 
2.43.0


