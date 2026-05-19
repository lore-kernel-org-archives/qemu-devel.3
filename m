Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86E07CD4F3C
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 14:33:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPLVj-0003GP-KE; Tue, 19 May 2026 10:33:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wPLVh-0003G9-PZ
 for qemu-devel@nongnu.org; Tue, 19 May 2026 10:33:29 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wPLVe-0004q6-6E
 for qemu-devel@nongnu.org; Tue, 19 May 2026 10:33:28 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64JAMgrd867353
 for <qemu-devel@nongnu.org>; Tue, 19 May 2026 14:33:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 PjNXYkocuNF+tVno2EUBfQM9s042M5YU62A3PRVKpV4=; b=ATZO2OTfD8DamfUQ
 OfAP6MwXG6e/AMT7kgQvpQVMTxLvdy/wySvIQK0x13jFwuFsCYXMuhPnTaXKfGhg
 ucqpAZ1JiXe8PH4L8Ax59JZhKTM+WA7hNdbNb+1sB3XgZndMvb2jq50XW6Ag8AGH
 ML7x1qJ7IBCpgeWcVnMAqRJXsTpx8YTQI/SDDYH+FAlF2DBQFB3jkGrxLQGeNfac
 8Pw30oBATIOyJS5OzQZFr1Hc82zSGA5AZSzj/MbnZNiZUp0CwhSryvIQMIFYJ0YY
 yQ16WDGTbvrqDlkUQ6TGh4YABXsWyEx332OnnyAdeM1yN6NyGzmrlA6+TyDrtv6M
 2SP9Yg==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e8hv1j7u1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 19 May 2026 14:33:24 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-135405e4035so17288660c88.1
 for <qemu-devel@nongnu.org>; Tue, 19 May 2026 07:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779201203; x=1779806003; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=PjNXYkocuNF+tVno2EUBfQM9s042M5YU62A3PRVKpV4=;
 b=R0obWnc/9orZqQHMi0n/KVQx11bvbhs1/gaFePoMl5cKCgZhES/uAXqTF9UowTgrIk
 O3u5SJSr7MnxvLXXMYyGwS7LIoAWv6j9oMoNe2zMe0ufka831pPRoQ9SAt8IoNAL7VC0
 SI37G2zc5PsW18PYvdrmqp1DfcBszG1ljYpZf8UAuZL/vMIRPYEbe4dGA/uwKPtSdTj6
 eLJU6UDrivLEHdziQlDyo3XYU7wPLgYgw0W2MIlVf5YiJG8aQj50iGdP4pVm2bNYElPD
 X6uyZf0s+l6U7EK9VKATPTSKcy51Rb7JrxKJN3fOBiyqC16VKQNz9Xekd81ZZC/xT+2a
 D9wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779201203; x=1779806003;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PjNXYkocuNF+tVno2EUBfQM9s042M5YU62A3PRVKpV4=;
 b=V97K0z1unMzRN0A8qDA7FbPKmHsKcsFQScTc+DlTRjbGxUcn3K5eBOy98dS842hx7V
 Q56aydkBNS4jWk/FhYdrwXAD27tpFjYaIzRUvIAMuIFK4Ln9ytf5T/JpskpugfBNaH1E
 MH1o4TrmB07NkGANXboKkJ65hvTRdR6ONkTit62uQmSjyZfzLu5yqtYk2RFxS6BufHBu
 bd9Anw0fayvtOqW8pm1tUga/dCVI4oGDAS1s2nnI80aoCg1hwD7KDFvTIPnHJRLGEBrp
 tK/xODv5yDMvzoSi2IZ/WfGg4MpUE6tUaeB7ITNDMYNtBD65pUx+GLWfX34iCm+po2O1
 YBNA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8TvfRyrrN2ffvV/uM2mJKrTP7LCRTmA/JqqPRrHkb7H0oYqvN3gYuPaxjAFtSzuOmWDbY4jRMbKlk/@nongnu.org
X-Gm-Message-State: AOJu0Yxb02DYioEMEVXJ4dblBwQW9r7dM9U5nosvtu9ig3sy4hcnxfPb
 yk47Wp+kDlk8Hb3iUOzfZBqyAE3i7lJZbtC51UClI89rYLISf8U809ch/uJQNbu+r5yD7Fq2+H/
 tqTKBWrLHyMS0Va20vEo9QzuvmQmK2FMnda7oifK1OgY4hexe3K6Bj4fM9Q==
X-Gm-Gg: Acq92OFqOM2N2fsSnfgVhP5qaqVdD4WFGduHVYfTsP41+uDb7WDaLji32W9YPGsqlBG
 z7KTm781ClSwNNkZuZFXfeOuV0H4jUxdgx6r8yC/Lrybfcy7ZUS2Hevru0eeHnNTaDopgs46pr9
 uOAB4XeS8tgKGSsXVatYaUGh5ttuZtO6Gnh4RdONZ8k7JMUfD1Uhq5GJoCn22z+7xCBTWTS4g4H
 HctdT4XxS9TOb86uc7yR1fGdav+Sgwg0EG3rWuhel5jiuKTd7IETcOodfdexQDpZwhWcfc3wdYl
 EJXLRuf3h8eBm8jdm5Z0cJkTnOX/H1CKZ6n72dbtBCeqk5HFCTX4uNykSwecheaFnA6HayxT38Z
 1HO/o03pEGAjgCS+gIDY6PPa6I3RX4oi5x7Bf1IOVD7PJliPAnDNJPH4=
