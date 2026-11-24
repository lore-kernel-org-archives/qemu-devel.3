Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4ECC606A33B
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 08:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=qOl6Es0D
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVlxa-0002rO-25; Tue, 24 Nov 2026 03:33:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <uverma@linux.ibm.com>)
 id 1xVlxT-0002qh-V0; Tue, 24 Nov 2026 03:33:01 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <uverma@linux.ibm.com>)
 id 1xVlxR-0005im-LC; Tue, 24 Nov 2026 03:32:59 -0500
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AO34Zkv1260155; Tue, 24 Nov 2026 08:32:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=BaQ+It
 pVP/G6N4ajEQmJA0MclC0dhcbiE8ogDP/+z+Q=; b=qOl6Es0D/5E63mavsJx4s8
 knIlCzeTsTPy0XwiMd3oiC8x7zXsav8I/njxr9wf81vpomGZsasnqj7y+OY/MS/e
 /Xdr57gTZUp+48I38FwxQWmGfnyZo69saWXb478K2ORyKHhgJqgXGPRxMNF5+15a
 oxXlXjpo9T8D5WJyEiiZJOislL/WWum1nFqJR2HNFjqtzTaHZ2CsYcm2LmFXan8W
 r77mxS+sNPpmry6bLi04sdPF52WONwLPzO1vTarCCA9y/JEHtORE5luMH2S61wn2
 cf662tMToDvMI1xSbeSkbNecvLpIHrDiKGtmIi3hGB1gSt3TaamgV199oPjg+yyQ
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j34fket45-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 24 Nov 2026 08:32:31 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AO2nFkh2740964; Tue, 24 Nov 2026 08:32:30 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4j3nmqj2v5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 24 Nov 2026 08:32:30 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6AO8WSoG23003896
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 24 Nov 2026 08:32:29 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CAD1C58061;
 Tue, 24 Nov 2026 08:32:28 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1D81058043;
 Tue, 24 Nov 2026 08:32:24 +0000 (GMT)
Received: from [9.123.12.1] (unknown [9.123.12.1])
 by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 24 Nov 2026 08:32:23 +0000 (GMT)
Message-ID: <c12290ac-37da-408a-af6d-92a3c177a1cc@linux.ibm.com>
Date: Tue, 24 Nov 2026 14:02:22 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PReP] Maintainer status check for PReP machine
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, qemu-ppc@nongnu.org,
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, Thomas Huth
 <huth@tuxfamily.org>, Laurent Vivier <laurent@vivier.eu>,
 Aurelien Jarno <aurelien@aurel32.net>, Helge Deller <deller@gmx.de>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 BALATON Zoltan <balaton@eik.bme.hu>, Chinmay Rath <rathc@linux.ibm.com>,
 Amit Machhiwal <amachhiw@linux.ibm.com>
References: <250f899a-51c0-4007-99dc-54bd336f0693@linux.ibm.com>
 <e29c8bc1-0a25-4dfc-b429-6805c373b5cd@oss.qualcomm.com>
 <7672e73a-2945-49d9-94a8-a3d187be300d@linux.ibm.com>
 <d515161e-f382-4937-a342-4d21e16332eb@kaod.org>
Content-Language: en-US, en-ZM
From: Utkarsh Verma <uverma@linux.ibm.com>
In-Reply-To: <d515161e-f382-4937-a342-4d21e16332eb@kaod.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI0MDAzMiBTYWx0ZWRfX+NkPMR/EUmls
 DXFQqOJSiiRk5+mTCjehlchPQWFplzSLrZkLrQ+RiS2ehspR6wtwDun/rs9I89U5/OgtJGP5dZx
 Hj4TGH4vWsac9nMBXzgxpb/IxoCV9OTvrCUvJrzS1VXZY21QmM62lNjPZLg+YOScy5aNWJkfRob
 3YeAtk23LnifcYMYkIwTLOhrTtrkgEy97lfnIybvT+kjGAEZ/+UQqp89JpmLCVLHvywbWjHgy/3
 vUAdlqeZ05yafV24TMZT78xOWo4CRUHWT6UODvH3kQkCna33vuuzDs/UnZae1IaFvyziK1UAAqg
 0GG8qBOdq0RSzukZwuO8OiWYaz7iVC9JArql3DHlqyq47+2jpGRsccvRy0ZFI6o5F6wNVBXUSFH
 HdrRV/jxYGuWhhqiTAdqwLHjy4YLvy0ABw9ECQAMj8lRkiy90E/6P3/utphL3K/Iki2W9Ae0s24
 EWiICBVS/EUj1TE3AQg==
