Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E292CD343F
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2026 17:15:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNw8U-0005dz-LR; Fri, 15 May 2026 13:15:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wNw8K-0005S5-VU
 for qemu-devel@nongnu.org; Fri, 15 May 2026 13:15:33 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wNw8J-0005vv-F0
 for qemu-devel@nongnu.org; Fri, 15 May 2026 13:15:32 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64FGn1HW2691586
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 17:15:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 PIYOdu+uxNxewrE4SrlEI7yQKy4MUxiFz4WOfHWZ+Zw=; b=ot844le3lOv2DRv3
 Hv6b8tPlbeHNyXrmleJYeTUmNSgJFzUIy2sjx7HITusFJqoe4VdbeYVG7OaB6xQK
 ibNkwxIj5Z3Vj2czvMvtn0SIELFJZfsnOr0zYqFQ5gV8SpcE/8IA6KUqmZ/hYP5I
 bhXzHV1R0/43eiG7a1V+s/F4pFu3wQoWz9Smb5rHfSr7vsYNjxyTUR0NuqjbYEJG
 9QEkMDdgpOJO4O9ABtCKP2Zzf4QGMiCkrgQrzrJnEE++L4TulQeebjBiU5rOq94t
 EvwiGuu7BM75xLkKLtdaj2ASJhbePdsw4UQaYUYbTfD9yZr8kbHbSFrxivqn4PNr
 pTKx5Q==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e67ber2uy-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 17:15:30 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-2bdd327d970so634335eec.1
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 10:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778865329; x=1779470129; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=PIYOdu+uxNxewrE4SrlEI7yQKy4MUxiFz4WOfHWZ+Zw=;
 b=Mwr3gVVLQi8qTWhPGLAF3szTcS/HMQSafppBY4xt3Uf5fnFUe1OiQaFH3vFCeaZb5z
 lgepuEhSu6e+DgRYclg8jt2qrOmTFEwt3EN3UfNqbjdvz/Tt33v7d/KqLE7JwH5rxj/s
 mZ/j+sEobarAYvLWYZWdXDr0J33c81xOnX5yi7v5fe4q9Aja05Mbs+Spywx04yo7iyje
 2l7CPZokkYdZl7iP3o/CdJb8dGUrA9ScNchNvaMQDRfyUN0yCyserPNFPhTt83C6NWsW
 EqUladW4Rwa1laQ04MhxhwB4hdJGJYLYsBDXWZoKHYcN08jNlhbO4LRwxzpIwzajJ8BL
 /ZMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778865329; x=1779470129;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PIYOdu+uxNxewrE4SrlEI7yQKy4MUxiFz4WOfHWZ+Zw=;
 b=rRxAI+dhaG7jLYWwtj/yt/LSGuEGuDdzAzapIdAQeUtj1ZFyeKx0jFuthPpvMnUoWV
 zhARFzQki39uEA9yqsIA32RdaeWsBp8dmpm8wjY3dLPal0J8FGUrd8BqgihwFFc82a9+
 rt5xx+Ox1+Utiv6xVRanoTzZY4JLVyLEJL7S8oigHnzAxyuOZ0BnHxo2LL3AdGAtjGN/
 Y+Gl5QnOhyKRIMVHn1IT3P9riP7GHQFl7njOxGunACGtTnlmjEY7Zml1nKRVXoUvY5m2
 ygK7rAU6a77xQzwzh1lNktg26G23hr1lg24ycyH4YMXI3Q6CZjmalsnQmdtEd24lYt2l
 pOWw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8ptp9lwUJjTBWEDG/30RsS4muwN4nD1CXVmK2p9fkUqMIbP4G5LUWzpB+ntjfu5Q/iN/PlcSEmX/wg@nongnu.org
X-Gm-Message-State: AOJu0Yytun+Bijcr8P+FzvykaGxWh/R1GrH54ANiE1zosgKryD5AlaLu
 +vAOKakcDb0cNJ8UGaGeAswWKdBXiIjXPW3ePkFwCszwoErhSxAmk+q+BJJoORXmQabPQfE7Uh1
 1QdDqVSBAKxX1qoBXRjv4yFp5i9D887tGmxe07iaiPYQWHyYrjjwzsqgysQ==
