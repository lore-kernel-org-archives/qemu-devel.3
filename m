Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BF64C43327
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2026 13:17:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfHIi-0002lt-Vq; Thu, 02 Jul 2026 09:17:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wfHIh-0002fF-9l
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 09:17:55 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wfHIf-0000Bf-J8
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 09:17:55 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 662D0Zew406353
 for <qemu-devel@nongnu.org>; Thu, 2 Jul 2026 13:17:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 cQ1mXb8WBc4w2USwc7Wk2mXpC32vGkJp9JOfd53UoyU=; b=jTbYKI7PJIiiZUuf
 rrgjHTw5NUDBbZozPgWjLL2Zk3YpvUlkotg+4NIUZW4+eO+NZN9Q2lKBRhhU+cJT
 oewbNtC/eHFh2uaw6Pe6R/btFML1NOv1rPq7N+gBLEnB5k/+18ANSHLKny5KvQPn
 yWOohV+liULR8Hbwpmz/3mAPAjEbYFJq3l8CmA3pONMQFhkd/uXVLtAUobCYsgdo
 IyMnpogF06PQr/lHX2Lx/8jqjZFnSa3RdaPxIjhOzLT9vkZ7Qelsxfy/k82JfoZO
 17pKJNzIX4zvbA23XFDO9bIn3aEMJHjTM6faiMImTdXpYZPX2CsGVdx063YQSMjs
 2f6MZQ==
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com
 [209.85.221.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f5h98hv7g-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2026 13:17:52 +0000 (GMT)
Received: by mail-vk1-f199.google.com with SMTP id
 71dfb90a1353d-59ec1fcd5aaso1980458e0c.2
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2026 06:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782998272; x=1783603072; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=cQ1mXb8WBc4w2USwc7Wk2mXpC32vGkJp9JOfd53UoyU=;
 b=Y3qOt9qGmGc1cqGEPd0XV+0Gt88HSAScNJNCCv4J227h2SvZTj8mirVofT35/ewqZI
 GjkhlJf9z6mo+yNUB1qlIJ56iRpxsfx5tXhSziwOKiYjgyDQqPEeusiqht3FjQ60nGhO
 56hZNbHtUHW1QIEsS+YMcg3+hOjEttjRBRrltxfYMPKY0r56+86xXwgfZzIShIi2sqZk
 F1R56eqDwDtq4xjQzhapw/jcyB/Vv0B7RUbHNBASDYo62KqgxPY2DRgxhEMlluy7jPKB
 DA5vSzdO9hxtcsWLno0qOlw4ZM1E/cgX/Oj6oJgS/MweHiRdHUhc4eYumCEvlRKgaa/r
 piyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782998272; x=1783603072;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cQ1mXb8WBc4w2USwc7Wk2mXpC32vGkJp9JOfd53UoyU=;
 b=RkF/cs21y/Wh5OdEgX7tM7cbBcz0E5W0HaTbYlXfzyYLEiqrDUtLFCJQoyGGbOykel
 sWThWvYLP0DO3i3h7hbO0rGxW1qVwiYbXGj0PtS1/OAoOJqtOJwLWVeU8R0GHIrMNPct
 s9LZz2CmQHbWvIDa+vVUwp9LQzFjr4RqZgOMurefwRRDAoB0vwgJ5lYqJFOOHJtGPl/6
 flKpwfGsjMWakvkATNfAwEh26bn4Y6qr6D3+ADw+fvudeMgvo87WTr/hBUquRKwdXkk+
 zK7grjCDpcxia6IKku2cfwOqdpsmKmOApx370xGLr1XLkQSq+QWGCHDBKkNiNCLYQpm0
 a+OA==
X-Forwarded-Encrypted: i=1;
 AHgh+RqsY1JFNjmbfIWwDv0IUsOHDgSHNdhNnNsQdODe8cMiPOgKjBshxCubpRFKvYiU8Bj+jbXIaCR1m4cP@nongnu.org
X-Gm-Message-State: AOJu0Yx2SiFb5mngg5GwdqObVvbPP2ak2inm3cspWAXgmnySQKs9yzPJ
 O5EvcO45grbDzKcbAU65E5/MPq7Yare9m/PBeC4pNeXTAbl4WJmYcMUYvxC/7u+3vaNgpIAzc2a
 zlUXRLLa9dZ1nRsu1Ony8hkSMijYOTgHUXq8qUvs5pYM+nayu500t4QobvA==
X-Gm-Gg: AfdE7clCo+fjIuDyTUNkz8SSSC2pL4BMEdRj+Gp+ceZdsUKdhybhDN2FUsMy5sgrRad
 JPXigpW5f7D1JZpqD5f37M3uQjwmjkFJCqjc7tJ6DoDKLZyudhxbZqatH6ISWzF1HZqei7A9zkP
 5ZwEmXexhVgV7IPqQRw6rrlsfpaeBUyJtUkhotOJGxsZ3EZ3YrV0VB1gO0Ii4dTgnrTApAXrJRk
 p1xUirdsx0u4yTlCCxkcC591mNC5sotOHQHKOo/8OEOI0sNFGXBJEB3c/2cPIOyRDj5NYaf0Y11
 kLH/zUf0tMsLA8UtVAvWPANC/3NCwYiijNBlN4XDm2/1sqhIBCVzplEAALU5wyp9iLyniZHLV0l
 veUxY1M7JgyoAIrJZZjmFNWxcMr2Q13Mv5/M1j9o9cl+N
X-Received: by 2002:a05:6122:3b8b:b0:5bd:a6e9:711b with SMTP id
 71dfb90a1353d-5bde3cefdfcmr2197811e0c.13.1782998271817; 
 Thu, 02 Jul 2026 06:17:51 -0700 (PDT)
X-Received: by 2002:a05:6122:3b8b:b0:5bd:a6e9:711b with SMTP id
 71dfb90a1353d-5bde3cefdfcmr2197777e0c.13.1782998271353; 
 Thu, 02 Jul 2026 06:17:51 -0700 (PDT)
Received: from [192.168.68.106] ([189.79.21.40])
 by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-5bdec83faaesm865620e0c.18.2026.07.02.06.17.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Jul 2026 06:17:50 -0700 (PDT)
Message-ID: <c3416e56-20b6-43e7-8de5-45b22495aa9f@oss.qualcomm.com>
Date: Thu, 2 Jul 2026 10:17:47 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/33] accel/tcg: Restrict tlb_protect/unprotect_code() to
 TCG
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Zhao Liu <zhao1.liu@intel.com>,
 qemu-ppc@nongnu.org, Richard Henderson <richard.henderson@linaro.org>
