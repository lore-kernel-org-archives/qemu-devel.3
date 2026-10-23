Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26590606A31E
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 12:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=R1ALMwfO;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=kFjlJGgZ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKENr-0008Id-IE; Fri, 23 Oct 2026 08:28:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xKENf-0008Fe-Qh
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 08:28:24 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xKENd-0004RK-82
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 08:28:18 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69NAAZSx2509102
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 12:28:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 SsaI/Xvlp19/ljGpqFYi+UuztwmnEv6Wro1WFDVBkwk=; b=R1ALMwfOe/bOqGtx
 WMUEI3OapSIQD610ZTXuqPtrCNExeNZiHw3eolaJMCWMbrxlgLRqspk91k4lVU2H
 PP9m9goS/g07r683wDN75NcC2bCGlOdbAX2LAYHlotAZVrtaxPMPoZwc48iwXj8S
 CWcy9LDUkVlvKzJcjdn+DvYFuRjQpg9Yi8kG5ZtTPJBW6RWq8Tv80jj9ZQvmEVDz
 XpsFBTPMPJsFptdMnWC8KUPGo1HNcrIsUUuoFIkv7tB1vx+aCupsb7CFRDUCGJgi
 np5I56pxu0nIcRsMkBQwTL0ZiLMe3MzefXvN7wLR9NQe3Uhh07uK8pRyn7jph9eQ
 hND/2g==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfsykb2dd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 12:28:15 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-91256a7b7b3so15640876d6.2
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 05:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792758494; x=1793363294; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=SsaI/Xvlp19/ljGpqFYi+UuztwmnEv6Wro1WFDVBkwk=;
 b=kFjlJGgZLw1IXPKpOyjDQCvUFwxkwBRwHzjgKk3cJkWMLlDXHSbpFCbfxPPfyanlIm
 RZbJYVnlN9rSeimFaRGdPPcjYEkeYaJrf0tB6RmtXmMgWKdOgLQmBdu05q1wjhgNT1eS
 mtw0+wXPQBysiE9ndyj5XkTeiz+p5taF1RayPj86upjoTdiv0i3FqpPXNyAcjegn7pvX
 g08BH14hfbl5p0njenviAg7U80B+k+eAsbxI6f326z5PEYzx/JGUM2L5AUM+AVoJCHyn
 wfP0DX7wM7lbhhKUZno+L/wTsq073IkGRIWyPPRlHFU3+fOu0RonEIeWTW7JsFazCq1g
 c3eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792758494; x=1793363294;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=SsaI/Xvlp19/ljGpqFYi+UuztwmnEv6Wro1WFDVBkwk=;
 b=TyhydjYnJOw3KDYHQtdpTuY0WX0N8bHwXymHF2q5d75XDEyW4290c32fJh9vRnvret
 m6PPORuLOvF8Z0V4zumXmEVkj/JnduwOZN3NPbt0kIS1vxePwj+lMeiueSLu71IOR+vj
 iXK7/7Ez/wGT9GRwgyExtriBCFWm3BnTYhpMkojCmjXlwXf/SnoVXdH5v/akfrnJzWRk
 6R1gYvy3EMefMORy5baOPuUGL4tPQNTxsFuxezQ6fpXB+ACKYjvjvjw5LnUejcWtG4jo
 GYVa0vQ+Uu9+Qn7O7eArnWGCMoyEDjPifSSGlNfJdMZhzftBGqVbbXiJvHHmrpLrb5Tg
 txUg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxuDYySDCsZG4W+wRDfxSmTt7ZL59wRqBJV9ck8lUaZjdHQiGiYnSZ0m+po34t4clRTQXKkTVwdYDSr@nongnu.org
X-Gm-Message-State: AFq9FYLKTf9yWb5T6ZGJQ7uEo2LAZkF8jUQcF8tG9z8b2Bn00R0zfa35
 fjFTkvo4bY5gePA/WSfwCKjRQmiHqtPwYuT9wCCwSrc6VUq6TmCogoshIfV8V4SnVMIGktpaC9f
 r3Tqwd3N9i3D8fcS2oY3RxfnwTtXWdgf4t/IFRweq+ir2vQSRGlbPuzjC7w==
