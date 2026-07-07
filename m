Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F123C43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 06:17:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgz7C-00025D-53; Tue, 07 Jul 2026 02:17:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wgz7A-00024C-AF
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 02:17:04 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wgz78-00011j-RV
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 02:17:04 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 667495w62526306
 for <qemu-devel@nongnu.org>; Tue, 7 Jul 2026 06:16:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 oobsrCmVsjTRzfac3qRh6AZ6iH4NpjJOhTlaCacpCOo=; b=p0nhqRQNaYgyrlbZ
 4uBtoEOlKkeIx7gUEvFoqYfsfmUyth12Gw3kVDxxSH0enUp7+6aEwtDTfX/ydqya
 rsdjq21xqMi1a8qFcRR4UKwW5yIqUfmerPI/oFXYYEHAkC+bCEvOpVel0JeFcogR
 x8iDsT8mEcLVYjiFkXTUxfxYxlq+zrG+EyoDmZLY0HrbM7bslYjAkMy52K7Dtu6i
 d2hXbD/XxrPxQrVzvLdMAC2HfR/WZFdLAVPXpg7b7ZmPHi/M2Ba16pJ/1rYBMFN/
 loiouVo7yi91gM+etFkpmPlSauN3wMtEpdndQl465nr1WaCSr8JWuceWPD1I7Mk9
 nJDH7Q==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8a98matn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 06:16:59 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-51c1eb52e1fso75741471cf.0
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 23:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783405018; x=1784009818; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=oobsrCmVsjTRzfac3qRh6AZ6iH4NpjJOhTlaCacpCOo=;
 b=ewt0YnMgaYb5c7/oFfDe7OygGa/CV5XaDTj9A1YEyXa3LauJ7/Rqg3L1HhGhW+Mw1x
 syTAzIIeF//7PqVO1AFM+qypdcM/7ye/V/lQB2JH66uDHADpbJavV6uxA32GNEpLZaJY
 qfBIJGzefohldvplSH9Bx7rH50xiMmLKgL/6UZM7BzArreeojYfDojSttB566kVDTZYo
 m5rLv9iPQI9APB6YMIiaAvnh3u72c0pMjiTEx1lSxwuDzHnUMIXj/gNiJogll99WJ1e9
 BFJazBlmvtNg4C2bAs35cyrk0jQG+Z8Anfyi9F+0NDRX2ZsoZebW1UNrGZZIcjFHwrpK
 67Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783405018; x=1784009818;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oobsrCmVsjTRzfac3qRh6AZ6iH4NpjJOhTlaCacpCOo=;
 b=kHwuf/GY/sKbiK0bzObMfypK1ZV0tWJ8RobFTfQKFq4koke0/V5aV8SIjD6P6IvgC9
 fikO624oRkYmd4FQxW62hI7dvj02lr/z89BCrNxFRTMZGXTs030VkkGasPxsljdbe8qF
 FIxjesnVZRGq7ipgrYWbNTYyomGE2UdF9EE6hzyyWTQahSvdvnxiTI6jsihhIYEKuZN0
 NJH8N+O/hvc1lvdFOmouYMKOTkn77iTbfHBBMUAEnOSsqcade8BucgXetgz6EpM2Vz7H
 KFu3yFPSbX87saqzCOtRBJadeulO91LQrM1sbHeZ5LxSivpsYyNTJM1AID5spLLb70ko
 2fiA==
X-Forwarded-Encrypted: i=1;
 AHgh+RqXfHL9e6KvV+3i7CjC2gcjB9rNQyctco66x9n8o/8aJogI75m3O0DiDneTmDQcInSYwjG5chvv3iiA@nongnu.org
X-Gm-Message-State: AOJu0Yw9kd/LRqX2j+e+mp4j6OQIAZabOTsl7ee5BWx2q8gMsrRVy6Q2
 xzphnDLY6RUQS0EVKPaem02WntZE/TqT5i5IBQKSrN5JjtAMJkAQpoUFaE7kY5IZ91vr//PTki9
 ufBfLKq3MV7dx8GlgOdBmxRoO1BCBK9pI/CGE1WupCp8JGoBwXBCswb3q3w==
