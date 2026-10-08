Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD8B0CA6009
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2026 00:04:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEbbq-0000ez-Dj; Wed, 07 Oct 2026 20:03:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xEbbn-0000eA-HC
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 20:03:39 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xEbbk-0005Kn-HV
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 20:03:39 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 697LtXQD3711293
 for <qemu-devel@nongnu.org>; Thu, 8 Oct 2026 00:03:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 zzAPSz8ejqsl5mCbRWgd9fjmhenX4R63sCxLBpGBcY0=; b=HaartuZxGbH/PC4g
 slL/OSVQ1L+82xW1Uwi8fB6toF8FWoo8yTIl9N9PI03BIu2Jugr2CytWNl0GcW5r
 qSoiFB12re6q7l63XlfGRDaaO84C7X0U7arT5KE1u5mC66vjosLmRLpHB+bFI2uG
 ex/OQEVY1Dje8Qyk1HR5kovcnZ6Lf7Ts8WAaun7rjgYxOydk5dm/LdeBhorQAzOT
 T71A62SjKDIvWRJRnnjaSPulk6UPvj7BiGA65nxW5WXLLMIVqWikVio1inE9VorL
 NI+zAYk9RF/5IcAzVsBsLlB1Eq+STrcWwxIf2ZgO4j4qNW+V2fLoFlr/zh09GEI0
 dLlQ/w==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h5xe309xd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 08 Oct 2026 00:03:34 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-33c35f5ca6cso8829042eec.1
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2026 17:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791417814; x=1792022614; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=zzAPSz8ejqsl5mCbRWgd9fjmhenX4R63sCxLBpGBcY0=;
 b=kUIto/8KwiEIQQ0cO9uFofI2wxBBgxo3daH4q9jCnEx7RxoUSwXSYeO0OD2XrI0v+2
 LgoAN2fvXsLHTnbvp5C9d9/p1DYX/++DQcHv+rm/FZCs7ZmSgmCYe2MMEan/tLA6ZBJN
 5i4pWz+SANpkx1L7PLY667T4yyO3/UfFtM/bKbeu0XmsOr0WjqbTYhTuOz4xCfegUUXM
 WMI0kwaOx+e5ScvTKJusWStiFvLYPB7lgQ2vEBpD0uH/UY4TzZrHS6Y96Llb8kGJu9wQ
 H1U7Gi1Y9Hhi4JiZJpkztUiRcBAyfnNULYaUnlDUJrcSuDC3yJRRPoF71092Qzk0eynB
 8U0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791417814; x=1792022614;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zzAPSz8ejqsl5mCbRWgd9fjmhenX4R63sCxLBpGBcY0=;
 b=05s90OQ0ThEtFcseK09k0izuhfHLNPsNdPjPj643liFAN8lnzphEChX361VKI5VKhy
 2dQo0FpqTG5e6uc6X8kR1Nc1Nk9MrHoqSInrU5WkC93zEKoUgQLo7O9y/9IM47sEwBwy
 SXmRQvtFtfrWdma29bbLamD+dOLNJAseSOCOeDHkP81i9XJhdBJqsrCsVTzKKoaB6DSI
 pFk8/PJdjbcX2r7pazNyih2qhdxRfj/dWteEEFV0uFX+0REjtFhO7oYcVV0mMGIRqeMS
 bpvMY8pu8CwTY+uI2O57lpQdYzUOn1x4kaANTfEHCQdWQ6/VHM/WmIqDcdZ8u8kYAtqE
 WGmQ==
X-Gm-Message-State: AFuF++k30LBcH2Et0CPYPrCW5rJO0dHZ4OBlopLcxymAUMQW9SaEjpmj
 QG4hkQie/UiVJYNPg1/w46H2u38Ksx/vW4mDIH/V2rfpJ//Qu54WfupbbLTnNwmJz8WMrdVStGm
 +nRJ8QzDNAgAYiWxb4iwyev1RGc/wqN9bMV8oX46ehbjTnb/U5qL68B885w==
