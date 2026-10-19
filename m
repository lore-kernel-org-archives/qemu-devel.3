Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A60F606A31B
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 21:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=QTUQRW0w;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=DUyTaXPx
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIutd-0002wI-DW; Mon, 19 Oct 2026 17:27:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xIutJ-0002o3-Dk
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 17:27:39 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xIutC-0006Jr-9l
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 17:27:31 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69JJJuBG3672236
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 21:27:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 bAAmjLSWEog6/VDmAXKBOiykt7JvqrYIFjongFPqGy0=; b=QTUQRW0w/6xvl689
 5QnYjJcTH0npafHT/v7FM0YZkGyFZsULMiMUe3Ud9s/VjvnzNAXY3HW3Me5xuyLM
 mdU94B/TTxjvJRilT4sOai9u13D/Zt6s4RmA7k21oA87oSr7BVzqCT6v1CUpjRZb
 NAtcjOCW3n+kAK4+5F86srNYdWdSFdvZNVwjntLKUksEM+BoiqYXxaGq0s+TIghC
 0oQhHACh+ypENfYMVT1PQcCGoJqTx8umZpy1PADbHIf6LuahxWruyhN4ulbrW+tI
 +qjWeb9P0On+gXHGol2HA0OuqnvxtQQae2j72ca6Sko9jyXfaYWv9zu3Wh79zY5g
 CCikjQ==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdf3xbbjx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 21:27:12 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-3aaee1fc104so3916536a91.1
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 14:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792445232; x=1793050032; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=bAAmjLSWEog6/VDmAXKBOiykt7JvqrYIFjongFPqGy0=;
 b=DUyTaXPxM3iCkfmoCQLfxwiuqAZamrwLZTGB3Gij6Gb/Jp4fK5ZxkY9HRBW4ZQEpji
 GUTMlFIyK2dEp6+Mg0vbbhqxTUWPKkzmCiSvXboty28B4eGIkU4MLYRNjoFJHNhoCMbY
 fHo7Nq9L4jA1LJIBfBtcUW8IUx5bshMasI3/0qowZ5v4xG3G+vUq4FY3dDdqov1oJl2Y
 QGPqPmvMeXYrOzItM97TaEs4sKIQ1K4RrN856xEvuHG6y2Q7E9DVE2Bzi2OmkiMK3MFW
 Cyv9S9Ak7e60paoRlQPTgAZCeio6yXWwxTZc18gZBWzzyys6wrgh7ddUJ7qPXWc86wCt
 AHJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792445232; x=1793050032;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=bAAmjLSWEog6/VDmAXKBOiykt7JvqrYIFjongFPqGy0=;
 b=uLiXAsERQl/Ye5FG2s4+TbEwTaDcuLNGzTothTqQg2dMFWREdav7ICBnacLvKbHmKF
 L+a2wAMJCoKD51l+kazKuMNQ+xDkQBgMFgNnPliqBnkFWnfX/VEWM5GdVMZrbnK/klDX
 CK+yOGU25trvc0Cel4BzpAzcATNGQHoaBamDIFgDo2PQ0PAAsis5+IhHBJp/RSBiDs+F
 XvhEna3GSy4sb+G4vZDdmTI3WgosJlGElaVub59t4CcMAfgvecBh2EKIhhh+l3Z3u/bT
 mZgDdmw7Dy0AGI45jDgPQkOE/4zi/EfN07p5f/YN6eM8mIrmtDTWvhGOYtb7FHrDskP9
 xO0w==
X-Gm-Message-State: AFq9FYLEfUNw9H37pkqyNJFRpItyLig4NpUs/gP9doNr6bexJVZUmxwe
 O64Ev2XZZ+zZBi6/dIYKR+hi8smBtrb74ytd6VpivhreuhXN1TMzOhfYwmHX8rMb9GMQiNMfXth
 wvG5AyTFLnVrdJfr5iSwQSOf2dma2SNsL2ZBwD+T1rETD4Hf6pgKVvza235pFKywYIw==
