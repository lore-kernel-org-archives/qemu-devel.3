Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94B45C88E77
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 19:08:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6YVK-0005Op-3a; Tue, 15 Sep 2026 15:07:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x6YVF-0005OG-HV
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 15:07:37 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x6YVC-0005xd-O3
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 15:07:37 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68FItcJF497812
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 19:07:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 B8IUSIYA5fIAD13hp5OVQzUKqX6NJDWbCv/Gc+CkNm0=; b=RREa2T7osj2GcObC
 Ijx97+tldgaz/aew2VcSefAV9nfVah2SWcut2L+fDLKrHSbGGzr3/+BZ/SzNoRbr
 4BdBKv2l+YIR6SsNQ549mT4QoRCzxlo0UVntTtezJ0rbDIuE/RYNZaoTY7TKeYVD
 MUS+AvznpkkwiQpTiXGZj7Xt7oUPFeqxwMjiQUkLDiURH33iY3sACkW6QnPcaqxr
 NSxbQk1IgysFEPcEK9PTVCW+ZnivMj1TJuPjy4OIxrl7sAwgk+Pc+B3sMi9OffZD
 Y9VX9gZugaUO5Wa9QDKdmLFy56XH4ZtDnQt5CAeqyw4/ATVqN5C7twJJHXsMgiDX
 EmDC9w==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gq3hc3809-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 19:07:21 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2dd188e16a2so54904485ad.2
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 12:07:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789499241; x=1790104041; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=B8IUSIYA5fIAD13hp5OVQzUKqX6NJDWbCv/Gc+CkNm0=;
 b=dqGYAVY8agzYbpNKvdTx5oL8gnRoEuy0ntIbKBREhlEXSfBz0hihy+EoOBjhVz+Obz
 Mg4tobjYOBGrammRkW5K+oO2UgGL0Plqmi1c+VMrmwceKfqNOSLZVpUIcHsse2mhFg58
 s3RJsFCEGV5mQ+nttueiO0RvfGaphfUpxhHnEOdrY9nNVTbGidHWDfBZLPt3MaNmnuQ5
 bQZvzVcpFr+FxOv0mSs/8Bn69OG0rWJkSCvGIM/p576verjiBFPXN5ybPNNLUh6x1+SB
 9MGa65a9XArb0Ndfsoeq/UhmXAC/+gyd1T8lA1jhl5ROHDkrhXtEO62i/DAH/vQfx4Gt
 uVqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789499241; x=1790104041;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=B8IUSIYA5fIAD13hp5OVQzUKqX6NJDWbCv/Gc+CkNm0=;
 b=ecNllX/vSSPEMt65zHpSxCxPPfwwdix5L9e5mZukRNiTj16Ivkd+tRtO1i5AmwfyEQ
 qQcCHqcj4x4dPao9zchxnGQmGgsWuXAa7zucBn62+ZyChTvNEWbb2rtiPb0t7tAO2feX
 XdxSqHSPRQvgR597hO3z3RvUSydb6x0YWftdUgpo+NIMtGx8efcqHF9OkWxAycJvOknF
 CGnVCS3oRaE7+knPoSTGc3zOiIw+wXQPFk1KhFsYuFEcu8cU5PrchRn3mY8WML7T6UB2
 KcVD/vZYn1RAVciEFK1BJFU5HkwbBhxD+f2WnpIcL9TZaZE1yL7YbcSP9tnh0TJFaBZ4
 i7qQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwXsYnAeFASB9PJ1krZRAgXrASwGkhv7zDGwT/BwJES/jBubkmald7aFgBuMQVuDzrjs8HRDZ7dlhGG@nongnu.org
X-Gm-Message-State: AFuF++njwT4WbSpi14tPkg0X42Oqjf73hhvasJoqcaf0Au0vviO+XkiQ
 vX+L7cj6Wbgq/UhYHq/eRt8RDDRBLwKW5XJorQ9UCvaBhYB8d2oHLnDy/EcfDCzviZPSlSmpGHH
 EvK0zWqRSpzGR4r7L/Zu7bG616F456fpLep/oGiShFs8ktCBP+DTrsgL4uQ==
