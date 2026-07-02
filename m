Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90C16C43458
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2026 20:37:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfO97-0003ei-EZ; Thu, 02 Jul 2026 16:36:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wfO96-0003dk-2j
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 16:36:28 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wfO94-0006i0-BJ
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 16:36:27 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 662Iv0O31226889
 for <qemu-devel@nongnu.org>; Thu, 2 Jul 2026 20:36:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=B+dqtRSj2X+Zvm9EUvR7J+Z7icE4L3mxio1
 ULCnQGk8=; b=CV3hDM0TloMM/116tVIQGHyI3S8pJUD5sYBVC0LyQOJhOB3Wp4e
 KhXqRjYN8vVxab7cZ9u1/kN5qkrfA7D6MXgtCUfaLpTlKkzk1QD6a7sYEmQ1nphA
 /WgVelvq8wYEZMvPaoOWFlp+YpRMW0Xxs+o2tMbE5Q9BUMKc7eiVWrh1qGAtTY+V
 m+MtWigncrzm508VMGiS2Py/maqHlHqdURz6JJUYEqr+c5FA326MB15P0bcOtReg
 CzQpyKshMNlOoCL5yLQPPv14MmHWWPuAL8UT/6ynxP2BmQvSeFKLaBKaHgRy4UMi
 Kmgknnru2dYpFFu/OxrZwDi+Zj2+wziZzpg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f5nprap4a-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2026 20:36:23 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-92e5e38fbc5so258925585a.2
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2026 13:36:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783024583; x=1783629383; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=B+dqtRSj2X+Zvm9EUvR7J+Z7icE4L3mxio1ULCnQGk8=;
 b=GN05UmZ1/qkCS1jrGqhQclSU3PGic2XJB5Sz2poqQbquzuDV4hhdhYwd03chsPQlT1
 oG0SDKISaN+qf991nV/Jrzo+rxcpeEktImN+mOdd7w7ldPlCjLa5/V3PBOTwW5XRTFSQ
 2TeBj2ublwst66+Cs3sm07tkQevh+6GWnMfMj5U5GpTFK9x638niNBpXn2OA5DRB+cYt
 wmRVMXq8v6ClJqj/lLDFv7y3KAZza6EOvk5Sq8Q//XRMypkbNlolhjw6Mez79szIQz2Y
 VsmVO5ceoTvwo5L7uzhu9ju5JeJ8gW9jBCII7BZTlwvtg7re3+Bz2Rz8EX5jEgtJ1xgF
 No+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783024583; x=1783629383;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B+dqtRSj2X+Zvm9EUvR7J+Z7icE4L3mxio1ULCnQGk8=;
 b=a+sgHu1qE3jI5I/F8ewf2UUGMG8pmU1YQBZQfMnijzKaqFVn3UfC6nWS7jIeHFk39o
 L6spyppQe4m70qCO7UMiqeBWZ2Ycve8QGYAQHj+moRDQLU0nxmT2YvQE/xQN0HazVFFj
 t41b2I/M+04VvNGnUDFxeju6Ykyf20i4/9bg63ViRxyGoPtVQzijTmEdACn7aeqFAQGU
 x+4QvpnS1fJjXg8+MQvEm+eyyEZvSQbd7aeMjYoN/ufDJ6LgMtxTLe0r5LTbbyTs6C2U
 TXpWBQncI+Jnm9Aq9cpZer+zDnz+YKXpWtZuh6O56pQ0nuicVIXdOLfUlaMkFBSIJ1xs
 QBtA==
X-Gm-Message-State: AOJu0Ywdy5pM7FwU244p0n/7ITp1dQEFfbwkV49jlOkY22l1wzofBiOn
 abob8elsbBtexwq7Qil+0Kak2pgeuYd/1JolR8uMcb+7iGzmP8G2JbDJs9Cjduu0oOdT3fB/7a3
 eOzVJ1OBUSd3seQmDjdH2/SieNVjxoOnEYjN1889VnfOmffDJsyQgvJLNinUAUaQfIw==
