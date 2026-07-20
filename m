Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E820C44520
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2026 22:19:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlwKX-0005FH-EX; Mon, 20 Jul 2026 18:19:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wlwKU-0005Eq-Ct
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 18:19:18 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wlwKS-0003n1-AG
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 18:19:17 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66KJU0JD3368819
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 22:19:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ydE6qmDyFR4eGtNTVXAeQ6tjRmV7Yb/ZNeTfcoWkS2Q=; b=lwbFpPa1nxJAFr+S
 WGF3WUxpig1eDzOrzyMd1HEC7DmnAtjivSE+OLWx58FPMfRuLdESE7dr8A01rT6E
 WY0ndYfxUh/hp6gDHnQ7UUutiT7r/nEamFpXFhOWruP18tNsSgr8EzsXdxH6X068
 adHyAZDUuPpeVdNKH/wurwD7zqq5xg/R3chRjn1vbfjRq6HU3svzpF5vGj0KK+EJ
 QGScx5l5gnI/Dggq9qofQZ0BKEwknMllwkWFJCMBZDUg9M2MbFr9GVz2wOTEWIBm
 CL+N8xEbDyxDAR18xscI1YoEuIhLr096e/DCtERr2rU+VyNKpFiDpWLcsatTZ7H6
 ASwUWg==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fhgs038rj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 22:19:14 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-c856470fe9fso6007842a12.2
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 15:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784585954; x=1785190754; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ydE6qmDyFR4eGtNTVXAeQ6tjRmV7Yb/ZNeTfcoWkS2Q=;
 b=Rh7+pGnBhJ5CUkuX46ocfmmO/MndO3LNe6AgTay26owKCa6wx6ZS2bMKbRfnVZnZzl
 9zugf0mc6kh80SxTDKKv7NHh12v7QsFoZ+ptzhI+IlAQBg0Lvozw++/D/PvMvosFEcrg
 0brpj3kR7FOoySsNRPYiASq/+dStw1qCYoDBg/yKXn4XUoq+5CAjq7+RRehUWOIgPI+X
 2Xp9YYbexyWOsR+piR0Ljna4TkR8fpDYqfOsxFQBnGZS1Ki2abtGm5tGzZkC20uFl2Jn
 lSj9p7trEwwpesbY1Rwa5CbllSxftbQ+duHE0EbG1eQPPDTQO70p5/26RMcYLDVYa6mP
 CGow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784585954; x=1785190754;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ydE6qmDyFR4eGtNTVXAeQ6tjRmV7Yb/ZNeTfcoWkS2Q=;
 b=I72HWO0JtoFih9Hk8lp2S0khMizusB0Tx59eBCRZQVNWVsNQvf0Qwjm/Zm7Bhie2Wp
 N5a26Xea/I/x9keoHr+lUZAjZbytxJb255Kn52hk5afVvfxx1e6x2lpjO3G/mLHTsrjI
 V94rfpg1NJ6K1WH+gTFLPr3lf5RE+lAJU0LsPi+pnmpM+EoQGSBgA03SWm4T/xFiqzxn
 YlnYzT1aZJr30ZZRvZq16cDhc0Yd214AB4XPwW3OkaTxco2oJwL1K3C40Du/lRbvSAG8
 bsnY/X7cdJfRMc1bnz65GO7cZAGaBtZAiIkob96IlQEwMjRvQkRviRhaeMkevTzPsVKl
 v4tA==
X-Forwarded-Encrypted: i=1;
 AHgh+RoS2/EU311qALKq1PAGr/062qjcbe9nkDEdSk+u3fQJFON7kfcQfkM5MK8vvNhxcD2++jlI9QVw9WKN@nongnu.org
X-Gm-Message-State: AOJu0YzwIYsM/v3k/rutwuz84q42D6Yn1ymL3RyhzoU3joNz0gsT+HMP
 xwT8vEIJO/dryrossYJ/TAjsWHktZFcqzdfuzjU/lC3pSiu1NFIRfpS8G9kJgVS8DxnhPsLTIj4
 6vMfERP4eBiEvAbeYXtmAsKUmYIQFYQ0BeGquMWPsp/omQKvBRACHZX+qUQ==
X-Gm-Gg: AfdE7cnRqzAQ1CPSOOCGf5B0mlL19yieHLAKR9gmM9Bv2mNPgWi7Ib0RFeNYkgQy1Eb
 aHVcjg34MTekT2G8UocdbNTXXt0u7K1pD9EkhyTV0SMT5qSE/VFmJroNcyZFdboTfG4x5bLe+sR
 qpp/i5/bARySKcost7Fe5JLB6R0dxdvMREEtWPBhtOl9xzjaZp8cY1f8YWvSWputTceS706kb1I
 LkXIf1JSnB4VNfV7IL9acgh5xQbpjDE4kSLUJGOAaJSLQ9dUMyIfOix/CfyNlwGbYm+SYQpRdV1
 cN6h14FB+jZ89f9o41jqveYx5se6+oGD/pOU8T77sLRYh7N8FTwXO/di4CNtznorpFG0D9YVK9F
 Lh7WXch+7+lyC9IC37kkQgPmbKgQk8nmzqXW6jaH5Nnk6XbsBP+QZPQx0sGqhmemviaaE
