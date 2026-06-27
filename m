Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1E5EC43458
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Jun 2026 19:47:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wdYzR-00047g-ER; Sat, 27 Jun 2026 15:46:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wdYzQ-00047H-8f
 for qemu-devel@nongnu.org; Sat, 27 Jun 2026 15:46:56 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wdYzO-0003wm-7p
 for qemu-devel@nongnu.org; Sat, 27 Jun 2026 15:46:56 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65RHncT21726449
 for <qemu-devel@nongnu.org>; Sat, 27 Jun 2026 19:46:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=94n6dLvTjm7QHNy4xfjSKqYgyXJrT1voiLo
 hDSjYbB0=; b=WDR1dJwvcaJmqu96NkWjj2uY1U7D9pBmnmGiOkQ6F3Pc4oRNSd3
 ThJ80OFXaNAINj2Xf+hD3/Bnl9RHWD6FLmpULsDp5P71q4+dN1r26u94jvvTCtM1
 pVjRQM/divYVYprw8+T3XUp+qzUdSkC0gTCTVh/h/c7xhH8bJivZP/UL+iwMsbC1
 B1n0jH27dqvo68fbxEPWzrGNgTrbL8Q5Mf1wvPAadfNjJE2mDXxzUTGSnxhYRG8l
 qEKekaYB7CP5SVrU68ct1dSiT1o7AspErBqTV8bT2+cp2nBzBbp28gdOVk/gMqpG
 FmWmTkXGMXLJL9E7KdwQHmJzQc+MssjSIQA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f27t7sg7d-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 27 Jun 2026 19:46:50 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-51a71d34c10so31610251cf.2
 for <qemu-devel@nongnu.org>; Sat, 27 Jun 2026 12:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782589609; x=1783194409; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=94n6dLvTjm7QHNy4xfjSKqYgyXJrT1voiLohDSjYbB0=;
 b=XT9TNcBZVYLm5oTOOsq2L45v+TkR3qtUdmjrCgq2Ug7KneFLE7kLZEFZ07GG19ugqR
 2ea58frKKJ22EFeLwh+VOfjd46/6qWDx3TJKYbQjV9vquHvChVznPELWUk1xhm/D8VZg
 OdorK1cSkAZ043n0FvxZU5EeYiTkxQ9ybBfPmKlZ78oG4+Ww4L+MEvqvdPug+EvHowG7
 9P97nzt8MHELPyAqz0hh8pZ42534oKsWihmvMQxp1SdfaMlcZvhMoL1JDjPaBHNK5POL
 +7aWKvj06hTiCb84M9p4+iGXmp0hHSvu8VtfVA0j6Z9U6Crpc0hHDBfE7uz460NHI+ZM
 IiaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782589609; x=1783194409;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=94n6dLvTjm7QHNy4xfjSKqYgyXJrT1voiLohDSjYbB0=;
 b=VRonX5SrbEeiPsbt7qR/vzprsbrC7bDo4nanMCZqYj/fL4xlQNoBx44TpMMTMB03Qv
 vat5jssYXBcidj0Gk6OhnS6ngOUHNOWMkZg/zmdXbFbzk8qq/jII4Ho/h7jXfqH47naX
 VeNDMxzVjycBZpzAIcVFr3j5MbRbSlJS8+x15EGWp8dHsZPawMELEdvF0CidrjYljFLy
 rebQmqxks52MkXR92LoMvng3NnsoZQn7XZzoju5T9Ab51o2qx4xYUUXHVEYuLiuw165r
 kHnzSAF+8uwBkTamYxmeLqjxUm2SLaeaMjWrEbmPPhI54WAGM0AyTcqMSJsdHElXo3x9
 1OvQ==
X-Gm-Message-State: AOJu0YyhHUiZwYPwAbIaNbsDMJoYrH1j2fmwBWiqLfp2QbSA2ILTlacf
 p/gVd87r0GtnMHK/HlUEsA0BGdv2dOB/T4fAkIN2+eNGlOtJTpZ0Uqsc85yBljEAX1w5FcZWvRH
 FJmj2BreI+KrVlADOV5xNQZg5oKVUkyOPfPSohRphDmo1WezeqKEQMpa6qyDIZdJdYw==
X-Gm-Gg: AfdE7ckXcKlsip/dxTr+n9zwPtmlgra04pgmTORY93c7VmYSKtVnJ8ZQ/8A76G47BVE
 vA3+XSt/cYpQCw+/H8Nxfn5Q93agXQRhZlGGYxanqRz8dT1u2zr5LMEy8RXYdSzxpKgNSKckyDG
 9FEGYkBj11trakox1K8/NyVTAfHOg24gcB5ACbaICYQthzG2uyNMN5eC5zDiQOU/OM2Gr1wXPXW
 QxyFXw9ZiLzMBNyRjXAsPW2u8ztfwDXsMtgoLm6NG3s6sMuKWxqpAWNmP+GEOnNygs6HfkW2+sF
 DO8pRkWXEnswjqb9rit/NilT+cZIcEhnJuNfrvr/PV4hY7pD7OOPsfxFD+M0RTjOOiS9eLeNYtv
 BC16wwp8lR/OmPVs0+Yyn/irb7Ia6s5aB18DA1JFlE2C1dg==
