Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C4E7CA9EC5
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2026 07:12:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGACO-0001ZZ-At; Mon, 12 Oct 2026 03:11:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xGACL-0001YR-PX
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 03:11:49 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xGACJ-0000Y4-8b
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 03:11:49 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69C55qfU303021
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2026 07:11:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 5l10d9x9fvzddju+W7LPcPBGIAylYTIZpW+rF3OMxmQ=; b=jFPBY1HjFeJhH2g7
 d+vFst+ew6b3Tc1lfp5VyTfA1MBeorwUiQNo9Bb/JngQU+ess9TMF942CuGvidIG
 RkzUbvAUQ8eNqBUEluGZ7KBS0RpvlaW2ULfsxg9B3yG5EshoNwJZ32eiBZzVd6Pv
 8amEUHWwD0U6ZjeVMd1i456g3aJ2EkvG+PNSnxu/4yuJBYLvRbgrjSUF7LzcD/HD
 dRc2LKkqzbnrNSeqRCTC/8FIiZuod5gDbe5yloRZrnihrKRW8/gr9a3uZ5CtDUw3
 T8L44wAnW2pLnxnjiaYSIFaFYPe5Me5peoeF2MRiLkQkqmAbCEnnJnFG1xszMNHo
 D0LXbg==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h8j6dhg7v-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2026 07:11:45 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-3a6d30f66c9so2264789a91.0
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2026 00:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791789104; x=1792393904; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=5l10d9x9fvzddju+W7LPcPBGIAylYTIZpW+rF3OMxmQ=;
 b=I1ZPqGrArViqeJdIbo53Y28nAnRXlTRxteguN/M4r42hs4Kmh+Aawl6hyOsra5LPhh
 wvo5OiwxY43FiXEg3Of9q5tki/G6X5T1Q483d1rCerGJqGw8rc/zICZes2+Etm5hra+F
 7O99Fu8cMEjR8/Ucx2ziiBNrHk6vmbQgavTqxYBtezfYGyLv+XrUH/MSE+ppwf4SrxaF
 tP+8YIzuhq3aZr9S7/nZviK3D5ufOtDRlGuBYcfgfLUqbefembYNuKe38gz09jFD7ieq
 /SXg2uVb8a4U/PxY9+gTh9T34ZbfrOb9UYi7SJCA69xMiY2v9/nuBwK5skq7PU/971lx
 Fyew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791789104; x=1792393904;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5l10d9x9fvzddju+W7LPcPBGIAylYTIZpW+rF3OMxmQ=;
 b=tPco1zOOqt9bd1gqXgwCI4C+/YwZzGHKIZqpeS8NianN8EruKYtxCI1qdRlNcH2D4Z
 iegyw4Yk8o6H1eJ3cHQF4MbhtcfqvS8SZEIsVSwZ7VBemRSdPuODhMClAN51o79UA+w0
 mxx6gsmPADUmVsOHu6/hyjC7wP5Tj5jUByGoMUcQWIF9B53o/fnOh/Y5uw2sPHh2PBI1
 1qD0qXOHK4Z46aKzS2sUdztOYY8SPxbwe3pNgTPcAu1qwc11PatC1uGsi7x4IaMM+xHm
 GeQgVs5vYR2RzAJ1/qrrAeSDpNuMILFXBM9ixn1/ZsLwe23UbfzGGy0G9XH+vYjcrBHn
 b/Pw==
X-Forwarded-Encrypted: i=1;
 AKwUvByr5EHuv2SZArDHwbd3XiYx+owQsmRaIv8Ur9tMn5Cu6YVr+dy9SJt7MGWrCpp135lunXJ1IT5DIsnw@nongnu.org
