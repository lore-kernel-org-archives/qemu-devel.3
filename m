Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84061C61DD6
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 11:09:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2RnN-0004z3-DG; Fri, 04 Sep 2026 07:09:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x2RnL-0004y4-HN
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 07:09:19 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x2RnJ-0000pC-Dm
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 07:09:19 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 684AIEO43301464
 for <qemu-devel@nongnu.org>; Fri, 4 Sep 2026 11:09:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 jaLuTyz8N4g34HI9MyuTQ8k/8CmZuXbqg1qv148KBbA=; b=oTsLCDukWr1BqkIO
 6tmIUAXezfAamfGGOtqv62pVXh5l8u6yEu3mgaP9PGbl/TuydcI2MvxAdB+Ah+OQ
 AcBiwE3HL3TSxdcbBTT2nMJ6JKve1guyN1hvyIeQ+Eu5twaoYMCOmalDJpvi1Hdd
 9BAojh8+r+CVY7JXtDT1jOkcwX4fQHTBiKO9nreiz9LHFTGpZqB/SzEkuh+28lil
 tW1AYLe7+C5AABcLQNIUL7MYz3GFUmpq/kQNTwEBNv5kvaMCoK8HYPFCfC/fj2TA
 q7l2XAT5Pm5P2CSxr5VPfXcshscs/d5GV51x1EDwhURRBtuA8ZMnnhrvKBum+qbd
 jNu1+Q==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gfdyxk6u4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2026 11:09:14 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-934963b2bc0so180560485a.3
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2026 04:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788520154; x=1789124954; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=jaLuTyz8N4g34HI9MyuTQ8k/8CmZuXbqg1qv148KBbA=;
 b=brYIcyYZoYMozFQtYL1EccrTw4MYE/lTt2m3CzQBi/EqddNeLyibD35CzoxYpaYaKw
 KqMRMl2ayQM0qP6ZUorMa0Iaa5ieRz0QMaspWkjmc03TB9iTmNrb6s45BzxQbpvjf6ay
 z0kxUatAiMLVjfUwRt5QTWYCMziwbCTgJkOUsd1cyR85/h9j4ivE6HBQOgOhMrVwHYpR
 0sW+cTDYGNZHkiQSs5HFCJG0kPtYEPpD4NYKo5NBThNxWM73R52GkfKemjXElZKRXmoZ
 1fd55TUm6bl6d969zUQf6OXSd3oAxSLwLxobOHb0IOlOyTJ/yeIq3dMGzeUvuOFH8LFB
 DCmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788520154; x=1789124954;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=jaLuTyz8N4g34HI9MyuTQ8k/8CmZuXbqg1qv148KBbA=;
 b=nDqcK1+YRZZ/do8hM+nT2fB7rLS9UXG6kKNao7B7n5Ldv7Ai/eI8w3OPUp7j0g2oOy
 VKCrrR21P6ZDVBw8YKDnkaZiu0DVmWq0xUerfd1gogpv4Q7khyguZ4+AfDtakSwfi8Ng
 UXhNBD0ZzPZVDgAfXaVCp1yt5gfD3CvpwasvhsWanF7PXw1nAhriu4XuxSr/izcyRd95
 hTf4rtn1npM4xI/iO7kkksh0ZHWTsMa7Lnz31a8bi1o0T0YyrfFTGFrFsWbaFBBBh2uv
 KPp1WfBR1DzcvHKXTuJLs1D/5sl9DuyxW3dl5FadgIPx/DKSP5XY5o8js3MIqx9l9mMl
 oSww==
X-Forwarded-Encrypted: i=1;
 AKwUvBw8XjnjLrmz5DS+edfpXgDSjRu5cOxZC01VKEyMJsppHgKaqoZuP5kyOKppx8cu10S7f8OHEE2SWLog@nongnu.org
