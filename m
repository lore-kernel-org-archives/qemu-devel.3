Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFD9DC88E77
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 17:18:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6Wmu-0005fh-LO; Tue, 15 Sep 2026 13:17:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x6Wmt-0005fJ-32
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 13:17:43 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x6Wmq-0005FK-HV
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 13:17:42 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68FFAUFB4176153
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 17:17:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 WJuJxcAQo+SgAZ08+yYwoIp72NrLJnkqBgIT42c7djA=; b=OSLyDEqNAidsCONd
 1sKVgE+yaf7H4FTdl4PCrmGsnkSer9XxW0vfF0Oq38HO2Rd7yKNGFx1zcRqisUbl
 ynUwZdiQo5Re37+cH8cKnGaSp+bwutzOzmCuYGct1sQlF6Vls9wk2kzuLds7DFwx
 TCU+ZmCMeVw0YmmnK94Nrn3dXkt6GK3YEjkcSnYw/ujSA559I9U9jFHd6MVqgEHQ
 ecrSgch4h/tp3aGJNzD9Fa+RaROjhAmXnNf7r1+3AvrpZ+ciYYGY4aYjpnHVeo0U
 lVh/pQsq7oe/wIKd/kZRJ8wfJxbGyr8g+iVXA0Ku1/PTex8IUh4ZpJcB3TtvYz4F
 kPZXGg==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gq3hc2ntn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 17:17:36 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-cc4fc935a11so1245020a12.0
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 10:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789492642; x=1790097442; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=WJuJxcAQo+SgAZ08+yYwoIp72NrLJnkqBgIT42c7djA=;
 b=A7cuLCmSG+CQYd3QOHkrFZ7NcSvC5h+8TZgo81yNDnYEc+CehnOAx0RXyEQkdJ+AcZ
 +Q9kPsIpcH155TGdlpA/cJ+DfYmBD7KG9csDypeNY2F2b5TUrRSnTI4r3csRmHWtmD9a
 huaQn6Nh6g64NVamR4mqS/Cq9SvUir05ZDnZURxCzmnLdgIJBXl2wJj1g+FtBxjr30l1
 nTbT2hZxbR85Gj6U9gJEPK5QMOF8hs6AmHQx81uJo0fDGgDq4LfYKgRQvI8pVUcbcfaE
 K2MCavXucTeiNpZaOfo7TNHg6WXqnu7qMJNhnSgY7H+cspS9Ag7ml5CW4ROCTwGJPP+g
 Nq5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789492642; x=1790097442;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=WJuJxcAQo+SgAZ08+yYwoIp72NrLJnkqBgIT42c7djA=;
 b=BifRub0SPCX+MnNRiImJOJ+gKy52NXFB35BZ7pfcKrTgs4bwnIaK9XjPUo23IOl2YS
 sBsMr506JSBF5apMJhGI99WaASkFs6abAwzAXK3EEmgHYnav9CMXfP4JpY9Bhsnnq08y
 4fKL/UBq1/kyIs9kBSVDg5khvna69XvHL7dE0AizPPiWUwhFZCN8R69lMuI7aKsexQL7
 d0+50reIlNw4iPFIjf1k5j0ZciWo4dQBdF/dNbbquTAVSJmNG4hLWmFBmEyuITx87npH
 S5yEvzPUd6XBvk/LQSGo6OW+E9RshR5HUgOTgTBbcr1wEU7S3mjC/eVhmflFm1XoaYPn
 V/ZA==
X-Forwarded-Encrypted: i=1;
 AKwUvBx9vxuP9+hsHWJJXlLh3/rVq77oGAqToVucKkQbyi5opF09Dzft5z8YzJ65HHDq2J/jRY8XoZQfcQqH@nongnu.org
X-Gm-Message-State: AFuF++mfWakFPjfl6sH1nZIkzt1mghcPLfxHOcSdcHsj4gFnGnEnoPRu
 oSOFGTmO5LNJvtlBvnBqJ8u8Z60WcHDHRX7p3hc01WJGoz4T9UtVJCOLl6viGIu2Dkn8AxHq9/N
 rDQJgzt8IP53PgEbr+eKN+ZcP4sAVovsKMAQJ9lMg4P0fhkdD76ZsvNes5Q==
X-Gm-Gg: AYBFou3VCUKme2ZT1E8No9LEzSLQcZpAg7gbXsSAIEzPNmNwGRjBbALXHMJ/sYoEjW2
 d8jawTnbEsHI9UhJjGdzwjUqrcmKLbMVLu/17EdnHFjITccSP7ZrOxQgXbgy5GkbIEy10i1wxGh
 QFSNj9ftKhb1vdPPhEh08ZOJOCxnjvpUqX/tLyEHtGuAArEmfI7SkgvxsAy3Hievt3ZqNNDkVYJ
 H96MftxNyMKBTZsTCa4x9l/V+VRh/eOrvyAvf2pjjIHKxzDcPr+UVQEgf4Ly2c4ltSR2HPYo8G9
 IbTYIS6cu3pFMwdHk75sQ00f+RHO+X8YAdgXwRYpkJdpxYPfOpKcDhccB7cS6Rnz6ViLC9oNknb
 clUG3XRgx5/V+wLznj3uO4UJ32fDWlh3d1/8gOfFMBNqfPQSx9vNW6bfwfvRsAQdiNBPe
