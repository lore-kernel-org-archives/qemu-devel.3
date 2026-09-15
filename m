Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1F6BC88E7D
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 20:05:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6ZOe-0005Jp-UA; Tue, 15 Sep 2026 16:04:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x6ZOc-0005JL-DN
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 16:04:50 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x6ZOZ-0000Q3-Dy
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 16:04:50 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68FItt1s971370
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 20:04:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 VQ6WDl8R1iMYAMNFIi6hHRYkNG3lhEq4kXkBmPzFH4M=; b=eGDarFE864OufN/E
 lojftKwyjeqCgoFIFIHUG/5nDJ5ZAuTI1XBCvIH3PhMDLtf8naEAxXciZb1LBs40
 NgYUEj1KhksZeT5XLEfQcO7cy8/4qYuNWXu1DcJuuvg2G3kriP3eTkY8SpW5Qu1P
 1XIQO5SoZt8pgnT7vzvN0Cswp/1QWLvUqi0cJNuffq0KmoVGiaLMtgk2B29mj0O5
 rDJCHDtP1aLKJ0wM/rSti+msgg/AfGSxt39EtvZ0YpnDOh7yNni7K51C19Mi/Biq
 6UUXc1xpBCzB8qXGGS05O6nvudEFpolDZdD6qrVnGSlY92EBwwLt/R7gY87lVF17
 I8H6dw==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gq0jeupws-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 20:04:45 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-38e8e864ef0so8292846a91.0
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 13:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789502684; x=1790107484; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=VQ6WDl8R1iMYAMNFIi6hHRYkNG3lhEq4kXkBmPzFH4M=;
 b=Bn3x2phVeDddrQhRj7ONi19M5EmkS2zDm+aUlRiFB7Vm5shzmOg3LBfvP+1kmkXVci
 W6jGT5f7/EiG/C+vwk+eB1ssyRyev7kxf97lbaK3UJho5Y9GxJE1MXh/YElR7OFWTLWp
 ohELCN8Tz7svpcskFGcd4sMJHiGSbdDR3/lV7350XAqr62bnMyEfgM6ux6Nw8INay6Mt
 PwXFfHOBbhg6aYdMY2nmymrclslMkYgGYng9KEM+6rYIhKbjTpFqOOi8OatA7Klg2Idg
 egH55gbSPVrHRJem24tkmjSXkPjv+g2z3cI8LVB8ra+FsW9/jwqL7T4SAn6OFrZSnTii
 1Ciw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789502684; x=1790107484;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=VQ6WDl8R1iMYAMNFIi6hHRYkNG3lhEq4kXkBmPzFH4M=;
 b=kltXdKf0i0GygZ4dBIaLyGOvVyfG/NKRHm4UEin+GFtPtqh1AhI+8r0bEUAc3kNvoO
 IYvYirI3LtkvyNSmKKijXz9jVzA5DybXcdsJuVJIFF6s3z5wzZcPfUnabhsDS547Di6K
 4HqLKecVdkm86VuEFkILMAKHf8FVD9NvmAxqGgp+gHTxF/E/rDO8asVphzSiDXyYG7I7
 0JXCwLh2Z4dc/1chjDDyDbArA37MzxZmZMU+docD1gQ7X3wOrEW4YmpTyXbyL/42Yhm5
 9s2U2Q35CVv09d7tDTVc5rzSwtvKnj1dBEnv9dh4R885xriy2PIK4EXfXrMKF7SJssZ1
 ghFg==
X-Forwarded-Encrypted: i=1;
 AKwUvByRe3S+d/EIYaVVsY9WhhtcOlpz3kdZzdxsVSvDa1UvP8EoCA9jkTSI45gO2XDPaxD9qF1n6bioWMCs@nongnu.org
X-Gm-Message-State: AFuF++liljZLkdJGZP+FgfB9zJDiAxLKVvfDQ1vD32NlcHkQHXFzVP7C
 X5VeOimMWhSn4hxBpPPCJHrJX2crI2G1F+ZCarg8TMSXXt+eM7LRK/Fo+IRcH2PkU2hVxyb/FBP
 t6XA4uya+VXZ+E/5ANMWVJcmHQE490hwWaSa/aq3k3DU/SX/Fbshs4kAMCw==