X-Gm-Gg: AYBFou3IVK4S4GGeqnJ6fXAV5Lr+JbSX/A82Hq3UqAQGGMj6dsNCtzxjsM/nycu8YUT
 sKyQ+IbqAt7DfvHP0qdQW0kZ751e+7DgBdp/Yq8e+Gijjvu+qYnhSCfUaVYjh3Q43cQa5+Yx+t+
 BQxRQDUE+SUBcIuxgJGWANAX8bhyoilG9LneSajQnKYxqOwX6vrHdiJ3xC0Sa5J6DhEHUNkMs+d
 05decx4pvgBdvlT/GruehyI/cZPLUZ7pL9KGkzpT+pYS5TRy/9y1oJjaKr/ahNX5ePeb20aYucg
 lGUuStZjWcabzDl/yEZg8CSCZ4ZM/YNZDFDV7S3+v7PeSwua6ei0Vq31qal0skV7k/gXTYxigzh
 2SxrM8gPZNEXcebRDAJ6bu9w7J+cnI9vg9qdNaTJlPb6Xaz8Ua6z+3hG3VfLGHYI=
X-Received: by 2002:a17:90a:d60d:b0:3ab:2737:3393 with SMTP id
 98e67ed59e1d1-3acef4e6d00mr7879715a91.40.1792445232181; 
 Mon, 19 Oct 2026 14:27:12 -0700 (PDT)
X-Received: by 2002:a17:90a:d60d:b0:3ab:2737:3393 with SMTP id
 98e67ed59e1d1-3acef4e6d00mr7879667a91.40.1792445230636; 
 Mon, 19 Oct 2026 14:27:10 -0700 (PDT)
Received: from pc.taild8403c.ts.net (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ad60f2c785sm867061a91.7.2026.10.19.14.27.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 14:27:10 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 anjo@rev.ng,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v4 07/21] target/i386: implement get_dump_info sysemu op
Date: Mon, 19 Oct 2026 21:26:34 +0000
Message-ID: <20261019212648.154493-8-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261019212648.154493-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261019212648.154493-1-pierrick.bouvier@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 10bJwnQX64j_YFX8tY-S1t70DX-gW_Ow
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA4NSBTYWx0ZWRfX72yl35XsARGD
 UtF/xVifPCFlLR23us76aYukX6+Vvz6soEzvRZER0+IVfxIl/R3BQoxVI0d7Hr3YXGr4wJO5gy4
 PNZ+dPlpAp68hQWx8I3izQMkRcWRv70=
X-Authority-Analysis: v=2.4 cv=XPOl2ghE c=1 sm=1 tr=0 ts=6ad68b30 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=9TR7Q1sQarOedDMGQfkA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-GUID: 10bJwnQX64j_YFX8tY-S1t70DX-gW_Ow
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA4NSBTYWx0ZWRfX5DurecH45fSs
 iST1C3GTGf+/B89zl/LxgiSy4ciHEtHJp1ZfrkytG/pBIqX/KJWdBYHJ4J/dRmfQHtPHYp1jymU
 6mJ8Qhpxdu3iL7+Cp0cPqr86ZTgNXhHU6OUo6uAjmDkMz+Vx6ESmsy+dxR4w2xKGrNU4MzgOj+J
 YypBK35Zqt5JJxSunv6no6i7pUAAKIHlywFIuwXQzkV5nB5jgCLsm0lQH8LI81Hx9rwMaUkN1rM
 96zydgOwalNeI13uoE6o0TLceV1C8H4CdRnVN4DwaL9IR6FNU1OiEkoHd9GolEtvBEMPVlT8VEb
 nOJeQjMhDSFCAdG2ndTmHujRmDyHBVKYFSBLIKkyQ1MrieigvchjuYcRqFJ8/3KuN2C7SFgXl5A
 BqaNpxjR0MVlXeuf/PFO3UU3hfrw507WXvjHvvcOyll3nLya9aPtaY/ytF/YmEbGlU7JEjQ9Pjb
 p3Xr35LcNi0O07Go8Dw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_05,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 adultscore=0 phishscore=0 suspectscore=0
 clxscore=1015 priorityscore=1501 bulkscore=0 lowpriorityscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
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
 target/i386/arch_dump.c    | 17 ++++++++++++++---
 target/i386/cpu-internal.h |  3 +++
 target/i386/cpu.c          |  1 +
 3 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/target/i386/arch_dump.c b/target/i386/arch_dump.c
