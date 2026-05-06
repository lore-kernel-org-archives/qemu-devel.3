Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEB27FF8855
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2026 13:57:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKckE-000243-1Z; Wed, 06 May 2026 09:56:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wKckA-0001xc-FU
 for qemu-devel@nongnu.org; Wed, 06 May 2026 09:56:55 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wKck6-000828-Lw
 for qemu-devel@nongnu.org; Wed, 06 May 2026 09:56:54 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 646C5KwK3036465
 for <qemu-devel@nongnu.org>; Wed, 6 May 2026 13:56:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 /ViqseiIUWdbYmYIPDB0/WyjHj/OsYJtgDoQBA4jmPQ=; b=hAswjB35J4se3yHB
 V4385m+Tt4piXRpNYPE8y+Mwc2j0OfV59avYmhl3DlOI0r8HvG8LkibTmMGQitDn
 FW01WQ85zbnYUNlc7ebJaHco56gLdoNDKpqYPK8+qAS+VvRwzNzYbGBPjJuyK0EH
 qQ1A2Q4zx8NbCkOgEnoxNxyx7mKZRqhg1R0rEPWOAExSpUk8FvNdL9WaNfgAj/Ey
 xyXKmIQexRQGNDVALmzIwfXmJbk0yQnKN0NOJVp4fG7P85MT+djYY0Df5WVW/Pxq
 pvCXUz++y60xiANQQ5Hz2jPxcnSvIxIFeawOXFZZIPOXNrP6kvLzLzg3RXeBYygi
 2DsW8A==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e05bf0d2j-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 06 May 2026 13:56:43 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-12dc3d81736so4093688c88.1
 for <qemu-devel@nongnu.org>; Wed, 06 May 2026 06:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778075803; x=1778680603; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/ViqseiIUWdbYmYIPDB0/WyjHj/OsYJtgDoQBA4jmPQ=;
 b=Bw13Ch1skrK4EC51/v2XtfGTRt0Eg17ianTMi0ypuOj4R8osxKCymAdoPP1EXd1Yc2
 3etVkMtN896LyshfbXvspqg6EyoK3UtxpbgZ9bAcl8kmvu5Mg3D3s/XaMLtO9Qv6wmov
 ERwLPpJOmTket8eLs0aIg46FvcL0pi5XQSkZSvY6P1yD4Ig50TKFtjIkJg5czL4wvmt0
 EMCfU5wlzI+irgFG1za5z+plQTD99jtevVOEzcm+9rwqQ8idqP1EBZJ+yUgVd/TExals
 hIbccNKAfGa+h7NuYkYNK9o95/LclPw4Gq1H1MHKVC2Dk3+NRYgoXVODf/LKCyM57Vwb
 /P/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778075803; x=1778680603;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/ViqseiIUWdbYmYIPDB0/WyjHj/OsYJtgDoQBA4jmPQ=;
 b=ppdQL9Wp/XiyTPPsQvHUIA8MCI+lQxv/UishRG3piKbSm2fIMllkaYKhHslphDT3px
 a+Z+SKrkGItJ0qOX6T8jk78ukGtXEnPb5jHIiM3sfvu3zumMa7i4R5tqYNGAgYWTsm/P
 LeMEBJu8Spodsob48jIfVgPBAMUjexQQAG3Gap/6os/veoJqiBG9bgAPx6FZEXqO2Ivu
 DBBuaKwL/zBorEf58D1zuo2HYLx0beBmYshwHk5QBkGrDiN0CwLvFipHb5uAKY1apb5b
 i5bIfeQine715197laywAjDXiB6IB9fQgtYfJLqzyYzo41J5VDSOqioAvm4Xiwbx6PIv
 PE1g==
X-Forwarded-Encrypted: i=1;
 AFNElJ8Yqcmhv4vKZ5fet4ssopMMdj7VBa0m9ZxhKHqeMKByzUBcksx/6bznYnHVUR4wE7wmAw+VR5kNp3Dn@nongnu.org
X-Gm-Message-State: AOJu0Yz0RUDe3uWd0Cv5hU7hd8RZ+rrs9uSUobebwikmK8g/Z2AwAP3z
 4VYd8ejjcBBFA+GHq2FPUFIaca3ajRAKO1b0XLH+jaLUxB4I0m1FUhExFyG8/36wF+iqcezYcQn
 7QaXM6v5cjZBcPHjBx1bvDmr9Xb/YEn76zjW+RtHr//r+EE81O+trdakEfg==
