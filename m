Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6E20CD4F25
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 15:46:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMpJb-0006YZ-5X; Tue, 12 May 2026 11:46:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wMpJI-0006Qj-Ky
 for qemu-devel@nongnu.org; Tue, 12 May 2026 11:46:18 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wMpJD-0000hD-0t
 for qemu-devel@nongnu.org; Tue, 12 May 2026 11:46:13 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64CC4V7N3321076
 for <qemu-devel@nongnu.org>; Tue, 12 May 2026 15:46:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 t4oeQYw37SMxU04VQaTxwMmH8zKNnEv6ULQQBxIdfdo=; b=d4qQaYtKf3zwtct3
 9Bj00MuHwGhybLccVOG7j5YDV3L0FYFrYeprJzjlXa04GmNXFv1DtVl0l+cJnztQ
 DotZLDAON0pBB/j1BNHOh0BdNOPe38Nc1gfgb4T6jjHDhCa0l5daeDZjFoj4Zc78
 8k0Lran38ydAIkdtkxFWEgJjoeQ+o+Dci5ANkKAMgD/eKgzwkTYczG+Up3ZOXJva
 Hj6GvCdfOTlz9DbCKYV5xN9W/JuIFl3voMbROn5ptDthP5kPPbT+w9w2pj8+PYpc
 /cncg16AAwoIG2tuh9HoqO1NKqWxOUtELJL3RDaq6y5E/pBcZAoQG1E4r6JGM/Lb
 dUKCwQ==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e43w1rtt4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 12 May 2026 15:46:09 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id
 a92af1059eb24-13312cff948so5534471c88.1
 for <qemu-devel@nongnu.org>; Tue, 12 May 2026 08:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778600769; x=1779205569; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=t4oeQYw37SMxU04VQaTxwMmH8zKNnEv6ULQQBxIdfdo=;
 b=PA/BSiXtMX9GZ6ylHop30oH273BLDHXwhL3TTmGLuBJ5ey/Rsn/UtS3ZEqAojCEb7M
 mPkEUfEel+iw+NukboswytC5Lw+KujONxSQOx1wg033ftSEVu8XJEDVvkhI4U6DZkb8L
 4gD/thZ59S9epg1e47y43jmRDQ/PQPwu/3X68BFjMveYHTr2WMhEtHPSNn4CUqf+yVnH
 kYyNLWenP2mCvGORle8VYxM904P6rPuXQbd4wavbRIQHC4RfkNvV8G9OQKq4axuAD5KS
 KEBES16WnWB4u5g6LfIY4V6xFtBcisoGovFG4KyLkKvC5FSti+AvUhn0BbC5EfFUiCt4
 Kjkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778600769; x=1779205569;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=t4oeQYw37SMxU04VQaTxwMmH8zKNnEv6ULQQBxIdfdo=;
 b=RfZQH0VddYU4zxRcru061eKakMTiJVAi/GPfwv0rxQHlNzj3IZ+r7Cq3JnA4cg98q3
 AyO5f04gPI2qWe2y5bW0Z4ADxnr0m4V/7KwQzeVFc3+QPagJfxouCUNJCEfXSp/MUNaX
 DBbo2z2Xs3uHX9kPnZZOqrM0p1Q0Wd5G/8i4DPNa30SAuD81Wo3vy1244nEzahMlpqzx
 LAjx1cgXAGo42ztOD27uNddkWef/y4yU/XgtmNytYL/xedQUezoZIVHhK/KncscT3ze6
 cmeytk+vXGRpXgQI6okBcWkM3XAWl5sDUmfniYrIwsGwEMpRKp/2yiByHqdjQQtVKNwU
 ehGA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/TL7iT4qk7dzudOpqv9V8oqfaAlLF1JWzHAIk2obDrSh1dkTBKDqcPxNpB49TQ2M7IC5KfLZVk5NIa@nongnu.org
X-Gm-Message-State: AOJu0Yy3pzpS+O1hevjUR070pjokoZ8Tmg8LiAP/wNIvrnn9wkiS90gy
 uMHJM/e7i7gNN5CNJYjmzN/j//TQSQy+/aAsV8iSZoIurG0IgJF1AXM4f7lOfSXugQ15uQo6a4I
 9SK8u7h814kTjEgoeuFszpUCi2mNTbdxnUJRJb9uUOltkpQRJZ36mtsRnNw==
