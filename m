Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6C85CC6B3A
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 16:24:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHOFK-0007ub-2X; Thu, 15 Oct 2026 12:23:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xHOFI-0007uP-Sn
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 12:23:56 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xHOFG-0000Or-Tz
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 12:23:56 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69FG5F8u3510305
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 16:23:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 CgyG/Qboa3/qW9dq4Eg+N+6efXgxk6EM8Kde++ds/tQ=; b=oTYqV/6GxMBmPZFj
 29f9PGpqKde1E1LAlSj2PyNpnuY0ID9K/p/BKyG3sGMRpTtpf5J/WghX/p+b39I2
 eXFdCUmnnARJCvvRAYWhHOKBTioOGSFtKVLxbHbX+kRxRe8ncNXQmWc1EeuqKdRu
 6EdkDQ/glrdIZltC2LwYtnQu2st5VlvjfWG/dsBaoplmuPP4EN8IgAirwt/VNYju
 SzW7nLdDjIPpQXJ1mnm1BD+VMdMZm699KX+293+Tseki72LJXedlki9pseBbGJkO
 1LQIIguU+TJzDcBcyrhCVvWgcNsqME37VkclWL1t3q52qzrqI9R5mJpiBD3xCv8e
 TlM1/Q==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4haqdsb08q-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 16:23:52 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-535066512b0so148110551cf.0
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 09:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792081431; x=1792686231; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=CgyG/Qboa3/qW9dq4Eg+N+6efXgxk6EM8Kde++ds/tQ=;
 b=OARBlwgCluvJ7BH4wQJCZ2kB7BdGcdLgT5Mx2TiZD4BQbtfY6gMra472K3OsGlXcUE
 VUqs4PYDVqNPdnaHOCpgXtFtSWJQ9YEvVsjMRcF7ANKdGYmoVI1X/N02PaSjqeLtxLwe
 ZWVFT0gLJSGvBZWcxEgu6BNzDynpeK9Cvq0V9/4OQOiEfi34HkMBndjBP/77vXLre7vb
 uWS31hbuYB++3eu3b7JacWlcXBC0y6LbznnkgDsgrZpxgBL0/svDCDYMGxyEF5wQD4dc
 lpdWt8zmztyJC7SClKCKvdE36GHuKxOe/Th4iVSzVDPLyn9Ac+FiWQ7GnRHL0Z6o7I2T
 nzMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792081431; x=1792686231;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=CgyG/Qboa3/qW9dq4Eg+N+6efXgxk6EM8Kde++ds/tQ=;
 b=tt+qiEa2yl23thcV+jjsiVB8FkJKrNrFjWE9Yu6xCuqO/QPuGEyrKv+Ocr5FcnDUCK
 nmi9N30zkkHy8Qs5/VUvQYffmNo1uhHUkdsKttq/xXs95p1/H5s9feoCOgahYD6/nR5p
 lPOecxJdOMA7ZWs3nWFf4zyPxJq/qcBbNb1UFFdkJmTlwu2VvCA6NAkLECSeadE94HAh
 gGAvzBD+etUx1ysbLcE3r/NNDK965UWGK42icvJ7WhHYLtiLxRxwyKb96CkjBqZTVvw2
 yomu4eqxejJyxsoC8QxQhYUG73SmvpwXOOl0BrJOLDCvXO8eNNGi1txeAJ7uqvg6CL8n
 CxbQ==
X-Gm-Message-State: AFq9FYL8XnzwMGqV9pYiUZ2/6CkKJqSkuIs1YQPzauSRbEhutfwuyLfy
 QPohp2hBxXgBbtTxHabIj34unIwqXczYKOdRb4EIt5kq3hSqVeqofFCppmjBhCmYEl/HRdZOzcu
 DUdNo02F3D64eotXIGbIMTAENWBN9kdB/BqPqjjuJVK8xnvu3D3Si/EWpvw==
X-Gm-Gg: AYBFou3v1hVWEDjAGeCoQz49Uhk0ezUUI6fB30oeh2lbYqdL96i1x/5eFovfyHpOv9L
 afmMda8ubTTToCnGjfb/hsJWHE/j4jOZGJySrr7gBZDRJ3Sxk/XqzCTet3oGMDSQ+jh5GXxvwCW
 tr1jbHynpR9zObrRMifUou0k19/iyiaClDjtOoxPXjEJcvwKE3H5krpA3xFCiDjOYXjxY+M9eJA
 tFlDr2u/BsBdxz0QKaSWy16VZOjeIiUSljGkrafXhXa/dQ4zzOdOYE+lwxwe5CDYBUq7/6anrQF
 ucfsnHtn3DNb8wpm/Nh/PxxwFm04YzkAX+2NbuZn5amXiRFp+LNYWvD4tjm5dQ7R+BVnkQ54swV
 Y26h2g03m59SmjruMU5zvl5noua3UiHpaDbyz6aUPI7jx6wlTOCRRFyicRfq/AT1R