X-Gm-Gg: AYBFou3uR6rwrnCiO/opdrQhs7gwv7MYRCjmDGmpcSm7j3JjJ0Pz7moxi40AM7eF4oS
 ZRlgYCrMO3PqGPm+INDkwsHzX9GGfv5R6RhdZJKs1sOxHNoxJqkpaDT9jcyW1d0VATZlQJ1gwF6
 llBcmLEdcuwch8h1xivOc0gHqs0XFr4u6/B7RARlHUY/fo2wovq9ZVuaI8OiobUxY8QwRsPl9Uj
 GYQGzWep3EgJj0cQTKU1qcwM1zlm9qPIZRyNvsucSj4p+hOu69I81VloGi6zf9AODXDWIqa9yDA
 lOjGPK58Mmbfbfo+QmwnJPitKoanbqSU4aaUV7cPoCYufQdOrCcYL2v8bKVXB43+VgQ1qTy0OUx
 OEPxJ5uZ7eNafVKsUsp/yPg6NWPem4YEMFQ==
X-Received: by 2002:a05:620a:1a12:b0:93f:334e:df26 with SMTP id
 af79cd13be357-93f6f878a79mr382296385a.51.1792758494234; 
 Fri, 23 Oct 2026 05:28:14 -0700 (PDT)
X-Received: by 2002:a05:620a:1a12:b0:93f:334e:df26 with SMTP id
 af79cd13be357-93f6f878a79mr382290585a.51.1792758493602; 
 Fri, 23 Oct 2026 05:28:13 -0700 (PDT)
Received: from [192.168.69.209] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e38048ae6sm4963456f8f.37.2026.10.23.05.28.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 23 Oct 2026 05:28:12 -0700 (PDT)
Message-ID: <c7bc002d-b235-4f6f-857c-216068184248@oss.qualcomm.com>
Date: Fri, 23 Oct 2026 14:28:11 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] target/loongarch: Convert to translate_for_debug
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>, Song Gao <17746591750@163.com>,
 Bibo Mao <maobibo@loongson.cn>, Xianglai Li <lixianglai@loongson.cn>,
 Laurent Vivier <laurent@vivier.eu>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>
References: <20261022125858.310252-1-peter.maydell@linaro.org>
 <20261022125858.310252-4-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20261022125858.310252-4-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA0OCBTYWx0ZWRfX8lH4yrB14NO2
 HEr/bvBtigyokIUrbavW0Usz7Yah9LLIfldHOC5WVAY9P4spGYhQ/rsyhqCKql3u2d+8TijNNPB
 rA74dBVcPrvb32e+kh6RI4rnnT5hErIkMpd92X9SOuFjFHhejeDB6p6StXOVJE6GvXa+VsqX/gz
 BrGohp/5vnjuOYBVsPnBaII+du0Uf70wpviK3ig3qfEoUNwPuO2afdTF2+ceahlNIqexSvOCHFQ
 6i+VxOdu9fpcMBVpYyzgz7UsGh2DURepkigPuOOhWjCu7q9ZHyVD259TNH80KSqxdwVbNO4pqeT
 SWx0N9IKZcC/B8FfClvNSfoND0tIhvDJHwuMC6R9W/ap/lhz0BkCe0i0TuWOUYcTcS2Czo1yELs
 HX49D6lU0UdOLrNzqIPPoLToIA/mchubCg+/0QV84F92wKd2BSWFWwUwJ9YjBkxyhUOHmV2gIqR
 2kqpYOgGPzNZYC7O5cQ==
X-Proofpoint-ORIG-GUID: rJUhv3kxge5RUCFV_QJ8AWp0MLsmFiEw
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA0OCBTYWx0ZWRfX7kVC9XZ2Rt8L
 /sE0KFsINWH4nmA6JRMXFJk0g8RZ7B1gSq3I0lEWDGvtipqIRlhMe+VvFIggUPQ+AmRzC3uv5YU
 RObMsabX1L/JNZVRN1Zyo3Dl1PVgiaU=
X-Proofpoint-GUID: rJUhv3kxge5RUCFV_QJ8AWp0MLsmFiEw
X-Authority-Analysis: v=2.4 cv=GLKdgeNK c=1 sm=1 tr=0 ts=6adb52df cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=80wub6co21KJe9jkMHIA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=OIgjcC2v60KrkQgK7BGD:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0
 clxscore=1015 priorityscore=1501 suspectscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610230048
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

On 22/10/26 14:58, Peter Maydell wrote:
> Convert loongarch to providing the translate_for_debug method rather
> than the deprecated get_phys_addr_debug method.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   target/loongarch/cpu-mmu.h    |  3 ++-
>   target/loongarch/cpu.c        |  2 +-
>   target/loongarch/cpu_helper.c | 12 +++++++++---
>   3 files changed, 12 insertions(+), 5 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

