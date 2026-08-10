Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FB59C5AD7B
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2026 18:38:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtUsi-0005zc-ND; Mon, 10 Aug 2026 14:37:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wtUsh-0005zP-22
 for qemu-devel@nongnu.org; Mon, 10 Aug 2026 14:37:51 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wtUsf-0007O7-L0
 for qemu-devel@nongnu.org; Mon, 10 Aug 2026 14:37:50 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67AGs7bp2237536
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2026 18:37:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 NZLbxbKDeHnbOhnQlfnDyZjZWN6ksraByviz57vBrH4=; b=T4Vgsy1mgSqqzeOw
 f0lqJ9fGMVpKToux1f1LGD0J1YVwF1lVr4WmmnYGrk1PGod51gnq4Qj8WbnetpKI
 Whz23KEkGZrkDdNdtsTfpve9n8L0QB9eWCMZC/fLMsf8ggLcbSdGm408TOKhXfaf
 sAKswh6qVJDQNhoTRaRH7WMrw32LMlDn9XF1i8ZEU5KzlkK9CgPFvCWdukGsrUI3
 o/PGjWkbnAQVPhd4kpj6HSWQSEIrmkXSJtvpjDUiWom5yYm//12+jR3dzI/SJPdc
 XteRk4NHO9ojLbf+afpQb48WRrvyp2f6IlxQrGZe80WmL3YqxFCanJj7XodKzUMP
 cAbo3Q==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fyjjtge3d-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2026 18:37:46 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-c89704da8c7so3584738a12.0
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2026 11:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786387060; x=1786991860; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=NZLbxbKDeHnbOhnQlfnDyZjZWN6ksraByviz57vBrH4=;
 b=LOvoi8jhaZZLug4gMVkA+7WB3+UOW95KuRqK5y/zW0UQPzPtYKpNo4+uy0Uin7WvM0
 JqFmAD7D7orot/N/+pYWcbD4Lft3AzlxmkYQEpTWC7Mi2Y7a3rz2KUMiREcO/mpfSfCz
 MV+iGhKDI89D7CDmVoTzgvX/PIzg9Q+E5HvLRMNu9YGCMD0dDVwfK/47cFhiJsA6L9Dx
 Frl+oHoiSTiEjldVzuVFzyLQ+nCGcI8+OHCEcNVJj4MiVSkz6oNt6sx8hOD3o1mLrk5s
 dSjkDZkChyc6iR1dQCCVvRz3KhDsUiQVZs3EMsDQzRXPM8KklLg+slTxJioZGS3subMp
 nz7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786387060; x=1786991860;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=NZLbxbKDeHnbOhnQlfnDyZjZWN6ksraByviz57vBrH4=;
 b=FPg37h98lkOeG+v1SsXlKnffqUWDmnXchd0Vbppga1ZAfza+osiInJQ/cZGPQUn9kU
 RZO7TJMPBkoE3VijUkhXVesT3/RtLqalIONcu6A7aRlqMQbfNQlyx25QnkimSG0AC/AU
 dvACJlju8N7StM2AKSPbMAEdlao1PZPG/Xkz6oO/JiIBkWbtLE4ceKjnhDWssvUsNFu7
 kzZl/A356k1HAOmY2Deepnen1PnoPqBHkkb1CvG62A4AnieMaTELyDVtmFaAdTtspWu5
 77vTXtd93qknDXOl8cpHCb0HUqVBHjCj8xjWJgWltO+DyQiMb1dX8qxgYHcsBWzx0AnK
 u1Fg==
X-Forwarded-Encrypted: i=1;
 AHgh+RoGod63iEBE3gY0N3jButlj1JdBoy84Gou6lQj2+qkUy/hpLNuFoeWR4A3D75YXYN35w7VIHXqQOQxi@nongnu.org
X-Gm-Message-State: AOJu0YxYNIhR4XlBdjwTGggMlz6NYCD+6LpPqQPnFwUJJgq4bOG/V3Y+
 XUuaJyBu81WdlGHUcZF7EzlzTWn+NyteKT7gq+TABaeZ0z9RGqKNDzaXIXVdjRd/xIisi6fwyp0
 mcZBSMlASrpoLlSt9czsPfnusbgvN3lhUA27IsvvFMnun57k7ZHMvLQfETw==
