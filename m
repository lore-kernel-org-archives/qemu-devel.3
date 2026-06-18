Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A6DDCD98F2
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2026 10:34:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waA3k-0004Sj-BP; Thu, 18 Jun 2026 06:33:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1waA3i-0004SM-Qg
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 06:33:18 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1waA3h-0006jl-FO
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 06:33:18 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65IAL4tu1526521
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 10:33:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 S5GU+Ad9fsOTIGRzJyA/jWOuIr6bcGedHh17/y3ztWc=; b=IJT3VGr3Mc3KOCPb
 Axug/VVgIpmG84nEQyzN8GXMzxa65NQcB4c9yCtoChErWWg1rny8G96ygWhk8dJx
 xJigWcVFJYpyzzPGajG1L8smMQ8IgFIoxOqDvyfHF0xfrNIFqgraavLDYYuPnj73
 NNIZtKCgYYfi+/ZgjG5ikDEluciGIxoA+VAQuvLSOcFDaC4LSjOiKy5iI56ngedm
 2gJVFwU0cv1MurOAcSBcsfS7y1OVjR5mw4toLtbqb1ZTCA5arqX1H6+VPyRVgHGt
 eOuVvuIb+ChXYFyWUmppjqnMpacNxceE8hCgZrVTdsinvls0kwrzBdyAuMv2ySNh
 gLmSGw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eux2jv4mg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 10:33:15 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-918622c3c7bso225216285a.3
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 03:33:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781778795; x=1782383595; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=S5GU+Ad9fsOTIGRzJyA/jWOuIr6bcGedHh17/y3ztWc=;
 b=PgICeEDtgwIo3o2QTxaHCItNZdvCmqqoR4lBZp+v7Jvnu/P1ooOvZSoONGubbkk98r
 cpX1TkD/oGSNUwJPwtMb24vJHVonkFWAZICyeHrZj1cNk8byS8iHEWUJXinivOtRiGi9
 Wke8jNjKs7XLYCVyujI62cXDi09Rs26xcbA+WAP/jew1t1gs8RYOzj1wC6U4L2gZqJng
 sT0QBeuVKUEw8mASiQf6t7cL7gDCRo5Bhsv1w2reUfuHv9jVj4BTXwvQq4hEEgZvTtkn
 LEjXbR2Ta1AQuZTmCxhFrNN+I/YEWMUCSu3VNKh4H45wdEWFzBGvKkK4XFqRqcX/L+t5
 UdQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781778795; x=1782383595;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=S5GU+Ad9fsOTIGRzJyA/jWOuIr6bcGedHh17/y3ztWc=;
 b=WNEXFaSTlHTfx0CpCYrqxmq87+caAEOpTFx3zjU/SOs3lL8E3k6nU1D7dg5ebuRx8W
 F/TzystS/DBV+mrU3JUmdVRI9vvXLsR9B+F15OEdUsniQ7UizowH1KI9h0Ablbmjhke/
 q7wK6PR/OHdr2yovdtiGvAFaoOJpFd7rfZ1vIxlW6yG3Zc5F+DXFckkRuTbEQrYlnTeR
 lT1iIsE00LNr5QnlvedlWjqlU9TRe9OoaEVxi3J9xlNVnGCP/IuJRfOiZIQ0+oRg4kV+
 mcMS9N6/UVQJRTM7fQ93TIdZhtTQj0QH3p0Bv4VfPomhiQ4vQ37JYbX6WMCh4cc5P98h
 FMKA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/6MvE4YXABztlIDGpvkw0/e4yB2ReHuyI5Kw9ZkgN9tf5EV3Kl2z+wvM6dM8RlWMWuUN6MRf4NVmBT@nongnu.org
X-Gm-Message-State: AOJu0Yw/6sZC99hhlbjL/g4Npdh894L9ro4rzM1xpvYkA+kkjUdJiXmw
 1ECoCDjT2P75xYhcXTVCm5n1iyXq2Tb5zmTzYHPofeGN27a8nWYXDL5dvFPJ0kSQtJQ8QL7kvTC
 O47XgH4VBBpWqZcTioquAOWsMQP0ueFxSjszBOP6KWCYiS0uRAwtKi55YyQ==
