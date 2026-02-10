Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B818BEB26F2
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 17:27:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vprWG-0000WD-2a; Tue, 10 Feb 2026 12:27:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1vprW3-0000RI-Qj; Tue, 10 Feb 2026 12:27:13 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1vprVz-0004Ql-IZ; Tue, 10 Feb 2026 12:27:09 -0500
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61A5QpCU3475385; Tue, 10 Feb 2026 17:27:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=6WfEf3
 efJuV49GXaeWGcAM1TUMKfpV+e0BfVjSAnHYE=; b=lcRi7QQgrX/llGMzQievnk
 qDM1wvuwMxd/Fouc99IduMhpOoikqp2AahZQOAezByjEF7G3yRpeYoc2oAgaCzRY
 qpy8oWBiN7UjRrK/BSqQZKPiB9gy4QMRz5OWsktLgY0mFmlxYzHcJYWDHNfMVn2E
 cZ6d+V36FS0cYRaFBBJQzfupv8QGobAA8K5fuUOynck3GBxSiTKG6WJ6dWR+hNEl
 emNHPaD8qvYJDXPh0HiHp3bUyLT+ai6iSwQqfZDWPHHVVY/S3JI9JKtoh4+zZxaW
 1oigQs7VUzWqcV4HhUsU4M7G1arE6hbKLmUYRJwGuFLQ3GksYozqjAj+gRztCCEQ
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4c696wubgp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 10 Feb 2026 17:27:00 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61AHHhHw002548;
 Tue, 10 Feb 2026 17:26:59 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4c6fqsjjkq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 10 Feb 2026 17:26:59 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com
 [10.241.53.104])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 61AHQuQb31130222
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Feb 2026 17:26:56 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 35A4958052;
 Tue, 10 Feb 2026 17:26:56 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AD9C258056;
 Tue, 10 Feb 2026 17:26:55 +0000 (GMT)
Received: from [9.61.245.70] (unknown [9.61.245.70])
 by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 10 Feb 2026 17:26:55 +0000 (GMT)
Message-ID: <192dc45c-5bc2-4bfa-8e6f-8a140e23d88a@linux.ibm.com>
Date: Tue, 10 Feb 2026 09:26:55 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] prevent null pointer dereference during zpci hot unplug
To: Aby Sam Ross <abysamross@ibm.com>, qemu-s390x@nongnu.org
Cc: qemu-devel@nongnu.org, mjrosato@linux.ibm.com, farman@linux.ibm.com
References: <20260210065214.2252464-1-abysamross@ibm.com>
Content-Language: en-US
From: Farhan Ali <alifm@linux.ibm.com>
In-Reply-To: <20260210065214.2252464-1-abysamross@ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=WZYBqkhX c=1 sm=1 tr=0 ts=698b6a64 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=VnNF1IyMAAAA:8
 a=4ZKmDIuTj1rYIXpkp7IA:9 a=lqcHg5cX4UMA:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: C4rQSQJXKWg5XYvi5cPa20RcNFpuWlnz
X-Proofpoint-ORIG-GUID: C4rQSQJXKWg5XYvi5cPa20RcNFpuWlnz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEwMDE0NCBTYWx0ZWRfX1cMtc9+Nnfvn
 uCIbSQLj6hbNGGxiaHdkw2ytv0keUK5nlPhb+dgHDyFWDyA5ndBC2ATR9eFEpZsSHA7GPvInlZ5
 s8KkdR5X6zM4WZZv/IqDdlfKxBtN1HVSdw1a9Z0AJjHhcGoPrvQCFU18e8tr2N/vkaweOMuzvwR
 ari/hfET3wVMnC1EeyZ/Wt3+NjRyks31qoOjm+jWzOIPI+iGQnSZWBNEjvRcTyvrlHUjGrG7v00
 mu1zO6x2fK9TpUAyD04HE8yHb73qGIOtffkFWe55e8hmbnxKnSgWfsn/ng7+DrZeu018CLK4Eil
 FKHzR79AGIZ9RUVmi2D7HemG7hyl7MURr5xxH0rvGOW8hea+6wi/0z4oUshVwLo+rKdNV55kLE0
 cuDIDpUBr1kFHWANqfY2ouWlXQTWb7x0+4SDGq6acpwEYVn3BU5BrW8ozb2Jm730PaHXecfof/x
 paRP1of/rcdzgzLKh9g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-10_02,2026-02-10_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 phishscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 impostorscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602100144
Received-SPF: pass client-ip=148.163.158.5; envelope-from=alifm@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


On 2/9/2026 10:52 PM, Aby Sam Ross wrote:
> vfio-pci hostdev realize during zpci hot plug fails (in `vfio_pci_realize()`)
> if the vfio group file in `/dev/vfio/` lacks appropriate permissions and the
> hostdev[/properties] addition doesn't reach the point where it could be
> associated with previously added zpci device (in `s390_pcihost_plug()`).
> As a result, zpci iommu pointer remains null. The zpci hot unplug following the
> failed hostdev addition assumes zpci iommu pointer was assigned and tries to
> make use of it to end the dma count resulting in a null pointer dereference.
> In the non-hotplug scenario, `qdev_unplug()` for the zpci device is not called
> after hostdev addition failure and this issue is not encountered.
>
> Fixes: 37fa32de7073
> Signed-off-by: Aby Sam Ross <abysamross@ibm.com>
> ---
>   hw/s390x/s390-pci-bus.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
> index b438d63c44..3166b91c46 100644
> --- a/hw/s390x/s390-pci-bus.c
> +++ b/hw/s390x/s390-pci-bus.c
> @@ -1248,7 +1248,7 @@ static void s390_pcihost_unplug(HotplugHandler *hotplug_dev, DeviceState *dev,
>           pbdev->fid = 0;
>           QTAILQ_REMOVE(&s->zpci_devs, pbdev, link);
>           g_hash_table_remove(s->zpci_table, &pbdev->idx);
> -        if (pbdev->iommu->dma_limit) {
> +        if (pbdev->iommu && pbdev->iommu->dma_limit) {
>               s390_pci_end_dma_count(s, pbdev->iommu->dma_limit);
>           }
>           qdev_unrealize(dev);

Thanks for the fix. With the Fixes tag fixed (as suggested by 
Matt/Eric), feel free to add.

Reviewed-by: Farhan Ali <alifm@linux.ibm.com> <mailto:alifm@linux.ibm.com>



