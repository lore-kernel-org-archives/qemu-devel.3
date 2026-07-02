Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8843EC43458
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2026 13:54:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfHq1-0002jB-7s; Thu, 02 Jul 2026 09:52:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wfHpy-0002Z3-G2
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 09:52:18 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wfHpw-000899-L7
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 09:52:18 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 662D0aYK406385
 for <qemu-devel@nongnu.org>; Thu, 2 Jul 2026 13:52:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=p7+r6ZA/ADu
 9UETUQG2EwKtMxRHHJT1XtPTNVf5Hoso=; b=pL/L52n48oBJT+K5FRsMXv6Q/Oe
 40fXZtkNhUEcBc2TPYBE5m7AQcCPBYRtJcg+tAhRJa84AEUfI3gauED6p67Z6pjA
 MW3a6xUMlFk5wnWDt7s8uh4BXtwNRhXfAk+RuaAxnGLigm+yV9jVvW5FhV9LSyav
 JTWhT7ID9O+i1fw6IsqSKsLWjyhNPNibo8DY9m49qefmrazvs+9unkC3XD4hhygl
 lPzcYptawDQW8WanyMWzXfKk1Zj/ZrvRjIwwVzPPlfKVCuaWfYoi+X6kxMGKkhGx
 zIT4Q/1FlaImFZHavT4KC/VqMWErovjhGxm4GEA6V4CmEf0d0/g738PxVTQ==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f5h98j117-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2026 13:52:05 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id
 ada2fe7eead31-737d34a0dc8so2059672137.1
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2026 06:52:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783000325; x=1783605125; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p7+r6ZA/ADu9UETUQG2EwKtMxRHHJT1XtPTNVf5Hoso=;
 b=Sx7NvknspzuI7CE8JoN33VsZ1CsRrn2kJXfEiXxDUg7c5TCmcKS+rfXXWwCI/idolg
 kIneNvVtvo/QeKJ7r3YSacV3K0gAimGBUu0wIDkzHGO6zYyPPfZ7o95oW/OFeNjnz7lp
 SwBAmf2/1Z3SkD0v573GyHue9D7/7ydFeinEJDGwSSr0ken16jIxAbdx3VRRwkXYDYXI
 uWhcjsiEQovwDmUUSiSGE50GVwwaE329YGiLK2fDqV7DXXYndvRyPtAQejir4+ce/AIA
 Sqtgjjz/kVytLxxrJstsJYYxHhJtOa8i9PGQEpnyR852QxwFyYNOhMZDmNEtX1suaU3b
 aoTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783000325; x=1783605125;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=p7+r6ZA/ADu9UETUQG2EwKtMxRHHJT1XtPTNVf5Hoso=;
 b=giwcQuXR1Ng8GHgQFE6/u1+G5107/VSFsWpCTIvRLKk6BFztCktwTCB46wgIyvMcmJ
 P99srB2SJlUxvmU3oyepzC+/QlDHgoXnx9V6bbqqkl2iBEPL1xDuIH7bG/rIXNMJp/Wh
 06KpWhJ2inHmE0B9d5/dUOEIsQEKtQyHE1ftpyRMS67eOVZpct+wD7il538VQMcwR7FS
 P/hOTwBBm8TP5+091Pn1CCP6n6+AP5Yld6lSRAg0K6QAc1C0N3aHd/f/HiG8kYumpvIc
 lQ/Yog+9cu7PlH6pLiOWhm+rxlSY0OjVr1QsLvBexEWp39Ifrq+en+6+3czCL9ZqTkGz
 myjQ==
X-Gm-Message-State: AOJu0Yx1vg73yNFHaJONp1ss2EWmX1rGnRrXJ1d4LGjzz57gnsbxXkpG
 JKYv4CCmKV58tx+gHcJX2QohzHsz3LtjobJZB7WxqPF/fWbJVg+LaIjF5z/4StqO2qSw+A6XH7c
 EhQdi60I2A/e2nBc7WmXVkKUMSQn5On9gPjozWg5uRr7GAGh0jYinfnC57wwYbx9wsg==
