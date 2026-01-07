Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2293AD0D17C
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Jan 2026 23:41:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdd9K-0003Ip-LO; Wed, 07 Jan 2026 18:41:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1vdd9G-0003HU-El; Wed, 07 Jan 2026 18:41:06 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1vdd9E-00075G-01; Wed, 07 Jan 2026 18:41:06 -0500
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 607B1VZZ011311;
 Wed, 7 Jan 2026 23:41:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=AWQeR0
 8eS+qjEWs3qLqJOePwwyLDyCXmQMfSpgVY+hM=; b=hyDBX/BXgSqmUjfIn3nhsd
 UPdN1xtqOgfudK55epO/c9Y1FJvbtOLYCn3oOaBcyKYk+eSBDPGPNSnDp3I8u5rz
 GCh2/UVnKKnqYM+64JihtdstJw+4/e6WVBAguLc1swEHwQB994IG21Kb2aOlUnOI
 Iou514jel+z37jkTt3S7xFdxzyouxV0sF46DL5y6uUnJcjihE1Hm10156C6JnYqz
 zt+/cElJ5JJ3NF22D54Ca0P6iEsvI4fNwOGTzcgLhgEMUVZ66oSzwSfH3K/MvVnm
 FMYq6wdRJeUKv/tau+HbAWC65nJffMQTZYU8qCvFvJWoQxNrgH9vCxluED52EwEg
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4berhkanej-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 07 Jan 2026 23:41:02 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 607K7kQK015233;
 Wed, 7 Jan 2026 23:41:01 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4bfdesm6yh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 07 Jan 2026 23:41:01 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com
 [10.39.53.228])
 by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 607NexG222414044
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 7 Jan 2026 23:40:59 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9ECEC58063;
 Wed,  7 Jan 2026 23:40:59 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A86F95804B;
 Wed,  7 Jan 2026 23:40:58 +0000 (GMT)
Received: from [9.61.39.95] (unknown [9.61.39.95])
 by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTPS;
 Wed,  7 Jan 2026 23:40:58 +0000 (GMT)
Message-ID: <01e4f382-91f4-4011-a0b7-e769722e5e52@linux.ibm.com>
Date: Wed, 7 Jan 2026 18:40:57 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/10] pc-bios/s390-ccw: Add support for virtio-blk-pci IPL
To: Zhuoying Cai <zycai@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org, thuth@redhat.com, mst@redhat.com
Cc: jjherne@linux.ibm.com, alifm@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com
References: <20251210205449.2783111-1-jrossi@linux.ibm.com>
 <20251210205449.2783111-8-jrossi@linux.ibm.com>
 <fb11a282-6100-4c4b-9899-6ec332e58ba0@linux.ibm.com>
Content-Language: en-US
From: Jared Rossi <jrossi@linux.ibm.com>
In-Reply-To: <fb11a282-6100-4c4b-9899-6ec332e58ba0@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=P4s3RyAu c=1 sm=1 tr=0 ts=695eef0e cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=bUZr9uQWIr9c-ZKH2N8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: WRRlZDbFrZSA3vdaADMhNpMnBvqQSn3l
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA3MDE4NiBTYWx0ZWRfX0Zp1aMUD090U
 QHfskVRZmEObzkCXHvT72T4QIyUib1yC8MpgD3IyDKlYQj5mybWeul7xDIw3UiNJeMQ+2DsJ0My
 6omwa11ZuOgUEN8mVTiLcsdNm55Tc+sUQlP2PdWkEzR5UKfWuv5ZkYcQ+k0C+y32nPfA98Q60hW
 lduaneih1avSjy6IheuIBICQPW2OGmy1P/giy/yy6XU/2hk0bd61p95bkuWYIciegKBdg4xEWqz
 q99P/HCKsfE0KSXbun0i5EcppNBElldbMjQ+eUlLVD0seIJEHpJq/AMEaLDO1qZR9P9IJ3+XTyy
 lvAtf69k3L/KRD3uMUfy9aAGWFMil1Yhawy0h4xuFL9jYPNh2S4pw+GXXWeDILSwcTbPnZa+MFl
 L0ZxyLc0si+Y1dXmIC80Qtu6pAYoOsPELU/JAPXAHZuGsheo1YQYuV3gxAdREUKsa+2aycwYTMH
 hiQv/HVU5ItXeoQlMSw==
X-Proofpoint-GUID: WRRlZDbFrZSA3vdaADMhNpMnBvqQSn3l
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-07_04,2026-01-07_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 priorityscore=1501 clxscore=1015 suspectscore=0
 phishscore=0 adultscore=0 spamscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2512120000 definitions=main-2601070186
Received-SPF: pass client-ip=148.163.158.5; envelope-from=jrossi@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



On 1/7/26 3:39 PM, Zhuoying Cai wrote:
> On 12/10/25 3:54 PM, jrossi@linux.ibm.com wrote:
>> +
>> +    rc = pci_read_bswap32(vdev->pci_fh, pos + VPCI_N_CAP_MULT, PCI_CFGBAR, &notify_mult);
>> +    if (rc || pci_read_bswap16(vdev->pci_fh, d_cap.off + VPCI_C_OFFSET_Q_NOFF,
>> +                               d_cap.bar, &q_notify_offset)) {
> Hi Jared, I think this came up in the previous version -- should
> q_notify_offset be taken from the common configuration structure?
>

Ah, you are correct.  I've missed fixing it.  My bad...  Thanks.

Regards,
Jared Rossi

