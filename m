Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77D89606A31B
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 18:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=GH1A8KFr;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=JNnIHZuz
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJxOc-0004jG-7z; Thu, 22 Oct 2026 14:20:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xJxOa-0004et-9r
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 14:20:08 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xJxOY-0000Vc-01
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 14:20:07 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69MIHOkG1510062
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 18:20:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=DWNS+QnaLQ/llNOq4BB3aU+o9fobtMGcO3j
 83fkBwv8=; b=GH1A8KFrOCogN0Y033xi/2wFdt6b2rftaKsjJQ4DihqmT+idcNM
 N9RaVtkuE7aiw8foHGUD7IS+rj1LsFIGjmPNm3SN0/ThFWZITtSdHwLem1j1hOCW
 fO47hJIeQJydD1+rTTspTG1S/DZZRrrLg1vL8xSGAiYdqBEL5DnUuTT3slfY/t60
 xZO9fzbJ4ir9WeGb5oXWb2Uw14qd65YQE0vr+FKLkSwBKBolojq/zzrbWcGu0GjM
 fnNNzPQjZSA+yO4m03+9kzhVydgmD2qkl0cNDZEdBEna7i736qIssskB73T328I+
 mWQwq0l1J+wcHDIaLm2/vAQTOMH5QlNfpdQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfqmp80ey-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 18:20:04 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93cb7f9bb86so480300685a.2
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 11:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792693203; x=1793298003; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=DWNS+QnaLQ/llNOq4BB3aU+o9fobtMGcO3j83fkBwv8=;
 b=JNnIHZuzenYYJOSyTqX6MIm0CQcXcj1eisB/dR4u5JDhMAKIFdIx8CS735KRMglP6h
 LFBlVSI/EHsU14ztaGvfK268ge2t8cOnxrpqGQJvxTsglAxf8INAl7OydvetgOWmAAA3
 i2C6tyj1WcA0qdaN/kPORmr61xJ+b278Y6j0Hwy+HQ8iY0r1KcMPnuXJyPi15xXxkvjS
 q0hHNB4aKl/oQyvfUhztEq6MhEXWn0DqzhSIj/TRlcqVuhl4ZrWRDFSnSuExd/INKwhW
 mPEi6c3F2u9p+V4RTuWJRQSZhmInnmEkSx6RvswfVSwEm3/oD5AxmMf7SB+nKgencfKe
 8lJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792693203; x=1793298003;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=DWNS+QnaLQ/llNOq4BB3aU+o9fobtMGcO3j83fkBwv8=;
 b=Y2bnoS1b0pF6/1X8+vhZf14o6Bmx7AAhCXc9i8UrqM+RZJNou00RKHsNGc4DGb6Vxn
 E/BrbvdAw0ygVIPoyPIIGt9u4kiYlJcUG1/Sg4iKb+hX6cNSZXBFOzyiwX9tqwEBXIYp
 F2NJFhk5bclfQy60VXPvo5ctrPbtDHHyfkf6nD+mFlOrQM1dMRyZNMWoxFWgiBGMrOmI
 Y3F+9BTBWmMRxOX/EJaR1yu6lSu7DIQRPwyKL9gBh2zjXZU/xJIf/P6BM2zHnb/jLN95
 N0S78impuNgrVKWAyYiZDDXKMdT1yeQovnP7d+8APKWR2mawYcmdbf4MI4G4JOi0WZF5
 jyEg==
X-Gm-Message-State: AFq9FYK6SjFN6SIZECFC0mXPnILpj+KQl5jcvyp521cPpreNouhUehaZ
 RGXZIBwZAz8eNGhcRFODke0QdApJcjfP16BkgNuvvg1S5vXrutFFfUb15raBaRWcP85WRwb3M5S
 ADfS7OJ8jzbXD56wgd2oFoMopWC2HyNtw8GtAe6qA8tVzHHXfQmSemrFxrMbPV+rY0Q==
X-Gm-Gg: AYBFou3aABs0vRRh1Ia/8x8l1DHDEu437uPoPDCVjrwz/DWBjvPndjO9GS7CW15eUoy
 gYHpbL8nICy5g5MuVpPgYi+fCHcJOxo4Trv0cN5Lg3i8IwaKBBa/+Ge76LjSv7iR5j5te8Q0XfS
 yQeTOaNF65tGUHAolkt89jEJizm0XYCD2lGTUbWjhzFmSOHDh4aeFvWcOhdIG7T7HIPE63gNbFr
 KvU9LhXMNqhJTFKV047No8ZttCvkZDRUJ7nXFti09KWkjVNBxffcMekjaMARpl0++N/hdNIcAMA
 eA7DF9WeWH7zUcKvcEbJo5heuXLDKBF0NTYyQqyQAR5ewmqh4RCS5uTC7Av0hvloSbulrMfCg+5
 BaKxEQMPuT3yrdLmE2pSnVLv1wiNizatjUkLm4g==
