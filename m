Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07701C5DF89
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2026 13:33:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxPMX-0004qX-Kb; Fri, 21 Aug 2026 09:32:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hbathini@linux.ibm.com>)
 id 1wxPMU-0004pm-TE; Fri, 21 Aug 2026 09:32:47 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hbathini@linux.ibm.com>)
 id 1wxPMT-0007j9-8U; Fri, 21 Aug 2026 09:32:46 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67LD1a9w454640; Fri, 21 Aug 2026 13:32:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=I4vM9R
 k7rwZDfOhH5yuofptCYkRws1LDFgCpihkqac4=; b=syJ12dVgHF1zfuBeeSWUZ+
 Mz2FCTTeg8Yya1ZB9vnQ/Iq9YRmZC6SINXlERNzm/mkBHZ/4KVzAhocs2URbpxNV
 vZB0KI6YYbZqZS2y4ZjTb4C83OdiPWT7Dxwyz13B4LZnNqns2WcDQjZGUK8p2fHx
 cCWzdBRjPo4YUi2VDP8HG7JXe3UwxFmThO+Dghz0Wlrsh9uOPb5evaUzcdOI0bYB
 JW5fA5yKZROGjM4Ykmxsl/3dAXxoxwvMeZb0pXIt8JPLbMaGBsAmGvYkPc/6etLr
 p8gVgQUqJvlp88Ir7FJnsY1sTkx/VJANhiGv7DjA+lXqui/nuV8QcB8WpyY7Sk1Q
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g4yu2hk4f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 21 Aug 2026 13:32:39 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67LDBOiD000762;
 Fri, 21 Aug 2026 13:32:38 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g32twmya5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 21 Aug 2026 13:32:38 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67LDWYnH49611108
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 21 Aug 2026 13:32:34 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 41B0520043;
 Fri, 21 Aug 2026 13:32:34 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F059B20040;
 Fri, 21 Aug 2026 13:32:31 +0000 (GMT)
Received: from [9.39.16.245] (unknown [9.39.16.245])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 21 Aug 2026 13:32:31 +0000 (GMT)
Message-ID: <043b3565-593a-41dc-87c3-08d8cd7e108d@linux.ibm.com>
Date: Fri, 21 Aug 2026 19:02:30 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] MAINTAINERS: add dedicated PowerPC RAS section
To: Shivang Upadhyay <shivangu@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
Cc: adityag@linux.ibm.com, harshpb@linux.ibm.com, mahesh@linux.ibm.com,
 npiggin@gmail.com, rathc@linux.ibm.com, sourabhjain@linux.ibm.com,
 vaibhav@linux.ibm.com
References: <20260819193757.1072909-1-shivangu@linux.ibm.com>
 <20260819193757.1072909-2-shivangu@linux.ibm.com>
Content-Language: en-US
From: Hari Bathini <hbathini@linux.ibm.com>
In-Reply-To: <20260819193757.1072909-2-shivangu@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=AdqB2XXG c=1 sm=1 tr=0 ts=6a885377 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=69wJf7TsAAAA:8 a=KKAkSRfTAAAA:8 a=S56xvJB5AAAA:8 a=FRK-AdzV_e937eZvcnYA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=Fg1AiH1G6rFz08G2ETeA:22
 a=cvBusfyB2V15izCimMoJ:22 a=MH9Ivq0PDQRhlrFuIVvX:22
X-Proofpoint-GUID: Lp_cCeJ7ystZ8nd79WTIObfIBPNdvHyx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIxMDEwNCBTYWx0ZWRfX+rpx8d2hUIIE
 eULq/UvoyuRVPq+y6DNyD/c03AEkr5Dg3skmrTWsbokAzRTaV+ccNmmDydTFmX4YBeNNd+KgfY+
 xlY1KeTRsgIFrZsvHdKhs6AP13qK0lhIavxNpiQct+2bGj7BW8CDFP4lzu8NdrXLBbNoWLzOvk8
 QW21vL6vkVoYicz0x5Zg5fg2vY25k6o+/mb78EXT1MppYjw7A/t/pmV6senhUhfIitFh/19xaXw
 HxKOlVpimgKGliH5fbCoH5tSRbCGcNe6L6jot9SDgrhH2rFqBRb17w3HLbKaSESX0b/aez5RmD8
 ZJ8vHRaJ3GZJlCT1fAM0ncPCbm12G2RcpeZh5/+01Lqy5CfigbVe4pyNQ6wuupwyQH/6e8nO+9m
 eqhUWGYtN36+FwxJaEysFvwKHEc3O5GidNUPBI4cIYAVxaWaqihmBV9QKuUIkDfoPsSvVFSR8oa
 SDxLpcrEuvgkVryFOlg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIxMDEwNCBTYWx0ZWRfX7vwNTzqs1LGe
 k2c/oEt6hQeYVtgSkR38OtnH68ktiVl1HXL1IPp0BNfHpkHYN4hGyrqcUXIwZHF005WuawSKzzr
 wWqq491bj79GuJY9o+ISfo/0faOoEHc=
