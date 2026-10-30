Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23AC6606A31D
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 17:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=I+RgJxhQ;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=QIGuvgDb
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMqes-0000Y0-4p; Fri, 30 Oct 2026 13:44:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xMqee-0000Wg-O2
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 13:44:41 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xMqea-00074d-6B
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 13:44:40 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69UERj9L3207537
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 17:44:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Qq92suXosY3GkAHZGRlh+NSDNw99zhR9Q1b6BiiMRbM=; b=I+RgJxhQZ9B6Uhup
 Dk419dmeRdU5ObY2m6AW76oYoAKKqqTm3PBFO315jYwu/1eme58D5RvvOHcuFWxb
 LT5/+690BoMK+ZdkahaQtobMhCoXvWEDS2XxdHMhEfHtlTCoQx59U2ih2XFIb/0t
 1ZFWOwYiFeQcTzeDC0ptNSWgKbnS3YQ28+KudfKQ3zVzyLh4ekL/cF4UAUVXRQuW
 o8qTjk+L+CWfCqbShgZB12tPsHqYg1GcxtFNRMqYoKevzR0dr+eRLRbxLg1/TN9D
 /2HrLXRXP8PwSogSa15gQVHM6APoYtMz9sA9RtMrZcdyeuBtweeNDL+kEXj0x5oa
 NscvFQ==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hme6qm92g-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 17:44:33 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-36637676140so1459947eec.0
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 10:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793382272; x=1793987072; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Qq92suXosY3GkAHZGRlh+NSDNw99zhR9Q1b6BiiMRbM=;
 b=QIGuvgDbvPt4ye+RJb1tm8C9kX/wgLlOU0Zx3QCaG00w/eA4ibirzHZIJNjT66keao
 7VjUNeEpJJYsxsMQ/eEvnmnFwCmxRUykcNBUJKMHpWR7SlxbvepFVnHf1vKNppZ5V2r8
 u6BCSAE/5e+0ONCrnjWsmwraqBCVJhIlr/ICGfdhd2GwDAUErOo8/NykTbyPBlAa35c2
 GJ0Vii7CAnsrwxymdnYrrLKMs9EqRCXw42f97qILOUTPY10UYJVyKRpouL9PCGkf5eNP
 fbB2TWQA6Fkgxh89G0dH8Hdj0xcIoVYX+8s6SZ6Whn1WTYfi9vO4zlz/KpiYUerKM73u
 Dhzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793382272; x=1793987072;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Qq92suXosY3GkAHZGRlh+NSDNw99zhR9Q1b6BiiMRbM=;
 b=CUtCmY8vkLz3vfvyUCCIpMZ+UyaEV61DyfUaKHCesNwwcmPfl7A0T+kguFFhTEwAwZ
 kTjlzlP14cF1VacHANx7oXwN3LUOzvred4kzuoUCV3Bt7uuQea9VvtqRmE2pJZPNwVbw
 UtIDxG0Pp7tDfQFeoZBhAJ4MqHlHi4TlRPaPDByKnMB+gloX5emsILaB+q85hhD4a3JR
 eO3+lqYoZIO6yw+SVEOvGJZKSvejRkYGWdPjkZD27SnTY4jLdxjKw+B5bQ73cABMl2go
 Je2wxUz1bHmRTVJKxxqNHxq04lIUhiJS1Nc/84b01jofaKo2vEhcuKTPJ4tum3HzbRUy
 oSog==
X-Forwarded-Encrypted: i=1;
 AKwUvBxXJQuk++v0gV2TQwB/qJBu9LyeeV5PoZAkGaZjmxeFQEn9GaQohCOdJ05/8LrkglZX8ZX+Ig27m0RI@nongnu.org
X-Gm-Message-State: AFq9FYLsbH8myiJmdQO3Q2slowiwgh9+V0MtAyrmq6/9EhW6Gr3zXH+W
 UMgioBBRQ+5V+I+ay4kUjAF+DIev00vbGEtLLImx1UIFqtYt0LB61Ym45dP9NyjElZRk9RvYZ9o
 USqDqkVlRZRg2lU+smZvFLExWWn+f8rOeJRQObQsVvMb9vSxV9HG2i4f94g==
