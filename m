Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A78D3C982C1
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 16:29:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6sUm-00075k-Q6; Wed, 16 Sep 2026 12:28:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x6sUi-00074w-II
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 12:28:24 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x6sUe-0005Hg-7A
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 12:28:22 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68GFeBCw3107042
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 16:28:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 aI+ugxaHycBsujRXImQEm5a5/F3oXawn6cxemW1G9EI=; b=JoyCLxaEVNzzzt+V
 hXmYqePbCFBaMZ3DwYGNPpd+guEDgy9vjGMBddz1snMJUe05kfdssZLjDnK41sZc
 anVMcNIOmYR7klPcRwoA4sjQJrw27btLRtck/72uMfkJuhxw/4n1VGlDZKIsLzHr
 i8mA4SB6nhXgtThSdJEgOgIMToZ01U1CdGtehhoxd0i6RJf1SZ1GGSJH95Ct4ND7
 J5iHU1fzxXnZykMqjYxXkXkMe+a/Cxu7ReKyZ/NW0og9ksPgNdSrIF/XYpjufVMR
 TOnlrH+62t4UIKe9QXuYSqg0RtvWUhbgmtKDGJYy5Y4oclteS6XbLdodc6gYbWe6
 5cmZ/Q==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gquw2rvv1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 16:28:16 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-39d8646b10eso6224979a91.1
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 09:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789576096; x=1790180896; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=aI+ugxaHycBsujRXImQEm5a5/F3oXawn6cxemW1G9EI=;
 b=PcMQChudXQj0xXbPMR55lZxWXmmMqZ9N/iEdeiiFGxYetagdRVRJXgxI1CZI4+4uvd
 lcW/JDRDt/+v/UvE3fDIyjEgPIvyHpvB1Pce0NzhfCOzA1qxQmbZPeVNRLJ703ObYHia
 2g0qEILx5YkHC9O1dRJLLnsIQCES36acBvLjPtGuWURLnUGI7h4ExI9gvtXP+joyo9KV
 xsWL/7/j0yIpFRoT1nQZMKlUtRznLI4kgg082HVulc+iPRKh779uZ9PbxjWcdHTzdYIS
 4g39r/6p1uwM9Mdq6LQ5RCDcWHMSUDpqH/K8kzCfi1DGrtF2pvLzKDk8sZhYg1Fx6x5b
 +kjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789576096; x=1790180896;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=aI+ugxaHycBsujRXImQEm5a5/F3oXawn6cxemW1G9EI=;
 b=AV3x+Cg7PORWZ7muIipoVbCNwdQL90jtNIv4CccpMwQvhYeLJ/OUF9YpnbqDTVNWh4
 rZ6DzwxpMfkHs6b+XBBDNIx8guv6o+Q8Bl186F2gvScowKAiVrqyNWU6MyjkW8Ig1gNL
 clzRfy3VKuS6seSQTQ7lSkNmY9qqckFXCdCv2WXm3f2bOC8nL25+3zUigK8LhL29AFyS
 0V+/IMpKigG7nAEav522z7zXyNlPjTF1u661b65UFaBcQas2TqKO/qqPUtKrnLmozZGi
 wpkHvy7dP+FvMZ4hn2fPUGlotmu4oTLWvOQhvYNtx4mTGA/pC+fWTdTs+1KJQ5d/bF+Y
 fHMw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwIJ9H0ZDNZgL0ZO7nhX4bI+Z6+h6K2UtqjYCZpT4t+Mqf69XHc2yFfwM3cp5HZ29LipmdIB/iEIiJ3@nongnu.org
X-Gm-Message-State: AFuF++nne92IppyB9Pyv4iPbKjKS/66ACFeta6PatnOqIVbTUCWyYV+S
 yk8OK/t2gHBTw7FAsjnx68xcKOw0OkKZynhKLo02ing1Rc8+XzaZYB1Wqw+qCxLyFMV/K7rT4GY
 Info44310dLPAbA0vxpFACN5d/sU1JUq5yjycxjlyiw1OW0LJOBAXAp286A==
