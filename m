Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48159606A320
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 10:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=r5vDD/C+
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJpjK-0004hm-JK; Thu, 22 Oct 2026 06:09:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1xJpjJ-0004hI-3y; Thu, 22 Oct 2026 06:09:01 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1xJpjH-0004wr-0n; Thu, 22 Oct 2026 06:09:00 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69M7EBSa1763348; Thu, 22 Oct 2026 10:08:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=GVjcBd
 3GzEHdfgfy7micNVJGtKbBC5kqXvhbGfo1cLA=; b=r5vDD/C+ltoEqs0Yo5BT8g
 fNjFLe9vAF8o6feRpa98TnCzlYq1Bg0OQgHFs2v4Klur2JKEtDGQiMm8wc4Nl/6z
 3Tl4NF/vZN5sIpfMRr7xsFO94vL8M1d3Fvtkwplc88wDANYp/5NnRfO4u4x8vR8N
 Cs9s9D9zASacnzbqQq4bvwXROxLsmedwvVnaJLqR0SgNM3JfzbLAZXyeVsorA0hT
 ikah7T81Xlr8drUMv3ZNikiPcphWC/dRfNVLOd+atHRDw/Is1prcb5CcMlQj9VVg
 Fe5eKb9QdAuSZzqz2ivLWHTdlohunXG6gL7aNSBWso0Tjdo5mSmgjQ9HCE8qJjSA
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hdw5bpdte-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 22 Oct 2026 10:08:54 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 69MA4rek285455; Thu, 22 Oct 2026 10:08:54 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4he7bs9gfr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 22 Oct 2026 10:08:54 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com
 [10.241.53.102])
 by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 69MA8qL432047748
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 22 Oct 2026 10:08:52 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5EC4758061;
 Thu, 22 Oct 2026 10:08:52 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AC1AD58063;
 Thu, 22 Oct 2026 10:08:49 +0000 (GMT)
Received: from [9.123.8.229] (unknown [9.123.8.229])
 by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 22 Oct 2026 10:08:49 +0000 (GMT)
Message-ID: <25b1325c-b9e2-4ffb-aac6-0a42e8932c83@linux.ibm.com>
Date: Thu, 22 Oct 2026 15:38:47 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/17] target/ppc: Ignore FPSCR W/L fields on e500mc,
 e5500 and e6500
To: Bin Meng <bin.meng@processmission.com>, QEMU <qemu-devel@nongnu.org>
Cc: Bernhard Beschow <shentey@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Glenn Miles <milesg@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
References: <20261006094921.110871-1-bin.meng@processmission.com>
 <20261006094921.110871-15-bin.meng@processmission.com>
Content-Language: en-US
From: Chinmay Rath <rathc@linux.ibm.com>
In-Reply-To: <20261006094921.110871-15-bin.meng@processmission.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: 1yv2cJEh3Q19EVVXjGX4uDlVEKu7NR3O
X-Proofpoint-ORIG-GUID: VeqjMftCyVr8mZ4QIZJp1Nh_6MWHFTXO
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDAzOCBTYWx0ZWRfXzSoJnat2g7f1
 9bBk1lf9NIzcYMZqWBlNEqA0tW6B5hDihOhMgE3Bxoct3FsAfS00IAj8+IQHgWFfdS8Xq3ua1mX
 PC4zszVkLydFevNMXlmqgQOvZ0tuAB0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDAzOCBTYWx0ZWRfX1P1mwoyzTAYz
 fe/N9OFCcnzZaj2WIXcEWQu5Qn65Lvg5fS6xam/08KslEmDpZQGQv26nKpkQMaNcH0H+byu5YUa
 3Qj8Cfli2p5SMm+nRa6Hb8WnGHkkmnp2IK8bvttobKS+5BWt4Xb453sDAS2u3yV17KTGgpzPHb7
 KEJGGTgMkuNteebwJxx0KiwQDtr5FaAhOlvMmFbmT8oR7wA7mQJ7XItMG3xjNv4PnWN/8H4kei+
 bsTf9MpcXv8q03Ib5qMnWDlxMtV1OMRJVmqjxWEoy2zi59RuHj3lesyXuXFDd7siS/HQ1hO+GJC
 yQjPNaipRzd21J42JsLAZY0s5cw7Gf+ZFdxE8WrGPQNoh+EujA8NHjMP+e9vzpr/KYepX5ZxagF
 ccB/AHqZgyMJUxSIlMAOVzeLQvgfGnUEZFPYPC5f5vyX5iAbuBsRn3RorO6fi4LHeRpjyptqL3b
 d8ebrZFaG4hfiTr25nQ==
X-Authority-Analysis: v=2.4 cv=Gb2CDgXL c=1 sm=1 tr=0 ts=6ad9e0b7 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=8AirrxEcAAAA:8
 a=FRSEYCzRAAAA:8 a=nTk3fblqnZa3Fprd_iwA:9 a=QEXdDO2ut3YA:10
 a=ST-jHhOKWsTCqRlWije3:22 a=H4N_Y-AU75W7NKDNhZlT:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 malwarescore=0 spamscore=0 phishscore=0
 clxscore=1015 bulkscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610220038
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


