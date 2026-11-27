Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5715C606A31E
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Nov 2026 16:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=I6GDsG4G
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWypO-0001Vg-Nb; Fri, 27 Nov 2026 11:29:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amachhiw@linux.ibm.com>)
 id 1xWypG-0001TU-VT; Fri, 27 Nov 2026 11:29:31 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amachhiw@linux.ibm.com>)
 id 1xWypD-0002Da-HN; Fri, 27 Nov 2026 11:29:30 -0500
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ARG50tj2252418; Fri, 27 Nov 2026 16:29:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pp1; bh=KgLqSiemi8kGyXBZC+l2853Wan6+Ea
 l67ic2P10Fxsg=; b=I6GDsG4GEnz5BgABjrJ1UftDaSDd+pKDT0MMybeezhQb5G
 CicwgK+KPk4rSPfoBEOljcp5Y4PHkSRtdTR0GseQqmby6c6chEGjaDe+QXD0BcCS
 9IfPTynsouoGDKuM1S2AJsS8A0OjfUmBPghJbRo3AdyXgyPagUFd6tPfrDj8EC/H
 3BPXRDGkWwYEhobbkj29UgHji1tNWG2gl7fJoDfsITUeT9AGYTzL0EGqok8Or5hE
 +sEc5zMlcfkFKYG6JEPTRdRCESZ9JGGmLPX9AnpN/QZKQTc/NBza6QDwGrWPLZJf
 S+YuxjlfL+BgZ7cONqkc8LiQXzex8O55xfhMGTVQ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j34p4wprd-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 27 Nov 2026 16:29:22 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ARFnQFw3360192; Fri, 27 Nov 2026 16:29:22 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4j5uxx9hg7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 27 Nov 2026 16:29:22 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6ARGTGnP42729964
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 27 Nov 2026 16:29:17 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4F0EA2005A;
 Fri, 27 Nov 2026 16:29:16 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EF8BD2004B;
 Fri, 27 Nov 2026 16:29:14 +0000 (GMT)
Received: from fedora (unknown [9.5.7.39])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Fri, 27 Nov 2026 16:29:14 +0000 (GMT)
Date: Fri, 27 Nov 2026 22:07:47 +0530
From: Amit Machhiwal <amachhiw@linux.ibm.com>
To: Showta Ishizaki <zakinko@snowrabbit.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Amit Machhiwal <amachhiw@linux.ibm.com>
Subject: Re: [PATCH] hw/ppc/spapr: Match the CAS PVR list terminator as PAPR
 requires
Message-ID: <20261127192345.1ecfb670-3c-amachhiw@linux.ibm.com>
Mail-Followup-To: Showta Ishizaki <zakinko@snowrabbit.org>, 
 qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
References: <20261028194120.C7B72C9296@bambi.snowrabbit.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261028194120.C7B72C9296@bambi.snowrabbit.org>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI3MDA2NCBTYWx0ZWRfX7YtspsIsZ3+y
 n0tIXetXuZHweMyMbn7yrP3TqdFBKktnVR6iGMX2IVNYUW1PWGhmMZrtvG/8poXJsaKODd8DncE
 qzjeZYYrT63qRXJvh2P4inykLtmfW7U=
X-Proofpoint-GUID: ESY_FhFQXIQy2BOSDzcxzC8uq43lbO81
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI3MDA2NCBTYWx0ZWRfX0/AmD0TqUEly
 TVrDt+a6CqLGtnMhH4mEqBtf0k2B9FZOAS6CN8cWRJlAXK8wJSUSyG6hIkRLqtAGad+IO6z0We8
 Kv5cpecRMOY/QSZYkcFBw/wTJLCbwx8YR4qZ8qZiLVgJxXT4VY5srGJNE0yoIOxb5UtRV//GDT/
 t0Uyp3ELHi3vwYAxIu2FSgFUjv4fg7UHGHHv+Keh11cw8b15q5AAQYAt5VwcGwDhMqXq0QjQa2S
 fGm3OLgOZqtMQRdXnyWRRPfHKDQ3GcZb0JD3asktLAbbuQPSOSaa0pc0RX547Al1Oh4ha6q8wrh
 6pXFiYIEjr0FLB2Gplx17e2m3ZNZjSQpxLb2SQ2UG2wdnIqX2w1rnClhGM52fB0w9UPw310H+3c
 WabZSU0T1aMpSDLRU5Ouss5SO1+3C7o4N/sxIb5GtLFJL04mLBV6RCMqwKzqqFwz3dMp84yullk
 ux1Bu6nTktyNB+rTnjw==