X-Received: by 2002:a05:6300:95:b0:3bf:e2f1:1b08 with SMTP id
 adf61e73a8af0-3c3ad9717d4mr16901377637.40.1784585953970; 
 Mon, 20 Jul 2026 15:19:13 -0700 (PDT)
X-Received: by 2002:a05:6300:95:b0:3bf:e2f1:1b08 with SMTP id
 adf61e73a8af0-3c3ad9717d4mr16901354637.40.1784585953531; 
 Mon, 20 Jul 2026 15:19:13 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3142a02b7f2sm39389097eec.13.2026.07.20.15.19.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Jul 2026 15:19:12 -0700 (PDT)
Message-ID: <43747f9d-f7c4-4001-adca-2ca9518607c3@oss.qualcomm.com>
Date: Mon, 20 Jul 2026 15:19:11 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/8] hw/vfio/listener.c: remove CONFIG_KVM
To: Michael Tokarev <mjt@tls.msk.ru>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org,
 philmd@linaro.org, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-ppc@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 eric.auger@redhat.com
References: <20260312224449.1605071-1-pierrick.bouvier@linaro.org>
 <20260312224449.1605071-2-pierrick.bouvier@linaro.org>
 <c3a7cd83-7666-40c5-9baa-ebe64edacab6@tls.msk.ru>
 <3f98fbb6-16be-4de1-b9ae-6108f8f33b57@oss.qualcomm.com>
 <d3f85639-e6a4-4917-8300-d48a7852662f@oss.qualcomm.com>
 <5dc9f2fc-3bd6-4df3-8496-44e6037b51ad@tls.msk.ru>
 <73d87f66-6907-4e02-8026-b89c49912aeb@oss.qualcomm.com>
 <f1a78cc4-a660-4d20-85ad-84431d5a5c13@redhat.com>
 <cfa19c77-6783-0870-a509-691f0539ff2a@eik.bme.hu>
 <e43b316e-e8ac-42ea-afec-c56d2f030819@oss.qualcomm.com>
 <1d7b9883-5f12-4cc6-b379-ce13a1f1afcc@oss.qualcomm.com>
 <ad75b68b-40a7-4bff-b6a2-5dd90401a186@tls.msk.ru>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <ad75b68b-40a7-4bff-b6a2-5dd90401a186@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDI0MiBTYWx0ZWRfX8CSqMMoM5/bH
 3EQLILZabQPNIxGAIsj3lnO/70aB1v8oG8KlFuJydD5Rr/EBD3jtgHC/mtgjjGaopKbYJoh96bI
 DRAezmg1NgJ3mj5Q4IvbPj0v+DMtpUs=
X-Proofpoint-ORIG-GUID: 3M5lTQiIsR2u2hDrrektKwa3piw9JVFU
X-Authority-Analysis: v=2.4 cv=DMS/JSNb c=1 sm=1 tr=0 ts=6a5e9ee2 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=xLbOTg0d_bj8s2U2oDIA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10 a=zZCYzV9kfG8A:10
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-GUID: 3M5lTQiIsR2u2hDrrektKwa3piw9JVFU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDI0MiBTYWx0ZWRfX3Be7bpsQ95WH
 KHB+K11yrsi4xIOQBQgylRUzlfIgUet0w7cLoTGB/1+V/qyW6si6s2cqlw02gayaIkxuBpEVyHG
 4wLzAVyJ22nxKlW0psX03NHIRglyC0RwsVpIEqWpqkvlXpjx9D6pZS/SVb2YuNf2RomPGx5L5CH
 KrQ4gUry3lASyrq6TfWZBxOJGnuKrLa9UO5ySjAZXxjewoCbGB40IXI0/N+luvpNA13qzbjsqU9
 eL6Ef94l52LLNWozzPClRxM9S+citq0JgzXPgYHqLlEIvPV95s6R78arPuSGWkltm477Qp8wFeY
 DjwaoCNZZuCmLa8+ZR6dXPQjo/SWSy9gYfwvuVRsro/8lEYOtc1cyXGH4t6Iai2g/95AB5NwYJc
 gp2rFDMUW4wNnEj2MELadWL5LPQ6tTdRGnPaEwQMAfAFFjEnBjjlMDRWpvioA+2KM07WJaAw/Ca
 lJtoGVt4AqNX4Er3izQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_05,2026-07-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 priorityscore=1501 spamscore=0 bulkscore=0
 lowpriorityscore=0 clxscore=1015 phishscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607200242
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

On 7/20/2026 2:37 PM, Michael Tokarev wrote:
> On 7/21/26 00:24, Philippe Mathieu-Daudé wrote:
> 
>> For the 11.1 release I'd go with this 1-line fix:
>>
>>   -         depends on LINUX
>>   +         depends on LINUX && (AARCH64 || I386 || PPC || S390X)
> 
> BTW, it looks like this can be expressed as:
> 
>          depends on LINUX
>          depends on AARCH64 || I386 || PPC || S390X
> 
> (my lame attempt to fix sparc was to add
>   depends on !SPARC64
>  line here)
> 
> FWIW.
>

Would that be possible for you to try this on the sparc64 host you have?
https://lore.kernel.org/qemu-devel/20260720221715.27108-1-pierrick.bouvier@oss.qualcomm.com/T/#t

I think it should be the proper fix to the issue we discuss here.
If you're happy with it, feel free to send a reviewed-by also.

> Thanks,
> 
> /mjt
> 

Regards,
Pierrick

