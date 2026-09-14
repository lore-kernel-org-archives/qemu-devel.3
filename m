Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEDD8C88E64
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 07:29:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x617d-00087z-NQ; Mon, 14 Sep 2026 03:29:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x617b-00082C-OC
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 03:28:59 -0400
Received: from mail-wr2-x10.google.com ([2a00:1450:4864:30::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x617Z-00062f-Ol
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 03:28:59 -0400
Received: by mail-wr2-x10.google.com with SMTP id
 ffacd0b85a97d-4858bc96fabso1099559f8f.3
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 00:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789370936; x=1789975736; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=miCeAUCJ/P28lDvL07gO6RScRtVNKg+m4eTqKf4dglc=;
 b=mOBhVZw5l5+0yMCTBh6F3YtzVCaH+x55b1CmRgUCbZh8EVFms3VDnQeOOSrptemFSy
 L+iTliepvKU4WOodRjxn8zYC4lHwMPPUjBWkc+UPIOXgMH/+Opu8gkcgpA1NjxBiLpou
 bbxKHT31+sEIoO0+LT+wKL8YBL3tUfa6dSoPBJBtGMjKl4fA4DZQXtoR4TbtU06Nzi1j
 6LkO+1OWKOl3p4Ap9w25LLAtfhjllUAkCQYx3BqTi8TsU+83YqJMqpKjTh/GX7/E6H+M
 ZymxTjLTamIR/VMOrb5gtlcEIBY0JXFIp7eIQhv5AaqbS2rMJghhrdZO1va1DJQ5NztR
 T4WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789370936; x=1789975736;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=miCeAUCJ/P28lDvL07gO6RScRtVNKg+m4eTqKf4dglc=;
 b=ihD/eZDl8WyEiNI59GRV2lrmnajUi/NE7gz5LaFnYKr0KsH43RE2FL/0YpEdaSEMNU
 PtCPCIF0GNM0UV4a/fiSbewHee1ukEmMU94aIIyNOZbAj6G9owMIdvMDJZj1ffD4hzjl
 Zd9DKKntUP8+s5lLJANHNwcBqL5g51h3BAjbSbeBX/X3yy/EpmZwxNthtFDApE+hVHic
 9fwVF3YMRfodAxWREDrGclGMLxvDVrBJ3ko42BJoB9qSC+f6zD4YbV3cSA/U2BgLGc6t
 +QQdbzzD6fS5IexRbUVqnrO8VISgp4ldHqRB4XBNHRiv/SOzyoLl5pY6470Zu26uCPp3
 MTpw==
X-Gm-Message-State: AFuF++lyT/gFz9sXP1b/C7eg+Xk580S5MUi4fTibCA2cJsd7NbTDmbuH
 A90PJrDUmzmCVCqW6p21kcjjIrTQnKnRZyYpuC1LEH4R8itPF4/1kvXWzOyDPjc56YE=
X-Gm-Gg: AYBFou0VpGhiVF1IFMTn85I7ZJuMt1EqkabA09PZ1c44Yegzki0zTz2oDasCag0lt2E
 Z2/dScQojB5sbcO4OTF3b/zUcz9ycf1BZLfIUMUIoVRA01m+epuH+P/RN8jidWmWHDmUqxajqa9
 977XIL7pu706iyqWsSuier2EX1qHaY6aLi3mIs9yyZ+h47oUtcdSGBPX9P9v5Jyl2YxYv8lnXdn
 OVBGgkPFyBkzNxgA3WxzWwp+VnIxO7HPqJu6PMjrNQDz6BhR7Vj0fjiJBo3pvLogjE4mI3Xw5R1
 4m8UrUUrEBI9Ian6fLGycTkLDBVd5WYhOOfD/mZ8j9q+1hlLQp9ft7z4jj8SklFsZs9zE2pEEL+
 jIFAu2RA885VMzOJlFNssoXBs0pqtTxSg3fkvyYiyR5jWcYaT6C4nQwNe5E9VuYnEO9GlT+G1EW
 si0Lzyrx4LDDsQv/4J8dJQkNv6iDBKNr8JeHyKps/vXopnjs4XziljFXb0t2WeZ5dVNafuKGGb
X-Received: by 2002:a05:6000:491e:b0:485:a964:be3d with SMTP id
 ffacd0b85a97d-48702ab66bbmr1193783f8f.13.1789370936155; 
 Mon, 14 Sep 2026 00:28:56 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-486eb330bdcsm25732716f8f.13.2026.09.14.00.28.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2026 00:28:55 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 712855F920;
 Mon, 14 Sep 2026 08:28:54 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org,  Brad Smith <brad@comstyle.com>,  Jiaxun Yang
 <jiaxun.yang@flygoat.com>,  Song Gao <gaosong@loongson.cn>,  Warner Losh
 <imp@bsdimp.com>,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  Peter
 Maydell <peter.maydell@linaro.org>,  Cornelia Huck <cohuck@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,  John Snow <jsnow@redhat.com>,  Paolo
 Bonzini <pbonzini@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@mailo.com>, Thomas Huth <th.huth+qemu@posteo.eu>,  Brian Cain
 <brian.cain@oss.qualcomm.com>,  qemu-arm@nongnu.org,  =?utf-8?Q?Marc-Andr?=
 =?utf-8?Q?=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,  Kyle Evans <kevans@freebsd.org>,  Richard
 Henderson <richard.henderson@linaro.org>,  Cleber Rosa <crosa@redhat.com>
Subject: Re: [PATCH 5/9] tests/docker: add container registry to configure
 and use
In-Reply-To: <abacad10-b9af-4a39-93c9-14b882f60bea@oss.qualcomm.com> (Pierrick
 Bouvier's message of "Sun, 13 Sep 2026 22:21:33 -0700")
References: <20260910181504.1010916-1-alex.bennee@linaro.org>
 <20260910181504.1010916-6-alex.bennee@linaro.org>
 <abacad10-b9af-4a39-93c9-14b882f60bea@oss.qualcomm.com>
User-Agent: mu4e 1.14.4-pre2; emacs 30.1
Date: Mon, 14 Sep 2026 08:28:54 +0100
Message-ID: <87qziw1ebt.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:30::10;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr2-x10.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> writes:

> On 9/10/26 11:15 AM, Alex Benn=C3=A9e wrote:
>> Previously we had the default baked into Makefile.include but as the
>> meson container logic will also benefit from it we update the configure
>> machinery.
>> For now we allow direct make invocations to override but for the
>> normal case it is in one place now.
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> ---
>>   configure                     | 8 ++++++++
>>   meson_options.txt             | 3 +++
>>   tests/docker/Makefile.include | 4 +---
>>   tests/tcg/meson.build         | 6 ++++++
>>   4 files changed, 18 insertions(+), 3 deletions(-)
>> diff --git a/configure b/configure
>> index aaa41fe47aa..7d6b11ddd35 100755
>> --- a/configure
>> +++ b/configure
>> @@ -172,6 +172,7 @@ fi
>>   # some defaults, based on the host environment
>>     # default parameters
>> +container_registry=3D"registry.gitlab.com/qemu-project/qemu"
>>   cpu=3D""
>>   cross_compile=3D"no"
>>   cross_prefix=3D""
>> @@ -728,6 +729,9 @@ for opt do
>>     ;;
>>     --container-command=3D*) meson_option_add -Dcontainer_command=3D"$op=
targ"
>>     ;;
>> +  --container-registry=3D*) container_registry=3D"$optarg"
>> +                          meson_option_add -Dcontainer_registry=3D"$opt=
arg"
>> +  ;;
>>     --rust-target-triple=3D*) rust_target_triple=3D"$optarg"
>>     ;;
>>     --gdb=3D*) meson_option_add -Dgdb=3D"$optarg"
>> @@ -862,6 +866,7 @@ Advanced options (experts only):
>>     --cpu=3DCPU                Build for host CPU [$cpu]
>>     --disable-containers     don't use containers for cross-building
>>     --container-command=3DCMD  which container command to use [autodetec=
t]
>> +  --container-registry=3DURL which container registry to cache from [$c=
ontainer_registry]
>>     --gdb=3DGDB-path           gdb to use for gdbstub tests [autodetect]
>>     --wasm64-32bit-address-limit Restrict wasm64 address space to 32-bit=
 (default
>>                                  is to use the whole 64-bit range).
>> @@ -1318,6 +1323,9 @@ echo "GENISOIMAGE=3D$genisoimage" >> $config_host_=
mak
>>   echo "MESON=3D$meson" >> $config_host_mak
>>   echo "NINJA=3D$ninja" >> $config_host_mak
>>   echo "EXESUF=3D$EXESUF" >> $config_host_mak
>> +if test -n "$container_registry"; then
>> +  echo "DOCKER_DEFAULT_REGISTRY=3D$container_registry" >> $config_host_=
mak
>> +fi
>>   if test "$default_targets" =3D "yes"; then
>>     echo "CONFIG_DEFAULT_TARGETS=3Dy" >> $config_host_mak
>>   fi
>> diff --git a/meson_options.txt b/meson_options.txt
>> index 292625af08a..030231492e1 100644
>> --- a/meson_options.txt
>> +++ b/meson_options.txt
>> @@ -391,6 +391,9 @@ option('containers', type: 'boolean', value: true,
>>          description: 'use containers to cross compile tcg tests')
>>   option('container_command', type: 'string',
>>          description: 'command to build/run containers')
>> +option('container_registry', type: 'string',
>> +       value: 'registry.gitlab.com/qemu-project/qemu',
>> +       description: 'container registry to cache from')
>>     option('tcg_tests_cross_cc_aarch64', type: 'string',
>>          description: 'cc for aarch64 tcg tests')
>> diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.inclu=
de
>> index 0adddb6a5c6..74bf471f171 100644
>> --- a/tests/docker/Makefile.include
>> +++ b/tests/docker/Makefile.include
>> @@ -11,9 +11,7 @@ USER =3D $(if $(NOUSER),,$(shell id -un))
>>   UID =3D $(if $(NOUSER),,$(shell id -u))
>>     DOCKER_FILES_DIR :=3D $(SRC_PATH)/tests/docker/dockerfiles
>> -ifeq ($(HOST_ARCH),x86_64)
>> -DOCKER_DEFAULT_REGISTRY :=3D registry.gitlab.com/qemu-project/qemu
>> -endif
>> +DOCKER_DEFAULT_REGISTRY ?=3D registry.gitlab.com/qemu-project/qemu
>>   DOCKER_REGISTRY :=3D $(if $(REGISTRY),$(REGISTRY),$(DOCKER_DEFAULT_REG=
ISTRY))
>>
>
> Couldn't we read the default from config_host_mak generated by
> configure instead?
>
>>   CONTAINER_COMMAND ?=3D $(shell $(SRC_PATH)/tests/docker/docker.py prob=
e)
>> diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
>> index 814f2f8cd8c..22157a47c96 100644
>> --- a/tests/tcg/meson.build
>> +++ b/tests/tcg/meson.build
>> @@ -101,6 +101,9 @@ if get_option('containers')
>>     endif
>>   endif
>>   tcg_tests_summary +=3D {'container command': container_command}
>> +if get_option('container_registry') !=3D ''
>> +  tcg_tests_summary +=3D {'container registry': get_option('container_r=
egistry')}
>> +endif
>>     # plugins come first, as we need to build the list
>>   test_plugins =3D {}
>> @@ -257,6 +260,9 @@ foreach target, plan: tcg_tests
>>       if cc_dockerfile not in image_targets and has_docker
>>         cmd =3D [docker_wrapper, 'build', '-f', dockerfile, '-t', 'qemu/=
' + cc_dockerfile,
>>                '--add-current-user']
>> +      if get_option('container_registry') !=3D ''
>> +        cmd +=3D ['--registry', get_option('container_registry')]
>> +      endif
>>         t =3D custom_target(image_name, command: cmd,
>>                           build_by_default: false,
>>                           output: 'no_output_' + image_name)
>
> Do user benefit from this, or is it mostly for CI need?

The aim is for faster image builds because the CI registry should always
be up to date. Most of the time the images don't change.

>
> The effect is to use --cache-from $registry, which I'm not sure is
> what we want by default, given all the "caching issues" we had
> previously with dockerfiles already.
> If that's for CI, maybe it could simply set with --container-command
> in our CI only.
>
> Regards,
> Pierrick

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

