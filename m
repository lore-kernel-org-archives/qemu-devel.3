Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D21BBC44529
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2026 20:28:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlubD-0006Ur-Kt; Mon, 20 Jul 2026 16:28:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wlubB-0006Tt-LJ
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 16:28:25 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wlub9-0001Su-K3
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 16:28:25 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66KJTgck3622334
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 20:28:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 XpijVZZX/OZ2BWanp89fg3flxVIA9637kv80lTyTQqw=; b=FwtTxdLhZb0JCODm
 BPJiOC/N/H7a/1OWuTtHwcvLWCZ0cFXg4Nq8ezpa0tfUFx4aKsiSZR2Ft8/b4QW0
 zcQmho7oJNMdh2guvY98MehhsRB4B9215yLinweXigGNEeQSdsVcyq/AJK4iy+th
 aiI23u42F+8yG4D0c4Fm/jO/GapxYMpN7n9i3N6fEO6encQmh8V/B6Mu0fK8WG1Z
 xgeB/lnUoo203zXtkX7JV45yiwjflg7pTnuy5nrqdTMGaxeELMRWKYq5Jp9fuppH
 Z7OiquwYnrOisLY97uy4k8Pgn8gtT2M2gvrI32c6XQ02yW2tZ1S8G62bI+EE5L2f
 Fb9uPg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fhfvxk8q7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 20:28:21 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-51c20762d21so99379141cf.0
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 13:28:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784579300; x=1785184100; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=XpijVZZX/OZ2BWanp89fg3flxVIA9637kv80lTyTQqw=;
 b=GDKkKJqMR70C7nS4niOIajiEUzf6qD3K1w361ZY8UjVrIcT4qdOJv/bNkEvqSrXhdb
 QwfvCaNurRHXMywoKfp40ez8XHnA5aRZm63uSVFJYHBGHIdwFZbobcDFkS9Locj3wb60
 gUmBdIKHAz+AWD4cBw2RIVrusvwmcp3EQX6Fszj5qsNi7L0NljnQtKYVDb7xra/ic2jv
 17bPk0a3nWdbM9FyacPCoeqZxK2jlpshZsBbCUcQke3bbwRxlx5H8+knxdd8j/KLglFX
 vvgqa/YrJ1ZyxohRG5YnJWwsYUgdqxbf7S1sn5KmrkrNmjNUu2LAIm9ZoMcuotWbSzzN
 vPSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784579300; x=1785184100;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=XpijVZZX/OZ2BWanp89fg3flxVIA9637kv80lTyTQqw=;
 b=TnNZ8bC2q8jdfRtA6DbyalOERS6wGbGCiLcYzpu8/4bOgWxJjm+APuUdlCA9LgX1YS
 Jo3eqmoxZjwGteKULknBzv8s54600Ohk3qhoTnWLaAfLTe/vVyGia+hUoCRGphEuv8AH
 gVXNB6zq4BpacLhBgtQfoMvzCo+AQe1E1DnKUonOywyQQWKJKLj0FzXTYWSkS7FEAPrD
 XKdulY2Ihfksi3w2O89aRmVLdD+ZEkOmyE8IHscosPkBLhByGJVCBagm7ovqvNpb40sq
 aOAcFl3qfr45hmKlL4xQUmhMsTeqET2fy3Ud2eGlGFyK1K0+8F3bn+/DhDO89QR5QvL4
 cFCg==
X-Forwarded-Encrypted: i=1;
 AHgh+RoYl1E4JhPA/fB/ea+zasDSGIjLY4/wwndQgsL09a3wbV5ZFEqccA0nXXhyAsrHvAn2FRsjvHzUxq5+@nongnu.org
X-Gm-Message-State: AOJu0Yxq7ZETyRR5LVN+L/E78Ac7QRru9mk400GffDRxqKgysITme8fn
 VjqMERBbvfDY6ED/fbTSzHG8oUg0xOekGf1ftdYJilcEGEiGYR8WRYRVGmNU3ynF8aQ+xZcFsEX
 u0V+iv6lBTiVMzxqpy4p0E1Wzi9n8mj9ZwbCxK0nExb0lse0k5IbQq+QR1g==
X-Gm-Gg: AfdE7cn0Fp8a2RDadizRi5ZLNeFAG7u5FaWPInCftJdjofbYhO72CaCFFJpbNt+34Wv
 xCdXeyV5iM1jQqZJiPbaA7nwZdv8JnfsgtkkFlpfLvq9fJbQTBErmfdkaCXj1evvo88IO5x10z5
 CiBY0kE46FCGhf83rMyaMYW8M9VxQXtQA34bTIAf6YXXtxM+3T/Qk7U1UfJLnRziI25OpnhEsR6
 3WNw/y9SV7ed6+R25+Y5Tz80ChKqV05TJcy2S6gIX8AtX9LGgSQeHXduvM98E+ka26JhmabIiKp
 E0r0Jg1Ufhf4GtUX/h9GPT+RBgyhkkqrAXHMl1GxW1oBpfDXOgxMaA7KO+A/blEqccUYLFKAWaE
 cbLPkf4W7qqhFhOXYt28mp+bjrg0hsfdjYmkQ6kOXWmoWDoaoN2Q=
