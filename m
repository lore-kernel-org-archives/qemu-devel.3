Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 898C7C982D0
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 19:28:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7Hlb-0003z0-No; Thu, 17 Sep 2026 15:27:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x7HlZ-0003ya-B7
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 15:27:29 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x7HlW-0001cp-Cd
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 15:27:29 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68HHhpGK1683043
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 19:27:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 NMfUyUQCBWT3YvdiMK5RJOc7J2Ry/gyPyG08OM8zVIY=; b=KRRsEgx1u9CwBCo1
 9yPVpYTDnAvMkDg89QWenMINlx+wsbKjDT6/zD3KvXFCo3ovbiUkkxOkWT/bfLBg
 a/OxQPHOerBNvEdjuLqomm4WOz/8xugk+hXjl2xL0RAKlI/G5qq21RDw9LfaD7Gt
 nml9jnR1Ck9is0b5QjV97z2G6+61iPa/O1onYiHyuxSBKy/aunFDVvSQJckHcfIy
 FO/eBOzwW0vWhtVWlpqGHE+rR+yces01S9GDbCS2fUNs8dgij8osnbtVBkBgTyI1
 K9f9rYjCU1HMUGYXgMg9RVbpb9hwQkpUKxxzwlWNllOi8krzEdaCvaAs9RsCDq5P
 pwaoYg==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4grmv5gf80-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 19:27:23 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-85f1f3620bcso1117514b3a.0
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 12:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789673243; x=1790278043; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=NMfUyUQCBWT3YvdiMK5RJOc7J2Ry/gyPyG08OM8zVIY=;
 b=GACFIsgY5s0JryK91fK+vF305GpdyfauGW9DEzOkEWwWchybVhnHQUD6e4EzhO6/lb
 WhgCHCVSEvmesDEiHqlwHdUd/OcCfGDsTqBqp7teTcLP6P3jeiQXDNzrxCsUjjupTwba
 qo7T6yv0xrrmd4t3y82+q1OaupdzCktIYmL0nI0gdcOEOWEKIKyT9JJEWYcLlGbC4mlb
 Bu/p5MqQrSJD7jIcCKMenvsRcIUl/td8fTuiFtbTs/ZQuHeEkq5WxkaEY1RqFp16PpuQ
 A8AmxM1O6C0xHMExWmAcQ8Mn7TY+kbWY8u2trM//F05KqBS3PAK/g3WBgHy+J2wQOkvH
 oZfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789673243; x=1790278043;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=NMfUyUQCBWT3YvdiMK5RJOc7J2Ry/gyPyG08OM8zVIY=;
 b=lObhg+bKAksJX3ax4FVlhTeSVOj7cA894p/GccnQKXUfow07HNoCIktKADKUxxh7kz
 LE6JHi6OAnSX6bSZIPSTn7aXEjkiwo306JKSkACnl3RYiAVsfikcD+w/3K94ColophGN
 70zrXyYdFUcJpl8sLOsb42Yyh2D6KrTSXSVELXQX6gWLeEMnNxkZfXA2V+MbfHN4jxxg
 WLtEEVxHtQWliFFnJF6v/5Y0gan2DTtXon8y9mlmaAsGvLyiTH5Ur68wSvCiLiWbxfYM
 U+Df7v+gYfdhr6kjQKBAs3SRxm109C8eGwuyDIomTdE+J98ntFSodXzWlXnReTDd/RcN
 yXrA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxePu9nsTr07oUnn9j9bWkGywNrsDS3KoRlKW1jlhWaKS0vaMyqYo7Mcdr3DJSmQZ7IMEgSZi53Sxya@nongnu.org
X-Gm-Message-State: AFuF++nlpRHZuHCAzEtn05oqZewZaxjE1jIiE4XAinjjRvG+VYQ9UMVy
 hI7HL7vQoCa1EEe8+C1MuQrIL5Thp4yio3TZS8AYkyQqYOOGfxJ3beYxyZVodA8sFQ7WQBmvfPC
 jfdIvBZeSga+bvxbBLomU5tanuNEMHw+RnhN4gGxX6Qro1M0f4jr4JA/Org==