References: <20260630220100.1289-1-philmd@oss.qualcomm.com>
 <20260630220100.1289-4-philmd@oss.qualcomm.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260630220100.1289-4-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 9MMw9vfdt1mxGoKrFPVsbAr2O02RlEC9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDEzOSBTYWx0ZWRfX7nTWFouY906k
 Xh1MKqPtjHOw7JA+dXLde9FwX/4KtPl6g7a2nWf4ElwWxOuTVcv4iGKFJai0oMQcw4UmA+NKFJ8
 +09xNLvbF8BGebE7Vp81c5XrzXdPHCmQM+1I1mhVIq0v32pYUwzgu/aXFQ++e2DVaLH1z8zJOWr
 EXdHEcVPIntYG5LBWrCb7CS/BhHnzKoW6/KSR9T1TagLC1IgMvtUYOL6EKolUb0z1pp4ILvyxor
 b7nMEPDzkpQaOOEzdMAE6JN6/a10fHWWfEX/6dsuvsW4vEVa7gjcbJtP5IBkI9UETogWepdqzKK
 OMI3Wtuzbt1Ysvzmwf8ro9V5Y67LbXCQy3JWamG/wBSAFpsgNVp9VXudHNoNUOR86L8MrMV/t+M
 cXXyi4q5uSZGRvjQ9MDpSdFG5VQzxz/uSL40/hbPgFBDLLNV8hA7/Qg/MVPD8h7glnjaWXUw/BR
 QxkvbRz6VXzux0Z+Q8A==
X-Proofpoint-GUID: 9MMw9vfdt1mxGoKrFPVsbAr2O02RlEC9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDEzOSBTYWx0ZWRfX5MyzcZm4ms8a
 ngsY1cmc7DjL018e2Quql8HNRQuLrq9IvUAGzxohOJPjvITCVa7ilBGJ3iUuoFPp+tGijkLPiFo
 dvA0b6KWp1gEMtWN6gDb3JJpiK0QduU=
