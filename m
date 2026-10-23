Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7A84606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 16:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=e3nZ+3ws;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Ym5ohlTh
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKHr0-00015i-0u; Fri, 23 Oct 2026 12:10:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xKHq7-0000dw-On
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 12:09:59 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xKHq3-0001VZ-6N
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 12:09:54 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69NE5sh84072734
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 16:09:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=A89pYnehqG9
 Oa0zr2K6Nlg1zPjOZrHj4TGrxRdiRMKc=; b=e3nZ+3wsUPbBP+JHCPFp6it1/WG
 rfHuqWOxLe3Pa+EaUSts6OTngv+GQ4gRT89ZljbIZkmzmWuYFNy3TIvcq19JS+dK
 F274zU+fE2porLY+Bpma+8ZM87sOjnNii4fhi9wYKmE9jlhOyI2rlNfcZifsIOme
 YTg4GIS629IL3Sc1eSEM+X+72OLSURwLQaZhr5+O7eK/oJjUOcjSHxuzI9PFoQrT
 T213gAyeZ8bclshxclAeueOv6kTBzNpjdOzIrdb4weyecX82UPdB84ec137kaMF1
 GZgKK0If24q/q/WPf4LOzqwUiAdmOGB3WkmbhKmvNGzo9c2i/ab+5lxonzg==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hg7bw0w2m-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 16:09:37 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-917a109c937so16109196d6.2
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 09:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792771777; x=1793376577; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=A89pYnehqG9Oa0zr2K6Nlg1zPjOZrHj4TGrxRdiRMKc=;
 b=Ym5ohlTh17VUi0BcOE3eefvNV8mln1X4E5Yr4oK9iflc5/kPGCvPkmHcZfotnrTtIB
 Fk7AtJehyESCR5eJZr9Cw4fTwaof9iQCtM7m+BUOISoRH+3yVWddTJYgUyng0vKb9UHh
 0VaopVwLozpZn92lknqb5tigIYkpwBDC1O5MO96YcQZZ3TjtDx5SodiVU8G99+MYJbxh
 d92gUqEnGWZgDgtypDgfOdcAC8ISDu3TrZ1T9t9CxmvTBnDwRFR/8p/LjRbqtfr1fKDq
 Sp53rARQwMaiJwV1Wf8i1DXYNbFKIv2CcNNuqeyDp069+VQv9AIcV9fvjDrWjJy0K1We
 Y2Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792771777; x=1793376577;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=A89pYnehqG9Oa0zr2K6Nlg1zPjOZrHj4TGrxRdiRMKc=;
 b=fjaeXopH6lb+qHtdF5eDpPKsYVvg8KobcV79thL2r+Dy1ffMDyotR1KHuroAZQV+jR
 1wrPrTn4+MjyyGjvdVMmjwl93lmpJIVR2yKQvUWPBgZjMczy3E2BVJeVX0YF2zrwNmBX
 M53yx70yLQuXcW+ozE0jepawCsyteVp1AU3WCgxm0NUMWDjCNA00XlQqEXeXrfwPxfZZ
 bp7r86ve4Rjxx7dSyKJ31v0/n8m4UKxVysyhuS3CahansmUcOBOr1nWNm1bimPBt44si
 kL7eqt/LcPohOw4eZ5UJI+aZJuz3WHLZTEyLOPyIC7/v+BHC5ysDTJqWot75EPIsZmxE
 9kYQ==
X-Gm-Message-State: AFq9FYJ2XWKgQbKGVfQKMWaGKOPoq/UPLYo5f59wsqto1vKeaaIy0QeQ
 b2lGbeRX30krxJWDnAJps/q0GpzLJnSMoTRkhwLd4fqJizuQmJT0drEoBYXG+SSbyAXNSCqvlYx
 xx6fotrjclX/DnjBL9HcGL+L1t71USatAwHGz4OvDnJx2JUWUTTZ0XLHq+KNa/jQogA==
X-Gm-Gg: AYBFou2KBNUV/xHOoB3kR77iK0xy5RkLvdfKGk254pUvLD2GpUq0etDtcmCsBL5Pow/
 ePmkS9c0zd2CD6F3893ajRiEkYS1fOm37fXaRtXn1WHHqZll+v64DDkLgZ7DW7ewaWFKkK8pulB
 Kvn+rBLJlQGc+fzkhgbK9QBX91zT6W/Mdcd3uEjYxA1/FZd5w9B5kHD5ySyJfeoix5w+Tk+qnuF
 4Cu90/Zyu8T1lbj5WIlOCenrTQzCbbEbL4N84xFtv8Lgvnema5jUG0Jl/621o0HF5+LMbk/Gqj8
 +ju9xPMk7WlEf/bbSUzJ4pE+kvrJhuq+GWGHGXRpjU4cowgfJV2UT4HMSx5L0IZbZG/XwGE7zEk
 jWb7XNpNjENwuXFq/WP2MzvNj4mviwKtgG8mIfw==
