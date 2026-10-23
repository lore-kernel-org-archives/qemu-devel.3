Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69482606A328
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 12:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=bh9xTen2;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=SJd0Tf/m
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKENp-0008HK-GM; Fri, 23 Oct 2026 08:28:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xKENo-0008GO-CS
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 08:28:28 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xKENn-0004Rg-0W
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 08:28:28 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69NAAxZ11444093
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 12:28:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 cJL431ZHSnjglK6T5I9gRq25tVgK8Gnz3VZ3S6y3bTM=; b=bh9xTen2OqJrAlKh
 MJYhf+P46xVR4qouLcU0pKTe6Dekdypq9hzwAAZblW0138+FoKGwOD3+9QkSFIl/
 tfRL9sqe4fxC2n8cZDkhw7k3ivQ/gGULPeQb7Wx9dBW76OXmEHo+lHoFbwi1oyJ+
 PgC1XNNyYa4to5oPXuXRYn56SeMVbI7k3eOvol96DtyrwDImkBoLTLVVv7nlPZch
 WK1cnxa3bkz1/cL9fPkdD2ZTIyDOTe87YC63gj51UV6w4kU0H9oeIAxEhznnVHhy
 HXA6uJLgnMCBijMOzxmsjCfC0bHK7PbRFCIK841r87bRvbCNHs/t3OSm8ULHXcdf
 Ac5kFQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfqmbkp3w-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 12:28:25 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93dd3c3badbso207516385a.2
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 05:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792758505; x=1793363305; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=cJL431ZHSnjglK6T5I9gRq25tVgK8Gnz3VZ3S6y3bTM=;
 b=SJd0Tf/mNw8J/T01GRj9zqqIhxPY4aRg8hhPN5+UWB7ITdo5egUUpemrf5d9tzhVCp
 RWssHKGt7Ghgz86qECzQPWMuNBqG9kijRe7QJ+7O8bejxv+wBlf+ducGkhomEqiTI4mv
 IJ7eajjvAXDIPc2CmVFBDHkY9B0MxWdtL5iFiPlSGLTbkSIsS10aYMJ5vlSMbY62gMbo
 EuFQ6s+QqWz1ZpDbUxgYtttGWUz9O/wBYePd7HFlyRzlpCkQgMhHrBzI6drltUZTlIU7
 DjlPxuVCrH2o2OVf3lcOcjrABILS1RRTPKawWj4GUpHGC+9OxkPzp9cm5o5ITFGG7q+Y
 dtZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792758505; x=1793363305;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cJL431ZHSnjglK6T5I9gRq25tVgK8Gnz3VZ3S6y3bTM=;
 b=TY6J0rVQZUcxeFcRxtxfhGRbm8lrMIVmxT2r7lEU2FfSr3yP9oFnon8XLI3qUMo2pf
 PeB7FR/2pjk+TBFQkSYYmEJx3M9Q+/ezj60kLXI068XKOy/0ZWhORMnH7O5QGA+5vu1Y
 7ZEQ1osrQJZUnnhqqK+vuNS7d5XcGSsOi/391kqzTXWLfglucbJwOPtBYPzYCddBNlRl
 njFaPrHzqxfZV72QGO0ARX08Yc0qJqDIkiPqobbjakFq6PtwJ/aBHqrsMjqNGMZmoRjN
 zRYO305MbWlXJ4IJWdbeERFk2gTHYBu3yQOP0LbssPCX20PLDGKOi/kYrk89eUSO4Znn
 AsHw==
X-Forwarded-Encrypted: i=1;
 AKwUvByGXazqc3nS+z8XyibO+wFGFbPkzSMilXrF8dA6UfzBcq2uOMg7QsOl0L4DJWoTj9PWwQZ8wsg4m6g/@nongnu.org
X-Gm-Message-State: AFq9FYLHufMWdAKZp2J8qu2OJMgy/97jonotJBJTIEe60X+pt5Y7iYQV
 lCHicBrt8EewlZqUrUPwuSp7bLA0KA25slRV8H/PYl7gXL8N1mWBYg1asgGD8HwxVmd+xGg6PcI
 FIVG2R15iCuE0grawMkOSOv/z9fgpgtSCzeYKWjDxCCjvgXk3X8kNs1WDmA==
