Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3172CD98ED
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2026 10:37:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waA7M-0006NJ-PG; Thu, 18 Jun 2026 06:37:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1waA7L-0006IY-ML
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 06:37:03 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1waA7K-0008SU-7h
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 06:37:03 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65IAEX0g1511517
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 10:37:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 KpYEqVmWNXbqJ40MDaDm74zg1UA0Si43LSfMTcVK0mk=; b=bfgEp2vlZfXeV2gK
 yLwc09Uyb70M45WGEeDaZw+lgwXvse/JRmWSXEtiVcoss/3QIGV3QrDaI8iTp4IO
 YSpkIiSZU9Rfw/mKWiGQrEOcceS84VOgzMv8ykTIE1/4BZWCyTSQ8hyzwQD7DqgF
 dhh6F5l5uDO4ezyS7tyk88+q5y7HBQJmLYjplA7G7uUW/nOm/p0E/dcWHXpIcOhJ
 DHt1TRMuJUviZegCeAhIAuRPhKj6eY2dvXrgWcAxNQ4q8kWs2T9GWlPfcGYs/Spn
 nJKZ80O9AzpuPzA1OfV8qkXEwUOER1xbwQ9mx6xEG1zhIX28dQcsUXmmCxvTAXVL
 GZlCpw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eux2jv52c-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 10:37:01 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-9158e75cbc0so151767785a.2
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 03:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781779021; x=1782383821; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KpYEqVmWNXbqJ40MDaDm74zg1UA0Si43LSfMTcVK0mk=;
 b=jkzrFMLiLTKHw6/TYNg+5gjNGR3EKu404zv+I9jDVy3dCwEQiVA8JZai13XJN3Syht
 mnr50P1MbanI+CBo0zCMt/WORLi811WTjO0UeWe6/nRavI1ylx6aSMn5GTzeIQSHacP6
 HRyN2HoXkLleNs+DxyC8iWt7saKZNI78LfWA/FZfrUcefC9S0gnJYWInAHUF9h+lz4Fz
 Zz9/fZLYQ6foJ0VYJ018WNn7oBrvs0C8gSHV4jchDlegPKB9aoWrS7Zpv7xGzGDD3svp
 XzSa01E3KU99mhA8X9bIOpXql1Enzyf1KX1dm70iWF/i3/1Eud5pOFtPHuLbmoYO/3M0
 mzTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781779021; x=1782383821;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KpYEqVmWNXbqJ40MDaDm74zg1UA0Si43LSfMTcVK0mk=;
 b=TohYcnyhZE8kSaFEnQSYXKIpxmdsOhgXDuKElvLK/VBdOjVfIoNX2azOJvn660AWOk
 3oUE9ZCj+txYRyqok+NMpjcBB4rYVb9lyTctpTplGa+r/xHD6weAqEHErs/F5CSdfXTq
 ayxA9WUguB+BpioWnea59qFBID/vBXMRwGIy3luQucjx23OgZNdeXXo4gR4yQtCBdHKP
 ijU3EqxJ3f5rjLb3P/SzgHmzGPag7Mz0MPo40XgS0ZwhJ6tNW+eq9TJenBdhlKSrqM0C
 jkNP0zZNRD9qu2JethsYWW3pVD+jDAKUalsfoZJI5zl9bnPJZ90awdjOpzAywRPZp36j
 5Vfw==
X-Gm-Message-State: AOJu0YzgoZh0p/8JetYX0JWPwGzutQySU2AqzfYjj+AefQBe4jiJBMUO
 w8bTpETvgbd3hBnRgeILbR0ZtXiT9rYCFNSfeOpkAehZV8foNFQ0himaKA3JyEj8ywCahymF1JU
 B/KxhDY0UaaGQjG8kcWvJGUWFUGz5bvivVefyOtIMsS2ITXY3N9m7IGzqrScsVdGqHw==
