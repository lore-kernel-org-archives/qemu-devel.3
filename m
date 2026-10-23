Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82C92606A320
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 16:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=NveyQPeK;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=MY8mx6+F
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKHuk-0004lV-8s; Fri, 23 Oct 2026 12:14:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xKHuW-0004Sw-En
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 12:14:30 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xKHuU-00025z-B8
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 12:14:28 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69NE65wt4064428
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 16:14:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 qpDBc8QFI93tMavIKpiMpZyuyqvWdA0AozOTXAlHAlk=; b=NveyQPeKKePxZ7Tf
 o0yK8txAEch8SCns/jt/1r8gpciJQuGwPhm3IIkd9MNUUVrxioLKhEQYIoq/zEJ6
 cSQUgYqBJTm4/JguZ0cJjsZPSNV4w6ZlUH9zB5F7acj14UaYsou8X2jPRBo4R2w7
 WZfAEoql/niyy2+g9/Fn8irseCEYjAXUGmck3FbzGfTCiYmz1v26ZIEJzfv8Lild
 oDcAh01dJiXxx4idCQy+6l1gCxB2Fsy7CUxIwI9HAjvxh9Zc9hE32Kyl3z8Z0LxN
 lg4AgzzSOyHpdeHd+iENtmnWQbj+YUJogaTlISkbRvNik3sLdNzdLZfCXeNIA+Tu
 0zDqZA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfqmrcgfc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 16:14:22 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93f559420f3so107359985a.0
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 09:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792772062; x=1793376862; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=qpDBc8QFI93tMavIKpiMpZyuyqvWdA0AozOTXAlHAlk=;
 b=MY8mx6+FynVFhgZya3u/pOuJo++Scu4Fz2/gj4qFQEs79dkzX696RkQ+oPIDuBDXWf
 ucTJTHAO5glKw8TE5eWe/wzl/I8h3Bf/6/8tu6mv3IFhJf+yDxtwNP4uiTr01a+PMFve
 pzkaPxrua46JJPkGIxBITStdaFkv5vcoXmhfQs3CchxHVoJRYYvNUvTKoHo6ukom0n+Y
 mr5y5i6pfWiFFuWeYCpAgk8fEuajtkl2vomHbEYBV/yr+XKSIJWYji9o6Kmm6ddkVebu
 Zfyqe3yC26ASHzwHp/ozlCB5HWaEndjqAA/1Psk3qAV8zHw+HxUIBC7ZbxTPTyCL4i+q
 y5JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792772062; x=1793376862;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=qpDBc8QFI93tMavIKpiMpZyuyqvWdA0AozOTXAlHAlk=;
 b=lz+vZF2b8cc8J0uVjSxeDapCD3YDHgNZe91coPY9QBvnBN9iVG58cqad/4U7PoJJ0P
 g4dJgjXGDcRbK8efvHKlz6SCsoEtSkBT1rVs8T45nPXqkLC5zDZI65nZVyT/JnI6Cnr0
 F/3myQBgSy3zTPH/LhoulDWzVloDZchyzv2t1JJBup5Z2Hb9bN/Mt6OQAY+wbvD9QxMZ
 xp30qSS530wPwJKZGHxOPGlJCTLfdyamDsVLwesYcTxNp91bVnXbUo7T/sLWy97B6yo4
 ih/R/CVe++hsD73O/kEVQ190jLPnOarc8UxGX8n1nHDIB2MuCTWQzAfBIPvjaGBSi9Ki
 y4gw==
X-Forwarded-Encrypted: i=1;
 AKwUvBz6ao1xQv7txjxyMJ5f63e3IwxTEFTZrTHTLVOCkawS8ENKBWlvJ95v1I9xfPGpup3Hp3yaqWtSENEp@nongnu.org
X-Gm-Message-State: AFq9FYIjeCKzJ+VBJhUcywaeEeyOVO5RljnbSFus1/D8JgFl7JOIeVJm
 n5Fo0L9RewslsefSrXqvQLQqulm+7iIIpC3owgRcug7hVLMVVUX0aU5ygM3luwoJsTTb5YRI2xF
 KCCgUCPpYCX+wJyEHl7Oy7RA54K0/x7SCfEsB0k6UJyCH07OJF56H94VL0g==
