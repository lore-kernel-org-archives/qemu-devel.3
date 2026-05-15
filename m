Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2518ACD4F25
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2026 17:23:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNwFN-0008OI-8z; Fri, 15 May 2026 13:22:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wNwFL-0008Nk-EL
 for qemu-devel@nongnu.org; Fri, 15 May 2026 13:22:47 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wNwFJ-0000B6-TE
 for qemu-devel@nongnu.org; Fri, 15 May 2026 13:22:47 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64FGkpWM1353822
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 17:22:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 xQvtF/TKe9keT6WorOWSGDBW4jh5tM7Uzeq/BxmuOI4=; b=cPjeUVC2fVuHe02b
 A3fDgV6jqUDrO9VI6qZvjp/2NOXqprdeI4cVMC/JtM4cc2BuXTBNI+/1xuKwa3uG
 /lyTnri3pdGoKlwC+DEU7eGtUKabIEOtRMajPsiu2blNAG7NO7zw4vGZP5tmODIw
 eTa8T8xXe7R17nNdJ5EK+sxYulJpw0KioqiO16L0p48PvtArqUJDZUrX3CEHPuuH
 M6gpjqqIiWYlP3lOI7gBLK8hfKVui50RDiI8Lwl4THgKAiYoYuvcOHdU4yV0UCMc
 40kIK2Sm0f49w4Vh7GpgzbHc5Jn1CzHmfs0FNEjDNpH89P4xlDhABb+vG/wSH0vn
 edryBA==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e67ac83wd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 17:22:44 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-2bda35eab74so1781eec.0
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 10:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778865764; x=1779470564; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xQvtF/TKe9keT6WorOWSGDBW4jh5tM7Uzeq/BxmuOI4=;
 b=g6RDYxr5CgXROpCOLqnQL8yE/jSgfHIqWyDAahwOGaFoj/ijhOzvMEXsQXucHO0m5k
 BVarv/aoq1q243LqX93yQ2hpUDEKzvelxIfQJ22qchyZpXLTcZxobjCN4nm2F87njcHz
 68McaSm0neiioMdwo7PnhPgYWSEUDoccOxyFGjSaf3g9y+Oi5zMiTolb3UKKE1V7YIHm
 jjNdYGDUzxuat+WhoGMt3c1s57VQEIEOq//VsFQK0laROzSn4cHJlMAyaJUPSOvRf9BV
 36qaP6hPjK6XZRvdAlLmtwoWrJo/qpDoB5Qh/JWbB3kpvef9TQNDmcBDjYOrDLgVBheN
 BvCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778865764; x=1779470564;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xQvtF/TKe9keT6WorOWSGDBW4jh5tM7Uzeq/BxmuOI4=;
 b=eOxTqIx0JYkU82wF49S0QcvMnfUP2ymXBkWdx7kWXNl7r71N4/wnVe8Nx8RuaWxWFu
 dBWTdLSC5BpvSfSLF67wZDQ0xjFve7ro+k6h1Q9XaIFZSv9Im0/FjUZgpH7la6yhYCbu
 hVub1Lh0g+Shvv8j9XGDRNGgS1USVcRNUvtzshUhI/Tu5KMpt4iY6yut7DV9IGZmRbIq
 Jt1IECQlwnUQNg6BUB0UDs996tCOKKpsp7BugprZUKKIf1rTZnOk+Zk35qbYfoX+sibZ
 toIBxVquQOXr+V2WdWT26rx+czG0hhf/mdYs4GDcrY372t/evVdMzYTtEF94KLlr6Mwb
 mNZg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9+vv9Z2eql8sGQpYMzrKYjBvY0eYdj38s5QawS8X2IT65UrMM6M4BUZSCwCxodYE5LiGCoA/4MNW3e@nongnu.org
X-Gm-Message-State: AOJu0Yy8U5NFLCu2fuz3a6BASzOXHYPxFUFL5tAyP4t2poQNJE4lzssF
 cgBrIQ8nj46ol2TrGP+BcOOLbTFThrIDAmUj4ctYjGsPLCByhNGHOE26r3v0JkLaoYRrlCSoznw
 sKLNMQgjW9HXuI0POZZVvfXPI73czpOZH4BfgyuhmbX1etcqbJseTyuQXzA==
