Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47F76606A31A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 05:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=cN+knWBK;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Bha3i4Fh
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMIlg-0004nv-VD; Thu, 29 Oct 2026 01:33:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xMIle-0004nm-G7
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 01:33:38 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xMIlc-0007o1-Ax
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 01:33:38 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69T5Goe5176843
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 05:33:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 pkNPqA5Ws7ijarZvADeQJdgkpX/ah1ttz8UUKvCmOyQ=; b=cN+knWBKqsw8wtFn
 2l9vJHU9T8DfhqGx4emV1SF4jWFUG0a+qLvGTEM6NJ2sGNZ/CS0IBqhH9SIjyKLv
 bxBrILDeyZ0rr6yECuFIMvyQpO6lIDZOmqr8MbG1g1ct8Prot02ho29NtmdmLJH2
 R8JckDibSKkIkPfdSaRR0Iem6a+374peq8O3paQkLqqHt57OskIe5Ag5ADIm76s4
 0NCnSY1y5p1qL8QQcAjeZDgiqA+bThcj53Zm9WvKygm9qKZrdwj+rLJlXJSb63eL
 zRiGug4ObwXVnR0DmZhf60EKSFhjXo97Uc1wmFv1Hua0eZM+5I0jnIXawOXx/mp9
 Mpm4Qg==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hkkehu215-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 05:33:33 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-3ae72da2f57so434638a91.1
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 22:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793252013; x=1793856813; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=pkNPqA5Ws7ijarZvADeQJdgkpX/ah1ttz8UUKvCmOyQ=;
 b=Bha3i4Fh5xeClUGdBqNyyrv5FU+NKQFudkGhz2DPPJrrebmws/GB7rCpobTFc3fN0Q
 RoAaJeuLLu0HrNfM7SFuESOznpfEbBb4/B/PlrEkwgTHQpnwdyWqhI0eeShwkMCIwF3g
 ZmHzryG+zk4U6jmhr8FG6pHF6pCYUmlMMRmAAlRS1jxmyLwJUewvBTkH+wGVYHHFNReu
 mcZG6c0KukGgb2BPmCv7UutaQDYoVT3wFPdYBe30FWkMlAt1ZDpJW0VNfPZnJl2pjJAP
 6AX8/OHswUMShIVWmi41uywYUVso6rj2muk7xB9nxzcLteHApaRtNvVwiGdp6ewKA7/+
 y7VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793252013; x=1793856813;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=pkNPqA5Ws7ijarZvADeQJdgkpX/ah1ttz8UUKvCmOyQ=;
 b=dqC0MFjH8mo6M/RTEBkrVrMrfb/neafA0aLCzRx6Bs5SYfaVnfAGIAKzehVuR3yAqd
 KRAmtciuI4Ud35qkprRHE/FhUA6ksJ3kChoQo9aoiJ/kSMC4Ir+sKnT2/fc6+PMBdxCc
 vIkszQ9JsUv7xQPytIUtWB1jPBhX031tpI9SGS0/4qPiNdFnc3iHw97K9xmUrMiZi/lx
 WpvrYpoTnC6Cf8fbZlTCT9b38b/loAgrWWLl39mwo51DR2yUYikGaQFsAeXKKZHjchDb
 JhbWQ+JIMm0MOSf6RWfKWVik4A24EYmdWpO06jxL8PUcscORPOJFW1KSb+cX4Lyw6qRD
 OpnA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzObeAWJkWNj2YnDOmwFffrplACoSq5x/uoYeOozEJABjntiQi3eR6O/ctQyvHlwbtAxU3QT9oaJGXp@nongnu.org
X-Gm-Message-State: AFq9FYJh03yJ1kORUQZwKZpbD55fqGyu87XwbL2MAdegYJI/QXrbQkGR
 lQ5ERywz0+HLemM75ZbcDi4dLuCFCgaHdRKUGYk94+qf2OfBDTb8U6+RtglYU+I1n9TUUmUlvxi
 Nn23/DaPC44sAL7RuVmebMxvz+6WVYnhMlClXxpPs6De4N9JXTB32gb/r2g==
