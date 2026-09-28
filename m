Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA0A7C9833F
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2026 11:30:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xB9YA-0005bo-QL; Mon, 28 Sep 2026 07:29:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xB9Y7-0005bT-A3
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 07:29:35 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xB9Y5-0001gQ-F9
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 07:29:35 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68SBAB7H1189373
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 11:29:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 pcls9M/RCzy+dy0SUVG2YEjqVeTGh254G4S8Py8gGec=; b=jlhFArqLwsLAEYsN
 s+r+yj0woskk839hHrPFxHO+Qbiy2QMkskMPM1vI9juVV+IIXnPITqMfOZD19ROi
 ApoJZVo9i5X+UcqQqdz8W0rcq1EwriJFSVHN5ug3j7VBO8B4nFFrrqHl6Ou7xH2s
 q27y/yw6VSDuJfQfFtblta2AQR77f/kWNq4GkGNuyUwhyD/k+GedXwHK2nBHkWY/
 m1rm0V3aAliNLBQCr0FHPa8yywAuz79AhoE0+4nbreEB0HjJvRHOyMRpS+9sWWYH
 wyCMNEUvjC54WpFzcoGN7T4THjDaMIMgAWWin96lZr/i1l3S6BgD2egQP3Gy8oXP
 E3Pf6g==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gynbc0fwe-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 11:29:30 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93a08ff8451so520410585a.2
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 04:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790594970; x=1791199770; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=pcls9M/RCzy+dy0SUVG2YEjqVeTGh254G4S8Py8gGec=;
 b=OMWC2Fl9/Z4f+xlmz7gGFdW9g2dUFpH8stlKudf0Mh7Jf6neewu7TCfvEYwXyJff5v
 wrefCfd/5y+S7Iuqsq2tbzUUiPAvwxAoIjjkFKZ8arJg/Qfqq+IZhVRsjmDipH0YcLLY
 NWcApWirZ0q1RwdYB3lKmPq8eA3vIbfOo7j10ZYi6huWJeMGDGP26Lr9OCYn217F7QOq
 ttb4vcy4vm0oSBOX81IvWfFX1PBpo8m6l8pUCLmIDmopUyVMsJqpY71LLiOctKaaBlRu
 +EJZ5jFIRsJhTiSf7epeN029rosvXOeNyPD7hFZX1Yl2astAtFl+uj+Tkun5l4uH9Rwo
 fuzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790594970; x=1791199770;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=pcls9M/RCzy+dy0SUVG2YEjqVeTGh254G4S8Py8gGec=;
 b=G4/U2LsvQgfcs0iLUuqxZRDBSdHXRhNJ9dTbbJT55++Rvvaro9pGvrjZmXHZiFqmKE
 fpbaeiCYvLrdfDQ7NUCsaB3aTKpHwk8+CoYM76TTsbjMxK1+0921ynSnUD/bcbZ7VdIW
 9Rk++3oh87Ltntng1bJNNf22kke5/Yc9mT0F6OafREtR4tKVgUTObJYI985Y9xUuOl50
 j/qhIKQc/XOZc+mDGK86ePcgGxnbHrviSt0HkB0va+rP9ziq7KUzpTt1awt5zc495COI
 aBdC9joBbTZQUxI/cOVu7MmLIEmEncBv0VDQob/ItJp8PupIUliUeFfOiFa1jx/KBRtF
 WmxQ==
X-Gm-Message-State: AFuF++m0RO2UvEXgbWBVVBvhltMck9AZZDwNZW9WnSyY1eQdTui9L573
 H3ttFnphTj9jJkdD1lxhgjFNBUpNLw8KjR1ClsVCua9TlzFV0KrWTpcYNgVWUF6vIfSAbfsYwTl
 HyVaUd6B24jgtD4yHXXNA9+HePx5mqUrEi503uZWDWoei3Kt3jHHO0tX+ww==
