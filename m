Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8512EC88E6E
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 16:19:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x69OB-0000lm-3I; Mon, 14 Sep 2026 12:18:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x69Nm-0000Z9-EK
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 12:18:16 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x69Nk-000880-Dn
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 12:18:14 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68ED0XQD1025806
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 16:18:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 +PSKjEl9N3V3oaNlR2OkbdtnOxjAdCqWyBcErLINe/I=; b=QdkHE+A5JD+ONcUi
 f1fDWSkS2e26SOeWxfAbzfC009uOgQhDgo5mA0D3l0Nr3g6LbwGMIGztUoaOzjYM
 YHDT2OPa/wO2QnRnMROZGw1NQTz8h1uEjt5B4XQPqS8UZY3OOpmtl8HalaTWBHlP
 DkwPgmr3rlYWl8EtdaY0imv84Q+VyaMd/f1xqI9b62tMGgK/O7lpljzrLVupwQnk
 LFjEuQpraeVGInyphfOPLJuR2uRkAk/NVcD0VxUjQcRi6bmDCvQLepV3uF2wuTid
 F+mt5SKw9y7sVh8SSLmPuMDlrA3BhNlQLC4Uz3xsJDVjjqbQKXXfinDPvAhr9ShP
 nVT+Tw==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gpdb5suwc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 16:18:11 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2d63bad3d09so56572615ad.3
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 09:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789402690; x=1790007490; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=+PSKjEl9N3V3oaNlR2OkbdtnOxjAdCqWyBcErLINe/I=;
 b=kI8uWOtdVGDuTYGsDiX78g2PFCaLHAHh8uNR3rZiemvvBQi8DeI5917Cq57bajdxub
 SK/CEw5AnnDIcS24Rp06Z7mRRwpskD+cqC5EMk57CsJ/KZxhT+oTFHv5xmrOGP4t6Xru
 BoFg8dKAyg25ZEqxbvXUZP0H7+kfI7TiM231EFlpinEWArTsBOK/CoPCbbXlqppTDTv5
 P5EGi0RyrhBXRbwmq+zGPACUXuUCJ+yY2rIRYhnLJ7Fc51pIP+lZysQk1cKndqXuAHKM
 78QtY6nUMdap+RRyIpPvtvQkTohsczsOtk7EpQIQCzK2+ejbtdQ4/Z0bnTStN1gICpXf
 BF6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789402690; x=1790007490;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+PSKjEl9N3V3oaNlR2OkbdtnOxjAdCqWyBcErLINe/I=;
 b=WvCRy5vUNFca5kt5OrWU68Mo+GBK7qzA/Xhra1vXNmKE2aFsrg7OSbOpGTkrN4pYS/
 EuCCHy0sWfd3nWI6yeYufv8oabiRBC38OohC/vEN213KiNNygk0oWr9B0w+WAGKZDZYW
 IcXxTYGW9nKTNpWsg2Jn7OmEvupi9QGM+zc1Km3bdtrKvqewpMbRgDScAYYAilMjhJgK
 AfgP8K4Dw52pwHKhjA3kXJITGv0+T6s2+ZFATI0Ua9qSh6GxQNV39rCwIG/wzgMfsDQE
 Rl4U7FUBDgbqyDvCh1pbbnKnTf2nWAYCA8LLN2t2sVV3stvefRT8ON1AiZlGU2gSDmZP
 5G1Q==
X-Gm-Message-State: AFuF++k/rkzysOUj0l5/8X3Jc1NXRB7ml3VMPenDlUnv1dWDB/oOInuc
 XjxA+ohxYXIoqqvU69ljg+LUMt6XN5+EcSDBVzNkZtObvoxpL9VM5gaHkMgCPlUQW6ecFfnSHvy
 BJab4oFPyW1nRciMI800i5OvKHJptwgWIlH9n8bNDMlBaRrS8svO7silsPdAZUw9Mqw==
X-Gm-Gg: AYBFou1rFR1Fky0v6Z3SkMFvqK+QJ8y8jwhCDovTMr5FfnPmcfYBxIgR8JRlnAmUdYl
 MD6yrFPwBuLLq7pWZoknIAAb6O8eI1sbQYU144GYOuhU3eZaE6rWdSD11IEZHyBbwyKWDbYW0hN
 4wC5/+yarH/+aU9c6SNENyUmhenBMlzMGXNAbZjM9ignSkpik7vEL9UNMEY3FSlW08kzd/8thG4
 c0dy5kM5CSXhwlJlYym4qZ4lV0cwDdSHC6AWI37k49rxm1lWDaxnQCn3WqR1IZhMNOKEYItA4tJ
 eVXwRad8HB7SZsbXUXCmhuycjR13AFozCGabL0Miqlk+Aq1JGbVtLJ4/VcrCB7CL++hdSUPsNo9
 hrHU6DCPy4ZzqfM7gXvdlyYpdyKfj3Yq4U/MryKCfrGiIN/cuG+aKzi0crsp+vUmBqVba
