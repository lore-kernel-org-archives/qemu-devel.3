Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 992DECDB479
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 00:08:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcB9e-0007iT-Jp; Tue, 23 Jun 2026 20:07:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wcB9P-0007Xe-Jy
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 20:07:33 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wcB9M-0003FK-Rz
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 20:07:30 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65NK0wZp1177683
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2026 00:07:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=tPKgOZLimsk
 fFqkC0kyNvo6B2QfFFcxZ49dpgDAdxuo=; b=Ip1QgaWTwjSnAuuNIzJU6Q9poyR
 rNhnQvvoWxSbrKf1A/EV7F6uv4mIx7R6k9FdJbvti3ifWtLndenVcVOnOz5/KKJm
 UKW47SHssonqpbK8wv7hcdlcPm2gfICUkJEa/kD31TqB0H6xn41CQ5CKbgLvWkCk
 GC1bclMvNPWcP88Hvsjn2/ZxMdAFZ0j3Do++QzM2ze12e4eT2ZrqzAgQcckROSY8
 R1rnIAYHinN1mZ4Ud8Awi2zlWFTP6Rf7YSYuOZAxm4gKpecAwdCVAKKZbk5dngKt
 UT3oYYWsxhM3uYQh9fvYTbVey/Qw5dX05Kkuq+1x4wfrlQmqFzZi/q9VOZg==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eyqe6bd9h-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2026 00:07:17 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-8dbc0f048efso10791256d6.3
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2026 17:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782259637; x=1782864437; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tPKgOZLimskfFqkC0kyNvo6B2QfFFcxZ49dpgDAdxuo=;
 b=PeAL+pDuMC5sEN/ZzmfH9he9aKLAwXbcKiqM9exc0fAuPGl5OKU9k95zQeuCKcq2j8
 fWNoB/+buHDUbpTJ5ayGHC7voWbv0wIdYXGF7MX/73Nw+irsKxIk2gifdOSWjJiVHbG+
 eUqRgRALUSFgLX+zb1za9F4f7APyVhQt1pGFzEUVFXzwA1mokf0NnbI/pmoAYrf/ECdh
 bKk0xZJXiWatLvxw4XRyMZWUjcMkV7Fy5EH0uDRe8WsKytQyeIhKoefXZP4xxfG+iY8z
 RnWIB+LqBj/nLfx66hnKhxqTrjPglL3jF6JxzcEfEd0TwVgIaEZgSqrWa1vO+cwB/b+s
 Zbfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782259637; x=1782864437;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=tPKgOZLimskfFqkC0kyNvo6B2QfFFcxZ49dpgDAdxuo=;
 b=UqK+/sMqRJKcf+jgB9UQyxkkiYOZryfDvnRoLvUEsQexBOCKwguLMagHLuQ16Zsit1
 oGCYiwGeGop2Bb5NvgosZh0BqkbzMFSPpTRSLlesb6kUQwee9V/FU8H5EnAqEw9In2ml
 u6VD9z2fog15DQk10sepreeoXWjEfLmCO2K+LUntbiPcbPvmYFKmT0THX5om1D3ha/Tz
 DvhZGOQh/F2xTlOolCZhVnC+oy5hUMf+UPnYL0aMwaaFMZ0Om3pOShmEZf741cZ68z1J
 CQr7e0Txv10OCZs6NXWgbBH/eKpuvtoZ37soIM5yOx2yFKWp8Nz3mEu4Yd4OInsR1l4d
 s0xg==
X-Gm-Message-State: AOJu0Yz3gEQX/D1/0dPmU3NYu5iixO0AdbFJPvNnvcvFuwZZrfzprYja
 ObXammI+Do/21HJvpQdEX6zTps7A2TjI7VRChnA9vBrWL6n4mdzySCuruKS3JOaO4oIABM2HaZB
 9rIPBgIS/2IEMYaVWMD/X4SEp++8irwT3m+gtmW2KuLXeUTZLgDK/HuwTi9jXHKkR6Q==
