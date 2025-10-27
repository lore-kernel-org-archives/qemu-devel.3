Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 942F0CCF9E0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Oct 2025 07:31:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDHgL-0001PY-9M; Mon, 27 Oct 2025 03:30:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_haixcui@quicinc.com>)
 id 1vDHgJ-0001Lb-4L
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 03:30:19 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_haixcui@quicinc.com>)
 id 1vDHgH-0008Ni-1o
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 03:30:18 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 59R7JvrO2059268; Mon, 27 Oct 2025 07:30:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 DLUayhY2HYxEY0qprFGP3fjfkgXv/E8UT6mrHl4Mjes=; b=NrxBy1sEL6pLcGI8
 kI7BrpF0dBaEDzMKcSRUa/K2IQgKoKaStzpICaOPUlxA1WlQbq/YqWH5/Oeh7slv
 hDmtm3/1wg/Iuy9eNKv41D8UWdpSQll+oXbSIn9rX/ccBzolBld/bRUXmLauODad
 StkHYZSD3wzzFEUd3i6SCf0rv59L+88sRgBxGxm77Xl9DAl7k6WHbaZ2Z4kX2O/Q
 r20mV46rasK4dx58jVOr12sv+WI0/kqm4Pr1CVMQwyIye9rcEfobsheTGt4bUvFh
 hd1n1RnQo1uGKON75m/sKvoCJhEbt0jycqOu+LDeFn+b2cTcKPul0LNl/eUNvskZ
 8yqYdQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a248p80s3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 27 Oct 2025 07:30:14 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com
 [10.47.209.197])
 by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 59R7UDFU004149
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 27 Oct 2025 07:30:13 GMT
Received: from haixcui1-gv.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.24; Mon, 27 Oct 2025 00:30:11 -0700
From: Haixu Cui <quic_haixcui@quicinc.com>
To: <alex.bennee@linaro.org>, <viresh.kumar@linaro.org>,
 <quic_tsoni@quicinc.com>, <qemu-devel@nongnu.org>, <mst@redhat.com>,
 <zhiqiang.tu@oss.qualcomm.com>
CC: Haixu Cui <quic_haixcui@quicinc.com>
Subject: [PATCH v1 1/3] standard-headers: Update virtio_ids.h from Linux
 v6.18-rc3
Date: Mon, 27 Oct 2025 15:29:47 +0800
Message-ID: <20251027072949.2187054-2-quic_haixcui@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251027072949.2187054-1-quic_haixcui@quicinc.com>
References: <20251027072949.2187054-1-quic_haixcui@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Authority-Analysis: v=2.4 cv=Zvzg6t7G c=1 sm=1 tr=0 ts=68ff1f86 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z4Rwk6OoAAAA:8 a=COk6AnOGAAAA:8 a=KqJd8QcNxZFF0aacHC0A:9
 a=HkZW87K1Qel5hWWM3VKY:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI3MDA2OCBTYWx0ZWRfX+8JDE0TEieuh
 hw2HxUJ6z0TBbbl0CA0D6sfOR4RtjzS5FKX6iTh6u/OVsiI8dJhcGWS4tFtEqqOhRRy2DGwCqwD
 voNvr6oW6lhIzQmxIBgVJNaHbKUNxKrPNhr51GVFobLvH4p8trCupHRNzwoJz06wI3AzHFcCNym
 LqNxlXNJNGxVKFTq8ugZm9njCLQQ1y7RGaoTkCiMTiKSpd8qOIH++LyXyeqZS8U0GUULMLiBzuN
 dVWyvRPx0wvDhsLO7ODf2hjNKLNQNi8vjUnUmoC22fS57sI0bJq+Si1C/e8OP1V21TPLnKeManP
 YDtqwPBv/toG0+CRrfMYe7bK9vNXNucXo0A0FF5Tat5T0P0onm88Vtw+jDwKb8n3itvBh/hbQxk
 ptacNjoAnCzIKWgI9JU3/sHDbCmh6w==
X-Proofpoint-ORIG-GUID: Dty-7QKo5Dxvynv6VOnhxFJVXfGUSgXh
X-Proofpoint-GUID: Dty-7QKo5Dxvynv6VOnhxFJVXfGUSgXh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-27_03,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 adultscore=0 clxscore=1015 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510020000 definitions=main-2510270068
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

Synced virtio_ids.h from upstream Linux kernel using
scripts/update-linux-headers.sh.

Source:
- Linux commit dcb6fa37fd7bc9c3d2b066329b0d27dedf8becaa (v6.18-rc3)
- Author: Linus Torvalds <torvalds@linux-foundation.org>
- Date:   Sun Oct 26 15:59:49 2025 -0700

Signed-off-by: Haixu Cui <quic_haixcui@quicinc.com>
---
 include/standard-headers/linux/virtio_ids.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/standard-headers/linux/virtio_ids.h b/include/standard-headers/linux/virtio_ids.h
index 7aa2eb7662..6c12db16fa 100644
--- a/include/standard-headers/linux/virtio_ids.h
+++ b/include/standard-headers/linux/virtio_ids.h
@@ -68,6 +68,7 @@
 #define VIRTIO_ID_AUDIO_POLICY		39 /* virtio audio policy */
 #define VIRTIO_ID_BT			40 /* virtio bluetooth */
 #define VIRTIO_ID_GPIO			41 /* virtio gpio */
+#define VIRTIO_ID_SPI			45 /* virtio spi */
 
 /*
  * Virtio Transitional IDs
-- 
2.34.1


