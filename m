Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6016CC6B0F
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 21:44:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGkIA-0005G1-Ic; Tue, 13 Oct 2026 17:44:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1xGkI7-0005Fm-WB
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 17:44:12 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1xGkI6-0004JD-A7
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 17:44:11 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69DLIxND725927; Tue, 13 Oct 2026 21:44:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=I90IMo
 A8V5kPxA/nKEJ5UN9yslPHJNcljyPIgGf8Er8=; b=TVrfXMWxUv4r6hJBZ7icC4
 Z+QXwqDr8k6mvjb1xfO9h1wXMMRBr8e1UnHdR01PWx+zlbZdlMabxZlNeQ1IN+13
 tpktOK7yYBJwqsqhMWbWwxfpGwyqfiPXzIbFqJveySCKACs0POYXBRc6qtBFvfsU
 DOWvHL+z2A8ZueFHACstVkMSqxeWDcSlI5+uXFY3BcOQOf+MlEz+VhaiC95zv23j
 q1UbcIiiORm2lj/h9lGrFjQipFc4zPODs47K8Bt10+Klw0w2MYSZt9JRpzHiis89
 MeONy1QaPrVjYQLfFpRskS/xgHEl1CA5LBH1Y2UyetHilWPXBWZJphd38ntRuUvQ
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h7dv0gn22-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 13 Oct 2026 21:44:07 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 69DLELTu1440173; Tue, 13 Oct 2026 21:44:06 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h81wg4ad0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 13 Oct 2026 21:44:06 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 69DLi5Fd42926468
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 13 Oct 2026 21:44:05 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 044F920049;
 Tue, 13 Oct 2026 21:44:05 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D198C20040;
 Tue, 13 Oct 2026 21:44:04 +0000 (GMT)
Received: from [0.0.0.0] (unknown [9.111.35.59])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 13 Oct 2026 21:44:04 +0000 (GMT)
Message-ID: <044a4043-187c-44cb-9a36-bda34a6e7b27@linux.ibm.com>
Date: Tue, 13 Oct 2026 23:44:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 01/13] tcg: add tcg_gen_goto_jc{3}_{i32,i64,tl}
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: mattst88@gmail.com
References: <20260917093307.1092084-1-richard.henderson@linaro.org>
 <20260917093307.1092084-2-richard.henderson@linaro.org>
Content-Language: en-US
From: Ilya Leoshkevich <iii@linux.ibm.com>
In-Reply-To: <20260917093307.1092084-2-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDA4NiBTYWx0ZWRfX3UknddXVVhia
 L4Ur7gYfzGf6IazuTIpasoP4o8qAUN8yLlah/trpaWHpWC/2eS32vherBEgKNbFqqNQJsn4U9qw
 wJ0uAvDZPBv2vFKCPxknKhL2ggo6+2jg9Zv1hJ+iJOE8Pm6Xg1OW3FaW2wBF6CLcPgF8KXrkUIE
 KlFSTF0yn/Z4PB01pGYgykdGkBXZV6Sx+aL9fTg3os0eCMncExRyqva/YCbYcQApG7RNJYLQWUg
 2dMPVCky3bNwo7MtvCn4U3FiUTP+qLzkfIalzqtkON3yO70+5efWafSVvIZitErp/FG3AJEG8Su
 eqnv13xHoDuIozm/Km3EJ/1bHHiulZEhQ6I5/TrIBkQT6wyX0oT9VwDUtZpf97q8fhy2auc3c+k
 pAwNuJsxXgUU6m7Q5FEnhBIAfcbG6JC/EAf3xlP8Wwz8fLxMubmlajJ2ReAWfbNA6fraTtZZCHp
 v5c/In/0/DUC9L2BSSw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDA4NiBTYWx0ZWRfXzskq7z+GLHe1
 6skSOjpAqQpyw8ZaW8GxcqCiqcXCkC+ktyaXxEARnvVyEE1B0PBcbpNb7f9jAVjiB4hasfTi7RS
 dxH/6gjegYDYbucUWoo7oWe7Xaq2+M0=
