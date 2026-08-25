Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30A23C5DF94
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 09:23:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wynNA-0000aE-MQ; Tue, 25 Aug 2026 05:23:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1wynN8-0000Zf-W8; Tue, 25 Aug 2026 05:23:11 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1wynN6-0008Kj-WB; Tue, 25 Aug 2026 05:23:10 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67P8W7ua2650158; Tue, 25 Aug 2026 09:23:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=3+vvPP
 wAyzarRRmJSEEj0CofxWp1KiwpaZESb0QTorA=; b=NNp3DwSuqDelPlLkNBqX3k
 1OvIByenRUcJ91o9dXIp7jcNc6i1fuKBQ7w3vORIp9hQO4xV+7r4BcpKDRPfJeeo
 j+5j6v+E4MVuiqLkKx/g9sxaoKlpyzNATNL4emIc/QznPRibZ6VsD9d3/4Tr5Gva
 32zq8JwoT1aT0NGEEspKfxSQZxoqtCQQ2Z48YHv5fy965DQxNPjMly8qiubhiAiX
 VN4CfJe0CJsrky623ZMJb8K6ei94mJhs2uKOI7vMv2mAm92aEGxZiBGtSbDpiA6N
 I7ZljDdbzPowSjbL2CIzGc0twWr5mRA9jKf5/N+mkb0Te7cLKSdFMpjXOUG4F63A
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g73eqq6g7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 25 Aug 2026 09:23:04 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67P9BIha020532;
 Tue, 25 Aug 2026 09:23:04 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g7rsy35ay-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 25 Aug 2026 09:23:03 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67P9Mxeh35783098
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 25 Aug 2026 09:22:59 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1C2412004B;
 Tue, 25 Aug 2026 09:22:59 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C3DBA20043;
 Tue, 25 Aug 2026 09:22:56 +0000 (GMT)
Received: from [9.123.10.203] (unknown [9.123.10.203])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 25 Aug 2026 09:22:56 +0000 (GMT)
Message-ID: <c4782554-94e0-467f-861c-7105962c66b3@linux.ibm.com>
Date: Tue, 25 Aug 2026 14:52:55 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/1] hw/ppc/fadump: report CPU_STATE_DATA dumped_bytes
 as source_len
To: Shivang Upadhyay <shivangu@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
Cc: anushree.mathur@linux.vnet.ibm.com, harshpb@linux.ibm.com,
 mahesh@linux.ibm.com, sourabhjain@linux.ibm.com,
 amachhiw@linux.ibm.com, hbathini@linux.ibm.com, npiggin@gmail.com
References: <20260825090932.1748581-1-shivangu@linux.ibm.com>
 <20260825090932.1748581-2-shivangu@linux.ibm.com>
Content-Language: en-US
From: Aditya Gupta <adityag@linux.ibm.com>
In-Reply-To: <20260825090932.1748581-2-shivangu@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: dnBF2In3WAPPuULk0tFgyimDW6Lsl2zY
X-Proofpoint-ORIG-GUID: -dz-pwEEcB_5zTzbDQLofnGBnpdrl0mI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI1MDA3NiBTYWx0ZWRfX/mvrGeIyrQNM
 oHVeU0fofw1EkQnkfZlGfc4HRoAu4cp8rPoIivW3ZKbIJAcZ5xZQMkT18x3+iMG87FNAIhOcXo8
 Ydh5pf24d8yyyP3Kic603EFsDTeLakvAv9/3iV9ruQaVnakbIijimBnXNWXlBzAzYoWvDPXEg3j
 cbsVMANZp71YbPPDyJ0mOV4/353C06XdbsFSa2SYyIgr4nNy9UegbpwfUzX12ycdDfRP9AAciZg
 FXX8RyRuPdCVPpgavf5rZAqLVbjrI3PjRMS14kQOk3SzTpNMOnK1a3fUttWnHMvVnan+aVQTzcj
 Cbg4YgLKW3Yu4J+xov6i/H1UKStrgMXN0TQzsp9EJCT0xrXuM48cGXLP4ObgX3z2vtNYzPeiZWp
 nscUZzJtEWkTUoCg1iUeUOh7Lq63dAqqaZwZhYJmXCu4Mky3vCaZT73ODS6PZTBaIJ4btgyEas1
 WCLJWc0gJjUv+IvjKoA==