X-Received: by 2002:a17:90a:f944:b0:39e:1692:fd12 with SMTP id
 98e67ed59e1d1-39e1692fed9mr1801026a91.24.1789492642028; 
 Tue, 15 Sep 2026 10:17:22 -0700 (PDT)
X-Received: by 2002:a17:90a:f944:b0:39e:1692:fd12 with SMTP id
 98e67ed59e1d1-39e1692fed9mr1800958a91.24.1789492641537; 
 Tue, 15 Sep 2026 10:17:21 -0700 (PDT)
Received: from [192.168.1.199] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14395cacce6sm275188c88.1.2026.09.15.10.17.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Sep 2026 10:17:21 -0700 (PDT)
Message-ID: <a80c4add-8c2a-4a20-8888-223fecc3f697@oss.qualcomm.com>
Date: Tue, 15 Sep 2026 10:17:19 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL v2 000/105] move check-tcg into the meson build
To: John Snow <jsnow@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20260904150826.2331577-1-alex.bennee@linaro.org>
 <CAFEAcA9vZZmVPP3_P1xz-NX_sqWY0zrOC2LeGLTdnaK54XKQzQ@mail.gmail.com>
 <CAFn=p-bXoctWNEdERPBL-SMRPYDisban2e0-mxYjws7UVcjVzw@mail.gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <CAFn=p-bXoctWNEdERPBL-SMRPYDisban2e0-mxYjws7UVcjVzw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: Mkpimb7hn7BXynUabMCm1xzNYVWdqPPu
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE1MDI1MiBTYWx0ZWRfX1CK+kRKtslNM
 yAnalX4izX+ZLZm9FKGTo5ezPiiITf2SAoGFinDp3rO4d9Dh7xFVMqqE8svNW4U1Ee+gxEkMsuv
 KBThoilYhJ8MhhsL3Qa8RGto2p3vnII=
X-Authority-Analysis: v=2.4 cv=dcUVTnXe c=1 sm=1 tr=0 ts=6aa97db1 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=NEAV23lmAAAA:8 a=p0WdMEafAAAA:8 a=KKAkSRfTAAAA:8 a=3KShrHkYSoLE9HqnjeIA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE1MDI1MiBTYWx0ZWRfX8d3ICilXHe6d
 jNTD+b3nM2aBuDUVqtZyZgZhj9x55u8m1/cCFO1qcpvlUi9phpF0Ha+y5B7QY5IicQh5NfwX0he
 GTxJpFEwODKa5o/5NZlKY8Yr0k0u2jnIVCVAQN6oKdmJgiljC4EOL3pThRSyLJM6RayWXaWZwRW
 mAYCjW3eErllmFYR265P6PHeo7dgIuS9qV7QU1e8VwOOTHrP2ZjPVMQz4kPBFOw2utS8c82eTkc
 SkXR5VU8F2J3oiFnpTqBNE3VjQwEf0bTrJ13vjpXv1qXC1YHk+KCbhKIQyMmwQcnIoTVoyiE8pY
 sVj+pyj/USmJ1rBYGNdMbXa79Lo7HEua6ZCrjoE0x+pPjReFN4HtIzn7Y5TvEWFvEecTsbXPr+H
 PFL1yEouXvz0aXAp+CezHzvKDqGKMb5h7Fje8hKcERUBq++viiURVBZmz5WuNmW8JNO62zxVpQT
 eyINzMJzt9vM/IwgszQ==
X-Proofpoint-GUID: Mkpimb7hn7BXynUabMCm1xzNYVWdqPPu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_04,2026-09-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 impostorscore=0 malwarescore=0 phishscore=0
 suspectscore=0 clxscore=1015 spamscore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609150252
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