X-Authority-Analysis: v=2.4 cv=bdFbluPB c=1 sm=1 tr=0 ts=6a466500 cx=c_pps
 a=+D9SDfe9YZWTjADjLiQY5g==:117 a=sHJf4AwOIoU3qjeHFPlg6Q==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=-Gn-N_3N14VAyuSf37IA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=vmgOmaN-Xu0dpDh8OwbV:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 impostorscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607020139
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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



On 6/30/2026 7:00 PM, Philippe Mathieu-Daudé wrote:
> Both tlb_protect() and tlb_unprotect_code() are only used
> within accel/tcg/. Avoid exposing them to the whole code base,
> declare them in a new "system-page-protection.h" local header.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> ---

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

>   accel/tcg/system-page-protection.h | 17 +++++++++++++++++
>   include/exec/cputlb.h              |  8 ++------
>   accel/tcg/cputlb.c                 |  3 ++-
>   accel/tcg/tb-maint.c               |  1 +
>   4 files changed, 22 insertions(+), 7 deletions(-)
>   create mode 100644 accel/tcg/system-page-protection.h
> 
> diff --git a/accel/tcg/system-page-protection.h b/accel/tcg/system-page-protection.h
> new file mode 100644
> index 00000000000..52896c6d24a
> --- /dev/null
> +++ b/accel/tcg/system-page-protection.h
> @@ -0,0 +1,17 @@
> +/*
> + * QEMU page protection (system emulation)
> + *
> + *  Copyright (c) 2003 Fabrice Bellard
> + *
> + * SPDX-License-Identifier: LGPL-2.1-or-later
> + */
> +#ifndef SYSTEM_PAGE_PROTECTION_H
> +#define SYSTEM_PAGE_PROTECTION_H
> +
> +#include "system/ram_addr.h"
> +
> +void tlb_protect_code(ram_addr_t ram_addr);
> +void tlb_unprotect_code(ram_addr_t ram_addr);
> +
> +#endif
> +
> diff --git a/include/exec/cputlb.h b/include/exec/cputlb.h
> index 3a9603a6965..f7f7020382d 100644
> --- a/include/exec/cputlb.h
> +++ b/include/exec/cputlb.h
> @@ -24,14 +24,10 @@
>   #include "exec/hwaddr.h"
>   #include "exec/memattrs.h"
>   #include "exec/vaddr.h"
> -#include "system/ram_addr.h"
> -
> -#if defined(CONFIG_TCG) && !defined(CONFIG_USER_ONLY)
> -void tlb_protect_code(ram_addr_t ram_addr);
> -void tlb_unprotect_code(ram_addr_t ram_addr);
> -#endif
>   
>   #ifndef CONFIG_USER_ONLY
> +#include "system/ram_addr.h"
> +
>   void tlb_reset_dirty(CPUState *cpu, uintptr_t start, uintptr_t length);
>   void tlb_reset_dirty_range_all(ram_addr_t start, ram_addr_t length);
>   #endif
> diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
> index 6e66f3c6e93..7f7c208ba12 100644
> --- a/accel/tcg/cputlb.c
> +++ b/accel/tcg/cputlb.c
> @@ -1,5 +1,5 @@
>   /*
> - *  Common CPU TLB handling
> + *  Common CPU TLB handling (system emulation)
>    *
>    *  Copyright (c) 2003 Fabrice Bellard
>    *
> @@ -47,6 +47,7 @@
>   #include "tb-hash.h"
>   #include "tlb-bounds.h"
>   #include "internal-common.h"
> +#include "system-page-protection.h"
>   #ifdef CONFIG_PLUGIN
>   #include "qemu/plugin-memory.h"
>   #endif
> diff --git a/accel/tcg/tb-maint.c b/accel/tcg/tb-maint.c
> index c33dbf65e7f..4313864d2c5 100644
> --- a/accel/tcg/tb-maint.c
> +++ b/accel/tcg/tb-maint.c
> @@ -38,6 +38,7 @@
>   #include "user/page-protection.h"
>   #define runstate_is_running()  true
>   #else
> +#include "system-page-protection.h"
>   #include "system/runstate.h"
>   #endif
>   #include "trace.h"