X-Gm-Gg: AfdE7ck+gBl6Qwiuf/5pmPK1Ll8cRD81xpLIgKFzEJhyDekCBFJ5g6vRvzydm35bc4d
 3bgJF0ToEAmG3JLVd+MhKKsrZh5q7mz9TK8DES2PHXwY0QyzmQzkiImu+1HAG5USwIeBz0OG9wN
 knlZHdRFY3V4v14uhV9Qyo8CaoyJcAIIEZt5MJsRzO2ku1xJ13h3Z29CDGklowLwyZ9rLsFDI7W
 NT+taWzW4zGO7HCqL20YtCzIf3Y5eTieVx9C1vOUTTKgG3dSU7V2ORMguVCgkMA+dOi54p/MEz5
 RjgCcaKuzM9htmiD8oaM7NtREMpaVoZQPs97mhdTDca4N6jYWJBipg5BXUgM9wzH+mh0QkvqAbc
 UW1oKAsuCBFykLu8lhQITqf7dDqSPG52gpuEYwLJBXYc7OA==
X-Received: by 2002:a05:620a:410a:b0:92e:76cd:9594 with SMTP id
 af79cd13be357-92e78233960mr1023095385a.19.1783024582779; 
 Thu, 02 Jul 2026 13:36:22 -0700 (PDT)
X-Received: by 2002:a05:620a:410a:b0:92e:76cd:9594 with SMTP id
 af79cd13be357-92e78233960mr1023093185a.19.1783024582346; 
 Thu, 02 Jul 2026 13:36:22 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([189.79.21.40])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-92e801bbd5bsm309347085a.44.2026.07.02.13.36.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2026 13:36:21 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 nutty.liu@hotmail.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Subject: [PATCH v2 0/1] hw/riscv/riscv-iommu.c: check for misaligned
 IOHGATP_PPN
Date: Thu,  2 Jul 2026 17:36:15 -0300
Message-ID: <20260702203616.1795588-1-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: zSF1Xq11D7szKdCTKAXyrZAk6rEuuQPk
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDIxNSBTYWx0ZWRfXxkjZp1s7ni0l
 xu4ua7NUcMAELHYOQ8mudLpE/xUqDDuhDQzlImbfVS5D88+/1Nw34QA3kAuiM1z2TdmUeG4VrSE
 GVref0Kdgj7rIipApLAHjQJQP0oW9vs=
X-Authority-Analysis: v=2.4 cv=NsvhtcdJ c=1 sm=1 tr=0 ts=6a46cbc7 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=sHJf4AwOIoU3qjeHFPlg6Q==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=ez8M8yltyU10Gaq5cLUA:9 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-GUID: zSF1Xq11D7szKdCTKAXyrZAk6rEuuQPk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDIxNSBTYWx0ZWRfX2y8dLSnGA6a4
 9YlXDRg5eZbXVu6/AusEeLFpzZPhv/17cNzGWljOqWUyFNPTh200CDbK95OOuZ9YXMP0oRsrOb9
 1YNrg66DtUoRE87xr50GeMtToz0QfEfwa1JyL/JPG88vFQH7gorEIJTJrPbVO6GM945KfLYU3cN
 JRwWmsmaqk0HzNntkH2Da9DM3OzkdRNIadOa9+L55AvjX3gXkA3LqKEE4dCLlkixnbS3/Wym6tB
 70jfQ+CSzQ9XqmN8PsIAV6pSubxDYm8hRuULdmaUjowHAGWW/8kOMSH+1ZKr8BVEFJtLnSzTaLU
 e4y45mO+qspDIpsckT1Jia6m+AauFxyH6NnGiA/1GWR7gBuGmQOFbBI2FEMgNvhiXEkC+hC8jsd
 yyNsb8GF93VIkikhGxwdTH5LNTLv5qjV9G92a1QUJ/3cZJt6D5h2rFL528MKPzbckDauPC+VebA
 CGZeTbTtwiobdDKvEVA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 phishscore=0 suspectscore=0
 malwarescore=0 adultscore=0 clxscore=1015 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607020215
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

This new version fixes a blunder I made in v1 pointed by Chao and
Nutty - I was using the PPN value, instead of the page table base
address, to check for the 16kb alignment. 

We no longer need to change qos-riscv-iommu.h because now we're doing
the right thing.

Changes from v1:
- use PPN_PHYS(iohgatp_ppn), i.e. the page table base address, to 
  check for the 16kb alignment
- v1 link: https://lore.kernel.org/qemu-devel/20260630203155.2103084-1-daniel.barboza@oss.qualcomm.com/


Daniel Henrique Barboza (1):
  hw/riscv/riscv-iommu.c: check for misaligned IOHGATP_PPN

 hw/riscv/riscv-iommu.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

-- 
2.43.0


