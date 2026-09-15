Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 032E9C88E7D
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 17:50:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6XIC-0004tx-B9; Tue, 15 Sep 2026 13:50:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x6XIA-0004st-DR
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 13:50:02 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x6XI8-0002ed-5T
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 13:50:02 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68FHKKFN3861379
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 17:49:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 rfHKThWM88KH58HWx9K+NlPRj8d8zOLmzbnt/AkRfrs=; b=VLQgs/mHiZ2XNpKp
 unGTdC7WuL+GG5zIywX/iWVVOivQFkAxn2yRHIS4MKKz5sVqdD/ySPzhVie49YzR
 iTxoNqH9QoVHeMb1HhGlFFDqwZbv7LxplmofcRBOG6A9KNiYW1XfqLs8UB0Nzhww
 eikf2AkvZi41mdqlN18j5928KVCavLfoFkZiqk/BckSnB7m+NvUsOncjPL3Dz3ep
 TfG0wmTDMp51GL7siFFFTLkLrvbxqQbVj9NsVxV5i1wwZmY+7giDMQdVDlb29ljj
 3pW7Z44MQdMLPGSest93NDnLn8qDKdff3dnGhbBVC422PpPAvfOBSnjX8uBhXExg
 p8At5A==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gpxydbcq3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 17:49:55 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-395543dc382so6391826a91.0
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 10:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789494590; x=1790099390; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=rfHKThWM88KH58HWx9K+NlPRj8d8zOLmzbnt/AkRfrs=;
 b=JBLPlVgMayVrsjs5E8XMW6Nf1nu5v+f8f0OKh2rtEFB4n2mq35RwtR9DoLb18bxTX9
 NRBwKpwJMDn3kTzntTVvv6u2LFVdzJPgS6SQp0pGGGPaubrgzh1B6KBboKS0+kltDr5c
 i798ML+qybOGLjVZwhIS3e6W4peRwv0xx+QqZiFgthTQIWgwsClDhAmibpkfPDIrUzdX
 BuVVgC3fzPofpz6KZnsMzV14Vs6ovb4YLKa3Aq3+853Odd51zN0QaHEEhlt7w4jjc9c9
 hyv5WZrl3oOdgNo/InviHZ1tIuFIlacMFpy+0nosGABCEaDMRYHhzgsl3urFvo97IUbU
 Y8eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789494590; x=1790099390;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rfHKThWM88KH58HWx9K+NlPRj8d8zOLmzbnt/AkRfrs=;
 b=GAvMd+l1Y6Rq5hQJNf1D3B61wAW+Ol+ddoF41gjNKOi9Hc/wkoKjS4HtA48cnEvSic
 LHm3dqp6P7Reuet9BTgxAYDY70SqTvJSZHt/azAH8EVWHJPMjEg+hWgMk98HR64STZS1
 EelUv9xqXNd0OjQdTWAgKCXM+YnGLxrDjn7bpNW2HF3d7OUMRsuoIaFcyldaZNLiXy/B
 Wt8uG5nYexWip4xRZhLRRX6+i2ZWMHfQNW0a2OLHwUDv+s4jyWv573ewtEa99PvEz0J6
 in57Y1S7iYUUolrvM3GivcO6+P+AMacBNRkblfvpok2cgGCcKhOI+xnzpl8GjhVIedJV
 OfjA==
X-Gm-Message-State: AFuF++mVxN+AkTuzhnJAifX7LenK/ITldWjCSI+Q1203OiLcFtjs+qi4
 b3SA7iqYbk+PeMqOQgMgeDbdv5tXTJ15+kWNfopi371qlxWjIKZzvipAatx6acC6cPKYvsuMisX
 russnUtbXyzYv8ty40+LPhwTKbXL6iZMFMOuTa+28WG4Mz1o8wDbTfVQkAw==
X-Gm-Gg: AYBFou2kd5h3yTkZqcqBUEtpK7MYp/E2MXQHVGXmdUW+uAntNQ/TnKgqUHtk9NmEvt6
 nTFYYDmMgh0tZjIcX8yDvzoyTuo0h+Ijrqer8Vb+CAowYnit8biwU5JzfCeA4InRzWpipsyebmA
 KKJjASdyJHAa9Ge4zMmtw0qQGLZETFedAaXY8Kz3ftpL98yM/5HyqvqaVClFzKB+3730PriIrY/
 IHsgRiqmSayqZBt1Q64fbCLsDoIvjWibMAio7gM90zie9eC4oiZ0RDjmk5kXdebZxFeT3Fhxs3z
 WeAYCL1gSxAoogAqYEbXdRMS0vuo9dqg/XatpR+IbW2LR13L5MY4jCwekhxVlZkzLfPXwETrLrM
 59g+s/1oWaWD6SLW9+0gGHnlsFfZLKau3Q9ClT+76VpWQwqtniZyvWppSG3k2qvyw55e/