X-Gm-Gg: AfdE7ckqUQFcTIFQ288qduv68cHeUtEnr0xmGt3r0S9eXsDhPRqKzbFz6+NzY/h8I8K
 bSg0lt9f3y0Cu204x5G2R/u9RrVX4e2eVAD6BOk88V/YjcP/7W9g1WWwK1Caz/+2xUbjKfzTVn+
 40uDL68ildFPzMG07TOND577+UA4js26BckN9yGF4jWqiiAEBoayTd9RBOZJiaPQlgBsHUQxYyO
 YV0oE4PoYKH1ea+PTxvPm5cgSaGXfFH6GkgDZyQpbQ4yr/6Cp8Ai8tnRy86300umRcYArM0zCT6
 1UJ1EkMr5lCWm/EnsRHiqOOU9ZiSoZT4p+zYmFcuEax0BemXy1mRzZTY9OLX6YzFY2p4Ge7A7CN
 pJAbnVmK9fgqkurv2GqfHZwQLrimLMYa2Ds8ZOac6CC3dhg==
X-Received: by 2002:a05:6214:5f08:b0:8ca:f47:25ea with SMTP id
 6a1803df08f44-8e52ac2bf0dmr25074166d6.0.1782259637243; 
 Tue, 23 Jun 2026 17:07:17 -0700 (PDT)
X-Received: by 2002:a05:6214:5f08:b0:8ca:f47:25ea with SMTP id
 6a1803df08f44-8e52ac2bf0dmr25073486d6.0.1782259636761; 
 Tue, 23 Jun 2026 17:07:16 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([189.79.21.40])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8df81cdec56sm142422976d6.32.2026.06.23.17.07.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2026 17:07:16 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 pierrick.bouvier@oss.qualcomm.com, philmd@oss.qualcomm.com,
 fritchleybohrer@gmail.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH v2 12/24] target/riscv: move valid_vm_* satp arrays to cpu.c
Date: Tue, 23 Jun 2026 21:06:19 -0300
Message-ID: <20260624000632.2149359-13-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260624000632.2149359-1-daniel.barboza@oss.qualcomm.com>
References: <20260624000632.2149359-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: tE6RNa-XKQ84WFy2uc3xt6xen6l_NWDo
X-Proofpoint-ORIG-GUID: tE6RNa-XKQ84WFy2uc3xt6xen6l_NWDo
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDE5OSBTYWx0ZWRfXwnbjjgFpBmFJ
 mKrPqXFxiNuZGDwiB+/S/lS9kNcOkyAP65GDLqDjQMh0kFaPkGqR0QK0h3lI74P0ZrWdWCjmJL0
 pR/ArzjCipSGHpNQDQNExrtHqenonvU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDE5OSBTYWx0ZWRfXxsloNYI512SC
 EYeat8p08rlx0wIH9bWu8TsjNRIl2uLDp4OeRtmGNmVbQlGDrcHcSbb+3D8Hps+K7vR0nfNDcOw
 8NL/vmrLtot5/cZvKl2/0hH6VN1D2mQK4LOTu8nrgCuUtTog1QPswkL8obQnsZfGDJBbIMmrzxU
 /H3rM4o4pUJKwzECYIL7pp19cgqkcA27ze+MLgJvHc0nJKwZb3tH590t6g5CTl57m5GaPxm29BJ
 nG7VC3c0Vfpu5XsKcwXWxSzlRTjMMOilA3/6lFgQ8KOUwUqG+fwt9JTqLAhjh6kpJGRgp21CqWQ
 YG59M4Wjlfh6/dtjxpKQEQ0SI3hFKH8tPIZ775KXvy26cfVs6oxzQ3rtDFyuHSoN58I1IoFy/sW
 RSyJxFPWtWDQPSDnsWliQ3GrGdj+Rnucf12bet3wtp6kcM3tzV165/a4/mrM2jfWIL6Pg8i4GeC
 QaSHMBb4Eztqo/0JgQg==
X-Authority-Analysis: v=2.4 cv=OeKoyBTY c=1 sm=1 tr=0 ts=6a3b1fb5 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=sHJf4AwOIoU3qjeHFPlg6Q==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=5rzsFUvyi4LdqLJPsjwA:9 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_04,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 spamscore=0 malwarescore=0 adultscore=0
 suspectscore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606230199
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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
index cba7d2502e..29af0f2be8 100644
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


