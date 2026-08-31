Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A7B4C624A4
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 04:45:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x0tsl-0007ur-6L; Mon, 31 Aug 2026 00:44:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x0tsi-0007uH-N2
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 00:44:28 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x0tsh-000575-AV
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 00:44:28 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67V1bd6P2240867
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2026 04:44:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 gZytEkDHBrqHeRKYkhBNA3anyBnUfE9uCeDBw/XwOgQ=; b=BAZ8VpycEdTcTUOn
 +f4B2z1WEL3ECeV2YRLD43Obtbtipf5k/BInirqA2N7zgD8cFcZwuihgrszBFq1t
 ANd9YD1mBYbalNOPnUPqcFDmUu0ylppVIS8wIXvWTd5GmNnoQXCZkRj8U4FCiKBp
 D0eP+z3vAjyJ9Jap+klZUOae3qYrc91u+vM5JWy3U4re5v7NvvymklVubedNYQXC
 +/4C/EgQBhdyNb2GcZInTP6O/LoF3CI0DP5aSEVobUrLJ1cufa7yQY0oSAnTKC06
 IDaeUcHXRae7N9bsSnL9KhutgsUIE1gQXRLDTgk+6ITPCG3+AcHlMBbAAC9PzkCh
 fiRnuA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gbqhwckf7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2026 04:44:23 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-939281526e1so78825385a.0
 for <qemu-devel@nongnu.org>; Sun, 30 Aug 2026 21:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788151463; x=1788756263; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=gZytEkDHBrqHeRKYkhBNA3anyBnUfE9uCeDBw/XwOgQ=;
 b=Jl8endA0WRLXOsC43Ki6OmOAwZldC7AjJZHUeKyRnkls5Gbbkb9mUhCE8WsKhhV+8/
 VFnbTgj6ZZ7EuMnwDwjwDKV96DAT2m1i0/pEUHAffSBl/0FO2Axj6ZCRYanOEWAKv8UN
 aAOYyRtLkYmbZ+Bul3TuJjikq78uHQpELDc2hhwmFKoyC3+iL//nZ8xy1HZ2Tx58LVtG
 2YpOxRT3wwk6X3y9YA8yYFqagob0GSC9W2EOFsg/UC+qJEMMi6aWF0k7hFLN3F9s8EDI
 Nrah964AXWtpSRNgBy5Ci8PkzB56TPNB35NhPNqKZyyRPujdCnbW0W9Qwol3xoXj4dSy
 xo9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788151463; x=1788756263;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=gZytEkDHBrqHeRKYkhBNA3anyBnUfE9uCeDBw/XwOgQ=;
 b=oufeikQ21BFZVqS5V1L6LW5MTkghcGocTpeS8rUTqBGFNhx0Z+BuApxAlkkdz5TIeU
 uJnDLHdEtibqmwcXsf5nBbqoK8cu4fAghrf1DSSO7pDnY27GCjkvAd7qeS65rIdhVYZu
 ZRYtHt/oq80GZLQJ/hbLkBsxXfaMgz5kMd2noS3RqNIkhpikvkZsYq26OErY3TgjSk2j
 e9l5zA/vhD48NdqhwwSwrA3m3C/yD6aFzK7ranOJHKbMH9YiSvKnYj1qSinK9eRXEGxy
 NqtzBMdYMVSXlQAaFyjDXptK4Dg5rvU9sAstfF4sAgXIFjk5wZbTrULB7yYJ6RYwLcDh
 BovA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rqh4yaeRJ98Xc8tV+7S6zngqLQrpB3vIssNf2pUNCOimWiwRcrpEUpV6HJ6APgtylbe1lvyF7agELVy@nongnu.org
X-Gm-Message-State: AFuF++kWPLc1KdAQg2aNAldrJiXYg0WDdcGktCNxpl9rNosCotvcTgkq
 9l7iQh3IqVIJw36+W3h+CFZe191DIe7iJRQu/kuQSXTMiGfOU88FnieQ2tJipzFc4Z5c/n6AX51
 rIPKuptMu+HSHtU7JmKL/5w1hcE1KfRsXkaqtlt79iNuOMcz+wjUUpEAEWw==
