Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95F80F9D0CF
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2026 13:26:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCdmc-0004Vx-4C; Tue, 14 Apr 2026 09:26:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1wCdmK-0004Uy-UG; Tue, 14 Apr 2026 09:26:10 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1wCdmH-0002Ho-Jd; Tue, 14 Apr 2026 09:26:07 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63E3nCKE2487108; Tue, 14 Apr 2026 13:26:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=tN9koP
 FbZV1xj0LMN82C/GO4xauyGsQFtLG+ei+xkxg=; b=q+PskocJFx/Of+jvKFJOpT
 krlu3ZRjz4G4Ay7d9AdPVd79a4o+OLfb9oTHgpJyk+mkomDcId5xMhkmWeQ9yrbe
 ZT+vM5gPFTbKiN92hgq40uG1JGVD3ilb7OHENsOi5kAVJx9s0cVjJ9xS5ce6Y4UT
 b5A4giBZ9dlCOv+OvLCw3xz+gpZbIM5yxAVj0pCJj1/poPCj7nL0ZT3S0Ohas8hh
 z9zH4QnrwMYp7Iuuu8lrBJ8yFEW8zXXTbdCWyuNdv8TbS5H9W+tv2IH0fN+f3u0o
 7Co6YHlsduzX6hqMtIUi7OffpAvVS19+ysAU5ZX3LEF8UbhjuNmz2816mTQVys/g
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dh89m2shd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 14 Apr 2026 13:26:00 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 63EAraiG025761;
 Tue, 14 Apr 2026 13:25:59 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dg3b1hcdw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 14 Apr 2026 13:25:59 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 63EDPwFx25362966
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 14 Apr 2026 13:25:58 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 80FBC5805E;
 Tue, 14 Apr 2026 13:25:58 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2F81B58056;
 Tue, 14 Apr 2026 13:25:57 +0000 (GMT)
Received: from [9.61.102.229] (unknown [9.61.102.229])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTPS;
 Tue, 14 Apr 2026 13:25:57 +0000 (GMT)
Message-ID: <70909712-6edc-40e5-939f-eedd36290a5f@linux.ibm.com>
Date: Tue, 14 Apr 2026 09:25:56 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 18/30] pc-bios/s390-ccw: Rework zipl_load_segment
 function
To: Zhuoying Cai <zycai@linux.ibm.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
Cc: cohuck@redhat.com, berrange@redhat.com, richard.henderson@linaro.org,
 pierrick.bouvier@linaro.org, david@kernel.org, walling@linux.ibm.com,
 jjherne@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 farman@linux.ibm.com, mjrosato@linux.ibm.com, iii@linux.ibm.com,
 eblake@redhat.com, armbru@redhat.com, alifm@linux.ibm.com,
 brueckner@linux.ibm.com, jdaley@linux.ibm.com
References: <20260402221453.1602899-1-zycai@linux.ibm.com>
 <20260402221453.1602899-19-zycai@linux.ibm.com>
Content-Language: en-US
From: Jared Rossi <jrossi@linux.ibm.com>
In-Reply-To: <20260402221453.1602899-19-zycai@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=I/dVgtgg c=1 sm=1 tr=0 ts=69de4068 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=20KFwNOVAAAA:8 a=cBWgyyR0_XLHYu1li64A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: dLGQ8pu9hn0zRekRQ3kohXNCkuUcSCjc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE0MDEyNSBTYWx0ZWRfX49hMJ5MjGRou
 KB2EuZNvEJUgurX6J6JB76TuBUZLXwK1M0WoaEy5oXKMJMblSkm4kvIHXPUwBqxjFPcnjVgwV0o
 rGliFP5cGChYwx/3wPVpqjh3iqbIn+1ex3I2esQBVhxqex30+UJFRQ6sTvLZ0UJxAG+YWat/bpR
 RFroW8A0Z3OqknfSmE9HcMQcS2l90GCyyPJCtlbQbEpX68aay+/X5YreILh2nqZsVG8idY2R/Sv
 u1nMiQnWhkCbfG0KaCvVn8nuBEg1wGE+U4cgRglwp51yNjzOI8qe3fN5nJQWvzvH+EhtER+9QL2
 ftk4nnFBlJ1DJblChGAGg11l9Z+jyF9ekXhfSw8ZMtleOzTwjgCmxHxgZ4u413OAA0lO/tpn3sU
 bkzRH2K0m+JO49L+wfwJq+NFj+DhTwNL5hObyBp5L5YPHM6PGqxyxnkwvD2ReYJteUz0mE1INYd
 nqDdS2AkvNlDCfbyWcg==
