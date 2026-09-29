Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53004CA5FAC
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 12:50:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBXHz-0006NO-Aa; Tue, 29 Sep 2026 08:50:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xBXHr-0006Ly-1o
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 08:50:25 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xBXHp-0007j8-CL
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 08:50:22 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68TCDvIf1491541
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 12:50:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 AULDh/9ayQmU2Po7+GsoztMtvR70aD6hEU66eANZKFg=; b=dIy2k4bEzcRCKpNY
 /rJteEl5AMJHUhMGNmvmvc2SJ6CuvTZApfRxOpFvgxW0WsGOc8YuLbfFNNqMisIM
 DD6nbQObNyCEm4tfxwGzK4628hItPKQeMmppGz7TdJPJij+Ica3s7aj0CrWJ0Pgv
 LcoRwcRSfQAaA3e4DejUZd+emeAttgONk63dC5UVwPKICihBJFHA9MIkBkglDu0H
 n+MbENg0Y8fJrDDhrPH09K2/Wp00lO9jjrMXQuexbDga/RhlH1VxEmsfIGsreMyh
 rH+dBXAnYRUKfAe5jOqc3Z5JfkXCFGQv+Xxj/G9R1o+Fo8gYTODjzaEYzOue6P96
 EHsKwQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h09x4s141-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 12:50:19 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93a0312937eso556879385a.1
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 05:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790686219; x=1791291019; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=AULDh/9ayQmU2Po7+GsoztMtvR70aD6hEU66eANZKFg=;
 b=Td3CegYtYbjcULvAd/3bKqCmM/KO6AFdNAweYIsplzzbtE42pa4cfAJyOABbJlWDx+
 ig/5cROMVX1SkhSBhnuq64Z7Efii42gaD5QN0MKqfgG/bnSqKiZSUfSfXpGoqMZp3Vpq
 8h/iqaDBrql2kgFH84hreA9sMunacieiJL8les8QMotOc+WKvtq2GjsAgwfHxHEa3xB+
 YRJ4/WyBfno9pDODqKpUDMrCwXORm5C4Ph3czUpPz/nW6pnNSq0X3Rtjs3iW9a7GKTE+
 EZ4VUGZ/tW/EnpSj/gR3vQKY1g2syOgi92+PCq+XPeCRwrguUUHnCl0js2zsCYz1Tufp
 +kZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790686219; x=1791291019;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=AULDh/9ayQmU2Po7+GsoztMtvR70aD6hEU66eANZKFg=;
 b=i4GiJPOKADK6f2YaB56gPaf9NIunSFrcJTpsCJq/U+2KjCvUdG4H27XuHxqC7tEqTH
 8trrwsvwbJljxRjDyZkZHhHu0+PGwgGyeFkvCf5YfAD+Q7QaWVX08IxLmL7hGUIQf6L+
 BXWZsHu+RooaRrOKEPxetVbNs2rbROKUftFpLQ76DQRZ2sew4qZ8RYEA6Ouu4v+VAtAe
 b7+JApeMJQ/4M0djkB8fnXn2o8/SBs3IR47v6F2WcGFxpgCEKqGItmGhYv5AxzUM2uD1
 7Dm3sWHZUunwbn8vU+VPqADlKCDg4HcsZOYcuWkBVwgw73YeAkZ284iFjrNGcjB14IZK
 jJ8g==
X-Forwarded-Encrypted: i=1;
 AKwUvBwsb3oNobRk13lGKiqqjPMJvfsICDBE4P4yQftPCA0FVitCSZHJWb5ql0E3D1RL8cX0CNx7E3piIXf3@nongnu.org
X-Gm-Message-State: AFuF++lVubZPhqRtWKFlaUazcy2Q3NiR1ACCt3fkcVwEWpb5rrqyUUvR
 Wdez6OmHZncx5D6m6rBkE+EmuAlZZlb0pdkV2nl5CYmDmhM/tNR5153fknjiRnU3InkMEGpcp2E
 OKXrO6b9vHXHp8lxlMNJnlESBRQy0L4ekreAx0AKZ7oiJ/H3mWFl/f1F6cw==
