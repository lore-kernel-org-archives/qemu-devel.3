Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5D80CA0EC0
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Aug 2025 12:17:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1unymv-00058V-9k; Mon, 18 Aug 2025 08:16:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1unymj-00056U-Sq
 for qemu-devel@nongnu.org; Mon, 18 Aug 2025 08:16:26 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1unymh-0003cz-8e
 for qemu-devel@nongnu.org; Mon, 18 Aug 2025 08:16:21 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-45a1b0bd237so32166375e9.2
 for <qemu-devel@nongnu.org>; Mon, 18 Aug 2025 05:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755519377; x=1756124177; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ERpkagCbSCS/A3OJnIbkpFDQlyt+R0t1slmUxxCe0/k=;
 b=YTWhMmXMnCJfjcCNfMQJH3Lcep7iYqyZw9LnhgfHesWSVrFfL5VFchMP6sVidwNALa
 9FhM3sBUOhtTiUx4Vdv/WHHmm8k88vzAAqKvKTF6EOhsDLEsMZyxZo4Utu4mbOPe5viS
 +SsQWC7tbjZTsB/6GFVXMFhx4Gr/aylFLyox5QpxITXEA9wZR++Ihio0b1ed5xGJPLAc
 dV6B3cSAyHVUpocE4YSqbCV3UlFC98Gu6Tfzc4Ed4KH1XhxoQCvRuS9eXNKEOLDl0FlM
 WiLxQH6jdI8eszIKFBRxbMGE+XY3Xbaql9f2AR+izj8JkGA/LuFI2TdZCcKNxOB8eRLD
 3HkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755519377; x=1756124177;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ERpkagCbSCS/A3OJnIbkpFDQlyt+R0t1slmUxxCe0/k=;
 b=U+5WZNPgjBod5XzUduFiusnokC2iY4KX5Og65YqdXkjabjxtQGsKWq5uoGJgdSCd/0
 CrOB0RYPA3etjlEyuN7oCgZvAEAKqy4qQSJsnsI+cExALwntgmYF5VULpiCh4eF1mCqr
 /YhsRw+C+8EZoigF0kmnkKz2aQbyaAwFWM6SSHvPE7U17GfhJo/OxIHzvdvlicxhoctL
 za3MlwijfMZ0kGoxLJOCSXmnQLnEZZYWJiWdXhmn7NAE7xQD86VbP/KMFlJ1JbWZyV36
 896pZrYgRZtEWAi/ARUY/lWpjOs5CyIQK4pmvdrefrYdEfvFgyfs5cDx2SssKTnReNzk
 2Okg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVJwAyiygHKTUjN8Xg+7+jv3HO9tXzd/8la7yfR1Ppcnxlov+XbMm+V8HRHb1cplI58HD1vRozptW3/@nongnu.org
X-Gm-Message-State: AOJu0Yz6ZzWBshwOXyu1jZFQtuzzCC5MplXAa9onFzQ/F18wmPVRuZJV
 +vyN5mrOF+2MbYle0eLDctEK+s9/A4IToxrW5FF9hHd1ZHRuFOB4MBeGDulir/+41yg=
X-Gm-Gg: ASbGncu1+9axBmu4h0jWCaFlPg+YZ4Vf3bDID7zncYDbcixh3zZeV32GgZtIvKSKWgc
 PhahCsYhAUT2rNZIYnOhUnqQ6BBDbpKWBmkonVApeqGgTUSTmjSRmOK2nPmm066sjtyOXrlPEUU
 yiISLD+5R/oksPwu5cQ31JaVeKbOQiK8pnfhvn9XX44n97+AolicEQJ5xaCNVDkF2C0LrLkQZeC
 yZ04+NfFABXWzzjUUUiCvyITDsGL4qeL3kyeftDvPQ9A4JA8bnLK3KgePxMwFXzENOQ5BGz8uuJ
 g1B+d7Auof9j3E8Y/lD3Bama/hJgyY55qyY+E10tRkCeOgiP3IDTP/jY5Zsk6V3vk48LY1WLjbQ
 Y3mOMTZ06h0Y0qynFMbLlNEa2AnYj6WCHOcPvKVlAENdRAb4Tn2z2ZvuxDX1FfV8pvQ==
