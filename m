Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED21A606A320
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Nov 2026 05:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=AEkoWsiL;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=iPhINlT4
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTusR-0004i4-Jr; Thu, 19 Nov 2026 00:40:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xTusL-0004gO-AL
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 00:40:01 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xTusJ-0004pB-Qq
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 00:40:01 -0500
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AJ1BARc1286456
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 05:39:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 +l39WlCMV80VC1IwLcMQTewzuoA9Bg+ULbAOXuNdQzk=; b=AEkoWsiLrODScX5N
 Ib1eghcsjTI9astCS8TvzsDprLTI/EbkvSlHgQVyNI1Db0xJJ5VMqkTmMohuBmps
 kaL0vNZRsOdFfW8J0kSNH3UIyMGmui5mVXFVDJwz57tSYWc4GADF0cBzePDQFkMu
 5qSQg1sFPhIuItDKMpvPAurRpcpklKo9lGOGMsgHgjkRWcBYF+tw5rrdn46qZ1Ky
 9A8bTuVgu5gdtDgLcFyUz9aPB4XIoS7hqqu+toBOejjhXygI4LiD+1+3p7nXIMHl
 6njcWpX7chwy+XGaFDT4tntYPhWGKuI49bxASU3mBGG+gGBIdTQwABBLJaH4iZiM
 Uq3KoA==
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j1g3ktrhm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 05:39:55 +0000 (GMT)
Received: by mail-oo1-f71.google.com with SMTP id
 006d021491bc7-71aefbef495so2216230eaf.2
 for <qemu-devel@nongnu.org>; Wed, 18 Nov 2026 21:39:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795066795; x=1795671595; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=+l39WlCMV80VC1IwLcMQTewzuoA9Bg+ULbAOXuNdQzk=;
 b=iPhINlT40SX2Teo4CCSvzsU+17EKM5uAIQ9hfeLfz1+OLLBWdX1FXULkNJTFGgyOwJ
 kSrEldVNDIMI0HzAUjCoH3uoe47UHfFAsF2HOCfM2fZsrRX43vhmVss137QvFY8aGzSq
 KbRFwfnLDUdkYqA0IWURLPw4k+6HICKZeVEWLUYBv46h7LncsVbzi18w15+2Vl+6zkqP
 sdPkoUuW26tSAg51ryHOv7YRD3p51VY60p3ds2/phhiFzDbVrB5Lfb/U7JhW1D1Wat2l
 nX01c2DRNFdq4Q6ZOvlIJA7l5moHW6qR34gdoR4De8ds9+3bkiI04aCdKaGRKTcmTyk2
 5wKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795066795; x=1795671595;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+l39WlCMV80VC1IwLcMQTewzuoA9Bg+ULbAOXuNdQzk=;
 b=mKuYud+Th1V/BICIKpAoG2WiSD2n6qCKbrGn86VUQ/I463S2Oieh4PGPnMx35/i53t
 lksh6gp//axHLFVu9sMtaAptclSMDHsxMTmG5Bm7sVe/ZrK58oEue0LI0FVDTx24tewR
 ueXN2Qbamu0WuajryJfnjejV+wEK4fWoF0G9lnIuKJOF/ou9Yt4NkrSau2jEIv6m6l0z
 Qy/QK1428F7eT/nWMJYc7aaGEMUOYUhxGZ0hf0yReZ1CPgWOwBAgBYWwDckM9a4ohSvt
 pTzSTIfI6skIXSMsD7e9WD7V29qxrSqhwYQHvnnjH0RCSVlMPcHL25p2RlSfBxEWIpGQ
 l22w==
X-Forwarded-Encrypted: i=1;
 AL+hErHErzFqXQWUE/K6vMP4EKU690CksNlZ+r0D9Fa+3GPawadewYwEF0SQJKJyBcv4P/d6te7a9kMkcdGe@nongnu.org
X-Gm-Message-State: APuU4Z8gaG9YXCHJyRT/9rNZV3w333dJ9xYpwEbfwK70OKpBJ6sSA1CU
 c7oHZfKTfrxEGoOvbq8rLeVZKGipLAxPqISCrvDIi9o/oieWrj8R+M4wAkwtUBiLMiZnFqoElFy
 U8FZOASLEzHVVajt9wIV4/tSYNEGKfQkH5ZwZNP24oAmW4YuJgJWbgmqCiQ==
X-Gm-Gg: AYBFou3OgqWC91cBBkN3Bj+UO9tT977sxZctn/XJScpxDurephOlVatnOS7HuTh2oRi
 zsrZ+iZbgyZCyXUSA+kaKCcA2qqHmhr+Qz3SJ8DJswR8OfSvH020wH5IRi9dadmZJeV+SB6lp0B
 Mavt/n5ymokqpITH0TWxdc9thCy09ilJ8TZ+3+AlI31ey6d9Wlk0s8xo0DXEWNKEd9mPMhQkXaL
 l/Jirmn781z84HYkhkyu4LOeMSRAYgjnCm4belLthFBUzxR84smpbz8LYqkQJOswJuHv663tUBT
 HIopIr9iu1/sLVN100m1lN7eOgCr0Z9+urzVY8Dkl0OMj3k2KwEhvTM6i8aFSjUOLzJDo8RET1a
 oYLqiH6LlYeqLWsMDz0jQ4wyWZ/tyEsOFKhu1CXSU99efHUuJ5JLMIW/fLBqaL+Zgwsyirc4m6H
 LeHwv7bbD0fd+YVP/XXxjTYujpYigno+UBl7oWAV3eCIpWO7SGdGWx
