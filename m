Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F45EF55432
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Feb 2026 06:04:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvUTW-000135-3Z; Thu, 26 Feb 2026 01:03:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jhkim@linux.ibm.com>)
 id 1vvUT9-00010W-A9; Thu, 26 Feb 2026 01:03:27 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jhkim@linux.ibm.com>)
 id 1vvUT7-0004S1-2B; Thu, 26 Feb 2026 01:03:27 -0500
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61Q0Sxug483702; Thu, 26 Feb 2026 06:03:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=8Lix5F
 8VF4Z0K6+MiREq9pKt8MIOzFH9qQYrCEDkbMY=; b=NPq5XP4iGBtYTvAvuCAInw
 OTkIfo4q9x46nV+Qwl0z4NgLiTP48ereuuKCVUGOtSXw/6eC4C3PDMXjxDBU7+tt
 MgofpZXWazV0evNu6AUijcRHgUq4sKB4h3SQlMRSsZlqFfOL4kFS/EciHFOjklaX
 kPxqpmnR/3TJCrTsjgJXtTXdDZePfqWjgk8a/QBcLZBsx2CpFyWeac0mBNBLvaC5
 VCyl54pNy7NFtzvUQD3DpyBJ5SMqng8JsZ/j7QiXqmTG5eM8QgP1bOi3CuAFjnc/
 +ByXBv1n/iiTZcoZrCXcXVla5MKjsU493CldCamYJVXkXKyBL4ylHPp+oRC7RyJA
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ch858sykq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 26 Feb 2026 06:03:18 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61Q316Oc001659;
 Thu, 26 Feb 2026 06:03:17 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cfr1n9j35-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 26 Feb 2026 06:03:17 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com
 [10.241.53.102])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 61Q63HjA29819440
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 26 Feb 2026 06:03:17 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1FE8E5805A;
 Thu, 26 Feb 2026 06:03:17 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D7F4D5803F;
 Thu, 26 Feb 2026 06:03:16 +0000 (GMT)
Received: from [9.61.242.74] (unknown [9.61.242.74])
 by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 26 Feb 2026 06:03:16 +0000 (GMT)
Message-ID: <5a50568c-d7c8-4938-b399-b304c162f6f2@linux.ibm.com>
Date: Thu, 26 Feb 2026 00:03:16 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v1 0/3] aio-poll: improve aio-polling efficiency
From: JAEHOON KIM <jhkim@linux.ibm.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, pbonzini@redhat.com,
 fam@euphon.net, armbru@redhat.com, eblake@redhat.com,
 berrange@redhat.com, eduardo@habkost.net, dave@treblig.org, sw@weilnetz.de
References: <20260113174824.464720-1-jhkim@linux.ibm.com>
 <20260219222717.GA1011077@fedora>
 <79c89de8-68f4-46ff-bcce-dcb817d04ad5@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <79c89de8-68f4-46ff-bcce-dcb817d04ad5@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI2MDA0OCBTYWx0ZWRfX1QqUqfSEeP0h
 8MdspxjukrDwkdgrD/pUdSWpW8Huype9T2rvcCFzzXgpJAUhDqin9LRkIulXq6j+uzYhRL2Xlf8
 5GgxUMC0lnFreo6YF+r/9CL0RJ4TUhS6A0hTQAzaMK79xTWLBod/pTm+x6uKU0ni0nBZKNjl/HV
 DUyz2+nJbc/uUelO5r3dvhr1iThm6d8/YyNuH71eKa99jyXPKqE+Vey+GeRHdq9HyGG46Rvl3xi
 UjVmsW2BOtK+CDkzeCEfTC1haILbO0b2p72FGPg6ukX+BxEqS3qUoNq5cGfqiKcwgZiKRV4xzvd
 8vwoyYlsfKb3gPorCR79u4mfVT2H3TkvaFJfYRbBLBbBwnsuCiR98v3U0wQbSNqFNosYxPjIJdC
 rkAe7IIJVrax6XsYbmVBfGdEBrcglFUc41t/masbryPw1WJbGfihYcuF7de+GDYHDFFWTkR6eCI
 IixhEUA8mm44Oz/Jn7Q==