X-Gm-Gg: AYBFou0F9F8S704OO5R/hFqkc/TxYrWbPwsZRvU7UYbWxwVKPpN+4zlsfuk2popkIuE
 JrMlfLNBB/XABnxAEIDzO7vgBLBDkq6e5DtlY+iyeJ/jptlMs/znnrC+ALT0dXm3uZciFdkR8hU
 dBUE+f1nQwywSJ+u9Ztn966Ih0jRH/uJlEtPTTJlFmzPCmWM+tPhodhvwUG8D7kpc0MIYC9GEB5
 anxIN+9PzNnnu5trMRdb7/O5JuhISZGs7uUStxADAwqnS/onxxxTsf+DZFeQgbagaDir+h5HwLS
 WSjCBYnM8YWMly3vcT3i/OJjNK3phC/0Qh9T+eHFsLaZ2IkcxLbnVp9aB6NqgCk3zq1G6Oc/PXD
 e7/4lCEKaGB5g6j8Q0u5daR9/ykfv3QzOFjsN77PP8ycs7qK1WXT8rsuX7Mwe5blQKD28
X-Received: by 2002:a17:90b:5887:b0:39e:8d5:fcee with SMTP id
 98e67ed59e1d1-39e08d5fe14mr8001811a91.17.1789502684107; 
 Tue, 15 Sep 2026 13:04:44 -0700 (PDT)
X-Received: by 2002:a17:90b:5887:b0:39e:8d5:fcee with SMTP id
 98e67ed59e1d1-39e08d5fe14mr8001701a91.17.1789502683357; 
 Tue, 15 Sep 2026 13:04:43 -0700 (PDT)
Received: from [192.168.1.199] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33bf5af4f0bsm1472700eec.24.2026.09.15.13.04.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Sep 2026 13:04:42 -0700 (PDT)
Message-ID: <ce78d727-046a-4755-b807-a996f06ae47b@oss.qualcomm.com>
Date: Tue, 15 Sep 2026 13:04:41 -0700
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
 <05149892-fad2-4576-a47d-bd8523ae6ada@oss.qualcomm.com>
 <CAFn=p-a64Dq7NOJo-7KqtkGovw6m+r_7q6ronAoy5ivWRGgZSg@mail.gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <CAFn=p-a64Dq7NOJo-7KqtkGovw6m+r_7q6ronAoy5ivWRGgZSg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE1MDI5MyBTYWx0ZWRfX3wMOVKOOzjGO
 1uu1tVKaPL7Yi/PnAQv8PM8ovzFqHaxylyYvYuIJQWR9Te+Tw1MluilyToWkTW5l3HjkTDC9xSx
 1z3VwomTVv0Ao+pQWV/1ZIpQxTlhUtQ=
X-Authority-Analysis: v=2.4 cv=Kr/YSmWN c=1 sm=1 tr=0 ts=6aa9a4dd cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=NEAV23lmAAAA:8 a=p0WdMEafAAAA:8 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8
 a=QimnV0fFZErb6rn68s4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: 7MdSsvH0Kkce__bZyaaqQ7sSQVk55J_U
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE1MDI5MyBTYWx0ZWRfX3sEBln2cM8wH
 YURV+B+CoxkFXx6DmxtNmge3gwuMP9+l8pFE5JAWhktSMET6HTJMAj3UlKtD71dAtsFnKuBue+Q
 +A6ZJRCPKJoW1P2URmUPtaS3thaAymiDfp6Z6+dGi7Z8+qVcNSYAASGPXsPsP6d0cKjC3HeEGpU
 C8UT13oaxGiz9nyHXbN6lM2cUUYXy2QJxKZARXQGFHmKt4zMXM3zTjmEpGwxemC/wyxZHn1mA+V
 ZwyDq3xLxVUCVGQg7822h5TmrqD93+0ypkR9W9n8ldC5+fP+5hRalRveyVEKg74gkKo9WsvUFSf
 Wf+rx8xbqVvDZbr8t1XCiXTuiHsWU5H99AKmOaz6eF6mj6M/5k0qoNgWUSDjcmKJDwMmndUTMTK
 wNBKq+hvzja5t2KvJUZuTjtFnJpeJXsxv8DlSsM3Eb+jUO20fsK4HjTIJEGoDHYyMnncdjzHoY5
 O+LiZIMzxuTkcLCefsw==
