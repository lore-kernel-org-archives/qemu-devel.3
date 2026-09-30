Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E07DECA5FC1
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 17:51:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xByRs-0001of-2S; Wed, 30 Sep 2026 13:50:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xByRh-0001id-T0
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 13:50:22 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xByRf-0001Vv-7y
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 13:50:21 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68UHf9uN643880
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 17:50:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 O12f/RezyT+/f0MD5pwtqfJck7NgEd8TZKdE+1UgoK0=; b=D47LKTt1su1NvD9C
 E3ZvvT0mWRuUz4PBXsWP2k7n0pR9iot2AtjuxTqfNl26K/ejr5mVog9hWdapFkf5
 uzLpZn23f/KPz+1AqRc9+R/i7zjStKNHTbHPM1M/cyG6iuUjtYSjZOaFqqZqUVsk
 YIQhqxex4YrKVjMYGJtLG3O43MGGYjBTdJMQ9m0AHzV9fSbqbvzU91yVnIWflf92
 vde+zWw6mdC+5Vv9ZVtBiEoStPKfZnAf3xbb38oRq2bHcpd7JYYD/+HYgxEjkCrc
 a/Hn3a727uO6clxvSEi0Ux4BLsHvO3WmlW8WTQ+MLGipctHB1mVexMfvGPb8XAYR
 b0PwEQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h14n20uw1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 17:50:18 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93c5ab5c136so750765285a.3
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 10:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790790617; x=1791395417; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=O12f/RezyT+/f0MD5pwtqfJck7NgEd8TZKdE+1UgoK0=;
 b=hlSo11oLmRISzMg4PrQzx4Qo3/AI+d+47hzOZ18p0taEpD3G/e970AgxAxYv5AqUy6
 wwRtruLEJY1yj4jma/c4NM3YHgbPE5xIcbqA7mfdecadkyDYTJ5OcnzdHr/9eE9vfI2n
 TbOJuMxl9k33FyI/Z4FyHS+akokloD39DTeciuL+QZXZWmjgUpIOd679KmF1+SdKmIDo
 7UH0sG5eDWs+CUSFGsfrBpx1VQBz1JoamTqy4HkT7+11Oe8XEG09PVQx+w4ZYF4w0RyA
 3uZhJUIqYEOzSkRlN1+ZnlfkE2c1HTdswkAzxK/bmiZIk/Ilmj6/XRQlxbpeODbuDwry
 7tIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790790617; x=1791395417;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=O12f/RezyT+/f0MD5pwtqfJck7NgEd8TZKdE+1UgoK0=;
 b=C3uwLAY/LB5S3YvLdU/BozhJc8Scw+qYHrfT3Mt1iGqJ7Sb0Q45Xt5DjmNvfscGNPW
 oYXvi5YseQq523S5h7SI4/+KSAYC90BwBo0QFEGhm6KTXMgtX9KZdDlR1CY66yasW1Xo
 pt1jUj6ONrcNlFEgPk4cYvv82XlU5yBeal7mC7o+RFecHuMoCp3ATpIwu5ARf9nEaajO
 4KmaFAnjUU5sl4vHAfbZsfB5noYf7AW82nyhvtgEj6QBTldWh4zrXtYtyHOXperqJ5dG
 3R8J5sDddGStKYfCIYiyJOnc5kdpfIvvWDE/swOQ9DRbFk4aeA6R/uBHcM8DooT0iQxI
 nfPw==
X-Gm-Message-State: AFuF++m4BHcYbJgQ9nxk5aMU9McsOMBkH3Yha/1+1iHyo9xnoRh6z4Ho
 8oyrn/3D/9a3cIeHQobWGxQCQfas8guV3Kp8jwlH32ggNEqkzZJhxE2u8NN7lfRWhJB31aXzGjb
 KN2YSE7+k+Qh7CrFIfYjrrkmem9uIMwW2tbS0VsI7BTkfRISGFzKCVYzHdni4jdAIcQ==
X-Gm-Gg: AYBFou0eIOgUnREz1N7pFtLJEbzASyvUQ54w+yXGmLNTMyL0yUEF9BJI+gEeDviuk+S
 cJi98mw9XaI1ZP+dBHOX7yS9NLlQyMpwmmzi2DjaFZHM9UxGA9dGWcIt6zg/X9m4vqw5f1j9Kh9
 HYy7ippDzLTu4oO1iyofNtWkcT1SR3LQObLeVyxq5QxshtdNTEO+XDXJjPgfQGdnjD63nCbsNHB
 RRRmXhAxXn0fH/0KbYMWNtgEbB0a7qpr6SPoqX6G4BzLIQ1fMe6uVw6VCXHdxwr5t/yzsT8P4Wt
 w6wTsQCklRROuCD22qWltUSsRxqEXmE8lqSvvRZpG1ghTF/vfrqoYwss1sMjGnAoHpfkWgYFqs3
 NhtYLdxYdC2DjS+xATevccUPk1E/T5or/m7DujGPR
X-Received: by 2002:a05:620a:2842:b0:936:dc4c:3bf4 with SMTP id
 af79cd13be357-93ca96b41eemr406654585a.28.1790790617304; 
 Wed, 30 Sep 2026 10:50:17 -0700 (PDT)
