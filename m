Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E20FF606A31A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 19:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=A5KsQztB;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=EETiuoz3
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLmps-0002cy-Hm; Tue, 27 Oct 2026 15:27:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xLmpn-0002Ja-9s
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 15:27:48 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xLmpk-0002Jl-M7
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 15:27:46 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69RIHT4R2451911
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 19:27:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 m60qRUtoUt+PJitqQF58q09jhlzYEpUpVRJgvKXhrcw=; b=A5KsQztB9kzquiZI
 g1vIydFSIHgK8ARZfrDaQZiWjQi4UfkZExDQKChzKwTNvyAI9s0lXNDInimOXtZG
 +wPvV0vhYxFDPrJZyKix235pGlsaUTDHeQpTHbv1T7iMKxRw1RIj8IZbR3Kuhi9l
 yofXgzaOpHbcTyNvoe4M3x58O3yULmovbDn3MqiWgSTWQmiR+Pj5xV39Ll2c3pCZ
 xm6LXkDIPIZmdkRbiCLPJGQX01XaTmfPN8aZ+HrDMKxqepS27gT18oG0Fhog14vL
 nwx6yR4rDHFQOs2HWeEaA8ACEc+SlIP8uN6AIT2tsrgAw4pEtj+NOmTqVgUyzo8y
 s2X8jQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hjy6g0uw9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 19:27:43 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93f20addba1so20484285a.1
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 12:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793129262; x=1793734062; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=m60qRUtoUt+PJitqQF58q09jhlzYEpUpVRJgvKXhrcw=;
 b=EETiuoz3sukaQYcfjirUl1ZEGA8MQOJMmWLEgNnzVShLrMOrMIPsbSjbVoQVRkyj7V
 ePXErlXEKXlcIqktMPGJUwfOK1hFM39ki5w3SVygZRtKojN+RJiLuM4fdJ0LGhbgVjuq
 stGwoPvNaf0mebO3qJRRDLszB7ohCrcLTdjKWX/beTKN+2hILcpk+lLEChoiEibYgsBH
 ezj6pVMKTyJLEPmuKujAqQrxhSmi1b+PGS9e9em9AS8JkH/97lIF7avVH4PKh7G1U1gU
 Ad/3DhO2Eq1QO3O843TzJPiMupwQjL/gW7AI5L2leO9VFxWSlKcMETqJdLV7bSz0t90+
 VXUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793129262; x=1793734062;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=m60qRUtoUt+PJitqQF58q09jhlzYEpUpVRJgvKXhrcw=;
 b=Wmy32rjDe5/q4XN8hGY/ukLpbwkUPt3swGiezEEc5/UR3SR17LWHFl+iKD6MfuENJZ
 hsoe0hALGBc1Uz0D+cLuWoAM509nQiA78060IGve4Lj4f63Eis+MovEKWxHNP5Ndoi3s
 jUjc/UdlEpQUz5YUQ0j6BNay/hFVzdwMYiDa9tRr/H1larnkh3XYofPqWNjH+w5ksnuT
 HnR8v3t2aKJSWqy+2DrJTFUJPVOuHylSG5iUHJtfbKxmF89xTp9hw5R8MUg/grCCm0Pt
 OyuwW/r202UznaSrBsbt7oxY/yXAeDpr2zkGhPc5PIzjbzkTXjlA/OhEyPmM3XKwVrME
 6d/A==
X-Gm-Message-State: AFq9FYLYRT7wSKUAot+rwAuv9Dv+Nw46/mnaDqRC/VfyNH5Xv2sz0FoQ
 T1wGCOxgo1lcDy3Fjn6eJVjcJ4TiL8Dbsn1yarOQz2aGu6L28MqxFfGRj/4NxESHbDPBw5X2ymq
 +FhcTLo+vQuatzBuZ+2gVoPD5/RKIgvn/CRAPuxCur2afxz2EdAw8xA3015DLQCetBg==
X-Gm-Gg: AYBFou2nkuICl3fna0MKr2lUYr8EAwCrug7dA+6GfuVJIDf8PuvlpReUYSM8fBoPsLK
 5UDgZU2wdPnRf2deTqi+2UhotdYbCobk0ejkOqbqe99B+CZc9bGqpLuy8VOhymb9XIIIW4N8CLr
 la4XB6NUepgSeYa5jR8xJiOVRz4pCbsTK9kgNpMDErhbQlm1545u7dObFTzwfIMgVS4p8S5hizH
 LI1500KUAWdIkuLjvl7BwFwwBQfldtAYPCUWlhVri9VW9u5ZrzGmatDTu0Q52k0Y0g/DZ3BSSkC
 4pCRoygcZpZ5iOQ7omX3Dyv2yD3XX486ELjMDWYjq425iu8yvIq2uEsQNeQ63qefF78l0y+0Uyb
 1GGqdVV8VIxn47Nz839w+V3rc8WYVfCiZiToTaEQauF2z5UR2gpbz5+uJ
X-Received: by 2002:a05:620a:29d6:b0:93f:2bca:2cd8 with SMTP id
 af79cd13be357-940ef96bb96mr1651612385a.57.1793129262214; 
 Tue, 27 Oct 2026 12:27:42 -0700 (PDT)
X-Received: by 2002:a05:620a:29d6:b0:93f:2bca:2cd8 with SMTP id
 af79cd13be357-940ef96bb96mr1651608985a.57.1793129261682; 
 Tue, 27 Oct 2026 12:27:41 -0700 (PDT)
