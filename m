Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 202E8C61DD3
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 21:39:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1WBk-000403-SL; Tue, 01 Sep 2026 17:38:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1x1WBi-0003z5-R9
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 17:38:38 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1x1WBc-0000La-Gu
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 17:38:38 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 681KTFYw2468829
 for <qemu-devel@nongnu.org>; Tue, 1 Sep 2026 21:38:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 6g0FXPehmA2uZ7Cl9iBL3LorYruePKAfwhgPzwb2Wfg=; b=OPEug+Q5hspp9IEm
 UFM8ZvlQA1hfl+7XqIvfc/7Id8ebdsFAotcXLg0mWsfHtLePX3tEahEaT59J3ldE
 rY5XK9CXqO/nc9C4dF0OxYCfq4B4tfsYv0qFTTVz7ynTLkTlNOzcgYvTMlJYmFZb
 4SWEY1lay+esXOF8tRV/JUoTK3Gzj6jSlQ5aJWeoooAjTDAt9OEm07s4yjUeSCoW
 9lzjvOoqZKIbvRu2AA54mGllFSNeW0WwJGIjrwORKFsCIcZ/lUKynTXCyVIBA7TC
 A5lbxOtYBCBLZLEx+W00twxiC8EKKDjA30DyUhuVjPw3nrf1Gv39EUGZZW1qtG+o
 srB6UQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ge39cgwu9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 21:38:30 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-52fbe82671dso5423621cf.2
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 14:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788298710; x=1788903510; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=6g0FXPehmA2uZ7Cl9iBL3LorYruePKAfwhgPzwb2Wfg=;
 b=cm6UoenY+pp0DsyAwbztjORbMUZpVEUzqBU9dcUWnPTZmZdFQBCxAp8rd/kiR+1qQz
 ZB9N+bxa20tGcO9x+i7eH73LDw58Icxn9Q3zeWVDs0F3xgV2NQQYpYjOJP4Ns1b4C5TA
 T8rBANgO0z7m9aM0oQHRH37mZ7R4wulfuAlytinm6NBy/BZIBZpQbuWiTYPinRhKo8ON
 nRyd2pjqiwenXEdEByElCqHzBiLS+7gcP5rg1umQxZsnTfivHiP9kcYaYXrpiLf6rRUq
 N8O9FxjXqH4mdydEWx2T6Nwe7E22ZrmykUgBYrwio+MNjCE+FtJ9/Xjrv5MAXrpv4TRZ
 nZXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788298710; x=1788903510;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6g0FXPehmA2uZ7Cl9iBL3LorYruePKAfwhgPzwb2Wfg=;
 b=WhADCLQO7m3s16xlt/86JM/ieqbhNCm4OhNHqFfeZnykUnYoeC2LJ5LrdYoiAYSq4S
 TmFVY82ZtQ4YTiUReqgjHG5y5Do0x4HwVy2Rr8f4B/E2qsiAjbff2YxSmqf1Nb9JAN0w
 WrXVlCb1oqBVVAEe06+DeVko51qEhBtPSqHt2DtUTPWyhnVtKouYBLERMHRbD/WVEprh
 IgHyBKxlSKzuvm9bcvYCGICAo4RrmnfYBzMFuqu9BvbQRF4D074JZwJAa4vZc+0zkJs+
 WQZXqODhLIMG0HEF8th87iy1ebbRrxnXYEmQFbjjN2MckJ7fBtSANX/M3XO6fPy/zf8u
 EV0Q==
X-Forwarded-Encrypted: i=1;
 AHgh+RrABfkXdFT7XEsNBWteOw5l781sP+VozcA93UuVnUT5pgt+d6QGkl6Ler1asIJay1cO0OhDyGaL+fqt@nongnu.org
X-Gm-Message-State: AFuF++kKgqpMY11r8Vdf3N7pEHZbyu1zbLxo+GOJCWknOrdrYv0JYdZc
 TkS0ww+T8i1XN9plqonO8vkc1lxMmmIlrkEnAAn0PtbQ/mWSy564+Fcov0GYFB/RAnTG3m/+qN2
 ytJQ5ajlTnAzAfxUx2hahTl3+yzB4+lhfTjeHturqpiWMmTunIjNyaWUpnw==
X-Gm-Gg: AR+sD11WHiUVeCHMFYjhFb5OdZRdH0WDaaNyBhJQhltbcVgBdtJdGzh3TtiYEBOCq4O
 koWmu6fCMFJ9jty+tb2cZNVCrbRhG9NKbIs+mSkXctUuGqj87whOKmjWpa+WKq9ecJ9sK1XKr/h
 3A1yUVGD0CTEB37MMsaUqoetrfhAZWPoKYJQevKLwspdZ9HJ+3gEVpaUpFmGZsdOFlh7DEYxKGU
 wMI2RWcallrmg2cvnKnBNPtIrKz4Li0/aiTgKJDWgX4QnMpVtf+zJFGlwxSQME1EEZET1jBUxxX
 YN5n1dWHrod9DfZ3rnk86hQxOPSqB8vGsa//ufXfsHOBoI72Wunq6XnVOXD3mSfE12EW4qFwhbL
 be9yS1T0FAxZAykjdnD5EAkPy7bIjjzsRj010
