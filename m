Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65A6D60A3835
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Nov 2026 16:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=ldLt+/Qf
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWFv8-00038g-29; Wed, 25 Nov 2026 11:32:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1xWFuz-00037f-N6; Wed, 25 Nov 2026 11:32:25 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1xWFux-0005MW-Pu; Wed, 25 Nov 2026 11:32:25 -0500
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6APEZ2NV1608786; Wed, 25 Nov 2026 16:32:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=plibVL
 lnj7XeVd4NnFUBPHWMiC1SU6hCWKNtueszpYE=; b=ldLt+/Qf0uD7NWsIcFT0uY
 C9iFcqKQbgETF/YyoG2EWZahDGXibEbcyzSwU0iGUdnwvaMQ8hb6GMQeyIT/ri6e
 HCDj5akhsJr9NkbxhtCIqaB+Z+SDqL0zc1n1UVmkCSxsRFiTQJ1WKRFfoeoI9gni
 LNIQ2dCIZJXPqHSGmliQMTwDEBTDpBX6b4hmToRI6xLHBeh6oAW8QaU8owHAms8x
 Wb20PrAkizKvJujfj4aAMp4IVCYb6KC0/Ck3n1x9ADeFzztR1RvcxbqnWousgz2h
 bNoKZtuLGUjegEJnZ4dTYGrIIIF28a1qeaDnhCnsFxy5vmHaf7YMM3ZLNn5knmhw
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j34g1cwd6-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 25 Nov 2026 16:32:13 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 6APEKHJc918320; Wed, 25 Nov 2026 16:32:12 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4j5dcuv1xy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 25 Nov 2026 16:32:12 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6APGW8TJ47448444
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 25 Nov 2026 16:32:08 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8A5682004D;
 Wed, 25 Nov 2026 16:32:08 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4692820043;
 Wed, 25 Nov 2026 16:32:08 +0000 (GMT)
Received: from [0.0.0.0] (unknown [9.111.11.72])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 25 Nov 2026 16:32:08 +0000 (GMT)
Message-ID: <23756053-86fb-4732-bef1-397be6233c38@linux.ibm.com>
Date: Wed, 25 Nov 2026 17:32:08 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] target/s390x/tcg: update regs and IV/tweak per
 block in CPACF AES/PAES
To: Andrew Holden <andy0x48@linux.ibm.com>, qemu-devel@nongnu.org,
 freude@linux.ibm.com
Cc: qemu-s390x@nongnu.org, richard.henderson@linaro.org, david@kernel.org,
 cohuck@redhat.com, farman@linux.ibm.com, mjrosato@linux.ibm.com
References: <20261120131443.61606-1-andy0x48@linux.ibm.com>
 <20261120131443.61606-3-andy0x48@linux.ibm.com>
Content-Language: en-US
From: Ilya Leoshkevich <iii@linux.ibm.com>
In-Reply-To: <20261120131443.61606-3-andy0x48@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: J4FsFlQlOIYgR_gRFIAKUGyD8S6HwDwJ
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI1MDA2NCBTYWx0ZWRfX/Xk0ZOqlkdLI
 CZbw4gmqj6fLYG2nLV2hxEaUN1/Kvr74wroQKh9C9GeurYxwpgNtKtgWluPt1mg0fPWfVYm+l9m
 5FLGmwWRkNw3jdAmpoqEmpZUMIl1jg0=
X-Proofpoint-GUID: J4FsFlQlOIYgR_gRFIAKUGyD8S6HwDwJ
X-Authority-Analysis: v=2.4 cv=c8M+0h9l c=1 sm=1 tr=0 ts=6b070d8d cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=GC56UDdQnz8hRXXMcJcA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI1MDA2NCBTYWx0ZWRfXxlfYatRS5fJh
 nvXrQV7fvOPTnB2+9e/g1sJmFkon3XzlB66TQpPWKT/h5kCNed8BvUjguGpmXmW0gxEiNA+B4VX
 oW1nS+DFyN5Nf6faCW4RH1KKDgFKTj5T/VZon0uH17hniOQ8Jm/F1vuYE/2WzCsFqTYSNh+DfTm
 fMr2iQNEha2H+yQRgabSP5719d07nr/dK2t8rGYJHjASyFQBmJW2O+U/bGrL+BKTVOieRXioDXI
 e7oRnM5qdqU0mMF6/Rcp/6E4WGDZaKSl03XAwpYk1S9BO/ADUvQWEWvXzg6MOmEenQSklSuqUgx
 whC+yrRbsDj6p/BIIh7YqygQ97Pp++oUst9jfgJ8QS61KK9mcw8LoQ4I3TVNIoaQpIYWh9aln7c
 taNPJ1iPUHv6VOlhYBt365gRafi7tGw4t49ubQZAdEHgcHwtxgwU2jTFAB1QHumUPlM1djt75NG
 8Ysq0zPnQ1XpY1cIJZg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-25_04,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 malwarescore=0 suspectscore=0 bulkscore=0
 priorityscore=1501 phishscore=0 adultscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611250064
