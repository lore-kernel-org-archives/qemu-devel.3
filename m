Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAD40606A31C
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 16:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=pVB+wE4d;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=XB3mdJ+z
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMT0R-0006Rc-Oj; Thu, 29 Oct 2026 12:29:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMT0P-0006RC-PS
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 12:29:34 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMT0N-00028m-Rf
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 12:29:33 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69TGF4bH053041
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 16:29:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 akjhiLyJn1JBs6AW1HtB/GnQXkGWsJcw0Dh4nIl7rOg=; b=pVB+wE4d408BQeqB
 F1HDwAa+NPhulqPtGRPRtY9igLpqWVXletO2f4k3II36xrubGFNjVbCG27/kiz4w
 b/aotZcu3HQwGlMPsK3e+3VCcwtYP7IdSffRVj1ipz65ugmJrgXz/P7PmXhI6bjJ
 wNXBYEacaKxkPV0UHkBnsNkaGJIUS3BvLqeoaP8m88YgfOeAfNrULaT+gCvIxTWN
 5LiRMjOk6n1vyKUFAET3uYcxz1ZKo5T2DQN4uzKgz+c/r/ZRgPaWuyJAFA1oH/J2
 2E9MRsnte9U9DrHZDsIm56IQAMIYsNbZY0mWtm7V11bPP8pNeGAiYzdPpH9tZCTi
 /JHktw==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hks3nc1rb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 16:29:29 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id
 ada2fe7eead31-7cc06b9ca9eso333341137.0
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 09:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793291368; x=1793896168; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=akjhiLyJn1JBs6AW1HtB/GnQXkGWsJcw0Dh4nIl7rOg=;
 b=XB3mdJ+zhgKXpwtpMEVlOp7kX4KgscwvXvsl/EugIakGKlTzRbQ/6TaQxtQtdJe0zv
 j7YStbIEz7LWSFrB9+uqJUN8luF5KuiJbWT7ODSXuDo7w/w/U6I6FwYeuz/Raq5KqC2d
 MCRVOgEVUySRyhEC2OSw8KwSEaOqxFunTjuwWOouJY92RWIzhwiVpDSgzCRDD+xpfSEt
 k0FWYi4CSv0/trvce6XbjJXwZfucIHj1P5S17afxuId8NvAZrZStwWiIHEweE8N1pxt8
 eTMPEOZMLYJRw+aTLMahTfizSNmhzj78q68y4pOzQdp/DR1SuquTdcVmQZNoppUvOMs4
 sogw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793291368; x=1793896168;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=akjhiLyJn1JBs6AW1HtB/GnQXkGWsJcw0Dh4nIl7rOg=;
 b=toQfwskVpevo0LSmf/lglimHZht/3hNXdmScxeS3hTiZ88Dv2YbJmRVgnSbHNuBb8p
 CM/DWdSKlnoJ+nDEPamTTn95JItRZnIojOSLo/nrSpwOEK7E90TCkfViJ8dMiHXia0bX
 YcHzM8HGFnPzj0zB/QyGR5szRkVxuYQv4bd6mELaWSRoNGHYHaLftTZ3l0zEMKEIN3Tb
 CT6arnfqWQyyTLE13bnVyYaZ0AAJ9gf1NemiIrucBSoZ6tgUXBQ5lNq5k8hHb4nrr7ez
 o1Nb04uI0tgvuKbruFGTwWVKXhevuHPpHwvi7L3M5PuWj8Rtf0NCHe57y3bcN7hSJ4SQ
 KsQg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzzqMauZma5lzvsRQpXVHdsCHTsTq9gM73b81qVBsTNmLPGPg7ZUnxoGKA/LbB8/KOlp94Kp/yjLiNw@nongnu.org
X-Gm-Message-State: AFq9FYKK3BvZYTRFmcAIY/24VmN76WMVDbTSD8eJ9+fyOfd0OuxsEgIL
 RxXDwbf3xIFrY4pDFnAm/4KvMPtTVWAB0AnNV5K9/x/RVW5/uG6LlBDfkwoy2rKASD8v7HbAmG/
 FfzeYkUCAu8j1i/y/U2szed/DDtWfal03C7y8WVFQ0GCK1ibbqC9QsG6mfA==
X-Gm-Gg: AYBFou0gn6ZNKxoxBYqKX0fxrIUR4bBGJ56D4oMWTYMAan2iTGmqoQzQdLv0PTnOOgl
 p1T1Qop7dCyMyof1/6p01MSwRd7tMgM/2w6+/5/mHiU+ytDsatUZXTA8PcvjRI0KR6YHPdGuyA/
 ES6uBeiugvyD0gv2r/cw5EEhEbWesZuhSaSDD7BXt1KZ97PyNF9unp53fU2xtNkdHg7a2dj/JWz
 9GVqj6xdErxTZnB4O3cV08ryPfq4c+TkA4cP/woloMI/3DHWmxfiwN56PulI3UrXnMqEw7Lkm4h
 27hbdAJUTO0F4BgxgLPA906XmXJluqlEcvEz9LgbYCLu8FvQt1X85UWhP1jl1e1/hpPRyIeBX7P
 kbRgvg1wRenIlVdLQumKnqtnCDyywxer7vSC//VbSwvys3sPBMPHZRTbOfww7XgJf8j6dHKsEoR
 2bdLpO174246eA42L7nKnUmZI=
