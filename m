Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 329E5C5B572
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Aug 2026 09:10:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvWrw-0005As-NA; Sun, 16 Aug 2026 05:09:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wvWru-0005Aa-Sj
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 05:09:26 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wvWrt-0000iV-9y
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 05:09:26 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67G72g8W2630878
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 09:09:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 lENoUCbKTcsn0o0Qiy2E7a4zjxvHNECXyajxvrquTLQ=; b=M4QtkWCu4wf6gOdJ
 MLjfs1jdJ9OdaamDKG8rWRFUVR7pybngVk9zPBwL6Y1L3+pLl2lFsrVtFtkAvhDI
 eNOuRMvthBWFXhpMMzWoeCTgLH541UJWCNu0wLDn+q7UIsOQkaatkuCZ5rlLoU5H
 OfZKQ8QhrNtVN5fXFuQgO3OEnz38+V4/X5TdZ8vvtiEmijhSvLbnlFyz3rUm4Rfj
 4/GfSzzzYF/TL8y9NpM5Z8v4QX+WKt/ea/Nso7OrHL6VyopDnElHT4wVnYbyXW8Z
 gYlJytbeTv9ePNUvISLrDYY47RjJ3+CxemarQ8r3mLhhURuGKyPf0Q0tebKCOy1V
 oaJkhQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g2ghk353v-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 09:09:23 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-52769fc3f2eso30624911cf.0
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 02:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786871363; x=1787476163; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=lENoUCbKTcsn0o0Qiy2E7a4zjxvHNECXyajxvrquTLQ=;
 b=QCK0G2o6uKFlCs3L9T2mK8HZB+bql4TJH+HG1+YqJrt97sCntZX0Lv8jdlvEO6+Eek
 RLDNcMHVgRZgudl9TuCx9PjVKyyblmAv0TubYRYCE6mubAI/BGLfrdJ8ELHxGpctjUGL
 B85uxgAIGAzBEBNejQjWt+N4GQ9d3h03nZym5y44FKzOru1vfjjS0WKQ1z2YHIZZ+ImH
 uzv9lK6eD5Q2ip64ZBb20ONFjMrbE5frJVNBWZPTa5qppykmRrfk/JgMbeuaTY3M/uv6
 1Bv6YXmxpTs6DtFY0aRBDwSIX/KMzcr7qj0Uu3aDSngVMI3XK2Tq5JIjS72/F+7kq1A1
 MD6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786871363; x=1787476163;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=lENoUCbKTcsn0o0Qiy2E7a4zjxvHNECXyajxvrquTLQ=;
 b=onnnphk9DJo+az0s0L+5qb2MH6ce+s1YL9ssN1h7e5kFTeaIQoTUXtcbdiKzIMOqVK
 YtOET9UOuFL5tGoQMjxrJdzT+mZi65oaGWPqgEtw1PThqZgruxZnT+onDF/vLPXL2fBQ
 RGCGMePvMAR+vslDi6LfuPTzgoFkyWstmr6O0SePRpPYYCdKwpC0t806b1TVhB6Y+ay5
 NsOigdgHCc7k1PfDm3PlIcATWC3FsMq/UO7xlaQJk1NA2sSNmBxjjBkgS7Idp3o8G5LK
 ev/Rm0UY+gyFgGsUo4jPMe58Xib+APxZO7wF4Mltc22jtf/8M16j/5rExNGzanfemB/W
 unGg==
X-Forwarded-Encrypted: i=1;
 AHgh+RrLFP0JXS1RpC1akyS2MJIVWQJdklOkaWKfdHCxxuzGBY42smh7RjFSoIr1IYmc8sOLtL0lsMY9NoOB@nongnu.org
X-Gm-Message-State: AOJu0YzmHdPco8Ec+yjH/pD5UussDtlmH6gyQAawkogQI4HRlPUzvItO
 f05I/Ct3UW0ByHt2BT8eWKzxNuXLZ0uHjRPS0Z6H8b5ZVOfxUFtoT/oZ7UOZ4xXQaY51KdBqhoy
 N+/960IqnsjL5mHLhVmPhzAgOR9qf5+UL/+VR0F+zmDN6EKO3vv6j+5rJ3A==
X-Gm-Gg: AR+sD10JLKKK6b7KN6e3pssBcS7dWISDwWxGLVHaJniZAM1EGC5WPVZIK83DLvbQsGG
 RcaVc+33nQfKv1s/IaBNIqAJYa8iPtFD40vbpJWckNGrCL1xRQpYwdtcBN6EB13XD6ltGylfBou
 k5rWfhQBk8m/xQebPMUCbgIvmHxaJZpF/95g7iKOsuz9s90y57Mr3YyKRWnXmKBXeFKW7Ye6Jl+
 rDKYptRF+Gx0RecEJqguoQpQLbHbqs4gWkgcTAui2dC5kuDNEiio5KvJVc8+GYUdR/Nu8aeZrTP
 Djk13cmANaV2qGiui3JQZztKGXnuq+t6zbgFvC7PTwjBtR3ZLdH+yq1T2JcWSwcPo6yjdXuONzf
 Atfif2CBCF44ajIulcdN2r51azcoZayd597o=
