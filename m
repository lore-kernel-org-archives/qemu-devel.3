Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 190AFE77188
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2025 17:56:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXl8l-0000pm-3q; Tue, 14 Jan 2025 12:55:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tXl8g-0000pV-R6
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 12:55:43 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tXl8e-0007gw-6U
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 12:55:42 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-436a39e4891so40623185e9.1
 for <qemu-devel@nongnu.org>; Tue, 14 Jan 2025 09:55:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736877338; x=1737482138; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Q16eQiaUy93SSjbT/AvPSjXfP1bE5EsrfnAHi7fo+3k=;
 b=gi5udqP6A70bfn/+58MO+P9zdpD0Jwer9gpiSLTU/cDpTw1fmDR+nY58ZTs/RcSfvN
 mMeWn07A7zO4hxZRU9AYu56Imd9b5lGiEGG5lW5K00/fysK0C9M0bt+BbmFNM5Ilc89t
 1Rju3p4wvxGg1pBJoiIxgLz1+zgCDBv33jqkU/Wkx5QR9KAB6yeFwkAHedp6LFMLnHd5
 6KhWQERvTp769cbhjeKhDaxiPAVP4qDKlSX11MMLe4ZEpU86HE3+bVLiCSt470Apacy5
 uUgk/6WCrAH+/drb6YcpbNJE638BNsBYWHge2yZLtwHzWGFnsulc5PjwmswOW3hFjxRI
 S+Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736877338; x=1737482138;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Q16eQiaUy93SSjbT/AvPSjXfP1bE5EsrfnAHi7fo+3k=;
 b=k3c3TQ4A6U7wj3uWM7y0mU226r2mz4YE3MhffzIUHP1sEA6maLxXQd38UYRiiQbcch
 LKslhxg9TEIM7ui8K90mMOozdlU8/c2IKz9jsI4AHHucQMf3CWc675z5Tp4imIVDpviK
 sr1W07aE77Qw5Azqg+8MHjcDxheWtrkXzG1MJMLTtbmQQ+A1uHFrvgdj66Cng9U6efhS
 UtWQKfcL8mBOFxmssxzw7624kLMH5spNyp6qLh4wnLUND8m8is6gfoyljEG4YuvaTw0I
 1wWLD9LSXdrX/yw+96UMmL8FYV4uXAY5fKwAOTVomhRi13SaGaic+zTvE8r9XPKKkfbS
 weOg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXT2+Yv7dSGg70W0FlWiC5FDw8WmzGTHxr9ljKlJYT7bG9QZiOqrpmpJYM53vtALxwaLhvzKCkd6ViC@nongnu.org
X-Gm-Message-State: AOJu0YxSEm1qEtIDiNjgOSEEwdD1BoGMl/D7K2yjBkOvTCdUzNGgYu5U
 pI+xGn5oBjQ86i9rlt+M9kj3xOyom28OtOMqqcY/KAE2z9ZDH5P/rmPPIzKeoc8D9QnUG/0TwhX
 MjH8=
X-Gm-Gg: ASbGncuq+lZ69cyC3KAB9i5sydSXTaf498GEErHcaplQQkplp2nhqGg+14NQf1i6VAU
 Tdz39B0Mfy+nJ7SoOKsvt4MGTuXvLNwmc812qplfiZt8UjQkiRyryU3jMOYIhUCOG56hFUbrg6W
 It59esNQSzCukj6llCP3l4VmNuSUxfrM0wa6pW+ztFp6zw0+T46Gd3B/fwIPtw3MaWpB715eASK
 3jyOSjcoBRzUKgBUwv4WTE11EaZTw3xyW3lYTdNGOgHVDPf1PkhG4qUn+qp4bWihI7AkYI1nVhc
 NOmplb5+XvOSkcX/ZRkSXsm4
X-Google-Smtp-Source: AGHT+IFHG1Bk83ge+dsxfhfOu3oT6Uz3kX3KEaoQNGoOlyx9RolB0F9dsRMQuvj33EZVsfOTzQzsfQ==
X-Received: by 2002:a05:6000:1fa1:b0:388:caf4:e909 with SMTP id
 ffacd0b85a97d-38a872e8bc4mr26519897f8f.25.1736877338611; 
 Tue, 14 Jan 2025 09:55:38 -0800 (PST)
Received: from [192.168.69.181] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a8e37d447sm15173970f8f.4.2025.01.14.09.55.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Jan 2025 09:55:38 -0800 (PST)
Message-ID: <20a0768a-38d9-44b5-a050-f893226b5d4e@linaro.org>
Date: Tue, 14 Jan 2025 18:55:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 00/81] tcg: Merge *_i32 and *_i64 opcodes
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org
References: <20250107080112.1175095-1-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250107080112.1175095-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

Hi Richard,

On 7/1/25 08:59, Richard Henderson wrote:
> Currently we have individual opcodes for each integer type.
> This makes things difficult in tcg/optimize.c when we want
> to transform the opcode stream.
> 
> Add TCGOP_TYPE() and use that instead.  Merge the opcodes that are
> common to both TCG_TYPE_I32 and TCG_TYPE_I64.  We could eventually
> merge some of the vector opcodes too, but that is a larger job.


