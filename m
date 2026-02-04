Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C28DEE8B397
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 03:35:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnTfM-0003nG-8m; Tue, 03 Feb 2026 22:34:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vnTfJ-0003n7-Jo
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 22:34:54 -0500
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vnTfH-0000aO-Ru
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 22:34:53 -0500
Received: by mail-pl1-x641.google.com with SMTP id
 d9443c01a7336-2a0d67f1877so42229125ad.2
 for <qemu-devel@nongnu.org>; Tue, 03 Feb 2026 19:34:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770176090; x=1770780890; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Av8r5uw4CR5AB8M4Nksy6GgCjSnmLjeRlg/59X3iEOA=;
 b=srIP1g5tLK0NnRv31xdTo+D87EXPxIQhDJgh2jXCnnU7CbC55/yEDtLa+bFeSCNcRR
 SWwB5h0Vvptzam5coRcqhtmfdwLNz7JPbDL2K3EaA5ZjGstQd2Zeplm//cns7DkkKIVh
 NdhAl59LQ/PpZVnO/oJJWWiozmI/eqjQ58DwESRlLMMz/0u7orBWY91joOuscnxp96vp
 PeahPi2A8DLkUWDo6fpUBlW35DO9dKsyYEWp7+YsIlJ1AOcvfFYyUuK2NiLWnXKui/8c
 6jAZiyib7yGxYoTUCTEATWB2jI6cR3u7cqiE2eUnOqR/7+hBQfl8qLNm68+Uyo50PTmC
 CBiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770176090; x=1770780890;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Av8r5uw4CR5AB8M4Nksy6GgCjSnmLjeRlg/59X3iEOA=;
 b=VZt4U4QrmhSqminfCDJG1a6cquY38C3/UdqRb6joiL54/m6T7PakjjhsXo9vXXauPW
 GiX5Txt57qnVw9MFdO0+NyCk0VpCSWUt0Fg6wnpPkO0GDwP94MafXvTtEwJxli68n3rO
 4x3u1WiH+YvLwvvXdY1MjcJJ/WkiVDtkMLah92blbxpiQgDf+YcoCIapWpYuFwx6RZqA
 zE9ExjHADT1xUwb/a73fMmo98dGWSzHSPjoZxrineIa4ou758vwkr5FjVM0Mv6k5+OBQ
 jub+Prw/7CRjux1fsOqjo53JoU/6LXWF8upWg8vJBXtZFAG63bp2xkkOaoV8oxq6n9On
 X7Bg==
X-Gm-Message-State: AOJu0YwzXc7Lw+8b/+Iv65CxPRv8HjqBGued3TgzfjwAf6g8vNFN095u
 EVwYqdO/Qt/qMnDcHECIxGWIZCf5a3k821Ee5Spo4W74zILjTPwmyLUviQVknsI4RleGjsxtp+5
 Gn1iHLJk=
X-Gm-Gg: AZuq6aKj1A+ZqrOqnVfQkdoxQdn9EbpVWCnW0J6upO2ABRnWIVvOpDEXdy45IQZ4S6w
 ZER40cnWR9bhw/QI8Z1rk7m894xzN63I4DcbDXQCrrcwzQUlrBZGZKhU9Ubmn7GnAOgnSWjbMrD
 CByYwXMWOO1ywtQDgbIAfg2oJA40vKdaFhzy8V5go6Ijbr2Vx8/WdAiVtdzSit4O0x4j02e8afN
 3IX2Rv8hxJl5g3oaNVnWkAzmBsybtkL/KqiPB7jpR5npYcbTjHt61M65uWB3QjesSZdFfHG3f/z
 OhFjsQKDlCsGbGGDwRpTNnN138SrPHJwl5egSlwUIpJvbnZeJiSquL0+9rN8Thd8MIVwFxdUlln
 50nyiIbHcuj2I8Fs+4KOs+BYET29UJg/GyatFd3tH0XKcrjW0tYYg8ncV9rcyl/RMks/Y2kgpUq
 LI76ekYPbWPeQmzryZRUuJrzzlAdI3OCbrHGzG8dDt/Ky24y5TmYaCQbSOOyNhzTVqpMGge5NcV
 Cp2HWdYbyINgmIT8IBEbwwQ4gGHB7cExCQH
