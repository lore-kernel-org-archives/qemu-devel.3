Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB019C55175
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Aug 2026 14:20:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wqX2z-000401-3o; Sun, 02 Aug 2026 10:20:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wqX2t-0003tj-9B
 for qemu-devel@nongnu.org; Sun, 02 Aug 2026 10:20:08 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wqX2r-0006u9-RV
 for qemu-devel@nongnu.org; Sun, 02 Aug 2026 10:20:07 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 672B6YM11602405
 for <qemu-devel@nongnu.org>; Sun, 2 Aug 2026 14:20:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 OzuMWa9y3m1rMB+KLjHXyf2Wyq9xiZ3gaKaqavScZFc=; b=BlE8/CMp4Yx+PMy5
 +OxnH6NVfB7RXYZ3K8IUYfg9woqfAG0KNxXnXhBhpbmn1YoYtxt593DxTs2ADD2p
 9JBNgRIRW1EagHJ45ENiYGOdZ3QJIXqR4fTegeMM7q6uxvNRecrKG/X4+CzL5vs0
 YlG/uWDRAO3lulL9qVwaV/HZznkESRAK/uTfCJ80aNkIdAVC/U/5wwIYjIkKs55I
 nvjUWDFPHCzN3+KNh1MUmhZ+n4A77JDeQb9SP7jLOA0PaRy7FTnJApEx/YjkaYUI
 RMxMVsZ6qFQpNEVAjlUXtPFc0GIzhEmBlEsOAqOj3RvpqQ20HRX8DmIP5AdTL4RZ
 nIJEyg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fs8vtb1b2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 02 Aug 2026 14:20:04 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-51ebdfceddcso27974831cf.3
 for <qemu-devel@nongnu.org>; Sun, 02 Aug 2026 07:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785680404; x=1786285204; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=OzuMWa9y3m1rMB+KLjHXyf2Wyq9xiZ3gaKaqavScZFc=;
 b=ibGVb3cQ0J+f7JQv+F1h/nt0szOFREcAxspDR80chtJaK9k6qQvZFC4DIW3i7mZ/3q
 QG97XY8qGHg8RJY3bkqjFAgn5QANdFBoiH03VT1XjqwfcdhjhWrqtmCLcQDnmeGAxuiX
 /W9J8s3z/QIBE/zf0AVMUxVZGSmTuExNiNC/LRUGVlZ48foIilAjsHtJG/2IA+Q3Xqg+
 SWfDdNKPTHlGrYMlIxBKvtG7NKu31iwxzTD4BuBT3R2vKoCVvDnYwbdTcSXELFKXia7j
 fqYl6zkk4xnkx/AQnTz198pVxA3YcmrWwzCBkkmKDeI1PWZWXLF7hqrSZt0t2RtftMMq
 IUPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785680404; x=1786285204;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=OzuMWa9y3m1rMB+KLjHXyf2Wyq9xiZ3gaKaqavScZFc=;
 b=sDt4No3sdUkBEI9lbVSXrv4aCOxYB82PCmnM2CdeIia94z6YB2ACZJoqPYYXwL4J5I
 l6nuv8G+KUF6ENPJt6QstiUCb29dzEe7TbCrVBrFwXVS4UObSWsuu6UG1wgOhbfDhlSa
 yxueG1Cnf8UJhK1dupi1qJ2HRK2em7ownEqgu+oJdesSLaCcEiS4Qb5yi5eQzrZW8xPI
 MaPaiFk1u61DQU75ATGjCRPOQKHcYWBHJC8C8+ajupV377QgAO/2/mumvQ8gkXFT53f4
 +yPvEkz5kqnMCv5qQfWDd0ZY1WkzizAfNekM9vEs+Ci4cxpS0zg3gKEM9CjpjivA5C+o
 jsuA==
X-Forwarded-Encrypted: i=1;
 AHgh+Roee9WyGBxpisOip+Q5MmA6AIs+FDlOVj+iqwx1vtOT2piQOpeSjm5xxGfapFe1l6NIrXXyihjUUMzk@nongnu.org
X-Gm-Message-State: AOJu0YwPKlmpQIkBZYO7i6vH0ltFzI/N8fTwa8ul2AcvQg1+RXmUEOlj
 YbK5P830pgVXPP0fvTcmAA5LE3EYcAX11IFyShAV4ulwjZqgFxMtd7nYCN9XLJbZ0CoFMdTnkz/
 7nafK9uhksfIRiIlKCJGoLlSiPqorS2rsl4oxgwC7AcWlWBgtDyEcqLA/JQ==
