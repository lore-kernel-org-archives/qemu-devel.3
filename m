Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14083CDB46F
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2026 14:51:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wc2Sa-0002jj-Gz; Tue, 23 Jun 2026 10:50:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1wc2SW-0002jS-5Y; Tue, 23 Jun 2026 10:50:40 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1wc2SU-0003Ak-DZ; Tue, 23 Jun 2026 10:50:39 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65NBmTRY1826484; Tue, 23 Jun 2026 14:50:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=kkDvc/
 d+a4X8ffSIRC38JWB/aGD1CPwASIJXr082SnQ=; b=hkyXzdPmQL6TogmjBJCN97
 /z8laxCQqm9fFWUOHGbyEVXU5vjo0uSQ2xJbwdN1UrhkqGK0xajyZkAOuR6siukX
 tNRgTlSK2TvN4u8e/lrdxRTtXNzPBw7+FA74xnD9Hm+p0nl/Ff1Er38VUpyINUPj
 xl3MtxB9soJoRba0HLW4JSj4/baxvF2Su/CGRqtrP+6+ircXHIOrsP0yMyM8udWk
 f1vK0c+/kAynd6XzgOIuBVC6lrZm3yTyIqR7yqQaQIOU282f41SaAnXuxU2jD3LF
 mrT/0KBmpIUPG/nbEBdIn3uqT4DcOeLHoERrdsP66HTGVDj7U03QabK31qIstoEQ
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewjgsq0ys-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 23 Jun 2026 14:50:36 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65NEnlZb015835;
 Tue, 23 Jun 2026 14:50:35 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ex7dg3k9y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 23 Jun 2026 14:50:35 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 65NEoVLJ49348864
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 23 Jun 2026 14:50:31 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0F0012005A;
 Tue, 23 Jun 2026 14:50:31 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0592220049;
 Tue, 23 Jun 2026 14:50:20 +0000 (GMT)
Received: from [9.39.19.165] (unknown [9.39.19.165])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 23 Jun 2026 14:50:19 +0000 (GMT)
Message-ID: <e6a15f0a-c803-451d-abbe-a945d52cb3ff@linux.ibm.com>
Date: Tue, 23 Jun 2026 20:20:17 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] Replace assert with bound checks in PnvPHB3
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Zexiang Zhang <chan9yan9@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>, Thomas Huth <thuth@redhat.com>,
 Miles Glenn <milesg@linux.ibm.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 qemu-stable <qemu-stable@nongnu.org>
References: <20260326190438.734239-1-adityag@linux.ibm.com>
 <906da372-3116-444f-919f-6cc3396fce0c@tls.msk.ru>
Content-Language: en-US
From: Aditya Gupta <adityag@linux.ibm.com>
In-Reply-To: <906da372-3116-444f-919f-6cc3396fce0c@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDEyMiBTYWx0ZWRfX8Wx75P9dNogC
 KDrD2rg8DvUQ8Sz0aS4akNlrTlTBZv8fhKAb+0gtLbiTrEtgDkUS3cOnQPu2s8AKqV4zy2fOOpT
 q7WwyPTnW+9faqgSTzgFE/x7dlfpTuRY/veDjvdg6hEP92MRjfYVURfcFUCMKvzW5pYGrlClS++
 4iQ6s1h/SXJhA0UkT9F9DufezNUQAUeXr0DzRmpsNp2+lznOHJ6Pqbt9ENTTWBlhYRKLYPa/uOX
 PdzU/cx6BTRyjrVeyzZ8KYBZwVUuTPJwnRWRU41nc53epEAfq1uNu/aOxJw4Ed0+PCWc+YJxY4S
 uPAQEpZHTdRDV37NYpL4X0BLWSvSLmkPDFZYo7Brk5ZSK7Cjr+j0pFAhCpKqbLIohoHVbkLwKcb
 xomPB6+StWQmdRlBbeOPdqspAuu41gZyFA/wl3idIjryzYiLaXi7mgcxUrwEM/SSvuXL2PS7+Sa
 RRTfvqAU5LR4GwZSIew==
X-Proofpoint-GUID: 6Bf3BUn3cfLEoBlFM2VLLjA29CiRMRaA
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDEyMiBTYWx0ZWRfX/n3ciydQZb2a
 0EuAuSnBkrXRrXrB1vswqVHsKrkurW4l6KG4EvMAisZ7QM3YrkSbexPcfgGzaDNz38D2uZjh6fl
 F4/puusu8c9e+cqZbRyWYpgzO+WsjjA=
X-Authority-Analysis: v=2.4 cv=I/lVgtgg c=1 sm=1 tr=0 ts=6a3a9d3c cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=p0WdMEafAAAA:8
 a=8oURcu1cqjsa_UTcp-MA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: EeL2HZeKD3RJIucq5lsYnrRmSgKEDkBT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_03,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 phishscore=0 clxscore=1011 priorityscore=1501
 adultscore=0 impostorscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606230122
Received-SPF: pass client-ip=148.163.158.5; envelope-from=adityag@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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

On 16/06/26 21:52, Michael Tokarev wrote:

> On 26.03.2026 22:04, Aditya Gupta wrote:
>> <...snip...>
> Hi!
>
> Is this a qemu-stable material?
>
This isn't a critical fix, as I believe this can't be triggered with usual
skiboot/kernel, as they don't do this invalid read.

This assert was originally triggered by a fuzzy tester, using qtest 
commands to
send the read/write commands with size as 8, as reported in
https://gitlab.com/qemu-project/qemu/-/work_items/3334

Though since the fix is small and safe, I don't have any resistance to 
it, and
okay with it going to qemu-stable.

Thanks,
- Aditya G
> Thanks,
>
> /mjt