X-Received: by 2002:a17:902:ced2:b0:295:888e:9fff with SMTP id
 d9443c01a7336-2a933d2fe37mr14937725ad.20.1770176090061; 
 Tue, 03 Feb 2026 19:34:50 -0800 (PST)
Received: from ?IPV6:2401:d002:dc0f:2100:1bc:fe1e:491:928e?
 (bg30dhzlx7lnyrq74wrz.ip6.superloop.au.
 [2401:d002:dc0f:2100:1bc:fe1e:491:928e])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8241d4b8c8dsm773891b3a.69.2026.02.03.19.34.48
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Feb 2026 19:34:49 -0800 (PST)
Message-ID: <28bcab83-0098-4e7c-b4c8-26c3bdf8a7f2@linaro.org>
Date: Wed, 4 Feb 2026 13:34:45 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] linux-user: Fix mremap() with old_size == 0
To: qemu-devel@nongnu.org
References: <20260201010436.5735-1-razvanghiorghe16@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260201010436.5735-1-razvanghiorghe16@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::641;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x641.google.com
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

On 2/1/26 11:03, Razvan Ghiorghe wrote:
> When old_size is zero and old_address refers to a shareable mapping,
> mremap() should create a new mapping of the same pages according to the
> mremap(2) man page. The MREMAP_MAYMOVE flag must be specified in this case.
> Previously, QEMU's target_mremap() rejected this valid case with EFAULT during
> the initial validation, before checking for the special old_size == 0 behaviour.
> 
> This patch adds proper handling for old_size == 0:
> - Validates that MREMAP_MAYMOVE flag is set (required by man spec)
> - Passes the call through to the host mremap()
> - Creates a new mapping without invalidating the original, with both
> beeing valid and sharing the same physical memory frames.
> 
> Tested with the reproducer from the issue on qemu-riscv64.
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3105
> Signed-off-by: Razvan Ghiorghe <razvanghiorghe16@gmail.com>
> ---
>   linux-user/mmap.c | 32 ++++++++++++++++++++++++++++++++
>   1 file changed, 32 insertions(+)
> 
> diff --git a/linux-user/mmap.c b/linux-user/mmap.c
> index 4bcfaf7894..b1a84eb60a 100644
> --- a/linux-user/mmap.c
> +++ b/linux-user/mmap.c
> @@ -1117,6 +1117,38 @@ abi_long target_mremap(abi_ulong old_addr, abi_ulong old_size,
>           errno = EINVAL;
>           return -1;
>       }
> +
> +    if (!old_size) {
> +        if (!(flags & MREMAP_MAYMOVE)) {
> +            errno = EINVAL;
> +            return -1;
> +        }
> +        mmap_lock();
> +        if (flags & MREMAP_FIXED) {
> +            host_addr = mremap(g2h_untagged(old_addr), old_size, new_size,
> +                             flags, g2h_untagged(new_addr));
> +        } else {
> +            host_addr = mremap(g2h_untagged(old_addr), old_size, new_size,
> +                             flags);
> +        }

This probably doesn't work with host page size != target page size.

The non-FIXED path doesn't work with reserved_va, as qemu needs to handle the address 
space itself for that case.  See the top of target_mmap__locked.

> +
> +        if (host_addr == MAP_FAILED) {
> +            mmap_unlock();
> +            return -1;
> +        }
> +        new_addr = h2g(host_addr);
> +        prot = page_get_flags(old_addr);
> +        /*
> +         * For old_size zero, there is nothing to clear at old_addr.
> +         * Only set the flags for the new mapping. They both are valid.
> +         */
> +        page_set_flags(new_addr, new_addr + new_size - 1,
> +                       prot | PAGE_VALID, PAGE_VALID);
> +        shm_region_rm_complete(new_addr, new_addr + new_size - 1);

Don't you need to copy the shm data?
Tracing all this through linux/mm/mremap.c is non-trivial...


r~