X-Proofpoint-GUID: VjDo4cj1E8JZrLacGjK_N5MEsK4B5yiF
X-Authority-Analysis: v=2.4 cv=S4HUAYsP c=1 sm=1 tr=0 ts=699fe226 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=BL-TWKcdoxXKg6rlIT8A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: VjDo4cj1E8JZrLacGjK_N5MEsK4B5yiF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-25_04,2026-02-25_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 impostorscore=0 malwarescore=0 bulkscore=0
 phishscore=0 adultscore=0 lowpriorityscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602260048
Received-SPF: pass client-ip=148.163.156.1; envelope-from=jhkim@linux.ibm.com;
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

On 2/20/2026 1:00 PM, JAEHOON KIM wrote:
> On 2/19/2026 4:27 PM, Stefan Hajnoczi wrote:
>> Hi Jaehoon,
>> Following the call earlier this week I ran a single fio job to get a
>> clearer picture of:
>> 1. The QEMU 10.0.0 regression that prompted you to optimize AioContext
>>     polling.
>> 2. How the poll-weight parameter affects IOPS.
>>
>> run      rw        bs   numjobs iothreads iops   diff
>> v9.2.0   randread  8k   1       1         174944 3.6%
>> v10.0.0  randread  8k   1       1         174285 3.2%
>> baseline randread  8k   1       1         168908 0.0%
>> w2       randread  8k   1       1         163718 -3.1%
>> w3       randread  8k   1       1         165805 -1.8%
>> w4       randread  8k   1       1         167388 -0.9%
>>
>> This time I only ran randread bs=8k iodepth=8 numjobs=1 with a single
>> IOThread.
>>
>> Observations:
>>
>> - There might be an IOPS regression between v10.0.0 and the baseline
>>    (9ad7f544c696) that your patches apply on top of. This is different
>>    from the CPU utilization regression that you found in v9.2.0 ->
>>    v10.0.0. I will bisect it.
>>
>> - poll-weight=3 and 4 improve IOPS to a level that is acceptable. CPU
>>    utilization looks like this:
>>
>> run         %usr     %nice      %sys   %iowait    %steal %irq     
>> %soft    %guest    %gnice     %idle
>> baseline   49.37      0.00     31.10      0.00      0.00 11.61      
>> 0.04      0.00      0.00      7.89
>> w2         46.24      0.00     32.61      0.00      0.00 11.84      
>> 0.10      0.00      0.00      9.21
>> w3         48.04      0.00     32.17      0.00      0.00 11.98      
>> 0.08      0.00      0.00      7.73
>> w4         48.56      0.00     31.23      0.00      0.00 11.48      
>> 0.03      0.00      0.00      8.69
>>
>> poll-weight=2 is the winner at CPU utilization. I'm not sure if
>> poll-weight=3 will produce an acceptable CPU utilization improvement for
>> you. Do you have data or want to re-run to measure poll-weight=3?
>>
>> Stefan
>
> Thank you very much for sharing the detailed measurement results.
> I truly appreciate the effort.
>
> Regarding w=3, I will discuss with our performance team to see
> if the CPU consumption levels are acceptable within our internal
> test environment. I will get back to you with more definitive data
> as soon as possible.
>
> Thanks again for your thorough analysis.
>
> Regards,
> Jaehoon.
>
Hello Stefan,

Thank you for your patience. I would like to share the observed changes 
in throughput
and CPU consumption in our performance test environment as follows.

We observed that when using W=3, performance returns to a level 
comparable to
QEMU v9.1, while W=2 results in slightly lower CPU consumption.

Our initial preference is to use W=2 by default.
However, we fully understand your concerns regarding the potential 
performance drop.
Should the patch be accepted, we would provide guidance on using the 
weighted value as
a configurable option.

For reference, we consider values between -2 and 2 as noise in our analysis.
I look forward to your feedback.

The table below shows a comparison between:
*  - Host:* RHEL10.1-GA+qemu-10.0.0-14.el10_1, *Guest:* RHEL 9.6 GA vs.
*  - Host:* RHEL10.1-GA+qemu-10.0.0-14.el10_1 (w=2, w=3), *Guest:* RHEL 
9.6 GA
     for FIO FCP and FICON with 1 iothread and 8 iothreads.
     The values shown are the averages for numjobs 1, 4, and 8.

