Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E04F6D68B03
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 13:02:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBZUC-0001RV-Oy; Thu, 14 Nov 2024 08:02:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tBZTa-0001Kb-Ue
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 08:01:40 -0500
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tBZTT-0000kM-F9
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 08:01:32 -0500
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-5cef772621eso772944a12.3
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2024 05:01:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731589284; x=1732194084; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=d6zhytplbAJK9UHZiJT4K7CXB6jTQ/D6FzQ5I4GUl4s=;
 b=mDEwODrFB24eM+9nJxHB/yXJfqxtg9RPJ1kCQBZ8iP03flEwrRn7x06gpoe8XoeUex
 9mMRADkaNSJ6XAJmiLKcMoyunN3uppozWxa4BmZ97nd6evaaGd/ew+uD0GliixHhkmUN
 K6NkTCz55ClnvOsMSTYI1fQNJfyrekcjk54FJzZHgdB8suF/PF/Q4IdDJLjmpw+S+vNT
 jdCeiqVtkMICl0dvit8eFBN2RQbRWPxXapL1F6qV97gqxxZ3uBhHeHh/2Z9Rx39iVOTR
 1+1O7F/vuOHwipxIf/cRxs0Ho7zNR4m+MlllNEpFKapTTQW/PVedi/ja8II6Yw6s9Sml
 D9bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731589284; x=1732194084;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=d6zhytplbAJK9UHZiJT4K7CXB6jTQ/D6FzQ5I4GUl4s=;
 b=tAnUaVoTuBpB9ccyPjjHcM3bAsNg2YkZ7WDge0gkwHZYs0/QISUos/ruAxRuq6MqGy
 lzapc87BoYucCKuRXrzzZTG++yjEjdEtlxGOg9wiQxDyJi8Xw2U94bYrwX99z1q+bgeF
 pWDME7o5yJwTUKKReFuOE9oIOXsH+w180lFv4/P+N4N83qLc87PecdVsdwYUE9eDriVp
 apIQmyHD8QQDl+n2lsMNqR/RXY7yNpc81NZ2AdVdhpnu7N3fQ7h4wcn8+FWw+r4WZZsZ
 /3xXfbUNCiAadl00eJ97Pp8cOF6FzqGlXk3gZa8eKuu7tvNe2da4kqIDl8rx3ipHqn4s
 shuA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUDuZz0T68y1RSE7Q5zBEVSwkkkoFvpyMaotlyGs3Pb0/9FZsF7JV56tEYYYM6BSoqVY5ZqBgIDsccm@nongnu.org
X-Gm-Message-State: AOJu0Yyy7Ae2qzrF2K9544h1rmOmvo2XAzqulgisFpOJnL4AIE3WUct0
 SwqA3NUxSbAqtwM0TZjB025t6AbybmPy8b2UIs1BF0w5nMS+Pj9DUmOeq4uSdP0zcBUj3f8BYFQ
 PGT+m8/B/OlsMbhO8cwfY99XYQwxfGKGB7HvQ5w==
X-Google-Smtp-Source: AGHT+IEgN2mpyoHuvI4Dx8Q8HWJrC0UBTeI7vPYcb8bWsQFbACrULvQh1mGv7nPJ2REozEycpgJRmk/8ttnrNwbpTOE=
X-Received: by 2002:aa7:c90f:0:b0:5cf:67c1:69e5 with SMTP id
 4fb4d7f45d1cf-5cf67c16ef9mr3537833a12.4.1731589283739; Thu, 14 Nov 2024
 05:01:23 -0800 (PST)
MIME-Version: 1.0
References: <20241108191024.2931097-1-roqueh@google.com>
 <20241108191024.2931097-4-roqueh@google.com>
In-Reply-To: <20241108191024.2931097-4-roqueh@google.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 14 Nov 2024 13:01:12 +0000
Message-ID: <CAFEAcA9DDVqgOs7B3kC30=OgJ8iLZ3R3RB6BdEBMEKNxx0LAjQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] tests/qtest/cmsdk-apb-watchdog-test: Test INTEN as
 counter enable
To: Roque Arcudia Hernandez <roqueh@google.com>
Cc: farosas@suse.de, lvivier@redhat.com, slongfield@google.com, 
 komlodi@google.com, pbonzini@redhat.com, venture@google.com, 
 qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x536.google.com
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

On Fri, 8 Nov 2024 at 19:10, Roque Arcudia Hernandez <roqueh@google.com> wrote:
>
> The following tests focus on making sure the counter is not running
> out of reset and the proper use of INTEN as the counter enable. As
> described in:
>
> https://developer.arm.com/documentation/ddi0479/d/apb-components/apb-watchdog/programmers-model
>
> The new tests have to target an MPS2 machine because the original
> machine used by the test (stellaris) has a variation of the
> cmsdk_apb_watchdog that locks INTEN when it is programmed to 1. The
> stellaris machine also does not reproduce the problem of the counter
> running out of cold reset due to the way the clocks are initialized.
>
> Signed-off-by: Roque Arcudia Hernandez <roqueh@google.com>
> Reviewed-by: Stephen Longfield <slongfield@google.com>
> ---
>  tests/qtest/cmsdk-apb-watchdog-test.c | 214 ++++++++++++++++++++++++++
>  1 file changed, 214 insertions(+)
>
> diff --git a/tests/qtest/cmsdk-apb-watchdog-test.c b/tests/qtest/cmsdk-apb-watchdog-test.c
> index fe535a553c..3777b7bd59 100644
> --- a/tests/qtest/cmsdk-apb-watchdog-test.c
> +++ b/tests/qtest/cmsdk-apb-watchdog-test.c
> @@ -68,6 +68,15 @@ static const CMSDKAPBWatchdogTestArgs machine_info[] = {
>      },
>  };
>
> +static void system_reset(QTestState *qtest)
> +{
> +    QDict *resp;
> +
> +    resp = qtest_qmp(qtest, "{'execute': 'system_reset'}");
> +    g_assert(qdict_haskey(resp, "return"));
> +    qobject_unref(resp);
> +}

The system_reset QMP command only requests a reset; it does
not wait for it to actually happen. For that you need to
   qtest_qmp_eventwait(qtest, "RESET");

We seem to already have several implementations of this
kind of "reset the system under test" function, several
of which have this bug. That suggests to me that we ought
to provide it as a utility method qtest_system_reset()
in libqtest.

thanks
-- PMM

