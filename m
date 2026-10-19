Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECB91606A319
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 17:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=bOLarfXJ;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=IWlhdZ67
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIrIn-0006cE-Is; Mon, 19 Oct 2026 13:37:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xIrIe-0006bB-Ke
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 13:37:30 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xIrIc-0001LV-7g
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 13:37:28 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69JFPZf82816879
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 17:37:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 lc9TzBB7ovTPxrmVVrofj5K1LEqqdREH+4yrSKkg4PU=; b=bOLarfXJV8MKbgQ5
 dWjmbopaj3B4+TRql3z7eXMRMQmgYoqxn6xzHo9tIGmeNb66Mte0HI0mnkLiRI/f
 ZQtXY63tdQ3xGbqLipK58Pd258LIcGNHnNdKaIJmGFwUDXd25eJqBbVEsgqNlG+4
 CxwkhTEVqPhN2lWSTm1azWrIewolOn9PYcTbZ1RTJOIdsD/1/0D38h9JtM/cY72h
 3B8/yUitcugxoPJqLLJELlk+irPyF2mZ2wraVvDE842+MtJbsJ6FYTNQyjDJeJzk
 qDAWgZS+mIKPPj4aLniVPoUWyfHC+MVE9gvvWnQRm9Abzujq666Xp62saQY7Xo5b
 Mu7nOQ==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdkmfh8y5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 17:37:23 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-919879b09b7so53653216d6.3
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 10:37:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792431443; x=1793036243; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=lc9TzBB7ovTPxrmVVrofj5K1LEqqdREH+4yrSKkg4PU=;
 b=IWlhdZ67MDkcUPrqXkS7uFQjdVtfyFL4P/PY+8vtlAmZQDDlvI2VuSlpa4odBZ3c+z
 YIijY5Uj/U2EJVLErjt+YBNta0bZBBRgWdRnpnlV7NAJpGPuZIf3Tcr5l87ebQYTl4+T
 hPfL3gplZgAySStohzfa3AKKDbcjiBvGsi+Grcukjh6afKm33C6QNn4+8Oaz5r7C7iV/
 mDZkS/8P9vZ1PjNu+ZRBYN3MimAjCoNXlV0IUrDpXU1OF0IVjT7iSTnJ8CISwcLNrXfA
 hMdm3rMXWdoZ8tbKNQsmm8QI/dXlY4KOx3MN/J9BgSzYX3X2smvX4yYt4deR5QGbCv0e
 ylJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792431443; x=1793036243;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=lc9TzBB7ovTPxrmVVrofj5K1LEqqdREH+4yrSKkg4PU=;
 b=eYERW3tCTMPqtfIWaL/GYhc5Rz5ic6fOFbNPorAjYJrtMA3bNwt9Owx+Z/SaiH49KV
 kO17U8l12O1Lkhd673Lqa0V64RwSxDC8zBNcAUW0y+qyG8VZRCDhR/Ul3RHFOnejJyle
 tAKAYcOFwtnoX6uikZYABK3/kZPOWEhOSOp1WIhkqlsdFVmTaf+dViFH1bd9/E9IrdfR
 7eyC9J+LJEvtEzIXobLlRoKOAHWnzZeGoaDSBL1HaJlazyB6HT/A5dWRQYBE5OT/HOgN
 o6Rj+FmFEJp07h5Ilo6G/igo7Kg/ZkrcqxDupAsExYlbXMYBcHIl80rxejSV5hl7/yxr
 fyYQ==
X-Gm-Message-State: AFq9FYKYLgqXYdibzZuN3gqXjD1109QM/zE+cE3x4zK26SA2sMiHCwEg
 LeLKCwbKkqwfUGlAiAmahqAmE3qd4pRUElS0V6cuIyLs6NgQ/ydAhAQ2U01XzYR98QycCyQ71Fo
 oSpwUIZ8PYQzVKL01JRJUR2UGJAguVVAHxdSnaOAsiqu80+163gZ97bykvQ==
