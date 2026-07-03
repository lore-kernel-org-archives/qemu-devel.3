Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1A84C43458
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 02:34:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfTim-0002mZ-Fr; Thu, 02 Jul 2026 22:33:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wfTif-0002Vb-3z
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 22:33:35 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wfTid-0004PD-9h
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 22:33:32 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66319bmg2356076
 for <qemu-devel@nongnu.org>; Fri, 3 Jul 2026 02:33:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 kNpbZaXoXz9khjcrnaLbf86TpvKm9Xi3BEWKVZj/2U4=; b=LGx2h4DDz0/SczT7
 1MebnaU/44mHCNYIc75tgNX4Z0CDNBmNVeGuB5i4i6QLYBy8JeNtTTwbF+FhyFdz
 8MX1j/DyAexOO6W6I1nHyxxAB6pCcnJ+HLQek5b0NB7k2+LQOPMMKAqBbbPXolil
 MR2Ka3/rcQayWvBKulM9i+pySLBdJWhl2Olx/aDlppnSo/EVJOWDXayfLmBS2vuq
 lv0E5iTKd88b7R7j/s3cQcFlqQrQcSZx6Cv1Sj4rz/uWjBYvJGF2KFgQyONkE9UP
 PEGXj6XrPGKsVT5q+UfJGjrEYD64CevCu09M5r9uEAHXFPKeFABTn82bSFRb1b50
 vhcrbQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f5qfc390j-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2026 02:33:29 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-92e8004d60eso17603985a.1
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2026 19:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783046008; x=1783650808; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=kNpbZaXoXz9khjcrnaLbf86TpvKm9Xi3BEWKVZj/2U4=;
 b=LRe8BbnvcxrukHktfQhT3Be4UXyj0MrV3g9h4deM9bNwL7RqrrghaPaT4PdXu+iWfi
 NACMykMVwKiSEzG+L9l0QzTzoCKMX1k0a+PiX2MTyeRtwNx0wqSabkh92GzTCN9v/kuX
 atGkmtzBEKOrYXTizCpvpnK6HQAAcy7JeN5ClNa2uxce+0C5OGMvwMaZglcb0YseBAjT
 c1x79Wtv6S/P/J07lBjgoWoDGAtUOuyXbZor7BEl8S+f6e1fyTbjsDruQXpdyXFJFJ/5
 uoEFmBnQ+EwUV+wBydb7Self/8JlcHlR36TxjxaJtvy1rDyQa3r0BSiG+T5TY9J1M1bf
 xYCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783046008; x=1783650808;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=kNpbZaXoXz9khjcrnaLbf86TpvKm9Xi3BEWKVZj/2U4=;
 b=jrD2T9YVq1X7eo0KBRRiSB5Uy8cJ+LE5bj7SyjAhEXJy7XnfsI7i/RPuoSwDRg7nEn
 QthVA9qMDjMbnD4yOj37fc/GXkAitmxo9GoWU+6Cty3yCnFlxstBeTeNNntK7XE477hD
 VX30PXo8bysLvkCWSBs4zMy430kpHvf2UsVMvCyPlBUn5z6Nn/kpte6/WYJYpHHfbRl0
 e/YBOI/rSjzTvXdbHlrx3qCpR9YrxGyoJHDNkuIw/zBSItdSxM1KflP5KC0rY+GhbYsa
 wknFi892Rgw3DU8gnhmLFUUEEvEd5lj/mD6HS/PgSqLuy5BVucBpwOsGz114WE74UXK3
 GIvg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/fz9REqgSydWvHpormnYYSE7XOELwQSjDEpvJxNt6lRmK0Xy3/nyShAdIAT+kf+r4tsvMd/50gNQEu@nongnu.org
