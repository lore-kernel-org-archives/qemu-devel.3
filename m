Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9B11C55179
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2026 14:59:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wqu7i-0007cF-1A; Mon, 03 Aug 2026 10:58:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wqu7b-0007bq-PW
 for qemu-devel@nongnu.org; Mon, 03 Aug 2026 10:58:31 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wqu7a-0000JG-9I
 for qemu-devel@nongnu.org; Mon, 03 Aug 2026 10:58:31 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 673EBlUW826827
 for <qemu-devel@nongnu.org>; Mon, 3 Aug 2026 14:58:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 azUP8zVXrDW0Aib2m/OhbmVYA0b4Cy7Knwfiy8Z0L8U=; b=fipP25cbIZ6H7cPA
 JIVQYTlzRFIaM8l7PtLswVJHJuheRoK75MphmcsBbVwGkBQAOVMxh06WfXkdNBkl
 4OmaGgMBvcf0//vVIk5FmPdT/utHe5abNrpCTudzTFygFrBGKk1JTb7iA+qMud3w
 baGBUywDePahioHcW9/MUbd3uo5OQYxNrBfnwKLUmGlmJq6A8ZcguGGt6KaRvJ+h
 hj7u8uCGyF2Nqza274AlXquToc5SQrri5jZbVX8EruuYtK/pGwgNIaCPrNZhEFjA
 ziWEDyIN0jMiA8mx3+DRlmqTyizlNb7HCWi7URdRmjxfgVwK/40LMu7zDT/xkO4L
 vVfcTg==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ftnhkj69t-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 03 Aug 2026 14:58:26 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-51ebdfceddcso39253051cf.3
 for <qemu-devel@nongnu.org>; Mon, 03 Aug 2026 07:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785769105; x=1786373905; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=azUP8zVXrDW0Aib2m/OhbmVYA0b4Cy7Knwfiy8Z0L8U=;
 b=XYxH+zFO9s+pgXJE77m9SBGYyTaefPr5rH12nFxFpLnqgLg9r6T2pEt1DyJZrp3FPo
 l8LyTfxf1et8QhXRI/rZ72jFEEj9iwH3TXv+06El3vKI4IkQ+kirFURK3p+4uQ9Sfu4n
 j7sculNtUxzz4SIdD90/giPiwTnDscBnRnuFkOi2MCbYDn4QbtQ/iuTJPtHJAT6ujkGj
 sHjlYO99IBxkpNyoJwAkPGVzSPDG75pq4S2qU7K2IMhMcOvU53bkSswgMWn3LTCYBKRm
 IpK9Z4Ic9pO2yINiyncDtArwUuz7avSqGkJa2P8uuBZaPtNpZsKySMGS+UKqBzYABWyh
 kaSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785769105; x=1786373905;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=azUP8zVXrDW0Aib2m/OhbmVYA0b4Cy7Knwfiy8Z0L8U=;
 b=RsStmOUu44TWErDzM0nAWonH2nUQp3hrOTrKeU6SLkk0O96ish5lgOn2/Jx132s+cU
 5nhdKtFw7ptPBGyEiwmezLKmuCG1Ve20kBTNHTUw5fyRy0XNB/uNGILKVqq/IMawRf9A
 S7OE9v6qiuL0H4hVaJC5wKnnJO54ggP7HX6nS4olapeGZipUGPD+fd6/K9a6SqkMr9wr
 wQO5/yiB/88t1lgXEIqm3/SfgrRiQXvx+9mH8+ASSMjH12dS/g7kfDPAIE6MjMaPjFoE
 E2xbNJ2SE2xa+f8N4z38Jj6QBTqCj+WMFmgInLGG30ZHB4ihAQfHz4fD09LrUZ0xXjiB
 Ct1Q==
X-Forwarded-Encrypted: i=1;
 AHgh+RrI7T4BoTRnoKxd0hzs/HrYlPZFB8zB++gCDqzwVHYnja4hJGvRlR3AAgFh3JjmrIQZ4KajgQyVfIEt@nongnu.org
X-Gm-Message-State: AOJu0Yy+G8LA25NQPfSglf3oDjFx1HnOIZ+D28cqpiWehLf96RPZV53p
 ll0ZT3hE0lGwRSFZHmpVa4gceE39X+FmPs4n5TVrz2TuBrU9EzjfJmCv6enoDMOUjUPm/Srub9c
 NFSjAaIp42WQWmMrsWPaXFXA6in8NHlGQ4lvvUtsZdxdPICYd+oX2/hKwfA==