X-Received: by 2002:a05:6820:c5c5:20b0:71a:d99b:e86c with SMTP id
 006d021491bc7-71b1843fef8mr2679162eaf.21.1795066794739; 
 Wed, 18 Nov 2026 21:39:54 -0800 (PST)
X-Received: by 2002:a05:6820:c5c5:20b0:71a:d99b:e86c with SMTP id
 006d021491bc7-71b1843fef8mr2679154eaf.21.1795066794221; 
 Wed, 18 Nov 2026 21:39:54 -0800 (PST)
Received: from [192.168.1.199] (104-54-226-75.lightspeed.austtx.sbcglobal.net.
 [104.54.226.75]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-71b19450af7sm3853709eaf.4.2026.11.18.21.39.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Nov 2026 21:39:53 -0800 (PST)
Message-ID: <4d35129c-a9fe-487b-97cf-4924ad193cde@oss.qualcomm.com>
Date: Wed, 18 Nov 2026 23:39:49 -0600
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] pc-bios: rebuild H2 firmware
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
References: <20261118171410.3753915-1-brian.cain@oss.qualcomm.com>
 <20261118171410.3753915-3-brian.cain@oss.qualcomm.com>
 <d206eb87-9f61-4655-9e8c-bc18ce66d376@tls.msk.ru>
Content-Language: en-US
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <d206eb87-9f61-4655-9e8c-bc18ce66d376@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE5MDAyMiBTYWx0ZWRfX+e6P6SXhVZbo
 GJxW9AgQrue7K9A34xp+7S2mwWuR9r2YARRZovotxILr43T0iJ4TT4z29JcqyKJwT2Kn7npm/3l
 0TFP/wR7lW2/Y5Jd7wUQcrwRcKF1STb3Y4CJD+tNrzv0JO4B4sP0x/vE8IZcaTXELLI/69E7F/H
 dB6BqYaOC9KiOafvpAiYkgD9bm+7m0syftIF7xwJxgsebbpOpGW5IiETsbwO9JepakbqtdbpB0y
 00BK8LnVNpvc+AIvCtcHK3gCSMx2qutXcSW41ipmEueEhJ9q0e4UNXGBfMH8T3WtZrrV5y8BnbR
 rwTs3xhVo1PMlxq1Rq9hRLaN72JCxXR1D7trRUnH6wYcZqfU3BcbQvIKVcLZ+3uVi8Vc5isEVKE
 umfix8ih+bxY36DtGMiLX3Qq2x9PEvAXQjAwutTDO0cHEWmIrDyItglJcueFaUy2AwEIwwcmk0M
 GwM/3CIh2BbUWuSStBA==
X-Authority-Analysis: v=2.4 cv=Wom+otfv c=1 sm=1 tr=0 ts=6afe8bab cx=c_pps
 a=V4L7fE8DliODT/OoDI2WOg==:117 a=x6rl1zRT+JsLSO7OGbGBKQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=75yZoPy1ll2WDghHyD8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=WZGXeFmKUf7gPmL3hEjn:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE5MDAyMiBTYWx0ZWRfX6Km7xUoEaUS2
 vYa9NqyhLkyjeDoQnxcTY/Q5b+d2IkBA9cXzPOD8irlgEE3F/55SvGELuz3OypMpIgh5QSgboTC
 Oo8rxUESZZJJyeZ0UjgyOx71YHXN/Ck=
X-Proofpoint-ORIG-GUID: ZcIPFL4CFwaWkNOAeL4O9BoWqR0ijKfk
X-Proofpoint-GUID: ZcIPFL4CFwaWkNOAeL4O9BoWqR0ijKfk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-19_01,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 lowpriorityscore=0 priorityscore=1501 adultscore=0
 spamscore=0 clxscore=1015 phishscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611190022
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On 11/18/2026 1:59 PM, Michael Tokarev wrote:
> On 11/18/26 20:14, Brian Cain wrote:
>> Rebuild the H2 images with the updated roms/Makefile.
>> The H2 sources and build ID are unchanged.
>
> Do we really need this second commit when nothing really changed
> besides the way where we're getting the commit ID?
>
> Not that I'm opposing or something, it just feels unnecessary
> (the binaries changes that is, not the change to README).
>
It felt appropriate to re-build h2 because the makefile changed - so 
that there'd be no confusion about the inputs to h2 when it was built.

But if you prefer, we can drop this commit.

> BTW, it looks like the firmware files aren't reproducible too,
> just like many other firmware files (since a rebuild makes them
> differ).  But it's an entirely different, separate, much larger
> question than the scope of this change.
>
> Thanks,
>
> /mjt