X-Gm-Message-State: AFuF++kLaGrj6Cu/zhfHY+Nli8peaUnHkdkjHc38vFcSjClMka6O+S80
 Ud/yeplJBHqKNsuvi+hq10PKM+cFfXCGPS4uhWS+EkWK8ElZSj6Ziw4rxYiWJ0piXWzwoTkzLrO
 kpcx0GjQO3LkEjt1TM/bryClDUReunLBxkgg/kB+a3K0E5AmtX/bgdcxO0Q==
X-Gm-Gg: AYBFou2zBe9t03C/8M6SApBsVF0KKLsxNTD7cgVQiiXQAlTFN0Ro3MZuZ8HzOLpzM4n
 GrSYFOsTy6F2KUFNh9c7NaItcb5NqgOEevY8wjn2AWMP4aOZwRzLJn/knJQe3TA0FqXs2I8akeh
 kDANOOcjZk/Xh3OxscoEo5P51dl8XDgKDZVtHbytvooptGKxFaqKcm+NhOD2noRU6cCOosckDA6
 7IJAFGh53trlQiPakxRlKrScQW/CjwXT+F5hV0ieDNrJg9gPXCIp0Oxjr1XcyuVZTCAKjt6rNgo
 G1zFDCUTZ4pTfONzavBr1VIZvCoRoYgr0nxgZowK1GqiBNVNwblWhcFqRtqIcSaweQgENUPnXY4
 ZMtO4a/KjrA0ibAX07YO8oaz9QZ4UpK6WsQ==
X-Received: by 2002:a05:620a:7115:b0:939:6df7:5e0f with SMTP id
 af79cd13be357-93980506519mr493500785a.51.1788520153924; 
 Fri, 04 Sep 2026 04:09:13 -0700 (PDT)
X-Received: by 2002:a05:620a:7115:b0:939:6df7:5e0f with SMTP id
 af79cd13be357-93980506519mr493493885a.51.1788520153252; 
 Fri, 04 Sep 2026 04:09:13 -0700 (PDT)
Received: from [192.168.69.202] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4858d2693e8sm1779740f8f.3.2026.09.04.04.09.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Sep 2026 04:09:12 -0700 (PDT)
Message-ID: <62e6effa-58ca-43a5-8c1b-0022163c7045@oss.qualcomm.com>
Date: Fri, 4 Sep 2026 13:09:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] qom: pass TargetInfo to is_available
Content-Language: en-US
To: Yonggang Luo <luoyonggang@gmail.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Kane Chen <kane_chen@aspeedtech.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>, qemu-arm@nongnu.org,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Helge Deller <deller@gmx.de>, Kyle Evans <kevans@freebsd.org>,
 Warner Losh <imp@bsdimp.com>, Joel Stanley <joel@jms.id.au>,
 Laurent Vivier <laurent@vivier.eu>
References: <20260903205018.975-1-luoyonggang@gmail.com>
 <20260903205018.975-3-luoyonggang@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260903205018.975-3-luoyonggang@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: muvS3Cz1qhmigmpNdXSrsV8JZ9Qrt7nM
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA0MDEwMCBTYWx0ZWRfX/04pTjSXeCLe
 +AOnJClG2bNheZ0KseWomv/jxNvcgNQ/vuAPuFaSgxeFOeBtzK3w6Vo16NAgY4DbSuCzaCL/qKy
 ttbITXN7zDgO5qnZgzDuI2T3n3P1IoE=
