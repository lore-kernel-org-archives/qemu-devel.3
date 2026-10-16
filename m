Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68F69CC6B38
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 16:45:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHl3D-0005wD-7T; Fri, 16 Oct 2026 12:44:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xHl3B-0005w1-Eh
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 12:44:57 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xHl39-0004Xc-4v
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 12:44:56 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69GG3hNP3260540
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 16:44:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 hATlBp6wB5t3ja95MsamNs9F/2R+ONqq7T0HhVz6oRU=; b=hk+6qou0Dz+cdfYc
 yp2RlxoG2Yky3EEakqOu/mG6DJiYjZTtJogD/ywNIkY7U9H+H94wY3hCm0I1hvs5
 wlxRjvpg2zHIi44bMwuNBeL6sYCnQsBPoxYjRD5UgT5PrUZmKWpw0PV8crhm62oI
 TbebJ9nr4a+eiVkpFIFrfg0AtyFadI0F7bS/KirJenFFIXwzsnhXtHzOzbBE0bXE
 aF595oNkVoPHSAHvbZKm7nKglOZ6X4gMgDKi14H6Z5r5y4I+jhFB7lFFSRgqsVyk
 ytt7WRTzpi/USY4On9gzF5K0BCdl+vJ7VAOOFSeCPmXHqC2waZyOSPVvqdKmPwjy
 C4N/eQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hbq4505pu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 16:44:52 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93a082c014aso41769785a.0
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 09:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792169092; x=1792773892; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=hATlBp6wB5t3ja95MsamNs9F/2R+ONqq7T0HhVz6oRU=;
 b=Zhnwau240LLjgyGStk2TP9PphcSArABd+1VxgZyycJYW4gg/wtn7Yn+xBXyrMJ7xsL
 2fiDN/Ageu9YVTep25vXzpfML4y4iS7rYOaVX5oqcLpRrkP+G19w6Cto59/Jn87CokS+
 kIawYTqrcCTDtg+WnYM4atWkBkXTFoZ8i8rwJLSw3vjYWwubBNk+fkMddr1W4+kdHagL
 9SdnxhONLXNeWZvAvq5yFCKhp5f4mhOwcyoAxw4bYQRQMoP2N/iNjuLGi1f8hhYZCPuz
 3fMxh4liEP6X+Zz9NTKx2k8dcXyF2zRgPII3agC9fpQq9vLyKtKP7spTGS0iWfH0XD5w
 XOVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792169092; x=1792773892;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hATlBp6wB5t3ja95MsamNs9F/2R+ONqq7T0HhVz6oRU=;
 b=YZxMFdToPgEAm1mA/nRwognilN29VSNHm38G64gYpfSEfRa9AZ4OET9ECHBiOFcipZ
 DM2nJPOgcFQYjPNapUF0PGV+/iVCh5EUUXkujSpe/I3xZmA9CBp3CIvljmwgWNexM4sf
 qQWwM1m08s23sOo4+XqbuUgPfPjzFJQRHHcJwbA3weSmQyTL3iwoj7xwxXk/OHdXOjBm
 sz8ltE/LQKHqOGWjCSFmEa7lntcukJQdcy/m3YyK5+Z+610Y5ElzPsYWj7Ub5/IVsRBN
 lNmN+PTBH8oh4TCfjcFh1vwBAK3doJADQnWue2GtZ0vgdNw5qma8ThRdi55FSxdDTjB9
 lLfw==
X-Gm-Message-State: AFq9FYKeiHc8sCQSovQnVUUkx7PKJMVQYl8nc0ZbGyu2l+H01ofaWCku
 L1NIDEYZFbYD6QXFRJdx1IB9h44Glzza8DSYt1f9IFbL4wDes8/IJAJSvTh6Sl9Q7hJ2WR4vzte
 Nr+Oq7XCkyRNaYouNIeC8O21Yiey7I1Uyn83IKX5abbXj6awmesKYh7YlBw==
