Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A29EBC44511
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2026 16:09:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkOe4-00076k-Kj; Thu, 16 Jul 2026 12:09:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wkOe0-00076K-W4
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 12:09:06 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wkOdz-00066b-44
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 12:09:04 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66GDJd8b3988086
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2026 16:09:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 k0bzd/cCqwKLMA4Jx2RmPmTw97YrIVEQ5MtnssVIH8Q=; b=H5evZHxGW3/jzji/
 bdWBIDtm0I5y6EaKL9IPVk1ugYmBVK0yNWBigK6B/paRuQai1KOfXiqMvX5Xlvbq
 /BboKEoZl0H3+vQGN1OWST6kQGSmbGQao40irmghRc3mLClmMNeaHIC3boXhiZlr
 aDZuXvheUw4uCY28dF08P4F4boNggCgt7yHwoMfUTX+Lm8q52DZLlgn30BAOcb/x
 Fd1pirDH7Lf6rXG9bP1Qt7s3b9MNZ8UInTHNAj21d7fd4hcAMlm/LVQPJmfSpiGd
 Z6hqWwTofe3yCIu1WHYpD+XShb4xmuT0w4wGrnNCnemaF0q2O/7J3DnRTLBLUqxu
 zaXQjQ==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4feq3pk5qe-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2026 16:09:00 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-38e095fd889so6902782a91.2
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2026 09:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784218140; x=1784822940; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=k0bzd/cCqwKLMA4Jx2RmPmTw97YrIVEQ5MtnssVIH8Q=;
 b=fLWeHEcmoMHnTR7nCLLjffsHe99hfHEloN3RiVUbaLI6mnOnjyrYkRa+02a0RAfEog
 jY1vAxmVuCwwB8KnlqBmYkSppWG9sat3y0PqJRScLS6asz9ohf224Iy6MB2TI5yzgCjB
 x8qKkJHsonlhgTv/SyWP00Ym8Uo4oLhR5jig+X7fnllgKatRU9Mbpt71ZLwGG2aSJkjd
 V/qIYn/CdWq5yEgY/8kSPhOV9fCfK/dntdZn9bKxs/6kqyWaMJ+z8p3lv7nItCGPPYmH
 +1TG7ceHoSgJUR4tsCHF92ZSI32N2aNYWPcJCxVN3XVswzGx0SMC5BW1IHK7s62Gs1fb
 LTsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784218140; x=1784822940;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=k0bzd/cCqwKLMA4Jx2RmPmTw97YrIVEQ5MtnssVIH8Q=;
 b=OzMNeHgpixMJEIxEKQfJ3uCiGPFdZ36LQZOuQ2Wq3jRspSqnTWjRD8LvX5lFMOSDPv
 eQCf/XwcOx3XOW+Xy5ro4HEoVpQuaNybxJZBNRmpenhoSHdv4CheG6WAu+cPwUpnEEWO
 PobUVKEGIE3ex7ZS7cpBV9o6V3jKrVrOHV8XBQa3y/rRWR35Uj4d00wDhJ5I15ru3DPP
 9+zLyeuhU2zWnsDz60UBBfm5KX0wJmPxV3rFdYQQu1/cqEXkXebWh7UlUSeS6NFHBF7E
 Bz3ptfi5ASYF4W3/PcVow1cMS5KXNOHDzphb87kUK5Ck2wBCWhOUBsWTZlm9kb7/+5Z/
 kRcw==
X-Forwarded-Encrypted: i=1;
 AHgh+RobFlEroZpOtfUOyooiWlJpNBpt3mp5xkh/SLiY/NR6VlaUf4haMvjm1yc0I9DS5BtolW3nqkrvigaK@nongnu.org
X-Gm-Message-State: AOJu0YzdbQ0C0mX3F6mvtJ1lIqpkwtzyMfCyx+qYWq7LmmkdYmNsDh24
 JaLQ7aGWlAofMvSZbnWawPk5K528A/A3rSjpDgSDbvvk7NA9iBadIhvbMyMNCXkuxNjQqfzydZ7
 jiZ43K74TReBONgh+m3KfK6+DR21XKv+sM2Cot95YfhHsg65w8sFcoBn3dQ==
X-Gm-Gg: AfdE7cneJ4Ma2V81YqG2AJ9anLsOy2WDCZ6DhYn+b5+EjVrQ87mZOgyXcfGlOYC2mRE
 RbttPOqGMfFa7+NHRLreacVtpjvEEHVSkeMKvYZxQJ8pIB1a5MMiZaHd9FE1BTvQdO8Y2aTC0Z3
 5Skr4mJAXHIuTzBXT/Xty71bA80ai+bBXwGUhM1MQBs6YX5y3FitkN3icBv9g+tHgagZAOUofFE
 PVqINgSxHxUcWFsPLkzVwq6LIwN3nGkeWNulf6cFxANQbHUis6rJ+Oh8zPB6dj6nK5nGcInfcAU
 mcVScfjhWa4JHYxIhgnVqWTKLgSpQ5ysWl92dqaEHLXtEQ8xOQ9lU3AB4S2j2x9CEuN71CKPb9d
 PUIO74i7oCEWFX7ldBv/qJyZ14+qUG87ehm9Rs/vNYrEcMU4RYXIy8nY1Kp5dt0556udh
