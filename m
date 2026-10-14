Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9F2DC3DA7A
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 19:49:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xH4y2-00034i-2J; Wed, 14 Oct 2026 15:48:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xH4xy-00034B-Pv
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 15:48:46 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xH4xx-00028p-7a
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 15:48:46 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69EEbJtE152402
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 19:48:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 WQbdwG9clrs8tVl5sL9kYpxlHwsanB+AdSCFTb59EQA=; b=V33nrtvwAsWU206E
 C2xUdWyq4YUQlDWG+IpOOIuNFnVTqGrvjJcK/IM7aa3qaX9xqBonU4HCjZQ1QIJ7
 2Q1q0e4EraspmtSxKmiQbgx91Ou5C07IxHnlrW3tZvmPoH0FjF5KNG/PfMVwqUsD
 ALswKOw+OabahQRigOU7BXckR3g0lwjVoNZqrilas9w2KiEcFVjfELg+cu1s+yj7
 WZHFA6KSmZjRQbqKYeNZH0tL9tR2KvqZWgGQlfrrXGY2RcjP7BwufJ+HY2kKuDwi
 5aEw8578JI2bg9IhM0+XJCCFOB9riWGDMlovZZSusbdsXSBbNRi3Um9o1tRUvmsT
 A5DyTg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ha7aejd08-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 19:48:42 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93e46c120dfso101852985a.1
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 12:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792007322; x=1792612122; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=WQbdwG9clrs8tVl5sL9kYpxlHwsanB+AdSCFTb59EQA=;
 b=K9lcWEvf1aW8mxyHLTi9AHjuVA7QCfL6E5IaBAW2KhUnmIZHYx2mLWAwZNrKt2BHLR
 5X/yHXUTPl5Hfar7tRWIvaQztkvgI1sBz7X5ej7IiI2In6hvGW0UkqBKIeGcYcgEx92L
 iEgiYAyZ/EyT2droTZb1sWO78AlDQoEKldSN0SCKqLjsCakbNCSPpT0pKUNSaUtzTEDW
 L/R9paVI21BnhcL4MOyVG3baO0c62gLXJC5o6p+fj1TaaOsKt68JtIX6v35gdoWk7XKg
 MzgwCJTqvqsVdJE3DHto9ntD1lURnk2TTXvfnNgv7dz80dZxcCiYMOOn6BzrmLoWer4S
 fKqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792007322; x=1792612122;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=WQbdwG9clrs8tVl5sL9kYpxlHwsanB+AdSCFTb59EQA=;
 b=bG48otEom97ptNFllMDUvlUjdY9KT1OIbQkJfvyRhLcYZs99Cpx7WlSg5vcu1PnWPe
 ibru/B5FjxEOvC2dGDaVvuXHcEvBzIy7I4dG8Ur6S0D9s3ZFARqCNU8NztA/fZK0zweN
 hF5PedUnUDAvEAk+aJI9w+ipxTtcqe5439jCFrPCyJh+jfxW4UMWw78PxgyoYBXDaq7/
 m8UCBcXUzdXKVfvd2KwWF2QpDAjlT14UoZ/BtpXpg9sIuOIJ2jgdy49gyNxSNEtvyGoU
 EtybzZOP7eTfFv3UDqMgYYSAsE/7Lu+KXo/bhtn/UFPIYs741oh6ng3CaEOnCju3o1H2
 EpEw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzFVmBY/BbrYs9odbr2FikMiaX2uf363xm03K8LIjY2Xc6kKzO5FSvxLJUOxtjGTkzzgHgq0isqkMXu@nongnu.org
X-Gm-Message-State: AFq9FYKBDJ3aQecccYzREG1aj/YV5yIF3HGx8VhXlfN5PK/dpla2AUm2
 n1gBf6WvWpaFyEwExYhsckiOyN6ihD49KEogxbrI5V7G/SouhHS4EZb+Lb5SfsLMLyAqSnvl4YB
 EGiLQTUGbyJBw2SpvmaD3ecMKZXLlYII5khjEz5sYvGzvPMXBVPjSGl1SXQ==
X-Gm-Gg: AYBFou0yQ7MLBJafUARYrVaPniRq/lidjFih1GTG5qyZ6u5y0h7IvX7c/Rr8KYKaK9r
 UqFH+YPYlDpv++ojHc9pFU5r37MIIft9gcbg+nDTXaMO3HsBVDGzjFs2pTC5FIEdhHO7EzY4Ss3
 P/ntNTejqP/hjR4TaREoSPbTU79rlDp7i4rWAmKtTRH18s3fahP5QnMJMgq2mI//geMXYJqEWx3
 JzHUiiyiCZq59/a5FZymC7xJ6MUdZ0pMgQJKwNvJPth3n9dPNDrhmsSgQGuBCUnRgigRLTjjJ3H
 x0rw3XExYX4TUIibnNNL9wbtlMQbN7ImoqPQYUqr4nUrnpz9sXuM7mqUNiEYLuPdQuWUqyc4esR
 NlNVvMJKG1IWMludUulZ3vxh5A3mNJhlnig==
