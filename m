Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 652BC606A32C
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Nov 2026 18:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=TKlonGij
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xUTXS-0007DL-QU; Fri, 20 Nov 2026 13:40:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amachhiw@linux.ibm.com>)
 id 1xUTX8-0007AV-SV; Fri, 20 Nov 2026 13:40:35 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amachhiw@linux.ibm.com>)
 id 1xUTX6-0005aY-HO; Fri, 20 Nov 2026 13:40:26 -0500
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AKEur8W3424197; Fri, 20 Nov 2026 18:40:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pp1; bh=SDZVOFGD3Z/NTKIA9Gqc+4t2chBWhH
 GnctZv1crd1kY=; b=TKlonGij6ogOYG50TzuIfn1kOvVewpj3awufD/EEeh7NFV
 7/UvHuOgxiLsa2V5Usslp/VhcmA126r6jo9EmdQh77kJ8dth7Y6OpEntaaT/NeV/
 42ezGS8us6nGtgz9eOiWOJzslNDb4g0GUWwz07D1fEDQ7vaqcG6zb0/iVX0SPVrS
 Kn+udVZe5fcJK9oGu1WdRafUaaja8VgqW4+3jaDTnlgde9sBZPdTMwqBVxfYNTkf
 HsQy5jaTqJnyYlKOffkNR3Av2S19K4y0h/3tIa02bHe2s1PvC/nYFVnsrwKfzFke
 DduXTw/tLGxQGgUv43gV7rCPj4RA22pXECwmj8Mw==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j105w26wn-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 20 Nov 2026 18:40:18 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AKHreik218666; Fri, 20 Nov 2026 18:40:18 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4j1v9xhrvm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 20 Nov 2026 18:40:18 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6AKIeEqK45023616
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 20 Nov 2026 18:40:14 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4DCB420040;
 Fri, 20 Nov 2026 18:40:14 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CB87820043;
 Fri, 20 Nov 2026 18:40:12 +0000 (GMT)
Received: from fedora (unknown [9.5.7.39])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Fri, 20 Nov 2026 18:40:12 +0000 (GMT)
Date: Sat, 21 Nov 2026 00:18:44 +0530
From: Amit Machhiwal <amachhiw@linux.ibm.com>
To: Utkarsh Verma <uverma@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 Chinmay Rath <rathc@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Amit Machhiwal <amachhiw@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH] spapr: nested: Check guest state buffer len in
 H_GUEST_{GET, SET}_STATE
Message-ID: <20261120230339.ff9b806a-52-amachhiw@linux.ibm.com>
Mail-Followup-To: Utkarsh Verma <uverma@linux.ibm.com>, 
 qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Chinmay Rath <rathc@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>
References: <20261120080829.195131-1-uverma@linux.ibm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261120080829.195131-1-uverma@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: g140iRiC8R-U1mLqC3_tBGbEucb84Zrs
X-Authority-Analysis: v=2.4 cv=HL9WhYtv c=1 sm=1 tr=0 ts=6b009413 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=p0WdMEafAAAA:8
 a=69wJf7TsAAAA:8 a=VnNF1IyMAAAA:8 a=r0KO3Q_-uB8qiZS0weAA:9 a=CjuIK1q_8ugA:10
 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-ORIG-GUID: AWveS1RsSUUyDfJRFH1J1xtPabDzL-lq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIwMDA3MyBTYWx0ZWRfX1bmb7Enh7VLX
 WU5iznNKbMHo+mzCmgxZ7YVDRe0K4dbXlgFgI0SLg3zALu1op2/E4i5Ksx8StC7yDLdsfnozD4X
 zTb5Jqlswod406WjznIOFpBgbhfoDzWtZL8eK1w9vbBw83J7AvP14qqM7/XGlwvNVE1XyplF1XV
 7H7SxZLSVV5bk77LHmMH93PcOxXIYQdA+vJBmj+bgVavjubBPajbgxEbTrWl+6fTBXnamb9UNxL
 rgw/j0QPK8LpWo71c6sj1Z0PLcwP1pdXOyFp4w2BjgXRVnzTbI63c7JucSF0TwFQ+1TJyzrTM7i
 Gx3hY92qwWrGSGYoQe2AEg/7c8PYzceDU85Gr8Gk8lPrc77EXfS7VyDhcHP8/Rk5R8/zmm5WEq4
 mN9aQ+u9gIcxzpKEI0c7ItJFy5Wm3vS6SVLrkVtetCdYuwYJFYSiNFvXBmzOCNMibnNVrVi5tgB
 NKnc3TVIeB2GkYEOHeA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIwMDA3MyBTYWx0ZWRfX5IyPJ2AL+5nn
 K+oplJcb1jAFJvlXWE02yjt0kbZlkpuQFtdSdZi3jzofRWfOiDwiTwzRGlLhU/EcHqcvDDjhBpq
 LD5RoIo7ZTFNyZXVJvt2XqR8W/+uIkY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-20_05,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 spamscore=0 priorityscore=1501 impostorscore=0
 adultscore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611200073
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=amachhiw@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Utkarsh,

