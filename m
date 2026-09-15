Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50767C982C4
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 12:31:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6SJP-0001W9-GL; Tue, 15 Sep 2026 08:30:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1x6SJJ-0001Vi-IX
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 08:30:57 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1x6SJ2-0006sJ-Mb
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 08:30:53 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68FA1Zi6366071; Tue, 15 Sep 2026 12:30:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=JwJMIH
 petfgzWx/3NAsG7UVf4EIJQwtB078xN8s9SMM=; b=GnpZU2HLnByhAq5j4idw4w
 MusIAsAouLokv5K43reQdn25+6cRVCAB/4xnf+K4VdtJuKiVVB1eP4xptvAqWBzh
 OsuR5KyrSWZVcp1tyBioET1EPI2F2wsf3wjKyo/xpSi6anRiYN7MVx/Ssu+0XBqm
 sJ8K5QvOCXDOfQdJYYDixnyMVT4/10mqv+HPxLuyOlvOsP/8mm8gaRoagUfqT/t+
 NnASoSYKJp99lOGr2aNm4YBmpVYmC1YWnJAp+WVTbmdEof1SQZsYXWRnRWBAAgn7
 GSy3qsLuy9VDosXndw3R35jVGnF34s5U7N1YJRvFijWs4v3Cqq4+qEZRC7HLqtmg
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmv5hq0w1-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 15 Sep 2026 12:30:33 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68F9oe503782021; Tue, 15 Sep 2026 12:30:32 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gq089h96s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 15 Sep 2026 12:30:32 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68FCUVop24773270
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 15 Sep 2026 12:30:31 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3FD0D58062;
 Tue, 15 Sep 2026 12:30:31 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8E17458056;
 Tue, 15 Sep 2026 12:30:30 +0000 (GMT)
Received: from [9.61.83.62] (unknown [9.61.83.62])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 15 Sep 2026 12:30:30 +0000 (GMT)
Message-ID: <c203cdd8-9549-4929-86bc-596ae33c58b6@linux.ibm.com>
Date: Tue, 15 Sep 2026 08:30:30 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 102/105] configure: remove cross_cc and gdb detection logic
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>, Aniket Sahu <asahu1x@linux.ibm.com>,
 Jared Rossi <jrossi@linux.ibm.com>, Zhuoying Cai <zycai@linux.ibm.com>,
 Joshua Daley <jdaley@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>
References: <20260904124604.2207440-1-alex.bennee@linaro.org>
 <20260904124604.2207440-103-alex.bennee@linaro.org>
 <dab85c9c-4718-48d1-a343-c2e6b5f8e24f@linux.ibm.com>
 <87a4pn8yra.fsf@draig.linaro.org>
 <CABgObfYEN8Qme6zXGYJpEeHTiFegjOm=Ym-3vU9LE1Z-Wsot3g@mail.gmail.com>
 <231c5426-b1b9-4465-b62d-a61dcb41c041@oss.qualcomm.com>
 <CABgObfZnyHenuVJ6maVs+jMNQCJeYhtcnXtXOqN1G3NcbvDt7g@mail.gmail.com>
 <aqfX2414cAMCcI18@redhat.com>
 <5cc8dd29-9093-4082-b8e5-32823f21c71d@oss.qualcomm.com>
 <CABgObfY68FT-V=G1Sks865FtEwEwB9SKyHx1YTLtG_4x9WDseA@mail.gmail.com>
 <871pavd8ry.fsf@draig.linaro.org>
Content-Language: en-US
From: Eric Farman <farman@linux.ibm.com>
Autocrypt: addr=farman@linux.ibm.com; keydata=
 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
 y8m0x6unNti2MZIUMy0m2gcE
