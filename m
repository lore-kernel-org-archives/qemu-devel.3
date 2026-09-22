Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 806F3C98302
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 21:34:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9887-0006qj-4o; Tue, 22 Sep 2026 17:34:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1x9881-0006hN-Gs; Tue, 22 Sep 2026 17:34:19 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1x987y-0007JC-RO; Tue, 22 Sep 2026 17:34:17 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68MI8kke4147019; Tue, 22 Sep 2026 21:34:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=VqMS09
 eYj7K6UsPOED1rCkN3axr+oCXYUU2KMOgCLoY=; b=ToYOSQFvPeUR5vm6Vhfl9G
 MgTXVpe8pCdUKpHt6igtp8T+MajRkcKfuwLh/7Sp902NRLI/ML/nT+RRPXRfy4Ds
 if4mkqFN7uK1w60KLi0VNIowqkSx7JKNnoxbNju6A/lQX4pCgfgusP425azUrzFF
 n+TjlrE7jzc2rE/NetaOI6/LEjjHFpbVWwqUseHYOqvK/hxKcZggGew/QZ5kmJok
 vGuxP2oSXk5CjRGjkzzvkCUVTLAA1QFtglwwpBohrpQ2bz48/VXxXaaIkwYvfskq
 f+Zth+DYoGbdSoxNt61qR0TNCd9lBONHlZnetjE5/ac94a+/vrfvsEhzr4qkvrGg
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskgqfnp2-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 22 Sep 2026 21:34:12 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68MIHXQh3239748; Tue, 22 Sep 2026 21:34:12 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gt67guh4k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 22 Sep 2026 21:34:12 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68MLYAa09634408
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 22 Sep 2026 21:34:10 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 66C9958055;
 Tue, 22 Sep 2026 21:34:10 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6523958043;
 Tue, 22 Sep 2026 21:34:09 +0000 (GMT)
Received: from [9.61.131.16] (unknown [9.61.131.16])
 by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 22 Sep 2026 21:34:09 +0000 (GMT)
Message-ID: <6ba3067f-7e29-42d5-b7ca-c1b67b318485@linux.ibm.com>
Date: Tue, 22 Sep 2026 17:34:08 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/8] pc-bios/s390-ccw: Add dynamic net header size
 handling
To: Zhuoying Cai <zycai@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org
Cc: mst@redhat.com, jrossi@linux.ibm.com, borntraeger@linux.ibm.com,
 jjherne@linux.ibm.com, cohuck@redhat.com, farman@linux.ibm.com,
 pasic@linux.ibm.com, farosas@suse.de, lvivier@redhat.com,
 pbonzini@redhat.com, jdaley@linux.ibm.com
References: <20260914193438.526407-1-zycai@linux.ibm.com>
 <20260914193438.526407-3-zycai@linux.ibm.com>
Content-Language: en-US
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <20260914193438.526407-3-zycai@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=G+OJgNk5 c=1 sm=1 tr=0 ts=6ab2f454 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=u5-0KgQjkn_obSh9IGYA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIyMDI5NyBTYWx0ZWRfX4+2pe9RFQQpY
 87baKmjx8aBDpPzsF9kx+4yg5STcfQaG/YX7WBYmRou4tL0/XfftxqQ0a4yttNtwpkSF+prDr7V
 LLeTUSTj5iBFE6qMW5uNvdu4nIxRiGj1Vp7Jm11lAtqq+J+WnFh3P+9i6zJeEuRtkTGVyaYXaxo
 6M8EmmRAteDHlmDWK/Mh54scgtAq3JUl6qyLtrYb3OA+sPFXyD0aHlKo2PRKaweeiKSOgEZfTfs
 qglAUAsqVOy8KWEeNJDVBjzpgCUlkDuoF0R78Cy/9Plq/LHFiIThUMpvgs2Ax2uGT2mfx9WcULa
 +j2RDpSkNlr2lq6UDYUzXBD4HoMz23oe/1U2cyJGzOpl+r959BFuRuWDhbYruIFtKAgbMFgZktr
 UaQ/qhdDBq1uexyT7SGF/b+yaSJMzAIce63QqeoXpiMV9dMRdP5IWx/LYi+prZu1/icJQYEblDA
 rXkZT73+Eh/4+PGtM3Q==
X-Proofpoint-ORIG-GUID: gggDjVClrfiNb6op23Lp5lDH54iKpAhc
X-Proofpoint-GUID: gggDjVClrfiNb6op23Lp5lDH54iKpAhc
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIyMDI5NyBTYWx0ZWRfXwWp54nE9NrlR
 G/bObLbdpcrBlXy5aBc8zk1b/llJFHT1189uoauTJUmK2/FY8gAbmArTOMTrOkcYEU3u5qBBGOj
 jtdWz+N/nu/wmdUURzp2CLDlhRbrSY0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-22_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0
 bulkscore=0 priorityscore=1501 clxscore=1015 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609220297
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=mjrosato@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

On 9/14/26 3:34 PM, Zhuoying Cai wrote:
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

Path needs to be fixed above.

[...]

>  
> +struct VirtioNetHdrMrgRxbuf {
> +    struct VirtioNetHdr hdr;
> +    uint16_t num_buffers; /* Only with VIRTIO_NET_F_MRG_RXBUF or VIRTIO1 */
> +};
> +typedef struct VirtioNetHdrMrgRxbuf VirtioNetHdrMrgRxbuf;

Thanks for changing to match the uapi.

Shouldn't you now remove the commented out instance of num_buffers in
VirtioNetHdr?  VirtioNetHdrMrgRxbuf should be used in that case.

With these minor changes:

Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>