X-Gm-Gg: AYBFou27qxaN122CNyrS1s/fF3qEwNMCBUggALRVqw4FPFFZo1gJdShASxR4a9t3Vvj
 1KPBgdtaxHqENxyH5ZgYmDhNhOgYMF/JlQ3zSnMeufdUPxIHKC7Lalu2Rs3qM2qCF72UeUl9Y2a
 wnx++BRHVTwTtkPoZBd0F9z1BAwY2am5iLtXfMK52TJd2WSlZEeofBiGL9RfVqirsUkcfKECqqY
 HrOTvkVIkUkuUWE4S4F0DAJZydSU3hPLp6TiKdMWXKp3RuxjPcgr6YB4JYPyLQqo1362/GlhtOw
 8GnVpD3cuw9fBgz2iiH2PplDOMn0U2fyUKfU4cBYiObXHEe8+TZGts090J0nAUEISOcpt9/GF+N
 FOXDG6oIzRI/dnuR6LjQSRN6pFlJpViHgu9Dbmdxd38g8xXLlaV+8vhg+q0ZQLGx8FphR
X-Received: by 2002:a17:90b:280a:b0:39d:f60b:8121 with SMTP id
 98e67ed59e1d1-39e1e4d39damr9449027a91.17.1789576095805; 
 Wed, 16 Sep 2026 09:28:15 -0700 (PDT)
X-Received: by 2002:a17:90b:280a:b0:39d:f60b:8121 with SMTP id
 98e67ed59e1d1-39e1e4d39damr9448928a91.17.1789576095286; 
 Wed, 16 Sep 2026 09:28:15 -0700 (PDT)
Received: from [192.168.1.199] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14395d13cb7sm7733638c88.7.2026.09.16.09.28.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Sep 2026 09:28:14 -0700 (PDT)
Message-ID: <e43aa653-637b-4e81-b6db-8c65ba911500@oss.qualcomm.com>
Date: Wed, 16 Sep 2026 09:28:13 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL v2 000/105] move check-tcg into the meson build
To: John Snow <jsnow@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20260904150826.2331577-1-alex.bennee@linaro.org>
 <CAFEAcA9vZZmVPP3_P1xz-NX_sqWY0zrOC2LeGLTdnaK54XKQzQ@mail.gmail.com>
 <CAFn=p-bXoctWNEdERPBL-SMRPYDisban2e0-mxYjws7UVcjVzw@mail.gmail.com>
 <87tsnq9siw.fsf@draig.linaro.org>
 <CAFn=p-au47ecRqxo=FB5S=LoQqa0dPRXb1xDuCefVXXyZP+OWA@mail.gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <CAFn=p-au47ecRqxo=FB5S=LoQqa0dPRXb1xDuCefVXXyZP+OWA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE2MDIyNCBTYWx0ZWRfX1oCs46IAFmzX
 UHse6wFmSM4qhjIv6lSR4IWthY+XGG5eKGUIeFfHX9Lvfe56bKoX8OoWZY3fv+fq6wYyfwwGZhN
 wYaxMgTyG6RKp2ZY18XyH1wAs5Q9KdA=