On 9/15/2026 9:52 AM, John Snow wrote:
> On Fri, Sep 4, 2026 at 2:04 PM Peter Maydell <peter.maydell@linaro.org> wrote:
>>
>> On Fri, 4 Sept 2026 at 16:08, Alex Bennée <alex.bennee@linaro.org> wrote:
>>>
>>> The following changes since commit d2843fbf80260e4346c856819e8cea11768c9d0e:
>>>
>>>   Merge tag 'pull-riscv-to-apply-20260904' of https://github.com/alistair23/qemu into staging (2026-09-04 09:43:27 +0100)
>>>
>>> are available in the Git repository at:
>>>
>>>   https://gitlab.com/stsquad/qemu.git tags/pull-11.1-check-tcg-meson-040926-2
>>>
>>> for you to fetch changes up to 7a485176838e6b6044e73f925d308bb4b3002597:
>>>
>>>   MAINTAINERS: add maintainer for tcg/tests meson infrastructure (2026-09-04 16:06:22 +0100)
>>>
>>> ----------------------------------------------------------------
>>> tests/tcg: conversion to meson
>>>
>>>   - remove unused variable from multiarch/memory
>>>   - standardise checking plugin output
>>>   - bump minimal meson to 1.6.0
>>>   - introduce meson plumbing for check-tcg
>>>   - return error code if docker probe fails
>>>   - add CI/self/mem test to gdbstub prot-none tests
>>>   - use raw opcode for fprcvt test in arm
>>>   - remove unused variables from gpc-test
>>>   - teach probe-gdb-support about mips
>>>   - identify or1k pc register
>>>   - port check-tcg logic to meson (all targets)
>>>   - update documentation
>>>   - add Pierrick as a maintainer for tests/tcg
> 
> Hi, I'm having difficulties building after this PR, after eb7f0c14 in
> particular.
> 
> I keep seeing stuff like this:
> 
> FAILED: [code=1] tests/tcg/x86_64-softmmu-hello.test
> /home/jsnow/src/qemu/tests/tcg/../docker/docker.py --command podman
> run --run-as-current-user -w /home/jsnow/src/qemu/build -v
> /home/jsnow/src/qemu:/home/jsnow/src/qemu debian-amd64-cross
> x86_64-linux-gnu-gcc
> /home/jsnow/src/qemu/tests/tcg/multiarch/system/hello.c -o
> tests/tcg/x86_64-softmmu-hello.test -static -MMD -MF
> tests/tcg/x86_64-softmmu-hello.d -Wall -Werror -O0 -g
> -fno-strict-aliasing -nostdlib -ffreestanding -Wa,--noexecstack -I
> /home/jsnow/src/qemu/tests/tcg/x86_64/system/../../minilib
> /home/jsnow/src/qemu/tests/tcg/x86_64/system/../../minilib/printf.c
> ../tests/tcg/x86_64/system/boot.S -Wl,-T
> ../tests/tcg/x86_64/system/kernel.ld -Wl,-melf_x86_64
> -Wl,--no-warn-rwx-segments -Wl,--build-id=none -lgcc
> cc1: fatal error:
> /home/jsnow/src/qemu/tests/tcg/multiarch/system/hello.c: Permission
> denied
> compilation terminated.
> cc1: fatal error:
> /home/jsnow/src/qemu/tests/tcg/x86_64/system/../../minilib/printf.c:
> Permission denied
> compilation terminated.
> cc1: fatal error: ../tests/tcg/x86_64/system/boot.S: Permission denied
> compilation terminated.
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
> '--label', 'com.qemu.instance.uuid=0df29d1fcdc947f1b0cde41104eebed9',
> '--userns=keep-id', '-u', '21266', '-w', '/home/jsnow/src/qemu/build',
> '-v', '/home/jsnow/src/qemu:/home/jsnow/src/qemu',
> 'debian-amd64-cross', 'x86_64-linux-gnu-gcc',
> '/home/jsnow/src/qemu/tests/tcg/multiarch/system/hello.c', '-o',
> 'tests/tcg/x86_64-softmmu-hello.test', '-static', '-MMD', '-MF',
> 'tests/tcg/x86_64-softmmu-hello.d', '-Wall', '-Werror', '-O0', '-g',
> '-fno-strict-aliasing', '-nostdlib', '-ffreestanding',
> '-Wa,--noexecstack', '-I',
> '/home/jsnow/src/qemu/tests/tcg/x86_64/system/../../minilib',
> '/home/jsnow/src/qemu/tests/tcg/x86_64/system/../../minilib/printf.c',
> '../tests/tcg/x86_64/system/boot.S', '-Wl,-T',
> '../tests/tcg/x86_64/system/kernel.ld', '-Wl,-melf_x86_64',
> '-Wl,--no-warn-rwx-segments', '-Wl,--build-id=none', '-lgcc']'
> returned non-zero exit status 1.
> filter=--filter=label=com.qemu.instance.uuid=0df29d1fcdc947f1b0cde41104eebed9
> ninja: build stopped: subcommand failed.
> make: *** [Makefile:170: run-ninja] Error 1
>

Interesting, it seems to be an issue with podman user mapping.

Which distro you use (especially which version)?

Also, could you please report output of those commands:
$ podman --version
$ ls -al /home/jsnow/src/qemu/tests/tcg/multiarch/system/hello.c
$ /home/jsnow/src/qemu/tests/tcg/../docker/docker.py --command podman \
  run --run-as-current-user -w /home/jsnow/src/qemu/build -v \
  /home/jsnow/src/qemu:/home/jsnow/src/qemu debian-amd64-cross \
  touch -v new_file && ls -al new_file

This should help us to see what's your effective uid in the container.
Maybe this issue was present before, did you try running make check-tcg
in the past, or not?

> Is there some kind of setup I have neglected to perform to make this
> new build system work? Is there a way I can skip these tests in the
> meantime...?
>

You can use ./configure --disable-containers, so it will not try to use
podman.

> Thanks,
> --js
> 
> 

Regards,
Pierrick

