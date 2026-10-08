Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAA85CA6017
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2026 21:05:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEvIg-0003IJ-KR; Thu, 08 Oct 2026 17:05:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xEvIe-0003HY-NZ
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 17:05:12 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xEvId-0001Bj-3g
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 17:05:12 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 698L0Mih3386978
 for <qemu-devel@nongnu.org>; Thu, 8 Oct 2026 21:05:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 c0Zih7m+ym6glsxK2AFLQqibQIQs1tkK07RArObHywI=; b=f/83Xyd1MG3Wc6UP
 PwId8YRZ+1WnC7ru34c0kX/Kz2fGv2eWU2Hjku6ruNe0erR6PXnzx7e5FtQb5E5t
 CnmEmVuDE/s0MVt/sQCdugbBHUgQVZQQ+S4vBW1ex4woPLM8RZGV+A6RPuIV8fZ4
 QqMBf46Yb2Sj/u41o/hEByqEa2oyXKHuTaIxhikG/7VJ2h5Ckvu04UQ3A/1LIcYk
 cUK49dPblNofbzcy2VpOhiPf2919Nh0DOygeK599rnC+lItk2XXU0lVx8Ug58h8w
 Gza7sRQ4CwZhJRAtkuNqOmoagRnSSiQdEG2IESZ0f1zkfbh5bZSt4h4T6gKRLiQ4
 aUcq2A==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h6fxrrnsr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 08 Oct 2026 21:05:03 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-34d62bb27a1so1508411eec.0
 for <qemu-devel@nongnu.org>; Thu, 08 Oct 2026 14:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791493503; x=1792098303; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=c0Zih7m+ym6glsxK2AFLQqibQIQs1tkK07RArObHywI=;
 b=OYZ/eMZ9Puher8qIs/UEAxSzCMj8bxXKKpQHYrkYlzHyhcIEgElEOGKouKwL9E4QEJ
 DVlilPNtOUcieVwBcOHbA19McOjaKd4tq/jSbvIGLqD64deKxlz59m2Aena9XFepVWAd
 Gevs1fiGNej27m3iaxDbpd0JxILNK7Hs9RqjDs/fAtrLJeeC8mzS05PpACvWIpDMlFN+
 zFhqdZ6jk7tE7ByGZBeX1N5AEiI1ke7AYdAvrbL0ES3qa9hY5eczoIRZiUNJEHkCJbao
 Giit6bYdoCMCML5isQN7GoK40oh5dqyMiAtdyYPmo/wc+ourhqVqgL0QKIvSjkHyL//B
 3+HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791493503; x=1792098303;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=c0Zih7m+ym6glsxK2AFLQqibQIQs1tkK07RArObHywI=;
 b=UNG78tGI2DTP3QN7IwiiIq3oaVjrWOAhuGq7GNivaxgfwo8kvGnkALaFVf0yj2KJUJ
 vCmw6buptSQIFM5Fc+d35vmFkPpLMi56uJJa7e9iC+OPBSVUxDICMDsmBrI2dwkbwMrV
 Un7FraftRX99ZoVq7uFuhB9I+ayhvU/I5ycynAORIOW2wZ70O6JyaNQ0eUFHipT5kEYK
 4hvG3ZRwQZY9kSslcrX8kavJCuSdWct1Ud5uBrMqPVNLuoK80vkZHzUXCZgFggOLAdWH
 IHvejlk7gViStjWlohtg7q1xxYyu2FnceMh1S5YmkZhhbUUkih0PfZUgPWnAr3eKyeAL
 E0OQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwXcfJLm4x8GJaPG+AnraJ8/QFchTFmxBib0/Cog3Kj4WOWKL/dhzMG3cZ96IDekvg6Hy0ju+bgsNOo@nongnu.org
X-Gm-Message-State: AFuF++lTOzlfc1hV0at907ulTpHPPvRcWP/nNZCPuXsDpyoy/ULcd+At
 yf52t0+w9rJpoSRnUrL+mrHuvUhMLi8awxsQePoCMpwx4fKkBL4KrkpVM8eo2SEbX51eR2SGKJP
 UXxL1Hi8OOxdUyjMR4XYXqwkPFcwzTTeKK4p7FoqKIOjYqGISKOKKiCANuw==
