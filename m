Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9BC1CD4F3C
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 08:25:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOtHu-0004FB-3V; Mon, 18 May 2026 04:25:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wOtHs-0004En-9i
 for qemu-devel@nongnu.org; Mon, 18 May 2026 04:25:20 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wOtHq-0005xV-AD
 for qemu-devel@nongnu.org; Mon, 18 May 2026 04:25:19 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64I5YetG2685062
 for <qemu-devel@nongnu.org>; Mon, 18 May 2026 08:25:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 EELbi55Nh7IqAHJ4/zv6ZCSEqNDfGNYK20gLNOmqQ+s=; b=NHsP498dJrmP2ji5
 SRdeQtM2YCdc93F8zI7Ijofc2bMvb1ppxC5M5gbuPI1q1OQWtnDxcSQAleFhpsFl
 t9e21eLTjCJUJyG/X4CDcJbuJf6viHgXmaIBmbZnF87Jw1hQM+Sp4Q8iLXe/zRTg
 GgQABju35u0Aj+MjFCNPSDK+lrZFSjNCsBXDsbkNQXnDHSOsjPS3CIuGOkQnIq5J
 cY4IbZHJoezk2DSL1+8k+7vYjqz8q/r947bnZjPn+3ZyZqwdZ2pOsxUMAHahzQ0R
 AkUv1uSe0KY9iqh2ht5ITfLxW1Jq4pc1wwXvi5TzmCBfhIx/a4EQNrioC787FtD2
 0aMhmg==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e7vrbrreh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 18 May 2026 08:25:16 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-2ee1da7a13fso2474948eec.1
 for <qemu-devel@nongnu.org>; Mon, 18 May 2026 01:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779092715; x=1779697515; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=EELbi55Nh7IqAHJ4/zv6ZCSEqNDfGNYK20gLNOmqQ+s=;
 b=Dk4YSHL2yXp9LpLYkm14codW0mya2PmW9POigofU0WjpXpFt8nIXKNjE/v9MZvj8Rp
 HhlYjjiYwb8pgs4chHQgswvu0lm4yEvIMHck54p/qY5ZEaMoF/FB6UGnURoukgYM7SeG
 f2bdD0E74L2/lI++frK3DhqlxgrMOSRHnh2ySnR98hYWQgc/zkM9UX4Q3pjvbooxxhjJ
 Y+2YxCqI+5L/yfSJM0/Ylk4uTzGCuIK4Vz0L2iVx/FU7poxIKCEvGaEc/g1BM4hu0zSy
 5FYPsrgREAofMAyLP13XDr5wXhRWuWtrVZKs8BMSTloGfY802swGokBvCZzt1AKxRvfW
 F2ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779092715; x=1779697515;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EELbi55Nh7IqAHJ4/zv6ZCSEqNDfGNYK20gLNOmqQ+s=;
 b=GRVvg/85YfkP16AQZuwm0xa0Sl0QRBZM9PlzPi64TwVV8Ql2GbiqmtAA8BtpEu6TvO
 Lv1jbju3h8QD7gI9p3ehBNsXMOoiScvnTXPrtzpGC3pDkwGKLy76VxhovC59rpOkJfO6
 oRVtbD1t86uJ7FaiPg9Ev75MR7werxi//h7J6+o9KhBDVUMacEO11EfYPYSoQ4zleT30
 eRPG9q9ECxkDID/H42E/V7roiv7MkABjraJjVirorvdKM5JngsQBVHUqmR/zcmzWUy3o
 KaSMZPkxz7M2AAfgjSA5rF409z/0vIdzP0NEtB7OeRsmaqWZEJGO5ims6BuTdXXS+F3+
 9S9A==
X-Forwarded-Encrypted: i=1;
 AFNElJ//np1B8Jb/Oew7Vh7/ElgonqvE0Cn0tUiSW2cQyYn4R2t7pkT2FVjm4lfPSKOitDzIWvQviFB9MNHG@nongnu.org
X-Gm-Message-State: AOJu0Yx9gNjz3Gx+0XRk12jO1Yg64L8d/XWWJdbwpYga2KCR1HumjRGQ
 XajYNEumCVPA3PX+/WK7OXmvalkjAlUeE0L5fu0QiH+LKvpWf2zA6jpsfwSrRWDskT8bSZkNgVz
 4KQUsqDtUdmA6H0vys6kbvZ4K8Uga+qToRnhqNgMcxLHVmeJ078Do8Gkmxw==
X-Gm-Gg: Acq92OEG/Hy85DXwBCFriA10dgqYj76thD1ETeBpQBFkqcQSxfulEq2H+wxTbv8ASAT
 8njJ2kBIT+Dm2KxWgUP0jGZfWjjrDIa+WQ2zwZe5LEyIHhpfWuapfbS5eJv3A/i077kY5U1zWUF
 O/rpfvpvoR1nTbsQBvt2bHY+SCacPlpx4zaEUgrsW+jFF4aLGZGjZSW0trhva9Xbx0DlOEbzWhX
 Otrm7oiueYVruRP+mq3agCQkfBfDH5M3QvX2bKPflBjDRFBvpKURuPjc3jPFe86aUU4nRblsxXd
 YeuIZo7U6S7jrzjGtN69HAr1MKwi2Myywaj/Hpq6IQkKYcmaNF2owxW/jKYUzUfAFbOczmTJGPa
 hU5+TS7FImCLU32+7lQmBRl0rtkX+dlQW817uJP4+jbMplbYKKzy/Ihs=
