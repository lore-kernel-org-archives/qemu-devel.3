Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC915C27C4F
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2024 04:31:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKVvf-0000pG-GX; Fri, 21 Jun 2024 00:31:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sKVve-0000n2-1F
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 00:31:14 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sKVvc-0001EV-3O
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 00:31:13 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1f9bf484d9fso12920725ad.1
 for <qemu-devel@nongnu.org>; Thu, 20 Jun 2024 21:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718944270; x=1719549070; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=iHQ90UlNrJNrsPqy+QQJgul1ZqjYrwlrZlxIUknpqJY=;
 b=eVgTWZPEb3si3Y1OQrIv2O0MslcKvS9PBbBWNrJl6URHcrt/JkCTfSexAW1bXq7Qf1
 Hh4aeMtYrjywssaPr1OxShzfFN0etxjStOED5UR92wYC4t9t+GEPF5J5QU67K0hWRIbD
 QDQxXuO3QyFU6C4i6lDK1Ix4ZdB7sEtL0Hzc+aBQ9HOk3sUArYB7mk1lH4qj3TdjU2Hn
 ji8WItQVq16GIWmUJRuMbW3H9ZMWLvue2tdO/Q9kM2aYoz/80XB2ijaKTt8Ljlipg1Lg
 SsU/FUAuPCAMO0gP/iQw7E25Bv//NdOclReuhWpeFCMJ8TV3sF11HB7mZSJUj8Gf5iEw
 4MeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718944270; x=1719549070;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=iHQ90UlNrJNrsPqy+QQJgul1ZqjYrwlrZlxIUknpqJY=;
 b=wq9MlpO8tzMvPhQviZ55oCgp0iZI+jd9MjvHAQWba3ugvQoGdSx5Jej6kq0YWXy0AN
 lffu30RSsdVq5udUIvglGG275TsSp60xcAJ8JyA1eEUYb8QVznrVUyqyYCE0aG/ZFUhf
 GL1zYrp/zsxvMa9UK2SaJylGfiFaPSMabWTQaJ3AVk03zyJxWJFEgEKN8Rb5BwO1OPp9
 phG2rTQK8zx4gHjARfkV4LLam/XGM4UzcCt/IY29/FbqnoVwsXDFl8Z4cTH6WWGBDvKK
 RMBOoJoIIIP6fgIKSpT/IOUhrrMapEgJecFGqIBO/1uIX4n7Um1aM6cYeR8k7ETElPAj
 RotA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVU7mT0YcWvkQ321B35+jJMAYKy+TNGukekr2ZRm19jz/rcfwjRXg6sllq5GYzGXYAArMBUPg66KDJpvwVvLW5bpaz1zYw=
X-Gm-Message-State: AOJu0Yztih8g052+PHe2YILSQrbI+N3ofUa68MGgllsOxbEZx3Lohgte
 sIo8N8RsnWe0GbcXBIMz5OEKJHy/cTmnuuLc2ODDXQ9PNYbb43+L5vtuNoxyrcc=
X-Google-Smtp-Source: AGHT+IHs1v6RDb3T+mJ/a+4q9zcYAKep5uiW68tL1mttEm4+28g4TePss3WlTyEg76YB7HnsxfEBMg==
X-Received: by 2002:a17:902:ec83:b0:1f7:1bf3:db10 with SMTP id
 d9443c01a7336-1f9a8d5f12amr110022765ad.20.1718944270107; 
 Thu, 20 Jun 2024 21:31:10 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.132.216])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f9ebbc72e9sm4488425ad.296.2024.06.20.21.31.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Jun 2024 21:31:09 -0700 (PDT)
Message-ID: <6c36a71f-f149-4a86-a015-d2a18129ac55@linaro.org>
Date: Thu, 20 Jun 2024 21:31:07 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/9] target/arm: Make some MTE helpers widely available
To: Gustavo Romero <gustavo.romero@linaro.org>, qemu-devel@nongnu.org,
 philmd@linaro.org, peter.maydell@linaro.org, alex.bennee@linaro.org
References: <20240617062849.3531745-1-gustavo.romero@linaro.org>
 <20240617062849.3531745-6-gustavo.romero@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240617062849.3531745-6-gustavo.romero@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 6/16/24 23:28, Gustavo Romero wrote:
> @@ -287,7 +256,7 @@ uint64_t HELPER(addsubg)(CPUARMState *env, uint64_t ptr,
>       return address_with_allocation_tag(ptr + offset, rtag);
>   }
>   
> -static int load_tag1(uint64_t ptr, uint8_t *mem)
> +inline int load_tag1(uint64_t ptr, uint8_t *mem)
>   {
>       int ofs = extract32(ptr, LOG2_TAG_GRANULE, 1) * 4;
>       return extract32(*mem, ofs, 4);
> @@ -321,7 +290,7 @@ static void check_tag_aligned(CPUARMState *env, uint64_t ptr, uintptr_t ra)
>   }
>   
>   /* For use in a non-parallel context, store to the given nibble.  */
> -static void store_tag1(uint64_t ptr, uint8_t *mem, int tag)
> +inline void store_tag1(uint64_t ptr, uint8_t *mem, int tag)
>   {
>       int ofs = extract32(ptr, LOG2_TAG_GRANULE, 1) * 4;
>       *mem = deposit32(*mem, ofs, 4, tag);

Move these two entirely to the header as static inline.
In general, inline without static doesn't mean what you think.

With that,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> diff --git a/target/arm/tcg/mte_helper.h b/target/arm/tcg/mte_helper.h
> new file mode 100644
> index 0000000000..69ad8457f8
> --- /dev/null
> +++ b/target/arm/tcg/mte_helper.h
> @@ -0,0 +1,63 @@
> +/*
> + * ARM MemTag operation helpers.
> + *
> + * This code is licensed under the GNU GPL v2 or later.
> + *
> + * SPDX-License-Identifier: LGPL-2.1-or-later
> + */
> +
> +#ifndef TARGET_ARM_MTE_H
> +#define TARGET_ARM_MTE_H
> +
> +/**
> + * allocation_tag_mem_probe:
> + * @env: the cpu environment
> + * @ptr_mmu_idx: the addressing regime to use for the virtual address
> + * @ptr: the virtual address for which to look up tag memory
> + * @ptr_access: the access to use for the virtual address
> + * @ptr_size: the number of bytes in the normal memory access
> + * @tag_access: the access to use for the tag memory
> + * @probe: true to merely probe, never taking an exception
> + * @ra: the return address for exception handling
> + *
> + * Our tag memory is formatted as a sequence of little-endian nibbles.
> + * That is, the byte at (addr >> (LOG2_TAG_GRANULE + 1)) contains two
> + * tags, with the tag at [3:0] for the lower addr and the tag at [7:4]
> + * for the higher addr.
> + *
> + * Here, resolve the physical address from the virtual address, and return
> + * a pointer to the corresponding tag byte.
> + *
> + * If there is no tag storage corresponding to @ptr, return NULL.
> + *
> + * If the page is inaccessible for @ptr_access, or has a watchpoint, there are
> + * three options:
> + * (1) probe = true, ra = 0 : pure probe -- we return NULL if the page is not
> + *     accessible, and do not take watchpoint traps. The calling code must
> + *     handle those cases in the right priority compared to MTE traps.
> + * (2) probe = false, ra = 0 : probe, no fault expected -- the caller guarantees
> + *     that the page is going to be accessible. We will take watchpoint traps.
> + * (3) probe = false, ra != 0 : non-probe -- we will take both memory access
> + *     traps and watchpoint traps.
> + * (probe = true, ra != 0 is invalid and will assert.)
> + */
> +uint8_t *allocation_tag_mem_probe(CPUARMState *env, int ptr_mmu_idx,
> +                                  uint64_t ptr, MMUAccessType ptr_access,
> +                                  int ptr_size, MMUAccessType tag_access,
> +                                  bool probe, uintptr_t ra);
> +/**
> + * load_tag1 - Load 1 tag (nibble) from byte
> + * @ptr: The tagged address
> + * @mem: The tag address (packed, 2 tags in byte)
> + */
> +int load_tag1(uint64_t ptr, uint8_t *mem);
> +
> +/**
> + * store_tag1 - Store 1 tag (nibble) into byte
> + * @ptr: The tagged address
> + * @mem: The tag address (packed, 2 tags in byte)
> + * @tag: The tag to be stored in the nibble
> + */
> +void store_tag1(uint64_t ptr, uint8_t *mem, int tag);
> +
> +#endif /* TARGET_ARM_MTE_H */