X-Gm-Gg: Acq92OFxxEs1E/XAVY5tO7zQz6IVa5tO+LAtoSv9wYHpjY1zyAyqKQTve3UlgLalxmS
 1mZ4oQqokQDhT3rG3qeCl0Y3QO4smXQKRmnXBc/RSQm8sobtXyGqO/KFzmAtSG4NgOKrpUkisJP
 ex+O03Ts1LkOucoBrN8ZKtXdRaHfrVrIlpg3usS1eOKtx2Dy/z3Ca9ylwVXhUXyOugWkBmj4vDi
 VbVUx9GW/TJEu8ls4Wk0pukaVTrriInHmxPZZReB44yCEqc8kWM+nN/Y9Ci1dRF1785HsYMljaW
 QsnQJJTlfzZfXCyRr1lmb/TPeZMrt0WjI81JdIQ5xODN0WpMDuMQx8nG8cljsdDO4/bfrdQBOC9
 KBkAsddXZth4VyttOmZm6FLcYLCYw6mCZnhycpWm7V2A/yooiFA1HH0uAjWxk8w==
X-Received: by 2002:a05:620a:1b8f:b0:915:cb40:f76a with SMTP id
 af79cd13be357-91f28b794bcmr494432285a.39.1781778794956; 
 Thu, 18 Jun 2026 03:33:14 -0700 (PDT)
X-Received: by 2002:a05:620a:1b8f:b0:915:cb40:f76a with SMTP id
 af79cd13be357-91f28b794bcmr494428685a.39.1781778794548; 
 Thu, 18 Jun 2026 03:33:14 -0700 (PDT)
Received: from [192.168.69.213] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4619a041986sm37394310f8f.23.2026.06.18.03.33.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Jun 2026 03:33:13 -0700 (PDT)
Message-ID: <9aa55db3-28b2-421d-9690-c8c1bda2f523@oss.qualcomm.com>
Date: Thu, 18 Jun 2026 12:33:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] system/memory: Rename cpu_exec_init_all() ->
 machine_memory_init()
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>
References: <20260616153754.93545-1-philmd@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260616153754.93545-1-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDA5NyBTYWx0ZWRfX/8eCYuMn5Jnb
 YMIaRgK2pyug4sUQJ29hb8tJX7ynONb2yiC2KKdMERMSfcBK1IrgMI7/Qxrby2KquOBCNbWgE8d
 9pY6FgaYcvqZqmsS0hlL2Qf0R05LZ/NLgB+kilc0SAvwIP9PcL2/7nIfpP3F5/d8sXGs/Bn1DUO
 oMx0wYp4k68Vxn2OOJuHY4148hJwRaMbbdXThK5HcIt68ASM3r9+23uNpkQocOKhbBvKTKyA4Sw
 w6c9ZMY8guxvxPSTVfh1/vyvez5Inj8nHK0s1X6UjEYB8N6xj6zGsq3FTnljCDKC9wFoIKj6HkF
 HECJ6SSPxe/k8xcRwANE4RS8ggBFrLx7LkQBw22KTTKNOn7LHuEPkv22no9izIHfCwtLw9aGkEF
 A//K/UV67e/9OTooxbsr4saw3YTwtmwBuyj42djaXtNaIucGPZLz0OZrmbwsH/ZOPpJ7BNMtKgK
 6dlfKyUC7JOsJKQFmzg==
X-Authority-Analysis: v=2.4 cv=Fsg1OWrq c=1 sm=1 tr=0 ts=6a33c96b cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=ONDNzV-dXf8L6aH2kuIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: IlSMb_almSNGzXpLJhvDk_i70_kVByIE
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDA5NyBTYWx0ZWRfX3iBvg11WFBXu
 hfFTAc0dbRSF6aYF53tM7WshzDMnoEbMFCy1Ywnpqnpb3ODX42xJl0Mn2dR3v0sx6fzqto8CXlz
 vCAfCAN0GLtgoSw0jfm54T/cQm8hnNg=
X-Proofpoint-GUID: IlSMb_almSNGzXpLJhvDk_i70_kVByIE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-18_01,2026-06-17_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 suspectscore=0 spamscore=0 phishscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 priorityscore=1501
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606180097
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

On 16/6/26 17:37, Philippe Mathieu-DaudÃ© wrote:
> Make sense of cpu_exec_init_all() name, renaming it and
> reduce its scope.
> 
> Philippe Mathieu-Daudé (2):
>    system/memory: Remove unnecessary CONFIG_USER_ONLY guards
>    system/memory: Rename cpu_exec_init_all() -> machine_memory_init()

Queued, thanks.

