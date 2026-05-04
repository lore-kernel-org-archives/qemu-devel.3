Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7FC2FF885A
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2026 17:25:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wJx1v-0003jI-Ml; Mon, 04 May 2026 13:24:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wJx1u-0003j9-WB
 for qemu-devel@nongnu.org; Mon, 04 May 2026 13:24:27 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wJx1t-0003iO-HS
 for qemu-devel@nongnu.org; Mon, 04 May 2026 13:24:26 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 644Dlkst299537
 for <qemu-devel@nongnu.org>; Mon, 4 May 2026 17:24:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Adv6/yKji/PkhfBZbBSrw1Bp1P5n4obVUa4wQYWwDVU=; b=nWEbQmZ+Vb5RA/Vi
 1naeyQvsVde0Cf0azqxIqxmiC7fHcBBiT5mabiPwQJOwLB0hlKeJT0Ng9KjegnBY
 6Rw+JdY42rL9CPF2D/wmk8/ltqrrnUQYtgJ5qt4LlltPACYKgLZyVlr28b/MciOA
 Sb8TSYC364IRwyEz/cQHQTyMVcI8s2qxNfgDY0iPsxBq3N1zgfzYHgXSIxhGe3SO
 gCBkVCZqdkvzTVYjubMnPEQsru0uxYLQGsP+M4tK6al+OJ9evdSLvOiWy9Xeevei
 qEus8b6DjzkPxt5EJGZdiQLx+hqpc0phyUOw2Y7ye0W8XGTS4tBOQreBnakbL62L
 +A33+g==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dxvnd8usk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 04 May 2026 17:24:22 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id
 a92af1059eb24-12db37213daso4664253c88.1
 for <qemu-devel@nongnu.org>; Mon, 04 May 2026 10:24:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777915462; x=1778520262; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Adv6/yKji/PkhfBZbBSrw1Bp1P5n4obVUa4wQYWwDVU=;
 b=BuF3c1GocDWQGmddE+t7GjSeKMt1yrfYHh5TE+fq/Rj/q9TTsTf8/iG1mBZDMz8OJq
 Mn72KYC4BuQG4dfN7smTUsr8XNUi5ccGxffhj6M10r+W4bg88Bmxko5+usMBJwF7Nb18
 XT9abGc+T2DYqDJYk64KV/dR5fKZjG+0LsCoFGGh3MgkGvd9GPOOAuzjXzNY6pry9EOj
 R/Y0hxe6mF3fHePNea4TTvtL2oPTp94QhJ9hyypYxalVn6CAdhd0X7CpIGVvHkMRldkY
 Lnj6XxGFEabhY5dEtsliyLPxII8cVjfOoTT7aKR0XbjQFsiIruSHRxGKenACqa6NG9VF
 Tgow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777915462; x=1778520262;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Adv6/yKji/PkhfBZbBSrw1Bp1P5n4obVUa4wQYWwDVU=;
 b=Uu6Tz+fzr9sS0K4Po+2fj9CMOJnCrzBvrC0/X02KzVfBg/cgn4BTXli2xbhZ1vyf1O
 6bw6x3aSO3E9+l6BN1ytn/yOzVbd8oqj7Fzz52fNPbQD8WZm/a9zyWuH5q4KjBNW46ZO
 gcRQSzSDdBEwO0CUbnH1Qaekbc6seF+sLaYoQJxWQtpK6bGV0DJgBsiYOQkNCQZIuHmM
 B4o9HtoA5j/JEx+h12OG+lf/hMWGE8OVDTP1KT0dB6dOPIt4liD11Z83yEWiKLzWOH8N
 XleDZUloC8WUYBITDsCKBI1d0hxdzwP090xbctyEHioeJoxgLUqaP94eu3kM6/AZcypJ
 RKJA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8B9HHpm18NcxKr7zHByAQv7RG3c0XP3Gm6iqLYlxUZ0GudzwX/85jzimLhy/dX45Hc2hjqyp0m8SMj@nongnu.org
X-Gm-Message-State: AOJu0YwpbTbyYzCRLc9FFGIX1KwCVjd4M8xTPa1lNlrGtA/VvYgRWetV
 rX/uo+0e/L88LAa++OFECiaOblzNGLopcWznsT+zB2gaeCX0ooMDlckOt9aA30U0POJGzIdQfPv
 /2ffZF/ucfaqJbLdjzc7rruPpRwymUOa3E6FysiV5ZciWbNbd4fezJB9VXg==
