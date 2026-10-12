Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC1D1CA9EBD
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2026 02:14:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xG5XO-0005lK-9B; Sun, 11 Oct 2026 22:13:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xG5XM-0005l5-IK
 for qemu-devel@nongnu.org; Sun, 11 Oct 2026 22:13:12 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xG5XK-0004SN-7m
 for qemu-devel@nongnu.org; Sun, 11 Oct 2026 22:13:12 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69C1lJ0J4078236
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2026 02:13:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Q6/+JgKm8jY0VKquYWA7r+k5EnTN0P7KXKaFlGhrKAg=; b=Shy2tZ70W0IY6mN7
 1K3EtDQD6wELSTsS+FUj0K+eRiVGf9qUFBbPI9X2P4NxSc5S2ckg5U/QOIRLikQy
 e/KJbXuJHaVyETX5pV2eUGwM2Y33zqx4Y+6ZwMjRQXx5I7Au71gRb4WkL+UVL4iA
 ur6ARyyD3fEE4RUzBc83Q2XlyfPBfDCQkbLWhXHUNvd/crXckikwqj3zldCzAjkW
 iALkRl4ob7FPd58coSW9ng+l7v1YYDvcXm2mkN6EKmeIb1BRewyoCz9KGsKRU4iX
 6nUEj/wjrTO5UzKEe/Y4CzXMjfxTHYgPDNScdz/eNtUSielpEzkKm4blCuZPMS+c
 fklhzA==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h8j6dghj2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2026 02:13:07 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-3ab2395f104so1036108a91.2
 for <qemu-devel@nongnu.org>; Sun, 11 Oct 2026 19:13:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791771186; x=1792375986; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Q6/+JgKm8jY0VKquYWA7r+k5EnTN0P7KXKaFlGhrKAg=;
 b=gczGH0BVis0MLY53xrlZ2/dboX1W/QiKnMLkxAHEChNVIa1DFgcn6OPeFmANrXUb+c
 jVvOP6BDDaDoNUeeQ2+ObKQtT5rL7D2Inyg1TGa3ugC3yOdV33yvzPA07zR9rV/CDFvi
 326i1V4wLkt5Gpcy9Rdl4wNO6F2tDJJ3Iu83+RDRsE9ENdKXhM5i8w3JmJgDcP85t4Tb
 L3jcibk33XW9TP8LwK5WuQ+oVrr5DRYyWu72ePRctz4zWIyIdd1ZmZ2K8x7UqxtWDtNb
 25bSYOYuNiNhJyUhmLTrR1lsHxMiRPyA2H42o7xS/Ci2YcJXBZNcFQWjv0ygOdqdZd48
 a2Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791771186; x=1792375986;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Q6/+JgKm8jY0VKquYWA7r+k5EnTN0P7KXKaFlGhrKAg=;
 b=H7xZGbxD0Bd6jf8JCLnGjwNZ8cqnC1t8VVRmKaaC5zE1M5fxrt11ozJPi6ylIpw9v/
 nAQEP6yoVrEUPugzjpYnM303bWLHHGgIo9sqneT6X29ogpMwkJ7RgViK5BfIJV/6kKlk
 tVGrAIta9Jryk6O/u2KkuxRbaiE55OoU0hslXiVoWMlVs0WHjAmeYc46aDTTPGTpDRrf
 MDeWHBgpIbmeKnt4FwVUWSSkmlxDTALUi1leky4Q5+i2/vaNnlw3vZ+LzIywP5mtXipt
 DjnihLHbEM5dFO33xObGsKIfeA75NqsW8D2hyEr+g6qfT+xpgdmY0diSF8cFjbS1820C
 biQA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzbnrg2+7hbce/tAdJoxx6xwkZOKn8cBArxgcHipFhg6gPdAU2DPS4+nazyz7cRfHSj+Z4IyjIwp3PR@nongnu.org
X-Gm-Message-State: AFq9FYLJvCQmz6sGGLq0IaFanyVbIP82+kcC+xDJHC2yinngmMOmVWOi
 y0xtvOJ4fwCY1qD3qdX0zxC5FdHcHPyBpLoVT2izLO0/WtBuIPke1Tho23yvFZnWq0t/o1dzN9u
 la+XMn/+Zzify/2++0a8aT5pOyqsV2VkUMH1Y4F2TSJVreEObm1vjGhVqjw==
X-Gm-Gg: AYBFou2lwidtzwlbYCJh6WyuKvseUlUltQvr9EWJHKt6zNAtzL78YI+I8Z+B4Q1TEaa
 1WpH+f+kE9QhqmMoUqfj00uPTd+o8th24++vC5k1eKvL0Go4yQankIqyoOC6w7dGMjTbompG6wZ
 aTWLTRN0Bv0PguThNa/o4hpkPr9IHfDnZF21ppSE9DixJfPFUooKorKCsjdDaOxWoWzugwhCReV
 yehAQKnUcuAH6+or3qMT1vaher171EBMCNOlT4TxHRJAq5z7Zyr4A8jAo5IgeL1wYpZ1CIGJHSL
 nNDJTtuPeTRQCzsqdyjBX5ypU0q8ZSG/SVX0urU24L1/DnHZW5PUDwqVcQg7YsWBLe1kH3b0Llg
 BFo3LRREuq8Wmr8JNMPw3yY6yhaaLG7HM2mQY/H4fd6+y3wz9UmBUd1M4
