Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD916CD3427
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2026 15:11:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKHQB-0006Bf-9j; Tue, 05 May 2026 11:10:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1wKHQ9-0006Aw-3T; Tue, 05 May 2026 11:10:49 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1wKHQ7-0000ci-D7; Tue, 05 May 2026 11:10:48 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6457vJ4u2807278; Tue, 5 May 2026 15:10:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=bQV91A
 qoQMLnmtyxOoCQnQdw+JDmR1+8i/tn9KjYbV0=; b=pwTx/aOf1YpU6q4oP8xb8y
 RueC/IuE+hY/z/PhFONRmvvleJpi7mPOtln8ll6LQrcTnnehBW829gH++47zo6GN
 V1deXMQbYElrbqJ3TnR62O8eyagOy0m+EVKGKIsrzjlub+GZsBz3qnsgd9ICvWkL
 QQUyjdFEcko8d7dYjuGwex4svqKj4OmY8HzippG7zvYW1I5JjeBkrcKZkiAR/Gkp
 MosLGADOSzUvF1BqYGSOEq0TqIEMn+P2+WDFchg1LZelarzWlV0SYhRkLXc21Wvp
 HBRVt/Yv1X7wcR1zeFstHasbM6OxTE0CKDeSs+LD7aH8qGwgGz7yOKv9F54jWMwA
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dw9y4m0en-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 05 May 2026 15:10:37 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 645F9ZAS025389;
 Tue, 5 May 2026 15:10:37 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dww3h23s0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 05 May 2026 15:10:37 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 645FAaFA64881148
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 5 May 2026 15:10:36 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 17DC158052;
 Tue,  5 May 2026 15:10:36 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DFAA558050;
 Tue,  5 May 2026 15:10:28 +0000 (GMT)
Received: from [9.124.208.117] (unknown [9.124.208.117])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  5 May 2026 15:10:28 +0000 (GMT)
Message-ID: <51770bf3-b141-4cf5-b935-4f5fdcfcb98f@linux.ibm.com>
Date: Tue, 5 May 2026 20:40:26 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "hw/ppc: Deprecate 405 CPUs"
Content-Language: en-GB
To: Glenn Miles <milesg@linux.ibm.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Laurent Vivier <laurent@vivier.eu>, Chinmay Rath <rathc@linux.ibm.com>
References: <20260505144621.1308457-1-milesg@linux.ibm.com>
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <20260505144621.1308457-1-milesg@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA1MDE0NSBTYWx0ZWRfX2OusdetbuvRP
 6CcIX39yBLGqNGSz/+lG4uKJivbqPTEYWAVMqfv0Khe6Y+9RNhp+kS0TMjdLMus93u9X2se9HB9
 mJI6dhnDD8uix1dPDnTuZn8H8O19Y/eAAA40fS4hYwnM4pplw9c+fSQg56iwm4LobT8ovyDIMKR
 9KGX36xtoBPbvgAkGSCBimMqx4yVHCKOuLpAUoN3lOSIE5p1DbWcr4F/tAj9kSpleSpN5TfWT9E
 bnWnNSipDLaB+kclDCEgwjr6ps+1Kr4DisQyRO5hVvHeponLKPn9P6JxSztmnb8sl8mDP5jYKLS
 SkwgzcdzXoAWfzYr6B2RfKz626WERcpTYN2CyuDb7+mLcyToFk7rcHYuV+KHFgRaFmB3t0cGcTE
 ehtM8HlJttRy3DaFcIMervGgJVNJToyV5+Yqi5gNkQKC+7fZnKY/a2dlFRSlYwCeC1k3HZD7bRc
 QrUmLRv2fp0wqXH0ogw==
X-Authority-Analysis: v=2.4 cv=J4GaKgnS c=1 sm=1 tr=0 ts=69fa086e cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=f7IdgyKtn90A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22
 a=VnNF1IyMAAAA:8 a=JdDNI7hCvnHmHIzuKtEA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 7YHlTxMiG0uwzaFkUgVLVc2wZCk8HsUF
X-Proofpoint-ORIG-GUID: TkleTPAqvPgltNp0-FF0N2qw26XZqYLg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_02,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 malwarescore=0 bulkscore=0 suspectscore=0
 priorityscore=1501 spamscore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605050145
Received-SPF: pass client-ip=148.163.158.5; envelope-from=harshpb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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



On 05/05/26 8:16 pm, Glenn Miles wrote:
> This reverts commit 52f0b59ec6b780f2a3e162d5862b90b406fa4697.
> 
> The PowerPC 405 CPU is used by the PPE42 CPU which was added to
> QEMU v10.2.  The PPE42 CPU is basically a stripped down version
> of the PowerPC 405 CPU and is used by the Power9, Power10, and
> Power11 CPUs as an embedded processor to handle various tasks.
> Also, IBM has plans to use the PowerPC 405 CPU model within a
> year to model the On Chip Controller (OCC), which has an embedded
> PPC405 CPU.  Therefore, this patch removes the PowerPC 405 CPU
> from the deprecated list.
> 
> Signed-off-by: Glenn Miles <milesg@linux.ibm.com>

Acked-by: Harsh Prateek Bora <harshpb@linux.ibm.com>

> 
> ---
>   docs/about/deprecated.rst | 9 ---------
>   1 file changed, 9 deletions(-)
> 
> diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
> index 10de10dc23..3639000af2 100644
> --- a/docs/about/deprecated.rst
> +++ b/docs/about/deprecated.rst
> @@ -209,15 +209,6 @@ in the QEMU object model anymore. ``Sun-UltraSparc-IIIi+`` and
>   but for consistency these will get removed in a future release, too.
>   Use ``Sun-UltraSparc-IIIi-plus`` and ``Sun-UltraSparc-IV-plus`` instead.
>   
> -PPC 405 CPUs (since 10.0)
> -'''''''''''''''''''''''''
> -
> -The PPC 405 CPU has no known users and the ``ref405ep`` machine was
> -removed in QEMU 10.0. Since the IBM POWER [8-11] processors uses an
> -embedded 405 for power management (OCC) and other internal tasks, it
> -is theoretically possible to use QEMU to model them. Let's keep the
> -CPU implementation for a while before removing all support.
> -
>   Power8E and Power8NVL CPUs and corresponding Pnv chips (since 10.1)
>   '''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
>   


