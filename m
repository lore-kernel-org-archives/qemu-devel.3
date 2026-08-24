Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 420FEC5DF94
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 10:01:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyRTv-000786-Gj; Mon, 24 Aug 2026 06:00:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wyRTu-00077s-Jh
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 06:00:42 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wyRTs-0003SV-T4
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 06:00:42 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67O99GYG3575222
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 10:00:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 fCmm44Cu3CZHMglmfccNxigzI+d1zjEiln8acQZSaVM=; b=nkM65kGHkMM9fZQG
 MTnK/qRj4X5bFF579GY2ngAmgYM+UJNeZbWyVfhfJnsIoxCpk87ZbDxZeV7SkPEm
 rhtM2JYY/n3kOyLblGbHLfe26QdfFr/pra0BlRFicDVj9AVRvuQFlplBupyr4I7a
 AT9XY3CfmwgljQ6TjDCWyY2BuYRaveNjYkxujkVO3EaMPdnc33iyyFqeinhqqg9C
 F59JgwlTZNw0mjbitjSfyB7pgHEpG9aAkiQBbYJjz0sNLbrWe997J1xG33b88cFZ
 vJJbhJnijFYstEPLxOq+5dZunJvuUHiIN+TItAT9S4VFqXF/oSWVUDLV5cf+iQnt
 KbV0JQ==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com
 [209.85.217.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g88jpj4mk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 10:00:38 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id
 ada2fe7eead31-739a588fadcso392442137.1
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 03:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787565637; x=1788170437; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=fCmm44Cu3CZHMglmfccNxigzI+d1zjEiln8acQZSaVM=;
 b=V8zhLXlcO2PVI0Oq3k4gbofV5SwsJlhIi9NgD2qW6r06Vlg6Q5wyrUkd2nzlKnhCFq
 EuRgjaRfB83b/pxjAbEGLK4i+njyqqJbJjGNypOJHzJuJX75Lt6ERj/qpdyYZQijMo+L
 sP6JsRizqLou5/ezetfyfXfQ5/wi5w4pudynWiyhMSBPVaLENw4DAfR8NP6JmAa3ignr
 xyn5vktH3cykmG+m4SQ1OCtFIrkJZ7v+jhCPWBbsCFv1ncH0O+q4FYimmaFJvxzJtPMw
 T1g4jEuk6w8V1R412yIT7bfT7jL/MOlRBnoOemuidmP2jxm4ZGsRnH7MMtVnTaBkz/12
 T+3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787565637; x=1788170437;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=fCmm44Cu3CZHMglmfccNxigzI+d1zjEiln8acQZSaVM=;
 b=br0Why7XiQAhMHC4z//plapx0KZMYcu/62fsv5yO2FQvxc7VCGyBeNxH4MsX5KF4zZ
 aHeVFAKvVAlcKew4jgEnL6Yck6ksyWH8kHptyP6LbniZ78GSjOi5m1fvaDf81PJuHPp6
 6qqzxeknn56IdaZ9VSgvOIrTbSfR0W9RiDiY8wkyrfbJU5SQq/ys6nCIIEy9R/DkvKRx
 TyWFXLrOw7xkAEFWB8UW87FK3yq47hgdHLFawX8C76tkXC8WdV82bQPPGQHj8Gdpj7MS
 xJMBXUv/8BX+kA1EHBOT1VZm6dedl/gC74T4fUlWkh7SlNqd+suaNAKWyjgJPKCSV7s/
 fTcQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RqHNSneil1mKFXMSLommxmY4GLMzt0KEXQP38kDFgfbjkLc+PGX7VCZPMOsKymaqQHspyYO2WsCfllQ@nongnu.org
X-Gm-Message-State: AFuF++mTbJxhyZdBOEZswE9Akg6ufqv0aWDbO3zD4FsxZyBo16Xna/0i
 sbsWY8z69YIKJlwRdSM1QJrDgeCc5gWsjct1Kr9uhT5jzuJ9sRVg3d/4sh5638Vl5DZCd6M4DgT
 YvSYVv+YvAXwTEKUXc+oM2NuglfBKFMzrIVLH+F/XtHfb2oWX7OcfZ5QrOQ==
X-Gm-Gg: AR+sD10KE8qobUAgDAPU1j+VSZRoDLgFOslTIivRieDyzbXSktVVzz2Kwh9IxLjwJFH
 eVOIBzKcxRuOYU7UjhzSXfcqVaMpc5N7Abh3JH8GZLY8GC0ZP7AW1UcWvlMorr+DQXBHj98VK89
 C1JpwSPx+OzoD2GOqiyGvMNYOQ+gOt0liy3+7RNlY9eGEcmRwGoSTJAUit68msT7kIHBZa+at5p
 Y93gAI5haeBdBet8Hj21afLK7EYKC0DOeQiOJK/KcU21vYKgIMrLLQTI54PywrvEPbhJMKUMarA
 auqlY7g0g7XxzMhjiig1i+Lrm7yGSDFAuDK93r7iS9DZj7JxM7L93UcsefjK/M5D0fCC+qvUEMd
 JQGwJHnw0gEcrn72vODqP2UulJrX0XGsueZGQCdejwA==
X-Received: by 2002:a05:6102:5044:b0:739:918a:16c5 with SMTP id
 ada2fe7eead31-77a629508ffmr8677212137.3.1787565637469; 
 Mon, 24 Aug 2026 03:00:37 -0700 (PDT)
X-Received: by 2002:a05:6102:5044:b0:739:918a:16c5 with SMTP id
 ada2fe7eead31-77a629508ffmr8677195137.3.1787565636959; 
 Mon, 24 Aug 2026 03:00:36 -0700 (PDT)
Received: from [10.254.188.74] (44.170.88.92.rev.sfr.net. [92.88.170.44])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a59e199ad5sm7803974a12.18.2026.08.24.03.00.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Aug 2026 03:00:36 -0700 (PDT)
Message-ID: <53af0f7e-fc71-4823-b016-9fbb421fc864@oss.qualcomm.com>
Date: Mon, 24 Aug 2026 12:00:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/5] target/hexagon: fix HVX predicate save size for
 histogram ops
