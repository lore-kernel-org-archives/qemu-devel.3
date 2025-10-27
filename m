Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 843B3CCF9EB
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Oct 2025 07:53:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDI1A-0006I6-2B; Mon, 27 Oct 2025 03:51:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_haixcui@quicinc.com>)
 id 1vDI16-0006Hc-0x
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 03:51:48 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_haixcui@quicinc.com>)
 id 1vDI13-0002eR-1S
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 03:51:47 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 59QNAVbp1001383; Mon, 27 Oct 2025 07:51:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=Uu0EDrjoa1pw9SL+Xf0dm5
 bMLmd6Ag7+k4tlqTfk3l8=; b=ppYJArPSHUIueHYvs8XxV3zk+7LTN+kVnUQQmo
 D6E5WudxpIT4gYpxaENP3b+MMrtfmYRwBBTpH9t0KyFzJ4T/kFXQ9wdSDAIATpER
 +y0COZc4g+doH3pXKdnjhxk66wxztZIed5/63f61b/UOw1LZfI8Pz2mZn/epUFpS
 eqBd/r7HXIvlCe9iiYqYEsIyHzF64W9hfp9s7g6ZUtgR5A26rTagFrZRFAYa92wP
 62m0BY/dqxIIhvl105nSwN6nPKrpS8nugBRyACnkYBgmYXJU3ccbw5kL7EJRPwy4
 8VdFc3csHzd7WMvQCBgPjzOk8Wd3m+l2WubIqc1AlNikAFOQ==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a0p4wbr3m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 27 Oct 2025 07:51:40 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com
 [10.47.209.197])
 by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 59R7pdW7011098
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 27 Oct 2025 07:51:39 GMT
Received: from haixcui1-gv.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.24; Mon, 27 Oct 2025 00:51:35 -0700
From: Haixu Cui <quic_haixcui@quicinc.com>
To: <alex.bennee@linaro.org>, <viresh.kumar@linaro.org>,
 <quic_tsoni@quicinc.com>, <qemu-devel@nongnu.org>, <mst@redhat.com>,
 <zhiqiang.tu@oss.qualcomm.com>
Subject: [PATCH v1 0/3] virtio-spi: Sync Linux headers and add vhost-user-spi
 device support
Date: Mon, 27 Oct 2025 15:51:20 +0800
Message-ID: <20251027075123.2237914-1-quic_haixcui@quicinc.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-ORIG-GUID: g107uv6Q638m1FFNDD34dES7RyakLZ80
X-Proofpoint-GUID: g107uv6Q638m1FFNDD34dES7RyakLZ80
X-Authority-Analysis: v=2.4 cv=NobcssdJ c=1 sm=1 tr=0 ts=68ff248c cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=ONEyY3_IPAylEGahahoA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI3MDA3MSBTYWx0ZWRfXyIWQKscjlWhI
 by1ggMQzdHnT3SfJ3viOM04LJvk8tDGbHQffA8PhSH9zMSRoVpYzZ0uvXNISP4ANqEpVrLgj4a7
 xEL3+3DQ0LNY/AcuBLJdLnqnV+T6m6dTuyBA2VMXs2pLTj6vRrR318xLHWUswDtr4k5c8ohJJnS
 rrNQ6yq0VQcbbRjCQr3Zl8MgRwVD71TGqa+3s7yhIfijsPu3vVwNx2heOB685b3/nUPA47sbQrl
 ZqY4/UMfsHo7uXR6f7/u89YS0eSuI+/9JwEdhViGH2bPyIC1Ysgl6tk5GZz0CiASl+Eo+ezlCFm
 a6FFt8609dVmA7Q8L6MlFXMzIFGGxXIYywJ2vP98I7f9AvWMMKV7BF50kCxvrk3IHKgJbYTjmme
 3BhV3rPxyhmFttb3T2A0Ij/YRpKx2w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-27_03,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 phishscore=0 suspectscore=0 malwarescore=0
 lowpriorityscore=0 spamscore=0 impostorscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510020000 definitions=main-2510270071
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=quic_haixcui@quicinc.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This patch series introduces vhost-user-spi device support to QEMU
and synchronizes relevant standard headers from upstream Linux.

The series consists of the following changes:
1. Synchronize virtio_ids.h from Linux kernel (v6.18-rc3) using
   scripts/update-linux-headers.sh.
2. Synchronize virtio_spi.h from Linux kernel (v6.18-rc3) using
   scripts/update-linux-headers.sh.
3. Implement vhost-user-spi and vhost-user-spi-pci devices in QEMU,
   enabling virtio-based SPI communication via the vhost-user protocol.

The new device implementation follows the virtio-spi specification and
leverages the upstream Linux virtio-spi driver. This enables QEMU to emulate
SPI devices using the vhost-user protocol, facilitating integration with external
SPI daemons and improving virtualization support for SPI peripherals.



