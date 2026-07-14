Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02BF8C43458
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2026 10:25:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjaK7-0004KD-Cs; Tue, 14 Jul 2026 06:25:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1wjaK5-0004G0-GB
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 06:25:09 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1wjaK3-0007pS-0P
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 06:25:09 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66E6fnZ7482032; Tue, 14 Jul 2026 10:25:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=KWMvjw
 fez8uPyHcB1yvzoUe/umdQJUzqNaxC1UJpc5g=; b=j19hKp5rpLg9qIXPcDqeTy
 mJLQsk4kVQfSCv7FMOanM07n6alAy3nj0RXx3ZJvm/LFRh0rEYxhTEs7eZpXBxXO
 JHL0RCcv8TdigSEmkhFC5R0W43eVuk0t4FdVWnhqS67wcP+Ub8OvHNuyh1gJbZ8b
 KQuycBgsiORjsNvbynD7fQLHbKcLrOdL1gdC4Jcw2pcRN3dZhv0bKUtJr7Og1Bo7
 lcMbsJ6TA6L79Jjclz1pk2lb/UBqoCMR+dXmw2Vxpghk/iXL/7j3l5FlLpc2LZ5U
 KQOUG8E2PyCfBFb2UupWza/6VmPF3jIwTKE/iSHEXv9S2qmd0LMk2Cf1VcHz9bYg
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fbexwn3ed-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 14 Jul 2026 10:25:00 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66EAJbCC010224;
 Tue, 14 Jul 2026 10:24:59 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fc15jt9ts-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 14 Jul 2026 10:24:59 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 66EAOtbw33095936
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 14 Jul 2026 10:24:55 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 36CD920043;
 Tue, 14 Jul 2026 10:24:55 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BA1D620040;
 Tue, 14 Jul 2026 10:24:50 +0000 (GMT)
Received: from [9.123.10.203] (unknown [9.123.10.203])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 14 Jul 2026 10:24:50 +0000 (GMT)
Message-ID: <0dbbac06-8fdf-45ef-9cd4-eaf2510394d2@linux.ibm.com>
Date: Tue, 14 Jul 2026 15:54:49 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: what is qemu_system_guest_panicked() for?
To: Fabiano Rosas <farosas@suse.de>, Peter Maydell <peter.maydell@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Shivang Upadhyay <shivangu@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Nicholas Piggin <npiggin@gmail.com>, Cornelia Huck <cohuck@redhat.com>,
 Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 "Daniel P. Berrange" <berrange@redhat.com>
References: <CAFEAcA_zmc=Vvs38Qos_gecCmGAbRgDQF-0+x85Ja66nsqrHxA@mail.gmail.com>
 <87pl0rdnar.fsf@suse.de>
Content-Language: en-US
From: Aditya Gupta <adityag@linux.ibm.com>
In-Reply-To: <87pl0rdnar.fsf@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: 1DAoBWADWI8TnWdXGTZwzw-KQOw9mZcK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDEwNiBTYWx0ZWRfX8Tca4ScBT3mH
 GZutmFvFkS1H/zDkKDRN8QtvcSMcCPWu27rtsJn5p+nZ4TQ0hhhSovC/kt3dqThEi4PpjwxrtRs
 4sX491lba5xgBQq/QJI5YdYErwM9MMA+htvxgbkSIUEDR51ZFjXkXRH/qf/UDkvvEj4vmsELhFE
 yNXBIl2fL7PdPq83x963tghGtg3P9ZmSyZj8Gh8JaJChmxbbG4kkowjjRD/72txA/ZueWFNgKAA
 Q87z97RnBYH8r53HTOl1C84zb1PVWXE7Fi8imVKMkCSHX/gC/dtNPUW000hIhuo4JqXCHpTd7l6
 dhUQhXB85uT6XGW5UGH6MudpGyfNU9JNdaYengJ7Wl2/MEYRVl48bjHz8AITxJ1psYVLGBHmNP1
 AYi6GWWwfuPU75inNcwlJW1B4YeA/D67/+OzIrttHFAK3gDIdAyopgmnbYNlASu91lTQoNK9v2/
 Uxdr1tqmHRAF0WEZJmw==
X-Authority-Analysis: v=2.4 cv=XJoAjwhE c=1 sm=1 tr=0 ts=6a560e7c cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=KKAkSRfTAAAA:8
 a=f5HZ8H6rYIj2k_FndF4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: knT9o_X6FxYWWIib1gkAKZaB9XNTEvBL
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDEwNiBTYWx0ZWRfXxkelQPbuHRg6
 XzNazXpmErDTSGvOZJBFFOu908bFGLYFuU3BY7CQPCmkSAu62mYHODJIG0RvnPignOdwEgBdVEz
 OclLuBZ3uYvG7LNRLoo/zcBFfU97HYI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-14_02,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 bulkscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 clxscore=1011 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607140106
Received-SPF: pass client-ip=148.163.158.5; envelope-from=adityag@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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

+ shivang


On 13/07/26 19:06, Fabiano Rosas wrote:

> Peter Maydell <peter.maydell@linaro.org> writes:
>
>> (cc list is a random mix of maintainers of code that calls this
>> function, Paolo as "main loop maintainer" and a few others who
>> I thought might have an opinion.)
>>
>> We have a qemu_system_guest_panicked() function which causes QEMU
>> to report this to the user and do one of a couple of possible options
>> (shutdown, pause the VM, do nothing). This seems mostly intended for
>> "the guest OS told us by some mechanism that it just panicked". But
>> we use it more widely than that...
>>
>> Cases which are "the guest told us about a panic":
>>   - accel/kvm/kvm-all.c handling of the KVM_EXIT_SYSTEM_EVENT SEV_TERM
>>     and CRASH subtypes
>>   - the pvpanic device
>>   - the spapr ibm,os-term RTAS call
> I think I remember this one is arbitrary and the spec doesn't really
> interprets this as an error state of any sort. It's just that this is
> the way it has been used.
>
> I had to comment that qemu_system_guest_panicked line a few times when
> experimenting with using os-term to do a clean termination _from_ the
> guest code.
>
> PPC folks, please confirm, it's been years since I looked at this.
True. The way the spec mentions it seems the OS can get control back after
execution of ibm,os-term.

This difference is noticeable with `panic=15`. On an LPAR, this would 
print the
following line and do a reboot after a timeout of 15s (this happens in linux
after it has done the os-term call):

     [  338.186072] Rebooting in 15 seconds..

But on QEMU, this isn't printed, and the machine powers down:

     qemu-system-ppc64: OS terminated:

Maybe worth taking a look. Didn't notice this earlier, thanks Fabiano !

- Aditya G

