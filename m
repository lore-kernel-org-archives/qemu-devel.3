Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7956A606A31E
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 19:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=jjWW5Gxd;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Z4yoIkF4
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMVke-0003eQ-Kd; Thu, 29 Oct 2026 15:25:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xMVkd-0003eB-0D
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 15:25:27 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xMVkb-0006Vu-6a
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 15:25:26 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69TGDJOP1654959
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 19:25:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 XOOOEhq7Li7CpWfz8dd2DTsSOOvArNtZC471RC+vh+I=; b=jjWW5GxddYkJOeyt
 4LQEaFGW8SR2OaaSj6x0VmB1/cBkGjqBZbO8rdyyzP2tt+7oxFGniBiS/9G3geV/
 nBOZrsHkfhGPRofpRVjBryb9/TTv5q5Ua3aNBrNY7jv+3MMqG8VMqbI4dkVAM8uj
 n8v2fthp4a+yZm+bv3pmhptDHZZxrmVKzSBfP3dXP0YX9yece/VbYzkJu5B+lU8R
 84F7TyAYQQPtGbhc7OhTRzPGnTL2fG3UQCacva/X9Xvv2KZlD0x4MGwgBy4u3lmA
 4GV8owAGQVpVPax4UqjmDHp7jbp2s9TWzQt5+C1cp/Eu1UbmVjrsinZG1v0f0sV3
 x06YSQ==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hm4a22e88-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 19:25:22 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-35c5aef2a74so112493eec.0
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 12:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793301922; x=1793906722; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=XOOOEhq7Li7CpWfz8dd2DTsSOOvArNtZC471RC+vh+I=;
 b=Z4yoIkF4o3wc/TmdwjJFV2srFNZfaRn0BthANUJWdR96tYg79864oVzMkMwrKIkFph
 x0IXbahJtFnJNZJPvKBi/jtblewEycRpwJMgmjsMUdWzSm6SRFx54Yge3Do+Jp6XlXXZ
 zCN60cahOvDwsgL3dhv7s0q/fZufUr2jTlbwIsv6Z6SnwISgVoGurAyTZnt4xRC/x67G
 KxdvIzfkvBAqm2chwWlrOhebSpUddzbJV/e9/A2EG5rWVLwIBouXqKJvFBWKjAVj0bSn
 cJu5Qu5uERLSLx1n7QxEiLDqW+2760NsdqX3gcKFdLVq63YbsAEgv63jbJ1IH85vSxmH
 1FTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793301922; x=1793906722;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=XOOOEhq7Li7CpWfz8dd2DTsSOOvArNtZC471RC+vh+I=;
 b=RW6uz/hka0YKLPklvrGw5fiJz7yGScuSmdKlXk7GLx7dFdrG3Byq4kt/gOJqLHEAzB
 2NUnUwgLiS8NzvPbGLM/1faixgRClVRY1HM+sP3yyYQcI6tdNGgnu7rWur5i+TRCs41G
 vR7vcuuaknzoOsNyzhzO7QyPVxpZrHeQbkxjt0+cOt/CjjFPTZzzEqYQqNCRpLo+6f5/
 OtlY49XJzBiYq8cBdDWohZSc0BuzA4FafPEaT2l3WLD/m/hO3+fh8FS9snfYBpxYQwyA
 eF8FT7P+PsPJ1Y0WunxbdYs4Jonq+Ujf0YPWREP3bn2qqpfm3QVG8cQi8c1vj7H+SXHk
 kTzQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBys3+cIUmsr8JueORcZK409MqEeiFQ5CDL/jlSb0qaESTLzd2FEQlIVBsKFxuv7stukUXHUP6M/r2UR@nongnu.org
X-Gm-Message-State: AFq9FYKiYi0eV+e07JDRDwEF90ua2IntrZanHpNWDzLWviVsWtnMHrRO
 FDw7Pvk34dUijOAoXkTvO/HPTCA6z4mcXeFWOxOE0qpYMev8LNvC4Ctn7cikqUclC1G0uAr2DM6
 uhW2kZan0VI4/464VCkbhv1pZOxWNAbFOQHnAicmh3kPNVto9T4Vwvu7zMUcsvzb71A==
