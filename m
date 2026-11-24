Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A7E1606A32E
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 18:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=lHKSJKz0;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=XJ9X87uJ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVvjo-00051M-0M; Tue, 24 Nov 2026 13:59:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xVvjk-0004zi-GD
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 13:59:28 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xVvji-0005cs-5k
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 13:59:27 -0500
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AOIXovs365912
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 18:59:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 dc7C27EGGemqF76M6jV5A4zj9+bEL1rBRfpFYWmQw30=; b=lHKSJKz0mz4Vyetf
 oB1v0aqzUuf4wTUknBm2Kzj5aP1LZMXNRMrmEJ4JRzz1+m7r1dJGoKQ0/3LtM2Tm
 z3y8OwVOHBY/d/EaVOIP5sEwfWoV/ghip44UqKvTJtA13m7XzvDcz/g/A/xXMh5h
 w0kKMrnwlvlyFyNw4a1nPuC/jJX3N33l0W2Dkef1I7G8qh7TxvDBX5v1NNdy9El+
 8w9sPMIbZXVzZOcNqvfWIsla+nkP37kLxYZjArvfNeiJYtlfif3JP+Mcma6LhknM
 3NJ+oUql+ENGeAM8ZgrCaNVYYKRELPVbmTs61BbYwi5G0MdYALcoDlnuHKxhOXt1
 2S8f/g==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j54rhbf89-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 18:59:24 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-94975041698so1282901185a.0
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 10:59:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795546763; x=1796151563; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=dc7C27EGGemqF76M6jV5A4zj9+bEL1rBRfpFYWmQw30=;
 b=XJ9X87uJhthAahK9nB16CkwNhoBuPR6SVycEBkkyke5d/4XuS5IY3jLoUOsSoiRmbG
 OFWxu1oFLiuT8Eyvk8i+BdZ5M7KNg7TBZLxy81REu5Y3c3ecDcZHP58ywY89p48BQ0lP
 NLFEsIpcIKhJ7FJQbVc3TBdBXXaeTsQPojBEYWSRHYH+RvyJFlr0SJQd45/oBbA0jyzb
 Dlds9+JePjrMqNqWO6sfrwMIVmq/8CzY4avMK+pkILdbLLaNbvTjIvwoLnUAPCaCNT58
 z8qEDYjrjSeaTmsVqLJLHUMKI1/PTV+JLceLF2VQPyLoZeQ9+Nr7BnT+Y4eL1esSN3BJ
 O6Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795546763; x=1796151563;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=dc7C27EGGemqF76M6jV5A4zj9+bEL1rBRfpFYWmQw30=;
 b=KPejlSX7OLhj7YOdq8P9TULRnef8aClTEAe65jWi4jAb05rMFLbiAPV8QTm3k9fBGS
 /Ic4RZAqYGcNhuAa1I9zOt0q8/4pMA+BrEd5j3S5UiEmLzP0OdL7vfVxXMipWrlR5Tev
 61snLaLJNCdatYiAFG3HwDaan+Th6bRgQSpsQzz3RFxKUBWSaXEKikDw6i5DvYD6exyS
 SIAYIsgelWUYvkmRqMVCmURIRFc+iqu4pBWgx34iohPnafJ6MjJb/AmbaFE3hvuuapDH
 QtpBMG3XH500tbPr9zMmiGkggHl66RxzvjFbThBXT5po29plne53pTqyFaD16IVq1Ntr
 Ziow==
X-Gm-Message-State: APuU4Z+n++sG3mSjhXOVrDmgwynhbVN+mzQnbbr5LPocnQMhSQvfW5cN
 3xGhABJ5CpVKLhf4dpvaoAG4PiKLi6qhB6Zs7UykD1J/yxRRyIO/YciKF88Lyb1heeC1X94OHoe
 OpVeMwkZTwO0DV4X42vL9syX7awWEN1dYaFvwr0M3t4Z7zAsrPhD8byLVsg==
