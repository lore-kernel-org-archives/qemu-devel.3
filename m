Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 504C6CD4F47
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2026 17:01:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNvuJ-0005Ri-MU; Fri, 15 May 2026 13:01:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wNvtk-0005IJ-50
 for qemu-devel@nongnu.org; Fri, 15 May 2026 13:00:47 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wNvti-0006G4-5B
 for qemu-devel@nongnu.org; Fri, 15 May 2026 13:00:27 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64FGl8cK1355051
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 17:00:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Sfolq7MzbHD6peVLfG5i0h0QkicqqGnj/cmPdRRzSoA=; b=p8PVJzP1rthX6s32
 9GgWm15sQ1BRI7UD94KK5GM9UPQgiulUyYAgXej2bRUc7Sdoq9ykSvOy8L0Jm7k0
 XQN/KarEGJ2mYEd8u7UQNbR8lENXBuZ5Hk921qYqLF3cLx27qNMOaHj8EEfzVNpP
 DKG70YfhalWNwg+hqMsdcpDaedZqVU4BVFnw43H8oMd+fUPHYHrHrEUQl5ol/sVu
 HnoJOS35EQ83bOTATBky6QNfZqAV3yMTp8t0FEx+ZSPR7QhqnKRlNuFotamkAl5k
 HAo7615VDevrfhHZ6Bisjo1SRCrb1g7k27hsdcSkMcjqvJP4JufTzyCB49GO0gxe
 TmnRlg==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e67ac8194-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 17:00:24 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-30230e64087so53789eec.0
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 10:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778864424; x=1779469224; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Sfolq7MzbHD6peVLfG5i0h0QkicqqGnj/cmPdRRzSoA=;
 b=kK389qmPpnD9pUsK7B341GJLLUsNBfoL8qGZxzHdSc3go8RWoTNSWwQKzevPzW3CBh
 GofpVaulQAqnabO3BIE//Mf9UReRJ8zFTULhqcOvljwA0s0UJw7S/rHvhSgH3Uu6Vp6b
 itSMkIPcwaJj3XmAE96t++iZFNZAON1Wn74Fb4/bxUS3zctCSIEEZ2udIp9sskGBaUST
 M3yCnHQ5gHVAwhv9ZZdMQsqFZOEGkhehiPYSoNb0QkPaYWI2sWXIUXtf7s35N7KcET9Y
 u/9wDCkWVW85+p9lTZwF8n9k3pSSNghK4tnesAfHPKb2PCYH8gF3QLT5Pw+dC3hYYLN8
 1kDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778864424; x=1779469224;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Sfolq7MzbHD6peVLfG5i0h0QkicqqGnj/cmPdRRzSoA=;
 b=Q1AZ391QW0+Ur/fn/5sPfqxRdq+eF/+RnckSzQm+gW9+8Av+YYQ3w9psU6QiPjpEwy
 lSLK9UeBzxEvd5/fXvCeoU58+s2HRhmAX5WrYCss8FNILmlRyBXbDOuqzW7zDdAHRjJZ
 cc9+4VnYZhXFyV11Rtf45KbOz66lVbIV8P2OGbT7u4/wAPCA2Iogs+HZiRWCnwCoHGAU
 v8wN0cKUsAr22MlWI1K2+xdlC1CpjSGP2V+yWxofcBmGnHlw0rIQflq7AVHjakL+Ovud
 6OID4K9t+h4C9XZ5mV9kh3/1SrTgUjRlrUZGm+8XCXwzhuFU0V4oo+RKnCHwxVJTBiDd
 NIlw==
X-Forwarded-Encrypted: i=1;
 AFNElJ818THDxBbEmHYmpdwkCqClZcuEgH+HOCZ5z+VRiLWizqO005H/fWE/xumdnAFz7+7BGKwXye5L1NjD@nongnu.org
X-Gm-Message-State: AOJu0Ywgixoz7sYW8INCgDV0tux/lEQ4gksHMCITbilkX3j1zqeQxybW
 D22RFXOsQ9iAg35hCx2b71Dv2ZEBtQbyJ9+D+uJ6l17AR+OY2x7QS7SZtI184RKw2s7+GTrsECI
 UTqBWYLC5cgXd9B5vLCJ+AGZCFU3cir20vwSmz1fato/2pF1DJ+H/Iwu5zQ==
