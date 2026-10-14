Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C24ACC6B1A
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 04:30:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGqdB-0001S5-II; Wed, 14 Oct 2026 00:30:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xGqd9-0001Rk-Th
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 00:30:20 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xGqd8-0006Eh-7b
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 00:30:19 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69E1074P2874347
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 04:30:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 nHpIV+ICZWmJiCNxXoDFV82xBdrGAj93nmDgD64kUTc=; b=ZFd6JGzAUsbY1kRr
 0rx4kEU+SUgdCJF7e/zLWHaR831ybvsfqPgnvatKw++BjmsqHGeDMjv0FnW0O9CG
 ROxb8ip83aX+BRtyKE2txcI27HfIH5zMFAJP+84ZtD7IJx0TE1IChawdwJJHe4k6
 7h8T6EWLhisNNqLp05Mk+36Z14ik/VnDj6h88I7tOEJxehyVJLQVVk/LRM5/gXKW
 nahGPIDoYz3msvjwL1yC8TpOJgSVyF7XwXvzDiO9AdrjXvy4JQQp3waNuiY42/ef
 45a/ugS3RXqe1ra5YDMKE4VAWcrtwGLFPl8F8OwCgByjiAkY+vfiank4HvAmJWua
 ZcqTSQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h9yphgpcg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 04:30:16 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-53522c265f1so84444451cf.1
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 21:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791952216; x=1792557016; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=nHpIV+ICZWmJiCNxXoDFV82xBdrGAj93nmDgD64kUTc=;
 b=admWoAMdnYRQT/zwRzjS1ESVzz7gNgFgmq0R+a9C/yTerKJSJh9512qrr+ve7HU7QN
 k2v2RAIxPxf8ieE66c1oHPv34zVTXqBMC0OLHbiSD1736cVWMhjZPlZ1ZHiV94kqxWgc
 28oeS3ggflfPldlUh3MAukLDJNkq73PqdDM3GLOr4+JgIiNDaNwdos3K5nrZmfR5Xz0n
 jaEl2PQhQW5GF96ee6EIWx1rGsT7vGVKG9BN6kQb05pTiBKWSuwwlVeS3pRdrayDAQk6
 mEXEpiFnndn/+jht33aoM6QCg3zFr95hym5GVb0gmR7XatB6RSkuYtNNrmBFY1X+2vSZ
 P8Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791952216; x=1792557016;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=nHpIV+ICZWmJiCNxXoDFV82xBdrGAj93nmDgD64kUTc=;
 b=QEUrgQKswtk2JvR04u8ce0b7zX+As5zDnTaUXmwCmXoAPxjPRHF37AgbdztTIIKxPv
 k5Iq6OKA1H0B3QJJg/5VcsbeL3CqlAKVlRlfjf5izdnXAqCSuCYI+W1pXtm0OFW4CRnZ
 zdvy/mdzjkOfoZQiNyIpAwPTdTrehwMrVxfcIw4XBGRAH2H0wxOrbzgMa9DvDgYiYqSY
 MFreYpQV9XFS64s17CgLI6Z/xAc7S+x5fbqao24ir4uHL6m6ATz0cQJmMJWbixMXZH6G
 gwwSmo2UQbbRCH/YCa/rzzlw3YhYlCOAx9vhbm8Oa5GR4fKb9y1QvTGefi/YN3WYTZVu
 NHFg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxkBWAgzhIQGLakWePEyOVHDyavo3KWWstX6jqVaT3N1Bu+GnX0qCmhxdRA2aNKfr2f6ZMAah6/wc5o@nongnu.org
X-Gm-Message-State: AFq9FYKZLVCctBKNJ+HCSBpD0OLUrC3dz7ZXrVDmzqrIega7/+S4oMgN
 NF84yl+NdxHtF4EwKm3LcIStglWRO0fxn9C+b30eQxjisqDXHVeBksDjUhg0lxRgFM06vr6U1e6
 TGiR/hNGfKl0Ilga37qr+RDZvghqbzP3rFEbqn66NnlIdjg36jF1SAQiUqQ==
X-Gm-Gg: AYBFou1AEWAqKn2bdqIRtl+m+HXpljBuWVzjQe3o4VH1pbLFTXszSU/9iF+4/sJVzDJ
 tqhVluLBvO3KR8QpK0HBfmz8VFh8zZqwXRpQSSv0HPOdKSIX3qduOvGBJihQ8j0HhCNgJlkyfLO
 6sAg/e8PXcYKzrbaJO/7unzp5o2rP02xbjh8Ia+qaK7G6XsV1zycL57Qnp2SsAvlizYbqa2XuJR
 NxA4E4pTQWbkCbhCdFUdD1jBanWBAH8mlLCaOulyt3xfec/gNKIyDIkzTeCqwSG/Hpee5fOjtqQ
 E2ue7nhvxWjzfAcMuXFwmbRrijEMgsDjctbaPawhStUwAicWeocEg8zzRwGrTivSrXKTpEY8WLp
 8gEkTYWeqRZnQROUD673kXP5vH5RimLyOFLaJSZ2eCb/+O106w03aGHc4HeJ8iLU9veNOALeFKc
 QUe78=
X-Received: by 2002:a05:622a:4a8e:b0:535:157b:ea22 with SMTP id
 d75a77b69052e-5359fb0c002mr241093031cf.40.1791952215709; 
 Tue, 13 Oct 2026 21:30:15 -0700 (PDT)
X-Received: by 2002:a05:622a:4a8e:b0:535:157b:ea22 with SMTP id
 d75a77b69052e-5359fb0c002mr241092681cf.40.1791952215096; 
 Tue, 13 Oct 2026 21:30:15 -0700 (PDT)
