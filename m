Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A1D5606A319
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 08:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=GREDl/x7;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=D00Yl3v/
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJS2L-0003q5-Aw; Wed, 21 Oct 2026 04:51:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xJS2K-0003po-08
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 04:51:04 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xJS2I-00022p-2k
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 04:51:03 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69L5j2IB165271
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 08:51:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 2zUFXHhFXwKfakQnMGoYSPg3HGYPLfkUxd+H0prMsY4=; b=GREDl/x7MG3eO5j2
 j0l7JOBm0Xeg8mStOhGsDURsPLYbCK3USuIs0DDaAQap7/hAiks5TF2BImReCs3S
 9t5oqh3Bw03NICTsjWltWJPRxotvglR+m5suxq+Xlu21gcziY14p4Ljm9ergzSPf
 Db/LRF58GjmL0R0CmbIrAGYIFkhv2Du9BpyTBf9vn1QCKz2yIvza3P425zFen6Ov
 DF00f3iOfKqKk/9rzmrBh7ozi7kUjnCiJiISE1IcE5qucEZmyrdwpx1IFqP6QQXU
 rBSg9fHyMgdeNQ3j8MGPpXNdGhkAb9B/03d5kTcTMb4g8PmbJqJVLO4NpuWlXVNL
 1YK5vA==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hegs0291g-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 08:51:00 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-91b937ecbb4so10623106d6.2
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 01:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792572660; x=1793177460; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=2zUFXHhFXwKfakQnMGoYSPg3HGYPLfkUxd+H0prMsY4=;
 b=D00Yl3v/9WwP+uc9meykwYOH6P/6aJZt2aiSv3FpiTYDqi8lBhm5kvyClDX/O7vHN5
 Gwdl+Qd1m3pi/A7xWTgpfUGtbHZlTdKnH+qABHhtKYKVw2kpYolNvcBgknf5kyLumfcb
 MUoKfrEsk7b59iasrsEu2o3ytkBo0BaqD0qDIP/GBUcXef8OGwjZOMzUwcsgbYMXc/rb
 GdR4bata4jNIEpniVa1KK/BFmfiPWRXA/PuDOGDx6IKvxOyVZjHA31URNJEIyE9C8VDp
 NFpWZdO9vWJq1jlTPsVRdZihjQA8fjlWu8k8tZAESlg6Pda0kADQYPwSmf/LHLTo09uw
 UQwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792572660; x=1793177460;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2zUFXHhFXwKfakQnMGoYSPg3HGYPLfkUxd+H0prMsY4=;
 b=N75dnQz2kKajyQp8d298FyspQ9oAH/aq1d6Bj7lrS8YEH5MQt6Wixaptbatm/1nsN7
 8HPaKmH5idg6c5asaWbN0P50lJbRb9O/ttqiPaYuAw3Amim1UKZYjs1Oz61ptcmFHwOp
 JObUDfszk+XYb7E/jgOE/QD/LpCi/4ktVMCt/ramtMkNqj5LvIYKsKzYqOaIGRRXewKF
 ckg2a4UcRbTqMHXDGblUdymv9h/FpXi3ZrQTDkPHa3m053LaFO61OH+/tz89nBeKJ4UK
 ot36LIEgzrtTSpd3zGa/ISSMlckd1Th6hQ3CYu6mm9C2cvaULWcvmHZ//9YUCYiIyNo4
 Xq+g==
X-Forwarded-Encrypted: i=1;
 AKwUvBws1nOsoThQtzhsk13FReFe6qN7nwNtaiDo5anbnLGu2sbj2Q1hsu8wrWC1mPltdB54+eNFn2fLIwgE@nongnu.org
X-Gm-Message-State: AFq9FYLuZjPy1Xs0o4403VC5nHntv4/W+6PBhOh/np+4FyR400QnDaJT
 KINePdVtDQQU35U7bYC7z0bZ7Of1ub9zKCSwFeraddo44WlRXOTPjozo1+4W9+NIXB+ykjVHGV0
 Z7+ryGawhfimiaWzdM/e/afxENf8EFFn6nmK3+7kp3EXFTAaKPxp7fXVCNQ==
