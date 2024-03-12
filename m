Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D0E0C54E58
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 16:30:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk50I-0004AU-C9; Tue, 12 Mar 2024 12:29:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rk50B-0003zj-Rb
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 12:29:22 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rk509-00028s-OU
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 12:29:19 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-5684f95cc9bso278077a12.1
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 09:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710260956; x=1710865756; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=U6QXTTSPCm3sFGZ+qrJBg0fuI95XHgO4UvVzyiDJF3Y=;
 b=HvMb+Jq5VwJHP0xgOP0AvrXyaE8UZjWaXzYTT6x/CZbnJ2utSAWYxBbj1bxQEAMkxr
 T0u3asZ5IQ/Db+FyOHb/8/jUdnpLw2F0pG6+jCyoYTATyhV/aSYVjkXK1wGqnwoL2oZ8
 T1McxYTTuo1WgdkOfNRukuoCg+0vsMtHKzQQmKhj152roYmWFlisD6t6gdReVNlAY32D
 +4WDvFve3bpOGc0a3Poqcb+l63Z2xzlYLy9ZDksqBESb7mDdetdf8Yl3ULaG9Nc6nX8B
 HGpThH/EgRXsDTNFipOQejcJhCW4bsNuHhItsdEdiM/eGaNyHougIlUZF/PM3V0W5jLz
 H/fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710260956; x=1710865756;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=U6QXTTSPCm3sFGZ+qrJBg0fuI95XHgO4UvVzyiDJF3Y=;
 b=ckTVUSFP9ugBZfgNHLMIRIyhtGwGocMiS7hjYrymPeZMdCeDnvwAAynEFIeOUPrfCg
 MMiVKVpw7F09JZ9kIjFNeD90TNmfmH2vPtJdQy+TzWBRdzrAbouTCAj9HL/AuwYcRPO/
 Nywa3AWrW7+ohlJJp5AdL65CVz5UnsPaqwytl6SgkFGTMc79SxxSQlqUV8RmQceScDei
 2S4cKI7Kv6v6E7xPBfz8MeAV1k+p6dApT0RGqRaezU4A1h5JceQMu+LsAcN6cItnkLof
 Wp5yXPNn2Jo42HIKVig9PgByGonCuR8sTk9ZIgYkwyqMNugwEHh6ZXykC3/haVCc/9zb
 7eRA==
X-Gm-Message-State: AOJu0YysYHXRSJrzRixPD+cdZizjhDO9KEtVs18Zfxf5N9VlqIw7ELlA
 KOiCB0mUSwVEbwZA31xBKJPPOoYrNFdMMzWXne0PFhMljwebu+vkstFnznrbMnr1laPkLJQ4gFP
 Y6IWmn0U6VErcSfwYVTRN+FilLHSsnZFeM2y6tg==
X-Google-Smtp-Source: AGHT+IHxx41pFBeQ93xdvNfMgBGXQslfZRiKCpY9613nsbhEbMxMHqhemJi06GIqmMaDsF04Skuoe6NhbHl570Yxqw0=
X-Received: by 2002:a50:d489:0:b0:568:335d:1192 with SMTP id
 s9-20020a50d489000000b00568335d1192mr48931edi.13.1710260956198; Tue, 12 Mar
 2024 09:29:16 -0700 (PDT)
MIME-Version: 1.0
References: <20240312113642.36862-1-jasowang@redhat.com>
In-Reply-To: <20240312113642.36862-1-jasowang@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 12 Mar 2024 16:29:05 +0000
Message-ID: <CAFEAcA8VSfk1qs6mX0spmMKTWo=L9FdPj_pScHaQPOMmnXe36Q@mail.gmail.com>
Subject: Re: [PULL 0/8] Net patches
To: Jason Wang <jasowang@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52e.google.com
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

On Tue, 12 Mar 2024 at 11:36, Jason Wang <jasowang@redhat.com> wrote:
>
> The following changes since commit 05ec974671200814fa5c1d5db710e0e4b88a40af:
>
>   Merge tag 'm68k-for-9.0-pull-request' of https://github.com/vivier/qemu-m68k into staging (2024-03-11 18:42:53 +0000)
>
> are available in the Git repository at:
>
>   https://github.com/jasowang/qemu.git tags/net-pull-request
>
> for you to fetch changes up to 0cc14182aba961f4c34a21dd202ce6e4a87470f5:
>
>   ebpf: Updated eBPF program and skeleton. (2024-03-12 19:31:47 +0800)
>
> ----------------------------------------------------------------
> -----BEGIN PGP SIGNATURE-----
>
> iQEzBAABCAAdFiEEIV1G9IJGaJ7HfzVi7wSWWzmNYhEFAmXwPUAACgkQ7wSWWzmN
> YhFnIwgAgctDniJwlRxXB01eVlzXz7IulHnpSby07XEJxENSpGB8ufaeE4eK5gJy
> NVK6C2+1EU2vRxm4oIdcvtN4C4/jtRbYYjiSTx7eE4FmSkqshSnR5XCV72LDqG3i
> WbzInjMvYfysmcMXLfrWgxOnVew9WqEzlpEWlc7FfNKnkzBVf+JDztfqCUx0XM7H
> qefw4ImjqQw993QxJpipXC7aEGUyouB0RIBB71FkCa9ihlh9x7W68evbOI/jTn5q
> HWuStgS02sKHjRFliMbdbMY77FNUz4Yroo/GKSvGt64atxkQSJqPNAV+/9n18LNy
> QAH5eK6cXFPOIAaYpADU5kHDVVAFiw==
> =iBdx
> -----END PGP SIGNATURE-----
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.0
for any user-visible changes.

-- PMM

