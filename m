Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5108A606A31A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 17:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=W6nnAPk2;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=KKVk9k8T
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMTpj-0004rA-P6; Thu, 29 Oct 2026 13:22:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xMTpi-0004qU-Cm
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 13:22:34 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xMTpg-0000vn-FA
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 13:22:34 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69TGD3Db1143410
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 17:22:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 gTEFmPyDlt2EG8JUyjdgugleGJk9fDChgre8iNrb3K0=; b=W6nnAPk2/XwG2Yp4
 NufdExb2hutEJbVN7jRQ/0At2xditeArJq2mjSM/YauGJWTPCpdd/OFbRz5A5nNJ
 fOPosOvr4xfWgBBEcKZInyFyMGxdYDPGE0gduojtNENWPy97Ij8V2mmFJ2m23zfo
 vsxY1RWStHE4BZkpdQbulu9+FTF2FoKJWvPUHnXgVX3hb1szPu6CjRwWwH+ENI/f
 tpGQ1FWDR978uIUqr0or9jfkSkVr4wBFc62BuJWrO+hwQ+4Nnk7dcG7ivjS2Beze
 qoJtHvlPvm1gSjEgWZlVCnlQQLr+WKW4jEXZk1petFCA1dGJZuRBKrfnFT6O3yEt
 E0IKNg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hm76cheu7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 17:22:27 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93f3969a2a7so339589685a.2
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 10:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793294547; x=1793899347; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=gTEFmPyDlt2EG8JUyjdgugleGJk9fDChgre8iNrb3K0=;
 b=KKVk9k8Tboa3ZaDcvxQjtTOMVRO9nSobXLjYWVoN85yrIjfSE2zMXGCGh1RTioxH7a
 +LmDZuIzeWMIW0B7mLgqhxZ1gyLsAZtAtrMHDHP88Ypxgnjbu2MKrXPTPDvOvg0Lquxv
 U6pbUvAWlADKvKFjChbfwhKzd3zaV0CfcG9LAXAaU6aomAjmk9jF+ddXywbkBD5YSYCn
 FMYMNYzgbE2dzPjM9RudRtKpJdCQdDVT3VxgRjBFP61CxTNcY5lituF72Bv8uFR867nO
 ifHgmh11/JzrKH+khT6lBMYw92gPYk6gs7D1UW0BNbftNMMgtGPux81iFssuVtj/b82m
 oFhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793294547; x=1793899347;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=gTEFmPyDlt2EG8JUyjdgugleGJk9fDChgre8iNrb3K0=;
 b=qVp/Ij9VZSUYfd2HV/F5g4RqgwTGL6nQ0z1ptN04AjiRLbWp/CMF6hIylcQvsqpsfT
 j1mdeVE0Qa6uldXkyvKrJBz4IzALMUdByhKc2WMI49n2q02X5R5qZcV7RQsaOHLbNUl7
 4nrRH9qo+dAPQnQloBrYqMmQEZWNgPNJRtX79cKOjWWrx8kZ/uxMqViAO51uP/V6GN/h
 bCD4uYTWeCYBMTqjU/NzIFofoOrbJMBZ4ZSWMzR4UfrvGDl706sPxUIYvenKON8l3iER
 TCMa1zZPhc5tZt4GtDuV1KGP7xjHd8lQdJU2+g21O4laEugdUzxD6ae6KryhUcb+NeNa
 wkFg==
X-Gm-Message-State: AFq9FYLQ15MXTwDf59nebDWJSDZkzyCowfscvOZbAcEwcRMMd7G5EhNo
 N0BOcCf1Wkb6dGBrd/8CiRj/mhSJPp/br6dnj7uvf6AJ68gy6zOUPTgRiK8Ki+Ul880rzwYH7tE
 nZsOPYaosFrodSah8GkgmPsTwcWJPPiI8PtWWGOAD5jx2ECMTFXUQ1SI2NPJNwNmg9Q==
X-Gm-Gg: AYBFou1CFNDlGxtHZp0RHKrmjYYWwnYz1VRTnt4z5jF6zB9ymIz63wk1a46pGdZQziQ
 qttQ2duc4O1szwWs1jSLvvNhlitvGk/gZodZo4o3jz32hUbgOVEuuhhne0GFz5tz1d+gu8zzULQ
 cWzjpPE8PbufyKfa/Dz6gsg2AW2lMEcNnmxiwP9qzw6gedKp6B7zd2xU31FXkizn7oe3nw/sP7q
 XZL8RCXwYyBuzmWVhUREZIzAqe/aDEs6g/84UdmsyakVMHWrohFcmfJ+T+j91TNkowQGn31qBsi
 ArFa2gXpKtytm6COMB9JQEtqCX9BZS4U5RE4VAsZmeZU+3m9QGfi6jMpJcpM9y6BHbq3/3wMehy
 F9IbTVo4MIFd9Gl+ZbYx0HznaV3ZBJ8UE0mi7tGCYtUDf5YASg4TEzctDa/N2IbyNMCEA1n3mJX
 Qsy1CNRjLLOC93sy4ApZ3afvWI5NKPgiuA9j5tH49/UcU=