X-Gm-Gg: Acq92OGif8tgTVdVeqbZ5Xxh7lEeeH7vjndWBxejSs3Pi1wJtXwYFuFBQ2rj5rQ+mSa
 c7hIswtQj2ZY9XCRGCfJXjOyOnZ1Us+/ow8r5KrN39Stnq8Nxasnql6wtwW/hnRzYieonUanOTZ
 afwLwnzRE3Q+MAMcXVK/v0ZMZRrkDwH6/CkmWlCFoej/WJJni4J/iZfuDkLQqYU1nicgBRY+uNU
 bT1JXQM7hBxtY8WqejBpkuCrB41nCav5kP86N+nhvtUWj1dPSqp9L/N9mEjJw1/h+6eyyUUD79a
 YlQ1KlWohnr6NtQKWdKRbUmwDG1ykQ3Xk55UDWp6R5VMkbSdOc5NhRsRtvaqFuWju0Tzo3PFugV
 czvhQLT0wAGmJpN1P/wqBTZuXoB8OG67FU+EYEvy/XPP1mUJ+XS6dx1HymopFBfxev+ETKke2jM
 FT3puvAXRk25NMlA==
X-Received: by 2002:a05:7301:1983:b0:2f3:a348:a2db with SMTP id
 5a478bee46e88-303982bffb9mr2299142eec.10.1778864423474; 
 Fri, 15 May 2026 10:00:23 -0700 (PDT)
X-Received: by 2002:a05:7301:1983:b0:2f3:a348:a2db with SMTP id
 5a478bee46e88-303982bffb9mr2299087eec.10.1778864422737; 
 Fri, 15 May 2026 10:00:22 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-302978b1a79sm7556858eec.28.2026.05.15.10.00.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 May 2026 10:00:22 -0700 (PDT)
Message-ID: <6fad8023-e720-4aa8-a755-e605f79109b2@oss.qualcomm.com>
Date: Fri, 15 May 2026 10:00:20 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 04/20] hw/arm/aspeed: Initialize 64-bit CPU types
 during DeviceRealize()
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
 <20260515141032.3271-5-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260515141032.3271-5-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: cTtjmLIjA6zgx17Z5LVhCLQUxBz4CTDC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE1MDE3NCBTYWx0ZWRfX1HT8waFgVmSo
 k1IO30WJRhYCINegzkrMcN/MrCORDjn8XutJpOQwhtg+3Xn6tqNlS8L40IR5qjYwiD1Z/A4vbFv
 0qN50pBDbQEIuaES2K/YB1vbi4uaZZh+1mXDWHrjmXVCE+dfe7YYZNuhNYK/sZ3BIxXrbM5vR3F
 f9wWqNCXzQroMkRKXk2iI/IT4+urbE5TGf3ThVVsfdrdqdnqX34vOGCPYaz+rT+gdeJF1qZ7rZY
 Mz2EG+wBpZiYQEyUUDhD8JktPrcJziuQMG0rIt8Eda5icrpsOIqALqCWbI7rwfHxE6EC3kQMQFH
 ZBhpoPvRAFvRRaBhqQgjgJALn18hjpmtZPSQqGnblxbDjw0Z/u5dd8oJiLuI44o6heIyuq07EhB
 6YiyJvUWsZJ6yb9mzqLu/MvgeTT3goQW9baU4i50fp6ChiTX/l1w7CvwC1VCxiX0D8nIgaErOjB
 S3XEPpcsGAIGvjakO7Q==
X-Authority-Analysis: v=2.4 cv=SuWgLvO0 c=1 sm=1 tr=0 ts=6a075128 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=Pc64puJslZYGwNK1JiYA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10 a=scEy_gLbYbu1JhEsrz4S:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: cTtjmLIjA6zgx17Z5LVhCLQUxBz4CTDC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-15_04,2026-05-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 impostorscore=0 clxscore=1015 suspectscore=0 phishscore=0 spamscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605150174
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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
> aspeed_ast27x0.c models 2 similar SoC based on a 64-bit only
> CPU (Cortex-A35), only available in the 64-bit binary.
> 
> If we build this file as common object, these SoCs become
> available in both 32 and 64-bit binaries; however when running
> the introspection test on the 32-bit binary, the init() method
> tries to init the Cortex-A35 type -- although not realizing it
> -- which is not available. This can be avoided by deferring the
> CPU type initialization to the SoC DeviceRealize step (this is
> safe because nothing uses the CPU type before, only the GIC
> access them, just after their realization).
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  hw/arm/aspeed_ast27x0.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