X-Gm-Gg: AfdE7ckGRdyGck4r96DK8xn4+chsPrg5DszzIs0p29bFTrSF6oGNZC9iBCYxP+Z071q
 mfWx3BmJmen27xlB/d+qsADsS30yWQboSzSYOtFfow2pC2yye/tad5bVfYxR+8hnbaE1ZW2W76Y
 pIqlBCb98ehjRzKwH9z1LnqjeKuwjt9J3nUdFO4aKG5X7Y1a7TAKbAJ3dLT/r0gcN+95NCprAOA
 WNy9yDw7IvOOdiNYB9M+abp2F47EY0qCB5sF07aYCK9WtyQXurhuD5qQhnQ1sXZ/pjm00e4vvrs
 usqeXBmMRTb18pR6AK+Nfhl9OX3fOWLt9nzUG7rF3t/rEkrH+5f0h2mSl7VfRg/6FI6TJFICL27
 s8SXuoaMzcwraVpt5AuMBo3zPdfPrFyaPhoLEoBAEByuXucVCvAJukflYekr7fw==
X-Received: by 2002:ac8:5a03:0:b0:51b:e92f:ec5 with SMTP id
 d75a77b69052e-51c747ac741mr43137781cf.3.1783405018349; 
 Mon, 06 Jul 2026 23:16:58 -0700 (PDT)
X-Received: by 2002:ac8:5a03:0:b0:51b:e92f:ec5 with SMTP id
 d75a77b69052e-51c747ac741mr43137481cf.3.1783405017960; 
 Mon, 06 Jul 2026 23:16:57 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47aa0960634sm32365516f8f.26.2026.07.06.23.16.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Jul 2026 23:16:57 -0700 (PDT)
Message-ID: <c9854a25-5b80-4c8d-a86b-ffdf118349d8@oss.qualcomm.com>
Date: Tue, 7 Jul 2026 08:16:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 69/91] tests/tcg/ppc64: remove dependency on
 qemu/compiler.h
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Helge Deller <deller@gmx.de>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20260706223343.988769-1-pierrick.bouvier@oss.qualcomm.com>
 <20260706223343.988769-70-pierrick.bouvier@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260706223343.988769-70-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=SpigLvO0 c=1 sm=1 tr=0 ts=6a4c99db cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=zgYW7IH8DJL9vgH2loAA:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDA1NyBTYWx0ZWRfXy1NMMCzQFIJw
 6Bh1kn5JYSWJtBvnNGzwsvlH/zu9lZeFq7R5Nd5fwynd3HKHt6gxcWp+mDu9lq9vmLs18V2oMIQ
 iGlZ4dWVSM96zNM+aWM4nnmcA5F3XNhzCfCi4XBvtA2/z91++eI8CA6XCuizuSiS4P3lTWGU6w6
 9yNMIV/gZPiI3ODNApPT5cI6CUs1jsk84zzTAzKfoSoqSgVMZ3tLXGOxBkhH9GNb5XrMZ+JospK
 1qikHKjYpOfIE7CXozcEpBIkSgE6bxApnByf2TL3RmyJmr7p9VLipizNRqF7ndkMmwy3AwYox6J
 HHUe1+sDt4mDyrHtvZmtwyyWBaok1PedU609YsrVAuV8UMwhsmT+aXoP1vy3WxBAL/wF/tCUJQr
 jwacYrulQQuHzmHhhtZ2s8d0Ba9EhejqIjkZpvfYjlQa5VqBkOGqhwH6RImCeORdmA+w5cgiGHO
 ZMF13la5vw3TdSGXvNQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDA1NyBTYWx0ZWRfXwsjPNpyG8/ug
 wKcFEHmc5fOvGkgWLnIyn0ZTe/tfylEmfww3otaY4SVbdkuoi/PsbO79sBq0V+fKpwj03r5WTyf
 PIEKdxv6NzxxoD6gQzZcVIYSofgv9GU=
X-Proofpoint-GUID: WL0rYgeCdBHH90l7NlpFKWf9iGV3KpkR
X-Proofpoint-ORIG-GUID: WL0rYgeCdBHH90l7NlpFKWf9iGV3KpkR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_01,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 spamscore=0 clxscore=1015 phishscore=0
 bulkscore=0 adultscore=0 suspectscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607070057
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

On 7/7/26 00:33, Pierrick Bouvier wrote:
> Replace definition of vector attribute, remove unlikely, and detect
> endianness from __BYTE_ORDER__.

Why remove the dependency on qemu/compiler.h?

> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---
>   tests/tcg/ppc64/vector.c      | 11 ++++++-----
>   tests/tcg/ppc64/vsx_f2i_nan.c |  7 ++++---
>   2 files changed, 10 insertions(+), 8 deletions(-)


