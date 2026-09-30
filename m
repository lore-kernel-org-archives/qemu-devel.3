Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F503CA5FB1
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 07:39:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBotn-0000Ap-3N; Wed, 30 Sep 2026 03:38:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xBotk-00008b-CC
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 03:38:40 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xBoti-0003mO-RI
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 03:38:40 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68U6oKtK2321703
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 07:38:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 2dphzk1O501AOx1PS4qF9z2AETyyEfwlqD5IqyPxuJ0=; b=mKX1icrEtptYyyDN
 MqNlqV/Z2CyV4uHCMliq65fux+D9dOwKTvBAqAsKqFr30t0lzN1FFFYXm6+xpZ5z
 yVWjH++Qb8+cg3BoNaUNoBoxiVCtIUKKatbJrmuuTtFH4VC7NhdKRfrYl64nTJcS
 HZbRvFFP2Lr3g6SoCJATUbUB8TqdSTUC1chyK9tp+DD/WlpwB2av+YuYegPhlOuM
 SSC6yueL0vVxRWqmXCCey7o8MRi2w1MmjOxTMiuPkiEcftV6e1qHA34QGV9R7Zrw
 UwZeEjyvD+JjIDu32uJgO0jxYvERDf0GG56HW2XrOswZf5TYQIrQGK7a2MHvwNEC
 kb5UVw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h0tkn0xwa-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 07:38:37 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93a183a0e93so1084286085a.1
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 00:38:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790753916; x=1791358716; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=2dphzk1O501AOx1PS4qF9z2AETyyEfwlqD5IqyPxuJ0=;
 b=Sk9OHq3Rb6eN5wv2fEQddvYUMdzyElz5J8c0vJ/GDzo0KlzHFV65W4TjYMi9PLcv5v
 OHkjutZvrMsbixjR0Iy28hBsp/YKVv3RVING/8deGvb8bG5YRDpSWDbJDDFQJMC5ti6x
 dC0OQp3s7UetY9Ylo6+d0Zj++Ddt4g8UIso8EYTCQAKYgbKi248AkYpedDG6P8As+mjq
 jKRoLVp5rvfZtQ1rndmt6Q2gQ/5toGQQATVCmtY5h7UUymrYBdbqGioZ4lyuplMlbTTZ
 P20JzwiehSff9hmNUpGh/Ckwt0Dcq71/RxalD7XRMRRrokHAuKpfdEX9OOw9X01nQjae
 HHiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790753916; x=1791358716;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2dphzk1O501AOx1PS4qF9z2AETyyEfwlqD5IqyPxuJ0=;
 b=sbIHkCwV3Ipah3Fl3rL4iejFJZC2IvrdoV/aHB3zzDmDj6qb8hdPP5bEgQsGfsbZNR
 4GpGYj/LdKLCO4BZGTOZWyS7zfE5g8OJbfmSwNivWl+SdskVORrgW6LnZMxXP7mAf2sA
 t72w+osiZShIxx1mksW8wjIakhDQjKyVU6Zke5dubyjYDxTMW1LdN8zUaipT6LLpOAGP
 aX9Vn4bzITs71f83zNcQLmGovth9zuHvtc38Hw7X+3l6GdpCZOXS9vMuxKEDmKZ7TCeF
 sBaowow8AbQpSRASNVfY/0BTWjxotT58YPQNZPrHtMDNnWWcOwaeor0W1U7rVc8BPJLE
 Ia7A==
X-Forwarded-Encrypted: i=1;
 AKwUvBy/wNlvOU6wOUnUbzXqmR/r95h5vh1jMhBjWNyUmaiYweMhAJFykdr1+bL7pTQ4udpYVpsSuaYuR65L@nongnu.org
X-Gm-Message-State: AFuF++kjximK7WYJqSjcGdm+ytC+WoVdArG4PCCplWA4QdVPzg903WLc
 cOotDM5JmQNd6fzRvRMVPpVMVCz4q35E6Wvi1GjG5vwaPs+/a9+PMMs8Ba6Z1SROkAx473KNVSb
 gOmvAgIAUA4k3sGu0QF/Yza9avBJz4cc5JDC9Lvw+CZswywcbKU3bfYsJfA==
