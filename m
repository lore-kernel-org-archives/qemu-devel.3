Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B766CD4F26
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 00:08:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcB9x-0008AF-Nb; Tue, 23 Jun 2026 20:08:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wcB9i-0007vU-GV
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 20:07:50 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wcB9h-0003Kc-1R
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 20:07:50 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65NK04Lh1191161
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2026 00:07:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=q3VKOG+bLiR
 yfEcN4LKgkHdSXA4OOkMf38y8s29WJto=; b=R5MKMGEM4osw/GWnPLLTKomQ8b3
 /haddFQzjiQsjvNyZxI3/GCNUlAk1wQwABkuwBL3zBebKVF1o18duHfnK68APyos
 1Fotp58Kn/X6itsWTjieH2iZvo/R33AeQi7SuWvc2Lq7afTqcQul8P2gP+180exc
 4O8R8GiNTaIqvwl8KzKI35DkIVH1sNefMa5/4OBWh5aYVdR30QZ7oCkWkyocoe83
 hvIeHu7nCTfj11Ze5ROCkjgQhGhEyNfpXSouMGFrZKmDFRjgpg16ZUHZJjh+QzNq
 xdQaztt9gSnt8N+6Xbf3Hv2hFfMdBI8ckvXEEBPUGb/n9NvUnWY87YLL/Jg==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eytvh2ex8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2026 00:07:37 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-51a1460e3d3so9006591cf.0
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2026 17:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782259657; x=1782864457; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q3VKOG+bLiRyfEcN4LKgkHdSXA4OOkMf38y8s29WJto=;
 b=kR2n+okZV7O4Hjp5KUUvTN5ZinYtTzM8swvO5zNO7NVSRXnaLo4UtL2Un1/UBOj5p+
 6FVM3RHpJQI+Js3DZnh5PsZdYxDMnJ1DcxwOFEwgYt61VpN7+tCD5cVgs6iWyyRsl6MY
 mSjjYu7r34lZEABnVTwCnYnaOTwpT02og1M6fSIYt4Y1hmELaxln4wBkQgDAFozJQpEo
 cr1jUSLs4Qk56r8GTg9Q6qJaOzNc2QUxctz5eNopq6lGeVDzeW+Hr7CKr5FhjJa5n+PS
 yYWGcN7LtEkMtJc4v7V+VfJipuXumVIWxDu9dH1vx3XsES6GaEfdTLaShzxcg2rGiql/
 v46g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782259657; x=1782864457;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=q3VKOG+bLiRyfEcN4LKgkHdSXA4OOkMf38y8s29WJto=;
 b=DLKnvcdRMy6jvQhDS47v0lu0cL0lbi4F6r79HU271tt2XcyGfrBQqgsk6DVZYY7dn6
 gAd9H4RpJsIX7PliLD3RM0XnU0GINw3mCSFW21ggyLF183t7gygebj9PQELn3nXjCTqA
 LnsUghZmykOiiihq74LC5GicRDF2Xkhy53lV6ywHS2xndB2/TRQV+DlZfTnuutv3f7Rw
 0BB3xEbrAfCV/E+iH7ZhGsyyGgXRrooyhZs6lED3K1aI72PlLSE6rJvO2o94RhMVdEzI
 67otfSJih5uaoVmDn940D2WdHnGN6Zq3twqQ7xnbK6tR8sWXZDosh2sjB/wiGyU5Zgki
 0Dcw==
X-Gm-Message-State: AOJu0YykPbOw3sxPlUxH3vUte+Mcq7xTnYAd5NizqOcITiLUtriOK0sl
 CNfcArmhPBsyft9j9BXfgEQzlff0kkitjMzqvi8kP9b+Y+CtBoABe+dQAbMj77Lt7eKKVIGYRtA
 WdW4gWXafDxnA+AXKQ5BGbV0E3fEysGzezVconYKVNGSmeKQGJpJMyOO9v6exfnoxCA==
X-Gm-Gg: AfdE7cm6ROR8gWPB2507A0mqMSVGF+hIUXnXlO7e1iC6gvcv3SeULTk24FNKR93dz+a
 nYItwujTg9NAQf9Azj9Lqio1Hjk7j8sDY7aJMcuwt6EEC7WaQEeQ71wae5Z1h6jQGGQoD7MEqnB
 Rhs9HI8bbkHovwBWJu3QCijxmykNUbxLYkY+36CxwYZgHr/7Z8kvgJafAMmGz8HhsRbQH4BuiZP
 bEdzWaiQ+AgiTlo3haLEYN1MKucOTaAV2RGP7N+dDcDwtf6Jg9WtOC46RVHpIN3j64C0ktdGjzK
 gTxyIdIlb7oP/LVH4UjeeKdGakLu6nNkylWbZPIVzIaKPSQ5o36EvkGnxdFWEEgHPlLS2iRSf2I
 B1l3JJlfglX4Tti1ZEztKqin0/dHKJ1suKksPFpwAJvivhw==
X-Received: by 2002:a05:622a:1a8d:b0:51a:1a44:101f with SMTP id
 d75a77b69052e-51a61b4c2a1mr20603531cf.21.1782259657167; 
 Tue, 23 Jun 2026 17:07:37 -0700 (PDT)
X-Received: by 2002:a05:622a:1a8d:b0:51a:1a44:101f with SMTP id
 d75a77b69052e-51a61b4c2a1mr20603031cf.21.1782259656791; 
 Tue, 23 Jun 2026 17:07:36 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([189.79.21.40])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8df81cdec56sm142422976d6.32.2026.06.23.17.07.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2026 17:07:36 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 pierrick.bouvier@oss.qualcomm.com, philmd@oss.qualcomm.com,
 fritchleybohrer@gmail.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH v2 19/24] target/riscv/gdbstub.c: isolate TCG only checks