X-Gm-Gg: AYBFou0x2HeTaHeWGhFRJqsPT374o0SkIg+MBT7oK9yufV957E8GyWKY4Mmb7m7ma77
 QhRbrEHaUNoknZhcduIDF7gLGha8fXP4SLcg8LFv09YS+q2ikbYk/3ErdK+jMTgCgTC/kGbl3Ap
 7FahtuHjfJZkARON/SrP4DHyF6i3ZdMk4v2/9RHzpxFuv9gW5vsipUAphp6xMF9YLORzrSo2ppt
 nGj6UWBaW+xzXazd4C9h6uzZU7EfaCSuncg2vaCQg51pfNy+m5D+hp9XdSWJokUl1htoOt5fDrV
 /PaJ4GlHueGuR9bKWyyIFF5YJftNFlOrQc4YJFaCsh/SXRhGtDIIVT+fpCAJYjZtT24nTt8N4cj
 KntsWWusn9HrOHE++KBm5YSr99lsfj0evH4QTG148bJGGa+P+o8DJeqXZHEeUTo52
X-Received: by 2002:ad4:5f0f:0:b0:914:4464:41a9 with SMTP id
 6a1803df08f44-91bdf1236abmr157052096d6.29.1792431442910; 
 Mon, 19 Oct 2026 10:37:22 -0700 (PDT)
X-Received: by 2002:ad4:5f0f:0:b0:914:4464:41a9 with SMTP id
 6a1803df08f44-91bdf1236abmr157051466d6.29.1792431442094; 
 Mon, 19 Oct 2026 10:37:22 -0700 (PDT)
Received: from [10.222.168.219] (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91c040b1576sm1419796d6.25.2026.10.19.10.37.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Oct 2026 10:37:21 -0700 (PDT)
Message-ID: <fc8d3fac-3c6c-4664-be0f-10507e4b05fa@oss.qualcomm.com>
Date: Mon, 19 Oct 2026 12:37:19 -0500
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/12] Hexagon: Add support for v83, v85
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: Mohamed Mediouni <mohamed@unpredictable.fr>
Cc: qemu-devel@nongnu.org, Alessandro Di Federico <ale@rev.ng>,
 Anton Johansson <anjo@rev.ng>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Laurent Vivier <laurent@vivier.eu>,
 Marco Liebel <marco.liebel@oss.qualcomm.com>, Helge Deller <deller@gmx.de>
References: <20261014195223.3233623-1-brian.cain@oss.qualcomm.com>
 <465659C2-05E5-47B8-89DF-50E50E8BD035@unpredictable.fr>
 <af448fb5-3b21-4664-8db4-e3fdd2075fc1@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <af448fb5-3b21-4664-8db4-e3fdd2075fc1@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: fNm842u47YE0XvZFb_DJXxxohl0qGdD4
X-Authority-Analysis: v=2.4 cv=O+isLx9W c=1 sm=1 tr=0 ts=6ad65553 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=KxPOqxloTzIjd19sK64A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA3MCBTYWx0ZWRfX7KxZ+9z2LDoH
 9l6CqsoQDRh+L1M1YDo8p5+hTlPHIonrDP+osGDi2gOtl/qYjy5RofD9ge0QocD1XLA7YTk2jBD
 wNj0TserrBE46deXcnJ3Tm/OQ5nDL7LgD7Pa7pZGy4GfaAV3SihjXk03KmXLvrWEkMZb9NdzU/S
 LGzHIbd/NT/lOzjW4J6YnOdbu7h5UvWcwRjJAllVuWvjoAT8iGgTLTpFXdsBRtoCUCUxkOnRJr9
 vl3yDeYyrmIjnzXKGfpGP8TJ4/8DPpFsBuyC6CKF7ALD8RxwVkq7R8radV3YMobZ0mKG05pfE5p
 zweOCbYmdYlXrYYNBDSIJe1FN/hK3seWnUdNQXVAX/8k5mKmYgVOSdOIQgyaHE2nGLZGTSbcs3a
 1FWNdth1z5DChFIqGEdMUxf6UKKLuAypXBG0LkLYVB/9elzCYYa1+4LkmE+Ti9Cm5dZYCxBj+2r
 a5EHuAa4qqeibO2WvoQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA3MCBTYWx0ZWRfX5CPM7amLCAIj
 5WS8jO/t7lEz5zb0uqv7e9bGYQMsdP61ASJA0F+9jx5pw+ArvZp0zkgje5fI4yeCrBVj4NAIkqc
 9S0CZsqWjObn7AdGBVv6dfwcsfQkhGM=
