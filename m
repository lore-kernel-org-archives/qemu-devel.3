Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8362CD5BD5
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 19:39:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSgYg-0002ov-IP; Thu, 28 May 2026 15:38:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wSgYe-0002oc-QH
 for qemu-devel@nongnu.org; Thu, 28 May 2026 15:38:20 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wSgYd-0005KK-3q
 for qemu-devel@nongnu.org; Thu, 28 May 2026 15:38:20 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64SGtCr63203335
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 19:38:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 TsT2beYYQqdPa71adxanh8NmhSsvLPvCYFxHzZnGr+o=; b=XILzsh0IF8YiFZBZ
 icJMuVzpR+uEsHVhuEpGAAmtDOnHS6TVREMpcumOT7RZ2ZMUkSxFUUf40cV4Z70j
 Ga1625/3divTd4Yki3QcCG9nVqndhoFAvPOc9N3grfMSimVrFCEb8mnTh2S58HNj
 7FWNrmxkayCZSpNr2rEkQdNXh3t0HyGY7R/18nnqtM/kTVm5pbvf1orTOfUBMHYC
 yq8no0zYez4TvLmIeyAWx1jvjOq8JnL8vENlymUfmBqiXNWky2Vr3vvWTvpRenw7
 sEaPNSongGUslCjBEZTYNfilXHKjV7Xri6F4jM0mzFODwYgVnAxpqKC58ec/lNcb
 c5xd3w==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ee7ynmhe7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 19:38:17 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-1353ac304f3so18748727c88.0
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 12:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779997097; x=1780601897; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=TsT2beYYQqdPa71adxanh8NmhSsvLPvCYFxHzZnGr+o=;
 b=Y6lrzwvE0lriv1ElVGoXRFSVXS7j31J8W0rQon1m+gLr+j9EphkUlS2XU3IMIJuclo
 e1HxtAjMF6vgVwxTThtB+LFR1vKhEU2fzR/DD8ma4HYIRk3QcCZn489O54C5pob4cRh4
 7rLPquhDIXyBN/zDW4NeuPS9Iy0eXG0sargNX/SwTG/pr6JjU55vasPMTlXF/VtMmUnI
 ZqSV2mO2kvd3qQgEWNFtCnZb2RjBrbyf4BBbHAlL5nJLITEDI42EzynK4iL1fLSzbGay
 OYt2o2X2ZH6/RfL6N2pNBTea7ioU7vMMgV+SnTvnjzMUDw7qFTm4r/MnztF+O3yZeR+U
 2btA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779997097; x=1780601897;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TsT2beYYQqdPa71adxanh8NmhSsvLPvCYFxHzZnGr+o=;
 b=qioVHTl2ZQ4211EwG1cUoWteUdp4XswXl8Fteo+7IO6h28hNUDim3GjDHhouk2La1i
 yM22rh5q4Ji+ukqQfNDBso988mfW1Izzc9bANYGO3i7gOAeu6KDzVeN1c421qmv72p39
 QQy2k07Qy5vsvauJs28+AJsPkya2E/tN9krs+T4j6B1xz6RDc01PsW+p62Ed07Eq6xdM
 Wvj5pP2BEOqQENGyk0c0bd7SrqajFgb/OexU9iBDuGAGFZ9E3Cl/DtsJsZ6VRGvQ8Pfh
 CGeOZeA1v8rC9mnWU25IxmKnV7t+kkk5v2l0B7XDZdzM/rci4mgE63mUlIC9ctiO23Zy
 2UsA==
X-Forwarded-Encrypted: i=1;
 AFNElJ88jBdmn1najfdNuYcroYSGbnrms077dwJiLT6v7aGurL6Uy0ANp7bDCIV6CfathCR+2K5tKoHIAAqm@nongnu.org
X-Gm-Message-State: AOJu0YzTG0dT+nAghW0XFckaYRsy80UG6/J1HTWBMOGcXKiFqvEfRWvE
 l90AdfnB2tvU8PF2PW+BbSe0StoZNfFyX0WT34Bt+p7tUjiaQH0lUknZHAopGpwJxK7a78cXwS+
 i7hMUpEqY+t26ikGVPEc00lBp2fUAAz2ExiBoWeUPdT2XlLiMk5t4nnhZ8g==
