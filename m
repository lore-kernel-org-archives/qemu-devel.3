Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0799FC44501
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 18:08:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfiJ6-0004Bi-MZ; Fri, 03 Jul 2026 14:08:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wfiHx-0001mc-1r
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 14:06:58 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wfiHu-0002NQ-4G
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 14:06:56 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 663HieNX494926
 for <qemu-devel@nongnu.org>; Fri, 3 Jul 2026 18:06:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 jZaXgUH/3rGreNYPT3bs5MepxGSZa1PaqN2c3deVVls=; b=SCZKZ95ZSH7VEkh0
 /uI+eZ4EuNPnaRnEWvrL/6h3Adm6KPHm9r8f2wHvHpDl34U3Jr2ENpkOzF84qgFS
 K73nxYBXEZp2P503O3J64Rgv8+iYb/c9rrR5aNqIqSIpP6lj2Y7ddYgBLKflUHg9
 ACCOV3J+CW1dOpXQS3h6oZoPrWNyQlPNDGDZJJWlLz+h3PjGV8OMtPARrOJpqfwE
 FgwlQlQA2gN6b7OvBWiRe8KO3I2TmgqzXc396jGL/xaGRG4q4ULzFR/PRQhoH5MY
 fmS6VdhcZK6x3ffJt9n5XztJItUF+c1yNG6ndxLEXUbSNnA8s4cv7D0OcaReFFsa
 i3VyHA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f68jyta47-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2026 18:06:42 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-51c1b4d961dso7212061cf.1
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2026 11:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783102002; x=1783706802; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jZaXgUH/3rGreNYPT3bs5MepxGSZa1PaqN2c3deVVls=;
 b=Bbur+KB2yVSXMIlWWS2PJ2ZaIgaayXPvpsbatllMwKlzxFvkl1STSyX4g4imLNME7z
 3KJL7ZPsP/KtFsv0o6KBxCPJ0dzERvh/CspgRC+VRrJ38e89JAHOyEpp0C/VMBuE9IvV
 3AP4Y3e/wJBQCulE+guBaMGinxJjN5ky3B7/xrF776D5dLpvDsOzfEQz9mMlrqMrue6N
 weRUkQ8/sMzzRIiT6n/VRZjHQTEIMtrIVAbs1cw9t8m89dhI56wy4klHsYJ10vDeS+ym
 RCIilFaQLM0OKALQTuDtBuBosH9jA5be8fTI6JI8ucQfYwEql1SqXD0tpFv+wVP6aH+T
 ccdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783102002; x=1783706802;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jZaXgUH/3rGreNYPT3bs5MepxGSZa1PaqN2c3deVVls=;
 b=bqQ/ys91hOUhgFVfx7AxBQgj6LKQHqKpV1UYIrcZ5FLrogeyeHQIAmzjOvpX/R3N2C
 uocPrEN4jg6dipUtoCeyPDYuDzGcv5ZRmF2jkulAK7fDBQOeSDsmbIRQsgF0KV/f052r
 wNZUWCJbygAGkRNZUpu0keh2s3dtplYQDvTopX1wOQhPofP4SRewbsyHjwW37ZkA/mQu
 b73WuEvUrZciJaHOsRMPlOaEi/WYVSUS1InMWoU6xNUvCDrljoT2oA6wZPNF4uIJorxq
 1qKn1d8yf3VHKKnh2/bL0k+VvYJLzKsRbcfnvzar2Nj1sIgFcT7at1qz8+SJUTMRGpEM
 3ZSQ==
X-Gm-Message-State: AOJu0YwGr4lOzNv3+QAvCu1JcPzzTC6pZG09Fso7Rm2/I43XNCLb9qVE
 2oED2ZTAwCDqrUAApPQFslXyCKmFUVFfCjXX36nSfUqB80qnvZRLYo6EUUmja4X7cso+kE4J47B
 sISvX+bLQQqDew8sL/Smu8sP5W0cHYlDBimtfbzWBpVxYcn4w+WUGnu/ICEPZDO8U0w==
