Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC4FBC531CD
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2026 08:59:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmpGQ-0001eG-2T; Thu, 23 Jul 2026 04:58:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wmpGN-0001dm-7t
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 04:58:43 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wmpGF-0002qV-Fy
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 04:58:36 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66N8qbIj3668067
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2026 08:58:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 vRTZ9SpIcpifUNWgCobaA6MBq+eTyM9qX++tnMLM/nE=; b=WMtNDrwm0WNegQ4y
 xO8RY+pU4BJySOa9D5Bpk0F/92SUysqI90QP5G6YfrmndifCjNbnmukbzUjhj6yY
 ANSUapN0IT2lbvTgoQBMy9rWR65yZTwjUq5yTOUUpubRNkor3rkufg8znIH0yZpR
 ugm7IXDocfJ2JF8neT94hwBjzkAhfd8vAnMmPlu/OeslDgOtWltOIx6ukvNih3/C
 lUsoxIb1YL4w4VacPjIHOX36LNPQH1uIuYkqWuyIbAv5D4bnol2Ay5OTKeWCNXmS
 S0fTqkqwf09kw1cjpFSkz/RxAU9caUuaeBicEbD2QdRjzi1VBUSEIiwxQM21s1hm
 ZFOIDw==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fk5cc2cre-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2026 08:58:33 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-51a8b0a08d2so6629351cf.0
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2026 01:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784797113; x=1785401913; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=vRTZ9SpIcpifUNWgCobaA6MBq+eTyM9qX++tnMLM/nE=;
 b=alew10lQA8LPreitGXA5HpghC3/l3HikqrALOIh9RujCvZYTM7ipclm4ynKXMuIKL+
 +1U1wuMYdfnCh3BL0x2bzobZF8mNLb4+9SRDYoHwaUW0uBUfXjsioQoV89/Foa3ryIse
 1sUFGa9zB+lX8Q641EEqJDhfuZtqoFt6q2Jnk7D3Q86q2yvoIBqvEv9P9pQGGUiY/4x6
 IBL9cOSqcDcZik4wfet1l5H9V1Gi0Lqy0Z4omVT1iV7vlpW0lkjwROm8YQ1tqELqrwpX
 Kx0DA0QtQl6V802TzZSz3q1RcFyBRVaxgvbtlBKyDCqozbqKjVHn6+r2vHIRohAd85DM
 sMcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784797113; x=1785401913;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vRTZ9SpIcpifUNWgCobaA6MBq+eTyM9qX++tnMLM/nE=;
 b=WKrJxz/Toxeab10VE8lzzgkWVBziYOGccFXmKBOqhcTZSfn0ppL94pVukKXKQFHtU6
 OUjkeWa5rIKklUhjfEopjmUAImavvZoEwtI8DHA8tgFtJ27EgTYsxuWN1BXpY78gjr3Z
 KXJl8UoIimZUPPlkk/02UnSJjD10o+Qm7BqyEQ2cBAL1t3HUwHqMHjXnGQjektAZFQNX
 smBNaq+Tzc+/dLT1KT4duuAOPNr/GWQWBnJQbfl5HJQh/tIFM3iwE40hOtInB3wGf500
 spmLSGhxUkzmpt6IZzFwTz7PUk0hz9YaV2/M6pCH6kx0qIxFt+zbM/fMBlOrWTklVYCy
 Ycrw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rqh4TaZnjrallY50kfFutDQAyvtWtDv94hLzEW3n5KUm0UBnbXkVen6Uxig/E+zDGI7xhBuP2+sOpZK@nongnu.org
X-Gm-Message-State: AOJu0Yxt12mYRT7qnrHb8+lWPLy/NLiuDKl4PlprmuK24MHZGC8ZHAvJ
 QEPJK2BoFHVSvEcVXe9MbvqGANLb2jfmzvCSQAB1GSUjC02grTpbToiQo7HCXxZJ/fLtUcyKBn8
 uDHTDeAW1sv+J5QYSWln5PC73+plZo4HH0X9+I6PeCElMojYZcyaz+EhzxA==
X-Gm-Gg: AR+sD10IkqmwPGmTj+wcH0QCY8Qfw2npFGnGF0CQoIadTAWLKDWlRKsJp9NXgUOYytV
 yAD8Nq9ld8yFd8f1nPqNe8Y1cr9FfK3xaWPvupWDYf1xtu9b8bgpJV5X27b8Kcs7AVhvFMnKXtw
 ZvQjlxNZYuwJ9GSDEkXmKQmnEd1PIwS80WvRR1Q0XzxR7MVSb46lQbN0iGIp4fyuDW0JA9Dyk3p
 2xftHeRBzgs6y15fwVwcqVnVGWBPyR4Lmb1UNVIyER8zIZJntDU/z1IMjnzDIWmOc3g5SnR/jzD
 J05R3+b1WcJZaSQbbz9OBq9vn5w8g9pBxMYiF/8JeJx6Q/ggeruHvIk22qvBdRYOqGU/SSSRRCk
 QW1A4dvs7nmOyG/cXl8gKdT8zT+lDK+js+92IYrMs3OC+uCcXL/Y=
