Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28DBAC44500
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 12:53:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgio1-0001Cd-Iu; Mon, 06 Jul 2026 08:52:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <uverma@linux.ibm.com>)
 id 1wgfJ7-0003A8-Fa
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 05:08:07 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <uverma@linux.ibm.com>)
 id 1wgfJ5-0002Ys-Kg
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 05:08:05 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 665MIlSf1515796; Mon, 6 Jul 2026 09:07:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=Ew8XFK
 M/ScWfcqxC2c3KnOkl11lpssmcFkmD+x44z+4=; b=kNYrIW+dGxwkt7Q+JnkWGx
 mDX7UjSMjC7IA4pibtjZ1s6YGyo26iPLYqwZeYh8eJatE9aKZDR6k9mojcVts6T3
 8dqyiJRrDXVC0Owg/WGz21t3w8BkW1pKeT4roSyg3UMSblrXuHKVb6nfPBedUANX
 fRCPmPbjIW+VSf312qcoOIomV9a+wXi+5VJybONqwHBI15oTd8Sj0sIimiMQch1Z
 qoZHGpgGaU6iONs0yXThSJlY2kABlBOo/q2YzK9jvRoj2LLmgphFVZTOK2YCB+qq
 wTcfPwYSdWHlSTMHi8+q84V801CiysZ6M9yhyhWIm7n8rINFIsxeNaDYdaDM5CdQ
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6rkdh8xp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 06 Jul 2026 09:07:54 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66695l7q028151;
 Mon, 6 Jul 2026 09:07:53 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f7cgpw3af-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 06 Jul 2026 09:07:53 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 66697qbd25166450
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 6 Jul 2026 09:07:52 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C7B7A58043;
 Mon,  6 Jul 2026 09:07:52 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0B39D58059;
 Mon,  6 Jul 2026 09:07:50 +0000 (GMT)
Received: from [9.123.4.188] (unknown [9.123.4.188])
 by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  6 Jul 2026 09:07:49 +0000 (GMT)
Message-ID: <99254c26-0b41-4efc-b1cd-ad1e19576f32@linux.ibm.com>
Date: Mon, 6 Jul 2026 14:37:48 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: VW ELF loader
To: Alexey Kardashevskiy <aik@ozlabs.ru>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>, th.huth@posteo.eu,
 nnmlinux@linux.ibm.com, sbhat@linux.ibm.com, harshpb@linux.ibm.com
References: <f881c2e7-be92-9695-6e19-2dd88cbc63c1@ozlabs.ru>
Content-Language: en-US
From: Utkarsh Verma <uverma@linux.ibm.com>
In-Reply-To: <f881c2e7-be92-9695-6e19-2dd88cbc63c1@ozlabs.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=M7J97Sws c=1 sm=1 tr=0 ts=6a4b706a cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=EGYj-OwPAAAA:8 a=EduV2CZr12S2zcHcuykA:9 a=QEXdDO2ut3YA:10
 a=xQyHFheebwQZ3wMG2Lhb:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDA4OCBTYWx0ZWRfXzifl8x16pxeX
 xJMN3c8pE55w5UfchFkHXPhTQVNj+D6949crP05Uf3/GooQgDnxhWgYArNRUYIINwmaaIaPRUts
 35Tzl2Il0nDPzKRbX24I2hIXyIZa8II9hRuycHqIE1oy0t0KMKJqRI7mpdUEdmkr7/JiOZghnQl
 dzpQQQEXLwrKTuv79oZeWEPmkMLgQQJaVB/EriOcLuSW0opQopB7OtCkUDLWe1vOA71z5qIExqk
 gs3tgXEHuXeiXwBbZvsj6Gxd3EWxS+8+G4zo4KYZU3ePWLSbfJJF0UwG939dpaaaHwakgYhBczV
 mqgVZnMIPoaAfDjq8yfjTWEmlrkEK7usKRu42SMQwSP2AbWjWat5t4Yz+Fk1hr8pLrl30fv0Viy
 w2WettNYb+shQEGv7Mj1arNDxnGd1zZDOg+JM4OkoWu9CZyraTvArhCpPQpuEQlMzk4zdh40QBc
 IOcTgxrZKA3PkUXDVfw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDA4OCBTYWx0ZWRfX5/ztidhqleJh
 MWGrlfISMENtn+DQUl61Z9AYbIvgejfW2QQvaWEEsEBo1RGK7LqVxB5FQC1BcFzzl0Aiy8Ss6Dh
 b8y1B+J4LEOYzqdWVyTIooq2DI6O+xA=
X-Proofpoint-GUID: YNh_5ysNXJZ4FMGQAeC5_R4FjMZkDBLu
X-Proofpoint-ORIG-GUID: YNh_5ysNXJZ4FMGQAeC5_R4FjMZkDBLu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-05_02,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1011 adultscore=0
 priorityscore=1501 bulkscore=0 spamscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060088
Received-SPF: pass client-ip=148.163.158.5; envelope-from=uverma@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 06 Jul 2026 08:51:54 -0400
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

+Thomas, Narayana, Shiva, Harsh - FYI

Hi Alexey, David and Paolo,
Reviving this thread as would like to add the disk boot support by 
loading GRUB.

On 2/1/20 7:09 PM, Alexey Kardashevskiy wrote:
> Hi!
>
> In my effort to "kill SLOF" (the PPC pseries guest firmware), I 
> proceeded to the stage when QEMU needs to load GRUB from the disk. The 
> current workaround is to read it from qcow2, save in a file and then 
> call load_elf(). Not nice.
>
> 2 problems with that.
>
> 1. when load_elf calls address_space_write() - I need to know where 
> and how much RAM was used to mark this memory "used" for the OF client 
> interface (/memory@0/available FDT property). So I'll need "preload()" 
> hook.
>
> 2. (bigger) GRUB comes from PReP partition which is 8MB. 
> load_elf{32|64} consumes filename, not a memory pointer nor a 
> "read_fn" callback - so I thought I need a "read_fn" callback.
>
> And then I discovered that load_elf actually maps the passed file. And 
> here I got lost.
>
> Why does not load_elf just map the entire file and parse the bits? It 
> still reads chunks with seek+read and then it maps the file in a loop 
> potentially multiple times - is this even correct? Passing "fd" around 
> is weird.
>
> Why ROMs are different from "-kernel"?
>
> If I want to solve 1 and 2 of my problem, should I just cut-n-paste 
> load_elf and tweak bits rather then add more parameters to already 
> 15-parameters long prototypes?
> Or I could read GRUB from qcow2 into the memory and change the rest to 
> parse ELF from memory (mapped from a ELF file or read from qcow2)? 
To rectify the mentioned issues, would like to implement a custom ELF 
loader for ppc that can load the elf from the buffer and claim the 
memory for each program header segment.

It was attempted earlier in v6 (Patch 6/6) and v7 (Patch 5/5) , but 
later dropped for reasons unknown to me:
v6: 
https://lore.kernel.org/qemu-devel/20200203032943.121178-1-aik@ozlabs.ru/
v7: https://lore.kernel.org/qemu-devel/20200220061622.15064-1-aik@ozlabs.ru/

I believe disk boot is a worthwhile addition to VOF. It would make the 
pseries machine type fully usable without SLOF for the most common case: 
booting from a distro qcow2 image with a PReP partition containing GRUB.

>
>
>
> Thanks,
>
> ps. VW == very weird, indeed :)
>

Regards,
Utkarsh Verma