X-Gm-Gg: AYBFou2gf8Wvtkvrd9bvwUNXYXDf0XeIjzwibrc/Rpl9B+lzxeYDfRqLx8cGMQnG0XP
 4Rk+j/sRnUkWHWf6rhFmLzfDt8jrmIQ97VxXo02HibRYzc6B77LKDLnVeMecH2rRKUKdMSd7X0Z
 rF3wcg0/SqMX4IEmZCzujbigZSFRD8cRGQJlK6PfjQgfBhVx/p4ti5A0H/mrLfEvj6kwxQdjabk
 BOka7CaVT3xy9o9tTd5rkkOnvbPOU2nRtF6ki9DtSLtAFT02RkCh0LgGjAkL8WmXnTcYJEzatv0
 JVA6ZHw3wAtQce8y/m0jtOTPE7yldESpFABtJlnK51cJcdkukHn5XRUKEaGuWguizQXf7qHF+S3
 ah/TJRxipe3OdLBpFbnGQSZgSnBAiNABqsA==
X-Received: by 2002:a05:620a:439b:b0:93f:211b:a7a with SMTP id
 af79cd13be357-93f6f907cf2mr476792285a.29.1792772061743; 
 Fri, 23 Oct 2026 09:14:21 -0700 (PDT)
X-Received: by 2002:a05:620a:439b:b0:93f:211b:a7a with SMTP id
 af79cd13be357-93f6f907cf2mr476787085a.29.1792772061270; 
 Fri, 23 Oct 2026 09:14:21 -0700 (PDT)
Received: from [192.168.69.209] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3d4104b5sm770751f8f.36.2026.10.23.09.14.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 23 Oct 2026 09:14:20 -0700 (PDT)
Message-ID: <d48b266f-c03c-4e21-affa-641557f04fe9@oss.qualcomm.com>
Date: Fri, 23 Oct 2026 18:14:19 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] hexagon, hppa, loongarch, m68k, mips: Convert to
 translate_for_debug
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
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20261022125858.310252-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: ePw5DmnK4QS5jFciSRAJ2TAKe_-dMkeS
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA2MyBTYWx0ZWRfX2qedvwApkxca
 JBBpagNBWTtLzDOnPXt/YZvt7ZwV+ZMYyluuaEzrLDZIKDdga26KqQXMAOCckvGO6vnmXkIJfO7
 zBjjC+GkPvrSmlugLjzes+1bT3+rr1c=
X-Authority-Analysis: v=2.4 cv=VNZIDNPX c=1 sm=1 tr=0 ts=6adb87de cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=wzb6SIvNOjDyy__SAiQA:9 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA2MyBTYWx0ZWRfX4OhcT7DOKetS
 Ne+8i4yVp9XL1zLaXxU3PvIBMDFpOD5SmCuNs36Mv0AggRMCcIq2JdhnKye08krh+kBdgyIWonw
 KMH5hZPVqNtybR2zrsK52T9rfbp4powTCh2NdWp4r7WnnQ6zcnTkyBieLcwTS06hEHE+90YRCYh
 vfHFxYjsQK+t9z8Tlh8YQhn0W6jCLpDXT2D3BIwgSlt4ediWWeHPrXknt0vsNh2Z1bhboUROVuA
 E+IfXUNs3wdOQS+AtSQsD2YNY14/aDLIpNzrbRBiR7VeagYcQ63F/u2U0J1F1hvnNofrRHIxJ/n
 ZTvWw/UcS3jsDLZmS8xGkP7TsPiNA6r8R05nfDiSYGykcW01vloiWOD37HmoJZF9I3ADgXEEeL8
 H0ZxmFhFnb1ogmKqIYTcAgdt/Cjn2QVqyAC5HOtPe1d1xHluDIDNEPHjZUH6bG+4u8Imjg6SZd3
 K8L129x7yEHBRT+GCnA==
X-Proofpoint-ORIG-GUID: ePw5DmnK4QS5jFciSRAJ2TAKe_-dMkeS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 bulkscore=0 adultscore=0 phishscore=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610230063
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
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 22/10/26 14:58, Peter Maydell wrote:

> Peter Maydell (5):
>    target/hexagon: Convert to translate_for_debug
>    target/hppa: Convert to translate_for_debug
>    target/loongarch: Convert to translate_for_debug
>    target/m68k: Convert to translate_for_debug
>    target/mips: Convert to translate_for_debug

Queued, thanks.