X-Gm-Gg: Acq92OHgGmMWRRQYZHlbXqI4UGqV6KVyZa+XNC3R8xq3nYVGgdAI7R4133/pID9tng/
 9QaHC8pPLYWS6wLMd6ylaqyJeTCxz4hwcGLdEZ/bPwwZpbF/zqLLhdfj4+DbThjkbn3ie4OvHpx
 P9ezWAJ0N3GPnMwKUQ2QIqltZG8WGUH0rLDgaCRawkfG80mCtIXJIOTl0H4sQ86zfIntJGpQ+tz
 qi69Y1ShEbacL8B8HN/02xOGf9IOhdkEF7Hs7YG+S1x+PyfplZLDAAw8rFeXwOXGMmDG1IPa4Vo
 yFHcxeA9QOvGyFy5zTt6vGYuw/hkvYsabpFG9SJIiW2n+8kZpbCmxF9tTFiEjPdC3+h++AfMWQg
 EjWO630MH2FuWDYCS1D2gS7MK+StO59DVrglEG4SkfMuzxaRmo6uqBNOpN0ZAP+WkZzcNpbI4Co
 5RMcgzF3pwfewd/Q==
X-Received: by 2002:a05:7301:644b:b0:2d9:db50:c6ce with SMTP id
 5a478bee46e88-3039785c4f8mr2205096eec.3.1778865329318; 
 Fri, 15 May 2026 10:15:29 -0700 (PDT)
X-Received: by 2002:a05:7301:644b:b0:2d9:db50:c6ce with SMTP id
 5a478bee46e88-3039785c4f8mr2205060eec.3.1778865328581; 
 Fri, 15 May 2026 10:15:28 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-302973bbd50sm7496742eec.20.2026.05.15.10.15.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 May 2026 10:15:28 -0700 (PDT)
Message-ID: <8d2ea9aa-929e-48d3-b21a-aa2c7caf8555@oss.qualcomm.com>
Date: Fri, 15 May 2026 10:15:26 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 20/20] target/arm: Build cpu-max.c once
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?Q?C=C3=A9dric_Le_Goate?=
 =?UTF-8?Q?r?= <clg@kaod.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 Joel Stanley <joel@jms.id.au>, Kane Chen <kane_chen@aspeedtech.com>,
 Troy Lee <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>,
 Steven Lee <steven_lee@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
References: <20260515141032.3271-1-philmd@linaro.org>
 <20260515141032.3271-21-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260515141032.3271-21-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: Bo-pA7BndNw6ysYkYw-qA7mRFuUJoSTY
X-Proofpoint-ORIG-GUID: Bo-pA7BndNw6ysYkYw-qA7mRFuUJoSTY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE1MDE3NSBTYWx0ZWRfX4XxhdjOnIpZO
 TN0jPmSHL8aip0NqyNfZjgQ82h6eXsmMP8oeI+ZgMN6OYnFhoEnTh/y+jthAqTnAI1dAsHa7jV0
 LqTl3uAr7qNDoTmehSm3KtJrpfZ/yJUAzYfKijrs4xVnApYFt1x0C/1LiAhlcNiybYDmhn279zE
 9VRRQ+vBH2LdK4wBCsiI1KFGBYcoOOi0vtbJeOgpOysZYpXDT0InLiXztQQ37CT5pWfFE6lFMhh
 5gScIjgIaHHebfAqQbtHlKmc57gepbTVYPGid9FSSiHuNL5wTBHo+FvWmKXDRtCMeAX+8C7A/CK
 rMUGWmAuLeFSwr8xPW476Si4l/YxopTm8pIlt4z0l8cgHjZcxJTNCns4e3TlHWuMNZ7iI2aWWzJ
 idK7k/9kKaiRdzwyHuA0MkHDZ5CbCH4VnGbtjSH3AbuJNclO+AyXHG53emNTOX96y1N+zwygwRL
 XEM1ucZ5Fgm304bHgsw==
X-Authority-Analysis: v=2.4 cv=IrUutr/g c=1 sm=1 tr=0 ts=6a0754b2 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=DDRv_mC4hNLIJudX-MkA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-15_04,2026-05-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0
 priorityscore=1501 spamscore=0 clxscore=1015 phishscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605150175
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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

On 5/15/2026 7:10 AM, Philippe Mathieu-Daudé wrote:
> Call TargetInfo::target_aarch64() at runtime, allowing to
> remove the target-specific TARGET_AARCH64 definition and
> build cpu-max.c once as common object.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  target/arm/cpu-max.c   | 8 ++------
>  target/arm/meson.build | 2 +-
>  2 files changed, 3 insertions(+), 7 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