X-Proofpoint-ORIG-GUID: UVt5T6L4NPRVLttKbFHEU6CrK97Sj4xP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-21_04,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 priorityscore=1501 suspectscore=0 malwarescore=0
 impostorscore=0 adultscore=0 bulkscore=0 lowpriorityscore=0 phishscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608210104
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=hbathini@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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



On 20/08/26 1:07 am, Shivang Upadhyay wrote:
> Introduce a new "PowerPC RAS (Reliability, Availability and
> Serviceability)" entry in the PowerPC Machines block, replacing the
> existing Fadump/MPIPL sections. Retaining the maintainer and
> reviewer entries from Fadump/MPIPL sections for this broader umbrella.
> 
> Currently most of RAS related code sits in spapr_rtas.c, So Adding
> it to PowerPC RAS section. Additionally adding spapr_events.c, as it
> implements RTAS error logging infrastructure and spapr_pci_vfio.c, since
> its all EEH related code.
> 
> Acked-by: Sourabh Jain <sourabhjain@linux.ibm.com>
> Acked-by: Aditya Gupta <adityag@linux.ibm.com>
> Signed-off-by: Shivang Upadhyay <shivangu@linux.ibm.com>
> ---
>   MAINTAINERS | 32 +++++++++++++++-----------------
>   1 file changed, 15 insertions(+), 17 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index b51f5c3e60..a2a80c789c 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1762,6 +1762,21 @@ F: include/hw/ppc/vof*
>   F: pc-bios/vof/*
>   F: pc-bios/vof*
>   

> +PowerPC RAS (Reliability, Availability and Serviceability)

With the scope now expanded to include additional files, I’m not sure
I’ll be able to review everything given my current workload. However,
I should be able to review the FADump-specific patches.

With that said:

Acked-by: Hari Bathini <hbathini@linux.ibm.com>

> +M: Aditya Gupta <adityag@linux.ibm.com>
> +R: Sourabh Jain <sourabhjain@linux.ibm.com>
> +R: Hari Bathini <hbathini@linux.ibm.com>

> +L: qemu-ppc@nongnu.org
> +S: Maintained
> +F: hw/ppc/spapr_events.c
> +F: hw/ppc/spapr_fadump.c
> +F: hw/ppc/spapr_pci_vfio.c
> +F: hw/ppc/spapr_rtas.c
> +F: hw/ppc/pnv_mpipl.c
> +F: include/hw/ppc/spapr_fadump.h
> +F: include/hw/ppc/pnv_mpipl.h
> +F: tests/functional/ppc64/test_fadump.py
> +
>   RISC-V Machines
>   ---------------
>   OpenTitan
> @@ -3386,23 +3401,6 @@ F: scripts/coccinelle/remove_local_err.cocci
>   F: scripts/coccinelle/use-error_fatal.cocci
>   F: scripts/coccinelle/errp-guard.cocci
>   
> -Firmware Assisted Dump (fadump) for sPAPR (pseries)
> -M: Aditya Gupta <adityag@linux.ibm.com>
> -R: Sourabh Jain <sourabhjain@linux.ibm.com>
> -S: Maintained
> -F: include/hw/ppc/spapr_fadump.h
> -F: hw/ppc/spapr_fadump.c
> -F: tests/functional/ppc64/test_fadump.py
> -
> -Memory-Preserving Initial Program Load (MPIPL) for PowerNV
> -M: Aditya Gupta <adityag@linux.ibm.com>
> -R: Hari Bathini <hbathini@linux.ibm.com>
> -R: Sourabh <sourabhjain@linux.ibm.com>
> -S: Maintained
> -F: include/hw/ppc/pnv_mpipl.h
> -F: hw/ppc/pnv_mpipl.c
> -F: tests/functional/ppc64/test_fadump.py
> -
>   GDB stub
>   M: Alex Bennée <alex.bennee@linaro.org>
>   R: Philippe Mathieu-Daudé <philmd@mailo.com>


