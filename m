Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99266C54FDF
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2026 07:50:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpLW6-0001JH-DE; Thu, 30 Jul 2026 03:49:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wpLW2-0001J1-5g
 for qemu-devel@nongnu.org; Thu, 30 Jul 2026 03:49:18 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wpLW0-0005Hf-Bp
 for qemu-devel@nongnu.org; Thu, 30 Jul 2026 03:49:17 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66U75Qwj231046
 for <qemu-devel@nongnu.org>; Thu, 30 Jul 2026 07:49:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 9gM9yOGVWbynzcomYjiSUBPXk76CJZKIN7ywx/UazHs=; b=DyjiGCcsc9vo5TT9
 cziaQBplDS88f0YqfFHlsef8h2Qt3QS2iN6kbYQhYxrMhUigMk5kF+CVBQPlAnXM
 2GsK5rpOqG6H+ivQoSSyNz90aXITcsltd2EUgkuQZOzD9Nnwo8W142W2xk907N5x
 +847ICJP1PhGzzw2vTwxej/MU8KNVNISKY9//89vOEL+LRkefqfAoVJg3WLvQO4a
 OW08Zis6DwwyP77rArtv+GDzD641VsUoqdKpFlQ5QrVz7egV7ft/A1TXgFDuOaQi
 /5cmjR4gCM4NgGOrOgADV/+HtMx0wavHA38S+4gD0GkgQTBKe239W+GdDFsUqqD/
 +p+NVQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fr1wtr64h-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 30 Jul 2026 07:49:13 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-51c0f0a0760so37958161cf.2
 for <qemu-devel@nongnu.org>; Thu, 30 Jul 2026 00:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785397753; x=1786002553; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=9gM9yOGVWbynzcomYjiSUBPXk76CJZKIN7ywx/UazHs=;
 b=afh3g1ovu+N1qvLcubxjYCnK/0zSdCDZLpQ79ECnUy5/dnpFujkplc1HCgmZRE+S5Z
 mHvdVlgcfxZWufwdrDZX+BYPOHpAr+VD0uCE/I7I/80Ex7ngMTf82fT30+H/XacF0NdF
 eJ95JOonfgC4xa8XQS5i/UmnlTRRnxcl+Ue81Q1U+AxC5tsVS9kwAUuDG6Pby0Zuj2zl
 9ri3Xas6AfZ0lNMa+LE9O7cmNw/hROuuzGj6d3r82KrTlAA7ZTGWlRhDMSzNMvSPT/fl
 8JvKR8LQ/gU5UEO5O5FC535AlWKljis4c1kpmni3HAuJflN+BLsa10Ryq5FmkLCdESsX
 Uj2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785397753; x=1786002553;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9gM9yOGVWbynzcomYjiSUBPXk76CJZKIN7ywx/UazHs=;
 b=N8TNTB1mp0Rg6rYKMVot0GePFICTKtz5mERODQVP/j0ahFjxqFGSTIOHGslJQJH/r5
 fzSGzFjBj+5nQ9nP1NLBQDIzRt61dqXWfqy+A3kigciKaUF5n8gLnksV3Fo7SLRfr7gG
 v8w19DC87wVeie2sWJvH2fT+nJ7pq41ax/2+jnR/jYCSd8AiYPUKRAQFXaNyRwFsYW3X
 OwgGty/8OBvO6Bt05hHeg8yoA8vcpKbFRy+VZS6mtFc8WwpQF/r25VvVWllt0D3nCU6o
 YX57L8RzKRM1LRhOVSXA3KItl4zBp0R6rlbOHeoKHC1CNGW2jgQ2D+H+EnfZ620C5mvD
 6U6w==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp53SDF6uR0RyNPTxj6j8hUPHhPORsRGgtO0tKqhX1BGJHzLHKn8xPSknR/BnHpHJd+g+b2zAGFErA+@nongnu.org
X-Gm-Message-State: AOJu0YwkUrPGIzZ4oe2ziHAwT/LAHbcmTTwelb6VdG8unMuzPiXuY7u/
 o0C5h+54HitZQCZGsVS1nyLZljZcpkPj2+X7CBrG71Br3ognSziAkQwFX1av7w1yMNOWta0I7SP
 ieaoKdXv6IZw1fB2s7h8I/xKnB1sb3UOBP1ZUWAd/GVA00UGd+kkuYXKWBg==
X-Gm-Gg: AR+sD10XN45MdjMptW8x7CmlasfKrPWTr6BWfsbekQ4UDUEYMUcEvvK7iChhFFWMpUW
 IzCceL4OY8Vf4iko1KheoU18COQAXGIpUdxj33W3BBkeZKU0RTnFoJoE7FnM6HRgbYd583ChuB3
 6qlIjqmbJ8VxoCxfE/91h9j8ydvlGVrf7zmzVhSakgrB4kxl5BPOsenJe2QHHzw1k5jRX8lyySj
 KlCmdGaZrSgaXsnxuiSBkeC+oFSIIWZ/jMgvwkk+sIwBwIMW5+nchP+pQQVQuNSUYGbE/KqbSJg
 Gn0X5VfgmrOjtM5+jx/4fP5iwu1I24QQK40+EZEiJbuHsEH1HfKj3rrDzwy0TUvjLkfdyxWYd2t
 gQDc+fKxFOyNMX1LYY/pzCBi83g2K7lBflq25SyRGtD16W2ZxXdc=
X-Received: by 2002:a05:622a:c16:b0:51c:7b11:419e with SMTP id
 d75a77b69052e-52b38725614mr19120911cf.75.1785397753199; 
 Thu, 30 Jul 2026 00:49:13 -0700 (PDT)