X-Gm-Gg: AYBFou2k+tznlBbjYltcZlnSIflpRZ87OgGYJtoO9tA3/5wdTxi3vFp7KWnL6bIIDSo
 /MG2sMZP7xreW9Kpevyp1PdMh10ySvt052SkrvqV1RdEewnpbXUICTbIFtESs/vNlUdBdYgTrPy
 BeUFqFBIfGwCaJrjoyqGuYGZ/LEcu0mLHqpTXa7ajaLsCVydI+Wz9K0/Dps7imYdHuNM7kSXOkp
 6aZL4qEhu6I/6dVjFk47jMoRAze0RNcKZyrmJRyvMbpQJEbyqKL0B1vv4qKs0ORKFfnI6uBemtW
 jnS3Q9Vds7nB3Ahq8yvOMDMQL/YOh0nIsWcwtyh3wrNTOCjj3XWCQRqyxkJjWgoErfUqMRrRZlY
 kDcDUSHCflpx7jWpajMdnlK+Hjg4bzce3Od9EgajK5EcWQkJ7b+teysi4OZA7CT+g
X-Received: by 2002:a05:620a:290e:b0:939:2b7c:34d1 with SMTP id
 af79cd13be357-93f29cc75afmr71934085a.15.1792169091553; 
 Fri, 16 Oct 2026 09:44:51 -0700 (PDT)
X-Received: by 2002:a05:620a:290e:b0:939:2b7c:34d1 with SMTP id
 af79cd13be357-93f29cc75afmr71929685a.15.1792169090902; 
 Fri, 16 Oct 2026 09:44:50 -0700 (PDT)
Received: from [10.222.168.219] (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-93f1a0cf98bsm252858685a.4.2026.10.16.09.44.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 Oct 2026 09:44:50 -0700 (PDT)
Message-ID: <98f45c19-ddbb-4a64-a58d-56c7f31d649b@oss.qualcomm.com>
Date: Fri, 16 Oct 2026 11:44:48 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/12] Hexagon: Add support for v83, v85
To: Marco Liebel <marco.liebel@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, Alessandro Di Federico <ale@rev.ng>,
 Anton Johansson <anjo@rev.ng>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>
References: <20261014195223.3233623-1-brian.cain@oss.qualcomm.com>
 <CAJ+KCYOhsLckWC0sazhOx=Tf21pEYesasuE=tutjrK6fXCUnSg@mail.gmail.com>
Content-Language: en-US
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <CAJ+KCYOhsLckWC0sazhOx=Tf21pEYesasuE=tutjrK6fXCUnSg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 9ZRad18xalbEOz_S7TJRrxCK1UfzfBkg
X-Proofpoint-GUID: 9ZRad18xalbEOz_S7TJRrxCK1UfzfBkg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE2MDA2NiBTYWx0ZWRfXxoWY/9QF2mT7
 z51UxS7Zsak4Z5t+DO5FDZpEF6ixqiThU+0DVvJG6KyJOAGsGG4pZeacsAnhSVcFuDBHCBgf3Rp
 CAAXAnn1TcnF/dZquICkiuEu86KIZKA56N5GHPBaKN/oxJjt8UhUdpcwlElIxGuqcL8Q/lyUmp1
 VuJliewAarwMuptj+q7znoYxd0XQPYxJc2xq1biZpJfxmpvAIZhzvvQk0Nmr6nlgZ+f9M5bdF7h
 VlUy6QmX4qn/mAuzvYM4dfEVfDjX0LbMZlhlWu66AwBg2bb3hhbUWbwNDxxjKzjrwpBcMXvpI81
 xYdhNC8KwyNhFdrvI3aNJoqXBkVxYE2+NrWKbZSNZcwfwNpHNWOYQTvy0Ov1yR+h8IkUZnwFdv8
 iI9SivBIl5VGdJrE8kvMVnamdcEF9Vu+aEXezK5niIeTUm1ItvxId+D7/xuVxudkFbfxsWHXXxN
 bZleRWSxaq5sI7iMgiQ==
