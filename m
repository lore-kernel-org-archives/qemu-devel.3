Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A538EC83F03
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 13:47:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXKH7-00028B-2E; Thu, 03 Jul 2025 09:46:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXKH4-00025N-JW
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 09:46:50 -0400
Received: from mail-yw1-x1135.google.com ([2607:f8b0:4864:20::1135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXKH2-0003jf-TC
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 09:46:50 -0400
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-70e23e9aeefso64236927b3.2
 for <qemu-devel@nongnu.org>; Thu, 03 Jul 2025 06:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751550404; x=1752155204; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=flS6TFeOZvoyt/ARcs3LNzYAUhneQXJ5kq+dG0ggD4s=;
 b=i3e/f3ezmOV2rtwxq+4C+B1odx2Cp5X6FrrU0zokl8MQ8FjjsYZVlyJTttR+m4shh4
 MAbNtlXIc3w7bFlDdW9GKJ7jvx28b3oHFWeComl6uq52h8qlde6XJwdE5Vlqw49JiFLt
 FdQRF2DHYq+YEi+enHF2j+HvPQ8xsnD+R9bSg2LJyKT01jiJ8IzEwCCGF1a67UnsSjR8
 otgJanfuOaff5idwyt0c8IYrf15VcZlJokrI7rdz8KgiO9XKcYCfGP/40Lo/bEHD/aXV
 DtxyequefzODC+xsy3QZLbO7YZdG0JBXYnycSHpGMatkZ+TK0oRcSw/hROMA/fj3thQn
 2Mgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751550404; x=1752155204;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=flS6TFeOZvoyt/ARcs3LNzYAUhneQXJ5kq+dG0ggD4s=;
 b=dyMQaRh65KkMgrLSkuIYbfNPKAjLwbWMqUtD8zY01EyL4qdvHMStiAxehIDR+KDt3O
 XB/BvnUNvbYWczbWsqw5eMdQI5tKhHzkVu4XrMzHMgAITgh3gN8mJ39QrHKBHTbF+HDr
 dQd1hXWjrymylwtEeAKCaYW3qP0sWhihiJ8FBVE+8nx/vSlIAg22L7i+fA5CXeaOLTSq
 b+VAyCXTmKyTywmI+7Vodlzd3rT1LJ7epbFdXmXrS5dIANO1V54tWXF3BBE2JCB3Y9eH
 twZofgOsmetclrGDBspn97hnfzOh9yPPLgrM8uwH5ZfT4r423xnU2bj8aj0/SzWdrSaJ
 Bfvg==
X-Gm-Message-State: AOJu0YwS7hNBTikF/ftMnIMzALxrKgMUYmNNEAsqZpN5x7oi9pnsszH4
 KC/xl72OPmiFBphK4BEc4n/Dv3c7Hcy6MnsJeyCqXga2lmOXzQm3xAE0GsyIYhFDhCyGvNPY4Iv
 UiexXXLo9DrtfdZNkIzqYwMIEPHErndkI6zeanZHiMQ==
X-Gm-Gg: ASbGncsPw2LvOY3BlEDyGjYXB3AeaTHr2r32JiUcnpfX3KC7wOXlH8QAwHcjNxg9TUN
 gr2bTSrwYYsMfz8fKN75kKc53csMipfD43XXAacioS4iuiSSbeaXCj8kaPP4jOdNU5qYxaG2BW0
 5qfg9B2428axhjphNNZ1z1pO5Kjt1NpIlFjNoeMQVotG/d
X-Google-Smtp-Source: AGHT+IEMZm719qroFCgdt+NB/P2u1+uK5R7VzorJ6VDNhLe45GJPibffuoP2EDxqdgaryg7WVzX7vUG/Kw6HwGwMdcM=
X-Received: by 2002:a05:690c:60c3:b0:70f:751c:2d8a with SMTP id
 00721157ae682-71658fbc2f8mr48735757b3.3.1751550403709; Thu, 03 Jul 2025
 06:46:43 -0700 (PDT)
MIME-Version: 1.0
References: <20250703105540.67664-1-philmd@linaro.org>
 <20250703105540.67664-48-philmd@linaro.org>
 <364dc354-ba78-47c6-ac65-2c0282e28733@linaro.org>
In-Reply-To: <364dc354-ba78-47c6-ac65-2c0282e28733@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 3 Jul 2025 14:46:32 +0100
X-Gm-Features: Ac12FXyjoUMUshc9DoTiWVwetwZ0Q9yjCJVVjro3qKCKC9YYLxR5jkB-AbTrEyo
Message-ID: <CAFEAcA8-ucEJPgVLpBfNyMo8ax-sR6iYr5Zk4DJavYaOkQnfDA@mail.gmail.com>
Subject: Re: [PATCH v5 47/69] target/arm: Use generic hwaccel_enabled() to
 check 'host' cpu type
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, kvm@vger.kernel.org, 
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1135;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1135.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Thu, 3 Jul 2025 at 14:45, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org=
> wrote:
>
> On 3/7/25 12:55, Philippe Mathieu-Daud=C3=A9 wrote:
> > We should be able to use the 'host' CPU with any hardware accelerator.
> >
> > Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> > Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> > ---
> >   target/arm/arm-qmp-cmds.c | 5 +++--
> >   target/arm/cpu.c          | 5 +++--
> >   2 files changed, 6 insertions(+), 4 deletions(-)
> >
> > diff --git a/target/arm/arm-qmp-cmds.c b/target/arm/arm-qmp-cmds.c
> > index cefd2352638..ee5eb1bac9f 100644
> > --- a/target/arm/arm-qmp-cmds.c
> > +++ b/target/arm/arm-qmp-cmds.c
> > @@ -30,6 +30,7 @@
> >   #include "qapi/qapi-commands-misc-arm.h"
> >   #include "qobject/qdict.h"
> >   #include "qom/qom-qobject.h"
> > +#include "system/hw_accel.h"
> >   #include "cpu.h"
> >
> >   static GICCapability *gic_cap_new(int version)
> > @@ -116,8 +117,8 @@ CpuModelExpansionInfo *qmp_query_cpu_model_expansio=
n(CpuModelExpansionType type,
> >           return NULL;
> >       }
> >
> > -    if (!kvm_enabled() && !strcmp(model->name, "host")) {
> > -        error_setg(errp, "The CPU type '%s' requires KVM", model->name=
);
> > +    if (!hwaccel_enabled() && !strcmp(model->name, "host")) {
> > +        error_setg(errp, "The CPU type 'host' requires hardware accele=
rator");
> >           return NULL;
> >       }
>
> Consider the following hunk squashed:
>
> -- >8 --
> diff --git a/tests/qtest/arm-cpu-features.c b/tests/qtest/arm-cpu-feature=
s.c
> index eb8ddebffbf..bdd37cafecd 100644
> --- a/tests/qtest/arm-cpu-features.c
> +++ b/tests/qtest/arm-cpu-features.c
> @@ -456,7 +456,8 @@ static void test_query_cpu_model_expansion(const
> void *data)
>                    "ARM CPU type", NULL);
>       assert_error(qts, "max", "Parameter 'model.props.not-a-prop' is
> unexpected",
>                    "{ 'not-a-prop': false }");
> -    assert_error(qts, "host", "The CPU type 'host' requires KVM", NULL);
> +    assert_error(qts, "host",
> +                 "The CPU type 'host' requires hardware accelerator",
> NULL);

Grammar nit: either "a hardware accelerator" or "hardware acceleration".

-- PMM

