Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DBF4C43458
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 18:06:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfiGz-0001GN-3v; Fri, 03 Jul 2026 14:05:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wfiGx-0001FZ-CH
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 14:05:55 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wfiGu-000243-0e
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 14:05:55 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 663HibmW494915
 for <qemu-devel@nongnu.org>; Fri, 3 Jul 2026 18:05:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Nkjq7pZrQfCsJ94d8fIQHCES8P4GDbUg/biFMhnie9U=; b=YuODJZn9cOu9ZyAt
 Dy7B1vJ5++ZkdY3xoSNiUwVjsK4vt26fGvL0seyZYW0DVrVC86v+6SgH5xfxw0lI
 zjVJl1c/vbfClKLGRXqNjA93uUU08KW3dr2agzT1BvGfO52JU0WatOo5WxvV+iJ+
 +Y8Sxl06pCikTxoZgPyqMBDcuVPTdg1lTL1ypPWB4EVFDcQ/WRiX14um1pGHz6/d
 jFgf79RQik+eYyaqtU0HWomuV8ExnP8Wbng7TujGt/ANV3yHmXSRvVKG1rIQfs0n
 qsddYLxGzGKim5610coRoZF4OyHzd9mJ2D3WVHMDh7YeNFZoPBq6ysv4fA8MGBFE
 lL5qTw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f68jyt9yx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2026 18:05:50 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-51c0408254aso20075481cf.0
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2026 11:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783101950; x=1783706750; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Nkjq7pZrQfCsJ94d8fIQHCES8P4GDbUg/biFMhnie9U=;
 b=ibFMSkAXPXnSNb33b2lY90sHOP+pZDQ3aCLLomqJsdV8fq929Mrkq1iy3+oOvhilLc
 02Hzdh2qYYObPJdxUx7cr9vxBjRD2iEmffFgEd/QhkgFMeOeKE7CCX9kMp9EyqQa7pSV
 AaN6xhN6KaRspmkQRg0o8uAvSXxyjkS/Pjih73bdRrht33UD4luCyKtk61BMhj6dEOgh
 6mfs6z5elu0gPf5Gxu9MPOtuU02Nx+6gZTWoBjQ5U1mDIBVhfrdX/aPMazqSSHHIELDd
 DiReRIYme7cQTjnbNzpJEH6UAAR6ON+eZVFn+lJz933D74ntlqCI6l7lsyewcehxMixt
 T+lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783101950; x=1783706750;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Nkjq7pZrQfCsJ94d8fIQHCES8P4GDbUg/biFMhnie9U=;
 b=RhE83iS5DeQftJWYI1olZG7zS7ZUcqM1qHNmUq2C1oCXjdd3FH0HZbQas51o7xwKoe
 pimY5vDZB2Nhr6YqnGL4GIYAjHzx7+lczmnVpWZRyCQLMlc787QTBcHd/VjItPEiCHqP
 NXMRpqL6w4GCiUukihEBES+xWePAHl3J64tlnFkXsma112tNV8jx/oe2mONe/qEQSIEk
 +AWDZoSmUkZ2xoBAOdxbyTAURMuFRgXd1cwyuS1+aeuplwEPfnVjOTVw4XVS6Ssq7mSG
 CVshtQJTcadZvJIW0nbWM055QZuPcvgtSdXrhQwnzVljQfOb7OnqTidSuef88rut+2Yh
 gElQ==
X-Gm-Message-State: AOJu0YwusRBex+zpD+TF6f2blTOpawMbVe0sMbA4hT4WVJPXbVGdrpCc
 RhQNM4+wbhc+7cs7QvlquxTepUHXe7suJ9Y+bxzzeg7Q14muWHrvumNqz8+pJagblzYW7Uk0mwe
 wosUCStvrxaVuxmcuMvDp/nbSxuo3Ij9K0X78mToHDhvwbrvjydvhWCNonWglzK3UPA==
X-Gm-Gg: AfdE7cktw8CGLa7IfdQgKhOvmtqHe1ChZqE99SgwxjV0JAFHXoI3D/cCnrLpbNhAoRG
 fBG/how/050OiVBj6JOZ9yReZcBtmDayiFw67+M+8EeEZPJdD2hEGfZtWNQ08vOgBOR9GUT8o+w
 FqjWkBVjc4Qb6Pus3Lb4D//pJnsUTZUwBZ/XN5ffrmTxvItR0PHuGtFvlEg8e8980iR/pMuQEnx
 HEWJwCNMKoui9Tayzo0qWkds4hOtP1mJ8oOHD7lcT3v61tEBn5/TOSxdcSyC4U/93ai/GCod6Vg
 4/L4UTxWGvHIvhwPOWYTSVHgzMUaCkhpFxmeKb5MijesynnBaAiohD4Hd9kBU9yqGHsq4zOSX3b
 zpWmPMXFKcDLVrOkT7P5LKQVnDSYs3tcybo/OPKkaGS3Exw==
X-Received: by 2002:ac8:5fc7:0:b0:51a:8c86:bd2f with SMTP id
 d75a77b69052e-51c4d1a0932mr2139551cf.36.1783101949476; 
 Fri, 03 Jul 2026 11:05:49 -0700 (PDT)
