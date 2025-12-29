Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B941BE8FDB1
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Dec 2025 11:25:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vaBN2-00008g-KK; Mon, 29 Dec 2025 06:25:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1vaBMs-0008TF-RH
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 06:24:58 -0500
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1vaBMr-0006bp-6x
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 06:24:54 -0500
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-64d30dc4ed7so10819121a12.0
 for <qemu-devel@nongnu.org>; Mon, 29 Dec 2025 03:24:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767007491; x=1767612291; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GL5QiCDGGMdUivLLoFnnqtdZyCvc43hcdc0r3RMhuwU=;
 b=pEK12g2rYAcyNuGrZeIJwjXkLeVEMosxjglKg055AjHJw9OWuALaQ87+9+hHua+MZj
 hVa3bSdAYwZFlCzUuQ8T3oVSZv+D+CGZKOVgA6Zwg1M+SMgq/Uoex/2sPK1tGu11wzwK
 8vzFr7XDuFkZ61smn4E2qqf79NAGRs1om7sd5hqZn18f9a8ozTy3QPa7PlbbiMANJMSO
 KXEqIIQ/BVe6ZAQmI3dbgeGk1DBITSZi4qLLjG36mUtzIW6EBNg8wipV3f94g2FaQz3x
 tblvmWzjBunLp6xEiYUciNjiq2HnfhzG5lbYWbmu1O7/acDluqRrN4mIvy2vP2E3zr4y
 e58g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767007491; x=1767612291;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=GL5QiCDGGMdUivLLoFnnqtdZyCvc43hcdc0r3RMhuwU=;
 b=cAnDTMintVQDxmp0JirdYFwwNv88yA9IKYwDr3To0fIT5yrkm7hGkrCIwpgPU3sYcC
 09c1CLWF8Mqb5GBdQYnsjrxxwVf+jVYzLIPIo0sxLaQnP3iR0fu1MfeAYaMPluQXAlWy
 kBGaqIVNcF1CtSPyXr3dD0NdiHkYThQ6pNh7VMqjUk26AP/thwBvw7yDWrq99GyN8cKW
 rQtWH/7shz2Kbbz51ExJk+oW7eHVTXf5XdFQmkrVSqujulN+D8ksBg8PSfy+k7H1nEZs
 8MnFPMT5BHwom/Zm3yqlih3h8QfEQbzo28A2KyPVFl418Jgtkb/XOoBB9RrQhgpkx/Sd
 PT4g==
X-Gm-Message-State: AOJu0YxAL978rbRNHIwpBZzBbB4Kj+JM0FBY0UoR13KXVi15iTqyyBuK
 GXU7kDf5E4ykJ6hZfEm9HUu3cgTkWg6xvlGcrulL4lP2ZJoA8jZM2uTmfWWkFzto4SdaMlgdlYS
 S58HQDyea22Jt5EvIpau3niOcveIAe2cJ0DqjNtOXSw==
X-Gm-Gg: AY/fxX7SMEjFPvZUCzotVXaUfL1TxTqKjjjBCN11Z6VaU5BO/yFrV7mab7h4+UVvbDI
 bH+4d02nCMUwmJWJJbiylcvhKW9dU7fkVX2DzmXMll41gscu+t66gka5iFhBBuU5wgON5T97nwB
 D5fnaHWGYYZPYZxJmNgjXqXlnn4pt/5nqcT76OrklXJflmaZSdNnSA+fOpv2dBW7TwEGMHvG36l
 Hnee3v7LJiNfzcHlxY58ilUBrdkWatckgM/YHgAY8AsyjOnMcc3uopXkAjw/SWKO3/qMMnavuHO
 YlZseiHjCBLtTY0Uv1nV8I+U6P0i4uaE/hNJdEConNVL06bNUA==
X-Google-Smtp-Source: AGHT+IFFdudTzDPtghUISuxXF+1bdhbZpWfklallcg9V2m8hh0PHmd/pPebbE1ZgcVBkeyISJjCMZsEwBr2I1uG5EeE=
X-Received: by 2002:a17:907:7f8e:b0:b7d:11ae:4006 with SMTP id
 a640c23a62f3a-b8037197254mr3351234166b.52.1767007491377; Mon, 29 Dec 2025
 03:24:51 -0800 (PST)
MIME-Version: 1.0
References: <20251224163005.91137-1-philmd@linaro.org>
 <20251224163005.91137-4-philmd@linaro.org>
In-Reply-To: <20251224163005.91137-4-philmd@linaro.org>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Mon, 29 Dec 2025 13:24:25 +0200
X-Gm-Features: AQt7F2rh8xXKO5vpXZMkYlbeeR8fl2EqPH05dhmbTkjWuLyrSr-T7KpifRomODg
Message-ID: <CAAjaMXZxTrnSufP4wkSN0sAK2MBX6u6kH98C8bAxrfchs-hPFw@mail.gmail.com>
Subject: Re: [PATCH 3/3] configs/targets: Forbid TriCore to use legacy native
 endianness API
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Anton Johansson <anjo@rev.ng>, 
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ed1-x536.google.com
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

On Wed, Dec 24, 2025 at 6:31=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> The qemu-system-tricore binary is buildable without a single
> use of the legacy "native endian" API. Unset the transitional
> TARGET_USE_LEGACY_NATIVE_ENDIAN_API definition to forbid
> further uses of the legacy API.
>
> Preliminary commits allowing this final change:
>
>  . cd08bcaa36b target/tricore: Expand TCGv type for 32-bit target
>  . 8a2235dd077 target/tricore: Un-inline various helpers
>  . e843ef2bbac target/tricore: Pass DisasContext as first argument
>  . 4f08815467e target/tricore: Expand TCG helpers for 32-bit target
>  . f30c8aa229d target/tricore: Inline tcg_gen_ld32u_tl()
>  . 6b2e4fcb836 target/tricore: Declare registers as TCGv_i32
>  . c558aa94211 target/tricore: Replace target_ulong -> uint32_t in op_hel=
per.c
>  . 30257dcd2b0 target/tricore: Remove unnecessary cast to target_ulong
>  . 44e2b68d275 target/tricore: Remove target_ulong use in gen_addi_d()
>  . a15e8996268 target/tricore: Remove target_ulong use in translate_insn(=
) handler
>  . 0d5f9542561 target/tricore: Replace target_ulong -> vaddr with tlb_fil=
l() callees
>  . 809b460f305 target/tricore: Remove target_ulong use in gen_goto_tb()
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>



>  configs/targets/tricore-softmmu.mak | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/configs/targets/tricore-softmmu.mak b/configs/targets/tricor=
e-softmmu.mak
> index 5e018d81068..9a9f23c7731 100644
> --- a/configs/targets/tricore-softmmu.mak
> +++ b/configs/targets/tricore-softmmu.mak
> @@ -1,3 +1,4 @@
>  TARGET_ARCH=3Dtricore
>  TARGET_LONG_BITS=3D32
>  TARGET_NOT_USING_LEGACY_LDST_PHYS_API=3Dy
> +TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API=3Dy
> --
> 2.52.0
>

