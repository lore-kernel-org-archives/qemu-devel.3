Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B695C021A0
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Feb 2025 17:59:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjMRX-0007wZ-9c; Sat, 15 Feb 2025 12:59:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjMRT-0007ul-0y
 for qemu-devel@nongnu.org; Sat, 15 Feb 2025 12:59:03 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjMRR-0007rB-24
 for qemu-devel@nongnu.org; Sat, 15 Feb 2025 12:59:02 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-221057b6ac4so10640205ad.2
 for <qemu-devel@nongnu.org>; Sat, 15 Feb 2025 09:58:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739642339; x=1740247139; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HuUZGJlz7fsLnNXiRXyUJUAUWT8LSchwOnIGXmCtzGs=;
 b=N3PcErosLzy7gGk97EiJ/1XpAS8QbnuK3XG/FMq7ZouOFkWvxN89ukh9Y28jXCJ+OL
 hgnTQvm55AVnZhFJHug2KCjcixzZ53ZaEIKhR+trk6oVuz6ZEsSDGLjplBpp0cOphGVn
 uI5UnVL0vDMzdXjlleSUyRnAvnWQt/iNBEf1+oV1kE1Z1dHZtr8qjjkTZKjvc7auOFdn
 A4wCXq5vVmKf/M1jROLbqGLvoVTgTgi2ieM8VK9O41mSKRoWW3R/gGN818ka5OlFWHfZ
 a2X/qMc1VWhk71M8OR0g5T+6YmN790ig1CLAgigSpWaeZgFFl+xyalfkN1z2uWFIYRxc
 jbDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739642339; x=1740247139;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HuUZGJlz7fsLnNXiRXyUJUAUWT8LSchwOnIGXmCtzGs=;
 b=uUsV13vQUHR8jOBQOYg9/HU8Y1gXS1Muce0J+a8vv14RniF0BLzL79d9sltId7gMjH
 BM+S9tmPzrH7lXn8mZePT/IxuokwpCnW5KnTQujJlv8FULJHZ209Mw7WmkS8iLVYtbI/
 4FAgOFSze0pUjZyF5BGA1MRk8tnjcj37crP1xzCEymlB6YSRTKCy+us2EazdG86N52WO
 9Z7YFYjOO9ueHvObapS43cY/9OuTdDHkMjjkYzu5oS1n00NS+k/Y2AjmpBGV/j4pFC9q
 Ywb+IIs9QP5XxkmzWCtc7jPdzxnnGSYwf2zywHxPlFrN3dPn3bh3mzPCNi6c9nph0gtc
 N0UA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXy263l2GPg2lydyaILH4I1cxvwpRLy8shXAMAJSOyomTqQNIW0u+5NHQN6RC0imQeIWyk1B48QHQeL@nongnu.org
X-Gm-Message-State: AOJu0Yxpbv3ixDeZYY5r4xoJkLDHjDI53U8nw/TQceQCOPSOVrephzbL
 BXD1zuHzDOrnDtiS4CJkHO1/4NTzfpZ0rWeNeKSwsF3p5szn0AjTAgKOrQEClIk=
X-Gm-Gg: ASbGncungKary5W40+nps90z5nCWB4qITdEN4Cm4qXy+5Y+5S4x/WbIHweLy9QKadUt
 vUF3oCYHGkiIz1dE9dq2tvaVsLsVKDi4gd28It3yY6PHLuBYYxGkE4C/dhg4Lsxf0pJvjl0PNFM
 pCbTTJC3e5oAvPMHJBk3y9vLvFGKM6gSlXzLpMoxcjIbk09ruXSjteDeflaG/bwyLrGkUjcO6I1
 nwUiBqv7oVNJMGqhjyHD/F1G0w8QB/1mynpEWuANNRZT4/DZIxg2iSwOqc3bD/6pIbjEClk1Y0T
 Nl2bBbhemSZzSKj4HroUYaDiBZ0UwDPOoXiFdbaW/bEG3gufktCfnFM=
X-Google-Smtp-Source: AGHT+IEQy6z65bbcamaqqgMICfN57MfShDYRkl9SpGxnxOB9aak2x3l+q0dW4FXRRDvx6ieNmNEcAg==
X-Received: by 2002:a17:902:d507:b0:216:2dc4:50ab with SMTP id
 d9443c01a7336-22103efc1d9mr59280025ad.2.1739642338778; 
 Sat, 15 Feb 2025 09:58:58 -0800 (PST)
Received: from [192.168.0.4] (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d5349056sm46763935ad.22.2025.02.15.09.58.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 15 Feb 2025 09:58:58 -0800 (PST)
Message-ID: <a62ee246-4249-458c-9f9b-bad79816ce5e@linaro.org>
Date: Sat, 15 Feb 2025 09:58:56 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tcg: refactor pool data for simplicity and comprehension
To: Michael Clark <michael@anarch128.org>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20250215021120.1647083-1-michael@anarch128.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250215021120.1647083-1-michael@anarch128.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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

On 2/14/25 18:11, Michael Clark wrote:
> the intent of this patch is more conventional nomenclature
> but the constant pool data code is also simplified a little.
> 
> - merge new_pool_{alloc,insert} -> new_pool_data.
> - rename TCGLabelPoolData -> TCGData.
> - rename pool_labels -> pool_data.
> - rename macro TCG_TARGET_NEED_POOL_DATA.
> - move TCGData struct definition into tcg.h.
> - comment translation block epilogue members.

You can see from this list that this should be multiple patches.

> TCGLabelPoolData is ambiguous and asks for potential confusion
> with the unrelated TCGLabel type. there is no label in the sense
> of TCGLabel.

Fair.

> the label member is merely a pointer to the instruction text to
> be updated with the relative address of the constant, the primary
> data is the constant data pool at the end of translation blocks.
> this relates more closely to .data sections in offline codegen
> if we were to imagine a translation block has .text and .data.

No, it doesn't.  It relates most closely to data emitted within .text, accessed via 
pc-relative instructions with limited offsets.

This isn't a thing you'd have ever seen on x86 or x86_64, but it is quite common for arm32 
(12-bit offsets), sh4 (8-bit offsets), m68k (16-bit offsets) and such.  Because the 
offsets are so small, they could even be placed *within* functions not just between them.

> thus TCGData is more succinct and more reflective of what the
> structure contains; data emitted in the constant data pool at
> the end of translation blocks. also, pool_labels is renamed to
> pool_data as the primary contents of the list is constant data.

I guess.  TCGData is perhaps too short, but we can certainly avoid the confusion of "labels".

> 
> finally, new_pool_alloc and new_pool_insert are merged into a
> single function named new_pool_data, which moves nlongs to the
> end of the parameter list with varargs to allocate, copy, and
> insert constant data items to simplify new_pool_label et al.
> a successive step would be to collapse callers into calling
> new_pool_data and remove a layer of indirection.

Why?  varargs generally produces horrible code.
The split between alloc and insert was intentional to avoid this.

> diff --git a/tcg/tci/tcg-target.h b/tcg/tci/tcg-target.h
> index a9ca493d20f6..448c2330ef0f 100644
> --- a/tcg/tci/tcg-target.h
> +++ b/tcg/tci/tcg-target.h
> @@ -72,6 +72,6 @@ typedef enum {
>   } TCGReg;
>   
>   #define HAVE_TCG_QEMU_TB_EXEC
> -#define TCG_TARGET_NEED_POOL_LABELS
> +#define TCG_TARGET_NEED_POOL_DATA

Oops, this should have been removed with a417ef83.


r~