X-Received: by 2002:ac8:5d45:0:b0:535:134a:2c83 with SMTP id
 d75a77b69052e-5359fb6a8cbmr312102711cf.41.1792081431381; 
 Thu, 15 Oct 2026 09:23:51 -0700 (PDT)
X-Received: by 2002:ac8:5d45:0:b0:535:134a:2c83 with SMTP id
 d75a77b69052e-5359fb6a8cbmr312102101cf.41.1792081430699; 
 Thu, 15 Oct 2026 09:23:50 -0700 (PDT)
Received: from [10.222.168.219] (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-536127b29desm29258111cf.11.2026.10.15.09.23.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Oct 2026 09:23:49 -0700 (PDT)
Message-ID: <af448fb5-3b21-4664-8db4-e3fdd2075fc1@oss.qualcomm.com>
Date: Thu, 15 Oct 2026 11:23:47 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/12] Hexagon: Add support for v83, v85
To: Mohamed Mediouni <mohamed@unpredictable.fr>
Cc: qemu-devel@nongnu.org, Alessandro Di Federico <ale@rev.ng>,
 Anton Johansson <anjo@rev.ng>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Laurent Vivier <laurent@vivier.eu>,
 Marco Liebel <marco.liebel@oss.qualcomm.com>, Helge Deller <deller@gmx.de>
References: <20261014195223.3233623-1-brian.cain@oss.qualcomm.com>
 <465659C2-05E5-47B8-89DF-50E50E8BD035@unpredictable.fr>
Content-Language: en-US
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <465659C2-05E5-47B8-89DF-50E50E8BD035@unpredictable.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: wnHwqIAN5Z-6PX0ZpWzStcYVGvpDUpaF
X-Authority-Analysis: v=2.4 cv=fNusTpae c=1 sm=1 tr=0 ts=6ad0fe18 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=9iD3GqkVbZ9UQp4sfz8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDA2NSBTYWx0ZWRfX0JQMQrE9IFDW
 9OTcm858uL4dun7MEn+Cl/Awu0i/QEHta1fLGxfg+9uu6rpkMamslEhsUma3MmEodIB/jjo/Tak
 Orm5atGZTpbShqsHGpEXhT7H9YiVtZyBMQ7mXo+NcZKPAJaSgMBMecDu9rSmRDtRzEbWooLJ1xt
 iMCLXG8LR68iKHrc14OEB/p3aNsvMaI4OXIXszUYZcNenOta9Fb+pHB4wtaqGsjDvlhXVELrtf+
 M+nHJ8fCI4iErMelyDpNDDj3iXJ+f4rRT46KHzzruz3mCaAh6S4YZNfGU1cNiyTOij6BQZxTJl9
 tgLdVjLYskumGrgfBn9ngjr9KBuY++C2VktfP+yBwWMEl1I8uIW2WAC4OhJziLL6i2i84E6CNMq
 sLvsbthGp46pLfEVuzCtTXzwancnaO0CpQ0C7/j+9SYUvG0AoyPiYM05gPeMy7d5w4wXoD/Kn+e
 42bBdpF4HLlSAcv0uZA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDA2NSBTYWx0ZWRfX7abpLV410YdU
 13LJ+7j+DqWdyadVQ/abM+w47H+FiYHkklMWoG9joRwvtofa481bbzNmgKc7WcBrFkif8CYODgd
 gz7cGwQmPG4I8iwwE2ElNVSC/jKTc58=
X-Proofpoint-GUID: wnHwqIAN5Z-6PX0ZpWzStcYVGvpDUpaF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-14_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 bulkscore=0 lowpriorityscore=0 impostorscore=0
 spamscore=0 clxscore=1015 priorityscore=1501 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610150065
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


On 10/14/2026 9:58 PM, Mohamed Mediouni wrote:
>
>> On 14. Oct 2026, at 21:52, Brian Cain <brian.cain@oss.qualcomm.com> wrote:
>>
>> v83 and v85 introduce new ISA extensions:
>> - CFI/restricted branches
>> - scalar atomic operations
> Hi,
>
> Probably not possible to emulate nicely but the TRM for those says:
>
>> V85 ERRATA: Atomicity may be lost if a competing instruction is not an atomic. To guarantee atomicity, only atomic instructions should be used for the memory location
I don't think we need to precisely emulate an erratum like this - but 
I'll review it to see whether we're "too strong" or "not strong enough".
> Given that is it expected to be used on v85? Or is it a footgun best unexposed for that generation?

Great question - I will double check how widely these are used.


> Would also note that the user-mode DMA spec is still behind the NDA wall, which
> makes no sense whatsoever when everybody on the platform is using it anyway...

Yeah that's a shame but I think I've convinced Qualcomm to publish 
them.  So - standby.


