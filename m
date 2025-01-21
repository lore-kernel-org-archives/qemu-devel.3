Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFE2FC0218B
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2025 13:06:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taDwT-0003yM-LG; Tue, 21 Jan 2025 08:05:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1taDwN-0003qj-C4
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 08:05:12 -0500
Received: from mail-yb1-xb2b.google.com ([2607:f8b0:4864:20::b2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1taDwL-0007jW-Kq
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 08:05:11 -0500
Received: by mail-yb1-xb2b.google.com with SMTP id
 3f1490d57ef6-e3978c00a5aso8696741276.1
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2025 05:05:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737464708; x=1738069508; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L0LC9uCGFjyS38qgSUaB3bhc+kfZQqXdfM2lVdqqJog=;
 b=Q679xQ1tI72dBrbM0vIAyRKx0qZKCivOkxAJNznNbW0JxABL4pZB3GI+XwFVB/uXXW
 COHivdic+iHOBfmS2YzT/sIfKuRluilvXMXcVct1OakWfmw7DQnFrM/Ij+2gTo3m5qAk
 4oVX3M2HqDcksFpKOiPQXSJM7FpcJ56IZGG2x1I46RsVH4pJ1nc7bpSdi+FWp5JWt3GA
 /rHuZBdbe5fhr3ka9pf99fTlv1BjVYdmQZlfnRanpAzZkSqJNKArUxH4IdDX/ZyWbHUU
 tN3/TwWU4SmWQerfieMfCiQs7gZKtEUV05rTKobdc5DhLeJiPdhXoFcg2tVB8Qf6mg3n
 OuIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737464708; x=1738069508;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=L0LC9uCGFjyS38qgSUaB3bhc+kfZQqXdfM2lVdqqJog=;
 b=H2vtEa7QgEe5AtJUcM6xMAuB1havDOaD7So1dU/9/E8lsYiP0+c5FLmgri7PZSCqap
 VCQSQrDoH83S3ouNd/IxKrqHGDk8VsPw+ZCzXz+t811mbERBB9J1aKea3Kf03W8O7ytX
 HaHXadPpY5FRersBH4TIg9E2lh++gDD9lGs7BEo8FWed1xGZ2nFM34BMft/tyEzCRva0
 plnvFdbQ+1OdvJ9CAf926lYnnubU2Mopq+bDJQkm4mlLazrvKxDmCq3/+h49Cc09kQdB
 k8MB/L5HlusYJYAZo75BoE+oCaJjZQ+LdnctlXd+6ORLUb21Y1ruyfXYdaV9MFM0m1rm
 YGfA==
X-Gm-Message-State: AOJu0YzACTyZTmgJ5rsN2+OyRFC2iVukZw+BWlXmTr+RhYZdf7ln7At/
 scJCwIucmVZM6a6VPjNNFabnA1UOgGzYJSFoLnMiZcNwWFVAV8pBAJiQfh1ij3ym88T2/AineTd
 U4sr+nlr6KmDddsM+F/JgPWwpZiF0aaZx2iieNQ==
X-Gm-Gg: ASbGncuMUSDl6EBFPMFdh04FiXO5xkXIGhPPdsT3ADA8bBiuI0wHQuKxCUsXA4xAhjT
 IkXL/AVEW2jJnIs1DN9r6pLM4wI2GHKcy5CmbUB+x/qtUJERSmSED
X-Google-Smtp-Source: AGHT+IHIU3MO35jrOSaOuGgzQBJYDsWlT7SNbbIrhCg41B+5rBE7f3T1bnIov5TSaO3VDauYrcLShn9Cnxp0uxMmBu4=
X-Received: by 2002:a05:6902:1b02:b0:e49:c11a:7580 with SMTP id
 3f1490d57ef6-e57b10453eemr12505410276.7.1737464707734; Tue, 21 Jan 2025
 05:05:07 -0800 (PST)
MIME-Version: 1.0
References: <20250120210212.3890255-1-alex.bennee@linaro.org>
 <20250120210212.3890255-7-alex.bennee@linaro.org>
In-Reply-To: <20250120210212.3890255-7-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 21 Jan 2025 13:04:56 +0000
X-Gm-Features: AbW1kvZ-Pag_aRcTSJV0CQvvb9KJN0wMv3z415E0AitAhflfvfj1yHoVGvRiExQ
Message-ID: <CAFEAcA_qceSO9be7wSj6U2a9yDvj9VhjQZuRugzGKsae+wEoog@mail.gmail.com>
Subject: Re: [PATCH 6/7] tests/qtest: tighten up the checks on clock_step
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, qemu-arm@nongnu.org, 
 Thomas Huth <thuth@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2b;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb2b.google.com
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

On Mon, 20 Jan 2025 at 21:02, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> It is invalid to call clock_step with an implied time to step forward
> as if no timers are running we won't be able to advance.
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>  system/qtest.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/system/qtest.c b/system/qtest.c
> index 28b6fac37c..1a9bfd0b33 100644
> --- a/system/qtest.c
> +++ b/system/qtest.c
> @@ -708,10 +708,15 @@ static void qtest_process_command(CharBackend *chr,=
 gchar **words)
>          } else {
>              ns =3D qemu_clock_deadline_ns_all(QEMU_CLOCK_VIRTUAL,
>                                              QEMU_TIMER_ATTR_ALL);
> +            if (ns < 0) {
> +                qtest_send(chr, "FAIL "
> +                           "no timers for clock_step to follow\n");

I think I would say
"cannot advance clock to the next deadline because there is no pending dead=
line"
as being a bit clearer about what's gone wrong here.

> +                return;
> +            }
>          }
>          new_ns =3D qemu_clock_advance_virtual_time(old_ns + ns);
>          qtest_sendf(chr, "%s %"PRIi64"\n",
> -                    new_ns > old_ns ? "OK" : "FAIL", new_ns);
> +                    new_ns > old_ns ? "OK" : "FAIL could not advance tim=
e", new_ns);

Maybe we should give up on trying to handle the OK and FAIL
cases in the same qtest_sendf() call? It's not clear to me that
printing the new clock value in the FAIL message is actually
useful.

For that matter, is it actually possible for the clock to not
advance? It doesn't seem obvious that "advance the clock by 0 ticks"
should be a failure case rather than a "does nothing" case,
and once patch 7 is applied I don't think there's any case
where qemu_clock_advance_virtual_time() could make the
clock go backwards... Put another way, this would be moving
back to the situation before your commit d524441a3610b.

thanks
-- PMM

