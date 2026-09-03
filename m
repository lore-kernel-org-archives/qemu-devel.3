Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF671C61DD3
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 10:41:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x24sn-0006cB-HX; Thu, 03 Sep 2026 06:41:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x24sf-0006PK-4V
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 06:41:18 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x24sc-0006ik-7B
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 06:41:15 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 683AHBDT3782255
 for <qemu-devel@nongnu.org>; Thu, 3 Sep 2026 10:41:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 LJzMQEeZwuyLRZ794iT9ittOkktIM5KJ5hP5aA3wxVQ=; b=JpLwleicmkC6d7Yv
 Sj3Hez0tZePZJHshIIxqs3tgls4baRIYxjiSkJnKlLC3pAwoD7oKGoFvEYL/oJ98
 tjqYOWjuG4c4TUwSZ0NK41bnpVAbAIPZXN4y15X7/7PgTrhlvXJwANBsX/HwMF6+
 dgo10ZL6be3vi0ziMKRLRPGR7yVsil65cBZD4w+V5xf5EBlIU4Dn0X81CCLfgQul
 Z+q5uO3o5ASZkeqmQpvuysk29Sd7KlRWOVyUo3XtyiLYvBBFaGL5nWoznFMUu0XE
 qKjhSWvP0gHL4RGLtgUJ5QtDTWcquhWde2hO08fQYk39qMXt5cVuX30+6SWyrrZc
 4fXiQg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gf5pdrfuf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 10:41:13 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-92ec3146553so614234585a.1
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 03:41:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788432073; x=1789036873; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=LJzMQEeZwuyLRZ794iT9ittOkktIM5KJ5hP5aA3wxVQ=;
 b=UoqX7/R1XBQ/11xeBOLKiZHm0k7eT+89q11hX5kl4gAtBV15rCmUHLUqz8EweNlB0F
 aztpSXBOS1cxTroaPreD6j8iuPQDD8a9G7owP6EPyb/dqnCnoWLoP/7LI7ufvYJxqspG
 9KpJWEnAOUxKhHFCds2kR0CQ59U/NlGeU1a51dOEegi1RGixBFFqoFvx1p1c9Y8+gLvh
 aAt5mleniWES1KykCLaF4XbJRFx6txX16ABSUpiGCL7UsFenbhEVbDvF6cwUSCayDIXe
 HRvPHLlpqrp1t/XcueKdEdTjB51b+BRqHxwVN73/Jdu6sfzIquDV4rCN+aBypebCcann
 aiMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788432073; x=1789036873;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=LJzMQEeZwuyLRZ794iT9ittOkktIM5KJ5hP5aA3wxVQ=;
 b=B7aF5xTp8IHUiURSI6Fn2DWlej3R48tRtHEx2DmWyx6iwytzG9AvfZY+wprm4v15i9
 m8Sfd5F4R8ZjleYssImDZQ3TNAhgo4qvlz68jIDHZdR1oUIKtFJ2AZbLCLc+U6OvvzLR
 ytGidBPZJnR6B3PYDgu6LGKHZSyAvA3ES8mFyR0LXCfh6EOPU4OTm3E+EKUcIeDFSvcl
 4DxtsiBRxb8EiRD0Eb4BDhl+/LnSAFUHkk0mkymI8uy1rNTUZkitBQ8bR9mKNxI1hgeU
 v2/eK5dRqgAJVRYyEZ6Y9NIObBmFwYyA3j4V7xMpIwdq1EarmzrwdZtmAPwOjG5MP8xt
 y45A==
X-Gm-Message-State: AFuF++nD6XAzyLgPnSVzrR2Dck64gU2xY7/CvQbMNpGmCk9WbGB7uVw9
 tYlLnnE5OuV3R5qF9MznOD1jbT45q83gVcP4qdv4o1/FPW0aFMA5YoeeFMk22gxTeVEo6skljot
 qydZYXbIbx5d2M8HQipBeXJOcXATSu3RCb8LjftFhy6lMBlHvXwnypLIUy/2mtpsbgA==
X-Gm-Gg: AYBFou0RJpUN9jdSNiY1TmlJQOXuP4kFWIVVImWaeHU8TolRoRnv+fcANzkrz+P0qTj
 TD2+lsTrCRb1wkMhgh9MmdB6OFin5zopb7d5U2VNpQNVRTgGKqluquiTeb0gfeXWH++n3LZsD+S
 unXiqOnNersg/94dYYN1mctnqgpIyxR+WnuPmORAmRYJ1/LxGTUUJE2MGRRt4GAizLRkOJ5ZdAq
 DB8xnt8d66Jl5eUjxpSa6vRmQ2ybZLpG/eot/9sVanPFwtxBvbjZtZUQ+WTGeDhM9zE6pW2vc9D
 O1nclrhBMTUTZ85Wyjig4twwoAhBfhUGF7foxo171Fcn1Ny+81R/5j+YnizQ/xr08D1Lh+eGkgT
 QdbqaGSefgdQ0mgMwVyuMhpLcUP9k0AzorgQChcST
