Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A6FEC55182
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2026 15:06:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wquFV-00045i-Rl; Mon, 03 Aug 2026 11:06:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wquFR-00043y-5f
 for qemu-devel@nongnu.org; Mon, 03 Aug 2026 11:06:37 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wquFP-0001fr-8E
 for qemu-devel@nongnu.org; Mon, 03 Aug 2026 11:06:36 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 673EC1Yh827288
 for <qemu-devel@nongnu.org>; Mon, 3 Aug 2026 15:06:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 rjs4nIMP7iizxXk9Gi6peg8/Qe9o1jtjeDFmwLowbhI=; b=J4Bde9wwgqJFy2eI
 s/dMr4zLsHBmQjFi9xiVw+vSNebfRt/+mBGXeqLBCi2sI92/j2YVoEcn4mOIQg3I
 rG2iOAbLp6GADks5aWZMNJ5MQf1Q3NDdHXtIZnvyztmHV6114Fm6TW2kwK7yyceC
 pIgCayOAyyvy7Br/QNO8Ihwq3RUiGl2PdUavpm9c9JzsqupBsh9v4cbdP7nJST/8
 DjzgCzXQGAsXj+O7sj7sRiVtoK14Or5vnExjrLC1pVR7qpOuRcIQG5y8p8GQd1W6
 zARGGL9VVFTJ9hVZVCsbZuNHmC/Jm5hwzhRwyChhATCILGduQFWvERXPjU7dRxdy
 heC7fg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ftnhkj7kv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 03 Aug 2026 15:06:33 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-51c1d137a68so4857731cf.3
 for <qemu-devel@nongnu.org>; Mon, 03 Aug 2026 08:06:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785769593; x=1786374393; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=rjs4nIMP7iizxXk9Gi6peg8/Qe9o1jtjeDFmwLowbhI=;
 b=RWLmFOGbKEAuJfg5c7kmkJexhAUaLp6Qo7GYROzCVEKppL+83+HXCHAe0IhNd1u++k
 2zgKxaGticgzFb2fTfxk/BA5GosxzgWR2HBp/95gKSmW6ku4Ij3i8bb91FuwjnxLLcN0
 gzkL459blcoazLVsHO0wIewqXAlyPt/4F3saMTMnAR25JMAGETx8W2+l/3cuB0RQvsOV
 eC6yI/iCvvpyeegtG/e2Lx1O1ST9/ls1j4kHuvSyfptFv0301i2CuQNA5DHZGGf27EaH
 SDzzk3+cZ3FK+JA95Er1kxFC7x/HGMzHgfStVKveOEz3BoOGWFisE2dOvgiPSyJ74MBB
 oTHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785769593; x=1786374393;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rjs4nIMP7iizxXk9Gi6peg8/Qe9o1jtjeDFmwLowbhI=;
 b=jvnyxY//6gJ7DiOknriSZuQt/5jlblgP3DlaUxETleN9VExCePFKEpohK9vlq7hWgI
 HypxpJ/WKRdVcpPsGthpjxLasQBrKQBmybPtApqz7OcZu3+qw/dNCBuUrtQO6dPcWDtx
 w9ZrSzO/QYOkFPgNCsSiFbiKrc7vpbnBnrhN5FvzgMIOKkdGW8l0CmqREGGzMsbW6RLI
 VlNUfs4Y8mka4MJwrG/YzNDHVXIw+Pw4my9mJiSZ7IF4fR3nfIhjNfTZkN0qQHbeLjyj
 NOU26/Fn+gBmOe2Fo0ygOKTgsjiT5OSDo4idNBmI40XOZwX8dVPX2OzNIswGYTN05o1t
 L2GQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RrIHLugXcdmODQlUAGScodgKn1OcPigusMuTROVGmKtUZG3znC2rZvmyNoy5AAKkuHM24ZIwzXMZCTo@nongnu.org
X-Gm-Message-State: AOJu0YzIPYnlX5vfYsAhdNJuS7WcqljCtZVCSjpVmA5jdrp1lEqaCqzR
 cZmxyjuvNXfzliEv96O8jN6z1ezC1R6HJgt4Wd1wFg3gpe1s9+HdIJjSwwJFR37qLW2ak30eB8t
 TizStJ3BCzU77jaCWRX6PF1G7j0+fSJo/vTBws9SIQ1J47fAiNMeRemPfNB9vfvLBoA==
X-Gm-Gg: AR+sD10HalhtepLHTWE+DyoVrpdgkKhUlzCKFazoSb+HSZH2NIiKE6E9l9XP1bpAsaw
 VNKXN2C+fluxHuyWteK10+uZxLgMvbDOfS62zmKJi+KbOqO88dwQkRvyHEasJafu7HpSgcl8k3k
 05+sJgxyCmu0/hhkbocZ5UGK+Ff1LH6QgsKRhjTiFeHpp4AIuTkIwYM0yELQYr1ognF0UMu3n4A
 yb2oo8S/KG36lxNoL8gE8/BXINn4YEQPCL99ABX58e3bYhjCo+bZlbKgtxBnYlHasSKXLpXdOVU
 ON327KV5XYugM5Umlfn6l7nNUrDneluZ4zcwBlhD9MFquGsp1VMuqLKY43l/4/mamWKPSsG6p1z
 4mj1SeeNMbcooHNa9TCeFfJOgTNQqHNdr45I=
