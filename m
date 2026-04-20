Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC4E1F588FB
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2026 16:36:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wErbR-0004VD-FR; Mon, 20 Apr 2026 12:36:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wErbO-0004Nw-D1
 for qemu-devel@nongnu.org; Mon, 20 Apr 2026 12:36:02 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wErbM-0006xP-Fr
 for qemu-devel@nongnu.org; Mon, 20 Apr 2026 12:36:02 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63KCNEg51532097
 for <qemu-devel@nongnu.org>; Mon, 20 Apr 2026 16:35:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 AJBL6elzNgFst/8qmBpvTGwQu/AjTzdwOGmYA9lS3Cw=; b=f6grxOap8AOZiGjz
 dp+Q7tBbnRIsI8JDMvfiYSpvEdt0JGSb/T0rtkAmy0ozduQaYlWwg5lvslOoMj68
 7E8w1Wlw7J4K3u/I5Dvu61BilyF3KJBu05iMZ8ZPWISAXu+7uVwyrB3IXeNH0Tgs
 Nmic+0C2HPRWy7FLkFCTJUn/ma3yhDCotzlR3DFvK7LwrCanL39gdv0Jx7QLwYMm
 ZPxAI4xk2Dt14HwUQn+TrRu72B+U96qabXEib6EmD5305CqhkwGYsZETprLN2f46
 0n2lpEnfFapc09cWUMYnlxh3r560EC1My8biNOSPdWetnKXYJKlTL4To8uNbrykK
 j3EYig==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dnfus2arn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 20 Apr 2026 16:35:54 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-12c726f4019so3693522c88.1
 for <qemu-devel@nongnu.org>; Mon, 20 Apr 2026 09:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776702954; x=1777307754; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=AJBL6elzNgFst/8qmBpvTGwQu/AjTzdwOGmYA9lS3Cw=;
 b=d3n3rl+OMhd8FooE+Bsump92IfX//wlDiNFOgZysa2EINsbVV+XTsmvRogjkEzfY9T
 qIUNpu1TprZit2W7xhr9kOY+3QwxEN+K45F12la5lmjOmpVjkhMeVsxK+c2wmur6wVRC
 s4hmsMAVebjWcQrVt9PMplZC1MVcoJpcLGWmo53XBFw19Z81G4oB57uExQIsyUyY8ttE
 iXZu1mLjBzO5ueo48qvC4baftPqFgnbv2HqEpZvQYVU+4MOHKLq7d8jqx6kYCaqHr4KY
 qqjt88wyGXoXZ1TfHzj5VpUi0+sPwiTPnHg1Cwd8lcgPeGSjb5x35odKHju+gDjmj5rL
 kXFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776702954; x=1777307754;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AJBL6elzNgFst/8qmBpvTGwQu/AjTzdwOGmYA9lS3Cw=;
 b=NV56L37hKx4vRRJyCMYKC3DpsFlnjscWnrnejbQWBKIvWfZW2RPBAMSNKhRHKl/EJB
 jkSeU/6T+6YJC0uAN9RB989LA41Urg9c0nTwjBiTMpmPgF6z6L9xMM1Ts9QGfFCwko/6
 HUBJ4QOXlRGXdJEatQGqsXUQHs74ypJ5oIUAJ9e2hSO1wUzrk/C9R4EI71qOOwd7loCY
 vSPenBthR7TzhJgKwp1WR7M4cjg6BhJfMuVJo8dcOaN1hARo5JaB6dA0xGVrL+KEx665
 mkiABkbp3pqQfaHJCQV0tmRlXHfgYgBwPfIAadXVpINcJ2rNL5bY71Vh3rQl4o+/YxCr
 Py1A==
X-Forwarded-Encrypted: i=1;
 AFNElJ+rPM/APHNNWBZpEPAkWc9PFYPDMxzdwneQnXIS5H6AoXnzbRaAdOXQ0HoYDkYCC0qE6kIbcRrHX2a7@nongnu.org
X-Gm-Message-State: AOJu0Yw8XEwg5Jo4FesoXwHN0vpX7oR/X+ZlBN5UDSviv8YoTQyU1CgN
 X6RDP05fOaYsKJ4AQeY4z7o1jJ+ZFZBvP53GOyAgNK81Z5h1G8RcZRdYBU2YW/8m18WqHQcgRKS
 YjxlDJZH5o7cc/JFhMFeWW4eHIVCjcmKCns+QYAg1slxMPBY1EGvhDoBgLQ==