X-Gm-Gg: AYBFou2F7pcZdYU4fIVROO0q3KzMt68qvt0WBvF0SNh0Lb61dWcGKgeyM/3MvIrVDcn
 JwvsS3xRBaPUG1qG/cDwoWPtRbKNpsZWJqPJP28pxxqmmQmshqzqBfAnJH3O7kvzhjlZH127VkP
 U6PzBAA7820VjreiVDXIKVT0i4a6ABP+LMuJ1MUHgUCj4u+jrbsIGu82f2Pwn+TeAClCMlFb5PS
 tmDlK2/xWByjD0Itk3uy91UtJJAzrUieAvZ/HcyLkSRjMhHVGdiICqf0bJhzw0yM/luFelgmavv
 laYN9TP12Flvr8lzXGsnu+4xDrQrtwnuzaJDDMSEgLBAujcXb80gF8wl5h0FyW9voW3W0kx7byU
 FbiwgoBEZ+gWSVLOUJq6R/Jedv3iH90yijBgIAgnypWfz2oACnOqfevTyER2/s0MWW88Z
X-Received: by 2002:a17:90b:4a82:b0:38c:a59b:5189 with SMTP id
 98e67ed59e1d1-39dec05f681mr16058390a91.15.1789499240510; 
 Tue, 15 Sep 2026 12:07:20 -0700 (PDT)
X-Received: by 2002:a17:90b:4a82:b0:38c:a59b:5189 with SMTP id
 98e67ed59e1d1-39dec05f681mr16058311a91.15.1789499239769; 
 Tue, 15 Sep 2026 12:07:19 -0700 (PDT)
Received: from [192.168.1.199] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14395caccf1sm699420c88.2.2026.09.15.12.07.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Sep 2026 12:07:18 -0700 (PDT)
Message-ID: <05149892-fad2-4576-a47d-bd8523ae6ada@oss.qualcomm.com>
Date: Tue, 15 Sep 2026 12:07:17 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL v2 000/105] move check-tcg into the meson build
To: John Snow <jsnow@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20260904150826.2331577-1-alex.bennee@linaro.org>
 <CAFEAcA9vZZmVPP3_P1xz-NX_sqWY0zrOC2LeGLTdnaK54XKQzQ@mail.gmail.com>
 <CAFn=p-bXoctWNEdERPBL-SMRPYDisban2e0-mxYjws7UVcjVzw@mail.gmail.com>
 <a80c4add-8c2a-4a20-8888-223fecc3f697@oss.qualcomm.com>
 <CAFn=p-bLuN2La1aqp7rpanjNiezUPk-v4D3kneGiHAPqPO-iyA@mail.gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <CAFn=p-bLuN2La1aqp7rpanjNiezUPk-v4D3kneGiHAPqPO-iyA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: S7QTonWLDQuTNxVKyr1efw6LhzAJrY3A
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE1MDI3OCBTYWx0ZWRfX8LVo6eogtvGA
 qdbChoKoDuS/dtDAdCyM31JFUo1o7EjXi13l/H8SN4vGi2NGBlv525As+lZxqrWxE8JFTfUsIEs
 TSKTR+Fcjeq0E2CKdf3U74Q1IX+waNs=
X-Authority-Analysis: v=2.4 cv=dcUVTnXe c=1 sm=1 tr=0 ts=6aa99769 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=NEAV23lmAAAA:8 a=p0WdMEafAAAA:8 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8
 a=DaujOAJNlQXT4kv3cWgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE1MDI3OCBTYWx0ZWRfX7BZXP7lYNrAF
 dovBvIIzWf71miclMd6V0KqRttN+sceAMIkZvxRUCHoTbxLoHANG/C4Q29n44GOZSD9XVR+/4GG
 5DQfKQKHNxDFPwPaVb36HbZ/orTcSiTOdMTgfnwaevX+i110CEwrdHJ8b/zLh4hCehbykqeUFJm
 bx2uwkr0wzMjnFFYPxgEkBMwBZpwo5TiEdfkUZ8JKXD6j/+seU+FvpifS7e5ipTCeCMwnA7gLka
 /w0o7gLe4+prUemYdUSxPoZl9xsjSDrxM3VyxrXCuEIBP2x8DBUbp9XlioULTpiMz66oFzOl3Ka
 HkYWCRYIIcE8MOH/Z7/0NdDyxorH+h4+pUB545u3aewUXudAIAn01uhH1D0vcS9tfLSoSLMGeOx
 XBAQAEHiYLaCLLIac1rmHFlkI6B0zo9Kb6qv0JNPWSUpU7p4l8a9rAWvgKIF8SUSB6MPJ1dQRVF
 6xsokyXaVCWUQXrXDeQ==
