Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5582AC43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 15:14:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wh7VQ-0008E8-3R; Tue, 07 Jul 2026 11:14:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wh7VJ-0007qd-KG
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 11:14:33 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wh7VI-00079j-28
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 11:14:33 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 667C93FT3590163
 for <qemu-devel@nongnu.org>; Tue, 7 Jul 2026 15:14:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 pjwllV9Cl6pKNHqYNBltfv7GH+bbKzdEEmrwbV3G8Cw=; b=SJeWyf8gkQC8OzLu
 pRn8q11rOHPgHLL7as4w/6rN/RCVenmJkbb3Hk7ALavm6uSl69+IO4CtkQI5lg+0
 oMvrtCm8uYq8SKBv70FN2rgo5PE+J0VCRQaemBdtBJ5+fcSw91f9yG04TUDrmgqh
 36MfuTWd7mU94uuB/11P/pWmT3EjfHrfsbbihJNUWGL9Kc+eM2dBeylyacrBF40P
 Z5o079X/QNpK6MZMjcjNT7pfd4um1kXpDKAdPAwjNzdeoELXf7EJLdNEGBMwf89w
 h1VtYpSZ/tx81gojoBOOofqRqJKEIhR9vTkN13ZS+SOIW3F5N9h6iGa9raUljEG1
 1QFlqw==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8w2u9wdu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 15:14:31 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-8f45dde7595so47578956d6.3
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 08:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783437270; x=1784042070; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=pjwllV9Cl6pKNHqYNBltfv7GH+bbKzdEEmrwbV3G8Cw=;
 b=Va4ZBoLTD1CumMlxU+WoOasoZK4jQ7HE2DFa0UcOUsr2ZCHptqwjWg2ZeebFlDcXj6
 44vdIS2KM+F80r/Ve4tAGCkzypcMSe8nifXSMHQXwqTEvNeRB4gEfaCT9lsXrq8CfRW0
 ZhBs0aCMr7mq5/t11I8zYfwMwh8RQd7u2ACddftLlxNX6kOTPrxPTvfPIlTRVLtZB/Sg
 6HiLlbblng/8nI/1MgZ1S/9Pgwa9WfKYdSsQwEtmhZCLeTMQaiwn5mkZXjucU2ouMafn
 pSSxB3g3g3BQ9dCUKvlwGsx64tZdxUYqfRIHtVdzkAKJDK9ZSMrivQUBnJGgdeQ70Sch
 Uc3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783437270; x=1784042070;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=pjwllV9Cl6pKNHqYNBltfv7GH+bbKzdEEmrwbV3G8Cw=;
 b=Hsojy7stVm0iRhTOW5mfqWz8fZu7uiCmNvFz3trMty9wB1N74pPDFqgGTnTiFsbOic
 3ZC6vUxkQinwD++XwrZwBI0P0FZwB/rEIQw24MO1LM8x45lchB88miCrvNyn2XO/O4Wr
 64628Kj6dXbpLa/fDsSy9FCN5nhvkrnKQG4YMH0GGEmo96HtBTQpo7IREND+tJjceXdR
 dEyhKstgwiTTqjpiZnf3YvMgpjv4apyRFq5nRx+WyobsTKN3W9cG1awSY2vOpvtxe7J+
 IwASaXy5KYNVso4HzDa7sTkuUTq8wPgQ4Am3wpXUbcq6VUGTWpF3R/UnChd7vxdk0SbA
 nC1A==
X-Gm-Message-State: AOJu0YyDB9IFalLs7v3vvAU77feceOsMpyXZeY1r+Rv/6yytEk3Tii5r
 kx5qO9HQCGKhpAeJ3rFKMajEQoE7FbPEyGpfhjcSrXYypU89+Buh7sPAmjOSy6dJO8Bu8M9Dhon
 QRmSr86zTCNVDTLujTu1XvBX7/dNVEfmedrRIAOh68GEN/EtVQaPQkNPe4UQAlxBdKQ==
X-Gm-Gg: AfdE7cmezrDWcpvobtiyDvm+thxbcMbBdfmDjdpfIDvnupaLy8IYmdW5dJen5pGHz5g
 o1w3gbp2DzZmB/G0oqe7Tz0wfBXrjxRDTj2HRFjPWw9tBXQp33IwwDyDvgzoFEFIq73M9p4bcR3
 /BFtOeK4epz0q4n7CYWRGl27seCJXi62hizN6oh+ej/eOAcohAZ7gLQQi5aNheIL/b/R/3P90Ou
 g7NmG4foNfsxSQoaxx/5zv9AowA3lysDMX5XBXtBl3kNHaN/y/CfMEh60AhX4J3+KqAubwmrXTW
 O6Cd5ljUtBWDmmnMK2AQJtdyQrMtKAbo7jIQSThK+dbsJXrQEoxdOMi2Dh56yuSMane2axttwcj
 /SEgHoABgU3kzYIogA3i4WwWY/YhgxE2T0IxHQ/1aMta2YQczbeqD8IXx5aF7UmjUCmqa
