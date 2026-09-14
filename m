Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91E8FC88E50
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 05:22:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5z8R-0006oJ-5B; Mon, 14 Sep 2026 01:21:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x5z8P-0006nr-4D
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 01:21:41 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x5z8M-0000u2-LI
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 01:21:40 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68E2effu2241392
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 05:21:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ovZsZJ5f9b4mVCnjxEclT7RUj5VvXthVTAWtXtEHom8=; b=cfezjpkm2tKHtxm0
 Ba4tmLclViPs9D4iLWhyfpe5pUa9m0QbQH20fuGWYfFVaxbUePTvSrgrO1wsRFkx
 oz2FAVOKpQDnPY8oFD7jgVrbtFj7EYi1cpLIKfufxeR+kcAADv19knghztd9xIZu
 q7f3uy2W0WXRspBufMzLDNilGQSIiBl3zj0I33eGbgGer0Kj+X/ufr9JSk2Dz71N
 ePFPbSh/DK+8U/hDNGmTSg7yfVDPk3mY1XvRnROdaH7V3Az27bZH/d21hRdJys47
 4BrdiZQcRpuP32GayZ+rIGgM0frKD5kK/K+d728uQHy4V75V39gMuESizEW0CraG
 tATWow==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gmywh50cy-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 05:21:36 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2d001671a54so57023615ad.2
 for <qemu-devel@nongnu.org>; Sun, 13 Sep 2026 22:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789363295; x=1789968095; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ovZsZJ5f9b4mVCnjxEclT7RUj5VvXthVTAWtXtEHom8=;
 b=FJIUJetM29qacoRBO+WNconyjuN5LOqNY9+u7727D/pUXBN4uhL1xRThJT2lNPOpVu
 UaxSL7OESbO//vwXV8b1o0dizVhrlPrNoykGTFyKbl8vj0NnJ6hA7hNIMDswYYfKoQ/8
 f78LN4TJ0VYUp2f0ivFj63Llf1XyQ7m70lam/YH5cPKX8+/05xtMCAQhiwbOi3TY6z23
 XhTUntV2TvJ55OTnzRUTw7sS+2HD3ZvfaBMjH6+QJEbuDX3kmZDMHy7FrWtIX3nvcK54
 4aXmlM4NStTjzFNWZoGRPxKt7y7eTubdna4wV7TnbJPYr1+3oCDMhUAG2V+H/uSiZDE7
 KnKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789363295; x=1789968095;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ovZsZJ5f9b4mVCnjxEclT7RUj5VvXthVTAWtXtEHom8=;
 b=qyUpsjDZXaU4XfzdQPEY9dHMUfPaNjtUHycH2KU0P/Zp2I+dM2doyW4e+VwnYRg0j7
 +MXrF/6EmhfKlhbLIHOExkxqvyvFIUOI4WEDGnh2Xt3FxjP1lShWNXKMyVvGlSfsj7IO
 joKQdQ6HHT1N0niMQOV9sJh9RXlEPB36JSq9XmRgGOxPvkMV/mhsnVJ49rqIsUVB0cr5
 JR9EirHYYMJpUj46r92wlOFjm977fLUoW+rCOFC0YvkoSuNWeOSkVGZugQzq5elm/wZY
 7/xUDgHovHfgg1WWX3ys2+hru3jaFs/AgiRCsKi/jJDGdRbrRpEOFAF+pTJ7I/31KLPk
 QXDA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxfefq2JVjiyrDbHKM3PPY7lT2c9pML34lStsT+Xndymo3qpW6H8RNEIvm5djLEyZcIy/1PwPX1NpLQ@nongnu.org
X-Gm-Message-State: AFuF++m7hBT4jETyYPAkFGI0djZ2PgtsqrpalZiN8+vlbqGKZMlgBiMO
 zd1yiDLI7BUbzZJo0RW4XChxsCfA3OQDR6/Ftr2y7kabDpOYMOyT3SKcmeKl3UEisl111N10IGJ
 Bt7DuF5WMrq64TgKWtq4HuoAT090qZokmzEki1QkCrAQRu1MmLICMXIn7Qw==
X-Gm-Gg: AYBFou00ZYeE6IiMFjNRLAiThg2K5SmWuWkqXXENsQd4L5hIbE13pQViabyhGM20qDx
 JjtdztTY5XOxR2Xdq0wkTPhnoQygkj/PbbV0DBFUY1c3z4vFv5g1SpJWGw7FBTk2ZRZ4h8xMYHx
 1lNM8ZYsfO7CYpPV/HX3Nk2ps4dHhCyWNEMlCs/MK+hefNPXO4iV4IZwUvenL1taPFMnqivpvb/
 wzyXez8BT76QIyFj4Zd4ez/AtPL/pjMW/wXtopwxiPXQ1cC3WCxj63rKJufYsYgeyWohW+0eqTf
 tkHxIG/r0giZvMujeMUnmR3QhM3UuK+t0em+PGjXOMEmXbFoMdtFiLS8CJIBCOJd4LmUuF8Y1jZ
 QnOE0kGS4RwuDq8Cd9H8rU7RwYx0Hcu/cbxW+u+BylNXT7h34tpdk5Ws=