X-Received: by 2002:a05:622a:1b23:b0:51a:329:e802 with SMTP id
 d75a77b69052e-51a72a562b6mr184253941cf.41.1782589609162; 
 Sat, 27 Jun 2026 12:46:49 -0700 (PDT)
X-Received: by 2002:a05:622a:1b23:b0:51a:329:e802 with SMTP id
 d75a77b69052e-51a72a562b6mr184253591cf.41.1782589608734; 
 Sat, 27 Jun 2026 12:46:48 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([189.79.21.40])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-51a51a9c533sm133678271cf.14.2026.06.27.12.46.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Jun 2026 12:46:47 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 andrew.jones@oss.qualcomm.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH] hw/riscv/riscv-iommu: check DC.TC reserved bits
Date: Sat, 27 Jun 2026 16:46:40 -0300
Message-ID: <20260627194640.4130073-1-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI3MDE3NCBTYWx0ZWRfX48McZUi1wwLU
 ArvJq7U0U9DhfkFaxU31b5FsyyDpST2uwpNQaFx0EYiP8CVzs+e442hnmU5gbiwlmmu/2S3yCEl
 PCaiWP+2En6gnHLardEir/FZopfvHRVb7jSUIF/Y42saqqsM7x/JtOUZa+xmikReYeU5aQjVcKw
 ub+RsQfPUmralIAxcaZbLyVYtPPet6P8xkXqZCq0xfFWvD9jBqKUdL6xABUK7B4t09OzN+efmcY
 q32IV4UGuY+We+aqT8CNFMVbC8F/p9mXRjXxvRA38VneW2aCDdJOQ3HqMXbeNef419ifMGsWtKr
 MlFIXDvAfaE/qv8551zCh77GbfbcpwhbsTHc1ea4f8dchtGiVAQT3G+vS26ua54ZHg8eWDsaU34
 /q+pXGhzUW3wX/5qMHUBdFcILBGaVkmg66EHELq4YtlAsereJr67kYnB2K6fuE6Vgec44yshxRC
 Lgwk+L+rMdTbGPhwXqw==
X-Proofpoint-GUID: i-J2FMsxhfQpB5fEdKVdZcJ-3-w5qtaN
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI3MDE3NCBTYWx0ZWRfX4gFHY8VUybDY
 xYM1wyn7BhITUpv7/uIdRLI+oHzfjAbaVTi5Kq8Ux3MhbXvi4rhLimylrn+9NpVLLvAJgJxEBbX
 P3yt2o3vra1PXG5YlPJ8FR0fAf+CcxQ=
X-Proofpoint-ORIG-GUID: i-J2FMsxhfQpB5fEdKVdZcJ-3-w5qtaN
X-Authority-Analysis: v=2.4 cv=BdnoFLt2 c=1 sm=1 tr=0 ts=6a4028aa cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=sHJf4AwOIoU3qjeHFPlg6Q==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=p0WdMEafAAAA:8
 a=EUspDBNiAAAA:8 a=wYWBzaFdCuXwoWfkOlAA:9 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-27_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 clxscore=1015 suspectscore=0 bulkscore=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606270174
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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

We are not checking for reserved TC bits being set during device context
validation.

Fixes: 0c54acb8243d ("hw/riscv: add RISC-V IOMMU base emulation")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3548
Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 hw/riscv/riscv-iommu-bits.h | 3 +++
 hw/riscv/riscv-iommu.c      | 4 ++++
 2 files changed, 7 insertions(+)

diff --git a/hw/riscv/riscv-iommu-bits.h b/hw/riscv/riscv-iommu-bits.h
index a938fd3eb4..f9b6f35170 100644
--- a/hw/riscv/riscv-iommu-bits.h
+++ b/hw/riscv/riscv-iommu-bits.h
@@ -308,6 +308,9 @@ struct riscv_iommu_dc {
 #define RISCV_IOMMU_DC_IOHGATP_GSCID    GENMASK_ULL(59, 44)
 #define RISCV_IOMMU_DC_IOHGATP_MODE     RISCV_IOMMU_ATP_MODE_FIELD
 
+#define RISCV_IOMMU_DC_TC_RESERVED      (GENMASK_ULL(23, 12) \
+                                         | GENMASK_ULL(63, 32))
+
 enum riscv_iommu_dc_iohgatp_modes {
     RISCV_IOMMU_DC_IOHGATP_MODE_BARE = 0,
     RISCV_IOMMU_DC_IOHGATP_MODE_SV32X4 = 8,
diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
index c9687e01a8..c2c470b5df 100644
--- a/hw/riscv/riscv-iommu.c
+++ b/hw/riscv/riscv-iommu.c
@@ -752,6 +752,10 @@ static bool riscv_iommu_validate_device_ctx(RISCVIOMMUState *s,
     uint32_t fsc_mode, msi_mode;
     uint64_t gatp;
 
+    if (ctx->tc & RISCV_IOMMU_DC_TC_RESERVED) {
+        return false;
+    }
+
     if (!(s->cap & RISCV_IOMMU_CAP_ATS) &&
         (ctx->tc & RISCV_IOMMU_DC_TC_EN_ATS ||
          ctx->tc & RISCV_IOMMU_DC_TC_EN_PRI ||
-- 
2.43.0


