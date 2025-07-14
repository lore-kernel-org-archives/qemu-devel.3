Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEF4CC83F1B
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 22:35:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubRlx-0005Oa-To; Mon, 14 Jul 2025 18:35:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1ubROB-00043Q-F0; Mon, 14 Jul 2025 18:11:11 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1ubRO8-0000lb-M9; Mon, 14 Jul 2025 18:11:11 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56EL8pPS008271;
 Mon, 14 Jul 2025 22:11:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=AZOWYu
 9mclR8wzNOKqzw5t53A6TQXyuaBJ/t1QydrMs=; b=mQVjhZgBX8i5nMHOJ1D+yM
 9raeOluolrSb2Iop5ROZlMCgMkH4IVEWulyGAquyyEFYsr1q0g8atpd4xTv9tJh9
 zBmlbz+1roVFOT5X5JcFx+YdPOMu/3wPPm0qUlk+w9oKm6PxmVE3pexGARZ+IQRv
 e23fUG8y5yFNvXOPByiV8G5KS1cKUX1ZOWG4wUC33ZKZO9O/BuTcL8AmDXwjF6Eh
 cjA2HXItLb9iQAB3q6hAWC4eRhXK22CqsibrkCt8XTOScIAm/ofvqvlg5S67nyDE
 /r8ydMphXTmlEwX+ejYxQ4TkAz9NM1aqcOSgKIM/wSIuAl7Is3AudMDsf/KMqS4Q
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47ufc6uqxw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 14 Jul 2025 22:11:05 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56EKIDhR021914;
 Mon, 14 Jul 2025 22:10:58 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 47v4r2yde7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 14 Jul 2025 22:10:58 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 56EMAu6B11141884
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 14 Jul 2025 22:10:56 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8EF4D58053;
 Mon, 14 Jul 2025 22:10:56 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 53BFD58043;
 Mon, 14 Jul 2025 22:10:55 +0000 (GMT)
Received: from [9.12.68.85] (unknown [9.12.68.85])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTPS;
 Mon, 14 Jul 2025 22:10:55 +0000 (GMT)
Message-ID: <be952290-0791-41e3-bfc7-a22eecfe97d6@linux.ibm.com>
Date: Mon, 14 Jul 2025 18:10:54 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 19/28] pc-bios/s390-ccw: Refactor zipl_load_segment
 function
To: Zhuoying Cai <zycai@linux.ibm.com>, thuth@redhat.com, berrange@redhat.com, 
 richard.henderson@linaro.org, david@redhat.com, pbonzini@redhat.com,
 jrossi@linux.ibm.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: jjherne@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 farman@linux.ibm.com, mjrosato@linux.ibm.com, iii@linux.ibm.com
References: <20250711211105.439554-1-zycai@linux.ibm.com>
 <20250711211105.439554-20-zycai@linux.ibm.com>
Content-Language: en-US
From: Collin Walling <walling@linux.ibm.com>
In-Reply-To: <20250711211105.439554-20-zycai@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Je68rVKV c=1 sm=1 tr=0 ts=68758079 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=VnNF1IyMAAAA:8 a=8F4PBablFy8sE-ONePwA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE0MDE0OSBTYWx0ZWRfX61CrNEaErhCb
 1++z2eE32EclM+mzSKFT0Glm7lzr11PfkPJ7U5YIb0cYWB2Q6fEejBOIRewDqFqkuYhbgOt+8is
 vmyZA7D3ShHAJSauhulVE5CNrbY1HKkc9GrHNhw5vdJdOwRUakOe16UMKjKazWHCorIOS0Ek+ap
 FKU3DyAoS/uWh8rU9AhgxVuKHMx+DVBzF7LhthyoeQA8L9XS+HhMJUtoWbHyR79di5OJhZJP9fi
 iHRAAEYpflcQFwQEWGIvkFSS+7GucgduTI+Afd+4HVJtadgMNwNKg7zkhrSZYUgwDh19CXZj+f4
 W8BNHS2TEAxXom+FhtmVRZ2UnB4JsbqT5CW5K7LftzxG7WVf3WTIACBAbaSeJjgtzxdYM0Wyewh
 VfkL/4WZ7p9TEbogeSCKCMnLfFW3tJIF8oaY3/m3KHp6PpwVW+b1qRr1ibA0LM/haMUtFx4B