X-Gm-Message-State: AFq9FYJro6FXNZE6SPXtF7TNA8lLwzV5fazna/dRaaDsAtpwZxtMf6tb
 WaxIs9wljZguP8OrD7VYbAYq+lVZ+/Bx5dgYE1ati487OCKLCyy75A6O6kzL7X+cfcCJfEyTkWs
 1F4MeVdWIEWhuauMvyd/z3MToTvE8xXeIjXH7MNcLooBPmbS7U0nz92/gCA==
X-Gm-Gg: AYBFou28mXDGALFpq6lkdokHgTHT7L/3s4rYZnlkq0ZyjuelK23ErFD9+alS4TOcmHI
 sMD8/VA7MLncyYgEuNY+7Nnv6/RwKoj415d809YQCwWP1M2fTK01OVw34EKRxfrf1hiCElmFYJH
 OgRWjPJw7bd7Bm5SIN/97eC4qFkQP9G4Ln41cWZI8A3EAiXWgAXPlF47E1X5fb8cJDLLfcqiXkl
 kPJJzXSeC9mC8lxV9h3PXkLPJlLOQtzqVkKPcCNxXuz9a56Ma/1Mh9zUpVFACnBZ3S4lwNFRLQA
 YCUFg9sO3UMsmxabF+Y42fghAarg0RZOQWtLO+9UMHOmZ/w3uDVv7OlLBomQ3fbh6GxC1+QlOeB
 dsMwZr81zOElOoUd0rGwl3MRBbYiXAu2UDpn++flsSyLC6vaxoQJxhiwm
X-Received: by 2002:a17:90a:d44d:b0:3a2:bb9f:f87d with SMTP id
 98e67ed59e1d1-3ab3a9f2d87mr5014188a91.21.1791789104295; 
 Mon, 12 Oct 2026 00:11:44 -0700 (PDT)
X-Received: by 2002:a17:90a:d44d:b0:3a2:bb9f:f87d with SMTP id
 98e67ed59e1d1-3ab3a9f2d87mr5014152a91.21.1791789103638; 
 Mon, 12 Oct 2026 00:11:43 -0700 (PDT)
Received: from [192.168.1.169] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ac05cac83bsm2658825a91.10.2026.10.12.00.11.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Oct 2026 00:11:43 -0700 (PDT)
Message-ID: <c4340255-ee0f-406c-b200-4347f9ef4ebe@oss.qualcomm.com>
Date: Mon, 12 Oct 2026 00:11:41 -0700
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
 <3034c146-0697-4db7-acd4-8076b317a09e@oss.qualcomm.com>
 <CAE2XoE-gCTrpEeCROz9JMpPnTQXQ+AnBTR4RwdQhYizkExjK9w@mail.gmail.com>
 <8cb24445-b659-4bd4-9497-888ce152e82d@oss.qualcomm.com>
 <1a477877-516a-41b8-8548-598bfad74f25@oss.qualcomm.com>
 <CAE2XoE_MotPuxBBkLFWmcDf6ACva2r7y-7sRbQ3DNNwZvXcJFQ@mail.gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <CAE2XoE_MotPuxBBkLFWmcDf6ACva2r7y-7sRbQ3DNNwZvXcJFQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDAyOCBTYWx0ZWRfX/r+yzEu46dpH
 DwVH2iGRBjcZOo7YuzQIpw5QADeSWkPPjyUImrOW+Z+drYQlgTFIkRG9V6R1OegP6XcuEHp3V9W
 u/FWdn13OlQX73+28f92wAMrkR4exLZpsUYnwsAwW9jzau8Lr2wbxsTfMS8UiVOAl1zwuCf3sqA
 VyuWNOXwGGJxRyLwWL6Z21nTiJSL+ANQkl2dC59UYR50z/Pi+hqWmvN6n83FYZBx8hzG964hhh2
 7BOcM/pUJ2RcAgVe2K8jWhr8qsxQiuLVvWHUppGsdoCNMs4/FOx157hqSl5vJqKcl3u82AJ/PO6
 q0ZQaucpiW3j2bY+JLmbjY4Ei8b1HKI6hxvy3nBMPMXo58M2xndFRWvJ81+maDsQ523KjtoN5BT
 i2psPEqWRzywtk/gGIJPM2T0aSNmXdCEg0pw/CoRfe1CZPoIXI0Swe2C/OfFlRc96gM4YsmY1iT
 0aKQXMNkxcH+CafQu3A==