X-Gm-Gg: AYBFou2t8R1adgVOa2fVVZLQuta+UO79u74gY6+VF3pobffiogyb0fdYeSdpP40QHhf
 rR68SnhcJz+Q5Xbmk7ri9O3qw2+/0sA/ezkPLd90ZWc0Sjkp/Xve2KDQVv66EyD6oYC4bYVAQ0a
 LLF2YS9XqoakJHCZjvyx6NtumCpAXVPIRTybYXcUnI5ELBxNjh7WHbtLju/m+IZhEku7HXnUNFC
 357GZuFPwNfC0ubus6/jgGbFCIhlOCXOOtNbMaMvhco/MKKGDbSHVv+LkqsbsMo+Gm+plvmPnEZ
 S2xGCTB5N0QmYeeWE4AroA3H1CP+r8ae3T2zXbYn3m5u9XRdeJJcmkF6JybjPmjt6WsOmZXPkI8
 cYBMtKeXCMNC7eR3mt/Ly3DkaDqh7xXrGAg==
X-Received: by 2002:a05:620a:170e:b0:939:5ae7:2dad with SMTP id
 af79cd13be357-93c43c9fcddmr2067539485a.38.1790594969664; 
 Mon, 28 Sep 2026 04:29:29 -0700 (PDT)
X-Received: by 2002:a05:620a:170e:b0:939:5ae7:2dad with SMTP id
 af79cd13be357-93c43c9fcddmr2067529985a.38.1790594968934; 
 Mon, 28 Sep 2026 04:29:28 -0700 (PDT)
Received: from [192.168.69.225] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49ff141948esm5976215e9.1.2026.09.28.04.29.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Sep 2026 04:29:28 -0700 (PDT)
Message-ID: <4da49cb4-6044-418e-b003-81c4ec6d6ed6@oss.qualcomm.com>
Date: Mon, 28 Sep 2026 13:29:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 46/55] qapi: add query-targets
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Yonggang Luo <luoyonggang@gmail.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-arm@nongnu.org, kvm@vger.kernel.org, Thomas Huth <thuth@redhat.com>
References: <20260926070057.1234-1-luoyonggang@gmail.com>
 <20260926070057.1234-47-luoyonggang@gmail.com> <aro93NuZBXYGbD33@redhat.com>
 <87e7c5ae-c78c-4a47-b9ba-9851ce5757d9@oss.qualcomm.com>
 <CAE2XoE9qsZZ+AnfGQ797SQj5yXP8SDOZyxYoKP=oh57UPFqq0Q@mail.gmail.com>
 <arpH_2anGV-JU12e@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <arpH_2anGV-JU12e@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Sq4Fe/O0 c=1 sm=1 tr=0 ts=6aba4f9a cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8 a=GQHC_H0yiGy-f9nngS8A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-GUID: HMv8ExLApi2GxqJpb62ljc6kxcHwisfb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDA0NSBTYWx0ZWRfXxxa3tIxBy5wb
 S70tMoi7DO6xRDSiAOYSbhf7x+FUMOIFpj6l/78TSgmESBXx5nNWdYsSe4wQKcyzheYcSCkaDT+
 zx03MtelGt45rrKQ+/Ze7azTceu7afh66rlICqkD34WYG2WxE0tAjihVHPrqdqeUczVE9PObD61
 wb/KqTU2lWRFsWffpWDpcZZDtJV9zj7/KBoK9YkE3g3vlDHV1Fa6DHgpsXfUUj4Ou9k8CsjtmHT
 WEWrjR7Rq7BAaviYhgBNeyfhDVfPyYr5xghg1UE1cetZAVstR4LxrVZZXHsE/5SwD/4IOODhTjV
 TYkzFUVkFXzyW+FBLNfJMtGzcjMjpB53G7k1BlcKvCZCIAPejjyNHJb5IlgfeCva0f6gXYI3vK0
 zG4uRi2VnGiQXK9ibmXsDDC0/d6kX82L4nJDaw+Bpe8CimqDHbkns5SC0usr9WUboEIPjXirk0r
 U3b/pIxr1WFUHWNmSmQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDA0NSBTYWx0ZWRfX1OqSZ1JYI0av
 Kot4hfwropgm2aHnoRilfCDIOukpM5nmjS1YXAX2k+HQsBVqmUnJdlYtgqu5tUdsFVdCVeEQnEl
 fFIA3FUuR2HwkRbrXIQ+lZbUKQSxmmY=
