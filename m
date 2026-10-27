Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C4F0606A31A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 19:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=QprGILDz;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=FIelRg4j
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLme9-0008BA-Ez; Tue, 27 Oct 2026 15:15:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xLme3-0008AF-CT
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 15:15:39 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xLme0-0001Ak-Er
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 15:15:39 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69RII0gT1459968
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 19:15:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 7Tvw8ZlwkAXVEMZWIRj5UYty3IKKxTVknl26s9VOgB8=; b=QprGILDzs1Fm4xeq
 hqtbzXdOfULQOKAJ1FAZLGmDMQzKD0FuPUeh+QHByWEToRqTuoz5nCSb/b29Wg6G
 jPmx+PYRJkx/twA79enSnvKESRiZ4ksKzHkkNQh3SLyPLugBbX9sRnfs+eBPMQcE
 tiM/DE5tM6DNen5bBUcXYM7WCtSREJ4BM/RBpb78gsctsmWus5hFv31XVoLo+uu3
 GLrmDYLj9EgHT/ByfLe5+KNOPsIgCM9XWDE36dXjnC5hpTg0GtV9VFYuQf5CcF9m
 SD1+tMugDq+pMTfz5wNnBYjksR2EvaKlWGv4NO0X+I+MskhtVObmpOpRrVtnWpdp
 v+XkCg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hjy710tyu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 19:15:32 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93cb93c874bso247287585a.0
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 12:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793128531; x=1793733331; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=7Tvw8ZlwkAXVEMZWIRj5UYty3IKKxTVknl26s9VOgB8=;
 b=FIelRg4jcALjII9UVP9rWdktdne7GOO1/UCt4LbmTosQ/J1H/QuSEk1UeE4QrUhmmq
 0fbimoWj+Z9iC7CWnrX8djDgnb6jr/3RrNsW8GIVGsNJO1i/2jmbf3bHXGDqnsdhrG4C
 S+184EiIE7MWqq3UUH1lRP8pkF3x44XKzx4dOGzADfWhbsVnESIj6ZFcGS/9KwODmTWr
 j7Mf8h+6412ONHC6oVCTBN4ZNstIeRvCss7VznOr85Uswo4BSz98H3WMqjr0x60RP/4/
 T7CcaLbd001ozuwIQAsw2Kxi2kwByx2haVxqS/oVBLyXLHPCNv/KyDSEV1nqLP7AgMQU
 Ytuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793128531; x=1793733331;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=7Tvw8ZlwkAXVEMZWIRj5UYty3IKKxTVknl26s9VOgB8=;
 b=es1Vq0SeuKjreRDmOuy0SXwREXTTnpfWJu6DUChDLJELXB3DFzLr3pomtdO6pSFPLI
 7ubUEvAJUflNAsN8xKQUhj+y2oRj6djWXi5G63ZbDKcCEk7lgor9vCCW2Z4wKZ1uTQqG
 H9DHXp8fZ6zpckxuSqg+RPSin4NtdfNC4Hj1j5p8/pi+6RNQN+y7r7gBIc6mAKwZv84Y
 xrbc+k6kP/k58UyCmoS5PparsCFgWVOzJKych/vpqMe576nTaVw8ywfLJoxn/6wbj6Vm
 BnXLZ5Tosz4bkjW2zlc4nH1cZQ/BO5p1BmQPmbvd3wsmXtZCo3xgGBGoFP+SOio/fX9W
 /ZhQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzz24a5lABbTctS6eww/q2ujdtzPNRH+QgY5cW6Mj7zWdpuwwtFoeg1OMdot0LYqVULdwm/LWSqvSLJ@nongnu.org
X-Gm-Message-State: AFq9FYLNRp2Y0JlrMKaBWlzN37JqWSiDAnrenWEBIOGZPDm+zQ/3Xdaz
 XwbVBOLq11+vWWNqnbIYlaeO6Fa2cohnPCLh9X37QpZ+jIZgz/HMfYPTM7ccGlzMgSHXFlry6KX
 RcwTS0Qux+IxqE8h8RJH9Zv18ST+F8tXbggdaXYltF2gRKgoN06sL2F4vIA==