X-Proofpoint-ORIG-GUID: 7MdSsvH0Kkce__bZyaaqQ7sSQVk55J_U
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_05,2026-09-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 phishscore=0 bulkscore=0 suspectscore=0
 priorityscore=1501 impostorscore=0 adultscore=0 lowpriorityscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609150293
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

On 9/15/2026 12:22 PM, John Snow wrote:
> On Tue, Sep 15, 2026 at 3:07 PM Pierrick Bouvier
> <pierrick.bouvier@oss.qualcomm.com> wrote:
>>
>> On 9/15/2026 11:26 AM, John Snow wrote:
>>> On Tue, Sep 15, 2026 at 1:17 PM Pierrick Bouvier
>>> <pierrick.bouvier@oss.qualcomm.com> wrote:
>>>>
>>>> On 9/15/2026 9:52 AM, John Snow wrote:
>>>>> On Fri, Sep 4, 2026 at 2:04 PM Peter Maydell <peter.maydell@linaro.org> wrote:
>>>>>>
>>>>>> On Fri, 4 Sept 2026 at 16:08, Alex Bennée <alex.bennee@linaro.org> wrote:
>>>>>>>
>>>>>>> The following changes since commit d2843fbf80260e4346c856819e8cea11768c9d0e:
>>>>>>>
>>>>>>>   Merge tag 'pull-riscv-to-apply-20260904' of https://github.com/alistair23/qemu into staging (2026-09-04 09:43:27 +0100)
>>>>>>>
>>>>>>> are available in the Git repository at:
>>>>>>>
>>>>>>>   https://gitlab.com/stsquad/qemu.git tags/pull-11.1-check-tcg-meson-040926-2
>>>>>>>
>>>>>>> for you to fetch changes up to 7a485176838e6b6044e73f925d308bb4b3002597:
>>>>>>>
>>>>>>>   MAINTAINERS: add maintainer for tcg/tests meson infrastructure (2026-09-04 16:06:22 +0100)
>>>>>>>
>>>>>>> ----------------------------------------------------------------
>>>>>>> tests/tcg: conversion to meson
>>>>>>>
>>>>>>>   - remove unused variable from multiarch/memory
>>>>>>>   - standardise checking plugin output
>>>>>>>   - bump minimal meson to 1.6.0
>>>>>>>   - introduce meson plumbing for check-tcg
>>>>>>>   - return error code if docker probe fails
>>>>>>>   - add CI/self/mem test to gdbstub prot-none tests
>>>>>>>   - use raw opcode for fprcvt test in arm
>>>>>>>   - remove unused variables from gpc-test
>>>>>>>   - teach probe-gdb-support about mips
>>>>>>>   - identify or1k pc register
>>>>>>>   - port check-tcg logic to meson (all targets)
>>>>>>>   - update documentation
>>>>>>>   - add Pierrick as a maintainer for tests/tcg
>>>>>
>>>>> Hi, I'm having difficulties building after this PR, after eb7f0c14 in
>>>>> particular.
>>>>>
>>>>> I keep seeing stuff like this:
>>>>>
>>>>> FAILED: [code=1] tests/tcg/x86_64-softmmu-hello.test
>>>>> /home/jsnow/src/qemu/tests/tcg/../docker/docker.py --command podman
>>>>> run --run-as-current-user -w /home/jsnow/src/qemu/build -v
>>>>> /home/jsnow/src/qemu:/home/jsnow/src/qemu debian-amd64-cross
>>>>> x86_64-linux-gnu-gcc
>>>>> /home/jsnow/src/qemu/tests/tcg/multiarch/system/hello.c -o
>>>>> tests/tcg/x86_64-softmmu-hello.test -static -MMD -MF
>>>>> tests/tcg/x86_64-softmmu-hello.d -Wall -Werror -O0 -g
>>>>> -fno-strict-aliasing -nostdlib -ffreestanding -Wa,--noexecstack -I
>>>>> /home/jsnow/src/qemu/tests/tcg/x86_64/system/../../minilib
>>>>> /home/jsnow/src/qemu/tests/tcg/x86_64/system/../../minilib/printf.c
>>>>> ../tests/tcg/x86_64/system/boot.S -Wl,-T
>>>>> ../tests/tcg/x86_64/system/kernel.ld -Wl,-melf_x86_64
>>>>> -Wl,--no-warn-rwx-segments -Wl,--build-id=none -lgcc
>>>>> cc1: fatal error:
>>>>> /home/jsnow/src/qemu/tests/tcg/multiarch/system/hello.c: Permission
>>>>> denied
>>>>> compilation terminated.
>>>>> cc1: fatal error:
>>>>> /home/jsnow/src/qemu/tests/tcg/x86_64/system/../../minilib/printf.c:
>>>>> Permission denied
>>>>> compilation terminated.
>>>>> cc1: fatal error: ../tests/tcg/x86_64/system/boot.S: Permission denied
>>>>> compilation terminated.
>>>>> Traceback (most recent call last):
>>>>>   File "/home/jsnow/src/qemu/tests/tcg/../docker/docker.py", line 657,
>>>>> in <module>
>>>>>     sys.exit(main())
>>>>>              ~~~~^^
>>>>>   File "/home/jsnow/src/qemu/tests/tcg/../docker/docker.py", line 653, in main
>>>>>     return args.cmdobj.run(args, argv)
>>>>>            ~~~~~~~~~~~~~~~^^^^^^^^^^^^
>>>>>   File "/home/jsnow/src/qemu/tests/tcg/../docker/docker.py", line 395, in run
>>>>>     return Docker(args.command).run(argv, args.keep, quiet=args.quiet,
>>>>>            ~~~~~~~~~~~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>>>>>                                     as_user=args.run_as_current_user)
>>>>>                                     ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>>>>>   File "/home/jsnow/src/qemu/tests/tcg/../docker/docker.py", line 353, in run
>>>>>     ret = self._do_check(["run", "--rm", "--label",
>>>>>                          "com.qemu.instance.uuid=" + label] + cmd,
>>>>>                          quiet=quiet)
>>>>>   File "/home/jsnow/src/qemu/tests/tcg/../docker/docker.py", line 230,
>>>>> in _do_check
>>>>>     return subprocess.check_call(self._command + cmd, **kwargs)
>>>>>            ~~~~~~~~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>>>>>   File "/usr/lib64/python3.14/subprocess.py", line 420, in check_call
>>>>>     raise CalledProcessError(retcode, cmd)
>>>>> subprocess.CalledProcessError: Command '['podman', 'run', '--rm',
>>>>> '--label', 'com.qemu.instance.uuid=0df29d1fcdc947f1b0cde41104eebed9',
>>>>> '--userns=keep-id', '-u', '21266', '-w', '/home/jsnow/src/qemu/build',
>>>>> '-v', '/home/jsnow/src/qemu:/home/jsnow/src/qemu',
>>>>> 'debian-amd64-cross', 'x86_64-linux-gnu-gcc',
>>>>> '/home/jsnow/src/qemu/tests/tcg/multiarch/system/hello.c', '-o',
>>>>> 'tests/tcg/x86_64-softmmu-hello.test', '-static', '-MMD', '-MF',
>>>>> 'tests/tcg/x86_64-softmmu-hello.d', '-Wall', '-Werror', '-O0', '-g',
>>>>> '-fno-strict-aliasing', '-nostdlib', '-ffreestanding',
>>>>> '-Wa,--noexecstack', '-I',
>>>>> '/home/jsnow/src/qemu/tests/tcg/x86_64/system/../../minilib',
>>>>> '/home/jsnow/src/qemu/tests/tcg/x86_64/system/../../minilib/printf.c',
>>>>> '../tests/tcg/x86_64/system/boot.S', '-Wl,-T',
>>>>> '../tests/tcg/x86_64/system/kernel.ld', '-Wl,-melf_x86_64',
>>>>> '-Wl,--no-warn-rwx-segments', '-Wl,--build-id=none', '-lgcc']'
>>>>> returned non-zero exit status 1.
>>>>> filter=--filter=label=com.qemu.instance.uuid=0df29d1fcdc947f1b0cde41104eebed9
>>>>> ninja: build stopped: subcommand failed.
>>>>> make: *** [Makefile:170: run-ninja] Error 1
>>>>>
>>>>
>>>> Interesting, it seems to be an issue with podman user mapping.
>>>
>>> Maybe something I set up ages ago and promptly forgot about? I haven't
>>> fussed with user mapping permissions in several aeons, it's possible I
>>> have something stale in some config somewhere ...
>>>
>>>>
>>>> Which distro you use (especially which version)?
>>>
>>> ~> cat /etc/fedora-release
>>> Fedora release 44 (Forty Four)
>>>
>>>>
>>>> Also, could you please report output of those commands:
>>>> $ podman --version
>>>
>>> ~> podman --version
>>> podman version 5.8.4
>>>
>>>> $ ls -al /home/jsnow/src/qemu/tests/tcg/multiarch/system/hello.c
>>>
>>> ~> ls -al /home/jsnow/src/qemu/tests/tcg/multiarch/system/hello.c
>>> -rw-r--r--. 1 jsnow jsnow 229 May  7  2025
>>> /home/jsnow/src/qemu/tests/tcg/multiarch/system/hello.c
>>>
>>>> $ /home/jsnow/src/qemu/tests/tcg/../docker/docker.py --command podman \
>>>>   run --run-as-current-user -w /home/jsnow/src/qemu/build -v \
>>>>   /home/jsnow/src/qemu:/home/jsnow/src/qemu debian-amd64-cross \
>>>>   touch -v new_file && ls -al new_file
>>>
>>> There's no "-v" option for touch, but:
>>>
>>
>> Copy-paste mistake sorry, thanks for fixing command.
>>
>>> ~> /home/jsnow/src/qemu/tests/tcg/../docker/docker.py --command podman \
>>>                                                                   run
>>> --run-as-current-user -w /home/jsnow/src/qemu/build -v \
>>>
>>> /home/jsnow/src/qemu:/home/jsnow/src/qemu debian-amd64-cross \
>>>
>>> touch new_file && ls -al new_file
>>> touch: cannot touch 'new_file': Permission denied
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
>>> '--label', 'com.qemu.instance.uuid=d2faaf6ef4914d83b429069b4497cbb2',
>>> '--userns=keep-id', '-u', '21266', '-w', '/home/jsnow/src/qemu/build',
>>> '-v', '/home/jsnow/src/qemu:/home/jsnow/src/qemu',
>>> 'debian-amd64-cross', 'touch', 'new_file']' returned non-zero exit
>>> status 1.
>>> filter=--filter=label=com.qemu.instance.uuid=d2faaf6ef4914d83b429069b4497cbb2
>>>
>>
>> What is the content of your /etc/subuid?
>>
>> Giving your user id (21266), I guess you have a LDAP account or
>> something similar: not a local account.
>> I had the same issue on my corporate VM, and had to add an explicit
>> mapping for my user.
>>
>> You should have something like:
>>
>> $ cat /etc/subuid
>> jsnow:100000:65536
>> $ cat /etc/subgid
>> jsnow:100000:65536
> 
> I updated my entries to this; I am still having problems so I assume I
> need to refresh my login or restart or some such thing. Will have to
> try that a little bit later :)
> 
> Do you think it's possible to add a simple "hello world" example that
> tries to touch a source file to determine if permissions are
> appropriately set up, and if not, gives a nice human-readable error
> message? (Along with advice to try --disable-containers as a
> fallback.)
>

It could be possible to add something to docker.py probe directly.
However, it would be good to know why there is an issue on your setup at
the moment, just to rule out another obvious error.

>>
>> Let me know if it solves your problem, else we'll find something else.
>>
>>>
>>>
>>>>
>>>> This should help us to see what's your effective uid in the container.
>>>> Maybe this issue was present before, did you try running make check-tcg
>>>> in the past, or not?
>>>>
>>>>> Is there some kind of setup I have neglected to perform to make this
>>>>> new build system work? Is there a way I can skip these tests in the
>>>>> meantime...?
>>>>>
>>>>
>>>> You can use ./configure --disable-containers, so it will not try to use
>>>> podman.
>>>>
>>>>> Thanks,
>>>>> --js
>>>>>
>>>>>
>>>>
>>>> Regards,
>>>> Pierrick
>>>>
>>>
>>
> 