X-Proofpoint-ORIG-GUID: HMv8ExLApi2GxqJpb62ljc6kxcHwisfb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-28_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 priorityscore=1501 bulkscore=0 malwarescore=0
 adultscore=0 phishscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609280045
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 28/9/26 12:57, Daniel P. BerrangÃ© wrote:
> On Mon, Sep 28, 2026 at 06:51:41PM +0800, Yonggang Luo wrote:
>> On Mon, Sep 28, 2026 at 6:39 PM Philippe Mathieu-Daudé <
>> philmd@oss.qualcomm.com> wrote:
>>>
>>> On 28/9/26 12:13, Daniel P. BerrangÃ© wrote:
>>>> On Sat, Sep 26, 2026 at 03:00:45PM +0800, Yonggang Luo wrote:
>>>>> query-targets lists each linked target, including none, with its
>>>>> arch, endianness, and the machines that target accepts.
>>>>>
>>>>> Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
>>>>> ---
>>>>>    hw/core/machine-qmp-cmds.c | 30 ++++++++++++++++++++++++++++++
>>>>>    qapi/machine.json          | 35 +++++++++++++++++++++++++++++++++++
>>>>>    2 files changed, 65 insertions(+)
>>>>
>>>>
>>>>> diff --git a/qapi/machine.json b/qapi/machine.json
>>>>> index 6aaa2af709a..d8cdea6203e 100644
>>>>> --- a/qapi/machine.json
>>>>> +++ b/qapi/machine.json
>>>>> @@ -307,6 +307,41 @@
>>>>>    ##
>>>>>    { 'command': 'query-target', 'returns': 'QemuTargetInfo' }
>>>>>
>>>>> +##
>>>>> +# @TargetMachines:
>>>>> +#
>>>>> +# One registered system target and the machines that can run on it.
>>>>> +#
>>>>> +# @arch: the target architecture
>>>>> +#
>>>>> +# @endianness: the target endianness
>>>>> +#
>>>>> +# @machines: machine type names, not aliases
>>>>> +#
>>>>> +# Since: 11.2
>>>>> +##
>>>>> +{ 'struct': 'TargetMachines',
>>>>> +  'data': { 'arch': 'SysEmuTarget',
>>>>> +            'endianness': 'EndianMode',
>>>>> +            'machines': ['str'] } }
>>>>
>>>> We already have  'QemuTargetInfo' struct which is used
>>>> with 'query-target', that should also be used with the
>>>> new 'query-targets' command.
>>>>
>>>> We need to add the 'endianness' field to QemuTargetInfo.
>>>
>>> Why do we want to expose endianness, and what endianness to
>>> expose? Endianness is a runtime bit state of CPUs. Sometime
>>> this bit is hardwired but that is an implementation detail.
>>
>> For some targets it's, but for some targets it's not. for example
>>
>> mips-softmmu.mak
>> mipsel-softmmu.mak
>> mips64el-softmmu.mak
>> mips64-softmmu.mak
>>
>>
>> mips64el-softmmu.mak
>> mips64-softmmu.mak
>> only differ the endianless
> 
> "EndianMode" is a tri-state including 'unspecified' as a value,
> so we can cope with both scenarios - the targets where endianness
> is runtime switchable in the CPU can use 'unspecified' as the
> EndianMode. That behaviour should be documented in the QAPI
> docs for QemuTargetInfo

OK but still I don't understand the usefulness of exposing that
at the machine level, since this is a CPU property.

Machine != QEMU binary.

Are you trying to expose binary properties to management layer?
Can you explain the use case?

