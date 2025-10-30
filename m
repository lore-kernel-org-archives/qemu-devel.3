Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C592CCF9FA
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Oct 2025 08:36:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEO7k-0001E8-B0; Thu, 30 Oct 2025 04:35:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_haixcui@quicinc.com>)
 id 1vEO7Z-00018r-4S
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 04:35:01 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_haixcui@quicinc.com>)
 id 1vEO7L-0005aX-J6
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 04:34:56 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 59U87duW1656357; Thu, 30 Oct 2025 08:34:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=zdr18Z4X36faUCmN4+Dadc
 rbVnWZs1WhloXJMbUMNeQ=; b=dAAg6K1yL0MIF59To0FIxHd8zd/gxr/JcUEold
 /2EmPwdSF3pLwcnv7+7hiC9ymVMf+imbPkJca7ZJsihDKkWdYLoyYv5rMYcYtLFO
 LrCIps2loQlKFqD5uGuItZZKE+u47Bo/vq0Q2CvFbi9fDnZkA+WegpEHv3A30+cx
 tqU4Y9zsMiM6hoe80XeKdOU/izQxu8e3vhU4GpY27rcYP20x71jwWS9oH8L/3FTk
 DKQ1kdL7deKid0Vi03yvYOEjtH9ECunD4J0CAY6enCm4Y072xksUy6hFwvuuI/o5
 iAwYHXVkiwZwWIaQ5DitmTKthTDGpMYJ7GDZOXaMt5ob9UTA==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a3tptsmbf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 30 Oct 2025 08:34:36 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com
 [10.47.209.197])
 by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 59U8YZLu005988
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 30 Oct 2025 08:34:35 GMT
Received: from haixcui1-gv.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.24; Thu, 30 Oct 2025 01:34:33 -0700
From: Haixu Cui <quic_haixcui@quicinc.com>
To: <manos.pitsidianakis@linaro.org>, <alex.bennee@linaro.org>,
 <viresh.kumar@linaro.org>, <quic_tsoni@quicinc.com>,
 <qemu-devel@nongnu.org>, <mst@redhat.com>, <zhiqiang.tu@oss.qualcomm.com>
Subject: [PATCH v2 0/3] virtio-spi: Sync Linux headers and add vhost-user-spi
 device support
Date: Thu, 30 Oct 2025 16:34:10 +0800
Message-ID: <20251030083413.1532360-1-quic_haixcui@quicinc.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMwMDA2OSBTYWx0ZWRfX+iiOu5HjTXbv
 1NuUO5ZADRfcEpMvLwob6ilEzOWKV58n3oC3bW0EptbEMsMqXF5fuIsxGAMwvJiWVBCTjYfcMho
 6K406z7uH5+9xrdBGKfNRwqQGDyvQQKnpsj6w32gQ+n+XksxWzODw4dgOdITfvzYVkDL6NWCrhf
 Z43HORjrtlgXAb8EqMoiivK0I1Yo4/yJ4X9jyqV5Anf/wICl0TaYwxT/Ep6nFkzfq5Svw4NSpSE
 l2GNyQl7oTsvXp1aXfMUzFCyei7PlA2zUnrRcgvq7IATcjFiy5hrZ/TlSkCYpYq8sZ0IPko4mwL
 tiU5SGzkifnq0DuWjZsmIym/qgxhZxeUEZgfUm4K6adrI8DbUx23Pi7M9kMf38qw3bbUs6/YVL3
 Wup0OZ5B4t3m3jQY97txj0PuC72rqA==
X-Proofpoint-GUID: uTjphTlK-vJOq-vynK-8eH7RZlwvFP_d
X-Authority-Analysis: v=2.4 cv=MuRfKmae c=1 sm=1 tr=0 ts=6903231c cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=ONEyY3_IPAylEGahahoA:9 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: uTjphTlK-vJOq-vynK-8eH7RZlwvFP_d
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-30_02,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 suspectscore=0 spamscore=0
 lowpriorityscore=0 clxscore=1011 bulkscore=0 phishscore=0 malwarescore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2510300069
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=quic_haixcui@quicinc.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Changes between V2 and V1:
- Added vhost-user-spi entry in docs/system/devices/virtio/vhost-user.rst



