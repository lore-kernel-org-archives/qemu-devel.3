Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91EF4C44539
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2026 12:03:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmVf0-0004q3-55; Wed, 22 Jul 2026 08:02:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wmVev-0004pZ-P4
 for qemu-devel@nongnu.org; Wed, 22 Jul 2026 08:02:46 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wmVet-0003om-TF
 for qemu-devel@nongnu.org; Wed, 22 Jul 2026 08:02:45 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66M8x38J524020
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2026 12:02:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 9+sAWM+YGLL1irJ0BSIWJXPSYYSlDbZtAeU1Xth0P+A=; b=SDdJ5O2NSflon0dV
 AI4VHYGvuvJ6yyM02mY8QS8zDAIPd+HPhkaY1aNd4OrBB4nNHQUPRpq5yj9wBTaB
 vL/Vp3qqfo0S6Iy1jdm5/gAliRFuHjI8Pru+/LAhvblhpMk9xdZIGlV4+ozNvXz0
 Yo5z7SUYATsQXJLhhwmOKaNdcENavdNM1Cr+p/b2ExOuabwKm5sAjZwGCqZzKbTh
 D85N9FuAH5EBuz7YtQYwcnEl1QerwmH2p7gKSfsQNhKTB/s16y2cqSJrcHd7phbT
 UXbdppVzDMPjMTCMvluFyRIPdsNY2MlNBHD3WYQHe4JrYCtr8v6IWVQVeolGtVHB
 HTYAAA==
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com
 [209.85.222.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fjrtt19k7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2026 12:02:39 +0000 (GMT)
Received: by mail-ua1-f72.google.com with SMTP id
 a1e0cc1a2514c-9772e18c186so1605023241.1
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2026 05:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784721759; x=1785326559; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=9+sAWM+YGLL1irJ0BSIWJXPSYYSlDbZtAeU1Xth0P+A=;
 b=ADdqdNk43Epy53nr14XlxNMMUcnR8Ft14lwoG+UY65g+Jx3MfDfTqMNGbs52oSQb+X
 ah0pAeHQ+7WX53W7jLyEZ3nV+ltFAel/sec/bpWgumOOqQ3qHIPhvRZCyf9iGQzQxTsB
 LxQxfbniwr4P6EXqKGNIeN5nEuZJtNCDEqiW4/YMwUteMi2n6Y06TPYUoH5ILwSDWzHz
 XyGjtNv+yGKGfZhxdjxkliqJ3s27/fbR+E7b05zeGoN1Dm/4Mpke56OzoF1QziXxfgit
 45c2pqtO4b59g6DZrZ56gBEPgEQ6kwhJOQsOfjtEDIsxUUBGJ4NQUSHKi4rBZqUAk3R+
 EoiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784721759; x=1785326559;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9+sAWM+YGLL1irJ0BSIWJXPSYYSlDbZtAeU1Xth0P+A=;
 b=A9Ccc0pCfICyU8EOgkDc3VrMH3L7ws0gxObuyu5Jp6e/A57TV9eWB0BR0Tng7E94/+
 KPPxpLKS2NSrbMxtndthCF4hwqqdU/GjBVkV6sQ9GedBqfkAmvn2gzwZJY/L0gLOTW+3
 uVS8uIT9ockwdkRvtw7E/mQ6kmalGDW3hmu1iYiYUDRwxB3X6pUb5Of6ZPqI11nEZQhe
 zLzz71AzD2QrBdCWUvZlMA9oZzYsz+WEJxe9JmrF73014K+KiYbSgjeVuMTXGLyOGxYD
 NtAQzsWzISnKUtSnchGC4ZjfxwqXaO9+emmxGteEEFlvQDibE2F4nLpGzihfM5/hUvK4
 xiJA==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro4hYbM9HgWDeCrows+WptNj4s47CwfaK8BWno40wiWIu59C39w0hYYfbJXBMOBTjCLCyx4PWkW3/iK@nongnu.org
X-Gm-Message-State: AOJu0YyXR6PYqxZT4O+lvXWasP94y0bJZQvMOmqOSJJcYMb4GZ01YKfh
 Kq9nlYzZY5KlzVeq8KZr3vD/f0wmy6tnGokcoqv86AjCQ0kEYEfCJ2i3pX9s1+6RMJX5NcUCKv2
 p3d90/y7vb1t5vO7cM8FK3Exk9aRAx+JibXOEcaVV61rW6f9SYN4Xd81nbg==
X-Gm-Gg: AR+sD135yfE+CQQ8LscTxsIxMxJqH9doKATi7lmvobxIHKboW6AoW+YRr9FV8/fsPsO
 t/YPZpekh8l/tBIlAXTh6KhyQaQujj9/AfGw2dawQX6AqUU39xFgKRH3O9A2UUsjor+XZ/jhYYP
 LkOQOUmZAoERtpNpy9MINDcOG6yteElr5+JGTI8TRh/lk5Jt2ASOit041XW/GnSI5xtEnZ8bgxo
 y1+r1O9rKkvx3NwsdmQZ2Mvbj9JmeStjHNtS86SwtFXpr0Cy85baOD4hIOZulxQq8fXjSsiYJGl
 GFWOdSY2rfeat4LH3dZCIDA4Lk+qHsKm+W8DRGOJeeHDF2qloCn10g/q9SrWtPC7V371Yo8olU0
 0Ir0FB7mm8/h+EhrsDe07PLCv5kGtc44ph4nYecBPPWRmcD38pRg=
X-Received: by 2002:a05:6102:4186:b0:729:1a8d:b2d9 with SMTP id
 ada2fe7eead31-747536f0861mr8725659137.22.1784721758451; 
 Wed, 22 Jul 2026 05:02:38 -0700 (PDT)
X-Received: by 2002:a05:6102:4186:b0:729:1a8d:b2d9 with SMTP id
 ada2fe7eead31-747536f0861mr8725634137.22.1784721757929; 
 Wed, 22 Jul 2026 05:02:37 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85b9a659sm5783967f8f.6.2026.07.22.05.02.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Jul 2026 05:02:37 -0700 (PDT)
Message-ID: <7358d920-d631-43b0-8285-c162bd67df78@oss.qualcomm.com>
Date: Wed, 22 Jul 2026 14:02:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/microblaze/translate: fix reversed load/store
 translation
Content-Language: en-US
To: Luc Michel <luc.michel@amd.com>, qemu-devel@nongnu.org
Cc: "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 "Edgar E . Iglesias" <edgar.iglesias@amd.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 Frederic Konrad <frederic.konrad@amd.com>
References: <20260710072348.3575-1-luc.michel@amd.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260710072348.3575-1-luc.michel@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: KUeLZ_B0X9TH7qBtWyooz4DYIIHVXapU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIyMDExNyBTYWx0ZWRfX1YhbUffiA/wA
 mckApwLR2d8CWkoCQfDnQU91IMfGV9ZQc+rq68Ce14sQ170GgK3VF6XcosvFkmJQDuQrsc6yHML
 VAlije9g0yp11WN0AnKqqrbnm7x3PsbpDv+bBDw3sqbPnyoulRNAGA/pqG5MJfdu/D187J3+rA8
 E2gv+3IZhbYNhZUJrNCGBhnCUdSIMLg0sm6YmTLnLDiNBlx3m9S6h38v2mXRqBfEQheceaxgAzX
 +ykVQKqXA+uyUv/Q3T3Bav3dXPF2SxNJkV5jLLbZLnItJ+Zptd+azt/f5qpjx2epPtBIDWTJBtP
 O7d3WTMgJquht0+lrmoP7HbX/h6o9+JV7V6l/oDJvz9M8T/7Ba6xSnlZQFLD8GDVavVIvunvYsr
 aqyPOfdy0nBCRaGUqKAo6ce069dpAC1M+pznXjByAszCdY1I3yDydDMkqkg+q++yCYRnzjCb1ju
 W7a8DqekQs9XhsW9Lag==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIyMDExNyBTYWx0ZWRfX7zKq6IE5qU/V
 ICYEewcY+ZvqA2hZpK76HAb4PwWH6jTtlGdusz1ue3JuFT6HAumnhu0xwIBK5BWwV5u9pSDHNEw
 nbYk3TptWKIJ96Q+C9M8WMsWy+Xnf/A=
X-Proofpoint-GUID: KUeLZ_B0X9TH7qBtWyooz4DYIIHVXapU
X-Authority-Analysis: v=2.4 cv=V8lNF+ni c=1 sm=1 tr=0 ts=6a60b15f cx=c_pps
 a=ULNsgckmlI/WJG3HAyAuOQ==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=zd2uoN0lAAAA:8 a=U5mT9tQJ0ZpJWxV_qEEA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
 a=1WsBpfsz9X-RYQiigVTh:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-22_03,2026-07-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0 impostorscore=0
 adultscore=0 priorityscore=1501 malwarescore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607220117
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

Hi Luc,

On 10/7/26 09:23, Luc Michel wrote:
> Since 36a9529e60e0 the TCGv returned by compute_ldst_addr_type{a,b} for
> the address can be a target register or a constant. However
> do_{load,store} might modify it in the case of a reversed load/store.

Register are modifiable, aren't they? IIUC compute_ldst_addr_typeb()
is not used by the reversed opcodes and the only issue is the 0 constant
in compute_ldst_addr_typea(). Is that analysis correct?

> Fix this by factoring out the reversed access logic and copying the
> address in a new TCGv_i32 if it needs to be modified.
> 
> Fixes: 36a9529e60e0 (target/microblaze: Simplify compute_ldst_addr_type{a,b})
> Signed-off-by: Luc Michel <luc.michel@amd.com>
> ---
>   target/microblaze/translate.c | 56 ++++++++++++++++++++---------------
>   1 file changed, 32 insertions(+), 24 deletions(-)