X-Received: by 2002:a05:620a:6c09:b0:93e:5861:34df with SMTP id
 af79cd13be357-93f6f7ba4bamr51733085a.47.1792693202954; 
 Thu, 22 Oct 2026 11:20:02 -0700 (PDT)
X-Received: by 2002:a05:620a:6c09:b0:93e:5861:34df with SMTP id
 af79cd13be357-93f6f7ba4bamr51729385a.47.1792693202478; 
 Thu, 22 Oct 2026 11:20:02 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([152.234.125.162])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91c370061e7sm3617416d6.8.2026.10.22.11.20.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 11:20:01 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Subject: [PATCH] include/hw/intc/riscv_imsic.h: remove unused macro
Date: Thu, 22 Oct 2026 15:19:57 -0300
Message-ID: <20261022181957.21760-1-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDA3MyBTYWx0ZWRfXyPRkp6Ts03xs
 bcnRQ8AusZp/NWeVWICSCBPA3f+e9D/EQwYGwxhwXYQhdyCK+LfkQUWmQHU3eA7gD1/V3tirU/U
 SxW2WcPNFBeZ4xlNxnQgHZmfuyjwP0g=
X-Proofpoint-GUID: 9BWb6U8szbnXhCV6RffvDxfCixE0MPwk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDA3MyBTYWx0ZWRfX8U7NWFaVkfVg
 mYWnhCsBauiGcueFf/SGWUYjR+BdzaOs/WDBvEVuqFbkb3LLAe+2iIJmzJ72SVc4aMsrq/+WJVs
 KMsqMdYZAyAxAJqBnvhi/13JOYaI8HS1uXdT8PPNxpaeD3epL+/Ok2qzWAZeLWWWHTID86lQvVK
 T5vNghri2uEeuSNrilvA8IBtSzjUaNz/BLIginoOG3NrLpYA0C44DQQLafITvmHKzn1vT3WCVSt
 ag1Y+JitSU7iQ4ySoriS6M7uThdPCHE6uqRy6r6Lk7J00Lylaayq9eR18hEBnDOJ+wOMlJAUrWX
 ZN85mxJsDvPJjw6m1Ck+E2tsHQDwPhgD9z3Vamvvy09TcSgYPyyfRai36HD8GxCvku+EayM4pGO
 atV1jcZzL3Je7Hv+a++OFEFwNcmlkWRkRASyldraIWeO6hnlK6Zez4ynuTM3JVSEMOFXMVrVLbt
 rnWxGrxxtPF36nN7eFg==
X-Proofpoint-ORIG-GUID: 9BWb6U8szbnXhCV6RffvDxfCixE0MPwk
X-Authority-Analysis: v=2.4 cv=BdBNQbt2 c=1 sm=1 tr=0 ts=6ada53d4 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=AgQEunjic7gIBKSbIeB6Ag==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=Gqw6Gra3IEblmeP_dQUA:9 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 malwarescore=0 phishscore=0 impostorscore=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610220073
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Found while reading IMSIC code.

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 include/hw/intc/riscv_imsic.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/hw/intc/riscv_imsic.h b/include/hw/intc/riscv_imsic.h
index 0a1df1c2f8..c744836657 100644
--- a/include/hw/intc/riscv_imsic.h
+++ b/include/hw/intc/riscv_imsic.h
@@ -31,7 +31,6 @@ DECLARE_INSTANCE_CHECKER(RISCVIMSICState, RISCV_IMSIC, TYPE_RISCV_IMSIC)
 #define IMSIC_MMIO_PAGE_SZ             (1UL << IMSIC_MMIO_PAGE_SHIFT)
 #define IMSIC_MMIO_SIZE(__num_pages)   ((__num_pages) * IMSIC_MMIO_PAGE_SZ)
 
-#define IMSIC_MMIO_HART_GUEST_MAX_BTIS 6
 #define IMSIC_MMIO_GROUP_MIN_SHIFT     24
 
 #define IMSIC_HART_NUM_GUESTS(__guest_bits)           \
-- 
2.43.0