X-Received: by 2002:a05:622a:1209:b0:51c:217d:d772 with SMTP id
 d75a77b69052e-51c747b985amr70970771cf.19.1783437269871; 
 Tue, 07 Jul 2026 08:14:29 -0700 (PDT)
X-Received: by 2002:a05:622a:1209:b0:51c:217d:d772 with SMTP id
 d75a77b69052e-51c747b985amr70965371cf.19.1783437264290; 
 Tue, 07 Jul 2026 08:14:24 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493df7010aasm50178945e9.0.2026.07.07.08.14.23
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 07 Jul 2026 08:14:23 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 36/36] MAINTAINERS: update Chao Liu's email address
Date: Tue,  7 Jul 2026 17:13:51 +0200
Message-ID: <20260707151351.57769-5-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260707151351.57769-1-philmd@oss.qualcomm.com>
References: <20260707151351.57769-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDE0OCBTYWx0ZWRfX3YgmMP8iuBmG
 tZg6xUP1ST9RIkD5OpZEeSlHVEej0N2OvbbxJhSN7OpR7W+vKMzRYfXA9iltMaudDL8ohSbn45i
 Msr4N7PdhP9s/1n4S2aklckLy4TI+PQ=
X-Proofpoint-GUID: jhOGzywGxv-icVwiXBMIIPBR49rq9pM1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDE0OCBTYWx0ZWRfXwiSZqUWturm5
 E8z3YfukmHVATo3tGnaIp2z2TWpRO6hQ24k2oiAryz1AcJ9tiG8t56L0PQJ6lXsBh+HX8brNWNu
 OLLWYWp21tDsiLvMFJhjLPviajoOFVUu3aueSxELC9pZAjV/lRNL7PCBMD449aNuTqGyyrdjDLD
 14ZLiIt6MWKMD29EYgEyc3/ped+VNfDN/CNjjeXCTx5Yx5lUuEtMLREgP2/Qm/sVSmmCJWxyk4u
 V5soSQKicJc5KtG5gz8Y6QD/6entpRpVwlfcki8Hyy5CrJ+zp9YiVX1VG12f94LME1oxPAWnEUM
 fedR5VARkiYUscGd2w3/25F5bevbj8/y6qtwQ3IHaNkM3gQrcfjWrQmShnHXLjldDtjnolatHqR
 qnnddHrlAWz+EyYNY9QBZLCxlq5BKLeXApiiJ4q76dKAUwmqjKYsZ3y64j3pxzW9qZWCjUIJ+OQ
 bnF5HFoNTvGwiiRsiiw==
X-Proofpoint-ORIG-GUID: jhOGzywGxv-icVwiXBMIIPBR49rq9pM1
X-Authority-Analysis: v=2.4 cv=bPQm5v+Z c=1 sm=1 tr=0 ts=6a4d17d7 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=FRSEYCzRAAAA:8 a=EUspDBNiAAAA:8 a=JF9118EUAAAA:8 a=pGLkceISAAAA:8
 a=SRrdq9N9AAAA:8 a=69wJf7TsAAAA:8 a=4xJ3ySMZSMD7joqOnicA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=pJ04lnu7RYOZP9TFuWaZ:22 a=H4N_Y-AU75W7NKDNhZlT:22
 a=xVlTc564ipvMDusKsbsT:22 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_03,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 clxscore=1015 priorityscore=1501 malwarescore=0
 bulkscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607070148
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

From: Chao Liu <chao.liu@processmission.com>

I joined Process Mission over a month ago and have verified that sending
patches from my new email address works as expected.

Update my MAINTAINERS entries to use the new address for future upstream
contributions.

Signed-off-by: Chao Liu <chao.liu@processmission.com>
Reviewed-by: Bin Meng <bin.meng@processmission.com>
Message-ID: <20260707132701.71164-1-chao.liu@processmission.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 MAINTAINERS | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 1e239f21166..5029be1586b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -353,7 +353,7 @@ M: Alistair Francis <alistair.francis@wdc.com>
 R: Weiwei Li <liwei1518@gmail.com>
 R: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
 R: Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
-R: Chao Liu <chao.liu.zevorn@gmail.com>
+R: Chao Liu <chao.liu@processmission.com>
 L: qemu-riscv@nongnu.org
 S: Supported
 F: configs/targets/riscv*
@@ -1817,7 +1817,7 @@ F: hw/riscv/xiangshan_kmh.c
 F: include/hw/riscv/xiangshan_kmh.h
 
 K230 Machines
-M: Chao Liu <chao.liu.zevorn@gmail.com>
+M: Chao Liu <chao.liu@processmission.com>
 L: qemu-riscv@nongnu.org
 S: Maintained
 F: docs/system/riscv/k230.rst
@@ -3806,7 +3806,7 @@ F: hw/pci/pcie_doe.c
 F: docs/specs/spdm.rst
 
 Checkpatch
-R: Chao Liu <chao.liu.zevorn@gmail.com>
+R: Chao Liu <chao.liu@processmission.com>
 S: Odd Fixes
 F: scripts/checkpatch.pl
 
-- 
2.53.0


