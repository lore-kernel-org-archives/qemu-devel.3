Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7B79606A324
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 15:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=MzpVW2km;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=CEWo5sxu
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJY2p-0001ZA-2Y; Wed, 21 Oct 2026 11:15:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marco.liebel@oss.qualcomm.com>)
 id 1xJY2i-0001YN-Lm
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 11:15:52 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marco.liebel@oss.qualcomm.com>)
 id 1xJY2f-0007Rk-SI
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 11:15:51 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69LEk29e894326
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 15:15:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 z4jxrIFpiDTqj/1FhI8hQvXBf2NPVSVAKIDexcs1Pro=; b=MzpVW2kmlrdpGgxJ
 H00oWP1JuEWJmAMaBCOvR3afPM/7qiHAAM9rIK5hm5C06oqif6zjn8N5LdlGCcpp
 MootzcpeV6AuD+hOHifF3qsuT2FvI3g/Z/3gO9xCJhpOKAXsMxhI/2s4q/7HoM42
 BvKrsM036PaiMV3rlzncPuw+bsk37Cc6OXuKuTu8LUSsbd9NueeX3DHFj+UyT+Ij
 V1jcJvX3/vOQpyEp0e4BHXZtvZS4QpPoXWpK6havLhjsIWGek0mbMk32+t9nJ2iB
 lvfn96nxw12TYsop3tzasuOLU0W9w3R1reHljpaB2LrZunzHv/XONHv68iozFN5H
 iljeoQ==
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4heh5r3ptj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 15:15:45 +0000 (GMT)
Received: by mail-oi1-f200.google.com with SMTP id
 5614622812f47-4a41f46d629so1184599b6e.3
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 08:15:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792595745; cv=none;
 d=google.com; s=arc-20260327;
 b=k5PEAI8ByCecsTpo0dpzQ9SR6CnT9nztmMEMoneNUfnOtt0r+Dw6kv0IA5F6yEMFwO
 M1lyyH+/KyMbU/rcz4TaAslx/dNcti1PphJzsK81ZiHhAR1rSBHP+oLZbcfqVJXhUTCR
 e/gt3h8pHKsuioOnq6ZHbskcgqhknj6wJAGvA0eiMQhqE0DbZjNcgh0yK8E6FVJbi71F
 vZNB09nMKGeIOpl2cJkyf40kPZByiF0Z2pdMH0psTeUhWfmUK+Gmyt3wkh8jhWPOy6c8
 Ppg/vSEc1d9H/yfdDisQE+PsDdF0xRuKWbJ1FOWhqeinn7o1zvNaVxNGxRuUhyWuVrpq
 S7Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=z4jxrIFpiDTqj/1FhI8hQvXBf2NPVSVAKIDexcs1Pro=;
 fh=DkbXE4ccMsTX7HmhBC7cW9zKYDAyLxQ+nKGU9uhWHTg=;
 b=n13C76c5fJ3ZCycxbTNN1eNWYwM7DVigRRf8BuBJ+3+huS92DMq7uW7Ih2CL3wxtvx
 At7bqiWcYcT7+UTQKUeqaME/Bh8yOfQci9lt2eHlXauO54d9hoRwYDXMbrvyZH8ozcma
 mn/i9785NInG60dNfFAaIQV/lOC0p86X54heXxiJM8xXIUMYgpHAc733AEDXnjjtEtZO
 mJu0vS09rnQhV1GuuipW5ZRvZm1P7FSLqCKEQ9hLw+G8ytCfGFturmyRxWDWo7Q8Vl9s
 6vo0esew0XMYRQJirxd/u8X9vQWXZA2ASkNZQ5bno1nnviMuAYJ1HgmNi9hoyu/6X6p/
 eedA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792595745; x=1793200545; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=z4jxrIFpiDTqj/1FhI8hQvXBf2NPVSVAKIDexcs1Pro=;
 b=CEWo5sxuxUOh36E67RElHgSmt9BZh4m5GGLUsOhuDqpEs1wZVY3HQMSe12KO7r3F1n
 ntlqkm5EUMFwY0H515F6J/p7fghNZL5ArOP6XszDQ5JKw79F0Np3FFofVl4/ZASWQ2kO
 ed8BUYhBn/6dGVGLbZ6tJHxlLHtbMCY76q9ua4byIUsA8UHVTCdp6vEK3yfP8ZpIW+k3
 oCi4QCMZp7x34BZcUKqNoTN/JfJ2CvvH8UYHU65Bvkhvp7XfEK9DoUnEslKBMTpvStS1
 FS9MKwg6A6qznA+642N0D/mmRR/puGD3thBoXYREdQYcuS3Gk4abdonc9iDORC3Ld7UL
 0xnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792595745; x=1793200545;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=z4jxrIFpiDTqj/1FhI8hQvXBf2NPVSVAKIDexcs1Pro=;
 b=JeIciHGml3dabBVJX+aVCvWyzp1MejKIYllEn8LaWwU4pHHDSrzXvW6V1YUsyKcI1n
 zL93XzpXcwG4luQlGVc1nvtR46siY/IT9+F63EtTBJbRuoWZzH9diLq/HNQzOhVDbZY/
 khkHrVJJxELrcotcwPL6KjjJ84CjF4TkEwU1Zjgc6CscpGhd1uEvKeDHCdtfvPFKDhqV
 o9Fodo+HVsjQwwW2WCKu/FqpSRKX5VgF9jx9npdi/kmzeGF1P4dEUIZ9ljpWFkpDqM7R
 hUgpBzzwTIKKZPyyLkX78c5H20mtUaQ+kmrf7zKvvDuwkQNVXab/Eq4v1B0wz0ZXxUTq
 +FUw==