X-Gm-Gg: AYBFou1sbQrZuRtuEPWGTInJgRs2z1pkoAVQpSrr53JJKXQ3ho3e9+dUZy0HX37Csgm
 CL4DSykumx63cTD+PXRm0TmkDQz/ultyGXlfwNr973cWLTRyV02x7h3v4kJA/FpbTmbdj+6GSeJ
 0z5bYOlfbNn070lsG9d9CE5ljuESOpYL145lm/s0vxxCIh0faRwgPHero9GwzjW1ZwtwifUVURz
 WIu4RrDTttKODvkGSMLlpvTp1qvjDNEeEE5WSrwj6aLRS+9Eikz1VSpwldLwf+Ej2/ZU54rVYbI
 m9aVThYgoiPeSLJaAzAcXpgU1NeZnydaf6hGMQWJSaPdI0r+stejGHJvTNgxRqwj3gAKBq5Bs4i
 agnoAe8DZcZKH9RO1+9s=
X-Received: by 2002:a05:620a:450c:b0:932:ddff:123d with SMTP id
 af79cd13be357-93ca97a83fcmr66052585a.29.1790753916276; 
 Wed, 30 Sep 2026 00:38:36 -0700 (PDT)
X-Received: by 2002:a05:620a:450c:b0:932:ddff:123d with SMTP id
 af79cd13be357-93ca97a83fcmr66050185a.29.1790753915811; 
 Wed, 30 Sep 2026 00:38:35 -0700 (PDT)
Received: from [192.168.0.4] ([79.127.134.49])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48b02949f45sm1423603f8f.2.2026.09.30.00.38.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Sep 2026 00:38:35 -0700 (PDT)
Message-ID: <892309f6-bf7b-44a6-897e-ae4c3a49da5a@oss.qualcomm.com>
Date: Wed, 30 Sep 2026 09:38:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 02/11] hw/arm/aspeed_ast2600: Use unimp array and table
 for unimplemented devices
To: Jamin Lin <jamin_lin@aspeedtech.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@kaod.org>, Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Kane Chen <kane_chen@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Cc: Troy Lee <troy_lee@aspeedtech.com>
References: <20260930072501.2612119-1-jamin_lin@aspeedtech.com>
 <20260930072501.2612119-3-jamin_lin@aspeedtech.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260930072501.2612119-3-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=CKy/zhrD c=1 sm=1 tr=0 ts=6abcbc7d cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=7g8aA7A78AY7OC82r+w+4g==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=V2NxCb60AAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22 a=3L6qF29SlnrayQqPM2jZ:22
X-Proofpoint-ORIG-GUID: SkaCaUbIj8lflQ-ffz5cV3CmuxEtYN-n
X-Proofpoint-GUID: SkaCaUbIj8lflQ-ffz5cV3CmuxEtYN-n
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDAzMCBTYWx0ZWRfX7OGEVqekgwa0
 ausHREGC0BVy9xTpXViNzck6q1Xhxs5CTFVvkCqLgkXKHWWoA12oQyzBb6gKNbdcB8Ln1EhAVV7
 vcetGVsfP+dqyHQ9Z4gcgterT/03eiEu9PXxp9NOhCDm+C8VU7zCOZKW/sbtsKFwioqG0mDSqht
 6njlgsDmJcEJ4YnKpnAKkg4LcevYHJFG82Nycj3K17wm5rdyPKSx4qIauOywA370P6WVy3vZRWd
 M0eC+lYia/PYMWdb5wgNe0RdQBXI4GfCZDhv6pCPQfw2d1VXXU2VbLEttjocuibDM7PotViyaHf
 k3xpwe/uLybRZT6WHJlBWWcjG4sqIVQahNGgFcq7qPilNomw5FzoL/9eJat2nYUaBUw5BSHcco6
 eqtQqKbuHiVkeSk1DXOWJIu+j3kOIsa9rYWXBjNAJRBaj+vv92rbNNl1VXBM5xqsJJZdQZ4N/k9
 CEEqDuy+BEoiwcJh2Zg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDAzMCBTYWx0ZWRfX9Y0AGzIVdA1W
 UxiuCVAbxUf78PBdWxjercIeYF+J6M2fBXFOCigKaDzw3wzoRoEFz3IpTe2y85AYkABz7MXsvth
 fZjtYDbno1WKeRu78sWBpH6CCN07NKQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015
 phishscore=0 spamscore=0 malwarescore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609300030
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

On 2026-09-30 9:25, Jamin Lin wrote:
> Before this change, each unimplemented device needed its own field in
> AspeedSoCState. This made the variable names confusing. For example,
> AspeedSoCState has "udc" as an unimplemented device, but
> Aspeed2600SoCState also has "udc" as the real UDC model.
> 
> Use the "unimp" array in AspeedSoCState for all unimplemented devices,
> and use the AspeedUnimpDevice table to describe them. This makes the
> code easier to maintain and read. Convert AST2600 to use them.
> 
> No functional change.
> 
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> ---
>   hw/arm/aspeed_ast2600.c | 53 +++++++++++++++++------------------------
>   1 file changed, 22 insertions(+), 31 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