X-Gm-Gg: AYBFou3mjiaweUArbzR6HO6x/jETchtP0LunCcEjwUC1mck44bosefJjLxLKIGMmbDc
 8OMn3v14chZx65kAlN+BtCqYuyTqgijN3NslKJAE6/NCis6ZrPuYPOMTEyB7f89g5fzUu3EsZJh
 HblssPsviJdKf4ZJyBFWzxlK/ANVPsKXy3W+Km+k2uLlc3Wt/mzmrSm3u2erBJPc1Jvb7Gs7gge
 vvvqU8BPnvDPZ0lOdSyrwjvhwMu0jEcqsWRk588Oy+sRhShNAdNcn6/T+DHAc6TzXIIODjDk6FD
 LJ5/2uwvHHyPRx1s/L3HdVc2ukW61ah1t0auJNIiHX0wNms1+Y/juk1SFWZ3wN3VGzFqfiTQLoT
 kBLL6+y9P3Tuli05dhH9trbOufnzN6h1xqv7bQpqbWGlOaXcgcQ==
X-Received: by 2002:a05:620a:2b88:b0:942:a409:35be with SMTP id
 af79cd13be357-943f4b8d691mr612100585a.19.1793128531186; 
 Tue, 27 Oct 2026 12:15:31 -0700 (PDT)
X-Received: by 2002:a05:620a:2b88:b0:942:a409:35be with SMTP id
 af79cd13be357-943f4b8d691mr612094985a.19.1793128530488; 
 Tue, 27 Oct 2026 12:15:30 -0700 (PDT)
Received: from [192.168.69.229] (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ebd47basm26688204f8f.32.2026.10.27.12.15.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 Oct 2026 12:15:29 -0700 (PDT)
Message-ID: <145f8689-e438-4714-bbbb-494584440f6f@oss.qualcomm.com>
Date: Tue, 27 Oct 2026 20:15:28 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 000/100] tcg patch queue 20261025
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20261025071915.1123867-1-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20261025071915.1123867-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA3NiBTYWx0ZWRfXyrnZM1db6/x6
 naGXnTufSLhC7mdyitS6QGn98Xno+0s2NM2nuUPIyyk7Ev4Svr/pYkwEsCadDC3aHQewCY/U170
 iMjWZw/SlAvp0nsDZDiicnByxIjLvXljijilddvyBKb7sgbcq2OHruKhoaDyJH6sP4ACgvzLd2u
 6zv8VG58ewJSr3ohqV3AdRIz5OqORJV4BjxUFJo0NWPGqkb/JFreiQDcJ2bWh5xoV+74s0j4huN
 JoUsqAX2NMaALq9hr/hp+q7WliuqNmkAwAGuwdq4VvHmi7NX2bY1j+Jh2wgKYz6WdpswECZqyNJ
 GecocGxkD5P1fAfUsr/PfM0orBzrgFcWhaHJIswFf47TsCZmtqyPhDW5TQAVv8ADaTAIkH4yxRR
 D0y1dOL3QqyDXI++P8O2LjQL+ypVviRQAwvjBD+o0QA/EQY8+zUzE9TkRoiLB+HDTZ9wZ2csPYe
 9aAeL+iB6V4dFeYWvcA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDA3NiBTYWx0ZWRfX66bgaVbwOs3T
 xc6kBuI0YNYrxJLm2V/ElTwAMKpCSVkrmF/wwjdtlx6XcqB3u6DI+n+40RQgeh1mhF8YLjxZRIg
 o/h7m/DpwoyjVPYrFbQgQXopxB13fZE=
X-Authority-Analysis: v=2.4 cv=JspkP84C c=1 sm=1 tr=0 ts=6ae0f854 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=xNf9USuDAAAA:8 a=p0WdMEafAAAA:8 a=Qa1kb0bglSVJbV4n7sAA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-GUID: upOr6T5K8mSlqRex-tmnasttfbUI-Hj3
X-Proofpoint-ORIG-GUID: upOr6T5K8mSlqRex-tmnasttfbUI-Hj3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015
 spamscore=0 priorityscore=1501 impostorscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610270076
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Richard,

