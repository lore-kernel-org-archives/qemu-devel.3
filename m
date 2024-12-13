Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94E3CE7717D
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 13:43:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tM5wl-00048u-Md; Fri, 13 Dec 2024 08:43:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tM5wQ-00047J-MP
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 08:42:54 -0500
Received: from mail-yw1-x1133.google.com ([2607:f8b0:4864:20::1133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tM5wJ-0002xV-AI
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 08:42:48 -0500
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-6ef6ffcc2dcso20797807b3.1
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 05:42:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734097360; x=1734702160; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=E1jBTIw2Sl//NPOzTInPBD9Stv0+pQd5hXrYIhxDQr8=;
 b=wK3YLoy5tckclS2OI4ApkO7KhyIRUx3It2EzI8vrekhl35SiHdoTuFNL2HQMHGgGFe
 UrZIqNqRlFzjnasjAXjYlV5XLHQ82NddT9KQaYwD6rAOAMHFyUaBl2yg+JKHtFSjws04
 x3W+n2ghdt5kVhdPLYCevGqwRFOsGj6EjayomvOlPiJ2Ev9SsBa5VI0UoF4+eRG9msgb
 TZGzwSinI83XjI4H68PL0MBSeAgwC8PTM2fK1FIvVlvlSJAGy/UXb1SuqHRABvWluScF
 QHUwOv1Dk94Mn6PEfjrTZ+6hdXD6ROIVraCD15aL+5HsvDIflAnyJa64EZ/TeRSDk7aj
 X9oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734097360; x=1734702160;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=E1jBTIw2Sl//NPOzTInPBD9Stv0+pQd5hXrYIhxDQr8=;
 b=peEoxVbP0UUwutJxoE5h0sO/54Rru/55xJ69EJXxgOIZrUW2T7hJlPfHy7lBt0Iwam
 l4M/3YWjHFpYs0auBiM44bU9KlTszF+LuTlpEdXmHfja7wsdjfvErCzV56ehWT8y+62c
 B/b01NGV4Pmo8OSZklpOcsrFSiUGFVONwpvVA2KhJ/yQfyu5sq4VuhEAL3vkDezr1NaQ
 XsRccvHe82hdo8ug4mVDaw/SHiTB8NT1z2SR4mNszuVR0fo9SSOEWcazxa/dmu4HKzuO
 wzNztGk3PnRa3sZu+IoK9ICkIxip2LHs0yeznIXWeVsy2zeB/oZufsuNi+p/Toak7sdt
 pTBg==
X-Gm-Message-State: AOJu0YzRZg80QgPLmvRIz1XWS1LiM/JgR/Jn1mD6NnrrM+4DFAtbAD/T
 ZmhNZZRbSrsTQwubUYJJVQJKIVHluY1/7RpK/eAUdgWaseF+RzYgiK99d7Y3O0ujxmUvd5CD2wM
 5kX9fZCl88sR2t4cATvViy8LFBQhuVZ4OEVD0Lw==
X-Gm-Gg: ASbGncvRnGu1OUZjUPcP6Kt7hfcuPdKZnFzSVnetQoEKK+skBwwoeFdTzkd2bIy05BE
 1g30nmm6WPwSl3xu8An72kCpVVbnoPp+iSxErj/Q=
X-Google-Smtp-Source: AGHT+IGzCqGrsr3B0BDyk/NAzfQlSG6Ef+zDEuIzcu3DiWeOeZumKC/zUvulMqg+Od7mvfXXOqib3s29qiBMdIeelF8=
X-Received: by 2002:a05:690c:6ac3:b0:6ee:4855:45de with SMTP id
 00721157ae682-6f275c4ed77mr38076327b3.9.1734097360723; Fri, 13 Dec 2024
 05:42:40 -0800 (PST)
MIME-Version: 1.0
References: <20241211163036.2297116-1-richard.henderson@linaro.org>
In-Reply-To: <20241211163036.2297116-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 13 Dec 2024 13:42:29 +0000
Message-ID: <CAFEAcA_B50u-57tv4DAEG7wdE7FRSay0VzrCwC2S1Vv4iKLwJw@mail.gmail.com>
Subject: Re: [PATCH v3 00/69] target/arm: AArch64 decodetree conversion,
 final part
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1133;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1133.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Wed, 11 Dec 2024 at 16:42, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Finish the conversion of all aarch64 instructions to decodetree.
>
> Changes for v3:
>   - Fix decode for f16 fsqrt (vector) in patch 23, prior to conversion.
>     This is the only patch without R-B.
>
>
> r~



Applied to target-arm.next, thanks.

-- PMM