X-Authority-Analysis: v=2.4 cv=aK5lOr9m c=1 sm=1 tr=0 ts=6acc8831 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=XeT34wHY2xQq_wk8a9EA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-GUID: yz0cwp_oyRmFEJLyuPr7hZlEYcg-KAOB
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDAyOCBTYWx0ZWRfX1Dgryq3HXNr1
 rfSaEytlNbIzOgp2GRSUScsnqYhR8PrB1cP+73eFWkGSIkpsBWTwCnUIL9L80qcbpxiqkr9B/XN
 65Kqwp76ttPSVMYZrEQ6DF8Us8YTJ4k=
X-Proofpoint-ORIG-GUID: yz0cwp_oyRmFEJLyuPr7hZlEYcg-KAOB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_02,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 bulkscore=0 impostorscore=0 spamscore=0
 suspectscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610120028
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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

On 10/11/26 9:26 PM, Yonggang Luo wrote:
> On Mon, Oct 12, 2026 at 10:25 AM Pierrick Bouvier
> <pierrick.bouvier@oss.qualcomm.com> wrote:
>>
>> On 10/11/26 7:13 PM, Pierrick Bouvier wrote:
>>> On 10/11/26 1:22 PM, Yonggang Luo wrote:
>>>> On Fri, Oct 9, 2026 at 2:34 AM Pierrick Bouvier
>>>> <pierrick.bouvier@oss.qualcomm.com> wrote:
>>>>>
>>>>> On 10/8/2026 10:13 AM, Yonggang Luo wrote:
>>>>>> On Fri, Oct 9, 2026 at 12:06 AM Pierrick Bouvier
>>>>>> <pierrick.bouvier@oss.qualcomm.com> wrote:
>>>>>>>
>>>>>>> On 10/8/2026 2:46 AM, Yonggang Luo wrote:
>>>>>>>> On Thu, Oct 8, 2026 at 5:42 PM Daniel P. Berrangé <berrange@redhat.com> wrote:
>>>>>>>>>
>>>>>>>>> On Wed, Oct 07, 2026 at 01:25:46PM -0700, Pierrick Bouvier wrote:
>>>>>>>>>> On 10/7/2026 4:47 AM, Yonggang Luo wrote:
>>>>>>>>>>> This allows a combined binary to register machine types from all its targets.
>>>>>>>>>>> Consequently, QMP `query-machines` can return machine entries from every
>>>>>>>>>>> target, even when `none` is selected. For example, a client can query the
>>>>>>>>>>> combined machine list with:
>>>>>>>>>>>
>>>>>>>>>>> ```json
>>>>>>>>>>> { "execute": "query-machines" }
>>>>>>>>>>> ```
>>>>>>>>>>>
>>>>>>>>>>> The returned list includes the registered machine classes from all linked
>>>>>>>>>>> targets. This is separate from selecting a machine: with `-target none`,
>>>>>>>>>>> `-M virt` reports the targets that provide `virt` instead of choosing one
>>>>>>>>>>> arbitrarily:
>>>>>>>>>>>
>>>>>>>>>>> ```text
>>>>>>>>>>> qemu-system -target none -M virt
>>>>>>>>>>> unsupported machine type: "virt" for target "none"
>>>>>>>>>>> Available for targets:
>>>>>>>>>>>      aarch64
>>>>>>>>>>>      arm
>>>>>>>>>>> ```
>>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>>    From the long conversation on a previous thread, I thought we reached
>>>>>>>>>> the conclusion that if we didn't expose any ambiguous name, then -target
>>>>>>>>>> option is unnecessary, or maybe I got lost on track of this thread.
>>>>>>>>>>
>>>>>>>>>> https://lore.kernel.org/qemu-devel/ar_coT44h5-zJPVV@redhat.com/
>>>>>>>>>>
>>>>>>>>>> I'm not sure which semantic we want to have with -target none. If there
>>>>>>>>>> is no ambiguous name registered, we just don't need it at all. It's a
>>>>>>>>>> win-win IMHO.
>>>>>>>>>
>>>>>>>>> Yes, if we expose unique names for every machine, then -target is then
>>>>>>>>> redundant.
>>>>>>>>
>>>>>>>> so how to diff riscv32-virt and risv64-virt? oh so for this machine we
>>>>>>>> needs two name?
>>>>>>>> "virt" needs register twice for it? or register only a single time,
>>>>>>>> but we prefix the target_name()
>>>>>>>> automatically? for example machine::name === "virt", but we can use
>>>>>>>> "riscv32-virt" "risv64-virt" to reach it?
>>>>>>>>
>>>>>>>
>>>>>>> Yes, ideally we should have different variant of virt for 32/64 bit.
>>>>>>> Same goes for cpu max types.
>>>>>>>
>>>>>>> QOM type is always registered unambiguously ("$arch-virt"). Then, for
>>>>>>> the "alias" name, which is virt, in case multiple matches are found,
>>>>>>> command line can return an error with list of unambiguous names to call it.
>>>>>>>
>>>>>>> $ qemu-system -M virt
>>>>>>> Multiple virt machines are available. Please choose one of them:
>>>>>>> - aarch64-virt
>>>>>>> - riscv64-virt
>>>>>>>
>>>>>>> There is no "parsing" of the argument, it's just the real QOM type. Then
>>>>>>> we can find which target it implements from mc->targets.
>>>>>>> And then, we can automatically choose which cpus should be available
>>>>>>> based on that, thanks to cpu->targets.
>>>>>>>
>>>>>>> For existing binaries, nothing change.
>>>>>>
>>>>>> Good, I think we found a clean way now, is_available should be
>>>>>> removed, and TypeInfo::targets and TypeImpl::targets should be added.
>>>>>
>>>>> It goes into MachineClass only for now.
>>>>>
>>>>>> I think
>>>>>> for "virt" we can add a shared hw/machine-virt.c instead, and forwarding to
>>>>>> the $arch specific virt. so that we only have a single "virt" registered.
>>>>>> And it's
>>>>>> targets is
>>>>>> QEMU_ARCH_I386 |
>>>>>> QEMU_ARCH_ARM |
>>>>>> QEMU_ARCH_RISCV |
>>>>>> QEMU_ARCH_LOONGARCH |
>>>>>> QEMU_ARCH_M68K |
>>>>>> QEMU_ARCH_OR1K |
>>>>>> QEMU_ARCH_XTENSA |
>>>>>> QEMU_ARCH_HEXAGON
>>>>>>
>>>>>> So that we won't have a list of conflict QOM names for "virt" machines.
>>>>>> As now we indeed have only a single "virt" machine that redirects to
>>>>>> different targets.
>>>>>>
>>>>>
>>>>> The idea looks appealing, but I don't think it solves the problem to
>>>>> have multiple virt variants available at the same time.
>>>>>
>>>>> The "alias" idea you introduced before is good, we just need to add a
>>>>> check if an alias is really unique, else return an error, as explained
>>>>> previously.
>>>>>
>>>>> If "-M aarch64-virt" works for both the new and existing binary, and -M
>>>>> virt only for existing binaries (and ambiguous for new one), I think
>>>>> that's a safe approach.
>>>>>
>>>>>>
>>>>>> For other types also conflict can be handled in the same way, such as
>>>>>> "-cpu host" "-cpu max"
>>>>>> maybe others, but I think they all have the same way to deal with.
>>>>>>
>>>>>>
>>>>>> That's why  TypeInfo::targets and TypeImpl::targets better than sole
>>>>>> Machine::targets
>>>>>>
>>>>>
>>>>> One step at a time.
>>>>> Let's keep focused on declaring targets for a single machine first.
>>>>> Then we can iterate to solve the "virt" problem.
>>>>> Then convert all the existing machines and add a check in machine-target.c
>>>>> Then, and only then, we can see what happens with cpus.
>>>>
>>>> I tried this idea, but I faced a fatal error, because the
>>>> target_info() is not available until
>>>> the machine selected(the target arch will be select just along with
>>>> the machine selected), so basically
>>>> all calls to target_info() would raise an error(null pointer), how to
>>>> deal with it?
>>>>
>>>
>>> I see. Indeed, since we can't set a target before registering all types,
>>> it implies that all the types class_init can't use target_* functions.
>>>
>>>
>>> - register_accel_target_type
>>> - cpu_max_v8_register_type
>>>
>>
>> Sorry, mail sent to early.
>>
>> For the is_available callback usage, it should be easy to do the switch,
>> since it's basically the same information that what we are trying to do
>> - we can leave them for now.
>>
>> Some types (like accel and max mentioned above), explicitly change their
>> definition depending on the target. It's a behavior we can't rely on
>> anymore, and it means we need proper distinct types instead of a single
>> one with dynamic definition driven by target-info.
>>
>> I think that's the preliminary work needed, before being able to go
>> further: convert all existing usage in class_init with distinct types +
>> is_available, and then we can do the switch from is_available to the new
>> .targets approach.
> 
> Hi Pierrick,
> I have already tried that introducing new QOM names just to make class_init
>   target-independent is too broad(means all usage of it should be handled)
> and could complicate compatibility(changed too much code).
> Can we avoid new names by some new means(ideas welcome)?
>