X-Gm-Gg: AR+sD12cR6R/ZoAn/w4P3zg1WkVB5yekvYFYfSpGYaJr5PUNDZ+ff5AdVJiMnlzYJaG
 6PHo85FanIrWF6BVJTNCYGqH4Xv8gfAj2nqVkWQtDu3EVFTAubcGxAJHg9DlN4AoO8eNYa6s2be
 MLDUR0zQ4McFNHxLGR2l0+avvFOgxbYRQeiCpgJWZyMIKZFrSVnJ4BCvGHqjCxZ3ivMut5VDQFu
 CdZWuQwiirsfgJ4ETaL8uu2zsHb2mGBq8B4wRTZ80T6f07acRNGZ88vG4jNjoOvq8yc/yLMEb7J
 Ma8nTuveaGBlH2EklEbZ93le5lTCyD7AB/mKkOMdTmkwHy/N+h9klCbv+tI/WdcEGxw4aakqeed
 PGtXDlCW4dz/hwBrHJZ/dOvv9fk/pftHModYw2PuD9gsKJKw6v7M=
X-Received: by 2002:ac8:7dd0:0:b0:528:601:301e with SMTP id
 d75a77b69052e-52b567784famr120742781cf.26.1785680404400; 
 Sun, 02 Aug 2026 07:20:04 -0700 (PDT)
X-Received: by 2002:ac8:7dd0:0:b0:528:601:301e with SMTP id
 d75a77b69052e-52b567784famr120742411cf.26.1785680404003; 
 Sun, 02 Aug 2026 07:20:04 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-498081a12a3sm210213865e9.8.2026.08.02.07.20.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 02 Aug 2026 07:20:03 -0700 (PDT)
Message-ID: <a4a89fa0-d07f-463f-a50b-d7d3a22f55c7@oss.qualcomm.com>
Date: Sun, 2 Aug 2026 16:20:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/14] target/s390x: Convert op_st64 to op_st
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org
References: <20260731185628.23161-1-richard.henderson@linaro.org>
 <20260731185628.23161-12-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260731185628.23161-12-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAyMDEyNiBTYWx0ZWRfXx2YKE/EFQYIx
 6w2JRU2sZlOQbAYOpFkIs93l/yIcHUs/Ph37OKwX2N32kjlJQY82TsuQqWrdWjs4TPueJgPe3Fw
 MXtDesLRVq2jQsP8yfS/KH5+5797G8c=
X-Proofpoint-ORIG-GUID: Ysxse7PgSJGeou81hZNVlEuse4L-0ABQ
X-Proofpoint-GUID: Ysxse7PgSJGeou81hZNVlEuse4L-0ABQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAyMDEyNiBTYWx0ZWRfXwQHR0ME0/hr+
 x5zuMmbut6fhxNT/u087UHzQm10PDm0uheEvh9szLML/BkpW+ZqobyhySUPXIFsa8B5cxNuqbsZ
 aITwM9JdFRdal/P9bHao2eRqVMtlWUHD44aL9d2iNzimLnlPmYQez4G7A6+te7pot/XprbT2M8a
 9JF0kzfox0nwHo3eC3/G2x+b77R0qkmMxsT5J6dONJIEmtSffRHIYD3DwWvAHnvyw6SlKVjBxG+
 7nroDQGgijxr6bDVnn5RiRrkH4/mfF9wEKbh1pYU1sgLqQxuAFQBaXdDXi5dZjhGrn1xuFRLlU7
 TmJZyhu8BCPB7Ovb1eEbw8i6TuEvARuw+3Rb3w4D/nz4u9NWogZKEPSho73uzVfMC7PvdRasbF+
 cZ6NMbNnBZlyu+PKK2jUHHa9fiWfQM85MytVr+9tXnpUMeaXMfBg0K9C9oTNdhYri7AIlGnnSvi
 YEjkiBk/c5UxuiBSyVA==
X-Authority-Analysis: v=2.4 cv=fKMJG5ae c=1 sm=1 tr=0 ts=6a6f5214 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-02_04,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 priorityscore=1501 malwarescore=0
 spamscore=0 phishscore=0 clxscore=1015 impostorscore=0 bulkscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608020126
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

On 31/7/26 20:56, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/s390x/tcg/translate.c     | 7 -------
>   target/s390x/tcg/insn-data.h.inc | 8 ++++----
>   2 files changed, 4 insertions(+), 11 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

