Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5310D1D493
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 20:28:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdwcT-0001nt-Bq; Thu, 08 Jan 2026 15:28:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vdwcS-0001j4-BB
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 15:28:32 -0500
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vdwcQ-0004zN-Hf
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 15:28:32 -0500
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-34c9edf63a7so2901273a91.1
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 12:28:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767904108; x=1768508908; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=J9Jv8FbQLCzgd0MYXFcGLwol8lVInwSqeJSs/w3sp/Y=;
 b=XL1kz0mLye9vvkP4vK8YFwE9EAs+8HFgVrtINf2ag0H3R2782U1TXLUMXohi90bmuV
 Xk6JnIdeftj7SvUACf2SfKrS9SYMzJlY8gYX7DvQ39ezgKaQN5WPBF5ZKd9Bf/GX/BEf
 rVwBW5wBo8cSoFLFGRfIYCB4T55DEbQykDOm+D2eVkgTS/Y5Cdj7OY1DiRQ1lDjbe9Pi
 CA+k6aW08PMfTLA+gQuy2hLG39F7zQnahfRdrtJQ11ctgyUCOLhCv9JS+7j7vkY0JZVs
 TWUfjhm0Zb2TRfVYjasrGMu6MsX/IO8eyEAN0WcrMs1EJ8sqw3V4vGYGyrOBFHF5PUcR
 LuCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767904108; x=1768508908;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=J9Jv8FbQLCzgd0MYXFcGLwol8lVInwSqeJSs/w3sp/Y=;
 b=U4joPWgK3oO7Q+6w69ekpbCTKec0ryJax5VDgf16QaeHzatHpnqZ5DmgYABZW/slE/
 9FXyBvKquCF0lOAHe1eOHSMjAoa1mVesM1T/S9YViVYgC3mC0mwxxKJ2Xt9aVCKqhuW0
 hNeLz+1pRzBLeatsnIngZeqzd9o6O8mMNDhAp0Of6tvLYm7BxBD/D8oeyiK+ZhDbCulr
 BtyI/IPcFsC7Lmcnip1Aq166fejJNuu10mbv3Nf1cRi2rEe8KgCxaoClcz50cuQRzJ97
 AVKKMMEBweOOO4F8IWmp/0JE211rvmHzTIVBWA67zthQLkVQ89QSQlaPv0F2aas+gGxy
 xneg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUIonh5FI7jNH6TtnItePAa8PqN2MvfDJGn5p/ws+lbNghqrAJhqbkVwrXwEsou3eKlgG5W2ithQamP@nongnu.org
X-Gm-Message-State: AOJu0YzVPyeMoyHwnhHKfRIiF+6xfQa6A96NdPcBnssbDyptr+fToxwt
 fuKo3ZsV4DuRicFaDNExrP+P4q3xXJpIsewe8EW1gdOUHmgZ5QZcnr5omqj1mmJDrwklj+rhl2+
 AoIkD
X-Gm-Gg: AY/fxX5+Ir10t0Ec0b9LBjIjf/p/InnHNCSxAdP3sqKd+ICeu/IcnGAdvf4fJ1XVU9q
 rnPnh5TbcNP3Zh0/K0wL6p2a9DvSVm5xYQDc2zgYuak0BCOfkfx4gEBP11iXlZ5pBs5n/CIyQ0v
 h9Tt36B7bCwpAlYW0tbR6vgsZkTMpMVu4GphEGYtSmnyHIjciC3craQDhUSBtlPcF6R+id+BM09
 ish9AIOCY88rRLZfzviDDbDK1PS/1yJrSVOFlG6iI1X/OTG4m7nGx+HZLJWUmXi+frQogVgskTa
 DuEYwJH1uXhWwDDQ8BLLYgRyZ3Zlqqh0GLKxzpcg6TdHwHeqKBICY9MpLyBAbwchChI/GiMqHq1
 gMvA3754Xh63H2NinStmEgKZAid+rW9KIK5I/k9AFKPkszWA3booA6Kw+qZ9Se++rooCDHAlkt3
 jo5F+Vit6id3592G3gav2sXEv6MFsDvEPy8LXb3iHIDSIGD0gnVHnv+ujW
X-Google-Smtp-Source: AGHT+IFlbl5EsaeDYNJVB+cFMw+JncRR3EhMu/CWrGNHFQ/7oYi9oIkU7H9Rsdy1p1+bkgsbY3lwTQ==
X-Received: by 2002:a17:90b:2dca:b0:340:ec6f:5adb with SMTP id
 98e67ed59e1d1-34f68c7a907mr6737297a91.3.1767904108518; 
 Thu, 08 Jan 2026 12:28:28 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-34f6b0dc3f9sm2151344a91.4.2026.01.08.12.28.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Jan 2026 12:28:28 -0800 (PST)
Message-ID: <3e33c7c8-8193-4e31-a296-1c99177ec3ed@linaro.org>
Date: Thu, 8 Jan 2026 12:28:27 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 18/50] *: Drop TCG_TARGET_REG_BITS test for prefer_i64
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20260108053018.626690-1-richard.henderson@linaro.org>
 <20260108053018.626690-19-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20260108053018.626690-19-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1030.google.com
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

On 1/7/26 9:29 PM, Richard Henderson wrote:
> Mechanically via sed -i.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/tcg/gengvec.c                | 32 ++++++-------
>   target/arm/tcg/gengvec64.c              |  4 +-
>   target/arm/tcg/translate-sve.c          | 26 +++++------
>   tcg/tcg-op-gvec.c                       | 62 ++++++++++++-------------
>   target/i386/tcg/emit.c.inc              |  2 +-
>   target/riscv/insn_trans/trans_rvv.c.inc |  2 +-
>   6 files changed, 64 insertions(+), 64 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

