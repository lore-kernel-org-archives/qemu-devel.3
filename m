Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 996E5CD343F
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2026 17:06:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNvzS-0000Ke-8H; Fri, 15 May 2026 13:06:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wNvzQ-0000KO-UY
 for qemu-devel@nongnu.org; Fri, 15 May 2026 13:06:21 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wNvzP-0000lm-6F
 for qemu-devel@nongnu.org; Fri, 15 May 2026 13:06:20 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64FB4Un83512721
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 17:06:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 8aStGqZHRZyKK0FY9xXuutMH53E7sRiaHBwhjmVh8rc=; b=BkIIcJF0eaoxQNbf
 efafodvyx/UrBzo40CNHsnY5ENCrtdaWaPAFiWzWYC88IH4Z3dQhEHJLu2I+NpYB
 HuiOtNIOP7PiajJWoQDHH0VHJqVaDZQ5JOURSOF0zVx+1f1RFXli5J+cIwnh6jB0
 DQevBOfPfCT8nBtYlDvDF3oBWERdb2e9L7bFdlsXlHMq54z+J2LLxMyUU6bxqyDm
 u73qt5klpUlTd1r2F2tYYoAuNl+1LGAWEYfSd/4Mo13yY9aYX/Ev29QBNA7Bxn5g
 g33Al+x48GFCJjucMDmeQd+0uvInF+yxwDas9uP8GgOfwfduuc4JMIwo48feihF2
 gqN2+Q==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e5m1vc5rs-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 17:06:17 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id
 a92af1059eb24-13367aca29aso514986c88.1
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 10:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778864777; x=1779469577; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8aStGqZHRZyKK0FY9xXuutMH53E7sRiaHBwhjmVh8rc=;
 b=FHVrlRI2O7CvUa18k4CEHDLHQR3TuV3++7/w4GJfPJ9mJuvkmeXK61M2rODifiHdXc
 d7QR6kdPOJZe86CXi6IIRlfa4IRdAALMh69U1vNbleEZBDhm+NZfobpXC4j6+LLvcvNC
 X3nChHNHL9IYpLjznnAbqf2ilkiGj8LwfTmIp4XGdWLZR12Mi/66sS8AQ2lmmbQ7yUJg
 q4A0K62c8PTLydf2+kq/cpGTfIi9F7I6nItSl2fRX4mB4a+3Rc4wJfQFwubAAU+CbO2Q
 KlN1j7NL1Z4UTmTI5Raup9mfvHBKxrhV69Y3bU9i4IA8TRHR0WQIshEVWLotp7f55zP/
 TVuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778864777; x=1779469577;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8aStGqZHRZyKK0FY9xXuutMH53E7sRiaHBwhjmVh8rc=;
 b=ROuYoqcBUuwmosFAUi5pRvobPJEGtDaN+FcdOQSpP8AZ35ZPvu2xAZ0IuGkPADBWY3
 6vLRPQsm1kBTcN4UGH2TOW1hpdcylQJ6J3eJsDrUYYDhX4lYQlHQUaLmbP+5sqDT2kl0
 LNSgjF+jU4yLylmokcx9cvUk9VZqJW233OI2FESVrIFhYuiydjvMmFIF6axNegAIkFbh
 fc6NkWzL8560aCZZmcaWVtILDuAgCak9XWTH3Zhzsvqc7SRMIJ56guJMD+AtJkzuk5hO
 kM9ZGq4fK91auYT7FrVrurwDqYdILmbVABoR0sjOAH2LWXy891t6+y2dkR8DU6uLD+EC
 8bgQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9vfZ4lD+5KGH2GdZcSZd7eL+yu/1YUuqCemRG64GLoPx/IWaMwdAh9YkBo1F9KPhQpa/hk7wrZLnYt@nongnu.org
X-Gm-Message-State: AOJu0YwAcxt9PocaVG+vxmBwHUi95txogLINX7wZuc0peWwJe/+6oWay
 7T952j7MLcxwuHqYfATL3ugztppscS/I1hXnEG+NU8BHqaB5jBm+bnEUMiqktjMenDurUzY8thI
 zF8IL0lJVkQpKiBApSQdpeZMhfFHvyeBXDwuD7QUh66fFYPQDZqYJen27Sw==
