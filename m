Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1210AC982FA
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 16:15:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x939J-0007gR-Bg; Tue, 22 Sep 2026 12:15:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x939H-0007fO-UR
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 12:15:15 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x939B-0007Dg-Uq
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 12:15:15 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68MEikkK3924094
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2026 16:15:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 n50aG5NQvQ4+uCU1siEZG8O7ne5kRiFHVYurXYitA4k=; b=Gq9pGBbeJmlP0d11
 M4wQpUTzga0ulTx0dCDNqIhaItZ/sXrzaHBJSShdQiddFrP7LtmaxS/8klt1qleR
 WLY4gLvpCl8MeN6RQrOIFy8T5NARm3yHUu3n7YlsTJqkzbFB0zSJFhH73nHyJWVh
 350RPrvzU1SvPlj0AXxb63i/gVGeZQqStC5WCo8ApDCi/Dv8vnkO5sSJ+9nX4yvV
 12ucZbONj9sBXdjFtJEkaUFLY4X+Et4lnoTe61tSF9Dt2tzZ7bbPvEOzOPTcZDQx
 S0CqSeXzVXREaStFOYFPLnwxmccgSScQRZnUqasGwefffdnUeu/UlDayp/Ss8Xra
 w1vbaA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4guuec0kmv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2026 16:15:05 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2d6df0a1e18so103555ad.1
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2026 09:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790093705; x=1790698505; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=n50aG5NQvQ4+uCU1siEZG8O7ne5kRiFHVYurXYitA4k=;
 b=bdmXQ5s2x8xlq9DovG7CI51aW1QwNPwYw6YSLFohBruswoSbyCLdBcVly4UUHeZNFd
 3MwYi2GNSeM8FOcH6xSuWhBsImwUWZ/P8QHA4i21DOsfHMmCrhTw37iBnUO++xfpymPG
 0WMLxP/ngKg3WPWW7XzqY/Fp5Ug6tuwkjqVVLpNJVgpLsNWas1Bgyoy3WMuB0MqIPV5t
 2tpIgxgAVo/vHYyVwlKQL8pASh7axSyeX+kloaqqIaJ48nwtqGF7j10E+GSsfB7UEftg
 gTQ9O9DKlBORhv9UC0OJk0hXQCD5P94qFysV8zqlKzFnMp2lXzMVz2jAOOMrBKKmmGaY
 8ptg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790093705; x=1790698505;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=n50aG5NQvQ4+uCU1siEZG8O7ne5kRiFHVYurXYitA4k=;
 b=X1uchbY570W+FaqqP55Wsx2X0Z9BCKoXi0508rV8oUQbK6kCq7lU2QAmM2TZARyNJ1
 hNU8n4kOPUUD77ne3btFUIsKj8nP3jrQ7qooqk5uygdQvgRW0VlVXX/RVcYkLchyTwty
 tQVP/lvfCrh6vwXFa6Cllhv5vXtjtgGJuAK4ykz2qQ+LBnONn7rHd6h2oUdugiM7P0cs
 vs7te1kWkU1r6jsdpykhfg/vj4qqqnqYPP2KrfUKOraPxIDWb5fbJERywnttsseuANYS
 2NgiRlEiryEHgY0jmoMzyDROJkUAr2z3z5QzH08FmUkMx7I1yW8AAneV6xDOdfi0U+Rr
 EDGA==
X-Gm-Message-State: AFuF++laUNLMj7tQe45R8csCeyyKX4q41Fj2i01LRQJQsTeLFhCavy0G
 kQrhBo1kAoXdOy4SF0DJ3l/7u1fxSTVWH6EUKpOLdIVQGng/qInJPUrAIfrJTJUBcjl4XdSaaKb
 qwtiytdab+iiOqBJyfWEE6Wnzr4EoIY3IXgstAKVkWKN7C5zTSIcSy/4XxyS2zTyVLQ==
X-Gm-Gg: AYBFou3O09axVVhhGOqsRbYiYWZtfCoo4eFJFueRpZnY47vS5Q0Y9767S1cktlTYehb
 BIAytudCsAsnkxmbJIR/focQspOv2PGqfpMe2GFLx4LeGluk2jO/Q9kvDT1TpaYb88kUqOYijIX
 hwAqbNhUvXjdks4G29KB9LYMVP02QYocAhOKqWcHBHTiPm0Imcb25kTJ3LzK5pWNpmZpP4OQ/qL
 7plN6rvseaJXY66sRVEhGZRmtVETlzoVP4g9XRZCenixnkop0RsX/R2SvJ66AimmCLqjwkFqgRC
 HE53r05I+7VxYG08XZcdBqK+ztbn7BCZpTlqTpe5i1g9Baxnmk4N2gYZwFuIlhxX69G8EW5NtBM
 VFwOOopJdf1lqGeCfV93r5T76AmiM1H6kLulY56cQfnU+5/Y/m6jrZuF5vyeg7vPB+mI=