X-Gm-Gg: AeBDieso8ASC7BL7Y+lm19MH+Pb8UGmd6X8/g2mfzUGzzvHnqwg6w893F5Be+sgRw+Z
 RTqiwOGVVHP3L4tQNU4e0Ltm4uvPcYpg21GtsgBYtcBkosjZh0/1dgVwlf9XOy5CnkBW5h3r4vs
 h2EM0Ipy+txocEwwD6ne7w4y6TwS5Ji4h5UxxXIj8M6WvIsxl3VhqAf70GvaJU9BI2vjfNqlzy3
 SrMJ9bKbgRN9oaVSUSXH4fybWTvEw3wUVI4yDq7tEoyvpFqqXMS56fP22vBtct3HNddb1T3c0M7
 D/GzxmrZ51XJbb+bdTows53zJpE7C9P/lSyfmXqh8HZ7b3HPWJGq1PQUOuTJLQ993y8QgwVHQCS
 5yR29rOG9VxRZ5eJKGijDvOAoOHwNAjzxQcQ+RKRWbjwcs3zi2C40xBGievUMUzdRI4dLvj9lWt
 4Pr1uGZ9I4Wf+njBfZI11x4qlo
X-Received: by 2002:a05:7022:20b:b0:132:270d:7bb4 with SMTP id
 a92af1059eb24-132270d7ddemr286942c88.21.1778075802883; 
 Wed, 06 May 2026 06:56:42 -0700 (PDT)
X-Received: by 2002:a05:7022:20b:b0:132:270d:7bb4 with SMTP id
 a92af1059eb24-132270d7ddemr286934c88.21.1778075802289; 
 Wed, 06 May 2026 06:56:42 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13202fbf850sm4023761c88.14.2026.05.06.06.56.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 May 2026 06:56:41 -0700 (PDT)
Message-ID: <efeb0398-9a4a-4658-ad68-b36af0b0195c@oss.qualcomm.com>
Date: Wed, 6 May 2026 06:56:40 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] meson: Allow building with empty target_arch[] source set
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20260506133216.18730-1-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260506133216.18730-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA2MDEzNyBTYWx0ZWRfX45o1SvNlTjiW
 euShz9CsLWgGDoDDIMzIravPy3uV6Y5OKJZAoW48VksWxMgZC9iG+YvEKJAeUmHsm/wkXG6g9wx
 J8p0NDii5kQzHq8MXA2ZOCwDBuN8tt2fyZHIBRMWgaNw+5HjC0ssysoRYu7Ta1ZoH/UVOTM6Rla
 5sUFvHawy5zk092pvZEF/kR/jMmrgGfpXhFqdl6ec7u8N9+mumS6CY4+LyaV36Qo8rtx1DnQD4s
 N2G+wDo0tibHer2gXnsmGS5xE9G7yA8JwLt17WxNeByY8wypc9qM/Hc0XAAdqbc1iXLT19eA1KE
 kU1pEYFn1Fmrc+27ut1TBA6uhJQ2UoBTHu6WBOTuDTWDlpE95K0uOdHfficOlz/JH7kqa0t5Nfs
 kmq2aR0g4ZcyqDEM/bfi71seIGzN5HE62CtiFNtQxdDWqnbnXJtw3DmW/d6sCyaCp1C4nRI9Ns0
 vkpIGOyoMHN4EVal74w==
X-Authority-Analysis: v=2.4 cv=PqmjqQM3 c=1 sm=1 tr=0 ts=69fb489b cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=Lz8PWAZ7Cq5JEbz8ErUA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=Kq8ClHjjuc5pcCNDwlU0:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: rzOilO296eX6FxUFXnfnmykevRIcnyMM
X-Proofpoint-ORIG-GUID: rzOilO296eX6FxUFXnfnmykevRIcnyMM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_03,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 adultscore=0 priorityscore=1501
 malwarescore=0 spamscore=0 phishscore=0 suspectscore=0 clxscore=1015
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605060137
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

On 5/6/2026 6:32 AM, Philippe Mathieu-Daudé wrote:
> Complete commit 83d5db95d38 ("meson: Allow system binaries
> to not have target-specific units") with yet another guard,
> allowing empty target_arch[] source sets for some targets.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  meson.build | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