FIO FCP -1 iothread
+---------------------+------------+------------+------------+------------+------------+------------+------------+------------+
|                     | Seq. Read  | Seq. Read  | Seq. Write | Seq. 
Write | Rand. Read | Rand. Read | Rand. Write| Rand. Write|
|                     |   w2 (%)   |   w3 (%)   |   w2 (%)   |  w3 (%)  
  |   w2 (%)   |   w3 (%)   |   w2 (%)   |   w3 (%)   |
+---------------------+------------+------------+------------+------------+------------+------------+------------+------------+
| Throughput avg      |   -3.00    |   -2.33    |    0.00    |  -0.33    
|   -3.00    |   -3.33    |    1.33    |   -0.33    |
| CPU consumption avg |   -5.67    |   -4.33    |   -6.33    |  -5.33    
|   -7.33    |   -5.33    |  -10.33    |   -8.67    |
+---------------------+------------+------------+------------+------------+------------+------------+------------+------------+

FIO FCP -8 iothread
+---------------------+------------+------------+------------+------------+------------+------------+------------+------------+
|                     | Seq. Read  | Seq. Read  | Seq. Write | Seq. 
Write | Rand. Read | Rand. Read | Rand. Write| Rand. Write|
|                     |   w2 (%)   |   w3 (%)   |   w2 (%)   |  w3 (%)  
  |   w2 (%)   |   w3 (%)   |   w2 (%)   |   w3 (%)   |
+---------------------+------------+------------+------------+------------+------------+------------+------------+------------+
| Throughput avg      |   -5.00    |   -4.00    |   -3.67    |  -3.33    
|   -4.67    |   -4.00    |   -0.33    |   -0.67    |
| CPU consumption avg |  -13.00    |  -10.67    |  -16.00    | -14.33    
|  -14.00    |   -9.33    |  -13.67    |  -11.00    |
+---------------------+------------+------------+------------+------------+------------+------------+------------+------------+


FIO FICON -1 iothread
+---------------------+------------+------------+------------+------------+------------+------------+------------+------------+
|                     | Seq. Read  | Seq. Read  | Seq. Write | Seq. 
Write | Rand. Read | Rand. Read | Rand. Write| Rand. Write|
|                     |   w2 (%)   |   w3 (%)   |   w2 (%)   |  w3 (%)  
  |   w2 (%)   |   w3 (%)   |   w2 (%)   |   w3 (%)   |
+---------------------+------------+------------+------------+------------+------------+------------+------------+------------+
| Throughput avg      |   -0.67    |   -0.67    |   -6.33    |  -6.67    
|   -0.67    |    0.00    |    1.33    |    1.33    |
| CPU consumption avg |   -7.67    |   -7.33    |  -13.67    | -13.00    
|   -9.00    |   -8.33    |   -5.00    |   -4.33    |
+---------------------+------------+------------+------------+------------+------------+------------+------------+------------+

FIO FICON -8 iothread
+---------------------+------------+------------+------------+------------+------------+------------+------------+------------+
|                     | Seq. Read  | Seq. Read  | Seq. Write | Seq. 
Write | Rand. Read | Rand. Read | Rand. Write| Rand. Write|
|                     |   w2 (%)   |   w3 (%)   |   w2 (%)   |  w3 (%)  
  |   w2 (%)   |   w3 (%)   |   w2 (%)   |   w3 (%)   |
+---------------------+------------+------------+------------+------------+------------+------------+------------+------------+
| Throughput avg      |   -3.00    |   -2.67    |   -7.33    |  -7.00    
|   -0.67    |   -1.00    |    0.67    |    0.67    |
| CPU consumption avg |  -16.33    |  -14.33    |  -25.33    | -27.00    
|   -8.67    |   -7.00    |   -6.67    |   -5.00    |
+---------------------+------------+------------+------------+------------+------------+------------+------------+------------+ 