X-Received: by 2002:ac8:5fc7:0:b0:51a:8c86:bd2f with SMTP id
 d75a77b69052e-51c4d1a0932mr2138891cf.36.1783101948860; 
 Fri, 03 Jul 2026 11:05:48 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([189.79.21.40])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-51c41d2d688sm22560081cf.17.2026.07.03.11.05.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Jul 2026 11:05:48 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH v4 02/24] target/riscv: move valid_vm_* satp arrays to cpu.c
Date: Fri,  3 Jul 2026 15:05:14 -0300
Message-ID: <20260703180538.3346781-3-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260703180538.3346781-1-daniel.barboza@oss.qualcomm.com>
References: <20260703180538.3346781-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDE4MSBTYWx0ZWRfXxbGIRrXGyM8i
 uPebtpumdPhVsRbyE5yp43kLHxH7/dv+WszsN6E7Vrh+hkRTOlR+WW9gHyoD13a8dFOjmycHjaN
 HaJZg3CofyXU8i9O6BXFHRzNNaav4DVUxDX+GXQbnisWSnxSChsccNe4ia1lLSbScNaGaQCV8kU
 FOMU30dlQya+8StmBNi3HoZAqM1L9XeACkfXYrJy57izKfq+XVimUuwn+BIjXbVRD8abvpeflts
 dP0CzLM1omAqAAsa63IjeHHfbMXXgFf3kEQrSvPQqwGBVoP/GbKGXpq7zc2972AHIDFQrN4TyDq
 IQqprVCkwqtrNgNVca7uAoCA4q4jTH1p/n6pEPgB6Y3MXrGG4UImCXnRkgf7ZEbiAsI528ZPmTt
 FmUT2JmgA9ZZtBC2oDBX0+NXYrofVF2nrE5z9mGn0ack/Z6ttlHdqvlCM4b8q/jR76vsBMjiE9L
 Y4HCUahFoXuuICwAHXA==
X-Proofpoint-GUID: vPRYmm9b3rXDfWqDpps0CdMmmD3QU7F_
X-Authority-Analysis: v=2.4 cv=QbFWeMbv c=1 sm=1 tr=0 ts=6a47f9fe cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=sHJf4AwOIoU3qjeHFPlg6Q==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=JF9118EUAAAA:8 a=5rzsFUvyi4LdqLJPsjwA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22 a=xVlTc564ipvMDusKsbsT:22
X-Proofpoint-ORIG-GUID: vPRYmm9b3rXDfWqDpps0CdMmmD3QU7F_
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDE4MSBTYWx0ZWRfX/7AE5bJsbsZi
 yVaNyPHCPuLP2lOVw1+UwhWJuQFMbQtDW8TDa0OnlZAoGQdCk4ouFJxfUWWtIliJpDB7HG3F0oT
 WbMFhH71YkspMCVrbSaFqSUaFsLMSzM=
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

These satp arrays are used internally in both csr.c and in cpu.c.  csr.c
is going to be moved to the TCG subdir in the next patch, and we want
the satp logic to be available for KVM with --disable-tcg builds.

Move these arrays to cpu.c to keep them available for KVM with
--disable-tcg.

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 target/riscv/cpu.c | 13 +++++++++++++
 target/riscv/cpu.h |  2 --
 target/riscv/csr.c | 12 ------------
 target/riscv/csr.h |  3 +++
 4 files changed, 16 insertions(+), 14 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 7664e686fa..cae4e96232 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -65,6 +65,19 @@ const uint32_t misa_bits[] = {RVI, RVE, RVM, RVA, RVF, RVD, RVV,
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
index bdd28d329b..82362ef8d8 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -968,8 +968,6 @@ void riscv_cpu_finalize_features(RISCVCPU *cpu, Error **errp);
 void riscv_add_satp_mode_properties(Object *obj);
 bool riscv_cpu_accelerator_compatible(RISCVCPU *cpu);
 
-extern const bool valid_vm_1_10_32[], valid_vm_1_10_64[];
-
 void riscv_cpu_register_gdb_regs_for_features(CPUState *cs);
 
 const char *satp_mode_str(uint8_t satp_mode, bool is_32_bit);
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 7168a4dc12..7818d81fb0 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -1875,18 +1875,6 @@ static const uint64_t hvien_writable_mask = LOCAL_INTERRUPTS;
 
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
diff --git a/target/riscv/csr.h b/target/riscv/csr.h
index c791260f83..66ec9546ed 100644
--- a/target/riscv/csr.h
+++ b/target/riscv/csr.h
@@ -72,6 +72,9 @@ enum {
     CSR_TABLE_SIZE = 0x1000
 };
 
+/* valid_vm_* arrays are shared with KVM via cpu.c */
+extern const bool valid_vm_1_10_32[], valid_vm_1_10_64[];
+
 /* CSR function table */
 extern riscv_csr_operations csr_ops[CSR_TABLE_SIZE];
 
-- 
2.43.0