Received-SPF: pass client-ip=148.163.158.5; envelope-from=iii@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 11/20/26 14:14, Andrew Holden wrote:
> The CPACF AES and PAES helpers (ECB, CBC, CTR, and XTS) updated the guest
> registers, and the CBC IV and XTS tweak, only after the whole block
> loop. A guest fault unwinds out of the helper, so the registers kept
> their start-of-instruction values, with the instruction having
> restarted at the first block instead of resuming after the last
> completed block, as expected regarding PoP. A block crossing a page
> boundary could also be partly written before the fault.
> 
> Probe the source, destination, and IV/tweak of each block with
> access_prepare() before any data is written, then update the registers
> last, a fault leaves the block untouched and a re-invocation would
> redo this. aes_read_block() and aes_write_block() do all the copying
> for each mode. Addresses are wrapped per block.
> 
> The IV/tweak write is probed first but it is not atomic with the data
> write. It's unlikely a fault happens between the data store and
> IV/tweak, but it could happen due to a specific thread unmapping, page
> change, etc., and only matters when source and destination overlap.
> 
> Signed-off-by: Andrew Holden <andy0x48@linux.ibm.com>
> ---
>   target/s390x/tcg/cpacf_aes.c | 380 ++++++++++++++++++++++++-----------
>   1 file changed, 259 insertions(+), 121 deletions(-)

[...]

>   /*
> - * write exactly one AES block from local buffer to guest memory
> + * read exactly one AES block from a prepared access into a local buffer.
>    */
> -static void aes_write_block(CPUS390XState *env, const int mmu_idx,
> -                            const uintptr_t ra, uint64_t guest_addr,
> -                            uint8_t *buf)
> +static inline void aes_read_block(CPUS390XState *env, const uintptr_t ra,
> +                                  S390Access *acc, uint8_t *buf)
>   {
> -    write_guest_wrap_u8(env, mmu_idx, ra, guest_addr, buf, AES_BLOCK_SIZE);
> +    /* gather block */
> +    for (int i = 0; i < AES_BLOCK_SIZE; i++) {
> +        buf[i] = access_get_byte(env, acc, i, ra);
> +    }
> +}

Can we introduce something like access_memmove(), but for guest-to-host
and host-to-guest transfers in order to avoid byte-by-byte accesses?

> +
> +/*
> + * write exactly one AES block from a local buffer to a prepared access.
> + */
> +static inline void aes_write_block(CPUS390XState *env, const uintptr_t ra,
> +                                   S390Access *acc, uint8_t *buf)
> +{
> +    /* scatter block */
> +    for (int i = 0; i < AES_BLOCK_SIZE; i++) {
> +        access_set_byte(env, acc, i, buf[i], ra);
> +    }
>   }
>   
>   /*
> @@ -62,8 +80,9 @@ int cpacf_aes_ecb(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
>   {
>       enum { MAX_BLOCKS_PER_RUN = 8192 / AES_BLOCK_SIZE };
>       uint8_t in[AES_BLOCK_SIZE], out[AES_BLOCK_SIZE];
> -    uint64_t len = *src_len_reg, done = 0;
>       int i, keysize, addr_reg_size;
> +    uint64_t len = *src_len_reg;
> +    S390Access srca, dsta;
>       uint8_t key[32];
>       AES_KEY exkey;
>   
> @@ -116,23 +135,37 @@ int cpacf_aes_ecb(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
>   
>       /* process up to MAX_BLOCKS_PER_RUN aes blocks */
>       for (i = 0; i < MAX_BLOCKS_PER_RUN && len >= AES_BLOCK_SIZE; i++) {
> -        aes_read_block(env, mmu_idx, ra, *src_ptr_reg + done, in);
> +        /* probe source and destination access */
> +        aes_prepare_block(env, mmu_idx, ra, &srca, *src_ptr_reg,
> +                          MMU_DATA_LOAD);
> +        aes_prepare_block(env, mmu_idx, ra, &dsta, *dst_ptr_reg,
> +                          MMU_DATA_STORE);
> +
> +        /*
> +         * linux-user: the accessors below use host pointers. Record ra so a
> +         * fault from a racing unmap of the probed page is unwound correctly.
> +         */

I'm not sure we need this comment everywhere; the existing usages in
target/s390x/tcg/mem_helper.c don't have it, and it also repeats what
the function's documentation already says.


The rest looks reasonable, thanks!