X-Received: by 2002:a05:620a:470b:b0:93b:c6ec:7825 with SMTP id
 af79cd13be357-93ebd269c7dmr2457694585a.47.1792007321717; 
 Wed, 14 Oct 2026 12:48:41 -0700 (PDT)
X-Received: by 2002:a05:620a:470b:b0:93b:c6ec:7825 with SMTP id
 af79cd13be357-93ebd269c7dmr2457690585a.47.1792007321218; 
 Wed, 14 Oct 2026 12:48:41 -0700 (PDT)
Received: from [192.168.69.210] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48de0ab4edfsm14762213f8f.26.2026.10.14.12.48.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Oct 2026 12:48:40 -0700 (PDT)
Message-ID: <108e9660-5d09-4e92-9d36-1a64dfb1f918@oss.qualcomm.com>
Date: Wed, 14 Oct 2026 21:48:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/11] semihosting: use new semihosting ops
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Anton Johansson <anjo@rev.ng>
References: <20261014182543.135965-1-pierrick.bouvier@oss.qualcomm.com>
 <20261014182543.135965-10-pierrick.bouvier@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20261014182543.135965-10-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: yB5OzWkC3DJz5H1ya9anLahrJ7dmb0NX
X-Proofpoint-GUID: yB5OzWkC3DJz5H1ya9anLahrJ7dmb0NX
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA3OCBTYWx0ZWRfX+32+r/CjiC2d
 gsXm2Ih2nsODBCInVsZKODgcnM2sVOyZ9WOg5Os2eS/MBxCp4uTPwMhub6HdBpS+a30kXncONh2
 jkGcsSGW6dUq/cEa8fLbOkO0ppvKsos=
X-Authority-Analysis: v=2.4 cv=NctzRGD4 c=1 sm=1 tr=0 ts=6acfdc9a cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=LRjOfy7O1rgA8vNvEm0A:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA3OCBTYWx0ZWRfX5UZmELGeDgT7
 HQNKFnfBpgNQicY/1l0QXwmW1iJqKTgmUZgwfmnRZFbPHOBdMJezAfRDL5n73/grkxLSXL2fWlH
 DYARoySfiMPR1kfiWqUf+P5l8vzqxzBiGGYmGpkxQimpsFmMvzhFGhRrilEBcsVGl0x0jWW4Eyx
 skcN9NiZW1Vu/ANWE6IKBHiuX/bv6hqxIBuM/VdlcEZ1bWPrpOq1tU9OhT8tm7N5hMKOIsXET+x
 y6oU0l3eXpduMCkvV18Eo+hq4dQVsCrAZ/bpGuORQ+T6417uoaccYwD7Juw+f8eWl/t2ABidk7z
 c/e95/v++CCs1+/3ge1Q9SAw6Nc1BYs+/ZO1U16GeEJd7SbLJQjy0/Sh80JZiqpWE8oePte1IH/
 rydBMyK5LcKtaRfdBQqh7fbosENNUtNWCmVUtqpyPOAezzFf0aWSQIVMU27tcV0SxSscynVPezF
 jFUSwZTX9v4VBNmfP6g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 suspectscore=0 lowpriorityscore=0
 spamscore=0 phishscore=0 impostorscore=0 bulkscore=0 malwarescore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610140078
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

On 14/10/26 20:25, Pierrick Bouvier wrote:
> Now that all targets implement this interface, we can replace function
> calls with the new interface.
> 
> Reviewed-by: Brian Cain <brian.cain@oss.qualcomm.com>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---
>   semihosting/arm-compat-semi.c | 56 +++++++++++++++++------------------
>   1 file changed, 28 insertions(+), 28 deletions(-)
> 
> diff --git a/semihosting/arm-compat-semi.c b/semihosting/arm-compat-semi.c
> index b930a028649..3117eadb3b7 100644
> --- a/semihosting/arm-compat-semi.c
> +++ b/semihosting/arm-compat-semi.c
> @@ -188,7 +188,7 @@ static LayoutInfo common_semi_find_bases(CPUState *cs)
>    */
>   
>   #define GET_ARG(n) do {                                 \
> -    if (is_64bit_semihosting(env)) {                    \
> +    if (cs->cc->semi_ops->is_64bit(cs)) {               \

No semi_ops / handler NULL deref checks, SEGV as implementation error
sounds OK but might deserve a comment in the commit description.

