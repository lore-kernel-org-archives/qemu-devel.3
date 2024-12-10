Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B13FAE7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2024 15:37:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tL2IX-00077c-Io; Tue, 10 Dec 2024 10:37:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tL2IM-0006zJ-GC
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 10:37:12 -0500
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tL2IK-0001JZ-Ly
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 10:37:06 -0500
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-5d3d74363cbso5826979a12.2
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2024 07:37:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733845022; x=1734449822; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6SUViHiYlm5aq4urdsn4S9EtzSdH/GA+uhrDJzlqIfY=;
 b=I1GBiAOoLY8JWuLrx50t7aGbDiraTnnj8Y/+PJY91r1cCqgMK7wileyNBsHfLsj+Q9
 4SeaR3P2nbyP9OgU0Jd0Mk0sFDSs8aI/6yHTCDefohrADUkZf2c7gYEB2GdTPr0wnVz6
 NInj7IDdBn8wWkwUgk9FH4IMRRwQ3eytkZrhfIDErQaqdC5R5iSJdzTVLorvII71DJzX
 2DPC02BQ2is3I+NNVK5PADp3Pel4C2vKixL23M5HAj90GRX8iOVW+wpD04SmMrALBvvr
 wPObphzGPgiYzlCb3c2xQHV4SyJRUB9OMcX15jLpF/Ackrmjuasq9/5wRFl4z6wUYNvh
 i5HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733845022; x=1734449822;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6SUViHiYlm5aq4urdsn4S9EtzSdH/GA+uhrDJzlqIfY=;
 b=LTOJR49jVmdl78Fn4y+m0QdjPv0YVdphYejkHRIUi6w7IU+49PKd+sYwEOPPlbZHbd
 OfBqk0vUhc3Jnxat6fKZxwxhf0e7z1QVPvxSfTMW7Ct/8GzGH1Slz3zANlxF6I556IeP
 O9mcM3qUlDYCLqan6qr8CoaYCHJoX4Bj0zr3wJKF01Dub3PWFyIfqznhCreC4AFBd4mo
 PbHmlTZruLa9shTb3SZixiDxbYqte0B/n2WcUpZKHiAirZgnJYbT6MsZDNIukCDSCm8e
 U5sEpAwrcu8QG1MdtDUdMyBEh3H0coTO9dGFiPC40xKPQGtFcij6XWexQ0q1vEZoTgeX
 0bKA==
X-Gm-Message-State: AOJu0Yz7QQ9MoDfJuZdOmVoWXbB61PTuKclHIWEwHEEjxWJrWjjL5YR7
 ZQKUkjH0Sc6wzndlIsnDsA5ycbT2HDMnRY+bGnDsxvlJ/2vSld/OLqEJYk5VYkyDPgfNYXBEIdv
 m9hRzhRB+0IlgHODYfLKVBftZnNLlhIBxxMg8MA==
X-Gm-Gg: ASbGncs4S9LJqQOz3LBPBLwDSpp5jfiC4UD358A2U1/eLgmrNis5fIlin3lpgqDuF4S
 18ZAzOnesutMlAsSLHYO2febooK9kU6dnY5nY
X-Google-Smtp-Source: AGHT+IFDthsqFfsZxSTH1wptEkXxsJX3Pt+Gm8H8y6dEkZMj2gsG3msSHUmsHZAY4h3jN0oURgHi2AQkTE6/9VwRXCc=
X-Received: by 2002:a05:6402:2551:b0:5cf:d078:c9dc with SMTP id
 4fb4d7f45d1cf-5d4185fe213mr6178276a12.22.1733845022461; Tue, 10 Dec 2024
 07:37:02 -0800 (PST)
MIME-Version: 1.0
References: <20241210140112.43313-1-philmd@linaro.org>
 <CAFEAcA_ZpeLop95ELDHn696cN-6OL3pC95Dwea934RLH3SpSAw@mail.gmail.com>
 <CAFEAcA8qNrsViuQrCeCeh=2s-2GF2yXOc9d1qFxAcc+Knw0PDQ@mail.gmail.com>
 <0e9b0ee2-4928-4cb4-b7d5-a78c9a2f3096@linaro.org>
In-Reply-To: <0e9b0ee2-4928-4cb4-b7d5-a78c9a2f3096@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 10 Dec 2024 15:36:51 +0000
Message-ID: <CAFEAcA9b2__Qqx4sfEcbMLYZq5ataMxtp-QzYwaG85-kv_Nk8A@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] bulk: Remove legacy cpu_physical_memory_rw() API
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

On Tue, 10 Dec 2024 at 15:10, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> On 10/12/24 16:03, Peter Maydell wrote:
> > On Tue, 10 Dec 2024 at 15:00, Peter Maydell <peter.maydell@linaro.org> =
wrote:
> >>
> >> On Tue, 10 Dec 2024 at 14:01, Philippe Mathieu-Daud=C3=A9 <philmd@lina=
ro.org> wrote:
> >>>
> >>> cpu_physical_memory_rw() API is documented as legacy
> >>> since 2017 (commit b7ecba0f6f6). Replace it by a more
> >>> recent API. Noticed while discussing with Peter:
> >>> https://lore.kernel.org/qemu-devel/e979b3ba-e701-4ac6-962a-19e4598ba9=
47@linaro.org
> >>
> >> I'm not sure we want to do this as a bulk automated
> >> transformation, because in each case there is likely
> >> a better thing we can do with the call than to use
> >> address_space_memory. For example most of the uses in
> >> devices probably want to have the device have an
> >> AddressSpace property that the board wires up.
> >
> > Also, examining each use gives us an opportunity to
> > consider the error handling (cpu_physical_memory_*()
> > drop errors silently) and whether there's an appropriate
> > MemTxAttrs we want to use.
>
> Yes I noticed that and agree, but do we really want to improve
> these devices? They have been using the legacy API for 7 years
> without caring much.
>
> I can repost split in 50 patches, hoping a dozen get merged
> directly. But then I expect discussions requiring too much
> unimportant work to happen, and the series being abandoned,
> giving this legacy API 10 more years..

Well, it's legacy in the sense of "don't use it for new
stuff", but also is it doing any harm in the old code?
If we want to improve the places that use it we can,
but I'm not sure I would worry about moving from one
"this isn't really the ideal" to a different "this isn't
really the ideal"...

If the existence of the function is blocking a separate
cleanup, that's a different matter, of course.

thanks
-- PMM