X-Proofpoint-GUID: muvS3Cz1qhmigmpNdXSrsV8JZ9Qrt7nM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA0MDEwMCBTYWx0ZWRfX9QX+u38R7YdC
 UejcIqNW1FVOWqcmKVF4E6ImnGPYEEiv0J7P2dDP1W/RtjqTOnxqaE1287vZiy8HC1+DKAyInVD
 HFyxYKlTze83CGTfUENyl1e5KozEAuobahCtDMg6JW/Ay0mFj0tfOrt6yKEqIsluxGN31WeURjb
 DWmCwc4q56Syh9XZBdCS+Vr2ZzZNZxZltwAwEAG5iDd6wxDYtONsr1sgL5H55QcrUlJ/HhVCSh+
 JQUi/A5mC9s9Nh8ChDNc6dbvUqRgxG/Pk6v5H3Cpyw9+qKtMhNYiGv2OCN2l4wbSwTMaYjsAOCV
 Pqs4ROeZGCf0Q1Li69eXJWOt9bUY1o1+JiJ/n8tMzvLjL6guPFrr/qd2BYdgUgDCNR9vbTTtK6c
 /IrP92eh2c/PLepna0qvkutiKZJKogF3VLXdvO2YwBonrhA5JvDAx0JahGY9/keKjWJLznt1qHF
 sLoOgESwBjxAyWQ9k6w==
X-Authority-Analysis: v=2.4 cv=X9Zi7mTe c=1 sm=1 tr=0 ts=6a9aa6da cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=pGLkceISAAAA:8 a=5JAL46gkvnvGfpoXBbIA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-04_03,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0
 impostorscore=0 suspectscore=0 priorityscore=1501 spamscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609040100
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 3/9/26 22:50, Yonggang Luo wrote:
> - Change TypeInfo.is_available to take const TargetInfo *.
> - Pass target_info() from type_register_internal().
> - Add target_is_riscv64() and target_is_aarch64() so TypeInfo can use
>    them as is_available callbacks without wrappers.
> - Keep target_riscv64() and target_aarch64() as wrappers around the
>    current TargetInfo.
> - Point existing ARM machine is_available callbacks at
>    target_is_aarch64().
> 
> Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> ---
>   hw/arm/aspeed_ast27x0-fc.c  |  2 +-
>   hw/arm/aspeed_ast27x0_evb.c |  4 ++--
>   hw/arm/raspi.c              |  4 ++--
>   hw/arm/raspi4b.c            |  2 +-
>   include/qemu/target-info.h  | 18 ++++++++++++++++++
>   include/qom/object.h        |  8 +++++---
>   qom/object.c                |  2 +-
>   target-info.c               | 14 ++++++++++++--
>   8 files changed, 42 insertions(+), 12 deletions(-)


> diff --git a/include/qom/object.h b/include/qom/object.h
> index 49956388098..08d47c632a0 100644
> --- a/include/qom/object.h
> +++ b/include/qom/object.h
> @@ -487,8 +487,10 @@ struct Object
>    * @class_data: Data to pass to the @class_init,
>    *   @class_base_init. This can be useful when building dynamic
>    *   classes.
> - * @is_available: callback invoked at registration time, to dynamically check if
> - *   this type should be available or not.
> + * @is_available: Optional callback. After target_info_select(), QOM
> + *   calls it at registration with target_info() and skips the type if
> + *   it returns false. Callers may also invoke it with a chosen
> + *   TargetInfo.
>    * @interfaces: The list of interfaces associated with this type.  This
>    *   should point to a static array that's terminated with a zero filled
>    *   element.
> @@ -511,7 +513,7 @@ struct TypeInfo
>       void (*class_base_init)(ObjectClass *klass, const void *data);
>       const void *class_data;
>   
> -    bool (*is_available)(void);
> +    bool (*is_available)(const TargetInfo *ti);
>       const InterfaceInfo *interfaces;
>   };
>   
> diff --git a/qom/object.c b/qom/object.c
> index c5a1bd74a38..5d959743169 100644
> --- a/qom/object.c
> +++ b/qom/object.c
> @@ -176,7 +176,7 @@ static TypeImpl *type_register_internal(const TypeInfo *info)
>           abort();
>       }
>   
> -    if (info->is_available && !info->is_available()) {
> +    if (info->is_available && !info->is_available(target_info())) {

While this might work for the single binary, this doesn't scale to
heterogeneous emulation, which is why we started the single binary
milestone, and where we are heading. Let's think about the API we
want to have it right.

>           return NULL;
>       }