X-Gm-Gg: AR+sD10zhSkf7DyVh+z4XavhGuwX75inzAALLZEKIc/7yosI/PTF5qmTlS7KRmTXZSv
 YSQgbXmTeFMEk/mvdrVQsLRbjzAhiX/i39lBfjv9BpsMK3fyTO1GL2WBuzJlWWQUXCCZWLkB2Ho
 lxmx2ifgropvNZGqpdxVZ1C5ATCjIL4VMWBmZMgekkfpYdfvPDDER/AQ9OT8yz9obw3+CRp7oEB
 mZaJ8CEbP6rlbMrGqb+oWv+XXYCye020Lz3dMojbCBuaD3Gtei9lSXgvIkwBh1vF9ho4fSKttWd
 RD3HsyPj4EcAbsyYZJQtILe2ij6OsrvgCWFi6TKCg0oSdZjTVwDXMlOvJK9u94a0C5Ylh+XX+ze
 0hEt4iX9IPGkgFjMoUHlBoeUUPQp51D+58f/MrH4cdRxh31VL9xxBdGnPxCwMx7gEB0cC
X-Received: by 2002:a05:6a21:4a89:b0:3b4:61f:1fec with SMTP id
 adf61e73a8af0-3cc1a0bcd18mr5265542637.2.1786387060458; 
 Mon, 10 Aug 2026 11:37:40 -0700 (PDT)
X-Received: by 2002:a05:6a21:4a89:b0:3b4:61f:1fec with SMTP id
 adf61e73a8af0-3cc1a0bcd18mr5265490637.2.1786387059966; 
 Mon, 10 Aug 2026 11:37:39 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-315bec2ec20sm54145573eec.28.2026.08.10.11.37.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Aug 2026 11:37:39 -0700 (PDT)
Message-ID: <50e7e3ed-59dd-4e72-9eae-6a98f5205949@oss.qualcomm.com>
Date: Mon, 10 Aug 2026 11:37:38 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 7/7] tests/tcg/hexagon: add HVX tests for vabsdiff
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: marco.liebel@oss.qualcomm.com, richard.henderson@linaro.org
References: <20260807152241.1576334-1-brian.cain@oss.qualcomm.com>
 <20260807152241.1576334-8-brian.cain@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260807152241.1576334-8-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEwMDE1OSBTYWx0ZWRfX01QPrYGnTaJA
 ZSp7kogyunu4fLt9WkCJKZ6x2P0wExcg6ikObQXj78KZn3WNmtt+RPOoH+Zp+HwVxtvx9zIs8Xk
 qtQGN9Ki1aOM4b6oK6zMGObMWKjD3i5N/GV6fJSeh+F3/pPWFcCoImmFKUA9Ti+0MiE+7dwBS14
 K7F0ScjUMdfQJ6NBc2mSX7qGgkruB8J/YbQUeP+VxKG/Igiw5OIGxZy95QnItDFnEzvHgzKGP+7
 N5aEyM5CaDTqqV11avTt/fVUbN1XH5Ahn3tFTbqO2B92D/E1+HleSDgNbHf1bzRgJ4IO2ikMGtM
 Sg/9KBBq8LUdAFLIcYbfy8ZqL1Irra0yFuGz5QpgRgBlYZUPLw/DfZsSxK7+xKd4P46WAs7FujT
 JDkdXbghiv9ajr9ec9GluG1os48r9pDctx8ngXZ9Z4XFlvn4wp0+4zltqEvW82Ju5JL3avm+Dzb
 6/V5qw32wBHWeaodZJA==
X-Proofpoint-ORIG-GUID: Wu6SzYezIRGVGwbhrV3J-uPKTqXCuVPA
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEwMDE1OSBTYWx0ZWRfX5F+JzEpxmPkh
 yWGRnhVx49Lqm9Bp/FWafq+jF4k6BJMUZGJD6+nCVJmbOfIb85JCMB5JtI6jFO17La6VnUyrCkF
 U69NHrF8SW7PhM/cPxcdPcS11DyAe2o=
X-Proofpoint-GUID: Wu6SzYezIRGVGwbhrV3J-uPKTqXCuVPA
X-Authority-Analysis: v=2.4 cv=JsHBas4C c=1 sm=1 tr=0 ts=6a7a1a7a cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=p202jHHaa0YgEzqyNK0A:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-10_04,2026-08-10_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 adultscore=0 spamscore=0 suspectscore=0
 priorityscore=1501 malwarescore=0 phishscore=0 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608100159
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

On 8/7/2026 8:22 AM, Brian Cain wrote:
> Cover the four vabsdiff variants.
> 
> The expected value is computed in int64_t to avoid overflowing the
> source element type.
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  tests/tcg/hexagon/hvx_misc.c | 33 +++++++++++++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

