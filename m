Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86610C44507
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2026 04:33:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkaFs-0008FO-HY; Fri, 17 Jul 2026 00:32:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wkaFq-0008F9-58
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 00:32:54 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wkaFo-0007np-JN
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 00:32:53 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66H33u2E594987
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2026 04:32:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 0QJ8U/2qEzyw1QoYriTA303Dma8AmM3n59AGrVtis5E=; b=X7YJh+S2msFMjOlt
 VP0Bg19+delVcrGNvgW+xr2Mnc9MIZxreSrORUChTmwoKV6/RrN7Lrd2wfrlsrg+
 J3DEp+Q9Akx2HvvobvTo6cnZkDg5Ra9TgjnSCJhS15P8Kn4n9QZ7yPwwCoVwzJoi
 my7Qv3iFwA0QmzD24MEUPNGTNwXEwongFHiqlkAnMr6e6WckqTW7RD2MA2uAebK6
 sUeM51IL3q4lDZhvflOKTF4CvobETG3pAJDP9k4qz8Ckcv5fZGsaJHAV7DAKYmCe
 JTRuWrH2xLno0KfYKxTUjAXV7rsXdm+Evkr/qurUUJhUGUobJdUUyvDOXp5du3g0
 Gpl0XA==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4feym1bbuq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2026 04:32:50 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-3811279d51aso7442561a91.1
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2026 21:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784262770; x=1784867570; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=0QJ8U/2qEzyw1QoYriTA303Dma8AmM3n59AGrVtis5E=;
 b=Q2RirG3PZ12OxKuvlgfCYjt6EqaJWg4QNkNCFNXjjWLrlvIub3CXaFN4xfDSvdr9nE
 f6PETA6wHJi48E2Pk3+lKLIsHgO/zd29BV0ePP/6XJe+ZSDF224Wlp+IThlpjDE8uG62
 LvNC5GCJiSajS5khZSIJR+vcQuoCEwkc/wnprVG240bbk4a25IGZzSQNdtKh69ufbBvy
 wqNchrcmoRhn9x3vHtjxpF75AiLngaeO8zYjgnZrQzFOFaSsPZQo3SDEjpikJA0ydQ7Y
 pdZInPj9WWny9S1sVXZxcBWeGdArms9gQHiqmmbfkf3gRuy2kw44o73Dd1B+6U4KvfnV
 y0qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784262770; x=1784867570;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0QJ8U/2qEzyw1QoYriTA303Dma8AmM3n59AGrVtis5E=;
 b=MaIg91NnY4hMzWfXJiEnmYdEAN3M7ETWErhyWMEueYcNbK5w3WPZMECzAECWSKeiYB
 oLcwrxaGBmR4ALK3vvKf61TX9qK4LGGy0XNL2aT9mO2f+vr1jLb/jwOig4Fq/My9ks/T
 CDHn48qSjKa7dWxuKTyqfbwXdnI/7e2M84nkbW8lrY+76FYHmm9f/Mx23AhWf3W/IBvf
 jW7irWWC2EGsIMtciPUlBGUOh8lfKw4m90bKBZhjXlXsa+iMgYd4N0+cQlOUk4XtSHHH
 izNlCKnrPf0Ljos83a/yOBwZg/lFlpcUqRq4Nfmg/aroBHpkoVvoadi4LXG4nfM4QbCB
 oWqQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RphfzHUNnWLIcdAFGdHqxM7jUM1cqcroH3CjVg8upEqUUZPtzx+lJCAeOI/z5m0Nq20TnFIkpjH4YKp@nongnu.org
X-Gm-Message-State: AOJu0YxU/CRcF9XAooxJK1p5DISLuuS1WbUljfjYW1kaYwpGqWJXmOzI
 7XhU1/J7yCgCREmc7dw+51uc8F8eKH6U9djq5HsWN8UxUmz/WKbliolSt7FTaeKpEndSNyWIfLF
 NoWohRorrX3FcsRuWi0pZ78OuC4CpP2PzMjP1jlQyfhKoKO5EoYMUCNDU7A==