X-Received: by 2002:a05:622a:4286:b0:527:8300:3d78 with SMTP id
 d75a77b69052e-5283df85c88mr18329491cf.70.1784797112723; 
 Thu, 23 Jul 2026 01:58:32 -0700 (PDT)
X-Received: by 2002:a05:622a:4286:b0:527:8300:3d78 with SMTP id
 d75a77b69052e-5283df85c88mr18329371cf.70.1784797112290; 
 Thu, 23 Jul 2026 01:58:32 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f864305f5sm13033260f8f.17.2026.07.23.01.58.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Jul 2026 01:58:31 -0700 (PDT)
Message-ID: <062de01e-0b9b-486c-920e-27612cdedbfa@oss.qualcomm.com>
Date: Thu, 23 Jul 2026 10:58:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/microblaze/translate: fix reversed load/store
 translation
Content-Language: en-US
To: Luc Michel <luc.michel@amd.com>, qemu-devel@nongnu.org
Cc: "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 "Edgar E . Iglesias" <edgar.iglesias@amd.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 Frederic Konrad <frederic.konrad@amd.com>
References: <20260710072348.3575-1-luc.michel@amd.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260710072348.3575-1-luc.michel@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: EvVMAr7CpyOUT0Abx36vKYCYclgTe6ov
X-Proofpoint-GUID: EvVMAr7CpyOUT0Abx36vKYCYclgTe6ov
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIzMDA4OSBTYWx0ZWRfX8GeXGibfurJg
 RZfmiAJ5iI3ZZ3SAOl/RC3lSF/K2pqT6Sxz9CzxGDBxaQoF8lZ97H943ws9mV6gqUNweMcpxDOG
 epYt7HyeFTGKbic+5qj4UWaHnWWchuI=
X-Authority-Analysis: v=2.4 cv=L/ItheT8 c=1 sm=1 tr=0 ts=6a61d7b9 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=zd2uoN0lAAAA:8 a=U5mT9tQJ0ZpJWxV_qEEA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIzMDA4OSBTYWx0ZWRfX8KLPKiucPd9W
 5lxzQGDA138m827fOhHDSsJdTpW1RsS/7HkQROkkRLSmdpEuOy5BKWPSzZsRLvlErMGCkU+z7HQ
 7ixZAuD0kKNRZM2NuuN6fRafwqQRZ13XOBLHNi0GxNVftfBU20GMoLjLm9Rgb53M60CgAPqEBdF
 5Wmyuf+vYItS6z8VwO+vcGg2VLbeeAyzCjU8Exm5FPSNEwqZZ80dgcYe4oF+VXK5q4Ma8r40rKa
 V3PY1gfSDx1U1QivxHKdtM1uu64dUePmvW4gYZUNB04LyddRwCRUa5FRYm9iupV1WPcgnClB+nx
 uDeQm+xGcaJb78Gy0hHmQNQniy2hs0ysM/xvLvFPspLBjXB5Ylsp2xjFNV29BaaIp13iyu336fy
 ILJvXTU8gbRnm0BllCHgErFQ6u2j/NjNOknLDb03XSVUA3RhPSP4kZadoyH+sXy/di8vTwHla0x
 /CFw2luZGQMwTgQPeBg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_03,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 adultscore=0 suspectscore=0
 priorityscore=1501 impostorscore=0 spamscore=0 bulkscore=0 malwarescore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607230089
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

Hi Luc,

On 10/7/26 09:23, Luc Michel wrote:
> Since 36a9529e60e0 the TCGv returned by compute_ldst_addr_type{a,b} for
> the address can be a target register or a constant. However
> do_{load,store} might modify it in the case of a reversed load/store.
> 
> Fix this by factoring out the reversed access logic and copying the
> address in a new TCGv_i32 if it needs to be modified.
> 
> Fixes: 36a9529e60e0 (target/microblaze: Simplify compute_ldst_addr_type{a,b})
> Signed-off-by: Luc Michel <luc.michel@amd.com>
> ---
>   target/microblaze/translate.c | 56 ++++++++++++++++++++---------------
>   1 file changed, 32 insertions(+), 24 deletions(-)

The tests in our CI didn't catch this problem.
Do you have an image I can use to test your fix?