X-Received: by 2002:ad4:5aa9:0:b0:91b:9694:d6b7 with SMTP id
 6a1803df08f44-91c3a870eaemr40014486d6.30.1792771776677; 
 Fri, 23 Oct 2026 09:09:36 -0700 (PDT)
X-Received: by 2002:ad4:5aa9:0:b0:91b:9694:d6b7 with SMTP id
 6a1803df08f44-91c3a870eaemr40014026d6.30.1792771776207; 
 Fri, 23 Oct 2026 09:09:36 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([152.234.125.162])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91c4524f226sm5063406d6.27.2026.10.23.09.09.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2026 09:09:35 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Subject: [PATCH 6/6] MAINTAINERS: add contact for the RISC-V server-ref machine
Date: Fri, 23 Oct 2026 13:09:13 -0300
Message-ID: <20261023160913.24992-7-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261023160913.24992-1-daniel.barboza@oss.qualcomm.com>
References: <20261023160913.24992-1-daniel.barboza@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: yZGPL8hc4EI9dmeO3RgsWW0CH8RGCDwA
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA2MyBTYWx0ZWRfX4VppVKs+6OMo
 yDQu+SgYfre1i8qkGwZzQdYhrAS8gGDmcfNqQWS/b2bGNdV3swYMWwjaLAeItq6piE2Mwltw4OJ
 YrrKOXFa4ZjKvgpgAEd7XpURX/Ie5mU=
X-Authority-Analysis: v=2.4 cv=QdTzLcbv c=1 sm=1 tr=0 ts=6adb86c1 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=AgQEunjic7gIBKSbIeB6Ag==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=69wJf7TsAAAA:8 a=MOatoMk4zhW8oBTF--8A:9 a=pJ04lnu7RYOZP9TFuWaZ:22
 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-GUID: yZGPL8hc4EI9dmeO3RgsWW0CH8RGCDwA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA2MyBTYWx0ZWRfX+B6OskoLNBmN
 iv5EolRhyJ0YArz3ECEDXqKuS6f2gi68ezAa1UovsJ55zbCgaWucXmnw345KKYHQMK2yaGVhX5G
 2sz8boUnkMOD1Pe3fC0yC9Er4ED4z/ziyfYK9nKK8BusdOaLAM+ngF0ttm8KjtUTzwz3ca06NEO
 fRu/uSrrGLxNDMm7RT2ZJHnQbLQ/DTqDxeMT27kbv535Si+vJAiF++iDUvU5bSuSKtXR9jOvMYb
 KGdzNOnFOGRUuI65fhEnFfiFCndhdrqJfamNdIVDe6DaLZnkTD+eUKbCMmOM+E7FR+08thgxj4d
 CIdt4jPUlk2P6c+kGUARrEr96YhjoLJrYzm4neggKbqIbcBmaBKpCkST9IiKvV+SmlQYf5BdDmR
 ZZCuHIIvCC7a19Gx8B/MEzsx5YICkKDPvVOCwAbrfc7kc3lrwxDfLCbuIJyuv8CiYmIQsf5s/ah
 B1p/W7T/NhRc1jUIvrg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 phishscore=0 impostorscore=0 spamscore=0
 bulkscore=0 priorityscore=1501 malwarescore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610230063
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

Make it clearer that this is a board that is actively maintained.

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index d9209f043f..146bdb587b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1897,6 +1897,14 @@ F: include/hw/riscv/cv1800b.h
 F: tests/functional/riscv64/test_milkv_duo.py
 F: tests/qtest/milkv-duo-test.c
 
+RISC-V Server Reference Platform (riscv-server-ref) machines
+M: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
+L: qemu-riscv@nongnu.org
+S: Maintained
+F: docs/system/riscv/riscv-server-ref.rst
+F: hw/riscv/server_platform_ref.c
+F: tests/functional/riscv64/test_server_ref.py
+
 RX Machines
 -----------
 rx-gdbsim
-- 
2.43.0


