Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB86BC43458
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 22:02:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjOim-0002m2-Dc; Mon, 13 Jul 2026 18:01:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wjOik-0002k1-0Y
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 18:01:50 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wjOii-0005hF-Gu
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 18:01:49 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66DKvPJE2483034
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 22:01:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 AXMScUxqap5kjhcIahQB25cd+fF11bcYm5XE0CyWb6c=; b=BmwjaBseZcVOmQiM
 O9JoR/4fBthvQD7ypDRvgyeWNt51JzUIkyoTFt6OMppDFzLKFTM9wYk8hIMR/oHC
 iWmvPnHMTAk/4pXEcdfLAAaU6i2MLINKEGEDb+/oD2L+/7rztJHnkY67f/a1C3yH
 u81RbPmxL+h/xTN7QUuzW/CWznYOWfZgKkKsi5iPfWZg/YgShTuAxiRbTgA/z+g9
 rcUDYIiETeJnFlrKUxwFAspkSC1bItkkcoYgdAgke+AjClJSKuwwLRVkiDuR3+aJ
 9UALQk91gbZcNfWB/u3PNufWT8Hk38panYqPcUKG3ghwo7PRZNBFquCzPEGn5l/l
 F3NLrw==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fd7gvg566-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 22:01:46 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-3823dcc1647so4696558a91.3
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 15:01:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783980106; x=1784584906; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=AXMScUxqap5kjhcIahQB25cd+fF11bcYm5XE0CyWb6c=;
 b=bn+kwTlmWn7mD2f+xlzMdNFNLqqSPubjnB5fS3lqbGU1GSglU1GI+Mst6fnhs1/9Qr
 TiQ45o0LnEe2pNHpznbTQ51TyGmWfotTS6aN8KerS+Fw550vUvw0otHZqMG/UXG1iJJR
 lZoawvpHKM5EEIt4vdCdSGVbGVT6OPMpmuYaBrR55ERCoCJull1WVq2t/Pi3dz60mY6y
 FSNmopxAJkldrDWMR1R4U/qqi0yIDNPxCFHP8jnRtuXn25cxXUKIj6XrKsrFvBgsf8ds
 H7oTtUneaQLADV/QCSV2W4g7TP0X09eex7+9GrEr0gdP6EmiJi6t3Ey5QiL+CYXI/Zmw
 G9uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783980106; x=1784584906;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=AXMScUxqap5kjhcIahQB25cd+fF11bcYm5XE0CyWb6c=;
 b=Y++br4BrLCuQ//UfVXNVbvqJ3XgOX6XMhq3UR91ftoA0cz+Juj9dPYExYInN4GjRR7
 OvpLINT5HdG64jlxP+nkYfZ/mmSvHgc75NS9ECKd2T42KQHRbeybNW/yWTXGtWrqDn92
 ZTm9a7+BgC+yVOy2HaU2kmIS3hM9y6PbHs/dleoBDN7j0HDJQRuCBByhnd73DAoH2zYO
 xVHrYMtqnqdaVZukJFzDc12gI+u2gOFqE/OSEWjOsQ2i3Ss3Jdr++VRvqAyUxD1CvtG+
 36ADuxrfF39qiFPdGxyZSvUXZEIsSnpsvwQLc5DtAnq+8Acvny7Q58sgT/z4/U4vJLEt
 g+QA==
X-Forwarded-Encrypted: i=1;
 AHgh+RowtwzCuN0sdQ9CjgDEGgSwWwPoikO51aEwWBDv4IPac9PUGoBmfxNzsweoNnKBgF1LEQmuEaunfmFn@nongnu.org
X-Gm-Message-State: AOJu0Yz9tLSv+u4Cm9dPErQi6mdMxH9T4DID+7U6LCYsb9n6mZMKmjuI
 YeI4xVV/VjV89DkO1JS/ktA1bIS2Q1FWVnScA2qdP4PwzSJYaXS5jv7ZQf91YFjDuklwYya7EHz
 RZHy8hpOI84fl1uHa57mz+eNZhOwhNYeXqioPLnuPtIIShitjANauJpCAMA==
X-Gm-Gg: AfdE7ck3R+CqXo/HfwHnENzGMocHcr3RDh8Qx62QeHlebX3ZmwzoL15WO1acLFxZnPK
 Cb1+/Os7mkqsHYtnQO4FLOokMIQIByDbfRaV2yhWpVCiaElJiUYlOUA0pOKMwnpZvEO59KOWdAu
 otjLyXnzNy+FsnCk3NT75m8BTGo33vD1K/FFjXr0zmdHvUbL3dK/h2dpZYfhAh100KLkXIXnkRM
 ejcBv7HWjKF5qHOm1dAXAIg1Md2bOzXtEX2exLe01kUB6NivmdRK5Rwa561swlndGDpKqObVh40
 TVX4cPzLn8q+L3oGljujMPaz/Z5ExBxpG2/ozNW8pyCk2VBMKWZykz0pGrOEqFp9olTvEpi1ZM0
 F1MCWyKMNdAOI57/sjm5vxpsYhQgK5XYGEvbizBOYgmlyMlV+5GY0QFRPiIFNsEb+VuyeY5OB0v
 ugRQc=