In-Reply-To: <871pavd8ry.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE1MDE3NCBTYWx0ZWRfX1sHAwG3K0BTK
 7lkWZvX3BT6do2JAsGwdqhG4jz7hKM6l8iWYIIi/o8T3KjOuuvuWblcmZm9AbI7wcpszgEvdrTS
 8/B1gEczYLi2xqEoFW/C9O+y9BRMs9mtFVHY58J778umiGrg6KeBeCGJtbuAcP11wdSk6KSZklS
 oKsFX0RKKiXsk3G0TyPeTRvy3djfvhDESAk+tq5BudKxd54Ncvtr/tCZqQo3lsXG0Un+lXJtDKZ
 09RmrpAn4krrFnMvBCOk9eqV+NY8Et79Gfm5YvKSIgthyMYRxeYnst2Ldl4c+0zpbhZP2uE0sT3
 ejRZanyMUKmSXL4PxiKoA1aHbkJyylMpUzP1EeqgOowGDGXPw3597A64ArHuN9Xyz17wR7oQRz8
 ZUBZyDu1iRZklRyPqMOyhf/eZYV618nxxN6+CzOuKhMW/eiFxhF0smnDsmR0cStlH7WxdSoAFwM
 uZ0BEL0cwIQfY9cejEQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE1MDE3NCBTYWx0ZWRfXydg8RUQ02qjS
 sJyO+fJ4n9Y1g02Uk79dP8n0JHSdgW5FEcKcv/iY6XxZHSyDNkY8W949MAhy8ZljoC36KPGuZ7d
 1l2v+l/CFfHY0Xqpcqvh03/9+twgU8M=
X-Authority-Analysis: v=2.4 cv=Zsx4uN7G c=1 sm=1 tr=0 ts=6aa93a69 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=20KFwNOVAAAA:8
 a=EUspDBNiAAAA:8 a=UDytehw1HmrwOlYHregA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: Uim8B4BvUxTXqQddGWIWAlF1GZmYeiT8
X-Proofpoint-GUID: Uim8B4BvUxTXqQddGWIWAlF1GZmYeiT8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_03,2026-09-14_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 adultscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609150174
Received-SPF: pass client-ip=148.163.158.5; envelope-from=farman@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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



On 9/14/26 1:48 PM, Alex Bennée wrote:
> Paolo Bonzini <pbonzini@redhat.com> writes:
> 
>> On Mon, Sep 14, 2026 at 6:13 PM Pierrick Bouvier
>> <pierrick.bouvier@oss.qualcomm.com> wrote:
>>> There might be some confusion with what the series introduced. To make
>>> it clear, it does not touch, nor use tests/docker/Makefile.include.
>>>
>>> Each tests/tcg/arch declares which container it depends on, and we have
>>> tests/tcg/meson.build that automatically builds it if needed for tests.
>>> Reverting that will not be very easy to be honest, as it's a core part
>>> of the new logic.
>>
>> If it is core, why is it patches 102...105?
>>
>>>   > IMHO it would be nice to replace tests/docker/Makefile.include with
>>>> a meson.build too. Yes, that would make it rely on a configured
>>>> build tree, but IMHO that's an acceptable tradeoff to get more
>>>> stuff into meson natively.
>>>
>>> That's easy, and would allow us to get rid of
>>> tests/docker/Makefile.include completely, by adding matching targets
>>> make container-image-debian-*. Also, we can have a top target
>>> 'container-images'. With this, people can build them with ninja or make.
>>>
>>> As Daniel mentioned, the trade off is to run configure first, and I feel
>>> it's quite acceptable. What do you think Paolo?
>>
>> The problem is that right now firmware builds are broken, because all
>> the supporting code in configure was removed. I'll review anything
>> that fixes it, even moving firmware builds to meson custom_targets
>> even though it seems quite intrusive.
> 
> I've reverted those three patches - so leaving the TCG tests still to
> run using meson but still generating tests/tcg/$TARGET/config-target.mak
> for the benefit of the firmware builds (and also vdso build which uses
> the same stuff).
> 
> However I need to test the firmware builds and its not quite clear how
> to kick that off. I did try:
> 
>    cd pc-bios/s390-ccw
>    make
> 
> but that works even with the current state of the tree.
> 
> Where is the firmware build documented so I can test the patches before
> I post v2 to the list?

Are there some artifacts left behind from the before times, that let 
things work as they used to? I don't think the steps I'm using are 
particularly weird. If I check out v11.1.0, I get...

[qemu]# rm -rf build/
[qemu]# mkdir build
[qemu]# cd build/
[build]# ../configure
...snip...
[build]# cd pc-bios/s390-ccw/
[s390-ccw]# make
-Wno-stringop-overflow detected
-fno-stack-protector detected
-Wno-array-bounds detected
-Wno-gnu detected
-march=z900 detected
Assembling start.o
Compiling main.o
...etc...

Compared to the error I'd mentioned earlier.

The best I can do to reproduce your behavior is to do the above on 
v11.1.0, checkout master, re-configure, touch 
/path/to/qemu/build/pc-bios/s390-ccw/Makefile, and then redo the make. 
But if I do a make clean, or throw away my build directory and re-do 
everything, I end up failing again.

Having said all that, I'll happily test what you have.

Thanks,
Eric