Content-Language: en-US
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: matheus.bernardino@oss.qualcomm.com,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
References: <20260820215117.1788954-1-brian.cain@oss.qualcomm.com>
 <20260820215117.1788954-5-brian.cain@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260820215117.1788954-5-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDA4NCBTYWx0ZWRfX5AFdxor2B4pu
 6FheOIFzONAdkPqo3Aq5Ta3C3feK9asl2jNnE91tlCTaI10XgCSoaHQ2pAtUb2l5a7BH7oj0DlH
 eJ8rPdKvQA+5ZARCxU9boprFcqOynVVXpZmey6BXVOkIGO9uMud1OmfxT77+gqTeeGsmUzgdNEo
 VD9Y1XzNlflq/0twgtder/GtaDhH9GvhJAkzcGGkwNGcXNoqab+z/B/qasBH5OxT+vUXAHwyPWV
 TpnznS6wmoTYByInZBFztfZvnLIsT2wzPNqlSDRitNFObxcCgQIOyq9G9EsA5mfIaduIUDvK13T
 NfilLjEA7v7FLEihA7hI5WTyeUHq1XSsiY9BwDzZySK2+FQ+TXgRZANfL/Y9h9b8wZ6o76jFBjO
 SrB2fNJ8SPxIvhtXNWM9wCBhxhFFRAFtLMCRjK+5sPfT1hv8y9NgprV/IRWu4xGP36V46tTu9CY
 sst8wAYmCTMt5g2CE+g==
X-Proofpoint-GUID: b9MJc0Fn4rfeRgsqonxfKs6WanoX8nOL
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDA4NCBTYWx0ZWRfX9X6iLfteR1eF
 nvlHMvZX432YYboABMhk5I41n9AIq6Tjv99ZoqPUptzolihJCTAuBvtbauR4ToXtHuh6Fmz50zR
 BK8cJs97PLMgnl/L5M4imh0ptLoFhTM=
X-Authority-Analysis: v=2.4 cv=Xey5Co55 c=1 sm=1 tr=0 ts=6a8c1646 cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=s1NLoHz9uzatdv2VNqxUSg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=crWF4MFLhNY0qMRaF8an:22
X-Proofpoint-ORIG-GUID: b9MJc0Fn4rfeRgsqonxfKs6WanoX8nOL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_03,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 impostorscore=0 spamscore=0
 lowpriorityscore=0 malwarescore=0 phishscore=0 clxscore=1015 bulkscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608240084
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 20/8/26 23:51, Brian Cain wrote:
> The masked histogram instructions save the predicate operand to the qtmp
> temporary with a gvec move sized sizeof(MMVector). Both source and
> destination are MMQReg, which is eight times smaller, so the move read
> 112 bytes past the predicate register and wrote them over the fields
> following qtmp in CPUHexagonState, that is vstore[0]. Use the size of
> the registers actually being copied.
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>   target/hexagon/gen_tcg_hvx.h | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)

Fixes: 7ba7657bc93 ("Hexagon HVX helper overrides for histogram 
instructions")

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