X-Proofpoint-GUID: S7QTonWLDQuTNxVKyr1efw6LhzAJrY3A
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_05,2026-09-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 impostorscore=0 malwarescore=0 phishscore=0
 suspectscore=0 clxscore=1015 spamscore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609150278
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

On 9/15/2026 11:26 AM, John Snow wrote:
> On Tue, Sep 15, 2026 at 1:17 PM Pierrick Bouvier
> <pierrick.bouvier@oss.qualcomm.com> wrote:
>>
>> On 9/15/2026 9:52 AM, John Snow wrote:
>>> On Fri, Sep 4, 2026 at 2:04 PM Peter Maydell <peter.maydell@linaro.org> wrote:
>>>>
>>>> On Fri, 4 Sept 2026 at 16:08, Alex Bennée <alex.bennee@linaro.org> wrote:
>>>>>
>>>>> The following changes since commit d2843fbf80260e4346c856819e8cea11768c9d0e:
>>>>>
>>>>>   Merge tag 'pull-riscv-to-apply-20260904' of https://github.com/alistair23/qemu into staging (2026-09-04 09:43:27 +0100)
>>>>>
>>>>> are available in the Git repository at:
>>>>>
>>>>>   https://gitlab.com/stsquad/qemu.git tags/pull-11.1-check-tcg-meson-040926-2
>>>>>
>>>>> for you to fetch changes up to 7a485176838e6b6044e73f925d308bb4b3002597:
>>>>>
>>>>>   MAINTAINERS: add maintainer for tcg/tests meson infrastructure (2026-09-04 16:06:22 +0100)
>>>>>
>>>>> ----------------------------------------------------------------
>>>>> tests/tcg: conversion to meson
>>>>>
>>>>>   - remove unused variable from multiarch/memory
>>>>>   - standardise checking plugin output
>>>>>   - bump minimal meson to 1.6.0
>>>>>   - introduce meson plumbing for check-tcg
>>>>>   - return error code if docker probe fails
>>>>>   - add CI/self/mem test to gdbstub prot-none tests
>>>>>   - use raw opcode for fprcvt test in arm
>>>>>   - remove unused variables from gpc-test
>>>>>   - teach probe-gdb-support about mips
>>>>>   - identify or1k pc register
>>>>>   - port check-tcg logic to meson (all targets)
>>>>>   - update documentation
>>>>>   - add Pierrick as a maintainer for tests/tcg
>>>
>>> Hi, I'm having difficulties building after this PR, after eb7f0c14 in
>>> particular.
>>>
>>> I keep seeing stuff like this:
>>>
>>> FAILED: [code=1] tests/tcg/x86_64-softmmu-hello.test
>>> /home/jsnow/src/qemu/tests/tcg/../docker/docker.py --command podman
>>> run --run-as-current-user -w /home/jsnow/src/qemu/build -v
>>> /home/jsnow/src/qemu:/home/jsnow/src/qemu debian-amd64-cross
>>> x86_64-linux-gnu-gcc
>>> /home/jsnow/src/qemu/tests/tcg/multiarch/system/hello.c -o
>>> tests/tcg/x86_64-softmmu-hello.test -static -MMD -MF
>>> tests/tcg/x86_64-softmmu-hello.d -Wall -Werror -O0 -g
>>> -fno-strict-aliasing -nostdlib -ffreestanding -Wa,--noexecstack -I
>>> /home/jsnow/src/qemu/tests/tcg/x86_64/system/../../minilib
>>> /home/jsnow/src/qemu/tests/tcg/x86_64/system/../../minilib/printf.c
>>> ../tests/tcg/x86_64/system/boot.S -Wl,-T
>>> ../tests/tcg/x86_64/system/kernel.ld -Wl,-melf_x86_64
>>> -Wl,--no-warn-rwx-segments -Wl,--build-id=none -lgcc
>>> cc1: fatal error:
>>> /home/jsnow/src/qemu/tests/tcg/multiarch/system/hello.c: Permission
>>> denied
>>> compilation terminated.
>>> cc1: fatal error:
>>> /home/jsnow/src/qemu/tests/tcg/x86_64/system/../../minilib/printf.c:
>>> Permission denied
>>> compilation terminated.
>>> cc1: fatal error: ../tests/tcg/x86_64/system/boot.S: Permission denied
>>> compilation terminated.
>>> Traceback (most recent call last):
>>>   File "/home/jsnow/src/qemu/tests/tcg/../docker/docker.py", line 657,
>>> in <module>
>>>     sys.exit(main())
>>>              ~~~~^^
>>>   File "/home/jsnow/src/qemu/tests/tcg/../docker/docker.py", line 653, in main
>>>     return args.cmdobj.run(args, argv)
>>>            ~~~~~~~~~~~~~~~^^^^^^^^^^^^
>>>   File "/home/jsnow/src/qemu/tests/tcg/../docker/docker.py", line 395, in run
>>>     return Docker(args.command).run(argv, args.keep, quiet=args.quiet,
>>>            ~~~~~~~~~~~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>>>                                     as_user=args.run_as_current_user)
>>>                                     ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>>>   File "/home/jsnow/src/qemu/tests/tcg/../docker/docker.py", line 353, in run
>>>     ret = self._do_check(["run", "--rm", "--label",
>>>                          "com.qemu.instance.uuid=" + label] + cmd,
>>>                          quiet=quiet)
>>>   File "/home/jsnow/src/qemu/tests/tcg/../docker/docker.py", line 230,
>>> in _do_check
>>>     return subprocess.check_call(self._command + cmd, **kwargs)
>>>            ~~~~~~~~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>>>   File "/usr/lib64/python3.14/subprocess.py", line 420, in check_call
>>>     raise CalledProcessError(retcode, cmd)
>>> subprocess.CalledProcessError: Command '['podman', 'run', '--rm',
>>> '--label', 'com.qemu.instance.uuid=0df29d1fcdc947f1b0cde41104eebed9',
>>> '--userns=keep-id', '-u', '21266', '-w', '/home/jsnow/src/qemu/build',
>>> '-v', '/home/jsnow/src/qemu:/home/jsnow/src/qemu',
>>> 'debian-amd64-cross', 'x86_64-linux-gnu-gcc',
>>> '/home/jsnow/src/qemu/tests/tcg/multiarch/system/hello.c', '-o',
>>> 'tests/tcg/x86_64-softmmu-hello.test', '-static', '-MMD', '-MF',
>>> 'tests/tcg/x86_64-softmmu-hello.d', '-Wall', '-Werror', '-O0', '-g',
>>> '-fno-strict-aliasing', '-nostdlib', '-ffreestanding',
>>> '-Wa,--noexecstack', '-I',
>>> '/home/jsnow/src/qemu/tests/tcg/x86_64/system/../../minilib',
>>> '/home/jsnow/src/qemu/tests/tcg/x86_64/system/../../minilib/printf.c',
>>> '../tests/tcg/x86_64/system/boot.S', '-Wl,-T',
>>> '../tests/tcg/x86_64/system/kernel.ld', '-Wl,-melf_x86_64',
>>> '-Wl,--no-warn-rwx-segments', '-Wl,--build-id=none', '-lgcc']'
>>> returned non-zero exit status 1.
>>> filter=--filter=label=com.qemu.instance.uuid=0df29d1fcdc947f1b0cde41104eebed9
>>> ninja: build stopped: subcommand failed.
>>> make: *** [Makefile:170: run-ninja] Error 1
>>>
>>
>> Interesting, it seems to be an issue with podman user mapping.
> 
> Maybe something I set up ages ago and promptly forgot about? I haven't
> fussed with user mapping permissions in several aeons, it's possible I
> have something stale in some config somewhere ...
> 
>>
>> Which distro you use (especially which version)?
> 
> ~> cat /etc/fedora-release
> Fedora release 44 (Forty Four)
> 
>>
>> Also, could you please report output of those commands:
>> $ podman --version
> 
> ~> podman --version
> podman version 5.8.4
> 
>> $ ls -al /home/jsnow/src/qemu/tests/tcg/multiarch/system/hello.c
> 
> ~> ls -al /home/jsnow/src/qemu/tests/tcg/multiarch/system/hello.c
> -rw-r--r--. 1 jsnow jsnow 229 May  7  2025
> /home/jsnow/src/qemu/tests/tcg/multiarch/system/hello.c
> 
>> $ /home/jsnow/src/qemu/tests/tcg/../docker/docker.py --command podman \
>>   run --run-as-current-user -w /home/jsnow/src/qemu/build -v \
>>   /home/jsnow/src/qemu:/home/jsnow/src/qemu debian-amd64-cross \
>>   touch -v new_file && ls -al new_file
> 
> There's no "-v" option for touch, but:
>