X-Gm-Gg: AZFdTZfLWzOkwGQGl6S9dZSWbfoeJBp+4LRGOwecWq6U4UmZjGdX71thBhmSw8Z7uY4
 dhUw6Q+xakHE+SzE/ojU54y9VqhCvN0+Mpv+6Uj3YDz8T3qkUQcSEVrCkgcbxfVz8HFL4caIAwl
 vxvUIxuVXOWVN1U1j7MY9X7nM2rIr3hERJkbCAQYYdeVE/jataqDL9fEmsefTJjrjfaW0xWVMJL
 7LbICVTJKtZ/f6NXdhPOYXvQXwB1IYWloxHbKIT96DOt5H4uz+XOXVcKXBEx0MDmTEhKKSMvBbv
 Qnz6zD/SFAtY0zXTHaNUqTfOcKS0uI5qsJqQPfqrEcRvymArHjxIUhznBeWo3C5xzV89zxeLF13
 KMkAF19iuZBGc2Xr4oRraWZMQwYdEpWFZDkpCas31bnk946nrJFC9XPKYbV1WTzx2T29IOQBxqK
 9nFmficsJ9
X-Received: by 2002:a05:620a:4142:b0:945:d6e9:9a8c with SMTP id
 af79cd13be357-949baa0735emr2624794285a.33.1795546763232; 
 Tue, 24 Nov 2026 10:59:23 -0800 (PST)
X-Received: by 2002:a05:620a:4142:b0:945:d6e9:9a8c with SMTP id
 af79cd13be357-949baa0735emr2624790485a.33.1795546762710; 
 Tue, 24 Nov 2026 10:59:22 -0800 (PST)
Received: from [192.168.68.101] ([189.110.107.17])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-949bb0354a9sm1124450485a.5.2026.11.24.10.59.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Nov 2026 10:59:22 -0800 (PST)
Message-ID: <207522b3-b789-4b87-b2eb-cc182855daca@oss.qualcomm.com>
Date: Tue, 24 Nov 2026 15:59:19 -0300
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] target/riscv: fault shadow-stack accesses on
 non-shadow-stack data pages
To: =?UTF-8?B?6buE5Y2O5oiQ?= <1112433017@e.gzhu.edu.cn>,
 qemu-riscv <qemu-riscv@nongnu.org>
Cc: qemu-devel <qemu-devel@nongnu.org>, palmer <palmer@dabbelt.com>,
 "alistair.francis" <alistair.francis@wdc.com>,
 zhiwei_liu <zhiwei_liu@linux.alibaba.com>, liwei1518 <liwei1518@gmail.com>
References: <tencent_6A2419A93AE52BD1685CA916@qq.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <tencent_6A2419A93AE52BD1685CA916@qq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=BKkmP1QG c=1 sm=1 tr=0 ts=6b05de8c cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=2Chh/y2wedAoPG2p3qwUfw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=ID6ng7r3AAAA:8 a=GwseAj7kokeJSUor_ecA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22 a=AkheI1RvQwOzcTXhi5f4:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI0MDA3NCBTYWx0ZWRfX4Ya8LRkvVR5L
 NPAA6+/c6cfeHOmV5DjYcrWgXA9n+LDGSJ3H62SXWnzNT/rxIb/iEHVSrXZgMJe98JFjgDKUDHM
 /GfMOXzUKjc7kF2l9sUgSKKEVxvrDlc=