X-Received: by 2002:a05:6a20:c99a:b0:3d3:ad3c:49a5 with SMTP id
 adf61e73a8af0-3db4061e365mr7205121637.19.1789402690018; 
 Mon, 14 Sep 2026 09:18:10 -0700 (PDT)
X-Received: by 2002:a05:6a20:c99a:b0:3d3:ad3c:49a5 with SMTP id
 adf61e73a8af0-3db4061e365mr7205050637.19.1789402689570; 
 Mon, 14 Sep 2026 09:18:09 -0700 (PDT)
Received: from [192.168.1.199] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33ba4fa50e3sm28548422eec.29.2026.09.14.09.18.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Sep 2026 09:18:08 -0700 (PDT)
Message-ID: <9999cc6c-04e4-4507-beb0-5856bf614333@oss.qualcomm.com>
Date: Mon, 14 Sep 2026 09:18:06 -0700
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
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <87qziw1ebt.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE0MDIzMiBTYWx0ZWRfX+mo3h7OSYFHT
 rMazPRlljL+TQDV77NJXPZW/bvGZQe5dtwL46AAbec6qir7Ae6hqa2zFOaH3ORyKbbLrF0OvjFz
 avtXv74UM0ZPGIgl5DLXe8UAfSUX4nw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE0MDIzMiBTYWx0ZWRfX9nZUiYgRoKzu
 xxRjE1A3+WGDqXL0UzQcWhjs0xqTBF1MSMaqu6Eeb6qICNj+N9cD8zrsnN/B9a1XYJrgNTDBr3F
 FuPmmz9FUZtYd4KhT4Tt3wlJ5nU5YhZLbWB15c/clI4gayVK/e1Noj0GL+JJ9/YukQOyhsiy3/c
 LKFNw2/jLlQDuvhqIbf8Icn7d3rj9x+adO/9MhlOrikhk2qBguq9CN8FIQPYdkTTEZ+ezjvzfp6
 VAc/f+RFYHi2KbwDIXHeDRaZOmwEWiSlwJ0OP9ukL7JuC973JJA8rV5bQHK2CqcCshLyBuYjxfl
 CkEslorcNAAr+55LBAUe4pFAeOTV9nH/ijpGnuW98DldZtOw3YR0r4ZzOPogBS7CWvEz/wj6b+l
 dQk4A2eI5VBRW3OyCnyw+f+McnnFQHPzaNfe64FgqqcMurZLi6xw6cU4oo4JPR/6ZqPKWVtXxck
 IgQJKUquKS/D57tgCIw==
X-Proofpoint-GUID: jlGD1yb0WtqAlS8-ubyvOZv8xRXjqELT
X-Authority-Analysis: v=2.4 cv=Ie4Symqa c=1 sm=1 tr=0 ts=6aa81e43 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=p0WdMEafAAAA:8
 a=XKV5pE7-dKgbzoMKZQ4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: jlGD1yb0WtqAlS8-ubyvOZv8xRXjqELT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-14_03,2026-09-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 impostorscore=0 phishscore=0 adultscore=0
 malwarescore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609140232
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

