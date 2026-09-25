Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA52FC9832A
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2026 22:17:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAEEX-0007wZ-Nh; Fri, 25 Sep 2026 18:17:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xAEEV-0007w8-Kf
 for qemu-devel@nongnu.org; Fri, 25 Sep 2026 18:17:31 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xAEET-0001Ty-TR
 for qemu-devel@nongnu.org; Fri, 25 Sep 2026 18:17:31 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68PIoX9x2496484
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2026 22:17:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 s1wB+UvrD553SVSC0X2L3zHjIfhX7QM5aIz9evRktrA=; b=Q58zvZ1UfLx7yXuB
 4gx0IGuiUw9NjE0ue1AJm9B/tiXuuy9V032mcvX8qfpLwN1IZAjTqZbRQyDXH31v
 hLNr6V650hZO8kTs51tESS50sKuD7nBrKOOm8B5jqsgC4jzF5rBLnacHHNrjLeYl
 lUcGnREMobCe6xMpJD/GNLuS3iF8PeW4ZChLKoD6QJ3Ed4I3ZDwCFKwl/dyU3Js2
 G3ExW0Flutczy9LHVkTD5wS60Rpx0JDSvkx441oMbSiKk2k7fMhHRsGFIjNxVdxs
 U/RRrLMW6gUMaJJZ/LGfCEXdw0dvw1u8C/lX9/bXUGRWrPwkn362UwaM12MtUrya
 XmVJFA==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gwjq0bcbj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2026 22:17:28 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-30bcb065bfdso2237808eec.0
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2026 15:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790374648; x=1790979448; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=s1wB+UvrD553SVSC0X2L3zHjIfhX7QM5aIz9evRktrA=;
 b=LfO1UgEhUVzXDYYnaIS8zTXATg1Iz43NT/8NXbzd0L0YKKLtAP48g88tTZpJ0v4iux
 PHzrc5jgyzA97Wp5RRc9es/X3mWQO+Y1HoqDeCu7nJYfegEy/YSdh3Z8i0NZ5EEcqehJ
 oJKdeTq/iPYw/SeQsANckiBzY8Zjr90qxdHlly8eJWIILb67jyXJUkp/sV0aiGwTW/uw
 bXsIR0Rjx+kWkcljS6qrFIJ84CvLTS+vLZ7jOaX4mOUZagRbhsD2OikGeaP1l+iVgGrR
 /Wbg96RUy2LXyA41Ag7sxGpH8fRAEOV5SDFNpn5+ECeaNYzu1tEnfORMUQF4Huhrjacv
 LC5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790374648; x=1790979448;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=s1wB+UvrD553SVSC0X2L3zHjIfhX7QM5aIz9evRktrA=;
 b=rcEWFysOR4QKXgwumpdfgMgZO4EaQzyNYzz/ztm2BtAbUw/+1O/2J3wm1f9JMgaU6H
 kLGDtu/q82XZb0CeaYjrdmIAztPO9L1zy0pUHt3Rxfziy7de+O2fURmdDeJjFB8QYoev
 I0NLIgPpAiLcgXlGt4B3S2YmJVtEnzsudnyo8j+/iktNZMjxUNrFppuLQsSwcrVIwUCt
 W6sKkecGLpzl3N9Ij0R7V00VuPldiLjGMILmwz98D7JjZyEBNQ0WxmGjFbpLhJGS9o1L
 tio7dZupFeXb4h3FkNXz+YFlr0UlKgWPUd6SJPTL4nQ0NHj+5tdhymo35Ojp4PkyVrW7
 DxeA==
X-Gm-Message-State: AFuF++li1D01daaH/9B5COU9+XVrw6soDHrhdaNo+a62/j58Qoq7ICha
 44bFtgWmygErmbNnUhu2iqJ2Wgwv0H23wyYgveOATHi8a6oF5sclCysvoIjt8HxSD2LvVDnkpAx
 SqGgPUWuFcXmBO7ZZhGW7zL9bFWKVFO43qA6xSdVgN8U7TbddPOApz8hnyHvbxVshkg==
X-Gm-Gg: AYBFou1M7DEKbLwp/6XITkXIP7b5peuqILpSCeaTVkxDyMKs2IsQDxFdzOxKeoQcn1P
 VdxiMcvZVx5I3ipKldcU5P9GTqRrvUt0BBU/it/NjnhTYQjlXZwxlyQl3spcURUW+dEtnR4ACTT
 XbshxfqCX19wKxj/unoTiD9WXhDXiA3Gfjiqc0OHmeQ88fchjytx+MboVS6U+RY3vF3URtRvThE
 gnqKR0XbgZM0bTdJdnGPC/cJV44lhT5qIyCIW4Hqp7bHvn7DwMpGrpZvvLgyY15xZm+WHVUWwBK
 HChIAvsgBA6dh41nHneV7mhZVNQ7NM0IgndgoEii613YEyWHOtj7vtOZu9VGMCPmloF1h3M9Wrf
 QTAdmS1pouG/9vplkSGz5Mz0LQMisd4HTf/nzvyV1lnMj89FJE9Rl3Cepeudga79k+uc=
