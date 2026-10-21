Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BADC606A319
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 18:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=I/gz7Qfe;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=XxHU/JHA
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJaoG-0004OT-5G; Wed, 21 Oct 2026 14:13:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xJao7-0004MD-5j
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 14:13:00 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xJao4-00082T-Vu
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 14:12:58 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69LHpIYA790725
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 18:12:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 fejO+kq6XFAivGndPilBb+hTqkQbrBhnt+3RSJr93Rc=; b=I/gz7QfeWMwyRSHa
 lvvNvrikYNF8VI919XOwob2sJ6a8BVezBARfdjsXsp2km7L38pTAqONndKlPNIRH
 jfvfKnUdBaTzkIjFfGcskar6fnd40kMEbXiAf3hed78NhcVwiOOVjPI4VeY8UPul
 G5KycHlvMSsd6Runio+i/yPhOYWGKLR4S5ZZJ6HmZFXCbU9QstsGxEgrzliRgibf
 YEGXD9vZ/cbflE1U9SbPS0esseL9HRFsmJHIKuBRxpgGqu8f+Ur8yULbxgv/Xd34
 FfkD7ZAZrAlmzeVflJKzzrLUnsmpRRvIhxn4ICKipN7e6sOVPKgFYSIIZww7vKnv
 Gz/Gmw==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hf0cv0myx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 18:12:55 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-3ac450b74b0so1724460a91.0
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 11:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792606375; x=1793211175; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=fejO+kq6XFAivGndPilBb+hTqkQbrBhnt+3RSJr93Rc=;
 b=XxHU/JHAzZItTw8tGIPzwTNnohM7hY3inwyLo2DYE6ApmOl8FCtl2Gy6Cyrp8q7WdH
 9zRFX0CIt0UDxiM4UQydHnL5lNn0FSplwCf3VG2R03WMHlwylRM5BbeSO30r3owikr11
 wAwl9nSyFVTAMHuZSfMV0EQ+wg9+NV7ZbHGt//kvT+e+usMbnxlZ9Tx8lg/RM9O9ZDjI
 hOAJjSNut/qeCP66HPkl3We5F/0IMiv+VSSs7jGKOy+SpBbNya4tflDGeKjh9B/dUF8F
 d3ShGxOksgxu98VYGv2QeRAIFz/fNCakrk2wFP4VzA0FjKNhUwYeEzOgov0i1ttzJz8f
 3NxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792606375; x=1793211175;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=fejO+kq6XFAivGndPilBb+hTqkQbrBhnt+3RSJr93Rc=;
 b=vFVoWzmIUUUsyhT3Zxe1QRzkaoizqxrIfvamsgn3MuuEsy4BWR/T/SOVwP0/L3Qx5o
 jWGpL0KsDScKJ1sc5AdBVM8qxJl8mfRZyMZhb7mcKVd1zm4I5SHdKzS+k81+A1DgDomi
 VymKkVaQdGeMDR3xpwpPvkOVPs7QebHRrXHIN2KjRk3TAcCizCMuLGcpT92CbWggHvoJ
 un0bW1k4zaL1MoCtOLTtUwWg+jDP3i9xK445S/2jLPNBC+8nGYld/dyLxC/0cabljNyr
 mz6jxniMm0oijJsdPTahqtGLzql4mPIo++Lk5Ga9/D+5fn/LOJBsCDhia/iZkk1LHSrN
 EfQg==
X-Gm-Message-State: AFq9FYJgUBRXAjuN+e7aIPpti8J9p+00cchvMx1FftmHr/QpptRb1dkF
 +Lr0x9XcIJwSbysBWThklvT6NBDV86ZfEjBL20eHqQ4PW5g/Cb5QGo4Tum+iACg/guciLZuIGIh
 u0y5/XdU3Pk+K1rM3f7UxJOOvFTQn69cseetiEUtREpRoZSX+66JuUSD1hV2cz/nh0g==
