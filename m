Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7664DC79F82
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 20:08:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2aCv-00012u-Kb; Fri, 04 Sep 2026 16:08:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x2aCv-00012l-1I
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 16:08:17 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x2aCt-0000yD-Dr
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 16:08:16 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 684HIEgo015992
 for <qemu-devel@nongnu.org>; Fri, 4 Sep 2026 20:08:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 aF5EBrRNJiCbQziP7rbqFqWMY3Unkj7go9EuN/Lc2UE=; b=RToUyNtqN8bYLRee
 4/c3CWXBK3WlrFou/2yHVFB8e8iaKD9HGbMFrQteSNTFMFr9OmO9Z22HvN/adWaC
 MxUoTLOz97ZPEemaJRibTFQrRPyObqzQ2VBgECmVRle67J8tmJf89rOpN2qo5jVY
 xCQidFWWeUPN7763vPWg8HhQ8WzzOEKHlQteB7cz44zuR2KjgquzO4EPj1vp7z+k
 0+DeKUzLl8fIRxzLRAOKtD6di/FkWfy2/AhEkd9gtGClNJv2ELzw4epTelODMazs
 CAEoLKZs6ruu+v1V7VmWenNiuQc8PfQIXiZBXOz6y2chqbjhAws7PbojTHLLjvnr
 31TudA==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gfqqd40ss-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2026 20:08:13 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-cc1c18c775eso2873848a12.0
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2026 13:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788552493; x=1789157293; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=aF5EBrRNJiCbQziP7rbqFqWMY3Unkj7go9EuN/Lc2UE=;
 b=Y8AdsZA850mKQwjLaiXJK1MJnry7RV5fPnRyqYHTvzVSiBXGBZLLLAG6PiyvRMbYsK
 DPv+k2xEiN1VHpxwUD4RwtCiJ3rORSutRhSIEjOzBvk2x47nmNrSrxlc4AX9JHxSL66P
 B+9cPJO/S6arz2vVBzo85N0CeCQIPY+WYebjFaXB27q/6ZIgDiYD2/9V31wnRkhRgOfb
 M9GjRROmS42jZsrbGza+UDyc4PA8mK0ww+GZPMhd8MxZh5M6xF3q8VqeAMvzLCyLrroA
 psSsnRj7rDerEPua2Wp/9hLYAQuRdUEyqF272XxijqQS8k4zc6Yteazr3G3nWkWCkehx
 FciA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788552493; x=1789157293;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=aF5EBrRNJiCbQziP7rbqFqWMY3Unkj7go9EuN/Lc2UE=;
 b=Uet/uYLR57Tky6GVPS/7lgigVJfeyNs5E3cBh3iLiNsjph2foz6EM0yHX5qnK5Yydf
 Vk7fDxgH9DClu1o2QiGi9BGXED7j0NeY1zctVWGrtp0wGB0THCVo4vwHp7sopR9xWDaX
 EEn94jk1sjYp4oW+PiRk9uea+TNJ2DjvGOVtdu5oG7JLfxXps9o2gycbR1f1MBXG90TR
 /Jb1E+ebN2IFcPGNm5hKCGWoctI/VivSlnQEYPTknwZcU/4N6nHmjSuU34s8izCN8cwP
 NBqnYMy0CBy9YB05I5sV0B3tAJ95SCICjGhkbjFwIpVa8VFzOsCexTUY+tdjGujJP5Bf
 M03w==
X-Gm-Message-State: AFuF++lgKRkoRdc522Z2yCOcVTSwjJWEvH8OaHmJRWgp17uiDdRuZHV8
 tTK7aCHzVkU0Qu3/G6g9njlpuL1jOC2cOW0Enr6mtx/x10Rw4bD6yInXLhAniShx/DGSr1vgV4M
 DLgKxigclduAsrgvA2a/llGtYr9ARyARcTCQWgD0Se+MCGyWsND5NLYNsU7zvRA8VIg==
X-Gm-Gg: AYBFou3Thl6oYeeHzmEZBtP33pN55MikAlJxBUsKzS9omkIjWi1Iibd0nxPvAf/9eTx
 gMRXHSywCvS89/4jG0cIxhpiNNfYY+Fdzd0huJVwfjj0o9wOkpfojJOG4aoiqkep6j+TOpvOVoz
 zrBxN9SoCIR22idBbDZNSVpwclhCJB35NYZJr3sANE7ad3cOjdCpIT/vC+XzJcil+OEOn3HVLhY
 wVpzVqp06E1AwOlUjuihMFJ5yDPbhS9qy1Hg7vgsTpJhTLkaq7x09qgnq+Q1KhTDqPoWQY5t75c
 AvkmtAslSsyRYlInmC8H4sF2u3yJK1JvKse6wW8/L1vodadBYoqHUIbyuxwcS7Z7mXagL7n/1X6
 GtcCx8msdk1lBlPUNSUSUVZyxEErSlM4aQk8xahWGbo3u6HhFF92pbSXkOwskgrNMgdLa
