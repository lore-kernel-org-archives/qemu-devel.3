Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26856CA6002
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2026 00:01:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEbYb-0008VK-C9; Wed, 07 Oct 2026 20:00:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xEbYY-0008Uy-4X
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 20:00:18 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xEbYV-0005Dg-3n
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 20:00:17 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 697M2UKw868109
 for <qemu-devel@nongnu.org>; Thu, 8 Oct 2026 00:00:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 vFAvB59rWae5boVLoincpVpKFZPDOupemCLENOZh+Co=; b=As8cvV8AwmwdjIeT
 So9Uml8GfJl6lIcodPj1AOuBrsGD5e4tBrfihoVzNxwCbW+QlD2niL47rP/KOFCB
 qJJpoyanVDb5eQAZv1v9Nsw/UlHzHl7scukUcNXbPv0E0FQoUoHhlpp7tX+2uG4Y
 Vxhmn1YueI5l6U0w9TapfhsS3P4Rx71CrFltkGyhDFeTEb6epnw3s1NO+w5DUlLo
 fhEEd+JPXoYKV3/2LaM+wJBx0W5NThGk3Rdm4lHHxDlFos1hV8ai6scQP9qYOAwC
 08dAW4dm4gZeyaJ7eDTcVzW9puccGzUse2ugAle4jgaM9/5p4dx7VE9v5ewTfwTM
 lpJXVA==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h5xe3gcg2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 08 Oct 2026 00:00:13 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-3510562ef98so6150728eec.0
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2026 17:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791417612; x=1792022412; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=vFAvB59rWae5boVLoincpVpKFZPDOupemCLENOZh+Co=;
 b=DQe/o03Ac9dGgX5vfGpJ7t9lfXYpdtU+rOzUZ5iFjyGmkNH5KVepK0oRuhRSmn/KkZ
 vJ7tBmouIV7DD877VdReFx6OKVY5+bbpJEZWlwFAUIUe4/SlBWGm+9Fm87ZJYu9InPxd
 uzFyjM9M/s4i+4tdF5UXE2/HOGyP4TrTg9QgzdLyVc4ckpc97oWdXCcXAFxxNM3rNBMb
 HuW2gVGCLkRo/VhfYjh2FR3/RJR7z8jzcTXG9kaA7SSXsWLxH5oLQckku2+Mbb8hARvb
 gr0gM0MhdSkcwBnZr0d0rdSQIOO079DCTtVwj+/0I5sWS9x+KqZU7oS2o8l7Zc1BCe93
 4uqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791417612; x=1792022412;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vFAvB59rWae5boVLoincpVpKFZPDOupemCLENOZh+Co=;
 b=PcX5JatzUypV71eF57c/2CtRC3YbT10vyqQQw2Wit+AmtFpwvZxap5VQJfpHoJ/tXp
 xixlczkLq7yj9UfAgF6zcme1Y2viuKB/EmoyJtfsXqYJasB2jbuGtIkNUuWuxKX8xGv/
 z3DWFi1eMIZhBkNzGC2h1sjJfoPdYWY4qxlkfL9H0dm1QyLZtOfEii3HfWuAZmlh+l3i
 PT0VHtPp1bs9pWZZn5s6NAvvjYj8ew/ZYr7/R7kHwoPd78vAYJPJkjUHDi8Vh5aVD9Qt
 7cB8CKT+/uCCS+LTcHBdrw66LgiaGH5yhVP/c4vkZ/UFYlP5LcfkI8+qkCX78DD38jUS
 ryoQ==
X-Gm-Message-State: AFuF++ndIs7Eh62+uPc04XKykQuEFQHa/bAiXmuh2Z1al5ctZDSsvZH+
 meL+HN3O9bXTilsIV5IWr51m42M/azQi75JSSldOcWn5WBWHJ8VoIxF0q4tduq8V5Vi8OrNK7y8
 6W4PLJJLTfhiLo7WJzo78pe6QtpKmMo+H4RzD7L2HU+dU62W82sP8I9g2aA==
