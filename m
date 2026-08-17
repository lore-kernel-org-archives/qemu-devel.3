Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADB5EC5DF66
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 10:33:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvud0-0006Tu-Ot; Mon, 17 Aug 2026 06:31:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <uverma@linux.ibm.com>)
 id 1wvucs-0006Md-Ae; Mon, 17 Aug 2026 06:31:34 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <uverma@linux.ibm.com>)
 id 1wvucn-00015V-Ev; Mon, 17 Aug 2026 06:31:27 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67GLVujM3685351; Mon, 17 Aug 2026 10:31:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=805HrY
 e2n2alq3Y+npI6777TzErWxqJfLQW80stAgOA=; b=ZfTcvemCPaRjQsUcB9hBiW
 yeXMB5wmrppSAtGnKwL7ngz5Nt8Op+bNJZxSgEda0rYTLF/1lqvGzR+9uRE/3E6e
 R9S6bZES7CVmL8tnLhD5uHeWWtLQ/aSXDfiBZ2ABsp57/comgDCJYVm8taUr9rgU
 l2exAukXdrLBGDW5chgbx4wVdJXhQZCL324vcDlBkDjsWPb1vCiMpnPtHEoR7j4G
 h+vLJbH2BKqWinI/SK0MYpZYsv7QArt3qLM64qXPDdzFuo4NN/vtmZhaov6D0aLP
 R2uiJGvFL8We+X+AlOtS/b20dtoPuQGy2NUzxn5y/u4Vepa+M/O3ipHaFwnE/CGQ
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g2fm3hrwv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 17 Aug 2026 10:31:14 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67HAQLb8003638;
 Mon, 17 Aug 2026 10:31:13 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g32epwsxb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 17 Aug 2026 10:31:13 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67HAVCSj32309780
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 17 Aug 2026 10:31:12 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 72B4B58078;
 Mon, 17 Aug 2026 10:31:12 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 985E05807C;
 Mon, 17 Aug 2026 10:31:07 +0000 (GMT)
Received: from [9.124.212.152] (unknown [9.124.212.152])
 by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 17 Aug 2026 10:31:07 +0000 (GMT)
Message-ID: <1457f407-54b6-4823-ad97-cf204ff36d4d@linux.ibm.com>
Date: Mon, 17 Aug 2026 16:01:05 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: VW ELF loader
From: Utkarsh Verma <uverma@linux.ibm.com>
To: David Gibson <david@gibson.dropbear.id.au>,
 Alexey Kardashevskiy <aik@ozlabs.ru>, balaton@eik.bme.hu
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Stefano Garzarella
 <sgarzare@redhat.com>, th.huth@posteo.eu,
 nnmlinux@linux.ibm.com, sbhat@linux.ibm.com, harshpb@linux.ibm.com,
 qemu-ppc@nongnu.org
References: <f881c2e7-be92-9695-6e19-2dd88cbc63c1@ozlabs.ru>
 <99254c26-0b41-4efc-b1cd-ad1e19576f32@linux.ibm.com>
 <akuViylBcKiXMbjH@zatzit>
 <b0ff3cca-7acc-419e-8507-4b3ae13a715e@linux.ibm.com>
Content-Language: en-US, en-ZM
In-Reply-To: <b0ff3cca-7acc-419e-8507-4b3ae13a715e@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: fHPAsAedi9_eVIeAH3kJ57jLrpAbCsH5
X-Proofpoint-ORIG-GUID: fHPAsAedi9_eVIeAH3kJ57jLrpAbCsH5
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE3MDA3NCBTYWx0ZWRfX2VyrFkLDnLL2
 w0rGfG9q3+YnkWDDEjNxuKRluI2VZc4R4GJfkuomXX+5hcVEe0fboVNh8gKJ7dXkutS0QTr5VQ0
 WsPabw8CRhdzRmFvTIIc5j8UOe1qrLo=