X-Proofpoint-ORIG-GUID: 0TfFvmxGjRLtv97y2Lbm3arfHIwLcsOX
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI0MDAzMiBTYWx0ZWRfXzYm/z3z1ySNH
 8ZPmvE+dXIQlma6bIzqCxCmMb9hNOavare4XuDD/gSpsFGpbhSvyS//g5ApRx9GoiYtVbJqSwzA
 Jxhw51pAakUKgo6nTVzi9RJ5nNIX1DI=
X-Authority-Analysis: v=2.4 cv=A9z5rKWG c=1 sm=1 tr=0 ts=6b054ba0 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=Co1jgmpq9uk2YL5_-7YA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: KfvoDVA2X-jzW-z5kdhkYFBTOcmitaTG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-24_01,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 adultscore=0 phishscore=0 priorityscore=1501 impostorscore=0
 bulkscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611240032
Received-SPF: pass client-ip=148.163.156.1; envelope-from=uverma@linux.ibm.com;
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Cédric,

On 11/24/26 1:39 PM, Cédric Le Goater wrote:
> On 11/24/26 06:59, Utkarsh Verma wrote:
>> Hi Philippe,
>>
>> On 11/23/26 11:02 PM, Philippe Mathieu-Daudé wrote:
>>> Hi Utkarsh,
>>>
>>> On 23/11/26 18:14, Utkarsh Verma wrote:
>>>> Hi Hervé,
>>>>
>>>> I wanted to check whether you are still interested in maintaining 
>>>> the PReP machine in QEMU.
>>>>
>>>> Your name is currently listed as the maintainer for PReP in the 
>>>> MAINTAINERS file. However, we haven't seen much recent maintenance 
>>>> activity for this subsystem, and I wanted to check whether you would 
>>>> like to continue in this role.
>>>>
>>>> If you are still interested, it would be great to have you continue 
>>>> as the maintainer. Alternatively, if you are no longer actively 
>>>> involved or would prefer to step down, please let us know.
>>>>
>>>> In the absence of a response, we are considering sending a small 
>>>> MAINTAINERS cleanup patch to remove your name from the entry and 
>>>> mark PReP as Orphan, so that the file accurately reflects its 
>>>> current maintenance status. This would not affect the PReP 
>>>> implementation or its functionality.
>>>>
>>>> Please let us know your preference.
>>>
>>> Are there any PReP patches pending review / left unattended?
>>>
>>> This machine works well enough, is tested; what is your issue with it?
>>
>> This is more about reflecting the correct status in MAINTAINERS file 
>> as the currently listed maintainer (Hervé) have been inactive for 
>> about 3 years, although the patches are getting reviewed by other 
>> community members.
> 
> yes. That happens very often for tree wide changes. Nothing worrying.
> PReP being an old and stable machine, not much is happening.
> 
> Debian still boots :
> 
> 
>      >> =============================================================
>      >> OpenBIOS 1.1 [Jun 29 2026 21:11]
>      >> Configuration device id QEMU version 1 machine id 0
>      >> CPUs: 0
>      >> Memory: 128M
>      >> UUID: 00000000-0000-0000-0000-000000000000
>      >> CPU type PowerPC,604
>      milliseconds isn't unique.
>      Welcome to OpenBIOS v1.1 built on Jun 29 2026 21:11
>      Trying hd:,\\:tbxi...
>      >> Not a bootable ELF image
>      >> switching to new context:
>      loaded at:     04000400 04015218
>      relocated to:  00800000 00814E18
>      board data at: 07C9E870 07CA527C
>      relocated to:  0080B130 00811B3C
>      zimage at:     0400B400 0411DC98
>      avail ram:     00400000 00800000
>      Linux/PPC load: console=/dev/ttyS0,9600 console=tty0 
> ether=5,0x210,eth0 ether=11,0x300,eth1 ramdisk_size=8192 root=/dev/sda3
>      Uncompressing 
> Linux................................................done.
>      Now booting the kernel
>      Debian GNU/Linux 3.0 6015 ttyS0
>      6015 login: root
>      6015:~# uname -a
>      Linux 6015 2.4.18 #15 Tue May 20 15:11:37 AKDT 2003 ppc unknown
> 
> 
> 
> Kudos to Mark for the OpenBIOS support !
> 
>   > It will be good to have someone listed in the MAINTAINERS entry for 
> PReP who is active in the community or we should change the status to 
> orphan, so that it encourages others to step up to maintain it.
> 
> Do you plan to step forward as a PReP reviewer ? You could start
> by contributing some changes. That would be a good first step to
> show your interest in QEMU support.
> 

Currently I'm looking into pSeries and VOF, but sure will find time to 
review and contribute to PReP as well.

Thanks,
Utkarsh

> 
> Thanks,
> 
> C.


