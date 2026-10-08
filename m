Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9A4CCA6011
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2026 18:34:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEswg-0003hx-Qy; Thu, 08 Oct 2026 14:34:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xEswZ-0003hO-9N
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 14:34:15 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xEswW-00041d-W6
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 14:34:15 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 698HqQ6Z2975852
 for <qemu-devel@nongnu.org>; Thu, 8 Oct 2026 18:34:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 I6RQDVToS6uGgYxhYq5AKIb8KaX7tucdYOEL6FCsKA4=; b=dIoLKXrJ5pBgnYhL
 UCCq+Sq0N4ET5725740KZe1jnSr1F0Rj1MFbGZLspy5EW4b5JuvpJxLjjHz2wfW9
 McqSMp39gazLaN1nX3LthkGqny2jMm4XC8Tp1fpbEWET9lrmtaiu6dpIihn3mqH6
 /S1FFNxTWjJVz+jAGThn5TwLqAzTKixDSeybgXOtwhS8SYDXDA0Gw9V+mfpPMijy
 Ig105gtvySGMyACRqrorDhcHQYFbJ9X5gq9HfubwnaqnL+RCGtNU+LXJniQSHG8Z
 MDJgCuZYxWiarDNrGZX6kKCi/+XOuDIi77/0z4vwH5S7M2WKXFmKOqvG9oulK71q
 uW3inQ==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h6fxrr5xh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 08 Oct 2026 18:34:10 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-cd0cf3b1c70so1825779a12.3
 for <qemu-devel@nongnu.org>; Thu, 08 Oct 2026 11:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791484450; x=1792089250; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=I6RQDVToS6uGgYxhYq5AKIb8KaX7tucdYOEL6FCsKA4=;
 b=chiwQVDEwQfWtHW62kRKRqFgJAfP2Qx6f8CmFmu485tnOxF9dB/2rKqwPMMTsg6K02
 wXBFFx8E7kVspN0KdgVGb8Wknn1DkqxA9ieJ8clORk+jc5U7gmz62Zp01KLuGLT4Uvfa
 B/8O82BOm+UkrJWXFAiuLDch/NPC1iKizkXUsQAYpgmRKwz6RVJcLGtpNyDo4dng+6TN
 KgUVTj38vvDWBiS2D6837gmwVUWq22+SsHXkjDO/1YZ8/3YKhz81nqgzP77qE+1LGMmf
 wPA6wtMoJZ3YtmwnVjJFAbWHvNusfEpZXF6XUWYPlzHQwKgZk1kSTNIjeP+mD2nElmsz
 ls9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791484450; x=1792089250;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=I6RQDVToS6uGgYxhYq5AKIb8KaX7tucdYOEL6FCsKA4=;
 b=KQkYDPNvPFF4xh5AE5MA+Bim4gO1oOciRwyjepIUgwsj+kzp4ncBAR3N+Ylzy8D6My
 NIiaxDtWcJsoSVWvtIiwYQDVaRcr3bwTVOwD1D+faNm6j9WR1IWnFnBdZkuvNg/JY6LM
 XKEt6qYbi4MBfO5ygO93XmXvDwRWlgpz0fJaDANked5iKfirnnCn2OvArBM+wQxPk5e8
 1cSe3/XqhhHtUFyJngLlPh/iMzaNvj2X3hCU4uyz23an/0EviGzEtbFxsEWNN0ZEapWf
 u5ZE0Mv93qVZAIQkv1Knb/vBP6r6DZ36i5Fr+Rtv4JVVeZIRUeCwdLh59wC2A08LyH1x
 RvCg==
X-Forwarded-Encrypted: i=1;
 AKwUvBw8qPNlfCviVx2G7aplnOGMzqpu8BO6DW0KFNDaDC7kxur80ztZP5WQloHzxXHevff4ZPGkyt03mV0t@nongnu.org
X-Gm-Message-State: AFuF++m6C1kwzJBWGwW8ysjyZh8bL5dfzu1Di3aPzehBe29ZDGv5jvRq
 IJuOsKaW5WiUc2TDMJ2U/ql20EKEa2bsL7QeHhBYKmEcxKWDIl7pOoFn6pqeRWB2cuM7C9xVRCu
 YBrinh8kHM7TXxm+/i82+h3Qej9pKTc3ON12dgKONtpFLc8nQvtVAbJkShw==
X-Gm-Gg: AYBFou1p79k53isThzLZixHuDIXzgq/0NQ9dxSPu7hNqQHCTxVtPc5vC/orXsHqqMYt
 dnsAO7P0NUKoHABRBh4WHet1O0HY5G1D1y07yjuY4JPLy1pSB4Ny7DkY0iMokJQFxrz8srUYZ1R
 y/JXnPk6n+ESydLXVByNK5b9siZBqgRtf5g/YInqH+DOBV+he7tFFcNEg5pRTWBhcmX1NuCasfv
 KBTsTxoZBjAxwWYq4eV6A63YaXiUoYku7FATebX1CPRTp3HdRG2R5N2cWJFs/J6opyV0WVu/iwo
 2cS5Yqkp5ELx1oH8Gm7J2gbR8KSdZVJuV4cIqRPRdEvAVvam84abspk3Wo4DXKnD2IaTnio4fMq
 A9QhhZAemxn5dDKR2iwJ6kEGnfmEtKD/zSzqouVc7/5qRqFioeSRKhL8A8y3oPldQfmSAjA==
