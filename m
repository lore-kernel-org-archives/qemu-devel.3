Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2D1CC79FA0
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2026 17:17:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3cxe-0006WQ-2U; Mon, 07 Sep 2026 13:16:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1x3cxd-0006WB-2Y
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 13:16:49 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1x3cxa-0000eC-Hu
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 13:16:48 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 687H7pkd512718
 for <qemu-devel@nongnu.org>; Mon, 7 Sep 2026 17:16:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 tKm8qvidRLofJCaGEY/WTB5mlFqgKYJApckUcam/ae0=; b=eYzu0a2JMQezAfE7
 Or6tbdd8IG3wpJ7wBC7RvDDZlETDtjxsa8bQizt0APSRmhuD5gtLN/FasxVeTjcd
 Ad32yix7nQssvcYLAahh5J9ydB7oCMufk3z/Ze07MXNyMir70CUZyP97iFk1NV+b
 pUvSOmESkpIICrEE2cVecmVDgw0ugAF0mOj6B3XE9wmpd117vXbizZayvS0Pa/6F
 XS4vqeT4byWRnAjqQvTjuJQ30f/oCPQVsUV61K8u+gKJyBwEo1Bu6a8Rgk6gFsmh
 zn0x6/FfpWR3xVpzIXfHrkFFHrrlIa986QcUBiW7a7728O6IQ2ddfowXsejERIr3
 7woqCw==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ghnmj310p-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 07 Sep 2026 17:16:44 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-53013dc2330so36291971cf.0
 for <qemu-devel@nongnu.org>; Mon, 07 Sep 2026 10:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788801404; x=1789406204; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=tKm8qvidRLofJCaGEY/WTB5mlFqgKYJApckUcam/ae0=;
 b=OyrGWMkuZyG0BlrZDjpB/OUbgVoFlZmC1RusSfDIIdin8MbidD/k1i/6Kn3pCgGJFd
 9fwJt+8jXAHB7lb5sfz1WqIdxn4h/ZsDsl5aIausVGIRK5/0cGEkPVfluX45oqcEBpOr
 6Yy5eolqGAyncdwccvakjfxFny/1GkpvgPpCkpEH1QU6XjsbD1LJL/AXJ2OY0yo0CmNU
 8aD/RmzUZgw2ndIcOMkUepZOCTeJwO5wugXlDGaHa5KJbdycWm1SBajl2d2oRQiRJmwb
 uPdQBxnORi+NbE59d7GRNtuVcv9KCNeeomMa6B6mlkA2iJyojHvn34hIBqWxU4FvqMdV
 FcpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788801404; x=1789406204;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=tKm8qvidRLofJCaGEY/WTB5mlFqgKYJApckUcam/ae0=;
 b=YjpGQITkRu34kz0mGW5t7badxII6g7HMTumsfPOPbdUFFBRh//Qnh/8npNEGPuKDSs
 HVqSGXSj/aYWEwQnpV2BsVi596wTyzz6i8DUI/GuQTugPCHs/F6uYI4qa+0jHTjYelKu
 xnVfOSo74/O+wFhgcHZLgc9vS1eJW6dCiyYzu6cPiV6LfEZl8XJUNf/2f4GfPvauW0bH
 ftvjuZRdLIasEcOokrlZIYjC0fZZTPM3HkKu2I1JC5hXNxXZVIO2p9FkwKRPujez4oko
 dPuT85LCW9ZGS7OucW9CAIqQUsi91C1t4iZwsqWH1g3Hvi5uV92u4AbKFDZfwMp/dRjo
 NLUw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwdmJop8SaNa/7qqit7k18aK3BCkJh5IQ+IUOUuCpggSS2apzlKYUzBamDDi1w55F3l2tSVoPsrLHTy@nongnu.org
X-Gm-Message-State: AFuF++kabDw5Xr0py+v1LZddnDZTBpqdDbxEkp9COjyxsCmWpSOB9SbS
 VnXToDf3OEdk+/BBDoW3leNZy1I4o6Q+/LLo2SGaSkJeJ6iyWzPY4CCQnepU2nHWG1K/coZKxP+
 fVgO4dSNDZp7Y1qKlIGoMx4+15xxGZ01x6d4BOgwY+70w8+FlIofMMh/geQ==
X-Gm-Gg: AYBFou35k+mHh9v/y6+ENtkOjJ0Fuswf8+zIqVvDfLYKnzVVeH8HKdId29dI25GoXzE
 fm95JC7CVYdzIo66NsrG7qZCrUDiG5AYcamWfm2Pb0QmyiQE/2POE19YSDYOpcUI4duSZV78Dho
 XPWaGTBHBqIo0pigWzqUyqabKR1ZY3DAk2yO3epb46nvgn8R9rdbAu/fnlSOKjFLTlCAWMNu5gt
 avzj1t2EOCSl5UK/uH7g8s0fCXSKbg0yGI6MxDSuw2Bj2Rpnh7F0VaN+2vC9YGMDXsLKirvhBz+
 tyQqwC2X+zr/NJ8P4fzIH9rvcm8SeBDkQ54sj552/Dw/1bRPqoOXukjY4m0BMY2tvs7zkXw95gV
 TeieEcfjsvf4g7RI7otr3X3cYOgV6S8p70NM=
