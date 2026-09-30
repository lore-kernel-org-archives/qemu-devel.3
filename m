Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9688FCA5FC4
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 17:46:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xByNa-0006kQ-Pb; Wed, 30 Sep 2026 13:46:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xByNZ-0006ju-PC
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 13:46:05 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xByNY-00017e-1f
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 13:46:05 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68UHf5jX3566639
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 17:46:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 NKFkuHP5kHsFlr48mIqBrzrwJma0vgwROjVU+AFRLRs=; b=W1A3obzCX5JBKYEW
 0eK8ADbLdVLvZKN18kOqHfVfO+T4wqG5qkAv37xm9gE7/t5bYG/yhJT9vVRxsSwx
 UOrLoUhTdG9l4S9vOAkSNdp9fdDkviO/2pUDFVOIEnt4skMcCN+6pfFBoOo0Fq48
 LKNN7w6P2gOHy0vN8Sf/Fy6kbuYVddA2bGBegTqzosi5Mss6IDCCczREcK6YJqXX
 KsaSfIrTui4EMh969KCSydRVk0W5zKxGd3slLdMFXnyb7leCWo82Gmp2Znxj/7a7
 ByTYNzlHvhlDHiiqom3TQi7xgPXDvKJ8uPH4FUCqbInwEzlVLZIkgzeYj/BhCNq+
 wyYrUA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h0smjky98-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 17:46:02 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93bf4c0af4eso3347085a.1
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 10:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790790362; x=1791395162; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=NKFkuHP5kHsFlr48mIqBrzrwJma0vgwROjVU+AFRLRs=;
 b=HBKwEF7ac5rQIrljEGlrgzuti4/qrO0i4eO3r5hx9Tj7H+4U1jAUIUHGkwe1OMEjMA
 Ip9vvs0NGp0awai3ElfMr0HNwXZWrDnX/xsSOyIbpxXorkMql5eWgFFOEGM/bx4Z2Sne
 TntdxiU4y8Ru6MDLjCGFfVG8OFzR24F4VQC/imVjdyMeYH3/vcs8X3ipoiI7If1Ebi0s
 9dJtJVK40U9+rHolwNOwdl0o23Yq22nbXfsr3SfwyNUc55V678A3c7X7PzsjZ5gRdVzF
 YYVioyBcFUD/nL71YTK1DXlYmCe8Mkz2wbKvUyJIBA8TEmM4Z3gwvObFIsmdDPiyUkJE
 oRog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790790362; x=1791395162;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=NKFkuHP5kHsFlr48mIqBrzrwJma0vgwROjVU+AFRLRs=;
 b=ubJ8NZb9gJSVnwNqRAhLBRRMKWaPVd+mmnfP50+4ovAxcwyN/gNGer9w31EQBJZEhl
 EIXC7+hbOO4M8YyUrKKykdvbX1KSr57gqhS/IbU+a+Z987/XRH2U5QaL18bqWwaGWLgc
 SuH0Eq2O3nuVIMWulpUdxBWK+7gOsjw97xF9VSJJX12TN8TLu7KTh1lsVOtklGHL23K/
 QInlyvuROuR3tlpSRExLq9MrZAzbUYXhz2fi68pM9A73U2VqvumMmXFOgyzWMBqkJAiJ
 +Cj7YVpdgtqyb0IyyV8VDeoKEfYWmxTu+54BQ6eYAOdpzLYBRpGP0P5U/g0dZpYEgUoR
 mCPA==
X-Gm-Message-State: AFuF++kXTF9pchsOvBsRHpK7QXatgoyd94xTh0dOUQOceLss3wY2sU/o
 kRAzTkVI7rN2S/U0xZyvh9hAwyrU67y1j7nBN7lJzaid2SHARwpoFH0e4nqgGwkT2T608SBQ30H
 zfsxB6WkF7kFBCEUKKp1rbaElHwLpunx4U6zc2Wr+soukBBNaOzumG6zIs226AtaK9g==
X-Gm-Gg: AYBFou346g2TLYZ7VBWH9Z7URl7SuY2PZy4zn8oPQYzImKZ6I+HOLgCJe0mlMkEgqHc
 hBJur753TEjoRfyyOxJ601xBf5ePgbN9zQ26O43h3whsnSqKu259cIDJNAOZ+vOUHgr6kJOYWIV
 7hR773QS3KQqGqfk7czg+Bjc6Mv2Y50eDLhHFPtEry+SjJmr5wBfuhY6dnewj5w0Q3MHu8kJlZB
 kmioazPgk2ODKnqSTjTE/WEK2xXl7qaOjzcLzQexa1boNUJzroQJJIYKXNwx7+5L3jbWfqHE+7X
 0hCVHrzKDH9rxrfANFjyglJR/iEhWCFgbenWriOusLrYe+C3jNEAkQMKyCzxHAvPJTuFldxz2zt
 RVsgwz3fhoy3QaoglSc4DWPj0EqkY6oRK+H3fzWCq
X-Received: by 2002:a05:620a:2942:b0:939:3f4f:7254 with SMTP id
 af79cd13be357-93cb5a5c552mr74605885a.14.1790790361539; 
 Wed, 30 Sep 2026 10:46:01 -0700 (PDT)
X-Received: by 2002:a05:620a:2942:b0:939:3f4f:7254 with SMTP id
 af79cd13be357-93cb5a5c552mr74598785a.14.1790790360809; 
 Wed, 30 Sep 2026 10:46:00 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48b068bcb8fsm655488f8f.1.2026.09.30.10.45.59
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 30 Sep 2026 10:46:00 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Chao Liu <chao.liu@processmission.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, qemu-riscv@nongnu.org,
 Weiwei Li <liwei1518@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v4 7/7] target/riscv: Skip redundant MIP updates