X-Authority-Analysis: v=2.4 cv=QsRuG1yd c=1 sm=1 tr=0 ts=6a8d5ef9 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=9AdMxfjQAAAA:20
 a=VnNF1IyMAAAA:8 a=E3e1_75F00jLdr1Alb4A:9 a=QEXdDO2ut3YA:10
 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI1MDA3NiBTYWx0ZWRfX+SkHGNke+I4r
 F0JTMVT6l/6/MFI72GnYO2QqmtCGkRqFW2NXrH+aQfBf8qtcOTz/7DF3sEG+DjxOaVZCdH+ojZe
 T777auUv3/sIyAyPDqiM6zIw0m9i0og=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-25_02,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 suspectscore=0 priorityscore=1501 impostorscore=0
 spamscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608250076
Received-SPF: pass client-ip=148.163.156.1; envelope-from=adityag@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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

On 25/08/26 14:39, Shivang Upadhyay wrote:

> When system is restarted with fadump, cpu registers data is copied
> to CPU_STATE_DATA region. The size of data depends on the number of
> cpus that are currently present in the system. But when maxcpus config
> option is provided in qemu command line, this causes the linux kernel to
> allocate extra space for CPU_STATE_DATA region. If there are no hotplug
> operations, this will lead to part of region being empty.
>
> As per current Linux kernel, It expects the size of collected Fadump
> region to be exactly equal to allocated size. Otherwise
> kernel assumes that dump is incomplete [1].
>
> If maxcpus option is used, This causes qemu to send partially filled
> region, and Kernel then rejects to collect to any dump. As a result of
> this /proc/vmcore is not generated.
>
> To fix this, Changing fadump to always report CPU_STATE_DATA's
> dumped_bytes as source_len. This behaviour is also noticed in Phyp.
>
> [1] https://github.com/torvalds/linux/blob/66498c75b4f8017f62d720d9b59675bdf3abce91/arch/powerpc/platforms/pseries/rtas-fadump.c#L472
> Cc: Sourabh Jain <sourabhjain@linux.ibm.com>
> Cc: Aditya Gupta <adityag@linux.ibm.com>
> Reported-by: Anushree Mathur <anushree.mathur@linux.vnet.ibm.com>
> Signed-off-by: Shivang Upadhyay <shivangu@linux.ibm.com>
> ---
>   hw/ppc/spapr_fadump.c | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/hw/ppc/spapr_fadump.c b/hw/ppc/spapr_fadump.c
> index 13cab0cfe1..c0f6474ae9 100644
> --- a/hw/ppc/spapr_fadump.c
> +++ b/hw/ppc/spapr_fadump.c
> @@ -575,8 +575,9 @@ static bool do_populate_cpu_state(FadumpSection *region)
>   
>       if (region->source_len != region->bytes_dumped) {
>           /*
> -         * Log the error, but don't fail the dump collection here, let
> -         * kernel handle the mismatch
> +         * Log the error, but don't fail the dump collection here.
> +         * This is probably because of maxcpus config. Linux kernel would
> +         * not collect any dump if dumped_bytes does not match source_len.
>            */

Understood the problem, can we mention something like "this is not 
specifically
suggested by spapr, matching phyp's behaviour here" or something like that ?

>           qemu_log_mask(LOG_GUEST_ERROR,
>                   "FADump: Mismatch in CPU State region's length exported:"
> @@ -584,6 +585,8 @@ static bool do_populate_cpu_state(FadumpSection *region)
>                   " QEMU exported: 0x%" PRIx64 " bytes\n",
>                   be64_to_cpu(region->source_len),
>                   be64_to_cpu(region->bytes_dumped));
> +
> +        region->bytes_dumped = region->source_len;
source_len = bytes_dumped makes more sense here, than increasing 
bytes_dumped to
source_len. what do you say ?

otherwise okay with me, but good to have a clear comment about deviating 
from
spapr to match phyp here, so we can fix it if phyp or spapr were to 
change to
follow one thing.


thanks,

- Aditya G