X-Received: by 2002:a05:6a21:489:b0:3dd:a195:fa12 with SMTP id
 adf61e73a8af0-3e1340ec207mr5317406637.55.1791484449748; 
 Thu, 08 Oct 2026 11:34:09 -0700 (PDT)
X-Received: by 2002:a05:6a21:489:b0:3dd:a195:fa12 with SMTP id
 adf61e73a8af0-3e1340ec207mr5317400637.55.1791484449240; 
 Thu, 08 Oct 2026 11:34:09 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cd3a5082926sm223288a12.2.2026.10.08.11.34.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Oct 2026 11:34:08 -0700 (PDT)
Message-ID: <3034c146-0697-4db7-acd4-8076b317a09e@oss.qualcomm.com>
Date: Thu, 8 Oct 2026 11:34:07 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/8] qom: pass TargetInfo to the is_available callback
To: luoyonggang@gmail.com
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, Cleber Rosa <crosa@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@kaod.org>,
 Laurent Vivier <lvivier@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 John Snow <jsnow@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 Joel Stanley <joel@jms.id.au>, Fabiano Rosas <farosas@suse.de>,
 Kane Chen <kane_chen@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Troy Lee <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>,
 Stafford Horne <shorne@gmail.com>, qemu-arm@nongnu.org,
 Philippe Mathieu-Daude <philmd@mailo.com>,
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@oss.qualcomm.com>, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@redhat.com>, Steven Lee <steven_lee@aspeedtech.com>,
 Alexander Bulekov <alxndr@bu.edu>, Darren Kenny <darren.kenny@oracle.com>
References: <20261007115253.328-1-luoyonggang@gmail.com>
 <2390b3d7-6918-41e3-8532-c19de4cdd1ff@oss.qualcomm.com>
 <asdlbOZBSYIaCMIh@redhat.com>
 <CAE2XoE91XxoJRFpQ_1jhmX6LdxMyN16CF7RXxM62C5Ctkc1tig@mail.gmail.com>
 <42fd67c0-c20d-4bc4-bede-79073e4be4a1@oss.qualcomm.com>
 <CAE2XoE-gN5-vmE8r00Ds_Z=E1WePSFi_MJXjmy9ZuXEU_=o31g@mail.gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <CAE2XoE-gN5-vmE8r00Ds_Z=E1WePSFi_MJXjmy9ZuXEU_=o31g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=E+1YNqdl c=1 sm=1 tr=0 ts=6ac7e222 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=YVV9U6z2R0o8oJsJggoA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-GUID: n0BEGVl1lFXyKm_57wVU_u3F0RQAn1ln
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA4MDA3MyBTYWx0ZWRfX0XAr2Ftgf2Cp
 Jn3kwLokc0yY22OLsHXyhYi11JQYK9mYdox0fZMZivABP4JeLVZy9m480ka6CdDK0cUWh2yuT1Y
 pZoAMxOYDjnTk4Xxa6diOvoqiejGIs32p1YzBasQRfAUk94kH/61sm9oF9dCY1FY+0Jprmo7yRF
 fA5TP6fXykO+SFxo5F/KhOSPkBC3D38En1E8C9Mv7SWCnzC1tXFqHNvUjXTBNHsSdyH59VJuT6s
 nfJmdGNPUp1Il8zPX8uKoKgUdWSTdBBVGuprZiOr4MW66pZseZ9J6Om01XngGSvSuTaLEw3THPO
 2pDj9BlepGqzcWUek4FTbvA3xlnLcdBfXUjzxx6XVmevEDTiY5jQgwSdu4wQIahdlHeKwGMjWSD
 pTrpfDOcs+dUQLFfyB3yJq6himpXzmt/3yS/vYveRFGYAZwzqjQYD7+3KFGYhfo2IeygC/4Su0e
 B1gs2pNgW5PE6aonG0Q==
X-Proofpoint-ORIG-GUID: n0BEGVl1lFXyKm_57wVU_u3F0RQAn1ln
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA4MDA3MyBTYWx0ZWRfX2zJQMWI1iw67
 MH6d98tP+TOP4g4UxY2AzcOraVkp4ed7KCokXnbHzSwrQTbWkBCZ3ODJEzcl7b94Z+2/mHBvAJt
 28kFg+oHfAc4lmlAKLqTYxPFoYbHfL0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-08_06,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 suspectscore=0 malwarescore=0 spamscore=0
 phishscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610080073
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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