X-Gm-Gg: Acq92OGI8FLYlPGXttuVWJDxnxVMBR399yIz/VWErxJOg2zM4yq3FkcaBam8y4eTPnm
 +vbcg6LmN62N7jqM6e/ctnxqcqzLiAeZ2NMiUjaIcCk3k9eHzOShskOaFHMNFoUl+G98ibiGp6G
 pa+aocS/GFriR+1w/QaJfsDp3PulwV/gINN0vrlfHBDWo78ExdDUk//wL9v2IZj6RR+++xIibVx
 T4T9Eib7pOijAR5sr8mtcRrh2+JBijm8PWAoHbayDinnmx2gzVdOz7Q/Fcwjo/TzR0PwcraLqyR
 pf5zfkMaYUGFhhbgcM3GYV5IcN8z9YvnG8FGuyDJUxMuJllwc6QkGL32LMraoI6N1exWNgnFpUc
 zC17BNg2TfFgDp+kV/Pwi7CShYvxZmaw6uZ//DEUzg17c75vqf/nCa8DriBKgFGlTCVlZzruSOW
 egMcj4BzeIkHdkTswvtZgL7FCd
X-Received: by 2002:a05:7022:ea2a:b0:130:5ec9:7ad4 with SMTP id
 a92af1059eb24-1350483ba79mr2050995c88.29.1778864776705; 
 Fri, 15 May 2026 10:06:16 -0700 (PDT)
X-Received: by 2002:a05:7022:ea2a:b0:130:5ec9:7ad4 with SMTP id
 a92af1059eb24-1350483ba79mr2050963c88.29.1778864776107; 
 Fri, 15 May 2026 10:06:16 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-134cc33a618sm10537098c88.12.2026.05.15.10.06.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 May 2026 10:06:15 -0700 (PDT)
Message-ID: <cd804f36-2fcf-4d7b-8639-4d3e4fcd9928@oss.qualcomm.com>
Date: Fri, 15 May 2026 10:06:14 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 09/20] target/arm: Build cpu64.o as common object
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
 <20260515141032.3271-10-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260515141032.3271-10-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE1MDE3NSBTYWx0ZWRfXyAFzTB8pxstT
 h/Vpmw3OjX6fdJORpcWT287vNlZAzO+diQAqUjTWZIZjTrRXSNbD2+Rme66IErHjff+Ol3ZIepL
 VVTdTtQpjKJZk1Tyb7ACrcreIBRuw8mhV8pt3RK5g5r7aZoLi68OXZeUsvDcHLxGgAnMCXW3D0a
 JKvxVL7QZitw6TpzR+fcItjznasiKRQL5g2dUTGLBhHSeWSefYOcyDN7jM7m5GhIYDtf8hNtHaT
 MD9EozHPgnRdOeffGjIFd7AO1C30YyyGsaiK+v68Hb+ay9SQAm9JiKV5ZBBFmPn1HknpXZEKUKK
 ClVKzn3QXqW8SfULOt50f1Ak3r4dAwn43bj/WhyPmSOjdp8xgFn34ccGn9mVeng9gqgt5vIkvpl
 wpmBImYUYD/ZMOZwWIztMH4y1zg2QVnoz785CEZLGxpzH/zLS5IR00KrgbDHFV607hjoI5WAmq1
 1aVt6LgPo+U8H5kh4qQ==
X-Proofpoint-GUID: VJiPa48Ep_FNCRLJpL3aQ4KHDq7p74as
X-Proofpoint-ORIG-GUID: VJiPa48Ep_FNCRLJpL3aQ4KHDq7p74as
X-Authority-Analysis: v=2.4 cv=BvqtB4X5 c=1 sm=1 tr=0 ts=6a075289 cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=wMs-g1Syp9tSsF1fmVcA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=vBUdepa8ALXHeOFLBtFW:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-15_04,2026-05-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 spamscore=0 malwarescore=0 bulkscore=0 adultscore=0 lowpriorityscore=0
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

On 5/15/2026 7:10 AM, Philippe Mathieu-Daudé wrote:
> While gdbstub64.o is already built once, build it as
> common object, reducing target-specific set in arm_ss[].
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  target/arm/tcg/meson.build | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 

With commit change as Manos mentioned:
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

