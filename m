Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB4CCC61DD3
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 19:44:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2DLn-0006fE-CP; Thu, 03 Sep 2026 15:43:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x2DLm-0006ez-05
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 15:43:54 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x2DLk-0005ag-EC
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 15:43:53 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 683Jh30X827101
 for <qemu-devel@nongnu.org>; Thu, 3 Sep 2026 19:43:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 c9LEYYry9Je7psFY/DlfdoTrTQ3nopbkru7rkQVSKlU=; b=NiQLyRLbn9kkAAMq
 +9gLnpRd+TDYV23gMv4CbVeDoCXfl2TCbmMj6rJn8aErmMx9zPkdaqJOK7hxf7pM
 +virfqZXQN7/nCMjlGiIVP8VomRhImHa3X1td6xjzU+222DldhotrL795XU5LIyX
 CqmHbaEr4wWENtR4X4zqsYhLq8Lif7rD1B/rJu3viO/tsfS/da+qlXCCbW8ymH3P
 6PYymKhzM/cB5kqEKPHKwm0p9AQ9yyu4JrlHIYcGD3nWq+3MDE9dynwlk6yiqxtg
 Non81zTgkiWUwRBMePzilru4i2mOUrzH2RoHzlplfG5d8RlgcGvm2lXdJhi6GbuO
 rV0TLQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gf5pdtw89-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 19:43:50 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2d02df2bf09so1735205ad.0
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 12:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788464629; x=1789069429; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=c9LEYYry9Je7psFY/DlfdoTrTQ3nopbkru7rkQVSKlU=;
 b=bc7GlqUVdtG83XIdFywUSnFAwkbWxQLEA7El0ABvgWHRDP1noUOpdGLnfILKyHsRI6
 QycRAW6KBy67DgrCl9PQzj/EBk0lyt3wgUO+IIj0YGC1FsUjczibWUXaSj2zuEOWa8rX
 VwABTRte4xRHnFytF77Pc5MUTqYobY+w4ZDqxQ1impzuqSCuRrhKxvRMidsWhDmT834W
 I71GCEp9vGMBoxkN9pG+XpIaeQZWG26JrPmzuuJOCmD5xQ3fUQu1L+T1t0XCyMa8o+4r
 0ymtYsqEVBHgzqm+/RMhTKZ7+avMp+a+Bj8q0S2XkoPthpsZ061r2FIMcQ750IRR6Dmq
 K09A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788464629; x=1789069429;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=c9LEYYry9Je7psFY/DlfdoTrTQ3nopbkru7rkQVSKlU=;
 b=H3kvujZz3AvuEfJV209s/Y423xz4N4z2EBKqBlnjcCX2j1oHBVtHRQn01w25w0iGDx
 ZviZf8gg0iDz3QncIW9V8yH639PW2aPDIORvDygVtrfOPocyt5tA+ApKm4cIDvVJoxRh
 +z2tf5nfx9R944VRfT3XwgrOWswR0Vis4/TkrpwykW+1TNJ3Pt6kWM6SMlAR1UD6nsIh
 Fh0k7jp+ke2+o0NDDluTJbAFFcH/EpYE6tQ+1Dv1B37f55+pf6WkoCkw96shCYtLvcOc
 6ubJScVPA+K9fiTeqVN+qNhVgaBSW13cFGVKRNF9RQdpxRzxZTqfp4rjLdqoz3fCIrhS
 vsYQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxqAJjIF858Y+NTCGoDX8KTUeijy80hlMG8EjP9j9ZsIj//svo/5jwKYNKTblsBdGhZKSZYRRyRFtwb@nongnu.org
X-Gm-Message-State: AFuF++n6X2id3pyYQIIxjQToURsJzQol6OK5zMAv4iDsjv1iP1s4Q4Ae
 n+24O+apwCTnezdZQbIBEJkM8n/FJVgGvEx/3/LjJ662EZ79aFFmVS+yAT9DkenwupSgahkevOR
 /xzcilhZ4mrWConV71FNuob3IkXmy/NEAo+ZtEdK8CHCGtEW+OzXeWmofQA==