X-Proofpoint-GUID: 0D6EAxRs_7fE55AmLIwIhxWuqNiE1OJx
X-Authority-Analysis: v=2.4 cv=N4m8hG9B c=1 sm=1 tr=0 ts=6aaac3a0 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=NEAV23lmAAAA:8 a=p0WdMEafAAAA:8 a=GaQpPoNlAAAA:8 a=KKAkSRfTAAAA:8
 a=20KFwNOVAAAA:8 a=ymkZSWm4nVd8mK6C7zkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22 a=xF5q_uoM5gZT5J3czcBi:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: 0D6EAxRs_7fE55AmLIwIhxWuqNiE1OJx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE2MDIyNCBTYWx0ZWRfXwP1Q8Z2JTXTI
 TAOYOnNAs55C0+As9Kw4fHxrdvi208QBvLFcCEmNUg+aF9PPuGgEEm+A/wC1Gn7T/5GzMvN8CPp
 nP2ZRz3KdZnLGRFU3PNq0wMR/Gs2H5+YP5nwRRBTF6RT6/qxducQQmTypYSxqG8WtuZXaRc+F3h
 oWFpztT3DPC5FlomgNmPp0zFuw1ZxtrsZhX9Zf/Oe4OpptGlOfrxBWmmhU0NZzCnmKQ5HHwdBqx
 xYPK32aUp8ExZrOR4X64VKzNAZSYFAuvf9K4AALYZaCJYeg2xRcLEQn6YUz/jI/+dtaN/vD18L+
 sxkjjdCLHlTNg/hOLr5NlqltBA5bGV03v+6QzU9SB7NLECEl0NjqTU2C8BvutRTSnpuLHgu5U/I
 c6TjtobKIfssPgUzzf7InnXaOm9Ar0zmswGeNTqmoXrSncHy/MvBmizMAzfVWc9fS6LMPzRDffJ
 Scal4abv8OwcbTRorNg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-16_03,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 impostorscore=0 suspectscore=0 malwarescore=0
 lowpriorityscore=0 clxscore=1015 phishscore=0 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609160224
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -11
X-Spam_score: -1.2
X-Spam_bar: -
X-Spam_report: (-1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_SBL=1.623 autolearn=ham autolearn_force=no
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

On 9/16/2026 9:16 AM, John Snow wrote:
> On Tue, Sep 15, 2026 at 4:19 PM Alex Bennée <alex.bennee@linaro.org> wrote:
>>
>> John Snow <jsnow@redhat.com> writes:
>>
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
>>
>> Try the v2 I've just posted. That fixed up the handling of mapping your
>> host user id into the container so there are less surprises when it
>> writes to the mapped volume.
>>
>>   https://patchew.org/QEMU/20260915201601.1207839-1-alex.bennee@linaro.org/
>>
> 
> No dice there. Fully rebooted my machine just in case there were
> permission issues lingering in my session; still getting perm errors:
> 
> jsnow@jsnow-thinkpadp16vgen1 ~/s/q/build (review)> cat /etc/subuid
> jsnow:100000:65536
> jsnow@jsnow-thinkpadp16vgen1 ~/s/q/build (review)> cat /etc/subgid
> jsnow:100000:65536
> 
> jsnow@jsnow-thinkpadp16vgen1 ~/s/q/build (review)> ls -lahZ
> ../tests/tcg/multiarch/system/hello.c
> -rw-r--r--. 1 jsnow jsnow unconfined_u:object_r:user_home_t:s0 229 May
>  7  2025 ../tests/tcg/multiarch/system/hello.c
> 
> Setting the dreaded `setenforce 0` it does seem to work, so I suppose
> the issue is that my source tree is not labeled in a way that permits
> it to be mapped into a container.
>

Ok, so it seems to be related to SELinux.

Good news is that we can verify if following fix would work:
Can you please try a shared mount (append :z to path mounted with -v)?
Would that be possible to try a shared mount (:z)?

$ setenforce 1
$ check previous command failed
# try same command with :z
$ /home/jsnow/src/qemu/tests/tcg/../docker/docker.py --command podman \
 run --run-as-current-user -w /home/jsnow/src/qemu/build -v \
 /home/jsnow/src/qemu:/home/jsnow/src/qemu:z debian-amd64-cross \
 touch -v new_file && ls -al new_file
> I'd like to ask that we have a hello world style check that tests to
> see if it can access your source tree and, if not, proposes some
> solutions:
> 
> (1) Prompt user to check that rootless podman is functioning
> correctly, check your subuid/subgid etc
> (2) Prompt user to check selinux labels
> (3) Suggest that container builds can be disabled with --disable-containers
> 
> Possibly even as part of configure we do a simple hello-world test and
> if it works, enable containers by default and if it does not, we
> disable them. If you pass --enable-containers and the hello world
> fails, configure exits with an error.
> 
> Or some other such thing.
> 
> --js
> 
> 


