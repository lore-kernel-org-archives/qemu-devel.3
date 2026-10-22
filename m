Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 657E0606A319
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 21:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=gCjQZn3q;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=E3egQfI9
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xK0nQ-0001lz-25; Thu, 22 Oct 2026 17:58:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xK0nN-0001ku-W1
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 17:57:58 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xK0nM-0000Gb-0P
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 17:57:57 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69MHtSxw387583
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 21:57:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 exw2wlWJfJEmYwWmwWpQZPNkyeMNbNfALRRpmmSogRs=; b=gCjQZn3qFrgxQGp9
 1jvmdWMOyRtxLMEAf6h0z2YXtoKUbuxSXDu7CFmqVpkH5oD8XaBKHDIYTDpzuiL4
 KnPwSFgUrPAjcTx892SfkRyqqMByr7k9e5jzvmrtjCw8tY5nFCgsnPEdcm0iJEDp
 d52YjcJUBILWX1u5E0rHKNrtFf+BLWWL0gdLDsYGSeaMTD72+VuQ7lCZmB2B1R9Z
 U3klPUZDB7to0jbqqZPNmpNqVXF/VjIAwsPaWTnYJr1swP7lyeO1jUqSzXwFjCE/
 UfDV1yK3jnybuH5CIRWhmHJSBW09tMC7tcp0fr+Uy88teRR+18SCt4XgmeNFGAfO
 JpTE+A==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfewq4rcf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 21:57:55 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-cd0cf3b1c70so136200a12.3
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 14:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792706274; x=1793311074; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=exw2wlWJfJEmYwWmwWpQZPNkyeMNbNfALRRpmmSogRs=;
 b=E3egQfI9tlOKTxg2comoB6qF3pyomuZChr5m4EM4At0EYT+K5QPuUYH2Jw02M7gZUC
 ooZAJGlPXblcfBdcSelmmZXmhWR/p0YDgJatDsYfJlqvEo2qbQNBd3eXrcQkr2gjuXTk
 oXthxIKtz4dNLhkJ+L2FbGRvpzWtojrKaXSOZ7iMHVK+Nlwgjdtfv1jrv5uw/cDVVGy1
 vI20KSpNfXj2I/8E5ZRPUK3yaYLBe4stUh19Jl56szP6dTQqSaGzAiwb9m+lDmeHqgnK
 nH7Kz0B/JEbUq2vqtpyIlPG0yv/01J++hShxQxP6icKgLjPlT8ImWsAFHDUShsV9pv93
 8oFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792706274; x=1793311074;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=exw2wlWJfJEmYwWmwWpQZPNkyeMNbNfALRRpmmSogRs=;
 b=2BPAdpRV56o+lI/bMO0WEOVJRclYkd5IWXpzuGIo7pXCyoCUldqlqBSXYVCi8XBybo
 jBgZv2GkHAYCIkxUZwvKvS87PbZcg5bNWbKS6uq6GafZzIy5xiqMsXQqGAG6lAP4G0CX
 6pj7xONXuPma8foouQgH4TTW1SeNPZnqiRvCIUXnFR4uSZIz6k7Sb7wHcm16Q5aotHVl
 LZmWvceOxlhINb3s1LsdapVP1MH5DsAEk3guct7RVu3mYVwSJ7XlxWxoJQ9FnqZSc2GA
 10sKxuUFbuxTQEdi5sFgAsHNEhySS8EDj3EmM3auGzarLcBJI31argr/3mP9wyUmAbMx
 bjCw==
X-Gm-Message-State: AFq9FYKUbomvv0u7xdpGsIFHvQbBUcjLjW9Ghz6NRDW7gUNvBCI7c/Cr
 efpwkbmjdqRgB5WUJKRv35wQbKq+yfcocKBmBhDktg5uxaoSP3s7j9dfWbfIsU04UIb9uy3IPYU
 EEaEvgcjNJZQrP3T3tBygnN7S29t/ytfPSPwcCLgw+hG/Y3vuB/FSS8jzAYypspnYwQ==
X-Gm-Gg: AYBFou1re2jYWb0XK7i2cYuCeiHgWH+fz5045f5U4a8uKYQZXSsYkrg6T/bV7A70hDq
 rufrox/cVOgs2XKbc+RQ/8WKc5vK0k9yayV26YEqTqxNbzghUR43dk0pdT0MKlcMAYiFtk1cnQD
 oJTP0odgPc0UDTebQyDsXq6j7q/FI35r9PXf3Vb1mJawNJLIF+ex3i0A7AVcfA79jpt80+N7kN7
 6n5NbgcKeSLQlR/T7T739r3OVSVaIRsog8AKkvrlrJmaY80Uzh1c9cVCX6PFOXi8O6fYBVVcPYP
 ekzkUUJh07fcG/P/vEGgysqQxFqqhlJoPvHuGJ7uZbZtkxrl0p062rViy9vIpIPXIqElpKLnZ2A
 pqJ4t7mnFn2FK/+XdA8HX7ts10hSBdqKkA9dgEBzAiJCQwn2RMOF8QMrsAq/SG4g=
X-Received: by 2002:a17:90b:384a:b0:3a7:b260:9ced with SMTP id
 98e67ed59e1d1-3adce0df80cmr214914a91.58.1792706274022; 
 Thu, 22 Oct 2026 14:57:54 -0700 (PDT)
X-Received: by 2002:a17:90b:384a:b0:3a7:b260:9ced with SMTP id
 98e67ed59e1d1-3adce0df80cmr214909a91.58.1792706273547; 
 Thu, 22 Oct 2026 14:57:53 -0700 (PDT)
