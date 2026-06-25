Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7E1ECDE010
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2026 21:09:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcrJW-0001NY-Bk; Thu, 25 Jun 2026 17:08:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wcrJU-0001ME-IH
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 17:08:44 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wcrJT-0000WE-2B
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 17:08:44 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65PFeJ5t2737269
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 21:08:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=wOAglh9JSHwEYh42iqkguXlvVr5dk+M4RUH
 43WG0Gio=; b=p2vFKYXisiv/NqjfCvgO/6StEs7bNPSVugrVL2ZALG7wgmtzyX7
 /g1L2ZPKjrJEUY6FtWpj7Dtzm/r0nOIbbj+ymr8wuXVxjbDKd6h0Q0T7jhZfrNBK
 9trMG799SQQCC6XNrg51kRL5QPgWPYVr7UbFMeVppPH41/MyrM4Y3KCRiRUz0nKs
 3UkG/uXawlsHOmeZfX1k7+t1GUsWt4GHrL0VRvGnfzrR86mKqBhvtyvggVfwwZO6
 lNTSTh/V6N/G/3bQ0WPYdD6XfNgGXHP0zbHc4OmZjcrmwhrVdHUiOeOC4FDXxkVl
 UB96yAZ/MCIBAAV0bUI4gkb3UpoFMDT5vPw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f0ya8udfw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 21:08:39 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-9157f1be083so44194185a.3
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 14:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782421718; x=1783026518; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=wOAglh9JSHwEYh42iqkguXlvVr5dk+M4RUH43WG0Gio=;
 b=D67AgAK/aBhesA4emajfdESfZH82LA4Z3BMWJc5Ycz/ZcRBUZtUyg5mHMEM0sg8zxH
 46WleyrblqMmMlK+eoloULqCiIFYLwwBW+xgWvvdCdn1LAYjNQqBojPvuD6CO/Dz8hS3
 rSwsLMCljLAfVHt5aZ1+QKkEX/oVDEJXnjSI5yWAJymC6oKMHSTV/yXaQGWQcEhNYMO3
 jaJaJNTxjWBkpYmI9PybMCWayrhgurVnTlaPvwVMqeOZbhb9/T8zLfLiHfbb88mVj1iI
 +lDDLtcseT4T1mH8vT+1xn4gAKC8CRXtE0bng1m8nk5RxBjTECLVNqwnoUizAjUeUsNn
 LShQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782421718; x=1783026518;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wOAglh9JSHwEYh42iqkguXlvVr5dk+M4RUH43WG0Gio=;
 b=czJxbEyJptGJahvPYt3Ce/H+LgFWDwrk433uJ13mKz0mHFjDjuyD9JJpZFg7MfV0i0
 44/kYhmko0/nPk9Tt1NsklpSwq/TUSUbBmiUoyP/hVMrfKknpTPptKkAoALR7Wyu7E25
 SgJkS9QGyPPUbgUpBMVZbAQ31sW9BPmbSpXSJCQhNsDaqXjEcoNk98JvAIP56B+sUsSF
 cQZ2aAOalyIwoNbUZGNWcmKxga1qbta8AZ1W50gHgin2uomudrPeTZWaa2l48AN9rGJS
 GRyPKeq1Vp3T+jbEUI9QngfRgHIp2045N575dCi0bBqbsdgU6N8Dqs4NdKd4MJtBnmVQ
 zqGw==
X-Gm-Message-State: AOJu0YzqbqujOxltNjxyLQEEC+rnFk54l+/te0btlYnVdFL8ApLEETRq
 IzdQxYqnIUdrzRy4+eifPuBVAlwuyr9rWMMSHRp7fvjka5HslvLxNAwBzxGqglBqBsQOCOYOSfe
 j/XydGcPkrC/o/5z0ziKMzA/Vxjw40TTfEDVUPG+6vxiJs86JzhQrvHC++OU+HRkcYQ==
