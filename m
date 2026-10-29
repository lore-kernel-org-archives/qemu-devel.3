Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92FC9606A31A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 05:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=N6X+NaYU;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=FN8jQm7S
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMIrr-0005YK-KB; Thu, 29 Oct 2026 01:40:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMIrp-0005Y7-OR
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 01:40:02 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMIrm-0008KE-4k
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 01:40:00 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69T5H56H2244443
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 05:39:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Z0ajX5slUXpfv4uKMbGwqaP4kA6vZvM7cByByqN1V/M=; b=N6X+NaYUtIff/whm
 yu4oeoPduqaFmd1KIPpcF88X9jDrwnpNfUMONHZGiYPw1lkVWP0JtnmZtywnH9s8
 U4a4S3bNx9EusSo4+9CNRAcz/Coeg/vz+O86xBrHg0LsODz+ymxxBdcWSA9hPw/X
 j2jTW/9FbsiaCfC8zWRqVyEAwExqF9YEYx/SL3/BuroER1KmI5HGSYS98dZtvX2N
 jqeZwMCZgXvWb2V39Zr8zRgNUo+93VzPiEk2x3Uc9cDMmLxphPmoCLe9MR8nlRpl
 yISyfyah7N980kAbV31aVA0klS0B5Bsm+wGDnTHAu0KtewQnCNPR32N4ozZs7g/1
 1d9J+g==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hky5s86na-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 05:39:55 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93f2c0e6653so116479785a.1
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 22:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793252395; x=1793857195; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Z0ajX5slUXpfv4uKMbGwqaP4kA6vZvM7cByByqN1V/M=;
 b=FN8jQm7SiZXWqb3HtG/dpVDPlOHe6fC6Yz9UTPhHo/WdG9x40joWMuUXmzOuG+bAEc
 9E4+JfIZqKSQj7evrn+P4XNFjZw479ZEonn1fkRd3r9JsFykz5y+izLEAy+hEdzdxCFc
 Q++pxhI/zA2W9eRXwUZLAafVYs1AiioBnKvawkbmA/eig0T6356Oh47nsh2XD+s86GhE
 vg0ImNOpZzsJdTEMXbM0qs0JBlDJePbkCeEM4TjnNojYX0qinkga2G2/tIFKQ1/Sdk0T
 2uNO7c8EM/lSytXM1qxr+/jylmSiQxnzxopx8KRHcNnyk+ynMwaausk45r/8lVJAjd3z
 SzxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793252395; x=1793857195;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Z0ajX5slUXpfv4uKMbGwqaP4kA6vZvM7cByByqN1V/M=;
 b=YnzFx8vY21G8ZrvCCadkDENv3BS2Am/htzPbTekoK5q0NP0wjrUzJnGwmtVZ7bkJJ7
 5AQ1jZTU80Ro7AsV71ErakD/jD/EwuHbaMjSs96L1G8fxGEpcB0Nya18MtssCz7p2hI7
 Z3IVhMy+34dtICcRQUQs3ymwmnBcz2leKAIslStvJ5kBDzkSIDG4HxPE464OuCjoi8Fi
 4CosHrCLMJsDDEKSl05wZmu9XHmrSiroRl4wPms65IF80IDivZ0EU3HoUA/CcSodkvpy
 a8mmUhCuEmhb9T0hMwt5SSHVfneJOQSju1r66tljx87owPsczdWCXxkZMkJ1O/1Hx63s
 yAyw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwct0j+yOM+RY7TRn1I6euMh20pn/bRhhHZ0f+TMzsKQqT/MRHrCXPqSZM0rz4TVhdT7E5HjOWTYWMQ@nongnu.org
X-Gm-Message-State: AFq9FYKQKTgyS2j1ic97DFWG69iRBvH+gneqLFpmWMO2/ta0RvFwp06s
 fP6Itm8u1xUek6Tw8aKXDYx0Oq1XPj6QMX/qk8hzx6uIr+k17xe5s/Y3iw2Sty/XPetHCPOMaOL
 TpkueOoO0XlKojekCcopcFNvsGAsjwiey5TsYHEp25Q0u2fJWMSFCgOPWGA==