On 10/8/2026 10:13 AM, Yonggang Luo wrote:
> On Fri, Oct 9, 2026 at 12:06 AM Pierrick Bouvier
> <pierrick.bouvier@oss.qualcomm.com> wrote:
>>
>> On 10/8/2026 2:46 AM, Yonggang Luo wrote:
>>> On Thu, Oct 8, 2026 at 5:42 PM Daniel P. Berrangé <berrange@redhat.com> wrote:
>>>>
>>>> On Wed, Oct 07, 2026 at 01:25:46PM -0700, Pierrick Bouvier wrote:
>>>>> On 10/7/2026 4:47 AM, Yonggang Luo wrote:
>>>>>> This allows a combined binary to register machine types from all its targets.
>>>>>> Consequently, QMP `query-machines` can return machine entries from every
>>>>>> target, even when `none` is selected. For example, a client can query the
>>>>>> combined machine list with:
>>>>>>
>>>>>> ```json
>>>>>> { "execute": "query-machines" }
>>>>>> ```
>>>>>>
>>>>>> The returned list includes the registered machine classes from all linked
>>>>>> targets. This is separate from selecting a machine: with `-target none`,
>>>>>> `-M virt` reports the targets that provide `virt` instead of choosing one
>>>>>> arbitrarily:
>>>>>>
>>>>>> ```text
>>>>>> qemu-system -target none -M virt
>>>>>> unsupported machine type: "virt" for target "none"
>>>>>> Available for targets:
>>>>>>   aarch64
>>>>>>   arm
>>>>>> ```
>>>>>>
>>>>>
>>>>> From the long conversation on a previous thread, I thought we reached
>>>>> the conclusion that if we didn't expose any ambiguous name, then -target
>>>>> option is unnecessary, or maybe I got lost on track of this thread.
>>>>>
>>>>> https://lore.kernel.org/qemu-devel/ar_coT44h5-zJPVV@redhat.com/
>>>>>
>>>>> I'm not sure which semantic we want to have with -target none. If there
>>>>> is no ambiguous name registered, we just don't need it at all. It's a
>>>>> win-win IMHO.
>>>>
>>>> Yes, if we expose unique names for every machine, then -target is then
>>>> redundant.
>>>
>>> so how to diff riscv32-virt and risv64-virt? oh so for this machine we
>>> needs two name?
>>> "virt" needs register twice for it? or register only a single time,
>>> but we prefix the target_name()
>>> automatically? for example machine::name === "virt", but we can use
>>> "riscv32-virt" "risv64-virt" to reach it?
>>>
>>
>> Yes, ideally we should have different variant of virt for 32/64 bit.
>> Same goes for cpu max types.
>>
>> QOM type is always registered unambiguously ("$arch-virt"). Then, for
>> the "alias" name, which is virt, in case multiple matches are found,
>> command line can return an error with list of unambiguous names to call it.
>>
>> $ qemu-system -M virt
>> Multiple virt machines are available. Please choose one of them:
>> - aarch64-virt
>> - riscv64-virt
>>
>> There is no "parsing" of the argument, it's just the real QOM type. Then
>> we can find which target it implements from mc->targets.
>> And then, we can automatically choose which cpus should be available
>> based on that, thanks to cpu->targets.
>>
>> For existing binaries, nothing change.
> 
> Good, I think we found a clean way now, is_available should be
> removed, and TypeInfo::targets and TypeImpl::targets should be added.

It goes into MachineClass only for now.

> I think
> for "virt" we can add a shared hw/machine-virt.c instead, and forwarding to
> the $arch specific virt. so that we only have a single "virt" registered.
> And it's
> targets is
> QEMU_ARCH_I386 |
> QEMU_ARCH_ARM |
> QEMU_ARCH_RISCV |
> QEMU_ARCH_LOONGARCH |
> QEMU_ARCH_M68K |
> QEMU_ARCH_OR1K |
> QEMU_ARCH_XTENSA |
> QEMU_ARCH_HEXAGON
> 
> So that we won't have a list of conflict QOM names for "virt" machines.
> As now we indeed have only a single "virt" machine that redirects to
> different targets.
>

The idea looks appealing, but I don't think it solves the problem to
have multiple virt variants available at the same time.

The "alias" idea you introduced before is good, we just need to add a
check if an alias is really unique, else return an error, as explained
previously.

If "-M aarch64-virt" works for both the new and existing binary, and -M
virt only for existing binaries (and ambiguous for new one), I think
that's a safe approach.

> 
> For other types also conflict can be handled in the same way, such as
> "-cpu host" "-cpu max"
> maybe others, but I think they all have the same way to deal with.
> 
> 
> That's why  TypeInfo::targets and TypeImpl::targets better than sole
> Machine::targets
>

One step at a time.
Let's keep focused on declaring targets for a single machine first.
Then we can iterate to solve the "virt" problem.
Then convert all the existing machines and add a check in machine-target.c
Then, and only then, we can see what happens with cpus.

Regards,
Pierrick