X-Received: by 2002:a05:622a:c16:b0:51c:7b11:419e with SMTP id
 d75a77b69052e-52b38725614mr19120751cf.75.1785397752755; 
 Thu, 30 Jul 2026 00:49:12 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-498011e5edesm38965485e9.2.2026.07.30.00.49.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Jul 2026 00:49:12 -0700 (PDT)
Message-ID: <e850287a-183b-406c-b1d9-8b6ca043859d@oss.qualcomm.com>
Date: Thu, 30 Jul 2026 09:49:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 41/50] target/hexagon: Add get_tb_mmu_index()
Content-Language: en-US
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: ale@rev.ng, brian.cain@oss.qualcomm.com, pierrick.bouvier@oss.qualcomm.com,
 philmd@mailo.com
References: <20260730031025.12926-1-anjo@rev.ng>
 <20260730031025.12926-42-anjo@rev.ng>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260730031025.12926-42-anjo@rev.ng>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: AwW3f9WeyFH5rhdVuT_xp4GBCVsxaMiY
X-Proofpoint-ORIG-GUID: AwW3f9WeyFH5rhdVuT_xp4GBCVsxaMiY
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDA1NSBTYWx0ZWRfXyGYptsUD6DFf
 //OPgZ9hMxTok/pUlaZWdqBAKQj+7VZtrIdD8xfCYbLJTrZi4l/Psd5ZmjMbdi5LERD8khj2prP
 zYeu/3wiiZ+6s/FRhb0Yb2Ny7z1UQEc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDA1NSBTYWx0ZWRfX17IVPGmDcBim
 46e3hth78u2y+V8sCUvt9ok8admlJW4OtI1ZMoudfqZUtptP0v3eaQHQZ1eNvNieKtX78ok0uxV
 ZoXmJXLvEDEwG2NX+smOwrHmwWJjyTuD8/bVa+W+zpxywvhCFtXi7WwqNUZjpwUNHV12STWFcCN
 I+zpnDwBrrfOyv3aQjkz8l6nX9AG2kPBlJ2dK8bqS5CzxOFp67rSigNOmmNNy+qD+4V6Lf6bJk/
 0bST7j9OteG3yTrcqWTfcfwF4tAlWukm/K9VipuHcVuMofjStmyNMpzDaSFqwfW1kRNiUPZr8DJ
 XPlUu7wQhQH8xXoLAAAzRtFp51LX9hK8d2r03PTC+Y6BpLMeVGT7CvdVe4R3EjjCvvhZJVk5Q0j
 S9Ga6uljHnR/DMMvY4ORD4wTNXqr5OuvqDeJkbcfaoB4H0LRgY7G+Jy73l1CkXLE/rn7wFbNLUl
 Dm/2kkGu3ZHLsjpYu7Q==
X-Authority-Analysis: v=2.4 cv=Wv8b99fv c=1 sm=1 tr=0 ts=6a6b01f9 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=hKPNWzxko4RLr0brJCQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_02,2026-07-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 malwarescore=0 phishscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 suspectscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607300055
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

Hi Anton,

On 30/7/26 05:10, Anton Johansson via qemu development wrote:
> Adds a functions to return the current mmu index given tb_flags of the
> current translation block.  Required by helper-to-tcg in order to
> retrieve the mmu index for memory operations without changing the
> signature of helper functions.
> 
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> ---
>   target/hexagon/translate.c | 12 ++++++++++++
>   target/hexagon/translate.h |  4 ++++
>   2 files changed, 16 insertions(+)
> 
> diff --git a/target/hexagon/translate.c b/target/hexagon/translate.c
> index 199b4f8c2e..bfd84bba4e 100644
> --- a/target/hexagon/translate.c
> +++ b/target/hexagon/translate.c
> @@ -128,6 +128,18 @@ intptr_t ctx_tmp_vreg_off(DisasContext *ctx, int regnum,
>       return offset;
>   }
>   
> +#if defined(TARGET_HELPER_TO_TCG)
> +/*
> + * Returns the current mmu index given tb_flags of the current translation
> + * block.  Required by helper-to-tcg in order to retrieve the mmu index for
> + * memory operations without changing the signature of helper functions.
> + */

No need to guard for TARGET_HELPER_TO_TCG IMO, simply add
and use in hexagon_tr_init_disas_context().

Dropping the "Required by helper-to-tcg ..." comment, the
TARGET_HELPER_TO_TCG guard and using in init_disas_context:

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

> +int get_tb_mmu_index(uint32_t flags)
> +{
> +    return FIELD_EX32(flags, TB_FLAGS, MMU_INDEX);
> +}
> +#endif
> +
>   static void gen_exception(int excp, uint32_t PC)
>   {
>       gen_helper_raise_exception(tcg_env, tcg_constant_i32(excp),
> diff --git a/target/hexagon/translate.h b/target/hexagon/translate.h
> index 2fca157553..6cf3b2fe3b 100644
> --- a/target/hexagon/translate.h
> +++ b/target/hexagon/translate.h
> @@ -345,4 +345,8 @@ FIELD(PROBE_PKT_SCALAR_HVX_STORES, MMU_IDX,        5, 2)
>   
>   void gen_framecheck(DisasContext *ctx, TCGv_i32 addr, TCGv_i32 ea);
>   
> +#if defined(TARGET_HELPER_TO_TCG)
> +int get_tb_mmu_index(uint32_t flags);
> +#endif