X-Gm-Gg: Acq92OH3uhsY+M0GgAvIrC/ffDM42YYm2Q9m8lI+VPT3sFbV7CEN3tWoia6Gm8xzlQe
 wGltF5JieRPquuxwK18qDliwkz4vMmYY028gY+OenewxbJsjARrIb1mMjf1UgNNsvaM7cpm0kYo
 Ub0r9ypgjs3QM/hZg7bvAwsAzVZRAq5XVTDHnjlRhyjspwgaf+CDOmAkaatdSoAlTdW2wJwBTaC
 qRats2d2369+SjgNxRirjf22hSTxITrtMIvyHKreeA8U7FWVPfuX9goQ60NhX8r6kseK8TLUwLT
 vzeIbW8NVgjIY8NN+cUqkV8oJk9Ap5W+9nPzJKyvePu6ojYSXQiywZb1lEnJywgKdVVieTTA3S7
 SLCiwZ1PM+Qp/XQy4CBsltgR/mjHa9PUJB1Z0G50IhH0QAFLzux87M4CB6WU2A1r8gi8Em3GnaF
 jVAGczY+u1G+459ZLm5qBKm5XL
X-Received: by 2002:a05:7022:2529:b0:132:956b:3a3 with SMTP id
 a92af1059eb24-137a82533a7mr184951c88.10.1779997096768; 
 Thu, 28 May 2026 12:38:16 -0700 (PDT)
X-Received: by 2002:a05:7022:2529:b0:132:956b:3a3 with SMTP id
 a92af1059eb24-137a82533a7mr184925c88.10.1779997096204; 
 Thu, 28 May 2026 12:38:16 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-137a9ad6ebbsm110469c88.15.2026.05.28.12.38.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 May 2026 12:38:15 -0700 (PDT)
Message-ID: <d394c93d-86af-412a-ab42-274ee7567d7f@oss.qualcomm.com>
Date: Thu, 28 May 2026 12:38:14 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 07/12] hw/riscv/boot: Rewrite setup_rom_reset_vec()
 using load/store API
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Djordje Todorovic <Djordje.Todorovic@htecgroup.com>,
 Anton Johansson <anjo@rev.ng>, Weiwei Li <liwei1518@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Christoph Muellner <christoph.muellner@vrull.eu>
References: <20260527201348.29511-1-philmd@linaro.org>
 <20260527201348.29511-8-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260527201348.29511-8-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI4MDE5OCBTYWx0ZWRfXxQq+jJvAkttM
 zb81jTLfdIJp+WWecrtoyCaNjHNGmiNUp7wLxROcdBppE8uPOTRZUM6lwsqxqGxHHAP2PhtHVpq
 vMFAH9PmsI+/BqbXFVwN4NCU38VzXwiXKp9G440JolqiaJxKAlrl8epvKbG295V+9OreqwbO0eW
 CzBIO15QazRhmQNmw17RatFZ29pba/xjFxsTZ6+C/RwiCUILwWiYeJp2igCdmjxhEZF/SOft9L9
 bvIY9YahzYKJgz+H6wSuyHE6XFbNj8IDCmeJ8z+2NrhZca1girvoE9zkrQIz/tBGPJNiOy40Mcc
 tU1Bf3w0ya1cbLJiFkCdUuhQawvJmyMEmeWrw3SAW/4vSMOaRRnNaJHy1BnElFmpjl5JIBo/reg
 6ro/Iz/vyB4lWBzkDlwOx7WZFS2T+nmuvoz0rxBT0uVQM9lYWlWozuTVon95gddKhAgPrJrizQD
 Hwgsc+BzJKc9T8HjxVQ==
X-Proofpoint-ORIG-GUID: 6jgvsKEEjiLj7wmYIx9DuWGMeizFuI8V
X-Proofpoint-GUID: 6jgvsKEEjiLj7wmYIx9DuWGMeizFuI8V
X-Authority-Analysis: v=2.4 cv=EdL4hvmC c=1 sm=1 tr=0 ts=6a1899a9 cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=X6yYlNyqGR7QDSpYCfcA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=Kq8ClHjjuc5pcCNDwlU0:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-28_05,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 phishscore=0 clxscore=1015 bulkscore=0
 spamscore=0 adultscore=0 malwarescore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605280198
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

On 5/27/2026 1:13 PM, Philippe Mathieu-Daudé wrote:
> In order to make the following commits easier to review, do
> not pre-initialize the reset_vec[] array, fill each word one
> by one. Set the start and FDT load addresses using the load/
> store APIs.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  hw/riscv/boot.c | 53 ++++++++++++++++++++++---------------------------
>  1 file changed, 24 insertions(+), 29 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

