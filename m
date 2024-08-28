Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5463BC5B54A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2024 15:45:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjKqh-0004nz-5W; Wed, 28 Aug 2024 11:44:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sjKqg-0004kc-4k
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 11:44:42 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sjKqe-0007UB-Fk
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 11:44:41 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-5bed83488b6so7844250a12.2
 for <qemu-devel@nongnu.org>; Wed, 28 Aug 2024 08:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724859879; x=1725464679; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=G9J6pdc/DGhDnSd3tg/nULMI5p8jWRU0Epq1sMUMrlA=;
 b=i0bdZWJoXEa6E5UnRm2S4o2soXMQxuiMpLomZ1t0sadXpN42+TjSVjyX+g4X0JUA6P
 DQlSG0OFCjYTPue3AzRKcAhP0/7TtSK2nKV4WlAmVvTyohx4mMLjJnB6flcyTw12AfOq
 PCkjzDm1OvWu4JWgjDFP8stAME4n4/XNj5H082VFNSgtuaUr0SHgx8ATueXVwDbstYde
 awmzLE4j4m4by/eKzF5raIC+5bQ72gmF6cJREhNTq6AYauEdH2F14g1riLicrSYjhoE9
 3atzguZALUNLfJIwaHKQT6BC5DnygGQd4tthsKJCwgHHk2jNfeCv0zgYEvNJHy2KjD+h
 OqaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724859879; x=1725464679;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=G9J6pdc/DGhDnSd3tg/nULMI5p8jWRU0Epq1sMUMrlA=;
 b=kFa3t2jXvQgl+B+qwtBeX1d5ELyhAvL6DACaprEQKkm6GMyGdyw8UxDNS984m+gCnQ
 29FHiBJ4EMyEuyOa5nVfkbUK9VD++If8Wq6n3esu72HHYE9DMfCoSGjxp2waJvw/I7m2
 sbJZ3DekDGY0DbHDvBT6IT8jg6YXzHctbi68dNKgVqHY2pNXe2oPNev0YLg/bgfc/zQf
 1xj4KFDBrEJh/oJOmqMFxtFpbkXkuMRSE9e3NzeYeOexPDoQn1983N13XNYo1DnRbEzW
 5PQL3t6oTK8w6BSndKiZUAAmLgGwfNak+c+MniZ/a3HpTydSVPXEUSq5RUxnE/o+feIM
 nu/g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWXBYZ9Z8EhygcH64CI6yrLTyXVmpz269RvbhWp3oqzmgxJfMKlkGmpO7pMVgzTdP1yMgm6GuCAOR38@nongnu.org
X-Gm-Message-State: AOJu0Yz02JZAvzpCYhCwrRl/UNBaMwAhmRNlubovokWKUAXyo4/xoXzt
 2yvDVE+yOosvPaixvecJyUBP+GdscnW7KmP9K8m2020eMubdZDrfE/cp9a75PF+dt291LSSXCWn
 uYYYES0BIJW8z+3Pmp1UP3X767/32atJ5WOyElw==
X-Google-Smtp-Source: AGHT+IFhc623i4Ezu2hvwjhkuGiIujxd9nUjsYZe1eTSCetS6fw7UFtukqDCpOGtNNcJDp8QaOCRQ6WVykHO/97pGZE=
X-Received: by 2002:a05:6402:d0a:b0:5a2:8bef:c370 with SMTP id
 4fb4d7f45d1cf-5c08916403amr12289916a12.15.1724859878821; Wed, 28 Aug 2024
 08:44:38 -0700 (PDT)
MIME-Version: 1.0
References: <20240828043337.14587-1-npiggin@gmail.com>
 <20240828043337.14587-3-npiggin@gmail.com>
In-Reply-To: <20240828043337.14587-3-npiggin@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 28 Aug 2024 16:44:27 +0100
Message-ID: <CAFEAcA-_o36LkE3YSTM6JDW7z6Fdsru0VtPT30PRn5skaes5Kg@mail.gmail.com>
Subject: Re: [PATCH 2/2] chardev: Remove __-prefixed names
To: Nicholas Piggin <npiggin@gmail.com>
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x534.google.com
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

On Wed, 28 Aug 2024 at 05:33, Nicholas Piggin <npiggin@gmail.com> wrote:
>
> Peter points out double underscore prefix names tend to be reserved
> for the system. Clean these up.
>
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  chardev/char.c | 20 +++++++++++---------
>  1 file changed, 11 insertions(+), 9 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