X-Gm-Gg: AYBFou0mnnYeECq0ycsmcLHqkyWdifA+p0sSOWoKVs5zVgAn8zmBgfgfzEGxxiZVIrZ
 LeiFS+K4N1B1uOB7eeLC154jgXQZg96cYifEjlJjulM0vByk6LPMtGHjEHuzFuBDRdtwjeZqLuv
 VWC+hng99iJpfIhqGlP9yF3ROlCrmJTfv5aa13OXHjibGPsqVZHFrrMJem5Nqmwsa0kaFtOmhB9
 xt3dSPezpg+Wq9JSl6NJ//jU49ysS2IPybEY4sHoZhPK4PdMS+H0nT0LCkCdHkF6qJ9rXk2h1mg
 Z4qCoQkilcKlT2jjW/ChMX0NlCHSjIhS+oPBeKgWC8WOGow7CYQtt1BGqszdVrMXrX8aH/lFVt9
 H6egk9KnXMHEeGCvNqgTIrvP+1Q0EIe3/JORpi6feXhAUrc6nRY/mFQx/nM/MdMfCZWST
X-Received: by 2002:a05:6a21:e44b:b0:3db:752:f89f with SMTP id
 adf61e73a8af0-3dd724bb05amr5592710637.2.1789673242519; 
 Thu, 17 Sep 2026 12:27:22 -0700 (PDT)
X-Received: by 2002:a05:6a21:e44b:b0:3db:752:f89f with SMTP id
 adf61e73a8af0-3dd724bb05amr5592691637.2.1789673241930; 
 Thu, 17 Sep 2026 12:27:21 -0700 (PDT)
Received: from [192.168.1.199] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14395cacce6sm15410169c88.1.2026.09.17.12.27.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Sep 2026 12:27:21 -0700 (PDT)
Message-ID: <78c818a4-2619-4dd5-87f8-af5e1017c9db@oss.qualcomm.com>
Date: Thu, 17 Sep 2026 12:27:19 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL v2 000/105] move check-tcg into the meson build
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
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
 <ce78d727-046a-4755-b807-a996f06ae47b@oss.qualcomm.com>
 <95c18d55-87ca-4f81-bfa9-364b4b012657@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <95c18d55-87ca-4f81-bfa9-364b4b012657@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE3MDI3OCBTYWx0ZWRfX3guHlSKw75uo
 MVl3cxnsfecTFFwIo1t3BcQoHP7JtJHXRxvsFC5IO90iW9yMrpJmpvlQUsZxUVgVZoF8yxNv2Kk
 boG5cb6hfhQ79AH/23Yveap6g0BWSaICrJC6ZUo7vlWA2R/Rz0g8UtVSdmhJWj0M+g9caSHBr8D
 k1FhfzponRYXoeJhkE6OqbrxqjcqoPPBLUYuT1eQjkapQoMuHLB79+HwhTB0Ir9awk4ofakE8TQ
 MRBiIwbDqjLsTy2RUKvda9xn+fFaijy3haLN9dVneGZhWsca8cvhtYmXVk0yoqdy4x4QCV2XbWQ
 5UXhQgzKWCi9LKou9DCssgzPfNw45+9+u8TTkdyisNJrXfPZOa1W+g6zj2KbEUiF0BxAWp7+DtD
 MzP0OWqE9yceHQ56/3ThwncNIxYyVUdbURxN5TTsGCJQyb3rxqwyJnBBI8Lq0L4x5sGlcuv5grL
 BCAKpMY1WyC6hir4TYw==
X-Authority-Analysis: v=2.4 cv=E+5YNqdl c=1 sm=1 tr=0 ts=6aac3f1b cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=NEAV23lmAAAA:8 a=p0WdMEafAAAA:8 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8
 a=PWA1krfQDRAxmS9I5xgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: qeVpbaPjDuin1OXuss3onqo_mQ_6G3R4
X-Proofpoint-GUID: qeVpbaPjDuin1OXuss3onqo_mQ_6G3R4
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE3MDI3OCBTYWx0ZWRfXyzq1DZI31lic
 C/z+UiYHvoWXYi/AOuRUT6OhweBfGXgHG+f5vUTTW2JyfkdJKCGXOo2kCC+HfGvm3lEjQ+p7zIL
 gOMdIn9xTRjWUcPEVjaQGgCOTjGjU9Q=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-17_04,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 priorityscore=1501 clxscore=1015
 impostorscore=0 spamscore=0 phishscore=0 adultscore=0 bulkscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609170278
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

