Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DAF7606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 20:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=IChA5uX4;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=XlK1HgfI
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMtNW-0000So-Tc; Fri, 30 Oct 2026 16:39:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xMtNS-0000SR-RE
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 16:39:07 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xMtNR-0004rr-CV
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 16:39:06 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69UIjGZB3059792
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 20:39:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 S+7ikNBILb9UdtS91pkktGq/PXtvUrfSV2001kVnBLI=; b=IChA5uX4UNODfSg6
 YGsfEg7Ku1MzKqeRy4WyWYYfTTTbV4V6WGO1x6X9DJM/8bGWx9E3ZnMrxoTxobyD
 TqGYKnKeMi+CJoSSxky+t+oVh2aDLRIE3khLLIcfai7Von4NL9XP0qG+382MniiN
 +sVKJKtKVss2lGs1NKxehGFChngSXOspUgTOgvFEBKFCImnj9YAnvL+LZa7/DjTa
 VO9nh5B1PJ+iifemby9zRClxkhA81RKQVKjmT9iMhwXt9YHWogo4irMOU77aVxJ3
 K8QS2IhsHFQqEUsE7iny8n+V0TloE9xnCZL0tqrCax7Q/hhdjfjTbEhWE3dyvLzx
 1yCGDg==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hn0sxgak3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 20:39:03 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id
 a92af1059eb24-1ab289bb41eso888530c88.1
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 13:39:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793392743; x=1793997543; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=S+7ikNBILb9UdtS91pkktGq/PXtvUrfSV2001kVnBLI=;
 b=XlK1HgfIcJy4myE+S67whp5fvInmk5khe5Kxk/XiJqc/Y4cYei55nNNmT+3A0ANSWT
 Z3PClCN4XUu6UqXSYdXx2Q5w5ZTvwAICZuaChF+i0+lUp+yPfHJkv77SKvikkUqS8ijv
 Dds7zKs0ZRrN2YjFfGVT0Ba74MdLxFPkAGLSvLzOJtYb0Ux7LfNnwjv2u47QlrG1b2Co
 LyGrpLycWtVxc5wukjnRgg3QD2/EDIjofV4oYBuGhHP+0tNKWnGzBviKBeAZux6HPz5N
 7QfHSeT0xbecABdRCBHPBqo/t+CajrRNZO4JWi+CbqXYb1oSNGyAVJHVwkiY9DJDaRev
 WB8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793392743; x=1793997543;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=S+7ikNBILb9UdtS91pkktGq/PXtvUrfSV2001kVnBLI=;
 b=vgygFDLkZP7PosQoQAJtwLbirhU8oK1E3xVzEGyhRywI+m/nmJ0MgNF1fuLCLrLA6C
 23Wlsxhy6FX/BlOsIyAslppMZhurPn29gG96893ZAIln5U0i9JTERqa2uWlwQ8QZfJDD
 X848toiLUiCNrvOtEUfZrhODCy5J7QjB4cfVUd1N091qE0sQZ5heq/45QaP5oxYpn6N8
 Mb17FV9dMngSbezMzznT+vedLZiIzQCjp03pnBVW/dN5pVTwAIPcDqVgAmqrGEd25Wk+
 exsp3bdky5r2T/weInF1EQ/kmn+x0TSesn4JTSTNgGfryuzJf2KNBVfgZ8zTs6jMwVlb
 D6AA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxTUOm+XxxY035M5LM+ADZ9ywlEtt6OPTTQpr/SZU+2zGEWC3icx+wZUrpyizjzIG5CDSR3aPHkkZv1@nongnu.org
X-Gm-Message-State: AFq9FYI0JkWPESXF1PmOsdUHTZA+eFWbvZ7B+nBECCYR+5RUtNiAJCB4
 +KraLruewlvyuIxoP/xHTH8dzLaMmZFe0s7ooDyaJK++puHTbsAx9nci88iIvPAXuP602FbqpHh
 ScW/wXHxJjwluLGUdIS4w0//EAM8l68WsSbUvCZ4996BNjjvsBxhEpsZRFg==
