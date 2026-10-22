Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50AE2606A31D
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 17:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=L2znfZAX;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=hTF5ojcG
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJwnr-00070M-8F; Thu, 22 Oct 2026 13:42:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xJwnP-0006zA-72
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 13:41:46 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xJwnL-0003eb-TK
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 13:41:42 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69MEFC2p978699
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 17:41:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 DEXyBvVccId+uZd/nCoeuT7mmtatIbKqHdNqyBkCZ2c=; b=L2znfZAXMZM61meT
 DX5WCOuOcBhIR0M7oCWBHcRvpHaD2MO2iR/0iceCVykKUugFY9X48EXNyr+NPe5K
 YO+lZtzNLMD07BIB0GXSEFAAbh79/Q9fa6UxzIfkcdnVjyriqPCWLZYD3FzIThil
 NAPITnLZ0S20b4ui6vh1c9yehU3bNF7X1Z793BUbQftdmaRGTLijq3tHzEe0EIvR
 L1TANwV9f/EfaLg6yIDSRRwTHwcPZsekwkQKJkazQCFW1Zv/3c0lfefuoYH0MZyr
 F3dfBwQ3Ha2jf9Ki4FhOuzmCjyMLgkcgK/ThLiTB1V2uaWJuk17ZZPP6XYvUGALq
 yQLoLA==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hf93dcrng-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 17:41:36 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-30bcb065bfdso75879eec.0
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 10:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792690896; x=1793295696; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=DEXyBvVccId+uZd/nCoeuT7mmtatIbKqHdNqyBkCZ2c=;
 b=hTF5ojcGfVHVrDSI3ADjXalx9nFGqALJFwYJB6qs4ZAInLt8oYs/tFvLGb1qDlxL4X
 QIF+LIn/xSKbZWIbY2qw2aqv2JTZp7Tqg49L0DHMXM3kwArMnYLZVGrxA+6HluCG0zQP
 JLC09dm4KylJSsOesA76JugUtrwFPyg2K4PjGsdU7RjshG1WyD9aTAOc9tK075PKoGVk
 KWgwI6OO7nQ3QN8gq9xGgOdTb6gN5rGdmbfHnf1aeAa530lAiN+cdKqycQYpFAe4kA36
 SaoMLsDJb8ucDTCxQw4/9ixvD/0xEUiADB7AZFwyRs+SjQQEAORB/v5YcBEARvGo0EYz
 t8Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792690896; x=1793295696;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=DEXyBvVccId+uZd/nCoeuT7mmtatIbKqHdNqyBkCZ2c=;
 b=tvU3qorQwe1olFI5zxhC1lEzUDfJ+ijfwpwgvb2rlSczsMwNqn/7c6qD6YyBWyT+/E
 3julGNGyXTRp6dMeOrTjNKsh7xtb/zLv7XJ+9oPatzf7kytlYnGga9wuTTKWa5RBsQ91
 uegi/43sdfjoGAjckQ3A7mVegc+4Fprq8sOQD/I2R14Jz77ZCPZAzuj0ivutMa1KAAgK
 ngzKBCn0SM107eadSMhZKjItK77I7OlXr4lSMFgGIkgCS/2UGe+/hZHOxVqOrLGwKBD4
 3BIiEUZI1zWinx3V9exsNLBkiBx0Se/7Ff4jT6otFZVox9+ReYPHdY2zx2UQguqHCUZq
 GihA==
X-Gm-Message-State: AFq9FYIAbeJuJgg9QJkndwvB69h8s0qM6ADqW01qu35ErVaq/CkGAKId
 XAFj0bKcDaoSZnekUUL4K5nfAH4wgsEKxYwAZfbpePEDn+BVagYgjZpte7XAXL7/Xk50RKXfsyk
 UEXas2OR4eELo0iGhx81IMo51MseO5si5UJFJWKCsa871HSD4d3rjqtgCaO5+IfJArA==
X-Gm-Gg: AYBFou0GGrxujvlXvsthdsa+AzsHzyWU9J8U+u4yUXq8f/N/kqlQah5iQYUYldVpQXf
 BabkEbCnaRSUHFPQRvJdYof4KYsEOFOk0bRz94BzAnPyoiZynBcEzVqunEK7OGqwRJcNwbHxlYu
 vUfHo84Z6fFMzWgZuwUw42thh2BevR9alBR/0vQYUL6083YgwoMVkHwEJUhW+3or3Rbu5YZWp4h
 ZHqoPbAYCj5K/r63lDuqtCzmOgA+qfGlMflO7+asZlPw+9fIdWp1Zhf6/F8gUWDDuS9KT4rc4vW
 aN42i3hVTb7dkXp/cYkVYZaSHEjOElh25NO847+4i9NoPrywUT/YY3G5E6p3z1/MpHyya4L83fM
 rlCc3cciPTJX/tMAheRlq8W+zMs1Q/sGFXJeGcREDG5lcj2X1UCYHTuEZkaORXd/AQdeTDQ==