X-Received: by 2002:ac8:5cd1:0:b0:528:3471:937f with SMTP id
 d75a77b69052e-53021ce5310mr159380291cf.29.1788298709699; 
 Tue, 01 Sep 2026 14:38:29 -0700 (PDT)
X-Received: by 2002:ac8:5cd1:0:b0:528:3471:937f with SMTP id
 d75a77b69052e-53021ce5310mr159379551cf.29.1788298709164; 
 Tue, 01 Sep 2026 14:38:29 -0700 (PDT)
Received: from [192.168.68.101] ([152.250.131.13])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-90e9ee260b6sm3472566d6.14.2026.09.01.14.38.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Sep 2026 14:38:28 -0700 (PDT)
Message-ID: <3f97f88c-9c49-49fd-9990-86dbca2c3404@oss.qualcomm.com>
Date: Tue, 1 Sep 2026 18:38:26 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] target/riscv: add helper_tlb_flush_page()
To: Trevor Gamblin <tgamblin@baylibre.com>, qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>, qemu-riscv@nongnu.org
References: <20260831-riscv_tlb_page_flush-v1-0-4fc6af95673a@baylibre.com>
 <20260831-riscv_tlb_page_flush-v1-2-4fc6af95673a@baylibre.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260831-riscv_tlb_page_flush-v1-2-4fc6af95673a@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=T968ifKQ c=1 sm=1 tr=0 ts=6a9745d6 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=CXdxNCAnTuDr1kYd6DjE4g==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=IpJZQVW2AAAA:8 a=0vUcrW1TMMbxpHMFu-UA:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-ORIG-GUID: gc8lag7DiZU_tJThTzCjg0ukRmNtLZBF
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAxMDE4OSBTYWx0ZWRfXwMxhR18OY0Vm
 OJGvJod/f9mt2NLNS+cRTvfBxj58Q8LjqahZulxyM+tEM/rbUuLUmyzO+yxonodt2K0F3Jzt3WI
 qDRo4pFN/hEiUR2G4LBZj61uwRVrGxY=
X-Proofpoint-GUID: gc8lag7DiZU_tJThTzCjg0ukRmNtLZBF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAxMDE4OSBTYWx0ZWRfXwNA22bKTyBgS
 M7xisSVveYEIyaD4PopJgzNZ9X1ltn1Acnsoc9M2cBFblpCwVXpwxwhtYZJGYuYOqClg4a1lNGo
 vZyBFPVF90qjwQmV+epKXk1HrjpBujapqoCA2zttR47ocXqkuKWbE2vRNxfKA90WC94JPNA+3f3
 zxpiaCvvft2psQuEKhhbcCDeuvUIYkBEki39IwCkGK+RZ/uJRVduoiZc8heSdqcxBqsJf8/v0aS
 Y2cz1iFFiPj8EC2Mfpot5vnnxWZXWreUiFxduC7Tu6h8Ft66+uCsIw5tOs54lq9L/vhW1FJlP5N
 cmPQI6IpiNBzKB2tTWStTzoceNbwTaxVOqeZgeeBP2JjesAdPzTSbEjeJhYqjrhp051ljeOlCnt
 rZ0xVSd5mAr2738Rc+GzPhGBzgGY8k1x7U3CtNkEomM+cV3nu8w2/pREhuffS9IsJbIEkecHPAB
 LP/OC0PNz16gwyW3ibw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-01_06,2026-09-01_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 clxscore=1015 phishscore=0 priorityscore=1501
 impostorscore=0 bulkscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609010189
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



On 8/31/2026 3:59 PM, Trevor Gamblin wrote:
> Add a page-level counterpart to helper_tlb_flush(), and condition its
> internal call to tlb_flush_page() on return value from the new
> sfence_vma_allowed() function.
> 
> Signed-off-by: Trevor Gamblin <tgamblin@baylibre.com>
> ---

I believe this code should be squashed into patch 3 where there's an
actual caller for helper_tlb_flush_page.

Also ...

>   target/riscv/helper.h        | 1 +
>   target/riscv/tcg/op_helper.c | 7 +++++++
>   2 files changed, 8 insertions(+)
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
> diff --git a/target/riscv/tcg/op_helper.c b/target/riscv/tcg/op_helper.c
> index 8039df2b48..723a45d181 100644
> --- a/target/riscv/tcg/op_helper.c
> +++ b/target/riscv/tcg/op_helper.c
> @@ -610,6 +610,13 @@ void helper_tlb_flush(CPURISCVState *env)
>       }
>   }
>   
> +void helper_tlb_flush_page(CPURISCVState *env, target_ulong addr)
> +{
> +    if (sfence_vma_allowed(env, GETPC())) {
> +        tlb_flush_page(env_cpu(env), addr);
> +    }
> +}
> +

Following my suggestion in patch 1 this would turn into something like:


void helper_tlb_flush_page(CPURISCVState *env, target_ulong addr)
{
     check_sfence_vma(env, GETPC());
     tlb_flush_page(env_cpu(env), addr);
}


Thanks,
Daniel


>   void helper_tlb_flush_all(CPURISCVState *env)
>   {
>       CPUState *cs = env_cpu(env);
> 