X-Gm-Gg: AYBFou2ljP69a6iCl6XFb+0d7FWlV5/lMP428VJv65ybAD5EXU1tgpChh7up/GoP3D4
 0gLa8u3GP5xzSMY59AeBSF47paER5Aas0Zb/ny+Ap9DYCWAxYCtHu8z7oks9x4sPi3oM9m9DS1X
 4xHHb8hH40Vh7trew1fP8MC3DcIh9Cbplfs16JiqMPPQAvHrDFZpgck98fB7xUVwh7on50Qjrp9
 5ehLznmihnOv9xDqZ7odXO/mRYEdzdGrK/ZsZdWkvXUZSk0kNUQPwZi+pwRAkzeH9sSTqv+B4wV
 Oqvq5o8rmOAZSBLS3JWeaanDQURBDuMAmby5Ix+Nl9Zyykp++wbPt6IAnWu5iGk0Cu98/bsi4Gh
 N6Wr7De0XakK7H9BYcPXk3G2GgSciFkmNygETOES8K3WosD5DqayQBgrhngB22I3WEbay1N+4ED
 wgbA4RHeVhRFa2Jl6+XAxVW+wtpppHdgj60qWa2s9DwSc=
X-Received: by 2002:a05:693c:41c6:20b0:368:c6b9:d3c0 with SMTP id
 5a478bee46e88-36a423cfcd3mr423164eec.28.1793301922166; 
 Thu, 29 Oct 2026 12:25:22 -0700 (PDT)
X-Received: by 2002:a05:693c:41c6:20b0:368:c6b9:d3c0 with SMTP id
 5a478bee46e88-36a423cfcd3mr423125eec.28.1793301921570; 
 Thu, 29 Oct 2026 12:25:21 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36a426681aesm889849eec.1.2026.10.29.12.25.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Oct 2026 12:25:17 -0700 (PDT)
Message-ID: <54734d4b-6b6f-45f2-a371-0abd2487afe5@oss.qualcomm.com>
Date: Thu, 29 Oct 2026 11:25:04 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/12] meson: Add the tcg_tests_cross_cc/cflags options
 for mips32r6el
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: Aleksandar Rikalo <arikalo@gmail.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Aurelien Jarno
 <aurelien@aurel32.net>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20261029174434.27985-1-philmd@oss.qualcomm.com>
 <20261029174434.27985-3-philmd@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261029174434.27985-3-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA3NiBTYWx0ZWRfX4xtqnknnj0y6
 dY6ct8kfu/8oUbAT99mXbG+OT9i2GFkKGq68d8VOXBETPXWMmng42O2GqrRHStvwqd+OTtQCqJw
 28+nw04yotf2vLYRSLxW+SdiN+fDmJbJwkDSK4+8SioEu7VKIRqDFf4zflccCliIozgNLXo1Ak+
 +kU0aIkmvFqAf/i/e1BiYxTIsL1n6uN7lctvoCN4FqrxzLFXA9RTvQ5s867h01C83yFB2c/s2rS
 poMf0A3kFvVxlh7rwEP85VkWB1PC2twwJ1YQoSqaVuENRsYkx8sI5Z5PclTo0TvkdW19cLmV11O
 lJH+SEgFu74IXfEDsfI+t3/yH5zYoeI+qO3kutOqNVpB1VBvgJPMYrNHdMZUQ+NHsYlnEWlUpdU
 X3FcNbkZU3UIgIil7DuoZ4zy0oDdnp4uk++XJkgJzG2YSWyTd8tk3lqtEFRuk0m8Qq+SmUkFeE4
 sX6EiYW+ZimwnwlQVsQ==
X-Authority-Analysis: v=2.4 cv=E8tYNqdl c=1 sm=1 tr=0 ts=6ae39da2 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=U4UPyUYTicQeuGa6yhYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA3NiBTYWx0ZWRfX5enW+rE1Pc/g
 FySxD6UaAg+hzxq+N8UpL79NU7ReravOvmUYutvrSj5f8MP2UJvGKPf6+DArJZdBSFHWecGeAcR
 fmDP4TikKa9na37d37cA0pV5FW/cZpc=
X-Proofpoint-ORIG-GUID: AdMnSZd_3im5-mOspJmdSw3_zlKkrAx6
X-Proofpoint-GUID: AdMnSZd_3im5-mOspJmdSw3_zlKkrAx6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 clxscore=1015 impostorscore=0
 priorityscore=1501 adultscore=0 malwarescore=0 spamscore=0 phishscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610290076
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, KHOP_DYNAMIC=0.001,
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