X-Gm-Gg: AYBFou3Z2ceqdT+wURp3iwhPiccSuEvgdVKdvotCW4vzKzdDUDtTPYUuQmpx3U9ZAAZ
 wwpOyy0Ch/89PcMXBe8VPNwc2xbpf7b+Pg3SmJxXFnI/4ZiUo5Mw3FVmNFWKnuTj/Xg6jbAuMmi
 liuGc+V+hHcjuv/FR0kdp02gBqn36lI62eQBh7/kjW4YQlyeTWTEZCKfQUMhj1sP1uYyqr9JR/z
 RcUPc1fPIXYo3Qq+pb9zWAfn5KGd9FWsS1MJCa/X3ntHjxDK2K1L1xWkwc+qKOuOXh6mfktJB4O
 gqokz6aLaL6u6JwViWhjlZqYK0suDiedwU0u+Q8PB0lT+Nx0cWMPYdugJs1O3rqzdhgwCzbPyoq
 MHxTKvmCn4P5zkvWMCU/AP7mIbjDqs8B0ibCg45DcBm2Ik0jQheQv4kdqxaQ5+i4mvsZphFmJD7
 6YHFUQo+bc+kyhH+myuTGfyIHEBHZHZA==
X-Received: by 2002:a17:90b:4983:b0:3ab:4f1:4f7e with SMTP id
 98e67ed59e1d1-3ae5809fca1mr3196294a91.28.1793252012708; 
 Wed, 28 Oct 2026 22:33:32 -0700 (PDT)
X-Received: by 2002:a17:90b:4983:b0:3ab:4f1:4f7e with SMTP id
 98e67ed59e1d1-3ae5809fca1mr3196275a91.28.1793252012194; 
 Wed, 28 Oct 2026 22:33:32 -0700 (PDT)
Received: from [192.168.1.169] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ae6e89f7d8sm2370808a91.17.2026.10.28.22.33.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Oct 2026 22:33:31 -0700 (PDT)
Message-ID: <28e90058-6b1d-40ad-9aed-590107f3f77f@oss.qualcomm.com>
Date: Wed, 28 Oct 2026 22:33:31 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/9] target/mips: Re-introduce the R5900 CPU (system) +
 sort tcg tests
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Aleksandar Rikalo
 <arikalo@gmail.com>, Richard Henderson <richard.henderson@linaro.org>,
 Fredrik Noring <noring@nocrew.org>, Aurelien Jarno <aurelien@aurel32.net>
References: <20261028192538.31600-1-philmd@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261028192538.31600-1-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: VMl1pGNOuNPgozwa4HDt7mdSV9xWRnwt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDAyMCBTYWx0ZWRfX9YFvLUNdW2Cm
 iReFfQplMApYxxShXzmIGpPE+V+8/Y7xBUbJpdT3ZBqUkqJsfEHCS4L9WltqxLrEv8mNns1ZI9v
 oXVswTqSIK2BuJ6itMwOthsLFdY8jUfNhQnbGQHRGBESLIsZ3oMC4IoJNiPpOgNW5+7TlWzMPfD
 +mGvPKCDf2flAdklk/+ynIkjmmMePCPcJYlumjRZsXlME1S2/OJdfC8+quO5gV4Aa4bbZpHXd4b
 hHIAX7O+uL1ljotiujF2iHTmHcU16hxMlRjJe2Y4+PrZi5M9El0vbxjDWGaoJqRKtUwsnEO4JDV
 K6llgyEHbMyFjxJ9SJRcIQtfNRSTayctWF6zZYT32WCYqms8L301INAGm+HxGoeTgX8BGsGSn/f
 0ZahAE2wv+SzP43iNT3VksSScF60kBQMAdWDKs8qBoLxncdvcljE9W10vYfkPbxrVzG98te9BYN
 FFFEWsB7xMrDSmgzWUQ==