Thanks for working on this and sending the patch.  Please find my comments
inline below.

On 2026/11/20 01:38 PM, Utkarsh Verma wrote:
> Add validations to check for guest state buffer length before accessing
> the fields to avoid out of bound memory reads.
> 
> Also, replace the assertions for invalid arguments with proper return
> error codes and fix the return error codes at other places as well
> (return code H_P4 for buf and H_P5 for buflen)
> 
> Fixes: 64c43909b297 ("spapr: nested: Introduce H_GUEST_[GET|SET]_STATE hcalls.")

Please consider adding:
Cc: qemu-stable@nongnu.org

> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4741
> Signed-off-by: Utkarsh Verma <uverma@linux.ibm.com>
> ---
>  hw/ppc/spapr_nested.c | 19 +++++++++++++------
>  1 file changed, 13 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/ppc/spapr_nested.c b/hw/ppc/spapr_nested.c
> index 10cf634da1..8b981fff14 100644
> --- a/hw/ppc/spapr_nested.c
> +++ b/hw/ppc/spapr_nested.c
> @@ -1117,7 +1117,9 @@ static bool guest_state_request_check(struct guest_state_request *gsr)
>      uint16_t id, size;
>  
>      /* gsb->num_elements = 0 == 32 bits long */
> -    assert(len >= 4);
> +    if (len < sizeof(gsb->num_elements)) {
> +        return false;
> +    }

Removing assert for an input validation makes sense.  We always expect a return
from an hcall and an assert can't return anything to the guest.  A failed assert
calls abort(), which kills the whole QEMU process, i.e.  the L1 guest and all
its nested guests.

