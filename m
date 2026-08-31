Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6E9EC61DD3
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 06:40:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x0vhD-0005qT-Po; Mon, 31 Aug 2026 02:40:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x0vh8-0005q7-8o
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 02:40:38 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x0vh6-0004cq-Ss
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 02:40:38 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67V52hLp2764751
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2026 06:40:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 xyI5YiKn/hJO6KJDwz8mDAkgMRcz5gQVsNiNDJTbWVY=; b=Ufx8SbykeVRN9XEP
 vRRItagHGsTCOCJl0+1oLIZOqAKAsoTTTJ6/7IUGEvd7tAxVrpG+dyUfVo2+KSO6
 BVZ0MYaD/Of7e0aX+dvXK2FVm6xWeqfjbv3O9gtmIE7R3WBe6MUiPPcUO7C0aLYx
 oiI26W1/f8JhZO0KgRMY+KqCFds51HgPJJgN13aLxi7ZGVbnMAQy9aAurLc0Nd+3
 kcRVhlie7SRwXv5gsCsp9bM1XTQO8X9KT2Y0NnQ4SQG0D+BOlg3y1XxKUG1+Oj5e
 V6EJO71m1hlKk/p1C4nlUjxrZsO9MXeF39IipvSqIKKAw1lL3tbkhb7ddKZHktSA
 unOQAw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gbqgyn1ef-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2026 06:40:35 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-92e4f946461so520308885a.2
 for <qemu-devel@nongnu.org>; Sun, 30 Aug 2026 23:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788158435; x=1788763235; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=xyI5YiKn/hJO6KJDwz8mDAkgMRcz5gQVsNiNDJTbWVY=;
 b=T9+ZUYlSAmpCLuoC6K1QNrnbaSbNiAkHoAwWlykeB3BWLoC86JSamw5OwHrit4+DKY
 4NxXiSpOrC5c+iCqAGrb2pd3otClJkHJDTnQ57QdwaOSDs3ESqYK2qyncdqY2IWTLQBO
 Z1DulxMPwoLVHcOsJI3Oa+GBQeaSfaJxXKouOE4/Kzci2VPkpkses2tfD4js8vNoq+kE
 5Bnr0LqTTEkey6nEQnGaVX8gAUAlA0j99dW6wrvKkLEmCSw2Tz8WzhTwr4wzLxwPxb/x
 LObvAY2R19AYAXY0wetnvQkYuH8ABBRAXT6ZeagM0MxlDV0lTJhFw2/16bscRhMkGIQM
 unNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788158435; x=1788763235;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xyI5YiKn/hJO6KJDwz8mDAkgMRcz5gQVsNiNDJTbWVY=;
 b=LuBDOzA6006+dt/V8tbCPGN5B2mKowpTVtJymjIJBiIXDH8BtGQLR7JuRa10TvCDWz
 AgTtUAFTw+gxUmmlb8m8BmSKYOKoM+TK4Svt2veyMRQ75wxmO13AMa8CLGcpFTQzf50i
 YEMqZYoijzB/p3PdbdSV3v9q5nUp3BK92ZVYYE4JFZnrMW5CLIIBCO/GzkRLbvtXg1y2
 e5V3x34Wyp+f1jRFssfAnvzXP6TF58AxrHjAFFfjOAGB/rhbfmBiYRD46v47t2PlK2Cm
 euUk1NVa1ptxynoxeE4c8ARDBKq81NBwJ3HYMEqRQamvskL9QNYb9eIV1QNbHeEJgJA5
 UtXA==
X-Forwarded-Encrypted: i=1;
 AHgh+RpmpYSGjpeRT8T3eqIrnF56VHwZ+SP4rMi2pNsSDJf4CXURahFrNtC3vOfdm6N+TMJnHqWuoT3awaDW@nongnu.org
X-Gm-Message-State: AFuF++mA5JqX2ybzy677FNDYUibr+sJ88jvrFGrFhM3582v7DMH0WiGT
 Xmh6SA9AKQE2t50E5n7YhDXM9yt14N+DtctPRl8PMYxA807jvNeH2OofxJULelHIWn+CZqCabWe
 OpUHRp6AiJYKjNhg3xUIWwCroxcSbfni9lFPcEv/woKZcpuiRnmmCuXS0sw==