X-Gm-Gg: AYBFou1+yrzauS2W2Kv+yCi+PYhzdmapOmYLXApHtrS2Tzdv+ijDaNaIjm4upkNnjN0
 wPh2rPSHhYIaB5yYqm0j1LPNLyGhPw0iZzzjji+W6v5lqbpM0eSXcQH3fm7JMJDC/m6i6FawuY3
 qO+HndrojU/KLeInn+KrWx8+PFmwm0J+FEp/mpKqpvl0523qfumWrrhQBS48RUlN55+eLzE9AfW
 NQIqMC0ElpoA7h67NVUJZQ/s4aGqxOxPFDRTrXzZVIC+edRmvUFufACRxPS/iJxsQXOE5VZQ593
 VzvObq7DZIS/tp+L0ipu6tvyc2+NV8Xe09lGLNmFqBLNDoeGoszTeDsSTYh4AAfyf8P5eJ7vSKH
 +B6OVm6IQfrRGPehmARi4/h6d3gHiaOyU6QlJKOhcg6dySkoYvVPYrVQ2lh2j83V7fbxC
X-Received: by 2002:a17:903:3905:b0:2d5:2f49:b3f4 with SMTP id
 d9443c01a7336-2db1231fb56mr20912975ad.2.1788464629237; 
 Thu, 03 Sep 2026 12:43:49 -0700 (PDT)
X-Received: by 2002:a17:903:3905:b0:2d5:2f49:b3f4 with SMTP id
 d9443c01a7336-2db1231fb56mr20912475ad.2.1788464628790; 
 Thu, 03 Sep 2026 12:43:48 -0700 (PDT)
Received: from [192.168.1.199] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3339b9f68e4sm1027680eec.24.2026.09.03.12.43.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Sep 2026 12:43:48 -0700 (PDT)
Message-ID: <332eba76-bd9f-4187-9511-0fbc9bcecf90@oss.qualcomm.com>
Date: Thu, 3 Sep 2026 12:43:47 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/5] tests/tcg/hexagon: check the two HVX predicate
 build paths agree
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: matheus.bernardino@oss.qualcomm.com
References: <20260820215117.1788954-1-brian.cain@oss.qualcomm.com>
 <20260820215117.1788954-6-brian.cain@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260820215117.1788954-6-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDE3MiBTYWx0ZWRfX0kbaV93IT5Ln
 lqU4tw8ApqQI4DNOojUIg6PY2OSQaCX8ozgaF7Nn1o+7UEA6ZUk52dOWuSDSzC4egGJeeEZD0zV
 z9qFfE7eJcEL0AZ6Ix9t3C+5mrPmJj0=
X-Proofpoint-ORIG-GUID: nFWhaC6Xvooj5IUR4rmrafhDjug2lifs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDE3MiBTYWx0ZWRfX+k8sfawCvtff
 MLmZ/ZtMxdRHBrsq5sGMiXlaxSwOnYnh6bvccwWlIH1I0lkjJ0vZjgI24Rz8IXHFGlZ1DgvLVfS
 3kJ0ovdjisImyxoH0M6g3CCaRfgTh6ryJudsr0lAFabAJtrnfPHUjh5YoULHVjgvIMS+RV6QiH7
 WLeNaTq2wWGuKEq0tMGbNIQqsvaF3JlYbh93qE2oOEX8ex2TZxZJtdiM1yAHznMw5h6SF5j6BC9
 zo5y5Lg7RNBsbpDqU8DLlh6sk7DBfI2mWLGQrMVkz/F4K2k26lb6fW/iRFCLlGYGk1z11/4oKs5
 0Y7hHtOZ1jYLLYYKw4d8p8RdnkpFDwO/nnKE0+RkuCIdrYdpo0p6SRgZ9oTyqpH3z0kPPlbQ+73
 8r3Oh5oTPQbEHg9aXvDJI7BqJ8Mso0OsNEAgPYO2moqeKtjkJPYoblPgZgLP7mmFrAfMdyz0lOw
 7OS+01AXbZWC7P4njSw==
X-Authority-Analysis: v=2.4 cv=RsL16imK c=1 sm=1 tr=0 ts=6a99cdf6 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=9mi-9uxVX9xl3ZHO2CsA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-GUID: nFWhaC6Xvooj5IUR4rmrafhDjug2lifs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_06,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 priorityscore=1501 suspectscore=0 clxscore=1015
 lowpriorityscore=0 adultscore=0 bulkscore=0 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609030172
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 8/20/2026 2:51 PM, Brian Cain wrote:
> A Q reg can be built by a vector compare or by vand(Vu, Rt), and
> those reach the predicate register through independent code paths. Check
> that both select the same byte lanes, so a byte-order mistake in either
> one is caught.
> 
> The input alternates every eight lanes: a flatter pattern
> stays unchanged when predicate bytes are permuted and hides the bug.
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  tests/tcg/hexagon/hvx_misc.c | 45 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 45 insertions(+)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

