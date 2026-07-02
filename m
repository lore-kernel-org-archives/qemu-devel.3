Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BD4CC43458
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2026 13:53:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfHq8-0002rB-W4; Thu, 02 Jul 2026 09:52:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wfHq8-0002qf-1Q
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 09:52:28 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wfHq6-0008Fo-EI
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 09:52:27 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 662D0YRR417152
 for <qemu-devel@nongnu.org>; Thu, 2 Jul 2026 13:52:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=nY1z6Bbeb6j
 aM44Jexap81Fs++lqMCjWMArhNgDWzas=; b=YtziHT6x/D+5XaNcJI/w9dhb88d
 nQS7yVjViTL64xjLIsBB3JJZAvrpu9/JTYbbmlta5meTgdHqQZLgdYn8qRqEL26a
 zSUckVwW4jBWWb5IRj+gEDf1izvSoTg1Z44Ifc3MNVXzJYKBtQTDokZOEy7FWUYm
 1Sc5xuxv0NSd1t08a9AwK/l0eOKFc8tmctB3lkodwAuh+jJaHi+IHGEoaCnUXdbR
 icvkPGn5w1b7eOZO8Yymk8cunZV8YzlLHyRpHWqY0ODG8V8Hkk6v8eRSAiYMpo+3
 szDC2GMLV0tdM8im/vmaPe7uH43/7osIMt5tNVLoKxiNyC+5g9nPqe0qvbQ==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com
 [209.85.217.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f5n9bh1hk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2026 13:52:24 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id
 ada2fe7eead31-7382fc429f6so1979542137.2
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2026 06:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783000344; x=1783605144; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nY1z6Bbeb6jaM44Jexap81Fs++lqMCjWMArhNgDWzas=;
 b=RyJ+ZIsa8PzkhcIgGT8bWAL7uBnB3wztmTzga8VwvjXktcpFZF5NQRTc33wDsAIDn1
 3WBVbyS8HPUvJGnmH7IIeKs3MPyG1QxJsvtlMZRhXgNgKdxK9CCuORUeGc3ugj91cXkR
 /PG6fob6KrJH7lxNm3/3NycKgcfusxMERU0OGXxHx9QPk/VeVO6yrZbv5C2Pliki2xjT
 HJ5SmSv6nkjMV/RI0MQ0uqkUNE5Ed2H0PY5eem4rC2BFVTnK6+mo5V7250BCxZBmVEpq
 X+gskeSTb6cnFI3iRcXKB1uYHN8iHLaMvgAM3pkXm+8XaImXa+1cHVDo4QITo/kaejGe
 VKBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783000344; x=1783605144;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=nY1z6Bbeb6jaM44Jexap81Fs++lqMCjWMArhNgDWzas=;
 b=U2mTPcIuuG5CDPoIHTEMB2f0R+tZSIOhF/YcoOUHJsU6QV0fBCWcs9l4+weN9sgiW+
 bIpK8E5uenNkK3FpfPPJIhkgeaxfvmHBC9pw67tHhUqWAEl2yBYT9l7nIv0/JUtDNK3c
 Olo1bMA0FsH+pO6GxAXnB1FN1JbNzgkRlJTG+nNRISbucRy7VJw86/DQD29vbpD9vC1/
 NmYJmmp0X/7IAuAT2xb6FkFbFAj1dPuccOoTBks2fO8e1t55JifIDRt1CI8LwecETeDd
 wCqjbgNz9rX16dXCDrBqOUBQYxaEQSisEr0HuvEqpfw+keMPF3WouJcev6utrQGdTOab
 bzvQ==
X-Gm-Message-State: AOJu0YwLD5M5637T71gAA16kej0joHshnYGvZiRqprJEJueB9XxAY8vc
 nOcXJtox+ThQUrlhggLSSjvgJrNxhfNH3fdTtMPgc7r1e90G1e/m1z/ni19hccj6S1nI/6mqk/x
 GAZ3HPhszO8HaG/DkA6hEArDLILy99iDaMmDTvwuwCXz/zFDswfMvFECr/rkMdaPKrg==
X-Gm-Gg: AfdE7ckmuKUDecBKAU/y31IANXz4CPsfDFP/zsBILT1074EGaPIdspFkNWB8pNVPIIt
 fijBYxB+/Yc5KNTnpejPIAaHv1W8ME9qL5Yb09NNtszrr6nnuW+sWsG86kK2/mA//0Yx5QFOyQD
 WA54/A44zkYKu623wH+HIEb1sf2RJEgYIXsgYbx9YowgwMycUB06pF7YZ/0dgP416GoKnJjcRen
 HRha/zcgKcZ1KMU4zaZSiWERJwNjheGWmXrjSR/skDRAatKApUM0FK+RHgSVlVCd+zoGCW2n69I
 71qqbO6SgqlxMw6OL0Q3Sw1TSVyjhNrGllvTGrRpgebEmNFjK5MQqXoXEQzv41fhBnwlKtmXB3K
 Ud5sT494wh5ofrIm1g6sZ2oWIlNPgqqzqQKfnkJjiAHPmSA==
X-Received: by 2002:a05:6102:41a0:b0:737:80f0:7885 with SMTP id
 ada2fe7eead31-73daa34b043mr2772685137.28.1783000343890; 
 Thu, 02 Jul 2026 06:52:23 -0700 (PDT)
X-Received: by 2002:a05:6102:41a0:b0:737:80f0:7885 with SMTP id
 ada2fe7eead31-73daa34b043mr2772639137.28.1783000342894; 
 Thu, 02 Jul 2026 06:52:22 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([189.79.21.40])
 by smtp.gmail.com with ESMTPSA id
 ada2fe7eead31-73e1c4e64a3sm1276462137.9.2026.07.02.06.52.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2026 06:52:22 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH v3 19/24] target/riscv/gdbstub.c: isolate TCG only checks