X-Proofpoint-ORIG-GUID: dLGQ8pu9hn0zRekRQ3kohXNCkuUcSCjc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-14_03,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 clxscore=1015 adultscore=0 lowpriorityscore=0
 suspectscore=0 impostorscore=0 phishscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604140125
Received-SPF: pass client-ip=148.163.158.5; envelope-from=jrossi@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



On 4/2/26 6:14 PM, Zhuoying Cai wrote:
> Make the address variable a parameter of zipl_load_segment and return
> segment length.
>
> Modify this function to allow the caller to specify a memory address
> where segment data should be loaded into.
>
> seg_len variable is necessary to store the calculated segment length and
> is used during signature verification. Return the length on success, or
> a negative return code on failure.
>
> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> ---
>   pc-bios/s390-ccw/bootmap.c | 15 ++++++++++-----
>   1 file changed, 10 insertions(+), 5 deletions(-)
>
> diff --git a/pc-bios/s390-ccw/bootmap.c b/pc-bios/s390-ccw/bootmap.c
> index b9ba004cfc..d17a6576ff 100644
> --- a/pc-bios/s390-ccw/bootmap.c
> +++ b/pc-bios/s390-ccw/bootmap.c
> @@ -613,19 +613,22 @@ static int ipl_eckd(void)
>    * IPL a SCSI disk
>    */
>   
> -static int zipl_load_segment(ComponentEntry *entry)
> +/*
> + * Returns: length of the segment on success,
> + *          negative value on error.
> + */
> +static int zipl_load_segment(ComponentEntry *entry, uint64_t address)
>   {
Passing both the entire ComponentEntry, which often contains the address 
already, as well as a separate address parameter seems redundant.

The only other ComponentEntry value needed is the block number, so let's 
instead convert the parameters to be block_number_t blockno and uint64_t 
address.

I think just those two parameters are sufficient without passing the 
entire ComponentEntry, unless I've missed something.

>       const int max_entries = (MAX_SECTOR_SIZE / sizeof(ScsiBlockPtr));
>       ScsiBlockPtr *bprs = (void *)sec;
>       const int bprs_size = sizeof(sec);
>       block_number_t blockno;
> -    uint64_t address;
>       int i;
>       char err_msg[] = "zIPL failed to read BPRS at 0xZZZZZZZZZZZZZZZZ";
>       char *blk_no = &err_msg[30]; /* where to print blockno in (those ZZs) */
> +    int seg_len = 0;
>   
>       blockno = entry->data.blockno;
> -    address = entry->compdat.load_addr;
>   
>       debug_print_int("loading segment at block", blockno);
>       debug_print_int("addr", address);
> @@ -668,10 +671,12 @@ static int zipl_load_segment(ComponentEntry *entry)
>                   puts("zIPL load segment failed");
>                   return -EIO;
>               }
> +
> +            seg_len += bprs->size * (bprs[i].blockct + 1);
>           }
>       } while (blockno);
>   
> -    return 0;
> +    return seg_len;
>   }
>   
>   static int zipl_run_normal(ComponentEntry **entry_ptr, uint8_t *tmp_sec)
> @@ -687,7 +692,7 @@ static int zipl_run_normal(ComponentEntry **entry_ptr, uint8_t *tmp_sec)
>               continue;
>           }
>   
> -        if (zipl_load_segment(entry)) {
> +        if (zipl_load_segment(entry, entry->compdat.load_addr) < 0) {
>               return -1;
>           }
>   
Regards,
Jared Rossi