X-Received: by 2002:a05:7300:f295:b0:33c:1ff7:8681 with SMTP id
 5a478bee46e88-342709b7619mr1161876eec.15.1790374647811; 
 Fri, 25 Sep 2026 15:17:27 -0700 (PDT)
X-Received: by 2002:a05:7300:f295:b0:33c:1ff7:8681 with SMTP id
 5a478bee46e88-342709b7619mr1161854eec.15.1790374647060; 
 Fri, 25 Sep 2026 15:17:27 -0700 (PDT)
Received: from [192.168.1.199] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-342c9c245a7sm1252642eec.11.2026.09.25.15.17.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Sep 2026 15:17:26 -0700 (PDT)
Message-ID: <deebddbd-e461-4ba9-a637-0a98c70cacc9@oss.qualcomm.com>
Date: Fri, 25 Sep 2026 15:17:25 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/tcg/meson.build: compile test with
 -fno-stack-protector by default
To: qemu-devel@nongnu.org
Cc: Bernhard Beschow <shentey@gmail.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>
References: <20260924202012.2465-1-pierrick.bouvier@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260924202012.2465-1-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDA4OCBTYWx0ZWRfX/XLxezU2Gvmd
 UU8+DetSjxKs7Y3GxzQCRO9QgzP1r4TnV3D5kIU1e7z21PlGxJvybgHFyzrXLW4swHs8LGAE3H1
 gLO5enTVXK15JF4nEVj7OD44R4XX0D4=
X-Proofpoint-GUID: sZYCi80wQt8C6aa0k6iAqIzLCDOZWcjv
X-Proofpoint-ORIG-GUID: sZYCi80wQt8C6aa0k6iAqIzLCDOZWcjv
X-Authority-Analysis: v=2.4 cv=LNPz05W9 c=1 sm=1 tr=0 ts=6ab6f2f8 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=p0WdMEafAAAA:8 a=EUspDBNiAAAA:8 a=k6uRkFEbn-8eZ543ZpQA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDA4OCBTYWx0ZWRfX2rEMjlJDEI4Z
 2/R/tOmHnduJEsFppEaATq2HU1Uimf7y2jqQ4aBeT4PTJLjm74tLJz8sf9hNhKcqNykt5IlUJEV
 j1b9fJFk8pnpHGGBRuTWYI23F+LrrnBYUs0ZsZhr/v+RxmN6dXX2cNvlne2fwwu5VQqnh4D95ln
 DVZy9OBbGYnEP3pYO8f7koJoDfrAAJBuP5iBoVno4Q1TrHeUHS9xkSocyXpj0TjFhDtDvMmhBnm
 ntj1C7cCGPGoyncfeio3Ucktm01eeVP74lIL1XOmQh8q/3XO9YFMw+voaq/O5nfmuKDA4/hQnMk
 w6dcijpamRgBMni/GRkmFGgSJyriM5r92xyERI4Iw0aqJ9rscpg1LBLcizubF3a+jSOY3tD1w5j
 s6zoFE3x+cvUVrA97IJ6LFNCb0PWBoQz142aJDBNNt4MjGPBAynaem5YiS4ZSweLSHmZYc5CwST
 Co21CTVPK5K4ivhKPtA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 suspectscore=0 impostorscore=0 malwarescore=0
 adultscore=0 priorityscore=1501 clxscore=1015 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609250088
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

On 9/24/2026 1:20 PM, Pierrick Bouvier wrote:
> Some compilers enable stack protection by default (for instance, on
> archlinux). This produce a compilation error on some of our tests:
> 
> /usr/sbin/x86_64-linux-gnu-gcc tests/tcg/multiarch/system/interrupt.c -o tests/tcg/x86_64-softmmu-interrupt.test -static -MMD -MF tests/tcg/x86_64-softmmu-interrupt.d -Wall -Werror -O0 -g -fno-strict-aliasing -nostdlib -ffreestanding -Wa,--noexecstack -I tests/tcg/x86_64/system/../../minilib tests/tcg/x86_64/system/../../minilib/printf.c ../tests/tcg/x86_64/system/boot.S -Wl,-T ../tests/tcg/x86_64/system/kernel.ld -Wl,-melf_x86_64 -Wl,--no-warn-rwx-segments -Wl,--build-id=none -lgcc
> /usr/bin/ld: /tmp/ccs11W6S.o: in function `print_num':
> tests/tcg/x86_64/system/../../minilib/printf.c:45:(.text+0xec): undefined reference to `__stack_chk_fail'
> /usr/bin/ld: /tmp/ccs11W6S.o: in function `ml_printf':
> tests/tcg/x86_64/system/../../minilib/printf.c:136:(.text+0x549): undefined reference to `__stack_chk_fail'
> collect2: error: ld returned 1 exit status
> 
> This flag has been previously added, but was removed when moving tcg
> tests to meson, with the goal to identify which systems require it.
> https://gitlab.com/qemu-project/qemu/-/commit/580731dcc87eb27a2b0dc20ec331f1ce51864c97
> One of these system is archlinux.
> 
> Thus, disable stack protection by default. It has no impact on tests
> results.
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---
>  tests/tcg/meson.build | 6 ++++++
>  1 file changed, 6 insertions(+)
> 

This was merged into master (efa3b9d5ac8024078225e1ab434411fdfe53b457).

Regards,
Pierrick

