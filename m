Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFACFC53219
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 08:25:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wod88-0002C5-5d; Tue, 28 Jul 2026 04:25:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wod86-0002Bt-LW
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 04:25:38 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wod85-0008PI-5P
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 04:25:38 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66S82nSX2309797
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 08:25:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 BYU4pr+bALFeuAz5cQoNVFKIl2lB5CxLaeGgnp8IDRE=; b=Ss5duM+ZyZjtazby
 iZ5VWl2uNtTqblUrwtU81DVTuYPj/N2tMhG83Ro0Ejk0ouAjZCljJO5ExglclJPl
 UqOOavTURrwTZQxxOxq9fI5ccpj5evPJ3N1vP0GA7WVh8ksKaWPtudnq6iZnPoiS
 TjTc6fCWc/kqhgePGm0R3pVNFs4F6S3SEQwDgi+vyk8QYuFesU4bSo1QOpgDE5LV
 CxDULBRoFxBWCq4cUsjNeKZFaQp6wfqDWTk7jymLwcB6ZsMEA7Qm8vK6rXcxryih
 X7YVtWcG3XAeEYife31H9gHxg7fEF9Q7m0/vGpUNMDqrW15oI3toTDi9YUJ1/g0y
 Sz7kgA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fphh7hrd9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 08:25:35 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-522de3c645dso12788671cf.3
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 01:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785227134; x=1785831934; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=BYU4pr+bALFeuAz5cQoNVFKIl2lB5CxLaeGgnp8IDRE=;
 b=jGQNB6SH+mHChD1nBmElwRIKnvla/TN1F2c0xLbd0QcdfGsM+NxaF500EQ5wSBz/6M
 fEcoVbiaUnc/NT0fGmtqvV0Ts0rMAcQChTCHOnUgp8jQZyV7qksCrybIUneXLZwF8dqP
 lD7z7pLCGxjjCILGRjBTqAEapw8gFn3lpCO0GzPkVrrXqGLzuuoMHUcVDIgh0MMsVx/z
 1u8jdGLOsbA9xMT2m+w+Sox4IjqhRw8DDzHgOePb4QvhvkXwe4wKbxMChoSfSZNRG/pY
 y2Gg4GB/wnyrJPIPlahlGG7LpO5R4zovb98vm9Lx2IF59lffb2CMhs5J7/+sXBu4PmW/
 OAqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785227134; x=1785831934;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=BYU4pr+bALFeuAz5cQoNVFKIl2lB5CxLaeGgnp8IDRE=;
 b=tOCgt7rQdVQlAtz5Yk2i79q/JLcPL4d9XewhyZ5bShmK0iXHY1+PRf9paM+kr+PP6e
 NiW0h9GHCW9ujeYQ3qDoBLQO18N8F8jnLUXovooJVukefumNaUXdhmT2Yr7CJsR7P7c8
 i/XQCgUF3Y1y/gCxTCB7Bo6A1Y3+peEZy7jQCoPM29zPoN5pZGZIlRmb40ec2RlbuFRR
 go6bSOwrBE3d2BzTf6D8sLTHAKPMUcc9OzE5OqzCCXxOFTA3iRajq4Xmbml+nVn3OAOy
 K2wKDQ/FUMxmVuUvo4vF053RMLB97x7PrqoVXhu0/7yieuknVA8f5bRzOum6SlAfv2AJ
 RPhA==
X-Forwarded-Encrypted: i=1;
 AHgh+RogUTO4vHFTifqIbKbZYbillp0vqTCL4UugZ0RISW8EDZLPxOnvr+H+ZF8pZKLXvBVNN5H9ZjCAfuvp@nongnu.org
X-Gm-Message-State: AOJu0Yx0T8S2nfBxAHY0XvjXupEDJInH30XSjrMJ2DLw3Q0KhwfAJxov
 1bophX5/mhpf6576hhxGd/bFMSErBiCePySJ+HojoC034hxmCZLYUaYwWzHGZxXq2m3fGfC443P
 zm+GjGKJ3N5dE31QxJGdiHr7JiDlJJzEshZrHXRy4QggU/+FD088aMIoK6m/PvYXLBw==
X-Gm-Gg: AR+sD13mgb6cFtelpuzfm2JtWon4wHqWw32Akdctc5l2JEZcgp9IVpUin0pt2/Huz6H
 L4e/1JvJn26Yx0N2XfoPq9QMWN9IfLQsolu3y0SUPU8JfTVVOHC4zdzWLxF4fPT8xrQGpA1Z0xy
 eYM68qL4XqH5PqqSiNaYBx3hPTLvKmesIiC7BUzswQlxotIXunhPOtErkzBUSBwVvqjtuu6V28R
 SqzZtLpKwGO+awnZQFindTKLjnv+ZgrjKAcicntGDvr0Y45RksIH3ehJlCrtugiZWBX7OPFyTlH
 ovLnZo9/jzxOS49305p0c3wNvrvJIr3EHwKtnGpXjXCuck2gOuUpcch4p5N34nTVXucjiNBkZiR
 hT6nWha8qQTeYivQUCgVWmvHnl/dsD6ygVy1saF+HfyHTVwXzJoY=