X-Proofpoint-GUID: TJVe_umGN9YchwYl9m0mapGbNxT8L7V1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI0MDA3NCBTYWx0ZWRfX82upsy8/70zx
 NeqON4BhTMdDoOdo6tIQWqDEAxGWWm/jtdYokJMSyUMjV5IQpTw+nPZBsccwgXKZZu0/4OcAf93
 sCZtlMGNappYnRM92nNKNrhORhFipOWHGcawzEacZb4VjrrF7lXiHirC7UDBVp7cVWYzDzuSymQ
 vkdOVGacUHrzp4k0uJCOgYnRxdrvEkv0gHdy2715/QqleAf4awdrrVHv7Ps9Is7kmVd1Exm7D+i
 fpTNvyQLgzOo8LoKQXU4+QXXVTkRYvxTE3RkqRt4oLO56jdMQTyvO98QKk15V1Q0j6pknYppc61
 gq64jrxC5BKUewxTxQk7qHVltjUPLzFEfQW+pUjqOvb1bS3aMTSP82IhJrHTGvmcemgmWjqLtMR
 usB4C3LNWe0JMDOdA7bKfpHpERhQPvXGGD/+2ucGapCGYjicBbjxb5HX80bRFEoTj1bhhrMw+RB
 NwwK0KQujHD4tBf+s1Q==
X-Proofpoint-ORIG-GUID: TJVe_umGN9YchwYl9m0mapGbNxT8L7V1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-24_05,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 clxscore=1015 bulkscore=0 adultscore=0
 phishscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611240074
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

On 11/22/2026 2:38 PM, 黄华成 wrote:
> Hello,
> The leaf rwx switch in get_physical_address() handles the W-only (shadow-stack) and R-only encodings for Zicfiss but has no cases for RW, R|X, X-only or RWX leaves when the access is a shadow-stack access (is_sstack_idx).  Those fall through to the normal permission path, so sspush/sspopchk/ssamoswap freely read and write ordinary data pages mapped V|R|W (user or supervisor), and sspopchk comparisons succeed against attacker-chosen RW or R|X memory: a ROP+1-style gadget that pivots ssp to any RW page can push forged frames and have sspopchk validate them (probe T11 exits 0x75 "full pass on RW page" on unpatched v11.1.3).
> 
> Per the Zicfiss spec, shadow-stack accesses are only permitted on shadow-stack pages (and, for unwind reads, read-only pages - already handled by the PTE_R case).  Reject the remaining non-SS leaf types when is_sstack_idx.  This also closes the MXR path: `if (mxr) prot |= PAGE_READ` must not grant a shadow-stack read of an execute-only page (probe T32: unpatched exit 0x59, patched faults).
> 
> All probes in the Zicfiss conformance battery behave spec-conformantly after this change (SS-page push/popchk semantics unchanged: T4/T5/T8 pass; pivots fault: T11/T13/T31/T32 flip 117/89 -> 15).
> 
> Fixes: 669b4867495c ("target/riscv: mmu changes for zicfiss shadow stack protection")
> Reported-by: <SENDER>
> Signed-off-by: <SENDER>

I'm afraid we can't accept this patch.  The idea of the Signed-off-by tag is to assert
that you, the human author, is legally able to contribute the code.  And "<SENDER>" doesn't
identify you.  Same thing with "Reported-by".

For more info:  https://www.qemu.org/docs/master/devel/submitting-a-patch.html

Thanks,
Daniel

> 
> ---
>   target/riscv/tcg/cpu_helper.c | 9 +++++++++
>   1 file changed, 9 insertions(+)
> 
> diff --git a/target/riscv/tcg/cpu_helper.c b/target/riscv/tcg/cpu_helper.c
> --- a/target/riscv/tcg/cpu_helper.c
> +++ b/target/riscv/tcg/cpu_helper.c
> @@ -1345,6 +1348,15 @@ static int get_physical_address(CPURISCVState *env,
>               return TRANSLATE_FAIL;
>           }
>           break;
> +    case PTE_R | PTE_W:
> +    case PTE_R | PTE_X:
> +    case PTE_X:
> +    case PTE_R | PTE_W | PTE_X:
> +        /* Zicfiss: SS instructions on non-SS non-RO pages must fault */
> +        if (is_sstack_idx) {
> +            return TRANSLATE_FAIL;
> +        }
> +        break;
>       }
> 
>       int prot = 0;
> --
> 2.43.0
> 
> Thank,
> Looking forward to your reply!


