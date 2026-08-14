Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 849ECC5CFCF
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2026 16:08:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuuRf-0002ta-HM; Fri, 14 Aug 2026 12:07:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1wuuRN-0002sb-GE; Fri, 14 Aug 2026 12:07:30 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1wuuRL-0003fR-Ds; Fri, 14 Aug 2026 12:07:28 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67EE5bds1342777; Fri, 14 Aug 2026 16:07:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=McVfK0
 mvOBFhiFgEjkbXNOPpejgzGK7CgrZ84E2BMFk=; b=qQ3mpHwP9vV/iRdd1s3sMv
 /C5YCWP5GRggX1jmzRKNxK/nKwQeuIL7/b+RiqpGYT8eDTqs6YhbcKrFXhn0ANOX
 ppE7CTj4Q0fEaKpuuo9DuvTciiRkXQTs9JaQ/47mIXxUqcKP3MAGbIvRFjmfW8lG
 n+VhGTxd8hz+d+P4WDin9k+/VGl/RSNN2B0fBdjB5z/odNuQX9OxBLCcvi8JlpPP
 KEae8dpN29LWqFkzgtYAiyDHJcebjXxxMdiHzHewiefpYukMN1G58YQvoP7dRbJh
 4UEBhmIbcwxdy5fTeWBp73/uP+OU+pZ2uj53F9NW8nbPaBjO6twQzsQEXJxyub/g
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvma5pqq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 14 Aug 2026 16:07:25 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67EFuLXW008430;
 Fri, 14 Aug 2026 16:07:23 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fxg9hfw2w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 14 Aug 2026 16:07:23 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com
 [10.39.53.228])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67EG7MJn32113288
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 14 Aug 2026 16:07:22 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 72EE758059;
 Fri, 14 Aug 2026 16:07:22 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 55A0E58055;
 Fri, 14 Aug 2026 16:07:21 +0000 (GMT)
Received: from [9.61.14.149] (unknown [9.61.14.149])
 by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 14 Aug 2026 16:07:21 +0000 (GMT)
Message-ID: <591fcc50-05ee-40e2-a94e-003fef7b9c79@linux.ibm.com>
Date: Fri, 14 Aug 2026 12:07:20 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 15/15] pc-bios/s390-ccw.img: update s390x bios
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Matthew Rosato <mjrosato@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>
References: <20260812171707.1605637-1-farman@linux.ibm.com>
 <20260812171707.1605637-16-farman@linux.ibm.com>
 <4aecc479-d63e-4b84-8278-44db0e6d82ee@tls.msk.ru>
Content-Language: en-US
From: Eric Farman <farman@linux.ibm.com>
Autocrypt: addr=farman@linux.ibm.com; keydata=
 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
 y8m0x6unNti2MZIUMy0m2gcE
In-Reply-To: <4aecc479-d63e-4b84-8278-44db0e6d82ee@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE0MDEyMiBTYWx0ZWRfX0/H/kLIC7qOw
 2S08hNn5jnNWmVhm9jTeRRSZ+KqqwAfUM8Ku+8mXpi/TeTt8XtOU6TauPwd7MCYiVF/DLxl5HPX
 +10Ycio4cr+1n4Gdz2TNC9d5c/hDQ2/KNeEY2t8XNpqlrxElsRIoEUBQgaLN+r5CNKhcuUvUGYb
 Jlvze2FIwyJTsiEgLx/Pyw5+cyeoMtu37CIMkvtlrqRbiopRjeGw5OPOOWT0WkPrVYIaCn3c3GE
 3fe3ruSECdIGBgOtq6JB3Y+pb1icGhfufbBgy3DXlQG/oMQpJNx+tNkTI10zpP4GKCLRwSwYiR5
 PlmBubC5dnwLzeHO8+nlFYfMWajTHDRMIQ/hSJLi+revdZ2YOL04JeF9+lZlHR4yBujGn/qO0EQ
 O9KPRcp6nWeqJ3X91hRxj4hQxExHhJm4WgKOuEUujM+PJEJ0jNdVnwZR9TM+ZaCIPI4TMVAvnYH
 ltXae3W/jDw5t2q6VmA==
X-Proofpoint-ORIG-GUID: WsI9KukQnpLeQmjHqD3CQELqB_K2-i2x
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE0MDEyMiBTYWx0ZWRfXxrHah5D2EQl8
 qw1YmTyJEN6syy0kIaXgE8NNzXeIFOwcNt19Yu7vJkyWiTZ/rBD5Jofig5oojpUs9fQ0uALCHJ2
 7JulDIpf3yZ5cdrQ7bZ4NY6+h9p3MBw=
