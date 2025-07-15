Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3557C83F22
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 16:38:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubice-0003JZ-V1; Tue, 15 Jul 2025 12:35:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1ubi3v-0007BC-MJ; Tue, 15 Jul 2025 11:59:24 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1ubi3t-0000AT-7Y; Tue, 15 Jul 2025 11:59:23 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56FC6g0X011103;
 Tue, 15 Jul 2025 15:59:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=hcLMvJ
 N7xNME0//CvNTptwBEYyg9iQTkRLy8KZ3/4DE=; b=An9/M79mEMqSwp5nNcQ2SR
 7TcyOVuA4QdTze6Cuh42ihvKESwOQrYmY/ZwJzaFOgUh8nM3iLoRfyckRAWERpNx
 C0+f9gIlbG8Gd3ipf5SX3vGaVJcc4BpHO/IMsVXIMdda2PvKGCteuWXwUuVzUHSv
 jnhspiKMJ9PAVPXWPokgVuRhXPMg2smBmjLwR6ca/wyY9uYz9nxYkNirE5sbNlic
 COgREXvyqW/aN30oaykk9wmxmPGIWLVrIxzLTRonASjocRa/EeFgTsoYnLgprSxO
 F0BSwrqvAYBGdflfD/QfH3nzock4Bqujo2CuBkKRMWDzOgL8ZLfW7+OaMBx49ndA
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47vdfmk36m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 15 Jul 2025 15:59:17 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56FDpApF008951;
 Tue, 15 Jul 2025 15:59:16 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 47v3hmk41f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 15 Jul 2025 15:59:16 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 56FFxEi121365292
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 15 Jul 2025 15:59:14 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B488658056;
 Tue, 15 Jul 2025 15:59:14 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D96FA58052;
 Tue, 15 Jul 2025 15:59:13 +0000 (GMT)
Received: from [9.12.79.241] (unknown [9.12.79.241])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTPS;
 Tue, 15 Jul 2025 15:59:13 +0000 (GMT)
Message-ID: <310f1563-e04a-4aa2-aed1-ee631676c4a0@linux.ibm.com>
Date: Tue, 15 Jul 2025 11:59:13 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 19/28] pc-bios/s390-ccw: Refactor zipl_load_segment
 function
To: Collin Walling <walling@linux.ibm.com>, thuth@redhat.com,
 berrange@redhat.com, richard.henderson@linaro.org, david@redhat.com,
 pbonzini@redhat.com, jrossi@linux.ibm.com, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
Cc: jjherne@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 farman@linux.ibm.com, mjrosato@linux.ibm.com, iii@linux.ibm.com
References: <20250711211105.439554-1-zycai@linux.ibm.com>
 <20250711211105.439554-20-zycai@linux.ibm.com>
 <be952290-0791-41e3-bfc7-a22eecfe97d6@linux.ibm.com>
Content-Language: en-US
From: Zhuoying Cai <zycai@linux.ibm.com>
In-Reply-To: <be952290-0791-41e3-bfc7-a22eecfe97d6@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: PJF3ECabGhtSw8B1oDlmhOj4szDQXeQk
X-Authority-Analysis: v=2.4 cv=JOI7s9Kb c=1 sm=1 tr=0 ts=68767ad5 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=VnNF1IyMAAAA:8 a=vu6q9_yT11EkrSj_UysA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: PJF3ECabGhtSw8B1oDlmhOj4szDQXeQk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE1MDE0NSBTYWx0ZWRfX68xqJ7fRmasM
 E5QUe2crJNKZhQOenpQvbD++gc+FlJK+q8kuiuaLd+Ha2qFbkN8QNIXlNArbVvEVFq4vdNtz5WX
 3Mc2ZSXHiO+kxRBSC5/kJwmHDd7E7rTPcwJFIIse7urqacr6Cn7IKJ7pM/Wxka7yKjSuCoSlgMx
 vxQo8tpJUt5/XJPQ5tgqSnc977WOUkLA69753cCwVYgr5P2o/p2G1X3a+Wf3XdplxhWwAYQZj22
 qWvk0svNBdr6Rq6ov8RRypik2k4mULF4HiyxFe+ZpRqTa8+FHj3vF9bCSZlGH9fCVMOutD8MqyN
 MFiPxqwXPeFoxS68db3RoSRcX5Ah9qkQkM+dG6fkNFB+aJtaSXj2QjSDiuT/f9/EV3rZWk/2lzm
 ellpyE7afNw4M/XfdOMJS4m6HgBGPQ4QP9rTwf3B/Fg4h+ywiZERYGIVEboVJ7vjwUI4+n45
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-15_04,2025-07-15_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 phishscore=0 mlxlogscore=999 malwarescore=0 clxscore=1015 bulkscore=0
 priorityscore=1501 mlxscore=0 spamscore=0 adultscore=0 impostorscore=0
 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507150145