X-Received: by 2002:a05:7022:ead3:b0:130:6904:e817 with SMTP id
 a92af1059eb24-13504a52c62mr8189335c88.39.1779201203165; 
 Tue, 19 May 2026 07:33:23 -0700 (PDT)
X-Received: by 2002:a05:7022:ead3:b0:130:6904:e817 with SMTP id
 a92af1059eb24-13504a52c62mr8189310c88.39.1779201202547; 
 Tue, 19 May 2026 07:33:22 -0700 (PDT)
Received: from [10.36.20.156] ([24.52.49.135])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-134cf44668asm19480935c88.6.2026.05.19.07.33.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 May 2026 07:33:22 -0700 (PDT)
Message-ID: <4171cf5a-2567-416c-be21-f74fbeee6af0@oss.qualcomm.com>
Date: Tue, 19 May 2026 09:33:19 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/7] docker: Remove LegacyKeyValueFormat warnings in
 non-generated files
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Max Filippov <jcmvbkbc@gmail.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Song Gao <gaosong@loongson.cn>, Cleber Rosa <crosa@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, John Snow <jsnow@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20260518102222.80735-1-philmd@linaro.org>
 <20260518102222.80735-7-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260518102222.80735-7-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE5MDE0MyBTYWx0ZWRfX67w20Y6QoYuT
 +36i8alf1lrrUtTFVkp1MmZZKca9r4AzrxQibuOyrRH4WgKonSg6YPVskFJbIXtql6svKv/cnYb
 lbGQ8+JDFpwv+XxmnEt/9HFHuDYsYdcHZNJMNo0yfPPrLUFI1PeewZB5SiPaEQoY/DdBtP0i1Yx
 bu7ApwZybcKZ3JXDZHKvNU7IuOVZEsH7FXDDlPLaYtiGFOHASxtX80UMupV+C40kPKe8Bgm7xhS
 28gf6SwDHPYdj1A0Xyh50KqQ/ky6xeHt0JBOfbRh9CuU7fNtVAslMuc0QUj/xog0sAx8Gaqctfj
 C8+Sr681hu7yeAuIAbxSO/0Xj+I2XmQP5qiNNRTbnRyUV+SJWo31TlA1FbMrbeCGahnTzqvGJPs
 xIZxdBbE6hyhMCk374jyObe0VVJIc4dj0Lhg1CaBrh0ww3W2qnbfzGKFB0ke7UYwpVHUacfA4l9
 q2U9HS1vzpqqYAtfdbw==
X-Proofpoint-GUID: iKZQ85Q0zhioOZPLStjT6g5DQ0-HZC-x
X-Proofpoint-ORIG-GUID: iKZQ85Q0zhioOZPLStjT6g5DQ0-HZC-x
X-Authority-Analysis: v=2.4 cv=WZM8rUhX c=1 sm=1 tr=0 ts=6a0c74b4 cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=bunxBM7YXCFQTret8gAQLQ==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=n6MYwUk4AAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=p6Oeh3WBiOopVHytevkA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=Kq8ClHjjuc5pcCNDwlU0:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-19_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 suspectscore=0 priorityscore=1501
 phishscore=0 spamscore=0 impostorscore=0 adultscore=0 bulkscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605190143
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

On 5/18/2026 5:22 AM, Philippe Mathieu-Daudé wrote:
> Manually update Dockerfiles to not use legacy 'ENV key value' format:
> https://docs.docker.com/reference/build-checks/legacy-key-value-format/
> 
> This removes warnings when building / using the containers:
> 
>  - LegacyKeyValueFormat: "ENV key=value" should be used instead of legacy "ENV key value" format (line 98)
>  - LegacyKeyValueFormat: "ENV key=value" should be used instead of legacy "ENV key value" format (line 64)
>  - LegacyKeyValueFormat: "ENV key=value" should be used instead of legacy "ENV key value" format (line 97)
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  .../docker/dockerfiles/debian-hexagon-cross.docker | 14 +++++++-------
>  .../dockerfiles/debian-loongarch-cross.docker      | 10 +++++-----
>  .../docker/dockerfiles/debian-tricore-cross.docker |  6 +++---
>  .../docker/dockerfiles/debian-xtensa-cross.docker  |  8 ++++----
>  tests/docker/dockerfiles/python.docker             |  5 +++--
>  scripts/coverity-scan/coverity-scan.docker         | 12 ++++++------
>  6 files changed, 28 insertions(+), 27 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

