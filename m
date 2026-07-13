Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 897D3C44501
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 11:13:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjEak-0004gv-Q9; Mon, 13 Jul 2026 07:12:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wjEak-0004gY-0h
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 07:12:54 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wjEai-0006iw-Cd
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 07:12:53 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66D9ucY01089701
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 11:12:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 7XsYLOkFKPevp72S9kIelJJc5OWBLLgZB83vPXvaDng=; b=NfPGmmLuQecF+Ihc
 NPW8D3RkCMUN34Gi83IF95YT1JtRl7pEPbBnUktLR8ijsVvcsjH2Iq5T+ybIcN9t
 kr5cBGWCwXGGTR0kQ822toW34tlRQcwiLDqWycmU16wmS/4eVHpFpXNAY/LI0Kmy
 Aw7MCBs9/kipKuGKhP/XbdA5ctVT6dTImPfrjFkp48ms/ZEh372naAbFqq1zE5Zv
 wDs3GTmXWB2BYLWG1TTLY8H/e5TWwBiutA6vHClPajZyquj44eo1kNRsXDyeIXSt
 FP+LhDslpfkcmhTvir5L8AXSoWXZGd+gcAzuLJesHRMSbUPab+jPOdd7b2Wz506d
 HZscRA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fcwu4r8k3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 11:12:50 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-51c0e702df8so32273721cf.2
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 04:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783941170; x=1784545970; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=7XsYLOkFKPevp72S9kIelJJc5OWBLLgZB83vPXvaDng=;
 b=FXgJAP98j/ehaDEhZxzA6IkLtTYF/GNDfpIVbnA8RiJ2VCS5DKnZNmYkCmM0V2NEMC
 rM62lg+h2sEQ47dPUbawa/X1HS1jkEQ7BAcjlDjKB04AtedaQl4VFjCPOt5Mf1P5xvr7
 H/vN/EiStJ9p2qFiYPVhOuOVLOqjxLJ/JqFTjqsHRKz9Fegff0bhV9CyEH2dtiETt3qM
 aVUK4QAkk8vhj4Zz/Clhg5xM31UhtBG2WBQdo4pFJ/K3i8atCP9HZvGFA7HkPw0GJ2Vv
 ZnHvxf7gS16cyId4Sa+Ohkb0n9oRSjmK1Yo+ALPYrSB4YyTocZ/WsEf2E/fVBh+d5K4w
 ueig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783941170; x=1784545970;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7XsYLOkFKPevp72S9kIelJJc5OWBLLgZB83vPXvaDng=;
 b=j/+1zPh7JlnWYJqhi8Eq8o4ZrUJpG4SRZTRM19Mg4YSmuTCXsm4JoNGXp+KB8rgFxl
 xa4jtH3qItB2Wmaev016c6CjpgJeb0oAnRIXHD6S/gg001h3UppMkOxGdBDi9dMpAXpN
 bSAgAZG7qoaLoYWquIoz7lbcS9StWWHV4uIDqVVQwqouf1Lh9bMEyNCYkGQ1uCZ62htI
 PDCOEA+U3nY6nWuoBOuSHDGvUWH+N6XyGI6dttQaEUNFMWcLxbM0fYTRNGIjSk+q9Hr0
 ItA9csN+YnHTqdjAW2qHcXHsijE3/lFk3C9nuZlM3YDZ8M9MgHdkpN2kZLXltR1TNxIm
 NMRg==
X-Forwarded-Encrypted: i=1;
 AHgh+RpLBDFTxe8JoDuI6CCyf34c2GqHjF1g4dML9DpohOemdXk6T10ICUWEssNrtCnnUrEUu7yoBQlMeD7S@nongnu.org
X-Gm-Message-State: AOJu0YziViDee37fXYsWcz9thbJH/a2NjT54A0MHhUmOoBoDXtb++1c7
 JYdkTNLr/ZiNsjNKDD2bpJACvT56l3LBxJi+6ay7aX9crtcP1w8j+cxofqQrf5ygSxn9cymPuY6
 o4tYoklrtNtfaG3oscTqtphfgnS72ughJW6/U4y3kirBmAFm8MH7kactfJA==
X-Gm-Gg: AfdE7cmYpw8YnTh9QI3x8LZXMl27V4bbjsNXGA9uLGXGxUwDvk04SbLQ1ra4+gelWUm
 v9gvww9b1LDW/4KGzqYdYosdNlLhZ6fkk+ENy+UlflVYA63FRjmwVSq6uaWjXuULceWkR3lQ+mL
 wSHre4BhUHEkne28YMjpdjErQbIKN3oNBtjHeUN7/lnrJXIi+9OJPMJKmauCVHNCIIRzHt6zeaN
 NUS4da1qSRizMokvV+t6/eTpcjAiPXqBMw0s6h37cspQkYCdYz9aVK5Z5C5jOMS7evY0lXpyU9D
 09VJEBf3QuL7lS7JmyZDlvC2E1j/SJ3TqiPpNsKzOxoyViu0RABA0c5rJeZXuCiY4rCJwtca6i3
 t7kin2m/QrnswHh71U0U/XitiEj386kKK+kqZ1CDEye5huRtTh0jiKcVa4Mr1wA==