X-Gm-Message-State: AFq9FYJ7Z3zIFqu06vybu8j/RsDcBUVpdKLi2XtBLuYACj5Kh7ZscoRa
 LW1PKRxrWtPXHGthLcSvQyUv2+BD7Y0hunxl9/Bz0RiA9XxWchfYeJYc8uqVQ+MXN4czzih/PCf
 w5tnQqvZtPZUiIu3XIElZ42mpwWEXAw+rtD8lfOzwf+Ge/+npW44G4BBm84cGtHs5xSU8ZdreHv
 iWb6GvQnbyjbmAVgUy2jP3fQDV5VFxFpH8
X-Gm-Gg: AYBFou2cZwEkBDo47mf088bJBFV3f+TQKMVIhl2RgJM//OFwcbalGJ8Gp0KR3MWHKSF
 CWqP/+jjrX+348aT50Q0eJWkG8g09qpkIPaRW6KmKNlZWa/bwtEcekohozOHvu9tLx70Mghdj78
 rlTCSo5mN5lyOPPb0wNcfYROrHgw/Egn4auO1sv/yWhGRDwIPygXKf0IJjhMR8bHFFzSDMwKMTV
 YXVa4U4BDCz7uopZb0=
X-Received: by 2002:a05:6808:1903:b0:4b3:3e1:4a25 with SMTP id
 5614622812f47-553559a2395mr1553808b6e.11.1792595744701; 
 Wed, 21 Oct 2026 08:15:44 -0700 (PDT)
X-Received: by 2002:a05:6808:1903:b0:4b3:3e1:4a25 with SMTP id
 5614622812f47-553559a2395mr1553776b6e.11.1792595744201; Wed, 21 Oct 2026
 08:15:44 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261019172603.2625677-1-brian.cain@oss.qualcomm.com>
 <20261019172603.2625677-7-brian.cain@oss.qualcomm.com>
In-Reply-To: <20261019172603.2625677-7-brian.cain@oss.qualcomm.com>
From: Marco Liebel <marco.liebel@oss.qualcomm.com>
Date: Wed, 21 Oct 2026 10:15:31 -0500
X-Gm-Features: AclHuK_phr8OqlliawW4TXkXMIq16BHwqjlX-SwtH02DdGA73g69CLscTiVFO44
Message-ID: <CAJ+KCYMuA8KHXsJvYpMF9FD5xF=2_amiQVCmtfC_77q4qgRhyg@mail.gmail.com>
Subject: Re: [PATCH v2 06/11] target/hexagon: add v83 trap2 and vector stack
 instructions
To: Brian Cain <brian.cain@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Alessandro Di Federico <ale@rev.ng>, Helge Deller <deller@gmx.de>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Anton Johansson <anjo@rev.ng>, Laurent Vivier <laurent@vivier.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=aI5lOr9m c=1 sm=1 tr=0 ts=6ad8d721 cx=c_pps
 a=AKZTfHrQPB8q3CcvmcIuDA==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8 a=J6zktHaIoBNljP-7JEIA:9
 a=QEXdDO2ut3YA:10 a=pF_qn-MSjDawc0seGVz6:22
