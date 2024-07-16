Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06DB4C3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 14:10:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTirv-0002sB-17; Tue, 16 Jul 2024 10:09:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sTirr-0002oP-LT
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 10:09:23 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sTirp-0004P0-KY
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 10:09:23 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-58b447c511eso7229088a12.2
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2024 07:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721138959; x=1721743759; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wnbnYZhKW3lBgSIL7cBcffW8bmVQWHFI2NF0kpCOhy4=;
 b=ZT6kmhe9lXbYhfEJ+5su9Wyj7DNuzKRXOySyW9xPtx8sp1NENFLnbQ8i4pAMppsKM0
 b7Mjdey5QurPkoK6ewK2j9xcr3Hrvj0SfnPG542lJv8P5mjAeGQIwUMVGraj1/G/mnbq
 JnhkgUjU87FH8S1KqaJAyggaCTnQDfrc+9A6i74ZaeE07qzDfOUptPzYZ56mIRkcz2nb
 OXBs1ODa/uapT9AAy9m5JwVwN2yymG2/dO+uHF99x7y3JHo/IkNs9Vamz8AaqJ7MM3+A
 /+XYX7c9rYZmdjyTnNPd2Pin1e0K7slWkj/X615Exy+O+hvg8ltGgsh2E1tCsQBu13FR
 1Mrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721138959; x=1721743759;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wnbnYZhKW3lBgSIL7cBcffW8bmVQWHFI2NF0kpCOhy4=;
 b=OgXjydqk1KZvoncOPvl0DMP5lvdGXEcG6Yy77qSzcJVEqSPWhHS3k4b0m4AbrlPrVQ
 AogYtOKfynbzcY5JWjQuZ9Tfugr5tcEU+mt2NXpeXyTyJC2iyS7aWy99fojo3DidFItY
 NluImekV6WV3l2Lbk3EbV1cuVkc25b6drINkuNEZafWRpCpRVCWp16nVtxxnVira7LQZ
 FXCzdcH/GEK2HN72EDivmHSSbrZi0+BDUcZMSgPInoM+WnjnUir06mETu0C688DPFZuy
 aPFkTaQH4+C9mreoOiU/XNfSxYx7gpnlK1vPxPgtU1R5P+9NEiHWoR2aAp4xcV2K4Niu
 lWBA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW+8Q3ZFkhV22nWUam/dLPZ93WhmLvo8gjAwcCEViVYHSbL+Y4gOKGkr2dY472SgpIfgzDlW6pC9LoSnSgeF8J9K84zi7o=
X-Gm-Message-State: AOJu0YyBv0JwJUQHPP5fJQnuXYVTd1JUc/kMyVoNASmXgVx8IPq722VR
 vHzuc7Bti3HwY/VcAqjNQqvIl/lDoRF/KDU5rXytuMMWCo7sZUpbmR0FVayEv4jab4bJ3mthJaf
 wDeRgk0o7tWNu0vuXnraSWekQ/GeomEqGhFphWw==
X-Google-Smtp-Source: AGHT+IFj+1fjmEFn58TsmUm8+IOlWFAQ4435xD2CAoyQRCl/4FNj9ZwIwgFJcww6Co1DcG7+o7eM0X8dM/cr7ULsIt4=
X-Received: by 2002:a05:6402:2692:b0:58d:d1d5:da65 with SMTP id
 4fb4d7f45d1cf-59eee53f724mr1766145a12.11.1721138959512; Tue, 16 Jul 2024
 07:09:19 -0700 (PDT)
MIME-Version: 1.0
References: <20240716114229.329355-1-alex.bennee@linaro.org>
 <b9690162-170e-1f74-f148-0642a8503002@linaro.org>
 <87plrdh2i3.fsf@draig.linaro.org>
In-Reply-To: <87plrdh2i3.fsf@draig.linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 16 Jul 2024 15:09:07 +0100
Message-ID: <CAFEAcA8+KXykmmk_4BU990kj3nY4xfr0zn2MtM0cYTuhNnsWtg@mail.gmail.com>
Subject: Re: [RFC PATCH] gdbstub: Re-factor gdb command extensions
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: Gustavo Romero <gustavo.romero@linaro.org>, qemu-devel@nongnu.org, 
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x529.google.com
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

On Tue, 16 Jul 2024 at 14:48, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> Gustavo Romero <gustavo.romero@linaro.org> writes:
>
> > Hi Alex,
> >
> > On 7/16/24 8:42 AM, Alex Benn=C3=A9e wrote:
> >> Coverity reported a memory leak (CID 1549757) in this code and its
> >> admittedly rather clumsy handling of extending the command table.
> >> Instead of handing over a full array of the commands lets use the
> >> lighter weight GPtrArray and simply test for the presence of each
> >> entry as we go. This avoids complications of transferring ownership of
> >> arrays and keeps the final command entries as static entries in the
> >> target code.
> > How did you run Coverity to find the leak? I'm wondering what's the
> > quickest way to check it next time.
>
> Coverity is only run in the cloud on the released build. There is a
> container somewhere but I don't know how its used.

The Coverity cloud stuff comes in two parts:
 (1) you build locally with the Coverity tools, which creates
a big opaque build-artefact
 (2) you upload that artefact to the cloud server, and the
actual analysis happens on the cloud

The container stuff and the integration with the Gitlab CI
is there for the sole purpose of automating the "local build
and upload" steps. You can't do an analysis-run locally.
(Well, you probably can if you have the paid-for commercial
version of the tooling, but we haven't got any kind of
setup for doing that.)

We only do analysis runs on head-of-git because the Coverity Scan
resource limits for open source projects give us about one
complete scan a day. So this is all "after the fact" stuff.
Developers who want to look at the scan results can create
an account via https://scan.coverity.com/projects/qemu .
Triaging new coverity reports is a bit tedious because there
are a ton of false positives...

thanks
-- PMM