X-Received: by 2002:a05:622a:2443:b0:530:256c:3718 with SMTP id
 d75a77b69052e-5305494a90cmr284506101cf.38.1788801403846; 
 Mon, 07 Sep 2026 10:16:43 -0700 (PDT)
X-Received: by 2002:a05:622a:2443:b0:530:256c:3718 with SMTP id
 d75a77b69052e-5305494a90cmr284505721cf.38.1788801403356; 
 Mon, 07 Sep 2026 10:16:43 -0700 (PDT)
Received: from [192.168.68.102] ([177.18.66.131])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-530868ceb68sm26893771cf.29.2026.09.07.10.16.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Sep 2026 10:16:42 -0700 (PDT)
Message-ID: <71b4b979-9d14-476b-90b9-918f4f50c2a0@oss.qualcomm.com>
Date: Mon, 7 Sep 2026 14:16:39 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] target/riscv: mask RV32 XTheadBb th.srri shift amount
To: wangyang <wangyang25@otcaix.iscas.ac.cn>, qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>, qemu-riscv@nongnu.org
References: <20260905093749.491-1-wangyang25@otcaix.iscas.ac.cn>
 <20260905093749.491-3-wangyang25@otcaix.iscas.ac.cn>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260905093749.491-3-wangyang25@otcaix.iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA3MDE5MiBTYWx0ZWRfX0jycD0TJ5fNl
 dQNcBtQLf3RQirTcwE7qFj2Jtv3iHYlRZXnqiCeHB/sCJnNTRiYhYPDjetQ53IySHQoDKlAYURL
 ulyEmHcjFHpeBioFQ1G5fSOniLBQstSaEFLea0uY1mSzjOMdv0foKmbICEt2N1n9PB6m9uGcRkF
 gnqTHBG0i/AZd6iFX454tlO4v0q9rIlz3Xv/YmknvCXW83kSpzzI89Q/o1D5Lz/PRARvDN8OqKL
 D/CKs+x5Tr6V10g3czs34w+DO3xi1t0Nmn/y7nFOnjL0RsUuGPTjOv+mrKuv9SdBXJqyvW34ZIp
 0W1GemnzlMFYhyWN49Mlfl3BSrk61sI4mlOyMIZWzcO0foBpoWIT+ttrnQAY9Av1ABoYLCjdPAm
 JLPryW7DkHGLauql702RHHdHPQfwQkcWQyj4CObmNEwrSaX4Eh1rMrF26ELZv9qjokH2f87k0l+
 SeUE3KpI6ZKoW826AXQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA3MDE5MiBTYWx0ZWRfX69+KhJN1aSs2
 3UkoDxlP6+mEb70V5wuv9nnZe9BxPslbpNBjK8E/9Xf8JzKtl9PQKS18l1P742F5fLg6lY/lCG9
 brDn5zFgQdwF9Ke54pVKLu280yHEyI8=
X-Proofpoint-ORIG-GUID: DTzAfu0VsjCPXa4zsCKDTn14mXA2Erxo
X-Proofpoint-GUID: DTzAfu0VsjCPXa4zsCKDTn14mXA2Erxo
X-Authority-Analysis: v=2.4 cv=LZYMLDfi c=1 sm=1 tr=0 ts=6a9ef17c cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=CQQxcbsX5Byh3TlVSSGwig==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=p0WdMEafAAAA:8 a=EUspDBNiAAAA:8 a=6hpQRmv5nqXfxsFbynUA:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-07_05,2026-09-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 malwarescore=0 suspectscore=0 impostorscore=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609070192
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



On 9/5/2026 6:37 AM, wangyang wrote:
> The XTheadBb th.srri instruction uses the low log2(XLEN) bits of
> imm6. The generic shift helper rejects values greater than or equal to
> XLEN, which incorrectly rejects imm6 values 32 through 63 on RV32.
> Normalize the operand before calling the helper.
> 
> Tested: RV32 imm6 0, 31, 32, and 63 witnesses with XTheadBb
> enabled and disabled.
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4413
> 
> Signed-off-by: wangyang <wangyang25@otcaix.iscas.ac.cn>
> ---

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

>   target/riscv/tcg/insn_trans/trans_xthead.c.inc | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/target/riscv/tcg/insn_trans/trans_xthead.c.inc b/target/riscv/tcg/insn_trans/trans_xthead.c.inc
> index 681f70e5bc..34226b1be5 100644
> --- a/target/riscv/tcg/insn_trans/trans_xthead.c.inc
> +++ b/target/riscv/tcg/insn_trans/trans_xthead.c.inc
> @@ -141,6 +141,7 @@ GEN_TRANS_TH_ADDSL(3)
>   static bool trans_th_srri(DisasContext *ctx, arg_th_srri * a)
>   {
>       REQUIRE_XTHEADBB(ctx);
> +    a->shamt &= get_olen(ctx) - 1;
>       return gen_shift_imm_fn_per_ol(ctx, a, EXT_NONE,
>                                      tcg_gen_rotri_tl, gen_roriw, NULL);
>   }


