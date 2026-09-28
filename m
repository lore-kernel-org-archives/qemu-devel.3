Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADC03CA5FA2
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2026 10:45:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xB8qe-0002MR-BB; Mon, 28 Sep 2026 06:44:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xB8qZ-0002M3-T9
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 06:44:36 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xB8qY-0004zy-0n
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 06:44:35 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68S9MbF32058486
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 10:44:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 bQXl3ec5I0tTbXGZZdIQHOW3bCO2DTp79uRtpkVGkeE=; b=KgPUWXi0mV0Z4kIr
 2QGqIxEqUEGk3WiA3nCTtnyakM7YsAGNQVnBgg+K9gKe6IrzA/5dpQEbAeR7xI4h
 Lgzh++5OkxQjIuBzyc1ceoXnclvYQdmJtxN3ZuLq9eD4thA4LiC6JZonmK2S+yji
 1z+FEK3bUB9SoPEQjRaqUSt2UV6lcSv+GJkVKnLXtQwzgxJrYPfUtxzQC1vuSILT
 znqz1K0jNfTgQylXlVxTLZdWxXT+oO3zWuOhrsdrbIIKsRkOrkxONm+KC0YgJsX4
 4SESiu2Hho3ai5oOx3GfuATQnWqzMf2ptHrayelRE6XPAvl8FZbH8o7EFw1R2K1s
 k3nWEA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gyhubh5ye-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 10:44:31 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93c57e0436aso193228285a.2
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 03:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790592270; x=1791197070; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=bQXl3ec5I0tTbXGZZdIQHOW3bCO2DTp79uRtpkVGkeE=;
 b=FbthUI1Pw6PIfkGmZzLveLJLvVQRytOBzu5214MYzmqjKfAMwfuennanlH34CQe57j
 V1RGg6/w5K8DirbmN0SFaOLacZUJtIsZfiK0QNraID4Htus5/QQFr7z8vZOomnEjJNpB
 5QR9Mw9no+tS5cfegMgKWZUksjReXV9JchPxFwUMxz7Ok1r+3dpnuAStsE05QzJcE+Wu
 G67N5ANYOfByjdjDW0+NiOXFfWGWVUzAW59/BOH1Z/6CC3Le5Bh2pW9ev/6nDBcc0pVE
 4G1bPX8t7nAF684lWYH810cOgC7T+Ua/kbQk1kf3Xun8HuGosu8yMCXrS6OKy9rMf1m0
 M3xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790592270; x=1791197070;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bQXl3ec5I0tTbXGZZdIQHOW3bCO2DTp79uRtpkVGkeE=;
 b=icPYPxNGzUIE/FFZggQp/zTUAsZFVjoKCChLUxwDnz5j+WHJGYbg24J/V5VABzvxAM
 TL1KOIt7vMT3UxEWlrO5LnsMIbbevnC3op/WPFom1Qz4APwDEdXLRM+to9BDgbri+j04
 YYmHfiDFrd22wSHgRBDJPho9G9tikx6KTW0q9O37GfQB37HSRpcC0I7hAdipB2istZ8X
 nHcA+AQDrILLFNnYw+aAKNAJ6iufrsDrH8NcynKmTV/feMvHqATXF9yMlb382NRrWfam
 Wl/qp+lsUKyqG7yR5tWMb3FDxfwJHEE1i0hYA1W/AKjOYfX+SbTJF/UqwGmi4o970zfx
 2JiQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzt7WcD+m9XnD3KKS0IFhpZEBehlSE6GBFmdtvzKJ9y0zeqLnD9jnZ+l/UxKijQ+0XXUlr2AIglUF91@nongnu.org
X-Gm-Message-State: AFuF++mJDgTbyLDTxBxI25eGCCKEfWQ03nx6e4x74GE3py0IUuK7XXmu
 onbSMvp0le0ETUFkQtDwd1QNB2EDXCNPJJgiwHn1lJB5E89+QHUpNP8/8Rbi04oEiyx0mqPpgXJ
 ijsoQ6pdpLUnARZUZQZ8j+vr/2l735TkNp1xy7GWyLkSD01bNKURnqqHJBQ==
X-Gm-Gg: AYBFou1Kz+2CfvnOdrS0Qw059UoOjGRKVuV0NXWYxnP9VUIpU8Ig1UdQ5ERJVwH6sXi
 KG1yapjbc0nUoUzwU3yvRqrvo/orMJ/S7c4cmSrkisrtYxUgyB6JSdW9DxjNkEJQ/6r6kP9vPF+
 P4RQ8EpNfPSPAhUfLrJ+cVxTJepb0CC47GQWL3PG7GFOkxXjI7alKmOQIn4BwBDVDutX3yyNAFY
 JZEMoopAfD844SOa57JgV+U9LBLwpTMh6nzpTykNKkeEoONWUx8Pt5Q17D1t31X+frxHvOBbvet
 2vxAmNIB6PsBF+bFwfJ/Hi0t9djvwpRkdHKqKhgnoBfzpfyRyz5c6Kf5tRYkJXN6lpTz2B8TXpB
 EufzWjTHa9FIbKG0m12CY0jL8yKebTSGMCA==
