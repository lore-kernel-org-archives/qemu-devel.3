Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C781CD98F2
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2026 19:36:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbkNx-0000of-CF; Mon, 22 Jun 2026 15:32:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wbkNs-0000mS-Nf
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 15:32:40 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wbkNq-0001qv-SK
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 15:32:40 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65MFVtSM1010425
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 19:32:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=d/uFzFy5FqR
 X3cHIra3ntqXywnztpCpncFwhI0IbSgw=; b=fiVza742NK2gyVOiHthMwMJ7blx
 gJGs7ZNlDTn+y/JXOc5RbK38SQjWABH41aXIMvOag4dQyQLYtJTjGO5azGCdciyY
 qswaQ4lKvhPwPIW0065x3R0Czhjttg0TboYTIFEPl53HEXFlVzzdqgxBtLsVgiV6
 GJvxpjNvPXUzrdLMXeGBrNKrVOgE1OYMIXGWFYCmlhSiRgAwtQW4vcBxWoS4B2eq
 EBVTJSEWRx+75dW+9fzZ/Xv1Dxa3zvdF3aQS6+fbKXihMZzrPOkpnETgrov9lxz1
 XvwCxylqIkJsNiBukMPh/+znD077tt8EIJGKpym/gqagxrysFRS35GzK52g==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ey3a0syq6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 19:32:27 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-921634eebdbso596857285a.2
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 12:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782156746; x=1782761546; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d/uFzFy5FqRX3cHIra3ntqXywnztpCpncFwhI0IbSgw=;
 b=QeBGSxkaQwg2FHwWfFAxE/NEUsyLu6MGY8m88Ka0yAhLHJnrzMWHxv+FXtiz/nv853
 yywkTIrkQfZYr/byXX8o5Lw0b9puz4dU8by5oFmWAz1U/pe/IREFWCGGRr32cgOahG0N
 NOhxX/14a8nIgpgAMdmPkTkc1JKEgvvsqK7cCszZRVPf0y/o5aFTu7age1stzHgt0/e5
 BCBMBZLyB9ebVvTt1QLJsx30nHOqPHKRYLbPV4+XY+4CU/8c1fsBrO9CIbuIwsJX265C
 3G5xxH+6diU+XiRy3CiAHimLzoqFI+o0tFdX7Ns66eQhuaiXs35qL3Q9nvgL+aFgYyWw
 KouQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782156746; x=1782761546;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=d/uFzFy5FqRX3cHIra3ntqXywnztpCpncFwhI0IbSgw=;
 b=f0NXH09Ut6J56FjHI8JFS8htx+RCUPLxGjNxrlYuuq5WVUhoHAvM/a3oMNwDATtRRm
 xvFxV+VxZd/UkupfcBJvtHnfO0DX+7mLGCS8ySbjKCP0FN+kGp6G/bJCGcZUBABnVpJR
 nLXebfiwcHPXZDvRAPSY7ZmiF4pW/rxLdNp7z1QwyQ3tbHH/arogi1Pj9Xgcgr7MQT06
 68jtSWLfTees+5HX1U/z7/TlJEuvNkaqi9bYXOrjgum8lywxC5bqS9Me8AXppUBV/NEf
 idnbSwKgpXkZ6L29BPdjUkNll4Zb9RA4wIzn/pDfSdCCkddA8nENGQ5u84P6f8CPrK+J
 tj+A==
X-Gm-Message-State: AOJu0YxB0NtiUnX04mldtLDyH6MHVKXWcKBWkhF+2Cef6Pgf+9eHFV4q
 gbCKHZJIysmfIel7IdAyyax8a0d3FlRnDZXUfxHhJjoHsB548YkQ3tpJxYkF/9h0BhHqQQKWyWg
 1rMOU4ABlMnQuH++j/GMOq0Mb9dF+imIGHQaBVkVu7VQpLRvhD+mgplTZ5hfgV47R9w==
X-Gm-Gg: AfdE7cmqumklMYme5cTxZVB3vp4o9LyyATmSXnxrB33/+nGr+i9XAQXpK8LKQ6lBqOm
 xW6bJvRLWnKYSYJzZZmI82K7hwHwxUpwezgvpABqRTKb385/tRU8n8wN5K45UzSUKuoBKiLA3zE
 kMZiDYVK7ItD/dxbCOa6gQt94lQbSx4gAuysNYzY0qs595XbssAZ2Qra/CEiAuPiMh4fpi6fy27
 bYD7WXz/ThHDl4HkatVT0puwBsP51K5JdPhvc6W4ZqLBVCJvvYu/rXv5N+nKzEdNir1JdR3crDa
 mVvzw+kp+WdpviNusvuou2LItpHuHhN+K3HIEeDNtui/Jf8SRSJBG/s2+OzFgSwuzBkpK2K7Jsd
 uyIpa/HX7CgNTonSdU6HiXjU8tq6Ycg2HFqrNqV4ZjH1lOw==