X-Gm-Message-State: AOJu0YxT72FaryVWa8NIkOWX0q/k6QDnv0buAG80pdZScDg9ZkaWZplG
 mDpWgj70ECPhEsn2FtUJkNo3kRxijEWb1UF2J7Ixml9PYbkkWf1RiY0Q2KsECneTRcZPXa2jQQx
 mbDX33TTV9GEEiAQWQvh+W5pyJk1onY0eJlEL+o9E9qi3OADeniSAJl8lqg==
X-Gm-Gg: AfdE7ckMvzXAobka0B5+OKx9RC27gUmma/L5Of2Unx6UPMFHREMUwE4tgCgd30R5nHT
 cIFu+MnzxQ6gLy+xfQeqTzDM7iBQTw8Pin6B4bZKrd5y7B1q54S3NCKbYmZsseV0iZvt7IJ1f4g
 5cM8HNSkcqICqIQ/nBTsWRGlxZvToVjRkZeIFbzd9dKgS2hZx9h5nyjrvT2DCxQP/y6N9PJPbhM
 7rn3xHoVu9Vd4/Y5HHVE4rkW9oLwE/ahrMM2uquiEIaq6CUb0y9+6Ag4wfh0G1NPyNRJxKnmFdB
 NCOw4s2h3ey6mUFbsU7gTWmqtLz5FtN30nY78wLS15b3FXB+aIwty2Q5/FGvIplkTpI/l7/oAPw
 Tr+Q/+WbDuQuKJsGwePqssuGrw0ax9sngQ4p7RdpDnDBLsC19DoRBbSTn/e06Gw==
X-Received: by 2002:a05:620a:2a09:b0:92e:72a4:f28a with SMTP id
 af79cd13be357-92e7b37812bmr1089602185a.44.1783046008013; 
 Thu, 02 Jul 2026 19:33:28 -0700 (PDT)
X-Received: by 2002:a05:620a:2a09:b0:92e:72a4:f28a with SMTP id
 af79cd13be357-92e7b37812bmr1089600485a.44.1783046007601; 
 Thu, 02 Jul 2026 19:33:27 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-477dd94ce4csm14507073f8f.17.2026.07.02.19.33.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Jul 2026 19:33:26 -0700 (PDT)
Message-ID: <55b9ad39-e4dc-405a-baa2-27d193452665@oss.qualcomm.com>
Date: Fri, 3 Jul 2026 04:33:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] accel/tcg: Use TLB_FORCE_SLOW not TLB_MMIO for user-only
 plugins
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
References: <20260702171057.47998-1-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260702171057.47998-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: O23ya-7juDZQfTAkeKqySPtCErIN7hbk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDAyMyBTYWx0ZWRfX3fZzWjn394bn
 4xsk7XANGHY4PWLJc12ovTma1Y0XGe2SArk0LzDIyTW4FakTdc33FvlFsp66z9dhajMLUNVmPN+
 Tjsdzf2p9inhy+Tlz+JDYmTG58bUx45OI7uRKccnlJlMPktL4FW82mfyngAzCjdovrwLP4+vcKo
 Af2waTXPMBMam7NmSljdz3pJ/4vIULWkDIU8fYh8TCWImkqu0GRKP+yK02cI/Y1d8M6SxQbg37L
 sabdCUG58K7dkp88tNuIPTkePyTXzNnLxhatztKLgMWtOjID48nbKZwzyczkCNu17Az+sTmgB/u
 1SQU06upph2R1FeFadrGg3zUQ3lhwV1LBuLSq1m2Uqyg7h6AWMkYxzRRCa1Dw0ArrolVRySQ/jg
 rLH35D4/6UdY0OcdP/1Em9/xuviyap1mDraICejzNosrerbUOli0+SZZLNtWjQT28r6hyLMQCUp
 vyxEQ7qlZwWy7sCStlg==
