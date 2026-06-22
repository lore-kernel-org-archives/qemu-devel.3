Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03B1DCDB46F
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2026 21:04:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wblou-0007gd-Ub; Mon, 22 Jun 2026 17:04:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wblot-0007fu-J9
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 17:04:39 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wblos-0001XR-1Z
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 17:04:39 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65MJZj493222608
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 21:04:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 bdBIkxvWyQO7nbRkTY889s3ea5h9o01MdgpuzxBPRNQ=; b=cgBbO5ud33WFN7Pf
 KhG4hI0PDhI4uONm/kDuAIZevWxWGNobii4+Y57tewFDHxijNq+qPdnYFl96k4qv
 VB/C6OcVrtGxH12SvRY6WXA3U9G266WAXiAJGDTh5iXuoMeuaIvcpgW6dfWadzQp
 glLjGBxkUdtDDm9eQlj6cxMezFsN+ftkaA7YyPBJ7c1vCC8AUvaKPzHJ+3+KNtOg
 CZZOZAW5BQwkckSeYO6VhoEe/NPSEbBMVJXxtmy2MOa+CIAJyRJHviJyvgDI2rcj
 NGGlGHHHFL+OCYkA88TCSIaV2PyyuYxxnbD0uZtZaLrWMv+gcsk9PEAMkLyT30K2
 57DXGA==
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com
 [209.85.222.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ey5sn1phk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 21:04:35 +0000 (GMT)
Received: by mail-ua1-f72.google.com with SMTP id
 a1e0cc1a2514c-9673c274512so125733241.1
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 14:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782162275; x=1782767075; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bdBIkxvWyQO7nbRkTY889s3ea5h9o01MdgpuzxBPRNQ=;
 b=brZTzsRGAB2otJfB9C1i/huoT0PtLIcdom3hU4VIo2qykdBm6vP1+rLS5l3IRiGFCr
 7wWDS+sM1WRDvcgkBJ0wKcX/+ThmWmMWJ6aK8fRf+Xo1pgnG2lRH9BkG6+bmxt+/GMrG
 0Na4jzjgGp/13Rfgs34QPIoZ1RJLbrNYslQIAz8OUW38qOTCPFQjPW54OPG7am4IE/7z
 deWcvloGJUeFBE3e1W4sQq+EUEzk4YMp0gUx454QsWE898Q3ADaYrYQATZHX/DoOS0N8
 PDRebEkO4xFpmayMB+dTxNhcM+o855RLDOrLTkhiZUnm7rGKXhF7vrr9rwaapoG09woB
 ul4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782162275; x=1782767075;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bdBIkxvWyQO7nbRkTY889s3ea5h9o01MdgpuzxBPRNQ=;
 b=NB/bHK7YozaLFzYwpwniG/sZRUUaEAz8gKKL42iwRZMPEmWag3m3NSyACDLuUXZg/4
 UYxqqAc/M8KmvHbRi7j+bEyiyd/204Xb/ktpL9O+panDIJEWKmx9BicbHigU0dkfOZXS
 LOaOYpdEiIvryy//3sxvotDuNxcR86NXLHeN9jEPWGSRMZXeiyUJ0EUXOnfVaNc52dYP
 GU+QRiqjcgn/5gazNxs9bARg58NK1sSMVfIxUlVUvcH6XJxzHAyNTgshTje9KLUgyoWL
 RDGgqofd5sg0GK9fEtd+MqfGlr8jYVCMKOBzFingxUmqM0Wj4cuv9306F4eJztgSdT6Y
 Z/0A==
X-Forwarded-Encrypted: i=1;
 AFNElJ84lNvKwcgZo1iCD5MmR8zuaKqAWVuKxJ+/M5bxT29fwr/45ZecvifxoMqmNLM44mGbJ+7cX+8ODqHZ@nongnu.org
X-Gm-Message-State: AOJu0YyHzub5NDPe/YYTT64fM7MAweCPhcl1HiFxHn7Q8zRy0N4zDNwd
 HOv1/LL31U9NDywmxL1AAoThf33yV3KfQM2nFfO51ue+iM+zySd1feBXqRq8oHOHyrwDIFCbM8z
 4MN8mHZJJ6y7Ir3T60f9haKGWBQK+YnvK0bzdt2AqzH88TPz0Pfa8kHrvDw==
X-Gm-Gg: AfdE7clJ1nQJ32Zh8PbbOZVbtGzRz1+JWzNXwJQZeXwWV5jLW/XjnxKoI+l9TmCC2L8
 0lCSwyZXHYT05kay7zcFr/vO4shtbve9t7FHOxgb7B7llacOO4WHaF+sdInHEMbZfm0bZfW5f5b
 ZOyEwKwCsl7ejU+YpHmAlJ5NPy2iZkgB+f2gt6w2jAKhXrIYg0XxA64rlAH9j24o5+EfkwqxHFg
 G3O786lGFLYa75Wk7k15BFT3xBl9UnxRbkNkEJfExouGUwbJSjmk0gapTJIaicBbjmQEY82YMpb
 Y/7xJAV3rSdEtFqXgLP589RriV80Rk2L3VqHCBvKzBEPwEJWN4tgBZM6CNxF9Lc7Jaat2Wxg8KE
 T30EzBaYKrBe4kqdtrkqp9qT3SgVKGRF1REesC5cnIJmdhFApndwV0Kcz6GAOIA==
X-Received: by 2002:a05:6102:e13:b0:607:95f4:53b5 with SMTP id
 ada2fe7eead31-72a767f4f7amr9197475137.4.1782162274969; 
 Mon, 22 Jun 2026 14:04:34 -0700 (PDT)
X-Received: by 2002:a05:6102:e13:b0:607:95f4:53b5 with SMTP id
 ada2fe7eead31-72a767f4f7amr9197460137.4.1782162274588; 
 Mon, 22 Jun 2026 14:04:34 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49245a69f81sm295821275e9.1.2026.06.22.14.04.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Jun 2026 14:04:33 -0700 (PDT)
Message-ID: <c6428872-6fe1-4961-a6a0-5df6714f939b@oss.qualcomm.com>
Date: Mon, 22 Jun 2026 23:04:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/24] target/riscv: move riscv_cpu_set_nmi() to tcg-cpu.c
Content-Language: en-US
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 pierrick.bouvier@oss.qualcomm.com, Palmer Dabbelt <palmer@dabbelt.com>
References: <20260622193141.1449724-1-daniel.barboza@oss.qualcomm.com>
 <20260622193141.1449724-12-daniel.barboza@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260622193141.1449724-12-daniel.barboza@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: GI8GrW5fFuWVbbg8OimXwtjwJal6Antl