On 10/6/26 15:19, Bin Meng wrote:
> Table 3-1 of the e500mc, e5500 and e6500 reference manuals specifies
> that mtfsfi ignores W and mtfsf ignores W and L, behaving as if these
> fields were zero. The existing translation rejects W=1 without
> extended FPSCR support and honors L=1, which does not match these
> cores.
>
> Add a processor behavior flag to ignore these fields without
> advertising extended FPSCR support. Keep the ordinary field mask
> and rounding-mode updates effective.
>
> Reference:
> - E500MCRM (Rev.3), section 3.1.1
>    https://www.nxp.com/docs/en/reference-manual/E500MCRM.pdf
> - E5500RM (Rev.4), section 3.1.1
>    https://www.nxp.com/webapp/Download?colCode=E5500RM
> - E6500RM (Rev.0), section 3.1.1
>    https://www.nxp.com/docs/en/reference-manual/E6500RM.pdf
>
> Signed-off-by: Bin Meng <bin.meng@processmission.com>
> ---
>
>   target/ppc/cpu.h                   | 2 ++
>   target/ppc/cpu_init.c              | 9 ++++++---
>   target/ppc/translate/fp-impl.c.inc | 6 ++++++
>   3 files changed, 14 insertions(+), 3 deletions(-)
>
> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> index 78fa4653fb..edcb2ac5c7 100644
> --- a/target/ppc/cpu.h
> +++ b/target/ppc/cpu.h
> @@ -844,6 +844,8 @@ enum {
>       POWERPC_FLAG_BHRB      = 0x01000000,
>       /* Use PPE42-specific behavior                                           */
>       POWERPC_FLAG_PPE42     = 0x02000000,
> +    /* Treat FPSCR instruction W and L fields as zero */
^ nit : '*/' to be aligned.

Regards,
Chinmay
> +    POWERPC_FLAG_FPSCR_IGNORE_WL = 0x04000000,
>   };
>   
>   /*
> diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
> index 1c02354e11..f38a67208d 100644
> --- a/target/ppc/cpu_init.c
> +++ b/target/ppc/cpu_init.c
> @@ -3188,7 +3188,8 @@ POWERPC_FAMILY(e500mc)(ObjectClass *oc, const void *data)
>       /* FIXME: figure out the correct flag for e500mc */
>       pcc->bfd_mach = bfd_mach_ppc_e500;
>       pcc->flags = POWERPC_FLAG_CE | POWERPC_FLAG_DE |
> -                 POWERPC_FLAG_PMM | POWERPC_FLAG_BUS_CLK;
> +                 POWERPC_FLAG_PMM | POWERPC_FLAG_BUS_CLK |
> +                 POWERPC_FLAG_FPSCR_IGNORE_WL;
>   }
>   
>   #ifdef TARGET_PPC64
> @@ -3238,7 +3239,8 @@ POWERPC_FAMILY(e5500)(ObjectClass *oc, const void *data)
>       /* FIXME: figure out the correct flag for e5500 */
>       pcc->bfd_mach = bfd_mach_ppc_e500;
>       pcc->flags = POWERPC_FLAG_CE | POWERPC_FLAG_DE |
> -                 POWERPC_FLAG_PMM | POWERPC_FLAG_BUS_CLK;
> +                 POWERPC_FLAG_PMM | POWERPC_FLAG_BUS_CLK |
> +                 POWERPC_FLAG_FPSCR_IGNORE_WL;
>   }
>   
>   static void init_proc_e6500(CPUPPCState *env)
> @@ -3288,7 +3290,8 @@ POWERPC_FAMILY(e6500)(ObjectClass *oc, const void *data)
>       pcc->bus_model = PPC_FLAGS_INPUT_BookE;
>       pcc->bfd_mach = bfd_mach_ppc_e500;
>       pcc->flags = POWERPC_FLAG_CE | POWERPC_FLAG_DE |
> -                 POWERPC_FLAG_PMM | POWERPC_FLAG_BUS_CLK | POWERPC_FLAG_VRE;
> +                 POWERPC_FLAG_PMM | POWERPC_FLAG_BUS_CLK | POWERPC_FLAG_VRE |
> +                 POWERPC_FLAG_FPSCR_IGNORE_WL;
>   }
>   
>   #endif
> diff --git a/target/ppc/translate/fp-impl.c.inc b/target/ppc/translate/fp-impl.c.inc
> index fef770368a..9937b2db50 100644
> --- a/target/ppc/translate/fp-impl.c.inc
> +++ b/target/ppc/translate/fp-impl.c.inc
> @@ -592,6 +592,9 @@ static void gen_mtfsf(DisasContext *ctx)
>       flm = FPFLM(ctx->opcode);
>       l = FPL(ctx->opcode);
>       w = FPW(ctx->opcode);
> +    if (ctx->flags & POWERPC_FLAG_FPSCR_IGNORE_WL) {
> +        l = w = 0;
> +    }
>       if (unlikely(w & !(ctx->insns_flags2 & PPC2_FPSCR_EXT_ISA205))) {
>           gen_inval_exception(ctx, POWERPC_EXCP_INVAL_INVAL);
>           return;
> @@ -627,6 +630,9 @@ static void gen_mtfsfi(DisasContext *ctx)
>       }
>       w = FPW(ctx->opcode);
>       bf = FPBF(ctx->opcode);
> +    if (ctx->flags & POWERPC_FLAG_FPSCR_IGNORE_WL) {
> +        w = 0;
> +    }
>       if (unlikely(w & !(ctx->insns_flags2 & PPC2_FPSCR_EXT_ISA205))) {
>           gen_inval_exception(ctx, POWERPC_EXCP_INVAL_INVAL);
>           return;