>   
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
>>   target/hexagon: sort tag_rev_info entries by version
>>   Hexagon: add v85 CPU model
>>   hw/hexagon: add v85 machines
>>   linux-user/hexagon: report ISA HWCAP through v85
>>   target/hexagon: add v85 scalar atomics
>>   target/hexagon: add v83 trap2 and vector stack instructions
>>   target/hexagon: generate vector frame instructions with IDEF parser
>>   target/hexagon: reject reserved L4_loadw_phys encoding from v83
>>   target/hexagon: preserve callr target when Rs is LR
>>   target/hexagon: implement control flow integrity (CFI)
>>   target/hexagon: add vsf* instructions
>>   tests/tcg/hexagon: add v85 scalar tests
>>
>> docs/system/hexagon/emulation.rst           |   2 +-
>> include/hw/hexagon/hexagon.h                |   6 +-
>> linux-user/hexagon/target_elf.h             |   2 +
>> target/hexagon/cpu-qom.h                    |   4 +
>> target/hexagon/cpu.h                        |   3 +
>> target/hexagon/cpu_bits.h                   |   2 +
>> target/hexagon/gen_tcg.h                    |  93 +++++++++++-
>> target/hexagon/gen_tcg_sys.h                |   6 +
>> target/hexagon/genptr.h                     |  12 ++
>> target/hexagon/helper.h                     |   5 +
>> target/hexagon/hex_regs.h                   |   2 +
>> target/hexagon/idef-parser/parser-helpers.h |   1 +
>> target/hexagon/macros.h                     |  12 ++
>> target/hexagon/translate.h                  |   4 +
>> tests/tcg/hexagon/cfi_tgts.h                |  16 ++
>> hw/hexagon/machine_cfg_v85na_1.h.inc        |  50 +++++++
>> hw/hexagon/machine_cfg_v85qa_1.h.inc        |  51 +++++++
>> target/hexagon/attribs_def.h.inc            |   2 +
>> target/hexagon/reg_fields_def.h.inc         |   1 +
>> hw/hexagon/hexagon_dsp.c                    |  48 +++++-
>> linux-user/hexagon/cpu_loop.c               |  10 ++
>> linux-user/hexagon/elfload.c                |  10 ++
>> target/hexagon/cpu.c                        |  10 +-
>> target/hexagon/decode.c                     |   5 +
>> target/hexagon/genptr.c                     |  95 +++++++++++-
>> target/hexagon/hex_interrupts.c             |   3 +
>> target/hexagon/hexswi.c                     |  16 ++
>> target/hexagon/idef-parser/parser-helpers.c |  14 ++
>> target/hexagon/machine.c                    |   3 +-
>> target/hexagon/op_helper.c                  |  73 +++++++++
>> target/hexagon/translate.c                  |  53 ++++++-
>> tests/tcg/hexagon/atomics.c                 | 102 +++++++++++++
>> tests/tcg/hexagon/cfi_user.c                |  63 ++++++++
>> tests/tcg/hexagon/check_rev_gating.c        |  10 ++
>> tests/tcg/hexagon/invalid-encoding.c        |  20 +++
>> tests/tcg/hexagon/trap2.c                   |  34 +++++
>> tests/tcg/hexagon/v83_scalar_fp.c           |  98 ++++++++++++
>> tests/tcg/hexagon/vallocframe.c             | 111 ++++++++++++++
>> target/hexagon/tag_rev_info.c.inc           |  82 ++++++++--
>> target/hexagon/gen_idef_parser_funcs.py     |   4 +-
>> target/hexagon/idef-parser/idef-parser.lex  |   8 +
>> target/hexagon/idef-parser/idef-parser.y    |   9 +-
>> target/hexagon/imported/alu.idef            |   3 +
>> target/hexagon/imported/branch.idef         |  38 +++++
>> target/hexagon/imported/encode_pp.def       |  43 +++++-
>> target/hexagon/imported/encode_subinsn.def  |   1 +
>> target/hexagon/imported/float.idef          |  49 ++++++
>> target/hexagon/imported/ldst.idef           |  15 ++
>> target/hexagon/imported/macros.def          |  10 ++
>> target/hexagon/imported/subinsns.idef       |   2 +
>> target/hexagon/imported/system.idef         |   9 ++
>> tests/tcg/hexagon/cfi_tgts.S                | 157 ++++++++++++++++++++
>> tests/tcg/hexagon/meson.build               |  19 ++-
>> 53 files changed, 1470 insertions(+), 31 deletions(-)
>> create mode 100644 tests/tcg/hexagon/cfi_tgts.h
>> create mode 100644 hw/hexagon/machine_cfg_v85na_1.h.inc
>> create mode 100644 hw/hexagon/machine_cfg_v85qa_1.h.inc
>> create mode 100644 tests/tcg/hexagon/cfi_user.c
>> create mode 100644 tests/tcg/hexagon/trap2.c
>> create mode 100644 tests/tcg/hexagon/v83_scalar_fp.c
>> create mode 100644 tests/tcg/hexagon/vallocframe.c
>> create mode 100644 tests/tcg/hexagon/cfi_tgts.S
>>
>> -- 
>> 2.34.1
>>