On 9/15/2026 1:10 PM, Pierrick Bouvier wrote:
> On 9/15/2026 1:04 PM, Pierrick Bouvier wrote:
>> On 9/15/2026 12:22 PM, John Snow wrote:
>>> On Tue, Sep 15, 2026 at 3:07 PM Pierrick Bouvier
>>> <pierrick.bouvier@oss.qualcomm.com> wrote:
>>>>
>>>> On 9/15/2026 11:26 AM, John Snow wrote:
>>>>> On Tue, Sep 15, 2026 at 1:17 PM Pierrick Bouvier
>>>>> <pierrick.bouvier@oss.qualcomm.com> wrote:
>>>>>>
>>>>>> On 9/15/2026 9:52 AM, John Snow wrote:
>>>>>>> On Fri, Sep 4, 2026 at 2:04 PM Peter Maydell <peter.maydell@linaro.org> wrote:
>>>>>>>>
>>>>>>>> On Fri, 4 Sept 2026 at 16:08, Alex Bennée <alex.bennee@linaro.org> wrote:
>>>>>>>>>
>>>>>>>>> The following changes since commit d2843fbf80260e4346c856819e8cea11768c9d0e:
>>>>>>>>>
>>>>>>>>>   Merge tag 'pull-riscv-to-apply-20260904' of https://github.com/alistair23/qemu into staging (2026-09-04 09:43:27 +0100)
>>>>>>>>>
>>>>>>>>> are available in the Git repository at:
>>>>>>>>>
>>>>>>>>>   https://gitlab.com/stsquad/qemu.git tags/pull-11.1-check-tcg-meson-040926-2
>>>>>>>>>
>>>>>>>>> for you to fetch changes up to 7a485176838e6b6044e73f925d308bb4b3002597:
>>>>>>>>>
>>>>>>>>>   MAINTAINERS: add maintainer for tcg/tests meson infrastructure (2026-09-04 16:06:22 +0100)
>>>>>>>>>
>>>>>>>>> ----------------------------------------------------------------
>>>>>>>>> tests/tcg: conversion to meson
>>>>>>>>>
>>>>>>>>>   - remove unused variable from multiarch/memory
>>>>>>>>>   - standardise checking plugin output
>>>>>>>>>   - bump minimal meson to 1.6.0
>>>>>>>>>   - introduce meson plumbing for check-tcg
>>>>>>>>>   - return error code if docker probe fails
>>>>>>>>>   - add CI/self/mem test to gdbstub prot-none tests
>>>>>>>>>   - use raw opcode for fprcvt test in arm
>>>>>>>>>   - remove unused variables from gpc-test
>>>>>>>>>   - teach probe-gdb-support about mips
>>>>>>>>>   - identify or1k pc register
>>>>>>>>>   - port check-tcg logic to meson (all targets)
>>>>>>>>>   - update documentation
>>>>>>>>>   - add Pierrick as a maintainer for tests/tcg
>>>>>>>
>>>>>>> Hi, I'm having difficulties building after this PR, after eb7f0c14 in
>>>>>>> particular.
>>>>>>>
>>>>>>> I keep seeing stuff like this:
>>>>>>>
>>>>>>> FAILED: [code=1] tests/tcg/x86_64-softmmu-hello.test
>>>>>>> /home/jsnow/src/qemu/tests/tcg/../docker/docker.py --command podman
>>>>>>> run --run-as-current-user -w /home/jsnow/src/qemu/build -v
>>>>>>> /home/jsnow/src/qemu:/home/jsnow/src/qemu debian-amd64-cross
>>>>>>> x86_64-linux-gnu-gcc
>>>>>>> /home/jsnow/src/qemu/tests/tcg/multiarch/system/hello.c -o
>>>>>>> tests/tcg/x86_64-softmmu-hello.test -static -MMD -MF
>>>>>>> tests/tcg/x86_64-softmmu-hello.d -Wall -Werror -O0 -g
>>>>>>> -fno-strict-aliasing -nostdlib -ffreestanding -Wa,--noexecstack -I
>>>>>>> /home/jsnow/src/qemu/tests/tcg/x86_64/system/../../minilib
>>>>>>> /home/jsnow/src/qemu/tests/tcg/x86_64/system/../../minilib/printf.c
>>>>>>> ../tests/tcg/x86_64/system/boot.S -Wl,-T
>>>>>>> ../tests/tcg/x86_64/system/kernel.ld -Wl,-melf_x86_64
>>>>>>> -Wl,--no-warn-rwx-segments -Wl,--build-id=none -lgcc
>>>>>>> cc1: fatal error:
>>>>>>> /home/jsnow/src/qemu/tests/tcg/multiarch/system/hello.c: Permission
>>>>>>> denied
>>>>>>> compilation terminated.
>>>>>>> cc1: fatal error:
>>>>>>> /home/jsnow/src/qemu/tests/tcg/x86_64/system/../../minilib/printf.c:
>>>>>>> Permission denied
>>>>>>> compilation terminated.
>>>>>>> cc1: fatal error: ../tests/tcg/x86_64/system/boot.S: Permission denied
>>>>>>> compilation terminated.
>>>>>>> Traceback (most recent call last):
>>>>>>>   File "/home/jsnow/src/qemu/tests/tcg/../docker/docker.py", line 657,
>>>>>>> in <module>
>>>>>>>     sys.exit(main())
>>>>>>>              ~~~~^^
>>>>>>>   File "/home/jsnow/src/qemu/tests/tcg/../docker/docker.py", line 653, in main
>>>>>>>     return args.cmdobj.run(args, argv)
>>>>>>>            ~~~~~~~~~~~~~~~^^^^^^^^^^^^
>>>>>>>   File "/home/jsnow/src/qemu/tests/tcg/../docker/docker.py", line 395, in run
>>>>>>>     return Docker(args.command).run(argv, args.keep, quiet=args.quiet,
>>>>>>>            ~~~~~~~~~~~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>>>>>>>                                     as_user=args.run_as_current_user)
>>>>>>>                                     ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>>>>>>>   File "/home/jsnow/src/qemu/tests/tcg/../docker/docker.py", line 353, in run
>>>>>>>     ret = self._do_check(["run", "--rm", "--label",
>>>>>>>                          "com.qemu.instance.uuid=" + label] + cmd,
>>>>>>>                          quiet=quiet)
>>>>>>>   File "/home/jsnow/src/qemu/tests/tcg/../docker/docker.py", line 230,
>>>>>>> in _do_check
>>>>>>>     return subprocess.check_call(self._command + cmd, **kwargs)
>>>>>>>            ~~~~~~~~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>>>>>>>   File "/usr/lib64/python3.14/subprocess.py", line 420, in check_call
>>>>>>>     raise CalledProcessError(retcode, cmd)
>>>>>>> subprocess.CalledProcessError: Command '['podman', 'run', '--rm',
>>>>>>> '--label', 'com.qemu.instance.uuid=0df29d1fcdc947f1b0cde41104eebed9',
>>>>>>> '--userns=keep-id', '-u', '21266', '-w', '/home/jsnow/src/qemu/build',
>>>>>>> '-v', '/home/jsnow/src/qemu:/home/jsnow/src/qemu',
>>>>>>> 'debian-amd64-cross', 'x86_64-linux-gnu-gcc',
>>>>>>> '/home/jsnow/src/qemu/tests/tcg/multiarch/system/hello.c', '-o',
>>>>>>> 'tests/tcg/x86_64-softmmu-hello.test', '-static', '-MMD', '-MF',
>>>>>>> 'tests/tcg/x86_64-softmmu-hello.d', '-Wall', '-Werror', '-O0', '-g',
>>>>>>> '-fno-strict-aliasing', '-nostdlib', '-ffreestanding',
>>>>>>> '-Wa,--noexecstack', '-I',
>>>>>>> '/home/jsnow/src/qemu/tests/tcg/x86_64/system/../../minilib',
>>>>>>> '/home/jsnow/src/qemu/tests/tcg/x86_64/system/../../minilib/printf.c',
>>>>>>> '../tests/tcg/x86_64/system/boot.S', '-Wl,-T',
>>>>>>> '../tests/tcg/x86_64/system/kernel.ld', '-Wl,-melf_x86_64',
>>>>>>> '-Wl,--no-warn-rwx-segments', '-Wl,--build-id=none', '-lgcc']'
>>>>>>> returned non-zero exit status 1.
>>>>>>> filter=--filter=label=com.qemu.instance.uuid=0df29d1fcdc947f1b0cde41104eebed9
>>>>>>> ninja: build stopped: subcommand failed.
>>>>>>> make: *** [Makefile:170: run-ninja] Error 1
>>>>>>>
>>>>>>
>>>>>> Interesting, it seems to be an issue with podman user mapping.
>>>>>
>>>>> Maybe something I set up ages ago and promptly forgot about? I haven't
>>>>> fussed with user mapping permissions in several aeons, it's possible I
>>>>> have something stale in some config somewhere ...
>>>>>
>>>>>>
>>>>>> Which distro you use (especially which version)?
>>>>>
>>>>> ~> cat /etc/fedora-release
>>>>> Fedora release 44 (Forty Four)
>>>>>
>>>>>>
>>>>>> Also, could you please report output of those commands:
>>>>>> $ podman --version
>>>>>
>>>>> ~> podman --version
>>>>> podman version 5.8.4
>>>>>
>>>>>> $ ls -al /home/jsnow/src/qemu/tests/tcg/multiarch/system/hello.c
>>>>>
>>>>> ~> ls -al /home/jsnow/src/qemu/tests/tcg/multiarch/system/hello.c
>>>>> -rw-r--r--. 1 jsnow jsnow 229 May  7  2025
>>>>> /home/jsnow/src/qemu/tests/tcg/multiarch/system/hello.c
>>>>>
>>>>>> $ /home/jsnow/src/qemu/tests/tcg/../docker/docker.py --command podman \
>>>>>>   run --run-as-current-user -w /home/jsnow/src/qemu/build -v \
>>>>>>   /home/jsnow/src/qemu:/home/jsnow/src/qemu debian-amd64-cross \
>>>>>>   touch -v new_file && ls -al new_file
>>>>>
>>>>> There's no "-v" option for touch, but:
>>>>>
>>>>
>>>> Copy-paste mistake sorry, thanks for fixing command.
>>>>
>>>>> ~> /home/jsnow/src/qemu/tests/tcg/../docker/docker.py --command podman \
>>>>>                                                                   run
>>>>> --run-as-current-user -w /home/jsnow/src/qemu/build -v \
>>>>>
>>>>> /home/jsnow/src/qemu:/home/jsnow/src/qemu debian-amd64-cross \
>>>>>
>>>>> touch new_file && ls -al new_file
>>>>> touch: cannot touch 'new_file': Permission denied
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
>>>>> '--label', 'com.qemu.instance.uuid=d2faaf6ef4914d83b429069b4497cbb2',
>>>>> '--userns=keep-id', '-u', '21266', '-w', '/home/jsnow/src/qemu/build',
>>>>> '-v', '/home/jsnow/src/qemu:/home/jsnow/src/qemu',
>>>>> 'debian-amd64-cross', 'touch', 'new_file']' returned non-zero exit
>>>>> status 1.
>>>>> filter=--filter=label=com.qemu.instance.uuid=d2faaf6ef4914d83b429069b4497cbb2
>>>>>
>>>>
>>>> What is the content of your /etc/subuid?
>>>>
>>>> Giving your user id (21266), I guess you have a LDAP account or
>>>> something similar: not a local account.
>>>> I had the same issue on my corporate VM, and had to add an explicit
>>>> mapping for my user.
>>>>
>>>> You should have something like:
>>>>
>>>> $ cat /etc/subuid
>>>> jsnow:100000:65536
>>>> $ cat /etc/subgid
>>>> jsnow:100000:65536
>>>
>>> I updated my entries to this; I am still having problems so I assume I
>>> need to refresh my login or restart or some such thing. Will have to
>>> try that a little bit later :)
>>>
>>> Do you think it's possible to add a simple "hello world" example that
>>> tries to touch a source file to determine if permissions are
>>> appropriately set up, and if not, gives a nice human-readable error
>>> message? (Along with advice to try --disable-containers as a
>>> fallback.)
>>>
>>
>> It could be possible to add something to docker.py probe directly.
>> However, it would be good to know why there is an issue on your setup at
>> the moment, just to rule out another obvious error.
>>
> 
> Would that be possible to try a shared mount (:z)?
> 
> /home/jsnow/src/qemu/tests/tcg/../docker/docker.py --command podman \
>  run --run-as-current-user -w /home/jsnow/src/qemu/build -v \
>  /home/jsnow/src/qemu:/home/jsnow/src/qemu:z debian-amd64-cross \
>  touch -v new_file && ls -al new_file
> 
> If it works, that's related to SELinux blocking such access by default.
> And we can add the flag inconditionally.
>

I installed fedora and could reproduce the issue. SELinux is enabled by
default, to the opposite of debian.

The right fix is not :z (not enough with podman), but to use
--security-opt label=disable, which works with docker and podman.

I'll send a patch today so Alex can include it in his PR tomorrow.

Regards,
Pierrick

