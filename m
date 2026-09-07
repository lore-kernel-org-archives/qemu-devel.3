Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3979C79F89
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2026 13:05:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3Z2h-0001lM-Ec; Mon, 07 Sep 2026 09:05:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1x3Z2e-0001kF-I6
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 09:05:44 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1x3Z2a-0005RX-E2
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 09:05:44 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 687AmwC5809960
 for <qemu-devel@nongnu.org>; Mon, 7 Sep 2026 13:05:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 lYFuWWqEBNNs8njpHwWbu1oMjcq+GBsXxgiGa2Pg4Ig=; b=UVZ6hAGNDc9EFsH0
 /TJox7iyxYgwiEHGpZB/hQ9MekknJHQJkYwSMwaxtoT169i+SuddfMcIb2ZXZ4Lh
 24Hth3CfYAG/Hdg3nqRIkEAgLHY697mHAwImJS4RXOKN8XL3QRuK+Maj7U5n2XT9
 m02rj9ek08snk2cpl9j+LHdh0HbBxf6W3fqfQsWb1MaTQUK5cT0yRCXH36+vjxRG
 OHi9uvUy0QIGpEhPfFqTUWd6apffW/kWE/W0udiyqhU0r5zQynuE5/uswHUM6O6k
 cu9mlinIvILg4RGl46SDUtJj3MozWAh5HtjKGlZJIT/jrtYvVtBTXeOYG+66Fkei
 A2xa4Q==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ghrua9gd7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 07 Sep 2026 13:05:37 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93903982af1so789938885a.3
 for <qemu-devel@nongnu.org>; Mon, 07 Sep 2026 06:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788786337; x=1789391137; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=lYFuWWqEBNNs8njpHwWbu1oMjcq+GBsXxgiGa2Pg4Ig=;
 b=RnGUqS4Z0zh9BPOpwSbgMuvMf7z/X5u5RGoei7XUMmtSH/04jW0TXRnRCHv/prXIGo
 TzbEoVjTXrw3gB7qsiSJM8O8YyigaDF8evrzr2OsnhT38VVJUs5U3uqQBoQAd65F0/Da
 YGHpOa+3nYDQTeyKLn1h/JMITbF9hv3mh2mdOpUORf75tqHDwxArG+D5naVBi5qqM79n
 2C2G6DAglnb+RfxY+LTb9mRJCW5gX4k3InPWMzUZeCbBrbL+LElcN54XNLt9HIhhmD1Y
 hkaoyEyuHRVUdAJyUXReUy+wseCGzWnzuJy6sCHekdqgFIF5TG6RDNUbxREqJ1FNHn5T
 Cmcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788786337; x=1789391137;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=lYFuWWqEBNNs8njpHwWbu1oMjcq+GBsXxgiGa2Pg4Ig=;
 b=DqDe5o0OIb7jWNJH33p25scrSmsvfHsh+dArhlvscgY0aQkRlIFeUqiSJY8MUerdMW
 1CQrXeHYY+uyXvz9iVvbt8vrs5Uo1QBl38j+k/GYb1RW1fWKmqBPLXnC+3l64m/jso/c
 2xcR/QnKHVfe5UMAIzIClFc9Higqr2YGEME1+fAa39sYMzMHZ6KOOi2PH2ELAole9+Oj
 nQQiW7Jiznd8oSw71Rw1jZ7QdOcrlbHCDKVcgbjW2zT+sRS8fzuFMaNaFZZ4rrqdmOtH
 IPOQQTTEZTfK42oGMSrn6IydMSJq3ADS6uDxVd8IxdLbFYTZo5mWBrVdCMMQNuJHB+0A
 oN+g==
X-Forwarded-Encrypted: i=1;
 AKwUvBwDFnw4Ag6pbbVuw/E3TIiXQ2hPkErN9kZOhyI/6jDimYLG62yMNaBHUWYwwBypz69IUAEwrwu9lAvL@nongnu.org
X-Gm-Message-State: AFuF++mjv6Vkm4VNLjP3FzcwzyzuIR2gtnhvfoZ/iPhQQlLNcg855u4U
 Pv9FxsmguP36uWEdygItcs1uY49dWM2kP8yx76Fe1QtrT2idhINxBCnJlKVOy+qN4AQqYxhSV7o
 5VhRYwSpK1oHxwp2RseYFu5PZWwYSwPaqEN9N0pI5xNAE7UKoUXe0fhvnUQ==