X-Gm-Gg: AYBFou2LNgnek/B/C1XGjmO+Ug2c1ffttb4bHNykvgEN1NWY+s7Yag5vOu4fQqgc2Xp
 BdAAbPzAnULCyxqmkaIN2g/Z8gBBaWv//UtU7R6HW4SgZr4cbrnPWZSzSSpM50Iyyi94USLGY4E
 3d8ULfEDtDz8QjPwsUPOJfm7TSafKmwNGzZwElJjrdhzr/Z+cNIBzTlFUufhSzb952AXMpb/K9r
 XdbVLlH2PFoWNdbGSwyWw/BLyEek4eItSFxFKLYeayPEAX6YCOgz4jgBadxzKAAz5ZWLQdloiiP
 zr20tElBRSLicqmdXx0kKgjwNCUUcXYCqhHhldIFN8k0UnB4XAkDdbeC3shmNl/YTNqHF189ptY
 kqdCIUC1ydu4t/JaAqU8Ujtr/2HbenSG0TDHL9Z3UUGGAVrHPbcdyoluRdxD9kPNtBizCqA==
X-Received: by 2002:a05:693c:8646:20b0:34b:68eb:fc04 with SMTP id
 5a478bee46e88-3515dd34088mr4620469eec.11.1791417813124; 
 Wed, 07 Oct 2026 17:03:33 -0700 (PDT)
X-Received: by 2002:a05:693c:8646:20b0:34b:68eb:fc04 with SMTP id
 5a478bee46e88-3515dd34088mr4620417eec.11.1791417812289; 
 Wed, 07 Oct 2026 17:03:32 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3515a8b7c5dsm11525851eec.0.2026.10.07.17.03.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Oct 2026 17:03:31 -0700 (PDT)
Message-ID: <3bdaa482-9dc4-41cd-b232-d46d058f47d2@oss.qualcomm.com>
Date: Wed, 7 Oct 2026 17:03:29 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/8] qom: pass TargetInfo to is_available for later use
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: luoyonggang@gmail.com
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
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
 <20261007115253.328-9-luoyonggang@gmail.com>
 <7fc0d377-a994-41f4-aa98-7ed56db11447@oss.qualcomm.com>
 <CAE2XoE8K+3e8h6H9NrPk1WWMmJfG807bN_Kh5qje-5pKWUUg5w@mail.gmail.com>
 <b2d89a92-0197-4873-b4ea-75bb21c0d0ae@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <b2d89a92-0197-4873-b4ea-75bb21c0d0ae@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA3MDA5NSBTYWx0ZWRfX+FXD31ZaMlEP
 KhhmV5DIzA0cFnok6Mu9d9Qz9ObC7fOFwpQdAG5QDyD1KEkPgZcBh6VzdFpq5HXv15XOmSiGtdy
 Jnsj9U+eSfKXOuT8yUq+7c55RqzuNdMRNHlqz2z0UK4qE5rTcDIOS6nxGSrq1PwnoaxuwJ8LtDr
 mVLJZr1Y+ZIc7GdkI0UiNhaVdik0/z25as3RHSyfcuxvIRivd8blyoWc4hQc3O2aUv+icXXH3Ry
 WO8lQJQnl+hFP4LLthrCsxzSlpwWRRysGeQubg45O8wqnSIfUG1tdrsbOuXM/rhkv/hPcuJbFar
 qCLzUy7BG+lWnCTDGJb3kMvYNOARRZL/HiEQfvP8tqSppWZDudsCYTiiFWM7HGnunuf0mkFtLu/
 H9hX+uOH8mR4xYlgv5cKBiZKFeBqdooqHZNH+QIN7gGEAPS3RmyNB4IoiqYmT3FRw6s85q8ySlX
 2OMYmNT9LKqo4ag5CXA==
X-Proofpoint-ORIG-GUID: nsYo-WGgthXsLrLHgLHJU2HTTYNHRnmL
X-Proofpoint-GUID: nsYo-WGgthXsLrLHgLHJU2HTTYNHRnmL
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA3MDA5NSBTYWx0ZWRfX+N2WqjZAXCGG
 m2yUnZ6fjEBH4oZK3fjE+6kf/Z6sk02kZtTHlsTSvclAupTvILYGuOoiPoJrkgi4noRQj2V4gTR
 tMZswvalKmSR00WYkfnQiScBGR3RQKI=
