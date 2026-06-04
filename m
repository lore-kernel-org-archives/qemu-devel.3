Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67B89CD6E74
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2026 10:30:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wV5LW-0005Xw-N9; Thu, 04 Jun 2026 06:30:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wV5LU-0005Oz-79
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 06:30:40 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wV5LS-0001Cs-Ey
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 06:30:39 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6548VVsv313682
 for <qemu-devel@nongnu.org>; Thu, 4 Jun 2026 10:30:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 rJ5GhClRxXOOsPIriWVFHhOpYV2R2uN6Wj1UleCX5a8=; b=Na6zpWDZJCMVx12v
 705aWkcR4vQE5+dpVedTfVhV0h8CqwiIAeX/Bq4GE5uyUcHaSGOIC/WRtDQ9JxRa
 94QXvER6RTigG038b+nSPSLevC+4ZMsgLVBUWKYujNffl8tfXoIWfri7i9QIcHFP
 ZDlt0FD6WzK5w0IfcPCRCUGan1PIhJxX35Kmq3PzkPwf2IX+WJu3h/1YQlHFw+tm
 Y9IjuANbkydpihAQt64Gs1UyNHzd7rqrpBIxgCPxz0QimK4eKh/WSEpqnAokYhhu
 xiR6NMDBryCnOCmV0vh452LCeP9WbvCylp1OPnHb/qS29rhun6WZNxFwfWBIBC6J
 xW6PLQ==
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ejy5v1wgr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 04 Jun 2026 10:30:37 +0000 (GMT)
Received: by mail-yw1-f199.google.com with SMTP id
 00721157ae682-7e9234db3bfso7028317b3.2
 for <qemu-devel@nongnu.org>; Thu, 04 Jun 2026 03:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780569037; x=1781173837; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rJ5GhClRxXOOsPIriWVFHhOpYV2R2uN6Wj1UleCX5a8=;
 b=SpQwfnn5T0z67cYj/d6Su7V1IGI7LKztGm88pASJ+IQ8YD3jOwAM5BkAhEP8twKTxQ
 CeW6nzJX1AWp5hxhY7Tl+yVCnzxyRfN8cxLO0G7yXvgmhVrfIP1Ate3qvqH+fvylyAjz
 Qf48yHZU+QUykSQ1I7i7RItVFGFnO2i6FELwmlhmZ7KChdlNhzcArrG3ljQgFRKEbHPS
 QteDv3cUxYfxKZvFx8W0jvp7+cRRmfAghkQni2+M3Og4Yx8H7J54xb/hDJG+xaUmo/Cb
 EhhWBveW6XIar/QeBU77SHww327l2IKqG7IcmGbY4lKvxfJF8MKf6j9EK1TjZG0xXQg8
 dZpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780569037; x=1781173837;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rJ5GhClRxXOOsPIriWVFHhOpYV2R2uN6Wj1UleCX5a8=;
 b=etfJMqPUUnL9ziA1G41jBzCWbuanDRgsfbkt6DpnLBiHzvCwZktLzT6UE6CcfWeg18
 icw1hTnpiyqrzH4ucWj6FV0qViAaeSOdA1V6Vn6eNiPKq35H2F2Qr67C9Lr/+wns1iI4
 4JPM4zG55kn04FP87Hqa48LDZxejInBAunYPG99CNVvVdHzy5B0Brksutn/vXM0hR79z
 jgYpKlZ6LdEwIXKOxU+G4WX93xZZO3cXpbVQdu5y3wZ1LFV+/8SOlH+NzPYsCytT/rg+
 +t5lGH7VD4N7/yKCy+94xJy+6ipyoInZaSpA+QA2Zmp+c0GmbSgSV1MvEjg2EwQ80ntW
 ZxFw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+TuYVJLnXfVdCILlBfWlEaUs1ex7C7zr/oSXwcS+FwBPJWQr8j+2GqEo95HF9kvsKe/xSdGSseCe2q@nongnu.org
X-Gm-Message-State: AOJu0YxMfNqaoJsQ4WLqG3RFrNnOGtzk1G0lZVuY4kif6KOjdVEVPjz3
 GF60Mrchj8wG3C9lCAQQ4QGLfrzWF1vcxRZ/zoMGY49XKY7n1yfHZUhgpm4kSwQ33NM9vcUv6nj
 FP1WnNxV/AnZeC6n8LBcnWz+WFItO5MQODxPm6nWultpmVfB9tuG72okL4g==