X-Gm-Gg: AeBDiesWrzV3dPRS1lxgtd9/lFYn65b74vLCpOjPMHZ4+u4u0NzFMqGhKDZr9u4z7wl
 Ql6/NsxASByF4F7hic7M3Cc7I+C/kTo5ylFp0WGHy9/GX8Q4VeI5VSjUBOxkXrPbjOxM+i3lbFa
 OcOIzqcW1S/IY5EIZ0Bp1tyYe4kbbO7QtGDiXx4ghR/lksf6ltWRAayFneZUPX6qizH5X4TES+f
 HCpdUaNHM6+SgFDOWe16YsGzX3OdGBAvmf69QZ6yX1yWd/BsoM+69CfgKk9HM/0gkWmINtHQ7bx
 67W2uUwk96Q9Oai6rzwpsPjHXJLiWaWinAxvH787zafSLttsEHZEXm5/COPsJfAMTom5cWlggTm
 k9RWJ4vPmHOtPpnj0e3WIl9TfcCASmNJnpXXFEKoyfV3au7zkNVpeg/umNbK4+Y91uYX6BQIU1T
 1MK6vS0RoASXc/K7MRsB2v5Z+Q
X-Received: by 2002:a05:7022:6b91:b0:11b:7970:ea3f with SMTP id
 a92af1059eb24-12dfd830821mr5373699c88.25.1777915462153; 
 Mon, 04 May 2026 10:24:22 -0700 (PDT)
X-Received: by 2002:a05:7022:6b91:b0:11b:7970:ea3f with SMTP id
 a92af1059eb24-12dfd830821mr5373671c88.25.1777915461497; 
 Mon, 04 May 2026 10:24:21 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12df84250f1sm16633380c88.11.2026.05.04.10.24.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 May 2026 10:24:20 -0700 (PDT)
Message-ID: <88625510-fb99-44a6-9995-8a1eb6aae2e4@oss.qualcomm.com>
Date: Mon, 4 May 2026 10:24:19 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] docs/devel/tcg-ops: Minor documentation updates
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20260504125032.35465-1-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260504125032.35465-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: -iOhujzbJI8jV3wstIKYhiS33oFHTITh
X-Authority-Analysis: v=2.4 cv=d9jFDxjE c=1 sm=1 tr=0 ts=69f8d646 cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=3L5ZzdVs6ka8BtqcuKEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=vBUdepa8ALXHeOFLBtFW:22
X-Proofpoint-GUID: -iOhujzbJI8jV3wstIKYhiS33oFHTITh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA0MDE1OCBTYWx0ZWRfXw3akxcqfV6+7
 wiehoFleZ5t91P+FrzhHZ/bnCWY+KeRLQKmNjp8Wn3WOJ82lAdGjAOPRYMogdip39RBH4oy8pTq
 EqICGTJFQL2ULPIZ/GOy9AnFaXkATxy7Nd6cnuA1H+slN4ELD385AvUDukrggD86jl3TP1bUjTu
 /fZJexrOcxS53zNfMZ/wSaFpeN5RyQ3j+LAOk0/tj7DKcYMk+PNxfk9C6cUcetiTan+rhZDTZkL
 ZQHNCy1tGTIsljkgC3yI/YFP+EHH4zXI/Sxlj1r0DWEvETpsQCEjd8SdbFafLyOwEYivACIQjUE
 Vclfcm0wBOEajiQ6S4o0ZDAmvKGOQrBXfrmxZ4I4zAb7xGqjJmebD/jHW34QBC1iOQ49QXCeYM7
 QczMAFw2lksBJp5KSB3jLBH38iTIpTN7poEkHCZMHdYfgMKlokO1r3gna4YZWrQRguJ1hMW1zuJ
 LCpgz8rmGOf3bZPc6zw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-04_05,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 spamscore=0 clxscore=1015 phishscore=0
 malwarescore=0 bulkscore=0 adultscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605040158
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

On 5/4/2026 5:50 AM, Philippe Mathieu-Daudé wrote:
> Update TCG opcode list.
> 
> Philippe Mathieu-Daudé (3):
>   docs/devel/tcg-ops: Stop listing dup2_vec()
>   docs/devel/tcg-ops: List more vector opcodes
>   docs/devel/tcg-ops: Slightly expand on discard() opcode
> 
>  docs/devel/tcg-ops.rst | 20 ++++++++++++--------
>  1 file changed, 12 insertions(+), 8 deletions(-)
> 

I will let Richard pull that as part of tcg subsystem except if he
prefers me to pull it through docs.

Regards,
Pierrick

