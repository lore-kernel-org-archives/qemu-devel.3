Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2183C43458
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2026 13:24:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfHOx-0007zQ-Pe; Thu, 02 Jul 2026 09:24:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wfHOv-0007yd-16
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 09:24:21 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wfHOs-0002nH-B0
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 09:24:20 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 662D0X9L416428
 for <qemu-devel@nongnu.org>; Thu, 2 Jul 2026 13:24:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 IZ/fe4xd/KZyQiYVIoDSRNpxH0woTIq8PEikeIXwRzA=; b=mlPXvRQzYN0GZjoe
 V+b2hMgxMrBzAJTgHoJyNH1G6ZsddeeAt2ye4+uh4KmbAxSJQOdRyDIC9y73nNMZ
 v5BqoC/CN5sI0UvcstBdhzP+orHUXqEQvzATZIJvrExefSHvb53jUWXPpZstDKqZ
 49M4Gu3obDJ0s2NXBhOYi5n9TaSt2oAMaonLJ2cKGNeELVA+ikmGFOoc1Vu/SqYY
 mTuPdo1mz89B++SnZiqxmfaEjFvpa32rIuvSzGe1KeTFzueF7H1VEkwMWsKOEWS6
 gHJim1jgXu9JYa2PhM5jhRVczijE0Ofrib3nFRbZVj6X7lngjlSCrsjYHrt4Li6/
 dtLOBg==
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com
 [209.85.221.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f5n940xc0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2026 13:24:16 +0000 (GMT)
Received: by mail-vk1-f198.google.com with SMTP id
 71dfb90a1353d-5bbdd424707so415312e0c.1
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2026 06:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782998655; x=1783603455; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=IZ/fe4xd/KZyQiYVIoDSRNpxH0woTIq8PEikeIXwRzA=;
 b=R8EFNnraYPUMKkw8eU1hVtulAi9Mz1PMEL8Bwx+olHqDkBwKjYtH5XiM32W1fZSaWa
 EeEJwpKOjQk3EkpUckBY69vAHyyHuMERt3Y4OO/fJt1unMn/7Lwuqa1x8DyKPfleHg7U
 NAXS7HrLl4EiBQeoep0wGQ/5bSkRrBnCFZ2YPcrsLb33oBpCBGYm6RqbBvFMJwAy/38b
 cwvs42HDCTOrpCpdLfXQKroh8nzocoVUPGH/aULqp9DodTR8r6+6/FJpu/XJtSPU+f/i
 s59JjmJTjfb5Q3zusOeXxox/2Kj5HUIxkKnWfIAyozi5d5rtByQxtanX9Uw4evybkgRr
 aDyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782998655; x=1783603455;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IZ/fe4xd/KZyQiYVIoDSRNpxH0woTIq8PEikeIXwRzA=;
 b=XKadGHZfjQyLrjnHpRO5uB2AnopYWcUuG7wz5C2ZwiKO+lHemmNH3K1YwWyVRD6V0D
 WIcpruf+LV4RzhuHujkgOX5GQaja0AM38cK6W/OY6aq+YjqNH8pkkA4gndKeZ013ix//
 KlVBgYhFr2FGOkYAE9ZiIwxw4UorqFtczjeil4HB5AXeRr/w1dxclE3W3jCGgIQib9ti
 Z6YKNUPWo2996UXZjJp1q1T27Gt0UKzutxPCQNJtjBYYrWqpXWaCzdoXAPTfeNB2VY+Y
 eh/x1wRwcx1MKtKcq0AecmGxu/Vn3cl6UelymPhal5ecdg0RLyDzvkiADnvvx9Vd7Ezb
 gzYA==
X-Forwarded-Encrypted: i=1;
 AHgh+RqVC+rt6UPjGfH3QTPvrdECKWwtFrBS5t6DngAdP69nB6kQlmUZQj++AP98m5nKaojIXX/HYSgG76iX@nongnu.org
X-Gm-Message-State: AOJu0Yz8GfmxleANPTaV9lTwanuSrGwDFTIflqX2vrKT/8doG0jNy5JA
 6DalYwL/soOEHRQABmj0ZC0aeUaAO8jCu1KIw2Gk2BU0vVyV5FGEOfGUr5LrSdVnlBk6x20NIb1
 WXSG7XaTpDppb1fjNP/7V0wUSq+z8Gg+GhPNtFR1HIkkJEdzWoPvBQtpY7A==
X-Gm-Gg: AfdE7cmWxSfIkxLxDx1fFqzC9XHdhtUTkCSEz0atNdhDlTdNO5WuDfREYeUxqHdN6iH
 CaDIPIQktnFPh8fwziGPqbHBFfl+05sNjIKM4wHGlMlxG9Lzu66/4DEkSmbnUOrDx3OwncMLh4B
 if0v03M3vAWuyexO9bUiWss5kOEWlXahlggVlfqoVFy4C+/yVfhfXdj9Mzufo4AR2eAfRamet/X
 DAXDFciNphd3sVHALPb39wQJQsWZFOUsQHVWjcBz1Mrop99RH7z1XixXGLmCDND75JeBXkqMdC2
 xB8mjr6u/1yl0tiec8BCWOsoY3EvudmheEyRhATFCK87IiWTBoi9D3J0IcJXJLIO/i3H0uVm6DU
 TML35OR+9zt0qZQ82a4QpmUZak3BKYik2Lz/85vU1MexG
X-Received: by 2002:a05:6122:d26:b0:575:352f:eac0 with SMTP id
 71dfb90a1353d-5bddf5f181cmr2162282e0c.7.1782998655525; 
 Thu, 02 Jul 2026 06:24:15 -0700 (PDT)
X-Received: by 2002:a05:6122:d26:b0:575:352f:eac0 with SMTP id
 71dfb90a1353d-5bddf5f181cmr2162254e0c.7.1782998654728; 
 Thu, 02 Jul 2026 06:24:14 -0700 (PDT)
Received: from [192.168.68.106] ([189.79.21.40])
 by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-5bdec4ab835sm856660e0c.2.2026.07.02.06.24.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Jul 2026 06:24:14 -0700 (PDT)
Message-ID: <e83e0798-7f7a-4d20-8e6f-9c716719a8d3@oss.qualcomm.com>
Date: Thu, 2 Jul 2026 10:24:10 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 17/33] cpu: Move BREAKPOINT definitions to
 'exec/breakpoint.h'
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Zhao Liu <zhao1.liu@intel.com>,
 qemu-ppc@nongnu.org, Richard Henderson <richard.henderson@linaro.org>
