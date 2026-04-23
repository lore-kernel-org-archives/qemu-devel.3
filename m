Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00B72FDEE35
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 17:44:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFy60-00020y-QR; Thu, 23 Apr 2026 13:44:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wFy5u-00020Q-IE
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 13:44:08 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wFy5s-0004Ey-Ub
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 13:44:06 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63NFFdtE179321
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 17:44:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 CGioHaRrrgUhz5GW7TSW5brpQDNWq842Gn1utupz2H8=; b=oIuUIvxUgazqnIPn
 zU4xfX1X6yMCJRiU+obqtTIr46mQFNwjNLiJeVI7MjqttLcX37mDAE/ivNRkTWVr
 ycAPrXRLsfBVadTGLhEhHVVB3n1KrB3WtSWzQ+itl7Ou72fZ2DhPsHl8Ajggc3vn
 /FYum8wCHBinUARichGTFS4T+zCW6vY5fI6ZeII15q1pNO5jQ4N8egQCmTCDIUCJ
 NJm4kXYQZIyL600nbYk4Z/Pn0Ia5iBHhtPjvM8K7gfBEIAtIjN/7D3iaaBOp+DyU
 uItBHBdqW8I9H4GCEvHeVu4QjlotuTzi196oCHi8uJ6st3gLWtrbjk78UIYbqoXj
 048toQ==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dqe62js93-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 17:44:02 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-2bdf6fe90a9so9537546eec.1
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 10:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776966241; x=1777571041; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CGioHaRrrgUhz5GW7TSW5brpQDNWq842Gn1utupz2H8=;
 b=a6IjWbJDeN3O+7k4TNOcfabAGQP00fdoKDHJIsRVUWHzXmnZ012bbwUGEByfcDddOi
 5CKZyAiLI3UVNNxOan/0XVUiJ72H3PXG/FXtzfInIPX22rDaozgWlWgmLDgVPN/H/sqz
 pSfSjLSCdmV8eRERheEIVSsvVdLV2u0RId5t1OrbAo7GIKkc0Iu7/2OVYJAwaCDJcdGP
 GaQkayIhrMf477w9T9H/XSquOx+sM029us16A3F40woevgLZY1r6Gp2mi8bzIykCeyhB
 buvcrA5Dhdb/Mspx89HsQtjG6hLrFeHWD0BR/3pKW6hD7J/G2tqFKpjULkr3e3zplvZe
 AN6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776966241; x=1777571041;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CGioHaRrrgUhz5GW7TSW5brpQDNWq842Gn1utupz2H8=;
 b=VjxepnPKWXkCCtDT88S2n9HEE4tDol66u8jeL+gmmjGsi/M+Tx8wLimPArX/BlaIVZ
 mSj7Zxxq1aAadRN9aKvkNPvg8egWu4YLdBcDVFUnMw8oH9quZVKVEMc6C/oyHtFtQItb
 wtIzAM6ydPogWlfb1ynkKtxAArhGJO7ZxClkMqZf5ve6DExaZQjHDtUShrWrK4150nD6
 CbSQuzh3XYezEH01OufzCElC56k63Ku9V9pLI5wP8TiRBDyZio0ZxhUnnqzTf9VxDUYl
 y0UWBkZ1G1idCJXZEdcaUqScUZp3yAOrxY44fD7PfjEACA7RYDqdhSN8Ch73j1FXasjw
 WHOA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+jiiH3TQ/bZvvleAqpP9K/AXaKnEaahCvdENaTEX1Ena9CsUJH3NKTVcnhhl3M9mg8Jelxg4DLoJLn@nongnu.org
X-Gm-Message-State: AOJu0YyHkJWvoFuwzK6Sx+3KNzKIlJ52K+pfvsOGk56BFYh0rVETfNBF
 MSX61FwQOYNCgHcjEHKpZs5whrlPKvTQMdJ3wkfY42jpx4ltNOYIgE1bt1fo8M1v0/tMp0ONNvU
 9JqsI8ANEH1niJE5j7K3uml2UwnbGLuq32XCBaBuRY3yeOB6D1NoNoiUKtg==
