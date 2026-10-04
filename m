Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61ACBCA5FEF
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Oct 2026 16:21:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDOy8-00066k-1o; Sun, 04 Oct 2026 12:21:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1xDOxv-00064Q-Ee
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 12:21:32 -0400
Received: from mail-yw1-x1133.google.com ([2607:f8b0:4864:20::1133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1xDOxt-0001jw-Vh
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 12:21:31 -0400
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-8ac9d666d4eso8213017b3.3
 for <qemu-devel@nongnu.org>; Sun, 04 Oct 2026 09:21:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791130889; cv=none;
 d=google.com; s=arc-20260327;
 b=fKPZoQmP+RMegFSVJJsuXNwfhaG7E1r9iBxVXK5b3KyR/9DrJ0q4jb2xTbRJ9L9Kt5
 qasW8M5Hdf3UH4aLJLc+Y+oexmuhCcwPJcrxGTkMOcDHS++4P+LLoUiOdRGUsTKpypQ9
 0kFxPRUVjx+9ADvN0k0i5rn+aomamTusioZJXPfML6lWP/ojf/aU194yLXRzYQuidiML
 gwhTuUzsIwnz+0k/M6UWDMvGUa48ubc3kufW0Rh6R4+CThcGPE987vkR6ShiQEOlg6eQ
 xQoC+yLU1zFJ/zZ82hcqmOzxvPtznYGclyQRYM3P8pGWkNbbexMKpGosWVmjIXkGSjPG
 5ovw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=4gsK/d0q0ehiNmWTKW6O9tNfG9O/1FIlMej4M+HIvxE=;
 fh=/0IC5dMyt1pYrKG8Th8uxNlasmylZbudYuns8eU0grQ=;
 b=k2pdV9ZMZvDNP09K5VvYzKSBo0Xn54wZkEDYB0LkA8q+qhgfg5pJVvYUv0akhB+Zie
 z0xxhCHztrOQbrxznBtshYICuafmlzCRDAPYR5KBBwlLGSpIUxdWHOI58yT73xG2wYvX
 xAT4/aCcpcscqiKNwzP4dCV/15EmLld5HjTMMiTCZR5J9JtqHYzlZpz2WeeUWQeU27M7
 f4dPWXy3F5fTWx8w0pbg6cqvPaNCKMdifKzGd8htVbuMEECapqVuXsu968FXcbqky0tL
 TyNKW5LJWhzf97vLUlnf09+JjfB5HZa/rxal/Fyop9m01FBGxYXAvu5JcvmBvIzY+nhg
 Li6A==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791130889; x=1791735689; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=4gsK/d0q0ehiNmWTKW6O9tNfG9O/1FIlMej4M+HIvxE=;
 b=jqHzIw551XcmZmGvbpjReuVZ4NzVQZrMmN83O4x2oocq8Nji3g2O1YK1xuXZMLdAOJ
 HlcS3tZiCHvVGc0hXwl6/1ys5d8ubm2TiVHxWaE/vqXuPyzHjeDjOJ1vELvdDtfTAnEX
 TTg4hguMHBFRuxX3tIGRb9wlfvtUGfBt1rAER6yLy9yYpVU3Zs6hMShcwUwzhru8FkxA
 7L6WyXWu3rZbwhfbbPEUA+/tRk6wY4//BuDbr7B1Y3LNnQLTihLAoLN+H4pVhumHGnlb
 rE9KS950i3oK4R9uV0+E6lsV4dCGw5l6FlqrR9ktx0W2ty9xoTpyAjFKOU7WUlohLe/j
 CyNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791130889; x=1791735689;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=4gsK/d0q0ehiNmWTKW6O9tNfG9O/1FIlMej4M+HIvxE=;
 b=pfXtyfhLAv8YAi5B3mdYzM+wIMRUviwbrktOOr3KW52EvleO3sDl/Sz74RhcpTlfpF
 UKEL+xbPbvN2vjQu2jDDucUY7jX3ENLk22DGLQx/7gi01sPyPsV+RD6q59aIO1s4DMpt
 RdAl7lXo93nTvUsEHMZXjhb1VH/jNEYCyyyCNWQnzcSKuaKqmD0ibd9lYcREqh4wdqOJ
 TUJxEHQom59qH7SIwTIz9HJdamDnEmf21862PBm2Ir6+XZZACWde4XpQ+fAstkmYi3TC
 WbiETDLbuAV15gx8oqHfaeGLBegYprLOyufYko6ZQF/VJY1B/2N7QaQ4UQa9WElR6NEU
 wtaQ==
X-Gm-Message-State: AFq9FYK9ABSlFZer2k7VgoJAdwpEC+0vE9dMAiqGUP0Ol/7gBCTfGnhG
 ftjyMqz7P7a4wE2ZSNTzYIzQYWjLdhqlBAlzZpcKZXVzCLzP18b0K2KkBk/z5UhZlYWOsL3VtfB
 j46+uAE1NnbEU3gLTD6AjG447xwThOIU=
X-Gm-Gg: AYBFou0Lv7wFe4ZXZHcQm3P88yExcpHTo5dZ/BqMfeUxM7uP6CLNnRPq3hiZiqM0oiP
 XHnd/OP8LfAyTAMDafadAvMH1sP0uWh6HyceognWCgcYCuQtw5kRAW3cOSi59fYvOT9y49hie04
 QAZXkBro6awvd8lDXX0gSjrQbc9olaKS0c1iDaSMz5OUsqOz4yao9mPe+vFh1CHGxu95o9KUFXi
 AQIHs7LmiyT5PDpCHl+WBu8MkjZxrmeV6i/PQerTVEBQpsGp/P6K16A4FTnTF7wMx1wka83lGhS
 kkMOojdJPSa4PGOnQDNg7vXOQXIAA1EhMiVwfRHOPle9qpNGaTU/ibDnVLnKv56u7jizccRx5cK
 xayWkCLiUj65YU6w=
X-Received: by 2002:a05:690c:e3e8:b0:8a0:e27e:8e75 with SMTP id
 00721157ae682-8ae951fa642mr18052627b3.82.1791130888524; Sun, 04 Oct 2026
 09:21:28 -0700 (PDT)
MIME-Version: 1.0
References: <20261004122647.3913-1-shentey@gmail.com>
 <20261004122647.3913-22-shentey@gmail.com>
In-Reply-To: <20261004122647.3913-22-shentey@gmail.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Mon, 5 Oct 2026 00:21:16 +0800
X-Gm-Features: AclHuK_1W2qS_waYy4Np_-BRAdGJTYJ6CNIOmg3xlU88F8rxp4YASb54Lcbf2Dw
Message-ID: <CAEUhbmXwKi5r9Ye5eVoH61dNJcJO0EsqRQwJVJsN2feZYjRqLg@mail.gmail.com>
Subject: Re: [PATCH v2 21/30] Kconfig: Extract config FSL_IMX{6, 7}_SRC from
 config IMX
To: Bernhard Beschow <shentey@gmail.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>,
 Gaurav Sharma <gaurav.sharma_7@nxp.com>, 
 Alistair Francis <alistair@alistair23.me>, qemu-arm@nongnu.org, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Jason Wang <jasowangio@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Bin Meng <bin.meng@processmission.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1133;
 envelope-from=bmeng.cn@gmail.com; helo=mail-yw1-x1133.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Sun, Oct 4, 2026 at 8:29=E2=80=AFPM Bernhard Beschow <shentey@gmail.com>=
 wrote:
>
> Over time, QEMU has grown a number of i.MX boards and the monolithic
> config IMX drags in unneeded dependencies into each SoC model. Extract
> SoC-specific config FSL_IMX{6,7}_SRC to eventually eliminate config
> IMX.
>
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
>  hw/arm/Kconfig      | 3 +++
>  hw/misc/Kconfig     | 6 ++++++
>  hw/misc/meson.build | 4 ++--
>  3 files changed, 11 insertions(+), 2 deletions(-)
>

Reviewed-by: Bin Meng <bin.meng@processmission.com>

