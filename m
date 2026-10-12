Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A532CA9EBD
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2026 02:25:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xG5jV-0003DE-DW; Sun, 11 Oct 2026 22:25:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xG5jK-0003Cg-70
 for qemu-devel@nongnu.org; Sun, 11 Oct 2026 22:25:34 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xG5jF-0005WI-EJ
 for qemu-devel@nongnu.org; Sun, 11 Oct 2026 22:25:32 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69C1lkkh734805
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2026 02:25:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 eRGuxq6XL+rUUjFuHsTXJ3D1st4kkWX6m/127fVub8k=; b=ijbVU4TnP2mKZdIU
 iJtbZUIaEtsWZz4NVUX7HmjTiNvorQpS1QTth1prUSkqe8jhyOxs4c4Ap4l/d7Vq
 Wjv4ZJbdAi6eQKwLDYw0/xC32xHBqx/JAbym6x/81fv0gpQaWYvFn5eppXkPecWt
 GcVwB1kWGQQjNHcngys8t56recMfIanHWLmWk5GLxIVO0CQhg0zF4DJ1c37FByt3
 EPbgplBGHIChB37twFkyiuh1r7Nto+tFi00i8OurPuOlYdIyPCebd1/h64yt7zXV
 jKSGAIZ60MRzpvs6qK2mC5lfxlbWLI2HXgPYtx7Rozeedh0JdXvdgqPlu3u7sGza
 AQS+/w==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h7aqmvsa6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2026 02:25:27 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-3a4aa263a4aso1053685a91.1
 for <qemu-devel@nongnu.org>; Sun, 11 Oct 2026 19:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791771926; x=1792376726; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:references:cc:to
 :from:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=eRGuxq6XL+rUUjFuHsTXJ3D1st4kkWX6m/127fVub8k=;
 b=JUq3SxGnZJPU5ThAWb+ba6WlUIa7c3+URl7v8pLi6QDgdnTq+wJfOeOQrlSUFTBVtV
 /0Fgc7Mo7OF6N/xVd7tZThi/mHR4v7IkrcONRvPCtO3YJ8TAvWXHg85bwHnrkBF+89vc
 BpTC8OR/3wkgy6J+LR+4zZtq/7ZEHuXX2ojXHLE82lsmyMGgN8zOncx3XaPJz17Ta23o
 i9AulAVu1TcPq93SRfaaI5PbttdX3uErxyUjbpsHxxr/UnHY2egmUJGGOXOk17iax2w+
 843laLtz6dm6CO79BNEzNOaeMzHfdZNVicnYMqZO19hiamejJGP8IyXafM2/X0LdjJ2e
 da7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791771926; x=1792376726;
 h=content-transfer-encoding:content-type:in-reply-to:references:cc:to
 :from:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=eRGuxq6XL+rUUjFuHsTXJ3D1st4kkWX6m/127fVub8k=;
 b=oFBJJW9zzzWWTI5dnVlZFna9Qt+vht6OsSVTPIqBf6ZOL5P9K/3VAoqTLv8YX7Szho
 jihiJZQEm5u1Cq1kmZ40b0trqlsXQtIl+0pi4GqOTsDdNs9HH3CBqwz/7q2TUpejDsNF
 V5vabYl32QayQ2KNMZJ60bdaK/dkAYTu7u3jkuEYubKizuHB0cYjItDSCLgWigoeFxCx
 pQnUp3MSGgKuEG6d2KkyuLQnluQ4degJKiM5la0LKPfycHqQFTjPm+/B2JVqIA/wFREi
 q7gbg/UjQUqK3kgvEWw2EnlRAXK3uKWkFz0IAoSpj2uyUnkwU1aqEb9P50Cl3dwYalGf
 JCew==
X-Forwarded-Encrypted: i=1;
 AKwUvBxAwzxjRXtVFIinon/pLPUvGlIL5rXigfhYICU/fbhlC5RKRCxExU1mmXW/MVeJC5QjRE5x0lCW0r3I@nongnu.org
