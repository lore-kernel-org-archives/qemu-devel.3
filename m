Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38777C43458
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2026 17:21:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wec9P-0003vw-K2; Tue, 30 Jun 2026 13:21:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wec9E-0003pM-0K
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 13:21:24 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wec9B-0006ay-UQ
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 13:21:23 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65UEDFmb2216851
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2026 17:21:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=3ro2aSb9dHcrzzgPkP3J5s3lSU/GWXp1eNi
 tAJPgj3k=; b=PdDuSoi0M/7CCoY2yJ/Sr8ZB/CnewaSSx3mQ/7ccpoAGI1Q+D6M
 hn/6TCq7Q2kML19dOFqxyR/hyLL4jEPXgCjXy9yvRfw1ROuhOrxVKV6c+2Q2LiMT
 8oHVjEB2fEmtWk7O/iEoE7g+U+jyIUfjziaZQOYAMctljGraZU3bml3JaIs/bif6
 XnRdo3s1icM7R0EjRx2RUtUtZj4cFpYxdjdfj1TMb9Pt8MtyKnXo6VsaIfI3aQk2
 RS2XKrM4aIxF301lpJqsB2oE1YQNynOXBp4KmfT4yJnuidiGP0XBpqs4U3F4NWF0
 exk/OjSUsjfu05kcGyZffb7gu7JQK4yw5uw==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f43vfkxyh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2026 17:21:18 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-8ea75996387so94108006d6.1
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2026 10:21:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782840077; x=1783444877; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=3ro2aSb9dHcrzzgPkP3J5s3lSU/GWXp1eNitAJPgj3k=;
 b=d2fL7X6fL2eFiq5hbZyMZrqFrFKUHBcZZ6glns8uF1B72KsjhT/roaY5nBxGhpKfo9
 k0ivPboH8Nsg/UgOkGaCAaDLBp+M7eLQYDhjUJ4r1GjFMuN2Fk6KtH2HgeL++wv9EZXq
 ZphzJK7HyDzoKWwd+TYLnvDuc1AdemOZsACmjI6sUa0fXQEUnkggL/TN9ai0t2wgiPkB
 EL89eremzgtfbYCH66MaYcLLtl0J+gwIaozTCtLHDLRjU8Hb41uA1Ji9UKuf0Wft9GPY
 N7sJwPDDM1mavUj1qyHcCV9mN2IBEWYa3lfSDRPReRKfwx8dKvqpgK1ekvXtFQd7vo93
 RIAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782840077; x=1783444877;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3ro2aSb9dHcrzzgPkP3J5s3lSU/GWXp1eNitAJPgj3k=;
 b=SeVWt6TRQ+z06VD0/uku9xRZc9fMoRdE7RkGBR26+rt+xYlugjHwm0nd24aTJ6tCbP
 CzN2gzTEBcLqhR99K/jwKoVo8OHD7PdjKgO03MUeGwW2c9Ta9JTErwXsTXcLw6dl9Sl3
 Y85gxzk2+4rtNuBPZKo8PVcVGlsBH/HYt6yxJmmnRDn1OXJnFE9RUFcnOa0Isc1C+/u7
 j6SmvMu+BwqXxmIddqiScBkwPy1bb+LPL2uRmG+Lva53RWbPy2DiTUgFP+AHTdzMeEVC
 Es25t9QdtW8b1DZ+e3IYu2ltwsoRF9j9Gz+75utVfy8XY0uOjMeWEs4CT/sGCP1JBB/d
 rUAA==
X-Gm-Message-State: AOJu0YwFUgQZq0KllVpisCAVDRxu21wG+kkN6bJ6VR1R1ltXPjsSf82P
 oww7ERna9C/OL56g5eeqY1J4D1t8+OqXyIXCcWxepleoBtt0OLdivB/eSahmrLQE7c0CDdq3ChJ
 iVHoDEn9AhTGCQNJ/hQF+bhL1PkQT1Od/bcbmJGSvPsUV2pC3nbSEaAi6ruLnmcWgJw==
X-Gm-Gg: AfdE7clCNeFfCPdClL80YlK6XzCdMUQ+H52tkFhVdHaN8XgWGYxqACyujGz4yxfDpw+
 UN9KZD1JtWEVvZdNVtYCcy7rrgp81uKbdI2iUf3ZfUe16mXTrpfGdw+H0p6jj/a/uXGQ6rD+umD
 yXW9DxG6S/F0jgVkSBshmNy3TgqjHNbpIEbWt7oSoFaAGB9BTUaXK+N30Oc5DlYIqA+wJRkGp/B
 vLeFAPJNE5IDz5WiV7GCZqg575UzQpIUYddSVvQ/BV2jTE4R+6Xks4nN6BFFWQbCd/6j8ZcjxFN
 cICRMxtuH+MMK06xg42i2mjnv1lLyY7QAIk5nvwd0kQAR5q6Wc7cwx5l9+bocf9K3dlFl8w5rJd
 FYfGb4EkViL7azEwMaYFMFxhsU3NCaAyYzlumX2fI1zEGbA==
X-Received: by 2002:a05:622a:903:b0:51c:1a46:9148 with SMTP id
 d75a77b69052e-51c1c9f3d61mr21353741cf.34.1782840077281; 
 Tue, 30 Jun 2026 10:21:17 -0700 (PDT)
