Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7336160A2601
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 20:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=HSPpfxQo;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ZCeUppCz
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQVXO-0004ii-V6; Mon, 09 Nov 2026 15:00:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xQVWn-0003sl-Ay
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 14:59:43 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xQVWf-0004Ah-QM
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 14:59:38 -0500
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A9HH7Ib879260
 for <qemu-devel@nongnu.org>; Mon, 9 Nov 2026 19:59:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 tM8YiLpqT+wLqSNqxCMW5CgNi//JYHTegiGv6da3yuk=; b=HSPpfxQotTiYMehR
 fMCb5H7NYOPEjoC5fHH9IR9AzlNY0rc7waZrkkLUQ5atHhVwei/8dD4PiIQZs2Jt
 7yGQ+a5cYXSSQUxzb4I0PwD73MSLNi9Vo+Ja+cfeVh9WInWKyTW1DP0bQ04atda2
 m9BR3sKH7AfTrcr1hizuYGe/CvlRKXdtBWjJ2E1IdRvHk85LACLARLhiqKu0fusi
 ZwBaPhr7G8sUIcJbMG5R09N5deN1Q/pVd/x4xBhrEg4dFLuvv7VP3UUNe9S5HFuN
 h5/1dJp1OxwYuDXIh7IjcHUJKANUk1kdMpmYX6QT2PViP80o8DDETfQdq5zxjZZW
 xhDfQQ==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hucr5sxrr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2026 19:59:31 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-91ea4a2210fso14177716d6.0
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2026 11:59:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794254371; x=1794859171; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=tM8YiLpqT+wLqSNqxCMW5CgNi//JYHTegiGv6da3yuk=;
 b=ZCeUppCz3V6f4ZYyc8nSZF0BDNICPgtk2st6TS8dlKibuiAheVs5BBtpb4pJb99cw2
 DOUYjCzwTtbsnyySZPdt4dJ8PCLRm/voR0TDTak2T2V18lWFebmm9VQzdgMcMI7TWhyX
 LfsgUxrB6k943WnRbv63s0AlKFoiYroOT/5/6xBqyAQkhItl4AE+VE0qDpn/izt5BOlC
 JXJZJi5tkE4U7RZbGOKNVasjtbR8nA7KzvDyTgH1OuHIuaVKfIEgqBwqh78LVC2VaAqS
 /zdiaF9doFp8H0NWkEa5zzM+Ge/pBw4tt4SWL1JQy7RqZaaJ2QJ+H0aoKZylx2tV7zOv
 X+fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794254371; x=1794859171;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=tM8YiLpqT+wLqSNqxCMW5CgNi//JYHTegiGv6da3yuk=;
 b=ET5ulbefop/Lx5ZjvW9ydve/60ohGrcE4VliqsEPvkcg5x2oHVJZqPRwyWElQlqDYT
 6B5d/aw4rKOA5U+7Yv4xUxeWA+D2u3rd6iE5RzPjWmzb3WPjZmvo+HnAm4be32LSAtrT
 6FEFy23dW9FeBu8ni4gl/4+FYtr7KXGwThQbtWotS0x3wfyum7ftTaA/98wqCM+6jphp
 7NBDsgaPlhYe5ZaM4iWphX2JzoNxsDM9rq3qJFETEqzdtY14MvPq7O4ceKmFG8/A1us7
 yDMGM/IgpL+1EvxPsIbvXbEEZQu+gfhMpXHQu1UB5LVH2A3+BWPr1mt2oYbcPS8kb6Jx
 u/4g==
X-Forwarded-Encrypted: i=1;
 AL+hErGndRbdQqQFCv/l8GAvg3fY+RWsPca5E1+gAReUhFfvBGezH+7dymO7DbCO95QSDDh87NAZLm7p/5Fr@nongnu.org
X-Gm-Message-State: APuU4Z+Z+ffYJ5INc2RiqQiIRQYbzwUWXC29/70pOgG/nf7/UX/OAqzp
 Raf726u9iW9dXO1IgRwtDLmdLBbxeTybPJUZjvySPhWUdd+tg7QZFXomUa7ofepIJXwrrRqDi9I
 PYG4Pk+2OflLmboWxHtBtVVZt40Ul8iKohwz7VqobAx7f4+p5fWe83+9Q/A==
X-Gm-Gg: AYBFou2a/i0JBVbLh68uepNO6TQ1znjHWAb9W9QwP6WGQ6d1Pzbe0mYJKyKEwEK8ioD
 VV91mnj7KkGGKbH8KeYR7NkXKMFgLgmvpffOPS71fTgcjrDzE7pFo8EEThLkt7Ns5YU8tl51sEO
 87HHdu5VgpUs8bdNJcae8BPW86YRQGhRJpbOVAzBJ8NdK2et2v8R6rzMKrlOtTkimgeF70k0Gtq
 3n4/qWJoxpN+8bNx3mzpiBXJLuUlqPxT/AkjKsHLIqqZ7J1rVeKc9wAHYA9g0Qn30CpolbWQHhs
 ZtdSl6mIDWAlPj/LpgocyNKpWnMZFC2v/DIVmFDc+2IOYdBtglXGbCrIlZDfr55hYkIa6fUTh4B
 EHBjXv8JKzk4iYrfkZ/iiN/dIIJyq+BiMinLn8wGVWuIxJxU1ZQINV39F/HTb8eK48G1b3eT50s
 yRlZe5q1IO
