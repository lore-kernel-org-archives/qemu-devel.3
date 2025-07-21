Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0F06C83F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Jul 2025 13:58:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1udr24-00049e-Gd; Mon, 21 Jul 2025 09:58:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1udr20-0003L9-Ni
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 09:58:17 -0400
Received: from mail-yw1-x1133.google.com ([2607:f8b0:4864:20::1133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1udr1y-0002yA-B9
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 09:58:16 -0400
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-70e767ce72eso40317047b3.1
 for <qemu-devel@nongnu.org>; Mon, 21 Jul 2025 06:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753106290; x=1753711090; darn=nongnu.org;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QiLzRZAwk16R29NBnm8GL+iNayzSFdpJTOyGjL7G/t0=;
 b=ALsSy0ddm0FcfGtdlay8E7PJX/rKGK/PASJtw8hrj4Rp/u4GJyxh1RoOcDG20JTyPg
 SI7OMj7YyU5xQHwrzcszSV+elVrTqyxnDjm/OIKtSi4qol8NtevnatdxjtEElGygagcK
 tsOswwYj1etU147SCZu+Nk4ZkF0ml1p6v1WpnADJW71xPE1TKgvQpGZo5dAP36yrw0Dg
 WwQlShuyanH67IVBo8jlUsdS9HDYoUv2mzfcZGFEnycCMOyLsG/4nO+hZX4dLSzRnvya
 +AAqIvrtqfEO1smG7FLFw+MjTDQVVhmbmJoBVFVBoHGkvQkXxxStma8sV/yIKGDipzLI
 nM0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753106290; x=1753711090;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QiLzRZAwk16R29NBnm8GL+iNayzSFdpJTOyGjL7G/t0=;
 b=nuq/CSqBGEvPL/zWcKBgJxUkOl8a6OeTNOLqlZPR8I/ej2NnfDkH9XEJusInnP5tPs
 dj2GfDwCoOImSCTqAXArnDQaH+Lv8KUNNVhjvIFc59rp9aUujXS4LOP9TgYXR8vUbTPz
 LaCdFgSJ9FK7JlEqIfFPLhfbpX3ZXUVnKiw21PPtgZ0vGNwTtatsJwNNQ+uGmvn3Su8T
 0KixvyC2t1kd6EcRDsmgnsPz8LxfZRomg0BnwxWSVkbToe3MVAhNeZg3em+hlHLn1tf3
 bfQkA+dp1cNrNjcviF0EyCWM0wtMaeYpjPp70M8LR3lKbLfldgfg2ULlqNX7D47gH9cO
 J4kQ==
X-Gm-Message-State: AOJu0Yxl6tnZkO/U0PKqleSqRo1SOIJ7EkHC0SajejVhD2CdSkWGCTW5
 OEQhHRS8SgOdP8yejCOwT7vjIYL44EOhd+B2m/sg+flHso3bAuX9cVnfQ2k1qWWF0NLU4uyePML
 iLDlfyKnEMspOEewcr1KSTgd984GPwBBg59pSMcAG4BfL4iLQwher
X-Gm-Gg: ASbGncs7KH7XZLyv50AV+NXdkFdSY8qMWXRWm8kzuUpsSZIpCNB+Uxc0zQWxxtC79Xi
 5P1rQdNN5sDsFCI3WrwTxEMxXwZ0LXQHvbuM1YD43AKsFlFB6CYHMV4bf5wY5ymLHh2gddnrNQG
 c77MzXpuDC/wujK7GIDOEHVlPwG6SK8DQX/npOPO5HG5svZ8BmQShoFlMdtWQmHmzEZ5/8Ft+wD
 yDWlY9n4Vx9bfTzQbU=
X-Google-Smtp-Source: AGHT+IGW57PlAucwniTF9Ft28lwgSvYPCREy7VhVSoPJniQsKqpL709Q/BTI89uP2WjbjI8ZqQkgx1AZ8yFLqPn0a0o=
X-Received: by 2002:a05:690c:7206:b0:70c:d322:8587 with SMTP id
 00721157ae682-71836ca9a62mr267650907b3.6.1753106290128; Mon, 21 Jul 2025
 06:58:10 -0700 (PDT)
MIME-Version: 1.0
References: <20250710174312.1313177-1-peter.maydell@linaro.org>
In-Reply-To: <20250710174312.1313177-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 21 Jul 2025 14:57:58 +0100
X-Gm-Features: Ac12FXwVF7bNKa6e2OhiOFkatul-cSGJRjRD2vIBbddXoA0u0cptSmbb6pS0N78
Message-ID: <CAFEAcA_T2wgp+5Sp-mEdr-RBBAW-Q3DYg_==EJW7s07_gCb2Xw@mail.gmail.com>
Subject: Re: [PATCH] hw/display/framebuffer: Add cast to force 64x64 multiply
To: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1133;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1133.google.com
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

Ping -- any opinions/review about this one?

-- PMM

On Thu, 10 Jul 2025 at 18:43, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> In framebuffer_update_display(), Coverity complains because we
> multiply two values of type 'int' (which will be done as a 32x32
> multiply and so in theory might overflow) and then add the result to
> a ram_addr_t, which can be 64 bits.
>
> 4GB framebuffers are not plausible anyway, but keep Coverity happy
> by adding casts which force these multiplies to be done as 64x64.
>
> Coverity: CID 1487248
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> This is one of those ones where I'm on the fence about sticking
> in the cast vs just marking it a false-positive.
> ---
>  hw/display/framebuffer.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/hw/display/framebuffer.c b/hw/display/framebuffer.c
> index 4485aa335bb..b4296e8a33e 100644
> --- a/hw/display/framebuffer.c
> +++ b/hw/display/framebuffer.c
> @@ -95,9 +95,9 @@ void framebuffer_update_display(
>      }
>      first = -1;
>
> -    addr += i * src_width;
> -    src += i * src_width;
> -    dest += i * dest_row_pitch;
> +    addr += (uint64_t)i * src_width;
> +    src += (uint64_t)i * src_width;
> +    dest += (uint64_t)i * dest_row_pitch;
>
>      snap = memory_region_snapshot_and_clear_dirty(mem, addr, src_width * rows,
>                                                    DIRTY_MEMORY_VGA);

