Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EBF9CA5FB1
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 16:40:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBarj-0004FL-Iq; Tue, 29 Sep 2026 12:39:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xBard-0004Dt-HR
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 12:39:33 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xBara-00063H-PL
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 12:39:33 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68TCqkkU858127
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 16:39:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=B5WBMdbGnoqAAhFppySLjkhk
 LBqj8UkaXKoXDwgAvaw=; b=W0nXo2rARNCfaqvNP6RjM9kedsSKosmYWMDbGurD
 s5+i5fFGzq6lM31In0ywIjyoi2tyhlI0CaLGIr3p/JcoEjxkigQtnuXFZh7JFZkl
 e9JMFkXzjOOw3bjZSnta/2Up5OY7c4HdQ1DidKfE6GPwXaon2fxAroiL9bSptZRT
 Gk6dj+jfiwJddj1mL2iBWYnMNcLQMGLV9jI9goTs3jw7yRaz5Y0GGdyxWA2ihYL2
 hhzzu4HRDnH/g18vl/RWcfXAmtX6O49eqXuuOGNVtTXNtYijeFzvXtwgMR6m7P/N
 IAc9QK0ES1aWMcoldHiSUdB9mm+PIXa7I6pPw3cjs4ZTIw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h08e0jjgn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 16:39:29 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-530d028f779so52447421cf.2
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 09:39:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790699968; x=1791304768; darn=nongnu.org;
 h=in-reply-to:from:content-language:references:cc:to:subject
 :user-agent:mime-version:date:message-id:content-type:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=B5WBMdbGnoqAAhFppySLjkhkLBqj8UkaXKoXDwgAvaw=;
 b=jDYVZAYtMlRFtZ3KVgNGnye0tRBDOZ9g3ShH9xRhZSmPFYO42KIxahvxPgMCGJ4ehi
 EnOY4IRVN1Rvc3P6lu1+0yib6U4KbmUIQ6WlsHN/41r6+iJcgGqeykV0u5lbJLBqWhiC
 fm42vmdv5Ss/L4pYqMCpIOqzD8hKD2+eVu8zKyUPrMzIOzwHKRDEvuTvmQ+UXqOZ+hC7
 NjJagVrVrewbzJcQtNkJuH5qKMT2TZLPlDFv9tBaeKrYBcS/uyWTPdVbPFJizqyDV/rJ
 nBnlie5MR8u/hmHV8+B0TxM8SIcdKnEA+WW8APjsmE32oDBfsdv7xT+Tw9j1nQrwcnA/
 uxBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790699968; x=1791304768;
 h=in-reply-to:from:content-language:references:cc:to:subject
 :user-agent:mime-version:date:message-id:content-type:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=B5WBMdbGnoqAAhFppySLjkhkLBqj8UkaXKoXDwgAvaw=;
 b=wl7VbPKwZskO6tnc6XZrTVlLU1LCLv5nKktZ3GUhyz6VED1GzhIUQDDAXvow09IItN
 oLN+vfBJQcIn8j9rwW2Il7ipDrN692vQb36ntovFnEvJPcUTnyhZ/DATkuQYmD3zrl+i
 opnixA+7EFYIH5v4P/RzqvruRHKfJ+weqz5Dz1ag2KMMmTZrAPzZR381LWy6GZSx8NvZ
 DnsPCtLUCI9R8hyvaWJ4UCVSsSsxG1J/lsZySWy8Ii2i8FJLWDYgOO97j2NrOy/sOLQ8
 6y/oqcnJcVzkSsRZEGUqhftF0L1fDpMfdqXA0tBzv2jXQ1d5LciFGgY4BR5ZkhTC7Tj+
 /1hw==
X-Gm-Message-State: AFuF++nu8G7H/+xS0e7BtDXcOiPkEpt4T+SE1w5nV0/E1QHxGjXbIwEG
 f31RE77srVJQ+Z8dIK6MAETgk2iDRbMoNAeTVNxSSEcvOSwYv70LH659ucI4AnCFYAm0/QbmCEh
 XFZy7BB9fL3WUh2H882OUOm+mvdxsTh3wSmNtXv/i5oLfnr99H2wmnBA3pA==