X-Gm-Message-State: AFq9FYIU6mTjGq6P29VpVdWWsBsnSNA5an3rxnkJsmzID2W7TNLMFD1v
 kDppuMB4qT/FGFflm6XD594zAXuoxMR455+5o5UW0R3r/N7ZdNy2umd/YdozQYyKc8wuYPpHN7j
 Ivipf/I/f4jbvY5GzZmhnfJwfVOSQF2e3V+TxSrsPvnA2cwD5DeXXyKhSpg==
X-Gm-Gg: AYBFou2GBVBikHo0SfAg2rmCFpKmPD45pOs1RD2ksHXz+Qr5pUYCUFr3xgAtfgxXt+v
 QyFeXOjuGJTl0cQ8t+vP6+lnVxc6jwDwZsqG1CHvRwuta1HIMv2yTVjXJ6OHOPGkxA9Hk3PCNMv
 /riGwOtITWm5aCbCQ8XwWg+8Bc4tP8h1OJBqk8LotV6iIscW3ibVCyNP73wPBd2MOc9OV8giBVW
 C/OIcEqM7doirlIk0+GNtiXenKq+8SCs6AWR1r6zMR2uVCf18LFrUf+zCVvHjfvctTpmYegLVPp
 t1Rez8dkxWFJcysmBw7+/p/+eZIAI2J0eJzEljYiV73EMk7X24g9xElde34Aq0MIpkVu5n+rWFF
 g3L9hgm8jWAzwxP93ofWvpFbcPkYZ7HLplb5OZKvNpaSac5yU7BA9BeGu
X-Received: by 2002:a17:90b:2d06:b0:3a4:b30b:b501 with SMTP id
 98e67ed59e1d1-3ab3a32d491mr6331771a91.9.1791771926100; 
 Sun, 11 Oct 2026 19:25:26 -0700 (PDT)
X-Received: by 2002:a17:90b:2d06:b0:3a4:b30b:b501 with SMTP id
 98e67ed59e1d1-3ab3a32d491mr6331736a91.9.1791771925537; 
 Sun, 11 Oct 2026 19:25:25 -0700 (PDT)
Received: from [192.168.1.169] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ab37817414sm14956321a91.2.2026.10.11.19.25.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 11 Oct 2026 19:25:24 -0700 (PDT)
Message-ID: <1a477877-516a-41b8-8548-598bfad74f25@oss.qualcomm.com>
Date: Sun, 11 Oct 2026 19:25:24 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/8] qom: pass TargetInfo to the is_available callback
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
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
In-Reply-To: <8cb24445-b659-4bd4-9497-888ce152e82d@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDAwOSBTYWx0ZWRfXw1ZvREPiZ4K6
 eHLbwbvuM6Qfwnd92+Jjfi0ygmwjb+LfXcFbIkQzT0g4iqJBi0tXoBRL10GB5t6i2bDRY98N79l
 1KOG5gIaNfE9L8U67GYEaisUJE+8lUY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDAwOSBTYWx0ZWRfX0sMoYMG9r8ug
 0plzzAoI3Jn5ndRRhkp9Zb3g+psfl6mes8nB7rUj8LCiM5G+wMIEBOvb4FV+WsSsNP03YIVnYlK
 ybKVy9eTQaD4KtKppWaeAv2NXmdKm0/xscZxUuZgDU0CSr7uTNsp7Y04omH4w+3VDCp1tEG8BaU
 xciMIXjCUcOBF7YT7iKEwzC0xs4wgnhzzhsyz84pUzdQjksu4d8UAEBjTiJiS5OGk1D05+0TmGs
 xa/5bXF1KdkfwkREBnuuKximb2jiaCE7iA839AbjG7PoZe0ILTmY8NwsZJ5QrZrai4NAb3WqWYE
 ioPULP6rYn+N46bTHrJc1mOhDwhLmVHDLYVwyoIot8WbPBcoTQeBccn588zJTt5B7z0B5jnIZe9
 tAnEnFNdItpGWrsnuP6DDeW4tgO9DrpS4r5av8KLaokKEV427Xce/UJzf9z1Pmpn3XOdQ33Ye05
 tY+RWjQ5BcdSDZsc1sA==
