Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6D13C43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 09:25:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wh22n-0002fM-4q; Tue, 07 Jul 2026 05:24:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wh22l-0002f3-UC
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 05:24:43 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wh22k-0005UC-Dc
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 05:24:43 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6678E4NJ3004578
 for <qemu-devel@nongnu.org>; Tue, 7 Jul 2026 09:24:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 EN26qKyuyVlZEnih5S69TeCMVL+47T4ZhBvcrycs8pI=; b=dz1ycEkHSfZT2w2D
 Ozurd7H2CIAj2STBxuYRpA5+qYVy9oj2MHITzN92sc7fzr36gz1eozSXTKI1LmqL
 SaTpx6fZYb7CqG9bS7Re6TZeY3G4OyahNXZe7vur5T2Q54mo57a0WkvxNbKkcfpV
 sDf6pGL++/VlrYeSoxkigjAGsZsFJLJQcuPJ5g9U/yQFDX4I1JVK4nTA3WJ45ZgJ
 nfeZICb0zJFBxjnq+jsrY6bSe8P5ginvBqnJ2gygj7TIPQXzHwk5k9pYVhVxotbf
 7T36lhhBXe0ONtImfjZhSxkD1Yr2tgix/Y+d4X7Tcg71I0RTzdgHTBjLe4G+tXiL
 aA4bjA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8su717fx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 09:24:40 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-51c0d6a2f4cso44292131cf.3
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 02:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783416280; x=1784021080; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=EN26qKyuyVlZEnih5S69TeCMVL+47T4ZhBvcrycs8pI=;
 b=YMjqYk2txIDeEoiPif6YB2oHlD6LIGUklNWwtDpwd+CDegyaK5Cm7pF97OKIAJFTGG
 VsIvd7Ts5SK0pVsey0OwBx++ctzCMfPrMLscKXqGqLLgSk9D4KaeqFHX6uq0rhDeZ7tA
 AuqGlOXfUb/u48RkHe+Y6lGyBhYtYkgAMhbV432HMaQOx2vaY4Z4oy0SFIJZ17ueeVxv
 k8RVHeEcYz1t3sFKChEFt8KLUyzy+f7E6p31TGRz0cF3ZLQBqFeacHdnfJxmMbdqtydr
 Li3VR86VaYhVqJdsWEVCWU/KWFHiihOrPZgz0BGm1nUy80YiMLehSnGwiVZHMitq6kjN
 btIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783416280; x=1784021080;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EN26qKyuyVlZEnih5S69TeCMVL+47T4ZhBvcrycs8pI=;
 b=d/IXkbLoMA5cdsgbYwxJckX3cRbJmIaDRYCfpkyx0/kZk1eondqKytD8nCLMpt/nti
 3X9FlX5eW191GKjIzikIYOtDYKsPsY/3sW9KfiKgG2JkLQSDZzDQWL05H4RPXZb5slLZ
 LE1RDuGP4i5H9EkKF0FDV7zsKGkyQxOlaxyhq0QaYkdKy3Txd5u1PuWfgtpMHv8wDiqG
 cNM+njyHGe0Rx7+yQztI34lqg9ZG/ynpbKNA1LRihTlJUrTdJzD+smUGAaXX1yH7X/oz
 +3pV762yyxM25RIO06ow0+lYxVYX5yUPP7tvWBQCNlt+2EX2eyv1vFLqJQN7VVKoBsRC
 vX9A==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr5/7HVwC6LiFy+yc9xQORqhQqdWZGbPQwZcmk6beiWmQINxIOUp4/L3zqAcAtctihHfPP+kuD3zuhG@nongnu.org
X-Gm-Message-State: AOJu0YxfFlKbbhtTrIcQbMk2s1C5JwLzw+3spgfFpdtmj0y7pA8q7eWT
 0Pn3yLVVU4IdSRxMBxQxwR1qnmnSGEEslx/+gLY4HhHX4g8ohsstT9LrAftA5kMdlzxqd1lRlCt
 SZ/gzGqZcZd8RveRtNsXpiiI7IwnZUUFxZCwc2KdIs33DqJ0iETvNQx8P3Q==
X-Gm-Gg: AfdE7cmkSC32FQh1bVIGymJ/UtpQ3HAoNFGLT+onMOO1nDVC4K5Kjkmu91tCEU/mwG2
 y2O806fsiDTx771x04BLPWJQH4Hu9S1xhsO6frvZpRpSceEURhqIpvuriC0495XaFOUZDbTg/61
 GxryElE0y0IIDTHFLLVKoC0tOt4SNIt93BuEwOhjt+X3jhMnAD7ZheHUzA2tziqHMp7mfCsU6MB
 wXGMfhSNkxNOwtk4Jbhl78k5tcmfralzTNJjW2GLVhaqqQFdrZcPDvqGqOFl2taWvHjAycXAAoi
 8BDKizcYFayrptyW6d8iDL7WlWryRIdKolGpvewk9lfPpnWVNReN9cq51QA47wXpWpdjgat17Qn
 XhgTEhENdRzO0HdSsIMUX/rvWg8Dpfxj3Xk9WaXr5B01NsLIb6r9H6DBFej9cag==
X-Received: by 2002:ac8:58cd:0:b0:51a:8c97:938d with SMTP id
 d75a77b69052e-51c748eda73mr44697451cf.68.1783416279586; 
 Tue, 07 Jul 2026 02:24:39 -0700 (PDT)
