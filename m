Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A9FACDB475
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2026 19:35:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbkPS-0002Kk-7i; Mon, 22 Jun 2026 15:34:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wbkPC-000284-KU
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 15:34:05 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wbkPA-00024x-Sx
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 15:34:02 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65MFW6qY1083656
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 19:33:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=q3VKOG+bLiR
 yfEcN4LKgkHdSXA4OOkMf38y8s29WJto=; b=I8CQH6xL+Q7WdczUlGeikOQMtKj
 l1X+zwdw2TV2O38B+o7P7sjHw6qaF22DmL3sDGrHn+/bDykdQ5JtdiyzD2gy+G7G
 cdats7rYrX063L0EY+ZT2hFDT4suonm6Mx5nDmAme3sj4WsQsd2rygy8c7XHYJc0
 Dp6zc68Xk5uM1q2+WRi0y+GrW/53ZWfouzWCrTisNUYIB32fTWUuXcHjw2lXZgus
 DM9mKHjJQWHNqD6/Vsh4E2CD2MOIUL3jH1nRORvg+SdUJCN/wSQRT2KxP0VrlE30
 +fGjGKGG16wfMgrvvMevZVJSvK+LaRLh/EagEQrF2tyC6owMv5rKBc6Nu1w==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ey2yja2kh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 19:33:59 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-920aa2e130eso718391385a.3
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 12:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782156838; x=1782761638; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q3VKOG+bLiRyfEcN4LKgkHdSXA4OOkMf38y8s29WJto=;
 b=Htl6BFq4BSWu3K7+Zb50NIg9rijEMHEfMsHiPlxh1zwdKBKVbQ0q88SybLFwNgEVUS
 4rbhbYYE8go9rBnAZac5q76Pk1wXi5CQaKQLur/vkaom86nT0sZANi3fr6Nw4WpawI/e
 jl6prM3PiVCZFmOVLD9zTnvVAAgwlCZivyQ34CtbFilxhXb3mEDBb34kYMrgK0S65mgG
 tPnrtY0ysGWeG6IoCDdaoA2RXOBdSGjWik+y+SJMPXCp6w4AvIupZRePhsK7ElekYt6A
 p9K8K3I/TuxwSnuwUFpeN0SOSmf9tr/5wxp+dBGrU6m9kCrNlX/rtFhc8QcmcefcVQZZ
 5NdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782156838; x=1782761638;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=q3VKOG+bLiRyfEcN4LKgkHdSXA4OOkMf38y8s29WJto=;
 b=juf3njhRVARwYkqejAm5hV8KCtnA0BxVAMnQkkfc9duMdk2st3R/NwTXhUA6yCcoBQ
 HbuLxy84pLqevXyrzV4yBswgBtPKdFJrxjaHypsDcnV2RNUO+rJmUVVbHKxFsWNQpp4I
 WyCUdHHxRdu8w87Edb2DTHm44FqkrU7KG5UyjWKdW0u+/cRTXHF4YRz5UHCnUOA+ux7J
 Eo36zxERdFDFz4KeNmE2VUw3JKkCm1gjwit3Sv7wmUuatpKbwqixkjz0DHqh4gWs4ghk
 Z8rd4Z3HLKp1XGfcdgp/DJwBSYP0MtSGLlLS9jfUtpHWAa85cJRtMlqTPr9rJKaQxLHJ
 YCnA==
X-Gm-Message-State: AOJu0Yz0Va9UCF/75Gru5/WAlVEPV/c/YPQUK58ZYxtNmGElB235FRns
 ouhHZt8Z641aHO5tL0LgdK6X6KoHAY6ggFVStQjp7EBd+yFerV+7Nrkq2w6HyKJhgXbrun9R2M4
 iSnGPVC5Y5ZT4Jzc2jbeu8DHFoSOQ7MGYG/faSqkLkE63K+ZCJTtn3NNec115CqXEig==