Received-SPF: pass client-ip=148.163.156.1; envelope-from=zycai@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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

On 7/14/25 6:10 PM, Collin Walling wrote:
> On 7/11/25 5:10 PM, Zhuoying Cai wrote:
>> Make the address variable a parameter of zipl_load_segment and return
>> segment length.
> 
> There's mixed use of the term "comp_len" and "segment length".  Since
> the context here is "zipl_load_segment", perhaps the variable should be
> "seg_len"?
> 
>>
>> Modify this function for reuse in the next patch, which allows
>> loading segment or signature data to the destination memory address.
> 
> The function is still loading a segment from the disk regardless if it's
> a signature or something else.  I'd suggest rewording the above for more
> precision about the change:
> 
> "Modify this function to allow the caller to specify a memory address
> where segment data should be loaded into."
> 
>>
>> Add a comp_len variable to store the length of a segment and return this
>> variable in zipl_load_segment.
> 
> This sentence is redundant since the change in the return behavior is
> mentioned in the first sentence.
> 
>>
>> comp_len variable is necessary to store the calculated segment length and
>> is used during signature verification. Return the length on success, or
>> a negative return code on failure.
>>
>> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
> 
> Bit of a nit: technically this isn't refactoring since the function's
> behavior has changed (new param and different return meaning).  Change
> the commit header from "refactor" to "rework" or something akin to that.
> 
>> ---
>>  pc-bios/s390-ccw/bootmap.c | 12 +++++++-----
>>  1 file changed, 7 insertions(+), 5 deletions(-)
>>
>> diff --git a/pc-bios/s390-ccw/bootmap.c b/pc-bios/s390-ccw/bootmap.c
>> index ced5190888..2513e6c131 100644
>> --- a/pc-bios/s390-ccw/bootmap.c
>> +++ b/pc-bios/s390-ccw/bootmap.c
>> @@ -613,19 +613,18 @@ static int ipl_eckd(void)
>>   * IPL a SCSI disk
>>   */
>>  
>> -static int zipl_load_segment(ComponentEntry *entry)
>> +static int zipl_load_segment(ComponentEntry *entry, uint64_t address)
> 
> The return value meaning of this function has changed from being "< 0
> means error, 0 is okay" to "< 0 means error, otherwise the total size of
> the component is returned".  Please add a comment above this function to
> describe its return behavior so it's easy for future developers to
> understand it.
> 
>>  {
>>      const int max_entries = (MAX_SECTOR_SIZE / sizeof(ScsiBlockPtr));
>>      ScsiBlockPtr *bprs = (void *)sec;
>>      const int bprs_size = sizeof(sec);
>>      block_number_t blockno;
>> -    uint64_t address;
>>      int i;
>>      char err_msg[] = "zIPL failed to read BPRS at 0xZZZZZZZZZZZZZZZZ";
>>      char *blk_no = &err_msg[30]; /* where to print blockno in (those ZZs) */
>> +    int comp_len = 0;
>>  
>>      blockno = entry->data.blockno;
>> -    address = entry->compdat.load_addr;
>>  
>>      debug_print_int("loading segment at block", blockno);
>>      debug_print_int("addr", address);
>> @@ -662,6 +661,9 @@ static int zipl_load_segment(ComponentEntry *entry)
>>                   */
>>                  break;
>>              }
>> +
>> +            comp_len += bprs->size * (bprs[i].blockct + 1);
>> +
> 
> I'm confused by the arithmetic here.  Why is size multiplied by the
> block count?  Won't that artificially inflate the value representing the
> size of the component?  What's the reason that comp_len += bprs->size
> isn't sufficient?
> 

A component table entry points to a segment table, which holds pointers
to code segments loaded into contiguous memory.

Since segments can vary in length, the block count field may be nonzero.

Block size indicates the number of bytes in a single logical block, so
the total component size is the block size multiplied by the block count.

>>              address = virtio_load_direct(cur_desc[0], cur_desc[1], 0,
>>                                           (void *)address);
>>              if (!address) {
>> @@ -671,7 +673,7 @@ static int zipl_load_segment(ComponentEntry *entry)
>>          }
>>      } while (blockno);
>>  
>> -    return 0;
>> +    return comp_len;
>>  }
>>  
>>  static int zipl_run_normal(ComponentEntry *entry, uint8_t *tmp_sec)
>> @@ -685,7 +687,7 @@ static int zipl_run_normal(ComponentEntry *entry, uint8_t *tmp_sec)
>>              continue;
>>          }
>>  
>> -        if (zipl_load_segment(entry)) {
>> +        if (zipl_load_segment(entry, entry->compdat.load_addr) < 0) {
>>              return -1;
>>          }
>>  
> 