> Richard Henderson (81):
>    tcg: Move call abi parameters from tcg-target.h to tcg-target.c.inc
>    tcg: Replace TCGOP_VECL with TCGOP_TYPE
>    tcg: Move tcg_op_insert_{after,before} decls to tcg-internal.h
>    tcg: Copy TCGOP_TYPE in tcg_op_insert_{after,before}
>    tcg: Add TCGOP_FLAGS
>    tcg: Add type and flags arguments to tcg_op_supported
>    target/arm: Do not test TCG_TARGET_HAS_bitsel_vec
>    target/arm: Use tcg_op_supported
>    target/tricore: Use tcg_op_supported
>    tcg: Add tcg_op_deposit_valid
>    target/i386: Remove TCG_TARGET_extract_tl_valid
>    target/i386: Use tcg_op_deposit_valid
>    target/i386: Use tcg_op_supported
>    tcg: Remove TCG_TARGET_NEED_LDST_LABELS and
>      TCG_TARGET_NEED_POOL_LABELS
>    tcg: Rename tcg-target.opc.h to tcg-target-opc.h.inc
>    tcg/tci: Move TCI specific opcodes to tcg-target-opc.h.inc
>    tcg: Move fallback tcg_can_emit_vec_op out of line
>    tcg: Split out tcg-target-has.h and tcg-has.h
>    tcg: Split out tcg-target-mo.h
>    tcg: Use C_NotImplemented in tcg_target_op_def
>    tcg: Change have_vec to has_type in tcg_op_supported
>    tcg: Reorg process_op_defs
>    tcg: Remove args_ct from TCGOpDef
>    tcg: Constify tcg_op_defs
>    tcg: Validate op supported in opcode_args_ct
>    tcg: Add TCG_OPF_NOT_PRESENT to opcodes without inputs or outputs
>    tcg: Pass type and flags to tcg_target_op_def
>    tcg: Add TCGType argument to tcg_out_op
>    tcg: Remove TCG_OPF_64BIT
>    tcg: Drop implementation checks from tcg-opc.h
>    tcg: Replace IMPLVEC with TCG_OPF_VECTOR

I still have 3 patches to review, but looking at the overall
maybe you can merge up to here, as the first part.

>    tcg/mips: Expand bswap unconditionally

(or up to here if I get this one reviewed in time).

>    tcg/i386: Handle all 8-bit extensions for i686
>    tcg/i386: Fold the ext{8,16,32}[us] cases into {s}extract
>    tcg/aarch64: Provide TCG_TARGET_{s}extract_valid
>    tcg/aarch64: Expand extract with offset 0 with andi
>    tcg/arm: Add full [US]XT[BH] into {s}extract
>    tcg/loongarch64: Fold the ext{8,16,32}[us] cases into {s}extract
>    tcg/mips: Fold the ext{8,16,32}[us] cases into {s}extract
>    tcg/ppc: Fold the ext{8,16,32}[us] cases into {s}extract
>    tcg/riscv64: Fold the ext{8,16,32}[us] cases into {s}extract
>    tcg/riscv: Use SRAIW, SRLIW for {s}extract_i64
>    tcg/s390x: Fold the ext{8,16,32}[us] cases into {s}extract
>    tcg/sparc64: Use SRA, SRL for {s}extract_i64
>    tcg/tci: Provide TCG_TARGET_{s}extract_valid
>    tcg/tci: Remove assertions for deposit and extract
>    tcg: Remove TCG_TARGET_HAS_{s}extract_{i32,i64}
>    tcg: Remove TCG_TARGET_HAS_deposit_{i32,i64}
>    tcg: Remove INDEX_op_ext{8,16,32}*
>    tcg: Add all_outop[]
>    tcg: Merge INDEX_op_mov_{i32,i64}
>    tcg: Convert add to TCGOutOpBinary
>    tcg: Merge INDEX_op_add_{i32,i64}
>    tcg: Convert and to TCGOutOpBinary
>    tcg: Merge INDEX_op_and_{i32,i64}
>    tcg/optimize: Fold andc with immediate to and
>    tcg/optimize: Emit add r,r,-1 in fold_setcond_tst_pow2
>    tcg: Convert andc to TCGOutOpBinary
>    tcg: Merge INDEX_op_andc_{i32,i64}
>    tcg: Convert or to TCGOutOpBinary
>    tcg: Merge INDEX_op_or_{i32,i64}
>    tcg/optimize: Fold orc with immediate to or
>    tcg: Convert orc to TCGOutOpBinary
>    tcg: Merge INDEX_op_orc_{i32,i64}
>    tcg: Convert xor to TCGOutOpBinary
>    tcg: Merge INDEX_op_xor_{i32,i64}
>    tcg/optimize: Fold eqv with immediate to xor
>    tcg: Convert eqv to TCGOutOpBinary
>    tcg: Merge INDEX_op_eqv_{i32,i64}
>    tcg: Convert nand to TCGOutOpBinary
>    tcg: Merge INDEX_op_nand_{i32,i64}
>    tcg/loongarch64: Do not accept constant argument to nor
>    tcg: Convert nor to TCGOutOpBinary
>    tcg: Merge INDEX_op_nor_{i32,i64}
>    tcg/arm: Fix constraints for sub
>    tcg: Convert sub to TCGOutOpSubtract
>    tcg: Merge INDEX_op_sub_{i32,i64}
>    tcg: Convert neg to TCGOutOpUnary
>    tcg: Merge INDEX_op_neg_{i32,i64}
>    tcg: Convert not to TCGOutOpUnary
>    tcg: Merge INDEX_op_not_{i32,i64}

Here I'm missing the "Convert X to TCGOutOpY" patches. I haven't seen
any blocking review difficulty, so will proceed soon.

Regards,

Phil.

