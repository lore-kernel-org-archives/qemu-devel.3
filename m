Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B468CC44515
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2026 17:35:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlrsW-0003PY-RZ; Mon, 20 Jul 2026 13:34:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wlrsK-0003GF-Hm
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 13:34:02 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wlrsH-0001jc-WE
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 13:33:55 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66KH6hKA3299103
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 17:33:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 GMvmCkAHg82DX/1z1K/QFHL9fUvondlWCqlld60+guc=; b=SQaWTSk9AdBP9DiC
 vWubY0BJEKOxxj/IJNeZc+h77BFc1FJc6VMJ+sdSkjvVJ4LaT5pYojMkdWnHduQB
 umbtd6L4sNlIrZmZqWiFwOPaT8cxQ+3Qr7vqlciW2MErl+wbjS9KCUbxJhJppKve
 yGKNtHCls+IV3UceV5P2WiatXbEp+ozdkjdvsUor7Dx+cjux2rVhXZqZamdEcAa5
 WidEKu+y0xvbU9Nxc/Z3dbYRTg/Zjyje+dv/CXDOWVBLzE9EiUuv1s6rw/DZilJx
 mqPSYlnHQO0dPijYnFEslxWXwhKUnFiO2xhNyp3PTfxakPX0YHVH7snNJGYwkB7f
 tU5ULQ==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fhfvxjk1d-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 17:33:50 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-c88cfe287e1so6528355a12.1
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 10:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784568830; x=1785173630; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=GMvmCkAHg82DX/1z1K/QFHL9fUvondlWCqlld60+guc=;
 b=LipgxdGl43o1YZ75yi4Wxwciv8flfaKcB1UKO/pO+Q645Hv+8ZEm/5XHtB9Z1DzEx/
 wq2F+CiuHmXC2HKYKc6mm5lwR7yJDUf3fJmKELpK1xQKRUz+CREa7K0X6wnl68qnGkGJ
 gX8Su1X8FScpp2gLpHrwjEeIyzBsLAVEu3wsy8bIaneJbGv5E8Yho86+RluGxitImjob
 55fXQH4yPm87+k9iGtvjyMFvSyhdZ6t5GQhQGgaN/GvEYtZjs9+CYJBg++u7E2f0dVOg
 82DkP9YU3SlzK18kC8pRMkRUTTSdy0sPWpoKyoNJln4HR0jHADSr3WjA6FfDHPAZxqgM
 nFbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784568830; x=1785173630;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=GMvmCkAHg82DX/1z1K/QFHL9fUvondlWCqlld60+guc=;
 b=aiqqGONQ8JxCyx7GNaHK37oXe0dZfugUBm4a2Rn2TJ85oSjXnTTH//2f0EHRuJv0yU
 jCH6a4BnF8eHN+qyY73PxHzbUNYqcnHfk3GyzIGYcKdAtVSh0TNZITYh3BSmsA3pAg7X
 pZYnQ0MKvXKvuTJIUgb7QJrAIkiTo6bj2/c4yZJYaJoIKKaFCY5fOswLYxt7QdClS0s0
 gfqqEzAr0fA1UgyB2y7gCwze89fR1tmYkNxKMg7Go/h6TG6idEgUQtTS2SWprlxQhpsh
 qZawkGW1zqb1scccKVM7WSe6ek7vSSgRI25pSYVmfpXg7H6J6A0ALZzV36lzyl/m8hu6
 jwIA==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro1vFc1MvRvOqbiwpcRj2ghV68s/lVwXfqYtxD+gOzMZBdXVtHavNsc9tim2DO/2eCAfC/McRYRTT9S@nongnu.org
X-Gm-Message-State: AOJu0Yx/wkmYd1tsXgda6jKAOYAS61cupcu/D4YhAPMCvLBSeaUPAZM1
 5MWc1FVEOH8PQ7sIti31Bgi1MS+aDu1KfYWP8JEwi4S+jfMMbv/or7Uihe3+YgzHiCf2KWHJjWI
 ZqLaw9Epg1NiI8tFlRF6+tMT7wKQ1TqSNA9jgSm+o2DwYqYJvnOKQ8bI1mg==
X-Gm-Gg: AfdE7cnzXvl/Go3cnsMPLjMfmQUrSvqaxTh/y/jSB2G/7iViKGHwLqu3GeL/SflmkQz
 UxzYC8JcegiRjAIl8eTjuCVSsbRHbvB68LBVlERjIgYYzlLH9X31Wqf01W9aOuHYh+y+1X/tAu7
 QNjLVvlN2NcUatTCh0HYukwicDjtsYatoFzLOYhGU6dEMlUba1m1uybD3zz5sNCgxvrb6a47v6q
 OL2TMdqiZvQtmYnaKRrlKygaXAwjBhbvpD7DMljsIqiyVHWsogJ2hjgvg2w2hl1Zx/ADDDUqGA/
 2+TBlITiR1KqV+yqb6IjHP/G9KD2mt19jbPh8YGDY5lAIitE8ctmVG7W7X5sHH0VkrxUlVqsSOM
 RQtgMeXqB1e8z7wulIhOr5l63FtFEIPGnFlNzgL8xLbtbj63EuhlSnccOHHmUVPYPzvl0