X-Gm-Gg: AYBFou0ipoxq81PMHs/WurwijGgY5YVT/VPT7u7uJBETDuIyzVoWtY+L25px1zBb2b3
 S5nyeSDPUWNdbk5QYuCnRIiGQXTR6hIyxgLWmyL5tyhPCeKXLWLvvNyNA2HbW51e8xhyvwMr7Te
 73HsCXpsOBwHKsp+jq0tOyZLopiK3PLFm9csA2tRCK96FD763cHnC60kr7sN543xqocrS20C2xf
 xC+lcbbkul7GKGMpaQXrDLs2yy6HUCONFDuZ+BjrGZFwLlodd9jPSxCbpOeblcWjls3H5KhHTUy
 k3yfGxdCizYnh7HJGB87HudjNtJttCmGwSVF2EbVEUUMVRNv+TvRx5DXqUiRfrxAgBTAvyISIHv
 X9OV4f/pSMmTSbI8h4b80+bGcCyKkk9YvOrU=
X-Received: by 2002:a05:620a:84c1:b0:92e:bd39:9993 with SMTP id
 af79cd13be357-939806da323mr2172251485a.31.1788786336619; 
 Mon, 07 Sep 2026 06:05:36 -0700 (PDT)
X-Received: by 2002:a05:620a:84c1:b0:92e:bd39:9993 with SMTP id
 af79cd13be357-939806da323mr2172245585a.31.1788786336161; 
 Mon, 07 Sep 2026 06:05:36 -0700 (PDT)
Received: from [192.168.68.102] ([177.18.66.131])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9399cf10c7dsm455608585a.15.2026.09.07.06.05.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Sep 2026 06:05:35 -0700 (PDT)
Message-ID: <a3bb8a2a-3235-4d3c-bcc5-71168ed6d1b2@oss.qualcomm.com>
Date: Mon, 7 Sep 2026 10:05:32 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] target/riscv: add helper_tlb_flush_page(), use for
 sfence.vma with vaddr operand
To: Trevor Gamblin <tgamblin@baylibre.com>, qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>, qemu-riscv@nongnu.org
References: <20260904-riscv_tlb_page_flush-v2-0-defec3f29312@baylibre.com>
 <20260904-riscv_tlb_page_flush-v2-2-defec3f29312@baylibre.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260904-riscv_tlb_page_flush-v2-2-defec3f29312@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: zRYjc4XjuvQAFuauGggBgas1aEnC3dKI
X-Authority-Analysis: v=2.4 cv=U+aiy+ru c=1 sm=1 tr=0 ts=6a9eb6a1 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=CQQxcbsX5Byh3TlVSSGwig==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=IpJZQVW2AAAA:8 a=EUspDBNiAAAA:8 a=i3LG-wDX8qFR2bV6r9YA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-GUID: zRYjc4XjuvQAFuauGggBgas1aEnC3dKI
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA3MDE0NCBTYWx0ZWRfXzYYGVJ8jv6vx
 lMbsCa8kvfO5ReRfZvw9xLKHzSK7Dk/dhIonr7TlfyLXUw+J4Yr2FzI789JG18w/T5P5sGSAn3d
 dNLzOIuFyTYEA70P3ATLH7/Tlpf+Tt4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA3MDE0NCBTYWx0ZWRfX4LOD+20xcW7H
 rn6ASE9VyhttAPLaLu/yy9QEPeKVb2HFaajX30e1OyMqXA7r9nViHKmXWwWtlxbnO8V96asv3Qn
 6lNThGbXwmmTz3Lfb8g8SO9S0Bblxt8goCkt6fG1MZQXipvR8SoPH2b+4/MdgLZid8iP3o5pOpt
 KVpF8JsX3Gv5Ch1tQHIdU9tFRf8bEcVred7kTgzVRK0vzKPx2/9EtZwJhIT7p0TbAcQ2ylLXiYB
 JrGAlxap5aMzpc+gTHy8F1NKlBpdyW93mGX5YeQmmn1CERvfB9bJFxJ860ZGlH0t6azztdYmZVh
 sRqtBZ4MVcUVOv+c8E2pmWh42aU2gH47u+tT/3nE/lxzvAh7MosgfErklJBdaydxm79IuosnYN6
 wd520WIaJbxylBEC+yBDX+ynAzjYU/HJo72RUsA3phaEnCPMvEZSXIpCf464yXxLo9J5BbQAGrA
 vdDKd5++86HTJbrELow==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-07_03,2026-09-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 priorityscore=1501 lowpriorityscore=0
 clxscore=1015 impostorscore=0 adultscore=0 bulkscore=0 spamscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609070144
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 9/4/2026 3:43 PM, Trevor Gamblin wrote:
> sfence.vma unconditionally called helper_tlb_flush(), regardless of the
> rs1 (vaddr) and rs2 (asid) operands, forcing a page-table walk on the
> next access. Create a page-level counterpart to helper_tlb_flush()
> called helper_tlb_flush_page(), and use it whenever rs1 != 0, falling
> back to the existing full flush for rs1 == 0. This makes RISC-V
> behaviour more similar to ARM's equivalent (tlbi_aa64_vae1_write), which
> already does tlb_flush_page_by_mmuidx() instead of a full flush.
> 
> Pass get_address(ctx, a->rs1, 0) to gen_helper_tlb_flush_page() rather
> than get_gpr(), so that the address being passed matches the current
> addr_xl width regardless of '-cpu' input. Otherwise, the raw register
> value can carry garbage above that width and never match the address the
> TLB entry was actually filled under, so the flush silently misses and a
> stale mapping survives.
> 
> Signed-off-by: Trevor Gamblin <tgamblin@baylibre.com>
> ---

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>


