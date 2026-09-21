Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A534C982EE
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2026 12:15:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8cuR-0006KS-7U; Mon, 21 Sep 2026 08:14:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x8cto-0006E3-8p
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 08:14:07 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x8ctm-0007L3-7r
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 08:13:32 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68LAdnhD227909
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2026 12:13:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 mspawvH0SVkypV9ky/EfH3/sSZLNgMemkEDDrFFIzCU=; b=L6Ayefly4zaqqLX0
 28esryD/S0OylPVB5p08+JCBo5tnN+smML4+mBIwflMmjNDGv3nHqqV4S4jHlCB4
 F8tLKg1+w5x4ZsQpbkR+2RsIGAOJMnX7bBj9KoIfsGDBll9/hNhntAyc5nwdWxJc
 FC0xHMQYo86sQeUjiff0dB0dBhjCJFX25GAVNmFBCMaFbi5pLgUY4G73nZBe+mFb
 1arru/LW/JyW0rLqhnvJ9Vjkm5IsgMV01Yr7h99EHSqjH3Js+a9KwtuCtDhiF+7o
 7YRs+e3d9a1xHIatbaxABOxcnqCp/DVVZBXPAqBsP2hDXH+YFfWw5tnWQR0vuPXm
 nP8vXA==
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com
 [209.85.221.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gu17grudy-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2026 12:13:27 +0000 (GMT)
Received: by mail-vk1-f200.google.com with SMTP id
 71dfb90a1353d-5c8487ce333so578797e0c.1
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2026 05:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789992806; x=1790597606; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=mspawvH0SVkypV9ky/EfH3/sSZLNgMemkEDDrFFIzCU=;
 b=Ykz8dsVqHgvMCKpvQKTnZpqebCqWD13N23bM4k0s42z8Sj2/PaNFCImWfM2mDWaetl
 IkwQGgQblr3VKdEG682fdsoxgdhusqszmjPwseeBvFX29TYU7NFbBDCAYZZ2DC630sRv
 ryTRaPjA5f7184wK5Cupp7/aleflX+s4mYNXIxox6kpAFNPGta8tUse4suXgX/60k8ER
 VsOf4X8scSADp89RNHk2abjmuFO3hH27P+dqq6KWdP2kCLLsx4qkc39oLldbr3ywBFPO
 GZn1YJlOaju3bhorcb2fizWU1isqwDXJjS/jdax0kYxzxUOs5ymHN/M15umt8e1fbVgH
 bIbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789992806; x=1790597606;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mspawvH0SVkypV9ky/EfH3/sSZLNgMemkEDDrFFIzCU=;
 b=VDCVl5vON0PXa1/87QSmvo6C/L3pg2zSBAfYDy+xlcAkZr4l43QoWY7c/CoZK1Y13b
 RAOoS52JeUGXxU5PBI7N/vMdJwlax6WVGev8dK+5Tbz9toYRzdWW96OoOweRB2qrTRFP
 s8eMnyXky5Kaw5nPK+XBK3nlTjKAGg3lXTV+9wQAgOxTU7k5D3AnKavyQZHKBmuWYYz6
 xh65DmWrUP5Dc/vKF90jvprqwHyMAlHi2d/Tfb2zllnWfzCez+Frk2ufCWbPYM/QgZZw
 XUzODhlZ/WowY2Q4p0PhAs5rRc+vOSNq58tbbG2XyrWihIRF2bYJNVlFE8sVsFPxzEC+
 MDJg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwyK6OaxKT22Su1S0RYVaMb1kKQPcgzRdyTzC9PEzDS7shYU2Kd4Bl7MER/vpYA2+sSm+vcaeo1I9Wi@nongnu.org
X-Gm-Message-State: AFuF++nILfy2/oPF3Cd8vqc8NeVp6FqE+z2oHNvB54S3e1M1973vgL22
 IQyapj1sM/Twf0vWV944434FDhToVij1ts+0h0OtdTtel/r0BDp0kv8zrnWokogIvlrAnRFemXJ
 9EAG6reKA8tjW825zVOo0XNyarEwOsMWL7q2yan3Pcy51IntWCTFzZ81pDQ==
X-Gm-Gg: AYBFou2tSTL/egKb9UWGFuGecFb9Fovfi/dqT8qCP/fD46t4gNsFVo0R28LUrGHc8nl
 Fg/TJKy49haqTRQs9VkSRtPEM4F2Slri3vKvXm3skM/RtUxDDuQMy+nqIE/ooA04Gyy2Xt+ROei
 M6rTCAqu7aZht7pRBfxG+ubLhZJ/83MEZLgP3Vcy486qbe2J6tfESNc1J0wVwwVE7mhRgCTw/Cf
 ogbvPxJbTeo8U3fhIALKEEMUAJYYY8G7XWurhHHqFVKENcj2SjkjzEC7/G/STcls6J4u+W3YV6C
 eczYs45I/ATegahhJKaRIELP9ccS8GUlvwFZLagvhQTYfbhl4Tu1/H5gbnDY8olAxUPDZl6hlTb
 AhZw3pQMqEYZlHH+hdBx3jFw161BtzWuduw==
X-Received: by 2002:a05:6122:1311:b0:5c9:a60d:327d with SMTP id
 71dfb90a1353d-5c9b5a0213fmr4760927e0c.17.1789992806098; 
 Mon, 21 Sep 2026 05:13:26 -0700 (PDT)
X-Received: by 2002:a05:6122:1311:b0:5c9:a60d:327d with SMTP id
 71dfb90a1353d-5c9b5a0213fmr4760893e0c.17.1789992805659; 
 Mon, 21 Sep 2026 05:13:25 -0700 (PDT)
Received: from [192.168.69.225] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48724593bbfsm20111247f8f.27.2026.09.21.05.13.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Sep 2026 05:13:24 -0700 (PDT)
Message-ID: <3c73feb1-89bc-49ee-9001-a7ce0f7d839c@oss.qualcomm.com>
Date: Mon, 21 Sep 2026 14:13:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/i386/tcg: Always initialize CCPrepare.reg
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
References: <20260914220000.1757165-1-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260914220000.1757165-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: ZJVOzok8dAdj8Jzvnr5Vut-z8KO55IXy
X-Authority-Analysis: v=2.4 cv=IewSymqa c=1 sm=1 tr=0 ts=6ab11f67 cx=c_pps
 a=wuOIiItHwq1biOnFUQQHKA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=XD7yVLdPMpWraOa8Un9W:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDE3NiBTYWx0ZWRfX/33CJGzCAkBQ
 /h3uUKnNXZZEvg68Iy2h+VbUNZOb6A5tUPhzTJC7Rrm2H+9AYblMMD3Av+4Q3WdSX5l1BZdJyaP
 f7F9RBF9n7xorbbfndkv156fdRVr8t9Su2++3Uac9VC++3npeb7RFPc0CxYHsg+V61pjwOGVVjc
 wqPEVqglVYbJaF6f0HDApWELB8HxbkEvKDStA/DoFJQEEW5aa4SNt/U7lGBWTJ+/lOVsjZ/R3J7
 2/Sm/5+bmcCRxyWZYswDim/RPBqYD1MbRC0QB4qA6DKPwak3GOM/lmsDOM+aAnbZ+win06Tqtuo
 TxYuAkEpkDnEUAJg5G4zhfKTvDXlEE/snr+MBl9Dq5rrdWYpWtszdfJtJVEz26Ef0EQlscwXi/5
 L0BLeFDJxp0s8mwppekyqTLXZsEML8Izo8XftTF2vgi2U+QIbstLMpTQeBNC9oNlmV9R4ZOu+RF
 dItzcdPwxr2qmpTq9bw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDE3NiBTYWx0ZWRfXy1W5pVEvAEwN
 tTFlXnkxx4knyDh3dRLnIAI/njGpzUTvshOmuxU0uefoaDo26DNHssk58CcZdPA0Jhsi0el+r4G
 TYAzyNuWnVknyTUnJXT2aLFKxhTdtPE=
X-Proofpoint-ORIG-GUID: ZJVOzok8dAdj8Jzvnr5Vut-z8KO55IXy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_04,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 lowpriorityscore=0 spamscore=0 phishscore=0 malwarescore=0 adultscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609210176
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 WEIRD_PORT=0.001 autolearn=ham autolearn_force=no
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

On 15/9/26 00:00, Richard Henderson wrote:
> Forthcoming tcg improvements will diagnose the passed
> null pointer with --enable-ubsan:
> 
> ../src/target/i386/tcg/translate.c:1177:5: runtime error: null pointer passed as argument 3, which is declared to never be null
>      #0 ... in gen_setcc ../src/target/i386/tcg/translate.c:1177
>      #1 ... in gen_compute_eflags_c ../src/target/i386/tcg/translate.c:1182
>      #2 ... in prepare_update_cc_incdec ../src/target/i386/tcg/emit.c.inc:407
>      #3 ... in gen_INC ../src/target/i386/tcg/emit.c.inc:2213
>      #4 ... in disas_insn ../src/target/i386/tcg/decode-new.c.inc:3151
>      #5 ... in i386_tr_translate_insn ../src/target/i386/tcg/translate.c:3514
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/i386/tcg/translate.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

