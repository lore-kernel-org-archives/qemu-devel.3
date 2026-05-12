Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0510ECD4F24
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 15:38:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMpBz-00030l-VH; Tue, 12 May 2026 11:38:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wMpBy-00030H-FV
 for qemu-devel@nongnu.org; Tue, 12 May 2026 11:38:42 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wMpBx-0002Wv-20
 for qemu-devel@nongnu.org; Tue, 12 May 2026 11:38:42 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64CEJRui424909
 for <qemu-devel@nongnu.org>; Tue, 12 May 2026 15:38:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 1RJo738Hdrm6xXyw6VaTn/0EW7Sia75PHwNgSthEGEk=; b=AGBMaRZAmmPEU+P9
 WF1/IdSpIGkL8xxykdjt4gc3hdxaGNf0WL8RR6YzR0h9D68fe4r1UhxkC8zh7pzt
 XdGMEgKjlmJHiHyItXji7P+pXRJ4KVB1ZPXjLs0H0SVJVU5JJiklwoWPMRNZxC6h
 dGKgfen5p+x8bFVgbyjeX74YhbsPH+ViJhy6iycfrkXVKJUPOUmYghq/ohWafKYZ
 OXHCKuzy9DVxRWHuhfV447Ik9fEccTByKn2gI6kd9T3D8/mpCzZvt+N72lF2FvEp
 KRuQrjvKXOHinia13VWQTAQ+MRI09kEl+ju/Umf+rKo2R9GmXVz4cVW1gAOmZr6A
 GecAZg==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e45v58awe-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 12 May 2026 15:38:39 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id
 a92af1059eb24-1329791f18fso7346328c88.1
 for <qemu-devel@nongnu.org>; Tue, 12 May 2026 08:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778600319; x=1779205119; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1RJo738Hdrm6xXyw6VaTn/0EW7Sia75PHwNgSthEGEk=;
 b=PFjCjicdzqCP5jvaA7UB3DOA0Xk4qjIWIiLoI0TWSO0cDB9UJhzn19tQFMMvLYConv
 huNsdVr5nyqTFahOk2bRBT/9Dzw3fuYqebZryqAhMl3cfjH1Verg4PRyWpNis58GNEw9
 6aYUccqAwWMgq6o/bUZCf+dlD2nB0prCFo9nasviKWcKpZvXdQWDvJAaA1OqpzMZb3+/
 J4gw3dDMtLm4/pX3SQfrb2jU0nrYLJ5S55RBRWMIz+n+BIGojxhzTDpJhC1vNsoZiFWN
 sbTE7iXLg8rUQ8BlPZ+wQGI2T8I8ZV0KbdtatVePpwpgCOObH1psaBScA5JjlIC1CVZB
 Gc2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778600319; x=1779205119;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1RJo738Hdrm6xXyw6VaTn/0EW7Sia75PHwNgSthEGEk=;
 b=dC8Kc7UmgLLJ5URrPYUsn2IkPO3xR7vdUOFzxIe2tY7JSkxtGRTBMZZLEB05ITS4vy
 Hm14Nu6UsdZobFtNSA5RHeNEFaxEn+Ed8RX6+OU/fjmDocO5JY3tqfJPKigoVMhqESyo
 0xRhHu6LVx103Lw1QEB7CAWEgVCDd8x2wwiTdhJKHp6TnCMqKCM7i1pgkaPg6pQPjWTn
 UiHU1OkF528LqXyT4tZdZzUPWwj4IH5gpW7DGBKIUEA2PXGb652EkpcKhxjRVhhG+fr0
 bDGwK9wzPLYqdbisa4F4oR5Ql3HJAMrVjV2c7/hUe1uvNmmRnMurfE18Kz7BVDSq/dfT
 eZ7w==
X-Forwarded-Encrypted: i=1;
 AFNElJ+hv/22Fprl2PyZOXE7OVLZZKSKCGgNV+psbeHJFAJy+xIfKsFOrUX870A1Ap6D93rPbc0UDuTiiwTY@nongnu.org
X-Gm-Message-State: AOJu0YwtIJRPm0CeJQlbGcgcDNyx4nc5VauuMtHikDpA0J16E3BAoyiV
 RN9PbvCBjEYrg225VuluOVHBYOQSx4pgkft7kHppkJ7MjjWaRywFXuQuskT/WppIb6X+LFJiQo/
 MCiTJ3AQQEysN0DfWThozYzxHw7/PiHRpndEHFpDgpCDOMFfb6XtE+x/bLA==
