Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40403CCA462
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 21:34:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHT5G-0005Tu-Ex; Thu, 15 Oct 2026 17:33:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xHT4H-0005Aa-1H
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 17:33:04 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xHT4F-0002Ql-AS
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 17:32:52 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69FKZsM63462799
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 21:32:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=V82ixEBm8lx
 1OxA/oRqf/zsd6icAK0eUBY4vLa0K6jc=; b=EFOgQZrGmgCFkAUMFC/uMZ/mbZU
 mQ+FJ6apLCIZntFnoG3RKqTROBJJ91SexJHY0j/TDXLcnhuWCQIQiR83EHTE+kup
 02bbZQUD8mEMVvWSB9Pbo1Q8tqLK9zH4ISDJP4XhdSPZ+4WhK9ewpAzSQ3a8Z5Ag
 TlkCHVmcGXJ4D4keGqme5FkIoyZIh84swwhNKlxWBYtOs1VQZE9Q1BFQT+OIRpsx
 AanQCp4x82TxDDGqysvHOh6+ErzO/GS36zBIZRNEO6GFo+zsJauz34TK7PCT05D5
 1bWgfZKkc7fC7kF1BXClYyzW92u5EaSbUYO/Div3eHGr9puZNHQTemJOp2A==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hayu69v4s-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 21:32:50 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-3ac77c3ff6aso2984201a91.0
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 14:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792099969; x=1792704769; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=V82ixEBm8lx1OxA/oRqf/zsd6icAK0eUBY4vLa0K6jc=;
 b=TUUPBvuGgQYo1y7UslMwXZ8Z57MaFUkeLFvG2vPFQg0bsYfjK+DSrVUvu3m0jkVb0e
 x3Q5TqAyRjX8xHW1ErE+ByFIVvdE1O6robB2GDVmEBSwm4gIYBS3KFXrJAyRLBmbwfIe
 gimbMI7GD635VquNfsVPMO7unFSX94hB8fqggr1wPasa75cMydvXOFOcFwoLjDhwaSvf
 xwQFxOt9ypEfWBft6sOLBjWAA2Lic/dKmQHmDgrUiPfRbL6WVEOkbee4BX91J5M2Z0Ur
 xvy1z0p6FiZzEsGlb5hyraophMDMkRs6HLpyilPboef0awZrFz6juTaTvx1G9BiIG6x7
 VvBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792099969; x=1792704769;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=V82ixEBm8lx1OxA/oRqf/zsd6icAK0eUBY4vLa0K6jc=;
 b=CJyU1k0pADxSoNvz+OBgcdUwCoPi9t2BU223IlBk5gUkGZFTAwSwCTXE0/VPc8QHCv
 fJxpxGKnQuVZ5AuRKLlqtfPc0hB9JRRjzqSswq9tML1CbRsDl5Xbx1CQlO/ur4bWE3ZQ
 gNkNk9kHhnOdSr4sZtr5XtVleosocIPHNFmwOutYt/61ZDUHG/QBs2wUdNi1aepMKydO
 ssf8o1w4lZW16A5EpSZBECdf0FKtN4H07TbcsKgKkb1PiJYjMXrNNg+by9HtKNqsdf5U
 aeh4Zal+MEPVJKgoAgCwLy6HGIcp7OsJFbqJcc1Ep6KWjVu0PO75mcbIWS/VxwfxUSR+
 D2gg==
X-Gm-Message-State: AFq9FYIC7K/rhFx/vlRwciOJcDMZp/oeCkIVbOvAccsMWP/fE8tYkPOy
 Qcy3mqH7vL66Td/6lHLfCzlNxjlH+Fd0HfnUHVpZzd3jX+uPVzBxVxFDTYCRrDtUzEVsJPcma1l
 XgEqwgN8bUKzDfMR3D4qw63N+zZB40jBgGWuNztcgqbdUoNkvWIHxC33lE9uDABAqLQ==
X-Gm-Gg: AYBFou31X2flLnpNhuZ8NTK8zQHMCAcr+UoW1+FhGysD+4OZnEIVPxL5SM7zRC5axpk
 PlgPlNxjY/NIlaxFHpeV8gOBiq+3NSZMQVwW7T0IrF/xMJ0gtGvRoKPZQz6nP0R2rLDRIxliXku
 ZVDjc9xQ0dIPTx42UzCDYetUGf14IMFwg09KR2ObKVDgTs2R/7Fs+9LDFCICQqEF2FVLwlBbm5K
 +aL3lsl73rKSPjQAHJnDdrM9+cSM07nx+bRIwDDhEEk7T2cFfVwsAQosRr8Av7nm2Q58cqsMnYV
 rHxqrgWq9SY2pS3NtwjInH12yHs985ExfdlL893zggbi2rSfiU7XajedvjkmG37GAv1+7buFFXK
 bMyv51KyUnAInlUJs6jUIJtCSLZNyJEGdrLUoQZF3Ylx1ygNnVNAOU+qxaC2eSHg=
