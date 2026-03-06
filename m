Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B346F01826
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 10:55:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vySpV-0008Aa-40; Fri, 06 Mar 2026 05:54:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hbathini@linux.ibm.com>)
 id 1vySpT-000897-Pm; Fri, 06 Mar 2026 05:54:47 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hbathini@linux.ibm.com>)
 id 1vySpS-0008VI-EN; Fri, 06 Mar 2026 05:54:47 -0500
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6268b3Lx2188183; Fri, 6 Mar 2026 10:54:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=NiFYH4
 xaXq38MRxHq5CuJWP2oDAeLeyAPE2eW0oGegk=; b=ntgIQLK8NFtYPOO37l0dhq
 +qDgzVV4ulJOFsIytxcEb8eIxHv39dkLFNDyHkC/jNwJgotcxWLismEXD4qyxTQH
 C7jG0p/ruLUeu+4YWiCkDkWnckNoxITTszvNVvcUmutnYa3gBufJZN1I81KJOAi4
 y0JUF0a1nj09osTBkIMGYcN/+uKLkSjoEeSdSGsGorI8Bu13jAPJqqOD9cStYNGo
 nZMWuYdOIoM9WlQlSCaRVCQKGFEUSZ0U9ij04zFUwvX2t2LIihVbBnT9MwEQtIL6
 Z7lYOx4ezJ8ftDTBsmHHs79uG6tlNqVRlpqcK/W8zxIThHEKkrPhHHHw+HFOSJLg
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cksk47hh6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 06 Mar 2026 10:54:44 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 6267k8sq029748;
 Fri, 6 Mar 2026 10:54:43 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cmapsfmdm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 06 Mar 2026 10:54:43 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 626AscYR44106034
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 6 Mar 2026 10:54:38 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 69B0920043;
 Fri,  6 Mar 2026 10:54:38 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C096820040;
 Fri,  6 Mar 2026 10:54:36 +0000 (GMT)
Received: from [9.78.106.17] (unknown [9.78.106.17])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  6 Mar 2026 10:54:36 +0000 (GMT)
Message-ID: <ced81a3c-41d0-404e-a910-43dbe76a1112@linux.ibm.com>
Date: Fri, 6 Mar 2026 16:24:35 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 10/10] MAINTAINERS: Add entry for MPIPL (PowerNV)
To: Aditya Gupta <adityag@linux.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Sourabh Jain <sourabhjain@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Miles Glenn <milesg@linux.ibm.com>, Chinmay Rath <rathc@linux.ibm.com>,
 Shivang Upadhyay <shivangu@linux.ibm.com>
References: <20260225124633.1841222-1-adityag@linux.ibm.com>
 <20260225124633.1841222-11-adityag@linux.ibm.com>
Content-Language: en-US
From: Hari Bathini <hbathini@linux.ibm.com>
In-Reply-To: <20260225124633.1841222-11-adityag@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: MfdCrVUbsF-6xitG1vFeXo_N-V3ZoEqu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA2MDEwMSBTYWx0ZWRfX43th2O/LvGfl
 TpvjxK7uWJOFlbYIQcuo8rEs0qQsK7b0bN4CLIpO8tm89eQhxdckRos63eUeift4qO50f68gZDE
 y1eiYcI7hqM57BWtYC5RJja0REYR/RBJ8vKS59Mv5tJqt2YS0jIBu3DZr3w270fXDUMW+u1NPka
 tgK+alYnJGXRgYp390f8wNtnyx9GxEdfVpsDX28FO8TikHX0U2L8YYR3DYcTQwUdggza9/8LoW2
 qarxBU1YkG6YAZmdwYF1/oaWjXfTQSJG+v0GbD98Ri3oaBPTao7u/tdXJV1KyKIPXlblQZpfmVc
 bHmCajVDvo464k7LgdIVmPW5rTU+revSsJ8dWmAknFFUd/TQeG/i/xHieC+jUBKkwpb3oYTY12V
 Z0OIrNZCe9ZZhvSwc4eJCmMBnV1c6Qyi90UyuEMtf2cMsOJcEi9Krz9J7Kxsq0hrQXCjXqTKln6
 hOwHnISrapicnmrf8gw==
X-Authority-Analysis: v=2.4 cv=csCWUl4i c=1 sm=1 tr=0 ts=69aab274 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=KKAkSRfTAAAA:8 a=fyyUhb9IhzwmOEVt19AA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: Oq2MXIiwD3boi1hsaxwXoyMavggJXu3b
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-06_03,2026-03-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 suspectscore=0 malwarescore=0 adultscore=0
 clxscore=1015 bulkscore=0 phishscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603060101
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=hbathini@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -11
X-Spam_score: -1.2
X-Spam_bar: -
X-Spam_report: (-1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.892, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.622,
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



On 25/02/26 6:16 pm, Aditya Gupta wrote:
> Add maintainer and reviewer for MPIPL subsystem.
> 

Couple of minor nits in patch 2 & 7.
None the less, for the series...

Reviewed-by: Hari Bathini <hbathini@linux.ibm.com>

> Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
> ---
>   MAINTAINERS | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 233d2a5e71ff..f536356faf49 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3289,6 +3289,14 @@ F: include/hw/ppc/spapr_fadump.h
>   F: hw/ppc/spapr_fadump.c
>   F: tests/functional/ppc64/test_fadump.py
>   
> +Memory-Preserving Initial Program Load (MPIPL) for PowerNV
> +M: Aditya Gupta <adityag@linux.ibm.com>
> +R: Hari Bathini <hbathini@linux.ibm.com>
> +S: Maintained
> +F: include/hw/ppc/pnv_mpipl.h
> +F: hw/ppc/pnv_mpipl.c
> +F: tests/functional/ppc64/test_fadump.py
> +
>   GDB stub
>   M: Alex Bennée <alex.bennee@linaro.org>
>   R: Philippe Mathieu-Daudé <philmd@linaro.org>