X-Received: by 2002:a17:90b:562c:b0:3a4:b3ac:904c with SMTP id
 98e67ed59e1d1-3ab3ac775bdmr6697289a91.51.1791771186132; 
 Sun, 11 Oct 2026 19:13:06 -0700 (PDT)
X-Received: by 2002:a17:90b:562c:b0:3a4:b3ac:904c with SMTP id
 98e67ed59e1d1-3ab3ac775bdmr6697252a91.51.1791771185499; 
 Sun, 11 Oct 2026 19:13:05 -0700 (PDT)
Received: from [192.168.1.169] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ab38fc9e52sm14130427a91.13.2026.10.11.19.13.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 11 Oct 2026 19:13:04 -0700 (PDT)
Message-ID: <8cb24445-b659-4bd4-9497-888ce152e82d@oss.qualcomm.com>
Date: Sun, 11 Oct 2026 19:13:04 -0700
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
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <CAE2XoE-gCTrpEeCROz9JMpPnTQXQ+AnBTR4RwdQhYizkExjK9w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDAwOCBTYWx0ZWRfXzaY3OA84Iayw
 /Sd8f/iPoRzvWItbvF2WH/BLqE1tsBjP8EFtmfl9Xwh4PCdJuV7VZYsx6YKpDAHXXn7Ur5VsHAl
 W0JN4TG6FUzUfB5oViIrmU4A2X9GZj9w0Q3SPi8Wc6pXxrSpZgCHeiG0CIro8Nrs38njeZgIJMK
 pzYnt3LV7PMqNRt8lfgdwdVzO5XrwHmWB86Ucd82claBWvBFjG4nojJR9BOb7HVU8uIDePHBAVN
 vZdrRzkd+DQhlXk7FeZy5xn5b3NXz4zpHjkJYYR0m7y7nAtixdOdhZdfocvckDfsvsb9erhTFyJ
 cP4bNnNbrlgpvma9PQcF1Twv+ljEkWlI1EWosHa71X9pENKY3RBXJI78JX2ts7+19SiS3k7A10+
 7dG8MH+b/XmQ9rlzEAdjYz519BL2bHD765n/MPqKw5p4vVc8UlfO1HBWnOa5MoQP3YcEV+Tpnqr
 hfIUHgcUskARTyj4gJg==
X-Authority-Analysis: v=2.4 cv=aK5lOr9m c=1 sm=1 tr=0 ts=6acc4233 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=B-3GWC4AWTgxg7b-HyEA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-GUID: hHt_8JI9rXUB6lm1K3I6F_6Q9VU2_xOt
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDAwOCBTYWx0ZWRfX087C42261J/j
 FxVSIbCjRTuEXpPdfA58R2xqidZMG/FRCn13KU8wLAtgLRFIqcuDD5zsky/gWqd9tSKXidmmGXX
 Ip2ZD5vXi0vF+nSAuKoO2ahp/VlWiK8=
X-Proofpoint-ORIG-GUID: hHt_8JI9rXUB6lm1K3I6F_6Q9VU2_xOt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 bulkscore=0 impostorscore=0 spamscore=0
 suspectscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610120008
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