X-Gm-Gg: AfdE7clQf6iO9Ag+AnALO/6Rkw602nXLjz+KOLPvkrv0eqfHVDwtuNcnb9im9SdLP/I
 c/M8Ifxa9icVFJnlftS+pIbciHyXwLMIXiGE9JGRf1eLbyioGKDC6zvnxnQ5LVHkA2bA+R/UPrs
 u5kg2ZEWuwX+sB7vOmA3IcVyozmyIKl6ZziS8abIaj/ZKZm8CMiKhdNf2zBmq72bSIRpikk+hfU
 s/R7EVwrLUeBbwXPCm0mMbZcnG+ngT9ykk9cV7+CnJ4BfCxbKImZox3BlZAal1hVUPhyIlmbItN
 E0dL6amzAYDvzg3fWQH5A88naxUVfzyXkg0EAV+KIYSn2tbXAotXzsfbS+Rnl1FXGVxOP8wJq/f
 ewPa3gJnO0fnasTp+SkM8RzSTh9WUKNP5Sf/s5Oi2upWtNQ==
X-Received: by 2002:a05:6102:c93:b0:739:86da:776d with SMTP id
 ada2fe7eead31-73daacbb442mr3511805137.25.1783000325153; 
 Thu, 02 Jul 2026 06:52:05 -0700 (PDT)
X-Received: by 2002:a05:6102:c93:b0:739:86da:776d with SMTP id
 ada2fe7eead31-73daacbb442mr3511781137.25.1783000324660; 
 Thu, 02 Jul 2026 06:52:04 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([189.79.21.40])
 by smtp.gmail.com with ESMTPSA id
 ada2fe7eead31-73e1c4e64a3sm1276462137.9.2026.07.02.06.52.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2026 06:52:04 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH v3 12/24] target/riscv: move valid_vm_* satp arrays to cpu.c
Date: Thu,  2 Jul 2026 10:51:14 -0300
Message-ID: <20260702135128.1188021-13-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260702135128.1188021-1-daniel.barboza@oss.qualcomm.com>
References: <20260702135128.1188021-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: t6SeSU9fXHY-b9Lr3Vd2la_sR4FE5j5l
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDE0NCBTYWx0ZWRfX3hV+VNR6+zBq
 Ww/iUkmwFv8KL8lLp4AzSMRfIYvOBmVCq0JEXWeF698v0ofG9rGfaeUZHiPpN6zOxpXpXQDs+qq
 VcBAO6ogcgwwSW6Ra0NzYUEOqIWGi1atTTYr1/8VQ8+pV/2xMEqwdBN7r3hnIkGpJPFluZPiVt8
 Nf/gOjd0We8kiMJqjuwK5QDKCt8IPT8cRagQLx+mjJKXcHfquVk/a2SHQ69jaVAYHPuVSrpwYdt
 s95UVy5pbd0MHeI9IH8+IDuFnABXPF4mRrHQe/W6I6YzkoEjGNY9TPejPe6daagrie9CXxbXXbf
 xnmydLK7jHnAH36vBQ8jwmluEVeyypnOHqm/Xh41dkPVVGjSGl/7C3HTVKZFxdJzDfwUTxXTOuA
 N3jtnCvQgtVXpz/acQmUIAww2wE03XnIQsVRwZKZ8gx4zAGyKMMM5VGbpHq7PuXin6oNaJFaJaT
 XmZk1+uqqpfl2eFLE2A==
X-Proofpoint-GUID: t6SeSU9fXHY-b9Lr3Vd2la_sR4FE5j5l
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDE0NCBTYWx0ZWRfX5O6q3RFj8mmm
 uKucuUJmz4EJMsWr4euq3HqRwzT3FqcQ0kldbhBYakY0P9gDBhw9bsArLXpv9TPgXawm+2LsVU7
 QoX4+7UZU5SVcar/q5b+o4+linfcet8=