X-Gm-Gg: AfdE7cncQGHPXcREQ/hpd8QZoZIUkhM9aPzwRBbh0lyR5tzJ8z1Tss4jZyAiEjPVaAN
 bCo+pYqH1vo2FuaHlP6X9x6iYZfXhbnMOLiTAx6m1q7NjG9oFq/z7wso14gqqto937cdzj16aCJ
 HVXKEOevBMMV/FnSm3Wl+gDtM8GvH451AKY9skQDHbxMQn6JvcpDnVe+3dikmMX3HZA0AoNINm3
 6R69SGiw8FCW8l7rAlAAI/E4yM8u/F/TAqxRHWElr9tcI1UCZSYvq5ePohEyYpDFWCxnt7bJGwA
 E8u0KC5Ilp7CFtUa4JkVZXAfD+XtmBH6wpVcvd4dPbmUkEuwxHnA5Y7FkZtiW8ZrqNrJvK79Vum
 HnVL0P6K443cbkTKmUSN40NvbwQ/7t3Frf1SP1DcftFounw==
X-Received: by 2002:ac8:5fc7:0:b0:51a:8c86:bd2f with SMTP id
 d75a77b69052e-51c4d1a0932mr2191411cf.36.1783102001693; 
 Fri, 03 Jul 2026 11:06:41 -0700 (PDT)
X-Received: by 2002:ac8:5fc7:0:b0:51a:8c86:bd2f with SMTP id
 d75a77b69052e-51c4d1a0932mr2190901cf.36.1783102001163; 
 Fri, 03 Jul 2026 11:06:41 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([189.79.21.40])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-51c41d2d688sm22560081cf.17.2026.07.03.11.06.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Jul 2026 11:06:40 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH v4 19/24] target/riscv/gdbstub.c: isolate TCG only checks
Date: Fri,  3 Jul 2026 15:05:31 -0300
Message-ID: <20260703180538.3346781-20-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260703180538.3346781-1-daniel.barboza@oss.qualcomm.com>
References: <20260703180538.3346781-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDE4MSBTYWx0ZWRfX+UXynVYHI+hs
 ADfEiho0TnMTDgGDaPk/9i1WD1m6Vs2tYuZ0logd37dNWKFroBWDNou1OTmaal+p5tHaUuef40Q
 WpU461R09sWQpIq5Q0e+cxQV3R3weq+2pJQnx/evYG9Ar/g3qp+EitEVgKhNId3+DU9GmDDkSgG
 C3oJeDYoNADGYWlbMQY0KabYDNDKgqbLQRE825ad1Yc6mEf5sHF1Ycr9HoNMklym/478aFGw8bR
 LPx+ARnS/7dhQ4e0+qPkkO3u7/wRyQaGxusJf/yGGU+RnxsTd2iTMGd3fOKIFllI7UBdADJyOx8
 1nXjDWed0CCCTY6Txc6ML99y2WEkE/9AU99l/1/deD1NrNmdHLrb4D35x6IhDT1ZaK4Uwyhnep4
 fNJ8lQv8FfDL5D4cqfjwCs7Uu3ppYwVoLwTR4XHWIHZ6QX2EiOnYGXcEmiLrpspT+ZowI3gTrLv
 iuzhx/Kfj+E45fEHGOQ==
X-Proofpoint-GUID: LXLBvfby2KBmYWcRVZYNgwHG5Xu49N3n
X-Authority-Analysis: v=2.4 cv=QbFWeMbv c=1 sm=1 tr=0 ts=6a47fa32 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=sHJf4AwOIoU3qjeHFPlg6Q==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=JF9118EUAAAA:8 a=Muc6iJuzKOfAuMMkZh0A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22 a=xVlTc564ipvMDusKsbsT:22
X-Proofpoint-ORIG-GUID: LXLBvfby2KBmYWcRVZYNgwHG5Xu49N3n
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDE4MSBTYWx0ZWRfX6ZO0lisGkCkf
 J2ceWEQyhKb3q9NO03RyY0AUuZ4yhbDuQgBojv7IaOIdDcr9W6k8f75H8daymPFxprkGQkLnt27
 jvw8NkYgSgMr2gNPAUm4qviW7ZwAH4o=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_03,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 malwarescore=0 suspectscore=0 clxscore=1015
 bulkscore=0 impostorscore=0 lowpriorityscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607030181
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
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
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