X-Gm-Gg: AYBFou2V7Lfv0Y9kUlxYaJdr2S1mOdAgwF587L+m8gH7B8bIr8FwocJ2DILFy+1Gk4h
 bLRnb7JDwvpPMg/R+21p1jcjBdg4TkxjO2oy2uBJn6CGn09VooE5O2os0wGxKNK8dtb291TUUW/
 8/mRwssjBym5fQG/bBEifyhYo6/kqfNmkeir9Nq/78JDuD7UQpa2m/sdqmDGdQOzSR6b2zaoaeK
 g2icoaWv0FkCH4pk953gyj10NzNCz4hSGWBxUecCyTGY/laNAtlRuNlr2sXRZ+14YMipFAxhXOa
 cNskJSRR6/QK8U7R0JQoLtDiRo5AjcjoVcdagDC/Vj3m6XYNc2ggnFlECTiM4jokpH3TuiWksJd
 ePXO9g130LtazcHcyYQYQcm6VHXt6fqTbfEOjPiytwgGqsqazE1aS2YDF28XH5pbCgqaclWGUFw
 xWIQ2BcHBfwf91C7RbgXuT2LyrUD1KrNiszIplw3FmoyI=
X-Received: by 2002:a05:701b:424e:20b0:194:e9e5:11b0 with SMTP id
 a92af1059eb24-1a9496c2e85mr9503518c88.14.1793392742522; 
 Fri, 30 Oct 2026 13:39:02 -0700 (PDT)
X-Received: by 2002:a05:701b:424e:20b0:194:e9e5:11b0 with SMTP id
 a92af1059eb24-1a9496c2e85mr9503463c88.14.1793392741845; 
 Fri, 30 Oct 2026 13:39:01 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1ac18458fa3sm10356142c88.4.2026.10.30.13.39.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 30 Oct 2026 13:39:01 -0700 (PDT)
Message-ID: <c6f8669b-ca3e-4af9-85e1-22f5f91468dc@oss.qualcomm.com>
Date: Fri, 30 Oct 2026 12:39:00 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] target/hexagon: don't take the BQL to find the MMU
 index
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
References: <20261029190208.1169519-1-brian.cain@oss.qualcomm.com>
 <20261029190208.1169519-2-brian.cain@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261029190208.1169519-2-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA4MiBTYWx0ZWRfX6+RbTlwOoRby
 CtRqgSEoUG9NiW46VbFcPIQlVPz6APle4WKxtufFCfbdwxxm0u2xxcZUNdj+SAfdDw1XFgJu0qJ
 QUOczv5LpyLHS/MJ4MRYbHmTqU96Ln10aFrL5PMYe86FoZbW5KsNtYTLmqVsZ/cH//ZoiCQL0Hb
 OT8gbi+E8RRIZyFlElNM91vOPOJSPGiSTJUxPBVfdPT/X0xlC/FF/BpfP3vHVCbCXzISP+EH18a
 PwfZgeLA/EEuWX//rR4oFqaGtXwc1dPig7UEHH+DKLG5/VfWkyZh3IsyMhs+UZL/6GLi/61iqA4
 nOiX+xu2ZLiuCtK+SF8KLadc2M4DGlm7eAeR8Xj+Gw54L4hy6YWaDsAyf60YWMyZXvUP6e2dKye
 aK1luIfpzsyApq3AxvZML0Xm4HptqTMa8mJl02pa9D8t+XlRXo362f6Nbdipf3wywt9zDWY8URt
 1IwBI3POpDt3AoO4NyQ==
X-Proofpoint-ORIG-GUID: seO_hs8jjlLlBhHw0whtdJBJ_WOKLi6L
X-Proofpoint-GUID: seO_hs8jjlLlBhHw0whtdJBJ_WOKLi6L
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA4MiBTYWx0ZWRfX87Zxm+fnSpWj
 7w5KI8aT5TwujrgkdSDYjXv2EtSEWWunKIynuB04JqH170dXj1p1kidLyMvXqkCHVCp/B/vvu71
 aCZ9Uim0F3AEcW3CJZhX0RxjT6MltPs=
X-Authority-Analysis: v=2.4 cv=ap0nmiZV c=1 sm=1 tr=0 ts=6ae50067 cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=eYp4hImbHSICEXAR_wEA:9 a=QEXdDO2ut3YA:10
 a=Fk4IpSoW4aLDllm1B1p-:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 malwarescore=0 bulkscore=0 impostorscore=0
 lowpriorityscore=0 priorityscore=1501 spamscore=0 adultscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610300082
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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

On 10/29/2026 11:02 AM, Brian Cain wrote:
> hexagon_cpu_mmu_index() runs very often - each TB.  Taking the BQL to
> read syscfg is overkill.
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  include/hw/hexagon/hexagon_globalreg.h | 6 ++++++
>  hw/hexagon/hexagon_globalreg.c         | 9 +++++++--
>  target/hexagon/cpu.c                   | 9 ++++++---
>  3 files changed, 19 insertions(+), 5 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

