Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67EFACC6B2E
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 20:16:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xH5OI-0005rF-IG; Wed, 14 Oct 2026 16:16:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xH5Nt-0005q2-BR
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 16:15:35 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xH5Ne-0004vr-11
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 16:15:32 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69EFMpI41682876
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 20:15:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 fQJ+XEd36NxV5aPzPLO0WUdRDibVO/QgPQZdKZqus3E=; b=KX3rSl7zM6yM3eSJ
 ITi+PHh9YGRICvh6Bpa0mHPLWF84Zrh+QE/9gWyldbaB+ND7EgZgLMUQHwf9WWYn
 b5D9e2GAjSRyLEqU+FCcBAnDYIi4SQYB2sA5TVp26DwE/JK1Lw3s1ieEM4VDX4bD
 eR0GwrIzA/kcElBFflw5QazXGmbOFy4q6f/bAaDbAVFIprUZunLHvwDqDlu+O7FF
 iFHb9hYej9BuuLCAVaVTZZeK5OSxDHhm4NHQ1MZ8pjp2b1x8HgkGoF7E9773ZM4V
 PZNnGuv330YmD+3Roa1+Ro37q3GthhZiyH9+kWZB4QjYJv89P1gVUwUbz/ui0Jco
 8BLDRw==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hacb013xt-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 20:15:15 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-3548cdfd2fbso6905936eec.1
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 13:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792008915; x=1792613715; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=fQJ+XEd36NxV5aPzPLO0WUdRDibVO/QgPQZdKZqus3E=;
 b=F9n/wc6RRWyOAnOEyktNavO6ZELzwtJF74szovpxhKpJ0Rc6mn8MXT7MzCQO5A0Yia
 GDR96GJzXaT/ZllbIMxt9fW7Eb3T00hAn2wXvc2wzmRQ3fz4HZqy53hrNzWNbPFzqRBW
 7AAicHdZQaA4tFPvc0qdLglYCV+RpyPbumLOGMmDHM7cp6CSrJJjxl+ncAKI//VLjjJ8
 TpUDZJI5f2Wsq7nk/G4kQ4jg1xcP3qkrTEJ3x1GDDkSPmtvxOR4j61awJVlqa88hnRj9
 x3C49/EBqIqS8G4UR7k5jsVfNm8Q+zaHud98M53suYtB3wv8who0xmxgLTv7NYLMpAEw
 7sow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792008915; x=1792613715;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=fQJ+XEd36NxV5aPzPLO0WUdRDibVO/QgPQZdKZqus3E=;
 b=HFakBYvoebe0v+RSQUQD0o61vd9v28Vm7Kp5mQ+55OZhYxptYe0QIJMEhBtzkR8PmD
 Jn47l6qsAH1yEFM5CrvGfBoYwD8USQBpB16k53wR2fOocbgtMyVNzyaFsTmFo5Gmem8q
 +DakHyhuv6AwIuDDlExu6mY0TOgv7i8YduyQJW6lQAUPzuvSWu0XR1R2XZX/qk5XiHqv
 nEAcGInAXF85cfQ1EbRfMa9TLw3s9wKoWcrJ+PhiIMhajUprdX+47xFChbAgQ3iQticp
 wESO55sZUudjDpVdbhekf9IMYiQmJ26wPnqKxff63FN2N6CNSCPERz0zECkWK0yrd5Lj
 qUKQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzK/xYue83SkhfzZaiv9QCA8N6LY9zzsP8lCdGE+aSA8LqsyQx6aHRRt85PJVz9jFKPIQmtOHLY7Pku@nongnu.org
X-Gm-Message-State: AFq9FYLcPlpmnshcOyxRaYCPgMZuDYUYsvofpE0w1tAA3+rE3z4cwRGn
 7gJ16v9aELw/yufWlWy8CcnC36WbPph9DKpKyn4xDAffbDfdf9TpN/M5vyP2CZqXyAfAfBL6Pk7
 slCye8ZR5jlHH7Za43wyLGMbuP71wAGdbH/Ii3vkF4jQV2FHeIzAhHlcZU+5vZAXkxw==
X-Gm-Gg: AYBFou2YSjInVNtSy4TNh/9fEoVq5HGwTNcqf5huK2ZkQM9kehXnEZYwO3u+eL0ckGZ
 AfW45Qmd3hnsuXuDscQXLCaklHWU+PN/IiePQcuydu34EZ4r7QSfJN4jT9WsP0WkcXc221Oiuy/
 W8JefSSLJ8WJmLwc7uwBNB1Xb2JiZea8tsQICmt5zR/4avmXYx4asPGVBvmWTcsl+oc+EripDkZ
 NyyLAJUrxza6d3dEZHVdrJdj2PPwug+uqHNyvFVDk31h7Epygag8HxNWyZrm47dGAWJg6UB1SD+
 n2KKuphyk3xckWAya3hFxM3n/0FW8DeinzMOThfCyZjfF0wWGBzCej+Jakhpdi44xq4fx7Bn5Gh
 nql4S67tLEFcQQT03N6fsMiVfdw0MHQEyGf7EohlcuUrVOyCHk7abNd9YpVaMavqyLrhffw==
X-Received: by 2002:a05:7301:d194:b0:35b:c271:df19 with SMTP id
 5a478bee46e88-35bc271e8c1mr10338584eec.32.1792008914802; 
 Wed, 14 Oct 2026 13:15:14 -0700 (PDT)