X-Received: by 2002:a05:620a:44d1:b0:915:d5cd:8ce3 with SMTP id
 af79cd13be357-921d104344cmr1643047285a.14.1782156746124; 
 Mon, 22 Jun 2026 12:32:26 -0700 (PDT)
X-Received: by 2002:a05:620a:44d1:b0:915:d5cd:8ce3 with SMTP id
 af79cd13be357-921d104344cmr1643040885a.14.1782156745643; 
 Mon, 22 Jun 2026 12:32:25 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([189.79.21.40])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-926004ab49csm61489585a.34.2026.06.22.12.32.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2026 12:32:25 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 philmd@oss.qualcomm.com, pierrick.bouvier@oss.qualcomm.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH 12/24] target/riscv: move valid_vm_* satp arrays to cpu.c
Date: Mon, 22 Jun 2026 16:31:28 -0300
Message-ID: <20260622193141.1449724-13-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260622193141.1449724-1-daniel.barboza@oss.qualcomm.com>
References: <20260622193141.1449724-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIyMDE4OSBTYWx0ZWRfX3OiTq1WK2lA8
 MvFN79lVOi3rPadkIBW+P4SSFK3VFLcr/81ETRSlMdDagtymrk9lJJnpqMyrEz+SvMoQQg4UvAq
 uJf+rxiq0VYQKfh5gshOrJjmsud1MSg=
X-Proofpoint-GUID: ZhRnVKj9qvrT-3uAIr8AgV1ZNAs9TlLT
X-Authority-Analysis: v=2.4 cv=UJ7t2ify c=1 sm=1 tr=0 ts=6a398dcb cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=sHJf4AwOIoU3qjeHFPlg6Q==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=5rzsFUvyi4LdqLJPsjwA:9 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIyMDE4OSBTYWx0ZWRfX44lkUZpdJNVl
 N/BOvc3uECTtr/H0kk3JgKAVH8VPfP/1GFQW1W7MM8veLGYEnboAHChab5TnGCznY+ainJR+K99
 unoMC236hGmvrTsVfZQixjoWLCepRlYr+u2E0RTcstcIXqw8n34qvE5iyIKVaPFSzt+o0xwNZ8M
 ID57ahWxzzxAo2k4IFXbhsvaABmGdAh54AUV/8YZ7vugo+L7Obhu+9xqz0YW631pNn9OyErlaZE
 nECKC/XngZ98BZR0ICJBpGevkYnHabEnH3dbDUK8cpelJpGKrqmPLNo4NKH5fr7s9K29wpoox3k
 K66On+LwuFIzFxBJzz5e+Ki5aA2cSPJxrQhHxmQzXtFGaaIS57dg1p9I8LXpDZwG5LY64WhmnPN
 6mwglUVCWbyvY40UNX7V8aXfSE4YLfrYiGFskV+eAX2bDqRLBMEOIyhO+ALxaIV2krr7RihLh4D
 jOI0yJbTz19sR8rnRyg==
X-Proofpoint-ORIG-GUID: ZhRnVKj9qvrT-3uAIr8AgV1ZNAs9TlLT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-22_03,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 clxscore=1015 bulkscore=0
 lowpriorityscore=0 adultscore=0 spamscore=0 malwarescore=0 phishscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606220189
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

These arrays are used internally in tcg/csr.c and in cpu.c in the satp
options logic, which is common for both KVM and TCG.

Move it to cpu.c to allow KVM to keep using it in --disable-tcg builds.

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 target/riscv/cpu.c     | 13 +++++++++++++
 target/riscv/cpu.h     |  2 --
 target/riscv/tcg/csr.c | 12 ------------
 target/riscv/tcg/csr.h |  3 +++
 4 files changed, 16 insertions(+), 14 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 74b6daa76b..f0ef4c5a4a 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -59,6 +59,19 @@ const uint32_t misa_bits[] = {RVI, RVE, RVM, RVA, RVF, RVD, RVV,
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
index 4fc82d2477..ae6b166d46 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -968,8 +968,6 @@ void riscv_cpu_finalize_features(RISCVCPU *cpu, Error **errp);
 void riscv_add_satp_mode_properties(Object *obj);
 bool riscv_cpu_accelerator_compatible(RISCVCPU *cpu);
 
-extern const bool valid_vm_1_10_32[], valid_vm_1_10_64[];
-
 void riscv_cpu_register_gdb_regs_for_features(CPUState *cs);
 target_ulong riscv_new_csr_seed(target_ulong new_value,
                                 target_ulong write_mask);
diff --git a/target/riscv/tcg/csr.c b/target/riscv/tcg/csr.c
index 572a39d660..b17be35e56 100644
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