X-Authority-Analysis: v=2.4 cv=WtQb99fv c=1 sm=1 tr=0 ts=6a82e2f2 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=EGYj-OwPAAAA:8 a=rqXIRdvwlrPMOgUx77AA:9 a=QEXdDO2ut3YA:10
 a=xQyHFheebwQZ3wMG2Lhb:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE3MDA3NCBTYWx0ZWRfX552/Ar86YSz3
 Dx+Ax7W1lp7DfrKm5iw9K7WGPNE5m+8SjphoQtSvgecspcTUjcGVzqYzRzcVBuoVOlk7g2e/1W3
 BKPH40AsXfZvcTzUXUNnDyn8k4YrZWGg3oVSQgbu7FpJMKI3c3a+7ZXp+H6sqJHJNnuTijM9e3S
 gAFsL0gEwb+xaE3iynb8jaqRmIObQYFo2UuSrfWgAAkDnWXmB8j6mtRQ49GS1mSMh4RYUskGoEX
 swfbaZ1xhUj1fPBc0nx2oXLrbiMO9qFBcyU+J3RN5eD6LN4k6LEmNtpsYLDthwwYO7qtCjFuKpW
 P0vS7aYJ0q7zAXQR9tX/R4QnxmrjhC7s4Ia8mSbsDOIenhsifr7+Xfd+XNzc2oObElfzuBuxbSt
 cwE4pvoYe09FesF7RHN1WXJrcZEAnOzU2DQJn+GWtZ8fTExiYm7xKX/JrnxGaslSepd/VJZeKAu
 qKGlSGo9PdD1EzuYVlA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-16_06,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 malwarescore=0 suspectscore=0 phishscore=0
 lowpriorityscore=0 clxscore=1015 adultscore=0 priorityscore=1501
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608170074
Received-SPF: pass client-ip=148.163.156.1; envelope-from=uverma@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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



Hi All,

On 8/12/26 12:36 PM, Utkarsh Verma wrote:
> + Balaton, qemu-ppc
> 
> Hi David,
> 
> On 7/6/26 5:16 PM, David Gibson wrote:
>> On Mon, Jul 06, 2026 at 02:37:48PM +0530, Utkarsh Verma wrote:
>>> +Thomas, Narayana, Shiva, Harsh - FYI
>>>
>>> Hi Alexey, David and Paolo,
>>> Reviving this thread as would like to add the disk boot support by 
>>> loading
>>> GRUB.
>>
>> Good luck, but I'm afraid I no longer have any interest in, or time to
>> commit to looking at ppc qemu stuff.
>>
> 
> Thanks for responding to the query.
> 
> Let me share what we have been working on to add the qcow2 disk boot 
> support with VOF to get inputs from others who might have an opinion.
> 
> With below changes, we have been able to boot a qcow2 image using the - 
> hda option. The implementation covers:
> 
> - Partition table scanning (MBR and GPT) to locate the PReP boot partition.
> - A new load_elf_ram_sym_buf() API in hw/core/loader.c that loads an ELF 
> image from a caller-supplied memory buffer, reusing the existing 
> load_elf32/load_elf64 paths internally via memfd and also added an 
> optional per-segment callback so callers can act on each PT_LOAD 
> segment, used here to update /memory@0/available via vof_claim()
> - read, seek, and vscsi-report-luns OF services for block I/O needed by 
> GRUB.
> - VTY read/write routing for GRUB console I/O.
> 
> With all of the above, we are able to boot a disk over the sPAPR vSCSI 
> bus. I plan to post a RFC patch series soon. Quite a few things are 
> referenced from the Alexey's older patch series for implementing the VOF 
> (https://lore.kernel.org/qemu-devel/20200203032943.121178-1- 
> aik@ozlabs.ru/#t).

I have poseted RFC patches here:
https://lore.kernel.org/qemu-devel/20260817102733.605346-1-uverma@linux.ibm.com/

> 
> Alexey, Balaton and others,
> Let us know if this approach looks good.
> 
> Regards,
> Utkarsh
> 

Regards,
Utkarsh


