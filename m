Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 061EB606A31B
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 21:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=mT6Xjn+j;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=AbfKhEjr
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIuvI-0004nS-6v; Mon, 19 Oct 2026 17:29:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xIutJ-0002oB-Gu
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 17:27:41 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xIutG-0006K4-CU
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 17:27:33 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69JJKBlc501398
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 21:27:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 66QHcAFY461Xlu5oQhRrDfn+iGpD1ShLcYrEMPzSC3w=; b=mT6Xjn+jAKAWi1Sx
 e4M47hSZFLrXkGoBuAYHyChvKyIUKzDl5sh7pJGIk2xI76FQ3DNaJUl80lNckzPV
 kPPUoA7FivLHW4ruHaNEttDrJ/5ZUxRsePmqFMFqgFyykXrM0roagAuY+ZFgvb2y
 1xwd2yenb6v8XJOO1WnMprnCvmwphJ3emPWM9TjeryndbZt1rH59+86dG44OlbML
 tTwrlcJCD4EELKRhW9Y4gUXxDTir2o/uz0AoZcm/ECbXOssYFmPAjYDrroEapbrJ
 /daBW6xZ89drHpNqjA/7rDqb6dvuPeqQliO76Zt6gMVA/TEQWcBle3ZV/GTXy9se
 4SOkCA==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdf3fbb83-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 21:27:15 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-3acc98e3b3cso2771544a91.3
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 14:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792445234; x=1793050034; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=66QHcAFY461Xlu5oQhRrDfn+iGpD1ShLcYrEMPzSC3w=;
 b=AbfKhEjrtnWPZ4a9La1xLULsZImd2C3vupJ2Lgug/ZEotYplbtqu/rh+61bQ8viwkP
 gitlK9jO4MBKT1cfmPDABM8hdFIlyuX1OMtdkCE++ixPncNzu8GiZ6dkxtSheVP8Cqae
 GowAS26I79YqQSlSOnO8HKtCBPxxfQPyNE+3ZiIrnefRU7H9qa1TsBj9rs9NI/k9L/sv
 4y0dm3FLTU2K4sZtZ25z7uobcsqCIgP5tLFKK6d+zMekwdlhzgrx51DJRlhIBtMdS6MY
 mcP56gr3bouMrH/9G/do/wK1SvFe8Tpopt4sp7Sk7EeaHg4lRYnn2NZSNAxSxdbZJbR/
 2G+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792445234; x=1793050034;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=66QHcAFY461Xlu5oQhRrDfn+iGpD1ShLcYrEMPzSC3w=;
 b=CRWWAYK3WPHeYW2aJ9FDjT77Pgq2maL0S8HN8By7BnPWLUioFkT83GdNj+mpcMW3Fu
 mxjJfGUqfhObc5KEcoIdr1hypTrmaAiaTI7N3iMvwMoO4hb+j+WwvHjHsrC6NKIg93GP
 MLJDSXG1YnjvrBw8z/xI6HFurB6ikH58lQOPhnsRO2xchVFdSwjLxOQybYTm7QI8Dyk6
 zE3DTEUSGZ9vLV2nkssma9b5UbhZ8o+ISDIr//l4dvYcF7xyFdQkCbFuT6XALOrbeSw1
 m4JpZCvuCZ3aSlgW37MSQyjHPkxKOxE3/dqL/ZXXwM5x0GxD9CPUB7GF06RPFjC2ihAv
 NfDg==
X-Gm-Message-State: AFq9FYIT/I6M7nG4K2uGYibrdEmJznwvFQPRyLuOsk4botxZf6Jxs9Hr
 Vz4sLwmUwBNliPJsPq7dSeVfarr4bw7qE0Ykh8dgBntWqDETwxwVgbw/RccJSdpEvIcP7Y3hSno
 y9yJMTkysqohSYVvJiGqdngTFCTX44wWtqxNYvDjKgFb2s//Yj+xh5ViN59XLxSHQGQ==
X-Gm-Gg: AYBFou2AhghGrOhcnS8zdDlrrYXBIiK3CCt+7R7TE+5oWt5VPmLYnHagOnbFq37kmbD
 oxyHgBS1ytrC4T3CWcpB4AgVqkLagNqxzLR1H3DXB7zl5Z+3CbOsitE2zUBRZ5lgeQ/Q4sqI42d
 Rrvv1lV1a2mkCDj5RSEE5xIobolm5AJEqccOqs8z5RBUsVnG45eWysP8UWG2ArvShSjJnPGE3KV
 cSASI30fPDhGRSYVetv8+hzu55n7qT/hafpJZ7gJky1S3nX14Yq1ivomzBnslIP6MFSxR/Q4cNY
 aN+DkO61yXD62xrsqFaX1mMr/fmMJzxsN0N5JTrBdFrzAWiOEXicowzNqH8CBc2n+ltM9j1Ds0S
 7EbdKxvl08Olak7lt9qqRGoYC5WKjSwN+h7LoG8cGHG2Drm7UtsEWjNHAsZNLvaQ=
X-Received: by 2002:a17:90a:51c2:b0:3ad:1b0b:1246 with SMTP id
 98e67ed59e1d1-3ad1b0b14f9mr3458466a91.32.1792445234364; 
 Mon, 19 Oct 2026 14:27:14 -0700 (PDT)
X-Received: by 2002:a17:90a:51c2:b0:3ad:1b0b:1246 with SMTP id
 98e67ed59e1d1-3ad1b0b14f9mr3458452a91.32.1792445233819; 
 Mon, 19 Oct 2026 14:27:13 -0700 (PDT)
