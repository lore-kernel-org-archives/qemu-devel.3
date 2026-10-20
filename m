Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57095606A31A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2026 19:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=bfJxQVPt;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ER+qrmCX
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJFF1-0005Xc-Mq; Tue, 20 Oct 2026 15:11:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xJFF0-0005Sh-5y
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 15:11:18 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xJFEy-0006iJ-Cg
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 15:11:17 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69KI7kbh3499179
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 19:11:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 UeG1Irzt2Osx1l/AHAM/2PrtqyLbbDYSt8Gt9pB0u+A=; b=bfJxQVPtDHCx3aFp
 wpkukQ7FqZ+2+BOm6MGZGqjCpW/VbDj1V9vKeKbBOkS7Vo48UdV4igQ5EyFpFBj+
 T8RNl262xEp8ntUQjSv5F8BrRVY0lhvB/o40HAYXWNmecTLYtKip8PsY95fa8XMl
 UZzQlEuznCtLcUii4V/z7dYCieF+Jhb5VX0ZwV+NaFyinYwJVufHd14Duh0sT+1c
 ZdRJwrz3Sgcf3+Jln8hhJsb1WijYDh/UsyA7oc72u7FiQPbN2CYWavJb8gkV+ZDR
 EsKIWK2yldvtUtATnA/hLhyPuNSE4bBAm+2I1H2nvcN2H+MqtLgAp96iZNtE6JsE
 5R/x2g==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hedabg7m9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 19:11:14 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-3510d0baf63so8764988eec.1
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 12:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792523474; x=1793128274; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=UeG1Irzt2Osx1l/AHAM/2PrtqyLbbDYSt8Gt9pB0u+A=;
 b=ER+qrmCXUh6p5D0l07h832bjQo6RYK285Xe1egi+AqvmzR4GZfW4qG3f5EkPVm2mPP
 xNCxDnNJhqFGJ950ymdpo/eeF4iceCtCDYfmAH8ZpEl6Ies4cFkv0FJcx8VKzLp0bjjC
 AGQ2f4rmlR4Xop/u5W5GL4M5tYlcCWz8D5Sw7954xT5UNdmcE99FVnOK7CMGbFLuq9Gv
 Hp4FIaN2ndy+8WdRnaWY9EY6WPrwP3T6ehIth9uPjNhfHcAE63pAVpdc4mvlOKVktZDL
 r9EYpbc5YbOmk4qM24zLct9847LTFts1/lESN3O7aURdBfXz5eCf3m1teXeK/lWO0c6B
 5O1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792523474; x=1793128274;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=UeG1Irzt2Osx1l/AHAM/2PrtqyLbbDYSt8Gt9pB0u+A=;
 b=rkIKlOX4qOSOT6JCgANVWVKDsVzd8BzsCqnxflF2xyfnxuUJaiT8nAHvOM8k0AioIG
 fvC3+xMqRlAXpWTCTXBQAj+q6qNyt/rm9TiSVX1OINQ+w5whWOxkEoW+nkGAstvepey2
 rBOnjvPTudWrZ1Qci3zgnueJd0/RPPXLO4ITz9XWuXHavt7pADOJXj8ac+J5pIduZStC
 MffKcPu5DiXjbNBqb16kFTWG6pmrIACDYnTdqYeeeQ7NErCvf1Q2EgeJXsaq75bxWlK2
 Gug2jky1fShMP3nz/yui/v4V6v9pA+VZiKjhU15d82DVCMTaF7/meuporCGaYa/xPFFI
 xU4w==
X-Forwarded-Encrypted: i=1;
 AKwUvBwtwFGZOeESAko6GL7P4Qa+L2jSC7gUULoY5oQI+lmjdTwHZgsg9kYnyAKExYlNnyHf6WB5Vf9j4ZxM@nongnu.org
X-Gm-Message-State: AFq9FYJdwOrZshtMczf4C5/ivLj5tnM47Valp4uLAzEyZaQPJv9qAHMS
 +bYCuiQyrNVICCd1zVOlPX+ic9rtykt3W4zqF6oist6SLSt78y1aRT6uYANLzRLuv6s2VwVeoke
 gGyR+d9tId5xL0nD4/1OrTWIT4nbMb3UqwO0dU8VF0ECAFlL/cueIVKR0Kw==
