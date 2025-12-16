Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5CA9D5C0C8
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Dec 2025 03:22:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVLdE-00043y-9y; Mon, 15 Dec 2025 22:21:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_haixcui@quicinc.com>)
 id 1vVLdD-00043q-JP
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 22:21:47 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_haixcui@quicinc.com>)
 id 1vVLdB-0002MI-Qx
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 22:21:47 -0500
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5BG2187k1131360; Tue, 16 Dec 2025 03:21:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=jj4xT3JDXa9wUSHasRkIKj
 k0FeB7W/O1l2IW9ZeqiVw=; b=c6Q/BOEAKsGkcfE9IoNyXOA2zLsDo1HuxzcJb7
 ZIaZ+Cs9csnJjjUMw9NMRLLJ9N4IbPxWqu/lR6mULMd7b/poD34CT/4X+WK20XJG
 ahCW+ccDQMG2J1fP1qx26GDLRV5gjm/pNBIYFKNi+uL0gULd5Y86Ze+9/DgNcS7W
 8QHZDGbqkk5EZl0cxPiOqwaMu7tvfug0+5me8pCun+MCOYoSgmqq4Q8hdwRl0hPU
 PgYaBZxNg1sWykQYSn6YkjK4mVE6NNLbvKBTWf26huWJPnb4oP6RfBmDCS/3gAnz
 1hAIB442bL0kSLJxeIlZzocSbd7U5+1Hgkb/J5L6YCkHRYkg==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b2p3u9ve7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 16 Dec 2025 03:21:41 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com
 [10.47.209.197])
 by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 5BG3Le26024288
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 16 Dec 2025 03:21:40 GMT
Received: from haixcui1-gv.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 15 Dec 2025 19:21:38 -0800
From: Haixu Cui <quic_haixcui@quicinc.com>
To: <manos.pitsidianakis@linaro.org>, <alex.bennee@linaro.org>,
 <viresh.kumar@linaro.org>, <quic_tsoni@quicinc.com>,
 <qemu-devel@nongnu.org>, <mst@redhat.com>, <zhiqiang.tu@oss.qualcomm.com>
Subject: [PATCH v3 0/2] virtio-spi: Sync Linux headers and add vhost-user-spi
 device support
Date: Tue, 16 Dec 2025 11:21:20 +0800
Message-ID: <20251216032122.1316684-1-quic_haixcui@quicinc.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE2MDAyNiBTYWx0ZWRfX84pDaY1kiOCB
 cnY/B+hhRFfVmeV03A99h7FkMljvkEm2EHGxl6nzT5VjEXUI/E5DVnZrYYIeoZ9PGn+c2XIKjTE
 M2Bfo3tukjfr8WsVjbBSTi2M3UqxrsLJLcVtVqf8BNAFVwfeGYuxNZzC2mGfhYIigYZk8UUeUSW
 mkLfCmQvElHRG0c0yLo21UXtQeKggJD1OEqlRBIxJ3L5dYakgWhQwPN3kQRug8qvqbTymHQ8Fju
 CI0J7wsLZ9HiNnDVWE1r7IrxZ11pi8VzC7H0ewOkOe43AEU+sHYZyzr1EeSltVN90Bzz7UZdPca
 LI15YFRhrbv9YqvDZbYEbFhjBjleoS73z+mNfapJ0uwaIC/BLWucGIDqLTikB5XzpHo0l9Mq3Kv
 QWqcQpUfPueGOC4fqSWLvxiQ/XaI0w==
X-Authority-Analysis: v=2.4 cv=Q/TfIo2a c=1 sm=1 tr=0 ts=6940d045 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=ONEyY3_IPAylEGahahoA:9
X-Proofpoint-GUID: MsUQidqDAviTMvlXhHmegAZ43oueQ8Xt
X-Proofpoint-ORIG-GUID: MsUQidqDAviTMvlXhHmegAZ43oueQ8Xt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-16_01,2025-12-15_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 spamscore=0 adultscore=0 suspectscore=0
 phishscore=0 priorityscore=1501 impostorscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512160026
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=quic_haixcui@quicinc.com; helo=mx0a-0031df01.pphosted.com
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
1. Synchronize virtio_spi.h from Linux kernel (v6.18-rc3) using
   scripts/update-linux-headers.sh.
2. Implement vhost-user-spi and vhost-user-spi-pci devices in QEMU,
   enabling virtio-based SPI communication via the vhost-user protocol.

The new device implementation follows the virtio-spi specification and
leverages the upstream Linux virtio-spi driver. This enables QEMU to emulate
SPI devices using the vhost-user protocol, facilitating integration with external
SPI daemons and improving virtualization support for SPI peripherals.

Changes between V3 and V2:
- Removed the patch to update virtio_ids.h since it is already updated
Changes between V2 and V1:
- Added vhost-user-spi entry in docs/system/devices/virtio/vhost-user.rst




