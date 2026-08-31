Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D87D0C624A5
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 07:17:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x0wGJ-0004V3-02; Mon, 31 Aug 2026 03:16:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x0wGG-0004Ug-AR
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 03:16:56 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x0wGE-0005dQ-SV
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 03:16:56 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67V52p242522792
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2026 07:16:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 +/wYieBAKaOeT4LTVofP1VEgkxVNvM6UdF3KMhm85aE=; b=eridylX1tS7gn7Lm
 EDyTdGYaV8xtWGxl4gBHsXhxc71Ff1gVJegMQZpb6rm2s8XRmJNa492GGwfl4gUX
 yqfEB/ue8cuAbX/3D8c2qcMG9bkXo3tzckzXRExsFXRNQZGpU2yYKJBHvmWrNQ15
 H0oYjRaVYR2NTUCA1AhIEeTbTwg7xSbW6d7TCPXoSe7cUK+Rq+oQQa0c8u7MFQSn
 SIArcQ1zV4B0sF6Qa+0Jv+D3e445lMVDTKLAYXRY1Lu4xQOlYU9uHShr8mb8WZPs
 9NUgjVRrtO9HHwhJZhARwSr4qGIynImSA0s3BsJzBm/ExM3X2zkqQ77scLooKGzD
 HJ+yWg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gcv7w9dgt-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2026 07:16:53 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-92e4f946461so525943585a.2
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2026 00:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788160612; x=1788765412; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=+/wYieBAKaOeT4LTVofP1VEgkxVNvM6UdF3KMhm85aE=;
 b=Uwiex2xObNh03wMR4I1jahrKmtcl14VEUb+cwS5ztwB4puXuFlDXj5xqmTemUbFeEO
 hGLiRecFTNkyWTa3oFpVxMwUMqvWJOA3tRNOK9SlyEz6tTDkGVhZXgcYziipipw4z4rn
 uuDMWBRXp0wVzOSb45oCVTQ/wZlIWI62iUmRxuXBWrvcOxo2bhteTlUQQwgQ3TjYrgjr
 b6LlGJFJANmZQ5zcg02kaC8Jo8Ca9yEAZl02insBI3+x5Xub/IvrOsgYU67ehWBoO2uL
 97lHK/A9+HeaHtPziaaS5Ehl+cJUyaH87uPxk+31NgpY2XPF9U/LJ4FFKevj7MLZ2VNw
 sPFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788160612; x=1788765412;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+/wYieBAKaOeT4LTVofP1VEgkxVNvM6UdF3KMhm85aE=;
 b=Fw/WIkBpmhSBdkPW73jmzWQWNjnRXg/ks9pU0T+9rGBB8JI6dhjxlzBs4r+eIrybDC
 qaa69kyjEOuqG1zTYy74TBPdBe8yDSEYrW0o7UeYe/YldRJpevIEQW45p05oE6J9vu4d
 pMAlg2HrfA654u09dqTwCWvu6AL4sTRCzQSm8SkJ9A61m7lHnEDbSKb5MKRSYczvX1l9
 xaMBkPachXjDGOI5ixLYL9khK9NccqOp0/dXriA643DBWmqEIEbObWAXQ0mfWOtJxG9R
 rbIjjVRPQOLjcLsvxL80BvszUMU90A1J9Pq7JonKoyAdHBw2Sw0wU9XGybgnAqscHIwq
 E9Gg==
X-Forwarded-Encrypted: i=1;
 AHgh+RrCS4TjYoGcaI0U/VCwNJdvn9mTv9kjpqLRbhoBxe7qEaCZSWDoLRza0NusxBLCYm01PGIsceSOGmKJ@nongnu.org
X-Gm-Message-State: AFuF++nmBBfRzsb0CWIw28RdIW4M8dN5rdYfFve0lXMYKOFSFtg1fqfB
 D6TCzj9vypUc/ctX/3FvuNKn14vWof+LPqz8k4PfX97jkI1cGBu28mFdpOFHWw5AWJDm+LxwPb5
 WwRNymNG+khxsYmNuQrLXwbj2NZDld9lNHmdcwljv04491R7+vCW7TfftO9feV7iMiQ==
