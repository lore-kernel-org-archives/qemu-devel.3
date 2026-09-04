Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5ADBBC79F82
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 13:09:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2TfA-0002R9-1Y; Fri, 04 Sep 2026 09:09:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x2Tf7-0002Qj-Sg
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 09:08:57 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x2Tf5-0004PR-Tx
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 09:08:57 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 684AI9kR243534
 for <qemu-devel@nongnu.org>; Fri, 4 Sep 2026 13:08:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Ek85zmcUnueEHE9BlIpU0VlBQBbPptk7zmzXB8AFf2s=; b=I+khzlrqnuXbf1x6
 rcLUkdNOHytpc+Yxzt6G4JEa84w1wLvL2BoKs0ELGLUn972NbTIjmlzfUUmoH/n4
 dm/HRyBRLr5fXwKY5R7Yym8wVnP6x4Jbqg+i+Xsjlznx++GuUKkQbCMW4kqv/Eg8
 aPY/FC+mQpPgDQe/auSdYFz41tWNvitUAwTXBv32qhEExrvkNuQqEmDfgOOVTVXS
 smq0Zo1qntYikbqUlSTQBsjXsBlp67T9qoD0x8ZhSsGDfuGC35MfEOPyUQEgMSeG
 fNOkK0a6hUS1bAFo/vdWq8br4LaH4S1Jvgwog2mRrPG9v4tsJ69MNEPadQ0ivBQq
 j/ROtg==
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gfusx0kkj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2026 13:08:53 +0000 (GMT)
Received: by mail-vs1-f72.google.com with SMTP id
 ada2fe7eead31-73883529f72so823503137.3
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2026 06:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788527333; x=1789132133; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Ek85zmcUnueEHE9BlIpU0VlBQBbPptk7zmzXB8AFf2s=;
 b=McUYw1/yRLf1Ccon/LGtVz18dD8WcUEAUe7AongkxIvMaZAOSmX29/+FbyJmld7/yf
 OhjdXp9NcFlOCnkq/jmTZAC+P/xwOVVuGu6ZuS1gR1vSAV/1ueAfyH/BLCDEtkilR9G9
 +JADbYQ9XDH60iqwigRGumPETDTgo0QBkI9ffFi6y065xL/m5ffUbIwVOrJWUBJnN/UM
 vlNt5vPp6XyeDmU6ZzgFQT0C26yP4hpnOiun+TEJUQVCK89WHmyAsnePOKbcDod9PTsK
 XmuaW4iUffnyTHOid+k/5cC9BMGyIFh98L/eXzDdhGQBfeu8mBGWf/KPz/B8Qfx0N9kI
 7BKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788527333; x=1789132133;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Ek85zmcUnueEHE9BlIpU0VlBQBbPptk7zmzXB8AFf2s=;
 b=H+hVzPwuWj8WlbEZ03uF3oBYLabgsaafETZYjyjBGV+kKVut/L/kLychhGFaqp7yD0
 QIrmWqGRakFFnO8uEFWCuQtbvcBmBs1IyDjhhmw8oJ6X+d8CenpuGWdzDx1wu7cT+BVV
 YiimRiOUmZllMcAm9zv/DRDjcKVTelDVqE9hJybbJd6QiEoOPyNtFfL6ztgr9OOCKUt4
 yvIuOor7sa9IZ/nWARTypVieJjKx3iZFrNUFpUUrfh9/Cf1ZHvY2uudK2ZZQOVWAGPnB
 ND/eJqj84VVwoJz4YrR6CzVVhLD+6exBYAOTwXjj0ObAQ98Xe4PlqVUa5UJoFkj5qxdt
 +h6A==
X-Forwarded-Encrypted: i=1;
 AKwUvBwmToqhbnYf7Ict3/awuVC4PkE/q5gLMLpVtvOCiyG2AYTubjFNr4BNzJQ63yzdHDaktMNHQSJgUW0s@nongnu.org