References: <20260630220100.1289-1-philmd@oss.qualcomm.com>
 <20260630220100.1289-18-philmd@oss.qualcomm.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260630220100.1289-18-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDE0MCBTYWx0ZWRfX4o3AEnT0Aho8
 U4/RUpYURmw8UpdOvSnxZEOglaserMlVP8mVFuTllfsfeSssLFva/WR+EJ8iDK7VL95JrcbPpbD
 TcfGN90vSsnozt2j+A9Q4g63MapkqEOL2+2D5LczHqMJxUCnrHw93sbUzW2E+bUBOXEm8s77UXZ
 apxuMPhx0lL5/H+oiSrO2a7BgDUFKgwf10V5hBQ6Wnwcj+noaFXFzKWNLyz3kSyzME5bBC1rfZk
 wXqf2P0aGC26hpDkjvaC0EsLLIQ/oy2tIvnoVEkWdfbaqDXVPK6sQ339V7wbCBT7aMcOFuRd8kT
 qWcSLXr7l/H2cVZv9uIK9PmYjm09sPgCEi723aA04bd6Rdr4CuPWNYO9KqsmFvP4/AzXu+jVxL4
 eAQe2fe06dy3rxQhcyd5QfjBHbPVp+NGtD7r2BvnTVFVffe9Bj8HY1DAej0F6VaXbk/rG3HKuzx
 GHgbbaD9HsGMnAN8nJw==
