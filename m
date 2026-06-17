Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 330BBCD98F2
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 16:20:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZszO-0001AW-SK; Wed, 17 Jun 2026 12:19:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wZszM-0001A8-So
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 12:19:40 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wZszL-0005q5-6q
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 12:19:40 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65HFoUe52731327
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 16:19:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 WUXUBYta4IVpCJU9zFsoItgoI3lkuFqg7Ese8LS+vc4=; b=Vgr4371ca1pnvA5H
 tT5EIWWU1t9qwOkG0UBHg4ZEWt742gZ/FUZnd6nh0dhShY/xq0ezhShuzRT/+f1z
 KqeRKPDzJCkrIeBF5TYW6fjQs+ogZkzBXH7E4SzdMQOUib53BHscJB3bMAQJdjb4
 kCBrEC/rpnDQhirWQjW/FTG0keM3QrtFOm8vxYBJ5YlnFvRsIMHfOkQXy1GWwE+t
 4r0lMTx2PLrQiktZsrK416tYUA9w9OA1ARG5ZAM0OG8vNo1u+mJQ1ZQjFqBMywHp
 qUODlACaldY6/DnEi82YbUUDaBDurOwj1AuRKJ2MNwGP1xri4dIXg6ynzvkNPWCg
 IM9qCQ==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eux2c8b21-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 16:19:35 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id
 ada2fe7eead31-71e302f0621so353492137.0
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 09:19:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781713175; x=1782317975; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=WUXUBYta4IVpCJU9zFsoItgoI3lkuFqg7Ese8LS+vc4=;
 b=fv4K3epem/BzR7JnyBD0D5e0ZRhxwGUSh+n9T7ZM8ukD41wiXddakOI95vMSvmooJK
 yLLp85WN0XmgmdrqJ9x2gV2xvlvFK4C7vmZ8HuTDA7MQat1eYELawROZ03uNm96su0dy
 +iYS1jRVa6awPm7gNJ7ZRddJgvXVrfNpVGTIM8jRiVPhdliOQWwerhdnpexks/cRHBg7
 B3mmukfJoMJgaIWJkYz2ltZRamIV/EWjKn/WhxAK85nWhc1Z018UliZPmX1AH6MYGPr+
 C6Ib4iPLaDiavFyjQ0Uf4RNnoPcNwCIntqDgzM4xv4DNDXBiPty8fPQJh5pOztNirJ1/
 FnoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781713175; x=1782317975;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WUXUBYta4IVpCJU9zFsoItgoI3lkuFqg7Ese8LS+vc4=;
 b=jLmQF0mdfUev4heD1AK18mvRy/hL+UBD1EYG+l0TTyWDcSSpErY+8yv41Es1tSP8yf
 /m+ITpookCgCivQJWYAUw/fJuhRj2IGFCOqFDoQC2Gyuf70TSZp5cCHDC08rIHf6IZBJ
 E7MvtAQHtEdkf9UONcFnQ32/Hjkk/KfGghu7595RdFi9VZiSDw8PLsSEPDu9/K4Bg0qk
 s342+377ZOE9jk0q5fWT4OtYjDSCp28xwedqFbPoSWlHXOctoFblPgOgz0ayoZp9BTWz
 3Es0GU9GSboSxRg2d8eXPKI5RMNQQHmG5SRP5CLUkJxwxW4pyDO6BYMUYp63bcqdNvXV
 XF9Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ80icOSi6RGaziX7U4FYjydqUmxc6W+RuhJDrVYhGSVKehBTxzjZt2iG0jcbdRfZFM5H4b1J8drkhCx@nongnu.org
X-Gm-Message-State: AOJu0Yx0EXuGJB08N//KiFyLD8ZN9fd1O6hMFFPVEFrgZSrrjEibtmKI
 mV4a0sIInSL2AJ/xftFsh4AAmlQlVqZol4xTW7m3xivwgucDUnsDbOlOF8le3FlsOYYTIB+nnqq
 hz3kQqxn59+899yyU3qc1Mv7RYiNYcMXqVAzpW9Rt7bwwPhIFIqNSAB6C6Q==
X-Gm-Gg: AfdE7ckHKex5Z5pb9rciTROyldd+xAudV4KKXcz0I4/QupoAn9bY3BKNq2if3/3Q5lj
 rlPSCfc8o4bBOAlphUkJyMBEr57QyLIct4JrwsRMBRw0eZnJBjp8kOULelJN9GqahzPAldcOFfA
 ycDM+F1iSgYL0ckJT6Om9C2RvZ9AMDFpBWFiqTC5fibF38GtuLawyYesIO3yEhd3p4IT+niUFcu
 AW1oKN5oX681Tq9EiEnFw49YuXpzwunOjgFzaYi0uk6iyXOssQTA+88oH3aEc979r51cNBEisBV
 FPb6iQ6/42+jgiFMUR5rai3kzXO5omijmz0cRk3yaHQANi/6h8l/EHViRa3KycKmGMES1Rdfpm0
 gcBWdDYAmrT1UQ6ANAP1y0O0E50LVRhCxhZ1V5iSZsdI4DaGa55M1PKULZslNVQ==
