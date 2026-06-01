Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29C88CD6E55
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2026 19:19:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wU8Ak-00072h-4U; Mon, 01 Jun 2026 15:19:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wU8AF-0006rV-7r
 for qemu-devel@nongnu.org; Mon, 01 Jun 2026 15:19:11 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wU8AD-0004fu-LZ
 for qemu-devel@nongnu.org; Mon, 01 Jun 2026 15:19:06 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 651FDohR4065896
 for <qemu-devel@nongnu.org>; Mon, 1 Jun 2026 19:19:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 g2Nx5DKmuI9gnJ9IX39zomdREWr2IYF/5RkMBahKRg0=; b=ABlX9K3HWjn8BPrE
 VHUzQnsflVTuXa5bDVF/xDVf4Dy0c4hGnwDu+HLTpHkkOyiDBQabbFc91+7GE6DP
 kQeUyhuw1M54LlX6Ff+sW0xxZHjbYj3fiF+oqKTDbhw84OBaTt2FZFNhNq1P3rVP
 MiyZQUO9muKr7kCHgpbi+OaVaZG7bj4EPz267o65QEa//tGMDUlXEqUNtz9wBGrO
 ZEVPARtBEgEy3RiSn9a84OfiDHc+/CmuonIaejkkDK90kSmgiECmEviYg6iKJz//
 W+mIs2aCK6X7XuKN5tZ6TvBxFEQudAgqntwP0XKOd8Dt1T1kNhy+uHzassn6dx3I
 FzcyAg==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eh6swtqf4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 01 Jun 2026 19:19:03 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id
 a92af1059eb24-135916eefa0so16197939c88.1
 for <qemu-devel@nongnu.org>; Mon, 01 Jun 2026 12:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780341542; x=1780946342; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=g2Nx5DKmuI9gnJ9IX39zomdREWr2IYF/5RkMBahKRg0=;
 b=WAEGCYZ4QCKoCoZ00WTsCCL/ZKmZc2fYxQkL+Jmtj8/Mob0kTDvrM9Q3v39ubypr2j
 8M3hyFQ8+MPHuSv8ZJQXZBGoMzd45E1sPll0eXs8AWujjnEvhIabWPcqiIVy+R58Yy5f
 Cztg2y5hcKOuy5UjRGw8CDlF6M/QMgi8hxUazxa/V+wdJNSOYZaKEKZ+2LEq3nQrrbML
 G1Y0VpKt3yqOVJ1R1M5pev44Mq+ayVl+iLyHmkEYBs5PPQBNo51C36oR+7kOp2sTRXmH
 ghIL8ZtWIdSbBoOX/HlVv9FIRCv3GxSfOFdWmAoqtsWawJ9T9Qu33EV/b/a4qGPjiQg8
 znZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780341542; x=1780946342;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=g2Nx5DKmuI9gnJ9IX39zomdREWr2IYF/5RkMBahKRg0=;
 b=R6/hEObTg85dh7CboGObI8HgPCyigCKuNN7M++lw+BXNn7T2xhemtzg+Dj4ZW0P5XX
 BvrfMY4V0U7V9I6/tdxd+i/SZG3Elicx5N2BzVS83bR/tcentj/Sh+IiP2j1mrL128eF
 OWp7QauM4BtcmAtZl5T+VrmB1N2nN8qxlbtEQC6U8AfYxolIiDMtyCPSuVzBthJpHa17
 PRZccDRfvB04CYOc4eBu2rRMq6fcnHHnjGznUigUQKskIC5TzIh9LPCS+OuUW7raINxI
 kJZL9F2c/KXQ1o0INNFdhAsVuYXw2HAY2AEENGDocIARJHDhCkgQOuh13pDFabQB0gpP
 brBw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+n+3Y4oenPpH3Cu++t6rzXKAg6UBXX0Oh6gzVNDQ8ZZReDBgKUpcIdE6lHEdK8oaM345w3LI5c1O7h@nongnu.org
X-Gm-Message-State: AOJu0Yzz7gzRr1XwMKp6kCMUILLku/M8Ut9YKmlZQJ9Dn5JnnDs41bc+
 Rqpsj9VkMfDSmUIKq0AIbEW6kmGVqCezQ6638ifMfHiq9ZCIWeo6JBCIfwrs2RT2SnnmB8WXRzr
 8Kjjs+Cvn1Zihc0B2KUvfVNgcvlmmdzkx2UlMMzfbqcfSb2R3xc6uWdxtqQ==
