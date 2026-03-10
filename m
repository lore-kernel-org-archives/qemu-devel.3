Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C890FFD4F16
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 19:04:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w02MA-0008Pt-I6; Tue, 10 Mar 2026 15:03:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1w02M5-0008PL-6e; Tue, 10 Mar 2026 15:02:58 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1w02M1-0005Ji-UP; Tue, 10 Mar 2026 15:02:56 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62AHXrMV402979; Tue, 10 Mar 2026 19:02:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=nAsSkk
 uX6C/7H28f8s/q57j1IB6fKgBVYL1jjX7Ycmk=; b=Wb6SO4TN+6BJyGBdTMvYrC
 Xo0nNuM855IHVzXdwZ8HQY4sNGX/f9g3YySS96o3GBh0fb2eCf4RQn3Pzp34ZNTA
 Zl0BjoOwuq5Zye3ShNzVkciSzqxW/H8kWzkunrVFhRiG3AoFk0PXnqjwl7L4hbF8
 8bFw/FoPj7chEyqml/2SK4CpQwY9tGGcEkagoMYWhp23e8CGgUh2CDRu5UyhpY0+
 DXbvDwsvtaEu/uVBAd76wkTWcAghDZVNyOTI3BvoUCGAj07qT+Uh/Fzf5qQIkQ9q
 70QWYnBnWos/X7ZdSqrIJRqKtNvi/lfsnUSxd/k6/OIorVhKkeLGu/WLFbs7fzoQ
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4crcunc4ex-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 10 Mar 2026 19:02:37 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62AFosDj023030;
 Tue, 10 Mar 2026 19:02:36 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ct8ng3dsg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 10 Mar 2026 19:02:36 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 62AJ2W6349152492
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Mar 2026 19:02:32 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 43C762005A;
 Tue, 10 Mar 2026 19:02:32 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EBA6720065;
 Tue, 10 Mar 2026 19:02:27 +0000 (GMT)
Received: from [9.39.23.69] (unknown [9.39.23.69])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 10 Mar 2026 19:02:27 +0000 (GMT)
Message-ID: <9a658ec5-a167-4d0a-a08b-50ea90c40be0@linux.ibm.com>
Date: Wed, 11 Mar 2026 00:32:26 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] hw/core/loader: fix error handling for
 load_image_targphys callers
To: Trieu Huynh <vikingtc4@gmail.com>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>, Thomas Huth <huth@tuxfamily.org>,
 Laurent Vivier <laurent@vivier.eu>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, Bernhard Beschow <shentey@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Nicholas Piggin <npiggin@gmail.com>, Glenn Miles <milesg@linux.ibm.com>,
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-ppc@nongnu.org
References: <20260310182801.196443-1-viking4@gmail.com>
 <20260310182801.196443-2-viking4@gmail.com>
Content-Language: en-US
From: Aditya Gupta <adityag@linux.ibm.com>
In-Reply-To: <20260310182801.196443-2-viking4@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: _r_3knnPfssdt0XGAACnLTJICYyDVNiZ
X-Authority-Analysis: v=2.4 cv=Hp172kTS c=1 sm=1 tr=0 ts=69b06acd cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=p0WdMEafAAAA:8
 a=pGLkceISAAAA:8 a=VnNF1IyMAAAA:8 a=jxmMncFiRjKL0zWv-wwA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEwMDE2NiBTYWx0ZWRfX9/4hiN7Ht27g
 dPw3Uo87vTLeDwlNqXHDR1dz0kV31rJFRX1G1V0mg7dRfRRretZBCmBcUfkIpXY4loyQhTJkhTL
 5p+sXwu+upy/TJFsWSUR0VZm4sN3XAleaTnu+DzyI1/xNm2Wu43Cp8ZV91UCSv3GeOJNn2jKjZB
 MUyuqo1F5MFlfp+oCezeNFtJZa+pxnkcLHRUXO6EWDnlqmivcRKpiX3R6lucptYUxPt49kvlMMl
 FhB+pIoSUe3OPbPAXKcZXjiABEUMzB8MZbWXHL8skxAVR/51t5XwV/Pf8tBb1DamXpTohLWaoCJ
 JKxKYv6gplRAYbuptrxvfK0btOQ/jkAD7q82CbjunX8n6NruafCnA87VhJj7004rUS/bj0FrylB
 oyLIly2mC7NhJY8JxtGVgWarfG2OGGwOgoEhfnLZ29BiQYfIWvBrafXb/KLr/99n84VBjEk6fAt
 VzlDoD2a5qqIlDBuO/w==
