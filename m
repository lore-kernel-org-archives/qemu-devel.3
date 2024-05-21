Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 783B5C25B78
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2024 16:47:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9Sd9-0005u5-Hq; Tue, 21 May 2024 12:46:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1s9Sd7-0005tS-PK
 for qemu-devel@nongnu.org; Tue, 21 May 2024 12:46:26 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1s9Sd6-0001Y2-3b
 for qemu-devel@nongnu.org; Tue, 21 May 2024 12:46:25 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-574b3d6c0f3so9876739a12.0
 for <qemu-devel@nongnu.org>; Tue, 21 May 2024 09:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716309982; x=1716914782; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=eHAevO1o5T/FTWV1iNtVT2hqiEgNn183cIuBt9r1fcA=;
 b=gG6NLtSKpB+T5+1nE2kj4nvfMdmbzMNvOwIUJw2DJmMMU3Zwv/ZemUTpRrg1mjuENX
 lYsdA0FRnsutli645QX3SAcnIaETQf6cQ4N7Ml47nKGjCp6826l6u+Dbd6Ysnksxutr+
 5Yw74SMwysjMxk4YXDIue2m+GwybOaxILaPmEQbxQUjnDKJeqaK16NgXQBMS/nREZi1k
 OoevK0zPXvEzzWoj1bwbYBmZLmjItRaIaxnGvsW5VT9DFL2zjibfJyhLGDi/OTSc2Zor
 nxf7ytN6Ste073q5prmQxtr9Esi4V7vEME3GNbt5FW/crNwPcna0prPUAUDWjH0KB/aT
 G63Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716309982; x=1716914782;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=eHAevO1o5T/FTWV1iNtVT2hqiEgNn183cIuBt9r1fcA=;
 b=mRNcdqR4z4S/8V8+2s428QEk7Dqm8pcuOQ98h6mcIAeyX7D0Toai50v3+r73o4Owvo
 /U3sutTcsuOyHL7eE0iofmirGR83x6tlEpS9VnPWp/TJLlkfLUGcfoyaC1TacisReFC/
 fbAbX60IoMv0HUeCK3XPxCdUmzhyr+OjPkzkLp61uCqxa1d91UQI55zcWNuHJlrC37Zg
 h2sqN8h3+QZ0SroOs0nYsD5SH931RGBJTtdgwZTL22NM4rlKsHyO1ROoQP63KPs5Tyvm
 kPrrsfIFvJz2iGB3hnjALyR03e4gxZ4JXQvpdre3gngytVZ7vst2ED5L9QXGPIewkdrD
 wRBw==
X-Gm-Message-State: AOJu0YwJSM9/xMWx4HQ2Sa0cr/uKLvZDMUleB79a3saKUlPkBsm0EMg/
 V9Nochv5IL+NV2rqgG5whumb8AMScJH9YxoQdn4MZYkNqQ5xpyAm4NerabuZJuzHHfbyNhWRQia
 RcCiPf4dV0zwd/fC1l8J47V6Rep2MXfKGIfqreg==
X-Google-Smtp-Source: AGHT+IHeKNOMGx70v12+ABkuLtOpWhQxUZSkxxm4x2VLTKJYRvLHmkjxUjNorNEE4nlfZ4T03tJZ2f2spmOY4Tqah1s=
X-Received: by 2002:a50:ab05:0:b0:572:9a99:cae6 with SMTP id
 4fb4d7f45d1cf-5734d5c0c62mr19908990a12.15.1716309982307; Tue, 21 May 2024
 09:46:22 -0700 (PDT)
MIME-Version: 1.0
References: <20240506010403.6204-1-richard.henderson@linaro.org>
 <20240506010403.6204-33-richard.henderson@linaro.org>
In-Reply-To: <20240506010403.6204-33-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 21 May 2024 17:46:10 +0100
Message-ID: <CAFEAcA-e6+z+07SvdqSf2AqPG=JvH4Zk2Fx_=zTtRZaFDOT-zg@mail.gmail.com>
Subject: Re: [PATCH 32/57] target/arm: Inline scalar SUQADD and USQADD
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x533.google.com
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

On Mon, 6 May 2024 at 02:08, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> This eliminates the last uses of these neon helpers.
> Incorporate the MO_64 expanders as an option to the vector expander.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>


> +/*
> + * Set @res to the correctly saturated result.
> + * Set @qc non-zero if saturation occured.
> + */
> +void gen_suqadd_bhs(TCGv_i64 res, TCGv_i64 qc,
> +                    TCGv_i64 a, TCGv_i64 b, MemOp esz)
> +{
> +    TCGv_i64 max = tcg_constant_i64((1ull << ((8 << esz) - 1)) - 1);
> +    TCGv_i64 t = tcg_temp_new_i64();
> +
> +    tcg_gen_add_i64(t, a, b);
> +    tcg_gen_smin_i64(res, t, max);
> +    tcg_gen_xor_i64(t, t, res);
> +    tcg_gen_or_i64(qc, qc, t);
> +}

Can you explain how this one should work? SUQADD is
"a is an signed value, b is an unsigned value, add them and
do a signed saturation of the result". If we take, say,
16 bit elements a = 0xc000 and b = 0x5000, then a is negative
(-16384) and b positive (20480), so the result we want is
0x1000 (4096) and no QC bit set.
But the codegen above looks to me like it will incorrectly set
the QC bit (because it's effectively treating both inputs
as unsigned).

thanks
-- PMM

