Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01292C982EE
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2026 12:17:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8cxo-0007aX-CN; Mon, 21 Sep 2026 08:17:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x8cxM-0007ML-Bc
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 08:17:23 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x8cxK-0008GK-K4
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 08:17:12 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68LAeB3G419384
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2026 12:17:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 jHfQbq7qsagH3eNaMOGuXpDFJz+kyHORcU4Kkz+aibs=; b=CQ4oFCo7H1nWbWnH
 bITtFz+2jSlVWBT2SfRYXFa4UiHoM0nzaviVrbnH1a5+ataxx3PdLZt4UFF8QkX7
 DDOLGhn+Z7vGmuqqoXJ4TWYCvLI9dx0BpV1lbRdiX5K4aVbR64oQLegxkleP6VtY
 DCwV4zMA6i8TkynB6Ka1smk6bdWcKwkdC5hQ2aGzqWRPD9oJJC4Q6DMnW9b8/vNQ
 VXBf7d0OXcSpQ+ookiLhKjdOk9Fg7b+yEIBk95gpAOH/LZ0EGgUthnDokjSxjzx0
 /zaKatvAttTul++Lb8wxuXvYqVui3N8p836KMJLKCoI/SJ8fV8ZJEbqy9Y96h/bN
 uCC28Q==
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com
 [209.85.221.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gtyxq96e3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2026 12:17:08 +0000 (GMT)
Received: by mail-vk1-f200.google.com with SMTP id
 71dfb90a1353d-5c851df59edso587300e0c.3
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2026 05:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789993027; x=1790597827; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=jHfQbq7qsagH3eNaMOGuXpDFJz+kyHORcU4Kkz+aibs=;
 b=dFkUQVZpIX5blE418ECrIPnFP/lJDF4omH6/Xh5idPly7SqS2fnEbJZHN7ykTKkRPf
 86Yn8bLd19RztQEkI3zYpcISP7e+JzvcnXINqEHv19ZUSGJuXR5QQ24UjXafAwTR4Rw6
 Oonh8iGZrXrr4wwG1TBgPyvuh3XVjxMzAObohJzOYd5fKJqDM0KNfCZMC6vscaAK0F5o
 DxF+UcDuQGBq8OUH08qnTjbCLJXJQ4iCFj0oXYw0VDQhynRwc9dRQOV7sk2yNvghMXYi
 gPklZhmgXtL/51Dl0XZPmDmPhr3uOYjIiQWpxGhId5uvdEVGlgooJdw3JTvhCwc757Em
 o42g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789993027; x=1790597827;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=jHfQbq7qsagH3eNaMOGuXpDFJz+kyHORcU4Kkz+aibs=;
 b=Zpk07b8EPaT3mA5/f66qflzUCqw4uStUDuxZWyG9Zo/9BDTbr7VZ10dLkEPKm6/1Gn
 vIplnPJ2Q5+UjSO8V5xa095vkiwdwfE5sNdQxPEiM7MipGr1+vhsdOmUO8HQn0BHWsFh
 9iHmS8sLj00Qw/6GEC5xKEz/6netMYbZKcxFQhEN+Enk2BiLBeT7WqomBqY8x8bqmL9x
 ufEIB6XvQlBpplaQ5evuxG5vE2oHQtqFvzoVRR40lk/7vgSTko2zOMaxenC4m7VBXxNR
 WAQCWj0YMUvYYDXVyguQVUg2wn9Hgm2BAt/qWTvaKCxH1XtmJMKb8OjAYdhf0FRqIC6X
 gb5g==
X-Forwarded-Encrypted: i=1;
 AKwUvBzD7UrM9qjKhf56Bz/gV6UCNVjMb0zEeNrgEhta2WittEMwCDW0wV9d1ZPpPAvyVz1sOe+Tsut2NRT1@nongnu.org
X-Gm-Message-State: AFuF++kZldBaEgwwYr+15guYfk04dC2SOvjmGmoCx98QQ3a8Q4K0Baaf
 wMpzaVgnb+xK7x09nzxhRz8C1OH6lOc32uA1ZkPryVl//wxpbJa2cEUncXY7afZzdKceVuWQu5/
 1DDuNVaR64MU6XY/htcGlxq/i8hW/68UIY0u1pEuA4XnnBSMIwvymRGdCmA==
X-Gm-Gg: AYBFou106q6h3RLJwzNuQC0wSw9BRWX7p4Fydc9SHVoapef2LB04JzATtjDp3sNUIb6
 Xp6FYBKuSaiTAlcSeNKA9H/U6mY9R7LwJmheZ2NLWa7M2rG3xWhBwAkdh2vG6QKOCKNjP3RYEYG
 awU42o7PsrwPXMbrPilOoOhXQhT6kCNndRs1G8cnxR94cVYTX1eaAPXQr4wWK5vN2F/AFZKaCLR
 AmrQtfB8RlPdghgA4E4DnbucKnCYRTpCmv/2MLDap/uKQ7JJ3Yp/ydAxl+z5SyO+Ect2pDLo9pl
 b6LuEXmTBSnNZb6KMNb1G1bp9SrOONnZhEEgmWdQ3WNMeENhezpMwsg2HBm8tKKij1x4aHGkSCx
 zLfZLwLGLTJ5/Pv3dDH5FaCyC5KAJSIpNIA==
X-Received: by 2002:a05:6122:d89:b0:5c8:4831:1539 with SMTP id
 71dfb90a1353d-5c9b58dbc15mr5052748e0c.5.1789993027351; 
 Mon, 21 Sep 2026 05:17:07 -0700 (PDT)
X-Received: by 2002:a05:6122:d89:b0:5c8:4831:1539 with SMTP id
 71dfb90a1353d-5c9b58dbc15mr5052685e0c.5.1789993026908; 
 Mon, 21 Sep 2026 05:17:06 -0700 (PDT)
Received: from [192.168.69.225] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b8c78c1562sm1928099e87.8.2026.09.21.05.17.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Sep 2026 05:17:06 -0700 (PDT)
Message-ID: <8c7d88e5-44c5-4b22-8983-2dd9af9d8128@oss.qualcomm.com>
Date: Mon, 21 Sep 2026 14:17:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 8/9] hw/intc/arm_gicv5: Pass CPU index to CPU interface
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20260914160020.327787-1-peter.maydell@linaro.org>
 <20260914160020.327787-9-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260914160020.327787-9-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 6UKj4R_wWDUAGkFdTqDjv6KmEprcnFWF