X-Gm-Gg: AYBFou2jJgDyovxAojvCO0DAFXAfOYyHxZPd3Uykb4EFQlMDl6BmFjfVH05sef9TSfX
 UDeI0xwWbzP06EXTmjiEoJeYSfn6oKIyqFhjZt86qUeeZYeJpIe5gzi+a3TdiI57kc23ZNP8mnX
 yVPHu1PQ3ZxHq9dHNte0EBh79VNPESlyajsaNhZEE79ueRO/mqhBgAnapuq+5tG1g9TI1HORv5J
 m4iQ8/5K7ueN6LDUiUSoSz7jtTiiTGnr5yhh2CdTE0Fr72X74xWcM3PwKN1R71gmh6EDYYpR8qW
 Q4/ffRkGcKBnAjdBkv+0QobseY06MnFHbiNODnfDa9ftucPGRBePjX5cjxvg9v37cZcH1zvi/8B
 py0F1w1SFBsqHT5jw7q1uUo86ch2RwE5kxg==
X-Received: by 2002:a05:620a:6087:b0:93f:353c:6bee with SMTP id
 af79cd13be357-93f57f9550cmr310901185a.41.1792572659526; 
 Wed, 21 Oct 2026 01:50:59 -0700 (PDT)
X-Received: by 2002:a05:620a:6087:b0:93f:353c:6bee with SMTP id
 af79cd13be357-93f57f9550cmr310898885a.41.1792572659003; 
 Wed, 21 Oct 2026 01:50:59 -0700 (PDT)
Received: from [192.168.69.210] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e254ef1casm3247660f8f.7.2026.10.21.01.50.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Oct 2026 01:50:58 -0700 (PDT)
Message-ID: <6080974b-f174-4e95-8846-26ed13202dcd@oss.qualcomm.com>
Date: Wed, 21 Oct 2026 10:50:57 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/3] target/i386/tcg: fix EIP truncation for wrapping
 near branches
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: paul@galbraiths.ca, pbonzini@redhat.com, qemu-stable@nongnu.org
References: <20260926235620.851099-1-richard.henderson@linaro.org>
 <20260926235620.851099-3-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260926235620.851099-3-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=S/NMU4sP c=1 sm=1 tr=0 ts=6ad87cf4 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=69wJf7TsAAAA:8 a=raqJFIpfAAAA:8 a=KKAkSRfTAAAA:8 a=hDIRARDuNmwtUEMYCP4A:9
 a=QEXdDO2ut3YA:10 a=iYH6xdkBrDN1Jqds4HTS:22 a=Fg1AiH1G6rFz08G2ETeA:22
 a=_hj11Ae09VJzK9KqwGmL:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDAzNSBTYWx0ZWRfX7A6+mz821etd
 f4gOpiTzVm3S6CEGks4CGtdtOxYfRWa48nM99QtUzK7Dd/gtirsAdD5mJaMgdSb5xk8/SdqNpBA
 ZFQ7jFyGuZg7KIKWRw6fv5h9r8Kevu7/Dn72ZZz2lHXYGplA/d6VM3J/xmGpVCedmSb0TAl3t/t
 fg9kmHYs6PVluOCdDWlKdMkIrFPFEOkPrJR5YBx5yVX9S+hxk2miG/YdndOGXmo2qImXqETd5Sa
 NWoVaQOkZwzY0MjZV0SYGqFwXPvuGsf1xa8T2rDrkXWvqbue9+BXSxdL43RvrpPFOO5DX0dvPuE
 zKyieS+3y4dB3GTjizofsuK1/zXDibgK2CJLdCsBuZhGfLQFbIkK3PDa4smLYbeB401lVnEAmfN
 NLVL5cVb6UHSzhyWxu/rlsvU2MceUxgYT/58wUP0nYmT7CaAHPtLscH5nbhgf0bl4k37JwsBXOy
 mdWGVZq7WRLTn6+5A8w==