X-Gm-Message-State: AFuF++lb03/o2DdEPZoO4yQ1fimbMSAWACxuA1GNpu0+zWJHRtXB2n6b
 LLywVJkWYIJhL8viZqo7+TNtKpWcY7c3OttNpQNcuceh5kWfNgEPRzu/q5lB90zxuMSQrOAh8o1
 rADxP272G5tQPoVzH0HGih7Pf+X1Sk7AkJrHMftwFkOl4SqYRDKSkV+YYlw==
X-Gm-Gg: AYBFou0Zn0l8GSxWFuKx07uUgd66ShtHkv39FWEkWoHhrjU3sqmFOYvHDOXpvw2UCqo
 hiTo/aJ+zMuB7Q3O7RTC3P1sc9H7Hu88xgeRLA7svWnrtftBMXpLaTtfqCh5gymXuEKkx33db7l
 WX6w0qWQ63mkx9mxpyqCGWntZKDH6BTsP1F1uFToGBh7AbwtIrx3y1kfzgaBU37tHhfvxYj2qO0
 AMUrCyQwEOJd4hUvA5RoRngcRar7q0vGacxeVV52DeG3D0Q/ibxcBqDicBxcMREuNIlk1Nx0XcH
 YwtUqeplRPkBuvVduoKfg/dzcSv9Ryup1F9FKPFlqR4AAu5E++TtNlCTCLISIMoSGKVHIyb3IjI
 1GSWp3SzvRSq1ZsMQsMIIDzo8Qj47+O6CVQ==
X-Received: by 2002:a05:6102:e0d:b0:778:636c:71cb with SMTP id
 ada2fe7eead31-78a4a9c40c1mr2230672137.10.1788527332909; 
 Fri, 04 Sep 2026 06:08:52 -0700 (PDT)
X-Received: by 2002:a05:6102:e0d:b0:778:636c:71cb with SMTP id
 ada2fe7eead31-78a4a9c40c1mr2230655137.10.1788527332368; 
 Fri, 04 Sep 2026 06:08:52 -0700 (PDT)
Received: from [192.168.69.202] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cf7736132sm67521165e9.12.2026.09.04.06.08.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Sep 2026 06:08:51 -0700 (PDT)
Message-ID: <770f90c2-5c31-40a9-92cc-3b7c0dbfbd0f@oss.qualcomm.com>
Date: Fri, 4 Sep 2026 15:08:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/47] single-binary: implement dynamic filtering for QOM
 types
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Yonggang Luo <luoyonggang@gmail.com>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 qemu-devel@nongnu.org, anjo@rev.ng,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
References: <20260828225901.367438-1-pierrick.bouvier@oss.qualcomm.com>
 <4b4f77ee-21e9-405e-a1da-21506afa1c5b@oss.qualcomm.com>
 <app_CnHimOrOymMH@redhat.com>
 <CAE2XoE9A1WzOe43-qd1v9i6K9kSru4R2kEE1-2TrztoM=8NZJw@mail.gmail.com>
 <CAFEAcA_4TZxYhFbHfJZCas7bvh_KZjNp2aKzx3LPaXTQFuoQYQ@mail.gmail.com>
 <apqVhJrtMDECUb7I@redhat.com>
 <CAE2XoE-qNgNXi5fKzjt5qM4pk8hs+x90h4Bv_8OsJczYHW1_Rw@mail.gmail.com>
 <apqZancGjQF7ld97@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <apqZancGjQF7ld97@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA0MDExOCBTYWx0ZWRfX186UGiMeZexW
 xdWVpiTEoOS90BPnP/mzlgka3KsraUbutRUHmPRbEIa4av1NpuTd7Xk/v0VDGacuC1Xm3mA1kl6
 /qACbWBOZ7B2QWdx0Kt8k6J+vE/F5Pc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA0MDExOCBTYWx0ZWRfX/cXxevLhR+HK
 fE3cKGlC+eqHvvAN5rvYe1gbtLyrpqux6QHoiZ8dHSU5ugJyv2JqXG9n28Y9V9sq3vVC8ah3UvL
 mgnG+v/LFfuLQY1H4JmjD2os41CTiVMRz2OAVggfN4gW1eIpAzEGhwkuXGTXur4DdwzETZIVATi
 TdLci6fnGGtztczK8v+/IWxD5QA9q8300z+0SgEEiw8PJ5rYavG9D7Ugy/goJVRTpuWygHT7xRi
 YhfuI/b/EKmySZn7engR6PiMYOtNLsgHc6QUc5qVNwY1Jh2TLq+9vo3NsAF8/Sz0hQ+RL06rKr5
 V+Nc49xBxtDu0Kvllc+2ebFyRYTfN3c/yY6531kaCnrjhDdbXf+2UKLS/Wz+GwzRIPVoi+qJA27
 mlSd6WFjbaXpHlRuNnxunyqpzVOUgyeJO54bth5rABo39ewiNlAaRfpQ/N/8C7ctYAeROfr4eXR
 YBjpybpdtM770Pun79A==