On 10/11/26 1:22 PM, Yonggang Luo wrote:
> On Fri, Oct 9, 2026 at 2:34 AM Pierrick Bouvier
> <pierrick.bouvier@oss.qualcomm.com> wrote:
>>
>> On 10/8/2026 10:13 AM, Yonggang Luo wrote:
>>> On Fri, Oct 9, 2026 at 12:06 AM Pierrick Bouvier
>>> <pierrick.bouvier@oss.qualcomm.com> wrote:
>>>>
>>>> On 10/8/2026 2:46 AM, Yonggang Luo wrote:
>>>>> On Thu, Oct 8, 2026 at 5:42 PM Daniel P. Berrangé <berrange@redhat.com> wrote:
>>>>>>
>>>>>> On Wed, Oct 07, 2026 at 01:25:46PM -0700, Pierrick Bouvier wrote:
>>>>>>> On 10/7/2026 4:47 AM, Yonggang Luo wrote:
>>>>>>>> This allows a combined binary to register machine types from all its targets.
>>>>>>>> Consequently, QMP `query-machines` can return machine entries from every
>>>>>>>> target, even when `none` is selected. For example, a client can query the
>>>>>>>> combined machine list with:
>>>>>>>>
>>>>>>>> ```json
>>>>>>>> { "execute": "query-machines" }
>>>>>>>> ```
>>>>>>>>
>>>>>>>> The returned list includes the registered machine classes from all linked
>>>>>>>> targets. This is separate from selecting a machine: with `-target none`,
>>>>>>>> `-M virt` reports the targets that provide `virt` instead of choosing one
>>>>>>>> arbitrarily:
>>>>>>>>
>>>>>>>> ```text
>>>>>>>> qemu-system -target none -M virt
>>>>>>>> unsupported machine type: "virt" for target "none"
>>>>>>>> Available for targets:
>>>>>>>>    aarch64
>>>>>>>>    arm
>>>>>>>> ```
>>>>>>>>
>>>>>>>
>>>>>>>  From the long conversation on a previous thread, I thought we reached
>>>>>>> the conclusion that if we didn't expose any ambiguous name, then -target
>>>>>>> option is unnecessary, or maybe I got lost on track of this thread.
>>>>>>>
>>>>>>> https://lore.kernel.org/qemu-devel/ar_coT44h5-zJPVV@redhat.com/
>>>>>>>
>>>>>>> I'm not sure which semantic we want to have with -target none. If there
>>>>>>> is no ambiguous name registered, we just don't need it at all. It's a
>>>>>>> win-win IMHO.
>>>>>>
>>>>>> Yes, if we expose unique names for every machine, then -target is then
>>>>>> redundant.
>>>>>
>>>>> so how to diff riscv32-virt and risv64-virt? oh so for this machine we
>>>>> needs two name?
>>>>> "virt" needs register twice for it? or register only a single time,
>>>>> but we prefix the target_name()
>>>>> automatically? for example machine::name === "virt", but we can use
>>>>> "riscv32-virt" "risv64-virt" to reach it?
>>>>>
>>>>
>>>> Yes, ideally we should have different variant of virt for 32/64 bit.
>>>> Same goes for cpu max types.
>>>>
>>>> QOM type is always registered unambiguously ("$arch-virt"). Then, for
>>>> the "alias" name, which is virt, in case multiple matches are found,
>>>> command line can return an error with list of unambiguous names to call it.
>>>>
>>>> $ qemu-system -M virt
>>>> Multiple virt machines are available. Please choose one of them:
>>>> - aarch64-virt
>>>> - riscv64-virt
>>>>
>>>> There is no "parsing" of the argument, it's just the real QOM type. Then
>>>> we can find which target it implements from mc->targets.
>>>> And then, we can automatically choose which cpus should be available
>>>> based on that, thanks to cpu->targets.
>>>>
>>>> For existing binaries, nothing change.
>>>
>>> Good, I think we found a clean way now, is_available should be
>>> removed, and TypeInfo::targets and TypeImpl::targets should be added.
>>
>> It goes into MachineClass only for now.
>>
>>> I think
>>> for "virt" we can add a shared hw/machine-virt.c instead, and forwarding to
>>> the $arch specific virt. so that we only have a single "virt" registered.
>>> And it's
>>> targets is
>>> QEMU_ARCH_I386 |
>>> QEMU_ARCH_ARM |
>>> QEMU_ARCH_RISCV |
>>> QEMU_ARCH_LOONGARCH |
>>> QEMU_ARCH_M68K |
>>> QEMU_ARCH_OR1K |
>>> QEMU_ARCH_XTENSA |
>>> QEMU_ARCH_HEXAGON
>>>
>>> So that we won't have a list of conflict QOM names for "virt" machines.
>>> As now we indeed have only a single "virt" machine that redirects to
>>> different targets.
>>>
>>
>> The idea looks appealing, but I don't think it solves the problem to
>> have multiple virt variants available at the same time.
>>
>> The "alias" idea you introduced before is good, we just need to add a
>> check if an alias is really unique, else return an error, as explained
>> previously.
>>
>> If "-M aarch64-virt" works for both the new and existing binary, and -M
>> virt only for existing binaries (and ambiguous for new one), I think
>> that's a safe approach.
>>
>>>
>>> For other types also conflict can be handled in the same way, such as
>>> "-cpu host" "-cpu max"
>>> maybe others, but I think they all have the same way to deal with.
>>>
>>>
>>> That's why  TypeInfo::targets and TypeImpl::targets better than sole
>>> Machine::targets
>>>
>>
>> One step at a time.
>> Let's keep focused on declaring targets for a single machine first.
>> Then we can iterate to solve the "virt" problem.
>> Then convert all the existing machines and add a check in machine-target.c
>> Then, and only then, we can see what happens with cpus.
> 
> I tried this idea, but I faced a fatal error, because the
> target_info() is not available until
> the machine selected(the target arch will be select just along with
> the machine selected), so basically
> all calls to target_info() would raise an error(null pointer), how to
> deal with it?
>

I see. Indeed, since we can't set a target before registering all types, 
it implies that all the types class_init can't use target_* functions.


- register_accel_target_type
- cpu_max_v8_register_type


>>
>> Regards,
>> Pierrick
> 
> 
> 