Received: from pc.taild8403c.ts.net (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ad60f2c785sm867061a91.7.2026.10.19.14.27.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 14:27:13 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 anjo@rev.ng,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v4 10/21] target/riscv: implement get_dump_info sysemu op
Date: Mon, 19 Oct 2026 21:26:37 +0000
Message-ID: <20261019212648.154493-11-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261019212648.154493-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261019212648.154493-1-pierrick.bouvier@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 2y-skPUEhFZYGETlfjTaDumYm2-2PWvf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA4NSBTYWx0ZWRfX+dWFV+VjraXT
 OafkBw+lJuSg749iOlWg9DHPzywPMnccQFPXZ4OVopO9Zy4KzYC6JSXnJPTh0YUSytx4GjqlasS
 BHgm30Q7IadYF2PNxtJNjalvkWCzaRoUt4SIFQHXXNHygnP20AHOr+U44nXKKPAu97VmfNvfeCz
 Vugmics1sZL9wp0HlA7mqQAjd1FUhS86DJPEiGnQccDVHY6nMH+FcghXGQMddJx03vePR99wMOo
 fd6tESoIk6Eqy55y7WFhe4bkyAsGpV8ETG7RccJ8ZbmPrCIPo6mikUo4eicpkYdGrIFMJCR6c8U
 oGlPrEyVNIpMv6VYCUvSai8sbx2DinJImUacfsuXXWPDGb2IK5tlkRpPyhSvwnxdCfXctN1JPXA
 2GyMywGnqS/ivm+3U+Rojl6od1Pr+1QILeEtQDYZ0ZwO2EwQGOlUw8slSkeme+4nJTearKKnudD
 VPZs9m2fe0gXrR4L6JQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA4NSBTYWx0ZWRfX67NvGrg39pSk
 dFoz6OasbFrntEaQoIPEQ4uGi0uCawV1B5HBhbJr2T9QYmAjBjQUqIfnthrVVBUpV83xAgjpAjn
 R3aA58WL2CZVii5NmKXTq6gE7/RnMjc=
X-Proofpoint-GUID: 2y-skPUEhFZYGETlfjTaDumYm2-2PWvf
X-Authority-Analysis: v=2.4 cv=OaANnRTY c=1 sm=1 tr=0 ts=6ad68b33 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=WNGBrETkOK3pTO-6kIgA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_05,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 bulkscore=0 adultscore=0 clxscore=1015
 malwarescore=0 suspectscore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610190085
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

For now, we keep the global cpu_get_dump_info symbol defined.

Reviewed-by: Anton Johansson <anjo@rev.ng>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 target/riscv/arch_dump.c | 25 +++++++++++++++----------
 target/riscv/cpu.c       |  1 +
 target/riscv/internals.h |  2 ++
 3 files changed, 18 insertions(+), 10 deletions(-)

diff --git a/target/riscv/arch_dump.c b/target/riscv/arch_dump.c
index 12b68799070..6562c32cfca 100644
--- a/target/riscv/arch_dump.c
+++ b/target/riscv/arch_dump.c
@@ -20,6 +20,7 @@
 #include "cpu.h"
 #include "elf.h"
 #include "system/dump.h"
+#include "internals.h"
 
 /* struct user_regs_struct from arch/riscv/include/uapi/asm/ptrace.h */
 struct riscv64_user_regs {
@@ -161,17 +162,11 @@ int riscv_cpu_write_elf32_note(WriteCoreDumpFunction f, CPUState *cs,
     return ret;
 }
 
-int cpu_get_dump_info(ArchDumpInfo *info,
-                      const GuestPhysBlockList *guest_phys_blocks)
+int riscv_get_dump_info(const CPUState *cs, ArchDumpInfo *info,
+                        const GuestPhysBlockList *guest_phys_blocks)
 {
-    RISCVCPU *cpu;
-    CPURISCVState *env;
-
-    if (first_cpu == NULL) {
-        return -1;
-    }
-    cpu = RISCV_CPU(first_cpu);
-    env = &cpu->env;
+    const RISCVCPU *cpu = RISCV_CPU(cs);
+    const CPURISCVState *env = &cpu->env;
 
     info->d_machine = EM_RISCV;
 
@@ -187,6 +182,16 @@ int cpu_get_dump_info(ArchDumpInfo *info,
     return 0;
 }
 
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
index 08a4d14ea1f..059aee855df 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -3104,6 +3104,7 @@ static const struct SysemuCPUOps riscv_sysemu_ops = {
     .has_work = riscv_cpu_has_work,
     .write_elf64_note = riscv_cpu_write_elf64_note,
     .write_elf32_note = riscv_cpu_write_elf32_note,
+    .get_dump_info = riscv_get_dump_info,
     .legacy_vmsd = &vmstate_riscv_cpu,
 #ifdef CONFIG_TCG
     .translate_for_debug = riscv_cpu_translate_for_debug,
diff --git a/target/riscv/internals.h b/target/riscv/internals.h
index f17d011d22f..ea4b4140c09 100644
--- a/target/riscv/internals.h
+++ b/target/riscv/internals.h
@@ -207,6 +207,8 @@ bool riscv_cpu_has_work(CPUState *cs);
 #endif
 
 extern const struct SemihostingCPUOps riscv_semihosting_ops;
+int riscv_get_dump_info(const CPUState *cs, ArchDumpInfo *info,
+                        const GuestPhysBlockList *guest_phys_blocks);
 
 /* Zjpm addr masking routine */
 static inline target_ulong adjust_addr_body(CPURISCVState *env,
-- 
2.43.0