X-Gm-Gg: AYBFou3KuM1zKTEqdsEH8YKlHpb9nrVKIZQrlto2IBwV4KvsFSG84zOXeGj6vzydGox
 lClZ4wRP2QUjcF3HRImYjTh3X29PF6l5yCPUPCophpG1X/rKnI4euyj2lFmUKETN0tmNpqXAR1Q
 DE6LJ7PewM1e339OTZuXJym3Esg/iY5JvkyoyOOMBEUpn31PUbKSyLBzDxkBgqE4QEpJ85mUbou
 RGAl8MrQsm823TVqUqJHvHqYhaVsqIi3zHOlp6DuRh9Ohaxodgv4c8k/1WJLOCManHS1Xv7cRTL
 SWjz7QoofSqiu7JEzSe02HIPZtU49YMF68Hnc5vLjD/hjZSQSHIFOIAi3f2+DcHZAx2+dd0iKge
 Lewt46K9HeUvC/uNflnQ+qbDCaGVCr71rYLPrO41ebMh7vt6fxp9G7X8MpKj0WNEKT7mtkQ==
X-Received: by 2002:a05:7022:ea50:b0:143:2968:564c with SMTP id
 a92af1059eb24-18512f1e993mr15309897c88.26.1792523474136; 
 Tue, 20 Oct 2026 12:11:14 -0700 (PDT)
X-Received: by 2002:a05:7022:ea50:b0:143:2968:564c with SMTP id
 a92af1059eb24-18512f1e993mr15309863c88.26.1792523473397; 
 Tue, 20 Oct 2026 12:11:13 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-19035c0c9a6sm608129c88.3.2026.10.20.12.11.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Oct 2026 12:11:12 -0700 (PDT)
Message-ID: <f987b585-80a1-4723-bc8a-fed184fc2a52@oss.qualcomm.com>
Date: Tue, 20 Oct 2026 12:11:11 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 18/27] target/rx: Unify BRK and INT trap handling
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, Yoshinori Sato <yoshinori.sato@nifty.com>
References: <20261007094516.75732-1-philmd@oss.qualcomm.com>
 <20261007094516.75732-19-philmd@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261007094516.75732-19-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIwMDA3NiBTYWx0ZWRfXwGDAl1wcuI4l
 4psGfeuwAZOOqz8d/knDPCY9Q37ND2C5YUyT7gGVtJ9lonRxq04bd/8jZajdU8cy8JrdHjTOMEj
 gTgvyroZ5apYhW7RmtirIvHd+zckspA=
X-Proofpoint-ORIG-GUID: avpFvo27n78dLvlMgMsQyH1TFt5OqvUf
X-Proofpoint-GUID: avpFvo27n78dLvlMgMsQyH1TFt5OqvUf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIwMDA3NiBTYWx0ZWRfX0qMM5CllZlgh
 jszRb+8P8h1JY5lBgibB18oUpPdcsDALam2/j5XdQ4DDS0LA5kt3GYYLm02zXtGyB5oiOTC3YBm
 7Qjj+r01Rs/9sy7/SC/L69wRI3ZK6pe5dj0PbS3nSAzlrBr4f2Ao1QWbBn9uHreOI68mGBqPR4Y
 0P5Ldj2907GjkuZaMKLd3f1udWs5zXd3vefLHsz0+jArH1hCLr3DZ9S11/nYPOFw8p5oaYBHGIb
 4Wb9KUjAC8llpMzUMt9L383kXDXvMl+8R609JKBDfKtnr6oFLDghXHsmrYbR45B0ahWncYMT6ft
 1hvPT6r2IntZal79ca+Z8wShhXx/zpnbGtLhgvj/JlFiy959xl+bM7ZseC3LCY7fnf5w0w9VrDp
 0uHnaVqSoU5cOnhTx5vPSh4vB4h0AMD38HKULDiVgCftgt+JJPaMNwDOFiWKvOFwnAUdot9/49W
 lErXvJq6Qnjo81hapEA==
X-Authority-Analysis: v=2.4 cv=NLpAaE6g c=1 sm=1 tr=0 ts=6ad7bcd2 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=YEB5RgzmAAAA:8 a=7iUGbdPMhdPr4ExiklAA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-20_03,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 impostorscore=0 phishscore=0 spamscore=0 adultscore=0 lowpriorityscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610200076
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/7/2026 2:45 AM, Philippe Mathieu-Daudé wrote:
> BRK is equivalent to INT #0, so route both instructions
> through the same trap helper.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> Reviewed-by: Yoshinori Sato <yoshinori.sato@nifty.com>
> ---
>  target/rx/helper.h    |  3 +--
>  target/rx/op_helper.c |  7 +------
>  target/rx/translate.c | 21 ++++++++++-----------
>  3 files changed, 12 insertions(+), 19 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

