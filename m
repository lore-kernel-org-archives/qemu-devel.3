Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D14EC61DD6
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 21:54:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1WQX-0006OU-LB; Tue, 01 Sep 2026 17:53:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1x1WQV-0006Nm-JL
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 17:53:55 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1x1WQT-0002oU-Py
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 17:53:55 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 681KUHaE2984470
 for <qemu-devel@nongnu.org>; Tue, 1 Sep 2026 21:53:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 KP0qegUkgSEw4edjzJT958f76RslNCL03yWxO6ZTYAM=; b=GmvUqbHLYTt2/VWT
 G5DWAadTJD0G1xGe4GY2VY0FG+c4ni262CCZNxFkH9iLIBkUBpWjml1oCY7jilUL
 0lUez1TpNOIIUX1KMj08DT6Q771bvDeb8ufnwiofYBKkvvs0ctBe6ddtp85AJPC8
 fu3CrvMSRn3oaA/Atmltjh1JL7g1nIMEJTirjBRiBviF1nTo6Lcb/RJjIxplvWrq
 GUXmyaFXdhVsN1bNdgTvYcaZn9f8t73wjGMTuQqz/YMiF/H6vomF5fyjOThxTCzx
 cHy6z6sSjw9gifV5o8q65O9fzmTKoJTg5BWtVKpgBYrsjhTvpTc3u1Ln4MpdOUnG
 f/N1aw==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ge35k11g5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 21:53:50 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-52ff59f2c47so8860351cf.1
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 14:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788299630; x=1788904430; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=KP0qegUkgSEw4edjzJT958f76RslNCL03yWxO6ZTYAM=;
 b=QqKZAHXKir76sy0D98GOrGMozmEjWgrns+Op0jKVHTmw8gouGB8Qp5aY+zAyR162QU
 M379xvK2jnpI+dlhpQxhJq49ZW0/qtUC+ACTElFyQy5/sJxCvuxBfguXXyhe7pPhUqAr
 5aik8tsqM6uNQM1UjkCbNQiBWP9C9CbmRodxrfUBFkes6gcVrHPhnbO8qQacErSrSsX/
 xsUIDCss3I1VbhrW78Kv5QePVAtM5bcs/hdzHlK5RoHpplwv27XR6kQf1ngW8OLy5tGL
 pFAtmvtOS03gX7PLIM6LP4qe7kkWS1qAzsi/RaslGWObTeePslWXoums3RSmXxQ+uX3f
 b1hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788299630; x=1788904430;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=KP0qegUkgSEw4edjzJT958f76RslNCL03yWxO6ZTYAM=;
 b=cK9zaEEDC0QLLZrMS3V0TpRLzsahefskkNvJcPay24T8iciT3m4CCzSuH/MRqkuyb9
 eLBNPOfTNdITuUNnGu+OGHN4T4tpK+ZXnx8lcY5FpWtHzupAiI+f9BVHQFF2s8aTtT/J
 wdxMwjLTJdeZ6RTaRyd1mebfpp0JBgMx/w1Oj/Ce6ANj6hLOMLx+vZoFm93yQzn+I5Qb
 MXu9IO+cKZVHq00c3dQMGPClNket4h5KjyLIZABnMoYn0eCb+daFHHjxEzvdRjkpyKyq
 4dxw/5Knyub8abdvKxjduxnkAbmZOBaI7QxtsINgd/dG0CrBM1vKeOay/qXUbL1yFuUx
 tz1w==
X-Forwarded-Encrypted: i=1;
 AHgh+RqbKGQBe74kuHtjmeg9dmQGwV90DGl9Z57nmnNyDB5jvOqSmRIUJuLkqsko4V+ZkxaHkeRKQS+VcTXA@nongnu.org
X-Gm-Message-State: AFuF++lwqi3Hwz5M1B6MANsASZ2CiLBM7H1t4Q9OMlFciirGgVcV6Hm2
 Dol96CXOX/WPudVF2fg18OUQZZYSE0hKduDXl45SNxUJWHg0csueEZvzwkvbPA6WltMKxSKypv6
 AUtNGHFpSy0d1e8pbgLTVOIu+qitvYQRh1aNRMVs9N/qW0X6n4iOphZbkYQ==
X-Gm-Gg: AR+sD12uunEXM20L27pIFXDpoCfetWTh+CV0ODTgua8RkpnhzrKKK/zWNw08QxhLdHQ
 GMObh6YPCaTCl8HoOi5N/kdi6fKr3ZNw4zibJj9KsHiQ/yqTnT2ixiv1GzgLmKslhmP6hp7fSFx
 1HDtFdJ3RROMsENU6huBqWYpEY0SVrmBAJdsLBQRZ+PsHccvCR70uHtAvpMrRamUsXWMjM/Xach
 O37JvjkTzf+jB6ibD+fNOhS33p4Xy9+Z6zCowbfjI6RagVT0Xj8BUXqphzue03cA0WuS36p20uI
 zX+1bpv+54s8I3mYCJzAZ5tvVtz90zO0qLrc8tSlDToX73GIVGxDYkzpnNa4teTClRMjqmZ60X7
 6jvhnexHa1X+rQqbykF7rzeWlCh3WzArMHLdx