Date: Tue, 23 Jun 2026 21:06:26 -0300
Message-ID: <20260624000632.2149359-20-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260624000632.2149359-1-daniel.barboza@oss.qualcomm.com>
References: <20260624000632.2149359-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDE5OSBTYWx0ZWRfX/7Isx1TyvsJR
 NO/rYsimUONm0+562hOiHO0TtjgeaHM3V4XqhOhiKBc/w4k552IJQrzp1C6OGMytAUaD4kHasWS
 kyPgn/TcDoxIR6J2UqDpswo3Wj75RKi3sLu0EYa+E3qzGc93sJhtoSC0swBs72adSC8dEmriBfF
 p8PpVSRqfp90wSclvgYGCVqpjMf6K1O/9UznXaA5yVxOdxwLURObDMkTUh4Zl9qvLLJmlKrTMKK
 tP7b/0lJAAgfiM5r4FOkRpxUFdYm7Y9RIt8WmZoDhE0rEhuDvbBRcbprBX1yXgKSMzYOIm/flCk
 Z9GlZHW1mteJnslAMT63jbmBc6QBnD/uwzEVoOq5PQ8XNeIBk4CZP4LB8t7iblJczUlxRj/coJ0
 QCOTZGA9v0y5wC2TkWbf3bwA+N7SK741bkgsnTfWoBSJFTFTGQyuatxTkeE16/jOH3MovN4lalN
 HQ7ZywsAbdbAHJy573w==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDE5OSBTYWx0ZWRfX20oEzb4MN6Yr
 gIHfmlX7hhsO8mr4VZL1xfmHyepSIbg6OF2EDqnffcxNUWuApRnk6B40P/pNwUuEbsV+bO7n35l
 Lybp8tHq/slXSw9tHmZ3HCFcLmSQjWI=
X-Proofpoint-GUID: mPW8hoPV9daV4vmPWJHBWf267QHx_284
X-Authority-Analysis: v=2.4 cv=AJDhMgPs c=1 sm=1 tr=0 ts=6a3b1fc9 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=sHJf4AwOIoU3qjeHFPlg6Q==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=m8F5ZJ-s4jyFCOPQnU8A:9 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-ORIG-GUID: mPW8hoPV9daV4vmPWJHBWf267QHx_284
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_04,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 impostorscore=0 clxscore=1015 phishscore=0
 malwarescore=0 suspectscore=0 bulkscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606230199
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The following functions are TCG only and are broken, if they were ever
usable in the first place, with KVM:

- riscv_gdb_(get|se)t_csr
- riscv_gdb_(get|set)_virtual
- riscv_gen_dynamic_csr_feature

Gate everything with TCG enabled to at least get them out of the way to
enable --disable-tcg.

As a note for the future: other archs have distincts gdbstub files for
each accelerator.  There's a strong case for RISC-V to do the same.

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 target/riscv/gdbstub.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/target/riscv/gdbstub.c b/target/riscv/gdbstub.c
index f0a5e0d86f..9abbf5bcdf 100644
--- a/target/riscv/gdbstub.c
+++ b/target/riscv/gdbstub.c
@@ -164,6 +164,7 @@ static int riscv_gdb_set_vector(CPUState *cs, uint8_t *mem_buf, int n)
     return 0;
 }
 
+#ifdef CONFIG_TCG
 static int riscv_gdb_get_csr(CPUState *cs, GByteArray *buf, int n)
 {
     RISCVCPU *cpu = RISCV_CPU(cs);
@@ -294,6 +295,7 @@ static GDBFeature *riscv_gen_dynamic_csr_feature(CPUState *cs, int base_reg)
 
     return &cpu->dyn_csr_feature;
 }
+#endif /* CONFIG_TCG */
 
 static GDBFeature *ricsv_gen_dynamic_vector_feature(CPUState *cs, int base_reg)
 {
@@ -336,7 +338,6 @@ static GDBFeature *ricsv_gen_dynamic_vector_feature(CPUState *cs, int base_reg)
 
 void riscv_cpu_register_gdb_regs_for_features(CPUState *cs)
 {
-    RISCVCPUClass *mcc = RISCV_CPU_GET_CLASS(cs);
     RISCVCPU *cpu = RISCV_CPU(cs);
     CPURISCVState *env = &cpu->env;
     if (env->misa_ext & RVD) {
@@ -351,6 +352,10 @@ void riscv_cpu_register_gdb_regs_for_features(CPUState *cs)
                                  riscv_gdb_set_vector,
                                  ricsv_gen_dynamic_vector_feature(cs, cs->gdb_num_regs));
     }
+
+#ifdef CONFIG_TCG
+    RISCVCPUClass *mcc = RISCV_CPU_GET_CLASS(cs);
+
     switch (mcc->def->misa_mxl_max) {
     case MXL_RV32:
         gdb_register_coprocessor(cs, riscv_gdb_get_virtual,
@@ -371,4 +376,5 @@ void riscv_cpu_register_gdb_regs_for_features(CPUState *cs)
         gdb_register_coprocessor(cs, riscv_gdb_get_csr, riscv_gdb_set_csr,
                                  riscv_gen_dynamic_csr_feature(cs, cs->gdb_num_regs));
     }
+#endif
 }
-- 
2.43.0