X-Received: by 2002:a05:7301:d194:b0:35b:c271:df19 with SMTP id
 5a478bee46e88-35bc271e8c1mr10338545eec.32.1792008914100; 
 Wed, 14 Oct 2026 13:15:14 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3537c841648sm62363542eec.3.2026.10.14.13.15.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Oct 2026 13:15:13 -0700 (PDT)
Message-ID: <e3aba3c0-03b8-47d9-9408-1116c5fd04c4@oss.qualcomm.com>
Date: Wed, 14 Oct 2026 13:15:12 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/11] semihosting: declare semihosting cpu ops
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Anton Johansson <anjo@rev.ng>
References: <20261014182543.135965-1-pierrick.bouvier@oss.qualcomm.com>
 <20261014182543.135965-6-pierrick.bouvier@oss.qualcomm.com>
 <98eb67b3-af20-4f94-b13e-b179dbac233a@oss.qualcomm.com>
 <2cfd5712-bc91-4600-836a-914f7dd7cd85@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <2cfd5712-bc91-4600-836a-914f7dd7cd85@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=VKpIDNPX c=1 sm=1 tr=0 ts=6acfe2d3 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=O1Tz3t1NGYmKf9gyRMEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA4MCBTYWx0ZWRfX66j0aoNZAo6F
 By7xZapaSmaFeQzm9UxvKJBrtGiboCzUdY0IO1SPPbGldy6GkregRmyZ0pRMeUhE4lTatEeAaNO
 1uqqpM7NRwWCQVP8fggY5pBI/JgL+wU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA4MCBTYWx0ZWRfXwrQM8U5oesQH
 oamh1L3acA/7wz0t7yg7WWa2xan9VfUENJ9ZhPrJUTfsrdAKziGgIIUrNEaKbPhXCzr1ClkhhBY
 Fajtuk0buF2+XHWYcTSNxFJB0tl4ts3PcJ5TwRmyRy1rymHV7WzJy5PRP5iJjubxY71nKasUkwA
 mpShE7b9Q52xgABe/+tGxdUxbZ31fzOtc0lgkM2BME7+/lQsBnlDMgD6bvo65JKfk5mnj+Ig+3d
 04RjK68yFtZdzOZWtFu11FL9im+WRgVPdhDGFYl45Uo3b7XTkOwlTaiPsVD8k3FzI4sm5Ha7CnH
 p03Mx2ECQn5YdNMmxPSmd/g6SYwun0MelMC9/X3ULAizzYCd1ygsZnQIycDF0zL9upwbou8xkDu
 pUw40ziFanlGTHFtcKWEP5viocRRp2R48G+2rBgYjGu7cboy4Yi7XoHii9KupZ2c5AhW2ESpawk
 6EZaDXAFUJ8JsGM/P/Q==
X-Proofpoint-ORIG-GUID: uPayFOWAF_uHyCGKEmrHaHlwZFeITjra
X-Proofpoint-GUID: uPayFOWAF_uHyCGKEmrHaHlwZFeITjra
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
 malwarescore=0 phishscore=0 spamscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610140080
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

On 10/14/2026 1:14 PM, Pierrick Bouvier wrote:
> On 10/14/2026 12:43 PM, Philippe Mathieu-Daudé wrote:
>> On 14/10/26 20:25, Pierrick Bouvier wrote:
>>> This allows a specific target to declare its implementation of 
>>> semihosting.
>>>
>>> Reviewed-by: Brian Cain <brian.cain@oss.qualcomm.com> Signed-off-
>>> by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> --- 
>>> include/hw/core/cpu.h             |  6 ++++++ include/semihosting/
>>> common-semi.h | 17 +++++++++++++++++ 2 files changed, 23
>>> insertions(+)
>>>
>>> diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h index
>>> 76801444a16..456154df6f6 100644 --- a/include/hw/core/cpu.h +++ b/
>>> include/hw/core/cpu.h @@ -98,6 +98,9 @@ struct AccelCPUClass; /*
>>> see sysemu-cpu-ops.h */ struct SysemuCPUOps; +/* see semihosting/
>>> common-semi.h */ +struct SemihostingCPUOps; + /** * CPUClass: *
>>> @class_by_name: Callback to map -cpu command line model name to an 
>>> @@ -186,6 +189,9 @@ struct CPUClass { #ifdef CONFIG_TCG /* when
>>> TCG is not available, this pointer is NULL */ const TCGCPUOps
>>> *tcg_ops; + +    /* when target does not implement semihosting,
>>> this pointer is NULL */ +    const struct SemihostingCPUOps
>>> *semi_ops;
>>
>> Could these be *const?
> 
> This field is not statically initialized, so we can't use *const.
> It would trigger: In function ‘arm_cpu_class_init’:
> target/arm/cpu.c:2669:18: error: assignment of read-only member ‘semi_ops’
>  2669 |     cc->semi_ops = &arm_semihosting_ops;
>       |
> 
> Current const ensures we can't modify callbacks set (
> cpu->cc->semi_ops-> (const)), which is what matters the most.
> 
> Note: that's the same pattern than all other ops.
> 
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> 

Sorry for the reviewed-by, my fingers slipped over my signature shortcut.

Regards,
Pierrick