Received: from localhost.localdomain (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a951f7f2b2sm1909145e9.5.2026.10.27.12.27.40
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 27 Oct 2026 12:27:41 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 35/59] Kconfig: Remove config IMX
Date: Tue, 27 Oct 2026 20:23:16 +0100
Message-ID: <20261027192341.9197-36-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261027192341.9197-1-philmd@oss.qualcomm.com>
References: <20261027192341.9197-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA3OCBTYWx0ZWRfX3CiDDxs5lw13
 mPG6aCvyKmZr7yZwCHBLwerV69+C4pLy8TtLJFZ12IEBmIV6ld92lq259rKHIZeDed8WkHIhPjG
 6Ui6+RYlAJou38BYGBv2SyQ7c0W89os01QBFhQjRlZtRMhHEetj3wm8WkqTVAMZ/+ZdXaD3ZpRT
 TgL0xPm3vXrB8xXUVe8KyfUpaz5ZZmaP/UyVmF7xHv9Zl3bbqsbipgbp8QtMJ//DPlHbzVfjAU/
 KOgXeiLRhHl6Cval/h1asvaD4Ho6BM4P3v2dchRwnp+4yJJd2W7ai0JEjpCfUNFJczzjBFaaNOh
 n4zBBoa/moYWNunQJJHRtGmgQT5V9SfXSxUJHwuZQqNYcpMXsTt7yrrCifWHkqlA2fj+s8DiEJ6
 KKSH2/HDBDSvTvknjaB5oxnyJ9u0+ZeOEjzqNZHHfUgarcvSoU5iTZxfgozcHYnRduFI8wX/lXA
 6cdliUgeQrH9Ea8Yfrg==
X-Proofpoint-GUID: 7YgSoX2o_v31IGFaKSKnLJOueae1CEVW
X-Proofpoint-ORIG-GUID: 7YgSoX2o_v31IGFaKSKnLJOueae1CEVW
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDA3OCBTYWx0ZWRfX5FEC/UiPqBrm
 8PI7cBCM/6E+60vxJ2N3qS5Zsj0Qf4QNYhsk2iJtyIkTfAirygnH7OYx5OaoL4YVh9AWt7tbo6g
 8dqG8Mhw8kxu50RMU+svrAbZHuzs2a8=
X-Authority-Analysis: v=2.4 cv=dKgzC+Zb c=1 sm=1 tr=0 ts=6ae0fb2f cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=pGLkceISAAAA:8 a=FRSEYCzRAAAA:8 a=EUspDBNiAAAA:8 a=NiYJVnUlP9n2ZHLTOxwA:9
 a=NRrQhWNJJhzriTs_:21 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22 a=H4N_Y-AU75W7NKDNhZlT:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 bulkscore=0 adultscore=0 spamscore=0
 suspectscore=0 priorityscore=1501 clxscore=1015 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610270078
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, KHOP_DYNAMIC=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Bernhard Beschow <shentey@gmail.com>

The previous changes removed all uses of config IMX. Remove the now
hollow config item.

Reviewed-by: Bin Meng <bin.meng@processmission.com>
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Message-ID: <20261006083445.30362-31-shentey@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 hw/arm/Kconfig  | 7 -------
 hw/misc/Kconfig | 3 ---
 2 files changed, 10 deletions(-)

diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 4b67f6432f82..e9f796f71848 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -481,7 +481,6 @@ config FSL_IMX25
     imply I2C_DEVICES
     select FSL_IMX25_CCM
     select GPIO_IMX
-    select IMX
     select IMX_AVIC
     select IMX_EPIT
     select IMX_FEC
@@ -501,7 +500,6 @@ config FSL_IMX31
     select FSL_IMX31_CCM
     select GPIO_IMX
     select SERIAL_MM
-    select IMX
     select IMX_AVIC
     select IMX_EPIT
     select IMX_GPT
@@ -519,7 +517,6 @@ config FSL_IMX6
     select FSL_IMX6_SRC
     select FSL_IMX7_SNVS
     select GPIO_IMX
-    select IMX
     select IMX_EPIT
     select IMX_FEC
     select IMX_GPT
@@ -603,7 +600,6 @@ config FSL_IMX7
     select FSL_IMX7_SRC
     select GPIO_IMX
     select PCI
-    select IMX
     select IMX_FEC
     select IMX_GPCV2
     select IMX_GPT
@@ -627,7 +623,6 @@ config FSL_IMX8MP
     select FSL_IMX8MP_ANALOG
     select FSL_IMX8MP_CCM
     select GPIO_IMX
-    select IMX
     select IMX_FEC
     select IMX_GPT
     select IMX_I2C
@@ -657,7 +652,6 @@ config FSL_IMX8MM
     select FSL_IMX8MP_ANALOG
     select FSL_IMX8MP_CCM
     select GPIO_IMX
-    select IMX
     select IMX_FEC
     select IMX_GPT
     select IMX_I2C
@@ -701,7 +695,6 @@ config FSL_IMX6UL
     select FSL_IMX6UL_CCM
     select FSL_IMX7_SNVS
     select GPIO_IMX
-    select IMX
     select IMX6UL_LCDIF
     select IMX_EPIT
     select IMX_FEC
diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
index e1396aa8c221..a5d03fb42601 100644
--- a/hw/misc/Kconfig
+++ b/hw/misc/Kconfig
@@ -89,9 +89,6 @@ config IVSHMEM_FLAT_DEVICE
 config ECCMEMCTL
     bool
 
-config IMX
-    bool
-
 config IMX_CCM
     bool
 
-- 
2.55.0