X-Proofpoint-ORIG-GUID: xwPeMufmF9WTT0CfifmT5jLzP8XXClg0
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDAzNSBTYWx0ZWRfX1Cv9EhXG8NFM
 gItZb4jk/ZP3SMl2saJY7kTvr4DvdOfl4IuTYgqVaweYMUHhL6T3XGEwofhTmAsvA1oWUY1/fxj
 dGcKmkYZNdrkTrrteuhMPEpH0/eCXys=
X-Proofpoint-GUID: xwPeMufmF9WTT0CfifmT5jLzP8XXClg0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-21_02,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 priorityscore=1501 spamscore=0 bulkscore=0
 lowpriorityscore=0 malwarescore=0 phishscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610210035
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Richard,

On 27/9/26 01:56, Richard Henderson wrote:
> A 16-bit near branch that wraps through 0xFFFF must truncate EIP.
> TCG skipped this when the target was on the same page, which can
> happen when the CS base is not page aligned.
> 
> There was an existing test for this further up that attempted to
> test this, but was restricted to a 16-bit branch in 32-bit mode,
> which can be subsumed.
> 
> The previous test for pc being on the same page, rather than eip, is
> only relevant to using goto_tb not to eip wrapping.  There is another
> test for pc on the same page further down, via translator_use_goto_tb.
> 
> Cc: qemu-stable@nongnu.org
> Fixes: e3a79e0e878 ("target/i386: Enable TARGET_TB_PCREL")
> Reported-by: Paul Galbraith <paul@galbraiths.ca>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/i386/tcg/translate.c | 24 +++++++++++++-----------
>   1 file changed, 13 insertions(+), 11 deletions(-)
> 
> diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
> index a38cc2c15d0..18706ec8a74 100644
> --- a/target/i386/tcg/translate.c
> +++ b/target/i386/tcg/translate.c
> @@ -2015,9 +2015,6 @@ static void gen_jmp_rel(DisasContext *s, MemOp ot, int diff, int tb_num)
>       if (!CODE64(s)) {
>           if (ot == MO_16) {
>               mask = 0xffff;
> -            if (tb_cflags(s->base.tb) & CF_PCREL && CODE32(s)) {
> -                use_goto_tb = false;
> -            }
>           } else {
>               mask = 0xffffffff;
>           }
> @@ -2025,15 +2022,20 @@ static void gen_jmp_rel(DisasContext *s, MemOp ot, int diff, int tb_num)
>       new_eip &= mask;
>   
>       if (tb_cflags(s->base.tb) & CF_PCREL) {
> +        assert(s->pc_save_valid);
>           tcg_gen_addi_tl(cpu_eip, cpu_eip, new_pc - s->pc_save);
> -        /*
> -         * If we can prove the branch does not leave the page and we have
> -         * no extra masking to apply (data16 branch in code32, see above),
> -         * then we have also proven that the addition does not wrap.
> -         */
> -        if (!use_goto_tb || !translator_is_same_page(&s->base, new_pc)) {
> -            tcg_gen_andi_tl(cpu_eip, cpu_eip, mask);
> -            use_goto_tb = false;
> +
> +        if (mask != -1) {
> +            /*
> +             * If eip "page" doesn't change, then the addition cannot
> +             * leave [0, mask] on any rerun of this TB, which only
> +             * ever shifts EIP by whole pages.
> +             */
> +            target_ulong old_eip = s->pc_save - s->cs_base;
> +            if ((old_eip ^ new_eip) & TARGET_PAGE_MASK) {

Is it OK to skip the previous ot == MO_16 and CODE32() checks?
The next patch only tests 16-bit, not 32-bit protected. Can we
complement with a 32-bit test? Since this is a qemu-stable@ fix,
can you better explain the "subsuming" and why we don't need this
safer check:

                if ((CODE32(s) && ot == MO_16)
                    || ((old_eip ^ new_eip) & TARGET_PAGE_MASK)) {

?

> +                tcg_gen_andi_tl(cpu_eip, cpu_eip, mask);
> +                use_goto_tb = false;
> +            }
>           }
>       } else if (!CODE64(s)) {
>           new_pc = (uint32_t)(new_eip + s->cs_base);