X-Gm-Gg: Acq92OH3qpjohAnoLdC32aN2/koqetva+eYjPEw9SHSQWZKr7KhLzjA1z6MmSi5fCCa
 2HgQp0pqcXNx3og8KBamlIEXEXZUbb8+V8LuuPRHw+izj/CCnMh2z28wukLQ8HjNuORyuqywCCY
 MSHAu/+9tX0yOuHwUKXaWzkB8z2niSBkC9rRmLH8APr0rXIaIKC4pkk+q5D29LcvaaZHpIrLRfx
 l3mOi+i6P9VThtU6VG0wg+/Qd4DkQoDiMj66rgvssNsCaASwX6kgMGSIOJ9e1HOSo1whP5QETh7
 yEw32+gPuZfcPg2lr9+WbG6xeE4vCIeqO3bugq6+qxfM9lUlFWpPnWRRz7AReT5mwEIj7iyjc3i
 nchpy2RNsyHap5Nw3bDcFjE8PU1uKV+eBu3lh/ue1irETl+YCsDw53VfCm5IqW+etyFoa
X-Received: by 2002:a05:690c:6ac9:b0:7ba:f3a2:551d with SMTP id
 00721157ae682-7ea4a2575f5mr62455067b3.15.1780569036771; 
 Thu, 04 Jun 2026 03:30:36 -0700 (PDT)
X-Received: by 2002:a05:690c:6ac9:b0:7ba:f3a2:551d with SMTP id
 00721157ae682-7ea4a2575f5mr62454777b3.15.1780569036358; 
 Thu, 04 Jun 2026 03:30:36 -0700 (PDT)
Received: from [192.168.68.106] ([177.170.117.62])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-7ea215825dfsm31443437b3.15.2026.06.04.03.30.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 04 Jun 2026 03:30:35 -0700 (PDT)
Message-ID: <50b16245-dcfa-4574-9a50-c5e0819562bb@oss.qualcomm.com>
Date: Thu, 4 Jun 2026 07:30:29 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 08/25] target/riscv/debug: Fix icount privilege
 matching icount_enabled() test
To: Nicholas Piggin <npiggin@gmail.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, bin.meng@windriver.com,
 vivahavey@gmail.com, Alvin Chang <alvinga@andestech.com>,
 Yu-Ming Chang <yumin686@andestech.com>, Joel Stanley <joel@jms.id.au>
References: <20260114044701.1173347-1-npiggin@gmail.com>
 <20260114044701.1173347-9-npiggin@gmail.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260114044701.1173347-9-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA0MDEwMSBTYWx0ZWRfXydryIcXxHn3P
 14+Hybr9Vw/OGSOtH2NOgKQWJDBQjMNKJqpOyD9wIEJh012ak54WeV20Vat2CEi3Ra2mS5Yv9WI
 L3NPzL2W2dFUJoEM+myq6t5Q+aLe4IBQ40jLJDCFJvFvgRjhfqb02aTsx8jfo9rg+t+RH2Eb91F
 2xH2nPWGMWNYuOTurW/Jzqrr5pcpoCAku3l1TuduZ0mrfImSuBoOSqZpp2vNrD27YZl04TU84TR
 a9s3Yi6EcOi7hD4caeMAKXVLuvYrsecqg50t+27tvNTlacWzjxiHcuTy/mI09XPW19JFVnIdNYk
 taLdnF9ZA1ymuuTeX9Gsrpdfr+xfteyS1T/ZMBFgHsaUwb0S4wl58/34b7qk9Qsv78X1f1yu1KX
 96giQQ9Pta6gRZc8jA7HDEtGBU/jG7hhwB9WTicp2fYMyeHJLk1/3BU3eqEV0+qCE9Fl36dsnYD
 +QDy/UpN3Ooq//HE1pw==
X-Proofpoint-ORIG-GUID: G1GA3ccKq4UgQ4HMm7-JEKouEjO71oBn
X-Authority-Analysis: v=2.4 cv=afRRWxot c=1 sm=1 tr=0 ts=6a2153cd cx=c_pps
 a=72HoHk1woDtn7btP4rdmlg==:117 a=gdiugJE53z4H+vvYeRBHqw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=aLERe-55eW_5Fbas3b4A:9 a=QEXdDO2ut3YA:10
 a=kA6IBgd4cpdPkAWqgNAz:22
X-Proofpoint-GUID: G1GA3ccKq4UgQ4HMm7-JEKouEjO71oBn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-04_03,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 impostorscore=0 suspectscore=0 spamscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606040101
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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



On 1/14/2026 1:46 AM, Nicholas Piggin wrote:
> itrigger_enabled should be set if the privilege does match. The test is
> inverted.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

>   target/riscv/debug.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/riscv/debug.c b/target/riscv/debug.c
> index af9c4e37cd..ecedffd3b9 100644
> --- a/target/riscv/debug.c
> +++ b/target/riscv/debug.c
> @@ -679,7 +679,7 @@ bool riscv_itrigger_enabled(CPURISCVState *env)
>           if (get_trigger_type(env, i) != TRIGGER_TYPE_INST_CNT) {
>               continue;
>           }
> -        if (check_itrigger_priv(env, i)) {
> +        if (!check_itrigger_priv(env, i)) {
>               continue;
>           }
>           count = itrigger_get_count(env, i);