X-Received: by 2002:a05:620a:4156:b0:93c:c7c6:90b5 with SMTP id
 af79cd13be357-94408932147mr886308385a.9.1793294546737; 
 Thu, 29 Oct 2026 10:22:26 -0700 (PDT)
X-Received: by 2002:a05:701b:454f:20b0:164:8e14:4939 with SMTP id
 a92af1059eb24-1a6cc90e78cmr8243984c88.10.1793294063203; 
 Thu, 29 Oct 2026 10:14:23 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1abeabe0aa0sm503347c88.18.2026.10.29.10.14.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Oct 2026 10:14:22 -0700 (PDT)
Message-ID: <ae1dada6-057c-4614-bf59-ec60b1f89604@oss.qualcomm.com>
Date: Thu, 29 Oct 2026 09:14:21 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/8] tests/functional: remove @skipSlowTest from
 quanta_gsj test
To: Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, 
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Chao Liu <chao.liu@processmission.com>,
 Tyrone Ting <kfting@nuvoton.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Hao Wu <wuhaotsh@google.com>, Halil Pasic <pasic@linux.ibm.com>,
 qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
References: <20261029161310.2065290-1-alex.bennee@linaro.org>
 <20261029161310.2065290-8-alex.bennee@linaro.org>
 <CAFEAcA_UJ=QMFwdGtWv_wWhRyzoig0_0VC+T21+kFvzv9qasoA@mail.gmail.com>
 <1d76264a-040a-40f7-977f-948d4db6576a@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <1d76264a-040a-40f7-977f-948d4db6576a@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: sKmuFD-r3cLFAzM6va1t8E8hKWph6DpV
X-Proofpoint-ORIG-GUID: sKmuFD-r3cLFAzM6va1t8E8hKWph6DpV
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA2OCBTYWx0ZWRfX7Ao15L6ASEAW
 rWweMosA102GvDNYnjSoVcB9iBH996/WrjBLohY7oqEZVgpFQ0Ll1/Pl5YBvf6tf4B44AKCWHSE
 QtoF8XGT/YZa0eJ2kSqzfVal01oGxkE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA2OCBTYWx0ZWRfX15xWL2JdkdoN
 CS1gupyEyqvpSdnxz6b+cn4GGpE2gc6v669EFRa43hJhxEIJeopjPfVsec17fEi8pV7GEmoUrwv
 b2CcOwp14U7u9H2mSStmSnDs+S1QtTbVYDdfUmTg/xthrfIvRD2jHCIw35AYbciBq0gkFCpbCJQ
 EpU8pzoaEFh5j1f4BSDrBR41/vEaDvjSS0bpHzUthS/fwSvwzc5oGJzuLbum5QjY9EjjjC8v21P
 HpTwHy1pyTopFiKSKVJmvxCqGmzNW601Ndsr5jcQ62szxgs2lMykXMpRLTXXiQz8LNARBTlhpf0
 7i610hkrNgiTcPnxXuMr1qzG7kPyUHObN/WOn21R23vbhECBVpvMkxf1VJ10zEbvKMTeOut27dv
 pDudrnk36ngRqprkAAqeVzGanLsZzA==
X-Authority-Analysis: v=2.4 cv=NPtAaE6g c=1 sm=1 tr=0 ts=6ae380d3 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=20KFwNOVAAAA:8 a=FRSEYCzRAAAA:8
 a=4Y4E1iENGhMKdSAYfzkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22 a=cvBusfyB2V15izCimMoJ:22 a=H4N_Y-AU75W7NKDNhZlT:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0 bulkscore=0
 suspectscore=0 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610290068
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, KHOP_DYNAMIC=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/29/2026 9:05 AM, Thomas Huth wrote:
> On 29/10/2026 17.38, Peter Maydell wrote:
>> On Thu, 29 Oct 2026 at 16:13, Alex Bennée <alex.bennee@linaro.org> wrote:
>>>
>>> The full quanta_gsj test would have caught the regression caused by
>>> the WFxT implementation and isn't that slow (<60s) it needs to be
>>> gated.
>>>
>>> Suggested-by: Thomas Huth <thuth@redhat.com>
>>> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
>>> ---
> ...
>> The other argument against using quanta-gsj as our test here
>> is that as discussed as part of a recent docs update:
>> https://lore.kernel.org/qemu-devel/20260627063208.33642-1-
>> bin.meng@processmission.com/
>> it's no longer supported by OpenBMC.
>>
>> I didn't get any response from the Nuvoton maintainers in
>> that thread, but I kind of favour deprecating the machine
>> type in QEMU.
> If nobody seems to care anymore, please go ahead and mark it as
> deprecated! We can still revert it in case someone speaks up later
> during the deprecation period.
> 
>  Thomas
> 
> 

For what it's worth, I also noticed that this test tends to timeout
randomly, even when running tests with -j1. So we might observe this in
our CI also, by enabling it by default.