X-Gm-Gg: AfdE7ck3ZwQ1OGmne/9FWyO2IeUwKWKsoX25WTFEHuW4Cyy+5NW/LBUYIVWAFFC2gAC
 jBp6jx15z7gk8cMd5UTNDI1L6oz3oKSf/YS5n9M95h6Lpm8GuJyhu8S68v/2YJk/FAjkmMBhW+y
 PCb5EYKZvCe1tv/FisnwSG7w1VGYhnadwleZYoz6WsARFyTKKBbMX/wwVnXnSpBD4lZF67RPXNm
 XXWE4BYCfD0zqP1ZV/nW2Ts9sMSiLyXn5Gn4fCnHT1vjYPHsW/DHJqmIDmKLEIMokMGdIEdJ2Nz
 Ho/6v8Q6XyCK9KrqrIoES0s15zh+1FRZ0sdX0c1loRI4r3KE28CI7iyhwconeaq0bVzKyNaXLrM
 KjjBuNL8Oh98WXYSlvjgV9fZZOQQrRi2iqG8B0dAxpoKDBA==
X-Received: by 2002:a05:620a:1a28:b0:915:6a2b:6265 with SMTP id
 af79cd13be357-9293daac958mr684274785a.44.1782421718494; 
 Thu, 25 Jun 2026 14:08:38 -0700 (PDT)
X-Received: by 2002:a05:620a:1a28:b0:915:6a2b:6265 with SMTP id
 af79cd13be357-9293daac958mr684268585a.44.1782421718032; 
 Thu, 25 Jun 2026 14:08:38 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([189.79.21.40])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-926004ac1acsm920733485a.32.2026.06.25.14.08.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 14:08:37 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 andrew.jones@oss.qualcomm.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Subject: [PATCH 0/2] hw/riscv/riscv-iommu: gitlab3576 fix
Date: Thu, 25 Jun 2026 18:08:31 -0300
Message-ID: <20260625210833.3294437-1-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI1MDE4MyBTYWx0ZWRfX5OFj9kB4Ct45
 MaSK1om3joyEKBZq/kKXr3qNUpv3oETiXvN43OhjIvr2pP3s20AYVmnxUQ+2VK5ugYSW+LGnqHs
 Krz3eSWNwxj640XvfwkbmxXOiRGvwRY=
X-Proofpoint-GUID: X_njSiJY0RaO35vCSZrpWZlrzRCyTsgE
X-Proofpoint-ORIG-GUID: X_njSiJY0RaO35vCSZrpWZlrzRCyTsgE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI1MDE4MyBTYWx0ZWRfX9hnMyxgxiqHZ
 zslGtAi9F9tOKZ7/B93u5l18RRPNaoF2ufXmu0G+3qhsxYMTKIZjlR5DDxWGr4wW8UQ9/axZ0Mg
 aXmFeJwFUbV2QdF5v7zHmeM52vAqhVd9F4q0prSwswcnQo3Hii1eHu9km+hNXyw61chRKHSz/SE
 PyHwoG4cNX9PUTyvh+J00L6cWFx1AUeKNDuJY/udHJvUNNu+s62xC6heu3zjbzYfrIykYEgOw6X
 cQ0/bOL9dp6/u0KgykUVV7++kAMiz1Hq5EXTp4x+mRYkeD7eyyIlnSQ1o6RnqCC4FpAqIwSSAtJ
 HTbGkTX5SO8q78stSiXpf8KNFlU2sqI6xfx15B1xCYuXh9wxQ8Qj5zqiV+dCHsrxH5JKmJaP5od
 8Qw1vLhZa7GA8cGVrdwhQ1q/Ad94OITiOt6ERF6rsHf9GRVSFEGmdgX+vWS2oNr5mUhM2xvQhEd
 2XJaiFauwz6h5RwFwfQ==
X-Authority-Analysis: v=2.4 cv=Z+Xc2nRA c=1 sm=1 tr=0 ts=6a3d98d7 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=sHJf4AwOIoU3qjeHFPlg6Q==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=kIApeaUeVm8R5dszq7MA:9
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-25_02,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 bulkscore=0 suspectscore=0 phishscore=0
 spamscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606250183
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

Hi,

Here's a somewhat trivial fix for gitlab3576.  Patch 1 is something I
decided to send because I got misled by regs_rw.


Daniel Henrique Barboza (2):
  hw/riscv/riscv-iommu: rename regs_rw to regs
  hw/riscv/riscv-iommu.c: make FCTL.BE read only 0

 hw/riscv/riscv-iommu-hpm.c |  4 ++--
 hw/riscv/riscv-iommu.c     | 40 ++++++++++++++++++++------------------
 hw/riscv/riscv-iommu.h     | 26 ++++++++++++++-----------
 3 files changed, 38 insertions(+), 32 deletions(-)

-- 
2.43.0