X-Gm-Gg: AYBFou1cYU3B7Lhl7PinAc2XUNlMuBPmxRBw8GmGhwXdX7yngbs20LnbQMThhe98xil
 jtN25j2jVLxKQmwdavwYF1FzTP7HjqBX/hKqj6EugBb9X1jYbof9jsHbGWKScCOlzqsoXN699N0
 zsZvNdho1IfaNlSH/v+s7YrtGBLYjthjkAUG8fN9N3z+RlW2KicGjOkMwnzEIJnvp9QidxECHOs
 bEH92gx1yGx+GHxUaMPkdKdj8oblTeUqoaMplpwXSnDf5zruyXujRP6P/TT0py0NDreIpAP9B9a
 uV98sJ/oDkkbjZ/NAE1ztJlvnMK4vkkqIy5QSxc0zFlJ3+LfWtiSdwBFbTQDNJqOZNyTISK6fMM
 TQ2kCdAxelt+KmvcCtosMCorrM4lVxLxvLw==
X-Received: by 2002:a05:620a:1a10:b0:93e:d854:4b83 with SMTP id
 af79cd13be357-93f6f782fa2mr384642085a.22.1792758505150; 
 Fri, 23 Oct 2026 05:28:25 -0700 (PDT)
X-Received: by 2002:a05:620a:1a10:b0:93e:d854:4b83 with SMTP id
 af79cd13be357-93f6f782fa2mr384637885a.22.1792758504553; 
 Fri, 23 Oct 2026 05:28:24 -0700 (PDT)
Received: from [192.168.69.209] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e38054172sm4580949f8f.40.2026.10.23.05.28.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 23 Oct 2026 05:28:23 -0700 (PDT)
Message-ID: <00e91134-6b22-496a-a9bb-279ae8191356@oss.qualcomm.com>
Date: Fri, 23 Oct 2026 14:28:22 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] target/mips: Convert to translate_for_debug
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>, Song Gao <17746591750@163.com>,
 Bibo Mao <maobibo@loongson.cn>, Xianglai Li <lixianglai@loongson.cn>,
 Laurent Vivier <laurent@vivier.eu>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>
References: <20261022125858.310252-1-peter.maydell@linaro.org>
 <20261022125858.310252-6-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20261022125858.310252-6-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA0OCBTYWx0ZWRfXwUTHMPvgWgXH
 SjrH3zWGloQkKWNPIIFXZ13iMlJ1mZxUkhxK/BkdBDlonUJqmwvY3ub6HpiDAPq8Yt9orA/QmVn
 On6KyJi2ilVaODhLuMEXriRArbYHmtM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA0OCBTYWx0ZWRfX3d3u1ZR9ceog
 aYwDjqUNcGqOQLzmQ98BCVrDaA7mcydyGrMwSjF0XZxENXIu6IGoIIpLgHvlpZ8piL1ML+G3mkR
 wDYgTQ1qXq1UvagkQX3xq1LqwQL1M/wWdARaprF5P3EVRhW4qprw/G7X7RB52lE1x3qXWcQ6uQw
 znKijQ+FdUoiqtIz5xd7TUcq/D/eO9tCsu9V1cfy+Wn3bkmPL3QTrutiJkY5QAYqkoYyFQpefRz
 E6SoL1+XSmp8mZdpLDauhWrPuzCBSvru5hhLCij/2ZNxQRMS51SXwCnCPqAq27hpa8VDq3+ulCu
 a6BUIz8D04a77rok1LYl4ZnQeNtb4ZRQLudVPd1TrOMNRRZv6JEqQ7FByAzkX+BnpELm1xOkLvb
 oXW82BXu1gtElf487tuDCQQCwE75m7GAUAcsJvcg/jqvBTT+iFFwo5wBn0qWAkVz3wEEY5c8x5D
 9DAaA8Av0dokjucMpVA==
X-Proofpoint-ORIG-GUID: 3L0MkJ1tVdJfzQdsLaGG5id9ZcLp_jzr
X-Authority-Analysis: v=2.4 cv=Nt1E4MdJ c=1 sm=1 tr=0 ts=6adb52e9 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=Vcjkbh16WYxSvleq-h8A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: 3L0MkJ1tVdJfzQdsLaGG5id9ZcLp_jzr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 impostorscore=0 suspectscore=0 malwarescore=0
 phishscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610230048
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

On 22/10/26 14:58, Peter Maydell wrote:
> Convert mips to providing the translate_for_debug method rather
> than the deprecated get_phys_addr_debug method.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   target/mips/internal.h        |  3 ++-
>   target/mips/cpu.c             |  2 +-
>   target/mips/system/physaddr.c | 13 ++++++++++---
>   3 files changed, 13 insertions(+), 5 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