X-Authority-Analysis: v=2.4 cv=e4GT2qp/ c=1 sm=1 tr=0 ts=6ad25484 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=dbqDgaQTMc-M4OkzAdIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE2MDA2NiBTYWx0ZWRfX0W6DDUqUpSsq
 pfi5K7vq7wG3tf4W4eM7I7IXoa7bAdIALYqT3YvpQituUReH1fwWDrE+KWibINnJFXSrN0HVW9V
 bO7Um6V2eDiHzSnI10/PkXZ3S8My8ZI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-16_02,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0
 suspectscore=0 malwarescore=0 spamscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610160066
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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


On 10/16/2026 10:58 AM, Marco Liebel wrote:
> On Wed, Oct 14, 2026 at 2:52 PM Brian Cain <brian.cain@oss.qualcomm.com> wrote:
>> v83 and v85 introduce new ISA extensions:
>> - CFI/restricted branches
>> - scalar atomic operations
>> - scalar float operations
>> - trap2 instruction
>> - vector stack, used by HLX
>>
>> The HLX vector coprocessor, also introduced by these new revisions, is
>> not included in this series.
>>
>> The cross-toolchain doesn't yet support these opcodes.  So in our tests,
>> we've manually encoded the instructions using ".word" directives and we
>> invoke the tests with the explicit '-cpu'.  The directives will be replaced
>> with the mnemonics and explicit '-cpu' removed once the assembler has the
>> necessary support.  I expect LLVM 24.x will include these instructions.
>>
>> Brian Cain (12):
>>    target/hexagon: sort tag_rev_info entries by version
>>    Hexagon: add v85 CPU model
>>    hw/hexagon: add v85 machines
>>    linux-user/hexagon: report ISA HWCAP through v85
>>    target/hexagon: add v85 scalar atomics
>>    target/hexagon: add v83 trap2 and vector stack instructions
>>    target/hexagon: generate vector frame instructions with IDEF parser
>>    target/hexagon: reject reserved L4_loadw_phys encoding from v83
>>    target/hexagon: preserve callr target when Rs is LR
>>    target/hexagon: implement control flow integrity (CFI)
>>    target/hexagon: add vsf* instructions
>>    tests/tcg/hexagon: add v85 scalar tests
>>
>>   docs/system/hexagon/emulation.rst           |   2 +-
>>   include/hw/hexagon/hexagon.h                |   6 +-
>>   linux-user/hexagon/target_elf.h             |   2 +
>>   target/hexagon/cpu-qom.h                    |   4 +
>>   target/hexagon/cpu.h                        |   3 +
>>   target/hexagon/cpu_bits.h                   |   2 +
>>   target/hexagon/gen_tcg.h                    |  93 +++++++++++-
>>   target/hexagon/gen_tcg_sys.h                |   6 +
>>   target/hexagon/genptr.h                     |  12 ++
>>   target/hexagon/helper.h                     |   5 +
>>   target/hexagon/hex_regs.h                   |   2 +
>>   target/hexagon/idef-parser/parser-helpers.h |   1 +
>>   target/hexagon/macros.h                     |  12 ++
>>   target/hexagon/translate.h                  |   4 +
>>   tests/tcg/hexagon/cfi_tgts.h                |  16 ++
>>   hw/hexagon/machine_cfg_v85na_1.h.inc        |  50 +++++++
>>   hw/hexagon/machine_cfg_v85qa_1.h.inc        |  51 +++++++
>>   target/hexagon/attribs_def.h.inc            |   2 +
>>   target/hexagon/reg_fields_def.h.inc         |   1 +
>>   hw/hexagon/hexagon_dsp.c                    |  48 +++++-
>>   linux-user/hexagon/cpu_loop.c               |  10 ++
>>   linux-user/hexagon/elfload.c                |  10 ++
>>   target/hexagon/cpu.c                        |  10 +-
>>   target/hexagon/decode.c                     |   5 +
>>   target/hexagon/genptr.c                     |  95 +++++++++++-
>>   target/hexagon/hex_interrupts.c             |   3 +
>>   target/hexagon/hexswi.c                     |  16 ++
>>   target/hexagon/idef-parser/parser-helpers.c |  14 ++
>>   target/hexagon/machine.c                    |   3 +-
>>   target/hexagon/op_helper.c                  |  73 +++++++++
>>   target/hexagon/translate.c                  |  53 ++++++-
>>   tests/tcg/hexagon/atomics.c                 | 102 +++++++++++++
>>   tests/tcg/hexagon/cfi_user.c                |  63 ++++++++
>>   tests/tcg/hexagon/check_rev_gating.c        |  10 ++
>>   tests/tcg/hexagon/invalid-encoding.c        |  20 +++
>>   tests/tcg/hexagon/trap2.c                   |  34 +++++
>>   tests/tcg/hexagon/v83_scalar_fp.c           |  98 ++++++++++++
>>   tests/tcg/hexagon/vallocframe.c             | 111 ++++++++++++++
>>   target/hexagon/tag_rev_info.c.inc           |  82 ++++++++--
>>   target/hexagon/gen_idef_parser_funcs.py     |   4 +-
>>   target/hexagon/idef-parser/idef-parser.lex  |   8 +
>>   target/hexagon/idef-parser/idef-parser.y    |   9 +-
>>   target/hexagon/imported/alu.idef            |   3 +
>>   target/hexagon/imported/branch.idef         |  38 +++++
>>   target/hexagon/imported/encode_pp.def       |  43 +++++-
>>   target/hexagon/imported/encode_subinsn.def  |   1 +
>>   target/hexagon/imported/float.idef          |  49 ++++++
>>   target/hexagon/imported/ldst.idef           |  15 ++
>>   target/hexagon/imported/macros.def          |  10 ++
>>   target/hexagon/imported/subinsns.idef       |   2 +
>>   target/hexagon/imported/system.idef         |   9 ++
>>   tests/tcg/hexagon/cfi_tgts.S                | 157 ++++++++++++++++++++
>>   tests/tcg/hexagon/meson.build               |  19 ++-
>>   53 files changed, 1470 insertions(+), 31 deletions(-)
>>   create mode 100644 tests/tcg/hexagon/cfi_tgts.h
>>   create mode 100644 hw/hexagon/machine_cfg_v85na_1.h.inc
>>   create mode 100644 hw/hexagon/machine_cfg_v85qa_1.h.inc
>>   create mode 100644 tests/tcg/hexagon/cfi_user.c
>>   create mode 100644 tests/tcg/hexagon/trap2.c
>>   create mode 100644 tests/tcg/hexagon/v83_scalar_fp.c
>>   create mode 100644 tests/tcg/hexagon/vallocframe.c
>>   create mode 100644 tests/tcg/hexagon/cfi_tgts.S
>>
>> --
>> 2.34.1
>>
> General notes:
>
> 1. The series does not bisect (Patches 5-9):
> A_RESTRICT_TARGET is undeclared. Patch 5 adds
> S2_allocframe_rb to ldst.idef, but the attribute comes in patch 10.
> Moving those two lines to patch 10 fixes it.

I'll make that change, thanks.


> 2. The no idef parser build is broken after commit 7 (Patches 7-12):
> patch 7 drops the fGEN_TCG_V2_v{,de}allocframe_* overrides, and
> patch 10 adds S2/SS2_allocframe_rb without overrides. Should we
> keep the ones in commit 7 and add some for the additions in commit 10?
Yes, that probably makes sense - I'll take a closer look and send a v2.

