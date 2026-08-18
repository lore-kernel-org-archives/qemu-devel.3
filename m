Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B119DC5DF70
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 06:08:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwCzT-0003mk-1t; Tue, 18 Aug 2026 02:08:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wwCzR-0003lv-5N
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 02:08:01 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wwCzP-0000Hn-6Y
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 02:08:00 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67I2YPBZ3761859
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 06:07:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 9wZgPQQqFHe1na84N0FjuTf7YZJnrXcwACl12YY+uyI=; b=MY5eSVYScL3jAS07
 nHU3tozFnjqrFN8UWve7IkOTRcgP5wW8ciKh42NolfLGj+Z3hV4vwOM2HwwJVE1h
 +WgRXho2La0Rkb9O9KctZiC8ZAfaXSL8rCbBiC56Owk1WB+AOMIxozRBflSEwr45
 NRN4Z+kE5HEba08TQb1oSUz9fZ3tawwJkDrLFGUgwdb7f8ihgBZx3lL6OnVe2nX7
 5QhRXLLcQYlVzb9WQMebN9c/LGna9mlTBbqgpeAopkJLKfFzxZAGWTvHHEvjbbpm
 OWSF2FtjtL2c0G+aQ0V0t+7qnjujz81Q9uEn8MCZhDgVx+RqJfFLttu9lOB+J+DL
 5PaeZg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4eqtrt45-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 06:07:57 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-52d28f8737eso76727491cf.2
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2026 23:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787033277; x=1787638077; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=9wZgPQQqFHe1na84N0FjuTf7YZJnrXcwACl12YY+uyI=;
 b=kZnTbD0zZ8HIuNyCvroQ4QB9zHtRBtnhI9BfthGbyn00dsKFCDVKBoD1q22/KXZFuo
 bPXKmVl1IKsnA20vjjcFdpR57lU606vjOdRggSY8NABAn1ZBPDLYPIGQYB9t1FWd0Qeu
 5nBhx06jPNRsvNIkDh3MshILPFTBC+wp1I2p80hPIUcKhzcG9hoWkwzLaxWQjp9el/ls
 6/snwUXOutDcJ4b5x9OsKYMJFP+JuLH40WE2JYjtqBfhAb1RUBJpduerWPJQcPT3vu5t
 /Us9nGHvLg6Tu7b+Lt2MS+RZHQ9RkRWQ7mL24oC/2xLhIhiU5j0xupyF4lOoJ+jEF+qr
 j5Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787033277; x=1787638077;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9wZgPQQqFHe1na84N0FjuTf7YZJnrXcwACl12YY+uyI=;
 b=nsESi3VxFuALYwWwRHEGdT9AxBYrBYQ8oXdqLuWPD52flxoxvslzqpq6kzbwv/YvDj
 jY5xGNhHFKMi6yH/MbKTxyxdJdWKv9Ck1DvSsvljbnrjb/4kJdeuFKqw3pk7tq4Y4PqU
 NrxTY/y712pYvxFf65N8a0OuPxhccahMC6zLf2kMOnxYaeKerlsaiDPrvWPZ1A6CBr7r
 YCJUiC0sq5fbhKlEjDd0U/VZ5j3qWDzcKk8iU3ry9Od4GlxA9NILKwWiOvLxMHS0VZrn
 IwD8y4PHxotScMwLSoWB7meVLFlZdAJsN/KtnHJXkq2g2EoEPwZ0ugEMRexNRfzm0tVO
 Xojw==
X-Forwarded-Encrypted: i=1;
 AHgh+RoUke7f5rsNbLljpgdgOH15fDpcgQN2H9QLdSpgc/viI0mLclyHRY1TNTC6fGfd0TF4y8higRQ0+zmq@nongnu.org
X-Gm-Message-State: AOJu0YxGUith0wy8hYNZqkHpfJPqRPLQlo3dTKRKKL4eH+hInUvX1AQe
 GXXSNG3OuXcz31kx+CL+0FAEd+eW8dcKbqW8lmQMPqJ3Cfzys/sIKrlChL4Un+Pbd/LYf09E5Eu
 o62mQ0J6W8Nu9X/YRZVghdARKKXxbOx/fKCGXhoUPFyVDuz0JwsZzyd30lQ==