X-Received: by 2002:ac8:5f4a:0:b0:517:9570:c1bd with SMTP id
 d75a77b69052e-52b5673f0f1mr193370461cf.25.1785769592853; 
 Mon, 03 Aug 2026 08:06:32 -0700 (PDT)
X-Received: by 2002:ac8:5f4a:0:b0:517:9570:c1bd with SMTP id
 d75a77b69052e-52b5673f0f1mr193369101cf.25.1785769592068; 
 Mon, 03 Aug 2026 08:06:32 -0700 (PDT)
Received: from [192.168.69.212] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4980869106csm304683795e9.9.2026.08.03.08.06.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Aug 2026 08:06:30 -0700 (PDT)
Message-ID: <4b5db4f0-bad1-48e0-bde6-f72ae4681f39@oss.qualcomm.com>
Date: Mon, 3 Aug 2026 17:06:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/11] tcg/loongarch64: Import REVBIT insns
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, git@xen0n.name,
 qemu-devel@nongnu.org
Cc: anjo@rev.ng, qemu-arm@nongnu.org, 17746591750@163.com, maobibo@loongson.cn,
 lixianglai@loongson.cn, philmd@mailo.com,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
References: <20260731000503.170446-1-richard.henderson@linaro.org>
 <20260731000503.170446-11-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260731000503.170446-11-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: O3IBUNJlXRhcH9BzgKqMF_WsLRgdS_Yw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDEzNSBTYWx0ZWRfX7t2VtoFWQpR7
 fDNyq1LjmQkSsCECOzFUIrtkSQJFWx3MpiBbfY5btc9CJO/p0/OOXUZNmVM0CgBw12VhW94LnY4
 SujecQyx7hj02Beio+RuJSguZGStQTwrSFTkLxfspHhjROc53GZImBzw2ojnDp+ENR3StIQ8av6
 PlmgHKgOgVPbDecar7s27JvDuNTtyIrULjaGNiUiYh1h/x0dzPTQhEDsHyIcjYhnJ++53QAtGwZ
 APFnaSJEFFL3BmwZfzmKQc8VRVy1FAqsXLqHgoRjE5DlFc6QMnC/+8IRRsW8Lu5I4hi2F1ulxSS
 lKVeeVOaXqGAE//ox16gesh94VZmHSjbxaR9GrlQSTjDSeICM9SMZd0BcSag+duYWZkX7rQXRM9
 Tcu4gpeoUQydKaC4L+CGAI38bAN44fkwBxb6lXGQi6nS2/TBCPnd+uNyL6xprBuvksegTyHZWPb
 95J6TyValalRiLBoGcQ==
X-Proofpoint-ORIG-GUID: O3IBUNJlXRhcH9BzgKqMF_WsLRgdS_Yw
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDEzNSBTYWx0ZWRfX+2I/H6QEqCz0
 MKXd0L4ewcgGV7cPsF22ZkVvgSBRPd5fp+OWt2AjO5OkU9pk7FLPgiAJpSeFL6koAsMIKH43t5p
 yBxckAYQyGyZRJYVRkTTCIPpr214Toc=
X-Authority-Analysis: v=2.4 cv=UIjt2ify c=1 sm=1 tr=0 ts=6a70ae79 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=NEAV23lmAAAA:8 a=KKAkSRfTAAAA:8 a=Q8D8so8t8yqNAXCl7-8A:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-03_03,2026-08-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0
 impostorscore=0 bulkscore=0 adultscore=0 spamscore=0 suspectscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608030135
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

Hi Richard,

On 31/7/26 02:05, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/loongarch64/tcg-insn-defs.c.inc | 944 ++++++++++++++--------------
>   1 file changed, 487 insertions(+), 457 deletions(-)
> 
> diff --git a/tcg/loongarch64/tcg-insn-defs.c.inc b/tcg/loongarch64/tcg-insn-defs.c.inc
> index 6bb8656fd8..c308b770ef 100644
> --- a/tcg/loongarch64/tcg-insn-defs.c.inc
> +++ b/tcg/loongarch64/tcg-insn-defs.c.inc
> @@ -4,7 +4,7 @@
>    *
>    * This file is auto-generated by genqemutcgdefs from
>    * https://github.com/loongson-community/loongarch-opcodes,
> - * from commit 7f353fb69bd99ce6edfad7ad63948c4bb526f0bf.
> + * from commit 40ea52087699392ad911387b666541891d33da31.

I couldn't find it then noticed your
https://github.com/loongson-community/loongarch-opcodes/pull/10,
so pending it to be merged?

>    * DO NOT EDIT.
>    */
>   
> @@ -18,6 +18,8 @@ typedef enum {
>       OPC_REVB_2H = 0x00003000,
>       OPC_REVB_2W = 0x00003800,
>       OPC_REVB_D = 0x00003c00,
> +    OPC_REVBIT_W = 0x00005000,
> +    OPC_REVBIT_D = 0x00005400,
>       OPC_SEXT_H = 0x00005800,
>       OPC_SEXT_B = 0x00005c00,
>       OPC_ADD_W = 0x00100000,
> @@ -545,14 +547,14 @@ typedef enum {
>       OPC_XVLDI = 0x77e00000,
>   } LoongArchInsn;
>   
> -static int32_t __attribute__((unused))
> -encode_d_slot(LoongArchInsn opc, uint32_t d)
> +static int32_t __attribute__((unused)) encode_d_slot(LoongArchInsn opc,
> +                                                     uint32_t d)

What triggered this code churn? Could we commit before generating for
REVBIT opcodes?

>   {
>       return opc | d;
>   }

