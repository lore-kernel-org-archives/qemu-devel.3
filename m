Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2DA4C8302F
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 09:50:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWXd7-000821-Ix; Tue, 01 Jul 2025 05:50:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uWXcy-0007xu-KK
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 05:50:13 -0400
Received: from mail-yw1-x112f.google.com ([2607:f8b0:4864:20::112f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uWXcu-00020E-Mj
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 05:50:12 -0400
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-70e64b430daso31979767b3.3
 for <qemu-devel@nongnu.org>; Tue, 01 Jul 2025 02:50:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751363406; x=1751968206; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L3ead+uizm1Vc976UnfrINanFTxCKtIjchE+tw+EPsA=;
 b=KPa10ZGvrzt+U31ql15kqWOBN+mAIN5oT41H1Xru842Y3FhoIKjWHEdGVVcrZashC5
 X+MWTAjbX/bcQfE3QOdp2BxBTVk1gsnt/pbbgvIJcZHFbaHRvwnzVFWJYdj3fS4VNekS
 V1wAhJfILTF0ifWhCP15+H9pKk8iaWRfAxEr7hi6QwhmO+pqDlIuE3oAXPhvanbcwBat
 kAsxuQaGOwlXHUXZsa4tt4KN2NmjoeSsYbrmAmxJVNIWVrOzKoUxNWOizhqIf4lvVFHh
 k1eLcMoCbuuN9iGq7GMxj6tvCn7tGeDPouHIJeekZ3lq/zrcyYNgL7hWAPX5oxOc7JfQ
 t7CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751363406; x=1751968206;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=L3ead+uizm1Vc976UnfrINanFTxCKtIjchE+tw+EPsA=;
 b=dSf/denQsXdWItM7OlHIF3nW2yr4KLqOd7pvN8f2Dxwzkf6MqMW2xZeZFbYS1C3ppf
 KitTntFoUPetRihwKdLKMOvkv3i5Y9rL0JE7FO0fqfQ8Kk95i/MMwYJ4Z2VqCMs+z+mG
 1Ft730I2cQoShrrC6OIY0BCK2Dw6MyQazfNMDhbU28MjKkEsHNmgFAXb46xWBBrM4Jyv
 JmQ+5BVfQ2gfJn3Ry5jmfsN9LZP2Ll5WpTEQtzeDfVFFOrmgwyOuB//VLxEv52SpxNSQ
 5CuhaJ0u43f7jxN2ZH0K6R+mPD98hlgtywoF5fXkgeTv5PR9wB4JXIU0jKy6kPPJGe9J
 AIbw==
X-Gm-Message-State: AOJu0YxONXZMVWBGLplLj5jDZOB4BAqn5K0Kh7yXcaFhgdwZGRYApwlp
 FhGp7FIeGnmea0O1fxfAwNOXKMYnWWyZhDx8VFVxKPLIWyEV5wN9ACmb2feXqhMoYusvaVslVF8
 cWqK8knM+y94r+kw1dRjOL+GP3gkBokfPyAv3BnB7uw==
X-Gm-Gg: ASbGncsTo8twYHlBwwtazpr/6dz6E0g26bhTeNeO3dlY2vE3RYTmxG5E5nKkYrbrja3
 DU9p6Eenr2mDAdnQKS6VWweUTw3ABlSMGhtzVHrWZkDioTm04uEtts6hDATrJqySAAsLuaEF5Vr
 03/Q3V4hO1FxGSVKAGkKLaaHGKlkM8sSVvuX3wBt7Pbpmc
X-Google-Smtp-Source: AGHT+IEgNBWX5tGLtftpO87ft/BiEpcXC82wrB1DaQaCVscRFjWWJgGUjii5r8i+5yiViziGpgeRsjHaIy59eNovzCg=
X-Received: by 2002:a05:690c:7442:b0:711:a4af:43ad with SMTP id
 00721157ae682-71517147badmr235251117b3.14.1751363406075; Tue, 01 Jul 2025
 02:50:06 -0700 (PDT)
MIME-Version: 1.0
References: <20250623121845.7214-1-philmd@linaro.org>
 <20250623121845.7214-7-philmd@linaro.org>
In-Reply-To: <20250623121845.7214-7-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 1 Jul 2025 10:49:54 +0100
X-Gm-Features: Ac12FXyuBHFyZZaOxyOwWqZE-W7vNcGgM_jfizm0gIVdy-6YVWg7T5T5DEF9PnA
Message-ID: <CAFEAcA9ref1SFd2uPRBBjyg=eph+GptWxoyURxMZj8aSVD7zAg@mail.gmail.com>
Subject: Re: [PATCH v3 06/26] target/arm/hvf: Trace hv_vcpu_run() failures
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Leif Lindholm <leif.lindholm@oss.qualcomm.com>, 
 qemu-arm@nongnu.org,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Roman Bolshakov <rbolshakov@ddn.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Alexander Graf <agraf@csgraf.de>, Bernhard Beschow <shentey@gmail.com>,
 John Snow <jsnow@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 kvm@vger.kernel.org, Eric Auger <eric.auger@redhat.com>, 
 Cameron Esfahani <dirty@apple.com>, Cleber Rosa <crosa@redhat.com>, 
 Radoslaw Biernacki <rad@semihalf.com>, Phil Dennis-Jordan <phil@philjordan.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::112f;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112f.google.com
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

On Mon, 23 Jun 2025 at 13:19, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> Allow distinguishing HV_ILLEGAL_GUEST_STATE in trace events.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/hvf/hvf.c        | 10 +++++++++-
>  target/arm/hvf/trace-events |  1 +
>  2 files changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
> index ef76dcd28de..cc5bbc155d2 100644
> --- a/target/arm/hvf/hvf.c
> +++ b/target/arm/hvf/hvf.c
> @@ -1916,7 +1916,15 @@ int hvf_vcpu_exec(CPUState *cpu)
>      bql_unlock();
>      r =3D hv_vcpu_run(cpu->accel->fd);
>      bql_lock();
> -    assert_hvf_ok(r);
> +    switch (r) {
> +    case HV_SUCCESS:
> +        break;
> +    case HV_ILLEGAL_GUEST_STATE:
> +        trace_hvf_illegal_guest_state();
> +        /* fall through */
> +    default:
> +        g_assert_not_reached();

This seems kind of odd.

If it can happen, we shouldn't g_assert_not_reached().
If it can't happen, we shouldn't trace it.

But the hvf code already has a lot of "assert success
rather than handling possible-but-fatal errors more
gracefully", so I guess it's OK.

-- PMM

