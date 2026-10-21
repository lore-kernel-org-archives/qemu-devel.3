Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CF3A606A31D
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 18:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=PCMfdi3I;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=FTlBiHhB
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJaoE-0004Nl-EY; Wed, 21 Oct 2026 14:13:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xJao7-0004MG-Fa
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 14:13:00 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xJao5-00082m-Ks
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 14:12:59 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69LHpGUb2384123
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 18:12:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 LetIZKcCtlpEnZFO8wDfamn5P3Nwf3Rcq8dEdYUy35M=; b=PCMfdi3I3ZEVUEC1
 TdwDkwVo4Nz3xGFxg1GSVkXY1eJmiKyEroBqjcK4tEWn5ZgcEMaGyOp8LNMMAnwW
 wbOVGnAKe+TSE+PNCgCeG6GnKX5N5kwtDGK8FBcTn895FxxqV1Mw1J64iY0Udzjy
 HHkW5wl4NFq8N2jtUG+nRGceK+AczAKXaVfUaO3c5IcxnxbFuKLBdF5al4dxHnj7
 RaiAFQyY+BFvpH7OHF2ZADZ8M7IIj3oafYipsMpp1wuoQ2tNXIPqaobzzLhrwPxR
 dj5F1lRFuqmkC9bo+DfV0Hdn/53uBfLthdEZlIXnSrMAqyhkgzVU/MJaS5+UAO0t
 ARmFWA==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hf0ke0jtu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 18:12:56 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-3ac8f449d1bso1117611a91.3
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 11:12:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792606375; x=1793211175; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=LetIZKcCtlpEnZFO8wDfamn5P3Nwf3Rcq8dEdYUy35M=;
 b=FTlBiHhBUY2HPdwwZSiZP2+Sn299mQnz+m8GsAMBQJATfUwbuzuWFKAyAbbN+dQPJZ
 7GfHO+ma2/2Nlxhq+dqHP/dHZf5w4H11Q6Ir+S5feZ+TKitzNAwfHAetn6bjew8h4JoB
 JppSR1Ed3hzGnhuNGJfc2e9XJ5rSW0+z1W+LiVjJz6BQO0apV+XER5OYJJAG/ep9qg2j
 k2I44Ig8ASPcTapOhyWxReldUWzwpbQC4TlbtAiUuf9Rui9p5p1nSv5iVLUP+pBZVONV
 NsXthhhYX8qkYNqSSo8tRJxeyt4uOMa3ModBa3tPRlv5J5lOOcM9RzmXCtEYmf1Z3pdw
 9w6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792606375; x=1793211175;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=LetIZKcCtlpEnZFO8wDfamn5P3Nwf3Rcq8dEdYUy35M=;
 b=U1kYzw+C4cEs3L5q85J/WobdJOKmSRsDh4/ftksywapU+Kp6ck0YiHoqENOTOP0gdz
 k3q9SgebDXDewACfGRGhBVabomV1+ML0+THnrzsCqt/pk9rMsR54Kd71QhqC/cT4qW6f
 Be894D161IukFX0eceMwpFUBuKt8oJzuJoQ7PMGaybFc9pVV3y/kVbfIU2IdQftYXIRN
 Bxjyo4sOVutvcN+isgr5T1tR1o2OvwjDum85Wlncxs0bKr5mWxQf67uay+JepVsovwAU
 03yF5bMefHqp3c0zbpcmcZUremJKOnuX60oCSF8+sPtQm0yDwsld0daMsg/eMADTuF2b
 /vhg==
X-Gm-Message-State: AFq9FYKhBu9vguhZHhMBbCcblURpUqHOwNGSs6TBxjHQVmgtUbddh6Zt
 7Ct+ClbGN0oAgAuTyLjeMn/KX6LgkAwrRHJoIkEZWWmX91rBvnZubotatofK0tXKOnvMfm+L0zN
 Up2J+gnOeT599xwSZfk/2ATLHtTmm02/PV4ZY75O7UrewehIJlgbbZTePlsFR70t0RQ==
X-Gm-Gg: AYBFou3ZDHkh1YzVhxTtxAwX0cvZl4X3Oll9cEdJElnVmcOe9aAWbdYG2UN2BNDhqNd
 MGdcxgZcfgI+ID8OjwjIfA0a1k0QzeI575HMUl5GXlxVOOCTpyXv/hZ9VHNG39SfwfmjLyq5vWZ
 4O02RkJh2+Na+fgMCUS716bYI13zPm/O3L8ABV3IJjoqXQ5OoZFyytqrTfVeiBknJYrnu8cZwq1
 9zGq6PgImFyqkeRWsLk2A+kzWgFOhJ19VQQPNERSi/2SCkSPmAIug93bLoBjQ5f5Z5UvYCj/w2E
 mGhPv3A9XHx6D40Paznr0Akmkvj/uREsSH8g6EZVxXgio0lzMdTV6GI65p7F8Fz8egIqA9dtm/j
 EyZS0tVUg389w9RfI1AUDfXuiIZoh32DF0TTTlFgAKj/svp8rllaGuYuiAdvraqs=
