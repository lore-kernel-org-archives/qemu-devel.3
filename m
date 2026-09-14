Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58122C88E72
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 17:25:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6AQi-0003GQ-9t; Mon, 14 Sep 2026 13:25:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1x6AQg-0003G5-HY; Mon, 14 Sep 2026 13:25:18 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1x6AQe-0004RR-3r; Mon, 14 Sep 2026 13:25:18 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68EFvldR607556; Mon, 14 Sep 2026 17:25:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=hczmzm
 gFzHlgVsWmJpS+r7/ptgUN7EgXvjB5iJ7mFck=; b=FwzCMI2ytpHTwEv7o/+64v
 Q3ZoK+SXeK07GR0nnqPl9NgJ26MZcbqJPvkM0RnCw16hbsuz6YyhPzyCEgeRI5GV
 oycl4z5r8lm3SiT11m1BogjTj0TCjqAJFCuddGrpa+dmOghv1mpH8CGLfhXWzkBa
 xmCrj0U/dJPyevECQkmqfvjH97UcIKI7QsIVPvhS+/ba+J1mJQt9f4uVj7qQiQgk
 v3JMh/Dc3ye2wR9VjuLpdprw16Ppodz7mOjtLgbX3RWEy4Wb90tSvwkWFBScRcy6
 lgGyBkng8BHtOa6CNixfic+cosRslUko9lafzotU4avDZd0vHjKcDRJkOzoW3SCQ
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmxdq2wvr-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 14 Sep 2026 17:25:11 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68EGYZV62298664; Mon, 14 Sep 2026 17:25:11 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gnj2jyaxr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 14 Sep 2026 17:25:10 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com
 [10.39.53.233])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68EHP9Xd2818962
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 14 Sep 2026 17:25:09 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BE77E5804E;
 Mon, 14 Sep 2026 17:25:09 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 632895803F;
 Mon, 14 Sep 2026 17:25:08 +0000 (GMT)
Received: from [9.61.94.186] (unknown [9.61.94.186])
 by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTPS;
 Mon, 14 Sep 2026 17:25:08 +0000 (GMT)
Message-ID: <74cc3025-4126-4ec1-8be3-72c946c75988@linux.ibm.com>
Date: Mon, 14 Sep 2026 13:25:07 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/7] pc-bios/s390-ccw: Add support for virtio-net-pci
 IPL
To: Zhuoying Cai <zycai@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org
Cc: mst@redhat.com, borntraeger@linux.ibm.com, jjherne@linux.ibm.com,
 cohuck@redhat.com, farman@linux.ibm.com, mjrosato@linux.ibm.com,
 pasic@linux.ibm.com, farosas@suse.de, lvivier@redhat.com,
 jdaley@linux.ibm.com, pbonzini@redhat.com
References: <20260903162449.2588271-1-zycai@linux.ibm.com>
 <20260903162449.2588271-5-zycai@linux.ibm.com>
Content-Language: en-US
From: Jared Rossi <jrossi@linux.ibm.com>
In-Reply-To: <20260903162449.2588271-5-zycai@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE0MDI0MSBTYWx0ZWRfX8BW60QtlhrVe
 QVixOSZd0z+RJ4n7NEiAGiOYibv2zVaUkLoqCwn8gTeQ8OU9koEnzROlVy99vD0lADqowit3sDG
 WYyZw2QNBGlzJmmAuiUSV3c1Ylhkt43CMXaFPOF3c31AiJGtd1sI+GYxeMzS0OfjLRDFvipZ4Kx
 NWeV6sBAGfY3wyL+VTzaJqjHsEqG0sexPTM0AcOJnd6UwCJ1a8IBXWt94TuklxyR2kZ7kST1Xw9
 R/xQPe9dHPRWnIj6wcail6gVZB/zN5k20f9NVfIHZ8gtvmFwZnMzTeqK/FVAnCaOmIKtuYsiTo9
 QBsKZQJ8TW8r7O0eyIMWaGadlFR2L1qrxpEjVZu7BKM5yw7G7HoEwztmgW8Q1+tWFbdN2MByYBl
 9jnemYKwtCzL6YdLhnl1MjgrEmtBwoEBNupMorYrevkLkZQV/DO5vm4/A5O+e7MjgncXU9O1AU4
 eDmyVrG3fzsOfeKIyNg==
X-Proofpoint-GUID: _GTiYNEfKmHU1w0sQcAZzFM_gRUqtMgz
X-Authority-Analysis: v=2.4 cv=DobDa2/+ c=1 sm=1 tr=0 ts=6aa82df7 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=ctsVLiZ_AAAA:8 a=bKjd5LtCsCfGKPsABLoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=3VCIHQLkQthbvTRuo98s:22
X-Proofpoint-ORIG-GUID: _GTiYNEfKmHU1w0sQcAZzFM_gRUqtMgz
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE0MDI0MSBTYWx0ZWRfXxCa1Lke8wh3e
 FKJO1OtDiXiU1TStk5CTkNkl5VBXsGZJNt1QuxU4jFWt0m4KqfMfskqEwSU2jyYkqXg8e7Ke6sD
 +5kUvmhLrl2TKQ2+uNWwdwNeFy3AfAg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-14_03,2026-09-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 priorityscore=1501 suspectscore=0 impostorscore=0
 spamscore=0 clxscore=1015 adultscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609140241
Received-SPF: pass client-ip=148.163.156.1; envelope-from=jrossi@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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



On 9/3/26 12:24 PM, Zhuoying Cai wrote:
> Enable network booting via virtio-net-pci by implementing PCI transport
> support for virtio-net.
>
> This patch also extends endianness handling for virtio PCI ring operations in
> little-endian to ensure correct behavior on s390x.
>
> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
> ---
[...]
> @@ -199,6 +203,14 @@ static int virtio_pci_get_blk_config(void)
>       return rc;
>   }
>   
> +static int virtio_pci_get_net_config(void)
> +{
> +    VirtioNetConfig *cfg = &virtio_get_device()->config.net;
> +    int rc = vpci_read_flex(d_cap.off, d_cap.bar, cfg, sizeof(VirtioNetConfig));
> +
> +    return rc;
> +}
> +

Nit:  Because all the other PCI device types require byte-swapping in the
config, I would like to see a comment here indicating that the only reason
the net config doesn't need any swapping is because the only field we use
is the MAC address, which is a byte array.  If the other net config fields
were ever to be used, they would need to be byte-swapped here.

Overall, looks good to me.

Reviewed-by: Jared Rossi <jrossi@linux.ibm.com>