X-Authority-Analysis: v=2.4 cv=Uq32pOwB c=1 sm=1 tr=0 ts=6acc4517 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=Kg6kHxSCj_xyqh2FFdsA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-ORIG-GUID: d_l3CCDJaferbj37Qnf6ktrvmEJWRxo_
X-Proofpoint-GUID: d_l3CCDJaferbj37Qnf6ktrvmEJWRxo_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 priorityscore=1501 malwarescore=0 spamscore=0
 bulkscore=0 adultscore=0 impostorscore=0 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610120009
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

On 10/11/26 7:13 PM, Pierrick Bouvier wrote:
> On 10/11/26 1:22 PM, Yonggang Luo wrote:
>> On Fri, Oct 9, 2026 at 2:34 AM Pierrick Bouvier
>> <pierrick.bouvier@oss.qualcomm.com> wrote:
>>>
>>> On 10/8/2026 10:13 AM, Yonggang Luo wrote:
>>>> On Fri, Oct 9, 2026 at 12:06 AM Pierrick Bouvier
>>>> <pierrick.bouvier@oss.qualcomm.com> wrote:
>>>>>
>>>>> On 10/8/2026 2:46 AM, Yonggang Luo wrote:
>>>>>> On Thu, Oct 8, 2026 at 5:42 PM Daniel P. Berrangé <berrange@redhat.com> wrote:
>>>>>>>
>>>>>>> On Wed, Oct 07, 2026 at 01:25:46PM -0700, Pierrick Bouvier wrote:
>>>>>>>> On 10/7/2026 4:47 AM, Yonggang Luo wrote:
>>>>>>>>> This allows a combined binary to register machine types from all its targets.
>>>>>>>>> Consequently, QMP `query-machines` can return machine entries from every
>>>>>>>>> target, even when `none` is selected. For example, a client can query the
>>>>>>>>> combined machine list with:
>>>>>>>>>
>>>>>>>>> ```json
>>>>>>>>> { "execute": "query-machines" }
>>>>>>>>> ```
>>>>>>>>>
>>>>>>>>> The returned list includes the registered machine classes from all linked
>>>>>>>>> targets. This is separate from selecting a machine: with `-target none`,
>>>>>>>>> `-M virt` reports the targets that provide `virt` instead of choosing one
>>>>>>>>> arbitrarily:
>>>>>>>>>
>>>>>>>>> ```text
>>>>>>>>> qemu-system -target none -M virt
>>>>>>>>> unsupported machine type: "virt" for target "none"
>>>>>>>>> Available for targets:
>>>>>>>>>     aarch64
>>>>>>>>>     arm
>>>>>>>>> ```
>>>>>>>>>
>>>>>>>>
>>>>>>>>   From the long conversation on a previous thread, I thought we reached
>>>>>>>> the conclusion that if we didn't expose any ambiguous name, then -target
>>>>>>>> option is unnecessary, or maybe I got lost on track of this thread.
>>>>>>>>
>>>>>>>> https://lore.kernel.org/qemu-devel/ar_coT44h5-zJPVV@redhat.com/
>>>>>>>>
>>>>>>>> I'm not sure which semantic we want to have with -target none. If there
>>>>>>>> is no ambiguous name registered, we just don't need it at all. It's a
>>>>>>>> win-win IMHO.
>>>>>>>
>>>>>>> Yes, if we expose unique names for every machine, then -target is then
>>>>>>> redundant.
>>>>>>
>>>>>> so how to diff riscv32-virt and risv64-virt? oh so for this machine we
>>>>>> needs two name?
>>>>>> "virt" needs register twice for it? or register only a single time,
>>>>>> but we prefix the target_name()
>>>>>> automatically? for example machine::name === "virt", but we can use
>>>>>> "riscv32-virt" "risv64-virt" to reach it?
>>>>>>
>>>>>
>>>>> Yes, ideally we should have different variant of virt for 32/64 bit.
>>>>> Same goes for cpu max types.
>>>>>
>>>>> QOM type is always registered unambiguously ("$arch-virt"). Then, for
>>>>> the "alias" name, which is virt, in case multiple matches are found,
>>>>> command line can return an error with list of unambiguous names to call it.
>>>>>
>>>>> $ qemu-system -M virt
>>>>> Multiple virt machines are available. Please choose one of them:
>>>>> - aarch64-virt
>>>>> - riscv64-virt
>>>>>
>>>>> There is no "parsing" of the argument, it's just the real QOM type. Then
>>>>> we can find which target it implements from mc->targets.
>>>>> And then, we can automatically choose which cpus should be available
>>>>> based on that, thanks to cpu->targets.
>>>>>
>>>>> For existing binaries, nothing change.
>>>>
>>>> Good, I think we found a clean way now, is_available should be
>>>> removed, and TypeInfo::targets and TypeImpl::targets should be added.
>>>
>>> It goes into MachineClass only for now.
>>>
>>>> I think
>>>> for "virt" we can add a shared hw/machine-virt.c instead, and forwarding to
>>>> the $arch specific virt. so that we only have a single "virt" registered.
>>>> And it's
>>>> targets is
>>>> QEMU_ARCH_I386 |
>>>> QEMU_ARCH_ARM |
>>>> QEMU_ARCH_RISCV |
>>>> QEMU_ARCH_LOONGARCH |
>>>> QEMU_ARCH_M68K |
>>>> QEMU_ARCH_OR1K |
>>>> QEMU_ARCH_XTENSA |
>>>> QEMU_ARCH_HEXAGON
>>>>
>>>> So that we won't have a list of conflict QOM names for "virt" machines.
>>>> As now we indeed have only a single "virt" machine that redirects to
>>>> different targets.
>>>>
>>>
>>> The idea looks appealing, but I don't think it solves the problem to
>>> have multiple virt variants available at the same time.
>>>
>>> The "alias" idea you introduced before is good, we just need to add a
>>> check if an alias is really unique, else return an error, as explained
>>> previously.
>>>
>>> If "-M aarch64-virt" works for both the new and existing binary, and -M
>>> virt only for existing binaries (and ambiguous for new one), I think
>>> that's a safe approach.
>>>
>>>>
>>>> For other types also conflict can be handled in the same way, such as
>>>> "-cpu host" "-cpu max"
>>>> maybe others, but I think they all have the same way to deal with.
>>>>
>>>>
>>>> That's why  TypeInfo::targets and TypeImpl::targets better than sole
>>>> Machine::targets
>>>>
>>>
>>> One step at a time.
>>> Let's keep focused on declaring targets for a single machine first.
>>> Then we can iterate to solve the "virt" problem.
>>> Then convert all the existing machines and add a check in machine-target.c
>>> Then, and only then, we can see what happens with cpus.
>>
>> I tried this idea, but I faced a fatal error, because the
>> target_info() is not available until
>> the machine selected(the target arch will be select just along with
>> the machine selected), so basically
>> all calls to target_info() would raise an error(null pointer), how to
>> deal with it?
>>
> 
> I see. Indeed, since we can't set a target before registering all types,
> it implies that all the types class_init can't use target_* functions.
> 
> 
> - register_accel_target_type
> - cpu_max_v8_register_type
>