X-Gm-Gg: AR+sD129LLGcZSJeXaJzj6l0tbot50XPWo+GS1ILEbWo3RZb4poL2iLWsnxWzNwhJtR
 RmoecaDopgmrd+7WHhwWKCUkxN1IIHdjb88Qb5CYhhQsm6uwX1TFxj2xsmJsMwsBKofU1ONb5yh
 lWmJ2Vjig7/VNNFlHLyTOHN4CZjaC23fyAG/yisa/pm25cqFxmaamvKKgG/pRclROCrrORvR8iz
 sAs2Csy0dxeLcuutkGSJd0/KT7R1pX0s0tYp3a8tiypxwzKI12CKKEcCD7+fvn2sWyYoc/pL6bz
 kbw7zd0dsVRRt6PCpz9SsBdYw1Ohzp+Rph1niaQ8/Wohud9Mj+HrMWPt3PNTUAf8wGf93/5myz/
 n0jSuYd0UPSyiNp8Iuw0mHYVzEspXHyIasfE=
X-Received: by 2002:a05:622a:230a:b0:51b:f857:cf82 with SMTP id
 d75a77b69052e-52b5669e087mr211377211cf.8.1785769105241; 
 Mon, 03 Aug 2026 07:58:25 -0700 (PDT)
X-Received: by 2002:a05:622a:230a:b0:51b:f857:cf82 with SMTP id
 d75a77b69052e-52b5669e087mr211376671cf.8.1785769104774; 
 Mon, 03 Aug 2026 07:58:24 -0700 (PDT)
Received: from [192.168.69.212] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fd456a5a4sm34213084f8f.20.2026.08.03.07.58.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Aug 2026 07:58:24 -0700 (PDT)
Message-ID: <ed657fe4-c944-4d72-badb-59219e8c100c@oss.qualcomm.com>
Date: Mon, 3 Aug 2026 16:58:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/11] tcg/optimize: Handle revbit{32,64}
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: anjo@rev.ng, qemu-arm@nongnu.org, git@xen0n.name, 17746591750@163.com,
 maobibo@loongson.cn, lixianglai@loongson.cn, philmd@mailo.com
References: <20260731000503.170446-1-richard.henderson@linaro.org>
 <20260731000503.170446-9-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260731000503.170446-9-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: gB0FivHeM_DZhur0ECdAqA5Rh3UhjtJM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDEzNCBTYWx0ZWRfX/iuSYldGr6Lj
 mAlMdoMmFFU3Dav1tGBN8/MyR2OgYgV91/drFN+WGTrHcL4QI8NhrrRXI9khaDiB+w5SYVQWDvY
 i7fYUqtE2dQBqaAdlgjLD6t8zmahN64Ab2isocW7GdlBWV9EsruNFC9HashiKAcNodvrWL+xspk
 GTPuxP5RMjghfNENG3i/bT5GgecVgnQ6EuiLFGu+MO+UR5fLXcSSNSgr4iBUaV89DKWQK7Opo5h
 T/tPTWrxsisV/xY2ps/7QCb/gyirl91V8LbiTxPi2PqmoWhAUIPWZy4U5OWOlIyVJz5eeTTcsnl
 J7Wk7e2LvllPyCCxqeaMJLxb0M7uaMDpUKoXROEunm6pNMCbdObWVSAtGqdUzpC7IM+3ne3Gv6b
 IiOuCJhOwpTYeiq8EkYz7pKKRQdockT4XXHcfyXB7zVtkyB96twq3eTqFu6bIQ0R5XTCpzLuXGe
 qZa/mlJwYHgDjX89A2A==
X-Proofpoint-ORIG-GUID: gB0FivHeM_DZhur0ECdAqA5Rh3UhjtJM
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDEzNCBTYWx0ZWRfX5bT5qnEN6PbJ
 2E4L4TYiXhJWUmSmG5Es9I/dCtqdLjHaRE8PBv4On0yPVmbvmm1cI0ys2uIWLYndQBgQj4LCZ0t
 iuLPcFJgYYgrRui5YQBhCi4DXrkooew=
X-Authority-Analysis: v=2.4 cv=UIjt2ify c=1 sm=1 tr=0 ts=6a70ac92 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-03_03,2026-08-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0
 impostorscore=0 bulkscore=0 adultscore=0 spamscore=0 suspectscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608030134
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

On 31/7/26 02:05, Richard Henderson wrote:
> These are nearly identical to bswap, so reuse fold_bswap.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/optimize.c | 48 +++++++++++++++++++++++++-----------------------
>   1 file changed, 25 insertions(+), 23 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

