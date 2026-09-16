Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF870C982C1
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 23:16:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6yrG-0008Hl-Hz; Wed, 16 Sep 2026 19:16:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1x6yrD-0008FK-EH; Wed, 16 Sep 2026 19:16:03 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1x6yrB-0002iA-QF; Wed, 16 Sep 2026 19:16:03 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68GG1W3C045782; Wed, 16 Sep 2026 23:16:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=KwArr8
 Rx+hyFmATfARuzALSL4UFNmMSRUXl2ObrZ6QM=; b=SdXsfsHhl4WeE4IwsUdZY7
 WsiMAa1gJj0U8KbP9RF+pYfNNlu6MQfO/GMUJbUKspIOhP4Zn4a3N/F8Wl8429xA
 dzon9Ga3jvWVQvu3CToZZwUpBwHl76lik3Fk9UeN8SWYa8b/TBkKnMpRT6rijzpN
 K9n0NA9CBdcJRg7iRoExD06YsdvK5kxlPsBitX3PEamnx0Q5FMU2uzCATAX7uMXI
 aFXkj7B6RxDuVWeHpl/k/57Qni4h5Aecf+kabEI2MYub1Y65R2T5ylhFOYzNFnrL
 gnN4FE2ZvgcC2XgndL0DTxo4B1jtEZYG7kQhz4GYNaBfgJ16Dyv/HzYcSlUUTYzg
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmxcv6yh3-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 16 Sep 2026 23:16:00 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68GMqn841713205; Wed, 16 Sep 2026 23:15:59 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gpywf0wt3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 16 Sep 2026 23:15:59 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68GNFwD924642066
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 16 Sep 2026 23:15:58 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5851058052;
 Wed, 16 Sep 2026 23:15:58 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9E2A358045;
 Wed, 16 Sep 2026 23:15:57 +0000 (GMT)
Received: from [9.61.177.109] (unknown [9.61.177.109])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 16 Sep 2026 23:15:57 +0000 (GMT)
Message-ID: <f5ba3b98-d219-413d-b2ba-db9f4c3d8d3a@linux.ibm.com>
Date: Wed, 16 Sep 2026 19:15:57 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/9] hw/intc/s390x: Fix payload to KVM_HAS_DEVICE_ATTR
 ioctl
To: Eric Farman <farman@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: Cornelia Huck <cohuck@redhat.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, qemu-stable@nongnu.org
References: <20260916203242.2509787-1-farman@linux.ibm.com>
 <20260916203242.2509787-7-farman@linux.ibm.com>
Content-Language: en-US
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <20260916203242.2509787-7-farman@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE2MDMyMiBTYWx0ZWRfX1rdQ4l0qSkw9
 9KPBZqZjXIbiVOcYTwz+NGIdXPAb7D0fA6XXDis4PJpfhQzIRzH2Ywzumy3wkxg3c7LKYwaxMJp
 V1pFlfe2aG/E+RuwwanPUljDAYeQEh0=
X-Proofpoint-ORIG-GUID: --V58XaxmK4yQalbMV4tPCTzi6AAbaHI
X-Proofpoint-GUID: --V58XaxmK4yQalbMV4tPCTzi6AAbaHI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE2MDMyMiBTYWx0ZWRfXxXgPXg5V7Cnp
 217DnpZL2Nl72deh8UdBnOp06rRVfYJKROSdUfjTEJUTJxpcIbkHnrckdL6H6FJHCDXomzicITw
 7HGhG8UilIeOui28DcG9cXx24K4VlCyVpluN/nltWiTnsjCYKGkULxs/0l/s/BLhGquWaEie7dH
 75qAJQa8rm+JAG/Vh849mNMMokRGCA4uu4rtTQ5N9nM6V9M3nvGrFx6wa+QvsW7VtC0rBkh8df9
 OmkQMCj93pZeR7spPfh/6yxZuQA12yT0t1LccmuL5SzngDyO4i+BOAGZMwZ+6GUOCvdNQHNXdBP
 NrjnQLGYus4pjEnzM9bP/LpRkskHhyjmfXeHDJ4XeJojiJuoc83abkS8r2pPQa9EWpbU39RSemi
 GAjJzkAZEiEaq4bVpXW0YY+zTKbrhc0Zc+rPo8FBage842yDSLJ/YK1j5unrwDfPyy25mby355v
 9m0/Kx0XdtpWj875UFg==
X-Authority-Analysis: v=2.4 cv=F+7C5ahN c=1 sm=1 tr=0 ts=6aab2330 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=69wJf7TsAAAA:8
 a=VnNF1IyMAAAA:8 a=hLE2qgY7I0kVXSCj97YA:9 a=QEXdDO2ut3YA:10
 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-16_03,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 phishscore=0 clxscore=1015 malwarescore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609160322
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

On 9/16/26 4:32 PM, Eric Farman wrote:
> The ioctl to determine whether KVM_DEV_FLIC_CLEAR_IO_IRQ is present
> receives the contents of the attribute struct as its payload,
> rather than a pointer to the payload itself as is convention.
> 
> This may result in erroneous errors from the ioctl, which would
> result in clear_io_supported being false when it otherwise could
> be used (which is helpful in device recovery).
> 
> Cc: qemu-stable@nongnu.org
> Fixes: 9eccb8622c ("s390x/kvm: add interface for clearing IO irqs")
> Signed-off-by: Eric Farman <farman@linux.ibm.com>
> ---
>  hw/intc/s390_flic_kvm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/intc/s390_flic_kvm.c b/hw/intc/s390_flic_kvm.c
> index f833a3996a..5e6d422fba 100644
> --- a/hw/intc/s390_flic_kvm.c
> +++ b/hw/intc/s390_flic_kvm.c
> @@ -633,7 +633,7 @@ static void kvm_s390_flic_realize(DeviceState *dev, Error **errp)
>      /* Check clear_io_irq support */
>      test_attr.group = KVM_DEV_FLIC_CLEAR_IO_IRQ;
>      flic_state->clear_io_supported = !ioctl(flic_state->fd,
> -                                            KVM_HAS_DEVICE_ATTR, test_attr);
> +                                            KVM_HAS_DEVICE_ATTR, &test_attr);

Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>

But AFAICT this means we've never actually driven
KVM_DEV_FLIC_CLEAR_IO_IRQ and instead always took the -ENOYSYS in
kvm_s390_clear_io_flic() -- so probably want to make sure we test this path.

>  }
>  
>  static void kvm_s390_flic_reset(DeviceState *dev)