X-Received: by 2002:ac8:7f8c:0:b0:51c:135a:5b49 with SMTP id
 d75a77b69052e-51cbf0468ccmr92571831cf.4.1783941169671; 
 Mon, 13 Jul 2026 04:12:49 -0700 (PDT)
X-Received: by 2002:ac8:7f8c:0:b0:51c:135a:5b49 with SMTP id
 d75a77b69052e-51cbf0468ccmr92571541cf.4.1783941169191; 
 Mon, 13 Jul 2026 04:12:49 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493eb6ccaf1sm632165655e9.2.2026.07.13.04.12.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Jul 2026 04:12:48 -0700 (PDT)
Message-ID: <61fcf3c5-6233-4100-96b3-00e8b0732893@oss.qualcomm.com>
Date: Mon, 13 Jul 2026 13:12:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] i386/tdx: fix uninitialized variable warning in
 tdx_check_features
Content-Language: en-US
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti
 <mtosatti@redhat.com>, kvm@vger.kernel.org,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20260706-fix-v1-0-4b83a70e9f3b@redhat.com>
 <20260706-fix-v1-1-4b83a70e9f3b@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260706-fix-v1-1-4b83a70e9f3b@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=FMErAeos c=1 sm=1 tr=0 ts=6a54c832 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=LfsA7Cq2GQzuzbZ-N0YA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDExNiBTYWx0ZWRfX+jLcRkhY2tgS
 tcrfDQrFkqfPWIyjRX5fSG8uqUiCLSI//ukKArbYYlGbgK+H0dcz7Js5zQAtSL3qRutnadWqQNs
 HbMumnlaxg/Ig1q3Xpz4PtEelKE8RX4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDExNiBTYWx0ZWRfXweBS4MN3L8NM
 ovDkZuM1mwSymqppj4wgaY3QEs2It+uNjTqMRY7mot5qyEM9hDIdBWq5ynDfQT6as2cYPoLzRwK
 bXZ3/a4xCXe8qPtmMt2B+iCqJDDx4fTcGtR7OeYUP3kDFZ05dwUjRiCMxZoPTk6S8M8S9p1nCf7
 6GG6JRenrKJid6Og2nVyM2wCaqWQWjLWiwdPtbDRZIxj7a1gzmKKnkxHqPAtJB79LxV/6VkxExY
 1YV5Zvw7FIk0icggm0CXMPVhpFM6Kms/PnWqWJRtD7mB8vkvOaAL8Ch6HadTTWIcSB40LONPG8h
 SRxaZYDehBVep7hlpvJlzoYiJFtv6aPGbtZuoxuyoM1KyuQwRLGp+m8CE4i2ZjYxv5kc3+jkxCs
 GWen/zvkfzkDyzywsvPquvVjeWnujAGHne/nDExJl01mItzJRxgthu+DtuRTZXEUYe42UCM0H8f
 bpl5NUiBSzGqf7oOiXg==
X-Proofpoint-ORIG-GUID: l0Wbltkrj3WYnbCjIxsrk5eOxz029t8W
X-Proofpoint-GUID: l0Wbltkrj3WYnbCjIxsrk5eOxz029t8W
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_02,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 bulkscore=0 malwarescore=0 impostorscore=0
 suspectscore=0 priorityscore=1501 phishscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607130116
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

On 6/7/26 14:53, Marc-AndrÃ© Lureau wrote:
> tdx_fetch_cpuid() only sets the output ret parameter on the error
> path. GCC cannot prove that r is always initialized before use in
> the caller, triggering -Werror=maybe-uninitialized.
> 
> Initialize r to -1 to silence the warning.
> 
> Fixes: 228e40f33048 ("i386/tdx: Fetch and validate CPUID of TD guest")
> Signed-off-by: Marc-Andre Lureau <marcandre.lureau@redhat.com>
> ---
>   target/i386/kvm/tdx.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/i386/kvm/tdx.c b/target/i386/kvm/tdx.c
> index c9c3b05d5fe..8294dbde3aa 100644
> --- a/target/i386/kvm/tdx.c
> +++ b/target/i386/kvm/tdx.c
> @@ -887,7 +887,7 @@ static int tdx_check_features(X86ConfidentialGuest *cg, CPUState *cs)
>       FeatureWordInfo *wi;
>       FeatureWord w;
>       bool mismatch = false;
> -    int r;
> +    int r = -1;
>   
>       fetch_cpuid = tdx_fetch_cpuid(cs, &r);
>       if (!fetch_cpuid) {

Alternatively, 'return -1;' here.

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>