X-Gm-Gg: Acq92OEod3OAcNMzBBRLi66qogrzMUlZ71QJ6D4CF+soezzneL0N4uOJralcnxJwDca
 tgoajOgZEN3RAxsQ63lXVAyQ2/utI2o4MzSa725rikMtAgcgCXHnk2wCcRz+5VdLZ/hKvQ8DO7Q
 ZSt8+Qa1pCgFNu6kt3/bkD+vDkH8HZugpruY+vUTwq15CGvlDa2dncTABhaIW9ZvQfGRqsWJo/9
 EUFnOIDiH/k+MkeJOFV1at4V1gd8F3tFZK9qgcqYL6RttQRY5CtsifUirpv95mTjBeAPUKXrmt7
 G/LUHilznBbKnNkVzQWwZI5X0fp8a62/iZhuKYjV3oC9N5AFr9v9MAxrukG+qgrLWYGuoltyJQS
 cMuKNEFTJr4qmBpc9TiLzEsSxKttmTXay0dHuxrnL04PLynXR+CQ0CSyPXIpXqUv1vSoHIWXYVV
 YSoG/imtm7hX8ukhZJ4vc/wWIw
X-Received: by 2002:a05:7022:50a:b0:136:90d9:f1fe with SMTP id
 a92af1059eb24-137d413a20cmr5468249c88.26.1780341542016; 
 Mon, 01 Jun 2026 12:19:02 -0700 (PDT)
X-Received: by 2002:a05:7022:50a:b0:136:90d9:f1fe with SMTP id
 a92af1059eb24-137d413a20cmr5468228c88.26.1780341541495; 
 Mon, 01 Jun 2026 12:19:01 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-137b3c69c0asm7906205c88.11.2026.06.01.12.19.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Jun 2026 12:19:00 -0700 (PDT)
Message-ID: <6e46b859-12a7-462c-b24d-ad02c224c80e@oss.qualcomm.com>
Date: Mon, 1 Jun 2026 12:18:59 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 03/28] target/hexagon: Implement start/stop helpers,
 soft reset
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: matheus.bernardino@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 philmd@linaro.org, Brian Cain <bcain@quicinc.com>
References: <20260529215806.608770-1-brian.cain@oss.qualcomm.com>
 <20260529215806.608770-4-brian.cain@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260529215806.608770-4-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Z4Hc2nRA c=1 sm=1 tr=0 ts=6a1ddb27 cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=iW6L48cjwSW6_7Lsg84A:9 a=QEXdDO2ut3YA:10
 a=vr4QvYf-bLy2KjpDp97w:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: ERMcVULgBuoaunU6mv1wYVGR-Cc3evMm
X-Proofpoint-ORIG-GUID: ERMcVULgBuoaunU6mv1wYVGR-Cc3evMm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAxMDE4OSBTYWx0ZWRfX7segTkll93Yj
 hOr4eeXozXaNJhnybysU4KvTf2XOzT41pP+lnQ2S9oEEBKhtzjU1+wt+1Eq9N937HSm/gNocXLb
 F/qFVcowCQ7U2KWNinBRwHuolvaAvOeyZVJD3RxS6SnyfRKC3W2XtHTEvNX7tnH3DLZbjAMtGat
 40YwM2DPLyoWTfQqVc90j15LDN0UnnVYxiVEQgV4DNWe6qb2Qe1rN+YdLgBejeTtyLkwLZ+n+Qy
 DEdItezUGeiBpUQU2NXgvPPtYiQueMng/4/50gNPcsXCCho2Gzh63T+nz4KGLJMH/s5jr33uw84
 HFtF4d0VF9fjPMLhojA1TtPqL9nKmthel6RjnX+HXh8DxiHhW9ztBSf9tEm++zDONUeiQqsN9K4
 s9Ry4Ys4U2PU/AbTHDeGahbbGiD7AnVRXnSqlFbAqnF0+Kk4PBghNvxBgHMJzfuPn89lp/Mam3C
 YAoxdj+JFsJU/VsyMhQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-01_05,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 bulkscore=0 adultscore=0 phishscore=0
 impostorscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606010189
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

On 5/29/2026 2:57 PM, Brian Cain wrote:
> From: Brian Cain <bcain@quicinc.com>
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  target/hexagon/cpu.h       |  9 +++++++++
>  target/hexagon/cpu.c       | 28 ++++++++++++++++++++++++++--
>  target/hexagon/op_helper.c |  4 ++--
>  3 files changed, 37 insertions(+), 4 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