X-Gm-Gg: AYBFou2c7a0ExPBWGvqs+1aMa9SRD2tDclPOSoQwHnQTpVJwR7dijNaCgsePQelkHNh
 Spmg0Yf4WY7T4fwM7kRv6dawIkKt48s96I18tGYeK157G77jiTG5ImdiV7W9UhcyXteftWtboNx
 M6nlPXZMR3PCrxahUl/hHV50D5dVRUTItwf9TlVGC4Yhs+qSBlS90kzFNEIL5opDoBn1UMjYDy+
 txjJR/EhePmCOJxyNkdO6+IDsvE27VA3L8xi8k8XlmBsUcwPm8Dw/o6sREfhdcQiTeHk3BoNGgu
 /QgNt6l+Ynwf9jlQqmcvD8PhGA++HxcWvWcY3EifCJb1tOc764gy3X2mdaZXw/DbkWRXqpaEjz+
 31EccVPxP8SODqpfHUAJ2ZEKCTYjGgsaGcmP2PQf77slK238aPsNaZs8v+RxfoExd9tVVHpga8C
 8oVh72hyTQ1i+R/18YauvGU58=
X-Received: by 2002:a05:620a:2907:b0:93f:34c9:9248 with SMTP id
 af79cd13be357-94408cf4109mr694326485a.22.1793252395344; 
 Wed, 28 Oct 2026 22:39:55 -0700 (PDT)
X-Received: by 2002:a05:620a:2907:b0:93f:34c9:9248 with SMTP id
 af79cd13be357-94408cf4109mr694319185a.22.1793252392745; 
 Wed, 28 Oct 2026 22:39:52 -0700 (PDT)
Received: from [192.168.69.229] (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ebcb851sm27887697f8f.26.2026.10.28.22.39.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Oct 2026 22:39:51 -0700 (PDT)
Message-ID: <a3555348-c24c-4df5-95a4-b4ab0a7490c1@oss.qualcomm.com>
Date: Thu, 29 Oct 2026 06:39:49 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/9] target/mips: Re-introduce the R5900 CPU (system) +
 sort tcg tests
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Aleksandar Rikalo
 <arikalo@gmail.com>, Richard Henderson <richard.henderson@linaro.org>,
 Fredrik Noring <noring@nocrew.org>, Aurelien Jarno <aurelien@aurel32.net>,
 Gustavo Romero <gromero@redhat.com>
References: <20261028192538.31600-1-philmd@oss.qualcomm.com>
 <28e90058-6b1d-40ad-9aed-590107f3f77f@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <28e90058-6b1d-40ad-9aed-590107f3f77f@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDAyMSBTYWx0ZWRfX9Tsw+B8DRub9
 xD2aQ+QqfSdp0Zk7WqGqUI4UGXeSHhWOV9453MgMOK7plG9zZnmyN1Ky7N7aNHzTLppYWCfM+93
 HfKClDfhVSuBwjHLqfkmRVqIORZ7i/yC40270DsYoTH41tZUjjYIi+QeIDwgZsf1NrFOUx/rzd0
 a9s5UzbMlaByolD4v5RFJ+uXa3CvZxQTQaT94a/kzSKi430NIPDIze4E9LbxxM4235p2ALKkLO6
 f3Zy9KnhVHB3NvZ035dUxwqUZxNuKM/mdPH6GCsRpKYEMoppCWbdVRGG9lgtZR6AvmiDUQ0IqKC
 b3FhgB2AYMivNYGT6iDsDg1IQ63Stb8AwDzRoQtHN9J5yXYZ1fOpz9X6YV3SF6wYsZC0QypmUmF
 bWI+Fk+B0X9Q+egJEOKiGkHg53E2CJf4+gvygh/TsLMG5KVglMWnWTjzR1VcUihn8yCpLmHvul/
 +XEELuHXKOjHbobLJTQ==
X-Proofpoint-ORIG-GUID: fTH5-Zs_dd2thbEau72D4aOG23KVY8fL
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDAyMSBTYWx0ZWRfXyFqJn1nxR0nk
 K3aYP3XORgqgm7l6frrk0JhXZ8o1es2WVE5jKGMLlFZ5dkQ7aPxJcEupdnhs+Mfo/xkvZf7Vdot
 kibXuijXv4lwYcvbzuVCD18uqqYgaO4=
