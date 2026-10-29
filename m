Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B84C606A31A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 17:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=avXTiSQU;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=DEF+cfyB
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMTmc-0003xS-IZ; Thu, 29 Oct 2026 13:19:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xMTmZ-0003wq-VS
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 13:19:19 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xMTmX-0000aQ-Vn
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 13:19:19 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69TGDPAm594494
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 17:19:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Tht1Rsk5z45fecKiWhmS76E1tOkZmd/6+3LCXJP4wVA=; b=avXTiSQUHVE2yH1c
 m9BWhfDGiE2+8agBc2bVgXdB1FCwCk1tx6vcNZ6il4W8kYRUsOLMhE/AcnKJCIlG
 UoNOf1DHaK+uInrlIHXl/u3T+jPSEvnCVUwoZiGSA6R0dV258pcSwtc3HDlMePJI
 +j7V4w3PqjT0rz6A9MvlOaBgm3KPfS/tSMTBCZN4Nj4GziZZ/48/3KvQdAzFjOhf
 U1LMvs8pZ/n19/tw4eSwUczvOarB/U69WeV7bmjHSOWyXiAzdg9Ctal1ycwneoQl
 qpSMbLuALUhafMEpXLtUshDekSrNPIuUbmU6N+O5gQoXf8WiPKJbh1ugTGAELB1+
 NbV+yg==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hkut3knnn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 17:19:16 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-36637676140so3337987eec.0
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 10:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793294356; x=1793899156; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Tht1Rsk5z45fecKiWhmS76E1tOkZmd/6+3LCXJP4wVA=;
 b=DEF+cfyBnS8MZ1LDmzYpdg4T8LxxNptwCIdE8C8tBsk6E/XU1V6NImpZvX17nhv1p0
 mY0SesO1TjIx0E5f8Hnp3FjBJnanPckbnHzyhnggBn7UbwnacrhSGrqMpZHUX57c+Nmj
 UJC/iZVFbXbV3Dyx1kLvGtyA9swt9c9whAZ8tX9cC7kohO3qtzuKiKm7BJANRnOGuUTo
 Q6AcPavT8czDKah4n3BjdAhqXxI1Bzi1arM8Hw/Zh/QUD6PYSPO9Bqksg4ujLascHfZi
 WDfRXtx4xVIclSIxHDgIZiLl1wP91N2H+rMUg+r9SU5gxsx5cWaFyf3DynQ89dNshGD5
 z5Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793294356; x=1793899156;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Tht1Rsk5z45fecKiWhmS76E1tOkZmd/6+3LCXJP4wVA=;
 b=lh/Udwy6eDNgyqZbYGw3Xhhww1zSxUaD3z4Cyuhb9fdyEYDZhfzx12gMicO6iZNvQ+
 FYWCzQFHKFRWzozNdrmvBZ/7M/RvtFSD1dMVhjXEyB2qyaiOqPrNWWHeaYgrd8GVd/Yb
 CDTw1HSdxSxWq0SWvGTnGQQnmbDSCYPQvjVsn1eFrNH7cSzaKV4Th9pVfdhGESxdL6F2
 FVMQx814o4KnBgHLCxfUcKeoL6z/mCqbflbJM04OAxao6y9jbxxK8IrDDZe3VB6M+gqm
 YNyNNifECtSKdS4NO7VeXCL9LwuuxVAu2kE5pRxEPK8yq10ikzSEv9qwG7DIbubPJq07
 GNfQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxR7001Iw2ldjB80uNSd+8nJCXgTg5ccu41YK0OGzUoprWR4s5VxYmBMmSi7NTgfj/hfs7uSZde+avQ@nongnu.org
X-Gm-Message-State: AFq9FYI6tUI8WLvfmZIGKiLmzC8lzTA7m+7svASBHH7tP2XxeZlyah8O
 Wv7PPb7F6tFuv6ATVs4gGdohsIqJYu0SecfXXk1p8/gJNzB2q2YymHlRfOtdgy+3qflwy+o0PtQ
 kBTS1iS2GI1ZHPp+WfntFQ8I8GN2hoiMSVK2YZLWXN1vx7LTu0NLUr+EoeQ==