X-Gm-Gg: AYBFou18zoI4MUSKU0S2UELqjLjuK5PHDJx02byp2rw2VaLe6efcE9Y+m+6Te3F3UCJ
 jRbrxUYObqKXCTDa0rsfbP/K6/JFBm6Y0TTH+yGnZGsz5HMtFvPIL1QqUGGzL/SbduAEGrM9IkM
 jXL2hPpwMiLqaRXr5Hgb+nHR0PXxskQ//xGIPDPBObR+OBr19OBrPom/2QdRk3DVRA1o1kv+bPW
 +OE0xvBQAxyGDloZJht7UOtHrdEwKNDNgizZ4pKvERwGrrO8x4kSfAaUbS89dGQlXViLe/69pmA
 4jNY+eUXfr1oweLfaVQg1HqWx9rHda48omDoOyOsJ7qK/H73n9hXfNA4Iyx2fieE2GoEZWcrCDS
 QL35lZkocTulQVPsEajXIKtX9ORxmTuHKfWJKWRCshL/SMAaf8a3l1BuaYdgJBXpMYI0E0A==
X-Received: by 2002:a05:693c:4159:20b0:351:4a80:d94c with SMTP id
 5a478bee46e88-3515ddec552mr4876772eec.21.1791417610836; 
 Wed, 07 Oct 2026 17:00:10 -0700 (PDT)
X-Received: by 2002:a05:693c:4159:20b0:351:4a80:d94c with SMTP id
 5a478bee46e88-3515ddec552mr4876629eec.21.1791417609363; 
 Wed, 07 Oct 2026 17:00:09 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3515af26f10sm11817604eec.13.2026.10.07.17.00.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Oct 2026 17:00:08 -0700 (PDT)
Message-ID: <b2d89a92-0197-4873-b4ea-75bb21c0d0ae@oss.qualcomm.com>
Date: Wed, 7 Oct 2026 17:00:06 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/8] qom: pass TargetInfo to is_available for later use
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
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <CAE2XoE8K+3e8h6H9NrPk1WWMmJfG807bN_Kh5qje-5pKWUUg5w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=NchzRGD4 c=1 sm=1 tr=0 ts=6ac6dd0d cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=p0WdMEafAAAA:8
 a=pGLkceISAAAA:8 a=UHNr_4ddF-MpCdtsS6kA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA3MDA5NSBTYWx0ZWRfX1DX4dx0yPNX9
 MiooDM2OLBLXgMDPyf36cKr/GF4FSjTeouJdlleRrcJcSScNFGsymRayy8ozFwlJoDMwj3MQEJC
 Yu52+cv2BSUavCq422vDOwoioDnaSRg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA3MDA5NSBTYWx0ZWRfX7ghthNmqn+Fn
 V3teWKKFpbNqdzMLxxS48plHs/fAVjX+dOg1Zt0kq5TPu4mTDX6mhVlREzR4d2HFdWwNfEQ6GgO
 DPaBC0hT8Q+21ziKCyhyIYtnf3k1IEV2t3Sz+687bXpiOweNUKky1md+5paWx11/ilCw++bhKlU
 3eH6NVxi4Htp/YH9PbYG91HEnBYmBeEwyyRHPOBDDvFQhvRFPvSffCbKKCHLqniqVK5o7oO7iRi
 PcGU1rUrvrvdnJKz+HvxMboeB8d0P1G+z98jD07sVaxtsdr+48geZVeYd90UfYJ/nEGzdQAhwI/
 VuprnfclCyeNjdsgFTy2PaXrlk8DXi4GYx9RxUBHwXN6lS0EKWQUnIFSJZ5i7cZheJNN5v6EqVv
 n5cATamNYY2Dav4Z9V6hbANf+Un3+2lPIuXiR+wE1+C9XQsB/TGdV0fT2ryMbGx7HK/z6jUpkyH
 9FyqagayXKEGUG+Yj6g==