X-Gm-Gg: AYBFou1v5S3hI0PWANZDW6J7c323trLZX7fPCEsac46wM+cUYlXGgnR+pgoGZgoZN59
 AniDc7dRg0no2FLRt9AnoOJ8BN1CcfpkLG5rFtMu8OEi/xBog0fOEZ04lHltJMWDlTvZRaPtfs7
 hTqN7cSo47fMaSEc3uhoxyPklIXFmeNA/2YP4FLOgRXkVLwYsfQppDKE/FYjpN9rRdDYBr1d8aa
 /IwkNvKFVh8FZKydCr6RlCoWbgFBlxUZNms2vN2dkLKu79jIkypDd04tDr5GEIH2/S+d2e0W1JB
 DmnFBMkod9Z4LZ4ffxoCSVWzSR7/GEDNH7dyItD7zui007lcSrvxKEm2+QCzZw2MGk2bCzvunyO
 AXnc7xTXONKf57zKjTgdOvNokL4Kwh9RVv9zO0+VelTdXA548n6u61vB4bM9yGfKPQy9PUtx/Pm
 oQrm8=
X-Received: by 2002:a05:622a:830b:b0:533:2a84:1f98 with SMTP id
 d75a77b69052e-5332a84315amr153666561cf.3.1790699968211; 
 Tue, 29 Sep 2026 09:39:28 -0700 (PDT)
X-Received: by 2002:a05:622a:830b:b0:533:2a84:1f98 with SMTP id
 d75a77b69052e-5332a84315amr153665701cf.3.1790699967246; 
 Tue, 29 Sep 2026 09:39:27 -0700 (PDT)
Received: from [192.168.1.199] (104-54-226-75.lightspeed.austtx.sbcglobal.net.
 [104.54.226.75]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-5332201fe59sm92101781cf.3.2026.09.29.09.39.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Sep 2026 09:39:26 -0700 (PDT)
Content-Type: multipart/alternative;
 boundary="------------dJrYDi0TPRZ9cR26RCNdMuDh"
Message-ID: <073a7c20-a75e-4873-9208-a366d06db991@oss.qualcomm.com>
Date: Tue, 29 Sep 2026 11:39:24 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/10] tests/tcg/hexagon: Cover HVX vector write conflicts
To: Taylor Simpson <ltaylorsimpson@gmail.com>
Cc: qemu-devel@nongnu.org, Helge Deller <deller@gmx.de>,
 Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 richard.henderson@linaro.org, marco.liebel@oss.qualcomm.com
References: <20260926192338.2702952-1-brian.cain@oss.qualcomm.com>
 <20260926192338.2702952-3-brian.cain@oss.qualcomm.com>
 <CAATN3NqiYs5Pm3S02H1vwLmE_BEkG--jq=+XiL0bXxQnJcXZ9g@mail.gmail.com>
Content-Language: en-US
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <CAATN3NqiYs5Pm3S02H1vwLmE_BEkG--jq=+XiL0bXxQnJcXZ9g@mail.gmail.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDA2NiBTYWx0ZWRfX3kuAhTs53tlw
 ayhHg0kObYpeb65DhE+IdssHmTAKVW1S89tBl74dLCm0VPm+ZdezfFwpvXWVf0N5gKHBmLGshqe
 2nSkrii0j0gujB+fYJQUUqb+hv+8mBo=