X-Gm-Gg: AYBFou2nfcQZBFjPWQ73SsLkVCdO6e/t/Sml5lU0O62EqnJ+qKvR3dXNNzjlw9Uscf+
 GQdreBcwafAOE7o8Q3IwozS85DMbSfYjNMLmHb0FGGwYAGJHaY+RaMcm69TyemK1jmNQWfChhMr
 +imVKfIYYPqnLH8EhF5xEDOzLMgCWI6/Pchb+ddDm70Tgq4cDX7/tee/bx3i4fRS1HLw4NkQ9Ro
 vEzm3yTNNBWY8eJxr4b5scSDhgJZ0AkQw250S+Dy/Lc6HgaCZoAb/09KMdKXkTaOHLhvAafhdj4
 5qSnHsTfdzMXyL+lg3L8RC72ThX5V9vyHp+GvxyTW/B//BYG3xgZq/bb8PSFnHBV0lifdbimcu0
 m05NDHRcl2ZOTBuPRqu2C9aZQZLv6oRkDPpnub9v8o7exciYOmLLAKCyVUOaUyUcBh2o5UzWCyy
 Ro4eWi0fh8h3e/3vR0HMGyI5nqnDw3wtSk4HODEpCpuMI=
X-Received: by 2002:a05:701b:2402:b0:168:6ad8:e88c with SMTP id
 a92af1059eb24-1a6d1bbc137mr7292179c88.39.1793294355570; 
 Thu, 29 Oct 2026 10:19:15 -0700 (PDT)
X-Received: by 2002:a05:701b:2402:b0:168:6ad8:e88c with SMTP id
 a92af1059eb24-1a6d1bbc137mr7292148c88.39.1793294354975; 
 Thu, 29 Oct 2026 10:19:14 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36a4108c56fsm482362eec.17.2026.10.29.10.19.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Oct 2026 10:19:14 -0700 (PDT)
Message-ID: <df083628-add5-42a0-8bfd-ebb71b88bc8f@oss.qualcomm.com>
Date: Thu, 29 Oct 2026 09:19:13 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] tests/tcg/mips64: Test the Octeon POP instruction
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>, Aleksandar Rikalo
 <arikalo@gmail.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>
References: <20261029152009.19812-1-philmd@oss.qualcomm.com>
 <20261029152009.19812-4-philmd@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261029152009.19812-4-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA2NyBTYWx0ZWRfX7+wjXWVKg9/a
 aI37QsCGLhtHbZHShdKjfoGjAKWvNvkJyQkhK9tfc89E0FGnyaLf8WaTufhbWALvqR3LYEkEu+c
 ZUBMS3TxkTXziQo4hY0Mjq3HYZr3z30=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA2NyBTYWx0ZWRfX7RfdrtmVavOp
 Cfe2bka2apfjdbff3+f6Cl6FsUWUl/Dug2TAOvzZ/g+2iKDoeSrJduhjCnfHUOc3g+DD4wGT60+
 uP8FXknYBNZW44UQZv8JflVjBvxOInjSsMfC5UVpg9mNvYrr2DQkRBJeoiIvs9vsD1KiQibK8Iu
 qfEXYNd0+3puTfYFl2AoN/oXWs3ihXGp6iLky2/7BDq76yLj9HNh+pS7/ahSjH0gmIFhxn1PKTc
 MA50TmreyF5mqZ2meH2Zs6BgjXoreP8vyby7/WQCKMwyF6ytxBve77wVkJ4xd1C61DDwFyliGmA
 AuEw6/ADU2HBPrA0PKD81uZplfow/lcTyTBT1gBrzk7sf2OiyK0L8wuhdPyYViyoATPeIHkpNgH
 0Z+DwetYv1htIKTk516h2ikBI5lN6T/X89Ke3B1Jjo/23SoDWzizYvxSIY7SijqJ21CmmNDS7od
 a6sgDn7m6AWYvtD9Sog==
X-Proofpoint-ORIG-GUID: il-gGK-d153f8Y9zM_w77FmavSSf_B1q
X-Proofpoint-GUID: il-gGK-d153f8Y9zM_w77FmavSSf_B1q
X-Authority-Analysis: v=2.4 cv=HYSB3SE8 c=1 sm=1 tr=0 ts=6ae38014 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=ZHPL0eB4cbTO3u5cAfwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 adultscore=0 suspectscore=0 clxscore=1015
 spamscore=0 lowpriorityscore=0 impostorscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610290067
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, KHOP_DYNAMIC=0.001,
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

On 10/29/2026 7:20 AM, Philippe Mathieu-Daudé wrote:
> Check that POP counts the bits of the low 32 bits only, unlike DPOP.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> ---
>  tests/tcg/mips64/octeon-insns.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