X-Received: by 2002:a05:622a:903:b0:51c:1a46:9148 with SMTP id
 d75a77b69052e-51c1c9f3d61mr21353231cf.34.1782840076754; 
 Tue, 30 Jun 2026 10:21:16 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([189.79.21.40])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-51c10862ecbsm22704371cf.11.2026.06.30.10.21.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jun 2026 10:21:16 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 andrew.jones@oss.qualcomm.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH] hw/riscv/riscv-iommu: forbid GATE/SADE if caps.AMO_HWADD is
 zero
Date: Tue, 30 Jun 2026 14:21:10 -0300
Message-ID: <20260630172110.1866951-1-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 8NexnI9TZw22xA7ljzwd7nvLxL57WflE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDE2NSBTYWx0ZWRfX3Y5dUo+BpXzo
 F0deId5QE+mDE+7XywuZB81SFDMp7jqTtj+qm7476FT9PoODdH/CSJCGadObkdqdF1SvHB8n8et
 nzpU+2HLKOyeMGoSpSk5OT3bFVz5IdOSoNDzkTDtrdcedzSmqDynOOFJP672YwfXnbq/J1ZSa0b
 hdcZop6RKCf6FMxjD37SI/UPT7RsoTT951IODX4uK+RnoDjP3WHWCXiIobhVZSPDrDKctFMchSJ
 WhSu00jAm70pB4OXKtUbvkmJCF/YyoYhngisgrrhBbC/4BDpkkPykDY7cn0cm8CWZbRUHr2G715
 1ESYYGRxTm+p3S84Vfzkobh5jTpkmGD+5q+y1zvnqx00g6M4uQHHuMJVm+lkFiM+QUs0QroKQLW
 /H0fRJ5How36yNBAIhb8Ok8iiiufJRVFDXQu0S/UZSyBlnWLwM3SMrXJOt+eXF4tfde5Ga+qAdW
 HrTJSKg+Nmkrj6ptMdw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDE2NSBTYWx0ZWRfX3lI4DngvfFQX
 0T4NHHLd/5qQF+Xtwb8xUXExcYStqmb+7RheDyHsajb0cUFSJ8zp7ItEiarsCc3TvBaMnphL7QT
 EknLamjRo1oTMmSPrVQts7IIN7Jd41c=
X-Proofpoint-GUID: 8NexnI9TZw22xA7ljzwd7nvLxL57WflE
X-Authority-Analysis: v=2.4 cv=PcXPQChd c=1 sm=1 tr=0 ts=6a43fb0e cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=sHJf4AwOIoU3qjeHFPlg6Q==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=p0WdMEafAAAA:8
 a=EUspDBNiAAAA:8 a=fpgzQ8Lw9WClb1XMRzwA:9 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_04,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 clxscore=1015 impostorscore=0 bulkscore=0
 adultscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606300165
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

When capabilities.AMO_HWADD isn't set, DC.tc.GADE and DC.tc.SADE are
reserved bits and setting them throws a DDT_MISCONFIGURED error.

Fixes: 0c54acb8243d ("hw/riscv: add RISC-V IOMMU base emulation")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3549
Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 hw/riscv/riscv-iommu-bits.h | 1 +
 hw/riscv/riscv-iommu.c      | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/hw/riscv/riscv-iommu-bits.h b/hw/riscv/riscv-iommu-bits.h
index a938fd3eb4..2e8bc19dca 100644
--- a/hw/riscv/riscv-iommu-bits.h
+++ b/hw/riscv/riscv-iommu-bits.h
@@ -86,6 +86,7 @@ struct riscv_iommu_pq_record {
 #define RISCV_IOMMU_CAP_SV57X4          BIT_ULL(19)
 #define RISCV_IOMMU_CAP_MSI_FLAT        BIT_ULL(22)
 #define RISCV_IOMMU_CAP_MSI_MRIF        BIT_ULL(23)
+#define RISCV_IOMMU_CAP_AMO_HWAD        BIT_ULL(24)
 #define RISCV_IOMMU_CAP_ATS             BIT_ULL(25)
 #define RISCV_IOMMU_CAP_T2GPA           BIT_ULL(26)
 #define RISCV_IOMMU_CAP_IGS             GENMASK_ULL(29, 28)
diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
index c9687e01a8..891a56e731 100644
--- a/hw/riscv/riscv-iommu.c
+++ b/hw/riscv/riscv-iommu.c
@@ -416,6 +416,11 @@ static int riscv_iommu_spa_fetch(RISCVIOMMUState *s, RISCVIOMMUContext *ctx,
         const bool ade =
             ctx->tc & (pass ? RISCV_IOMMU_DC_TC_GADE : RISCV_IOMMU_DC_TC_SADE);
 
+        if (ade && !(s->cap & RISCV_IOMMU_CAP_AMO_HWAD)) {
+            /* GADE/SADE are reserved bits if AMO_HWAD is cleared.  */
+            return RISCV_IOMMU_FQ_CAUSE_DDT_MISCONFIGURED;
+        }
+
         /* Address range check before first level lookup */
         if (!sc[pass].step) {
             const uint64_t va_len = va_skip + va_bits;
-- 
2.43.0