X-Proofpoint-ORIG-GUID: uQm9CAN_3NtV4Yc73m55_15DfGs9Kd5s
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDA2NiBTYWx0ZWRfX54GQC27kzmbK
 TtMPrJWNy7mvBZ8mBCmszUu1zdk7ch/Jjmjc+WCuZq0eNzyLLbbqaAAzXouSq3Yim+rkaHe8BuT
 FWZWABIwD2xOBbYXwyOSX+YhOfNUyvFiAax0LpVDt+HP5HCAHlE83zqcmSgfXHRnet1uJNnxMxM
 A9F8r+ing7jleuftVQ5QLjSNxuPzVdnguEI51cmNnrIb09c28onXwSt5vd+1GhZQAiqDuYAHGu2
 SgwyjeUU4qpA1djJnTzmPRhDTWGriDvj4/VZmUHhxORMWykrHG69ULiDPDpr8520yul8W5wgcZA
 TZ94ww7wXRyAT4CJCcfoMaLISTZN04GZIGHGpKLu5seqllfI0S4YTxlhUqwSbWWNpz5cx4p0CpT
 h1LgOtuwKAiiHiKKwSHl4ahgRRGOqWJU7houX8xWQzhq9HkOwYUv94xZEt41NhKozhzaUdByky5
 i1mm2IQXHqKR4QV4zAw==
X-Authority-Analysis: v=2.4 cv=WJ7qzXsR c=1 sm=1 tr=0 ts=6abbe9c1 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=x6rl1zRT+JsLSO7OGbGBKQ==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=r77TgQKjGQsHNAKrUKIA:9
 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8 a=3pT8_-mKT5-ywmvStBMA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=-ui2fljckFxbOdJo6NkA:9 a=8sMz4n05qokqYSjx:21
 a=_W_S_7VecoQA:10 a=lqcHg5cX4UMA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-GUID: uQm9CAN_3NtV4Yc73m55_15DfGs9Kd5s
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 clxscore=1015 malwarescore=0 bulkscore=0
 adultscore=0 spamscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609290066
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

This is a multi-part message in MIME format.
--------------dJrYDi0TPRZ9cR26RCNdMuDh
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 9/28/2026 11:52 AM, Taylor Simpson wrote:
>
>
> On Sat, Sep 26, 2026 at 1:23 PM Brian Cain 
> <brian.cain@oss.qualcomm.com> wrote:
>
>     Cc: Taylor Simpson <ltaylorsimpson@gmail.com>
>     Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
>     ---
>
As it turns out, the multiple write behavior for vector / vector-pred 
registers is "undefined".  In practice, neither the hardware nor ISS 
raises exceptions here.  I will downgrade this behavior to logging a 
GUEST_ERROR similar to the assembler behavior to reject these packets.