X-Gm-Gg: Acq92OGmhoaeq6DAJHOZQfmJxGRdthowugHx6n6fSO+Ds9g39F8ts1ENqCi77KaR2FP
 cjWdE9f3nVnBh1kTpbfhNeGjqzpEVEYPgaWPP8NS60LFmuQ8t95wEHecRWjPPHjsqoPZD+4nPzE
 mZ1zDF0zIflEoyaJsag6z2VXI7hfNzk8ShF4Wqyv8VuxkUrX5Mz4ukQie/Paf6EPMJEHIq6/HGJ
 PL2xjdDytll1h+ockQglI9Nxy7kbmpElRGnndQOGQ2VlT8aUPPBpmu90iyWO5S7+iq/xbYPXvWo
 3R9RSvHiillRWyD8BnMLFEUHmh3AcMpkIn71jPLTLfbbMLA5qPb4b7oMmgYOP9ZD7wnG8tMp/3v
 sYWolAzikTYhJxYHfqI+w6X7fyLINo+xdhi7tkdfIQGzv/rdbVZpI5KiLT38sGg==
X-Received: by 2002:a05:620a:1a01:b0:915:e670:4021 with SMTP id
 af79cd13be357-91dbcf0e472mr1156724485a.45.1781779020722; 
 Thu, 18 Jun 2026 03:37:00 -0700 (PDT)
X-Received: by 2002:a05:620a:1a01:b0:915:e670:4021 with SMTP id
 af79cd13be357-91dbcf0e472mr1156721085a.45.1781779020223; 
 Thu, 18 Jun 2026 03:37:00 -0700 (PDT)
Received: from [192.168.69.213] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49230a8ebe3sm195110365e9.11.2026.06.18.03.36.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Jun 2026 03:36:59 -0700 (PDT)
Message-ID: <69512004-8d71-43aa-a2ca-5107a324d06d@oss.qualcomm.com>
Date: Thu, 18 Jun 2026 12:36:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/6] system/memory: Constify various
 AddressSpace/MemoryRegionCache arguments
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20260616020359.18627-1-philmd@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260616020359.18627-1-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDA5OCBTYWx0ZWRfX0Xj2I6l17LDC
 4q++T5hkErL91a0CrMwQTWRdYsmpMIBXepmXdHnqPX9+ftWsCU4MwD/CbYsuz6H/Ak555X9u+hj
 TgEL3G2/87aBikSpZeSrJQPPjYmLyzkvnhEETfqzY6BgCIJxES4ABAxY9Crd3+WT/Vrc5SAv/Y2
 SoVj49H76XksYrJPWptEmIXkUoDZETMN8R/RQgP34RFWNEgnkDbrHeEvu1UzdC2+/FVidrGpJYc
 Jnv7eOPk1MUNfSZzVYTDvOW3J9AcfnHeQwU6txvH2QVhdXcyXiJWpnHr0tAUxMlM12Qy897Lyjf
 hUFpvAtYbAtdfZINf0X2m9lSTxVEsntjszjTx/Jc2AESuJf4U3b9QN/Wn65ur13bHqmA/sAZQyZ
 y3nfQpJJe1nuASv8BbZBXHmUCkMb291qbGb+EZfqjOMcOoqJnY6EWRCm5/xm60J2/wQYsOMFYmT
 ybd0iWox4fSpvWk3Oew==
X-Authority-Analysis: v=2.4 cv=Fsg1OWrq c=1 sm=1 tr=0 ts=6a33ca4d cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=ckzjz2HmQZQTp9cpXWoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=zZCYzV9kfG8A:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: vZim5fjehPd64Uy5PcJFUtGUx1au9CQj
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDA5OCBTYWx0ZWRfXy/hKEjg8ZOIE
 m30YuZT4tJIdY5Cv7rlQ+7d7DpJLzswlTHIl9AUGbfg3ikfoGwsyZjN6L6v1g+cABX4QeLpbbXL
 NimET1klHbx9QEMrp6YcoHfHcnqHZhk=
X-Proofpoint-GUID: vZim5fjehPd64Uy5PcJFUtGUx1au9CQj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-18_01,2026-06-17_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 suspectscore=0 spamscore=0 phishscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 priorityscore=1501
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606180098
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


> Philippe Mathieu-Daudé (6):
>    system/memory: Constify various AddressSpace arguments (checks)
>    system/memory: Constify various AddressSpace arguments (flat-range)
>    system/memory: Constify various AddressSpace arguments (notify)
>    system/memory: Constify various AddressSpace arguments (cache)
>    system/memory: Constify various AddressSpace arguments (access)
>    system/memory: Constify various MemoryRegionCache arguments

Queued, thanks.