X-Proofpoint-ORIG-GUID: rFF25HDNdEp65NdcCgnldrFKoHvQtOSz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDA2MCBTYWx0ZWRfX/FEsATXNcJyT
 5SITurFQFDWrSP6Ebe3b2AORaPXDuBp/FUb+IaSqU+NzVrTuCx2GDtffhU3HbJdbAvymPYwuf17
 urCmTRkp3qW1Fw+ck56VdVwX0R0cznHska7cLOqXkXoGN6sUEsG/Le3sL1Njjm2O4ECT4n1PibI
 y2YM5Y5nZMPXAi3+aG3OgGr5la7XkHNQFKtJSK0scidpuHnsMa6ja4JPOgg/TYsmXD0t5yk9lTp
 N1MlHBFT/G/miR9yGMnVwZ39JJXmkjlnQeK7RYYFypq4w1SUG/pBSn1a8NGuOKKfGsMaLSdiYFP
 Rn2Inby7wu8XXJcape2Eim6kmLWJBG3DOtpxzRmItoCF8bDAiY6ksDeqMrDIp0YjsZuNpQ+kONE
 zC4rs1RHXSn3NMsPBlPGiDGcYaG7dtUcKE2SbawKhfKcH18Rkn945NLIqbVkR/tyQ3gRx2MZy1M
 FMyvAfd72QLFHD47Gjw==
X-Proofpoint-GUID: rFF25HDNdEp65NdcCgnldrFKoHvQtOSz
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDA2MCBTYWx0ZWRfX1lbaxvh1+vGN
 ZlPT808fPOyc4Tt5PRLsfLRHknnUQa98AA3+O5VEGAb8N0lHIpahvmxAi6H1lMdaO/C+B0GhYrE
 F0EbxL5ZImHqjysNfIRbqgWaaKeTkmA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-21_04,2026-10-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 impostorscore=0 spamscore=0 bulkscore=0
 malwarescore=0 suspectscore=0 adultscore=0 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610210060
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=marco.liebel@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Oct 19, 2026 at 12:26=E2=80=AFPM Brian Cain <brian.cain@oss.qualcom=
m.com> wrote:
>
> Add decode and translation for trap2 and the vallocframe and vdeallocfram=
e instruction forms introduced with v83. Model vector stack overflow as a p=
recise exception and report it to linux-user as SIGSEGV.
>
> Teach the IDEF parser about VSP and vector frame checks. Describe the val=
locframe and vdeallocframe instruction semantics in system.idef, and move t=
he vector stack overflow check into a shared TCG generator helper.
>
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  target/hexagon/cpu_bits.h                   |  1 +
>  target/hexagon/gen_tcg.h                    | 51 +++++++++++++++++++++
>  target/hexagon/genptr.h                     |  1 +
>  target/hexagon/hex_regs.h                   |  2 +
>  target/hexagon/idef-parser/parser-helpers.h |  1 +
>  target/hexagon/translate.h                  |  1 +
>  linux-user/hexagon/cpu_loop.c               |  4 ++
>  target/hexagon/cpu.c                        |  2 +-
>  target/hexagon/genptr.c                     | 21 +++++++++
>  target/hexagon/hexswi.c                     |  5 ++
>  target/hexagon/idef-parser/parser-helpers.c | 14 ++++++
>  target/hexagon/translate.c                  |  2 +-
>  target/hexagon/tag_rev_info.c.inc           | 10 ++++
>  target/hexagon/gen_idef_parser_funcs.py     |  2 +-
>  target/hexagon/idef-parser/idef-parser.lex  |  8 ++++
>  target/hexagon/idef-parser/idef-parser.y    |  9 +++-
>  target/hexagon/imported/encode_pp.def       |  5 ++
>  target/hexagon/imported/system.idef         |  8 ++++
>  18 files changed, 143 insertions(+), 4 deletions(-)
>

trap2 goes to the wrong vector. It should send event 10, but sends event 9,
because it's hooked up to trap1. There is no HEX_EVENT_TRAP2 yet.
register_trap_exception, hexagon_cpu_do_interrupt and event_name need
some trap2 specific code.

find_iclass_slots and decode_opcode_can_jump also need trap2. trap1 is
also missing but maybe that should go in another patch.