X-Received: by 2002:a17:902:f78e:b0:2ca:e19c:986 with SMTP id
 d9443c01a7336-2dd6c5ba248mr24465245ad.1.1789363295376; 
 Sun, 13 Sep 2026 22:21:35 -0700 (PDT)
X-Received: by 2002:a17:902:f78e:b0:2ca:e19c:986 with SMTP id
 d9443c01a7336-2dd6c5ba248mr24464575ad.1.1789363294882; 
 Sun, 13 Sep 2026 22:21:34 -0700 (PDT)
Received: from [192.168.1.169] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2dd2d0006d6sm41073605ad.82.2026.09.13.22.21.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 13 Sep 2026 22:21:34 -0700 (PDT)
Message-ID: <abacad10-b9af-4a39-93c9-14b882f60bea@oss.qualcomm.com>
Date: Sun, 13 Sep 2026 22:21:33 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/9] tests/docker: add container registry to configure and
 use
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Brad Smith <brad@comstyle.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Song Gao <gaosong@loongson.cn>, Warner Losh <imp@bsdimp.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
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
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
In-Reply-To: <20260910181504.1010916-6-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: S3y3TwXyXF5KotJY0hskGN6OyrkM-4G2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE0MDA3MyBTYWx0ZWRfX+Yxwr0i/6lV/
 5zqUqppelHMb/szuF+za/EasETLlJnJLwpenh6t8FulXPIMD1poTL07s0HNrYcKjVs3LGMoGaBK
 BABdWf9Zvge1PAY0g4yRpDqI07/jVWfDO+StP79XrCbCPzMSrRselRExQfl0WHC8XaZJnaisxes
 2gVRNz5LZerQUFTgeeZAA9wEVu3aOQBhJaLBSa7F+aeIhByr/U8n6mi+zcrZPLxeLyTzLqOsy8D
 /rdGldg4UDvyd9JyNKG34by7sOevczlJa3VyuE8TIM/dMlFk04+FVo5I4R7j1I6QzM44dyuQFx7
 Aw2l1/+ef/LfoDOJXXlYI/K6q76TW5+yxxot+Byo2lI7inUmLQlDXOwj3dXDFNW9iOCNi7UVE5q
 vnWaUM8OCfvGCWJMvffpXfr7cop66nWoK6TyN4NHwat6/kK26+FcvtICMAX2urnw/HWoj/8ZWV/
 mD4+BKpZtEklYyReepg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE0MDA3MyBTYWx0ZWRfX4MTad94oXAoH
 lrYNO4bhKjTq/JKgAxFteHOwId16l//rZZYqU3cIBiK2+E8IpQDAOeZzG+fR/8o/neVq52EQEZa
 kRBVEFHxhuEG8QiAspxxg7jR2m45l6o=
X-Proofpoint-ORIG-GUID: S3y3TwXyXF5KotJY0hskGN6OyrkM-4G2
X-Authority-Analysis: v=2.4 cv=PsUG/AM3 c=1 sm=1 tr=0 ts=6aa78460 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=KKAkSRfTAAAA:8 a=p0WdMEafAAAA:8 a=QOBLK8SJlxrh8d0QBJoA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-14_01,2026-09-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 suspectscore=0 bulkscore=0 spamscore=0
 malwarescore=0 lowpriorityscore=0 phishscore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609140073
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