Sorry, mail sent to early.

For the is_available callback usage, it should be easy to do the switch, 
since it's basically the same information that what we are trying to do 
- we can leave them for now.

Some types (like accel and max mentioned above), explicitly change their 
definition depending on the target. It's a behavior we can't rely on 
anymore, and it means we need proper distinct types instead of a single 
one with dynamic definition driven by target-info.

I think that's the preliminary work needed, before being able to go 
further: convert all existing usage in class_init with distinct types + 
is_available, and then we can do the switch from is_available to the new 
.targets approach.

It's probably worth having the conversion in its own series (only 
cleanup usage of target_* in class_init), before trying to get rid of 
is_available.

For the implementation, you can use the multi-targets.c binary test to 
drive the change. Remove the module init for target info (leaving no 
target set), and add a hacky patch to skip call to is_available (and 
return true instead) and allow double definition (which will rely on 
is_available). Then, fix all the segfault. Once it compiles and runs, 
only double definition will be left, which can be handled by inserting 
the right is_available callbacks. Then in a subsequent series, the 
switch to .targets can be made.

It's a work we'll need to do for heterogeneous anyway, I was just hoping 
to delay that until there, but seems we need to deal with it now.
A good thing is that it means target-info won't have to be registered 
before all QOM types anymore, so it's worth the effort IMHO.

Thanks,
Pierrick