X-Proofpoint-ORIG-GUID: ru9-feIt6dKIWdYZutfkUUwJ_9PHXpXS
X-Authority-Analysis: v=2.4 cv=QabzLcbv c=1 sm=1 tr=0 ts=6b09afe3 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=L9C5IM_eAAAA:8
 a=VnNF1IyMAAAA:8 a=h-_faxIVXE_-Btiv-s8A:9 a=CjuIK1q_8ugA:10
 a=d8_PwHeUR2dB5DzxAQPm:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-27_03,2026-11-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0
 bulkscore=0 priorityscore=1501 clxscore=1015 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611270064
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Showta,

Thank you for the binaries and for explaining where the ofwboot comes from.
With them I could reproduce the failure and the fix.  More details are below.

On 2026/10/29 03:45 AM, Showta Ishizaki wrote:
> cas_check_pvr() stops at the first entry whose value has bits outside
> its mask, before comparing that entry with the processor's PVR.  PAPR
> has the PVR list processed "until either a List-entry allows the
> process to continue, or the Terminator-list-entry has been processed",
> and both of its "List-entry values of special interest", 0x00000000
> 0xFFFFFFFF ("matches any PVR value") and 0xFF000000 0x0FFFFFFF, are
> terminators (B.6.2.3 in PAPR v10.60; the same text is in B.5.2.3 of
> LoPAR 2.9 and B.6.2.3 of LoPAPR 1.1).  The terminator takes part in
> the match like any other entry.

<snip>