X-Received: by 2002:a05:6214:320b:b0:914:cdbf:b68 with SMTP id
 6a1803df08f44-91eef888d87mr10468546d6.20.1794254370564; 
 Mon, 09 Nov 2026 11:59:30 -0800 (PST)
X-Received: by 2002:a05:6214:320b:b0:914:cdbf:b68 with SMTP id
 6a1803df08f44-91eef888d87mr10468036d6.20.1794254369822; 
 Mon, 09 Nov 2026 11:59:29 -0800 (PST)
Received: from [192.168.68.100] ([152.234.124.231])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91ef04fc000sm3776096d6.26.2026.11.09.11.59.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Nov 2026 11:59:29 -0800 (PST)
Message-ID: <d797d962-1911-4d0f-9977-0fee55c9a1cc@oss.qualcomm.com>
Date: Mon, 9 Nov 2026 16:59:25 -0300
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 09/38] target/riscv: Add Zvqwdota16i dependency imply
 rule
To: Max Chou <max.chou@sifive.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>
References: <20261104194155.679241-1-max.chou@sifive.com>
 <20261104194155.679241-10-max.chou@sifive.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261104194155.679241-10-max.chou@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDA3OCBTYWx0ZWRfX8ayQGPdL7tqL
 +LzrEnRABtTPZGNWfBl0bxZRyzfJoRaD95A0x5uFTFH1lVpRJ234pFrglmYt8Zd5njaHzN1z3TT
 ge9Ba2nXzxkEQVT9IH9oJVczyYXiO6U=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDA3OCBTYWx0ZWRfXyx17QKCK4LrE
 /yH6hkdQSteQCs5XFhFOZH6IQuX6FfS5747unc9PDYZVlpbiYvZv/SLYzuGeESzyG4mKVUi9zJp
 6HwpAIER3q6RG2LM1uuczO+bBed7POb8CKits8C7Hn6LU/pijqDB+9oZtJQkIRo3kWe+aJ6FQbQ
 VVGwOuDC4haM9V1vnkfeU82QMoND9hmr1wgmuMZ4T2Q1I5JlK7PKUfRWl8ALHOO0l6IbncrN0lt
 jh9PJ/IIQTeNHx+D5o9qWIqwgM+QniwFL9IHJUmngYzKfRNIp0kDOdCfubpnbzK5z2eQ9qplr04
 Apa1yYwO2e8ucQDA4vdAEl1RfTQHE0vOHW7qlRIHfB8JRhWZolhFsy4f5UHI+5i7xncmjx2oHue
 pmCeOqv4Ls+5AiUTn+a6ZDUka+ej/qI4W+EFnAkvwpliM9g77xYl/ONx2JJjOYUcTBKK03txOro
 IUr/bnHguWm1sT4Y5/w==
X-Authority-Analysis: v=2.4 cv=ErlHPicA c=1 sm=1 tr=0 ts=6af22623 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=8elE1k/PHQNyZ14TNTodlQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=pFyQfRViAAAA:8 a=EUspDBNiAAAA:8 a=lghVttTW7IiECEMhu-gA:9 a=QEXdDO2ut3YA:10
 a=iYH6xdkBrDN1Jqds4HTS:22 a=oJz5jJLG1JtSoe7EL652:22
X-Proofpoint-ORIG-GUID: HGjYyWLdA42xU1IaX_nkvizLc37Dz2P8
X-Proofpoint-GUID: HGjYyWLdA42xU1IaX_nkvizLc37Dz2P8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_06,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 malwarescore=0 spamscore=0 bulkscore=0
 priorityscore=1501 suspectscore=0 impostorscore=0 lowpriorityscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611090078
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 11/4/2026 4:41 PM, Max Chou wrote:
> According to the Zvbdota isa spec, Zvqwdota16i requires Zve64x.
> 
> Signed-off-by: Max Chou <max.chou@sifive.com>
> ---

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

>   target/riscv/cpu.c | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 7873e67c053..ae859128d30 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -2853,6 +2853,15 @@ static RISCVCPUImpliedExtsRule ZVFHMIN_IMPLIED = {
>       },
>   };
>   
> +static RISCVCPUImpliedExtsRule ZVQWDOTA16I_IMPLIED = {
> +    .ext = CPU_CFG_OFFSET(ext_zvqwdota16i),
> +    .implied_multi_exts = {
> +        CPU_CFG_OFFSET(ext_zve64x),
> +
> +        RISCV_IMPLIED_EXTS_RULE_END
> +    },
> +};
> +
>   static RISCVCPUImpliedExtsRule ZVQWDOTA8I_IMPLIED = {
>       .ext = CPU_CFG_OFFSET(ext_zvqwdota8i),
>       .implied_multi_exts = {
> @@ -3066,6 +3075,7 @@ RISCVCPUImpliedExtsRule *riscv_multi_ext_implied_rules[] = {
>       &ZVKS_IMPLIED,
>       &ZVKSC_IMPLIED,
>       &ZVKSG_IMPLIED,
> +    &ZVQWDOTA16I_IMPLIED,
>       &ZVQWDOTA8I_IMPLIED,
>       &SHA_IMPLIED,
>       &SSCFG_IMPLIED,