Date: Thu,  2 Jul 2026 10:51:21 -0300
Message-ID: <20260702135128.1188021-20-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260702135128.1188021-1-daniel.barboza@oss.qualcomm.com>
References: <20260702135128.1188021-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: bQK1wYfj_BvDUubsbFI-S1yocD6wSPO-
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDE0NCBTYWx0ZWRfX2bjzm1ZJUtey
 QjYIOSr8WkjbNydhBZ7HhAJ40HKaA0zxrGR8nN4zDR6yLmAlZQSFCC/gqq2hfdGhzog6Q3mxR6L
 sJTmqd6uw1tRKlJqYJX1sxirxh8DgBw=
X-Proofpoint-GUID: bQK1wYfj_BvDUubsbFI-S1yocD6wSPO-
X-Authority-Analysis: v=2.4 cv=bOom5v+Z c=1 sm=1 tr=0 ts=6a466d19 cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=sHJf4AwOIoU3qjeHFPlg6Q==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=JF9118EUAAAA:8 a=m8F5ZJ-s4jyFCOPQnU8A:9 a=crWF4MFLhNY0qMRaF8an:22
 a=xVlTc564ipvMDusKsbsT:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDE0NCBTYWx0ZWRfX0wD8VgGQMyFs
 Ev4S920myADAbResqAJxSDWBlt3mvRrxXoIYjSZFgblJbYeOK69/9S17NAOjuPD1il4Lvpkkgc8
 LcsZhtYjhTHjdQTPTKH3iaBDmAu4gD8A335wSwggNFMZNvxzYMkRNE1baZ62PrHbqiXE8HFMx1h
 YymzWdi00yfIbEpCRdmuwswD1IoXZjCuKDnYOSgaxoZg9UGLXFGbxeGK+K8qOiCEnaHp67hCG6V
 2HnRElN0gwwk8YsaOQ+Cyvuqt3pLGyN1ShzU9gdgrP+ryJMN9vVp+1MhSqlAj7mFwkPtqZIvDQu
 FOnSEu0i0M7Zya6UEjhTPaCWXdtEUuT4lccDHlEsRpQjA+xv6hk3E3e4wXZM2UoXRLYTgCjEh9l
 dEbmDJHu9joRV6i5SX7Ohd8dxJkkTJbbIadR9ElHUBBsl5F8ovwuNyj9lXUcmXsJFa+EjrzZSAG
 Y+cP+7RncOxwRZxvFBg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 clxscore=1015 suspectscore=0
 phishscore=0 priorityscore=1501 impostorscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607020144
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
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