>  
>      num_elements = be32_to_cpu(gsb->num_elements);
>      element = gsb->elements;
> @@ -1126,6 +1128,9 @@ static bool guest_state_request_check(struct guest_state_request *gsr)
>      /* Walk the buffer to validate the length */
>      while (num_elements) {
>  
> +        if (len < offsetof(struct guest_state_element, value)) {
> +            return false;
> +        }
>          id = be16_to_cpu(element->id);
>          size = be16_to_cpu(element->size);
>  
> @@ -1133,7 +1138,7 @@ static bool guest_state_request_check(struct guest_state_request *gsr)
>              log_element(element, gsr);
>          }
>          /* buffer size too small */
> -        if (len < 0) {
> +        if (len < offsetof(struct guest_state_element, value) + size) {

The old check ran after id/size were read, and it only noticed an overrun at the
next iteration, so it could never catch the last element.  Two notes on this
function:

 - len is int64_t and these comparisons are against size_t, so a negative len
   would compare as huge and pass.  That cannot happen today: on the hcall path
   len starts at buflen (<= GSB_MAX_BUF_SIZE) and it is only reduced after these
   checks pass.  It depends on that ordering, so a cast or a signed constant
   might be worth it.

-  Two paths below still call log_element() after the new checks: unknown
   element ID and size mismatch.  log_element() reads 8 bytes from
   element->value whatever element->size is, so an element header that ends
   exactly at the end of the buffer would still read past the buffer, but only
   with -d guest_errors.  I have not tested this; it comes from reading the
   code.

>              return false;
>          }
>  
> @@ -1464,7 +1469,7 @@ static target_ulong getset_state(SpaprMachineState *spapr,
>      lenleft = gsr->len;
>  
>      if (!guest_state_request_check(gsr)) {
> -        return H_P3;
> +        return H_P4;

I don't think H_P4 is right for all of these.  PAPR describes H_P4 as "the
dataBuffer had an invalid data buffer address", and for H_GUEST_GET_STATE H_P5
as "the dataBufferSizeInBytes parameter had an invalid data buffer size or the
buffer was too small to fit the requested guest state".

The three new length checks above (len < 4, truncated header, truncated payload)
are "buffer too small" cases, so for GET_STATE they should return H_P5.  The
tables also have H_Invalid_Element_Id and H_Invalid_Element_Size, which fit the
unknown-ID and size-mismatch failures below.  Since H_GUEST_RUN_VCPU reaches
this function too and uses different codes (H_Input_Buffer_Too_Small,
H_Invalid_Element_*), guest_state_request_check() would need to tell the caller
why it failed, not only that it did.

>      }
>  
>      num_elements = be32_to_cpu(gsr->gsb->num_elements);
> @@ -1516,12 +1521,12 @@ static target_ulong map_and_getset_state(PowerPCCPU *cpu,
>      gsr->gsb = address_space_map(CPU(cpu)->as, gsr->buf, (uint64_t *)&len,
>                                   is_write, MEMTXATTRS_UNSPECIFIED);
>      if (!gsr->gsb) {
> -        rc = H_P3;
> +        rc = H_P4;
>          goto out1;
>      }
>  
>      if (len != gsr->len) {
> -        rc = H_P3;
> +        rc = H_P4;

H_P4 is right for the two map failures.

The !gsr->gsb branch has a separate problem that this patch does not fix: with
buflen = 0, address_space_map() returns NULL, we jump to out1 and call
address_space_unmap() on the NULL buffer, which crashes QEMU with SIGSEGV on
TCG.  This is not a regression and should not block this patch.  I have a
possible fix that I'm still testing.  I can send it as a follow-up on top of
your next version, or you can fold it into v2 if you prefer; let me know.

Also, map_and_getset_state() is used by h_guest_run_vcpu() as well, where the
buffer is the vCPU's registered input buffer (runbufin) and not an hcall
argument.  As implemented here, H_GUEST_RUN_VCPU only takes flags, lpid and
vcpuid (H_P2 for lpid, H_P3 for vcpuid), and PAPR has no H_P4 for it, so a bad
input buffer used to return H_P3 (the same as a bad vcpuid) and now returns
H_P4.  PAPR lists H_Input_Buffer_Not_Defined, H_Input_Buffer_Too_Small,
H_Hardware and H_Invalid_Element_{Id,Size,Value} for the input buffer, so this
path needs those codes instead.

>          goto out1;
>      }
>  
> @@ -1546,7 +1551,9 @@ static target_ulong h_guest_getset_state(PowerPCCPU *cpu,
>      SpaprMachineStateNestedGuest *guest = NULL;
>  
>      gsr.buf = buf;
> -    assert(buflen <= GSB_MAX_BUF_SIZE);
> +    if (buflen > GSB_MAX_BUF_SIZE) {
> +        return H_P5;
> +    }
>      gsr.len = buflen;
>      gsr.flags = 0;

I reproduced #4741 on an unpatched TCG build (SIGSEGV with buf = 0x0FFF_FFFC,
buflen = 4, num_elements = 1 in a 256M guest).  With the patch the hcall returns
an error and QEMU keeps running.  buflen = 3 and buflen = 0x110000 (SIGABRT
before) also return an error now.  My test image only prints S/E, so I did not
check which return code comes back.

Thanks,
Amit