X-Authority-Analysis: v=2.4 cv=dvXrzVg4 c=1 sm=1 tr=0 ts=6a471f79 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=69wJf7TsAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=qOLl444hFbqTvrjM0UMA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
 a=Fg1AiH1G6rFz08G2ETeA:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: O23ya-7juDZQfTAkeKqySPtCErIN7hbk
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDAyMyBTYWx0ZWRfX2NQO33aWRqbL
 8i9ERia/xsixel0olsrMmVlL75VWh6xarrciOR6hZxFsmyYcrxAG8z6owihKz6fbAPR2IIwinVT
 IyO1BWwcGQxAC7pq2HdoRY+VrKWcazM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 priorityscore=1501 adultscore=0 impostorscore=0
 bulkscore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607030023
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

On 2/7/26 19:10, Richard Henderson wrote:
> In 6d03226b422 we set TLB_MMIO to a non-zero value for user-only
> so that we could return a non-zero value from probe_* functions
> so that we could force callers like Arm SVE vector moves to use
> the slow path rather than direct access.  All for the sake of
> exposing these accesses to plugins.
> 
> Back then, TLB_FORCE_SLOW did not exist, so TLB_MMIO seemed like
> a reasonable solution.  However, user-only doesn't really have
> MMIO and this has knock-on effects, like forcing Arm SVE first-fault
> vector loads to stop.  Better to use TLB_FORCE_SLOW as a more exact
> exact trigger for plugins.

"exact exact"

> 
> Cc: qemu-stable@nongnu.org
> Fixes: 6d03226b422 ("plugins: force slow path when plugins instrument memory ops")
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/exec/tlb-flags.h | 7 ++++---
>   accel/tcg/user-exec.c    | 4 ++--
>   2 files changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/include/exec/tlb-flags.h b/include/exec/tlb-flags.h
> index 357e79095c..e12cddf234 100644
> --- a/include/exec/tlb-flags.h
> +++ b/include/exec/tlb-flags.h
> @@ -27,12 +27,13 @@
>   
>   /*
>    * Allow some level of source compatibility with softmmu.
> - * Invalid is set when the page does not have requested permissions.
> - * MMIO is set when we want the target helper to use the functional
> + * INVALID is set when the page does not have requested permissions.
> + * FORCE_SLOW is set when we want the target helper to use the functional
>    * interface for load/store so that plugins see the access.
>    */
>   #define TLB_INVALID_MASK     (1 << 0)
> -#define TLB_MMIO             (1 << 1)
> +#define TLB_FORCE_SLOW       (1 << 1)
> +#define TLB_MMIO             0
>   #define TLB_WATCHPOINT       0

Slightly clearer:

   #define TLB_MMIO             0 /* Handled as INVALID */
   #define TLB_WATCHPOINT       0 /* Handled as INVALID */

or:

   #define TLB_MMIO             0 /* INVALID */
   #define TLB_WATCHPOINT       0 /* INVALID */

>   
>   #else
> diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
> index 7704e4017d..e4629b837d 100644
> --- a/accel/tcg/user-exec.c
> +++ b/accel/tcg/user-exec.c
> @@ -769,7 +769,7 @@ static int probe_access_internal(CPUArchState *env, vaddr addr,
>           if (page_flags & acc_flag) {
>               if (access_type != MMU_INST_FETCH
>                   && cpu_plugin_mem_cbs_enabled(env_cpu(env))) {
> -                return TLB_MMIO;
> +                return TLB_FORCE_SLOW;
>               }
>               return 0; /* success */
>           }
> @@ -804,7 +804,7 @@ void *probe_access(CPUArchState *env, vaddr addr, int size,
>   
>       g_assert(-(addr | TARGET_PAGE_MASK) >= size);
>       flags = probe_access_internal(env, addr, size, access_type, false, ra);
> -    g_assert((flags & ~TLB_MMIO) == 0);
> +    g_assert((flags & ~TLB_FORCE_SLOW) == 0);
>   
>       return size ? g2h_vaddr(env_cpu(env), addr) : NULL;
>   }

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

