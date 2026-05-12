Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC90ECD4851
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 15:38:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMpBe-0002tq-92; Tue, 12 May 2026 11:38:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wMpBV-0002qz-0h
 for qemu-devel@nongnu.org; Tue, 12 May 2026 11:38:14 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wMpBS-0001yy-SG
 for qemu-devel@nongnu.org; Tue, 12 May 2026 11:38:12 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64CEYZ4v1733323
 for <qemu-devel@nongnu.org>; Tue, 12 May 2026 15:38:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 +1YlZ/HAhA38NUOlwJWZiryloZbt5XFTQ1jQOWN45SI=; b=QCBI99XPEj8urB5l
 trJz4E8KsobG40lkfBpHPrDXj3+EyV487G/1V7Av6iHYe+zQizzXe7YFhHVvEFWW
 YEpJQZ1uYnItCjxJ/qofdj4HT3tZAhGux6LGb1LKmzOrkg5QhRI30vraUBhMryZS
 pIyV58GR3CXZPN9fW5Lw53fR9SGeoEF5tpD4FIgBCVBI1D2oVVid+jjEa5ztP4YU
 qEJYzTSj0a/VFI0GSJRgOQL6w2xoXLo6Ghe4uOItmqtPVKHyAYa/2XnniYWmeUCs
 MOnJNMJBfqd53IHVp9WW+SX34cQjWllXAgHc4OHVuyEn238w0B30lkrtUDo9GABn
 HrJe4A==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e463dg8a6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 12 May 2026 15:38:08 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-2ef37c3f773so6801518eec.1
 for <qemu-devel@nongnu.org>; Tue, 12 May 2026 08:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778600288; x=1779205088; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+1YlZ/HAhA38NUOlwJWZiryloZbt5XFTQ1jQOWN45SI=;
 b=D36r68dSZsw06USH/v/gtgpFlaJLh3sYK5C2E4JnC/iiU1l5sRkhEMzbQBeCGPom8K
 c6fl1XsznLCadeiTahUK/tDU8VJtkpoTDccpQvUc2hlBLd9/kXRW44CVL4Ygd2cj1TC0
 AiN2zZqAr1duM8r4AGxRvIrJVjTeeFpCMr8JAw5Uj6E1lVBQdpVjldv16JK8otA21i80
 dtaqKrP094fylTCI/JaSZ/6H5GS0+0Hzkyk40OJeT2QgIBUXeG84E7eDlHwbJaOpFvrD
 nsIqs4/idq75t+yrTOhgEzIsh6+QzY9m3xGXN7tEeO9zTsCcdOjBNu/KID9lUh3WRLh2
 dBEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778600288; x=1779205088;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+1YlZ/HAhA38NUOlwJWZiryloZbt5XFTQ1jQOWN45SI=;
 b=VCFsiSAwHYs0X+yJi1SXNzUOnBH2A/Q18zmkq/+qB5ow/+qnb4WivAMP1Z48h25d1W
 XFtEJ5MPgc66epc4OVbRi/aSDZPWKfCTbJ22oSD3eSYpCzUiatECNizEPrDIMpBifdxM
 ylnSkku3mzhP4CKrmCCQnSHMXmJ20HplDZULYsgZABnmlj26BXJ4lRVCjCCLePDgAkjh
 GgXDOG5syMDZqbOnYkWAfRNlIRgFikyU/2JHX8vvLIAr1jqEowTr0mvy7Obnj/bJ68f1
 u67FWOF5a6lvAVHy+4hMOZb1Njy6fLpCCGkC1E/OzjSP4OEnd6yPDNAIvHFjOq0wXfbx
 1d1w==
X-Forwarded-Encrypted: i=1;
 AFNElJ81TWEWHflF8J5dO1XSPQ74h03WQ6mVIEyZZk6Y5DzFBHjlXlTwwaxybddwOjKoK90Z6D5NRsMbwtAC@nongnu.org
X-Gm-Message-State: AOJu0Yx2VOA7ItbvERBo5HyGIt00tT5gSLzBDfhuEsEUFuuF37YFVW9u
 Z0ddrsf0Q2Cce7aw8m9bA4F9xOkbCkbtnciDQgbigtZL/wfZxbly4ldngpCb4zyTLiVAJavEd2P
 /QinhX3IIIlQ131gBBxTkawj/3Xnx0VJyqMRWJ3lHPp5ycmjg8M4tbjJSpg==
