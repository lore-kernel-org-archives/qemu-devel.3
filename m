Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12A4B606A319
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 18:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=RSgHRze8;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Fp3Pe+yb
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJaoH-0004PO-Ta; Wed, 21 Oct 2026 14:13:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xJaoA-0004Mr-4S
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 14:13:02 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xJao8-00083b-CS
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 14:13:01 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69LHpLra454467
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 18:12:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 3TVBizQ4o/KQ+vNhUd+UliSRR7xPynBqUOdb79A8Uac=; b=RSgHRze8lZNWEhb6
 y4MlbLwGSw28u9EytNwfO6lW/LcFG0WbXg+8J2DwD1wu9zSWgQmGnbidy92Uieve
 u7ezAbbd8WTdTc5z+DR7Kr9kZD17eTIM/194gxRlwvFpRAKjb6jiENaoCPxQ5f9g
 inonSALKFY5qH6YA5J92yhrNNlf/qnyJgI5EJq0Pmu4/RwDGdRxnplYR/6Nmako/
 ts3awmwcfjDe/U0aQT9L7K8E74oeedI9ueHp+WSjXbnPKLVjgfu6ZtyRsgCgq4tq
 rSNqUXRUbAAaVmpWbfLJRG47FWgPhtIb02rGjg8CEBedM+CBIwiel3tIM4WTzgsg
 mQCQtw==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hex589c1v-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 18:12:58 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-3acc98e3b3cso996481a91.3
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 11:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792606378; x=1793211178; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=3TVBizQ4o/KQ+vNhUd+UliSRR7xPynBqUOdb79A8Uac=;
 b=Fp3Pe+ybn9lySPKYmu7v/NFfLWOnG60osrdF2/OYQMQD6DDb6xP+atJnEvTZCPsnxa
 Omn02S/T/Z5VkWqvc1xwa1rgvutWW19Ggo8ZRcGxNERJibdwpqG+Cl4lgdgRohKwcKLT
 JchBEqz89+MWbYUgzFsL3Jisubi242JnxTzQ8nl27A7PyaI2dcbl7QyCXBhRwlhlo/GQ
 hfjY422mz7/nx5crP+SZLjd7oJciP90u0R3lg1RBHujgOcF+JulaJ9jc6dkI/YSAB0TW
 1rIQCWtpeefAS0pZ8gepoDq4lBvu8AywEOaNQZp+8ayy9ypgopfiyd45A6wYL6VGL/as
 HqAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792606378; x=1793211178;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=3TVBizQ4o/KQ+vNhUd+UliSRR7xPynBqUOdb79A8Uac=;
 b=Bw9O23DKACVepUx1vot6aKBU6b4+CX2Q+LJM+dtrZhoK84orU3GLI7AqeRF1rj1Upr
 dqlmFevUhRCbckYtVsrCBtNsKlvmpsE0qmDYdjooSkIuLgCW/D1LqjXnTmVrWC/GFYug
 DbtJugdruCnQJJ2kIKACfJu4vr8B5UDao/p+l5i7xktlIcCXe6PEE7Iz+YtM7fiIQe4I
 2hydTkIQjO6BBdYDHkUJqOsfWOH8bn+vEtGUedXmbpGpUmtYzBFVylphthZ7bBD89MMX
 UQ3bjnqrf/J9zHS4ECiUIyYll+5bRc4/zRUx37Du30+6RDeBfZNJ/9XessO94nkesl3z
 Ld7g==
X-Gm-Message-State: AFq9FYLt9Jed3uhHzjnD3T1nJ5tgk5TIzh7sPj9Bp7vjVsqctuENGqUi
 Qtdk6YQtf0s5omzCY0D3OlCr9Pp2Tn8D/s+/38mqYnFqPRJksdBF84GnYMeHtYj4+P1kVQwlR7F
 QOV70n0uv02H5atY3e8+tCym9qLG8/xZ5N2eeLlKo6IrnG10pGbROvkxASY85oh+Upg==
X-Gm-Gg: AYBFou1Y4XFuWXTfwZ9fxmbqhP16FGVXb6nb1q359ydTdY2IBiXYRL9LVaUtsoOSJwy
 zUMRrQG2HF0nw28HldRssX0W1B8YiZBiKHTEXF9BnT2L7L8cuD6h1jsgWSOQ9Ffzpcvoeo3MUOa
 49YFIp+x18UzgKwKi2QmoSNRWB1xCyGwZ2azkF6mX4teBK2eG2R6tlgny95lRBe6FR7ixfxg7q8
 VDY2C9AuOFX15fZs5wl63bN/fB/jda3rZMJQi9auj02I5Y7qcEgOiRozPS9p71jjT7DvcZwGwSq
 wEcBx+TPgxG5pKQO7gsKuYwsMAGXLv38ML9pQHBUHG0IIA9L63TY/K/8uIHKkSfJG7Z2s/ihw/Z
 B/jdjNaG6r09Y49ZQDGXePPA7OozGb1LNzNzTa5HTkh90Cd4IBehdF7VHdz0kSBU=