X-Gm-Gg: AR+sD11nE9b//1dso5z1HN9UPs4aa0NTlPPeMoOuXfSozAsq2PVNBqPJ4UT8lG8xkoO
 qedHv4DA2aoEKof3vCGYEYvtAs+xIFq1hHAVmgR8MR5d5iHfesaAyJJm7e26+aJUUwHElE8QSNW
 IxDF1aZOHm34SlFapEo0QZYUF0FgpT5E6XdA3V4YqFzHl3FIq4EOiZAms7o9RXH2+ihwN8pinok
 z0PiS09lC1uDpSpFrPIIkmMUuToi1owsrMye6ihioWH4X338U5AZyjhxdyqOBWYyAsJ6bxBSZw/
 L06T/9f7t87SVYbnMLCAACGk2XZfmlu+IVhvCANqnZg4scRVvoW3mWE8dwehcxRfKESLkbH800k
 eCYHHD0OZnC30RRhVK5nN5NDm/dptf7ka3g==
X-Received: by 2002:a05:620a:2b81:b0:938:ac3e:79b0 with SMTP id
 af79cd13be357-939427e8ddcmr101369285a.9.1788160612466; 
 Mon, 31 Aug 2026 00:16:52 -0700 (PDT)
X-Received: by 2002:a05:620a:2b81:b0:938:ac3e:79b0 with SMTP id
 af79cd13be357-939427e8ddcmr101365785a.9.1788160612033; 
 Mon, 31 Aug 2026 00:16:52 -0700 (PDT)
Received: from [192.168.69.226] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49b963c3c0asm476769535e9.10.2026.08.31.00.16.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 31 Aug 2026 00:16:51 -0700 (PDT)
Message-ID: <044509bf-1976-4319-954b-438307e91a8a@oss.qualcomm.com>
Date: Mon, 31 Aug 2026 09:16:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 41/47] target-info: add target_microblaze
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: anjo@rev.ng, Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>, Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20260828225901.367438-1-pierrick.bouvier@oss.qualcomm.com>
 <20260828225901.367438-42-pierrick.bouvier@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260828225901.367438-42-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=E9f9Y6dl c=1 sm=1 tr=0 ts=6a952a65 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDA2MSBTYWx0ZWRfX6g+locb53XFi
 jHrnXYtQtuEMzA1DS6FcS7JCbK3Ynouh9OQxlhKTMFrI/b5htG/dl5/oNWLKBKwxoxaKxcRJjA4
 ZtjtWJ+PRaC1kVZO08Qok9oOKHUwT1k=
X-Proofpoint-ORIG-GUID: ydqu54SX0nmeehVYY4z16dT2360Mi5zt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDA2MSBTYWx0ZWRfX8fG22i74Soht
 XSRng63XnsEwDCL0uNSUe+t0sJ99kzvW63FmpSyjTZbDUjkcnxuOPIdZAXjdYtBoQ94I0QyniNb
 b/qmtn+jGCyJuxnhPgV6R8sX20TQynEs3iurzNWkyTfZP4inup5vW7KUMvLvBoEhZZtYSrVec47
 qm2Cbl+W6CzlxJWe/dv6/SbyTZWTCbfQ+oif20i7oC4ukwP86Z8mbNKOeeVgYY9q/aJwhtlZOk0
 SjzSRyEGU/vUq8inPk8DYAtzLNvUrrwvvGy2ED9EK1UuS9OHUZz5gnaHUMAdCK8RKGtmm5UjQWq
 W+pixSt3R9wQ01I5Fb1c/taFoLSN0OOAQxjqOz1UnAlZIwKHELKbev0E2rIxcdxJPYF9K5QeZr8
 Qx972OM1ZOn6qseQUEwWOrGTjisXE2ZGgu5t8wopdEBSJq5gH1UjtSgL1FCxHC7UEo/B4RksJif
 nmXB62lNdjSr0dZfEqw==
X-Proofpoint-GUID: ydqu54SX0nmeehVYY4z16dT2360Mi5zt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_02,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 bulkscore=0 spamscore=0 phishscore=0
 lowpriorityscore=0 adultscore=0 impostorscore=0 priorityscore=1501
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608310061
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

On 29/8/26 00:58, Pierrick Bouvier wrote:
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---
>   include/qemu/target-info.h | 7 +++++++
>   target-info.c              | 6 ++++++
>   2 files changed, 13 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