X-Gm-Gg: AR+sD11ZNDC5WqE9yx3ZhChQuRk+el7fcJ3x9zLlg2PVviae33jW51VOPr2JuLYeAnP
 EC7CbSzzssJmS9dGPF8iNwTi2BCvbJaPfqYLYlh5OJJto5RPtj+JlaTd0O4mkeLSvjSGDSu6Khj
 0FEY16PXZ3Q6pr2QDxhv2ezxSp4WT7ndlqSVqm3qpOLI7S5v/w/5OV054oQmmPmPpRF/1/vkWRS
 sXZVG0ckLLRO+QJrIf5S4d+9iNwaSUxapxt2Vb/VLPjyjT1AZ2UlGdhMeOhiyWuUZ3j+1V/ZyMy
 uVvNis/DioHDXjdFecTaB0f5haPZ8u0ylm/zWemyC5akp1xTUqILYHZExQ7SMdx8mYQ47ew23iz
 8JQMxuO0cnA8H3bZXWh05Lh3/L5IB7Rzv6/M=
X-Received: by 2002:a05:622a:258c:b0:52d:9a3f:85bc with SMTP id
 d75a77b69052e-52d9a3f954fmr233734581cf.18.1787033277119; 
 Mon, 17 Aug 2026 23:07:57 -0700 (PDT)
X-Received: by 2002:a05:622a:258c:b0:52d:9a3f:85bc with SMTP id
 d75a77b69052e-52d9a3f954fmr233734361cf.18.1787033276719; 
 Mon, 17 Aug 2026 23:07:56 -0700 (PDT)
Received: from [192.168.69.229] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482a5b783d1sm9523438f8f.25.2026.08.17.23.07.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Aug 2026 23:07:55 -0700 (PDT)
Message-ID: <75087cf4-04f9-416e-aaf3-fbfffa2063be@oss.qualcomm.com>
Date: Tue, 18 Aug 2026 08:07:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 5/8] RFC: accel/tcg: allow cross-page goto_tb chaining
 in user-only builds
Content-Language: en-US
To: Matt Turner <mattst88@gmail.com>, qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, pbonzini@redhat.com, philmd@mailo.com,
 zhao1.liu@intel.com, laurent@vivier.eu, deller@gmx.de,
 pierrick.bouvier@oss.qualcomm.com
References: <20260817190038.580257-1-mattst88@gmail.com>
 <20260817190038.580257-6-mattst88@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260817190038.580257-6-mattst88@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDA0NCBTYWx0ZWRfX6nxcvPqPVzh1
 VEylDGfo6+6BWihfHlPprB8hoZ9v3packHmgMtC+GY1yd17+G5dGX3+mhAZKELzPvHGCPBIlxWB
 ABEtxdu/X4nYttQioQY/FXcDXzFDiCY=
X-Proofpoint-ORIG-GUID: dafKg5bk7jbNBvA2bGF4JupTWzl3oLry
X-Authority-Analysis: v=2.4 cv=UfFhjqSN c=1 sm=1 tr=0 ts=6a83f6bd cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=pGLkceISAAAA:8 a=cO3hiOed5FHUAnKiHYQA:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-GUID: dafKg5bk7jbNBvA2bGF4JupTWzl3oLry
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDA0NCBTYWx0ZWRfX6eJtads5Wh/T
 5pw6Nb3fSznMUPpISPsYMbgSfYKRtCIO19T9+7ETETILSZJm1M6VGSw2ix8eCSSU/M9BOg3hycc
 SdeqCz4lPIu0dlZN/+73X6ZGuCsrYGlBxMbzTVt+ICNuF2U431oWRvC2CXtqVK+9FOuHKU4FL+j
 DtLv8i0qd5FupLIsMfchbWNAUVc1Pq1Y+PHLI0PIlIbAdTkshj5mNjLrWP48fsaRiXFyImSPrkV
 BJUJRNHUoWZjtUka+014zAfZD1EmD2cRaVwC6cbmtv/zZfRPEVaW0o+hbubNckYKjoxf/KvsBeh
 3Fc479mSh84dwoughDUnhDvibt7bqfBzBFfH+n5b1mtjX9/xHRbMNy0sQdgsLCtBygRI3XeU9M2
 1O11lPiTcNKmOCy1HqW3XZPLr3/cBiLvCSPmibfxitMK76N0UrzDGxAa3imZ83VxTKypfWi/EWD
 Eo+tZWhoESqKvLIXQ4A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-17_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 impostorscore=0 suspectscore=0 adultscore=0
 spamscore=0 priorityscore=1501 clxscore=1015 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608180044
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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