X-Proofpoint-GUID: fTH5-Zs_dd2thbEau72D4aOG23KVY8fL
X-Authority-Analysis: v=2.4 cv=f/vdl+yM c=1 sm=1 tr=0 ts=6ae2dc2b cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=VwQbUJbxAAAA:8 a=NEAV23lmAAAA:8 a=Ixn1CAxRAAAA:8 a=-c_pBLeY_7QNfUhwTdsA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
 a=_0vDLAJOulx5KDpLVjVP:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 bulkscore=0 spamscore=0 lowpriorityscore=0 phishscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610290021
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

On 29/10/26 06:33, Pierrick Bouvier wrote:
> On 10/28/26 12:25 PM, Philippe Mathieu-Daudé wrote:
>> Add R5900 system tests, code is covered, CPU can come back,
>> allowing to fix a bug on PCGT opcode.
>>
>> Since [v1]:
>> - rebased
>> - added freestanding libc stubs
>> - o32/n32 tests
>>
>> [v1]: https://lore.kernel.org/qemu-devel/20210214175912.732946-1- 
>> f4bug@amsat.org/
>>
>> Philippe Mathieu-Daudé (9):
>>    target/mips: Re-introduce the R5900 CPU in system mode
>>    target/mips/tx79: Fix PCGT* (Parallel Compare for Greater Than)
>>    tests/guest-debug: Allow placing the binary within system QEMU args
>>    tests/tcg/mips64el: Add bare-metal harness for R5900 system tests
>>    tests/tcg/mips64el: Move R5900 tests to system mode and build with
>>      meson
>>    target/mips: Factor mips_gdb_read_value() out
>>    target/mips: Describe gdbstub registers with XML features
>>    target/mips: Expose R5900 registers to gdb
>>    tests/tcg/mips64el: Add a TX79 instruction test in system mode
>>
>>   MAINTAINERS                                   |   1 +
>>   configs/targets/mips-linux-user.mak           |   1 +
>>   configs/targets/mips-softmmu.mak              |   1 +
>>   configs/targets/mips64-linux-user.mak         |   1 +
>>   configs/targets/mips64-softmmu.mak            |   1 +
>>   configs/targets/mips64el-linux-user.mak       |   1 +
>>   configs/targets/mips64el-softmmu.mak          |   1 +
>>   configs/targets/mipsel-linux-user.mak         |   1 +
>>   configs/targets/mipsel-softmmu.mak            |   1 +
>>   configs/targets/mipsn32-linux-user.mak        |   1 +
>>   configs/targets/mipsn32el-linux-user.mak      |   1 +
>>   target/mips/internal.h                        |   2 +
>>   tests/tcg/mips64el/system/include/assert.h    |  15 +
>>   tests/tcg/mips64el/system/include/inttypes.h  |   7 +
>>   tests/tcg/mips64el/system/include/stdio.h     |  17 +
>>   tests/tcg/mips64el/system/include/string.h    |  16 +
>>   target/mips/cpu.c                             |   4 +
>>   target/mips/gdbstub.c                         | 152 +++++-
>>   target/mips/tcg/tx79_translate.c              |  10 +-
>>   tests/tcg/mips64el/system/harness.c           |  66 +++
>>   .../system}/test_r5900_div1.c                 |   0
>>   .../system}/test_r5900_divu1.c                |   0
>>   .../system}/test_r5900_madd.c                 |   0
>>   .../system}/test_r5900_maddu.c                |   0
>>   .../system}/test_r5900_mflohi1.c              |   0
>>   .../system}/test_r5900_mtlohi1.c              |   0
>>   .../system}/test_r5900_mult.c                 |   0
>>   .../system}/test_r5900_multu.c                |   0
>>   tests/tcg/mips64el/system/test_r5900_tx79.c   | 477 ++++++++++++++++++
>>   target/mips/cpu-defs.c.inc                    |  45 ++
>>   gdbstub/gdb-xml/mips32-cp0.xml                |   9 +
>>   gdbstub/gdb-xml/mips32-cpu.xml                |  42 ++
>>   gdbstub/gdb-xml/mips32-fpu.xml                |  41 ++
>>   gdbstub/gdb-xml/mips64-cp0.xml                |   9 +
>>   gdbstub/gdb-xml/mips64-cpu.xml                |  42 ++
>>   gdbstub/gdb-xml/mips64-fpu.xml                |  41 ++
>>   gdbstub/gdb-xml/mips64-r5900.xml              |  47 ++
>>   tests/guest-debug/run-test.py                 |   9 +-
>>   tests/tcg/mips/user/isa/r5900/Makefile        |  32 --
>>   tests/tcg/mips/user/isa/r5900/README          |   6 -
>>   tests/tcg/mips64el/meson.build                |   2 +
>>   tests/tcg/mips64el/system/boot.S              |  23 +
>>   tests/tcg/mips64el/system/kernel.ld           |  43 ++
>>   tests/tcg/mips64el/system/meson.build         |  62 +++
>>   tests/tcg/mips64el/system/test-r5900.py       |  30 ++
>>   45 files changed, 1211 insertions(+), 49 deletions(-)
>>   create mode 100644 tests/tcg/mips64el/system/include/assert.h
>>   create mode 100644 tests/tcg/mips64el/system/include/inttypes.h
>>   create mode 100644 tests/tcg/mips64el/system/include/stdio.h
>>   create mode 100644 tests/tcg/mips64el/system/include/string.h
>>   create mode 100644 tests/tcg/mips64el/system/harness.c
>>   rename tests/tcg/{mips/user/isa/r5900 => mips64el/system}/ 
>> test_r5900_div1.c (100%)
>>   rename tests/tcg/{mips/user/isa/r5900 => mips64el/system}/ 
>> test_r5900_divu1.c (100%)
>>   rename tests/tcg/{mips/user/isa/r5900 => mips64el/system}/ 
>> test_r5900_madd.c (100%)
>>   rename tests/tcg/{mips/user/isa/r5900 => mips64el/system}/ 
>> test_r5900_maddu.c (100%)
>>   rename tests/tcg/{mips/user/isa/r5900 => mips64el/system}/ 
>> test_r5900_mflohi1.c (100%)
>>   rename tests/tcg/{mips/user/isa/r5900 => mips64el/system}/ 
>> test_r5900_mtlohi1.c (100%)
>>   rename tests/tcg/{mips/user/isa/r5900 => mips64el/system}/ 
>> test_r5900_mult.c (100%)
>>   rename tests/tcg/{mips/user/isa/r5900 => mips64el/system}/ 
>> test_r5900_multu.c (100%)
>>   create mode 100644 tests/tcg/mips64el/system/test_r5900_tx79.c
>>   create mode 100644 gdbstub/gdb-xml/mips32-cp0.xml
>>   create mode 100644 gdbstub/gdb-xml/mips32-cpu.xml
>>   create mode 100644 gdbstub/gdb-xml/mips32-fpu.xml
>>   create mode 100644 gdbstub/gdb-xml/mips64-cp0.xml
>>   create mode 100644 gdbstub/gdb-xml/mips64-cpu.xml
>>   create mode 100644 gdbstub/gdb-xml/mips64-fpu.xml
>>   create mode 100644 gdbstub/gdb-xml/mips64-r5900.xml
>>   delete mode 100644 tests/tcg/mips/user/isa/r5900/Makefile
>>   delete mode 100644 tests/tcg/mips/user/isa/r5900/README
>>   create mode 100644 tests/tcg/mips64el/system/boot.S
>>   create mode 100644 tests/tcg/mips64el/system/kernel.ld
>>   create mode 100644 tests/tcg/mips64el/system/meson.build
>>   create mode 100644 tests/tcg/mips64el/system/test-r5900.py
>>
> 
> See some test failures, related to gdb:
> https://github.com/p-b-o/qemu-ci/actions/runs/40776744817/job/123131480244

Ah hmm I had similar failures due to too old gdb, I might have
missed to check the version in that container image. IIRC
Gustavo had similar problem with ARM I'll see how he fixed
that (I suppose check gdb version and skip the tests).

Thanks!