X-Proofpoint-ORIG-GUID: fNm842u47YE0XvZFb_DJXxxohl0qGdD4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_05,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 malwarescore=0 lowpriorityscore=0
 bulkscore=0 suspectscore=0 spamscore=0 clxscore=1015 adultscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610190070
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On 10/15/2026 11:23 AM, Brian Cain wrote:
>
> On 10/14/2026 9:58 PM, Mohamed Mediouni wrote:
>>
>>> On 14. Oct 2026, at 21:52, Brian Cain <brian.cain@oss.qualcomm.com> 
>>> wrote:
>>>
>>> v83 and v85 introduce new ISA extensions:
>>> - CFI/restricted branches
>>> - scalar atomic operations
>> Hi,
>>
>> Probably not possible to emulate nicely but the TRM for those says:
>>
>>> V85 ERRATA: Atomicity may be lost if a competing instruction is not 
>>> an atomic. To guarantee atomicity, only atomic instructions should 
>>> be used for the memory location
> I don't think we need to precisely emulate an erratum like this - but 
> I'll review it to see whether we're "too strong" or "not strong enough".

We don't currently model this limitation and I think it would be 
impossible or very difficult to do so while still preserving atomicity 
or inventing new memory orders.

Hopefully future cores don't have this limitation.


>> Given that is it expected to be used on v85? Or is it a footgun best 
>> unexposed for that generation?
>
> Great question - I will double check how widely these are used.

Shows up in CDSP image, so that indicates potential for use.