X-Received: by 2002:a67:f942:0:b0:6cd:23a8:3a31 with SMTP id
 ada2fe7eead31-727b3a0a2ccmr118545137.1.1781713174905; 
 Wed, 17 Jun 2026 09:19:34 -0700 (PDT)
X-Received: by 2002:a67:f942:0:b0:6cd:23a8:3a31 with SMTP id
 ada2fe7eead31-727b3a0a2ccmr118531137.1.1781713174534; 
 Wed, 17 Jun 2026 09:19:34 -0700 (PDT)
Received: from [192.168.69.213] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f2e592csm58065872f8f.36.2026.06.17.09.19.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Jun 2026 09:19:33 -0700 (PDT)
Message-ID: <b51bd218-03c9-46ff-a7a9-e2e1bd4cf5c0@oss.qualcomm.com>
Date: Wed, 17 Jun 2026 18:19:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/10] hw/s390x/ipl: Remove TCG dependency in
 handle_diag_308()
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>
References: <20260616191716.12932-1-philmd@oss.qualcomm.com>
 <20260616191716.12932-3-philmd@oss.qualcomm.com>
 <05667f78-bdf8-425b-a242-4c1aa21e8626@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <05667f78-bdf8-425b-a242-4c1aa21e8626@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE3MDE1NiBTYWx0ZWRfX2RnWOkh3XIqb
 +qvFPwSzKoo8UMOA4ZQnEYp8SJ5fQO7X13HRE126hRSszNRL0DDYnbyOGn5fEZ1qw2gDMPJEYiq
 CBeHdAR2YjuaBT/rcsx+2feAkDBj+MjoUFBVxGucE2Mw6xNx7XrQuSRQQcMwCF4OI8C2YAYC4a2
 e1sy2g9UW/VBEgPhwDsrqCsVmKXM2s4bdAehxOHL+kKR3Zjdsdg3ZImqEn6tGZYQPFZ2JWqjJIx
 i8LOrY5qUXUUeDe7ZQTN2ar7iwQ7KeY+J8lMs+UGdjG4JhKCZ0RlWwW8UqjCiGXulfThWU/VgOE
 LgUr7mRW5itWThhEOnbFPk2BzCStsxMXKcdhkyd0n4tdmET72oOVmL2iFtUqxJyrKKHZ2fWbC5l
 HhgNZlzjWLObfZdTiHFSCt/ZsjEXv2hAWkdkIdqwvSgKnxAKdYgHFMYW+a7oc1MgpsvuVaQtJaE
 chUbylhblEBj5qv2q2A==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE3MDE1NiBTYWx0ZWRfX9LLERQe8eO5q
 q4TZ4MxCbasJLZL9eoIKfPvRnjQseyYT/E7PgCHXceTVYbH5Fh4B4puGPb0v6UOtmlCTVsHADLz
 JKzZ8LVTSUVPGQNtHe5QnyuvuQoZeRc=
X-Proofpoint-GUID: Xrzah0_Zt4SQImwfjGuckHEUvv3WgXjz
X-Proofpoint-ORIG-GUID: Xrzah0_Zt4SQImwfjGuckHEUvv3WgXjz
X-Authority-Analysis: v=2.4 cv=WN1PmHsR c=1 sm=1 tr=0 ts=6a32c917 cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=CD24dtRP5RseXM5x2RoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=gYDTvv6II1OnSo0itH1n:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-17_02,2026-06-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0 phishscore=0
 spamscore=0 priorityscore=1501 adultscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606170156
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

On 17/6/26 16:51, Richard Henderson wrote:
> On 6/16/26 12:17, Philippe Mathieu-Daudé wrote:
>>       case DIAG308_STORE:
>>       case DIAG308_PV_STORE:
>>           if (diag308_parm_check(env, r1, addr, ra, true)) {
>> -            return;
>> +            break;
>>           }
>>           if (subcode == DIAG308_PV_STORE) {
>>               iplb = s390_ipl_get_iplb_pv();
> 
> Why change these return to break, rather than just return false?
> There aren't *that* many places where reset_requested are set.

I thought the diff would result smaller, but not really ;)

  - 4 files changed, 25 insertions(+), 18 deletions(-)
  + 4 files changed, 22 insertions(+), 23 deletions(-)


