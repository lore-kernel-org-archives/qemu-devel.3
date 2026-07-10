Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A246C44507
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 21:48:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiJ5O-0001ub-Fr; Fri, 10 Jul 2026 17:48:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wiJ5E-0001Xi-B7
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 17:48:34 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wiJ5C-0004ke-W7
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 17:48:32 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66AK3ong1648751
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 21:48:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 AuU1AxNQdEe12mck+iDZMnewEFFAahJNOb3wRaAvWmQ=; b=f5C7Vopu/p5cbCUb
 wnlSdnXgwUL0QIbfBAmwsCsLbmySsZWzyZJNysHdDRWET/p4a9tJUp1dRWPG+3mS
 NZkuXVIJ9IYIHlAwCmkmepmUFSAg0oVetsv9uMpkACuIvaVx4djIkI2XQEpDH/Pi
 dzS3dClzTnGR1DSZ1Z9bjuU3Y1vLXzVkE2IktOrTACMWDFkrCPJYiTg90W8Y2wT9
 SBx10s55xLxBE9tobssYPOrLphm87nHIos25pnaE+jVzatuOwVq4ZxHXvsIdYVWs
 iyE2u4bogNITS4I8zn10wypUms6CVJDDbLDeacYODRZHbEDdvhEZvDYzHJei83VD
 kH9GwA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fb2txhdew-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 21:48:28 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-51c1a9764f0so15469481cf.1
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 14:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783720107; x=1784324907; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=AuU1AxNQdEe12mck+iDZMnewEFFAahJNOb3wRaAvWmQ=;
 b=J69PdB9oIssd5HOuZWRdv1BuMJqZQF6uANEb9otcIZlv73usdBAJBKZq0hB+SBf4xl
 jDkeENb2yhJUPzaLOzBbSlk8tBZnsXyAwe9WOvMUgSvJPBj9ndIl0OS8PAmkBfuJrQmE
 6sOSz8/sQyMFB3T27hjZ5Eah1NBLiMc3K+IjvIV9lxadqykySRX8ryLeUkkIPdcGfxeU
 KVETUg6XOdpXrX+zPzZ8gHF/hK6n0FN9MZhFNpXL0nis0b6O/pKX5o9YY/AZrDbLWqIW
 7dD7SDjQsjk4T9HjANvYfuI1EqFhhutmIfQVzFD922jO1bGNypr4LCUrq+rxydPnUSPR
 aC7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783720107; x=1784324907;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=AuU1AxNQdEe12mck+iDZMnewEFFAahJNOb3wRaAvWmQ=;
 b=P84aOh6EHqqhJy7gt7qOnW2cJz1//0FuToaXI4AcJ5sMQzi5M+MgjeWQ/wDIQUbdIM
 AupeE/NsnUVBLLz8rs6N/k/NU1J5jHqnVR6JuAHAv/ZaXgmGXU+eKapCgPOpNnk85rLh
 Nw5v1UoM92c713yNZ0qmwej1Du1Bahd+JatJjpLsRj0RyWyi1NW2QCtzy3X5KF+RqePj
 1uAqP/V8HdW++GTKBuRpwYW53+M8WVfWnWcBtg03mLs2P/SYMbxIqF/neMNKF3OkjUw3
 l3DdzlPcgUKfiHFwesguxXZNfrRMk5p9HmEkoFYeXi17hf6+LsbG8aXy29d+rChFARn3
 B5Kw==
X-Forwarded-Encrypted: i=1;
 AHgh+RpVXQBXSaVnAVk2NX+96uXZSS8xl+WsoofkP7ANYQjfisHkLwYgMqicWLU37crQclV6/9q03gj8v2yb@nongnu.org
X-Gm-Message-State: AOJu0Yzm7X0LoW3yYQM19A0G8fGMP1glHGQyGbPE5j1AZ89XdDIcVl/g
 sMtBCdPswHmRc0zb3aznZJntzm72Him9URlWumFrcxgHqRsv5t+BR3yl823xNHuKFgAcjf2Rq/i
 8DUuH4tzz3Hg5Gv243SPTwJgdJ3kCXSFSj5XdFHsDrVCvg4ziQb7xlIwW3w==