X-Google-Smtp-Source: AGHT+IFVZiGjJXjG59JVWv15y5oe5tJK1WV7M9tlkXPgJIDuQSsxzOhS3s+zft7Te2QeFegO8HVJzg==
X-Received: by 2002:a05:600c:310c:b0:459:dc81:b189 with SMTP id
 5b1f17b1804b1-45a218648e7mr90453955e9.31.1755519376523; 
 Mon, 18 Aug 2025 05:16:16 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3bb64c30c45sm12760626f8f.16.2025.08.18.05.16.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 Aug 2025 05:16:15 -0700 (PDT)
Message-ID: <c92d983d-0b89-467b-b5e2-b09fe61ff5b9@linaro.org>
Date: Mon, 18 Aug 2025 14:16:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] i386/tcg/svm: fix incorrect canonicalization
To: Zero Tang <zero.tangptr@gmail.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, richard.henderson@linaro.org, eduardo@habkost.net,
 Lara Lazier <laramglazier@gmail.com>
References: <CAAXNugBwiRuwiNHeuBV5U+HyrSisPSN-HL_7n6Pqc7oAOTX6Pw@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAAXNugBwiRuwiNHeuBV5U+HyrSisPSN-HL_7n6Pqc7oAOTX6Pw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Zero,

On 6/8/25 09:58, Zero Tang wrote:
>   Replaces "long" with "int64_t" during canonicalization.
> 
>   ---
>   In Linux GCC, "long" has 8 bytes. However, in msys2 GCC, "long" has 4
>   bytes. In this case, canonicalization would set all high bits to 1 when
>   the segment base is bigger than 0x7FFF (assuming 48-bit linear address).
> 
>   This is why QEMU-TCG in Windows cannot boot a bluepill-like hypervisor
>   in UEFI, in that the guest IDT and GDT bases are above 0x7FFF, thereby
>   resulting in incorrect bases. When an interrupt arrives, it would
>   trigger a #PF exception; the #PF would trigger again, resulting in a #DF
>   exception; the #PF would trigger for the third time, resulting in
>   triple-fault, and eventually causes the shutdown VM-Exit to the
>   bluepill hypervisor right after it boots.
> 
>   In summary, this patch replaces "long" with "int64_t" in order to enforce
>   the canonicalization with 64-bit signed integers.
> 
>   Signed-off-by: Zero Tang <zero.tangptr@gmail.com 
> <mailto:zero.tangptr@gmail.com>>
>   ---
>    target/i386/tcg/system/svm_helper.c | 2 +-
>    1 file changed, 1 insertion(+), 1 deletion(-)
> 
>   diff --git a/target/i386/tcg/system/svm_helper.c b/target/i386/tcg/ 
> system/svm_helper.c
>   index b27049b9ed..1ccfccf419 100644
>   --- a/target/i386/tcg/system/svm_helper.c
>   +++ b/target/i386/tcg/system/svm_helper.c
>   @@ -49,7 +49,7 @@ static void svm_save_seg(CPUX86State *env, int 
> mmu_idx, hwaddr addr,
>    static inline void svm_canonicalization(CPUX86State *env, 
> target_ulong *seg_base)
>    {
>        uint16_t shift_amt = 64 - cpu_x86_virtual_addr_width(env);
>   -    *seg_base = ((((long) *seg_base) << shift_amt) >> shift_amt);
>   +    *seg_base = ((((int64_t) *seg_base) << shift_amt) >> shift_amt);\

Alternatively:

          *seg_base = sextract64(*seg_base, 0, 64 - 
cpu_x86_virtual_addr_width(env));

>    }
> 
>    static void svm_load_seg(CPUX86State *env, int mmu_idx, hwaddr addr,
> 
>   ---
>   base-commit: e0006a86615baa70bc9d8b183e528aed91c1ac90
>   change-id: 20250806-fix-tcg-svm-canon-adbea9508073
> 
>   Best regards,
>   --
>   Zero Tang <zero.tangptr@gmail.com <mailto:zero.tangptr@gmail.com>>