X-Received: by 2002:ac8:58cd:0:b0:51a:8c97:938d with SMTP id
 d75a77b69052e-51c748eda73mr44697261cf.68.1783416279074; 
 Tue, 07 Jul 2026 02:24:39 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-69a19ce4b42sm5308062a12.9.2026.07.07.02.24.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Jul 2026 02:24:38 -0700 (PDT)
Message-ID: <82dbfdc0-9469-4204-b832-0726c70fe87d@oss.qualcomm.com>
Date: Tue, 7 Jul 2026 11:24:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/8] hw/arm/ast27x0: Share single SCUIO instance across
 PSP, SSP, and TSP
Content-Language: en-US
To: Jamin Lin <jamin_lin@aspeedtech.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@kaod.org>, Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Kane Chen <kane_chen@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, Alistair Francis <alistair@alistair23.me>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Cc: Troy Lee <troy_lee@aspeedtech.com>
References: <20260707060919.350637-1-jamin_lin@aspeedtech.com>
 <20260707060919.350637-7-jamin_lin@aspeedtech.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260707060919.350637-7-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDA5MCBTYWx0ZWRfX845YuWDoYz7I
 QGADsOc+0pFW8iQgx6oSenTo5Ozp/lcFONfPh+nkyuRTUNtCfk9llOgQDrlKAiSgGY9VUwsHG/v
 bIRt6Icw+tkFRJQ3kGnENBts0WPCJQDMJ/4Z9+RL0saAheA9opAc2vOf9C/0jeV6W3zejW48IEd
 zP9SA3x7XhuAec03sbOiOxxH6OiHwwIYbTcVIctPTg8pm0O9h2eKdvKiTRpfA/mpNeW8VBtHRg/
 ztXi5HMULCvnvRYrWyrvz7ziQMHsuVtdoMRDUq9TIhEuYYgBLQVOa0aDzqZFCTO79VzWYbQFkeP
 CUb5QgrOFVZnm4O0e2K44oJATg3ZmzP1ADVkeC4F6Zx0RpaKinsIjC2b3WRuKuC1XN4GuBsBvNp
 jsbDI4GU7fvFTwIQsfIjHxp3Ji/agrS1Bbar94Ndt59QSw0UEsnnFZdBZqbSW4bkaAgqXflqPtr
 yiBYDXBQwIY0Q4c8NcQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDA5MCBTYWx0ZWRfX51LC/3/Z1H4T
 d7M8mcjLABZMWj7olTa03kvrrgtAZ/EIXIX1QCaah3F66/Nv6g6E8mXazjrzieibSqAzVxfR1j1
 szb9YT1U8Na1rYmqxKUHSJmQJbDkLsE=
X-Proofpoint-GUID: OjwBH0_limu4z8AL8_nv86jdq_40aemh
X-Proofpoint-ORIG-GUID: OjwBH0_limu4z8AL8_nv86jdq_40aemh
X-Authority-Analysis: v=2.4 cv=HN7z0Itv c=1 sm=1 tr=0 ts=6a4cc5d8 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=V2NxCb60AAAA:8 a=EUspDBNiAAAA:8 a=LfsA7Cq2GQzuzbZ-N0YA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22 a=3L6qF29SlnrayQqPM2jZ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_02,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 malwarescore=0 adultscore=0 clxscore=1015
 bulkscore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607070090
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

On 7/7/26 08:09, Jamin Lin wrote:
> AST2700 has a single SCUIO hardware block, memory-mapped at
> 0x14C02000–0x14C03FFF from the perspective of the main CA35 processor (PSP).
> The SSP and TSP coprocessors access this same SCUIO block at different
> addresses: 0x74C02000–0x74C03FFF.
> 
> Previously, each subsystem (PSP, SSP, and TSP) instantiated its own SCUIO
> device, resulting in three independent SCUIO instances in the QEMU model.
> In real hardware, however, only a single SCUIO exists and is shared among
> all processors.
> 
> This commit reworks the SCUIO model to correctly reflect the hardware
> behavior by allowing SSP and TSP to reference the PSP’s SCUIO instance.
> The following changes are introduced:
> 
> - Add a scuio property to Aspeed27x0CoprocessorState for linking the
>    coprocessor to the PSP’s SCUIO instance.
> - Replace per-coprocessor SCUIO instantiation with a shared SCUIO link.
> - Add "MemoryRegion scuio_alias" to model address remapping for SSP and TSP.
> - Create SCUIO alias regions in both SSP and TSP coprocessors and map
>    them at 0x74C02000 to mirror the PSP’s SCUIO registers.
> - Ensure the SCUIO device in PSP is realized before SSP/TSP alias setup.
> 
> With this change, PSP, SSP, and TSP now share a consistent SCUIO state,
> matching the single-SCUIO hardware design of AST2700.
> 
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> ---
>   include/hw/arm/aspeed_coprocessor.h |  4 ++--
>   hw/arm/aspeed_ast27x0-fc.c          |  4 ++++
>   hw/arm/aspeed_ast27x0-ssp.c         | 20 +++++++++++++++-----
>   hw/arm/aspeed_ast27x0-tsp.c         | 20 +++++++++++++++-----
>   4 files changed, 36 insertions(+), 12 deletions(-)

Nice.

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

