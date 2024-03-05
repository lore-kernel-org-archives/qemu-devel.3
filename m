Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A5CFC54E41
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 15:28:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhWi7-0001us-VN; Tue, 05 Mar 2024 10:28:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rhWi4-0001uZ-W2
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 10:28:06 -0500
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rhWi2-00034Z-Kc
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 10:28:04 -0500
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-563c403719cso7861558a12.2
 for <qemu-devel@nongnu.org>; Tue, 05 Mar 2024 07:28:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709652481; x=1710257281; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UphnCZ3xP8e4Zwi8aB9kHv+9FQBR4vpSKI5825OqHRc=;
 b=pSMhgHfw4mf8yyvdSBNR2lNIX6Tqr2b8RdWw8jruCb5XIeudAbysWQeuC++1cJrJQA
 Jq/vqL3gH66jexPFDa1iJiDfWhnpp9sQ+6gJfQGC6iRe4RfpY4mP9R3XEP8bJYgCye9o
 CMRu8a6tWTHcgw8ZKlQ4KG5dWNOYwwbKjk78k70Uasr/6jxnyMRatohl0pmf7g1Iu2oU
 3fE9n9NLntOwUAZA9HWO6JtojRolYEJgz4I39AW0IBFxrcFChwBDd0+S8F0NZR5H4l2d
 7Z2NiF5l1Y57LbevTg3egfEU/Lc2lttUQWAJNCHJXRnba73aZn8UE7nyj32hblP9CwQ9
 60Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709652481; x=1710257281;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UphnCZ3xP8e4Zwi8aB9kHv+9FQBR4vpSKI5825OqHRc=;
 b=VAjHnKj1pgaP9MscRu2CDWHvNh6IJf6qKOyec6lZ4xpqOkQXMfgadb1/VRt0g24/zY
 h6XgSTyn9eb50Pmsjku+Hjjt8TP82YJgz0HJssyaB5+9ZrFC8/HSv5IK54ckVcokOYq6
 H2MpZttpR2KZTvAijZyxj+bGuLFtf9wVH9jvfQNlPhbbOHTYqZMrlQFEJg3ds0s5dQqx
 zum5wX9LtKv/zuRmmNtF/eBzxHGKxEAW063W7JVUp0RIknKJA9pVdehe6HomIdMvTI6c
 4nPrXmQmiP7GvTphrnSVsxpEGrtOEVbIwoBsiicET5uwxaIPp7PpVb6av1vaj3uA2ico
 Ie2Q==
X-Gm-Message-State: AOJu0YyVGhBAHw6KjiAwv0VNKfdnEWKvbsAw6R0JCS8R8Q5Rp5k27ogT
 ZhqfSrJu190/85hGzIJA2jNUkbvE4LKlhzgri8qi1syovYIBbbLasc8x7o7+ZcB36WVVG8WxgQj
 mBC1Z/FktZgwe9Hi27AlKH6DMAoiUN4CMjvQHELeSVY0NHzY0
X-Google-Smtp-Source: AGHT+IFKGUyLRf2xGEIWF6Uz1JkIvO1xklpjmoWOrJalp0ozov9QuUndQdBz70W4eoGPXxz0+LztVpCQCbp/YuASbLA=
X-Received: by 2002:a50:cbc8:0:b0:566:d27a:2ab5 with SMTP id
 l8-20020a50cbc8000000b00566d27a2ab5mr8609762edi.10.1709652480791; Tue, 05 Mar
 2024 07:28:00 -0800 (PST)
MIME-Version: 1.0
References: <20240305110608.21618-1-philmd@linaro.org>
In-Reply-To: <20240305110608.21618-1-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 5 Mar 2024 15:27:49 +0000
Message-ID: <CAFEAcA-D-GvgNTshzCQbRS1Os9M4FFRnm=ucJhFra7jJ55dacg@mail.gmail.com>
Subject: Re: [PULL 00/12] Cocoa patches for 2024-03-05
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x529.google.com
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

On Tue, 5 Mar 2024 at 11:06, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org=
> wrote:
>
> The following changes since commit 52e7db443bd8d233acc3977bd150bdadb62db8=
6c:
>
>   Merge tag 'hppa-latest-pull-request' of https://github.com/hdeller/qemu=
-hppa into staging (2024-03-04 16:01:33 +0000)
>
> are available in the Git repository at:
>
>   https://github.com/philmd/qemu.git tags/darwin-20240305
>
> for you to fetch changes up to 5576663208b7c31766c580520df506375d00103e:
>
>   ui/cocoa: Remove stretch_video flag (2024-03-05 12:04:41 +0100)
>
> ----------------------------------------------------------------
> Darwin Cocoa patches:
>
> - Add 'zoom-interpolation' to smooth scaled display with 'zoom-to-fit' (C=
arwyn)
> - Set clipsToBounds on macOS 14 to fix window clipping (David)
> - Use NSWindow's ability to resize (Akihiko)
>
> ----------------------------------------------------------------

I'm going to hold off on applying this for a few days in the hope
that the fix to homebrew's glib package propagates through and
our macos CI job runs OK again. If that doesn't happen by the
end of the week I'll apply it anyway.

thanks
-- PMM