X-Received: by 2002:a17:902:c40c:b0:2dd:b281:8d44 with SMTP id
 d9443c01a7336-2df609b7c9dmr21974975ad.13.1790093705041; 
 Tue, 22 Sep 2026 09:15:05 -0700 (PDT)
X-Received: by 2002:a17:902:c40c:b0:2dd:b281:8d44 with SMTP id
 d9443c01a7336-2df609b7c9dmr21974565ad.13.1790093704475; 
 Tue, 22 Sep 2026 09:15:04 -0700 (PDT)
Received: from [192.168.1.199] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33e6129ae9bsm5463163eec.11.2026.09.22.09.15.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Sep 2026 09:15:03 -0700 (PDT)
Message-ID: <4207d4f8-a452-417f-b240-77cef59b7d54@oss.qualcomm.com>
Date: Tue, 22 Sep 2026 09:15:02 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/7] tests/docker/dockerfiles: refresh images
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
References: <20260921231458.3369-1-pierrick.bouvier@oss.qualcomm.com>
 <20260921231458.3369-3-pierrick.bouvier@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260921231458.3369-3-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIyMDIzNyBTYWx0ZWRfX3xCqKUi3e4EH
 BynWRxXQ6FODbwTXAUzJiU7DV0rxBuv4ODhBNLjV48plQFORFueIW6VUM6bdVJrG4SlF6yV22oz
 W0m8SghMyVcQbMa/WEUZ+q49eIIIoTQI5v7Kt4wDCtFHbAv/JL1aikw3rkNrwZhkbNWEF8FpkND
 Z3O4IvyinjUMPY2VszUuT6aRQXFkaYyOJuqaiS6lMmy9irRwzfjsEz7nEGAaKy2nIkfBUwwdl2e
 pYPEks+0ckNJnE5Wx85oOADhWLlz8HjHR4QFB4aeIXCquUtjqjvptrgZEEQ8jSxjsVaj3AsoTM9
 qi2HQkziT5HyAc0+HdIqwNzEYSexbYyMfBr/2Dj8asIm0l6RFHJwO+cZJIfXce9PlDimiJDD+H0
 0wqllSH/4yk+0Ci/5rP9AH8JGM4kph2HfiH0lSpxJHHd+JyCkudBdcS9KzBydXhIy0CvTMvADlZ
 P+QqBGuUnKtRaFNdwKA==
X-Authority-Analysis: v=2.4 cv=VKdIDNPX c=1 sm=1 tr=0 ts=6ab2a989 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=xeqQcB0Rbcjnpua9woEA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: GgZyrV2nSqU0pVlgByE4D_mKAj8kuy3d
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIyMDIzNyBTYWx0ZWRfX5lcGlbL0mXB4
 zdupyLEnbWGIaE/GR1U4dgTGp5FgF6+KABG2HivjBg5peHkEzo9SXF42FtU1BDYETmhVx+BYxfl
 dB9oJoRXDYwhYMItw5l5ibgs1K2HGaY=
X-Proofpoint-ORIG-GUID: GgZyrV2nSqU0pVlgByE4D_mKAj8kuy3d
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-22_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 phishscore=0 spamscore=0 malwarescore=0
 suspectscore=0 bulkscore=0 clxscore=1015 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609220237
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

On 9/21/2026 4:14 PM, Pierrick Bouvier wrote:
> latest update of libvirt-ci changed packages, but images were not
> refreshed.
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---
>  tests/docker/dockerfiles/debian.docker     | 1 -
>  tests/docker/dockerfiles/ubuntu2404.docker | 1 -
>  2 files changed, 2 deletions(-)
> 
> diff --git a/tests/docker/dockerfiles/debian.docker b/tests/docker/dockerfiles/debian.docker
> index 77869f71546..2d03ff03c8d 100644
> --- a/tests/docker/dockerfiles/debian.docker
> +++ b/tests/docker/dockerfiles/debian.docker
> @@ -73,7 +73,6 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
>                        libpcre2-dev \
>                        libpipewire-0.3-dev \
>                        libpixman-1-dev \
> -                      libpmem-dev \
>                        libpng-dev \
>                        libpulse-dev \
>                        librbd-dev \
> diff --git a/tests/docker/dockerfiles/ubuntu2404.docker b/tests/docker/dockerfiles/ubuntu2404.docker
> index bb8f4e4e53f..440699a5005 100644
> --- a/tests/docker/dockerfiles/ubuntu2404.docker
> +++ b/tests/docker/dockerfiles/ubuntu2404.docker
> @@ -73,7 +73,6 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
>                        libpcre2-dev \
>                        libpipewire-0.3-dev \
>                        libpixman-1-dev \
> -                      libpmem-dev \
>                        libpng-dev \
>                        libpulse-dev \
>                        librbd-dev \

Dropping this patch, as it's incorrect.
In libvirt-ci, libpmem-dev is a dependency of targets debian-13 and
ubuntu2404, so not sure why it removes it here. Seems like a bug in
libvirt-ci itself.