X-Received: by 2002:a05:6102:c94:b0:7c3:873c:b3fa with SMTP id
 ada2fe7eead31-7d03a29ed23mr2513054137.4.1793291368488; 
 Thu, 29 Oct 2026 09:29:28 -0700 (PDT)
X-Received: by 2002:a05:6102:c94:b0:7c3:873c:b3fa with SMTP id
 ada2fe7eead31-7d03a29ed23mr2513020137.4.1793291367778; 
 Thu, 29 Oct 2026 09:29:27 -0700 (PDT)
Received: from [192.168.69.229] (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e6df87f1asm223717f8f.14.2026.10.29.09.29.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Oct 2026 09:29:27 -0700 (PDT)
Message-ID: <df337596-81b6-41e4-8bd3-17eb6299beaa@oss.qualcomm.com>
Date: Thu, 29 Oct 2026 17:29:23 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/6] target/mips: Translate MSA vector load/store
 opcodes
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>
References: <20261029151317.19170-1-philmd@oss.qualcomm.com>
 <ea5c1985-9dca-4839-8255-6be49593a1df@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <ea5c1985-9dca-4839-8255-6be49593a1df@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: cHXSh3FUc379dGg-TEAyiYObMxOAb_xw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA2NCBTYWx0ZWRfX1mP1K0T/e+/B
 Gm7yXrypCN6LYr7T2MUJdnxwNcQx/FmI0lC90uR2c/2262hFBA7veAJbk3Uy/kpuP+lrScgsNgi
 B2w/SnaSLaBujNPR0wzL4fWRCpDyMTJRqq3qRiKq+v1MpvOceubcmjvO+rb9OzrfT4TFyh/FIQw
 qWWYYiIMxdHh+Q/WH3RR9OboUiLjftIAKV+ZKLh3JYLgEJugFDXPnGk+e9kUnpYsoSns6NLS+b/
 FBevcNaXMzKuFcLulisPdA2r0aTUEB2ResJLPL/hZvsxB/sNyRZt9VpP+ssh7sDAKAV38an4jT9
 c8TulXBnaXElqHHOmgNOi3yACt41hLCZJbYm4vYy9nBwJoJOAYPnGmXbH+kUHCiX42Z5UtEqpDB
 7uWe/iDWyHIkF784mng9nRTKgbT4y/c4nTaHUq0k2v7GuQtq++6POduAm/h7XOp/aG2wWn1a3d0
 7YB974lr+KGKpNtYYIg==
X-Proofpoint-GUID: cHXSh3FUc379dGg-TEAyiYObMxOAb_xw
X-Authority-Analysis: v=2.4 cv=XZEcX455 c=1 sm=1 tr=0 ts=6ae37469 cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=VwQbUJbxAAAA:8 a=Ixn1CAxRAAAA:8 a=KKAkSRfTAAAA:8 a=ljnDzggwR5cPuSxph_kA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=gYDTvv6II1OnSo0itH1n:22
 a=_0vDLAJOulx5KDpLVjVP:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA2NCBTYWx0ZWRfX7PlsLnd0PJV2
 7zQpEieVDUpcnLJOnil9uG0Ou4UrTRCi9bxs8Aowh7gzBab9l8o0gBrnyiQQ+BjcNW0ztvpILjn
 QPVzQSKgEo3GrbRkDtX9lpFoGAqwI60=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 malwarescore=0 clxscore=1015 lowpriorityscore=0
 suspectscore=0 bulkscore=0 phishscore=0 impostorscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610290064
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 29/10/26 16:47, Richard Henderson wrote:
> On 10/29/26 10:13, Philippe Mathieu-Daudé wrote:


>> Philippe Mathieu-Daudé (6):
>>    target/mips: Expand TRANS_DF_iv() macro for MSA Load/Store
>>    target/mips: Convert MSA LD/ST.B (Byte Vector)
>>    target/mips: Convert MSA LD/ST.H (Halfword Vector)
>>    target/mips: Convert MSA LD/ST.W (Word Vector)
>>    target/mips: Convert MSA LD/ST.D (Doubleword Vector)
>>    accel/tcg: Remove non-explicit endian cpu_ld/st*_data*() helpers
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

\o/ finally \o/ took me 5 years hehe \o/ thanks :)

https://lore.kernel.org/qemu-devel/20211023214803.522078-1-f4bug@amsat.org/