X-Proofpoint-ORIG-GUID: tWiapfD_8Ddr5o3YpA5tcCgxO9Td9_CD
X-Authority-Analysis: v=2.4 cv=a6KlZkSF c=1 sm=1 tr=0 ts=6acea627 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=p0WdMEafAAAA:8
 a=pGLkceISAAAA:8 a=KKAkSRfTAAAA:8 a=JC07bDGcoiX0JEuZR1EA:9 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: 1v__1b16F3sUUBgyz6bpQfXVBUSbuGM2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 spamscore=0 suspectscore=0 clxscore=1015
 phishscore=0 priorityscore=1501 lowpriorityscore=0 impostorscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610130086
Received-SPF: pass client-ip=148.163.158.5; envelope-from=iii@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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



On 9/17/26 11:32, Richard Henderson wrote:
> From: Matt Turner <mattst88@gmail.com>
> 
> At translation time the caller often already has the destination PC
> in a temp and knows the flags, cflags and cs_base any destination it
> may reach has to match because they are the same as the ones as the
> current block being generated.  But the promise that the flags are
> known (or unchanged) is subtle.
> 
> So add new entry points with new semantics and --enable-debug-tcg
> checks against get_tb_cpu_state() at run time.
> 
> Signed-off-by: Matt Turner <mattst88@gmail.com>
> [rth: Split out target changes; add jc3 variant; expand via tcg-op-def.h.inc]
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   accel/tcg/tcg-runtime.h      |  4 +++
>   include/tcg/tcg-op-common.h  | 29 +++++++++++++++++++
>   include/tcg/tcg-op.h         |  4 +++
>   include/tcg/tcg-op-def.h.inc |  2 ++
>   accel/tcg/cpu-exec.c         | 27 ++++++++++++++++++
>   tcg/tcg-op.c                 | 55 ++++++++++++++++++++++++++++++++----
>   6 files changed, 115 insertions(+), 6 deletions(-)

[...]

> +static void gen_goto_jc3(TCGType type, TCGTemp *pc,
> +                         TCGTemp *cs_base, unsigned flags)
> +{
> +    plugin_gen_disable_mem_helpers();
> +
> +    /*
> +     * Widen @pc to i64 because the jump cache is keyed on a vaddr;
> +     * for a 32-bit guest PC that is its zero extension.
> +     * Note that cs_base is target-specific, not a vaddr, and always 64-bit.
> +     */
> +    if (type == TCG_TYPE_I32) {
> +        TCGTemp *pc64 = tcg_temp_new_internal(TCG_TYPE_I64, TEMP_EBB);
> +        gen_extu_i32_i64(pc64, pc);
> +        pc = pc64;
> +    }
> +
> +#ifdef CONFIG_DEBUG_TCG
> +    /*
> +     * The caller has asserted that no flags-affecting cpu state changes
> +     * happened between this TB and the destination.  Check it.
> +     */
> +    gen_helper_goto_jc_check(tcg_env, temp_tcgv_i64(pc),
> +                             temp_tcgv_i64(cs_base),
> +                             tcg_constant_i32(flags));
> +#endif
> +
> +    gen_lookup_tb_ptr_and_goto();

This is subtly different from [1], found at [2] linked in the series
description: the GitLab commit has a tcg_gen_lookup_and_goto_ptr() call
here, which results in duplicate plugin_gen_disable_mem_helpers()
invocation.

I wanted to build this series and poke at it a little. The GitLab branch
in general works, but from the above I conclude that it's not
necessarily the latest version. And this series doesn't apply to
master - what is it Based-on?

[1] 
https://gitlab.com/rth7680/qemu/-/commit/9f3b27849bbc14ac61c09c79ecadb64935cc4568
[2] https://gitlab.com/rth7680/qemu/-/tree/tcg-matt

[...]