X-Authority-Analysis: v=2.4 cv=Lv+iDHdc c=1 sm=1 tr=0 ts=6a466680 cx=c_pps
 a=1Os3MKEOqt8YzSjcPV0cFA==:117 a=sHJf4AwOIoU3qjeHFPlg6Q==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=6gJ4CK2oKd2TxSMj2O8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=hhpmQAJR8DioWGSBphRh:22
X-Proofpoint-ORIG-GUID: HhbK7olR0LSW9iydwlYIxbOJpctdJ70M
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDE0MCBTYWx0ZWRfX+3M6svYSrol4
 w7hcQAd9fkdXIvPpWpYAHlOXaMYl8yj2lKKs6ozV4wgVO0ddJmxDSamLSnuM+Shh37OVZXRMEXE
 5V8TSaPptLRt+GwvltG9MXQV1k/TxLQ=
X-Proofpoint-GUID: HhbK7olR0LSW9iydwlYIxbOJpctdJ70M
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 spamscore=0 priorityscore=1501 clxscore=1015
 bulkscore=0 suspectscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607020140
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
> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> ---

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

>   include/exec/breakpoint.h | 14 ++++++++++++++
>   include/hw/core/cpu.h     | 14 --------------
>   2 files changed, 14 insertions(+), 14 deletions(-)
> 
> diff --git a/include/exec/breakpoint.h b/include/exec/breakpoint.h
> index 95f0482e6d0..cc6fedd09fe 100644
> --- a/include/exec/breakpoint.h
> +++ b/include/exec/breakpoint.h
> @@ -12,6 +12,20 @@
>   #include "exec/vaddr.h"
>   #include "exec/memattrs.h"
>   
> +/* Breakpoint/watchpoint flags */
> +#define BP_MEM_READ           0x01
> +#define BP_MEM_WRITE          0x02
> +#define BP_MEM_ACCESS         (BP_MEM_READ | BP_MEM_WRITE)
> +#define BP_STOP_BEFORE_ACCESS 0x04
> +/* 0x08 currently unused */
> +#define BP_GDB                0x10
> +#define BP_CPU                0x20
> +#define BP_ANY                (BP_GDB | BP_CPU)
> +#define BP_HIT_SHIFT          6
> +#define BP_WATCHPOINT_HIT_READ  (BP_MEM_READ << BP_HIT_SHIFT)
> +#define BP_WATCHPOINT_HIT_WRITE (BP_MEM_WRITE << BP_HIT_SHIFT)
> +#define BP_WATCHPOINT_HIT       (BP_MEM_ACCESS << BP_HIT_SHIFT)
> +
>   typedef struct CPUBreakpoint {
>       vaddr pc;
>       int flags; /* BP_* */
> diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
> index 60a23d6f38b..b1df615792a 100644
> --- a/include/hw/core/cpu.h
> +++ b/include/hw/core/cpu.h
> @@ -1138,20 +1138,6 @@ void qemu_init_vcpu(CPUState *cpu);
>    */
>   void cpu_single_step(CPUState *cpu, int enabled);
>   
> -/* Breakpoint/watchpoint flags */
> -#define BP_MEM_READ           0x01
> -#define BP_MEM_WRITE          0x02
> -#define BP_MEM_ACCESS         (BP_MEM_READ | BP_MEM_WRITE)
> -#define BP_STOP_BEFORE_ACCESS 0x04
> -/* 0x08 currently unused */
> -#define BP_GDB                0x10
> -#define BP_CPU                0x20
> -#define BP_ANY                (BP_GDB | BP_CPU)
> -#define BP_HIT_SHIFT          6
> -#define BP_WATCHPOINT_HIT_READ  (BP_MEM_READ << BP_HIT_SHIFT)
> -#define BP_WATCHPOINT_HIT_WRITE (BP_MEM_WRITE << BP_HIT_SHIFT)
> -#define BP_WATCHPOINT_HIT       (BP_MEM_ACCESS << BP_HIT_SHIFT)
> -
>   int cpu_breakpoint_insert(CPUState *cpu, vaddr pc, int flags,
>                             CPUBreakpoint **breakpoint);
>   int cpu_breakpoint_remove(CPUState *cpu, vaddr pc, int flags);