> Fixes: 152ef803ceb1 ("pseries: Rewrite CAS PVR compatibility logic")
> Signed-off-by: Showta Ishizaki <zakinko@snowrabbit.org>
> ---
>  hw/ppc/spapr_hcall.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
> index 708902934c..29b726b474 100644
> --- a/hw/ppc/spapr_hcall.c
> +++ b/hw/ppc/spapr_hcall.c
> @@ -1151,10 +1151,6 @@ static uint32_t cas_check_pvr(PowerPCCPU *cpu, uint32_t max_compat,
>          pvr = ldl_be_phys(&address_space_memory, *addr + 4);
>          *addr += 8;
>  
> -        if (~pvr_mask & pvr) {
> -            break; /* Terminator record */
> -        }
> -
>          if ((cpu->env.spr[SPR_PVR] & pvr_mask) == (pvr & pvr_mask)) {
>              explicit_match = true;
>          } else {
> @@ -1162,6 +1158,10 @@ static uint32_t cas_check_pvr(PowerPCCPU *cpu, uint32_t max_compat,
>                  best_compat = pvr;
>              }
>          }
> +
> +        if (~pvr_mask & pvr) {
> +            break; /* Terminator record */
> +        }

Nit: the "/* Terminator record */" comment is less informative in its new place.
Something like below might help:

  if (~pvr_mask & pvr) {
      /*
       * Terminator record: matched above like any other entry and acts as
       * the end of the PVR list marker.
       */
      break;
  }


The change looks correct to me.  The history in the commit message is right:
152ef803ceb1 moved the terminator test in front of the comparison, and its
message only talks about how the compat mode is chosen.  The reorder also
matches PAPR (B.6, the section your commit message cites).  The list is defined
as follows (I write the bitwise NOT as ~, as in C):

  PVR-list = Terminator-list-entry | Non-terminator-list : Terminator-list-entry
  Non-terminator-list = Non-terminator-list-entry | Non-terminator-list-entry : Non-terminator-list
  List-entry = 4-byte-mask : 4-byte-PVR-value
  Terminator-list-entry = List-entry such that (~mask & pvr) != 0
  Non-terminator-list-entry = List-entry such that (~mask & pvr) == 0

So the terminator is not just an end marker: it is the last List-entry of the
list, with a mask and a PVR like the others, and a list may even consist of the
terminator alone.  And this is how CAS walks the list:


    The PVR-list of the ibm,architecture.vec structure is processed for
    the PVR value of each processor that the client program may be
    exposed to until either a List-entry allows the process to
    continue, or the Terminator-list-entry has been processed.  If no
    List-entry allows the process to continue, then the
    ibm,client-architecture-support method terminates partition
    operation as with a boot failure.  A List-entry allows the process
    to continue if either of the two following conditions hold.
    1. (Processor-PVR-value & List-entry[4-byte-mask]) ==
       (List-entry[4-byte-PVR-value] & List-entry[4-byte-mask])
       /* The client program explicitly supports the processor
       implementation */
    2. If (the processor requires no client support for errata) &&
       (Logical-Processor-PVR-value & List-entry[4-byte-mask]) ==
       (List-entry[4-byte-PVR-value] & List-entry[4-byte-mask])
       /* Client program specifies support for this level of
       architecturally compliant processors */
    List-entry values of special interest (these are
    Terminator-list-entry values):
    * 0x00000000 0xFFFFFFFF Single entry list that matches any PVR value
    * 0xFF000000 0x0FFFFFFF Single entry list that matches all
      architecturally compliant processors.

"[...] or the Terminator-list-entry has been processed" means the terminator is
tested against the two conditions like any other entry, and the walk stops after
that.  The old order stopped before testing it, so a CPU whose only matching
entry is the terminator (your Power10 entry) was never matched, and neither of
the two special single-entry lists could be evaluated at all.  Also, *addr is
still advanced before the break, so the option vector pointer handed to the rest
of CAS is unchanged.

A few comments, none of them blockers:

1. Side note, not a request: the two special values you cite are both
   terminators, which is right.  From reading the code (I did not test it), the
   patch makes them reach the match test, and 0x00000000 0xFFFFFFFF then matches
   because a zero mask makes the explicit_match test true.  0xFF000000
   0x0FFFFFFF is also compared now, but it still has no effect: it is meant for
   the logical-PVR condition, and pcc_compat() does not apply the mask, it looks
   the PVR up exactly in compat_table, where 0x0FFFFFFF is not present.  That is
   how it was before and it is outside this patch.

2. Commit message wording: the message says "NetBSD's ofwboot", but the one that
   makes this call is from your ppc64-pseries port and is in no NetBSD release
   (the 11.1 ofppc ofwboot never calls CAS).  Could you say "an out-of-tree
   NetBSD pseries port" or similar?  Also, since boot continues, it would help
   to say what is lost: CAS returns H_HARDWARE before the option vectors are
   parsed, so the XIVE request in vector 5 is ignored and the guest stays on
   XICS.

3. A question about your port, not about this patch: ofw_cas_vec[] lists only
   real PVRs and no logical one, and vector 1 claims the architecture levels up
   to 3.10.  I read that as deliberate.  Just so you know how QEMU treats it:
   the compat mode is chosen from the PVR list only.  Vector 1 is only read for
   the 3.00 bit (to hide the radix bit in "ibm,pa-features" from guests that do
   not claim 3.00), so the levels in it do not select a compat mode.  This guest
   therefore always runs in raw mode and sees the real PVR in "cpu-version".

   With `-machine max-cpu-compat=power9` raw mode is not offered, and CAS still
   fails with your patch applied (see below).  A logical entry that the cap
   allows, for example 0xffffffff 0x0f000005 before the terminator, would avoid
   that, and "cpu-version" would then hold the logical PVR, which PAPR says it
   may.  Is raw-only intended?  I have not tried a list with a logical entry.

What I ran, on Qemu v11.2.0-rc2 (9751c62358) with and without your patch, with
local debug prints in cas_check_pvr() and -trace spapr_cas_pvr:

- A Linux guest, under TCG (PVR 0x801200) and under KVM on a Power10 host (PVR
  0x800200).  The PVR list is the same with and without the patch, only the
  0x800000 entry matches the CPU PVR, best_compat is 0xf000006 in both, and the
  only difference is that the final 0xf000002 / 0xfffffffd terminator is now
  compared (and rejected by ppc_check_compat()) instead of being skipped.

- Your ofwboot and kernel (ppc64-pseries, built at 82c0b82eb), with your command
  line, -cpu power10, TCG:

    Without the patch: the four entries before the Power10 one are compared and
    none matches; the Power10 entry (0xffff0000 0x0080ffff) is read but never
    compared.  The trace shows "explicit_match=0", then "Couldn't negotiate a
    suitable PVR during CAS" and "ibm,client-architecture-support: error".  The
    kernel comes up without any "xive:" line.

    With the patch: the Power10 entry is compared and matches
    ("explicit_match=1", best_compat stays 0), CAS returns without an error,
    and the kernel prints "xive: exploitation mode, priority 6, 65536-byte
    queues".

  Both runs end at the kernel's "root device:" prompt (no disk).

- The same ofwboot and kernel, with your patch only, and "-machine
  pseries,max-cpu-compat=power9,cap-hpt-max-page-size=16M" added to the command
  line: the Power10 entry matches ("explicit_match=1", current=0xf000005,
  best_compat stays 0), but CAS still fails with:

    "Couldn't negotiate a suitable PVR during CAS"

  ...because raw mode is not accepted when max-cpu-compat is set.  I did not run
  this one without the patch.

So, with the above nit and the commit message wording (comment 2) addressed,
please feel free to add:

Reviewed-by: Amit Machhiwal <amachhiw@linux.ibm.com>
Tested-by: Amit Machhiwal <amachhiw@linux.ibm.com>

Thanks,
Amit