X-Authority-Analysis: v=2.4 cv=bdFbluPB c=1 sm=1 tr=0 ts=6a466d05 cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=sHJf4AwOIoU3qjeHFPlg6Q==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=JF9118EUAAAA:8 a=5rzsFUvyi4LdqLJPsjwA:9 a=gYDTvv6II1OnSo0itH1n:22
 a=xVlTc564ipvMDusKsbsT:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 impostorscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607020144
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

These arrays are used internally in tcg/csr.c and in cpu.c in the satp
options logic, which is common for both KVM and TCG.

Move it to cpu.c to allow KVM to keep using it in --disable-tcg builds.

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c     | 13 +++++++++++++
 target/riscv/cpu.h     |  2 --
 target/riscv/tcg/csr.c | 12 ------------
 target/riscv/tcg/csr.h |  3 +++
 4 files changed, 16 insertions(+), 14 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 69c2827e31..508e8dc03e 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -66,6 +66,19 @@ const uint32_t misa_bits[] = {RVI, RVE, RVM, RVA, RVF, RVD, RVV,
 #define BYTE(x)   (x)
 #endif
 
+/* SATP bits that are shared between TCG and KVM */
+const bool valid_vm_1_10_32[16] = {
+    [VM_1_10_MBARE] = true,
+    [VM_1_10_SV32] = true
+};
+
+const bool valid_vm_1_10_64[16] = {
+    [VM_1_10_MBARE] = true,
+    [VM_1_10_SV39] = true,
+    [VM_1_10_SV48] = true,
+    [VM_1_10_SV57] = true
+};
+
 bool riscv_cpu_is_32bit(RISCVCPU *cpu)
 {
     return riscv_cpu_mxl(&cpu->env) == MXL_RV32;
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 34c63a3628..82430ecec6 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -971,8 +971,6 @@ void riscv_cpu_finalize_features(RISCVCPU *cpu, Error **errp);
 void riscv_add_satp_mode_properties(Object *obj);
 bool riscv_cpu_accelerator_compatible(RISCVCPU *cpu);
 
-extern const bool valid_vm_1_10_32[], valid_vm_1_10_64[];
-
 void riscv_cpu_register_gdb_regs_for_features(CPUState *cs);
 target_ulong riscv_new_csr_seed(target_ulong new_value,
                                 target_ulong write_mask);
diff --git a/target/riscv/tcg/csr.c b/target/riscv/tcg/csr.c
index 4657b17e2d..36f2004bc5 100644
--- a/target/riscv/tcg/csr.c
+++ b/target/riscv/tcg/csr.c
@@ -1874,18 +1874,6 @@ static const uint64_t hvien_writable_mask = LOCAL_INTERRUPTS;
 
 static const uint64_t vsip_writable_mask = MIP_VSSIP | LOCAL_INTERRUPTS;
 
-const bool valid_vm_1_10_32[16] = {
-    [VM_1_10_MBARE] = true,
-    [VM_1_10_SV32] = true
-};
-
-const bool valid_vm_1_10_64[16] = {
-    [VM_1_10_MBARE] = true,
-    [VM_1_10_SV39] = true,
-    [VM_1_10_SV48] = true,
-    [VM_1_10_SV57] = true
-};
-
 /* Machine Information Registers */
 static RISCVException read_zero(CPURISCVState *env, int csrno,
                                 target_ulong *val)
diff --git a/target/riscv/tcg/csr.h b/target/riscv/tcg/csr.h
index 73d874ee98..53ba3b4a4d 100644
--- a/target/riscv/tcg/csr.h
+++ b/target/riscv/tcg/csr.h
@@ -69,6 +69,9 @@ enum {
     CSR_TABLE_SIZE = 0x1000
 };
 
+/* valid_vm_* arrays are shared with KVM via cpu.c */
+extern const bool valid_vm_1_10_32[], valid_vm_1_10_64[];
+
 /* CSR function table */
 extern riscv_csr_operations csr_ops[CSR_TABLE_SIZE];
 
-- 
2.43.0