X-Received: by 2002:a17:90b:380b:b0:39e:6c68:c77a with SMTP id
 98e67ed59e1d1-3ac5c83940fmr7400028a91.48.1792099969289; 
 Thu, 15 Oct 2026 14:32:49 -0700 (PDT)
X-Received: by 2002:a17:90b:380b:b0:39e:6c68:c77a with SMTP id
 98e67ed59e1d1-3ac5c83940fmr7400014a91.48.1792099968848; 
 Thu, 15 Oct 2026 14:32:48 -0700 (PDT)
Received: from pc.taild8403c.ts.net (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ac940055f5sm5989362a91.0.2026.10.15.14.32.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 14:32:48 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, anjo@rev.ng
Subject: [PATCH v2 06/19] target/riscv: implement get_dump_info sysemu op
Date: Thu, 15 Oct 2026 21:32:23 +0000
Message-ID: <20261015213236.157767-7-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261015213236.157767-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261015213236.157767-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: Wm3FakUSV7dlp3MrlEv7NYpqulpluIJS
X-Authority-Analysis: v=2.4 cv=ff04WEQF c=1 sm=1 tr=0 ts=6ad14682 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=jz9sZypbQeUOAt_tUScA:9 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-GUID: Wm3FakUSV7dlp3MrlEv7NYpqulpluIJS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDA4NSBTYWx0ZWRfX4rm4nHTfxtkN
 pQ38F5sk7S8EOTtvz6RG9TVPlqU0Wt++c1HXpe8vHIyWbKUFS4BdA+EwZGaHB/bN5urtwt6Oex2
 YntOyXbyUJHbX7UM44hT5aakv8nzmep5fYsFIlROx2HcNxGjSuOra/DaoN1DzjECJ6t2yD9Tce2
 8qh9n/uAjUfxtN85ZBWTYQGfp34PZBFu7fcJXTzSmqyVgQGc4M27gxIpee2Kohrx25iYOkI8LQu
 G7yq8jdjaokmJXuD0ZG7CsZuJMmMxFqAnyoeoyDdKEOjy7WBZMmBXgkJIo1BUdyKE2DKj6P0yOV
 nUcsoaiyHp57oet/Hd7RJsSR8B1vYnGYhix9SHxdkY6CEkMuufKI+D0WD4RkgpHdKAUchMw5kx8
 nndOrUfETBa7l3Y4yhajKl0RUma+JOjPDVJsmBUwpncYhFUw/CcJxoHS9cg2/BpzIZccQJ/OhNR
 rgXy7aSCJEYrwmoaM9g==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDA4NSBTYWx0ZWRfX6OE9+4HPUHrf
 hK3VrZguMIAaoDoa5t9kiDBulUvvyVTEWd9Cl/9uvT5voftwXxQAwZcyUEV4rVYfOTX+WCoZ8PP
 Hr5IiUYbMd/QRVevk+R+8yhxlT+S4pc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-14_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0 spamscore=0
 phishscore=0 bulkscore=0 suspectscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610150085
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
 target/riscv/arch_dump.c | 25 +++++++++++++++----------
 target/riscv/cpu.c       |  1 +
 target/riscv/internals.h |  3 +++
 3 files changed, 19 insertions(+), 10 deletions(-)

diff --git a/target/riscv/arch_dump.c b/target/riscv/arch_dump.c
index 12b68799070..ac9e4964660 100644
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
+    RISCVCPU *cpu = RISCV_CPU(cs);
+    CPURISCVState *env = &cpu->env;
 
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
index 63c709ac738..bfaaea94824 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -3015,6 +3015,7 @@ static const struct SysemuCPUOps riscv_sysemu_ops = {
     .has_work = riscv_cpu_has_work,
     .write_elf64_note = riscv_cpu_write_elf64_note,
     .write_elf32_note = riscv_cpu_write_elf32_note,
+    .get_dump_info = riscv_get_dump_info,
     .legacy_vmsd = &vmstate_riscv_cpu,
 #ifdef CONFIG_TCG
     .translate_for_debug = riscv_cpu_translate_for_debug,
diff --git a/target/riscv/internals.h b/target/riscv/internals.h
index f17d011d22f..8a94aa0900f 100644
--- a/target/riscv/internals.h
+++ b/target/riscv/internals.h
@@ -23,6 +23,7 @@
 #include "hw/core/registerfields.h"
 #include "fpu/softfloat-types.h"
 #include "target/riscv/cpu_bits.h"
+#include "system/dump-arch.h"
 
 /*
  * The current MMU Modes are:
@@ -207,6 +208,8 @@ bool riscv_cpu_has_work(CPUState *cs);
 #endif
 
 extern const struct SemihostingCPUOps riscv_semihosting_ops;
+int riscv_get_dump_info(const CPUState *cs, ArchDumpInfo *info,
+                        const struct GuestPhysBlockList *guest_phys_blocks);
 
 /* Zjpm addr masking routine */
 static inline target_ulong adjust_addr_body(CPURISCVState *env,
-- 
2.43.0


