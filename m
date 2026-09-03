Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE76DC61DD3
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 19:40:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2DGo-0005yx-G1; Thu, 03 Sep 2026 15:38:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x2DGk-0005iw-W1
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 15:38:43 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x2DGj-0004cH-AK
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 15:38:42 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 683G36K12088737
 for <qemu-devel@nongnu.org>; Thu, 3 Sep 2026 19:38:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 UQvdF8KaGgkw/kGplgwv2afNY6LxiyS06HZYQvm26rU=; b=JP+2QOekIMMuWZPJ
 u/Iy85iw6+fmaXrngfU5mS5nY4WHcc5rdzBGJuxtz4Gi6Lu8fFZmj0Ni8IFF8Xmy
 YK2gqGbiOllH4ADL9mO2cqpejRBZ9kuNkK3h0fLMXBZk9liYqKiaDUSLp222ngn8
 jqnE2FwcgLlqysY9diQijpRaWeVx/9TFZ5UfEd/6IXtz2cYH0/tCtmkRBFXh953N
 uBWig9sk6g+HqWSbrir1sG0mo8f3ystqkyakM41gVxrazRDF/JVQH28i8+UQpQdE
 SBl64M/AxHavjRyFAcnNzS9DXW8E+ZyH1I0HiGcRbj9yRc2VYLo56FrWlZA8a4KI
 inTJ/Q==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gf9b19wnh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 19:38:32 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-39533bb224cso212740a91.3
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 12:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788464312; x=1789069112; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=UQvdF8KaGgkw/kGplgwv2afNY6LxiyS06HZYQvm26rU=;
 b=Bjz8xBSL/tDR9vta+fSdTheq3mSuiH9LHZL3iAwnxlF856Jgnqbbaja5Rh2ASVXdWt
 A2m4WmQ43lL5QXWgwwZQEhzS7WCSPO8Gr3h/aPujOdVRzKNSYTsge9NuqXq2LU8Hvgh4
 fUFOOw9EPVdzC1+pLExkkmU7ElZqrtlFo2B9PYIll2qxN6ikPsvWCYEkqdaezIrYhlju
 koyNy97T5PcK8CmACizYYmDxOxd8Rt6WmcaE7IECddR4yY/c2djawS3JryKxcJBVnTlC
 8XTkMk9ZocQ1UA5c5md4wmsQ+T2jXl/Qa7qNA42sMsEyIIQfpOFirLMyDFAc52BGT/sQ
 Y1fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788464312; x=1789069112;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=UQvdF8KaGgkw/kGplgwv2afNY6LxiyS06HZYQvm26rU=;
 b=k2OulJEdG4MOL2quP9g2+XY5AFf9LEkHWe/OwqWTjt6xXUkUh1YM4irztTtOBxxdUl
 Y6jlZ5u+o/K4ToRBVQic1osug1rLkItFU2h9n1aaGagvY9pBDHgA2+d+5jVPmXuPLHh/
 ZV4PUO1Oeu1am1g8Pp9LIwmag0wkhGao092lX6XOeYMT3uPGAt3ONvZl608EFHFyfd2x
 ERVHXPISWO+gU8b7l/sYqEGQeoOkFDixxhRL4VycsC3ymj8B3zJeoQiyx1ddI9iI4NBJ
 8DWiRwJFq6Uv9iBK6IYih1gW3vME9hgyyP7YuIdUSrIZ/hL3kUhSHVgZcrmXos+MSouZ
 MDfg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxu76xpiRExScKQPTxEmI61n4QtwfilRW5FhFpKbL5WE37TFbt6yq30pUX4ehlvm11iQ5Ihp7vvHwgJ@nongnu.org
X-Gm-Message-State: AFuF++kaMoQquLpV1EKvIly1RNo5IeHYGO3MGi0aszLil0ZZg1B3qpHI
 1HornLW8j7S60/EeY7LTzzFujxS0AkeH6QMV6qFLOnC8X6SyM1SWXcrlueGIThUK/xUTrA3tZ21
 gqu8epaS5MjpL8nRwLMy223S5S10PW6Gq60yNa7wIB6XMFwf213HNnR4vEA==