>      tests/tcg/hexagon/multiple-writes.c | 98
>     +++++++++++++++++++++++++++++
>      1 file changed, 98 insertions(+)
>
>     diff --git a/tests/tcg/hexagon/multiple-writes.c
>     b/tests/tcg/hexagon/multiple-writes.c
>     index bd2b1384dd9..21771252020 100644
>     --- a/tests/tcg/hexagon/multiple-writes.c
>     +++ b/tests/tcg/hexagon/multiple-writes.c
>     @@ -13,6 +13,7 @@
>
>      #include <assert.h>
>      #include <signal.h>
>     +#include <stdint.h>
>      #include <stdio.h>
>      #include <stdlib.h>
>      #include <string.h>
>     @@ -223,6 +224,80 @@ static int test_vreg_legal_predicated(void)
>          return sig;
>      }
>
>     +/*
>     + * Complementary predicated writes to the same V-register pair
>     are legal.
>     + * v16 and v22 are splatted with distinct patterns; since p0 is
>     always
>     + * true, v14 must end up holding v16's pattern.  Extracting a
>     word from
>     + * v14 confirms the executed branch actually ran, rather than
>     merely that
>     + * no SIGILL was raised.
>     + */
>     +static int test_vreg_pair_legal_predicated(void)
>     +{
>     +    int sig;
>     +    uint32_t result;
>     +
>     +    asm volatile(
>     +        "r0 = #0\n"
>     +        "r1 = ##1f\n"
>     +        "memw(%[resume_pc]) = r1\n"
>     +        "r4 = #0x11111111\n"
>     +        "r5 = #0x22222222\n"
>     +        "v16 = vsplat(r4)\n"
>     +        "v22 = vsplat(r5)\n"
>
>
> Go ahead and assign something to v21 and v23 here.
> Ultimately, the values aren't used but the registers are referenced in 
> the vcombine instructions below.
> Alternatively, you could just use v16 and v22.  Something like
>         "    if (p0) v15:14 = vcombine(v22, v16)\n"
>         "    if (!p0) v15:14 = vcombine(v16, v22)\n"
> If you do that, you can remove v21 and v23 from the clobber list.
>
>     +        "r4 = #0\n"
>     +        "p0 = cmp.eq(r0, r0)\n"
>     +        "{\n"
>     +        "    if (p0) v15:14 = vcombine(v21, v16)\n"
>     +        "    if (!p0) v15:14 = vcombine(v23, v22)\n"
>     +        "}\n"
>     +        "%[result] = vextract(v14, r4)\n"
>     +        "1:\n"
>     +        "%[sig] = r0\n"
>     +        : [sig] "=r"(sig), [result] "=r"(result)
>     +        : [resume_pc] "r"(&resume_pc)
>     +        : "r0", "r1", "r4", "r5", "p0",
>     +          "v14", "v15", "v16", "v21", "v22", "v23", "memory");
>     +
>     +    return sig == SIGILL ? SIGILL : result;
>     +}
>     +
>     +/*
>     + * A future write may consume a temporary value from the same
>     V-register.
>     + * buf is zeroed, so v0.tmp loads all-zero and v0.w =
>     vadd(v0.tmp.w, 1)
>     + * must end up as 1 in every word.  Extracting a word from the result
>     + * confirms the add actually used the loaded .tmp value, rather than
>     + * merely that no SIGILL was raised.
>     + */
>     +static int test_vreg_legal_tmp(void)
>     +{
>     +    long long buf[16] __attribute__((aligned(128)));
>     +    int sig;
>     +    uint32_t result;
>     +
>     +    memset(buf, 0, sizeof(buf));
>     +
>     +    asm volatile(
>     +        "r0 = #0\n"
>     +        "r1 = ##1f\n"
>     +        "memw(%[resume_pc]) = r1\n"
>     +        "r2 = %[buf]\n"
>     +        "r3 = #1\n"
>     +        "r4 = #0\n"
>     +        "v1 = vsplat(r3)\n"
>
>
> Consider putting something non-zero into v0 here.
> That will be a stronger check that the read from buf actually took place.
>
>     +        "{\n"
>     +        "    v0.tmp = vmem(r2 + #0)\n"
>     +        "    v0.w = vadd(v0.w, v1.w)\n"
>     +        "}\n"
>     +        "%[result] = vextract(v0, r4)\n"
>     +        "1:\n"
>     +        "%[sig] = r0\n"
>     +        : [sig] "=r"(sig), [result] "=r"(result)
>     +        : [resume_pc] "r"(&resume_pc), [buf] "r"(buf)
>     +        : "r0", "r1", "r2", "r3", "r4", "v0", "v1", "memory");
>     +
>     +    return sig == SIGILL ? SIGILL : result;
>     +}
>     +
>      static int test_vreg_illegal_mixed(void)
>      {
>          int sig;
>     @@ -242,6 +317,26 @@ static int test_vreg_illegal_mixed(void)
>          return sig;
>      }
>
>     +/* A pair write and a single write to either pair member are
>     illegal. */
>     +static int test_vreg_illegal_pair_overlap(void)
>     +{
>     +    int sig;
>     +
>     +    asm volatile(
>     +        "r0 = #0\n"
>     +        "r1 = ##1f\n"
>     +        "memw(%[resume_pc]) = r1\n"
>
>
> Consider putting something into v14 and v15 here and check the values 
> are unchanged at the end.
> Perhaps a subsequent patch that does this for all the illegal tests.
>
>     +        ".word 0x1f5055ee    /* { v15:14 = vcombine(v21, v16) */\n"
>     +        ".word 0x1e03e5ee    /*   v14 = v5 } */\n"
>     +        "1:\n"
>     +        "%[sig] = r0\n"
>     +        : [sig] "=r"(sig)
>     +        : [resume_pc] "r"(&resume_pc)
>     +        : "r0", "r1", "memory");
>     +
>     +    return sig;
>     +}
>     +
>      static int test_vreg_illegal_uncond(void)
>      {
>          int sig;
>     @@ -308,7 +403,10 @@ int main()
>          assert(test_post_increment3() == SIGILL);
>
>          assert(test_vreg_legal_predicated() == 23);
>     +    assert(test_vreg_pair_legal_predicated() == 0x11111111);
>     +    assert(test_vreg_legal_tmp() == 1);
>          assert(test_vreg_illegal_mixed() == SIGILL);
>     +    assert(test_vreg_illegal_pair_overlap() == SIGILL);
>          assert(test_vreg_illegal_uncond() == SIGILL);
>
>          assert(test_qreg_illegal() == SIGILL);
>     -- 
>     2.34.1
>
>
> Otherwise
> Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>
--------------dJrYDi0TPRZ9cR26RCNdMuDh
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 9/28/2026 11:52 AM, Taylor Simpson
      wrote:<br>
    </div>
    <blockquote type="cite"
cite="mid:CAATN3NqiYs5Pm3S02H1vwLmE_BEkG--jq=+XiL0bXxQnJcXZ9g@mail.gmail.com">
      <meta http-equiv="content-type" content="text/html; charset=UTF-8">
      <div dir="ltr">
        <div dir="ltr"><br>
        </div>
        <br>
        <div class="gmail_quote gmail_quote_container">
          <div dir="ltr" class="gmail_attr">On Sat, Sep 26, 2026 at
            1:23 PM Brian Cain &lt;<a
              href="mailto:brian.cain@oss.qualcomm.com"
              moz-do-not-send="true" class="moz-txt-link-freetext">brian.cain@oss.qualcomm.com</a>&gt;
            wrote:<br>
          </div>
          <blockquote class="gmail_quote"
style="margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Cc:
            Taylor Simpson &lt;<a href="mailto:ltaylorsimpson@gmail.com"
              target="_blank" moz-do-not-send="true"
              class="moz-txt-link-freetext">ltaylorsimpson@gmail.com</a>&gt;<br>
            Signed-off-by: Brian Cain &lt;<a
              href="mailto:brian.cain@oss.qualcomm.com" target="_blank"
              moz-do-not-send="true" class="moz-txt-link-freetext">brian.cain@oss.qualcomm.com</a>&gt;<br>
            ---<br>
          </blockquote>
        </div>
      </div>
    </blockquote>
    <p>As it turns out, the multiple write behavior for vector /
      vector-pred registers is "undefined".  In practice, neither the
      hardware nor ISS raises exceptions here.  I will downgrade this
      behavior to logging a GUEST_ERROR similar to the assembler
      behavior to reject these packets.</p>
    <p><br>
    </p>
    <blockquote type="cite"
cite="mid:CAATN3NqiYs5Pm3S02H1vwLmE_BEkG--jq=+XiL0bXxQnJcXZ9g@mail.gmail.com">
      <div dir="ltr">
        <div class="gmail_quote gmail_quote_container">
          <blockquote class="gmail_quote"
style="margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"> tests/tcg/hexagon/multiple-writes.c
            | 98 +++++++++++++++++++++++++++++<br>
             1 file changed, 98 insertions(+)<br>
            <br>
            diff --git a/tests/tcg/hexagon/multiple-writes.c
            b/tests/tcg/hexagon/multiple-writes.c<br>
            index bd2b1384dd9..21771252020 100644<br>
            --- a/tests/tcg/hexagon/multiple-writes.c<br>
            +++ b/tests/tcg/hexagon/multiple-writes.c<br>
            @@ -13,6 +13,7 @@<br>
            <br>
             #include &lt;assert.h&gt;<br>
             #include &lt;signal.h&gt;<br>
            +#include &lt;stdint.h&gt;<br>
             #include &lt;stdio.h&gt;<br>
             #include &lt;stdlib.h&gt;<br>
             #include &lt;string.h&gt;<br>
            @@ -223,6 +224,80 @@ static int
            test_vreg_legal_predicated(void)<br>
                 return sig;<br>
             }<br>
            <br>
            +/*<br>
            + * Complementary predicated writes to the same V-register
            pair are legal.<br>
            + * v16 and v22 are splatted with distinct patterns; since
            p0 is always<br>
            + * true, v14 must end up holding v16's pattern.  Extracting
            a word from<br>
            + * v14 confirms the executed branch actually ran, rather
            than merely that<br>
            + * no SIGILL was raised.<br>
            + */<br>
            +static int test_vreg_pair_legal_predicated(void)<br>
            +{<br>
            +    int sig;<br>
            +    uint32_t result;<br>
            +<br>
            +    asm volatile(<br>
            +        "r0 = #0\n"<br>
            +        "r1 = ##1f\n"<br>
            +        "memw(%[resume_pc]) = r1\n"<br>
            +        "r4 = #0x11111111\n"<br>
            +        "r5 = #0x22222222\n"<br>
            +        "v16 = vsplat(r4)\n"<br>
            +        "v22 = vsplat(r5)\n"<br>
          </blockquote>
          <div><br>
          </div>
          <div>Go ahead and assign something to v21 and v23 here.</div>
          <div>Ultimately, the values aren't used but the registers are
            referenced in the vcombine instructions below.</div>
          <div>Alternatively, you could just use v16 and v22.  Something
            like</div>
          <div>        "    if (p0) v15:14 = vcombine(v22, v16)\n"<br>
                    "    if (!p0) v15:14 = vcombine(v16, v22)\n"<br>
          </div>
          <div>If you do that, you can remove v21 and v23 from the
            clobber list.</div>
          <div> </div>
          <blockquote class="gmail_quote"
style="margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
            +        "r4 = #0\n"<br>
            +        "p0 = cmp.eq(r0, r0)\n"<br>
            +        "{\n"<br>
            +        "    if (p0) v15:14 = vcombine(v21, v16)\n"<br>
            +        "    if (!p0) v15:14 = vcombine(v23, v22)\n"<br>
            +        "}\n"<br>
            +        "%[result] = vextract(v14, r4)\n"<br>
            +        "1:\n"<br>
            +        "%[sig] = r0\n"<br>
            +        : [sig] "=r"(sig), [result] "=r"(result)<br>
            +        : [resume_pc] "r"(&amp;resume_pc)<br>
            +        : "r0", "r1", "r4", "r5", "p0",<br>
            +          "v14", "v15", "v16", "v21", "v22", "v23",
            "memory");<br>
            +<br>
            +    return sig == SIGILL ? SIGILL : result;<br>
            +}<br>
            +<br>
            +/*<br>
            + * A future write may consume a temporary value from the
            same V-register.<br>
            + * buf is zeroed, so v0.tmp loads all-zero and v0.w =
            vadd(v0.tmp.w, 1)<br>
            + * must end up as 1 in every word.  Extracting a word from
            the result<br>
            + * confirms the add actually used the loaded .tmp value,
            rather than<br>
            + * merely that no SIGILL was raised.<br>
            + */<br>
            +static int test_vreg_legal_tmp(void)<br>
            +{<br>
            +    long long buf[16] __attribute__((aligned(128)));<br>
            +    int sig;<br>
            +    uint32_t result;<br>
            +<br>
            +    memset(buf, 0, sizeof(buf));<br>
            +<br>
            +    asm volatile(<br>
            +        "r0 = #0\n"<br>
            +        "r1 = ##1f\n"<br>
            +        "memw(%[resume_pc]) = r1\n"<br>
            +        "r2 = %[buf]\n"<br>
            +        "r3 = #1\n"<br>
            +        "r4 = #0\n"<br>
            +        "v1 = vsplat(r3)\n"<br>
          </blockquote>
          <div><br>
          </div>
          <div>Consider putting something non-zero into v0 here.</div>
          <div>That will be a stronger check that the read from buf
            actually took place.</div>
          <div> </div>
          <blockquote class="gmail_quote"
style="margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
            +        "{\n"<br>
            +        "    v0.tmp = vmem(r2 + #0)\n"<br>
            +        "    v0.w = vadd(v0.w, v1.w)\n"<br>
            +        "}\n"<br>
            +        "%[result] = vextract(v0, r4)\n"<br>
            +        "1:\n"<br>
            +        "%[sig] = r0\n"<br>
            +        : [sig] "=r"(sig), [result] "=r"(result)<br>
            +        : [resume_pc] "r"(&amp;resume_pc), [buf] "r"(buf)<br>
            +        : "r0", "r1", "r2", "r3", "r4", "v0", "v1",
            "memory");<br>
            +<br>
            +    return sig == SIGILL ? SIGILL : result;<br>
            +}<br>
            +<br>
             static int test_vreg_illegal_mixed(void)<br>
             {<br>
                 int sig;<br>
            @@ -242,6 +317,26 @@ static int
            test_vreg_illegal_mixed(void)<br>
                 return sig;<br>
             }<br>
            <br>
            +/* A pair write and a single write to either pair member
            are illegal. */<br>
            +static int test_vreg_illegal_pair_overlap(void)<br>
            +{<br>
            +    int sig;<br>
            +<br>
            +    asm volatile(<br>
            +        "r0 = #0\n"<br>
            +        "r1 = ##1f\n"<br>
            +        "memw(%[resume_pc]) = r1\n"<br>
          </blockquote>
          <div><br>
          </div>
          <div>Consider putting something into v14 and v15 here and
            check the values are unchanged at the end.</div>
          <div>Perhaps a subsequent patch that does this for all the
            illegal tests.</div>
          <div> </div>
          <blockquote class="gmail_quote"
style="margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
            +        ".word 0x1f5055ee    /* { v15:14 = vcombine(v21,
            v16) */\n"<br>
            +        ".word 0x1e03e5ee    /*   v14 = v5 } */\n"<br>
            +        "1:\n"<br>
            +        "%[sig] = r0\n"<br>
            +        : [sig] "=r"(sig)<br>
            +        : [resume_pc] "r"(&amp;resume_pc)<br>
            +        : "r0", "r1", "memory");<br>
            +<br>
            +    return sig;<br>
            +}<br>
            +<br>
             static int test_vreg_illegal_uncond(void)<br>
             {<br>
                 int sig;<br>
            @@ -308,7 +403,10 @@ int main()<br>
                 assert(test_post_increment3() == SIGILL);<br>
            <br>
                 assert(test_vreg_legal_predicated() == 23);<br>
            +    assert(test_vreg_pair_legal_predicated() ==
            0x11111111);<br>
            +    assert(test_vreg_legal_tmp() == 1);<br>
                 assert(test_vreg_illegal_mixed() == SIGILL);<br>
            +    assert(test_vreg_illegal_pair_overlap() == SIGILL);<br>
                 assert(test_vreg_illegal_uncond() == SIGILL);<br>
            <br>
                 assert(test_qreg_illegal() == SIGILL);<br>
            -- <br>
            2.34.1<br>
          </blockquote>
          <div><br>
          </div>
          <div>Otherwise</div>
          <div>Reviewed-by: Taylor Simpson &lt;<a
              href="mailto:ltaylorsimpson@gmail.com"
              moz-do-not-send="true" class="moz-txt-link-freetext">ltaylorsimpson@gmail.com</a>&gt;</div>
          <div> </div>
        </div>
      </div>
    </blockquote>
  </body>
</html>

--------------dJrYDi0TPRZ9cR26RCNdMuDh--