X-Gm-Gg: AfdE7clXSG6HWz4V2Jm+meO7fGf13XohZZXG87ic7yOdF3liDJJZuiPkcP2xLmj4gk6
 ErRdANjExt4UJz2lyRA6Xff9C1QBrLZNzqn4vArSarmuy+rPdy2JmoE4ZH+hPfgPWw4dAA9L1gR
 761t9YvIeK3aJiA/LKulGO49VSzbVcy56p5f5qpcw6r7IuO0VE1su5LynqyplNvnj8JJ5X5owxa
 M4vyd695CrMtTT89m3BhcaR1PTlh3vfHhY+eEwtqLFKld+coymDsClQep1gQSuSXEO9F1S6e4aD
 BzbSbWXpoxKAhp665Y36Zv/Jbv4lugWo+7UG1hxAscdUB77HD4nLlWPR9qfzrcPr7ZUbXGRC7kB
 8q9tbdTne6VelvKbLeTNc7QbRvIthrmGA2OIw0CUZdhqQkAPgPW5rtOQ=
X-Received: by 2002:a17:90b:17d1:b0:38d:b36e:9824 with SMTP id
 98e67ed59e1d1-38e4b5458dcmr862833a91.20.1784262769684; 
 Thu, 16 Jul 2026 21:32:49 -0700 (PDT)
X-Received: by 2002:a17:90b:17d1:b0:38d:b36e:9824 with SMTP id
 98e67ed59e1d1-38e4b5458dcmr862802a91.20.1784262768880; 
 Thu, 16 Jul 2026 21:32:48 -0700 (PDT)
Received: from [192.168.1.169] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-38e4b0e9c5fsm339168a91.10.2026.07.16.21.32.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Jul 2026 21:32:48 -0700 (PDT)
Message-ID: <e462cb4f-d4a0-443b-8dfc-c6dfe6dbde18@oss.qualcomm.com>
Date: Thu, 16 Jul 2026 21:32:47 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] gitlab-ci: build hexagon-softmmu to enable functional test
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: matheus.bernardino@oss.qualcomm.com, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>
References: <20260717041916.3949105-1-brian.cain@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260717041916.3949105-1-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=KPRqylFo c=1 sm=1 tr=0 ts=6a59b072 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=qbVTx35NfVmC8YQ4Tz8A:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE3MDA0MCBTYWx0ZWRfX9Uyp0x2Adh5u
 TVS1OYfIs2sqIggEf1hjR2VZaO3TYbaRbHj5M/TwMHFwKqy0KQMliTp8A439nx7f6GbBj8MckrV
 5eTlUNTLIvLlnExIQAHBtPR7gEnFY9l35c/5B3yo7iEu0NVzV4jjz4jdtNr1K3kHKQiYD+sHfm3
 OypETlgBj40B6ZyUE09mzuOLsIBF941ba0CFel7XTHF0kV4GEYD5nQEfCcr9mMjWuLUvWHsm9K1
 VyiNitzSHW7sCfW+TMttpVC8fvNs8Cp6MH0j/k+YW1+UfCgsvg3Fcnt8JOnTWMjTUs+PmHXKh3j
 UP4WYE3p2pDrLrW1cQ6Phb3Ek4mMQ3PXlnR9Rua+vwyiRG6HyUoB+Dx+VuHzSrrrD/Tpl4c/7x5
 96A0paaf+6zo7vYCaFXexQgMYHVMC3EwSSH2q1I8sa0Gch+qEm0sGhrBDlyY6dofZRCpXp2Pegl
 Bah+DkVtJYljdI5ZK5w==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE3MDA0MCBTYWx0ZWRfX6AaAJ6cLuZPC
 qDuNit/bzC3CS0/8rUiCs1YDFLQZAayMditYcns7coxcCg05CtdykHd+9vvfk81oQoO57cl1Viy
 G140ArBFSmHKk4khFIGOJyeU0mrzvy4=
X-Proofpoint-GUID: 0VduK9wAUiTePQv5_IN2QqE9xrewn_-5
X-Proofpoint-ORIG-GUID: 0VduK9wAUiTePQv5_IN2QqE9xrewn_-5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-17_01,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 impostorscore=0
 clxscore=1015 malwarescore=0 bulkscore=0 spamscore=0 phishscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607170040
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

On 7/16/26 9:19 PM, Brian Cain wrote:
> Add hexagon-softmmu to build-system-debian's target list so that the
> existing functional-system-debian job picks up hexagon functional
> test.
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>   .gitlab-ci.d/buildtest.yml | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@>