X-Proofpoint-ORIG-GUID: 6UKj4R_wWDUAGkFdTqDjv6KmEprcnFWF
X-Authority-Analysis: v=2.4 cv=OtraWC/t c=1 sm=1 tr=0 ts=6ab12044 cx=c_pps
 a=wuOIiItHwq1biOnFUQQHKA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=LfsA7Cq2GQzuzbZ-N0YA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=XD7yVLdPMpWraOa8Un9W:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDE3NyBTYWx0ZWRfX89RRb4xh/erj
 WrTD6XvmWvwnGn+I/p3a0Eap/MZwXg+uHP2tDC5YeQXDHQ26NmxI0q92I3KWsEHusEJ/x7kIuwR
 CNibi04Yd5XeSoMYYTdEW1DVMdJBAe/jq/7dC6YGc6SpN4pAf1RgkJXXL+pdSAuJ8FsjFHtCaAC
 2B9L+VQLoBZ9HyCtk5yFfjvklCEc9AnHIM8HTWAKsJdl3aEQXo+JUAxEUuCToYdk/DveB0ZkdLF
 MCtZ+HZfggEK2awFF3djT2TuMwhAXt1xHCMIBRRn5YrnyLYjwRYQekjrDMUfqeSN4shVobBcKCw
 qCfvKzBIlWcXU2IzK9y5N+UGo3bagsLuqkBU9l/TazfNbAu6PMj5BXBvDHCh2ZjIRa9yOxYMnOt
 k3CbIinJ+aRuto7Jt7ZdwJQhgWryw0glefF47gZq9XTJvU1H5Rb0xFO/pjLM+03GigQCRK2qCER
 XQKhZZ7jGe8J/1HbTJw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDE3NyBTYWx0ZWRfX+2Mp98jTxqIm
 S5cqB4ZibgDd5uY0MEbFBuVI8aSueE3kyQyg+gIw3C15hHrkYcUAvIenliM/wOmzr0gkjLTKlk+
 XKmSyTgaOB55rBThLwAps5t3QiG8eTI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_04,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 adultscore=0 phishscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609210177
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

On 14/9/26 18:00, Peter Maydell wrote:
> In a real hardware GICv5, the IRS knows which CPU is talking to it
> because each IRS<->cpuif link is a separate 1:1 connection.  In
> QEMU's implementation, the cpuif code calls functions like
> gicv5_set_priority(), and currently we usually don't pass anything to
> tell the IRS which cpuif is making the call, because mostly the IRS
> doesn't need to care.  There are a few places where it does need to
> know, notably in gicv5_get_hppi().  Here we have the cpuif pass its
> IAFFID; the IRS then looks that up by doing a linear search of the
> cpu_iaffids[] array to get the index of the CPU.
> 
> For virtualization, many of the stream commands which don't currently
> need to say which cpuif is making the call will have to start doing
> so, because changing the state of a virtual interrupt requires the
> IRS to look up the VPE which is resident on the calling cpuif. This
> makes the IAFFID->cpuidx lookup seem increasingly awkward.
> 
> Change gicv5_set_gicv5state() to pass the IRS's CPU index value for
> the cpuif as well as the guest-visible IAFFID, and make the stream
> functions identify the cpuif by CPU index rather than IAFFID, to
> avoid the unnecessary IAFFID->cpuidx lookup.
> 
> As this is now three GICv5-related things that we are keeping in the
> CPU state struct, we push them into a sub-struct to keep them tidy.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   hw/intc/arm_gicv5_common.c         |  2 +-
>   include/hw/intc/arm_gicv5_stream.h |  6 ++++--
>   target/arm/cpu.c                   | 10 ++++++----
>   target/arm/cpu.h                   | 10 ++++++----
>   target/arm/tcg/gicv5-cpuif.c       |  6 +++---
>   5 files changed, 20 insertions(+), 14 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