>   target/riscv/helper.h                              | 1 +
>   target/riscv/tcg/insn_trans/trans_privileged.c.inc | 6 +++++-
>   target/riscv/tcg/op_helper.c                       | 6 ++++++
>   3 files changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/target/riscv/helper.h b/target/riscv/helper.h
> index 4fc2d3a155..652f85a5c7 100644
> --- a/target/riscv/helper.h
> +++ b/target/riscv/helper.h
> @@ -137,6 +137,7 @@ DEF_HELPER_1(ctr_clear, void, env)
>   DEF_HELPER_1(wfi, void, env)
>   DEF_HELPER_1(wrs_nto, void, env)
>   DEF_HELPER_1(tlb_flush, void, env)
> +DEF_HELPER_2(tlb_flush_page, void, env, tl)
>   DEF_HELPER_1(tlb_flush_all, void, env)
>   DEF_HELPER_4(ctr_add_entry, void, env, tl, tl, tl)
>   /* Native Debug */
> diff --git a/target/riscv/tcg/insn_trans/trans_privileged.c.inc b/target/riscv/tcg/insn_trans/trans_privileged.c.inc
> index a8eaccef67..8655fa332e 100644
> --- a/target/riscv/tcg/insn_trans/trans_privileged.c.inc
> +++ b/target/riscv/tcg/insn_trans/trans_privileged.c.inc
> @@ -155,7 +155,11 @@ static bool trans_sfence_vma(DisasContext *ctx, arg_sfence_vma *a)
>   {
>   #ifndef CONFIG_USER_ONLY
>       decode_save_opc(ctx, 0);
> -    gen_helper_tlb_flush(tcg_env);
> +    if (a->rs1 == 0) {
> +        gen_helper_tlb_flush(tcg_env);
> +    } else {
> +        gen_helper_tlb_flush_page(tcg_env, get_address(ctx, a->rs1, 0));
> +    }
>       return true;
>   #endif
>       return false;
> diff --git a/target/riscv/tcg/op_helper.c b/target/riscv/tcg/op_helper.c
> index 7f63f3ada5..178b4d271b 100644
> --- a/target/riscv/tcg/op_helper.c
> +++ b/target/riscv/tcg/op_helper.c
> @@ -607,6 +607,12 @@ void helper_tlb_flush(CPURISCVState *env)
>       tlb_flush(cs);
>   }
>   
> +void helper_tlb_flush_page(CPURISCVState *env, target_ulong addr)
> +{
> +    check_sfence_vma(env, GETPC());
> +    tlb_flush_page(env_cpu(env), addr);
> +}
> +
>   void helper_tlb_flush_all(CPURISCVState *env)
>   {
>       CPUState *cs = env_cpu(env);
> 