On 25/10/26 08:17, Richard Henderson wrote:
> The following changes since commit d73149283205645625bfa9fe029cfb68e4c4a9ae:
> 
>    Merge tag 'samuel-thibault' of https://people.debian.org/~sthibault/qemu into staging (2026-10-24 16:09:37 +0200)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/rth7680/qemu.git tags/pull-tcg-20261025
> 
> for you to fetch changes up to 0509b1a38002d99c28e24ba96a89c75ac08d9da7:
> 
>    tcg: Annontate functions in tcg-op-common.h with QEMU_*_NONNULL (2026-10-24 17:14:50 +0200)
> 
> ----------------------------------------------------------------
> tcg: Generic expansion of integer opcodes.
> tcg: Annontate functions with QEMU_*_NONNULL
> 
> ----------------------------------------------------------------
> Richard Henderson (100):
>        include/qemu/compiler: Add QEMU_*_NONNULL attributes
>        tcg: Annotate functions in tcg.h with QEMU_*_NONNULL
>        tcg: Annotate functions in tcg-op-mem.h with QEMU_*_NONNULL
>        tcg: Annotate functions in tcg-internal.h with QEMU_*_NONNULL
>        tcg: Prepare for easy temp lifetimes
>        tcg: Enforce sign-extension for TCG_TYPE_I32 in tcg_constant_internal
>        tcg: Generic expansion of tcg_gen_mov_*
>        tcg: Generic expansion of tcg_gen_movi_*
>        tcg: Generic expansion of tcg_gen_discard_*
>        tcg: Generic expansion of tcg_gen_add_*
>        tcg: Generic expansion of tcg_gen_addi_*
>        tcg: Generic expansion of tcg_gen_sub_*
>        tcg: Generic expansion of tcg_gen_subi_*
>        tcg: Generic expansion of tcg_gen_neg_*
>        tcg: Generic expansion of tcg_gen_subfi_*
>        tcg: Generic expansion of tcg_gen_and_*
>        tcg: Generic expansion of tcg_gen_or_*
>        tcg: Generic expansion of tcg_gen_xor_*
>        tcg: Generic expansion of tcg_gen_shl_*
>        tcg: Generic expansion of tcg_gen_shr_*
>        tcg: Generic expansion of tcg_gen_sar_*
>        tcg: Generic expansion of tcg_gen_mul_*
>        tcg: Generic expansion of tcg_gen_shli_*
>        tcg: Generic expansion of tcg_gen_shri_*
>        tcg: Generic expansion of tcg_gen_sari_*
>        tcg: Generic expansion of tcg_gen_andi_*
>        tcg: Generic expansion of tcg_gen_ori_*
>        tcg: Generic expansion of tcg_gen_xori_*
>        tcg: Generic expansion of tcg_gen_muli_*
>        tcg: Generic expansion of tcg_gen_not_*
>        tcg: Drop division helpers
>        tcg: Generic expansion of tcg_gen_div_*
>        tcg: Generic expansion of tcg_gen_rem_*
>        tcg: Generic expansion of tcg_gen_divu_*
>        tcg: Generic expansion of tcg_gen_remu_*
>        tcg: Generic expansion of tcg_gen_andc_*
>        tcg: Generic expansion of tcg_gen_eqv_*
>        tcg: Generic expansion of tcg_gen_nand_*
>        tcg: Generic expansion of tcg_gen_nor_*
>        tcg: Generic expansion of tcg_gen_orc_*
>        tcg: Generic expansion of tcg_gen_brcond_*
>        tcg: Generic expansion of tcg_gen_brcondi_*
>        tcg: Generic expansion of tcg_gen_setcond_*
>        tcg: Generic expansion of tcg_gen_setcondi_*
>        tcg: Generic expansion of tcg_gen_negsetcond_*
>        tcg: Generic expansion of tcg_gen_negsetcondi_*
>        tcg: Generic expansion of tcg_gen_movcond_*
>        tcg: Split out tcg_gen_ext{rl,rh,s,u}
>        tcg: Convert ext/trunc from TCGv_ptr to the new interfaces
>        tcg: Generic expansion of tcg_gen_clz_*
>        tcg: Use signed integer for tcg_gen_{clz,ctz}i_{i32,i64}
>        tcg: Generic expansion of tcg_gen_clzi_*
>        tcg: Generic expansion of tcg_gen_ctpop_*
>        tcg: Generic expansion of tcg_gen_ctz_*
>        tcg: Generic expansion of tcg_gen_ctzi_*
>        tcg: Generic expansion of tcg_gen_clrsb_*
>        tcg: Generic expansion of tcg_gen_rotl_*
>        tcg: Generic expansion of tcg_gen_rotr_*
>        tcg: Generic expansion of tcg_gen_rotri_*
>        tcg: Generic expansion of tcg_gen_rotli_*
>        tcg: Generic expansion of tcg_gen_deposit_*
>        tcg: Generic expansion of tcg_gen_extract_*
>        tcg: Generic expansion of tcg_gen_sextract_*
>        tcg: Generic expansion of tcg_gen_deposit_z_*
>        tcg: Generic expansion of tcg_gen_ext8s_*
>        tcg: Generic expansion of tcg_gen_ext8u_*
>        tcg: Generic expansion of tcg_gen_ext16s_*
>        tcg: Generic expansion of tcg_gen_ext16u_*
>        tcg: Generic expansion of tcg_gen_ext_*
>        tcg: Generic expansion of tcg_gen_smin_*
>        tcg: Generic expansion of tcg_gen_smax_*
>        tcg: Generic expansion of tcg_gen_umin_*
>        tcg: Generic expansion of tcg_gen_umax_*
>        tcg: Generic expansion of tcg_gen_abs_*
>        tcg: Generic expansion of tcg_gen_ussub_*
>        tcg: Use umax in ussub if available
>        tcg: Generic expansion of tcg_gen_extract2_*
>        tcg: Generic expansion of tcg_gen_addcio_*
>        tcg: Generic expansion of tcg_gen_add2_*
>        tcg: Generic expansion of tcg_gen_sub2_*
>        tcg: Generic expansion of tcg_gen_mulu2_*
>        tcg: Generic expansion of tcg_gen_muls2_*
>        tcg: Use unsigned for flags for bswap and revbit operations
>        tcg: Generic expansion of tcg_gen_bswap16_*
>        tcg: Split out tcg_gen_bitswap
>        tcg: Generic expansion of tcg_gen_revbit8_*
>        tcg: Generic expansion of tcg_gen_ld_*
>        tcg: Generic expansion of tcg_gen_ld8s_*
>        tcg: Generic expansion of tcg_gen_ld8u_*
>        tcg: Generic expansion of tcg_gen_ld16s_*
>        tcg: Generic expansion of tcg_gen_ld16u_*
>        tcg: Generic expansion of tcg_gen_st_*
>        tcg: Generic expansion of tcg_gen_st8_*
>        tcg: Generic expansion of tcg_gen_st16_*
>        tcg: Generic expansion of tcg_gen_dup_*
>        tcg: Generic expansion of tcg_gen_qemu_ld_chk
>        tcg: Generic expansion of tcg_gen_qemu_st_chk
>        tcg: Generic expansion of tcg_gen_{non}atomic_cmpxchg_chk
>        tcg: Generic expansion of remaining atomic operations
>        tcg: Annontate functions in tcg-op-common.h with QEMU_*_NONNULL

I rebased my PR but now get:

tcg/sparc64/tcg-target.c.inc: In function 'tcg_out_movi_int':
tcg/sparc64/tcg-target.c.inc:477:24: error: argument 2 null where 
non-null expected [-Werror=nonnull]
   477 |                        tcg_tbrel_diff(s, NULL));
       |                        ^~~~~~~~~~~~~~
In file included from include/tcg/tcg-op-common.h:11,
                  from ../tcg/tcg.c:41:
include/tcg/tcg.h:913:25: note: in a call to function 'tcg_tbrel_diff' 
declared 'nonnull'
   913 | static inline ptrdiff_t tcg_tbrel_diff(TCGContext *s, const 
void *target)
       |                         ^~~~~~~~~~~~~~
cc1: all warnings being treated as errors


