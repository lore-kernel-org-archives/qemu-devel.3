Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D4EEC25B75
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 13:46:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sE80C-0003xh-Jj; Mon, 03 Jun 2024 09:45:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_llindhol@quicinc.com>)
 id 1sE80A-0003x4-Vs; Mon, 03 Jun 2024 09:45:31 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_llindhol@quicinc.com>)
 id 1sE809-0004O6-24; Mon, 03 Jun 2024 09:45:30 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 453AkJEN008725;
 Mon, 3 Jun 2024 13:45:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Vrc3zH2saHzPO80cYyYmvOtq7S4VVkmPp9w28dycxf0=; b=AQ0BwBF+vsefu8Mw
 JwlWgYXZbTn/sXJCSWkaIAF2hExJ/gWZuOKgcoJk7PvC0ODgzWTWFNaVaeT+lA1/
 /FDtC2LXtVGXVMzanp9njYsgCEKx3tiaHdAAaEPibjSYex5V/sx/wrnbl2v3gbiI
 ODggqplALwO8V64VqD0Wp4cUQWEjkqiUi15PhVG9cFD4nS4rpeLGyS4n4wPdFf7C
 HcsTOjdWuu7cIOKG722CLIdBMoWQf2Ucgt+2KnGSOKJPAEC8BNfVWt2bUC+dEO/v
 xy0E/MlgnSdIxAtXOLIaj8pqpL4yNW595vmwUuA46MeqRyU5zl4KkpDmyNVEb2qq
 FCdFFA==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com
 [199.106.103.254])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yfw6qm294-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 03 Jun 2024 13:45:05 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com
 [10.45.79.139])
 by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 453Dj4ek021230
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 3 Jun 2024 13:45:04 GMT
Received: from [10.111.137.228] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 3 Jun 2024
 06:45:03 -0700
Message-ID: <5fcb50de-6a6d-4f97-b384-a79d99508a21@quicinc.com>
Date: Mon, 3 Jun 2024 14:45:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] hw/arm/sbsa-ref: switch to 1GHz timer frequency
To: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>, <qemu-devel@nongnu.org>
CC: Peter Maydell <peter.maydell@linaro.org>, Radoslaw Biernacki
 <rad@semihalf.com>, <qemu-arm@nongnu.org>
References: <20240531093729.220758-1-marcin.juszkiewicz@linaro.org>
 <20240531093729.220758-2-marcin.juszkiewicz@linaro.org>
Content-Language: en-GB
From: Leif Lindholm <quic_llindhol@quicinc.com>
In-Reply-To: <20240531093729.220758-2-marcin.juszkiewicz@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-GUID: BfDXCE8YiKpea6Y1Oiy9m9K5WkgMMIUh
X-Proofpoint-ORIG-GUID: BfDXCE8YiKpea6Y1Oiy9m9K5WkgMMIUh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-06-03_09,2024-05-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 bulkscore=0 mlxlogscore=999 clxscore=1015 impostorscore=0 malwarescore=0
 mlxscore=0 adultscore=0 lowpriorityscore=0 suspectscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406030114
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

On 2024-05-31 10:37, Marcin Juszkiewicz wrote:
> Updated firmware for QEMU CI is already in merge queue so we can move
> platform to be future proof.
> 
> All supported cpus work fine with 1GHz timer frequency when firmware is
> fresh enough.
> 
> Signed-off-by: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>

Reviewed-by: Leif Lindholm <quic_llindhol@quicinc.com>

Thanks!

> ---
>   hw/arm/sbsa-ref.c | 12 ++++--------
>   1 file changed, 4 insertions(+), 8 deletions(-)
> 
> diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
> index 57c337fd92..7bd6898edf 100644
> --- a/hw/arm/sbsa-ref.c
> +++ b/hw/arm/sbsa-ref.c
> @@ -62,16 +62,12 @@
>   
>   /*
>    * Generic timer frequency in Hz (which drives both the CPU generic timers
> - * and the SBSA watchdog-timer). Older versions of the TF-A firmware
> - * typically used with sbsa-ref (including the binaries in our Avocado test
> - * Aarch64SbsarefMachine.test_sbsaref_alpine_linux_max_pauth_impdef
> - * assume it is this value.
> + * and the SBSA watchdog-timer). Older (<2.11) versions of the TF-A firmware
> + * assumed 62.5MHz here.
>    *
> - * TODO: this value is not architecturally correct for an Armv8.6 or
> - * better CPU, so we should move to 1GHz once the TF-A fix above has
> - * made it into a release and into our Avocado test.
> + * Starting with Armv8.6 CPU 1GHz timer frequency is mandated.
>    */
> -#define SBSA_GTIMER_HZ 62500000
> +#define SBSA_GTIMER_HZ 1000000000
>   
>   enum {
>       SBSA_FLASH,


