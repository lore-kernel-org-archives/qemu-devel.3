Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD139C982D2
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2026 07:51:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7TN9-00024B-2M; Fri, 18 Sep 2026 03:51:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <borntraeger@linux.ibm.com>)
 id 1x7TMz-000239-FE; Fri, 18 Sep 2026 03:50:53 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <borntraeger@linux.ibm.com>)
 id 1x7TMx-0008Iu-7G; Fri, 18 Sep 2026 03:50:52 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68I61ckI470546; Fri, 18 Sep 2026 07:50:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=vbRW/2
 4pQXZPc+HoImBGoQhY8cZtxj70kjtzmIWdjBU=; b=DX0krXXiwnxEr398Y433o4
 aVlmGZdxhla2PsaaD3wNkji8hcqyYIQIkWNdBFVZsIN6TT9wLXMkmmFK20XTj9Ay
 CdWx6hTvljpSwqBV58hGj+OXSCfWnAeYCr44XldxnPH+AWSoxenfH0VjiuTh8FES
 Tmv0MDGwCSGmlEwq5AYl9tXo42sHgrzUKbENxArZkt5+uPkpZglQVReUB0+9qXkh
 Cu5xjtWm3Nyxz+1UgAgHACaUvZ4fFbeddLNUQHvd1wbSNcvPku3zQlmh8cbYD59d
 z6brZMqOYQgWOUAA/aDwHPVjVE6fJ+6xb0naZ5K4HH6JbQNweUexihGJRBh4Kb/A
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmxf5ex0j-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 18 Sep 2026 07:50:48 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68I653Q4208397; Fri, 18 Sep 2026 07:50:47 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gr5xa68q2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 18 Sep 2026 07:50:47 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68I7oh6145416862
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 18 Sep 2026 07:50:43 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 49CDF20043;
 Fri, 18 Sep 2026 07:50:43 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 32FF920040;
 Fri, 18 Sep 2026 07:50:42 +0000 (GMT)
Received: from [9.224.77.173] (unknown [9.224.77.173])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 18 Sep 2026 07:50:41 +0000 (GMT)
Message-ID: <c0e0dfca-a438-475c-b86b-c0a90c66d438@linux.ibm.com>
Date: Fri, 18 Sep 2026 09:50:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/8] pc-bios/s390-ccw: Add dynamic net header size
 handling
To: Zhuoying Cai <zycai@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org
Cc: mst@redhat.com, jrossi@linux.ibm.com, jjherne@linux.ibm.com,
 cohuck@redhat.com, farman@linux.ibm.com, mjrosato@linux.ibm.com,
 pasic@linux.ibm.com, farosas@suse.de, lvivier@redhat.com,
 pbonzini@redhat.com, jdaley@linux.ibm.com
References: <20260914193438.526407-1-zycai@linux.ibm.com>
 <20260914193438.526407-3-zycai@linux.ibm.com>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <20260914193438.526407-3-zycai@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: JnczG53jaJJ8cZkOANcZRObow_L03pB5
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE4MDEwMiBTYWx0ZWRfX5Z6uKGdFHtgK
 jU/V2NrW32NZWpNfeXy8BAII8OlYLthS9GJPhUtKAcLwcaTegV7yfgR8Yv0jKLQyCrkSborvtwr
 bL8FfBsWenQLT3BCf3ZHhzQ/ncRmZJk=
X-Authority-Analysis: v=2.4 cv=cvgOAF4i c=1 sm=1 tr=0 ts=6aaced58 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=M_p5TQ9nyLvd2tX-92UA:9 a=QEXdDO2ut3YA:10 a=zgiPjhLxNE0A:10
X-Proofpoint-ORIG-GUID: JnczG53jaJJ8cZkOANcZRObow_L03pB5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE4MDEwMiBTYWx0ZWRfX9sWv9BLLAaWn
 KARmc3gt3D4Tug73OPGjKox214+rdF74/DZOmAxcz5XqYCfmxCvSvxQnjIIhbZKuPDNzZC2n+UL
 tIhXQ+n2zPKS4BkYNQf7dAkqKfUglrbiBWnDd2iKuZQI8QQgTaUK56OP4mPhWmoqmz4bRZnaA1e
 su+kWagqS+JcKzs2XeHM9HvwE63TkKa3SkNZPc7HmZsL/HE4s1RjK/36TOFQFfvB0y7gPy2JhN2
 UVXeFYTDWPxPzbW1L1z0lBilTRLRigYdF6IzfLVaP6ybHg4yirH6E7s2EfnuUfb8u435dU1zvK2
 aShAJWxnj4IruhZSrsynd33iGhgGAWiNXovhcz6l0b1bnFEtos/LteJtEN98Krcsqthc1AOZcBW
 1QnrDG92tQmC6cC4P+k0UERaKURQVw0tBatC0iCyEUT6Prt8SmICO8nONKalm047y6f0earRZXo
 PPncsQp7qZVaL/MdEqg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-18_02,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 clxscore=1011 priorityscore=1501
 suspectscore=0 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609180102
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=borntraeger@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
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



Am 14.09.26 um 21:34 schrieb Zhuoying Cai:
> The virtio-net device used a fixed header size that did not account for
> the num_buffers field used in VirtIO 1.0.
> 
> Use dynamic header sizing: 10 bytes for legacy mode and 12 bytes for
> VirtIO 1.0. This ensures correct packet handling across different
> VirtIO configurations.
> 
> The VirtioNetHdr and VirtioNetHdrMrgRxbuf structures replicate the
> same field layout as struct virtio_net_hdr and struct
> virtio_net_hdr_mrg_rxbuf defined in inux/uapi/linux/virtio_net.h.
                                       ^ include> 
> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>

Acked-by: Christian Borntraeger <borntraeger@linux.ibm.com>