X-Proofpoint-ORIG-GUID: GI8GrW5fFuWVbbg8OimXwtjwJal6Antl
X-Authority-Analysis: v=2.4 cv=PuKjqQM3 c=1 sm=1 tr=0 ts=6a39a363 cx=c_pps
 a=ULNsgckmlI/WJG3HAyAuOQ==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=kIJCwnWd_ba_kY1MPIQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=1WsBpfsz9X-RYQiigVTh:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIyMDIwNCBTYWx0ZWRfXwjssh0EPTiS6
 /z+fQ6xGqcNfQTGRhqCJWXrs9u3mNV01BxOfKbEVXqBboooZBIpsdU5rzzgoQVHawvdsgYv4vKi
 vJxFd1y0vbj6G3JeJvQ7evNbm/Ihz58=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIyMDIwNCBTYWx0ZWRfX87xKgeydoA0D
 mr76AmTne0PXM2WJHCPddMkQcxiSy0O6awliiK8ikdeffigAjeAvDIpVRk2fdBtpwnRboMoRzMD
 iN4F94KiPGjoEnIqkaBxkNzl7WnnMl99QB8And/6q8038g6zQWDlVG/sKzkctuclDf4YDAF6R0j
 wGNKvPH9TNeTS1SjBHuBML3cC2md9m+ZAi295wJJW2b42NbogPZ2JgHQrEYpvWoxfZAn2SYssHh
 7kyNC1Ej66OGN56agQ63M/sU0cq9M4P/KGUv8JOdERc7GFhrUSEVg+WN0Glt71M+8HLUzgVpHBM
 fOPEhwQeOgp1YmJE+ZmdrK/7lDJ/eJxeXeqj2VKIcQZw1eo8COAehg3Ios5+P3QKQ3ba9ZAgjA1
 veff/73UgIKl+kMS9sHYpgIdDcvzxBrFWCWfnSPZL+ONCysau/O3ABWZX5PiUK8KAiziWRxhmFC
 E3MNdXBxNosUQdF9pjQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-22_04,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 priorityscore=1501 phishscore=0 impostorscore=0
 adultscore=0 clxscore=1015 bulkscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606220204
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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

On 22/6/26 21:31, Daniel Henrique Barboza wrote:
> This function is related to Smrnmi and non-masked interrupts, firing up
> interrupts via env->rnmip from riscv_cpu_local_irq_pending().
> 
> This is all TCG only code.
> 
> Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
> ---
>   target/riscv/cpu.c         | 8 --------
>   target/riscv/tcg/tcg-cpu.c | 7 +++++++
>   2 files changed, 7 insertions(+), 8 deletions(-)


> diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
> index fef66557c2..0d0a704179 100644
> --- a/target/riscv/tcg/tcg-cpu.c
> +++ b/target/riscv/tcg/tcg-cpu.c
> @@ -1662,6 +1662,11 @@ static void riscv_register_custom_csrs(RISCVCPU *cpu, const RISCVCSR *csr_list)
>           }
>       }
>   }
> +
> +static void riscv_cpu_set_nmi(void *opaque, int irq, int level)
> +{
> +    riscv_cpu_set_rnmi(RISCV_CPU(opaque), irq, level);

Preferably inlining riscv_cpu_set_rnmi() here:

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

> +}
>   #endif


