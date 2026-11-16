Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED997606A890
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 09:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=CqSXcYX9;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=KYNwVSxN
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xSslw-0007xp-GN; Mon, 16 Nov 2026 04:13:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xSslu-0007xG-EV
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 04:13:06 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xSsls-0005wu-PO
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 04:13:06 -0500
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AG7esSa633362
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 09:13:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 dnbkgh+D9uwBbqbmDN8QuvZ3XM3lRwZdGFxxkFGGKsU=; b=CqSXcYX9YA5kSFFi
 kBX3zh5kzl6rOu7eKD2KAOX+xBy4pe3amKPdAHIppyfPQvgriW9z81QZPgmD5IzH
 CGQ24imC55cXK6iR4zguj0rN9pThf6LgU5h3WuX8cyD86YeBjrfxJXFRoGF8YgoV
 bgDcDkscfC+TLZQOTQiWYOnt29U0gy6BoWiyI/nSdGErYrKH5JGEZltFRhKa5lvG
 TgH0vHFNG8L57YqfhOeLqMx0rph5Gq/cpORSXcpnK09sk7VwFYjUYMye/Xuf4gPZ
 iPNj0dbhxS7IU9GgAyS/jPh8UrCdohyXg1jRpJ5PHE2/H9gCs5TUKmGCjVXNaGhN
 6YjV4g==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hxhnx5tmj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 09:13:03 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-91c046843f1so40949446d6.1
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 01:13:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794820382; x=1795425182; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=dnbkgh+D9uwBbqbmDN8QuvZ3XM3lRwZdGFxxkFGGKsU=;
 b=KYNwVSxNkg0luv3BC/xjS4M6UleN8R4zt6hjDbs2XqvaiQQpfdYjG79kxrnQmvQpPs
 a4+i3pQuCILUeZVc+67kA1Jib5NHZhrcFbAnhkdQOcsOFufCpoM8hoZncHpn9s14rGIC
 QhFBog4KzCB7t1Z4LZYG14XzZs/y3S45pXt0irLr0+sbuGS86XuCIugJD9d/oEAW/88y
 XVhK87kBgrHj3mIBX5+MzQw4FhfhEkVuT8c4c8EzWb9yeq6zivgWeQQfkJZc/ERZSzCm
 BL15hFpwXk0Zijn8o6CvG7BDB/ayBHg5lesjk+duLex52q4A+EOADrigd6pxYC0fnpMp
 GqXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794820382; x=1795425182;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=dnbkgh+D9uwBbqbmDN8QuvZ3XM3lRwZdGFxxkFGGKsU=;
 b=Vu4RqG64+xNVX7HMtVSuGwE9uxev6v8emC0dyd0+FTsJUHhLgARIs42P1DR/MdQ05k
 2DQLQfN/vlvySBLbriB3HDLxkPO9ucezHKGJMyLbgSC91ZUUnlT7hNeITkz8dKipB51h
 /9E+Sk9GWZgLIGJMLeTMEkuxpU8nASAvaBdhMP1iGADLSDohZl26NsaIf4FatbZLRE+y
 ryMWejFURCWUw0sxCiVMGc63b00d3n0sN7mXX6x8LqCE2fxKn1irj8ducMROot427xS6
 UEd9WYNCebbj2d07PxJzRQajmhmR79lz3hMYX6ufiXLBd01FyTmUVL7e4WCKIeAX/XdA
 Z8pg==
X-Forwarded-Encrypted: i=1;
 AL+hErFm+5E9WbyVmu69W7cuI9PyfiqrPzt25G7oi6H9qDtpSQJEnihUqwa5g99RJVtuQ5laZx9WgVcnWce+@nongnu.org
X-Gm-Message-State: APuU4Z8p1jt5ZPe9ipuEF0Ozl0kIg7CpxGi0z0jcMC4O1UoBSszRh26Q
 c3rdd5nZeBXm5i6DOBVxvaiO1vXoacZRriPP3HPFaMrV0BghAmfRNbFOI0f0qI4t0feR+5liIGk
 V+80j3jqimyW5TgYktf5Duie8aPa4ZFl3ZB9Wk78O7mO+toUKZ0LdiMJpuQ==
X-Gm-Gg: AYBFou1hGkkqJFLt/Z+K2vZv8B6V4+VFWmY6IoVenqlaa1q6GlZECxmrMIWAQH8vQ41
 q04G6ZcshmThONQIrKITlloQqmWd2DGBj82LhcBiEKcbiVyRreWEhTG9L+IfNIyRnNj78t31pii
 NuDAziLz8CwCkotM0xZ1o/9FxW87xuYROhgjf0opFaX4VVkC/hhmuXBwN71xV+CqCSWxFZwqyTi
 okVsyzQdtl2sMDfhJnNZEi6oAfHDTMTuBWwx3oJ6PKrBIG7XnTELPJGD3Sv1np7LIu1vZM1+5Ol
 XZf4nFKIb7/MKv8RxAcWJyWMRZE43ZoZWXMFV+bx/lIlhH0FILXiY+0HjiQnBZd6GQtMsitWoIi
 mC4fl26+URQ4y4aqz1gSQTeeRix4q5wvr3geVeGL1dq+/mX+nlonddfEg/UAF+cRD/vpf+M+dIv
 H6bQ8GEII=
X-Received: by 2002:a05:620a:6ccd:b0:93b:fde4:4923 with SMTP id
 af79cd13be357-9494bbc05e4mr1692460485a.63.1794820382272; 
 Mon, 16 Nov 2026 01:13:02 -0800 (PST)