X-Proofpoint-ORIG-GUID: VdiN7tC1WybPtXrl_4eRV3N90c6-CgWK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_04,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 spamscore=0 phishscore=0 clxscore=1011 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603100166
Received-SPF: pass client-ip=148.163.158.5; envelope-from=adityag@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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


On 10/03/26 23:57, Trieu Huynh wrote:
> From: Trieu Huynh <vikingtc4@gmail.com>
>
> Check return value of load_image_targphys() and return early on
> failure instead of continuing with invalid state.
> - Use ret < 0 to handle negative return value.
> - No functional changes.
>
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/413
> Signed-off-by: Trieu Huynh <vikingtc4@gmail.com>
>
> <...snip...>
>   
> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> index 1513575b8f..aecffb211b 100644
> --- a/hw/ppc/pnv.c
> +++ b/hw/ppc/pnv.c
> @@ -1068,14 +1068,21 @@ static void pnv_init(MachineState *machine)
>           exit(1);
>       }
>   
> -    load_image_targphys(fw_filename, pnv->fw_load_addr, FW_MAX_SIZE,
> -                        &error_fatal);
> +    if (load_image_targphys(fw_filename, pnv->fw_load_addr, FW_MAX_SIZE,
> +                        &error_fatal) < 0) {
> +        error_report("Could not load OPAL firmware '%s'", fw_filename);
> +        exit(1);
> +    }
>       g_free(fw_filename);
>   
>       /* load kernel */
>       if (machine->kernel_filename) {
> -        load_image_targphys(machine->kernel_filename,
> -                            KERNEL_LOAD_ADDR, KERNEL_MAX_SIZE, &error_fatal);
> +        if (load_image_targphys(machine->kernel_filename,
> +                        KERNEL_LOAD_ADDR, KERNEL_MAX_SIZE, &error_fatal) < 0) {
> +            error_report("Could not load kernel '%s'",
> +                         machine->kernel_filename);
> +            exit(1);
> +        }
>       }
>   
>       /* load initrd */
> @@ -1084,6 +1091,11 @@ static void pnv_init(MachineState *machine)
>           pnv->initrd_size = load_image_targphys(machine->initrd_filename,
>                                                  pnv->initrd_base,
>                                                  INITRD_MAX_SIZE, &error_fatal);
> +        if (pnv->initrd_size < 0) {
> +            error_report("Could not load initrd '%s'",
> +                         machine->initrd_filename);
> +            exit(1);
> +        }
>       }
>   
>       /* load dtb if passed */
>

Thanks for the patch, but as balaton said, atleast in this case, the 
condition is not needed since it's have error_fatal.

Previously the if checks you added used to there, these were recently 
changed to not have the conditions,
by this patch from vishal:

     commit cd274e83d50ba52ede62d2a8ea0f0ae7cb1ef469
     Author: Vishal Chourasia <vishalc@linux.ibm.com>
     Date:   Fri Oct 24 18:36:03 2025 +0530

     hw/ppc: Pass error_fatal to load_image_targphys()

     Pass error_fatal to load_image_targphys() calls in ppc machine 
initialization
     to capture detailed error information when loading firmware, kernel,
     and initrd images.

Thanks,

- Aditya G



