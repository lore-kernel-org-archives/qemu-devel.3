Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79293C3DA63
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 15:52:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWHnq-0006ea-In; Tue, 23 Jul 2024 11:51:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sWHni-0006bR-Rs
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 11:51:44 -0400
Received: from mail-lj1-x22c.google.com ([2a00:1450:4864:20::22c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sWHng-00017e-BX
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 11:51:41 -0400
Received: by mail-lj1-x22c.google.com with SMTP id
 38308e7fff4ca-2ebe40673d8so69193861fa.3
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2024 08:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721749898; x=1722354698; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9o1sQd07hPkXNaVq14CpeNbX7Vyqu9hfz6trrLrRT2o=;
 b=Aiag1ueCDZu8DKBawl3OY/Ax+cTcR8poBneJqRDnWM36hfPdkAflZaejZy96neEb61
 LEqyLT5xrl4X2MqtCo7xRADpoKy2H0sYOo+yzr+J92KhQs68UJMFEqypwI97aL0uMRYu
 2NDBrvLrXgfXyXEi1Ml9xBLbjrUwt+WCOCwcS3VrqGHaMLi2yx5Ws6KdXWfjjpg+V9Ko
 GAo9CUkWnLqsvXrz1u7KC/obX++7jlihdI8VZNBSLhn8qj6+tkcdjUTqLt/vCnN547ND
 dsqUBHbyrbCD6XrVyWb1KJ431nfOdqr3OrVMciAZhrnmgLB5cji2MCUnhkgQFgMiUYBh
 3fnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721749898; x=1722354698;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9o1sQd07hPkXNaVq14CpeNbX7Vyqu9hfz6trrLrRT2o=;
 b=TdceQx9efzZGr7deg0ivM3prPRu4eoEvzl0FvTw1waUIBztoeX0msDWf+i11jQc38C
 BsSifP+XLWgtN/yN6hrtMM+vggbz0KkwjkPjrgKj5ZxquYf4dOsYPRDlnQ0YNvzQKHlt
 /2a6fesNmnIR1nONpY1y0O18u4Pi2+d4V4ZrSkKnyzORHyf5uEonA4/B75+EKKcsaw0I
 9wByYwBOtpaJcB2pFddx2b/2Yxvhd+0lqekHocDdD8UvvV7Wosdv3pbHZDa3xqor8Z8/
 b0oCO2UD3zzJ8g6J/idrshMbBvvcMn0FBaO9k5fTxmncLz+xIPQZMYBdEwtomgJH5Jjt
 hKBA==
X-Gm-Message-State: AOJu0YwL0/J+LbHlserzY13ltP6i4HS5RvYbqnL+mGi/0uMd2t70ybYS
 cnQjjY+lF0GSyJ87f2EcK8i++uEDk7LVXJ3+W9NY28JvrwK+BVc820fMOMjahYgVifYAE3YP62e
 4B3BRqRDtpRlrOoBoOLkfQGHNnKgYFSVZfRHxog==
X-Google-Smtp-Source: AGHT+IHzZ82CEzxp6QaBEbfDQl1/mUv7KBvJ154QSqMKejQJNW6LZiCs2UxD7vL3x9BGtLOHs955w8M8uqs56cSZLFk=
X-Received: by 2002:a2e:8505:0:b0:2ef:2d58:ec24 with SMTP id
 38308e7fff4ca-2ef2d58f07bmr47738081fa.17.1721749898490; Tue, 23 Jul 2024
 08:51:38 -0700 (PDT)
MIME-Version: 1.0
References: <20240723150927.1396456-1-peter.maydell@linaro.org>
 <331c454b-56f1-485b-bc70-c1b433db20f7@linaro.org>
In-Reply-To: <331c454b-56f1-485b-bc70-c1b433db20f7@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 23 Jul 2024 16:51:27 +0100
Message-ID: <CAFEAcA_HoeDYvjVsbkMJqYxEWh5nE1Y9hRLkeOhfVqX8=r=H=g@mail.gmail.com>
Subject: Re: [PATCH] util/async.c: Forbid negative min/max in
 aio_context_set_thread_pool_params()
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org, 
 Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <fam@euphon.net>,
 qemu-block@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::22c;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x22c.google.com
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

On Tue, 23 Jul 2024 at 16:44, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> On 23/7/24 17:09, Peter Maydell wrote:
> > aio_context_set_thread_pool_params() takes two int64_t arguments to
> > set the minimum and maximum number of threads in the pool.  We do
> > some bounds checking on these, but we don't catch the case where the
> > inputs are negative.  This means that later in the function when we
> > assign these inputs to the AioContext::thread_pool_min and
> > ::thread_pool_max fields, which are of type int, the values might
> > overflow the smaller type.
> >
> > A negative number of threads is meaningless, so make
> > aio_context_set_thread_pool_params() return an error if either min or
> > max are negative.
> >
> > Resolves: Coverity CID 1547605
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> > ---
> >   util/async.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/util/async.c b/util/async.c
> > index 0467890052a..3e3e4fc7126 100644
> > --- a/util/async.c
> > +++ b/util/async.c
> > @@ -746,7 +746,7 @@ void aio_context_set_thread_pool_params(AioContext =
*ctx, int64_t min,
> >                                           int64_t max, Error **errp)
> >   {
> >
> > -    if (min > max || !max || min > INT_MAX || max > INT_MAX) {
> > +    if (min > max || max <=3D 0 || min < 0 || min > INT_MAX || max > I=
NT_MAX) {
> >           error_setg(errp, "bad thread-pool-min/thread-pool-max values"=
);
> >           return;
> >       }
>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
>
> I don't get the point of using signed min/max here...

I think this is because those values may originate in a
QAPI command structure (EventLoopBaseProperties), where
they are defined as "int" rather than a specifically
unsigned type. So we carry them around as int64_t until
they get to here, where we do the validation of whether
they're sensible or not.

thanks
-- PMM