X-Received: by 2002:a17:90b:3883:b0:398:a486:81ec with SMTP id
 98e67ed59e1d1-39debfb91b9mr14822555a91.11.1789494589744; 
 Tue, 15 Sep 2026 10:49:49 -0700 (PDT)
X-Received: by 2002:a17:90b:3883:b0:398:a486:81ec with SMTP id
 98e67ed59e1d1-39debfb91b9mr14822496a91.11.1789494589216; 
 Tue, 15 Sep 2026 10:49:49 -0700 (PDT)
Received: from [192.168.1.199] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14395d5d0f3sm296305c88.12.2026.09.15.10.49.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Sep 2026 10:49:48 -0700 (PDT)
Message-ID: <700467b2-f9a9-4192-aaeb-bcd3dd0dc6b7@oss.qualcomm.com>
Date: Tue, 15 Sep 2026 10:49:46 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/9] tests/docker: add container registry to configure and
 use
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Brad Smith <brad@comstyle.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Song Gao <gaosong@loongson.cn>,
 Warner Losh <imp@bsdimp.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Cornelia Huck <cohuck@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 John Snow <jsnow@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Thomas Huth <th.huth+qemu@posteo.eu>,
 Brian Cain <brian.cain@oss.qualcomm.com>, qemu-arm@nongnu.org,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Kyle Evans <kevans@freebsd.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Cleber Rosa <crosa@redhat.com>
References: <20260910181504.1010916-1-alex.bennee@linaro.org>
 <20260910181504.1010916-6-alex.bennee@linaro.org>
 <abacad10-b9af-4a39-93c9-14b882f60bea@oss.qualcomm.com>
 <87qziw1ebt.fsf@draig.linaro.org>
 <9999cc6c-04e4-4507-beb0-5856bf614333@oss.qualcomm.com>
 <87zexia19c.fsf@draig.linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <87zexia19c.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE1MDI1NyBTYWx0ZWRfX/wcCbqmGEWDa
 H1hFHiAfOpY0J9tTIPpKNUtJCP+59rQme4wykwwqcXQvAhhQEMI7EeSx9hzghYltTG/oSTtNeVf
 hRhLwW53ZknZCJRCT740whO0lw8Atok=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE1MDI1NyBTYWx0ZWRfXzBMt3gPedGv0
 XPwZS9unoS8k7IGivfPCCEwYPLwe/N8jlP/gdcXUA9SCZS1lbtEwI9OTbjMp5d7utPwdikT0MOY
 09Kx7XWecSIynsKbOEf78MsZhEsg93ztEXM1jemTXmuTbouzVTqzWTewyDZZSWtS59N7DY/zPHV
 A+0F5D5Gxx+wuN5niFbBPCWutitponse1ooZuWwR1n6qDSDz3d2xW8yZeuyHznWXTn18GsSPMyV
 0FW/zaOBEcDdT2KOQJvs9UpXJ4iuqj2ST5ZjnUGoqP11AHKqbvhCBPQl0rzHYBliIxfGgKw+KoY
 USBqleI0d+Rh7f8rYm0r56iSJXYpprecuX0jVWthlDlha9dfse6tDz3cTbgLN8zqPUIhi6VIJbC
 VQkcsTFb12uO7Eh+8xU074IfCpVYE9JqXymf1SYghlV383MrPslH9uPLGz88IqVSO1ko64cN5Jv
 e/mgZa5Yyp7L4EYkZjA==
X-Proofpoint-ORIG-GUID: N2yU2c6yTd3VHNdwlPxQC-c415kPBU_I
X-Authority-Analysis: v=2.4 cv=LYepeTfi c=1 sm=1 tr=0 ts=6aa98543 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=20KFwNOVAAAA:8 a=NEAV23lmAAAA:8 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8
 a=p0WdMEafAAAA:8 a=7yyM_NBgSiweAe7c2_4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: N2yU2c6yTd3VHNdwlPxQC-c415kPBU_I
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_04,2026-09-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 suspectscore=0 adultscore=0 impostorscore=0
 malwarescore=0 priorityscore=1501 bulkscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609150257
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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