Copy-paste mistake sorry, thanks for fixing command.

> ~> /home/jsnow/src/qemu/tests/tcg/../docker/docker.py --command podman \
>                                                                   run
> --run-as-current-user -w /home/jsnow/src/qemu/build -v \
> 
> /home/jsnow/src/qemu:/home/jsnow/src/qemu debian-amd64-cross \
> 
> touch new_file && ls -al new_file
> touch: cannot touch 'new_file': Permission denied
> Traceback (most recent call last):
>   File "/home/jsnow/src/qemu/tests/tcg/../docker/docker.py", line 657,
> in <module>
>     sys.exit(main())
>              ~~~~^^
>   File "/home/jsnow/src/qemu/tests/tcg/../docker/docker.py", line 653, in main
>     return args.cmdobj.run(args, argv)
>            ~~~~~~~~~~~~~~~^^^^^^^^^^^^
>   File "/home/jsnow/src/qemu/tests/tcg/../docker/docker.py", line 395, in run
>     return Docker(args.command).run(argv, args.keep, quiet=args.quiet,
>            ~~~~~~~~~~~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>                                     as_user=args.run_as_current_user)
>                                     ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>   File "/home/jsnow/src/qemu/tests/tcg/../docker/docker.py", line 353, in run
>     ret = self._do_check(["run", "--rm", "--label",
>                          "com.qemu.instance.uuid=" + label] + cmd,
>                          quiet=quiet)
>   File "/home/jsnow/src/qemu/tests/tcg/../docker/docker.py", line 230,
> in _do_check
>     return subprocess.check_call(self._command + cmd, **kwargs)
>            ~~~~~~~~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>   File "/usr/lib64/python3.14/subprocess.py", line 420, in check_call
>     raise CalledProcessError(retcode, cmd)
> subprocess.CalledProcessError: Command '['podman', 'run', '--rm',
> '--label', 'com.qemu.instance.uuid=d2faaf6ef4914d83b429069b4497cbb2',
> '--userns=keep-id', '-u', '21266', '-w', '/home/jsnow/src/qemu/build',
> '-v', '/home/jsnow/src/qemu:/home/jsnow/src/qemu',
> 'debian-amd64-cross', 'touch', 'new_file']' returned non-zero exit
> status 1.
> filter=--filter=label=com.qemu.instance.uuid=d2faaf6ef4914d83b429069b4497cbb2
>

What is the content of your /etc/subuid?

Giving your user id (21266), I guess you have a LDAP account or
something similar: not a local account.
I had the same issue on my corporate VM, and had to add an explicit
mapping for my user.

You should have something like:

$ cat /etc/subuid
jsnow:100000:65536
$ cat /etc/subgid
jsnow:100000:65536

Let me know if it solves your problem, else we'll find something else.

> 
> 
>>
>> This should help us to see what's your effective uid in the container.
>> Maybe this issue was present before, did you try running make check-tcg
>> in the past, or not?
>>
>>> Is there some kind of setup I have neglected to perform to make this
>>> new build system work? Is there a way I can skip these tests in the
>>> meantime...?
>>>
>>
>> You can use ./configure --disable-containers, so it will not try to use
>> podman.
>>
>>> Thanks,
>>> --js
>>>
>>>
>>
>> Regards,
>> Pierrick
>>
> 