X-Gm-Gg: Acq92OEAuoSRYvdk1BD6j/XV02ZQfm3gRpKnrDfzm4j1MVVgiXEbLC2U4yOs//MZrkJ
 7k+GyTFst5bFFfsiTXUe9g7bLkjmeTOU48FpeL7Ue7gJqTOgNF288bQ/LsGvK+ryYy1m3zGFmL1
 B2EEd/9iEd67bIoVHNGZyk5OJNoNDdLfNcX7wpBtuHRRcYAb8O8dVNh/+PCkUqzg9uq9YWUtVtq
 AffkFeS+1wVL8/3EwH29XcskD3JySANp/fArOCVQnw02ZNAm2xlaK6iux01mGO2Pylyei2TonHs
 LKLv71w1TVqqNLgHgk83Qw7epUIWN1/j2eoLx3F2ywLmQpms8hRDvHMs0L/L7w2YXUnFkFmLqqs
 Zru6NRrIRGUH6bBDtmbBqivKWd6DzrUAL59GfLf84sADAIpsrWbc6Mv0GpGIep1tKzUOZfsD2jF
 c2WCzGiA9IfVV/Fw==
X-Received: by 2002:a05:7022:6629:b0:128:cf5c:5362 with SMTP id
 a92af1059eb24-132a79ef2c6mr8924899c88.12.1778600768796; 
 Tue, 12 May 2026 08:46:08 -0700 (PDT)
X-Received: by 2002:a05:7022:6629:b0:128:cf5c:5362 with SMTP id
 a92af1059eb24-132a79ef2c6mr8924839c88.12.1778600768104; 
 Tue, 12 May 2026 08:46:08 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1327821fc59sm21652822c88.7.2026.05.12.08.46.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 May 2026 08:46:07 -0700 (PDT)
Message-ID: <1fc90db0-8c75-47ca-8396-e56e12f33b44@oss.qualcomm.com>
Date: Tue, 12 May 2026 08:46:06 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/16] tests: add a meson suite / make target per block
 I/O tests format
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Hanna Reitz <hreitz@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>,
 qemu-block@nongnu.org, Cleber Rosa <crosa@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20260424154205.364268-1-berrange@redhat.com>
 <20260424154205.364268-9-berrange@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260424154205.364268-9-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: LEa0EA07XOAs1cb1NECVVwcouyafBinA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEyMDE2NCBTYWx0ZWRfX6RdtYxOH9ZKj
 oR58oiiyj8Lj+iunZ1NMiZ3OaCuB8lMryDW9K8orr0tLn6j93vpnbUb0dLVJClo4ryrejE/FGj+
 t8z4J9gSKb9pnsZ9ogrJ7D45WNxzuoVc+YwnK66thxD+ZYHvjhuLyh/62U7kx2zF3kbO/thrlDN
 dxoh3ORvGTOv/00o6hlsGMVYVxYZ/XSGtuznRZDK+VK2eRYhoaSliwL6/PxiNumieJ2g+8pXs7R
 SzynE/NGNQZ7JZeEGz1puUrqHBSZQWWTIm+qSqbHDk0+TrsCAEpKMFid1q78rpydNL8485wM7LU
 TXxh8TF+UevYeyiYpHmbXYkEZz0MqBcFHD1xFwySE8FgOk8H3tgsiouC12qabrS/J5IRpXGDxVY
 H98J0MP2ZrJ4b8oMqs4zA/X1OMTkIo/se7PvmDU4Ze/KE2XLgnXcZ/J0FrN3+ZrGF5O+s6LLaff
 brIL8wt/auCSwK3d9Ew==
X-Proofpoint-ORIG-GUID: LEa0EA07XOAs1cb1NECVVwcouyafBinA
X-Authority-Analysis: v=2.4 cv=BoGtB4X5 c=1 sm=1 tr=0 ts=6a034b41 cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=WrOjs3o2L3k8GbqiSNoA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=vBUdepa8ALXHeOFLBtFW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 adultscore=0 clxscore=1015
 impostorscore=0 phishscore=0 spamscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605120164
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

On 4/24/2026 8:41 AM, Daniel P. Berrangé wrote:
> Currently each block format is classified as either 'quick', 'slow' or
> 'thorough' and this controls whether its I/O tests are added to the meson
> suites 'block-quick', 'block-slow' or 'block-thorough'.
> 
> This suites are exposed the 'check-block' make target, accepting the
> optional SPEED variable.
> 
> As we add more formats to the 'thorough' group, however, it becomes
> increasingly large and time consuming to run. What is needed is a make
> target that can exercise all tests for an individual format, regardless
> of speed classification.
> 
> This makes use of the previous enhancement to mtest2make.py to introduce
> new meson suites 'block-$FORMAT-optional', which translate to new top
> level make targets 'check-block-$FORMAT'. These new targets always run
> all tests and as such do not need the SPEED variable to be set, but are
> not triggered by 'make check' or 'make check-block'.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>  tests/Makefile.include         | 3 ++-
>  tests/qemu-iotests/meson.build | 3 ++-
>  2 files changed, 4 insertions(+), 2 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