X-Proofpoint-ORIG-GUID: 7TRJrRUS8KYvOp4eCQZVufJaMdf-k4y2
X-Proofpoint-GUID: 7TRJrRUS8KYvOp4eCQZVufJaMdf-k4y2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-07_07,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 bulkscore=0 priorityscore=1501 spamscore=0
 malwarescore=0 adultscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610070095
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

On 10/7/2026 2:42 PM, Yonggang Luo wrote:
> On Thu, Oct 8, 2026 at 4:44 AM Pierrick Bouvier
> <pierrick.bouvier@oss.qualcomm.com> wrote:
>>
>> On 10/7/2026 4:48 AM, Yonggang Luo wrote:
>>> Change TypeInfo.is_available to the new TypeIsAvailable type, which
>>> takes a const TargetInfo *. Registration passes target_info(), so
>>> behavior is unchanged. object.h only forward-declares TargetInfo.
>>>
>>> Switch the existing users (raspi, raspi4b, ast27x0 evb and fc) and the
>>> generated machine parents to the matching target_is_<arch> helpers.
>>>
>>> Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
>>> ---
>>>  hw/arm/aspeed_ast27x0-fc.c  |  2 +-
>>>  hw/arm/aspeed_ast27x0_evb.c |  4 ++--
>>>  hw/arm/raspi.c              |  4 ++--
>>>  hw/arm/raspi4b.c            |  2 +-
>>>  hw/arm/virt.c               |  4 ++--
>>>  hw/m68k/virt.c              |  4 ++--
>>>  hw/or1k/virt.c              |  2 +-
>>>  include/qom/object.h        | 12 +++++++++++-
>>>  qom/object.c                |  3 ++-
>>>  9 files changed, 24 insertions(+), 13 deletions(-)
>>>
>>> diff --git a/hw/arm/aspeed_ast27x0-fc.c b/hw/arm/aspeed_ast27x0-fc.c
>>> index 73362b60d2a..8a7c6a116ac 100644
>>> --- a/hw/arm/aspeed_ast27x0-fc.c
>>> +++ b/hw/arm/aspeed_ast27x0-fc.c
>>> @@ -234,7 +234,7 @@ static const TypeInfo ast2700fc_types[] = {
>>>          .parent         = TYPE_MACHINE,
>>>          .class_init     = ast2700fc_class_init,
>>>          .instance_size  = sizeof(Ast2700FCState),
>>> -        .is_available   = target_aarch64,
>>> +        .is_available   = target_is_aarch64,
>>>      },
>>>  };
>>>
>>> diff --git a/hw/arm/aspeed_ast27x0_evb.c b/hw/arm/aspeed_ast27x0_evb.c
>>> index 460c9ff0d2e..02a8cff1d9d 100644
>>> --- a/hw/arm/aspeed_ast27x0_evb.c
>>> +++ b/hw/arm/aspeed_ast27x0_evb.c
>>> @@ -75,13 +75,13 @@ static const TypeInfo aspeed_ast27x0_evb_types[] = {
>>>          .name          = MACHINE_TYPE_NAME("ast2700a1-evb"),
>>>          .parent        = TYPE_ASPEED_MACHINE,
>>>          .class_init    = aspeed_machine_ast2700a1_evb_class_init,
>>> -        .is_available  = target_aarch64,
>>> +        .is_available  = target_is_aarch64,
>>>      },
>>>      {
>>>          .name          = MACHINE_TYPE_NAME("ast2700a2-evb"),
>>>          .parent        = TYPE_ASPEED_MACHINE,
>>>          .class_init    = aspeed_machine_ast2700a2_evb_class_init,
>>> -        .is_available  = target_aarch64,
>>> +        .is_available  = target_is_aarch64,
>>>      }
>>>  };
>>>
>>> diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
>>> index fadbacb2534..22b06c6ca22 100644
>>> --- a/hw/arm/raspi.c
>>> +++ b/hw/arm/raspi.c
>>> @@ -403,12 +403,12 @@ static const TypeInfo raspi_machine_types[] = {
>>>          .name           = MACHINE_TYPE_NAME("raspi3ap"),
>>>          .parent         = TYPE_RASPI_MACHINE,
>>>          .class_init     = raspi3ap_machine_class_init,
>>> -        .is_available   = target_aarch64,
>>> +        .is_available   = target_is_aarch64,
>>>      }, {
>>>          .name           = MACHINE_TYPE_NAME("raspi3b"),
>>>          .parent         = TYPE_RASPI_MACHINE,
>>>          .class_init     = raspi3b_machine_class_init,
>>> -        .is_available   = target_aarch64,
>>> +        .is_available   = target_is_aarch64,
>>>      }, {
>>>          .name           = TYPE_RASPI_MACHINE,
>>>          .parent         = TYPE_RASPI_BASE_MACHINE,
>>> diff --git a/hw/arm/raspi4b.c b/hw/arm/raspi4b.c
>>> index 566d64572db..a1dc477f25e 100644
>>> --- a/hw/arm/raspi4b.c
>>> +++ b/hw/arm/raspi4b.c
>>> @@ -121,7 +121,7 @@ static const TypeInfo raspi4b_machine_type = {
>>>      .parent         = TYPE_RASPI_BASE_MACHINE,
>>>      .instance_size  = sizeof(Raspi4bMachineState),
>>>      .class_init     = raspi4b_machine_class_init,
>>> -    .is_available   = target_aarch64,
>>> +    .is_available   = target_is_aarch64,
>>>  };
>>>
>>>  static void raspi4b_machine_register_type(void)
>>> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
>>> index 9d192515d85..18160f7fad3 100644
>>> --- a/hw/arm/virt.c
>>> +++ b/hw/arm/virt.c
>>> @@ -132,7 +132,7 @@ static void arm_virt_compat_default_set(MachineClass *mc)
>>>          .name = MACHINE_VER_TYPE_NAME("virt", __VA_ARGS__), \
>>>          .parent = TYPE_VIRT_MACHINE, \
>>>          .class_init = MACHINE_VER_SYM(class_init, virt, __VA_ARGS__), \
>>> -        .is_available = target_base_arm, \
>>> +        .is_available = target_is_base_arm, \
>>>      }; \
>>>      static void MACHINE_VER_SYM(register, virt, __VA_ARGS__)(void) \
>>>      { \
>>> @@ -4430,7 +4430,7 @@ static const TypeInfo virt_machine_info = {
>>>           { TYPE_HOTPLUG_HANDLER },
>>>           { }
>>>      },
>>> -    .is_available = target_base_arm,
>>> +    .is_available = target_is_base_arm,
>>>  };
>>>
>>>  static void machvirt_machine_init(void)
>>> diff --git a/hw/m68k/virt.c b/hw/m68k/virt.c
>>> index e52546e4fab..ad2a43ef3fb 100644
>>> --- a/hw/m68k/virt.c
>>> +++ b/hw/m68k/virt.c
>>> @@ -327,7 +327,7 @@ static const TypeInfo virt_machine_info = {
>>>      .parent       = TYPE_MACHINE,
>>>      .abstract     = true,
>>>      .class_init   = virt_machine_class_init,
>>> -    .is_available = target_m68k,
>>> +    .is_available = target_is_m68k,
>>>  };
>>>
>>>  static void virt_machine_register_types(void)
>>> @@ -355,7 +355,7 @@ type_init(virt_machine_register_types)
>>>          .name = MACHINE_VER_TYPE_NAME("virt", __VA_ARGS__), \
>>>          .parent = MACHINE_TYPE_NAME("virt"), \
>>>          .class_init = MACHINE_VER_SYM(class_init, virt, __VA_ARGS__), \
>>> -        .is_available = target_m68k, \
>>> +        .is_available = target_is_m68k, \
>>>      }; \
>>>      static void MACHINE_VER_SYM(register, virt, __VA_ARGS__)(void) \
>>>      { \
>>> diff --git a/hw/or1k/virt.c b/hw/or1k/virt.c
>>> index a3ff903839b..89fb786641f 100644
>>> --- a/hw/or1k/virt.c
>>> +++ b/hw/or1k/virt.c
>>> @@ -559,7 +559,7 @@ static const TypeInfo or1ksim_machine_typeinfo = {
>>>      .parent     = TYPE_MACHINE,
>>>      .class_init = openrisc_virt_machine_init,
>>>      .instance_size = sizeof(OR1KVirtState),
>>> -    .is_available = target_or1k,
>>> +    .is_available = target_is_or1k,
>>>  };
>>>
>>>  static void or1ksim_machine_init_register_types(void)
>>> diff --git a/include/qom/object.h b/include/qom/object.h
>>> index 4c0645817a5..7d52a15f6b8 100644
>>> --- a/include/qom/object.h
>>> +++ b/include/qom/object.h
>>> @@ -17,6 +17,7 @@
>>>  #include "qapi/qapi-builtin-types.h"
>>>  #include "qemu/module.h"
>>>
>>> +typedef struct TargetInfo TargetInfo;
>>>  struct TypeImpl;
>>>  typedef struct TypeImpl *Type;
>>>
>>> @@ -117,6 +118,15 @@ typedef void (ObjectUnparent)(Object *obj);
>>>   */
>>>  typedef void (ObjectFree)(void *obj);
>>>
>>> +/**
>>> + * typedef TypeIsAvailable:
>>> + * @ti: TargetInfo to test.
>>> + *
>>> + * Returns whether a type is available for @ti. Typical implementations
>>> + * are target_is_*().
>>> + */
>>> +typedef bool (TypeIsAvailable)(const TargetInfo *ti);
>>> +
>>>  #define OBJECT_CLASS_CAST_CACHE 4
>>>
>>>  /**
>>> @@ -498,7 +508,7 @@ struct TypeInfo
>>>      void (*class_base_init)(ObjectClass *klass, const void *data);
>>>      const void *class_data;
>>>
>>> -    bool (*is_available)(void);
>>> +    TypeIsAvailable *is_available;
>>>      const InterfaceInfo *interfaces;
>>>  };
>>>
>>> diff --git a/qom/object.c b/qom/object.c
>>> index 96498f3d001..253b9562b41 100644
>>> --- a/qom/object.c
>>> +++ b/qom/object.c
>>> @@ -15,6 +15,7 @@
>>>  #include "qom/compat-properties.h"
>>>  #include "qom/object.h"
>>>  #include "qom/object_interfaces.h"
>>> +#include "qemu/target-info.h"
>>>  #include "qemu/cutils.h"
>>>  #include "qemu/memalign.h"
>>>  #include "qapi/visitor.h"
>>> @@ -167,7 +168,7 @@ static TypeImpl *type_register_internal(const TypeInfo *info)
>>>          abort();
>>>      }
>>>
>>> -    if (info->is_available && !info->is_available()) {
>>> +    if (info->is_available && !info->is_available(target_info())) {
>>>          return NULL;
>>>      }
>>>
>>
>> ```
>> info->is_available(target_info())
>> ```
>>
>> or
>>
>> ```
>> is_available() {
>>   TargetInfo ti * = target_info();
>>   ...
>> }
>> ```
>>
>> Are doing the exact same thing today.
>>
>> So what is the future goal requiring to introduce this?
> 
> From Daniel P. Berrangé's
> requesthttps://lore.kernel.org/qemu-devel/apAszS1ewxM0Y1XU@redhat.com/
>         I forgot to mention that this is also pretty important for making
>         introspection work, as we need to be able to say
> 
>           'qemu-system --machine none -qmp ...'
> 
>         and connect to QMP to introspect the binary. Having to add a
>         '--target <name>' into that mix is undesirable, as it creates
>         a chicken & egg problem. You don't know what targets are built
>         into qemu-system without introspecting it and you can't
>         introspect it without selecting a target to introspect.
> 
> From Pierrick's review
> https://lore.kernel.org/qemu-devel/557262df-b8e7-49b5-a245-ae46b8885b30@oss.qualcomm.com/So,
> for existing binary: -M virt works as before.
> 
>         For new multi binary:
>         $ qemu-system -M virt:
>         Multiple machines were found, select one among:
>         - aarch64-virt
>         - riscv64-virt
> 
>         Does it matches what you would expect?
> 
> From Daniel's review
> https://lore.kernel.org/qemu-devel/aro93NuZBXYGbD33@redhat.com/
>         We already have  'QemuTargetInfo' struct which is used
>         with 'query-target', that should also be used with the
>         new 'query-targets' command.
> 
>         We need to add the 'endianness' field to QemuTargetInfo.
> 
>         I don't think that we need to report machines though.
>         We already have 'query-machines' which gives much broader
>         information on the machines. "MachineInfo" needs to
>         gain
> 
>         "targets": ["SysEmuTarget"]
> 
>         to list which target(s) a machine can be used with.
> 
> 
> To achieve these, we needs add TypeInfo parameter to it so that we can do
> 
> static void report_unsupported_machine_type(const char *name, Error **errp)
> {
>     g_autoptr(GSList) machines = machine_class_get_list(true);
>     g_autoptr(GString) targets = g_string_new(NULL);
>     TargetInfoNode *node;
>     GSList *el;
> 
>     error_setg(errp, "unsupported machine type: \"%s\" for target \"%s\"",
>                name, target_name());
>     QLIST_FOREACH(node, target_info_list(), next) {
>         for (el = machines; el; el = el->next) {
>             MachineClass *mc = el->data;
> 
>             if ((!strcmp(mc->name, name) || !g_strcmp0(mc->alias, name)) &&
>                 object_class_get_is_available(OBJECT_CLASS(mc))(node->info)) {
>                 g_string_append_printf(targets, "  %s\n",
>                                        node->info->target_name);
>                 break;
>             }
>         }
>     }
>     if (targets->len) {
>         error_append_hint(errp, "Available for targets:\n%s", targets->str);
>     }
> }
> 
> That is we can iterate on all target-list, and check if it's can be fitlered.
>

Ok, I finally see where this is going.

So, based on all the previous conversations, we agreed to have a
qemu-system binary with all the QOM types available (for all targets).

I personally think that if we go this way, we should not have any
-target option, and even less a -target none option.

The current is_available() approach was made with filtering per target
in mind, which predates where things are now. So, it's a good time to
reevaluate how to do it.

This leaves us with (at least) two options:
- keep the callback and add TargetInfo parameter (what is done here)
- remove is_available, and adopt a more declarative approach

How about we (re)-explore the second one?

It's what we did in the past
(https://gitlab.com/qemu-project/qemu/-/commit/5de9216064d32eaac125dac4de1878486c16d73e),
and that I removed recently, in favor of is_available.
My rationale was that it was incomplete, since we needed to filter types
per config also, and not only target.
Now that direction is to not filter anything, filter per config is
unneeded, and switching back to declarative instead of callback makes
total sense. Using interfaces like we did has its own issues, and I
would not like to see this coming back.

I'll do one very concrete proposal:

```
How about letting machines (and machines only first), have a new field
'targets', being a uint32_t mask with an array of EMU_TARGET?
machine->targets = EMU_TARGET_X | EMU_TARGET_Y;
```

@Daniel, IIUC, this is exactly the approach you proposed a few weeks
ago, just before I got frustrated and lost my patience against you. I
think it's more clear for me where you wanted to go. Sorry it took such
a large detour.

Yonggang, does that sounds good for you?
Daniel, does that sounds good for you also?

Regards,
Pierrick