On 17/8/26 21:00, Matt Turner wrote:
> translator_use_goto_tb() refuses to chain unless the destination is on the
> same page as the start of the TB. For guests whose text is much larger than
> a page this is expensive: an emulated alpha gcc compiling a 255k line
> translation unit takes the indirect dispatch path for 8.4 billion of its
> 34.2 billion TB exits, and a large share of those are ordinary direct
> branches that simply crossed an 8 KiB page boundary.
> 
> The restriction was made unconditional by d3a2a1d803 ("accel/tcg:
> Introduce translator_use_goto_tb"), whose rationale was:
> 
>      Various targets avoid the page crossing test for CONFIG_USER_ONLY,
>      but that is wrong: mmap and mprotect can change page permissions.
> 
> That is true, but in user-only builds the invalidation path already covers
> it. There are no page tables: every mmap, mprotect and munmap reaches
> page_set_flags(), which calls tb_invalidate_phys_range() whenever the flags
> actually change, and tb_phys_invalidate() calls tb_jmp_unlink() to reset
> incoming jumps. A chained cross-page jump is therefore broken whenever the
> destination page's permissions change. This is not true in system mode,
> where TBs are keyed by physical address and a page table change invalidates
> nothing, so the restriction is kept there.
> 
> Add tests/tcg/alpha/test-xpage-chain.c to cover the hazard directly. It
> places a direct branch near the end of one page targeting the next page,
> runs it 200000 times so the chain is established, then checks that
> mprotect(PROT_NONE) makes the next call fault, and that remapping the page
> with different code runs the new code rather than a stale translation.
> 
> The test detects the hazard it is meant to detect: with the
> tb_invalidate_phys_range() call in page_set_flags() commented out, it fails
> both phases, executing page B after PROT_NONE and returning the stale
> result.
> 
> Measured with qemu-alpha running an emulated alpha gcc 16.2.0 compiling the
> SQLite 3.45.1 amalgamation on an x86-64 host, LTO build, on top of the
> preceding patches:
> 
>      before: 890,713,633,237 instructions
>      after:  869,178,598,378 instructions   -2.42%
> 
>      before: 84.44s wall clock
>      after:  80.49s wall clock              -4.68%
> 
> Note that this is worth more in time than in instructions, the reverse of
> the preceding patch: a chained jump replaces a cache probe whose loads can
> miss, so the instructions it removes are more expensive than average.
> 
> Measured before the inline jump cache probe, when a missed chain cost a
> helper call rather than an inline probe, the same change was worth -7.9%.
> 
> RFC because this reverses a deliberate decision and the reasoning above
> wants review from someone who knows the invalidation paths better than I
> do.
> 
> Signed-off-by: Matt Turner <mattst88@gmail.com>
> ---
>   accel/tcg/translator.c             |  12 ++++
>   tests/tcg/alpha/Makefile.target    |   2 +-
>   tests/tcg/alpha/test-xpage-chain.c | 111 +++++++++++++++++++++++++++++
>   3 files changed, 124 insertions(+), 1 deletion(-)
>   create mode 100644 tests/tcg/alpha/test-xpage-chain.c
> 
> diff --git ./accel/tcg/translator.c ./accel/tcg/translator.c
> index 29e609b2ec..4921bf978c 100644
> --- ./accel/tcg/translator.c
> +++ ./accel/tcg/translator.c
> @@ -117,8 +117,20 @@ bool translator_use_goto_tb(DisasContextBase *db, vaddr dest)
>           return false;
>       }
>   
> +#ifdef CONFIG_USER_ONLY
> +    /*
> +     * There are no page tables in user-only mode.  Every mmap, mprotect and
> +     * munmap goes through page_set_flags(), which calls
> +     * tb_invalidate_phys_range() whenever the flags actually change, and
> +     * tb_phys_invalidate() unlinks incoming jumps.  A chained cross-page
> +     * jump is therefore broken whenever the destination page's permissions
> +     * change, so the same-page restriction is not needed here.
> +     */
> +    return true;

Should this be directly changed in translator_is_same_page() in
"exec/translator.h" instead?

> +#else
>       /* Check for the dest on the same page as the start of the TB.  */
>       return translator_is_same_page(db, dest);
> +#endif
>   }


