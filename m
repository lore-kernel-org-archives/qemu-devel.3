Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2935FC5AD5A
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2026 02:56:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtGBH-0003wD-MF; Sun, 09 Aug 2026 22:56:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wtGBF-0003vi-5b
 for qemu-devel@nongnu.org; Sun, 09 Aug 2026 22:56:01 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wtGBD-0004mS-Rd
 for qemu-devel@nongnu.org; Sun, 09 Aug 2026 22:56:00 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 679L77II3498969
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2026 02:55:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 qG24S/XyKBY5v7BM9lFvldZ/sXod0uMVB0/MWvK9u28=; b=WsWUJCIT7WE3PQce
 9LdLiLm756AkH9EFLdafAQRFxSY2RsadtsuMOtKBXEqU1Wy4FMFOpfPawKS5M0re
 kc0Ba2v5YBCa9yGiHQZNkQBvt7U5gXwjALQrauqwSeKWjNuEQmIt2a9Ft4XelcAP
 loO9bMESBicA3wGYab7vkCzIMa1yC0yfKBWmCR2DN879mm6qbIisb+DviXSR/K39
 H3ljfEQSWPKvZ4DK4fcjFCh+ak5KBJrQvAdWz8otxF4EwsA9hJZsUPK+xTfQgBNV
 VjaF09kG1QUNNGQ+aZLr6GGFVo8GweTQU5eEsrqvEapO4FnRmmejRQJd1bMlj8Gc
 7ZdBGw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fwvu8m37h-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2026 02:55:58 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-92e53b8a302so128021385a.1
 for <qemu-devel@nongnu.org>; Sun, 09 Aug 2026 19:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786330553; x=1786935353; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=qG24S/XyKBY5v7BM9lFvldZ/sXod0uMVB0/MWvK9u28=;
 b=PDg6tqUlgWzprB0OFyJj5LJupOmdtUIBOxe6MYLo5hWlQODzob1Y8wJ7kI/AmnOswk
 36thVRQ1tKwCmgnDzi0XbCUwlwM35Y6zGybbECklmtGhEOArx3t1pIp52fs2RaNBWvL1
 NAMs5zITvRc5iBzllI2kgkE/k1zscbbtmJNknG+7W0Nz5BV6ZyBOU6U/Pc/adglsfFxv
 Y5KAJ9iwweegqO6HsYhp6GpcLvLirXUqY5MV8Qf7nWjs3O6JV6eK0el0y9ALMGBBa1BF
 5XPHQEO5a0MRDVfBjt1WsMtCs1yVyn+WC8cbK0eexIfNScBKYcilNFoXG+uvXeyBlhrj
 wAbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786330553; x=1786935353;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=qG24S/XyKBY5v7BM9lFvldZ/sXod0uMVB0/MWvK9u28=;
 b=nwect19q7Yq32lxYQX56WIc0/zjMWLPRA1LDgIJjxU6JMVo1Q2Itl4IVtDuyQxUyls
 4vY6w3z5+yILqn4ecp1X0t+cQDVqR4H1MOSy3zd/+aYfZl08EZpet9qW9XtmJqxS1Dnp
 fiGO7anzeULwUClu58yllP99aH8A2I1aHUYcNZT3VgbaIzMasKRR/kQuzOF9yJrYgHX2
 ZwV7HaxegtfMbl+rQJqk3UPDPGeU1BY8VdSFmTDncxNpySaDENF1FWyTvSHMUmh/rzDf
 g0SdKGzP6UZvUHqK9asftuhMwrl3i+Ote4BMuypTpIXpSgB/AgXqtWtx29GcqCUL8SEJ
 /Slw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rrp4dLDCziVZvDINWAqaXyhEa9eqr9Scv3/9p/t6KUic8qafwkO51i4lL4rjI2hFJVIDdy9OYdT1yeS@nongnu.org
X-Gm-Message-State: AOJu0YyTGOXPNdZjcFtgxYP8ITb8h05d6mQGiFzB5TShE5Ug9fcaRA0V
 uT7fO7jXX1J+VpIUBGSJ2tWdW6KEsdMy5fTJpj8npVAe/rPNZDCsAYxkSS8p6vnffZSMJSEpB3F
 NwK4/Si/jsATHyX6RHbrGdmV6yBQsISpVqmw3OaEwvF0HLwQzoK6mceRMYYba4vHCeQ==