X-Authority-Analysis: v=2.4 cv=NenWEWD4 c=1 sm=1 tr=0 ts=6a9ac2e5 cx=c_pps
 a=DUEm7b3gzWu7BqY5nP7+9g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=20KFwNOVAAAA:8 a=pGLkceISAAAA:8 a=2CVGY7FKgPJ2g3LI8WAA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=-aSRE8QhW-JAV6biHavz:22
X-Proofpoint-GUID: ps0Zh0BlEfUYiomjx_x2oklDXNG4ru1F
X-Proofpoint-ORIG-GUID: ps0Zh0BlEfUYiomjx_x2oklDXNG4ru1F
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-04_03,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 bulkscore=0 clxscore=1015 impostorscore=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609040118
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

On 4/9/26 12:11, Daniel P. BerrangÃ© wrote:
> On Fri, Sep 04, 2026 at 06:04:24PM +0800, Yonggang Luo wrote:
>> On Fri, Sep 4, 2026 at 5:55 PM Daniel P. Berrangé <berrange@redhat.com>
>> wrote:
>>>
>>> On Fri, Sep 04, 2026 at 10:13:04AM +0100, Peter Maydell wrote:
>>>> On Fri, 4 Sept 2026 at 09:58, Yonggang Luo <luoyonggang@gmail.com>
>> wrote:
>>>>> On Fri, Sep 4, 2026 at 4:19 PM Daniel P. Berrangé <berrange@redhat.com>
>> wrote:
>>>>>> I'm still not clear on why we need to filter the devices at all for
>>>>>> a new "qemu-system" binary ?
>>>>>>
>>>>>> Looking at the device delta listed in your other mail, a large
>> number
>>>>>> of those are PCI based. The microblaze machine types don't expose a
>>>>>> PCI controller, so those PCI devices are redundant / won't be used
>>>>>> with microblaze machines, which is why existing
>> qemu-system-microblaze
>>>>>> doesn't link to those devices.
>>>>>>
>>>>>> The same is true of many of the arm machines too though. Only a
>> subset
>>>>>> of arm machines have PCI, but the qemu-system-arm binary still
>> includes
>>>>>> and lists all these PCI devices. Users simply can't create a PCI
>> device
>>>>>> for the arm machines that lack a PCI controller, or they'll receive
>> an
>>>>>> error.
>>>>>>
>>>>>> Why doesn't this approach extend into the future qemu-system binary
>> ?
>>>>>> List everything, and if the user tries to add a device that's not
>>>>>> compatible with a machine, then it will simply result in an error.
>>>>>
>>>>> Device filtering would be complicated, I guess, as there is so much
>> CONFIG_* for devices. Another approach is to just place devices under an
>> meson "enable_modules "  (in *.so/*.dll/*.dylib), so it won't be
>> listed(memory consumption will also be reduced when it's not needed).
>>>>>
>>>>> But machine listings still need the filtering, considering virt is
>> present for many different arches(riscv/arm/i686). so machine listing is
>> still a thing.
>>>>
>>>> I was wondering if maybe one way to approach that is some
>>>> "disambiguation" syntax on the machine name; so one could write
>>>> "-machine aarch64:virt" vs "-machine riscv64:virt" (or whatever) to
>>>> disambiguate when just "-machine virt" would be ambiguous; but if
>>>> there's only one machine of that name then just "-machine foo" would
>>>> work.
>>>
>>> Currently the QOM type name is directly derived from the machine
>>> type name, just with a "-machine" suffix attached. So if the
>>> machine name is not unique, then neither is the QOM type name.
>>>
>>> At the very least we need the QOM type name to be unique. We
>>> could de-couple the two to make this work though, which does
>>> not seem too hard.
>>
>> I have did that, for example:
>>   hw/riscv/virt.c         | 3 ++-
>>   include/hw/riscv/virt.h | 2 +-
>>   2 files changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
>> index dd396410178..5e57f9443c2 100644
>> --- a/hw/riscv/virt.c
>> +++ b/hw/riscv/virt.c
>> @@ -1739,6 +1739,7 @@ static void virt_machine_class_init(ObjectClass *oc,
>> const void *data)
>>       HotplugHandlerClass *hc = HOTPLUG_HANDLER_CLASS(oc);
>>
>>       mc->desc = "RISC-V VirtIO board";
>> +    machine_class_set_name(mc, "virt");
>>       mc->init = virt_machine_init;
>>       mc->max_cpus = VIRT_CPUS_MAX;
>>       mc->default_cpu_type = TYPE_RISCV_CPU_BASE;
>> @@ -1802,7 +1803,7 @@ static void virt_machine_class_init(ObjectClass *oc,
>> const void *data)
>>   }
>>
>>   static const TypeInfo virt_machine_typeinfo = {
>> -    .name       = MACHINE_TYPE_NAME("virt"),
>> +    .name       = TYPE_RISCV_VIRT_MACHINE,
>>       .parent     = TYPE_MACHINE,
>>       .class_init = virt_machine_class_init,
>>       .instance_init = virt_machine_instance_init,
>> diff --git a/include/hw/riscv/virt.h b/include/hw/riscv/virt.h
>> index 7c862b0da25..9f96dd98c6a 100644
>> --- a/include/hw/riscv/virt.h
>> +++ b/include/hw/riscv/virt.h
>> @@ -30,7 +30,7 @@
>>   #define VIRT_SOCKETS_MAX_BITS          2
>>   #define VIRT_SOCKETS_MAX               (1 << VIRT_SOCKETS_MAX_BITS)
>>
>> -#define TYPE_RISCV_VIRT_MACHINE MACHINE_TYPE_NAME("virt")
>> +#define TYPE_RISCV_VIRT_MACHINE MACHINE_TYPE_NAME("riscv-virt")
>>   typedef struct RISCVVirtState RISCVVirtState;
>>   DECLARE_INSTANCE_CHECKER(RISCVVirtState, RISCV_VIRT_MACHINE,
>>                            TYPE_RISCV_VIRT_MACHINE)
>>
>>
>> Maybe we have a better way for it?
>>
>> For device conflict, that needs to be detected after the qemu-system is
>> present.
> 
> Our existing qom-test should already be validate that in fact, if we
> run them against the qemu-system binary, aas it'll start
> 'qemu-system -machine none' and list all QOM types & properties,
> at least for the targets & associated devices that we have converted
> to work with 'qemu-system'. Best coverage would require all targets
> to be converted but we don't have to get there straightaway.

I feel the whole series discussion derailed. Can we start a new design
thread to clarify what people want? Apparently we don't refer to the
same understanding of what "qemu-system" binary is or aim for.

