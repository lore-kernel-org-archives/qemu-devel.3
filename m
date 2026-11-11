Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9745E606A885
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Nov 2026 10:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=a80ElUYe;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=H5gBEThv
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xR5hY-0006CD-G5; Wed, 11 Nov 2026 05:37:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xR5hW-0006Ba-Fk
 for qemu-devel@nongnu.org; Wed, 11 Nov 2026 05:37:10 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xR5hU-0005m5-2q
 for qemu-devel@nongnu.org; Wed, 11 Nov 2026 05:37:10 -0500
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AB5KKXN2350842
 for <qemu-devel@nongnu.org>; Wed, 11 Nov 2026 10:37:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 iUp5/IEs6JgM7LSa+9KuH3IQBNTZyfeqKEgEODpR6JY=; b=a80ElUYe2DLqa7l1
 JAAc/UyzFTYFlJjvPtpMqkKelkeW4IUrVB6f3YSp3th/rbnNrvpL38veOg6P6hAJ
 gNljg1uPclZMX4SDdJUMf1Yagx9PgMLEVcL9EqCzPiUP6cvunmB5nlW4XqN8HWEq
 6V+LJM9ImP264yn300bZ3lJ0fnVRNCaCPMQ/UuBg1JlvlZXIs5IrFaa8ituOXxVg
 yHZorOmul+JMKbJEck9JbVzU082p+j2CR8vM4K95iVj7bCowdSgvTsEKPuY3QIy2
 B8gUEHRcFKoWJP0cAy9avQIhr/o2ExLSRDHSJXjb8ZaqHOsn/GjYW7rbsmfaGKvU
 5rCSDw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hvdnp23rn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 11 Nov 2026 10:37:05 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93f5844e383so579643985a.1
 for <qemu-devel@nongnu.org>; Wed, 11 Nov 2026 02:37:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794393425; x=1794998225; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=iUp5/IEs6JgM7LSa+9KuH3IQBNTZyfeqKEgEODpR6JY=;
 b=H5gBEThvRtF8gnntgOgnsVCy11QCRArDfy01lGm1kb3PCyFCMf7JjZzN/3tVflX2lj
 Dp4GWDfyzA01W/tg0WfPrESjyfTaR/M76ZBWGfjOhsp6uAThFnJ5wordAZFo41uq0pUc
 HzCfLA7nAyXsE5ag0227oELD6TEh4wRjD5K0B3+ePELBoy2pPlBPPzA6Q7Pybk2nUHhs
 qM83r80w4wQ2sro0u5biTBsD8DHw62Xj8HL6Fq6WAUxhqRRbllSGc0P6WYnxAn9KMznx
 kvte3nK7x/imP/M1JZX504RD2kd6zjcLSO+xhvnrf6Bq+c1sHnd0Umz91iGEKvytbvwN
 p8dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794393425; x=1794998225;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=iUp5/IEs6JgM7LSa+9KuH3IQBNTZyfeqKEgEODpR6JY=;
 b=qbBpWQlK2r8OYtZFAaqz++G2/V5/jmwpzvV8qszEP0lSrmmIC1vJoLDkRBVknVberX
 Mr/BANlC2Xo8RUScFcq3WRYm67OiVJt5pilg482DJ5RDNBswKDcLypyB87G+9mm+8a80
 yy1FS4eDCy7PG2YlNLSlRJz1/QlyjTh73NKRNjydiovqnDdEN/lZhrstBaCS+pkei0Yf
 WU2U7+x1DevMvyQshV1dXI231FtXTTvszdvmAN+9ehLJlHZEMALIG2xrIAl9OOn0ndQz
 cJoXX19DN7fGeddJVfEhYdKP4wlj8zCkUGqZsCzFkxpbc2mEOaJbwDRUc5AavleawNJD
 TVcw==
X-Forwarded-Encrypted: i=1;
 AL+hErEUdissDNumUyzXCe1vPhRvBYPOiC6l5KvMBQ20+JTDqiluWfZmGzxM93XV/nTZChd+eCxXZQYSQYsz@nongnu.org
X-Gm-Message-State: APuU4Z+R3Wc4Q16R8OIqq4z9kTGfAtck4gUrkAWsh4auCMfPKQrnUY3y
 br5FqK93mtfC4OEvps42+YiFM7aOdJ1+sanpHrHE2buhknqySt2qF5wKUy49LxX5XCHHPhnPXDn
 ZTCZS+UWfwuaMcnjlqVdxlWgU5GxZ/VSn+JNE3GXCvyqVaDrsWMcsPz4rRw==
X-Gm-Gg: AYBFou2WLRpcWTBpOsj9/Q0eEDgAXI75YcOiAKBY6bKnRW6aUXOWCkoaWKT7EOLu/E9
 k0oCwrMFf/ym12vho82d/5WImIoLYaGjpvaRp+w1GtlKWPsUq3TrWSbWCKKe1ZlK317sLaIo3Ih
 AuJ5V5SRMy6kjRMVY2CaLe8WhDK67WBEHMbl8qs1dEunmEEH+2PGrQ4I3fdkP5eI1hh8Klb8ZTt
 TrTf6PboNBZuDhB/xJeUOXw/tpZmpDKfDs/kF18saupvMfL+0y6VPbuR5CIcLrVQrZ0PrxuuM+I
 lA+u1ag+XgcGSPZwB8eEFiNfqxg17K3ge9Fn6ngftwEVlfyit1O0fDDP76PSAhgjIcd/OLCVzwu
 +6siHdarJwnH/gIh9HnC0s2RZPYbazRijuk/ysoynUic0wqsYzr+TOwqfQI6WClvSFbRx2Qnbrh
 cG295OMFG4/A==
