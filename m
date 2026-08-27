Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E1E9C61DC4
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 16:09:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzcfY-00041b-CQ; Thu, 27 Aug 2026 12:09:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wzcfW-00041R-Rv
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 12:09:34 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wzcfU-0007ex-A1
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 12:09:34 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67RFbwNb059045
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 16:09:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 5/pCsLc+9l/bLDOjka83aGOFp9BQopLGTlNrH3De4ww=; b=WmnXgif/zwJbM/DC
 QiWHbaKxVItf7dt3h9huLlVJkwb68FVRodMYBnZqBdf3pgdvDE/csbfSRDtrZmXT
 ytwpxcGM2BO8Ah0YW75/2+CeVeZPcYyg6Y9eqIej8D8+sxKuN5vMhw+gzqAzBVrY
 xtkDv+HNdgvCHtAqFcFJRAelt3aiY7jRkjiEefrMgNLO95RDopzPOwzOR3oW52HY
 CITF0awhTnTNjOA75+0WJgR5/u1r7heUR/Av0/iOrz6VXef0CXslyWTF88AGsV+k
 12N0yMPbY26xJXPTKbEvKERka1i/CtCqsx6JF+oXJmk8KC8ZI2QvuOngDftS2yeg
 BqTUDA==
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com
 [209.85.222.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gak561b07-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 16:09:30 +0000 (GMT)
Received: by mail-ua1-f69.google.com with SMTP id
 a1e0cc1a2514c-97c3796d17dso6755241.2
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 09:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787846970; x=1788451770; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=5/pCsLc+9l/bLDOjka83aGOFp9BQopLGTlNrH3De4ww=;
 b=CHZL9F+NYPiCPGBYF8HNgPfw28bP/1bd/x4a9w0Iuw65kMjrnt1XwwMPWO4SPDteOW
 5Raj0MYK2Bn7J5FpPEYVUkrLAXLRH0pSDWF9Yvqxu+7AqooYAZTUJ+Zqtxu0hpK66jk8
 BgeD/qZWvlTaPptvovWGECCmuJUc/f5x5UWAZGijj6rLhVqeQpksUSPLH+sxyinjsWMA
 eakssYSPgPvl5k7noyWlbWkkFJg4x6X3mhDEury7UdpmZ5ula9zKI/G2mv3/YuqqmcUU
 vEoNTFc9wHb7Zn12uPDjfw8y2+hOa/GcVWnKmCBSULfZwNYZFizXxJKcxVPeMJJQLAus
 FAhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787846970; x=1788451770;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=5/pCsLc+9l/bLDOjka83aGOFp9BQopLGTlNrH3De4ww=;
 b=eggTNViua4EIFR6+Ib3d8nAvtPQoloph/qAxYUTl1PfZFnofvDP7tUASL6qJ/bfgxg
 wiCk5IsoEPV69e8rsOy2V9dESfanuO1Pyso080jpHXp6TCf4d9aqW79PH8xfrisbvjpA
 a5Rfp4hmPcBv74KES2BpltXKM3khLJFlAfrHNh413YlM/8F/X+mpbHqet+GkB5/aMyjR
 /ateE94zizWdymhUjmvK3UiGWHKV4Kgr1NBaD0LLzmAKc3bGXP4A/++QwQUQDb7mzgQC
 79QPw9GJAB1Y37wn6EmmBMPs8lj6Qm1Xx8yd2wPxWXI2gahbNetWXJjari2c8fSe8T2b
 2QwQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RqAh8An5nuSDbhwEtpFN4WqQK/H3UXs/UbVmaj7P/uUlUdrPv9/DrrLtMH0TM9su2FB6J4Xo7eKitJB@nongnu.org
X-Gm-Message-State: AFuF++n1lUNKl4t3GQeD50nOHa75qIdHZO8Ejq5Djs3leYDv/CmJrCU8
 Kj9cgo0Eag68+BI+Sr5V2pz/bn7fLLZlMAC2QwVgzEuZ/NuMGfXrVHSbOYdwx0h2Tuc5rQwmMfn
 hKvrNvSIbLikieZSUNraB7JMHG1gFnsZT0oW2GcMUn9lSF5yYeBT9oy92IA==
X-Gm-Gg: AR+sD126PqYCP8dA4gSpdg0v9/Acv3klu/Tca5sYh3b9NhYnNfGRbAJh5auQv9gJ+c7
 5cvqBz4/NQDxPycx7ADCUHzDxDBBConFmfIg1+A98kEXZItot1yjAt2ApGxYsnk0OqsshMEJoPc
 Ds5Ytc4IJrv8zMkmpCQMhNg8ENQsaP7PnXI9i9/ryE0RgXM0MCqyM1AJDCZPd9FlPOrOJAp49cJ
 F+QWC23OQ5Aur8+7zaP8lzuBYXkjMOlNFG+oi9+3KgDK07M5RjBNq7So+T3xmHdbpSxllUY733L
 MbBhZpOHnriJpEoIMyH3uI3+zC3rpWvs8o4rg3KCOKxYDNzHY/DauamztMeZs5qPFbO8tZKLsjw
 3ZtqQuwykDzik2nXOuvFVbr+2PN5zhBn5dQ==
X-Received: by 2002:a05:6122:f86:b0:5c6:58df:5826 with SMTP id
 71dfb90a1353d-5c66e67deccmr3805953e0c.5.1787846967718; 
 Thu, 27 Aug 2026 09:09:27 -0700 (PDT)
X-Received: by 2002:a05:6122:f86:b0:5c6:58df:5826 with SMTP id
 71dfb90a1353d-5c66e67deccmr3805604e0c.5.1787846963528; 
 Thu, 27 Aug 2026 09:09:23 -0700 (PDT)
Received: from [192.168.69.226] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49b49bd11c3sm60857275e9.7.2026.08.27.09.09.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Aug 2026 09:09:22 -0700 (PDT)
Message-ID: <74883723-8f58-404c-9bab-ddb9a4aef4a8@oss.qualcomm.com>
Date: Thu, 27 Aug 2026 18:09:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs/about: Deprecate the 'next-cube' m68k machine
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Thomas Huth <huth@tuxfamily.org>, qemu-devel@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>, Natalia Portillo <claunia@claunia.com>
References: <20231007072313.22108-1-huth@tuxfamily.org>
 <1826b106-2b9a-41e2-81a4-8a3439f9c511@ilande.co.uk>
 <bf3036ba-0259-4757-a249-68e2a15af1ea@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <bf3036ba-0259-4757-a249-68e2a15af1ea@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDEzNiBTYWx0ZWRfX8JvqO+tSZyDz
 PayuxR5YjJbiy7Ff98/N5tIHcZDdnYMiTl3o2o30PwgsO2WKgczK0jFlyuYDUJ1HKxeKlel2oEw
 DK6XKy//5BdZkRYSh1S+mjD5n+rat3A=
X-Proofpoint-ORIG-GUID: U1l5jqG_9i_200gvopAR6OoX4HUvUYiq
X-Proofpoint-GUID: U1l5jqG_9i_200gvopAR6OoX4HUvUYiq
X-Authority-Analysis: v=2.4 cv=G+Ms1dk5 c=1 sm=1 tr=0 ts=6a90613a cx=c_pps
 a=UbhLPJ621ZpgOD2l3yZY1w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=p0WdMEafAAAA:8 a=dIu3SnmMAAAA:8 a=M4lxsBK10X_m7C-BeH0A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=TOPH6uDL9cOC6tEoww4z:22 a=Ua9G7VpiFza3u12uuhVB:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDEzNiBTYWx0ZWRfX/FTJymGK9Yo7
 a0On/H2mvic6IKOMzkjUouonRV1MYlllGDSxDailI3RH6arkpsGIUPTnuGqsyh8IUFNJNcs6sc6
 kgDQsvS34kO9c6Mw+h08mcdAxuD+HnyynKXCyOKt+RKrKLH4j6AoD47O0lb7fGnlgyrDrFj4Wod
 rvDLz0w1pnA7X+Fcv0nQMNzdlgtKTVUvW/XTG11e9xo08GR1qE9eEgeo+uIIv3POd8EDFTlFe8n
 a4zfBeeMSGP0r6tTwjuv6N8JhhbSSzrO3+pXbyCCXlqvt8voL4sPbJsXzr5BUd45Dw8Xj/CP2fM
 /9uhIFNlc1CpJ2sqzCFr3G/pzyHVPXAwcHHti3+eSu+WPgydVdT4rDZzAVechegTo0Bh+1hEd61
 Lpvai2SHgtEHddY2IqRA+Z8g3q0oyofgdHuyO4XMnkRW0AYF25SQTpL9T2zT9/8cNoBrsXJEozZ
 lUw1ltN73jiODshvGbg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_07,2026-08-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 clxscore=1015 bulkscore=0
 phishscore=0 spamscore=0 impostorscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608270136
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

Hi Thomas,

On 27/8/26 14:54, Thomas Huth wrote:
> On 09/10/2023 21.39, Mark Cave-Ayland wrote:
>> On 07/10/2023 08:23, Thomas Huth wrote:
>>
>> (added Natalia who was the GSoC mentor for the NeXT cube work)
>>
>>> The machine is incomplete, and unfortunately the hoped-for improvements
>>> never happened. So it's maybe best if we mark this machine as deprecated
>>> and finally remove it again in case it gets into the way of a code
>>> refactoring or other reasons.
>>>
>>> Signed-off-by: Thomas Huth <huth@tuxfamily.org>
>>> ---
>>>   docs/about/deprecated.rst | 8 ++++++++
>>>   1 file changed, 8 insertions(+)
>>>
>>> diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
>>> index 3b074b9ed4..2f6dadd12f 100644
>>> --- a/docs/about/deprecated.rst
>>> +++ b/docs/about/deprecated.rst
>>> @@ -253,6 +253,14 @@ deprecated; use the new name ``dtb-randomness`` 
>>> instead. The new name
>>>   better reflects the way this property affects all random data within
>>>   the device tree blob, not just the ``kaslr-seed`` node.
>>> +``next-cube`` m68k machine (since 8.2)
>>> +''''''''''''''''''''''''''''''''''''''
>>> +
>>> +The machine never got fully implemented and can only show the 
>>> firmware prompt.
>>> +Given the incomplete state and slow progress on improvements, it 
>>> might get
>>> +removed again without replacement.
>>> +
>>> +
>>>   Backend options
>>>   ---------------
>>
>> I'm torn a bit by this one - on the one hand the NeXT code could do 
>> with some love, but then given that the code already uses qdev/QOM 
>> then there isn't really much in the way of maintenance burden. The 
>> main concern for me at the moment is the use of the old-style memory 
>> accessors that pre-date the memory API.
>>
>> With my latest ESP patches I think it shouldn't be too hard to update 
>> the NeXT DMA controller to get SCSI working, so perhaps we can leave 
>> it for now if it doesn't cause too many problems?
> Almost three years later, the world changed quite a bit. We're getting 
> flooded with AI-generated bug reports now, and of course people are 
> discovering problems in this old and neglected code, e.g.:
> 
>   https://gitlab.com/qemu-project/qemu/-/work_items/4303
>   https://gitlab.com/qemu-project/qemu/-/work_items/4304
>   https://gitlab.com/qemu-project/qemu/-/work_items/4305

Hobbyist motivated machine emulations never committed to be
secure. While I appreciate these bug reports for the overall
quality of the project, I'm taking these one as lowest priority.
I wouldn't even mind of closing them as WONTFIX "Thanks ...".

"code should not be reached" is exactly what we expect in these
cases. We deliberately not implemented those code paths because
the guests we use don't access them. If a real guest is accessing
then I'm sure someone will end implementing the missing parts.
Fuzzer-generated guests are not useful at all for the hobbyist
part of the project.

> 
> I think it does not make sense to keep this incomplete and experimental 
> code around in (upstream) QEMU anymore. If someone wants to complete it, 
> they can do it in their own repo first and resubmit it once it is really 
> working. So unless someone comes up with very good reasons to keep it in 
> the main repository, I'll include the deprecation patch in my next pull 
> request.
> 
>   Thomas
> 
> 


