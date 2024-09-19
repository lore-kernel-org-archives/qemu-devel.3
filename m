Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63DFFCE8D7D
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2024 12:35:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1srGNO-00009f-OP; Thu, 19 Sep 2024 08:35:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1srGNK-0008RN-Ex
 for qemu-devel@nongnu.org; Thu, 19 Sep 2024 08:35:10 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1srGNI-0004OI-Ez
 for qemu-devel@nongnu.org; Thu, 19 Sep 2024 08:35:10 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-5c413cf5de5so1133295a12.0
 for <qemu-devel@nongnu.org>; Thu, 19 Sep 2024 05:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726749306; x=1727354106; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=o/SwdblouEhEnCZnb5NVaN4hQYxFPGgEO3+R3dzFctc=;
 b=pfghPbojW/rA50vb7ntB9la07w989gHgW34kXLk+UEMDB4uGI8ieDWamNMtgyJQBvA
 6ctBkg60CRkXcGBVP/BBFI560Lc1zoUFhdNYb+TN5w1BLoa7Q3bE+GvP+n0euuSegUtI
 j1iJ7CcgaO8S+mqZmfBEPoFhAdpvz6YsDO52/ZPZWrRpPYM9qDlxVrY0EWjzfngScoIb
 aE3UnNSmqw8HVPINgqxhICsoVMMMIvJVwUyAYcydPwynWzaQCrv1edIOzz30RV8QQNW+
 JrroEcoOLz37uyJ2sZPAwkFTa2bZf6hY2e6C5Kf5+YiPsbjiHsHPE8wz5jJDk4E0GUwA
 hXxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726749306; x=1727354106;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=o/SwdblouEhEnCZnb5NVaN4hQYxFPGgEO3+R3dzFctc=;
 b=M7LJn+RWAzGr+b9bYb+3KPEhzYK9MqbIFEjBv/+Ha/2xt+TVUfquWGoB9EsSi+KSZf
 n1szJgELsWeIeys+BtnF3HHSo62VuDJSSooXA8nmtO5MFXayPLO0nR9+ziY/NL/VjTVX
 UMM4z2WPur4UTqhl4/Rkl5Cju7oZerVPMLVEdQAh5Ag2WVSg0YfEp7pdbs/udC7p/9rF
 ellqBYnYTUBRky6GqQkM/VIh/wkihHJwCQpxbGLA0KAjkhD1KXD2+IbLfZ+FB51W5SOD
 3C59shyS/mBwEMMxBIkO8Oe/Xzc23YZxILmDFx9VlDIPRDwoK3T+Mhivup8o4NGiVzBD
 D1TQ==
X-Gm-Message-State: AOJu0YzwkUklLiaUlwH+NriiF67HEWWQJOscZOUjemx9i2LipJx+2FK4
 80CgYM47V8Z19XlSZi1w3wxlmFvhRXi064DglV7bwDRln/vxTJW2L1tO4mGrQYsOcsjA8ZQgL5n
 MmrQ2cur6Gf/mCgygWEa9ReullFyYX7Tctwwetw==
X-Google-Smtp-Source: AGHT+IFTP45wdSS8WPzGLkL0d7NBYuJ0N2Bibaj3UCTaa7gVC3/qfiIGX0Ts5f5YrahqViPGJKmbcQGcqLOaewVW2B4=
X-Received: by 2002:a05:6402:24a5:b0:5c4:b00:5e62 with SMTP id
 4fb4d7f45d1cf-5c413e2a27cmr21858261a12.20.1726749306432; Thu, 19 Sep 2024
 05:35:06 -0700 (PDT)
MIME-Version: 1.0
References: <20240819144303.37852-1-peter.maydell@linaro.org>
 <20240910110344.10e4805e@imammedo.users.ipa.redhat.com>
 <CAFEAcA_Rjiy1so28OVPpL=+++XuU+gSXhn-v_WHMcpc_wa_xMw@mail.gmail.com>
In-Reply-To: <CAFEAcA_Rjiy1so28OVPpL=+++XuU+gSXhn-v_WHMcpc_wa_xMw@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 19 Sep 2024 13:34:54 +0100
Message-ID: <CAFEAcA94EdUOOk71nv4oFRJXNBM=62FCD9dfwVSWMS-VM_OZtw@mail.gmail.com>
Subject: Re: [PATCH] docs/system/cpu-hotplug: Update example's
 socket-id/core-id
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x535.google.com
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

On Tue, 10 Sept 2024 at 10:38, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Tue, 10 Sept 2024 at 10:03, Igor Mammedov <imammedo@redhat.com> wrote:
> >
> > On Mon, 19 Aug 2024 15:43:03 +0100
> > Peter Maydell <peter.maydell@linaro.org> wrote:
> > > @@ -83,34 +83,32 @@ vCPU hotplug
> > >
> > >        (QEMU) query-cpus-fast
> > >        {
> > > -          "execute": "query-cpus-fast",
> > >            "arguments": {}
> > > +          "execute": "query-cpus-fast",
> > >        }
> > >        {
> > >            "return": [
> > >                {
> > > -                  "qom-path": "/machine/unattached/device[0]",
> > > -                  "target": "x86_64",
> > > -                  "thread-id": 11534,
> > >                    "cpu-index": 0,
> > >                    "props": {
> > > -                      "socket-id": 0,
> > >                        "core-id": 0,
> > > +                      "socket-id": 0,
> > >                        "thread-id": 0
> > >                    },
> > > -                  "arch": "x86"
> > > +                  "qom-path": "/machine/unattached/device[0]",
> > > +                  "target": "x86_64",
> > > +                  "thread-id": 28957
> > >                },
> > >                {
> > > -                  "qom-path": "/machine/peripheral/cpu-2",
> > > -                  "target": "x86_64",
> > > -                  "thread-id": 12106,
> > >                    "cpu-index": 1,
> > >                    "props": {
> > > -                      "socket-id": 1,
> > > -                      "core-id": 0,
> > > +                      "core-id": 1,
> > > +                      "socket-id": 0,
> > >                        "thread-id": 0
> > >                    },
> > > -                  "arch": "x86"
> > > +                  "qom-path": "/machine/peripheral/cpu-2",
> > > +                  "target": "x86_64",
> > > +                  "thread-id": 29095
> > >                }
> >
> > beside reordering, which seems fine, this hunk also introduces target change
> > perhaps a separate patch for that?
>
> What target change? It all says "target": "x86_64" both before
> and after.

Hi Igor, would you mind clarifying what you meant here?
I'm happy to respin, but I don't understand what change you're
asking for.

thanks
-- PMM

