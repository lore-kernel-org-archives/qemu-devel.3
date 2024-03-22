Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3750C47DD9
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Mar 2024 16:40:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rnhwH-0007Eu-6H; Fri, 22 Mar 2024 12:40:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rnhwF-0007EI-UJ
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 12:40:15 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rnhwE-0005oE-Hv
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 12:40:15 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-56899d9bf52so2767290a12.2
 for <qemu-devel@nongnu.org>; Fri, 22 Mar 2024 09:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711125612; x=1711730412; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uNeR5/Qku60sNPGCrf+nb2u/H4CBa2VUeW8ba0w9GpY=;
 b=tgCqLlMLXxTL5IxQBIX/YuhC0Fs8Jq7AZwck6KivrMwWeSycE0RqdG8DDgL+6ef2zE
 33bmMvNIQQRckHdfJCDNw26FuZ4/jsHfDf4PFszCBpRI48pPtnVTOsOHu7xdYi5wyugQ
 HxEbNT0eNqBNV7luWgK9Q686+R26DmsMXl8J5C97zB/ci+H3BIGghlO4VG7LwAWEzUVF
 GJO/6mKqW8GZqY1OhOe43o5SChiW3w2KMqkEHknKUXhsNd+yyuCOwU8Rnr425QZ9jsMS
 YiiOl9oii8iFPgx0aZDAX54ebEKWQwpUIKNQ8p56VzvkKuC8IblDvlPH7T9FHZ9AKvcE
 ckjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711125612; x=1711730412;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uNeR5/Qku60sNPGCrf+nb2u/H4CBa2VUeW8ba0w9GpY=;
 b=uFQVNSZTOazyVCAqTjEgLLaBX+12cAKXWkTJ9tJbhTjkojbQ9oitQZt4TehoFWluCd
 fK9YiFGizAcqy6MZsj74YJJv6fW2YX7XuURpxEm867tmpi3xszb9/0dNPU0UWS4pCpdm
 ffrS05UqPTmVcqNoEe5Sk+f9NwZXeQjcDv6XhA1feIB6Ant9M+MdjkVZnTzvLT58JQDt
 TsGGh8u1WobPtx0fqCh1iDCA8OKbK2F7gBZ5MvzEylcM5RWd3M+rtwGljl1oDd1GtRgr
 cBg+CG/jn2BPHH3LpzsWFFk+C57ottm35NO4fO6W4pTzYCTGnE1DJamfXgoV6IqPcF1d
 c4Lw==
X-Gm-Message-State: AOJu0YxyuLUDkTmUyztKU+LZaN2E9A0E8yDMAMx3ULJgDnwd3f7B3mKu
 +SuXK4kVh1LOxSs8VRyzRIwKWyvGNTbpIY91BXpzfD+a5ejkCpKG69y9R74LSe+Xxn5HDrhkz1V
 XQhJ/dGASZornmekh7OgKOUDVJhphY1INvltGfdim/kbUmMxs
X-Google-Smtp-Source: AGHT+IF6ufCuKJCsprllRzhIxJ9h25a80/gLl+asA+1YDtH3Rv5UbozJysaNCE4Aa5Br6Ar/9wFENjs4HlExuURKZ9o=
X-Received: by 2002:a50:9ec2:0:b0:56b:afe0:3070 with SMTP id
 a60-20020a509ec2000000b0056bafe03070mr38680edf.19.1711125611880; Fri, 22 Mar
 2024 09:40:11 -0700 (PDT)
MIME-Version: 1.0
References: <20240322155810.5733-1-philmd@linaro.org>
 <20240322155810.5733-2-philmd@linaro.org>
In-Reply-To: <20240322155810.5733-2-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 22 Mar 2024 16:40:00 +0000
Message-ID: <CAFEAcA8eES_5aeEp0vDs-nMdsbZ7JPodfTG-cBhtc_+a9rL+Uw@mail.gmail.com>
Subject: Re: [PATCH-for-9.0 1/2] hw/clock: Let clock_set_mul_div() return
 boolean value
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Luc Michel <luc@lmichel.fr>,
 Luc Michel <luc.michel@amd.com>, Damien Hedde <damien.hedde@dahe.fr>,
 =?UTF-8?B?SW7DqHMgVmFyaG9s?= <ines.varhol@telecom-paris.fr>, 
 Arnaud Minier <arnaud.minier@telecom-paris.fr>, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x530.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Fri, 22 Mar 2024 at 15:58, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> Let clock_set_mul_div() return a boolean value whether the
> clock has been updated or not, similarly to clock_set().
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  include/hw/clock.h | 4 +++-
>  hw/core/clock.c    | 8 +++++++-
>  2 files changed, 10 insertions(+), 2 deletions(-)


I guess this makes sense, especially since you often would like to know
this to decide whether to call clock_propagate().

We should also update the docs/devel/clocks.rst to mention this.

thanks
-- PMM