X-Gm-Gg: AR+sD12JtLFOmaYmzHj89w+EYf6G9k62ga53kSWW2yYL0mcmBfjWYw8zI7DiufdhiDg
 4xpXyr2txHfUvg6mgU1oaHnCZXxaf1oaZDGJMvI0fPTo2IUq0jHvAOoOiPzUAIVqvftD4Zgm6Ac
 0ZmmUcb1tA9+b6HQ0S9HMBDVa8UT1VzekmymPbGoICTKmKDQNVEFA4l9wIlhfOLvztmj0D2YoVF
 j1tkUx8LxF8Ko7+loyed5wBcgkhslPc1We4NQ7Q8c8yngRD9XnPDxZbbOQxBkD45kpDDusY8lLQ
 MptgnfGwkKy8XhZuw9Dilxh/bWaybAkXD7ATxjckRJc8fk4YNG1SRTQKqC38dDCN3y6osKwjuTY
 xP434f/wTtjorgx3As2CsaPNBe77tpHAMQA==
X-Received: by 2002:a05:620a:1a1a:b0:939:3a51:2490 with SMTP id
 af79cd13be357-93942846197mr100591485a.15.1788158435099; 
 Sun, 30 Aug 2026 23:40:35 -0700 (PDT)
X-Received: by 2002:a05:620a:1a1a:b0:939:3a51:2490 with SMTP id
 af79cd13be357-93942846197mr100587385a.15.1788158434666; 
 Sun, 30 Aug 2026 23:40:34 -0700 (PDT)
Received: from [192.168.69.226] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482fbb33d58sm18064228f8f.35.2026.08.30.23.40.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 30 Aug 2026 23:40:34 -0700 (PDT)
Message-ID: <f77e00d5-31d1-4091-991f-c95e65cb32cf@oss.qualcomm.com>
Date: Mon, 31 Aug 2026 08:40:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/47] system: query machines using TYPE_MACHINE
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: anjo@rev.ng, Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>, Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20260828225901.367438-1-pierrick.bouvier@oss.qualcomm.com>
 <20260828225901.367438-12-pierrick.bouvier@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260828225901.367438-12-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDA1NSBTYWx0ZWRfXyVCVoxzT4N5U
 y9DwIfIV2Zx9rb4k2TXUc8sz3mUX1fsJk5z6FZDJg/znV1WKY4cYlMsLP6pwF0r5I95TK43OKEq
 N5HdCjhSVFaCKL1bfbv+U4ttvZh53xI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDA1NSBTYWx0ZWRfX/186hkR7umKJ
 KreNbpjwAGaEs90okq1sqnzgTUFzcR2hw+zvT1OuTIcPJo1NkEeqamlH7sT6UgJc8h0jX2j77YM
 GGctMyc8fU7FF3HYCfLLiROHTgCdOFb9zZpsO/+Uqn6tFR1dhtJlPV5Fa/ptE5MPIiiQmm3vRmw
 ObwbUQAuzMHgzlKPsKWCVP/jRlQldHvmmjxWZU62Af277KMGP8rONw32kxMVQ+mZFTD49GkiYKI
 Afr/8KgyWLcy5tcs9Vly+lhvxGNy5DuTclM+uzTD9LL/tXGr/8haLS+agE0zUgW8KErJxyeaVzo
 NSC793FLOwyWlDXifLLdJvKgXPxf+SEI799kuyPU4agge/Ms4I3D5b0qT6prv/TSivTeEXB5J3G
 D6tR/m9wBnvSeI/T0A22Hh1x6UordN+z3qBQYiEjMTzUWx1HV8jDX0nY1GgvUoYQ4jBAjxTzN2b
 sfKO62yPKjjnji8o/CQ==
X-Proofpoint-ORIG-GUID: AYqkGFYKfuwBcK6desUkWa8gedLpB_US
X-Authority-Analysis: v=2.4 cv=R5Ez39RX c=1 sm=1 tr=0 ts=6a9521e3 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=RupPi2YFEwiQSAa9joAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-GUID: AYqkGFYKfuwBcK6desUkWa8gedLpB_US
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_02,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 phishscore=0 impostorscore=0 spamscore=0
 bulkscore=0 adultscore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608310055
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

On 29/8/26 00:58, Pierrick Bouvier wrote:
> We drop the target_machine_typename() we introduced previously, and
> revert to using TYPE_MACHINE. From there, we'll make sure only the right
> types are registered at startup time.

"This reverts commit 2c6fab1c143059e59128b805f4e6a6796eedee43."

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---
>   hw/core/machine-qmp-cmds.c | 2 +-
>   monitor/qemu-config-qmp.c  | 2 +-
>   system/vl.c                | 5 ++---
>   3 files changed, 4 insertions(+), 5 deletions(-)