X-Gm-Gg: AYBFou1FrUBlkFGWHouo7RCnsWTkrwVv6k+0zIhf9kJboTosskKourGU0zXy/w6EFkl
 KWBWpwthJq/fTSrmjFZv9BcTfogx4M21ZSMrKUYEGOLGteprYQrf7/Lv2+jkHk66TEeLafzSbVQ
 b3ZY/OltPEV7ecK7cLJYd3/G00hTzlSZ3EXREXqUO6sAW0CjSSVg2FIfvW7BxKUB7hiRcT3VE81
 dIVu3AJjJk42p8OnNwMo20XxarbuuG0Fytz/3Fonozj9xQWfyBkBp+KFggoNZt06Kt9lSTSjle+
 Uw09gmfWo8SHaa3Win57GmoMJ6mddouBG/yzaOaItyGFYXSGXPT9urmfoJgWoX55XgiDo3lsV3n
 JwSFsLRI+czFHQsJIQS8Jhxouvf50Bo4xQWqwoO9yGqGk5SFKp2iGubHL/6o+djrf6CfoeA==
X-Received: by 2002:a05:7022:69a9:b0:143:2984:6517 with SMTP id
 a92af1059eb24-1620966b83amr10779520c88.38.1791493503064; 
 Thu, 08 Oct 2026 14:05:03 -0700 (PDT)
X-Received: by 2002:a05:7022:69a9:b0:143:2984:6517 with SMTP id
 a92af1059eb24-1620966b83amr10779464c88.38.1791493502458; 
 Thu, 08 Oct 2026 14:05:02 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-169a31f6f5csm728322c88.11.2026.10.08.14.05.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Oct 2026 14:05:01 -0700 (PDT)
Message-ID: <a1ea514b-0d80-4210-8d3e-6bdef81b80e6@oss.qualcomm.com>
Date: Thu, 8 Oct 2026 14:05:00 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 07/12] target/hexagon: use object stride for HVX pair
 operations
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, Laurent Vivier <laurent@vivier.eu>,
 marco.liebel@oss.qualcomm.com, Helge Deller <deller@gmx.de>
References: <20261008003711.3984454-1-brian.cain@oss.qualcomm.com>
 <20261008003711.3984454-8-brian.cain@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261008003711.3984454-8-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=E+1YNqdl c=1 sm=1 tr=0 ts=6ac8057f cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=PUtKF3i_0BrShiKzQt8A:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-GUID: EaQVghw0Bd5Z1QQ-Zp3I1c4CabD8feYK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA4MDA4NCBTYWx0ZWRfX8MHBtgZC4lO4
 7qz3JiELME942fhq3V6UeBmMGr0ab8yyVX4OKAN9zb8x9E/FOlwY2FNKZGXZAMoUpXPICR7H4Wj
 shMJul4pmY/IHOrvem5lfpR688rCz6YOzbmlh3ASA8ooRbDfSxKYdPxLn8q8bfWvTfJkOi8VOOT
 /47Y/7ihcP0EI5Y12E8quJl77TQVguY31r6p2F4EHudD1jHiXzrZtbLw4B2OtYdaZYOyG7vdkEX
 Z2bzUVQzHdd/NOuI0LjDE/GiCPyxs24MVUncgVfVRyVfUHFVaIIJkWFShXOr73/SUVsLNQHpJPf
 8Bq/e0qaBN+dz9GfLVcV05bEIQ0AVeLY0yBKqkwE90aBvBAq064sgPlk5tyymeRRHrwZBb8+F57
 2usDF5bj9pe+/yLAEYPKFRQiitJ8Lf8xi4Q1cQscXyGFIue3kTCKHHh6TvsoI8B8w9brJX8TEsw
 5izziTvyaXIQr18vl6A==
X-Proofpoint-ORIG-GUID: EaQVghw0Bd5Z1QQ-Zp3I1c4CabD8feYK
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA4MDA4NCBTYWx0ZWRfX1J+6JkTronol
 Go/QgpOsgKs6BWvAt4e/SzasISuwHDkK8vALTHyfO+jj2Sf8VQTdDyImh9rxJthJxwK445NhoAx
 /z6719OCP2N6G9KjVWhuaTX5r3B46kc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-08_07,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 suspectscore=0 malwarescore=0 spamscore=0
 phishscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610080084
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

On 10/7/2026 5:37 PM, Brian Cain wrote:
> An MMVectorPair contains two MMVector state objects.  Perform pair ops once
> for each vector payload and advance to the second member with sizeof(MMVector),
> rather than treating the pair as one contiguous payload.
> 
> This keeps pair access tied to the MMVector layout when it gains internal
> state in the following QFloat change, while retaining VECTOR_SIZE_BYTE as the
> length of each operation.
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  target/hexagon/gen_tcg_hvx.h | 70 +++++++++++++++++-------------------
>  1 file changed, 33 insertions(+), 37 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