X-Received: by 2002:a05:7300:6c05:b0:2d8:df01:d9f6 with SMTP id
 5a478bee46e88-3039864d5c1mr5904431eec.23.1779092715491; 
 Mon, 18 May 2026 01:25:15 -0700 (PDT)
X-Received: by 2002:a05:7300:6c05:b0:2d8:df01:d9f6 with SMTP id
 5a478bee46e88-3039864d5c1mr5904406eec.23.1779092714881; 
 Mon, 18 May 2026 01:25:14 -0700 (PDT)
Received: from [10.11.7.97] ([50.238.185.218])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-302973bc9d4sm13024749eec.23.2026.05.18.01.25.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 May 2026 01:25:14 -0700 (PDT)
Message-ID: <b718241c-12d4-4223-a2cf-a8086ed7f84b@oss.qualcomm.com>
Date: Mon, 18 May 2026 03:25:11 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 11/21] target/arm: Restrict IDAU interface to TCG
 namespace
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Steven Lee <steven_lee@aspeedtech.com>, Joel Stanley <joel@jms.id.au>,
 Jamin Lin <jamin_lin@aspeedtech.com>, Laurent Vivier <lvivier@redhat.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Kane Chen <kane_chen@aspeedtech.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>, Troy Lee <leetroy@gmail.com>,
 qemu-arm@nongnu.org, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Fabiano Rosas <farosas@suse.de>
References: <20260516171524.19184-1-philmd@linaro.org>
 <20260516171524.19184-12-philmd@linaro.org>
 <5053ba4c-01eb-443d-b364-50a32be41e26@oss.qualcomm.com>
 <2a560940-d834-4184-9369-301ca9dfc5fd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <2a560940-d834-4184-9369-301ca9dfc5fd@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: HF7VvHpOx4pD6nxlg54yDOjp-UmqFUmG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE4MDA3OSBTYWx0ZWRfX0O9woBfk7JFJ
 hyHQUDS/XET6MZcL+OAPppu64+8qGJWPwrA9jpr2HW40Dl1DJjGg78H+TaKa2khnDgZKUwIGsal
 UKqeVL1qXTDbMANQ9Jt0MFI01pMYvFilpD7ehMAeI3GO3SCjTf4AQLAZWtfcJBTuPwxwBL0/l1c
 eiEXatY6NPKrvcD0ACSI8RoMHLW+ulptf42s1Cv/lZM+AMSKVXBYqskWXgFTMEJI9S0uwsheB13
 g0Rsx6HaK0JWDYkSaoVlb+naqKeId4m2/vlzoh0mBDfKpv0gt5/Xwe9tQbuy+jy1VCfH3LwLCIi
 DxGDgKmSMr4FLXhgLDtUux9aIm9QrbnKRuY3onu9lL030jv0DyoklMyTnxGv6QS+wJEeuOIHn6I
 geh46k9eKHY0EEhFS3XDUf7HB+1Tz2qhARIfy05RHvCUgD9Misc2vM2/GXdqQSIja3rtkihtvVc
 nF6IfukdqZsSJXk0DPA==
X-Authority-Analysis: v=2.4 cv=KZ3idwYD c=1 sm=1 tr=0 ts=6a0accec cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=+WjNtiTvTqxFfZe9JAS8OQ==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=CVyTDA8UNC5bGtqKXk8A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: HF7VvHpOx4pD6nxlg54yDOjp-UmqFUmG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-18_02,2026-05-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 phishscore=0 priorityscore=1501 adultscore=0
 clxscore=1015 spamscore=0 lowpriorityscore=0 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605180079
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

On 5/18/2026 2:59 AM, Philippe Mathieu-Daudé wrote:
> On 18/5/26 09:48, Pierrick Bouvier wrote:
>> On 5/16/2026 12:15 PM, Philippe Mathieu-Daudé wrote:
>>> Emphasize the IDAU interface is restricted to TCG by moving the
>>> header under target/arm/tcg/. Move the definition to cpu-v7m.c
>>> which also contains v7/v8 hardware (NVIC), keeping only CPU types
>>> in cpu32.c.
>>>
>>> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>>> Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>> ---
>>>   include/hw/arm/armv7m.h     |  2 +-
>>>   include/hw/misc/tz-msc.h    |  2 +-
>>>   target/arm/{ => tcg}/idau.h |  4 ++--
>>>   hw/arm/armv7m.c             |  2 +-
>>>   target/arm/cpu.c            |  2 +-
>>>   target/arm/ptw.c            |  2 +-
>>>   target/arm/tcg/cpu-v7m.c    | 11 +++++++++++
>>>   target/arm/tcg/cpu32.c      |  8 --------
>>>   8 files changed, 18 insertions(+), 15 deletions(-)
>>>   rename target/arm/{ => tcg}/idau.h (97%)
>>>
>>
>> This patch creates a problem with the (now merged) commit:
>> 8d3e31c0d575b3265ae5cacfba10680718ba5a22
>> "target/arm: Extract IDAU interface to its own unit"
>>
>> Indeed, it results with TYPE_IDAU_INTERFACE being register twice which
>> fails at startup.
>>
>> Maybe simply drop current commit?
> 
> Yes. I'll repost, but the series still won't apply cleanly when
> the "discarded const qualifier warning" fix gets merged (just
> letting know, I don't mind respinning).
>

No rush to respin, as I fixed it on my side for now :)

>>
>> Regards,
>> Pierrick
> 


