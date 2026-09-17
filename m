Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA575C88E72
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 17:00:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7FSZ-0002SG-Sz; Thu, 17 Sep 2026 12:59:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x7FRW-0001l0-OO
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 12:58:40 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x7FRL-00016t-Rd
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 12:58:29 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68HECmJd2496797
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 16:58:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Oacd1iE438+BmbFXbn1PVh+ldeosxWdRmyHQ/KOmp9k=; b=mqWNRWn/k9D/8Riv
 +Qz7izhBL+2LJOJtLDCgdfgpFBHCIAvVgnZd4ptjRZja1NvrUwJC2jkSXDQ5rBs6
 2PeTMLDQaMii6U8XPXm0CTFnFO2vXxsanKZkhCfDhYzBE4FrDpODOTrV94BxncFR
 obNhY2zHUU/Z4IxpH1tc3dXeKkGCYv1q9t0oWd3UganqX/kZj5FsDbBErLtb8Tjn
 ynnBX3U203yVGr8wyzxeCKxJlgIArCxJJg4oovf3yiaOAwxMakHGpKrFfde0BRZg
 l7NZjxMGZe4sGQRtkAzaQ4fhROHXygeyHVrudc9poNcQc43ihD34ep806m2kQMi3
 IoaBJQ==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4grhs6gsy9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 16:58:26 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-cc489e7a701so1554058a12.2
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 09:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789664306; x=1790269106; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Oacd1iE438+BmbFXbn1PVh+ldeosxWdRmyHQ/KOmp9k=;
 b=HEakbc3LngAWZxqBYdlVMbFdzPCKhC/rXikCNwYr0asCnS/Z8gNkQILjXrS+b42VIR
 YTrCfy61mloiYURjHLDuw6Y8f07zOHCHBKngsNH6OWn/vOSzWuOJwo3BY7I3jtczGqus
 BNkpmZViQiBFvwPAk1nq8t4cZdZIbdwAeP9aOubvnSJ04nDYQLN+jBe3PZZaGGCHmbgO
 rlteNN6T/ll8cl3m7/ailwvsXgStd2eTfKUkaRbpxq+wLEpHpOl4aofEUv/h6gHUn1rw
 GB2mBjzCtLldVpXGj+FXPXy1LuAy/E4HyrvydHjq8sVGvk1wqXaqmMHjYeXlB+gqMoV/
 RZcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789664306; x=1790269106;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Oacd1iE438+BmbFXbn1PVh+ldeosxWdRmyHQ/KOmp9k=;
 b=G/G09InKlxkR3twl0HW5jcjAJYZ2vAlSsi32rQlheSC3NEZqf30jlT561RlnPYMYVw
 cmuzXZvxm48kivFUHLgT6HbpejmnH/Mdcz0DP0hBuzzrtThx8uLUypb6a7qa2MFktjYQ
 kRjjPXa74XShErxr+DKC+72EEHnsPO+kXk53vuIgq8FsmdqXEEpZjpv6pkKN1xBMViPQ
 eYgb2luz03ku7U0RXcZpaMold+tZriBfuH/DTatfXQv1N/HYp3v+BRqLs8xyFLOR1W5S
 KPqxlQ7628lOuO/++pEPPEDpojftL0daS3Qauv1qdgrU6552IybuVZ5MdIr9Z0CccH2M
 tS2g==
X-Gm-Message-State: AFuF++lPmIWs7TB/dEqZ0tpyQuhqfLkrPO3UjYaM+QiOdhv2RlACRACA
 a0osNfu3RXqbeyi+VKtC93ahWvnbFd4e/GmZ1e88oM4d9RHSea31VjRPwtxJL9ko84xf0j/6F6k
 IhqdJ21fV7BjlwP72WUi3sf7pO4NbqBZ2IRRwsD2TCstfjRK/RAF1RVURKg==
X-Gm-Gg: AYBFou25WXYfP05NqB47WyQqFNkpNoZWxQIqtibWwVAySFn0TI2GRFrjpGk7oDDDONZ
 +FAAabqZ/bSIU9l5AYi2D9lRq9sfCzpGLT4U3Ff/M/67xEfFKZANrZkx/slF7Qt/ieVWAXuyAN/
 z3RZ/dhXOKhtDQevqZMU2++atyMAennoZO9P0s91cR9NaksTWxEOFqnWXA8eAXLQBB/6U7ge4F3
 gdczkqptcHgLxZvdy/8JVR4rT8eyUxdiV9h7e+o/yBYX3ZeAGLWvUmIcDWyrQ+TQN1OlXF8WaM5
 34emb1ZrU8e7Z5PGKu/guEFdgit5KtJjtFiud6bvTCMzsPhkN++M2lulNPt09guSvK0qrKzSHFN
 81+XJDYEGhjBR8j14j/LX43RzctUoWwQGRp6fgJdIUdElkx3om3eib7ytR8biVcJYlGqh