X-Gm-Gg: AfdE7cnkgx1AiUc0beGHVYQ7WHAiPS9ZThU29SSeajprJ5tCt3hYQ5ZVHTURHdkRdby
 fyCv1QLUYwoKnTwF7D6a1qNL8DKaY729mR+i7X3zUl8l2T8+l75uGcJM3W5SgW9DbYEoh3Q6b97
 8YBz6FU1w0ld3859cnwvhRzxBtkex13X2cR4BCrPdKjO53wJn252qF7fGE7V4+kmtpKplQjFmwy
 3IeUZfhWud+jzmIvcjZQc0ZRlsCdevIB3gIhi7VCpnAs8UaDLQnMZVgZxdmn9lSZg1SQYdEDivf
 skMSrWMxTBTBTYWSr0xdk5orCUu5zhr6PZO0+A0EgNThKjQZxHtmD8Gp34ZXccktTgn4H5yUqaf
 /EBay9XVYUyjbpDA8H3ROpbBzk9Vb9qLXLNR0UpjLXRiIXuvYJi98Ch6s5QELuA==
X-Received: by 2002:a05:622a:1e0c:b0:517:8711:d466 with SMTP id
 d75a77b69052e-51cbf324541mr7304841cf.56.1783720102557; 
 Fri, 10 Jul 2026 14:48:22 -0700 (PDT)
X-Received: by 2002:a05:622a:1e0c:b0:517:8711:d466 with SMTP id
 d75a77b69052e-51cbf324541mr7304691cf.56.1783720102154; 
 Fri, 10 Jul 2026 14:48:22 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47aa0f21328sm64505445f8f.32.2026.07.10.14.48.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Jul 2026 14:48:21 -0700 (PDT)
Message-ID: <04ff0b28-bde6-40a4-8e9b-33227f18f5c0@oss.qualcomm.com>
Date: Fri, 10 Jul 2026 23:48:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 10/51] target/arm: Use bp argument in
 arm_debug_check_breakpoint
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-riscv@nongnu.org,
 qemu-s390x@nongnu.org, jcmvbkbc@gmail.com
References: <20260710205401.836304-1-richard.henderson@linaro.org>
 <20260710205401.836304-11-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260710205401.836304-11-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=ELM2FVZC c=1 sm=1 tr=0 ts=6a5168ac cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: x0Oj1xExwBLK2AvReN48-thYxtACloKn
X-Proofpoint-GUID: x0Oj1xExwBLK2AvReN48-thYxtACloKn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDIxOSBTYWx0ZWRfX5lIigcpDlpL0
 IwLJEJr74WxUQrkRPQ2USdU/6BSFAxPP5C4/Pk7h0FZnUWvQykXlsCeJNktCWCxTJ1a6Qnq3A6w
 mE2V/nax/2TSFyzHuoVjP/FO976HF0HJEoQwX/kUuGK9MAHrPGFoOSpJK9XcU6bhlH5SgH+NjHq
 rpVPPush+RvN5xsMQj/8ma7oOLNZgt5ygjEwhv8Qxg3Rus+CbJfBdfaLQmrTdcWCkHTM5wzuat3
 FVuGz8VyLKqjnA4nIY86JbvtvlRQX/Zp+1dU46hX0oQlhprUChnipJqnLee9OvvfKOX6B0+Dw0C
 jT40fLqP4K5N1kfAoJ8Od2XtRhD8vwmXAHaPzBTK2PD7e9C//DCE/zKT0c8cMDeBTkp8ugOtoWm
 VwSVtLrvijoRWLATNGJYPueZFbuMXLCj69VeayVLpQc10lFImonsVLH7+ex25tH4ZdTVAlXVGFZ
 Z80cyLKQ9iKqyves3zg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDIxOSBTYWx0ZWRfX3R9b/PluZpmR
 arEOaT6g9L0Kre2c1cN6aieL+rI7p4jEVsOS3u3bfP++wkGgSh4873x55f2U5lhVhTqrm3HQoxm
 7Ej0YfSZtuYXfQfUQ5dLlkW3ZaiTkuY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_06,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 bulkscore=0 impostorscore=0 priorityscore=1501
 spamscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100219
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

On 10/7/26 22:53, Richard Henderson wrote:
> Use the matched breakpoint instead of looping over all.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/tcg/debug.c | 11 +----------
>   1 file changed, 1 insertion(+), 10 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