X-Gm-Gg: AYBFou14lJJEMDPLAmI1q7Baf4aVwD0n1FHqPVfarEZ76L3wXeZ37jWkgi2FYNQbUqH
 D/c1otJ7YU4hOviuLaZQLSx537jNgxsEnX9iYKUxQCc+st4g7r5ZNLdDBla93iCO4+ZFlDLn5Kr
 m1NBBBMiHKUndHPyEkav8YYY04IKYwPnw2eeSg6w509CHkDJ8S1qD+98Zl/bghava0YY8QiR96O
 K7HDjcA57VrS/7AQzk1bS3Mwcseg/pZg1BrG1qAib8l/34T6I3Qgqhtm4AxOhjQH6BbPZ+wqbof
 PgGuE2nZ52S/4BRQpy0kd1s1kQVn48WqQAakMebFXHXXHCXQ/LprfgcDC5hgDfaR1Mzx4qV8cou
 cv0YOcGHkT95z5zRlqealLiALKc4fzJQmsRNU3+B8+Lzg1q4CC8QLHHlCTP+nKgtWjmn6
X-Received: by 2002:a17:90a:d2c6:b0:395:4de4:92c7 with SMTP id
 98e67ed59e1d1-39b260d2f07mr1365511a91.3.1788464311562; 
 Thu, 03 Sep 2026 12:38:31 -0700 (PDT)
X-Received: by 2002:a17:90a:d2c6:b0:395:4de4:92c7 with SMTP id
 98e67ed59e1d1-39b260d2f07mr1365451a91.3.1788464311091; 
 Thu, 03 Sep 2026 12:38:31 -0700 (PDT)
Received: from [192.168.1.199] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-143243e6ed1sm1287210c88.12.2026.09.03.12.38.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Sep 2026 12:38:30 -0700 (PDT)
Message-ID: <bbd621e1-b124-4c03-970e-85f761036b32@oss.qualcomm.com>
Date: Thu, 3 Sep 2026 12:38:29 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/8] tests/functional/hexagon: update arch tests to v0.2.14
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
References: <20260903185622.3234171-1-brian.cain@oss.qualcomm.com>
 <20260903185622.3234171-9-brian.cain@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260903185622.3234171-9-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: lamiFPzlzSO0LaoIJMfEOS3Fh8h2eVO6
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDE3MCBTYWx0ZWRfX8b+KDFeKiK1F
 HhI9eXplmd919/M9JCrTlZLlATvon3UtxhBjOjB1hm0R0u8BNVVHZ5J7SQkcXcIt6PklJMnNZ45
 QWSLFHjieP33ElH/eM6VvsWHC6+RrfE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDE3MCBTYWx0ZWRfX4IvJQsbOMOge
 9xpeanqavmqp+qg1HGNmEi6GJHKJxpfeUBlTn2Cn8zUULqhU8xgf5VPV8dD9tADW6Ej6EhEXzfn
 lk0fIX56q8DfHKxD3G1LL4kQinvgDC+2Azs/+JtDLVa5pICgrsvHL8U82Qx34HtolCDnMp1YyCI
 SZD3rBHansl0YUlEF4fWjfiFuwYVbzZkkFW7zta+wtSN3BkdPvu8XH22hvJ2guHebnFUinp+VvO
 zRWZqMlsdLnDfuzhgK/klU3kjaezHGxiuoKRT/e5BOA+5CKniJECg5sty0OyTfikTp+IoAfujpi
 pC0huCeQQN2lSOJRVfvw3qTu2+VJCPl+kArjI/MQVvcswjBN/wroLb5QU7ZP6/ShSND8PHtCKSI
 RS+5Ji4uW2UkVNTVQaX3IrK8wKdqrPSWKJwFtC6yiJkkfscoTfZX5V2jD79x5CVSVOY0BDVzl8i
 iT1Y98cz8FyCJZl3igQ==
X-Authority-Analysis: v=2.4 cv=NNTlPU6g c=1 sm=1 tr=0 ts=6a99ccb8 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=6-dfFjAAtPCGfwNzOGwA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-GUID: lamiFPzlzSO0LaoIJMfEOS3Fh8h2eVO6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_05,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0 adultscore=0
 malwarescore=0 clxscore=1015 suspectscore=0 impostorscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609030170
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

On 9/3/2026 11:56 AM, Brian Cain wrote:
> Some of the tests run longer now, extend the timeout to 180s
> in order to keep it robust.
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  tests/functional/hexagon/test_arch_tests.py | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