X-Received: by 2002:a05:620a:2842:b0:936:dc4c:3bf4 with SMTP id
 af79cd13be357-93ca96b41eemr406647885a.28.1790790616748; 
 Wed, 30 Sep 2026 10:50:16 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a01eb84e59sm7053555e9.15.2026.09.30.10.50.15
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 30 Sep 2026 10:50:15 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v4 4/9] target/arm: Convert cpu_exec_halt() to leaving_halt()
Date: Wed, 30 Sep 2026 19:49:40 +0200
Message-ID: <20260930174946.82195-5-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260930174946.82195-1-philmd@oss.qualcomm.com>
References: <20260930174946.82195-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Gr3XaU1C c=1 sm=1 tr=0 ts=6abd4bda cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=AtaPWBxvZOLBLR1XvpsA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDA3MSBTYWx0ZWRfX78wx5/CbF1lM
 0sDhc5hWhLHSvlAv6QpdYHeroCWM0CPer3A+tWVDX22rPoJjRoTBqJ7IJQU8KNih1pSZVip8e2y
 ZenXSh4rQnXrRS2dtAx8V79TOAu3V+U=
X-Proofpoint-GUID: _bxprZu3y1XcvrDqCTP6FDQHGBZgaYX1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDA3MSBTYWx0ZWRfX+WAjjz2MiSwV
 ek/e1L2WeRVeBEOAc6U9zV/H/spduZLeLVq6Gy4sGVjQCwtq4hGL/VMq7EH+qGwC9lw28If8nDb
 rIwQEy+3NQm4YMjaKnoxuQnzKOs/hKjWq3rEeyDNjiF6OXVFS1gZdG5v+fhfMvdWRyi1x5vmNrY
 rhr5APDmIEuWTpmGy3j/u/XZXv5ZrJiSJxtneeR/uu3PHZb0bVWwII/XHRJUDAnSD9XuVmU/gUq
 /TYwwzKQAMmcs3CBZR3Rs/hxcuR04TF30yyVri646A0N7EDgQdqNMYzu4yY02zHQxKylkR+KPB5
 ZB7SnVeoSD+bR5GDTqGj4DHycBsMf3SytyCkZUabOxrLZahIBTP53t1R1CDpDbZLOcmH8er7NzH
 85oOEiAVIXJGbCrhoUe0Q5XAMm9lAaY695wgoJOQVf5zw0+AIB4vk9aEMjO3rXdfiw2lczMt/Ju
 dI2ff7EIciXLHPaN1xg==
X-Proofpoint-ORIG-GUID: _bxprZu3y1XcvrDqCTP6FDQHGBZgaYX1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-30_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0
 spamscore=0 suspectscore=0 impostorscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609300071
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

arm_cpu_exec_halt() now merely checks cpu_has_work() and
conditionally call arm_cpu_leaving_halt(), which is now
the generic flow in cpu_has_work_after_processing_async_events().

Register the leaving_halt handler to use the generic
target-agnostic flow and remove the arm_cpu_exec_halt() wrapper.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/internals.h   |  3 ---
 target/arm/cpu.c         | 12 +-----------
 target/arm/tcg/cpu-v7m.c |  1 -
 3 files changed, 1 insertion(+), 15 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index c41fa5225c7..9917931fae9 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -431,9 +431,6 @@ void arm_restore_state_to_opc(CPUState *cs,
 #ifdef CONFIG_TCG
 TCGTBCPUState arm_get_tb_cpu_state(CPUState *cs);
 void arm_cpu_synchronize_from_tb(CPUState *cs, const TranslationBlock *tb);
-
-/* Our implementation of TCGCPUOps::cpu_exec_halt */
-bool arm_cpu_exec_halt(CPUState *cs);
 int arm_cpu_mmu_index(CPUState *cs, bool ifetch);
 #endif /* CONFIG_TCG */
 
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 53f9a532a75..7e411b07bde 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -883,16 +883,6 @@ static void arm_cpu_leaving_halt(CPUState *cs)
     /* clear the halt reason */
     qatomic_set(&cpu->env.halt_reason, NOT_HALTED);
 }
-
-bool arm_cpu_exec_halt(CPUState *cs)
-{
-    bool leave_halt = cpu_has_work(cs);
-
-    if (leave_halt) {
-        arm_cpu_leaving_halt(cs);
-    }
-    return leave_halt;
-}
 #endif
 
 /*
@@ -2625,7 +2615,7 @@ static const TCGCPUOps arm_tcg_ops = {
     .tlb_fill_align = arm_cpu_tlb_fill_align,
     .pointer_wrap = aprofile_pointer_wrap,
     .cpu_exec_interrupt = arm_cpu_exec_interrupt,
-    .cpu_exec_halt = arm_cpu_exec_halt,
+    .leaving_halt = arm_cpu_leaving_halt,
     .cpu_exec_reset = cpu_reset,
     .do_interrupt = arm_cpu_do_interrupt,
     .do_transaction_failed = arm_cpu_do_transaction_failed,
diff --git a/target/arm/tcg/cpu-v7m.c b/target/arm/tcg/cpu-v7m.c
index 48b31d5eac8..1093c6cbf63 100644
--- a/target/arm/tcg/cpu-v7m.c
+++ b/target/arm/tcg/cpu-v7m.c
@@ -302,7 +302,6 @@ static const TCGCPUOps arm_v7m_tcg_ops = {
     .tlb_fill_align = arm_cpu_tlb_fill_align,
     .pointer_wrap = cpu_pointer_wrap_uint32,
     .cpu_exec_interrupt = arm_v7m_cpu_exec_interrupt,
-    .cpu_exec_halt = arm_cpu_exec_halt,
     .cpu_exec_reset = cpu_reset,
     .do_interrupt = arm_v7m_cpu_do_interrupt,
     .do_transaction_failed = arm_cpu_do_transaction_failed,
-- 
2.55.0


