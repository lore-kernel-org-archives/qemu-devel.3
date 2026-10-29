Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86F33606A326
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 13:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ew0XOI2z;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=dxELRdR8
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMQIc-0006CU-41; Thu, 29 Oct 2026 09:36:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xMQIa-0006CD-CY
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 09:36:08 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xMQIX-00018O-SS
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 09:36:08 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69TCe2m13768196
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 13:36:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 /AfULuY2CHkgdc0/rYCUno+hBAqAfJnq3t1JgFjS+Ns=; b=ew0XOI2zEVOFUEn8
 rZnfJ+O9NVNFg8GIEsRG6ySuE55LfXQ7uUgL1jP1e8/QrR9ywfdTYD1L+c/rDa76
 YhPwphqIYUves135QQvOWmGv5dGIFa0PtvmvYoZF6m1VyQckztRUzXquMTBGyOSd
 Mq3zLOIvqdo3FVtLjZad2OpUbQ1rApNfUefArx6tHYGhpirqwjhqJj8WrPtsTZ3B
 81Ivb1LmJ4vSn4aajKlspIJzY+wpjYBUD/JLi2RwTB094Q+/yrZ6SSCSHx3RhQ9Q
 zyz9XXJz4i5BsMOP+aDx1aDa/VB/nsfkf1SJszN5Zk4LhyXtOJ9ObtF9o+Gzygin
 jEFjtQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hks3nb6qu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 13:36:03 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93e92aad34aso396952785a.0
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 06:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793280962; x=1793885762; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=/AfULuY2CHkgdc0/rYCUno+hBAqAfJnq3t1JgFjS+Ns=;
 b=dxELRdR8PHeO9L6FcDhWiJpaWZZqChb25x8BjGcLf498+Efx68SdvRo1p8S0gvEgIX
 1QCi5q1clioA+l45BDMjp0uQEyzlLE5AF/jH2RHDE3VOAoCVqJgutRkPwumXME4NvjU0
 fPxCnLBnisSC/jcsIPZtYN8sp3WbLAGhCaHIC6ANHpIsJX9ec00UW46czaYTDrNTpMTC
 ocRaYvnfcfJre2kqMuYkbJjysCX1wwH2RCdr7Wkh83kS+3848UG6A4R14ZD7g8vXsctm
 LgXUzEdRybIXBE3oAPcSfcSdQvOfpe6Gm+yamujRRrkGfd26NNvqzR4c1Wb14pa6wzuK
 /lrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793280962; x=1793885762;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/AfULuY2CHkgdc0/rYCUno+hBAqAfJnq3t1JgFjS+Ns=;
 b=DsboMhMUnRUzmUsGEgrjRaJinL33kCg5V9kQotwmwMQ1RjD4JANiaJSep7SKA08fpE
 WnAvX7zIpq3qq0Jm/OgiRzocACUnERW2nJXbGoeN3WWZwwO9vhw0YdCVSc9Mhsckr4SH
 UIEAK4G5mkUPjvFDoDxi3n9EcLipJE/dkrkCPkY3Lm13H4evG+6gJhurJJqUvf1rniHT
 M4zJx+RWt/35zC/6TBfZJLo5zWediURQi3g/J8B/TrBSae1nIbJxg+rv1Veh+rAzRnAn
 9ElC4iQ/CGwEN/1EbNLL2MHNiYBJEqw120QeSj1nnVS8rcBYijHXW+nTjPBxR8G85voI
 oXIQ==
X-Gm-Message-State: AFq9FYLgGFb6/Z6YyepUv9A/opIYRsvdZ8NppVCjEv4DfK39doGvn51S
 EaNftB3wkG/tvTuFjQWLs1N6c+3kmY48bO6UCg72Z0JAsLLvyd8hvHPkaHcOAuQEfiTMkv1FhTq
 hPdBHdkAH0FzkKGpe6w53YplaCgkCTFPb9fsGop+wujR8T6j1ZJKnw6zwwK+paoAmrw==
X-Gm-Gg: AYBFou150XWkbAoi13+JDUGS5/hDzbRpJ7UdNut13hKSHAYlQO2Z5O937X0uJ3fjErx
 DmbbSXVtUmCf5xR0qgj6vsU+MmbqS95xByViiMmww6UgDo37hI1n6h7RH9F1m3W4yTqkNrr6ClN
 oMfoLT6OwqFRW027E/udoy7ZHamyQ6t7Qt5jjqJ6ZnACHcPaqjH6iknOZiKh+hS4fKbl0FXoVPE
 eAdbdiQukFve1yk29+rE4LQ+/TUSGZRmh0gTTb8OpMaUi7H94ZqKpgDjZvHL5kCpyFuvQx1MZB/
 eoznyKgTeaGWZme76nmasY/VJTx2ko20k3+tqNmezxTC1AtdiKeArgXBJKQVGlkozzZ7bT+kR+W
 D1okO3+NAc87ZX5M1HVJ6A27NMTvf1NpoizgggWV0PJ6mczI51T2Sqn7BM5YRv0vqSB39R2VW7d
 3ifS6rct/prsiVBXuXVDfp+YIUhUB4SzQp+uQQzQ==
X-Received: by 2002:a05:620a:468e:b0:93f:1936:b1fc with SMTP id
 af79cd13be357-94408d562e0mr822534185a.78.1793280962115; 
 Thu, 29 Oct 2026 06:36:02 -0700 (PDT)