X-Gm-Gg: AR+sD11DYdS9uVkWtIihpcF97lVWK5rk/UOXYfOu6y/X5zin2v7otsp86b87beYezw5
 +q5zW8Cos+bxXIIrv5dvmyqQ/i9Pjh+m331xcWJCAL+aD+osj6OrA+xAwWra+Cx2fJV200qpQU9
 csYg2Zc3HH1DjdTNBO+FRr+g7ZpUCteVsPZMlwFEMX9SSKPWLKMF0CyVW98SZANezjePouA3VZK
 3qckE2K3ml8NygEesB0gKJchDVkv8dvhUVqh4NAUOwpv3UFjPmO5hA/Wm7gISY2zEoPJ1B+rKvv
 QELCCC3JPPKUThPZLErf7+mUTWyQgtQw8gVnVA/pVTmvYXwX65H4PPPeULHqfFhn9OcoEnCXBtr
 ysyvMHY8keoWSHJUFI/iuwj0kQTH0wKl31oY=
X-Received: by 2002:a05:622a:345:b0:51b:fc67:c73c with SMTP id
 d75a77b69052e-52ce5ff3246mr396496001cf.16.1786330553197; 
 Sun, 09 Aug 2026 19:55:53 -0700 (PDT)
X-Received: by 2002:a05:622a:345:b0:51b:fc67:c73c with SMTP id
 d75a77b69052e-52ce5ff3246mr396495861cf.16.1786330552780; 
 Sun, 09 Aug 2026 19:55:52 -0700 (PDT)
Received: from [192.168.69.229] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4995c69c8ffsm197491205e9.2.2026.08.09.19.55.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 09 Aug 2026 19:55:52 -0700 (PDT)
Message-ID: <a56e6ac7-e3c2-49c7-8a72-e14302389193@oss.qualcomm.com>
Date: Mon, 10 Aug 2026 04:55:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 16/56] disas/riscv: Drop useless const in structures
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org
References: <20260809223545.730664-1-richard.henderson@linaro.org>
 <20260809223545.730664-17-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260809223545.730664-17-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: xs37OaR8Cv8WlJ1Rp6ehOb3s-3zl8Z3O
X-Authority-Analysis: v=2.4 cv=M8p97Sws c=1 sm=1 tr=0 ts=6a793dbe cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: xs37OaR8Cv8WlJ1Rp6ehOb3s-3zl8Z3O
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEwMDAyMyBTYWx0ZWRfX7bb32U1/bczM
 7AA11N63u31cNaJQZAMrr2YrYar2Oj+oNaaJFtfPLqteSKSuOBcs6zdjzfOuBhvSulRq+3s/OB5
 +LnVl70UpwUQevQD829E0an32+3d3rPPNzuW0RKeBNfqQv9FQyB2B/6KYjMZAPpkAgQDN+n6hzu
 /74DqiuAhw/QR8rk1Wnxoe0Pymyep8qkomz5UYhTuUCyOSp2BiSQAv+WH0Pj4AvNPi2g/+J6MDZ
 NVHYAtlJSPsDiaX+cB7xDdnZx5RK6K7ni3YFRKx7Fpf5gPD+R5Xi6cKTppJJdxNwlJ0IoYIVBch
 MdGGlLlEnxBd6/rzK5xMZRFH27essrFVnxaUny90XMCKciWf+NGGMtFCoqta+d3n8ZIMXN8ckHh
 qs20Cx35TD8jgcvErFCKHFeYMFXr9YHDwRcr3pRcSmrmUTXWc3BwLKCwduxJuWOs+mJrJU4lLBi
 E7jNvVJRQVm91iLcL0g==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEwMDAyMyBTYWx0ZWRfXy5FOK+0hn4aJ
 i1GH9oyr0Omog/dtOwDEvW15+SZLmDiXzd6Uz2JYnmVzR8sdxcv0sj9sCEUV8kE5oa+M06Qdw5c
 D8t3CDlsjOidqO0txC3JtuMBTJgLCR4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-09_07,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0
 malwarescore=0 impostorscore=0 adultscore=0 bulkscore=0 suspectscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608100023
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

On 10/8/26 00:35, Richard Henderson wrote:
> Individual fields should not be const, only full structures.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   disas/riscv.h | 16 ++++++++--------
>   1 file changed, 8 insertions(+), 8 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