X-Received: by 2002:a05:620a:3190:b0:93b:d7a2:dd2e with SMTP id
 af79cd13be357-93c43d34647mr1888186885a.62.1790592270271; 
 Mon, 28 Sep 2026 03:44:30 -0700 (PDT)
X-Received: by 2002:a05:620a:3190:b0:93b:d7a2:dd2e with SMTP id
 af79cd13be357-93c43d34647mr1888183585a.62.1790592269678; 
 Mon, 28 Sep 2026 03:44:29 -0700 (PDT)
Received: from [192.168.69.225] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a0019162fcsm133091655e9.13.2026.09.28.03.44.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Sep 2026 03:44:29 -0700 (PDT)
Message-ID: <045c66fb-1ba4-4e22-ad16-af09a64a32e0@oss.qualcomm.com>
Date: Mon, 28 Sep 2026 12:44:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 075/101] tcg: Generic expansion of tcg_gen_abs_*
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: mattst88@gmail.com
References: <20260927090011.10724-1-richard.henderson@linaro.org>
 <20260927090011.10724-76-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260927090011.10724-76-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: Kt7cfttR0_m3xgoY-w6pFXiCVzK1S-bT
X-Authority-Analysis: v=2.4 cv=C7F8WgP+ c=1 sm=1 tr=0 ts=6aba450f cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=YRKm52ci-pRe0zCNswQA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: Kt7cfttR0_m3xgoY-w6pFXiCVzK1S-bT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDA0MiBTYWx0ZWRfX2yJ0TSXSUbHE
 lkPxSOM1xop8S4JTHUgHVLXxJKwzExjESUAiZulMH5RiwMd0h3pBv9ezeXuW3wwvIbZDKUKTcku
 m8UYPkuUAovlSDy0tBzxAz2tAt+F9yJ8qvXRwRgyzxMGYZ19iCOer9KEYh/j6aWk2p8wOhdbdH1
 Ext7/9mHe9ILMajpouj3IngC17PtFx7XwfQPeG/zcO3kedzOdzBzWGKp+w4zCYSLE2yugB3Tuxo
 8FqRBtJUXWl1AjlPmi+uSDEJ0R951bhrAn9zKibJ9bNeslAbNb+EqIQql5Bje/BAIzGmTVlw9uU
 7lGZFU7VKcCvdg+5kC5cBdvzFj96zUDNW8fkQnlGDSpaAhKdpBG9QFB8iWDv+NQCdM+gLgABGbn
 uZYxIGqMyI+0YhwEiPuTVE0/jJw33upyBcQfmy4udh6k3aWrhEIwHGxMv+bNNNGRDVjz6Dfz271
 yvO39rsTIhVa00/RHjA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDA0MiBTYWx0ZWRfX14lKufHderZG
 iwnT5tiq/AqNJdKIZJHEJtA4yeqnu81PhcKruY8RmyX2tEHiCFZHMfKFESSRJgr30zrSxqlWbt6
 P0lntbVhUAttsCThwU6XiVnXUsCQ9pQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-28_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 adultscore=0 suspectscore=0 spamscore=0
 malwarescore=0 lowpriorityscore=0 clxscore=1015 phishscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609280042
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

On 27/9/26 10:59, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/tcg/tcg-op-common.h  |  2 --
>   include/tcg/tcg-op-def.h.inc |  1 +
>   tcg/tcg-op.c                 | 35 +++++++++++++++--------------------
>   3 files changed, 16 insertions(+), 22 deletions(-)


> +void tcg_gen_abs(TCGType type, TCGTemp *dst, TCGTemp *src)
> +{
> +    g_autoptr(TCGTemp) tmp = tcg_temp_new_ebb(type);
> +
> +    if (tcg_op_supported(INDEX_op_smax, type, 0)) {
> +        tcg_gen_neg(type, tmp, src);
> +        tcg_gen_smax(type, dst, tmp, src);

This patch is doing 2 distinct changes, generic expansion of ABS
and use of SMAX. Can we have the SMAX use in a following patch?
Otherwise:

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

> +    } else {
> +        int width = tcg_type_size(type) * 8;
> +        tcg_gen_sari(type, tmp, src, width - 1);
> +        tcg_gen_xor(type, dst, src, tmp);
> +        tcg_gen_sub(type, dst, dst, tmp);
> +    }
> +}
> +
>   void tcg_gen_add(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
>   {
>       tcg_gen_op_ttt(INDEX_op_add, type, dst, src1, src2);
> @@ -1377,16 +1392,6 @@ void tcg_gen_ussub_i32(TCGv_i32 ret, TCGv_i32 a, TCGv_i32 b)
>       tcg_temp_free_i32(t);
>   }
>   
> -void tcg_gen_abs_i32(TCGv_i32 ret, TCGv_i32 a)
> -{
> -    TCGv_i32 t = tcg_temp_ebb_new_i32();
> -
> -    tcg_gen_sari_i32(t, a, 31);
> -    tcg_gen_xor_i32(ret, a, t);
> -    tcg_gen_sub_i32(ret, ret, t);
> -    tcg_temp_free_i32(t);
> -}


