Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EBA9C5AE5D
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2026 10:58:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtNhC-0005lH-Ku; Mon, 10 Aug 2026 06:57:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1wtNhA-0005l5-E2; Mon, 10 Aug 2026 06:57:28 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1wtNh8-00031q-EX; Mon, 10 Aug 2026 06:57:28 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67A9VYaU1208983; Mon, 10 Aug 2026 10:57:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=drPK3O
 4aQOcLvd2RULq+W3uledZWjB2+RSZrbKOy8OE=; b=tnVaZ6ZO+QY1Q9+tzyrN14
 8LijowaEKcZgCITyqZ53HrEoXAoSPFZoelRHhUBmnoWyyShCR9S8+VUV0ffG7gFE
 ZjVMMIjgPQvQoeUy3VnQ+QSR+zNVmkDb0MBUgfV0L9bSFBVhB6Hj3hZilXMBUOTk
 2ne+nZVR5j5p/6sVjtKBB3cUNmar53yvNsCCTFLlHnwyqrI6fYecAxP0SYYTl4yn
 lf6Ctam6AdSCZ5lnTiVqGrJEf/DE2WpweGf4YUdtgCbXRR2M0++2igj+U4KawHH4
 VtGIOcfJDh0paWCDdn7nVQKuhSE1CY3qgtHUdb4W4TlWHg/qNdvIB/bzKXALxo8Q
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvq97gt0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 10 Aug 2026 10:57:20 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67AAuIAK013774;
 Mon, 10 Aug 2026 10:57:20 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxh0g4abc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 10 Aug 2026 10:57:19 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67AAvIYI32047662
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 10 Aug 2026 10:57:18 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0C86A58058;
 Mon, 10 Aug 2026 10:57:18 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6F07F58057;
 Mon, 10 Aug 2026 10:57:15 +0000 (GMT)
Received: from [9.123.8.229] (unknown [9.123.8.229])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 10 Aug 2026 10:57:15 +0000 (GMT)
Message-ID: <a15bda83-a711-4f34-802c-42c6b389962b@linux.ibm.com>
Date: Mon, 10 Aug 2026 16:27:13 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] tcg: defer tb_flush when initial region alloc fails
To: Yogesh Vyas <yvyas1991@gmail.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, richard.henderson@linaro.org, pbonzini@redhat.com
Cc: anushree.mathur@linux.ibm.com, npiggin@gmail.com, harshpb@linux.ibm.com
References: <20260805171453.25940-1-yvyas1991@gmail.com>
Content-Language: en-US
From: Chinmay Rath <rathc@linux.ibm.com>
In-Reply-To: <20260805171453.25940-1-yvyas1991@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: 7n_-ZLGbmFQESDJ8sG7YYgYckAJNdBk1
X-Authority-Analysis: v=2.4 cv=PbDPQChd c=1 sm=1 tr=0 ts=6a79ae91 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=p0WdMEafAAAA:8
 a=VnNF1IyMAAAA:8 a=pGLkceISAAAA:8 a=t84m7cRm7uVbb12eVNgA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEwMDA5MSBTYWx0ZWRfX9KaDnkCftJhJ
 TQbiRaOS+yuAXefiTXikrj+TdVYcKK0TpMMMdxssG56sCHH1/Vfao5iTkgDDab1dw0jLqBDx4GU
 dUsqsAaT+PylOvVvAfNMETAxLA/xeerATdSpwwZN7vbLFzLFvehoR5vNgV8/nVw1SLchO3mzC3K
 MODFLDE8KaeMQ5cVQ2XsxLDuUnkUMTAkQtsti0jdWTuFkmx8iuZvdmk4LPEYmQHQevL8QBcKylC
 YoXh+6fmX3tLO1enRPiPiFguFrP+mrV08Qvsl0+4CIArTzMtNrwbYWbjbb93jhtZS9bbfodg5Is
 YE0b9W6jjkcu5gEAkHoeYtNUwZlwrbqFPXvs7+y4d370x5blvis3s9MTfsOc/JkQGPuMWaommWW
 udj7s/GIvN6Ri/KX9xI20LrstlxTPFXQSxwYF7flyhhePCKpD1EcDnrZZ1K3fJ2nktT2P6+XOPn
 FY8jyTm3hAxubU6jD0w==
X-Proofpoint-ORIG-GUID: St7eQcxX9YbTfqlLkOX57Up9WhEEgSHP
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEwMDA5MSBTYWx0ZWRfX8/2146KWo8y2
 yh2w/zwXdB8rD7iK9BjhXEn8GE/XDA/8DewrlM2g90OzWWQKg+DyLAU/pnRj9b+O5X9S2jceoeF
 BXMjTEaJNSrg68EneUvRiJnh/fQVekI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-10_02,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 impostorscore=0 malwarescore=0 adultscore=0
 clxscore=1015 priorityscore=1501 suspectscore=0 phishscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608100091