X-Received: by 2002:a05:620a:172c:b0:936:77d7:55a4 with SMTP id
 af79cd13be357-93960e5324cmr1234609285a.19.1788432072753; 
 Thu, 03 Sep 2026 03:41:12 -0700 (PDT)
X-Received: by 2002:a05:620a:172c:b0:936:77d7:55a4 with SMTP id
 af79cd13be357-93960e5324cmr1234605685a.19.1788432072234; 
 Thu, 03 Sep 2026 03:41:12 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48448eea5b4sm13248317f8f.27.2026.09.03.03.41.11
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Sep 2026 03:41:11 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 13/51] hw/sd/axiado_sdhci: Add header guard
Date: Thu,  3 Sep 2026 12:38:57 +0200
Message-ID: <20260903103936.62355-14-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260903103936.62355-1-philmd@oss.qualcomm.com>
References: <20260903103936.62355-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDA5MiBTYWx0ZWRfX+3BKhvXhNwVn
 T8fZxeul07VwTg5ytad4ZNbA/ZFpNVerVOpTAWhPiVER5RXIIlv8AiesHCl6y8m9inB4yGGv0At
 TxXBUx9LTFBtM8PhYgRrf+fbsQ0WD8A=
X-Proofpoint-ORIG-GUID: wKCADhAoyLmXh-6xBMkknm-VQoupP4n0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDA5MiBTYWx0ZWRfXy6bWwPXkN0ak
 6DGL+nLBZmBuGzV73pvDSNyH1A2RgOL2ArctCKULqEaZ4dhgcSOA8LIllephQZ/CjyXBWRkHNwT
 NCZnGBZKeC8tL3dmtJoiEEEiCmLTQ14g3JzvF8VuJqZezLeEAgfcRqtKzybKAUFMdhHMC7ekOIm
 W0Qrn/gUldAk6HJeE0n+p35v4JcP5oZn431WO+G75mWFw7oNxqtC0b2gKO12eoBVjsrS8WbqPfV
 d0UEi9fPTOO7WJjJeWW+poTueUCkiDZBABgY9if+MoHLqkss/Nun+ZhsGYa82J9ymwu3SRedTOm
 vfOm75anLhygNvk6+kRDxfjCaM7LmIUyd3DkCVhomWVWmLNMWH9Kfb6jXRcqNzglNZkodNQ5Zrw
 azI73BCDpT82+JIqN1C8OBtY47tKnIEXxsJxyEAICM8E72lR8hBv2A+B+adtvCLaCNtoS0HI9fz
 OZafEtIasu2yTM85IgQ==
X-Authority-Analysis: v=2.4 cv=RsL16imK c=1 sm=1 tr=0 ts=6a994ec9 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=440cDlBIAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=1lr7JO5igfqhUGZHbYQA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
 a=d9D1X1bx8dWolqnE4HNT:22
X-Proofpoint-GUID: wKCADhAoyLmXh-6xBMkknm-VQoupP4n0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_03,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 priorityscore=1501 suspectscore=0 clxscore=1015
 lowpriorityscore=0 adultscore=0 bulkscore=0 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609030092
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

From: Kuan-Jui Chiu <kchiu@axiado.com>

Add the missing header guards to avoid re-definition
errors when this header is included multiple times.

Fixes: 8c55a630c5b ("hw/sd: Add Axiado SD host controller with eMMC PHY")
Signed-off-by: Kuan-Jui Chiu <kchiu@axiado.com>
Reviewed-by: Jack Wang <163wangjack@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Message-ID: <20260826074635.2850931-2-kchiu@axiado.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 include/hw/sd/axiado_sdhci.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/hw/sd/axiado_sdhci.h b/include/hw/sd/axiado_sdhci.h
index 85afebad931..ab52eb8185f 100644
--- a/include/hw/sd/axiado_sdhci.h
+++ b/include/hw/sd/axiado_sdhci.h
@@ -6,6 +6,9 @@
  * SPDX-License-Identifier: GPL-2.0-or-later
  */
 
+#ifndef AXIADO_SDHCI_H
+#define AXIADO_SDHCI_H
+
 #include "hw/sd/sdhci.h"
 #include "qom/object.h"
 
@@ -19,3 +22,5 @@ typedef struct AxiadoSDHCIState {
     MemoryRegion emmc_phy;
     BusState *sd_bus;
 } AxiadoSDHCIState;
+
+#endif /* AXIADO_SDHCI_H */
-- 
2.53.0