X-Gm-Gg: AYBFou32jHlqYLM8qKY1IFTTrLenbcV1E7//kKSGFMxjMOpNntCALm6fbGltycJgrEz
 HJMyMYMwzpOGAN6Zwpkw+++AMY6XZpQ4u/4trN2AgsBX/AuU5v3Njf6cMhfJBX1zhMAEYNL3GIW
 Vuu8N6Ug9KRTCDZ4rpsWL0/VJWn4ndmUCLN1+oQht7BI9ULm3c4c5iNDLc/7fenb8ZtfYVMWnfq
 CTOqytXB1OsDuCoklx1xy9QszCQsngh2Uh+CnRAYJv1mGdDLECxtZamLNUxD/uNbQJ4eUa3yPoF
 vjA+xO17LfEcZxMUISyYjHn9+I7/fzt5g/5ZwKpNE6zNOZHs2rt3fYgi0IGc3DxRZBp1+CGSDZB
 rXqmbTmwS9CFrXlipQBRQaUYr4n7HOLwiEGhXnNfS6GdeQh7V26ATuXXaf3SK/NUHGCeZA4d9Yk
 4VjgR+IaTcCXbFN2pjwzin9SYsDIGrcSwiJHkMkmsz2uk=
X-Received: by 2002:a05:701a:ca8a:b0:1a6:887b:16e5 with SMTP id
 a92af1059eb24-1ac5e31f9a1mr4430697c88.27.1793382272113; 
 Fri, 30 Oct 2026 10:44:32 -0700 (PDT)
X-Received: by 2002:a05:701a:ca8a:b0:1a6:887b:16e5 with SMTP id
 a92af1059eb24-1ac5e31f9a1mr4430644c88.27.1793382271338; 
 Fri, 30 Oct 2026 10:44:31 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1ac18458e07sm7900744c88.8.2026.10.30.10.44.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 30 Oct 2026 10:44:30 -0700 (PDT)
Message-ID: <f2994f4c-6aa0-4356-b2b0-465960666724@oss.qualcomm.com>
Date: Fri, 30 Oct 2026 09:44:30 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] tests/qtest: double qos-test timeout to 240 seconds
To: Yonggang Luo <luoyonggang@gmail.com>, qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>,
 Philippe Mathieu-Daude <philmd@mailo.com>
References: <20261030154317.1807-1-luoyonggang@gmail.com>
 <20261030154317.1807-2-luoyonggang@gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261030154317.1807-2-luoyonggang@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=KsrYSmWN c=1 sm=1 tr=0 ts=6ae4d781 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=pGLkceISAAAA:8 a=g1-r7mIJbWHR8nllbp0A:9
 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-ORIG-GUID: g4xDdo3Cs-Jga13dK44ZKLWREAfYMpIA
X-Proofpoint-GUID: g4xDdo3Cs-Jga13dK44ZKLWREAfYMpIA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA3MCBTYWx0ZWRfX33JE9fLJLmKS
 eVq8o40QdbRR+U6AgOEsENN1lXgzZiqoN9/L1rzWoa+Rh82IsmHrF/kox1Vmh9y6P5D0N9ELn1Y
 5MtIVltbghjIC9GOnNzYK3emI6COCMVts81iPjQ4C+fYBcCCeU9Iyzoyqe8x+AGupSVJ85mBBpH
 jMNWpq37yf81sEDuTIu1VmRlIRYgwXIMX/uA/Gs2ocypsGB6MoxUPSgaGMIbRieuMRjmmXN4MMK
 EWHtdJpWZVRaOLx70pxz2sdIaOivBQnMvHk77pJzVvzIp51S1V4XMwHMaTxseGlSFUbHdZq1RVG
 p13dHpmMHyYA7Xm25i6Rlt6JG8DZWtzuiEKbgMfs0yku+1boSXwKkUv2Rqv6XuRxIYYzg2IjF5V
 LXEFgjYGK/tsmVaH3CGEbWD91Ip/Qy/71rHZdZfGVvlK/C4e3IJyL+cyIx6iXr6LoYDTbFr2iDd
 CQ+4+8q+/5cpkJG7pxg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA3MCBTYWx0ZWRfXzKTWIRlKImly
 lN8CCN2ARRo1m/327Bnh84+I6oN4OZOosqYoPV4niZJBhMbLVc7JxjlXCp1/3kor+aMS3WjSS55
 XshlipVZrf2kl9h1yJSNo1KgcwG1nNU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 priorityscore=1501 malwarescore=0 suspectscore=0
 lowpriorityscore=0 impostorscore=0 bulkscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610300070
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

On 10/30/2026 7:43 AM, Yonggang Luo wrote:
> Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> ---
>  tests/qtest/meson.build | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
> index 46d4fc1d2b0..c2dd5e5ef2b 100644
> --- a/tests/qtest/meson.build
> +++ b/tests/qtest/meson.build
> @@ -15,7 +15,7 @@ slow_qtests = {
>    'pxe-test': 610,
>    'prom-env-test': 360,
>    'boot-serial-test': 360,
> -  'qos-test': 120,
> +  'qos-test': 240,
>    'vmgenid-test': 610,
>  }
>  

The recent regression on qos-test comes from:
https://lore.kernel.org/qemu-devel/cf0650c4-e6ed-4dda-9b8f-fed5a2762251@redhat.com/

Regards,
Pierrick