X-Received: by 2002:a05:622a:4d47:b0:516:d612:d1c4 with SMTP id
 d75a77b69052e-529d70e4e08mr11472791cf.52.1785227134597; 
 Tue, 28 Jul 2026 01:25:34 -0700 (PDT)
X-Received: by 2002:a05:622a:4d47:b0:516:d612:d1c4 with SMTP id
 d75a77b69052e-529d70e4e08mr11472561cf.52.1785227134063; 
 Tue, 28 Jul 2026 01:25:34 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85b9a596sm55279324f8f.4.2026.07.28.01.25.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Jul 2026 01:25:33 -0700 (PDT)
Message-ID: <026f1ddb-4725-4c3c-857c-a4adead18d7c@oss.qualcomm.com>
Date: Tue, 28 Jul 2026 10:25:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/9] target/mips: drop hidden TLB shadowing for tlbwr
Content-Language: en-US
To: "Kirill A. Korinsky" <kirill@korins.ky>, qemu-devel@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>
References: <20260713112004.4956-1-kirill@korins.ky>
 <20260713112004.4956-5-kirill@korins.ky>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260713112004.4956-5-kirill@korins.ky>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDA3MSBTYWx0ZWRfX5Osdq6VJzUp9
 W7Va+dhy0hisZPoN/DWuRiCSap1zqZjV77x+KD7fdzO4E8sZfIkaIt28dws7ldqTBrFV0q5Y8yQ
 La/JNf/3S6/rPA5lsXkgvMsK4fNMWJxyBmiyqGvmNMhz+J8YwB0EnRpG0NTJSq1dFl6dzJYHeP6
 p3PFiALlTa7ovwBD9bcPQ+AgCkarn8mxF4n96fCZ5Wa9kl9BCdMIK3QhlskmhI4zJ0wEmBmVoqJ
 rhgT9HViKpt1CaMr8sPpb+DftEdZfoMggWnUeSbyWqjZuD8pfjvLkwDjNm3WVvZMlvovNT9fxqf
 31hLGl/RB7eFysoHO40iNH66lS9d5UI/nOaK8jkQR/CPuH9zZV/bKRGrqwa2kzbLek3sPRX1/bG
 D7i+Bqc+Roewb+Rn7+c2ZDXd7MuiaATrSIK3Cow66IInBf9pURFXRYNnLpIQc6fBZWg0tZGxb8f
 QVnkILcdvDCQ5LGpBqw==
X-Proofpoint-ORIG-GUID: BWL87b11RKxzGr-2CTeYQ8BhozAaKHhF
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDA3MSBTYWx0ZWRfX1q+TTTPA9Z/k
 Z1JPiplw3Jr7Jcbh/3nZojt+vjArVMEvS3oBwHoxqFNApTHceyFINoPjG2heLFs2n2oR5TrgaWG
 /0UdarEL+quGPPtvOjgLLn6xed5wabU=
X-Proofpoint-GUID: BWL87b11RKxzGr-2CTeYQ8BhozAaKHhF
X-Authority-Analysis: v=2.4 cv=b+6CJNGx c=1 sm=1 tr=0 ts=6a68677f cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=Gys3sEToJdxMFU4jq1oA:9 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_02,2026-07-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0
 priorityscore=1501 impostorscore=0 malwarescore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607280071
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Kirill,

On 13/7/26 13:16, Kirill A. Korinsky wrote:
> tlbwr replaces a random architectural TLB entry. Once that happens, the
> evicted entry must stop translating guest virtual addresses.
> 
> The current helper keeps the evicted entry in QEMU-only extra TLB state.
> That makes the old mapping survive until some later operation discards
> the extra entries. A guest can observe this directly by writing through
> a TLB mapping, replacing that entry with tlbwr, and writing through the
> old virtual address again.
> 
> Invalidate the replaced entry instead of shadowing it. This keeps the
> translated TLB state aligned with the architectural TLB contents.
> 
> Signed-off-by: Kirill A. Korinsky <kirill@korins.ky>
> ---
>   target/mips/tcg/system/tlb_helper.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/mips/tcg/system/tlb_helper.c b/target/mips/tcg/system/tlb_helper.c
> index 9772df5d6c..4c0a25e622 100644
> --- a/target/mips/tcg/system/tlb_helper.c
> +++ b/target/mips/tcg/system/tlb_helper.c
> @@ -165,7 +165,7 @@ static void r4k_helper_tlbwr(CPUMIPSState *env)
>   {
>       int r = cpu_mips_get_random(env);
>   
> -    r4k_invalidate_tlb(env, r, 1);
> +    r4k_invalidate_tlb(env, r, 0);
>       r4k_fill_tlb(env, r);
>   }

This comes from commit 814b9a47490 ("MIPS TLB performance
improvements, by Daniel Jacobowitz."), 20 years ago and is the
single use of @use_extra. Should we remove it altogether,
along with the @tlb_in_use index and r4k_mips_tlb_flush_extra,
indeed reverting that commit?

