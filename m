Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0861FD3758
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 13:08:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvEcK-0002zx-Ef; Wed, 25 Feb 2026 08:07:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1vvEcI-0002za-NW; Wed, 25 Feb 2026 08:07:50 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1vvEcH-0005bA-1L; Wed, 25 Feb 2026 08:07:50 -0500
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61PALXTK2089891; Wed, 25 Feb 2026 13:07:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=lXna2y
 XXKQXa4/ac6couCL18v+ugxPYiQjHsEVt9j7k=; b=mFda9bYN0pQwm1v9O+yldm
 xDNK60LFf5Tds2ADNDhwKZpCTvIvLwrwSRXZsyEmAPNkVZ5o0bKBIFIYiYHA6BSS
 A2Fx8xwnEkicexiP4cBe78cSMtTdPrlDuUv3OAiNR2DD1evpE01h76D1hKDvPjSZ
 ib3bIvQOopaYe/5WZkHoHH6meqZwRNlsgvumQM+eN9qg2sVdoZWaU8fILGQdFckx
 QGGeTniFxxvRMKOu9y/Dj9WIy6DK33s6GoBT+131lyn5pIh7SNzd1AUJpUOFuTwz
 zAiGM0XgnUOESRpczNmr6tTKyhpjdxAD2JEZ9vDUTzq9Re+iHO/+Rh8/Ngha2cnA
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cf4cr08t9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 25 Feb 2026 13:07:46 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61P9LFaE027812;
 Wed, 25 Feb 2026 13:07:45 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cfsr1w4g0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 25 Feb 2026 13:07:45 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 61PD7fPW29688214
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 25 Feb 2026 13:07:41 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B983620049;
 Wed, 25 Feb 2026 13:07:41 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CD00620040;
 Wed, 25 Feb 2026 13:07:39 +0000 (GMT)
Received: from [9.124.222.235] (unknown [9.124.222.235])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 25 Feb 2026 13:07:39 +0000 (GMT)
Message-ID: <fa672226-0d73-4b38-9104-0ccb826e7c0a@linux.ibm.com>
Date: Wed, 25 Feb 2026 18:37:37 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ppc/pnv: fix dumpdtb option
To: Shivang Upadhyay <shivangu@linux.ibm.com>, qemu-ppc@nongnu.org
Cc: npiggin@gmail.com, milesg@linux.ibm.com, qemu-devel@nongnu.org,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
References: <20260225081037.21990-1-shivangu@linux.ibm.com>
Content-Language: en-US
From: Aditya Gupta <adityag@linux.ibm.com>
In-Reply-To: <20260225081037.21990-1-shivangu@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: mBR6dO6UGUJe3uTalTeq6-vXSCIKfiDz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI1MDEyMyBTYWx0ZWRfX/8Gop6GqhoLa
 rnCWhTL7YU+LbMyGCIPA6cWncJR98RpWnWIwNwohYbaHrnSgvMoyxrX/JgtgG0du+ldQCEhJ1r7
 K6IFd8q6KoKSsNOKadMpiZJMCiQRiDvH9yjfbTT1u88OjrawhIv+dAhvdJTTntb7GSkhjnZ/yAY
 TjCtTxt7o8Rz/hWNptji6aESxKZLdCkiINqP5Eh6qkqLNcSifXsiRSxqbpUoXi9gX8TlM5N+4Dc
 lU9va9O3txgUwwWuwLB/XB2ISZ1oyRvf7AjQkQXnjmLQiyw9DcdowJwOA5zJpNsLNcsGv72D9dj
 8Y2hqqfjoEz5dhaqDhYeZ6hZd63kv+DxtOsFb88hahcq9DWNt5BHeVQqboduQjUhUkq7EbfxOKz
 JjBrdzLY0YyRQ/0tit3xxH1FgdVQy+5wc2IELxbEzqFqI+Bm/m9lbjWxU/f89May25/7ZssSgLl
 K7vqUxcZbegy6+55t2w==
X-Proofpoint-GUID: Tx4AOQeHjgRQVgUsJe_ZgLwtlbKpcv2l
X-Authority-Analysis: v=2.4 cv=bbBmkePB c=1 sm=1 tr=0 ts=699ef422 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=VwQbUJbxAAAA:8
 a=KKAkSRfTAAAA:8 a=VnNF1IyMAAAA:8 a=QEMjK0bNoiwVexijJm0A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-24_03,2026-02-25_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 adultscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 suspectscore=0 clxscore=1015 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602250123
Received-SPF: pass client-ip=148.163.156.1; envelope-from=adityag@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -11
X-Spam_score: -1.2
X-Spam_bar: -
X-Spam_report: (-1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.734, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.78,
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

On 25/02/26 13:40, Shivang Upadhyay wrote:

> The '-machine dumpdtb' command line option stopped working on
> PowerPC/pnv systems after recent design change [1].
>
> Fixing this by generating fdt blob in `pnv_init`.

Thanks for fixing this Shivang.

The generated dtb is same as the dtb qemu passes to OPAL, which is good:

     # diff original.dts dumpdtb.dts
     Files original.dts and dumpdtb.dts are identical

Reviewed-by: Aditya Gupta <adityag@linux.ibm.com>


Thanks,

- Aditya G

>
> [1] https://lore.kernel.org/qemu-devel/20250206151214.2947842-1-peter.maydell@linaro.org/
>
> Cc: Aditya Gupta <adityag@linux.ibm.com>
> Cc: Harsh Prateek Bora <harshpb@linux.ibm.com>
> Signed-off-by: Shivang Upadhyay <shivangu@linux.ibm.com>
> ---
>   hw/ppc/pnv.c | 4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> index 1513575b8f..9861714ad5 100644
> --- a/hw/ppc/pnv.c
> +++ b/hw/ppc/pnv.c
> @@ -1261,6 +1261,10 @@ static void pnv_init(MachineState *machine)
>       if (pmc->i2c_init) {
>           pmc->i2c_init(pnv);
>       }
> +
> +    if (!machine->fdt) {
> +        machine->fdt = pnv_dt_create(machine);
> +    }
>   }
>   
>   /*