X-Received: by 2002:a05:6a21:1805:b0:3dd:85a8:cb81 with SMTP id
 adf61e73a8af0-3dd85a8d015mr2054075637.36.1789664305563; 
 Thu, 17 Sep 2026 09:58:25 -0700 (PDT)
X-Received: by 2002:a05:6a21:1805:b0:3dd:85a8:cb81 with SMTP id
 adf61e73a8af0-3dd85a8d015mr2054028637.36.1789664305146; 
 Thu, 17 Sep 2026 09:58:25 -0700 (PDT)
Received: from [192.168.1.199] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-144c6f2384bsm3697290c88.13.2026.09.17.09.58.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Sep 2026 09:58:24 -0700 (PDT)
Message-ID: <0ba903cd-8a89-4ce8-a7b5-40ddddb19c94@oss.qualcomm.com>
Date: Thu, 17 Sep 2026 09:58:22 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 03/19] Revert "tests/tcg/meson.build: implement
 ./configure containers options"
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>,
 qemu-arm@nongnu.org, Cornelia Huck <cohuck@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 John Snow <jsnow@redhat.com>, David Hildenbrand <david@kernel.org>,
 Thomas Huth <th.huth+qemu@posteo.eu>,
 Paolo Bonzini <pbonzini@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Warner Losh <imp@bsdimp.com>, Song Gao <gaosong@loongson.cn>,
 Kyle Evans <kevans@freebsd.org>, Eric Farman <farman@linux.ibm.com>,
 Brad Smith <brad@comstyle.com>, Fabiano Rosas <farosas@suse.de>,
 Helge Deller <deller@gmx.de>, Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-s390x@nongnu.org,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Jared Rossi <jrossi@linux.ibm.com>
References: <20260916153013.2134555-1-alex.bennee@linaro.org>
 <20260916153013.2134555-4-alex.bennee@linaro.org>
 <ef0cab70-4f36-4de1-bfdb-18501d801728@oss.qualcomm.com>
 <87eces8by8.fsf@draig.linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <87eces8by8.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE3MDI0MSBTYWx0ZWRfXzSR5XjbO2OQX
 QAvTKVeIK6x3AIvHdKuKlhu2Beppz1+czTu3ABmd9ZrckWRf1JU9UYB4Fqgwjl0wEBjRknGd8QG
 32bTZlFc+nGIIDbL4yY/5aL3Gju6Km+ul3oOgCKt+6bj64oo2uDqm3nN6DO8x2ES1yHSnifBDvL
 FE4LdHJA7tv4H6K0g3PS5jRhFw6/KGdLzvh3aPz5/VVDDMRhEdrNRMvzR9YPHo5zmLbU1XvPMlw
 BlTKwJ8qngYR5H54X2S0GjHyv5ee4D8BJWNPuUbLj4u3y4Bj0Ls0AAI65IA1sonIX02d310NIZp
 s3iGK263xdbmBeYH+4kmeYSiC/RblValrMQ0miXruXu7q3OmKb9c9UnFJCLuqQ9yyrcu4ylteZU
 maamHb+UmSoSEJK6vuMH1cjv5t58thJqt4F63thVWEDjHET8R/+qg1pHlfvLyOn0Z7cJclzGmo6
 N+tn4tTozh2vpWsmyQg==
X-Proofpoint-GUID: fhOZRpFHaFdJHQZ9myhKBODwbMLF2njE
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE3MDI0MSBTYWx0ZWRfXywzmX2diNNvg
 DA0uLnrjCfyQvfFX3ToiPYkvtwgGlVjfSkMlh6R/Je65cooH/PF/buOI1bVAb8SGTQbB5MdLO4w
 tkPybSdWuTD21KnV2FDDLyD047g3eEI=
X-Proofpoint-ORIG-GUID: fhOZRpFHaFdJHQZ9myhKBODwbMLF2njE
X-Authority-Analysis: v=2.4 cv=cvwOAF4i c=1 sm=1 tr=0 ts=6aac1c32 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8 a=KKAkSRfTAAAA:8
 a=p0WdMEafAAAA:8 a=QpgUHPqvu-fO-wwmKeEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-17_03,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 adultscore=0 spamscore=0 suspectscore=0
 lowpriorityscore=0 clxscore=1015 impostorscore=0 phishscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609170241
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