$ llvm-objdump -d linux-firmware/qcom/hawi/cdsp.mbn |rg 'atom[wd]_'
c20aab10:    b6 e6 0c 90    900ce6b6 {     r22 = atomw_and(r12,r6):aq }
c20b14b0:    d0 96 db 90    90db96d0 {     r16 = atomw_xor(r27,r22):rl
c20b4f88:    53 f5 dc 90    90dcf553 {     r19 = atomw_swap(r28,r21):rl }
c20bd27c:    a4 fe 15 90    9015fea4 {     r4 = atomw_and(r21,r30):aq }
c20c08f0:    b9 e7 d8 90    90d8e7b9 {     r25:24 = 
atomd_swap(r24,r7:6):aq }
c20e3fdc:    37 e8 cf 90    90cfe837 {     r23 = atomw_swap(r15,r8):aq }
c20e7658:    41 dc cf 90    90cfdc41 {     #r1 = atomw_or(r15,r28):rl }
c20ed164:    cb f5 d9 90    90d9f5cb {     r11:10 = 
atomd_swap(r25,r21:20):rl }
c20f6714:    41 e3 de 90    90dee341       r1 = atomw_swap(r30,r3):rl }
c2109ac4:    c6 f0 de 90    90def0c6 {     r7:6 = 
atomd_swap(r30,r17:16):rl }
c212b83c:    b7 69 d3 90    90d369b7 {     r23:22 = atomd_swap(r19,r9:8):aq


>
>
>> Would also note that the user-mode DMA spec is still behind the NDA 
>> wall, which
>> makes no sense whatsoever when everybody on the platform is using it 
>> anyway...
>
> Yeah that's a shame but I think I've convinced Qualcomm to publish 
> them.  So - standby.
>
>
>>> - scalar float operations
>>> - trap2 instruction
>>> - vector stack, used by HLX
>>>
>>> The HLX vector coprocessor, also introduced by these new revisions, is
>>> not included in this series.
>>>
>>> The cross-toolchain doesn't yet support these opcodes.  So in our 
>>> tests,
>>> we've manually encoded the instructions using ".word" directives and we
>>> invoke the tests with the explicit '-cpu'.  The directives will be 
>>> replaced
>>> with the mnemonics and explicit '-cpu' removed once the assembler 
>>> has the
>>> necessary support.  I expect LLVM 24.x will include these instructions.
>>>
>>> Brian Cain (12):
>>>   target/hexagon: sort tag_rev_info entries by version
>>>   Hexagon: add v85 CPU model
>>>   hw/hexagon: add v85 machines
>>>   linux-user/hexagon: report ISA HWCAP through v85
>>>   target/hexagon: add v85 scalar atomics
>>>   target/hexagon: add v83 trap2 and vector stack instructions
>>>   target/hexagon: generate vector frame instructions with IDEF parser
>>>   target/hexagon: reject reserved L4_loadw_phys encoding from v83
>>>   target/hexagon: preserve callr target when Rs is LR
>>>   target/hexagon: implement control flow integrity (CFI)
>>>   target/hexagon: add vsf* instructions
>>>   tests/tcg/hexagon: add v85 scalar tests
>>>
>>> docs/system/hexagon/emulation.rst           |   2 +-
>>> include/hw/hexagon/hexagon.h                |   6 +-
>>> linux-user/hexagon/target_elf.h             |   2 +
>>> target/hexagon/cpu-qom.h                    |   4 +
>>> target/hexagon/cpu.h                        |   3 +
>>> target/hexagon/cpu_bits.h                   |   2 +
>>> target/hexagon/gen_tcg.h                    |  93 +++++++++++-
>>> target/hexagon/gen_tcg_sys.h                |   6 +
>>> target/hexagon/genptr.h                     |  12 ++
>>> target/hexagon/helper.h                     |   5 +
>>> target/hexagon/hex_regs.h                   |   2 +
>>> target/hexagon/idef-parser/parser-helpers.h |   1 +
>>> target/hexagon/macros.h                     |  12 ++
>>> target/hexagon/translate.h                  |   4 +
>>> tests/tcg/hexagon/cfi_tgts.h                |  16 ++
>>> hw/hexagon/machine_cfg_v85na_1.h.inc        |  50 +++++++
>>> hw/hexagon/machine_cfg_v85qa_1.h.inc        |  51 +++++++
>>> target/hexagon/attribs_def.h.inc            |   2 +
>>> target/hexagon/reg_fields_def.h.inc         |   1 +
>>> hw/hexagon/hexagon_dsp.c                    |  48 +++++-
>>> linux-user/hexagon/cpu_loop.c               |  10 ++
>>> linux-user/hexagon/elfload.c                |  10 ++
>>> target/hexagon/cpu.c                        |  10 +-
>>> target/hexagon/decode.c                     |   5 +
>>> target/hexagon/genptr.c                     |  95 +++++++++++-
>>> target/hexagon/hex_interrupts.c             |   3 +
>>> target/hexagon/hexswi.c                     |  16 ++
>>> target/hexagon/idef-parser/parser-helpers.c |  14 ++
>>> target/hexagon/machine.c                    |   3 +-
>>> target/hexagon/op_helper.c                  |  73 +++++++++
>>> target/hexagon/translate.c                  |  53 ++++++-
>>> tests/tcg/hexagon/atomics.c                 | 102 +++++++++++++
>>> tests/tcg/hexagon/cfi_user.c                |  63 ++++++++
>>> tests/tcg/hexagon/check_rev_gating.c        |  10 ++
>>> tests/tcg/hexagon/invalid-encoding.c        |  20 +++
>>> tests/tcg/hexagon/trap2.c                   |  34 +++++
>>> tests/tcg/hexagon/v83_scalar_fp.c           |  98 ++++++++++++
>>> tests/tcg/hexagon/vallocframe.c             | 111 ++++++++++++++
>>> target/hexagon/tag_rev_info.c.inc           |  82 ++++++++--
>>> target/hexagon/gen_idef_parser_funcs.py     |   4 +-
>>> target/hexagon/idef-parser/idef-parser.lex  |   8 +
>>> target/hexagon/idef-parser/idef-parser.y    |   9 +-
>>> target/hexagon/imported/alu.idef            |   3 +
>>> target/hexagon/imported/branch.idef         |  38 +++++
>>> target/hexagon/imported/encode_pp.def       |  43 +++++-
>>> target/hexagon/imported/encode_subinsn.def  |   1 +
>>> target/hexagon/imported/float.idef          |  49 ++++++
>>> target/hexagon/imported/ldst.idef           |  15 ++
>>> target/hexagon/imported/macros.def          |  10 ++
>>> target/hexagon/imported/subinsns.idef       |   2 +
>>> target/hexagon/imported/system.idef         |   9 ++
>>> tests/tcg/hexagon/cfi_tgts.S                | 157 ++++++++++++++++++++
>>> tests/tcg/hexagon/meson.build               |  19 ++-
>>> 53 files changed, 1470 insertions(+), 31 deletions(-)
>>> create mode 100644 tests/tcg/hexagon/cfi_tgts.h
>>> create mode 100644 hw/hexagon/machine_cfg_v85na_1.h.inc
>>> create mode 100644 hw/hexagon/machine_cfg_v85qa_1.h.inc
>>> create mode 100644 tests/tcg/hexagon/cfi_user.c
>>> create mode 100644 tests/tcg/hexagon/trap2.c
>>> create mode 100644 tests/tcg/hexagon/v83_scalar_fp.c
>>> create mode 100644 tests/tcg/hexagon/vallocframe.c
>>> create mode 100644 tests/tcg/hexagon/cfi_tgts.S
>>>
>>> -- 
>>> 2.34.1
>>>