X-Received: by 2002:a05:6a21:4a97:b0:3c3:8c88:7b20 with SMTP id
 adf61e73a8af0-3c3ada1eb3cmr15051953637.44.1784568829965; 
 Mon, 20 Jul 2026 10:33:49 -0700 (PDT)
X-Received: by 2002:a05:6a21:4a97:b0:3c3:8c88:7b20 with SMTP id
 adf61e73a8af0-3c3ada1eb3cmr15051906637.44.1784568829339; 
 Mon, 20 Jul 2026 10:33:49 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13ce29c2a48sm28547775c88.2.2026.07.20.10.33.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Jul 2026 10:33:48 -0700 (PDT)
Message-ID: <9c6b8575-6043-4768-b79e-9408dad4d908@oss.qualcomm.com>
Date: Mon, 20 Jul 2026 10:33:47 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] plugins/execlog: fix segfault and flush output on
 vcpu exit
To: Harry van Haaren <harry.vanhaaren@openchip.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: BALATON Zoltan <balaton@eik.bme.hu>, Alexandre Iooss <erdnaxe@crans.org>, 
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20260616161242.267315-1-harry.vanhaaren@openchip.com>
 <20260716094126.787556-1-harry.vanhaaren@openchip.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260716094126.787556-1-harry.vanhaaren@openchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=HKLz0Itv c=1 sm=1 tr=0 ts=6a5e5bfe cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=VwQbUJbxAAAA:8 a=OZcmDFxvAAAA:8 a=MI6s7Ohd7u6-WKzijUcA:9 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22 a=liPxxeoTYnb3ClP5OJlV:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDE5MiBTYWx0ZWRfX74T/DHOpUDcU
 qTPQCJ++J4XIA8HkEO8ZXRIyNIvKEvN37WTy0L0gioE2dk3X7GjH5LPgKSx0ST/VErfeooZnlAi
 wLnyMf4AJqTXEmQ5rasoTvutr5kPf98=
X-Proofpoint-GUID: ejDHFQqO_re--Gpdi4SsUJPEwAfkI00P
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDE5MiBTYWx0ZWRfX5vNb6oRVeRDw
 3Nd1r0atNjprhsCKgIpApmv/yUnjIEvvJ1LZzHoajbgJDXvM17JRZ58PcJSVPGneop/kiN52jPd
 wjqHfFjj3K37uzH903UIOclhyVjv+66LRBIqWL192flxpEuv3SzoGk2uMhhoZ4bTzrLqxiS78m9
 7wiAZIfhZ2L2lqpjUQYoW98xQp1xhJJIR+0Dd4kM2VSClchyIz6wZ2a+rcFp8UcJWxDsHe/qU5m
 i7QlmAmYs0HmcEAFdzpH8au1/VCa3XgR9HXWrxcnoR/CcJOQcFzqimjofDq+6qV/7L+l3fX5sCI
 2R3+pH8zOnHY7JVfdSy6EvI36UhIpxm5wcsrAAzgus9RIinX7jPrDORfmHTpvFKMUQ0iEYEioTv
 ZT9SOeFUlyLrdH5CqkZJlX/dm9n+CuckQfljPjKBM2B4V4JJm5JPsCfZuLE87DPG1dihF7XOYNH
 k0OSs1ma3elodtDpckA==
X-Proofpoint-ORIG-GUID: ejDHFQqO_re--Gpdi4SsUJPEwAfkI00P
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_04,2026-07-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 clxscore=1015 malwarescore=0 bulkscore=0
 spamscore=0 lowpriorityscore=0 suspectscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607200192
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

On 7/16/2026 2:41 AM, Harry van Haaren wrote:
> From: Harry van Haaren <harry.vanhaaren@openchip.com>
> 
> Hi Qemu-Dev & CCs,
> 
> This is my first contribution to QEMU itself, but I have worked on
> DPDK, OVS, and QEMU-RS a bit in the past. I have experience with
> mailing lists for patches and some QEMU internals.
> 
> This is a "git publish" reply to the original patches that weren't in a patchset:
> https://patchwork.kernel.org/project/qemu-devel/patch/20260616161242.267315-1-harry.vanhaaren@openchip.com/
> https://patchwork.kernel.org/project/qemu-devel/patch/20260616161242.267315-2-harry.vanhaaren@openchip.com/
> 
> Thanks for reviews and input, the v2 reworks as follows:
> - I expect email to no longer have "| OPENCHIP" in my name, and the email footer removed
> - git publish used to send, with "--number 2" to hopefully get a v2 patchset out
> - rebased to latest branch, atexit() function signatures changed
> - avoid adding mutex for output, rely on QEMUs logging mutex (thanks Pierrick)
> --- use single call to log to avoid line-breaks corrupting output
> 
> Please note that LLMs were used to investigate and fix this bug,
> but all code in this patch has been reviewed by me, and I believe
> it to be a good solution.
> 
> Regards, -Harry
> 
> Harry van Haaren (2):
>   plugins/execlog: fix segfault/race-cond on per-vCPU structures
>   plugins/execlog: fix execlog vcpu_exit execution print loss
> 
>  contrib/plugins/execlog.c | 88 +++++++++++++++++++--------------------
>  1 file changed, 43 insertions(+), 45 deletions(-)
> 

This was merged into master (3b49fccda43ef0953d1b0e226c7b1d7b64b62dd7).
Thank you for your contribution!

Regards,
Pierrick