Received: from pc.taild8403c.ts.net (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3adca62e477sm648061a91.2.2026.10.22.14.57.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 14:57:53 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 06/27] target/arm: implement get_dump_info sysemu op
Date: Thu, 22 Oct 2026 14:57:25 -0700
Message-ID: <20261022215747.2479440-7-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261022215747.2479440-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261022215747.2479440-1-pierrick.bouvier@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: ywqwQURRLRn625pOwQrdI8CrkheKymPa
X-Proofpoint-ORIG-GUID: ywqwQURRLRn625pOwQrdI8CrkheKymPa
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDA4NyBTYWx0ZWRfX1Sn6XKqGIBT+
 EdzykYSufjdfKYMgSUIWPcOX8xI02ainupI56+YFHzabuoDtKrhReAO2wgcs+WRdgaFyBWb6dxx
 SjuKExBpUH/admHdTmHRyS6tlyC0KGg=
X-Authority-Analysis: v=2.4 cv=G4OJgNk5 c=1 sm=1 tr=0 ts=6ada86e3 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=20KFwNOVAAAA:8 a=yPRlV_JfklmHwqd3OFsA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDA4NyBTYWx0ZWRfX+MbmsZrm8JG4
 xdDy41j1sHXuIypbB3oTJaJBOVPn2xcTm+VmmehO1tMjY3lGD/aEZlccxexuV04C2QIAgNyfnN0
 j2toyWjB59TXumSa44r3jbyAy9+wvQx0V3a/Lgem/PFyDZonZnFxy5W+oYZ63E/CHspycgKa/xs
 uffQyTK/xXC5rPk780su8leBGTPWXMYOUMI+hT6AVkDsBLt12fOPO/94Iw6uFfKSTS31msKEpnh
 dthYkTjc6O9pSQubewtuU4pkigOaF9GZe3v2fqIdDJ42RaafyZ3xFtMDkKV3l1Ynr35RZbL3agH
 w6VBNdTpIIj5Tg2oTrv8bM8jvTr/4hhqBBtb5/pHaLPOaf12M/mGtWeLdowU9c72vcdoFk3O2y0
 D3MdQTVy9HLYr7xHvK4BCsu/vYomE8e/uinUqC4IhDDftsFo1uA2EbCVL+sHMZOi/iQE4a+SbEi
 6oIMGxekkuWZdHaIKdg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0 bulkscore=0
 impostorscore=0 adultscore=0 malwarescore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610220087
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
Link: https://lore.kernel.org/qemu-devel/20261021181244.867840-7-pierrick.bouvier@oss.qualcomm.com
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 target/arm/arch_dump.c | 24 +++++++++++++-----------
 target/arm/cpu.c       |  1 +
 target/arm/internals.h |  2 ++
 3 files changed, 16 insertions(+), 11 deletions(-)

diff --git a/target/arm/arch_dump.c b/target/arm/arch_dump.c
index 1dd79849c13..3ce6ba1d68d 100644
--- a/target/arm/arch_dump.c
+++ b/target/arm/arch_dump.c
@@ -385,21 +385,14 @@ int arm_cpu_write_elf32_note(WriteCoreDumpFunction f, CPUState *cs,
     return 0;
 }
 
-int cpu_get_dump_info(ArchDumpInfo *info,
-                      const GuestPhysBlockList *guest_phys_blocks)
+void arm_get_dump_info(const CPUState *cs, ArchDumpInfo *info,
+                       const GuestPhysBlockList *guest_phys_blocks)
 {
-    ARMCPU *cpu;
-    CPUARMState *env;
+    const ARMCPU *cpu = ARM_CPU(cs);
+    const CPUARMState *env = &cpu->env;
     GuestPhysBlock *block;
     hwaddr lowest_addr = ULLONG_MAX;
 
-    if (first_cpu == NULL) {
-        return -1;
-    }
-
-    cpu = ARM_CPU(first_cpu);
-    env = &cpu->env;
-
     /* Take a best guess at the phys_base. If we get it wrong then crash
      * will need '--machdep phys_offset=<phys-offset>' added to its command
      * line, which isn't any worse than assuming we can use zero, but being
@@ -435,7 +428,16 @@ int cpu_get_dump_info(ArchDumpInfo *info,
      */
     info->d_endian = (env->cp15.sctlr_el[1] & SCTLR_EE) != 0
                      ? ELFDATA2MSB : ELFDATA2LSB;
+}
 
+int cpu_get_dump_info(ArchDumpInfo *info,
+                      const GuestPhysBlockList *guest_phys_blocks)
+{
+    if (first_cpu == NULL) {
+        return -1;
+    }
+
+    arm_get_dump_info(first_cpu, info, guest_phys_blocks);
     return 0;
 }
 
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 81ec1ce21c6..7bf0c5e74f8 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -2569,6 +2569,7 @@ static const struct SysemuCPUOps arm_sysemu_ops = {
     .asidx_from_attrs = arm_asidx_from_attrs,
     .write_elf32_note = arm_cpu_write_elf32_note,
     .write_elf64_note = arm_cpu_write_elf64_note,
+    .get_dump_info = arm_get_dump_info,
     .internal_is_big_endian = arm_cpu_internal_is_big_endian,
     .legacy_vmsd = &vmstate_arm_cpu,
 };
diff --git a/target/arm/internals.h b/target/arm/internals.h
index e849e357cfe..8c1c6e7c44e 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -438,6 +438,8 @@ int arm_cpu_mmu_index(CPUState *cs, bool ifetch);
 #endif /* CONFIG_TCG */
 
 extern const struct SemihostingCPUOps arm_semihosting_ops;
+void arm_get_dump_info(const CPUState *cs, ArchDumpInfo *info,
+                       const GuestPhysBlockList *guest_phys_blocks);
 
 typedef enum ARMFPRounding {
     FPROUNDING_TIEEVEN,
-- 
2.47.3