X-Gm-Gg: AeBDiesr0H8hX9gZaOBR9UyAxm3koAv6D+2zEcukEI0mNZP+E0slpz9Wd2ryXB3NLBv
 4o2x03CclE4OXjGV8O7tkCdKrk2sQxLnFjcM4PXjXgpU60DDX4+2/DHz7cYc+JSHKO9KNs0yWUG
 +gNneiAX229KlJAEjEut6rwwg8Y/4zXPY97rHbRkMEjToz0dUiVQG1PcsxafaEf572lZ0xbgQ+I
 81kmOjsLGJ8kkvNwbbjsHE5Et/WsP+Ijeexf+qv5BlgZc8mlKADW8slkR1HI5QKPEWTJKLF6CCF
 43B01+N50HKTJApAiNgbcTfPJh6Qzu/sEzLgOTKBDFt1cRzXavWkgSH8bxoJ6sd98zKCjpd/eq4
 twYvWYZAZKdSD1xIDPLNx+s7lYTcGbzs1P0YUK9iCeJEOIgfaInJ93wSrLr0V96JxbQREEuBWiT
 kTieNr7s5ca0122uLJrSeh122u
X-Received: by 2002:a05:7022:48f:b0:128:e0dc:6428 with SMTP id
 a92af1059eb24-12c73f90cbdmr8186665c88.17.1776702954172; 
 Mon, 20 Apr 2026 09:35:54 -0700 (PDT)
X-Received: by 2002:a05:7022:48f:b0:128:e0dc:6428 with SMTP id
 a92af1059eb24-12c73f90cbdmr8186621c88.17.1776702953525; 
 Mon, 20 Apr 2026 09:35:53 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12c74a20b9csm15305177c88.12.2026.04.20.09.35.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Apr 2026 09:35:53 -0700 (PDT)
Message-ID: <62050179-b41c-46cf-a8a2-a8e3525c36db@oss.qualcomm.com>
Date: Mon, 20 Apr 2026 09:35:51 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 15/37] target/hexagon: Add imported macro, attr defs
 for sysemu
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: philmd@linaro.org, ltaylorsimpson@gmail.com,
 matheus.bernardino@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, Brian Cain <bcain@quicinc.com>
References: <20260401152657.314902-1-brian.cain@oss.qualcomm.com>
 <20260401152657.314902-16-brian.cain@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260401152657.314902-16-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIwMDE2MCBTYWx0ZWRfX7JwZcSJcuefm
 raQ9347b9ZwGhZwTL/5dJzGxq2KlRkBHyAsgB9O/GCaRYgjz9lafgokD4PX9LTQ764d7QvYDqXN
 OEuAnk2+J7wlUrk/IGq0kEEUqC0fHgGP+CCErWeH1JW3DbXt1hWkxzqswwDQEWjTXvYTbbcLMxQ
 ADOvzBe1KWUj1bf1q3/OnA+F/02HBYdFoFoZbvuiGOfBmlvxbgod/rQMXovG8Mk4LSV4rUdjc97
 cWl8zyenRj7dgq7Y/QWxXlzqYs3tK63N0fHHPsyRjJtgIyUFPhRIiz1VS09N6SwMQz6PpGLq/1/
 gbTh3iH8jcJz1u/PZlc9FMDX977ueQenRx4rok57zhy36AXpeJ9xc55rCTnWEfaZ8qZaSvT79xN
 sr4CHnT7Pr5IAJnNKIwzNxb+al5wI5m7Cy/d+BW5zUgvFupgNkheF+bLaSt2jZi+66iUvvIBhoH
 ASQpFy4U8ef6onoh1nQ==
X-Proofpoint-GUID: rvwgUU9GbDu02imTSKeIThVb-v5SF7t2
X-Authority-Analysis: v=2.4 cv=PMQ/P/qC c=1 sm=1 tr=0 ts=69e655ea cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=sBzRzBvcTUSsfqThXD8A:9 a=QEXdDO2ut3YA:10
 a=Kq8ClHjjuc5pcCNDwlU0:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: rvwgUU9GbDu02imTSKeIThVb-v5SF7t2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-20_03,2026-04-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 impostorscore=0 adultscore=0 lowpriorityscore=0
 suspectscore=0 priorityscore=1501 clxscore=1015 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604200160
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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

On 4/1/2026 8:26 AM, Brian Cain wrote:
> From: Brian Cain <bcain@quicinc.com>
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>   target/hexagon/attribs_def.h.inc   |  35 ++-
>   target/hexagon/imported/macros.def | 482 ++++++++++++++++++++++++++++-
>   2 files changed, 504 insertions(+), 13 deletions(-)
>   mode change 100755 => 100644 target/hexagon/imported/macros.def
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