X-Gm-Gg: AYBFou1iE/s/S/AppFi2bLju2ufio3C4YQTof1vKKJYFErpNXB4fK+ULuNCqyHIMl0b
 9AOnzAmzYEJr4awzAE4Ti3OSQPI/yCj0lg61yv5dNSQebQr49V9bq2zE60RiYfntwsgGZu1npsb
 N9r9Crtn+reE5mfKGRzPpVv49bJkNLDDyQwA2MB3Kl8DknB+FIBcpYjsdskz04KHAcDm8m2ku2G
 5w0zALjHaaRllcqHenBmgjWzTImZciST6bS6YgrAf1omMjPtKc/GCNdw9dKwDR7AlkhIzfpCkD+
 Lw+bHJtxwJ9bWbqP8Nt5M/JKbsiWMEXt/5zIB+gU2JLMNDCtURrauwWZotfQ+3IINW9kMTZ1mqX
 7Q6w3gGxN47F8bYEXl06SLTXWpsJmwp6ncw==
X-Received: by 2002:a05:620a:4102:b0:93c:2108:3088 with SMTP id
 af79cd13be357-93c43b92b24mr2746155085a.9.1790686218543; 
 Tue, 29 Sep 2026 05:50:18 -0700 (PDT)
X-Received: by 2002:a05:620a:4102:b0:93c:2108:3088 with SMTP id
 af79cd13be357-93c43b92b24mr2746150885a.9.1790686218090; 
 Tue, 29 Sep 2026 05:50:18 -0700 (PDT)
Received: from [192.168.69.225] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a00cfae123sm83292135e9.13.2026.09.29.05.50.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Sep 2026 05:50:16 -0700 (PDT)
Message-ID: <c05c723a-ced1-41e2-90f9-67a90e749bb7@oss.qualcomm.com>
Date: Tue, 29 Sep 2026 14:50:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 052/101] tcg: Use signed integer for tcg_gen_{clz,
 ctz}i_{i32, i64}
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: mattst88@gmail.com
References: <20260927090011.10724-1-richard.henderson@linaro.org>
 <20260927090011.10724-53-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260927090011.10724-53-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDA1MSBTYWx0ZWRfX+4AWP3i5Y2kw
 q1KQbpBru/nsuNna2RpdvYLK1bSmtUeG77asIArGmQbHzVPJBnWZqzZbAIJm2DacrKU0d0uvZx5
 yPhChTCY+ZFZ7N/TI91oNGpf7M+nQUk=
X-Proofpoint-GUID: QDQewTbeb21jKkryWUkhUk3TeeT3ct_Z
X-Authority-Analysis: v=2.4 cv=I5Hw19gg c=1 sm=1 tr=0 ts=6abbb40b cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=GnLSOQwolrN13sIzo9YA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: QDQewTbeb21jKkryWUkhUk3TeeT3ct_Z
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDA1MSBTYWx0ZWRfX9fmbnBgqu7IS
 95wMN+swWQQUkF+G5chAhV9ft6WVxZ54x9gpmwEffk55oarVdDFfVx3lryTIE912oGWaT26qFlj
 RxCmGs14dP6VIbKkSAxruxRdGPgsrB3En4n5lHAVo/vlf0VRFDGbw+yWltTaFZGrLNt/X+fmMyN
 ivIOlgZ/HL8Y8pugOoubMm3iax9IMr5EQOGazn+uLm7rx+aiFwWfaQ7koaSm1z9wo66ME0P1W1H
 UotU6pwXnZhZGEMzlj6zQADDQneg8D4XV2n+Dh3gJxHMVNqCbFSZ0xqcBCxvm/jdzFHMo7PWyYy
 ecGVvvzUnaWKcVMMuWs0h4EU26ou5Z51UyptdIqJ5nui3rEnbAY9r7v8k/mw/GyBMTocI+M2bvp
 ftbPBInqn1RebUaVrZEVcz8eGXQYFfDNNdVNn9DuxxniHMRmoSMdbTpA1WC3uxwcReA+YgDeXF3
 jSc4Ph7VmWQy5e5gfvw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 clxscore=1015
 impostorscore=0 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609290051
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

On 27/9/26 10:59, Richard Henderson wrote:
> We use signed integers for all other functions, and the
> sign of the second source is not meaningful here.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/tcg/tcg-op-common.h                | 8 ++++----
>   tcg/tcg-op.c                               | 8 ++++----
>   target/ppc/translate/fixedpoint-impl.c.inc | 4 ++--
>   3 files changed, 10 insertions(+), 10 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