X-Gm-Gg: Acq92OGIpA4pTXX9eINHFkpF5bIzNdnEBrWtYzGHdvyPxUWHKr7oCuKMiEsq2RKfOFq
 Cx8pwfmgYIYPFEwcv630xOP+mPVGBWxZFmK/RylX4g2r1HOsESpdPwmKurtC1cHtOsFKfcIyfct
 FQqJuWQPyBGsc4zEdZ8tk4LSUn6ydVCx4MghaCOYIYxHfitroXnkwdXFY00PD2Qg5ptF6RYeWGJ
 AgfLpkucTGV7jyy06LubZyoZUaEYOGefbf6Vqw7oHxb3w79iQmZGXy8/Bdjdlz4I15VlX04Nxf3
 Ounl3q8Wn2EVNcQkJ0ukxV75ArqOUaTBZUbjTIKjFEjSRot+SwgOu44xxtILZ9f0Ap94lGRlqak
 bwMP6zkAhQsS64K6MOHw+YpCOPBPtFOXfYHCz8Fb/0CbjZb740xxj3va4J7+LhPC4lV3D3WxofZ
 YmGZaIYPsVdvBq2Ph+TGc1WF2n
X-Received: by 2002:a05:7301:128f:b0:2ed:e16:6b39 with SMTP id
 5a478bee46e88-303979efbeemr2279967eec.17.1778865763503; 
 Fri, 15 May 2026 10:22:43 -0700 (PDT)
X-Received: by 2002:a05:7301:128f:b0:2ed:e16:6b39 with SMTP id
 5a478bee46e88-303979efbeemr2279944eec.17.1778865762944; 
 Fri, 15 May 2026 10:22:42 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30296dcc458sm9056059eec.18.2026.05.15.10.22.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 May 2026 10:22:42 -0700 (PDT)
Message-ID: <32cffeee-5dcc-4fa4-963d-85ca262ea719@oss.qualcomm.com>
Date: Fri, 15 May 2026 10:22:41 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 18/20] target/arm: Define 'max' CPU type in cpu-max.c
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?Q?C=C3=A9dric_Le_Goate?=
 =?UTF-8?Q?r?= <clg@kaod.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 Joel Stanley <joel@jms.id.au>, Kane Chen <kane_chen@aspeedtech.com>,
 Troy Lee <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>,
 Steven Lee <steven_lee@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
References: <20260515141032.3271-1-philmd@linaro.org>
 <20260515141032.3271-19-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260515141032.3271-19-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: RMEBwfm0UI2zGRgC5hqXA9-B6y4A9Yii
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE1MDE3NyBTYWx0ZWRfX9dKAG+T5JkVD
 lHC6H72U2HczEORV5C9MeCCDEzyPHJ+D6fUZL2Kga/DNBiCDRJE3PcR4avMCMjqQmrky5k4tTIh
 Kwx1jBianIBrklX57OFX6+JURei6vIYaRqOe75xTW95SQ5FkVvtq/lk51+iCMSNT0dGjlzb+TOe
 LAYE3h6NrjrntVgN94uTPoR8Wss++E0QSHGV+XDP6IiGp0y3gJPNqhReAfKvy4NaUwQMaIcg+n5
 Mn0GeJgPIeRZsdiDaBhLoGEa1uICE71riLzvpqnXEzJ6LGXjhIWq0HxTZYqzwnH+KqU0STUjKBh
 s6KhzdQMZgMLBJVLlcjwBHkdROjcMgzeUr8DQ3eQXBk31haepDAvTJ7u8zCvxr8qujKNkmn7uR5
 KfiKGb9RlwgrOO9zicqS6Rm2XfM5yoappY7Lr9kAp3BWUZMYETDwf7In9ZHPQTppPytwhHkUmKk
 E00llBBIOxsf8TthqCA==
X-Authority-Analysis: v=2.4 cv=SuWgLvO0 c=1 sm=1 tr=0 ts=6a075664 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=yxX4FA_8Oh2w2vnb4N8A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: RMEBwfm0UI2zGRgC5hqXA9-B6y4A9Yii
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-15_04,2026-05-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 impostorscore=0 clxscore=1015 suspectscore=0 phishscore=0 spamscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605150177
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

On 5/15/2026 7:10 AM, Philippe Mathieu-Daudé wrote:
> Rather than having the 32-bit 'max' CPU type defined in
> cpu32.c and the 64-bit counter part in cpu64.c, unify the
> code in a single place in cpu-max.c. Define stubs for
> aarch64_host_initfn() and aarch64_max_tcg_initfn() in the
> 32-bit binary.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  target/arm/internals.h   |  1 +
>  target/arm/cpu-max.c     | 65 ++++++++++++++++++++++++++++++++++++++++
>  target/arm/cpu64.c       | 21 +------------
>  target/arm/tcg/cpu32.c   | 29 ------------------
>  target/arm/tcg/stubs32.c | 10 +++++++
>  5 files changed, 77 insertions(+), 49 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