X-Proofpoint-GUID: VMl1pGNOuNPgozwa4HDt7mdSV9xWRnwt
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDAyMCBTYWx0ZWRfX0gl+asinYKN8
 U8b3gaMtyEZPJATjVbSLw7MQJZp7at2U3dinoLxmyCi7NsMETI2vD8qLdU0dHZSPFc+IArVUuA0
 xcOAfFi1LEIbbOn2aYVsd15vwb3BMjI=
X-Authority-Analysis: v=2.4 cv=bYv+w+PB c=1 sm=1 tr=0 ts=6ae2daad cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=VwQbUJbxAAAA:8 a=Ixn1CAxRAAAA:8 a=NEAV23lmAAAA:8 a=IiPBFYYwbZ-5J7yJQAYA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
 a=_0vDLAJOulx5KDpLVjVP:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 malwarescore=0 bulkscore=0 spamscore=0
 phishscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610290020
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, KHOP_DYNAMIC=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/28/26 12:25 PM, Philippe Mathieu-Daudé wrote:
> Add R5900 system tests, code is covered, CPU can come back,
> allowing to fix a bug on PCGT opcode.
> 
> Since [v1]:
> - rebased
> - added freestanding libc stubs
> - o32/n32 tests
> 
> [v1]: https://lore.kernel.org/qemu-devel/20210214175912.732946-1-f4bug@amsat.org/
> 
> Philippe Mathieu-Daudé (9):
>    target/mips: Re-introduce the R5900 CPU in system mode
>    target/mips/tx79: Fix PCGT* (Parallel Compare for Greater Than)
>    tests/guest-debug: Allow placing the binary within system QEMU args
>    tests/tcg/mips64el: Add bare-metal harness for R5900 system tests
>    tests/tcg/mips64el: Move R5900 tests to system mode and build with
>      meson
>    target/mips: Factor mips_gdb_read_value() out
>    target/mips: Describe gdbstub registers with XML features
>    target/mips: Expose R5900 registers to gdb
>    tests/tcg/mips64el: Add a TX79 instruction test in system mode
> 
>   MAINTAINERS                                   |   1 +
>   configs/targets/mips-linux-user.mak           |   1 +
>   configs/targets/mips-softmmu.mak              |   1 +
>   configs/targets/mips64-linux-user.mak         |   1 +
>   configs/targets/mips64-softmmu.mak            |   1 +
>   configs/targets/mips64el-linux-user.mak       |   1 +
>   configs/targets/mips64el-softmmu.mak          |   1 +
>   configs/targets/mipsel-linux-user.mak         |   1 +
>   configs/targets/mipsel-softmmu.mak            |   1 +
>   configs/targets/mipsn32-linux-user.mak        |   1 +
>   configs/targets/mipsn32el-linux-user.mak      |   1 +
>   target/mips/internal.h                        |   2 +
>   tests/tcg/mips64el/system/include/assert.h    |  15 +
>   tests/tcg/mips64el/system/include/inttypes.h  |   7 +
>   tests/tcg/mips64el/system/include/stdio.h     |  17 +
>   tests/tcg/mips64el/system/include/string.h    |  16 +
>   target/mips/cpu.c                             |   4 +
>   target/mips/gdbstub.c                         | 152 +++++-
>   target/mips/tcg/tx79_translate.c              |  10 +-
>   tests/tcg/mips64el/system/harness.c           |  66 +++
>   .../system}/test_r5900_div1.c                 |   0
>   .../system}/test_r5900_divu1.c                |   0
>   .../system}/test_r5900_madd.c                 |   0
>   .../system}/test_r5900_maddu.c                |   0
>   .../system}/test_r5900_mflohi1.c              |   0
>   .../system}/test_r5900_mtlohi1.c              |   0
>   .../system}/test_r5900_mult.c                 |   0
>   .../system}/test_r5900_multu.c                |   0
>   tests/tcg/mips64el/system/test_r5900_tx79.c   | 477 ++++++++++++++++++
>   target/mips/cpu-defs.c.inc                    |  45 ++
>   gdbstub/gdb-xml/mips32-cp0.xml                |   9 +
>   gdbstub/gdb-xml/mips32-cpu.xml                |  42 ++
>   gdbstub/gdb-xml/mips32-fpu.xml                |  41 ++
>   gdbstub/gdb-xml/mips64-cp0.xml                |   9 +
>   gdbstub/gdb-xml/mips64-cpu.xml                |  42 ++
>   gdbstub/gdb-xml/mips64-fpu.xml                |  41 ++
>   gdbstub/gdb-xml/mips64-r5900.xml              |  47 ++
>   tests/guest-debug/run-test.py                 |   9 +-
>   tests/tcg/mips/user/isa/r5900/Makefile        |  32 --
>   tests/tcg/mips/user/isa/r5900/README          |   6 -
>   tests/tcg/mips64el/meson.build                |   2 +
>   tests/tcg/mips64el/system/boot.S              |  23 +
>   tests/tcg/mips64el/system/kernel.ld           |  43 ++
>   tests/tcg/mips64el/system/meson.build         |  62 +++
>   tests/tcg/mips64el/system/test-r5900.py       |  30 ++
>   45 files changed, 1211 insertions(+), 49 deletions(-)
>   create mode 100644 tests/tcg/mips64el/system/include/assert.h
>   create mode 100644 tests/tcg/mips64el/system/include/inttypes.h
>   create mode 100644 tests/tcg/mips64el/system/include/stdio.h
>   create mode 100644 tests/tcg/mips64el/system/include/string.h
>   create mode 100644 tests/tcg/mips64el/system/harness.c
>   rename tests/tcg/{mips/user/isa/r5900 => mips64el/system}/test_r5900_div1.c (100%)
>   rename tests/tcg/{mips/user/isa/r5900 => mips64el/system}/test_r5900_divu1.c (100%)
>   rename tests/tcg/{mips/user/isa/r5900 => mips64el/system}/test_r5900_madd.c (100%)
>   rename tests/tcg/{mips/user/isa/r5900 => mips64el/system}/test_r5900_maddu.c (100%)
>   rename tests/tcg/{mips/user/isa/r5900 => mips64el/system}/test_r5900_mflohi1.c (100%)
>   rename tests/tcg/{mips/user/isa/r5900 => mips64el/system}/test_r5900_mtlohi1.c (100%)
>   rename tests/tcg/{mips/user/isa/r5900 => mips64el/system}/test_r5900_mult.c (100%)
>   rename tests/tcg/{mips/user/isa/r5900 => mips64el/system}/test_r5900_multu.c (100%)
>   create mode 100644 tests/tcg/mips64el/system/test_r5900_tx79.c
>   create mode 100644 gdbstub/gdb-xml/mips32-cp0.xml
>   create mode 100644 gdbstub/gdb-xml/mips32-cpu.xml
>   create mode 100644 gdbstub/gdb-xml/mips32-fpu.xml
>   create mode 100644 gdbstub/gdb-xml/mips64-cp0.xml
>   create mode 100644 gdbstub/gdb-xml/mips64-cpu.xml
>   create mode 100644 gdbstub/gdb-xml/mips64-fpu.xml
>   create mode 100644 gdbstub/gdb-xml/mips64-r5900.xml
>   delete mode 100644 tests/tcg/mips/user/isa/r5900/Makefile
>   delete mode 100644 tests/tcg/mips/user/isa/r5900/README
>   create mode 100644 tests/tcg/mips64el/system/boot.S
>   create mode 100644 tests/tcg/mips64el/system/kernel.ld
>   create mode 100644 tests/tcg/mips64el/system/meson.build
>   create mode 100644 tests/tcg/mips64el/system/test-r5900.py
> 

See some test failures, related to gdb:
https://github.com/p-b-o/qemu-ci/actions/runs/40776744817/job/123131480244

Regards,
Pierrick