X-Gm-Gg: Acq92OHTXcdKd1IpzB0+606pGYKXSVBEk1FQDc9di9mWnfppPTxslNkF5/X60XB12Io
 QcP6olW6lDWVC81mfUgZUvEY5Yxw/ufAmSX0Z+L49sU1Ci1lTwjWS+CNN1MM5KyKkNpb9syvx91
 NHS1FsS2KGCbUbS7C3tU4hOw5B1oN1boBPVglUZGcZ0QS3UyynC/01V7G4gn9fbM9tKeq61QrgG
 IIe91igi8d0MDiq/SHfxXBsPHAaYZq6UVi1G5Sp4buA/uCLwaEGjFNbjH8UK8boxwyAuIrGvodR
 vik6QMb6ovbWYAP3BryERdR/qrSitPBuJwHT7MM0xmjLolaeFGDAAhAmhGMbASLKx4SxRsJhhDo
 mbhtgzAHr95xK9fDsSmRfcPkXHwypjXUQKPOC5yy0GQ4yksAR6dipSEJopBR+YyRdKz3/LvI5Jy
 5YGnndc4JwO95ROQ==
X-Received: by 2002:a05:7022:672c:b0:12d:de3f:f3e7 with SMTP id
 a92af1059eb24-131a69f32d3mr14386779c88.39.1778600318751; 
 Tue, 12 May 2026 08:38:38 -0700 (PDT)
X-Received: by 2002:a05:7022:672c:b0:12d:de3f:f3e7 with SMTP id
 a92af1059eb24-131a69f32d3mr14386749c88.39.1778600318151; 
 Tue, 12 May 2026 08:38:38 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13277bb2b14sm24773749c88.0.2026.05.12.08.38.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 May 2026 08:38:37 -0700 (PDT)
Message-ID: <204d89bf-69a1-495a-badc-03f1ef7e5558@oss.qualcomm.com>
Date: Tue, 12 May 2026 08:38:36 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/16] tests: print reason when I/O test is skipped in TAP
 mode
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Hanna Reitz <hreitz@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>,
 qemu-block@nongnu.org, Cleber Rosa <crosa@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>
References: <20260424154205.364268-1-berrange@redhat.com>
 <20260424154205.364268-4-berrange@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260424154205.364268-4-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEyMDE2MyBTYWx0ZWRfX1K/nFrtSdt+Z
 9loFiWcEyF2twjbWjpeapP6nCeCFG4ZXsnZ92BTN59cp9Xs1qBG9HDz93VMDTSvt55LVxIIc8Cu
 Lf2wuIuR//BZow2yWfxubOw75DSdMMphZD3ZGMu+SyyQJKQCs2whWHU1dMFryVZzbzUJtCxW7yf
 DFn7rhXKqDA00ruh9CoPVlw7RgT/gQ12BZIqZMfN7X4VGqpsSaF2uIB9DBeleqjRBA3bE7zxIeg
 uF+sreiKRitsH9HSHnJ9/qrDLJXAArRvjBNXctxluN96RnqdlSehn7jpqwWJDeFdh/LLNQWykoo
 zgC80jTke5qIMvRPbTJsBql4JAEd15Lv9mgi8+5Y3kIGTmVWSRiheV/whgE8GPh203+1SZA4GlX
 esVTxqUv/clD5lQYzSayWiVKjHUY4AgBCGbot9yDPboXPGG2Lgbv0L2ECipIXTuLJLq4mcwCXbA
 KmB0t5zmAI1yt5MrHJA==
X-Authority-Analysis: v=2.4 cv=GZ8nWwXL c=1 sm=1 tr=0 ts=6a03497f cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=44zaEEGZ9flZBKOlRaYA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=vBUdepa8ALXHeOFLBtFW:22
X-Proofpoint-GUID: OX-gYKKUiF86HM8DBcwLeBWTezZYQNDz
X-Proofpoint-ORIG-GUID: OX-gYKKUiF86HM8DBcwLeBWTezZYQNDz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 spamscore=0 malwarescore=0 phishscore=0
 impostorscore=0 bulkscore=0 adultscore=0 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605120163
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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

On 4/24/2026 8:41 AM, Daniel P. Berrangé wrote:
> The TAP output on a skipped test:
> 
>   ok raw 181 # SKIP
> 
> is not informative.
> 
> The test program included a reason, and that should be displayed
> in TAP mode (it is already shown in non-TAP mode):
> 
>   ok raw 181 # SKIP Postcopy is not supported
> 
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>  tests/qemu-iotests/testrunner.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Good idea,
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>


