Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7BCACD5BB3
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 23:11:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQZ0Z-0002wh-6D; Fri, 22 May 2026 19:10:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wQZ0V-0002vm-3q
 for qemu-devel@nongnu.org; Fri, 22 May 2026 19:10:19 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wQYzx-0004Q4-On
 for qemu-devel@nongnu.org; Fri, 22 May 2026 19:10:17 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64MGncHi3947400
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 23:08:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 0SmLJjEMFMGkLKiEARiohtencp7kmfS561QNwORhdj4=; b=XH0tqgd3E+6zNoIz
 XmBSRGFXjTDcLe+6XFHR8yRU0A8nD/G5M1+rpK4znz6tC0FIV2RmFn6439eyJrwD
 UeyymxE4oLFk98v6p0UQIa2Losv24TkprIrBIM+fpaTi6w2jOxbh6B/Ld0d6Me2V
 3FqEQY7xEiHU8G1OH3iVkQBugMyNE1l9lC+Hhdz9XJuvUChUvOL0eCaA2MYaNArs
 +1O0+/HIoCp6qPhfayr3jKvamZz8CppmMo8nxqb6S2Y2gIQ1Twt6+eIMpp5sMpfs
 gD4NzjuvM5ZwkHkoyEUncW/l2Q4ARymHQF5WULIOm0gohQWvapwdwvNi9m1bM6Fl
 w+/zJw==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ean2njr7f-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 23:08:05 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id
 a92af1059eb24-135de949041so6565635c88.0
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 16:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779491284; x=1780096084; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0SmLJjEMFMGkLKiEARiohtencp7kmfS561QNwORhdj4=;
 b=GHinzC6ZUlqvPj1p7JZz3XYDNHaHBKCjgXHydcsPJLmsrcChk8t8wZ0tt3hmMhrX0/
 7delW9+I4KtSB1i8ujj+eQbU5s8OZD5d/HBujO+3Bj21QUF66gR/WPDlKDLkTErg/pJy
 O926ctgwP0Oix5eXzKcitSI2k/HwoKagNkQdi4Yv0N08EKgq3pmPbEDWTC7kHSSzUI1F
 jA/dkA5DAz1VnXR8jdmNpmG5+XIzZ9eUdO38OeeV1Diuwnea9KL9w3xjX+Ehz+Gx/sP+
 MeQre0k7Ic9KDLM/0SCzQdwWH/FjcD6GYMq19pBBIiYp3pTYh9et9RAP48xlzXge/rdd
 0ynw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779491284; x=1780096084;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0SmLJjEMFMGkLKiEARiohtencp7kmfS561QNwORhdj4=;
 b=pdU0iPU0vv8/bhAwDibV4FMZhzuHRn3VDUGupuCsCXUwS/U5kHFvcUg1lRqQurk3cU
 ZxgfL8tBwbWMhtSkUnGn0rPUG+MOwsLR0V3NIxwh6aLPHs17zNdY3y29Fg136wZSAyqW
 ByGVQywcB7Pn40v+mEmRapOjnTL6rk+yzyCQ+OyEsBqRUIh7c49waS1svIhXp1Tb39JF
 neXWmdd3u38q9l/eym0PcUfeasxuBCbLsyqHiR3FBaKqct/l5oX1XU7+zTHohJ3W9eNn
 uJ2KBap++rGt7z5jHLZejw6leEids4AIWE0Jr1rr5jbjq2SGy9lKDvkIvceczTPGxso5
 vrEg==
X-Forwarded-Encrypted: i=1;
 AFNElJ92iIrxVnL2DRvNCGe23QrNeyiemA9fG+eZbfZ2N0FumgGDxp71i4H21SR8vFGBsj/X86ASK/mIsa0f@nongnu.org
X-Gm-Message-State: AOJu0YxoCWU9p3r5RBSjyHImKmJSqi8vKtFDY86Sqt+Pm+hczZpg1Tji
 TN3jmS/un+qpCbBHa0WBF9mFZ81FQexA9W0fVWaDYqBXKE0boM4aVO498bgCMeTd9YVYadOxXjq
 JV9ZMMlDAWlXx+O6cYx43Vk8zlNjE9Lf958ONDmpsgyvQ3jMuht+Ljhmu5w==