Received-SPF: pass client-ip=148.163.156.1; envelope-from=rathc@linux.ibm.com;
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

Hi Yogesh,

Thanks for coming up with this solution ! It looks good to me. I had a 
doubt though.
After tb_flush_pending is set, tcg_region_reset_all() allocates new 
region to all the contexts. Is there a possibility of region not being 
allocated here as well and the loop repeating ?

Thanks,
Chinmay

On 8/5/26 22:44, Yogesh Vyas wrote:
> Under MTTCG, busy vCPUs can temporarily exhaust the fixed code-gen
> region pool by holding multiple regions. A newly registered vCPU
> thread that then fails tcg_region_initial_alloc() currently hits
> g_assert and aborts QEMU — seen during vCPU hotplug on ppc64 TCG
> (virt-type=qemu) with a large maxcpus.
> Instead of asserting, mark the context with tb_flush_pending. The
> first tcg_tb_alloc() returns NULL so the existing tb_gen_code path
> queues a tb_flush; tcg_region_reset_all() then repacks the pool and
> the new thread obtains a region on retry.
> This mirrors the graceful exhaustion handling already used by the
> runtime tcg_region_alloc() path.
>
> Reported-by: Anushree Mathur <anushree.mathur@linux.ibm.com>
> Closes: https://gitlab.com/qemu-project/qemu/-/work_items/2984
> Signed-off-by: Yogesh Vyas <yvyas1991@gmail.com>
> ---
>   include/tcg/tcg.h |  9 +++++++++
>   tcg/region.c      | 15 ++++++++++++++-
>   tcg/tcg.c         | 12 ++++++++++++
>   3 files changed, 35 insertions(+), 1 deletion(-)
>
> diff --git a/include/tcg/tcg.h b/include/tcg/tcg.h
> index 7669dc1c2d..8a05e3af7b 100644
> --- a/include/tcg/tcg.h
> +++ b/include/tcg/tcg.h
> @@ -381,6 +381,15 @@ struct TCGContext {
>       /* Threshold to flush the translated code buffer.  */
>       void *code_gen_highwater;
>   
> +    /*
> +     * Set when this context (a newly registered vCPU thread) could not be
> +     * given an initial code-gen region because the region pool was
> +     * momentarily exhausted by other busy vCPUs. Rather than aborting, the
> +     * thread defers a tb_flush: the next tcg_tb_alloc() forces a flush +
> +     * retry, which resets the region pool and reclaims slack for this thread.
> +     */
> +    bool tb_flush_pending;
> +
>       /* Track which vCPU triggers events */
>       CPUState *cpu;                      /* *_trans */
>   
> diff --git a/tcg/region.c b/tcg/region.c
> index 5d4be1453b..1200947385 100644
> --- a/tcg/region.c
> +++ b/tcg/region.c
> @@ -393,7 +393,20 @@ bool tcg_region_alloc(TCGContext *s)
>   static void tcg_region_initial_alloc__locked(TCGContext *s)
>   {
>       bool err = tcg_region_alloc__locked(s);
> -    g_assert(!err);
> +
> +    /*
> +     * The region pool can be momentarily exhausted when many busy vCPUs have
> +     * each grabbed several regions during translation. A newly started vCPU
> +     * thread that cannot get its initial region must not abort QEMU: instead
> +     * flag a deferred tb_flush. The thread's first tcg_tb_alloc() will force a
> +     * flush + retry (tcg_region_reset_all() resets region.current and
> +     * re-packs the live contexts), which reclaims that slack and assigns this
> +     * context a region. This mirrors the graceful runtime path in
> +     * tcg_tb_alloc()/tcg_region_alloc().
> +     */
> +    if (err) {
> +        s->tb_flush_pending = true;
> +    }
>   }
>   
>   void tcg_region_initial_alloc(TCGContext *s)
> diff --git a/tcg/tcg.c b/tcg/tcg.c
> index 1e77f2365a..ea66fb6f84 100644
> --- a/tcg/tcg.c
> +++ b/tcg/tcg.c
> @@ -1830,6 +1830,18 @@ TranslationBlock *tcg_tb_alloc(TCGContext *s)
>       TranslationBlock *tb;
>       void *next;
>   
> +    /*
> +     * A newly started vCPU thread that could not obtain its initial region
> +     * (region pool momentarily exhausted) deferred a flush. Trigger it now:
> +     * returning NULL makes the caller queue a tb_flush and retry, which
> +     * resets the region pool and gives this context a valid region. Do this
> +     * before touching code_gen_ptr, which is not yet valid for this context.
> +     */
> +    if (unlikely(s->tb_flush_pending)) {
> +        s->tb_flush_pending = false;
> +        return NULL;
> +    }
> +
>    retry:
>       tb = (void *)ROUND_UP((uintptr_t)s->code_gen_ptr, align);
>       next = (void *)ROUND_UP((uintptr_t)(tb + 1), align);

