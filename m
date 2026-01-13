Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08D1AD29DDE
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Jan 2026 07:21:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfYiF-0001wI-3m; Tue, 13 Jan 2026 02:21:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_haixcui@quicinc.com>)
 id 1vfYiC-0001rq-Hm
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 02:21:08 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_haixcui@quicinc.com>)
 id 1vfYiA-0005mH-Uw
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 02:21:08 -0500
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 60D5gxxj3815236; Tue, 13 Jan 2026 07:21:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 yPR9gT+mnp8tC3IIkLJP/NFEiObJUo8vfG8NQ3Dr0KE=; b=Mcja54ka5uMoUD8G
 YKZIIdbWokRElrNR3M1N9Gx8CKNqyYyvsSzZZgLKmLZwsndL7Vag3DqwqUOKPtIS
 7TQo7Qc2j0mHZDjwR2zMBXTYhZ4FnjGZpB8Aae1nnhxHPbJ1cHNGhCFOlxxHeQra
 WR2ufm9dDLpLXzACipG85aYC34cAouwM3juhgbg1lNF6+4EbH5pxKTqiCQ1IX1wc
 JB5FwSklOeonfs733nF/JfK0JwSwYRXmYpTcmILO94OH7UgBT4WT2tfB6yEJ6vS2
 UXZppR23rlSnzZPjsgzIkLVl1UXorUmYSQiDVgGsliJ4U7n82omAy/jDVLr1e1Mw
 A//wSQ==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bng55r98f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 13 Jan 2026 07:21:02 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com
 [10.47.209.197])
 by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 60D7L13I020877
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 13 Jan 2026 07:21:01 GMT
Received: from [10.233.23.41] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 12 Jan
 2026 23:20:59 -0800
Message-ID: <4388d9ee-cdc6-4c65-8afe-938f62c431b6@quicinc.com>
Date: Tue, 13 Jan 2026 15:20:57 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] virtio-spi: Sync Linux headers and add
 vhost-user-spi device support
From: Haixu Cui <quic_haixcui@quicinc.com>
To: <manos.pitsidianakis@linaro.org>, <alex.bennee@linaro.org>,
 <viresh.kumar@linaro.org>, <quic_tsoni@quicinc.com>,
 <qemu-devel@nongnu.org>, <mst@redhat.com>, <zhiqiang.tu@oss.qualcomm.com>
References: <20251216032122.1316684-1-quic_haixcui@quicinc.com>
Content-Language: en-US
In-Reply-To: <20251216032122.1316684-1-quic_haixcui@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-GUID: VPCzvSv82xx_DJKlWlOKIClps1yNhxdY
X-Proofpoint-ORIG-GUID: VPCzvSv82xx_DJKlWlOKIClps1yNhxdY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTEzMDA2MCBTYWx0ZWRfX5num0rSY19lm
 arNotmt2Nop76p3L34TvCQvLlyvyNg6t9WuFzyTCdnLV+aLknA4w04N20br8B4HcjoXEi6OD2ah
 InUD6QF28V8Fmd5zLF+sFjQGL8MclG97Mz/IyTJvw5vaLMeRypB+YKdmiAf9PZQt+faPk1riHVw
 gpdyI0/sxYga4/jH52hKOepLEOfuec/rFgzyeqkGUd+KKKxHs0GrLfiIs7xKnmQAkjev4Q0a5An
 pU5ogRApsonugAHE/tTPzGRJRoG8EEakA7CxEA28G8UpnbzYFzrupC/k5PXWl45W2HScxJiypTN
 jx/xeAy42bB2jpymdlOG002UW1b/dDgPfH54ATti42IxTu96mTiLrQ+pVqJXXlDoeuk8h+fRQai
 xltBEGEh4b0XKLEQLOa3c/wOgdTB/tnqCNUflVmvgof9avLE/dx1u1eNbwlWdJTHaKnsQAumSdT
 qG2oFpt3PS9ovRDG6+w==
X-Authority-Analysis: v=2.4 cv=IIsPywvG c=1 sm=1 tr=0 ts=6965f25e cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=odLUve6iMOfCOi6oHW0A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-13_01,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 clxscore=1015 bulkscore=0
 phishscore=0 priorityscore=1501 suspectscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601130060
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

Hi QEMU developers,

I’m following up on my patch posted on 12/16/2025, and haven’t received 
any review yet.

Could you please take a look when you get a chance? I’m happy to update 
it based on feedback.

Thanks,
Haixu

On 12/16/2025 11:21 AM, Haixu Cui wrote:
> This patch series introduces vhost-user-spi device support to QEMU
> and synchronizes relevant standard headers from upstream Linux.
> 
> The series consists of the following changes:
> 1. Synchronize virtio_spi.h from Linux kernel (v6.18-rc3) using
>     scripts/update-linux-headers.sh.
> 2. Implement vhost-user-spi and vhost-user-spi-pci devices in QEMU,
>     enabling virtio-based SPI communication via the vhost-user protocol.
> 
> The new device implementation follows the virtio-spi specification and
> leverages the upstream Linux virtio-spi driver. This enables QEMU to emulate
> SPI devices using the vhost-user protocol, facilitating integration with external
> SPI daemons and improving virtualization support for SPI peripherals.
> 
> Changes between V3 and V2:
> - Removed the patch to update virtio_ids.h since it is already updated
> Changes between V2 and V1:
> - Added vhost-user-spi entry in docs/system/devices/virtio/vhost-user.rst
> 
> 
> 
> 