On 10/29/2026 9:44 AM, Philippe Mathieu-Daudé wrote:
> Add meson tcg_tests_cross_cc/cflags options for mips32r6el,
> similarly of the previous mips32r5el commit c7b1a7bc9d33
> ("tests/tcg/mipsel/mips32r5el: add msa tests"). This allows
> compiling TCG tests for the mips32r6el-linux-user targets.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> ---
>  meson_options.txt             | 4 ++++
>  scripts/meson-buildoptions.sh | 2 ++
>  2 files changed, 6 insertions(+)
> 
> diff --git a/meson_options.txt b/meson_options.txt
> index 895c6e63c28a..9ae8e44ab54e 100644
> --- a/meson_options.txt
> +++ b/meson_options.txt
> @@ -461,6 +461,10 @@ option('tcg_tests_cross_cc_mips32r5el', type: 'string',
>         description: 'cc for mips32r5el tcg tests')
>  option('tcg_tests_cross_cflags_mips32r5el', type: 'string',
>         description: 'cflags for mips32r5el tcg tests')
> +option('tcg_tests_cross_cc_mips32r6el', type: 'string',
> +       description: 'cc for mips32r6el tcg tests')
> +option('tcg_tests_cross_cflags_mips32r6el', type: 'string',
> +       description: 'cflags for mips32r6el tcg tests')
>  option('tcg_tests_cross_cc_or1k', type: 'string',
>         description: 'cc for or1k tcg tests')
>  option('tcg_tests_cross_cflags_or1k', type: 'string',
> diff --git a/scripts/meson-buildoptions.sh b/scripts/meson-buildoptions.sh
> index 14990966d31d..0f8b56bd7f8c 100644
> --- a/scripts/meson-buildoptions.sh
> +++ b/scripts/meson-buildoptions.sh
> @@ -539,6 +539,7 @@ _meson_option_parse() {
>      --tcg-tests-cross-cc-m68k=*) quote_sh "-Dtcg_tests_cross_cc_m68k=$2" ;;
>      --tcg-tests-cross-cc-mips=*) quote_sh "-Dtcg_tests_cross_cc_mips=$2" ;;
>      --tcg-tests-cross-cc-mips32r5el=*) quote_sh "-Dtcg_tests_cross_cc_mips32r5el=$2" ;;
> +    --tcg-tests-cross-cc-mips32r6el=*) quote_sh "-Dtcg_tests_cross_cc_mips32r6el=$2" ;;
>      --tcg-tests-cross-cc-mips64=*) quote_sh "-Dtcg_tests_cross_cc_mips64=$2" ;;
>      --tcg-tests-cross-cc-mips64el=*) quote_sh "-Dtcg_tests_cross_cc_mips64el=$2" ;;
>      --tcg-tests-cross-cc-mips64r6=*) quote_sh "-Dtcg_tests_cross_cc_mips64r6=$2" ;;
> @@ -566,6 +567,7 @@ _meson_option_parse() {
>      --tcg-tests-cross-cflags-m68k=*) quote_sh "-Dtcg_tests_cross_cflags_m68k=$2" ;;
>      --tcg-tests-cross-cflags-mips=*) quote_sh "-Dtcg_tests_cross_cflags_mips=$2" ;;
>      --tcg-tests-cross-cflags-mips32r5el=*) quote_sh "-Dtcg_tests_cross_cflags_mips32r5el=$2" ;;
> +    --tcg-tests-cross-cflags-mips32r6el=*) quote_sh "-Dtcg_tests_cross_cflags_mips32r6el=$2" ;;
>      --tcg-tests-cross-cflags-mips64=*) quote_sh "-Dtcg_tests_cross_cflags_mips64=$2" ;;
>      --tcg-tests-cross-cflags-mips64el=*) quote_sh "-Dtcg_tests_cross_cflags_mips64el=$2" ;;
>      --tcg-tests-cross-cflags-mips64r6=*) quote_sh "-Dtcg_tests_cross_cflags_mips64r6=$2" ;;

Need to update also scripts/meson-buildoptions.sh.
make or make check-tcg should update it for you.

It's a pain, I know, and TLDR: it's a chicken-egg problem between
configure and meson.

Regards,
Pierrick