X-Gm-Gg: Acq92OHgeK42zuZMucrTQXrVuP05gTkj52ObYILhI3poCMmUL58ZFQ5fDfZW2n38EJ9
 4ZJsj6LTe5ieZlMdp5VxNHAlTfu0qAmG0u5mGwaJ2cJkVRVHlTq2p804+FNUT2AeqciwYv05SpX
 FR/xAIyuFBSafqTB5d2H8dHq458RGUhx1eQ8V03Tk4LQEllpnpfS4oQqXgK0VLWEIen15I0g4sX
 EkMLcu+1gv73Np9Q0BmzHGAQFD/FzzZvR+j3WdMHbIRYdpksSZtQth+KbNmHim3d7+pj8Ek3PCf
 goCrpJEAkqXkszXzKBPi+sc81VncgJ84DMsqHe0RVkBeYHjf386gxY+AF6NlxDMSJDPeGWMK/IB
 RFORTKZ6QuvUYU0ygNVsY/jSlHspPZ6cC6vOuG5o1lR72JGP19201qOBNHbEt8Kfz4bmOLQxafT
 /qSHB/1fkpQvK4mw==
X-Received: by 2002:a05:7022:ff48:b0:136:97ed:44ea with SMTP id
 a92af1059eb24-13697ed4b45mr32868c88.39.1779491284482; 
 Fri, 22 May 2026 16:08:04 -0700 (PDT)
X-Received: by 2002:a05:7022:ff48:b0:136:97ed:44ea with SMTP id
 a92af1059eb24-13697ed4b45mr32855c88.39.1779491283967; 
 Fri, 22 May 2026 16:08:03 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1366aba39d7sm1787312c88.14.2026.05.22.16.08.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 22 May 2026 16:08:03 -0700 (PDT)
Message-ID: <551323c5-b2e8-4824-a478-20282ba8ac3a@oss.qualcomm.com>
Date: Fri, 22 May 2026 16:08:02 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/37] bsd-user: Add socket shims socketpair through
 shutdown
To: Warner Losh <imp@bsdimp.com>, qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, Stacey Son <sson@FreeBSD.org>
References: <20260518-misc-2026q2-v2-0-6c16fe448301@bsdimp.com>
 <20260518-misc-2026q2-v2-10-6c16fe448301@bsdimp.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260518-misc-2026q2-v2-10-6c16fe448301@bsdimp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=XvDK/1F9 c=1 sm=1 tr=0 ts=6a10e1d5 cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=6I5d2MoRAAAA:8 a=7Qk2ozbKAAAA:8 a=EUspDBNiAAAA:8 a=BmzOMtn50fFWoKjQ37oA:9
 a=QEXdDO2ut3YA:10 a=vBUdepa8ALXHeOFLBtFW:22 a=1lyxoWkJIXJV6VJUPhuM:22
X-Proofpoint-GUID: lwOTYF-y5tq83CHFfMzsGq0yQ9hDuBmS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDIzMSBTYWx0ZWRfXzQ+fWXp3GqmA
 tGV2TUD+5yMgJPCVsVU/ovBGeitC0XjIROX7IBeG7IDq2QYKehwFFH/OaLAyzfftjZdKGyB9T+u
 Sv0Nu5Bl5+kEuTAoUKv71KaC1SAxr8PBmz8FHGsic1Wd0YDslOYkh0/LtXlTZq/KS4imlgMIWHs
 6yRpzGyr16Q8Ex79KY359ZNsbvf2pssKlWdmdo9UCCHtE2dijFOd2aZCfnWSwjFZ7rUi7by+2fu
 r1kX43g1EjZtz6x4TaKB9YErJVFmE6EB8CF+Ogn0/ZdtEE2sXnmfe+3MEI+B7F9Y+2geLIaFPh/
 gy4eJM1FeKdr8IsYBPs0X0n6NhMEylCHgrUhnWjbIqk6bVSWqXsgDuFFyvbB9wCDbeOAo3Vo0mV
 8kJKCEqlHKU9VNeUnVV+caia+tQDQe5Rlc7EPXgAZh/VJ5mLdZ0BEyy6aBryCyEC5thdiiBCgaK
 MoZOte4KFRXaLNiS2cw==
X-Proofpoint-ORIG-GUID: lwOTYF-y5tq83CHFfMzsGq0yQ9hDuBmS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-22_06,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 malwarescore=0 phishscore=0 spamscore=0
 impostorscore=0 adultscore=0 suspectscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605220231
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

On 5/18/2026 2:27 PM, Warner Losh wrote:
> Complete bsd-socket.h with socketpair, sendto, recvfrom, socket,
> and shutdown system call shims.
> 
> Signed-off-by: Stacey Son <sson@FreeBSD.org>
> Signed-off-by: Kyle Evans <kevans@FreeBSD.org>
> Signed-off-by: Warner Losh <imp@bsdimp.com>
> Assisted-by: Claude Opus 4.6 (1M context)
> ---
>  bsd-user/bsd-socket.h | 116 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 116 insertions(+)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