On 9/17/2026 2:27 AM, Alex Bennée wrote:
> Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> writes:
> 
>> On 9/16/2026 8:29 AM, Alex Bennée wrote:
>>> We want to keep the container configuration inside configure for the
>>> firmware builds.
>>>
>>> This partially reverts commit 522b299ca4316d8cad57f9496ffcba87dcc20719
>>> while keeping the plumbing to disable containers within meson.
>>>
>>> Tested-by: Eric Farman <farman@linux.ibm.com>
>>> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>>> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
>>> [AJB: untangle changes since]
>>> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
>>> Tested-by: Jared Rossi <jrossi@linux.ibm.com>
>>>
>>> ---
>>> v4
>>>   - tweak revert to keep disable reported
>>>   - update commit msg
>>> ---
>>>  configure             | 14 ++++++++++----
>>>  meson_options.txt     |  3 +++
>>>  tests/tcg/meson.build |  3 +++
>>>  3 files changed, 16 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/configure b/configure
>>> index bedde58b8cf..6084a7a065e 100755
>>> --- a/configure
>>> +++ b/configure
>>> @@ -260,7 +260,7 @@ ninja=""
>>>  python=
>>>  download="enabled"
>>>  skip_meson=no
>>> -use_containers=""
>>> +use_containers="yes"
>>>  rust="disabled"
>>>  rust_target_triple=""
>>>  
>>> @@ -727,11 +727,14 @@ for opt do
>>>    ;;
>>>    --disable-plugins) plugins="no"
>>>    ;;
>>> -  --enable-containers) # enabled by default
>>> +  --enable-containers) use_containers="yes"
>>> +                       meson_option_add -Dcontainers=true
>>>    ;;
>>> -  --disable-containers) meson_option_add -Dcontainers=false
>>> +  --disable-containers) use_containers="no"
>>> +                        meson_option_add -Dcontainers=false
>>>    ;;
>>> -  --container-command=*) meson_option_add -Dcontainer_command="$optarg"
>>> +  --container-command=*) container_command="$optarg"
>>> +                         meson_option_add -Dcontainer_command="$optarg"
>>
>> Not sure if we want to keep this option (meson container_command).
>> Related if in tests/tcg/meson.build can be removed also.
> 
> We want Makefile.include and meson to use the same container runtime
> surely?
>

Agree. It seems like the general direction was "revert" everything, but
yes, I think it would be better to keep all meson options as they are
currently.

>>
>>>    ;;
>>>    --rust-target-triple=*) rust_target_triple="$optarg"
>>>    ;;
>>> @@ -1718,6 +1721,9 @@ echo all: >> $config_host_mak
>>>  
>>>  echo "SRC_PATH=$source_path" >> $config_host_mak
>>>  echo "TARGET_DIRS=$target_list" >> $config_host_mak
>>> +if test "$container_command" != ""; then
>>> +    echo "CONTAINER_COMMAND=$container_command" >> $config_host_mak
>>> +fi
>>>  echo "SUBDIRS=$subdirs" >> $config_host_mak
>>>  echo "PYTHON=$python" >> $config_host_mak
>>>  echo "MKVENV_ENSUREGROUP=$mkvenv ensuregroup $mkvenv_online_flag" >> $config_host_mak
>>> diff --git a/meson_options.txt b/meson_options.txt
>>> index 66d3689d14c..daf301ed48a 100644
>>> --- a/meson_options.txt
>>> +++ b/meson_options.txt
>>> @@ -389,6 +389,9 @@ option('rust', type: 'feature', value: 'disabled',
>>>         description: 'Rust support')
>>>  option('strict_rust_lints', type: 'boolean', value: false,
>>>         description: 'Enable stricter set of Rust warnings')
>>> +option('container_registry', type: 'string',
>>> +       value: 'registry.gitlab.com/qemu-project/qemu',
>>> +       description: 'container registry to cache from')
>>>  option('containers', type: 'boolean', value: true,
>>>         description: 'use containers to cross compile tcg tests')
>>>  option('container_command', type: 'string',
>>> diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
>>> index ce208e686ff..890da7b81e9 100644
>>> --- a/tests/tcg/meson.build
>>> +++ b/tests/tcg/meson.build
>>> @@ -101,6 +101,9 @@ if get_option('containers')
>>>    endif
>>>  endif
>>>  tcg_tests_summary += {'container command': container_command}
>>> +if get_option('container_registry') != ''
>>> +  tcg_tests_summary += {'container registry': get_option('container_registry')}
>>> +endif
>>>
>>
>> Rebase issue?
> 
> Possibly - it got messy with the reverts.
> 
>>
>>>  # plugins come first, as we need to build the list
>>>  test_plugins = {}
> 