X-Gm-Gg: AR+sD12ZlHcIMHiNyYgbx88yca/EaQ+kLZeZOyMstqsrSiSaJSyqwXO2JGasUV9dZZm
 0GDPp3WpGchD5R68uqZ7LdR/qHNemeDZwe7u0wfe8JG8UR9OhW4sWgSgF0Gr85suJZZVTsNG+J/
 4QiVNRDVZXYt6YvBiDmbiA06ig6+F2XUuPMx9D4a+zSaVtnWMU1V3g0wAM7U6bh716f9ZhKZkNx
 K8MgRXOUXUjRxNhCSX7ZF/IIB1rgebtWBm5BKg2ha/Rcl/2luI93gkF+UvpylIMnwNzilnU84wc
 NHj6+nRQVqnzAbCEIlaFXoz8gAIoK4JLRNYWxCdP1m/v5AVwqOd4/MZ/UIIXj4TR8kEUNsAvH4d
 zGOu3n++rUsfl5lfOj+8TMWDp1xIa9J3Oaw==
X-Received: by 2002:a05:620a:a192:10b0:92e:e559:fe6b with SMTP id
 af79cd13be357-9391377b1e4mr1901534685a.7.1788151463289; 
 Sun, 30 Aug 2026 21:44:23 -0700 (PDT)
X-Received: by 2002:a05:620a:a192:10b0:92e:e559:fe6b with SMTP id
 af79cd13be357-9391377b1e4mr1901533385a.7.1788151462815; 
 Sun, 30 Aug 2026 21:44:22 -0700 (PDT)
Received: from [192.168.69.226] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482fbb20737sm17839428f8f.22.2026.08.30.21.44.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 30 Aug 2026 21:44:22 -0700 (PDT)
Message-ID: <6312d50c-e18d-4c2e-992b-3ba0995f8a4b@oss.qualcomm.com>
Date: Mon, 31 Aug 2026 06:44:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/13] target/arm: Rename and adjust
 aarch32_max_v8_tcg_initfn
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
References: <20260828222639.1432046-1-richard.henderson@linaro.org>
 <20260828222639.1432046-2-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260828222639.1432046-2-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 2qIof35vsIuObbyibfo3ayGfiHHC_PMg
X-Proofpoint-ORIG-GUID: 2qIof35vsIuObbyibfo3ayGfiHHC_PMg
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDAzOCBTYWx0ZWRfX59s5sCoiTRZ4
 MrqyP5vPfAeVFVOtake4HYY7R1tPGthMDGySjzstqs8BTJNhtkEUwu1/2GOXSaHXpBvKD9idA2d
 6z9Zjc//9dGi+PwIFgsA7FytfuqqN+I=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDAzOCBTYWx0ZWRfX5JMI5S4UeGH6
 yVW9Q5x/RS26E2NYdYTivNdmYQxtruFwVlk9rDMioY5UcPznE/gAu65zuAfY8x75gP7SSHAMCJb
 uHx6ksN0y5/ENiozAAlArD64swd6izvU1TOU35AMGOD9s1Qqi+mh7Jb0SQ42uzfaayo8PhZLGrk
 t3zda7kf5OJVuKkBG/d1kfU5AFRMiqhJSBKtYVjt36CItyYSHsucJTQrZRCSN7Ml3KbIkYmbOvG
 jp9+KzIS/R49C2ezNkeKwEYcDz1tQ5sp9cLfzfF8e+URMhwZqVUrMNHB3lzRhdqTweclRhH/w7T
 3D7RH8zJ37G8groW/MkotQHRxTDzOY4izvr8SMBSBxOVC7tCV/AnGMQUWDMXsvtXTLBJP5V0DmP
 P1veYiHU3Axw0QV/7IMGeznrZjp31evErA6yyzxdY5bv81zyhzJa7Sk5U6wgHvS7MiY7Wr+MLD5
 seivVxGUH2xPadur1bA==
X-Authority-Analysis: v=2.4 cv=YKKvDxGx c=1 sm=1 tr=0 ts=6a9506a7 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=jDE5IcpPZucr9eBqKOQA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_01,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 suspectscore=0 priorityscore=1501 phishscore=0
 impostorscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608310038
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

On 29/8/26 00:26, Richard Henderson wrote:
> Rename from aarch32_max_tcg_init and take an Object pointer,
> in preparation from being used with TypeInit.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/internals.h | 2 +-
>   target/arm/cpu-max.c   | 2 +-
>   target/arm/tcg/cpu32.c | 4 +++-
>   3 files changed, 5 insertions(+), 3 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

