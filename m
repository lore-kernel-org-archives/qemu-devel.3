Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5287DC369CB
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 04:41:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9cln-0006SG-5x; Tue, 29 Apr 2025 00:40:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1u9clg-0006Ry-Vu
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 00:40:29 -0400
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1u9clc-00044l-MN
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 00:40:27 -0400
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-ac34257295dso939992366b.2
 for <qemu-devel@nongnu.org>; Mon, 28 Apr 2025 21:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=jms.id.au; s=google; t=1745901622; x=1746506422; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=V0v/TYwvjG+d6TWayOXNWFPo/MJkvEdg7WvDq2KVH/I=;
 b=lV5jMXJV0ioYeeYI3oYK3828FRE3ao0pZXF51/4bPoha3O8l6ntzlrmldThjPw0Hhi
 luy7P434NargsRPFlS0WEOi0SQXS7d6fUJG3CokxdX4zeo+hua6UAf6/zopuRCkSWoYX
 ExmexLN56CYfvaFNj+iVdjCL8Re3PJuqpTz7o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745901622; x=1746506422;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=V0v/TYwvjG+d6TWayOXNWFPo/MJkvEdg7WvDq2KVH/I=;
 b=OqF0hhxDyEv1Kuo7kNJxS/8cxP2QypIfOiy0jQDjlx/5a0S2PuZxTb7uQoJNFHMMHk
 +MnuLcXt7vI8YXY4spkttysq7u77YzBe3vCWqc7UzzQeQA2zUsfSNmabC/HGq7Y9M7gx
 eBG05n/pOoOxrRvB6q0F69JeQnNghdF2NvDoHPKUC+39tBzte69WkXO6cH8w+hKkSoLM
 pnDztXBxB3xltPcBoWFmn8meE90hgfq7SVtUSUGypGlEQWp9gA99/GI6xneIUkjiO/bo
 CBegAZet8FX2inrH0/eshXt5TgolDRmJGAg/jNzdtCfCvri3Iyp0QJQ41KB66lhYrr48
 Nytg==
X-Gm-Message-State: AOJu0YzqIh6cdS3uA3zr1RPgIYWRYl3Twbl7Klvvi7VoRqC82su6x6UU
 3cmDtuumMU3jc+WoB7i8UsrFmm4vomzlngjVSqSXmQvnsAYIWGrPUbclPWP4ZQwNpap7Pi8sMoK
 fmzyoEZhdohX0XAIJQoVjsxuYBLs=
X-Gm-Gg: ASbGncuN10zY5qmO3BqeZ7oFZjg7MV1hjTTXDz+1l+ZiiuAXIF/VdleiAvG2PrS+D+J
 Rbrms4mBWRVTk1vxiDYElYTgweOY5rRrtti99JMyf375hSpGstK+zcUFjcQEGTJQRHPnRGexN4v
 pmLrdgHFwYBw4N8yGCQGWcaA==
X-Google-Smtp-Source: AGHT+IHjOEntMyJx17/hHLInk1lQ/Q3mH9BgNlwZ32m7IQEm8BwTg9MYpPQhbTrL3pfXEvZ3QKNG9ZmzZPBs2QOV3dI=
X-Received: by 2002:a17:906:f58f:b0:aca:d2f0:d291 with SMTP id
 a640c23a62f3a-acec4ccfda3mr207693166b.5.1745901621552; Mon, 28 Apr 2025
 21:40:21 -0700 (PDT)
MIME-Version: 1.0
References: <20250425115912.912889-1-djordje.todorovic@htecgroup.com>
 <20250425115912.912889-10-djordje.todorovic@htecgroup.com>
In-Reply-To: <20250425115912.912889-10-djordje.todorovic@htecgroup.com>
From: Joel Stanley <joel@jms.id.au>
Date: Tue, 29 Apr 2025 14:10:08 +0930
X-Gm-Features: ATxdqUFuUyAnM0ez5CUdzzmeHRB1uomEePg3mqMWEQhV_yH0GdDSgXjbUa_8vOc
Message-ID: <CACPK8Xd3LSxOT4KO1gUCjCqq9Ro6rXfr+_BSAQXeaTv9+2b2GA@mail.gmail.com>
Subject: Re: [PATCH 9/9] hw/riscv: Add a network device e1000e to the
 boston-aia
To: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Chao-ying Fu <cfu@mips.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=joel.stan@gmail.com; helo=mail-ej1-x62b.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.001,
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

On Fri, 25 Apr 2025 at 23:37, Djordje Todorovic
<Djordje.Todorovic@htecgroup.com> wrote:
>
> Add a network device e1000e to the boston-aia board model.
> There is no pch_gbe emulation, so we add e1000e in slot 0 func 1,
> instead. We need to pass func to call pci_parse_devaddr to find
> out slot and func.
>
> Signed-off-by: Chao-ying Fu <cfu@mips.com>
> Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
> ---
>  hw/pci/pci.c          | 23 ++++++++++++-----------
>  hw/riscv/boston-aia.c |  5 +++++
>  2 files changed, 17 insertions(+), 11 deletions(-)
>
> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> index 2844ec5556..9748acda09 100644
> --- a/hw/pci/pci.c
> +++ b/hw/pci/pci.c
> @@ -980,16 +980,15 @@ static int pci_parse_devaddr(const char *addr, int *domp, int *busp,
>
>      slot = val;
>
> -    if (funcp != NULL) {
> -        if (*e != '.')
> -            return -1;
> -
> -        p = e + 1;
> -        val = strtoul(p, &e, 16);
> -        if (e == p)
> -            return -1;
> +    if (funcp != NULL && *e != 0) {
> +      if (*e != '.')
> +        return -1;
> +      p = e + 1;
> +      val = strtoul(p, &e, 16);
> +      if (e == p)
> +        return -1;
>
> -        func = val;
> +      func = val;

Some unrelated changes have crept into your patch.

When you re-send be sure to cc qemu-riscv@nongnu.org.