X-Received: by 2002:a05:622a:2b0f:b0:51a:8c99:1f14 with SMTP id
 d75a77b69052e-5213eb7c912mr154172221cf.67.1784579300381; 
 Mon, 20 Jul 2026 13:28:20 -0700 (PDT)
X-Received: by 2002:a05:622a:2b0f:b0:51a:8c99:1f14 with SMTP id
 d75a77b69052e-5213eb7c912mr154171931cf.67.1784579299870; 
 Mon, 20 Jul 2026 13:28:19 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f63e496afsm34051197f8f.1.2026.07.20.13.28.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Jul 2026 13:28:18 -0700 (PDT)
Message-ID: <7d5a7592-85d8-4559-82a0-2e262e5ebef0@oss.qualcomm.com>
Date: Mon, 20 Jul 2026 22:28:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] gitlab: remove gdb from MacOS jobs
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
References: <20260720180459.2542918-1-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260720180459.2542918-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=HKLz0Itv c=1 sm=1 tr=0 ts=6a5e84e5 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=KKAkSRfTAAAA:8 a=3PbSliMuyj2uv0RB41MA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDIyMyBTYWx0ZWRfX6R7y43jXBMXS
 pYoHXdmfkLkXId3jiKuvxZg1ab9gTvefSx3mTzJH4jUj+fng5Dw4eEVwwP3WSh84DJL7Zb46Hqb
 TXRvFJtMekjNcu3rxod/1NOt+Mj+HYo=
X-Proofpoint-GUID: 4ieGmcVzAVgdhp-4rcHJ_RhuVZQ2iLzx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDIyMyBTYWx0ZWRfX+TsjqQsK/3gu
 Fo0ZrXqAemewNZyhKuRnN6Akf0m4bxhEf4tcmom/QwvK6oDgBLYiAVjLnZs1hvIJ91gVflQu9I4
 zLWFBYtRvE2vKylv+65QnaF+j5KDbeUV5YYfagXffPs1UU4BmoAIJIs5QLRWksX/pEqx+md4u2G
 mnxUdt/a8saumKCcB8eSZzoOWB0d1SoH3nSMzEjB7ni/4w7Xhho1G6G/zJtwtA389q4bv2BjkrV
 X5a2J3EmBC70AD+oJkilK53+DPgLrDh3h0CPNND/49NmANGyLeG8pcZbBlRWOum7fD9PUerNGon
 tE54pDA17lj6psbPktCbsziZn/qd+tcZp8uKF+AJ2SdJmBIie1IYdyjtfe+k8d+9zXN5n/HN0XY
 aK7dPZk0ZnpIQsPmqAbuvaCNWBLQYSwNL8DP/sSusw/vZYDh6qvhOHdmO+NCy2bRRw73pFKao51
 vxHSnhz840RzVjhvWJw==
X-Proofpoint-ORIG-GUID: 4ieGmcVzAVgdhp-4rcHJ_RhuVZQ2iLzx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_05,2026-07-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 clxscore=1015 malwarescore=0 bulkscore=0
 spamscore=0 lowpriorityscore=0 suspectscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607200223
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

Hi Alex,

On 20/7/26 20:04, Alex BennÃ©e wrote:
> The gdb jobs fail on CI

What is the CI failure? Could we at least record where the
CI console fail?

I'm worried to recall what was the issue when trying to fix
this in the future.

> and although I can't replicate locally on the
> machine I have access to it definitely fixes it for the gitlab CI
> machines.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> 
> ---
> v2
>    - better commit message.
> ---
>   .gitlab-ci.d/macos.yml | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/.gitlab-ci.d/macos.yml b/.gitlab-ci.d/macos.yml
> index 53b6e6c4d8f..641a48b3832 100644
> --- a/.gitlab-ci.d/macos.yml
> +++ b/.gitlab-ci.d/macos.yml
> @@ -22,7 +22,7 @@
>       - export PKG_CONFIG_PATH="$PKG_CONFIG_PATH"
>       - brew update
>       - brew install $PKGS
> -    - brew install gdb aarch64-elf-gcc i686-elf-gcc x86_64-elf-gcc
> +    - brew install aarch64-elf-gcc i686-elf-gcc x86_64-elf-gcc

Maybe add a comment "# we ought to install gdb but ..."

>       - if test -n "$PYPI_PKGS" ; then PYLIB=$($PYTHON -c 'import sysconfig; print(sysconfig.get_path("stdlib"))'); rm -f $PYLIB/EXTERNALLY-MANAGED; $PIP3 install --break-system-packages $PYPI_PKGS ; fi
>     script:
>       - mkdir build