X-Authority-Analysis: v=2.4 cv=KcdHIgYD c=1 sm=1 tr=0 ts=6ac6ddd6 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=p0WdMEafAAAA:8
 a=pGLkceISAAAA:8 a=isydLfZ-Rj6rRkjCDxsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-07_07,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0
 phishscore=0 priorityscore=1501 clxscore=1015 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610070095
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

On 10/7/2026 5:00 PM, Pierrick Bouvier wrote:
> On 10/7/2026 2:42 PM, Yonggang Luo wrote:
>> On Thu, Oct 8, 2026 at 4:44 AM Pierrick Bouvier
>> <pierrick.bouvier@oss.qualcomm.com> wrote:
>>>
>>> On 10/7/2026 4:48 AM, Yonggang Luo wrote:
>>>> Change TypeInfo.is_available to the new TypeIsAvailable type, which
>>>> takes a const TargetInfo *. Registration passes target_info(), so
>>>> behavior is unchanged. object.h only forward-declares TargetInfo.
>>>>
>>>> Switch the existing users (raspi, raspi4b, ast27x0 evb and fc) and the
>>>> generated machine parents to the matching target_is_<arch> helpers.
>>>>
>>>> Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
>>>> ---
>>>>  hw/arm/aspeed_ast27x0-fc.c  |  2 +-
>>>>  hw/arm/aspeed_ast27x0_evb.c |  4 ++--
>>>>  hw/arm/raspi.c              |  4 ++--
>>>>  hw/arm/raspi4b.c            |  2 +-
>>>>  hw/arm/virt.c               |  4 ++--
>>>>  hw/m68k/virt.c              |  4 ++--
>>>>  hw/or1k/virt.c              |  2 +-
>>>>  include/qom/object.h        | 12 +++++++++++-
>>>>  qom/object.c                |  3 ++-
>>>>  9 files changed, 24 insertions(+), 13 deletions(-)
>>>>
>>>> diff --git a/hw/arm/aspeed_ast27x0-fc.c b/hw/arm/aspeed_ast27x0-fc.c
>>>> index 73362b60d2a..8a7c6a116ac 100644
>>>> --- a/hw/arm/aspeed_ast27x0-fc.c
>>>> +++ b/hw/arm/aspeed_ast27x0-fc.c
>>>> @@ -234,7 +234,7 @@ static const TypeInfo ast2700fc_types[] = {
>>>>          .parent         = TYPE_MACHINE,
>>>>          .class_init     = ast2700fc_class_init,
>>>>          .instance_size  = sizeof(Ast2700FCState),
>>>> -        .is_available   = target_aarch64,
>>>> +        .is_available   = target_is_aarch64,
>>>>      },
>>>>  };
>>>>
>>>> diff --git a/hw/arm/aspeed_ast27x0_evb.c b/hw/arm/aspeed_ast27x0_evb.c
>>>> index 460c9ff0d2e..02a8cff1d9d 100644
>>>> --- a/hw/arm/aspeed_ast27x0_evb.c
>>>> +++ b/hw/arm/aspeed_ast27x0_evb.c
>>>> @@ -75,13 +75,13 @@ static const TypeInfo aspeed_ast27x0_evb_types[] = {
>>>>          .name          = MACHINE_TYPE_NAME("ast2700a1-evb"),
>>>>          .parent        = TYPE_ASPEED_MACHINE,
>>>>          .class_init    = aspeed_machine_ast2700a1_evb_class_init,
>>>> -        .is_available  = target_aarch64,
>>>> +        .is_available  = target_is_aarch64,
>>>>      },
>>>>      {
>>>>          .name          = MACHINE_TYPE_NAME("ast2700a2-evb"),
>>>>          .parent        = TYPE_ASPEED_MACHINE,
>>>>          .class_init    = aspeed_machine_ast2700a2_evb_class_init,
>>>> -        .is_available  = target_aarch64,
>>>> +        .is_available  = target_is_aarch64,
>>>>      }
>>>>  };
>>>>
>>>> diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
>>>> index fadbacb2534..22b06c6ca22 100644
>>>> --- a/hw/arm/raspi.c
>>>> +++ b/hw/arm/raspi.c
>>>> @@ -403,12 +403,12 @@ static const TypeInfo raspi_machine_types[] = {
>>>>          .name           = MACHINE_TYPE_NAME("raspi3ap"),
>>>>          .parent         = TYPE_RASPI_MACHINE,
>>>>          .class_init     = raspi3ap_machine_class_init,
>>>> -        .is_available   = target_aarch64,
>>>> +        .is_available   = target_is_aarch64,
>>>>      }, {
>>>>          .name           = MACHINE_TYPE_NAME("raspi3b"),
>>>>          .parent         = TYPE_RASPI_MACHINE,
>>>>          .class_init     = raspi3b_machine_class_init,
>>>> -        .is_available   = target_aarch64,
>>>> +        .is_available   = target_is_aarch64,
>>>>      }, {
>>>>          .name           = TYPE_RASPI_MACHINE,
>>>>          .parent         = TYPE_RASPI_BASE_MACHINE,
>>>> diff --git a/hw/arm/raspi4b.c b/hw/arm/raspi4b.c
>>>> index 566d64572db..a1dc477f25e 100644
>>>> --- a/hw/arm/raspi4b.c
>>>> +++ b/hw/arm/raspi4b.c
>>>> @@ -121,7 +121,7 @@ static const TypeInfo raspi4b_machine_type = {
>>>>      .parent         = TYPE_RASPI_BASE_MACHINE,
>>>>      .instance_size  = sizeof(Raspi4bMachineState),
>>>>      .class_init     = raspi4b_machine_class_init,
>>>> -    .is_available   = target_aarch64,
>>>> +    .is_available   = target_is_aarch64,
>>>>  };
>>>>
>>>>  static void raspi4b_machine_register_type(void)
>>>> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
>>>> index 9d192515d85..18160f7fad3 100644
>>>> --- a/hw/arm/virt.c
>>>> +++ b/hw/arm/virt.c
>>>> @@ -132,7 +132,7 @@ static void arm_virt_compat_default_set(MachineClass *mc)
>>>>          .name = MACHINE_VER_TYPE_NAME("virt", __VA_ARGS__), \
>>>>          .parent = TYPE_VIRT_MACHINE, \
>>>>          .class_init = MACHINE_VER_SYM(class_init, virt, __VA_ARGS__), \
>>>> -        .is_available = target_base_arm, \
>>>> +        .is_available = target_is_base_arm, \
>>>>      }; \
>>>>      static void MACHINE_VER_SYM(register, virt, __VA_ARGS__)(void) \
>>>>      { \
>>>> @@ -4430,7 +4430,7 @@ static const TypeInfo virt_machine_info = {
>>>>           { TYPE_HOTPLUG_HANDLER },
>>>>           { }
>>>>      },
>>>> -    .is_available = target_base_arm,
>>>> +    .is_available = target_is_base_arm,
>>>>  };
>>>>
>>>>  static void machvirt_machine_init(void)
>>>> diff --git a/hw/m68k/virt.c b/hw/m68k/virt.c
>>>> index e52546e4fab..ad2a43ef3fb 100644
>>>> --- a/hw/m68k/virt.c
>>>> +++ b/hw/m68k/virt.c
>>>> @@ -327,7 +327,7 @@ static const TypeInfo virt_machine_info = {
>>>>      .parent       = TYPE_MACHINE,
>>>>      .abstract     = true,
>>>>      .class_init   = virt_machine_class_init,
>>>> -    .is_available = target_m68k,
>>>> +    .is_available = target_is_m68k,
>>>>  };
>>>>
>>>>  static void virt_machine_register_types(void)
>>>> @@ -355,7 +355,7 @@ type_init(virt_machine_register_types)
>>>>          .name = MACHINE_VER_TYPE_NAME("virt", __VA_ARGS__), \
>>>>          .parent = MACHINE_TYPE_NAME("virt"), \
>>>>          .class_init = MACHINE_VER_SYM(class_init, virt, __VA_ARGS__), \
>>>> -        .is_available = target_m68k, \
>>>> +        .is_available = target_is_m68k, \
>>>>      }; \
>>>>      static void MACHINE_VER_SYM(register, virt, __VA_ARGS__)(void) \
>>>>      { \
>>>> diff --git a/hw/or1k/virt.c b/hw/or1k/virt.c
>>>> index a3ff903839b..89fb786641f 100644
>>>> --- a/hw/or1k/virt.c
>>>> +++ b/hw/or1k/virt.c
>>>> @@ -559,7 +559,7 @@ static const TypeInfo or1ksim_machine_typeinfo = {
>>>>      .parent     = TYPE_MACHINE,
>>>>      .class_init = openrisc_virt_machine_init,
>>>>      .instance_size = sizeof(OR1KVirtState),
>>>> -    .is_available = target_or1k,
>>>> +    .is_available = target_is_or1k,
>>>>  };
>>>>
>>>>  static void or1ksim_machine_init_register_types(void)
>>>> diff --git a/include/qom/object.h b/include/qom/object.h
>>>> index 4c0645817a5..7d52a15f6b8 100644
>>>> --- a/include/qom/object.h
>>>> +++ b/include/qom/object.h
>>>> @@ -17,6 +17,7 @@
>>>>  #include "qapi/qapi-builtin-types.h"
>>>>  #include "qemu/module.h"
>>>>
>>>> +typedef struct TargetInfo TargetInfo;
>>>>  struct TypeImpl;
>>>>  typedef struct TypeImpl *Type;
>>>>
>>>> @@ -117,6 +118,15 @@ typedef void (ObjectUnparent)(Object *obj);
>>>>   */
>>>>  typedef void (ObjectFree)(void *obj);
>>>>
>>>> +/**
>>>> + * typedef TypeIsAvailable:
>>>> + * @ti: TargetInfo to test.
>>>> + *
>>>> + * Returns whether a type is available for @ti. Typical implementations
>>>> + * are target_is_*().
>>>> + */
>>>> +typedef bool (TypeIsAvailable)(const TargetInfo *ti);
>>>> +
>>>>  #define OBJECT_CLASS_CAST_CACHE 4
>>>>
>>>>  /**
>>>> @@ -498,7 +508,7 @@ struct TypeInfo
>>>>      void (*class_base_init)(ObjectClass *klass, const void *data);
>>>>      const void *class_data;
>>>>
>>>> -    bool (*is_available)(void);
>>>> +    TypeIsAvailable *is_available;
>>>>      const InterfaceInfo *interfaces;
>>>>  };
>>>>
>>>> diff --git a/qom/object.c b/qom/object.c
>>>> index 96498f3d001..253b9562b41 100644
>>>> --- a/qom/object.c
>>>> +++ b/qom/object.c
>>>> @@ -15,6 +15,7 @@
>>>>  #include "qom/compat-properties.h"
>>>>  #include "qom/object.h"
>>>>  #include "qom/object_interfaces.h"
>>>> +#include "qemu/target-info.h"
>>>>  #include "qemu/cutils.h"
>>>>  #include "qemu/memalign.h"
>>>>  #include "qapi/visitor.h"
>>>> @@ -167,7 +168,7 @@ static TypeImpl *type_register_internal(const TypeInfo *info)
>>>>          abort();
>>>>      }
>>>>
>>>> -    if (info->is_available && !info->is_available()) {
>>>> +    if (info->is_available && !info->is_available(target_info())) {
>>>>          return NULL;
>>>>      }
>>>>
>>>
>>> ```
>>> info->is_available(target_info())
>>> ```
>>>
>>> or
>>>
>>> ```
>>> is_available() {
>>>   TargetInfo ti * = target_info();
>>>   ...
>>> }
>>> ```
>>>
>>> Are doing the exact same thing today.
>>>
>>> So what is the future goal requiring to introduce this?
>>
>> From Daniel P. Berrangé's
>> requesthttps://lore.kernel.org/qemu-devel/apAszS1ewxM0Y1XU@redhat.com/
>>         I forgot to mention that this is also pretty important for making
>>         introspection work, as we need to be able to say
>>
>>           'qemu-system --machine none -qmp ...'
>>
>>         and connect to QMP to introspect the binary. Having to add a
>>         '--target <name>' into that mix is undesirable, as it creates
>>         a chicken & egg problem. You don't know what targets are built
>>         into qemu-system without introspecting it and you can't
>>         introspect it without selecting a target to introspect.
>>
>> From Pierrick's review
>> https://lore.kernel.org/qemu-devel/557262df-b8e7-49b5-a245-ae46b8885b30@oss.qualcomm.com/So,
>> for existing binary: -M virt works as before.
>>
>>         For new multi binary:
>>         $ qemu-system -M virt:
>>         Multiple machines were found, select one among:
>>         - aarch64-virt
>>         - riscv64-virt
>>
>>         Does it matches what you would expect?
>>
>> From Daniel's review
>> https://lore.kernel.org/qemu-devel/aro93NuZBXYGbD33@redhat.com/
>>         We already have  'QemuTargetInfo' struct which is used
>>         with 'query-target', that should also be used with the
>>         new 'query-targets' command.
>>
>>         We need to add the 'endianness' field to QemuTargetInfo.
>>
>>         I don't think that we need to report machines though.
>>         We already have 'query-machines' which gives much broader
>>         information on the machines. "MachineInfo" needs to
>>         gain
>>
>>         "targets": ["SysEmuTarget"]
>>
>>         to list which target(s) a machine can be used with.
>>
>>
>> To achieve these, we needs add TypeInfo parameter to it so that we can do
>>
>> static void report_unsupported_machine_type(const char *name, Error **errp)
>> {
>>     g_autoptr(GSList) machines = machine_class_get_list(true);
>>     g_autoptr(GString) targets = g_string_new(NULL);
>>     TargetInfoNode *node;
>>     GSList *el;
>>
>>     error_setg(errp, "unsupported machine type: \"%s\" for target \"%s\"",
>>                name, target_name());
>>     QLIST_FOREACH(node, target_info_list(), next) {
>>         for (el = machines; el; el = el->next) {
>>             MachineClass *mc = el->data;
>>
>>             if ((!strcmp(mc->name, name) || !g_strcmp0(mc->alias, name)) &&
>>                 object_class_get_is_available(OBJECT_CLASS(mc))(node->info)) {
>>                 g_string_append_printf(targets, "  %s\n",
>>                                        node->info->target_name);
>>                 break;
>>             }
>>         }
>>     }
>>     if (targets->len) {
>>         error_append_hint(errp, "Available for targets:\n%s", targets->str);
>>     }
>> }
>>
>> That is we can iterate on all target-list, and check if it's can be fitlered.
>>
> 
> Ok, I finally see where this is going.
> 
> So, based on all the previous conversations, we agreed to have a
> qemu-system binary with all the QOM types available (for all targets).
> 
> I personally think that if we go this way, we should not have any
> -target option, and even less a -target none option.
> 
> The current is_available() approach was made with filtering per target
> in mind, which predates where things are now. So, it's a good time to
> reevaluate how to do it.
> 
> This leaves us with (at least) two options:
> - keep the callback and add TargetInfo parameter (what is done here)
> - remove is_available, and adopt a more declarative approach
> 
> How about we (re)-explore the second one?
> 
> It's what we did in the past
> (https://gitlab.com/qemu-project/qemu/-/commit/5de9216064d32eaac125dac4de1878486c16d73e),
> and that I removed recently, in favor of is_available.
> My rationale was that it was incomplete, since we needed to filter types
> per config also, and not only target.
> Now that direction is to not filter anything, filter per config is
> unneeded, and switching back to declarative instead of callback makes
> total sense. Using interfaces like we did has its own issues, and I
> would not like to see this coming back.
> 
> I'll do one very concrete proposal:
> 
> ```
> How about letting machines (and machines only first), have a new field
> 'targets', being a uint32_t mask with an array of EMU_TARGET?
> machine->targets = EMU_TARGET_X | EMU_TARGET_Y;
> ```
>

Machine class more exactly: mc->targets
See mc->desc for a concrete example of where it should be set.

> @Daniel, IIUC, this is exactly the approach you proposed a few weeks
> ago, just before I got frustrated and lost my patience against you. I
> think it's more clear for me where you wanted to go. Sorry it took such
> a large detour.
> 
> Yonggang, does that sounds good for you?
> Daniel, does that sounds good for you also?
> 
> Regards,
> Pierrick