X-Gm-Gg: Acq92OFKd9FB5BWlFXJdefop77KmlsGYP6LgQ81NZjFAeCk1DGIs7Pj/tp2q5Lr5l9O
 3cJbXJSDcZnIMtUES0ElBH8MWC+aqZeGJNGErd52NpRjDXwdu/rcc/qF8A/EKuZcv1KZgSH3m0F
 RgeS2f3+EPzrA3gjzOz0gr2xSn1AHcUeuzXNRwsO5Mrv9yknIPn6Lw75OfO6dbiFMI8BydibsoJ
 lFEwFBtG/aOsjhGHnKK4gOio4indmbN0cmE0FgxWe57DeO3N6tU/XOnZEHhGDue9R8sekbwL7m5
 PEZAdyL04lczTtHufoCQjIGhkjDm9p7kEfD05tKM5qVwEdq7srp1KpGNxfSUH3vTVyUwIZVVdoc
 Uy7znUvarhQPVPL49YtqoEoHf9yrUj3G+mPn5OXHYXZBt7k7jcUINXdhtk/OaQUgHyQNhZzf83A
 DQyWVVSfpsXCC57w==
X-Received: by 2002:a05:7300:5352:b0:2da:a813:a5fd with SMTP id
 5a478bee46e88-2ffd75efc9cmr2160250eec.22.1778600287412; 
 Tue, 12 May 2026 08:38:07 -0700 (PDT)
X-Received: by 2002:a05:7300:5352:b0:2da:a813:a5fd with SMTP id
 5a478bee46e88-2ffd75efc9cmr2160220eec.22.1778600286771; 
 Tue, 12 May 2026 08:38:06 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2f8860ce1bfsm18928718eec.9.2026.05.12.08.38.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 May 2026 08:38:06 -0700 (PDT)
Message-ID: <454f8d07-ea77-4db5-9877-305e08d46dff@oss.qualcomm.com>
Date: Tue, 12 May 2026 08:38:05 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/16] gitlab: ensure all meson jobs capture
 build/meson-logs by default
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Hanna Reitz <hreitz@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>,
 qemu-block@nongnu.org, Cleber Rosa <crosa@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20260424154205.364268-1-berrange@redhat.com>
 <20260424154205.364268-3-berrange@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260424154205.364268-3-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: OFObOLDcxJtlhEZM2Y6OseDV_77Rlcjd
X-Proofpoint-ORIG-GUID: OFObOLDcxJtlhEZM2Y6OseDV_77Rlcjd
X-Authority-Analysis: v=2.4 cv=aLTAb79m c=1 sm=1 tr=0 ts=6a034960 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=dBgznmYQ-dI-89KA81gA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEyMDE2MyBTYWx0ZWRfX088fdxiImPZ8
 u5tn0OITy18Dz1gMtJz2i4HJZ6dn7Of2aUpimJuY5xnB4s4NMOgG8x3EpcMYxouXlL3TUqNeTzw
 hhrnIwwQ2/8Ji5kwU0z3JnQHeiY1J81VZp3Ggv9I+HTf0RtVQYFq6m2csoYaOQ3C56ub+l3FRyL
 afW1ciI7dzQyBrSPR1pYvfoaNRug43o73PijvUDFrH7u/2sAf49f5NpWaUmumylCUxG/VCadNP/
 MpontRdTMrOSkgoB/HOQ63suQjCZEXdit300jfcn/+noGg1Vk4X/84JZ3NrsLcmx+H8FIVU/gdS
 z0AFBKamcp5aD743bKrBYEcnlQAF6uSlp0IfIzOUX64OZbsgeJAGblaP6xDaRA9mI7gAyOH/l03
 B3pz7Adn3Iab7nrTW6n241BTAIN8xpVI2xFrpi/3HEyLDVjLBYSwVoNW+GvQMAnvNSM0zD4N1xQ
 BqrC/HhXYWang6Pt30w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 suspectscore=0 adultscore=0 lowpriorityscore=0
 phishscore=0 impostorscore=0 bulkscore=0 malwarescore=0 priorityscore=1501
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
> The build-without-defaults and build-tci jobs do not capture any
> artifacts, despite running 'make check'. This has proved a repeated
> bug with CI jobs, so introduce a new '.meson_job_template' rule
> which always captures 'build/meson-logs'. Jobs can still provide
> their own 'artifacts:' config which will override this default
> behaviour.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>  .gitlab-ci.d/buildtest-template.yml | 30 ++++++++++++++++++-----------
>  1 file changed, 19 insertions(+), 11 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