X-Gm-Gg: AYBFou2pY4R20QHYLUhcKoy5X29bywz1ghHbLfiAKKhQ7fWt5U0Rt+qFLgp/RlWf9jW
 HV4uCWnNQxCtBXRdr6xwiODb6RicFOx0vuV1HJObrfzP2aqjVB1yRmChFsXxKJm/Zi1J1VGiVwo
 boZa2UsHVClb/msx41rbWu5RlEAGENowm8vKE73rqJtVBs8fZuiDinU1VtlraBwIovCA63rvkVL
 of7g599UWplYtrnnOAh3F5wfmS/HSF/WySfhLG3NI1gknkIZ45Bu/4igVOK/BwBoU5CKmaY5Z6l
 BTjSKPjst0BIQn69dsfXcV/Tb7l9nyZR3tVgNgZsXa/9/zZdM/J8px6XeaBpd7YmDH/cupoQdew
 uG0CNQ0K5CghXajh0d0VrB+Ajd/GfJf0Tdoorzrqltok0izrBrqaKoLmUzgeOk2s=
X-Received: by 2002:a17:90b:1846:b0:3ac:9e76:aa76 with SMTP id
 98e67ed59e1d1-3ad86c7993emr2285969a91.13.1792606374754; 
 Wed, 21 Oct 2026 11:12:54 -0700 (PDT)
X-Received: by 2002:a17:90b:1846:b0:3ac:9e76:aa76 with SMTP id
 98e67ed59e1d1-3ad86c7993emr2285956a91.13.1792606374226; 
 Wed, 21 Oct 2026 11:12:54 -0700 (PDT)
Received: from pc.taild8403c.ts.net (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ada48ed74bsm499152a91.3.2026.10.21.11.12.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 11:12:53 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 anjo@rev.ng, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v5 06/21] target/arm: implement get_dump_info sysemu op
Date: Wed, 21 Oct 2026 11:12:29 -0700
Message-ID: <20261021181244.867840-7-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261021181244.867840-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261021181244.867840-1-pierrick.bouvier@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=NrRE4MdJ c=1 sm=1 tr=0 ts=6ad900a7 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=UlvQ5ZLdSjF5flW1Q70A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-ORIG-GUID: 4EwtR70EvkN72qHrbW7eHIzKZnF3zkWE
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDA3MiBTYWx0ZWRfX7c7KDDiguXwR
 2JerKvT4lpWuPCuzs07wVQa59z97cyx/TdxBxwP+teVZs5xaeoNd+QXlX9dmb0tCotmRK0FcsvP
 dkwnOGPBwpeZfSuMz3xca09xxeOflp4=
X-Proofpoint-GUID: 4EwtR70EvkN72qHrbW7eHIzKZnF3zkWE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDA3MiBTYWx0ZWRfX9GWU+QOHylTf
 Jdaygxf2b8f/4t45edv9gScu6qyOX5Wk2gHpysfifRwZTCsf22Q50Sij4I/sCjH4iYX0qfXw9Pl
 geJ/cJLzCmT6hwoEZodh+iUhFX8cd2MFF6uShIVotUvyZPDpfZp26SIobox0e22M26Jir6iJZ0y
 mIOEbzjB0rOaOOBaL/Uoal6OgU3IyI8p0ZH8B8f0xu/CVE/K59oa+Wj9JNL1Jk5MCB709iv9lD1
 8Sc/+xH57re2JqzGwGKip0P54w4XIpxivSC1bZyVvHrqwvLEH9o/wMtPtcUucHoRJ9XO5h6rOqQ
 Gq5IyJkZcR8mX1B0C24pk4sVi9ffgqU4ljmy4oRKLhq1CsOn5FsmKSH9KQdlwcrsY+md/FqDBtd
 /R3qpVqwine7xwE64rUs5x7qAEFCVHNhlELYvNOPADxzw8anTEOVllsWyC7kjsuKT5ZuS7gd0UN
 6rqQVkFnCBlMJ8GLBEg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-21_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 priorityscore=1501 impostorscore=0 clxscore=1015
 spamscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0
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