Date: Wed, 30 Sep 2026 19:45:07 +0200
Message-ID: <20260930174508.81497-8-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260930174508.81497-1-philmd@oss.qualcomm.com>
References: <20260930174508.81497-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDA3MCBTYWx0ZWRfX+P108TCx6w6g
 a/THsN8b6+jEUBpBOz5ojfUpTIOg5W6GWyCQt/XOCDvbNNYKL+mip5OcecYu4OYeTopD6zKC5bK
 YVMUvn47llsjwmfJHKS9XaWG3aZW2JY=
X-Proofpoint-GUID: Q7zLCixjyxRjLOCsPrUuxI348uuAOenj
X-Proofpoint-ORIG-GUID: Q7zLCixjyxRjLOCsPrUuxI348uuAOenj
X-Authority-Analysis: v=2.4 cv=KfxHIgYD c=1 sm=1 tr=0 ts=6abd4ada cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=wLUV87mrs9pMXVOQZCMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDA3MCBTYWx0ZWRfX/kYEIVaproPJ
 yFrKab5G5RoTgamFet+00uu7OrEdiBWJ/rHKDlfo7JyCniajOiawaRlFLnU1DmR8nQm0Axvr90m
 ldc2Fxwd/8fVz6CDreRFDN4wSqhIGP+YY2W6M5G2VHgovuDXuqzg8qGPhqTKeWN0hQR+KJGkt9d
 fCfefBRakPAvciP+MbMsj7ooPwVF2hDxRUyq4vcDBcVaJFgDoLr0EAr91dISvqz1qSctJmxGzlp
 Lo/NRks0FwWur/TqcAk2bJuDKr/1ux+9RPmcvTAIBEyqaPnoj7lRYCghzGhAAOg+2lJyPTdvlDe
 g018IwnNJTHRv3HopiUknq39c+vjKfJ+8gNx640n1Xow3KZXIwUtwrkpI8zFQAc1TYCr9/00i27
 4n6bg/gfCBfk1SjdQqFTLVX6et7qa4hEnk3uZ77ayAmQw48LrL3zH+ISIv/+af+qoq2SJc0P4a4
 LZ7JBXZ4GXGwXfJ0q0A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-30_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 suspectscore=0 phishscore=0 clxscore=1015
 priorityscore=1501 bulkscore=0 adultscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609300070
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

riscv_cpu_update_mip() was called with a zero mask only to re-poll
interrupts after updating env->vstime_irq, where the VS timer keeps
VSTIP (see 14cb78bfaf4 "target/riscv: Don't clear mask in
riscv_cpu_update_mip() for VSTIP"). Move that re-poll to
riscv_accel_set_irq(), which now calls riscv_cpu_interrupt() directly
for the zero-mask case, and keep the early return for the no-op VSTIP
update.

No caller passes a zero mask anymore, so document @mask as non-zero
and assert it.

AI-used-for: code (prototype)
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 target/riscv/cpu.h            |  2 +-
 target/riscv/tcg/cpu_helper.c |  6 +++++-
 target/riscv/time_helper.c    | 11 ++++++++++-
 3 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index ad731bf5d34..6173360e407 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -694,7 +694,7 @@ uint64_t riscv_cpu_get_mip(const CPURISCVState *env);
 /**
  * riscv_cpu_update_mip:
  * @env: CPURISCVState
- * @mask: Mask of the MIP bits to update
+ * @mask: Mask of the MIP bits to update (must be non-zero)
  * @value: New values for the bits set in @mask.
  *         Use BOOL_TO_MASK() for boolean values.
  *
diff --git a/target/riscv/tcg/cpu_helper.c b/target/riscv/tcg/cpu_helper.c
index db7f2bd6de7..16b2c486934 100644
--- a/target/riscv/tcg/cpu_helper.c
+++ b/target/riscv/tcg/cpu_helper.c
@@ -579,8 +579,12 @@ uint64_t riscv_cpu_update_mip(CPURISCVState *env, uint64_t mask, uint64_t value)
 {
     uint64_t old;
 
+    assert(mask);
+
     /* No need to update mip for VSTIP */
-    mask = ((mask == MIP_VSTIP) && env->vstime_irq) ? 0 : mask;
+    if (mask == MIP_VSTIP && env->vstime_irq) {
+        return riscv_cpu_get_mip(env);
+    }
 
     BQL_LOCK_GUARD();
 
diff --git a/target/riscv/time_helper.c b/target/riscv/time_helper.c
index 29bbebb96fc..6bd917383e3 100644
--- a/target/riscv/time_helper.c
+++ b/target/riscv/time_helper.c
@@ -39,7 +39,16 @@ static void riscv_accel_set_irq(RISCVCPU *cpu,
         uint64_t mask = irq_or_mask;
         uint64_t value = level_or_value;
 
-        riscv_cpu_update_mip(&cpu->env, mask, value);
+        if (!mask) {
+            /*
+             * The VS timer keeps VSTIP in env->vstime_irq rather than
+             * in mip, so callers pass a zero mask only to re-poll
+             * interrupts after updating it.
+             */
+            riscv_cpu_interrupt(&cpu->env);
+        } else {
+            riscv_cpu_update_mip(&cpu->env, mask, value);
+        }
     }
 }
 
-- 
2.55.0