X-Received: by 2002:a17:90b:2dc7:b0:387:e0db:3d89 with SMTP id
 98e67ed59e1d1-38dc77c33a6mr9647971a91.36.1783980106003; 
 Mon, 13 Jul 2026 15:01:46 -0700 (PDT)
X-Received: by 2002:a17:90b:2dc7:b0:387:e0db:3d89 with SMTP id
 98e67ed59e1d1-38dc77c33a6mr9647926a91.36.1783980105587; 
 Mon, 13 Jul 2026 15:01:45 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3119d5cf176sm48890968eec.12.2026.07.13.15.01.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Jul 2026 15:01:45 -0700 (PDT)
Message-ID: <f27a66b8-0b74-4f01-916b-594bf4279d87@oss.qualcomm.com>
Date: Mon, 13 Jul 2026 15:01:43 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/14] semihosting: add callback to set error
To: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 philmd@oss.qualcomm.com, ale@rev.ng, anjo@rev.ng,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Palmer Dabbelt
 <palmer@dabbelt.com>, Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>, qemu-arm@nongnu.org,
 qemu-riscv@nongnu.org
References: <cover.1783973054.git.matheus.bernardino@oss.qualcomm.com>
 <df1607f5ee373a1ecaa6f88bb56fc64101d818f8.1783973054.git.matheus.bernardino@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <df1607f5ee373a1ecaa6f88bb56fc64101d818f8.1783973054.git.matheus.bernardino@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDIyNiBTYWx0ZWRfX0/furTUhMWbu
 wIu53zxBk4aI6lpg/BKzVAtZQWHOuukbxLg1kgq/iY4bNggRQDHMDx+pyQOGBXaIW2nlnrlQ+HE
 IiQ9QKDmlJbRwIJxWV1K4+XwOQgBBpfyQLVTMF8I1xV+Ou74DMPBvgBbm8kQRcz2TM8TWVXXuK9
 j3FrMW+1SB4r6+ScplX7P21D+7Ykk/YoCGwPRpHOgiFb8ahLAjjUUCxaT3TjeuN90bqI+xzMqGu
 9Aii9EEvOIi/t4DqdVuWBI+d4zYwmRWcEXemoy0zzfK0mzS090caH/fSw0YR6R5Z8+iKiaJqnW7
 gafLa6POO7LuCi29gnxZnn90ON7s3AULtEb3cEKE/KBL/4A+3U2ohuUxD9nmnVEw3fckLC6HIPG
 ZYTDPlEv+uqlkt5R77ofILqwAQARMnOrgznELaCBfIRKNCJRK1SVfOzcZyPGN++K9YH56uVfbIj
 YyXFukh1NqF98sH+Atg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDIyNiBTYWx0ZWRfXy3hOhSv5xeja
 EK1VZKnoW5/Wi9s8XdtvouxPHt1vBUQ9yVXpbbBLnVVP4r8mfwbdghfAA91noVLFzFdDN2e22qI
 BqUdFSP0/vPhtxVkdDnTUXSlb2gd8/M=
X-Proofpoint-GUID: sIAnt6kncIMSUxlGZFfYmrBIXO7h87jd
X-Proofpoint-ORIG-GUID: sIAnt6kncIMSUxlGZFfYmrBIXO7h87jd
X-Authority-Analysis: v=2.4 cv=NYjWEWD4 c=1 sm=1 tr=0 ts=6a55604a cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=KdzvvqdFADfKUjNgu8wA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_05,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 spamscore=0 suspectscore=0 clxscore=1015
 malwarescore=0 impostorscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607130226
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 7/13/2026 1:07 PM, Matheus Tavares Bernardino wrote:
> This is currently unused by existing semihosting targets, but it will be
> used by hexagon.
> 
> Signed-off-by: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  include/semihosting/common-semi.h | 1 +
>  semihosting/arm-compat-semi.c     | 1 +
>  target/arm/common-semi-target.c   | 4 ++++
>  target/riscv/common-semi-target.c | 4 ++++
>  4 files changed, 10 insertions(+)
> 

Is it used in this series?

Regards,
Pierrick