X-Received: by 2002:a17:90b:35cf:b0:398:9beb:a2bc with SMTP id
 98e67ed59e1d1-39b0881d765mr17449240a91.30.1788552492609; 
 Fri, 04 Sep 2026 13:08:12 -0700 (PDT)
X-Received: by 2002:a17:90b:35cf:b0:398:9beb:a2bc with SMTP id
 98e67ed59e1d1-39b0881d765mr17449170a91.30.1788552491953; 
 Fri, 04 Sep 2026 13:08:11 -0700 (PDT)
Received: from [192.168.1.199] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3339aa37dbdsm7594828eec.11.2026.09.04.13.08.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Sep 2026 13:08:11 -0700 (PDT)
Message-ID: <24b17d75-47c1-4c9c-b938-125c6095be75@oss.qualcomm.com>
Date: Fri, 4 Sep 2026 13:08:11 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/tcg/meson.build: fix build_test_depends
To: qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20260904200614.2808877-1-pierrick.bouvier@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260904200614.2808877-1-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: j3fJnAVbSsrwSnjb4YFXeVh_YCBWaab4
X-Proofpoint-ORIG-GUID: j3fJnAVbSsrwSnjb4YFXeVh_YCBWaab4
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA0MDE4NCBTYWx0ZWRfX+yFwkZEVpCht
 +LDXWBjCWmwzg2KjGxxfut3kg06RBA8w1le8qB7xpQHypT+FCdAjVcx92WVTrUjl+Nl4sPc5KMp
 Tv7Qo1t1BLW5mAAAp9v+DZAu9Id9p3U=
X-Authority-Analysis: v=2.4 cv=XtnK/1F9 c=1 sm=1 tr=0 ts=6a9b252d cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=vPurY90SqSf-aJcHuzUA:9 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA0MDE4NCBTYWx0ZWRfX3oa46JekscsK
 yvdpAa6sETiKYAMz+fL5R6np/AWjHO2UcLDQWr4CqajwZTRJLo6pNWNuC2BggQHoF4JXK/mUJvH
 NooLEGKZKmLPBi/JENozbdL0jFvmWQ7mb1XAvItRp/4KIBRnrq0Q1Ej3Fizt1BPVpUAzzdLWY5t
 Kc61BarJ0L/RiTR0hiP/3fL8OvueMoPUChXGmYq4YEK9wZZmbC2ht8TPhZXKJpSOTDntRTSWGbY
 DD8Juvf0zHdgiG53r4u883WGvDdVKU7zOcpR3fCmDCmy6rTUHzKpIlopzzHVr3Wje1s7cw4fHzn
 pfyyk/eMiY8RlFEtTitmCAif/7OHR6f5G0HZcYSjH6cfRvj9CF8PCKwiP5HRnrr71X2OZTAk/Q4
 eNYANbdC9axmqLWvYg2i9iA8dBiV+GgK/R29pAdizmTMKtGc390I9EUYS7w07nsWQ2lN3AMrTUZ
 MWfnc+i/EQQq+uilk1Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-04_05,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 malwarescore=0 spamscore=0 clxscore=1015
 impostorscore=0 bulkscore=0 adultscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609040184
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

On 9/4/2026 1:06 PM, Pierrick Bouvier wrote:
> build_test_depends is supposed to be an array, not a custom target. In
> case we go through this path, we have an error with following lines:
> 
>       exe_depends = build_test_depends
>       if 'depends' in setup
>         exe_depends += setup['depends']
>       endif
> 
> where meson complains that custom target has no += operator.
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---
>  tests/tcg/meson.build | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
> index 243cdb5fc8c..d41a228fb3d 100644
> --- a/tests/tcg/meson.build
> +++ b/tests/tcg/meson.build
> @@ -263,8 +263,8 @@ foreach target, plan: tcg_tests
>      endif
>  
>      if not has_cc and has_docker
> -      build_test_depends = image_targets[cc_dockerfile]
> -      build_test_depend_files = dockerfile
> +      build_test_depends += image_targets[cc_dockerfile]
> +      build_test_depend_files += dockerfile
>        mount = meson.project_source_root()
>        mount = mount + ':' + mount
>        here = meson.project_build_root()

Alex, I had this fix on my local branch which I forgot to mention.
I'm sending a PR directly to make sure it does not break configure for
anyone (will happen if people don't have cross compilers and have podman
or docker installed).

Thanks for the original PR you sent.

Regards,
Pierrick

