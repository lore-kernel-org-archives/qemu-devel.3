Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E290EC10F1A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 11:58:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4JSW-0003e7-N1; Tue, 07 May 2024 07:58:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1s4JSU-0003d2-Is
 for qemu-devel@nongnu.org; Tue, 07 May 2024 07:58:10 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1s4JST-0001Bo-2J
 for qemu-devel@nongnu.org; Tue, 07 May 2024 07:58:10 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-572c65cea55so4805793a12.0
 for <qemu-devel@nongnu.org>; Tue, 07 May 2024 04:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715083087; x=1715687887; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=SHY4qNCmKD3/9ozABk0PGK0VBe5/q/mMNTm5fxVC62Y=;
 b=Cd68Njuy4+Y8Jfc1jaqMult5rQvAXjS3kpOSRzToGJiTP2GuzuckGAG89W1TJ2VIou
 R5uAG7GBAG+gPZ+lFUWvt4xL3hVvAqggewTBtWLw0jgvpMvoL1gMFEk5+ytzqX5wREtG
 W3nyVFHtDSTk7iQVy5LuU+sW2IpdtUmoK0L5Q8J/5A53vZ+Xr5ZFOMumGe291i4DDMAL
 QWuX+VO4tEgTEzTCRa7eVcfpzr10BGNejlAol6hZs879J6uUgG4SFmjxmok4EPw9G8TZ
 7hrXBa69BhgTUncJt5592XuUG2f9k84LzuZIVWBAdAuourpz1YMpckHTAwg/uQtbbFHF
 DtDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715083087; x=1715687887;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SHY4qNCmKD3/9ozABk0PGK0VBe5/q/mMNTm5fxVC62Y=;
 b=ZNpdu8ecFMEdcjIVG3cgS4gVJL+RDI+KvswfpF7KDfd66P2+M+CigQK8cTpzKT3NNe
 KhhHxtgWwSTpm0vGOWrMVDTCFEY/f/DUdpyZMOoKtH/GNtGdcy6OOblyEQbjsnW68IIx
 OjNhPbQwX8RyNhNc5fIQCrnMgkOz1xgv5WcQ6FGrEnrHwpYuARv/col7QjQaWMLci7I0
 yPV7JoqOXPfxSg1SfbQTUmK5sgwnzpnujgmeB+lN2pHKLOHSOQpti9zkm3S3qo0ajhGI
 KMWQjlIzA4OkTDhfujI0j4N7bfya69Vg300ug93ysnSxYeYaZEjuYAanboaltMH/R8Dm
 sMcg==
X-Gm-Message-State: AOJu0YxYi3tnAvVCcwwEBXRt2RW4BzjSEYj948PeqhtG4U3os5TkHAeE
 zHF6piwGFgW6+ttggWh03hXa0Jxpe2WONchxcJOiENlDm1d2rrphAHF2Tk2TXSIFJ6pfr+/sVJm
 9dbuqNp8tvYTElZmTWjOYxv7UXofYatqWS+AgWA==
X-Google-Smtp-Source: AGHT+IG4BGHFYAHaziJy2B9rBDj2dSAKWDINf5j6FVsVdduObsYFEKSuPiG8zK5CruaL4nYnmw4SVyfN4pFz2pOe0OU=
X-Received: by 2002:a05:6402:134f:b0:572:a087:304c with SMTP id
 4fb4d7f45d1cf-5731101d4b9mr2041338a12.2.1715083087358; Tue, 07 May 2024
 04:58:07 -0700 (PDT)
MIME-Version: 1.0
References: <20240507104926.179301-1-pbonzini@redhat.com>
In-Reply-To: <20240507104926.179301-1-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 7 May 2024 12:57:56 +0100
Message-ID: <CAFEAcA9uBWCNGDVX8C9nNV2xEHuZZPkMjHUWvvc8OM5h_ttv0Q@mail.gmail.com>
Subject: Re: [PATCH] configure: quote -D options that are passed to meson
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52f.google.com
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

On Tue, 7 May 2024 at 11:50, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> Ensure that they go through unmodified, instead of removing one layer
> of quoting.

Do you have an example of what goes wrong that we could
mention in the commit message ?

thanks
-- PMM