X-Authority-Analysis: v=2.4 cv=IfK3n2qa c=1 sm=1 tr=0 ts=6a7f3d3d cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=I5e9eXzb_jZjufu3kuIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: WsI9KukQnpLeQmjHqD3CQELqB_K2-i2x
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-14_05,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 impostorscore=0 bulkscore=0 clxscore=1015
 lowpriorityscore=0 adultscore=0 malwarescore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608140122
Received-SPF: pass client-ip=148.163.156.1; envelope-from=farman@linux.ibm.com;
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



On 8/13/26 4:38 PM, Michael Tokarev wrote:
> On 8/12/26 20:17, Eric Farman wrote:
>> Update the s390 bios with recent fixes for out-of-bounds accesses.
>>
>> Signed-off-by: Eric Farman <farman@linux.ibm.com>
>> ---
>>   pc-bios/s390-ccw.img | Bin 104136 -> 104216 bytes
>>   1 file changed, 0 insertions(+), 0 deletions(-)
> 
> How do you guys build s390x-ccw.img - which compiler version(s) are
> used for that?

This was gcc-16.1.1

> 
> Since we're updating source files in the stable series, where this
> image is not the same as in current master, I'll have to rebuild
> it after patching.  Now I wonder how should I build it.
> 
> In official debian we always build it from source, and there were no
> complains - maybe because no one uses debian to run qemu-system-s390x? :)
> 
> Anyway, on debian stable we have gcc-14.2.0, -- is it okay to use it for
> building the image?

I should think so. But if it doesn't work, let's look into why.

> 
> Also, there's little changes in s390-ccw.img between qemu 11.0 and 11.1,
> here's the list:
> 
>   b2b5dec9295 s390x: Enable boot menu for virtio pci device
>   d0473643803 pc-bios/s390-ccw: write IPLB location for non-net virtio 
> devices
>   e26dafb207b pc-bios/s390-ccw: Verify virtio support when booting from 
> virtio PCI device on s390x
>   084feb90980 pc-bios/s390-ccw: Add per-queue notification offset for 
> multi-queue virtio configurations
>   730173107a9 pc-bios/s390-ccw/virtio.c: Fix missing break for PCI 
> notifications
>   c12bb74fd57 pc-bios/s390-ccw: Refactor byte swapping
> 
> I think I can pick all that stuff for 11.0.x series just fine, to avoid
> (re)building the image for 11.0.x series.
> 
> For 10.0.x, things are really much larger:
> 
>   14c29f29064 pc-bios/s390-ccw: Fix compiler warning when compiling with 
> DEBUG enabled
>   d72fb5e6b2e pc-bios/s390-ccw: Add support for virtio-blk-pci IPL
>   40d80aedd5a pc-bios/s390-ccw: Introduce virtio-pci functions
>   5ed17bb32ab pc-bios/s390-ccw: Introduce PCI device
>   d3da8afd1dd pc-bios/s390-ccw: Introduce CLP Architecture
>   4ff1499adab pc-bios/s390-ccw: Split virtio-ccw and generic virtio
>   ada7a60056c pc-bios/s390-ccw: Store device type independent of sense data
>   4228a92b2a3 s390x: Remove duplicate definitions of IPL types
>   dd8c8f16c02 pc-bios/s390-ccw: Always reset virtio device on failed 
> boot attempt
>   5dbabcfee89 pc-bios/s390-ccw: Remove redundant vring schid attribute
>   1ef532cbcfc pc-bios/s390-ccw: Fix misattributed function prototypes
>   acb00a7aae4 pc-bios/s390-ccw: link statically
>   fc24fd9342e pc-bios/s390-ccw: Add a boot menu for booting via 
> pxelinux.cfg
>   47d68f7475f pc-bios/s390-ccw: Make get_boot_index() from menu.c global
>   108977796fb pc-bios/s390-ccw: Allow up to 31 entries for pxelinux.cfg
>   a4adf071dc7 pc-bios/s390-ccw: Allow to select a different pxelinux.cfg 
> entry via loadparm
> 
> basically it's whole virtio and pci support added, which might be too much?
> Please note that 10.0.x is an LTS series, also used in current debian 
> stable
> (trixie), so maybe it is also okay to pick everything up to this series, to
> bring the image in-line with current development.
> 
> In this case I'll just pick the commits updating the image too :)
> 
> What do you think?

Yeah, might be a bit much. The smaller fixes were contained enough that 
targeting them for stable made sense. Of the four fixes that were in 
this rebuild, three of the blamed commits date to the v2/v3 days. The 
fourth went in in 9.2.

Everything else in your lists is new function and whatnot, so my gut 
says leave it there.

Thanks,
Eric