X-Received: by 2002:a05:622a:156:b0:52d:6f91:86e with SMTP id
 d75a77b69052e-530253c4c2fmr111086911cf.15.1788299629999; 
 Tue, 01 Sep 2026 14:53:49 -0700 (PDT)
X-Received: by 2002:a05:622a:156:b0:52d:6f91:86e with SMTP id
 d75a77b69052e-530253c4c2fmr111086331cf.15.1788299629549; 
 Tue, 01 Sep 2026 14:53:49 -0700 (PDT)
Received: from [192.168.68.101] ([152.250.131.13])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-90e9ef0e9b1sm3509186d6.43.2026.09.01.14.53.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Sep 2026 14:53:48 -0700 (PDT)
Message-ID: <b8ab3fbd-cf37-499b-8efa-26df5fd01fd9@oss.qualcomm.com>
Date: Tue, 1 Sep 2026 18:53:46 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] target/riscv: use a targeted TLB page flush for
 sfence.vma with a vaddr operand
To: Trevor Gamblin <tgamblin@baylibre.com>, qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>, qemu-riscv@nongnu.org
References: <20260831-riscv_tlb_page_flush-v1-0-4fc6af95673a@baylibre.com>
 <20260831-riscv_tlb_page_flush-v1-3-4fc6af95673a@baylibre.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260831-riscv_tlb_page_flush-v1-3-4fc6af95673a@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAxMDE5MiBTYWx0ZWRfX0WRfbpwQv6Kz
 rV34Zsaj9I40P/99C5a0BctbydvYs8ssMxIrulnOjfBs/lhervdD+E5DnxhaNH0GcSNLSxWG+Ug
 PFagap7oAcLDv+csIL0lbKwtnt8dHtrIES7Swh/vGTJoQVXOPL1H08DlUZhH3pcdwHNCmpLhX8L
 d53CkyiwF789AInbOcPvhLm6NsPmYaNRCs+R10aO+Jc7PxqBA2Y/F0qEip613oAzvkaagxR9CUg
 bl+w0SRFD0CN/qXyYRT3xveoqeoH0BzzMDvq6JwedcHSopqo/d2HQomhb/wBv81Go2hbiiubd1y
 XvBQa0hRSorqrs39vTsE+GmAfNKNiIBr4OyYaWNErYDsZchYZQXG1SOOc3YPqyaceHSAgtwg/5W
 txB8/Zqij6UYjHVfK3IrvZiR2pCSpQolgCr3NutxGiEvd7IoePL6QkNAUVB2M1p+5XJrTZmHBSA
 itcWBcbG2/iAonMJVUQ==
X-Proofpoint-GUID: 57asI8LlPcEU3p8Y4qK57ApcCOXjMrOd
X-Proofpoint-ORIG-GUID: 57asI8LlPcEU3p8Y4qK57ApcCOXjMrOd
X-Authority-Analysis: v=2.4 cv=VLrtWdPX c=1 sm=1 tr=0 ts=6a97496e cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=CXdxNCAnTuDr1kYd6DjE4g==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=IpJZQVW2AAAA:8 a=8Hkwp5nkjh_TlMOIT6UA:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAxMDE5MiBTYWx0ZWRfX2fR8GcF3wBG4
 C5Y0+reUdLEMgeBQV3iNnhGci5uK+FWQk4IlaModYWW3oFzTiOptLS2GXqK2A8F6V376ojeQ7S3
 CfAMeIo7eXeJEMEoSGisiIRjGaWCFJ0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-01_06,2026-09-01_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0
 malwarescore=0 adultscore=0 priorityscore=1501 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609010192
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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



On 8/31/2026 3:59 PM, Trevor Gamblin wrote:
> sfence.vma unconditionally called helper_tlb_flush(), regardless of the
> rs1 (vaddr) and rs2 (asid) operands, forcing a page-table walk on the
> next access. Use helper_tlb_flush_page() whenever rs1 != 0, falling back
> to the existing full flush for rs1 == 0. This makes RISC-V behaviour
> more similar to ARM's equivalent (tlbi_aa64_vae1_write), which already
> does tlb_flush_page_by_mmuidx() instead of a full flush.
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
>   target/riscv/tcg/insn_trans/trans_privileged.c.inc | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
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

As I said in patch 2 I believe patch 2 and 3 should be squashed.

LGTM otherwise.  That's a nice performance boost for a handful of lines.  If only
all optimizations were like that :)



Thanks,
Daniel

>       return true;
>   #endif
>       return false;
> 