index 16e47c4747d..d5016c198cb 100644
--- a/target/i386/arch_dump.c
+++ b/target/i386/arch_dump.c
@@ -16,6 +16,7 @@
 #include "system/dump.h"
 #include "elf.h"
 #include "system/memory_mapping.h"
+#include "cpu-internal.h"
 
 #define ELF_NOTE_SIZE(hdr_size, name_size, desc_size)   \
     ((DIV_ROUND_UP((hdr_size), 4)                       \
@@ -394,15 +395,15 @@ int x86_cpu_write_elf32_qemunote(WriteCoreDumpFunction f, CPUState *cs,
     return cpu_write_qemu_note(f, &cpu->env, s, 0);
 }
 
-int cpu_get_dump_info(ArchDumpInfo *info,
+int x86_get_dump_info(const CPUState *cs, ArchDumpInfo *info,
                       const GuestPhysBlockList *guest_phys_blocks)
 {
     bool lma = false;
     GuestPhysBlock *block;
 
 #ifdef TARGET_X86_64
-    X86CPU *first_x86_cpu = X86_CPU(first_cpu);
-    lma = first_cpu && (first_x86_cpu->env.hflags & HF_LMA_MASK);
+    const X86CPU *cpu = X86_CPU(cs);
+    lma = !!(cpu->env.hflags & HF_LMA_MASK);
 #endif
 
     if (lma) {
@@ -429,6 +430,16 @@ int cpu_get_dump_info(ArchDumpInfo *info,
     return 0;
 }
 
+int cpu_get_dump_info(ArchDumpInfo *info,
+                      const GuestPhysBlockList *guest_phys_blocks)
+{
+    if (first_cpu == NULL) {
+        return -1;
+    }
+
+    return x86_get_dump_info(first_cpu, info, guest_phys_blocks);
+}
+
 ssize_t cpu_get_note_size(int class, int machine, int nr_cpus)
 {
     int name_size = 5; /* "CORE" or "QEMU" */
diff --git a/target/i386/cpu-internal.h b/target/i386/cpu-internal.h
index 37c61a1bc3d..9bd2a37c447 100644
--- a/target/i386/cpu-internal.h
+++ b/target/i386/cpu-internal.h
@@ -65,6 +65,9 @@ void x86_cpu_get_crash_info_qom(Object *obj, Visitor *v,
 void x86_cpu_apic_create(X86CPU *cpu, Error **errp);
 void x86_cpu_apic_realize(X86CPU *cpu, Error **errp);
 void x86_cpu_machine_reset_cb(void *opaque);
+
+int x86_get_dump_info(const CPUState *cs, ArchDumpInfo *info,
+                      const GuestPhysBlockList *guest_phys_blocks);
 #endif /* !CONFIG_USER_ONLY */
 
 #endif /* I386_CPU_INTERNAL_H */
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 5da80ade70e..49f453bb011 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -10920,6 +10920,7 @@ static const struct SysemuCPUOps i386_sysemu_ops = {
     .write_elf64_note = x86_cpu_write_elf64_note,
     .write_elf32_qemunote = x86_cpu_write_elf32_qemunote,
     .write_elf64_qemunote = x86_cpu_write_elf64_qemunote,
+    .get_dump_info = x86_get_dump_info,
 #ifdef CONFIG_HMP
     .monitor_defs = x86_monitor_defs,
 #endif
-- 
2.43.0