X-Proofpoint-GUID: 4ggV-d6Mn6rUjuMUiN4RTEfxhGYeSOBF
X-Proofpoint-ORIG-GUID: 4ggV-d6Mn6rUjuMUiN4RTEfxhGYeSOBF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-14_02,2025-07-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0
 malwarescore=0 lowpriorityscore=0 suspectscore=0 adultscore=0
 priorityscore=1501 clxscore=1015 bulkscore=0 phishscore=0 spamscore=0
 mlxlogscore=999 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507140149
Received-SPF: pass client-ip=148.163.158.5; envelope-from=walling@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 7/11/25 5:10 PM, Zhuoying Cai wrote:
> Make the address variable a parameter of zipl_load_segment and return
> segment length.

There's mixed use of the term "comp_len" and "segment length".  Since
the context here is "zipl_load_segment", perhaps the variable should be
"seg_len"?

> 
> Modify this function for reuse in the next patch, which allows
> loading segment or signature data to the destination memory address.

The function is still loading a segment from the disk regardless if it's
a signature or something else.  I'd suggest rewording the above for more
precision about the change:

"Modify this function to allow the caller to specify a memory address
where segment data should be loaded into."

> 
> Add a comp_len variable to store the length of a segment and return this
> variable in zipl_load_segment.

This sentence is redundant since the change in the return behavior is
mentioned in the first sentence.

> 
> comp_len variable is necessary to store the calculated segment length and
> is used during signature verification. Return the length on success, or
> a negative return code on failure.
> 
> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>

Bit of a nit: technically this isn't refactoring since the function's
behavior has changed (new param and different return meaning).  Change
the commit header from "refactor" to "rework" or something akin to that.

> ---
>  pc-bios/s390-ccw/bootmap.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/pc-bios/s390-ccw/bootmap.c b/pc-bios/s390-ccw/bootmap.c
> index ced5190888..2513e6c131 100644
> --- a/pc-bios/s390-ccw/bootmap.c
> +++ b/pc-bios/s390-ccw/bootmap.c
> @@ -613,19 +613,18 @@ static int ipl_eckd(void)
>   * IPL a SCSI disk
>   */
>  
> -static int zipl_load_segment(ComponentEntry *entry)
> +static int zipl_load_segment(ComponentEntry *entry, uint64_t address)

The return value meaning of this function has changed from being "< 0
means error, 0 is okay" to "< 0 means error, otherwise the total size of
the component is returned".  Please add a comment above this function to
describe its return behavior so it's easy for future developers to
understand it.

>  {
>      const int max_entries = (MAX_SECTOR_SIZE / sizeof(ScsiBlockPtr));
>      ScsiBlockPtr *bprs = (void *)sec;
>      const int bprs_size = sizeof(sec);
>      block_number_t blockno;
> -    uint64_t address;
>      int i;
>      char err_msg[] = "zIPL failed to read BPRS at 0xZZZZZZZZZZZZZZZZ";
>      char *blk_no = &err_msg[30]; /* where to print blockno in (those ZZs) */
> +    int comp_len = 0;
>  
>      blockno = entry->data.blockno;
> -    address = entry->compdat.load_addr;
>  
>      debug_print_int("loading segment at block", blockno);
>      debug_print_int("addr", address);
> @@ -662,6 +661,9 @@ static int zipl_load_segment(ComponentEntry *entry)
>                   */
>                  break;
>              }
> +
> +            comp_len += bprs->size * (bprs[i].blockct + 1);
> +

I'm confused by the arithmetic here.  Why is size multiplied by the
block count?  Won't that artificially inflate the value representing the
size of the component?  What's the reason that comp_len += bprs->size
isn't sufficient?

>              address = virtio_load_direct(cur_desc[0], cur_desc[1], 0,
>                                           (void *)address);
>              if (!address) {
> @@ -671,7 +673,7 @@ static int zipl_load_segment(ComponentEntry *entry)
>          }
>      } while (blockno);
>  
> -    return 0;
> +    return comp_len;
>  }
>  
>  static int zipl_run_normal(ComponentEntry *entry, uint8_t *tmp_sec)
> @@ -685,7 +687,7 @@ static int zipl_run_normal(ComponentEntry *entry, uint8_t *tmp_sec)
>              continue;
>          }
>  
> -        if (zipl_load_segment(entry)) {
> +        if (zipl_load_segment(entry, entry->compdat.load_addr) < 0) {
>              return -1;
>          }
>  

-- 
Regards,
  Collin