On 9/14/2026 12:28 AM, Alex Bennée wrote:
> Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> writes:
> 
>> On 9/10/26 11:15 AM, Alex Bennée wrote:
>>> Previously we had the default baked into Makefile.include but as the
>>> meson container logic will also benefit from it we update the configure
>>> machinery.
>>> For now we allow direct make invocations to override but for the
>>> normal case it is in one place now.
>>> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
>>> ---
>>>   configure                     | 8 ++++++++
>>>   meson_options.txt             | 3 +++
>>>   tests/docker/Makefile.include | 4 +---
>>>   tests/tcg/meson.build         | 6 ++++++
>>>   4 files changed, 18 insertions(+), 3 deletions(-)
>>> diff --git a/configure b/configure
>>> index aaa41fe47aa..7d6b11ddd35 100755
>>> --- a/configure
>>> +++ b/configure
>>> @@ -172,6 +172,7 @@ fi
>>>   # some defaults, based on the host environment
>>>     # default parameters
>>> +container_registry="registry.gitlab.com/qemu-project/qemu"
>>>   cpu=""
>>>   cross_compile="no"
>>>   cross_prefix=""
>>> @@ -728,6 +729,9 @@ for opt do
>>>     ;;
>>>     --container-command=*) meson_option_add -Dcontainer_command="$optarg"
>>>     ;;
>>> +  --container-registry=*) container_registry="$optarg"
>>> +                          meson_option_add -Dcontainer_registry="$optarg"
>>> +  ;;
>>>     --rust-target-triple=*) rust_target_triple="$optarg"
>>>     ;;
>>>     --gdb=*) meson_option_add -Dgdb="$optarg"
>>> @@ -862,6 +866,7 @@ Advanced options (experts only):
>>>     --cpu=CPU                Build for host CPU [$cpu]
>>>     --disable-containers     don't use containers for cross-building
>>>     --container-command=CMD  which container command to use [autodetect]
>>> +  --container-registry=URL which container registry to cache from [$container_registry]
>>>     --gdb=GDB-path           gdb to use for gdbstub tests [autodetect]
>>>     --wasm64-32bit-address-limit Restrict wasm64 address space to 32-bit (default
>>>                                  is to use the whole 64-bit range).
>>> @@ -1318,6 +1323,9 @@ echo "GENISOIMAGE=$genisoimage" >> $config_host_mak
>>>   echo "MESON=$meson" >> $config_host_mak
>>>   echo "NINJA=$ninja" >> $config_host_mak
>>>   echo "EXESUF=$EXESUF" >> $config_host_mak
>>> +if test -n "$container_registry"; then
>>> +  echo "DOCKER_DEFAULT_REGISTRY=$container_registry" >> $config_host_mak
>>> +fi
>>>   if test "$default_targets" = "yes"; then
>>>     echo "CONFIG_DEFAULT_TARGETS=y" >> $config_host_mak
>>>   fi
>>> diff --git a/meson_options.txt b/meson_options.txt
>>> index 292625af08a..030231492e1 100644
>>> --- a/meson_options.txt
>>> +++ b/meson_options.txt
>>> @@ -391,6 +391,9 @@ option('containers', type: 'boolean', value: true,
>>>          description: 'use containers to cross compile tcg tests')
>>>   option('container_command', type: 'string',
>>>          description: 'command to build/run containers')
>>> +option('container_registry', type: 'string',
>>> +       value: 'registry.gitlab.com/qemu-project/qemu',
>>> +       description: 'container registry to cache from')
>>>     option('tcg_tests_cross_cc_aarch64', type: 'string',
>>>          description: 'cc for aarch64 tcg tests')
>>> diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
>>> index 0adddb6a5c6..74bf471f171 100644
>>> --- a/tests/docker/Makefile.include
>>> +++ b/tests/docker/Makefile.include
>>> @@ -11,9 +11,7 @@ USER = $(if $(NOUSER),,$(shell id -un))
>>>   UID = $(if $(NOUSER),,$(shell id -u))
>>>     DOCKER_FILES_DIR := $(SRC_PATH)/tests/docker/dockerfiles
>>> -ifeq ($(HOST_ARCH),x86_64)
>>> -DOCKER_DEFAULT_REGISTRY := registry.gitlab.com/qemu-project/qemu
>>> -endif
>>> +DOCKER_DEFAULT_REGISTRY ?= registry.gitlab.com/qemu-project/qemu
>>>   DOCKER_REGISTRY := $(if $(REGISTRY),$(REGISTRY),$(DOCKER_DEFAULT_REGISTRY))
>>>
>>
>> Couldn't we read the default from config_host_mak generated by
>> configure instead?
>>
>>>   CONTAINER_COMMAND ?= $(shell $(SRC_PATH)/tests/docker/docker.py probe)
>>> diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
>>> index 814f2f8cd8c..22157a47c96 100644
>>> --- a/tests/tcg/meson.build
>>> +++ b/tests/tcg/meson.build
>>> @@ -101,6 +101,9 @@ if get_option('containers')
>>>     endif
>>>   endif
>>>   tcg_tests_summary += {'container command': container_command}
>>> +if get_option('container_registry') != ''
>>> +  tcg_tests_summary += {'container registry': get_option('container_registry')}
>>> +endif
>>>     # plugins come first, as we need to build the list
>>>   test_plugins = {}
>>> @@ -257,6 +260,9 @@ foreach target, plan: tcg_tests
>>>       if cc_dockerfile not in image_targets and has_docker
>>>         cmd = [docker_wrapper, 'build', '-f', dockerfile, '-t', 'qemu/' + cc_dockerfile,
>>>                '--add-current-user']
>>> +      if get_option('container_registry') != ''
>>> +        cmd += ['--registry', get_option('container_registry')]
>>> +      endif
>>>         t = custom_target(image_name, command: cmd,
>>>                           build_by_default: false,
>>>                           output: 'no_output_' + image_name)
>>
>> Do user benefit from this, or is it mostly for CI need?
> 
> The aim is for faster image builds because the CI registry should always
> be up to date. Most of the time the images don't change.
>

Ok. In this case, you need to add --timestamp 0 (that's enough in what I
tested) to original build command that generates those layers from our
CI, and use it here also. Else --cache-from does not work as intended
and you'll see have some duplication because timestamp is part of hash
for each layer.

See this guide for more info:
https://docs.redhat.com/en/documentation/red_hat_enterprise_linux/10/html/building_running_and_managing_containers/introduction-to-reproducible-container-builds

>>
>> The effect is to use --cache-from $registry, which I'm not sure is
>> what we want by default, given all the "caching issues" we had
>> previously with dockerfiles already.
>> If that's for CI, maybe it could simply set with --container-command
>> in our CI only.
>>
>> Regards,
>> Pierrick
> 


