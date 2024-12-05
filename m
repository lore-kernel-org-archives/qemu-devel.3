Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FBE4E7716C
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2024 11:47:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJAJT-0007DP-JG; Thu, 05 Dec 2024 06:46:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_llindhol@quicinc.com>)
 id 1tJAJQ-0007D2-O0
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 06:46:28 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_llindhol@quicinc.com>)
 id 1tJAJO-0006RF-L4
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 06:46:28 -0500
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B54lE7f032006;
 Thu, 5 Dec 2024 11:46:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 9cYjF++fvG+zwsfGWkGcOiVRR7T2i8RkGAetpXJbKms=; b=hXCmbSwOQTM7PPHH
 8wpU3EWj1zNvnCRcKodxmB+t/AJqqYg4RWdKqVlMMEYvTlRkK2ZvoNduvAZTrWxF
 IIDn4INdrkOBD4mM9aZ8QzMRNAARwYCoQera+j4KdXHZAP5FvSFcZSx+RNQpIgVM
 iU09l0vrMXM/BDVRYTAwu2JCzb+N6xS9lNjMiIHCLLyLrPl65vuSZBzH8xc5OQNg
 TZfBC5BTwXZ1jec3HXIWcFytSc6ntZPkdq7kU8xdR9PVC/vY/Gq1SzuIRC/buq7x
 fmkMPBCh3i/J9TgA6a2DEAxGnUL0WRW7BanSdIxSyD6r9mryRB10XTgbwYAvbbsQ
 mP/xrw==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com
 [199.106.103.254])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43a3faxbc5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 05 Dec 2024 11:46:23 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com
 [10.45.79.139])
 by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4B5BkL32014327
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 5 Dec 2024 11:46:21 GMT
Received: from [10.111.132.184] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 5 Dec 2024
 03:46:11 -0800
Message-ID: <59d52f27-2374-414e-9aa9-6ffb0879f3fe@quicinc.com>
Date: Thu, 5 Dec 2024 11:45:02 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: update email address for Leif Lindholm
To: Leif Lindholm <leif.lindholm@oss.qualcomm.com>, <qemu-devel@nongnu.org>
CC: Peter Maydell <peter.maydell@linaro.org>, Radoslaw Biernacki
 <rad@semihalf.com>, Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
References: <20241205114047.1125842-1-leif.lindholm@oss.qualcomm.com>
Content-Language: en-GB
From: Leif Lindholm <quic_llindhol@quicinc.com>
In-Reply-To: <20241205114047.1125842-1-leif.lindholm@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-ORIG-GUID: mIp6p_IUT2pC5CxJvE9JA3JRz42Uh722
X-Proofpoint-GUID: mIp6p_IUT2pC5CxJvE9JA3JRz42Uh722
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0
 spamscore=0 mlxscore=0 suspectscore=0 adultscore=0 mlxlogscore=627
 lowpriorityscore=0 clxscore=1011 priorityscore=1501 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412050085
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=quic_llindhol@quicinc.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

(oops, +Marcin)

On 2024-12-05 11:40, Leif Lindholm wrote:
> From: Leif Lindholm <quic_llindhol@quicinc.com>
> 
> I'm migrating to Qualcomm's new open source email infrastructure, so
> update my email address, and update the mailmap to match.
> 
> Signed-off-by: Leif Lindholm <leif.lindholm@oss.qualcomm.com>

Reviewed-by: Leif Lindholm <quic_llindhol@quicinc.com>

> ---
>   .mailmap    | 5 +++--
>   MAINTAINERS | 2 +-
>   2 files changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/.mailmap b/.mailmap
> index 727ce204b2..5f6df414e1 100644
> --- a/.mailmap
> +++ b/.mailmap
> @@ -87,8 +87,9 @@ Huacai Chen <chenhuacai@kernel.org> <chenhc@lemote.com>
>   Huacai Chen <chenhuacai@kernel.org> <chenhuacai@loongson.cn>
>   James Hogan <jhogan@kernel.org> <james.hogan@imgtec.com>
>   Juan Quintela <quintela@trasno.org> <quintela@redhat.com>
> -Leif Lindholm <quic_llindhol@quicinc.com> <leif.lindholm@linaro.org>
> -Leif Lindholm <quic_llindhol@quicinc.com> <leif@nuviainc.com>
> +Leif Lindholm <leif.lindholm@oss.qualcomm.com> <quic_llindhol@quicinc.com>
> +Leif Lindholm <leif.lindholm@oss.qualcomm.com> <leif.lindholm@linaro.org>
> +Leif Lindholm <leif.lindholm@oss.qualcomm.com> <leif@nuviainc.com>
>   Luc Michel <luc@lmichel.fr> <luc.michel@git.antfield.fr>
>   Luc Michel <luc@lmichel.fr> <luc.michel@greensocs.com>
>   Luc Michel <luc@lmichel.fr> <lmichel@kalray.eu>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index aaf0505a21..9ae6a78ae9 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -915,7 +915,7 @@ F: include/hw/ssi/imx_spi.h
>   SBSA-REF
>   M: Radoslaw Biernacki <rad@semihalf.com>
>   M: Peter Maydell <peter.maydell@linaro.org>
> -R: Leif Lindholm <quic_llindhol@quicinc.com>
> +R: Leif Lindholm <leif.lindholm@oss.qualcomm.com>
>   R: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
>   L: qemu-arm@nongnu.org
>   S: Maintained