X-Received: by 2002:a05:693c:65cc:b0:351:1e72:7470 with SMTP id
 5a478bee46e88-3674ce2ef7bmr7573307eec.13.1792690896038; 
 Thu, 22 Oct 2026 10:41:36 -0700 (PDT)
X-Received: by 2002:a05:693c:65cc:b0:351:1e72:7470 with SMTP id
 5a478bee46e88-3674ce2ef7bmr7573253eec.13.1792690894700; 
 Thu, 22 Oct 2026 10:41:34 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3674198f1cdsm20191772eec.25.2026.10.22.10.41.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Oct 2026 10:41:34 -0700 (PDT)
Message-ID: <8ac942f6-27e2-424d-b224-7d0de71f1ad4@oss.qualcomm.com>
Date: Thu, 22 Oct 2026 10:41:32 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ci: add automatic retry
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20261020231602.24344-1-pierrick.bouvier@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261020231602.24344-1-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDA3MCBTYWx0ZWRfX0wNQl1QEr90n
 OAvOPNBcA0kQt103uA2Oo+lSUb8KS5G0nOJDZwL312zesYwTbjOIJWU497TMOmQcsD4wxvXtq40
 qwqTYugexQk/x/cGV/ogVF5nMVbiVsw=
X-Proofpoint-ORIG-GUID: 8QT7l0NspdI9MAOlPUxbamySgpS_bjTs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDA3MCBTYWx0ZWRfX6WEgG6s/y8F6
 a4ZichWPg3J4i14qFIAD3A+Bkri78ofQf7YNyBugAnRZTU5VOCfOXuXg78Xgx8fmgNwz75IUL+N
 t0VdTN8ZP140lc3wdEDZz0Sn6NBsv9EETgaWQTQ9FxwZ/xST3OgH6wbh98N8Al1/bB3RLshMGC0
 XI3pffgAfbA+wz5/l4c1WZ3lKDRjX1DZ8LqRfMV7wjaKUMfAP52iTe8S6jRoIrKm2PMxWvhphUQ
 Inzhj0thOBeCl5D5Qj/hOrIuAuCckeSqjyiH213lDqkB+ukD9h9PO/WSv/E4NGxStEVRYGtVdlg
 8HGIWIWxzDYA2V985lTGaYFGaVq41YtrUn1xSZoUKnL+TjxtIvNHXmbX2GRRyfOnZFWh0SGkbcF
 4wI1dozZyHsUWPZhQoFZ8FK+9966YQAazqiJvZvoBfkxhOy7kYoncV9A8blGwE1Y/sjMcFONeyk
 F5ewNJ+S0m1PgrPlVuw==
X-Proofpoint-GUID: 8QT7l0NspdI9MAOlPUxbamySgpS_bjTs
X-Authority-Analysis: v=2.4 cv=TIPQ2Fla c=1 sm=1 tr=0 ts=6ada4ad0 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=oP5yz2Yi8CnxVeh9_jYA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 clxscore=1015 adultscore=0 priorityscore=1501
 suspectscore=0 impostorscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610220070
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/20/2026 4:16 PM, Pierrick Bouvier wrote:
> When merging PR on the project, it's possible to observe failures on CI
> that can be related to sporadic test failures or infrastructure issues
> (pod eviction with Kubernetes). As a result, it adds latency on the
> process and workload for our top maintainers.
> 
> This patch sets an automatic retry (supported by gitlab out of the box),
> so failing jobs are automatically retriggered.
> 
> It's important to note that in case there is a real test or build
> failure, concerned jobs will run a second time, and fail again. That
> said, it happens seldomly since sub maintainers are supposed to test for
> this before sending it. Also, the retry is limited to the job that
> failed, so it should be cheap in terms of CI minutes.
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---
>  .gitlab-ci.d/base.yml | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/.gitlab-ci.d/base.yml b/.gitlab-ci.d/base.yml
> index 8fe00809357..63ba82e3632 100644
> --- a/.gitlab-ci.d/base.yml
> +++ b/.gitlab-ci.d/base.yml
> @@ -31,8 +31,9 @@ variables:
>      # Ensure docker.py / tests/docker/Makefile.include always displays stdout
>      # from any docker commands to aid debugging of failures
>      DOCKER_V: 1
> -
>    interruptible: true
> +  # automatic retry on failure (sporadic test failures or infra issues)
> +  retry: 2
>  
>    rules:
>      #############################################################

This was merged into master (3ad81d3d271cef6ce95b3a3a33bb71faabef56a2).

First pipeline was green without requiring a manual retry:
https://lore.kernel.org/qemu-devel/c0774bbe-dcee-489f-862c-f481e58c1d73@oss.qualcomm.com/T/#md488890f5d439b02b5da24d7770e71f7e6283390

Regards,
Pierrick

