Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E9FFC5AD5A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 03:36:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtzko-0007kz-Gf; Tue, 11 Aug 2026 23:35:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brad@comstyle.com>) id 1wtzkm-0007db-93
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 23:35:44 -0400
Received: from speedy.comstyle.com ([2607:f938:3000:8::2]
 helo=mail.comstyle.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_CHACHA20_POLY1305:256)
 (Exim 4.90_1) (envelope-from <brad@comstyle.com>) id 1wtzkk-0003Zu-EA
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 23:35:43 -0400
Received: from mail.comstyle.com (localhost [127.0.0.1])
 by mail.comstyle.com (Postfix) with ESMTP id 4hKYzS4KtRz8PbP;
 Tue, 11 Aug 2026 23:35:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=comstyle.com; h=
 message-id:date:mime-version:subject:to:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=default;
 bh=MRdc2732U33FDcXu/2rPgsjFBGap6qLYl9bfn02AQb0=; b=D8XmDxZlM33I
 s0f9IPRngJ9SVMaZyKwiaBIXKbn0chz2UI+cWviHbSkQfei0hjPU26eZAaYhjetA
 CHUZBd+6qpBevF2cTfObgvo4DSUbnB2ONG1ShyjGUUrk/KKHn/xG71O5Wac/RYn3
 aUdU27xcNR+Dxi9b1qJP2Q1soYIAfqE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=comstyle.com; h=message-id
 :date:mime-version:subject:to:references:from:in-reply-to
 :content-type:content-transfer-encoding; q=dns; s=default; b=f8G
 0GL+BUikZFqRK1U38WELZTDa2VWT5U6hqhvaBbv4386SOAchciMfVD1uFf+KwIx8
 S6XKuvz2xmgOjj0AyYYn2ZZsF/0Vw5zycmDN1EDikrAxFQp1RNAPwtlUEWlMbKMG
 rrbRmZuAweDRsW2qHhmhrnNSNtOFMzo7HOVfm28k=
Received: from [192.168.6.99] (dsl-173-206-41-176.tor.primus.ca
 [173.206.41.176])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: brad)
 by mail.comstyle.com (Postfix) with ESMTPSA id 4hKYzS3h8lz8PbN;
 Tue, 11 Aug 2026 23:35:32 -0400 (EDT)
Message-ID: <8dcd5fde-7d99-441a-86c2-5e293d474e23@comstyle.com>
Date: Tue, 11 Aug 2026 23:35:31 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/7] util/cpuinfo-aarch64: Detect FEAT_CSSC
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20260812003143.225228-1-richard.henderson@linaro.org>
 <20260812003143.225228-4-richard.henderson@linaro.org>
Content-Language: en-US
From: Brad Smith <brad@comstyle.com>
In-Reply-To: <20260812003143.225228-4-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f938:3000:8::2;
 envelope-from=brad@comstyle.com; helo=mail.comstyle.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On 2026-08-11 8:31 p.m., Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   host/include/aarch64/host/cpuinfo.h |  1 +
>   util/cpuinfo-aarch64.c              | 13 ++++++++++++-
>   2 files changed, 13 insertions(+), 1 deletion(-)
>
> diff --git a/host/include/aarch64/host/cpuinfo.h b/host/include/aarch64/host/cpuinfo.h
> index fe671534e4..c32c04dade 100644
> --- a/host/include/aarch64/host/cpuinfo.h
> +++ b/host/include/aarch64/host/cpuinfo.h
> @@ -12,6 +12,7 @@
>   #define CPUINFO_AES             (1u << 3)
>   #define CPUINFO_PMULL           (1u << 4)
>   #define CPUINFO_BTI             (1u << 5)
> +#define CPUINFO_CSSC            (1u << 6)
>   
>   /* Initialized with a constructor. */
>   extern unsigned cpuinfo;
> diff --git a/util/cpuinfo-aarch64.c b/util/cpuinfo-aarch64.c
> index 288074c08f..0b4f8a747d 100644
> --- a/util/cpuinfo-aarch64.c
> +++ b/util/cpuinfo-aarch64.c
> @@ -72,6 +72,7 @@ unsigned __attribute__((constructor)) cpuinfo_init(void)
>   
>       unsigned long hwcap2 = qemu_getauxval(AT_HWCAP2);
>       info |= (hwcap2 & HWCAP2_BTI ? CPUINFO_BTI : 0);
> +    info |= (hwcap2 & HWCAP2_CSSC ? CPUINFO_CSSC : 0);
>   #endif
>   #ifdef CONFIG_DARWIN
>       info |= sysctl_for_bool("hw.optional.arm.FEAT_LSE") * CPUINFO_LSE;
> @@ -79,10 +80,11 @@ unsigned __attribute__((constructor)) cpuinfo_init(void)
>       info |= sysctl_for_bool("hw.optional.arm.FEAT_AES") * CPUINFO_AES;
>       info |= sysctl_for_bool("hw.optional.arm.FEAT_PMULL") * CPUINFO_PMULL;
>       info |= sysctl_for_bool("hw.optional.arm.FEAT_BTI") * CPUINFO_BTI;
> +    info |= sysctl_for_bool("hw.optional.arm.FEAT_CSSC") * CPUINFO_CSSC;
>   #endif
>   #if defined(__OpenBSD__) && !defined(CONFIG_ELF_AUX_INFO)
>       int mib[2];
> -    uint64_t isar0;
> +    uint64_t isar0, isar2;
>       uint64_t pfr1;
>       size_t len;
>   
> @@ -101,6 +103,15 @@ unsigned __attribute__((constructor)) cpuinfo_init(void)
>           }
>       }
>   
> +    mib[0] = CTL_MACHDEP;
> +    mib[1] = CPU_ID_AA64ISAR2;
> +    len = sizeof(isar2);
> +    if (sysctl(mib, 2, &isar2, &len, NULL, 0) != -1) {
> +        if (ID_AA64ISAR2_CSSC(isar2) >= ID_AA64ISAR2_CSSC_IMPL) {
> +            info |= CPUINFO_CSSC;
> +        }
> +    }
> +
>       mib[0] = CTL_MACHDEP;
>       mib[1] = CPU_ID_AA64PFR1;
>       len = sizeof(pfr1);

You can remove the bottom chunk. Any OpenBSD release that has the 
ID_AA64ISAR2_CSSC
and ID_AA64ISAR2_CSSC_IMPL constants is also covered by elf_aux_info() 
which is the
first chunk.

ID_AA64ISAR2_CSSC_IMPL