The table below shows a comparison between:
* - Host:* RHEL 10.0 GA + qemu-9.1.0-15.el10, *Guest:* RHEL 9.6 GA vs.
* - Host:* RHEL 10.1 GA + qemu-10.0.0-14.el10_1 (w=2, w=3), *Guest:* 
RHEL 9.6 GA.

FIO FCP -1 iothread
+---------------------+------------+------------+------------+------------+------------+------------+------------+------------+
|                     | Seq. Read  | Seq. Read  | Seq. Write | Seq. 
Write | Rand. Read | Rand. Read | Rand. Write| Rand. Write|
|                     |   w2 (%)   |   w3 (%)   |   w2 (%)   |  w3 (%)  
  |   w2 (%)   |   w3 (%)   |   w2 (%)   |   w3 (%)   |
+---------------------+------------+------------+------------+------------+------------+------------+------------+------------+
| Throughput avg      |   -0.67    |    0.00    |   -0.33    |  -1.00    
|   -1.00    |   -0.67    |    3.33    |    2.00    |
| CPU consumption avg |    0.67    |    2.00    |    1.67    | 3.00    
|   -3.33    |   -0.33    |   -2.33    |    0.00    |
+---------------------+------------+------------+------------+------------+------------+------------+------------+------------+

FIO FCP -8 iothread
+---------------------+------------+------------+------------+------------+------------+------------+------------+------------+
|                     | Seq. Read  | Seq. Read  | Seq. Write | Seq. 
Write | Rand. Read | Rand. Read | Rand. Write| Rand. Write|
|                     |   w2 (%)   |   w3 (%)   |   w2 (%)   |  w3 (%)  
  |   w2 (%)   |   w3 (%)   |   w2 (%)   |   w3 (%)   |
+---------------------+------------+------------+------------+------------+------------+------------+------------+------------+
| Throughput avg      |   -2.00    |   -1.33    |   -1.00    | 0.00    
|   -0.33    |    1.00    |    1.00    |    0.67    |
| CPU consumption avg |   -3.00    |   -1.00    |   -2.00    | 0.00    
|  -10.33    |   -5.67    |   -6.67    |   -3.33    |
+---------------------+------------+------------+------------+------------+------------+------------+------------+------------+


FIO FICON -1 iothread
+---------------------+------------+------------+------------+------------+------------+------------+------------+------------+
|                     | Seq. Read  | Seq. Read  | Seq. Write | Seq. 
Write | Rand. Read | Rand. Read | Rand. Write| Rand. Write|
|                     |   w2 (%)   |   w3 (%)   |   w2 (%)   |  w3 (%)  
  |   w2 (%)   |   w3 (%)   |   w2 (%)   |   w3 (%)   |
+---------------------+------------+------------+------------+------------+------------+------------+------------+------------+
| Throughput avg      |   -1.67    |   -1.67    |   -0.33    | 0.00    
|   -1.33    |   -1.00    |   -1.67    |   -2.33    |
| CPU consumption avg |   -0.33    |    1.00    |    1.00    | 2.00    
|   -2.33    |   -1.33    |   -1.33    |   -0.33    |
+---------------------+------------+------------+------------+------------+------------+------------+------------+------------+

FIO FICON -8 iothread
+---------------------+------------+------------+------------+------------+------------+------------+------------+------------+
|                     | Seq. Read  | Seq. Read  | Seq. Write | Seq. 
Write | Rand. Read | Rand. Read | Rand. Write| Rand. Write|
|                     |   w2 (%)   |   w3 (%)   |   w2 (%)   |  w3 (%)  
  |   w2 (%)   |   w3 (%)   |   w2 (%)   |   w3 (%)   |
+---------------------+------------+------------+------------+------------+------------+------------+------------+------------+
| Throughput avg      |   -1.00    |   -0.67    |   -0.33    | 0.33    
|    0.67    |    0.33    |    0.33    |    0.33    |
| CPU consumption avg |   -1.33    |    1.00    |    4.33    | 2.33    
|   -2.00    |    0.00    |   -3.00    |   -1.33    |
+---------------------+------------+------------+------------+------------+------------+------------+------------+------------+ 



Regards,
Jaehoon.