X-Received: by 2002:a05:620a:198c:b0:947:8f04:1c1b with SMTP id
 af79cd13be357-947afb8cb4amr316998285a.3.1794393424949; 
 Wed, 11 Nov 2026 02:37:04 -0800 (PST)
X-Received: by 2002:a05:620a:198c:b0:947:8f04:1c1b with SMTP id
 af79cd13be357-947afb8cb4amr316995485a.3.1794393424447; 
 Wed, 11 Nov 2026 02:37:04 -0800 (PST)
Received: from [192.168.68.105] ([152.234.124.231])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9479e4fa312sm453134785a.0.2026.11.11.02.37.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Nov 2026 02:37:03 -0800 (PST)
Message-ID: <9dc9aa28-9c7f-4675-a67e-0a7569e4c176@oss.qualcomm.com>
Date: Wed, 11 Nov 2026 07:37:00 -0300
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/riscv/kvm: Limit SBI DBCN transfers to 4 KiB
To: Zephyr Li <fritchleybohrer@gmail.com>, qemu-devel@nongnu.org
Cc: palmer@dabbelt.com, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 qemu-riscv@nongnu.org
References: <20261111015724.47594-1-fritchleybohrer@gmail.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261111015724.47594-1-fritchleybohrer@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDA0MiBTYWx0ZWRfX2wrMbBJBuHOf
 6OohggezYhQQOZoc1acgn6aZwV/QU3USwcKpIgI4K/V1+YUzp02o0Ski00++jXhZPCstR6Nl7Mc
 lVC++xPaUbJtl9DcFpd16cmXSqBzoESYreaahRIFfL1fr+OK7bxBFhvXGKPaPUiRBQK6QY+ExhI
 f5NHaH4VFt6wpscKEe3oWCSXMadSvWFy1CkvUC9U/1t5zCl/2n8XwASDHM/Y54B5AC7bmPvg9Gu
 UXuMnq33JZwiDzqhgzI86n5IdxrjuGRt3hyBRf6VmcxaeQPjdiHTvKf+qAZqq2443L+8ty42aPO
 fjnK7GAu6s9XWHlKC1OXfyOujJuiBZa7UesnrHnXKb3znndfjFolmBSKyQkfqzkQ+WglRNHPcjX
 adKYZDECk/kQ6lVtPgzVd7+EntepSCbURoJx5RbwHGl4ZVfI9dzenMvWbmtZ7twAPz+GK+boqA9
 LsNiUiHCsFQnZtM8jhQ==
X-Proofpoint-GUID: Zzzx4tsG_QJ5kinSbQYvY6TYNB15LFF1
X-Proofpoint-ORIG-GUID: Zzzx4tsG_QJ5kinSbQYvY6TYNB15LFF1
X-Authority-Analysis: v=2.4 cv=NK1AaE6g c=1 sm=1 tr=0 ts=6af44552 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=8elE1k/PHQNyZ14TNTodlQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=p0WdMEafAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=Zya2yLTonIcibLQ-MgIA:9
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDA0MiBTYWx0ZWRfX1zHWGK15ojD3
 X5hiyU3Zpu4dP1fmkUJcRdtVZ6tXCWy9iUCO6ULPqVpAOfuwmfW0JKbDaw7j8DyW5L8c/gOuPPm
 jN1pmJRUdYf8H1+O2J729z4UAUlPgLw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_02,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 clxscore=1015 suspectscore=0 lowpriorityscore=0
 adultscore=0 malwarescore=0 priorityscore=1501 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611110042
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
X-Spam-Status: No, score=-22.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 11/10/2026 10:57 PM, Zephyr Li wrote:
> DBCN console read and write use a guest-provided byte count directly as
> the size of a g_malloc0() allocation. An oversized request can therefore
> make QEMU allocate excessive host memory or terminate on allocation
> failure.
> 
> Cap each bulk transfer at 4 KiB before allocating the buffer or calling
> the character backend. DBCN permits partial transfers, so the existing
> return path reports the actual progress and the caller can retry the
> remainder. Zero-length requests and WRITE_BYTE are unchanged.
> 
> Choose 4 KiB as a bounded transfer size consistent with QEMU's memory
> allocation guidelines for small allocations. Linux's DBCN read and
> write helpers already limit each SBI request to the remainder of the
> current page. For guests using 4 KiB base pages, this cap accommodates
> the largest request issued by these helpers without additional
> size-based truncation, while keeping the backend length within its
> int range.
> 
> The 4 KiB cap is a QEMU implementation limit, not an SBI-defined
> request-size restriction or a dependency on the host or guest page size.
> 
> Fixes: a6b53378f537 ("target/riscv/kvm: implement SBI debug console (DBCN) calls")
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4431
> Signed-off-by: Zephyr Li <fritchleybohrer@gmail.com>
> ---

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

>   target/riscv/kvm/kvm-cpu.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
> index 5beb602338..a301b584da 100644
> --- a/target/riscv/kvm/kvm-cpu.c
> +++ b/target/riscv/kvm/kvm-cpu.c
> @@ -1699,7 +1699,11 @@ static void kvm_riscv_handle_sbi_dbcn(CPUState *cs, struct kvm_run *run)
>       switch (run->riscv_sbi.function_id) {
>       case SBI_EXT_DBCN_CONSOLE_READ:
>       case SBI_EXT_DBCN_CONSOLE_WRITE:
> -        num_bytes = run->riscv_sbi.args[0];
> +        /*
> +         * DBCN allows partial transfers. Limit each call to 4 KiB so the
> +         * guest cannot request an unbounded host allocation.
> +         */
> +        num_bytes = MIN(run->riscv_sbi.args[0], 4096);
>   
>           if (num_bytes == 0) {
>               run->riscv_sbi.ret[0] = SBI_SUCCESS;