X-Received: by 2002:a05:620a:6ccd:b0:93b:fde4:4923 with SMTP id
 af79cd13be357-9494bbc05e4mr1692458685a.63.1794820381725; 
 Mon, 16 Nov 2026 01:13:01 -0800 (PST)
Received: from [192.168.69.234] (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c5ff2cd05sm18965555f8f.31.2026.11.16.01.13.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Nov 2026 01:13:01 -0800 (PST)
Message-ID: <c0c6e448-bddd-4593-a041-4ba8ad41981d@oss.qualcomm.com>
Date: Mon, 16 Nov 2026 10:13:00 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 02/26] target/mips: fix MIPS64 segment access checks
Content-Language: en-US
To: "Kirill A. Korinsky" <kirill@korins.ky>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Aurelien Jarno
 <aurelien@aurel32.net>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, qemu-devel@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20261113214926.98536-1-kirill@korins.ky>
 <20261113214926.98536-3-kirill@korins.ky>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20261113214926.98536-3-kirill@korins.ky>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDAzNiBTYWx0ZWRfX6BA+ou9VMZBj
 ZYVfzz1lKz5bP+XGNZfL99G7IjeYFqUu3fzECyYVgLyj8DzTKbevRCpC67aJNZsB1jIl2TRc8sz
 gG9vi+LJgFgNQ/3SH58/NkpzDEGmyeU9qB7ddlzIbenRL4p2RWGv4JdA1lutUxDW9a7I4I6KbAI
 CFMxSDopjjrLlOWlNJeg//Jqtjkzd3BxeOkyIlsMJxiJvJiVM3pNrAuOhrJOzuTYS6o5GxWS8Cw
 RLcPV4M0/e5jCwp/G049UHOd9XOz+QdT6Ae9KfrgKvDmtM8MzeBflmIsIiRFHkZh6/C9nfyzDs7
 PcIsFgU4hmAwIEB2bJtSqTkT/eaT2SSgLmpc3ePB4h/DjpQkJN6LzwdHLfyDUVe1BHK1GOugnoZ
 sF5AULJ994hzo7QUUrv6ItzMPKsIq0r3rladrOhpfnJF1kmXV1evpy9X0pJyLsXpG5aJ7fDPlWG
 IYBBfQF/1zwR5qfri/Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDAzNiBTYWx0ZWRfXwp3oZnmk6YdC
 LEsX/8ROOtSePY03gOfNZVeG+hApq5KUqjPjs2HovThnGDh6ceehq8rlTqJmITihVLM4Jruxile
 2VWjZuqzPBh1ORyg9NI6biARJSXmMog=
X-Proofpoint-ORIG-GUID: EGxOB4sbRdnGn-rRRRoOJ9-MoUBGKrwQ
X-Proofpoint-GUID: EGxOB4sbRdnGn-rRRRoOJ9-MoUBGKrwQ
X-Authority-Analysis: v=2.4 cv=Jr5kP84C c=1 sm=1 tr=0 ts=6afac91f cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=5Qy3y0gPgTHNMTgMjzYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_03,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 adultscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611160036
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

On 13/11/26 22:45, Kirill A. Korinsky wrote:
> From: "Kirill A. Korinsky" <kirill@korins.ky>
> 
> The xuseg and xsseg checks only tested UX and SX respectively; kernel
> and supervisor accesses must instead use the mode bit that applies to
> the current execution mode.
> 
> Allow supervisor and kernel mode to use xuseg when SX or KX is set, and
> allow kernel mode to use xsseg when KX is set.
> 
> Signed-off-by: Kirill A. Korinsky <kirill@korins.ky>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

Now that I found the Octeon CN71XX manual I couldn't verify this claim
so I'm putting this patch on hold (along with my R-b).

> ---
>   target/mips/system/physaddr.c | 8 +++++---
>   1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/target/mips/system/physaddr.c b/target/mips/system/physaddr.c
> index 523197f020..b9f44c27bc 100644
> --- a/target/mips/system/physaddr.c
> +++ b/target/mips/system/physaddr.c
> @@ -145,7 +145,9 @@ int get_physical_address(const CPUMIPSState *env, hwaddr *physical,
>   #if defined(TARGET_MIPS64)
>       } else if (address < 0x4000000000000000ULL) {
>           /* xuseg */
> -        if (UX && address <= (0x3FFFFFFFFFFFFFFFULL & env->SEGMask)) {
> +        if (((user_mode && UX) || (supervisor_mode && SX) ||
> +             (kernel_mode && KX)) &&
> +            address <= (0x3FFFFFFFFFFFFFFFULL & env->SEGMask)) {
>               ret = env->tlb->map_address(env, physical, prot,
>                                           real_address, access_type);
>           } else {
> @@ -153,8 +155,8 @@ int get_physical_address(const CPUMIPSState *env, hwaddr *physical,
>           }
>       } else if (address < 0x8000000000000000ULL) {
>           /* xsseg */
> -        if ((supervisor_mode || kernel_mode) &&
> -            SX && address <= (0x7FFFFFFFFFFFFFFFULL & env->SEGMask)) {
> +        if (((supervisor_mode && SX) || (kernel_mode && KX)) &&
> +            address <= (0x7FFFFFFFFFFFFFFFULL & env->SEGMask)) {
>               ret = env->tlb->map_address(env, physical, prot,
>                                           real_address, access_type);
>           } else {