X-Received: by 2002:a17:90b:48d0:b0:3ac:9ed8:f310 with SMTP id
 98e67ed59e1d1-3ad86dc0735mr2476600a91.49.1792606378190; 
 Wed, 21 Oct 2026 11:12:58 -0700 (PDT)
X-Received: by 2002:a17:90b:48d0:b0:3ac:9ed8:f310 with SMTP id
 98e67ed59e1d1-3ad86dc0735mr2476586a91.49.1792606377738; 
 Wed, 21 Oct 2026 11:12:57 -0700 (PDT)
Received: from pc.taild8403c.ts.net (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ada48ed74bsm499152a91.3.2026.10.21.11.12.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 11:12:57 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 anjo@rev.ng, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v5 10/21] target/riscv: implement get_dump_info sysemu op
Date: Wed, 21 Oct 2026 11:12:33 -0700
Message-ID: <20261021181244.867840-11-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261021181244.867840-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261021181244.867840-1-pierrick.bouvier@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDA3MiBTYWx0ZWRfX0zYpy1LOHzUd
 XvbRnd0KnIUtMtl3SDTaB3iK204DH/5Ox8gF+2/GSmtnLLrXakmTxQ7qZiTitbL4VAxT1uKNjax
 t6Rf53Yrs4y1OB99pQ8Hv/LNvXXg0EM=
X-Proofpoint-GUID: lIHucuuXb6m2NeaQuC4O4fWVBrJZoZIq
X-Proofpoint-ORIG-GUID: lIHucuuXb6m2NeaQuC4O4fWVBrJZoZIq
X-Authority-Analysis: v=2.4 cv=Ku7YSmWN c=1 sm=1 tr=0 ts=6ad900aa cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=a_k_kdOq9Wkoc2Y14hoA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDA3MiBTYWx0ZWRfX34pBfQzcZINw
 EocBxhuoK73aWW5zHkWZrNulteAb5JcratPngoWiEIvshm9pSYFb1U7S323uTZsvf1CQOh8v3r3
 XSuoGz2l1ywHz4Go/e+6CY4oQKmKRqA0GqctzaVjCfSmoF+VrgqLyGE0Xd6A6VXL9GdxeNB/X/g
 p1fmPIK0fO4x61abxuTekH4Brp11RVN+In+p7vrab7U87nAlY+FlMxAXQFhs8ZxSgTp958qu8Q5
 M831C4mLuPFNKlP97w0VdnJrooIsPehyBLzlzbOElIoc4kKQj81h1KmPsdkjkSFb7q5OmB8x4GE
 z2HQ7v+foJNoAyARSNFaC4wHrBQdOZ3NuUsDx+tu8OIZ993jN/t9DcKNNCCWlboO9yEve/VgUTY
 xREoAjmQDJzRlOt9VwLk9yU7QmT56+mPx7nRe9xGOYmLEvAK5EINYA4Qe/wyURU04IYoLk0NdBB
 T0ZbLVWrLZT7jy5+Y0g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-21_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 malwarescore=0 adultscore=0 clxscore=1015
 priorityscore=1501 spamscore=0 phishscore=0 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610210072
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
 target/riscv/arch_dump.c | 24 ++++++++++++++----------
 target/riscv/cpu.c       |  1 +
 target/riscv/internals.h |  2 ++
 3 files changed, 17 insertions(+), 10 deletions(-)

diff --git a/target/riscv/arch_dump.c b/target/riscv/arch_dump.c
index 12b68799070..4c442a78312 100644
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
+void riscv_get_dump_info(const CPUState *cs, ArchDumpInfo *info,
+                         const GuestPhysBlockList *guest_phys_blocks)
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
 
@@ -183,7 +178,16 @@ int cpu_get_dump_info(ArchDumpInfo *info,
 
     info->d_endian = (env->mstatus & MSTATUS_UBE) != 0 ?
                      ELFDATA2MSB : ELFDATA2LSB;
+}
 
+int cpu_get_dump_info(ArchDumpInfo *info,
+                      const GuestPhysBlockList *guest_phys_blocks)
+{
+    if (first_cpu == NULL) {
+        return -1;
+    }
+
+    riscv_get_dump_info(first_cpu, info, guest_phys_blocks);
     return 0;
 }
 
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
index f17d011d22f..d2993842a32 100644
--- a/target/riscv/internals.h
+++ b/target/riscv/internals.h
@@ -207,6 +207,8 @@ bool riscv_cpu_has_work(CPUState *cs);
 #endif
 
 extern const struct SemihostingCPUOps riscv_semihosting_ops;
+void riscv_get_dump_info(const CPUState *cs, ArchDumpInfo *info,
+                         const GuestPhysBlockList *guest_phys_blocks);
 
 /* Zjpm addr masking routine */
 static inline target_ulong adjust_addr_body(CPURISCVState *env,
-- 
2.47.3