X-Received: by 2002:a17:90b:17c3:b0:384:5b5b:3465 with SMTP id
 98e67ed59e1d1-38e467a97edmr163280a91.29.1784218140197; 
 Thu, 16 Jul 2026 09:09:00 -0700 (PDT)
X-Received: by 2002:a17:90b:17c3:b0:384:5b5b:3465 with SMTP id
 98e67ed59e1d1-38e467a97edmr163242a91.29.1784218139728; 
 Thu, 16 Jul 2026 09:08:59 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-38e2a23eb4dsm1491850a91.2.2026.07.16.09.08.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Jul 2026 09:08:59 -0700 (PDT)
Message-ID: <d559136c-8c93-450d-9880-cc4bac9aa841@oss.qualcomm.com>
Date: Thu, 16 Jul 2026 09:08:58 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] plugins/execlog: fix segfault and flush output on
 vcpu exit
To: Harry van Haaren <harry.vanhaaren@openchip.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: BALATON Zoltan <balaton@eik.bme.hu>, Alexandre Iooss <erdnaxe@crans.org>, 
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20260616161242.267315-1-harry.vanhaaren@openchip.com>
 <20260716094126.787556-1-harry.vanhaaren@openchip.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260716094126.787556-1-harry.vanhaaren@openchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: wwqOc1xo_z9-IHGArwzPxwgN_twD8D7c
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDE2NSBTYWx0ZWRfXwjlWDM5x81Zv
 Wh/6f2lF8WHRMxKCwLiQfZkUoDtMMQQt1jo4d+IpPTXht67kokOoFtUs1Pm2PIwttYyQ6a3k9As
 Tz9zOQQpCH0OChVzsupy32JUGv4tPRY=
X-Proofpoint-GUID: wwqOc1xo_z9-IHGArwzPxwgN_twD8D7c
X-Authority-Analysis: v=2.4 cv=PN8/P/qC c=1 sm=1 tr=0 ts=6a59021d cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=VwQbUJbxAAAA:8 a=OZcmDFxvAAAA:8 a=MI6s7Ohd7u6-WKzijUcA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22 a=liPxxeoTYnb3ClP5OJlV:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDE2NSBTYWx0ZWRfX9rZ7rhxWXMYf
 0yv2EN5u7M1whBRsNxsuRGqMznLVJwhPb456lm6qFzhz7ZKbL04Onz8QrOHkw5TILsZJD0OH4BR
 UwekGRQ73vlW8JfcHv9sN6Z909GwFudG23538x6FQ6V/fTgcM47wv/aQ5rs8L5EdxAvFim8hmGy
 hiNaJrkMvFhMfb8XIGnW9KMYCQE9I/pdJjUcLo86CDvWUdeg4Jk+4hvVbc/TlAX+cgSPhnKm68T
 qL21JGLfgWRlP658Vw68PBs03N1cxBPAEbMc7riXciOdp6RGNmvWNfYpg+mhwH7aS8kYFwGTuyh
 0vOINdZoO8hUnY2Wpwc6VwwfFk2/lv2pfX+KHLkddvxhCiJjpkxC4lgxzdVLTpltQKwYFwZv987
 z0FOpfr7yBsposjZPN+gQbHF5dqJ24L1DNILMJOvjiCMhV7Uh70WqKdBWpT63Ije/yOBvBFeiIm
 ROr8Ffm29xXQwKhgWYw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_05,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 lowpriorityscore=0 phishscore=0 adultscore=0
 priorityscore=1501 impostorscore=0 clxscore=1015 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607160165
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

Hi Harry,

On 7/16/2026 2:41 AM, Harry van Haaren wrote:
> From: Harry van Haaren <harry.vanhaaren@openchip.com>
> 
> Hi Qemu-Dev & CCs,
> 
> This is my first contribution to QEMU itself, but I have worked on
> DPDK, OVS, and QEMU-RS a bit in the past. I have experience with
> mailing lists for patches and some QEMU internals.
> 
> This is a "git publish" reply to the original patches that weren't in a patchset:

When sending new version, you should not reply to v1 series, but send a
proper new thread. Not sure if you added some extra parameters to
git-publish, but it should not be needed.

No need to resend that now, but just an information for your future
series :).

> https://patchwork.kernel.org/project/qemu-devel/patch/20260616161242.267315-1-harry.vanhaaren@openchip.com/
> https://patchwork.kernel.org/project/qemu-devel/patch/20260616161242.267315-2-harry.vanhaaren@openchip.com/
> 
> Thanks for reviews and input, the v2 reworks as follows:
> - I expect email to no longer have "| OPENCHIP" in my name, and the email footer removed
> - git publish used to send, with "--number 2" to hopefully get a v2 patchset out
> - rebased to latest branch, atexit() function signatures changed
> - avoid adding mutex for output, rely on QEMUs logging mutex (thanks Pierrick)
> --- use single call to log to avoid line-breaks corrupting output
> 
> Please note that LLMs were used to investigate and fix this bug,
> but all code in this patch has been reviewed by me, and I believe
> it to be a good solution.
> 
> Regards, -Harry
> 
> Harry van Haaren (2):
>   plugins/execlog: fix segfault/race-cond on per-vCPU structures
>   plugins/execlog: fix execlog vcpu_exit execution print loss
> 
>  contrib/plugins/execlog.c | 88 +++++++++++++++++++--------------------
>  1 file changed, 43 insertions(+), 45 deletions(-)
> 

Regards,
Pierrick