X-Received: by 2002:a17:90b:2f8b:b0:3a5:1b:34a5 with SMTP id
 98e67ed59e1d1-3ad86d3874emr2422851a91.49.1792606375480; 
 Wed, 21 Oct 2026 11:12:55 -0700 (PDT)
X-Received: by 2002:a17:90b:2f8b:b0:3a5:1b:34a5 with SMTP id
 98e67ed59e1d1-3ad86d3874emr2422834a91.49.1792606374874; 
 Wed, 21 Oct 2026 11:12:54 -0700 (PDT)
Received: from pc.taild8403c.ts.net (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ada48ed74bsm499152a91.3.2026.10.21.11.12.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 11:12:54 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 anjo@rev.ng, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v5 07/21] target/i386: implement get_dump_info sysemu op
Date: Wed, 21 Oct 2026 11:12:30 -0700
Message-ID: <20261021181244.867840-8-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261021181244.867840-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261021181244.867840-1-pierrick.bouvier@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: p1wUhWWN3goWfP-FUsiPyZtyv_LDIIpT
X-Proofpoint-ORIG-GUID: p1wUhWWN3goWfP-FUsiPyZtyv_LDIIpT
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDA3MiBTYWx0ZWRfX8ugtaKIvo1FZ
 QD0/Eelm9engKhd06DxO0XGmCItSrujMOu0HdYZ8gjDn/M24Hsn/O0GpsZq947Sx62s/sVISJzF
 wPz8o9sMORhTZv/Ik3C6gpS3E0C9XLc=
X-Authority-Analysis: v=2.4 cv=KOzPn1Fo c=1 sm=1 tr=0 ts=6ad900a8 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=9TR7Q1sQarOedDMGQfkA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDA3MiBTYWx0ZWRfX8paMWv0d7qHr
 8PfzNY0fVaA3czwMEQ5DQslgGgxqLRfN/fu3YodSVnWmQMPFewWCct73enjPapzBXBWuFwQ8OJ7
 dv8gXh6uNQep9/zOWKWczEisOFRf8LuUywUzu53SxwpieWWHEYpEfZN0Qw5xtq37A6IXu0aD29E
 C3izR18Mx0nAMCAmL7YTS6lSwzWXd0O0wgMcdJeLqUm1VNK7RfMzwjGeLMdg4E8rLWf0dfnlir7
 ++qbW8WDi0FrSTdAgPj5XKnqle5GmfdXnHdenp/LzUbM4cZnq663F37aO7r3rSBnBEvB+OC22Zz
 hBUN7GU8aMkYZRcn323o2EdTOX6j1XlA2ZbhVNxxmeXDvJnysuD6tMrt7CLLkVIGzkKmv5LnHs7
 lw4gKZ1EMn3vxbe7ojoTWag7A+Jy007NBCSqCLjXC0558Rsj8hcVjkE2g1ZUiyG2nFU+ev0/0ML
 bawrWHXwYPTAgJ2zFwg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-21_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 impostorscore=0 suspectscore=0 bulkscore=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 malwarescore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610210072
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
 target/i386/arch_dump.c    | 18 ++++++++++++++----
 target/i386/cpu-internal.h |  3 +++
 target/i386/cpu.c          |  1 +
 3 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/target/i386/arch_dump.c b/target/i386/arch_dump.c
index 16e47c4747d..ed273708c60 100644
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
-                      const GuestPhysBlockList *guest_phys_blocks)
+void x86_get_dump_info(const CPUState *cs, ArchDumpInfo *info,
+                       const GuestPhysBlockList *guest_phys_blocks)
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
@@ -425,7 +426,16 @@ int cpu_get_dump_info(ArchDumpInfo *info,
             }
         }
     }
+}
 
+int cpu_get_dump_info(ArchDumpInfo *info,
+                      const GuestPhysBlockList *guest_phys_blocks)
+{
+    if (first_cpu == NULL) {
+        return -1;
+    }
+
+    x86_get_dump_info(first_cpu, info, guest_phys_blocks);
     return 0;
 }
 
diff --git a/target/i386/cpu-internal.h b/target/i386/cpu-internal.h
index 37c61a1bc3d..75bbd00bc7a 100644
--- a/target/i386/cpu-internal.h
+++ b/target/i386/cpu-internal.h
@@ -65,6 +65,9 @@ void x86_cpu_get_crash_info_qom(Object *obj, Visitor *v,
 void x86_cpu_apic_create(X86CPU *cpu, Error **errp);
 void x86_cpu_apic_realize(X86CPU *cpu, Error **errp);
 void x86_cpu_machine_reset_cb(void *opaque);
+
+void x86_get_dump_info(const CPUState *cs, ArchDumpInfo *info,
+                       const GuestPhysBlockList *guest_phys_blocks);
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
2.47.3


