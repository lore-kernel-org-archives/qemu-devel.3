Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 859BBC36002
	for <qemu-devel@archiver.kernel.org>; Sun,  6 Apr 2025 23:32:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u1ZT6-0001GW-9g; Sun, 06 Apr 2025 19:32:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1u1ZSz-0001Du-Tl
 for qemu-devel@nongnu.org; Sun, 06 Apr 2025 19:31:54 -0400
Received: from mail-ua1-x92e.google.com ([2607:f8b0:4864:20::92e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1u1ZSy-0003n3-9F
 for qemu-devel@nongnu.org; Sun, 06 Apr 2025 19:31:53 -0400
Received: by mail-ua1-x92e.google.com with SMTP id
 a1e0cc1a2514c-86d42f08219so1551428241.0
 for <qemu-devel@nongnu.org>; Sun, 06 Apr 2025 16:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743982311; x=1744587111; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QUaqkTg4jdxcQ97gZFa3a/janMRKcKb4fwWv+HFVvrk=;
 b=Wz4amf6bs65LnkKQqULlDVoFipHquoNG7zqcezwLToNASQFrcFfTOYU6rSG+noVyhr
 JfS6JDwHCRJdVQu86vCI0RG6OFGp9Ezg+Bq7+JBAyXsumfhHG/VLMrzivjQWI6igXarK
 jsM5pM9mXA98NTn8gOWU69xQHZdSkaVHl2hIOn2oEwfeXrGhSEUk7+zY5KSlG+XEutk4
 Jcmv4F0+U2WIwzw4fnJsl3u5w8RrN7vncNG4z8/FDOr/nwjTxYsoXzi06RBeJ1bF9PUU
 8kYgUnNEojwKXYh67R/tcT4HjVwylMygYnYnOY5o3kryNgw6aqqeQd+9WzLJKPFmU4H+
 wlbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743982311; x=1744587111;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QUaqkTg4jdxcQ97gZFa3a/janMRKcKb4fwWv+HFVvrk=;
 b=KihIaDFIt8UUonvS7QmpuaAP6XTtKsLgyxMuuuswZMaEbR3cCNam/izXV+25MnwhcH
 RXIjmZzDbO7qIIYbPpRWN7XUKwpo6nHtNKAfLz99fBvFRpqCiPGbojwLY1OIFAa3oRhh
 SVudeKtDt+wbVKVh2M1NmvCIg3+T3CX2w+PXhhxWvz1wP4qR7LQWLlPK1oVCGkX1404X
 tc62eYBQJiIPeyC5z8fR0Wdgr1RR0nu9NNBT+UChax9rZLcgeTQaJ738bWUUGWhP4WE0
 W2t/3DRIFW6brJXLnvYK97tAOBGTVIpOwr19MdnM+BxzZnKdW8q8bVlBSJzcZjN09u5n
 VbSA==
X-Gm-Message-State: AOJu0Yzd8fkboTwquT6arFWPpFH/2JxpGcxqAdOAyp5H6GkRGvfEkh7n
 DJQOvhztTzd5q49HUcXupVvCbDIEGb4IYzO6kQh7smgsG5svWRtsxYLlYIdGAKPfbTwk3g3Uhgp
 XEEHP3bIVgKxvDgVGsYnTwcjdVsyR0g==
X-Gm-Gg: ASbGncvJyvd31PY8IEwDNw6KX+RNAafaJNaNHlLiK+JZZlJTbPmru32jMZ8BX1YH3EL
 wpoDF6bgX0UESE1POGXsTRJZEpas3a7fGaUETXr8sd76wCzf5kk5z/Z2HRaOVqX3GgmYbUXDRVL
 9CtUhIr+Z6EXLJSf9JLe0mAilEsUoyiCbsWFUVTenUpwQ3rn6xDt+MQx+f
X-Google-Smtp-Source: AGHT+IHsiTwMf0tjmSjdCDU+us+EASBXfd3ax2RMZq7pfnV3OoZ/O2tarTuI8w6Oea8NPPtFFYFjN1A4vjrKqVvFDqo=
X-Received: by 2002:a05:6102:510e:b0:4c3:6215:9f86 with SMTP id
 ada2fe7eead31-4c85547bf34mr7703156137.19.1743982310806; Sun, 06 Apr 2025
 16:31:50 -0700 (PDT)
MIME-Version: 1.0
References: <20250404152750.332791-1-dbarboza@ventanamicro.com>
 <20250404152750.332791-3-dbarboza@ventanamicro.com>
 <debc3677-3282-4064-a34c-0234d0eb7a78@linaro.org>
In-Reply-To: <debc3677-3282-4064-a34c-0234d0eb7a78@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 7 Apr 2025 09:31:24 +1000
X-Gm-Features: ATxdqUFNKzdlpdBzlROVuTkZX3IIZV05bk7-HS_QEvMHe71GUpTAtTbTSzazs_s
Message-ID: <CAKmqyKNMUU3brR++stxae1VmSW2eJLRGpxOBr4+FJWjde3Yt4A@mail.gmail.com>
Subject: Re: [PATCH 2/2] hw/riscv/virt.c: change default CPU to 'max'
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::92e;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x92e.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Sat, Apr 5, 2025 at 9:02=E2=80=AFAM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 4/4/25 08:27, Daniel Henrique Barboza wrote:
> > Using 'max' as
> > default CPU is done by other QEMU archs like aarch64 so we'll be more
> > compatible with everyone else.
>
> This isn't true.  qemu-system-aarch64 -M virt defaults to cortex-a15 (for=
 hysterical
> raisins), which is completely and totally useless.  Which means that one =
must always pass
> a -cpu option to qemu-system-aarch64.
>
> Moreover, -cpu max has zero migration guarantees, so anyone who wants to =
be able to
> reliably migrate is encouraged to use a real cpu model.
>
> I suppose, for throwaway VMs, -cpu max is a decent default.  But there's =
a lot to be said
> for not specifying a default at all.

I agree. If we aren't going to specify a default machine, why specify
a default CPU?

It probably makes sense to deprecate the default CPU for non-vendor
machines and then force users to pick their own CPU. That should start
in 10.1 so it's a release offset from the removal of the default
machine.

Then maybe think about even removing rv32/rv64 CPUs and push people to
the profiles, as it's a lot clearer what they are getting.

Alistair

>
>
> r~
>

