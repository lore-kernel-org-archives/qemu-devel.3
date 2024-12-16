Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 336FBE77180
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2024 16:57:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNEOp-0004J4-M1; Mon, 16 Dec 2024 11:56:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tNEOn-0004Ij-D2
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 11:56:49 -0500
Received: from mail-yw1-x1136.google.com ([2607:f8b0:4864:20::1136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tNEOk-0005fM-GD
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 11:56:47 -0500
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-6efea3c9e6eso30740297b3.0
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2024 08:56:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734368205; x=1734973005; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=2DkDZEwqGEHB6RYdbqnk6V6GpbtChe+u6hKVPLK8WjI=;
 b=WUfQt1XzcgPD/2k8vhtBGlamQRnEILR4qhYNRJsKp1VjuvAANJMDI9hDHDULs7BONF
 N25C+hxYqOh20FlLQx5NsLLU8Bg1wBAEYaTbb4XUJCKkPF6nUl1yJnIUjd6MhQL+du1N
 iJoab9hGm193zZ1nBFPLyvT3WUlojgzv3a3nUFC/ErxYYD6KaQ5BGeBq2ki+JS361ypo
 UauOW17zPXQ7GxnZv3ldljURL+MezkDWZcDScXoAOcXLobkG/KVhvvfNgKv6rf1kHS0L
 2ZhYlguoCbK6Ux2ZEg6upWloaIl3Bz43NwA6hOILgn1HkGia3FDsRHzaz0sD81COjE0I
 AEpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734368205; x=1734973005;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2DkDZEwqGEHB6RYdbqnk6V6GpbtChe+u6hKVPLK8WjI=;
 b=GV3rOkVA8Joh5nJOxG0m/8HSqyEdvgfP8dc51RF6yLgakfU9pZBzff2xnmaR5BvniZ
 /Ht+DiMjc3CFalJFCeUwbMuMd4eU2LEh5xWB64k0nPcawUr/czBOSYPa0xibIUdz4j/U
 Zmdwb0Hh46eW0hJAiZWaJLoM47+/L9EmeDy3ooiMk3iKQBAOJI29qe6udZVrKgYFRolR
 wc8XNLOYKQn7p90HkNobjUXAhgR6sFFxdxG3l4WQ3g/4GXFnA3iWn2MVsh5KP5k3qBZI
 /PUSYCGeYOEe7jOe6VptoNcZhx4a/9XPZdNxyvq8rACZ1l/ERy4J0z8MFLLvCWa9tqhr
 x/4A==
X-Gm-Message-State: AOJu0YzrxC3fu9DHgXV528pmTYRIOi5Ljt2xH7aMW99tw+FJpytjMUDp
 X7TD+eMGocENRtXVjz+BtSqNRM6N90AXKvREo8s8j9u/mUa6qafx1dfGGJSwzWdW9Tdhd6g+5E5
 e+MoUZq6pq6rxOfT/gKl3LkrcGtmIIYEEZOefaw==
X-Gm-Gg: ASbGncvcTWu3sr+NvnlgsKqjfGQ3DIocPQ3gI/lScLf+CtyRKGNOHbHvv4Vgh5LMJrL
 HejpL2VJSDJJRbN15OM4r/9MklD9636X5Mq/bucU=
X-Google-Smtp-Source: AGHT+IE/A9vIdG9fVbEYKyIBIdquDLITsj0jitt5CHNztNIfg2lHqv0IuS4Y4A9UfBTsZVbdiNMK1R3jIchR3+L3rzo=
X-Received: by 2002:a05:690c:6a0e:b0:6e2:12e5:35a2 with SMTP id
 00721157ae682-6f2bb2e857amr2852747b3.4.1734368205237; Mon, 16 Dec 2024
 08:56:45 -0800 (PST)
MIME-Version: 1.0
References: <20241216161413.1644171-1-peterx@redhat.com>
 <20241216161413.1644171-2-peterx@redhat.com>
In-Reply-To: <20241216161413.1644171-2-peterx@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 16 Dec 2024 16:56:33 +0000
Message-ID: <CAFEAcA_u++fJudO1ca9q76NYWTg75PRGAEHBqDyjUDEnR5m8Cw@mail.gmail.com>
Subject: Re: [PATCH 1/3] osdep: Add qemu_mkdir_with_parents()
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Michael Roth <michael.roth@amd.com>, Fabiano Rosas <farosas@suse.de>, 
 Konstantin Kostiuk <kkostiuk@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1136;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1136.google.com
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

On Mon, 16 Dec 2024 at 16:14, Peter Xu <peterx@redhat.com> wrote:
>
> QEMU uses g_mkdir_with_parents() a lot, especially in the case where the
> failure case is ignored so an abort is expected when happened.
>
> Provide a helper qemu_mkdir_with_parents() to do that, and use it in the
> two cases in qga/.  To be used in more places later.
>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  include/qemu/osdep.h     | 7 +++++++
>  qga/commands-posix-ssh.c | 8 ++------
>  util/osdep.c             | 6 ++++++
>  3 files changed, 15 insertions(+), 6 deletions(-)
>
> diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
> index fdff07fd99..dc67fb2e5e 100644
> --- a/include/qemu/osdep.h
> +++ b/include/qemu/osdep.h
> @@ -828,6 +828,13 @@ static inline int platform_does_not_support_system(const char *command)
>  }
>  #endif /* !HAVE_SYSTEM_FUNCTION */
>
> +/**
> + * qemu_mkdir_with_parents:
> + *
> + * Create directories with parents.  Abort on failures.
> + */
> +void qemu_mkdir_with_parents(const char *dir, int mode);

Don't put new function prototypes into osdep.h, please.
It is included by every single C file in the codebase.
There is always somewhere better to put things.

QEMU shouldn't abort on things that are kind of expected
OS errors like "couldn't create a directory", so I'm
a bit dubious about this function.

The two use cases in this commit seem to be test code,
so asserting is reasonable. But a "for test code only"
function should go in a header file that's only included
by test cases and the comment should be clear about that,
and it shouldn't have a function name that implies
"this is the normal way any code in QEMU might want
to create directories".

For the qtest tests, I currently ignore Coverity
reports in our test code unless it seems particularly
worthwhile to fix them. This is especially true for
complaints about unchecked return values and the like.

Even in a test case it is still not great to call
g_assert(), because this makes the test binary crash,
rather than reporting an error. The surrounding TAP
protocol parsing code then doesn't report the test
failure the way you might like.

thanks
-- PMM