We can use is_available as an intermediate step.
The good thing is that removing target_* from class_init can be done as 
much incrementally as we want: there is no need to do all the changes at 
once.

Once we get to the point where there is no target_* in class_init and 
all types are properly defined with is_available filters, we can see how 
to deal with the duplication. My point of view after our discussions is 
that we should keep current name for existing binaries, and should be 
free to force user to deal with ambiguity with new single-binary 
(machine type "X" is ambiguous, please choose among arch-X, arch-Y, ...).

> 
>>
>> It's probably worth having the conversion in its own series (only
>> cleanup usage of target_* in class_init), before trying to get rid of
>> is_available.
> 
>>
>> For the implementation, you can use the multi-targets.c binary test to
>> drive the change. Remove the module init for target info (leaving no
>> target set), and add a hacky patch to skip call to is_available (and
>> return true instead) and allow double definition (which will rely on
>> is_available). Then, fix all the segfault. Once it compiles and runs,
>> only double definition will be left, which can be handled by inserting
>> the right is_available callbacks. Then in a subsequent series, the
>> switch to .targets can be made.
> 
> 
> Still have no clean clue about how to remove is_available , as we have many
> "virt" machines. Do you means all "virt" machines with "virt-machine" QOM names
> are inserted to the table? How to get it working because the "key" is string.
>

The alias series you posted initially was good, with the addition to 
detect when multiple machines have the same alias (and report an error 
in this case).

I triggered the conversation we are having now because things have not 
been defined properly, and the direction to have -target + arch:machine 
was not really satisfactory. Now we settled on excluding -target, and 
embedding all types, I think it's clearer.

> 
>>
>> It's a work we'll need to do for heterogeneous anyway, I was just hoping
>> to delay that until there, but seems we need to deal with it now.
>> A good thing is that it means target-info won't have to be registered
>> before all QOM types anymore, so it's worth the effort IMHO.
>>
>> Thanks,
>> Pierrick
> 
> 
> 