X-Received: by 2002:a05:620a:468e:b0:93f:1936:b1fc with SMTP id
 af79cd13be357-94408d562e0mr822529685a.78.1793280961429; 
 Thu, 29 Oct 2026 06:36:01 -0700 (PDT)
Received: from [10.222.168.219] (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-940f068328dsm1546902885a.23.2026.10.29.06.36.00
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Oct 2026 06:36:00 -0700 (PDT)
Message-ID: <dd7ad5bd-fc4f-4b47-840d-84da04144d5b@oss.qualcomm.com>
Date: Thu, 29 Oct 2026 08:35:59 -0500
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: QEMU Sashiko
To: qemu-devel@nongnu.org
References: <bfacc761620e29347af03f3b613c6c877b4c1862.camel@alistair23.me>
Content-Language: en-US
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <bfacc761620e29347af03f3b613c6c877b4c1862.camel@alistair23.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: VBTQcoEMbYcaqSr1A3AByObaXtGyQ3t_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA1MyBTYWx0ZWRfX7rm7UuZwpFAA
 CN75suHhWYjvDBaRbpDDbndlB0Fz78uqVLtFDzBBY9BW6EfEsZd5kVbRSKI1LetlHdHbtCF0fCo
 /8+1zYDYFTr2dDxxmPPZi9OrXx68DVyHf20kqAO4FVbNIehPJhuSqwjBVluAU/HKdqjfk/R3ut+
 pdPxXkdY2syIekYxs6cmx8cYmEd44YlErG0ku+T5ONFPGG2HjjfVDuUoS8xFGPhP3yrO1dSM1z5
 qsAn0/UCSXZSqhYUoFywPHXaBhyrav7EVjkLaJdoM7M5qMSTOqAsDj4WblYWKYx8dIq24CtbWRp
 qW+JEI5h+8jZU0DK626PGGai04RozzR4ZGPVv968Q6XtKDDSP/3eI0kDdEJk2a/wUCsuNyfxAgo
 McE9uy3jNWB5uvKkZAFeLwahK2Cf3BVR7Y5MYu9pNbdCm9EQXFQOXzdbA8Rm0cPmQMsv6HQF23u
 LLg9NOeDqW5mRdCFkVg==
X-Proofpoint-GUID: VBTQcoEMbYcaqSr1A3AByObaXtGyQ3t_
X-Authority-Analysis: v=2.4 cv=XZEcX455 c=1 sm=1 tr=0 ts=6ae34bc3 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=c92rfblmAAAA:8 a=NEAV23lmAAAA:8 a=PEW2b8y4vpI4o5ud6l8A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA1MyBTYWx0ZWRfX1A6xX7gbrqd4
 zA51RrSIW9P5r2tYEblfftCJmon9i90LldInf3a70jQXIQRq939g9PO5vp39pctsc6U+bXhCGpO
 QJxRDVy1GRUWTbfYmfdlS/SUGjcC6lo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 malwarescore=0 clxscore=1015 lowpriorityscore=0
 suspectscore=0 bulkscore=0 phishscore=0 impostorscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610290053
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, KHOP_DYNAMIC=0.001,
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
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On 10/28/2026 6:32 PM, Alistair wrote:
> Hey,
>
> Sashiko just merged initial support for QEMU [1].
>
> For those who don't know, Sashiko is a LLM powered review bot used for
> the Linux kernel. When people send patches to LKML Sashiko reviews the
> patches and responds to the mailing list with any issue that it finds.
>
> Like all LLM tools, it is both useful, but also verbose, prone to
> hallucinations and misses things (like humans do to though). The
> general consensus in the kernel community is that it's a useful and
> valuable tool.
>
> Sashiko is just a Rust application and prompts, it doesn't include a
> LLM and you can use a range of different LLM backends.
>
> Google sponsors the development and runs a Linux instance. So you can
> see the hosted Linux instance here: https://sashiko.dev/ and it uses
> Gemini for the LLM which Google pays for. It seems like there is also a
> GCC one starting up.
>
> The cool thing about Sashiko though is you can run it locally as well,
> so you can use it to test your patches before sending them to LKML, as
> long as you have a LLM backend you can use.
>
> So, now that Sashiko also supports QEMU there are two exciting use
> cases:
>
> 1. Developers can run it locally to review their patches before sending
> them to the list. This can catch issues before sending patches
>
> 2. Maintainers can run an instance to review patches. How you set this
> up depends on the maintainer and how many tokens you have. Pointing it

The one time I tried Sashiko (on kernel patches), it seemed to consume a 
mindblowing amount of tokens.  Which model(s) do people normally use 
with this?  Local/open-weight ones or commercial ones?  High-end or low-end?


> at the list directly and running it for all patches might be too much,
> but some combination of manually triggering it for certain patches
> seems to work well. The Settings.toml file can be setup based on what
> you want to do.
>
> The hope with this is to save maintainers time as Sashiko can catch
> issues without requiring much time from a maintainer.
>
> QEMU support in Sashiko is very new, so it will take some tweaking to
> improve things, but it is at least a good starting place.
>
> 1:
> https://github.com/sashiko-dev/sashiko/commit/e432036bba7ab10d4517385916e6c834d8176f70
>
> Alistair

