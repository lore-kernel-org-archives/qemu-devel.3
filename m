Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA36FC27C43
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2024 13:12:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCJ5c-0007Nc-13; Wed, 29 May 2024 09:11:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_llindhol@quicinc.com>)
 id 1sCJ5Z-0007MV-PM; Wed, 29 May 2024 09:11:33 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_llindhol@quicinc.com>)
 id 1sCJ5X-0003by-Rd; Wed, 29 May 2024 09:11:33 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44TD8aCX020826;
 Wed, 29 May 2024 13:11:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 tVvy+wvXznPZBbhasBYzCLoBByeqATo5zBWCfKNNZDE=; b=RofHXOl3iS6xWDBb
 lN7BP8NpJs6Ab/EQck54ICVTsVt1K8Ffjwxu3epu6A6rhhLrqBawlLyuJxHH/k/N
 lrD8KhvXuzit32BvDNM+eIaU2iTD0U4zfvhcwOgkL50xEuGbDf3WW0d4RvLTmCyu
 HgeviHaAKBlLyNWTK0HkiVUOZI3GZzIXstdQChE/sQ1snHTDkJHk6yvdz4cDwMT1
 cdWPD/BCUj4Xo9SS8x4CXpnB5CsO1X1qhedH61kCscM7I9/1Xz3gv0OA9UvFmzXx
 LZrxDt39kRyVSG4KfTLNMH834vFeNOqxYhpz+ARnGIQ5S9FZNk09P68omuLWJ66m
 ih3ZUA==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com
 [199.106.103.254])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yba2h8xx0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 29 May 2024 13:11:26 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com
 [10.45.79.139])
 by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44TDBQr5009635
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 29 May 2024 13:11:26 GMT
Received: from [10.111.132.194] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 29 May
 2024 06:11:24 -0700
Message-ID: <ce59d92a-cae2-42b1-b9b7-d482f6d2ef66@quicinc.com>
Date: Wed, 29 May 2024 14:11:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] arm/sbsa-ref: move to Neoverse-N2 as default
To: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>, <qemu-devel@nongnu.org>
CC: Peter Maydell <peter.maydell@linaro.org>, Radoslaw Biernacki
 <rad@semihalf.com>, <qemu-arm@nongnu.org>
References: <20240523165353.6547-1-marcin.juszkiewicz@linaro.org>
Content-Language: en-GB
From: Leif Lindholm <quic_llindhol@quicinc.com>
In-Reply-To: <20240523165353.6547-1-marcin.juszkiewicz@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-GUID: TSDSiOcnQZMP2h2aEjS21tUF2IYh8LI6
X-Proofpoint-ORIG-GUID: TSDSiOcnQZMP2h2aEjS21tUF2IYh8LI6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-29_10,2024-05-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 adultscore=0
 malwarescore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 phishscore=0 bulkscore=0 mlxscore=0 lowpriorityscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2405290090
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=quic_llindhol@quicinc.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 2024-05-23 17:53, Marcin Juszkiewicz wrote:
> Moving to Neoverse-N2 gives us several cpu features to use for expanding
> our platform:
> 
> - branch target identification
> - pointer authentication
> - RME for confidential computing
> - RNG for EFI_PROTOCOL_RNG
> - SVE being enabled by default
> 
> We do not go for "max" as default to have stable set of features enabled
> by default. It is still supported and can be selected with "--cpu"
> argument.

I still want to move to max at some point :)
But this is a good improvement for now.

Reviewed-by: Leif Lindholm <quic_llindhol@quicinc.com>

> Signed-off-by: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
> ---
>   hw/arm/sbsa-ref.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
> index 57c337fd92..e884692f07 100644
> --- a/hw/arm/sbsa-ref.c
> +++ b/hw/arm/sbsa-ref.c
> @@ -891,7 +891,7 @@ static void sbsa_ref_class_init(ObjectClass *oc, void *data)
>   
>       mc->init = sbsa_ref_init;
>       mc->desc = "QEMU 'SBSA Reference' ARM Virtual Machine";
> -    mc->default_cpu_type = ARM_CPU_TYPE_NAME("neoverse-n1");
> +    mc->default_cpu_type = ARM_CPU_TYPE_NAME("neoverse-n2");
>       mc->valid_cpu_types = valid_cpu_types;
>       mc->max_cpus = 512;
>       mc->pci_allow_0_address = true;