X-Gm-Gg: AfdE7cm6TCkgdDvF58pJet1FRayAtw+1N+10GF4KD+Qr+nWNywdDviFgk1jyAfv7TuI
 08modApQqj2TESE4NKWSL7vS8XYeUfG6EBOmyo7mP5Zoo7aWpDtXnysC3qQXv2AHOwXICCDHwVh
 PX1KiJpjtNWCTTRckXtZWikYuA3kUozHrTvludQZl0PNb2UgY/6u9WCUcqxakdYbitN6kuWrJxJ
 2oWuhjsaxMQ+73YnaqYDEZakJQNJQHUhiDkVCSWwx9QkHX3rJz2QsCVTCCjiMaoL3lQMFlAz91k
 P4JsavXmI9zjOujSUkpFt5oCwybAmOSJlNAYgIwR8m1rVh+5YEkuiGkWp+rasNVCbZoJw80xteq
 hnlbuSgfLnYwsMJewnkMb0zDmXS2G67u703QczQ9KkypG7Q==
X-Received: by 2002:a05:620a:2725:b0:914:ca66:841f with SMTP id
 af79cd13be357-9208f256a65mr2472362985a.6.1782156782281; 
 Mon, 22 Jun 2026 12:33:02 -0700 (PDT)
X-Received: by 2002:a05:620a:2725:b0:914:ca66:841f with SMTP id
 af79cd13be357-9208f256a65mr2472143485a.6.1782156765168; 
 Mon, 22 Jun 2026 12:32:45 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([189.79.21.40])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-926004ab49csm61489585a.34.2026.06.22.12.32.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2026 12:32:44 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 philmd@oss.qualcomm.com, pierrick.bouvier@oss.qualcomm.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH 19/24] target/riscv/gdbstub.c: isolate TCG only checks
Date: Mon, 22 Jun 2026 16:31:35 -0300
Message-ID: <20260622193141.1449724-20-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260622193141.1449724-1-daniel.barboza@oss.qualcomm.com>
References: <20260622193141.1449724-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: -4IT0YtseqcY7cFXKTNDnIYVlTVzBKKc
X-Proofpoint-GUID: -4IT0YtseqcY7cFXKTNDnIYVlTVzBKKc
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIyMDE4OSBTYWx0ZWRfX99ZoBUDPl6Xc
 e9BfweCVvlT3MoZRBQ+WIo10c3qVj08cQIX0X/w8EJSMAb5n0QSXtmfIGeB/19PZ0NnVVm9R4Ai
 ORe50tgL8x76Uv8x84/ycX45oTgVYCw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIyMDE4OSBTYWx0ZWRfX4i14OmaiWvtP
 aJZoS6aVFmYqIGZNZlEVITQXtFTN/dGR+W+ogXNiZ5h6QDQjm0C7nY2n4nmcjTsGlN5jJPHMMv/
 sR1fspsGoSgTW3BeXYOpbjr8NjGE0o85tdUu2hW4T3A3Idbk1r9fWjFnrcpMxMYlU3DXlVQjejX
 MfBoVTRUwXS/BzzFjwOZLMzLQd8SNLIgOkzDz7Y/xixwpPb5Xbumm3hue1KvXkOO+rehtogm8Jl
 sgMpdSz1Np9WyqbOTX2so9dhkFa8lQk8uDyIGN0TAWe3VZJ70FJP8IHGTAnklietwCUL9xjHlRj
 Dj8uzR8yxKEMC3rIEIztVvjd+0EPjyezcEqEzbHQLIcJZJxFZywcds2013c2xMDS8sgsgh7pBpn
 Md4Igau6ohFM7hhyOd5ZvoNhLmjgSCBa0fYjeLaDFiuhGYLmECb0Br2o3Fe1fzsFuqdz2TfcovE
 Nd7um8IjFZSrYx9LnMg==
X-Authority-Analysis: v=2.4 cv=YLSvDxGx c=1 sm=1 tr=0 ts=6a398e27 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=sHJf4AwOIoU3qjeHFPlg6Q==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=m8F5ZJ-s4jyFCOPQnU8A:9 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-22_03,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 bulkscore=0 clxscore=1015 phishscore=0
 adultscore=0 spamscore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606220189
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