On 9/10/26 11:15 AM, Alex Bennée wrote:
> Previously we had the default baked into Makefile.include but as the
> meson container logic will also benefit from it we update the configure
> machinery.
> 
> For now we allow direct make invocations to override but for the
> normal case it is in one place now.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   configure                     | 8 ++++++++
>   meson_options.txt             | 3 +++
>   tests/docker/Makefile.include | 4 +---
>   tests/tcg/meson.build         | 6 ++++++
>   4 files changed, 18 insertions(+), 3 deletions(-)
> 
> diff --git a/configure b/configure
> index aaa41fe47aa..7d6b11ddd35 100755
> --- a/configure
> +++ b/configure
> @@ -172,6 +172,7 @@ fi
>   # some defaults, based on the host environment
>   
>   # default parameters
> +container_registry="registry.gitlab.com/qemu-project/qemu"
>   cpu=""
>   cross_compile="no"
>   cross_prefix=""
> @@ -728,6 +729,9 @@ for opt do
>     ;;
>     --container-command=*) meson_option_add -Dcontainer_command="$optarg"
>     ;;
> +  --container-registry=*) container_registry="$optarg"
> +                          meson_option_add -Dcontainer_registry="$optarg"
> +  ;;
>     --rust-target-triple=*) rust_target_triple="$optarg"
>     ;;
>     --gdb=*) meson_option_add -Dgdb="$optarg"
> @@ -862,6 +866,7 @@ Advanced options (experts only):
>     --cpu=CPU                Build for host CPU [$cpu]
>     --disable-containers     don't use containers for cross-building
>     --container-command=CMD  which container command to use [autodetect]
> +  --container-registry=URL which container registry to cache from [$container_registry]
>     --gdb=GDB-path           gdb to use for gdbstub tests [autodetect]
>     --wasm64-32bit-address-limit Restrict wasm64 address space to 32-bit (default
>                                  is to use the whole 64-bit range).
> @@ -1318,6 +1323,9 @@ echo "GENISOIMAGE=$genisoimage" >> $config_host_mak
>   echo "MESON=$meson" >> $config_host_mak
>   echo "NINJA=$ninja" >> $config_host_mak
>   echo "EXESUF=$EXESUF" >> $config_host_mak
> +if test -n "$container_registry"; then
> +  echo "DOCKER_DEFAULT_REGISTRY=$container_registry" >> $config_host_mak
> +fi
>   if test "$default_targets" = "yes"; then
>     echo "CONFIG_DEFAULT_TARGETS=y" >> $config_host_mak
>   fi
> diff --git a/meson_options.txt b/meson_options.txt
> index 292625af08a..030231492e1 100644
> --- a/meson_options.txt
> +++ b/meson_options.txt
> @@ -391,6 +391,9 @@ option('containers', type: 'boolean', value: true,
>          description: 'use containers to cross compile tcg tests')
>   option('container_command', type: 'string',
>          description: 'command to build/run containers')
> +option('container_registry', type: 'string',
> +       value: 'registry.gitlab.com/qemu-project/qemu',
> +       description: 'container registry to cache from')
>   
>   option('tcg_tests_cross_cc_aarch64', type: 'string',
>          description: 'cc for aarch64 tcg tests')
> diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
> index 0adddb6a5c6..74bf471f171 100644
> --- a/tests/docker/Makefile.include
> +++ b/tests/docker/Makefile.include
> @@ -11,9 +11,7 @@ USER = $(if $(NOUSER),,$(shell id -un))
>   UID = $(if $(NOUSER),,$(shell id -u))
>   
>   DOCKER_FILES_DIR := $(SRC_PATH)/tests/docker/dockerfiles
> -ifeq ($(HOST_ARCH),x86_64)
> -DOCKER_DEFAULT_REGISTRY := registry.gitlab.com/qemu-project/qemu
> -endif
> +DOCKER_DEFAULT_REGISTRY ?= registry.gitlab.com/qemu-project/qemu
>   DOCKER_REGISTRY := $(if $(REGISTRY),$(REGISTRY),$(DOCKER_DEFAULT_REGISTRY))
>

Couldn't we read the default from config_host_mak generated by configure 
instead?

>   CONTAINER_COMMAND ?= $(shell $(SRC_PATH)/tests/docker/docker.py probe)
> diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
> index 814f2f8cd8c..22157a47c96 100644
> --- a/tests/tcg/meson.build
> +++ b/tests/tcg/meson.build
> @@ -101,6 +101,9 @@ if get_option('containers')
>     endif
>   endif
>   tcg_tests_summary += {'container command': container_command}
> +if get_option('container_registry') != ''
> +  tcg_tests_summary += {'container registry': get_option('container_registry')}
> +endif
>   
>   # plugins come first, as we need to build the list
>   test_plugins = {}
> @@ -257,6 +260,9 @@ foreach target, plan: tcg_tests
>       if cc_dockerfile not in image_targets and has_docker
>         cmd = [docker_wrapper, 'build', '-f', dockerfile, '-t', 'qemu/' + cc_dockerfile,
>                '--add-current-user']
> +      if get_option('container_registry') != ''
> +        cmd += ['--registry', get_option('container_registry')]
> +      endif
>         t = custom_target(image_name, command: cmd,
>                           build_by_default: false,
>                           output: 'no_output_' + image_name)

Do user benefit from this, or is it mostly for CI need?

The effect is to use --cache-from $registry, which I'm not sure is what 
we want by default, given all the "caching issues" we had previously 
with dockerfiles already.
If that's for CI, maybe it could simply set with --container-command in 
our CI only.

Regards,
Pierrick