Received: from [192.168.1.199] (104-54-226-75.lightspeed.austtx.sbcglobal.net.
 [104.54.226.75]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-5359b7a34b5sm116346401cf.22.2026.10.13.21.30.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Oct 2026 21:30:14 -0700 (PDT)
Message-ID: <32a717a4-97da-4ad7-921f-9124447d38db@oss.qualcomm.com>
Date: Tue, 13 Oct 2026 23:30:12 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/11] semihosting: declare semihosting cpu ops
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
References: <20261009225226.10657-1-pierrick.bouvier@oss.qualcomm.com>
 <20261009225226.10657-6-pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <20261009225226.10657-6-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: YYDWxLFPBJYuI_suPagBEpc8WU7qeamF
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDAxNyBTYWx0ZWRfXyQUnHA7HP1Sz
 OMvpU41qbuYkXSsqFPfK2wJ+vi0pg1s3NXvS4MCaLFiiYYlVdubJaFGlSK6eGAlJr1xcxXHiaM+
 vmcsmqcXVyZ2zTXc/UjOcT07vbeOd+g=
X-Proofpoint-ORIG-GUID: YYDWxLFPBJYuI_suPagBEpc8WU7qeamF
X-Authority-Analysis: v=2.4 cv=Uv72pOwB c=1 sm=1 tr=0 ts=6acf0558 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=x6rl1zRT+JsLSO7OGbGBKQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=p-yNHxhON5qUDS1X5zwA:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDAxNyBTYWx0ZWRfX2kBN+3EIYP+9
 NHCiYokTVgLtZsJq6XHDa/dDLQeC8/nIVwPoL88fqhINL4dwZAiI/gmU8pgiHYVCrm7KS2j7szx
 YKpNLP6DLKYs6nfJfQVLrQlSZdXgWIXRBD4tZypuAxdFc7QohRLltLCbHaTK+JxfUHFMz6Gw7wj
 dRCd4x4c+1KcUz7PAI2+8HaInlgRgrvgbFBfNhW71sCgmePogIlx+7Qn47Lb7c9cdiiLBbVlSbo
 3gCWbZJ6qB6LRXQ+mR/ZkQb1NPIYvWwki93pnTWG+ZThaaKIoXY+n+3knD+LjndOhzUPxkobFQP
 sbHU22jLn9Vdy32PzyYFP7ja4qKQbS3jlKK9d0oVESNH+zRbORYPj7S6HuSBD3tfXPYk4/yffqI
 ebmxX3aPnDi0EIf2JsY++pTNm9Ui54465PFij+3Ar/E4EYbeEPedRNPS/1t5XWPNFVFx6hizPHT
 4H4uiq9z9tL8nRC/s2Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 clxscore=1015 priorityscore=1501
 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0 bulkscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610140017
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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


On 10/9/2026 5:52 PM, Pierrick Bouvier wrote:
> This allows a specific target to declare its implementation of
> semihosting.
>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---

Reviewed-by: Brian Cain <brian.cain@oss.qualcomm.com>


>   include/hw/core/cpu.h             |  6 ++++++
>   include/semihosting/common-semi.h | 17 +++++++++++++++++
>   2 files changed, 23 insertions(+)
>
> diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
> index 8160a301978..8432c66906d 100644
> --- a/include/hw/core/cpu.h
> +++ b/include/hw/core/cpu.h
> @@ -98,6 +98,9 @@ struct AccelCPUClass;
>   /* see sysemu-cpu-ops.h */
>   struct SysemuCPUOps;
>   
> +/* see semihosting/common-semi.h */
> +struct SemihostingCPUOps;
> +
>   /**
>    * CPUClass:
>    * @class_by_name: Callback to map -cpu command line model name to an
> @@ -186,6 +189,9 @@ struct CPUClass {
>   #ifdef CONFIG_TCG
>       /* when TCG is not available, this pointer is NULL */
>       const TCGCPUOps *tcg_ops;
> +
> +    /* when target does not implement semihosting, this pointer is NULL */
> +    const struct SemihostingCPUOps *semi_ops;
>   #endif
>   
>       /*
> diff --git a/include/semihosting/common-semi.h b/include/semihosting/common-semi.h
> index 1e7699d7bbd..618f60f76e7 100644
> --- a/include/semihosting/common-semi.h
> +++ b/include/semihosting/common-semi.h
> @@ -34,6 +34,23 @@
>   #ifndef COMMON_SEMI_H
>   #define COMMON_SEMI_H
>   
> +typedef struct SemihostingCPUOps {
> +    /* Return argument @argno */
> +    uint64_t (*arg)(CPUState *cs, int argno);
> +    /* Set return value for semihosting call */
> +    void (*set_ret)(CPUState *cs, uint64_t ret);
> +    /* Set an error for a semihosting call */
> +    void (*set_err)(CPUState *cs, int err);
> +    /* True if the guest is using the 64-bit semihosting ABI */
> +    bool (*is_64bit)(CPUState *cs);
> +    /* True if SYS_EXIT takes an extended parameter block */
> +    bool (*sys_exit_is_extended)(CPUState *cs);
> +    /* Return lowest address until which stack can grow */
> +    uint64_t (*stack_bottom)(CPUState *cs);
> +    /* True if SYS_SYNCCACHE is implemented */
> +    bool (*has_synccache)(CPUState *cs);
> +} SemihostingCPUOps;
> +
>   void common_semi_cb(CPUState *cs, uint64_t ret, int err);
>   void do_common_semihosting(CPUState *cs);
>   uint64_t common_semi_arg(CPUState *cs, int argno);