On 9/15/2026 10:10 AM, Alex Bennée wrote:
> Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> writes:
> 
>> On 9/14/2026 12:28 AM, Alex Bennée wrote:
>>> Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> writes:
>>>
>>>> On 9/10/26 11:15 AM, Alex Bennée wrote:
>>>>> Previously we had the default baked into Makefile.include but as the
>>>>> meson container logic will also benefit from it we update the configure
>>>>> machinery.
>>>>> For now we allow direct make invocations to override but for the
>>>>> normal case it is in one place now.
>>>>> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
>>>>> ---
>>>>>   configure                     | 8 ++++++++
>>>>>   meson_options.txt             | 3 +++
>>>>>   tests/docker/Makefile.include | 4 +---
>>>>>   tests/tcg/meson.build         | 6 ++++++
>>>>>   4 files changed, 18 insertions(+), 3 deletions(-)
>>>>> diff --git a/configure b/configure
>>>>> index aaa41fe47aa..7d6b11ddd35 100755
>>>>> --- a/configure
>>>>> +++ b/configure
>>>>> @@ -172,6 +172,7 @@ fi
>>>>>   # some defaults, based on the host environment
>>>>>     # default parameters
>>>>> +container_registry="registry.gitlab.com/qemu-project/qemu"
>>>>>   cpu=""
>>>>>   cross_compile="no"
>>>>>   cross_prefix=""
>>>>> @@ -728,6 +729,9 @@ for opt do
>>>>>     ;;
>>>>>     --container-command=*) meson_option_add -Dcontainer_command="$optarg"
>>>>>     ;;
>>>>> +  --container-registry=*) container_registry="$optarg"
>>>>> +                          meson_option_add -Dcontainer_registry="$optarg"
>>>>> +  ;;
>>>>>     --rust-target-triple=*) rust_target_triple="$optarg"
>>>>>     ;;
>>>>>     --gdb=*) meson_option_add -Dgdb="$optarg"
>>>>> @@ -862,6 +866,7 @@ Advanced options (experts only):
>>>>>     --cpu=CPU                Build for host CPU [$cpu]
>>>>>     --disable-containers     don't use containers for cross-building
>>>>>     --container-command=CMD  which container command to use [autodetect]
>>>>> +  --container-registry=URL which container registry to cache from [$container_registry]
>>>>>     --gdb=GDB-path           gdb to use for gdbstub tests [autodetect]
>>>>>     --wasm64-32bit-address-limit Restrict wasm64 address space to 32-bit (default
>>>>>                                  is to use the whole 64-bit range).
>>>>> @@ -1318,6 +1323,9 @@ echo "GENISOIMAGE=$genisoimage" >> $config_host_mak
>>>>>   echo "MESON=$meson" >> $config_host_mak
>>>>>   echo "NINJA=$ninja" >> $config_host_mak
>>>>>   echo "EXESUF=$EXESUF" >> $config_host_mak
>>>>> +if test -n "$container_registry"; then
>>>>> +  echo "DOCKER_DEFAULT_REGISTRY=$container_registry" >> $config_host_mak
>>>>> +fi
>>>>>   if test "$default_targets" = "yes"; then
>>>>>     echo "CONFIG_DEFAULT_TARGETS=y" >> $config_host_mak
>>>>>   fi
>>>>> diff --git a/meson_options.txt b/meson_options.txt
>>>>> index 292625af08a..030231492e1 100644
>>>>> --- a/meson_options.txt
>>>>> +++ b/meson_options.txt
>>>>> @@ -391,6 +391,9 @@ option('containers', type: 'boolean', value: true,
>>>>>          description: 'use containers to cross compile tcg tests')
>>>>>   option('container_command', type: 'string',
>>>>>          description: 'command to build/run containers')
>>>>> +option('container_registry', type: 'string',
>>>>> +       value: 'registry.gitlab.com/qemu-project/qemu',
>>>>> +       description: 'container registry to cache from')
>>>>>     option('tcg_tests_cross_cc_aarch64', type: 'string',
>>>>>          description: 'cc for aarch64 tcg tests')
>>>>> diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
>>>>> index 0adddb6a5c6..74bf471f171 100644
>>>>> --- a/tests/docker/Makefile.include
>>>>> +++ b/tests/docker/Makefile.include
>>>>> @@ -11,9 +11,7 @@ USER = $(if $(NOUSER),,$(shell id -un))
>>>>>   UID = $(if $(NOUSER),,$(shell id -u))
>>>>>     DOCKER_FILES_DIR := $(SRC_PATH)/tests/docker/dockerfiles
>>>>> -ifeq ($(HOST_ARCH),x86_64)
>>>>> -DOCKER_DEFAULT_REGISTRY := registry.gitlab.com/qemu-project/qemu
>>>>> -endif
>>>>> +DOCKER_DEFAULT_REGISTRY ?= registry.gitlab.com/qemu-project/qemu
>>>>>   DOCKER_REGISTRY := $(if $(REGISTRY),$(REGISTRY),$(DOCKER_DEFAULT_REGISTRY))
>>>>>
>>>>
>>>> Couldn't we read the default from config_host_mak generated by
>>>> configure instead?
>>>>
>>>>>   CONTAINER_COMMAND ?= $(shell $(SRC_PATH)/tests/docker/docker.py probe)
>>>>> diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
>>>>> index 814f2f8cd8c..22157a47c96 100644
>>>>> --- a/tests/tcg/meson.build
>>>>> +++ b/tests/tcg/meson.build
>>>>> @@ -101,6 +101,9 @@ if get_option('containers')
>>>>>     endif
>>>>>   endif
>>>>>   tcg_tests_summary += {'container command': container_command}
>>>>> +if get_option('container_registry') != ''
>>>>> +  tcg_tests_summary += {'container registry': get_option('container_registry')}
>>>>> +endif
>>>>>     # plugins come first, as we need to build the list
>>>>>   test_plugins = {}
>>>>> @@ -257,6 +260,9 @@ foreach target, plan: tcg_tests
>>>>>       if cc_dockerfile not in image_targets and has_docker
>>>>>         cmd = [docker_wrapper, 'build', '-f', dockerfile, '-t', 'qemu/' + cc_dockerfile,
>>>>>                '--add-current-user']
>>>>> +      if get_option('container_registry') != ''
>>>>> +        cmd += ['--registry', get_option('container_registry')]
>>>>> +      endif
>>>>>         t = custom_target(image_name, command: cmd,
>>>>>                           build_by_default: false,
>>>>>                           output: 'no_output_' + image_name)
>>>>
>>>> Do user benefit from this, or is it mostly for CI need?
>>>
>>> The aim is for faster image builds because the CI registry should always
>>> be up to date. Most of the time the images don't change.
>>>
>>
>> Ok. In this case, you need to add --timestamp 0 (that's enough in what I
>> tested) to original build command that generates those layers from our
>> CI, and use it here also. Else --cache-from does not work as intended
>> and you'll see have some duplication because timestamp is part of hash
>> for each layer.
>>
>> See this guide for more info:
>> https://docs.redhat.com/en/documentation/red_hat_enterprise_linux/10/html/building_running_and_managing_containers/introduction-to-reproducible-container-builds
> 
> Hmm is that a podman only option?
>

Yes, indeed.
Portable option seems to be: --build-arg SOURCE_DATE_EPOCH=0.

You can experiment with this using a personal registry (like dockerhub).

1. Build an image with:
--cache-to myregistry --build-arg SOURCE_DATE_EPOCH=0.
2. Then purge image and all its layers.
3. Rebuild it using:
--cache-from myregistry --build-arg SOURCE_DATE_EPOCH=0.
=> You should observe that all layers are effectively cached.

See a concrete example here:
original build:
https://github.com/p-b-o/qemu-ci/actions/runs/34837577836/job/103954828254#step:4:3170
cached build:
https://github.com/p-b-o/qemu-ci/actions/runs/34806642832/job/103859733976#step:6:9

Disclaimer: I exclusively use podman (for years), so not sure if docker
has its own idiosyncrasies on top.

>>>> The effect is to use --cache-from $registry, which I'm not sure is
>>>> what we want by default, given all the "caching issues" we had
>>>> previously with dockerfiles already.
>>>> If that's for CI, maybe it could simply set with --container-command
>>>> in our CI only.
>>>>
>>>> Regards,
>>>> Pierrick
>>>
> 