X-Gm-Gg: AeBDiev+M7kQMLyGeGI7nTxCEe3lgC5hFoeYrp5NWTBfmAr+LY1zqcCRWNZKiH28V8O
 nSpc6r89MSVPo6DNapf1+n5PGTGPl4bEGXIy6bCb2NkutpzRi2FVbosqYOdKGw2IZ0kkewaNo0B
 YThy7iRT2vxSWQlaWiF0QUXna/1aoahXLR9s1Q8F0EntzPlkCNpUzK9Rsg8TGC6P9IsG3Lum4Cq
 dI3W9h+5fgdDjkoC7QNkT//rRQKmgeJygoIpyvG1T3sNq73xQ5ujxqUfu9hMY7v1upiBoMByiBS
 dpYEA/ayJc+SjuvV4qPoI8ey6WjN/bY3U1T6yjmYHypcERcAPM61b3B725Q2PqNYzMxgc5mf5DE
 Pd4JIJ7UtEWy9WsgGTgTf4yl8lM28h3lQmRjclaE3IESFxKZQMj+IhklqCwb/p5VnLXxpGwazWa
 MyVerG0F72NyUnb4Qaihlc0L6n
X-Received: by 2002:a05:7301:1693:b0:2d2:129a:1694 with SMTP id
 5a478bee46e88-2e47873a614mr14205076eec.18.1776966241307; 
 Thu, 23 Apr 2026 10:44:01 -0700 (PDT)
X-Received: by 2002:a05:7301:1693:b0:2d2:129a:1694 with SMTP id
 5a478bee46e88-2e47873a614mr14205054eec.18.1776966240773; 
 Thu, 23 Apr 2026 10:44:00 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2e7025cf413sm23895494eec.15.2026.04.23.10.43.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Apr 2026 10:43:58 -0700 (PDT)
Message-ID: <923468b3-2bba-49b8-b6f9-69062e81f88a@oss.qualcomm.com>
Date: Thu, 23 Apr 2026 10:43:57 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/16] target/arm: Only set CPU_INTERRUPT_EXITTB for TCG
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Roman Bolshakov <rbolshakov@ddn.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>, Mads Ynddal
 <mads@ynddal.dk>, qemu-arm@nongnu.org,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexander Graf <agraf@csgraf.de>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20260423170229.64655-1-philmd@linaro.org>
 <20260423170229.64655-12-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260423170229.64655-12-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 1vuBuczu93f5E2SkrhmPXyTvFKnS2Jm-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIzMDE3MiBTYWx0ZWRfX5fjReidyAAMN
 kjWE2JoSk9atIv0YvFrDdIcv78HDkIuzV0qec/MWFriLrgbOUITBT1mk0xTgWb4UcjsORUX3DBW
 K8LJhw3tIgZA/LWStCzkEB+GHON/btF9TfCYGRASDCsjvM7XDEiXfBXgGaNTDZvf5Rg0ol1mK1V
 QEtiCLqOY2LWwnW6H96H7jWFEjMz1OnZCdWTf+D8waV1zFPIedbwUQYhB4mJmZ9qO3ZJVLgazOT
 fpLPWL02FZdEViR8aOSTPYRIygJG3LTFl831t8VBxvxSX2Feqr7SW/1mfM6rHUaJpRjH1io6JoB
 hVXapOAvXEd9oYzSQyWq3icVlKp/0DNkofwlH2n1sW7BVy7c3YfL9WDGnPOt0KvAd2X9RLIEvWx
 +B2OFe5uDSusqwf7m+LxiXEIBDk/flZRd+KoFUDIjDpdhiURnEhjIVGnGuNRfvjYB/EZItCwqDx
 ++dkNRAqD/jrqnGOPyQ==
X-Proofpoint-ORIG-GUID: 1vuBuczu93f5E2SkrhmPXyTvFKnS2Jm-
X-Authority-Analysis: v=2.4 cv=Nv7htcdJ c=1 sm=1 tr=0 ts=69ea5a62 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=oNFF6uGEv09ksA5f1voA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=6Ab_bkdmUrQuMsNx7PHu:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-23_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 adultscore=0 phishscore=0 malwarescore=0
 clxscore=1015 bulkscore=0 impostorscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604230172
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

On 4/23/2026 10:02 AM, Philippe Mathieu-Daudé wrote:
> Commit 34c45d53026 ("target-arm: kvm - re-inject guest debug
> exceptions") removed CPU_INTERRUPT_EXITTB from KVM, but it
> also appears on HVF. Better to restrict it to TCG.
> 
> Suggested-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> Message-Id: <20250630130937.3487-2-philmd@linaro.org>
> ---
>   target/arm/helper.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