X-Received: by 2002:ac8:5cd1:0:b0:517:87bc:9b47 with SMTP id
 d75a77b69052e-52d854d682fmr198488581cf.39.1786871363363; 
 Sun, 16 Aug 2026 02:09:23 -0700 (PDT)
X-Received: by 2002:ac8:5cd1:0:b0:517:87bc:9b47 with SMTP id
 d75a77b69052e-52d854d682fmr198488291cf.39.1786871362991; 
 Sun, 16 Aug 2026 02:09:22 -0700 (PDT)
Received: from [192.168.69.229] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4815f20051esm24659460f8f.7.2026.08.16.02.09.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 16 Aug 2026 02:09:22 -0700 (PDT)
Message-ID: <2875df0a-d000-46fa-a8e9-22aadf102a7b@oss.qualcomm.com>
Date: Sun, 16 Aug 2026 11:09:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 07/18] accel/tcg: Replace size with first/last in
 probe_access_full
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-riscv@nongnu.org
References: <20260815203730.1468365-1-richard.henderson@linaro.org>
 <20260815203730.1468365-8-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260815203730.1468365-8-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE2MDA2NyBTYWx0ZWRfX4cIAD82IctEe
 fKIF37Wk/EuQ8wYXkQchT+8diN6Bag87Fe+iMWAU2nx0JyvD3lIAEx8JPBnWALFECGx832SwcWI
 bBzgO7YP31zD8upIlU2Fpqpz8ak+08w=
X-Proofpoint-GUID: VCUlEthu-863wMUojbdaxkglqQoBAaLI
X-Authority-Analysis: v=2.4 cv=f+14wuyM c=1 sm=1 tr=0 ts=6a817e43 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=JkiptoVkqo8WkY8BhawA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE2MDA2NyBTYWx0ZWRfX8+o4FOWH0/ni
 b0I5LOMp93gmXoAphG20xBYPbt3FtGJ4u+hcxsbOmCcuXNyNE/EFMcHGzmRgT68+UifATBYgWTV
 lfzgWsgN3hrBLHYLiBKV/4egr/htrJW4Xhsg1yAjhmJ3hbmsoIfo2vQpc/OXusBWI78TpQVyq5e
 hOL+dlwTqm2jFKapTsS2rwJ1K+rcXj25PKNYjZqVLo5uXCkSGEqNyFny1t6tZkk4OduPDJIizgw
 KMyiATKL3kfU4U5F+07S8MfKEkXSj0nDz2/QQvj/+pOMupMCWda3Os1QTpIIEDmheMMuwRcR0FZ
 jtlg0WGYYxiB4beoKs3pKgcXHKTtr/J6DQ3V/xVShFD4vg0JXNwut6fhbTV+kCDiIdlIxKmCKxG
 wXD2nzVKDzTR7qHVE8lu0hcPeppkhm4T6gADUCPK3bAFkissDsi3qtBp+zugQf6oxJh4Qpcmeq1
 2H4EJ17mrkPcPIoK0aw==
X-Proofpoint-ORIG-GUID: VCUlEthu-863wMUojbdaxkglqQoBAaLI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-16_02,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 suspectscore=0 bulkscore=0 phishscore=0
 malwarescore=0 impostorscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608160067
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 15/8/26 22:37, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/accel/tcg/probe.h     |  2 +-
>   accel/tcg/cputlb.c            | 17 +++++++++++------
>   target/arm/tcg/helper-a64.c   |  5 ++++-
>   target/arm/tcg/mte_helper.c   | 21 ++++++++++++---------
>   target/arm/tcg/sve_helper.c   |  5 ++++-
>   target/mips/tcg/ldst_helper.c |  4 ++--
>   6 files changed, 34 insertions(+), 20 deletions(-)
> 
> diff --git a/include/accel/tcg/probe.h b/include/accel/tcg/probe.h
> index 0b788901ba..e3068a79de 100644
> --- a/include/accel/tcg/probe.h
> +++ b/include/accel/tcg/probe.h
> @@ -86,7 +86,7 @@ int probe_access_flags(CPUArchState *env, vaddr addr, int size,
>    * This function will return TLB_MMIO in order to force the access
>    * to be handled out-of-line if plugins wish to instrument the access.
>    */
> -int probe_access_full(CPUArchState *env, vaddr addr, int size,
> +int probe_access_full(CPUArchState *env, vaddr addr, vaddr first, vaddr last,

I prefer this clearer first/last range API, it feels safer.

Missing updating the docstring, otherwise:
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

>                         MMUAccessType access_type, int mmu_idx,
>                         bool nonfault, void **phost,
>                         CPUTLBEntryFull **pfull, uintptr_t retaddr);

