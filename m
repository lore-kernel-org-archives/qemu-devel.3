Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C72B6C52D7F
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2024 19:15:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sefw0-000684-Ho; Thu, 15 Aug 2024 15:14:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sefvy-00067a-M6
 for qemu-devel@nongnu.org; Thu, 15 Aug 2024 15:14:54 -0400
Received: from mail-lj1-x235.google.com ([2a00:1450:4864:20::235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sefvw-0000wZ-21
 for qemu-devel@nongnu.org; Thu, 15 Aug 2024 15:14:54 -0400
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-2f189a2a7f8so11778121fa.2
 for <qemu-devel@nongnu.org>; Thu, 15 Aug 2024 12:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723749287; x=1724354087; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=C4Tdm0BLIKW4vLJ/tMJlCbjNPdC0nP6nH25zH31/otc=;
 b=MOZ6yYV4Flws3JDkQvrb3/LTK6oO2sn8nKrYSYQG9DtceCDy3mSJrpMgHJCeS25zbw
 99k5ugHnwpp6Mzi9kzG6LJD0zUr0r7rP26JiKOkUywRm60ov56h9RSSGehS027PZX9yn
 YJg7ZL0sahOTGwn/t0FgTAMOxQSJbPYxOMPZJ3dvnkVhKEls4kF1cR6CewxfyWesjDbM
 6FgxVFG1A/f+AJ1nkNJrV/z6UHfL/4agPIfQs7pGS12jcaRvFuel2Gld6//ZFRSao09h
 ocMnu9Yct0y3YTp4Ys47QT7S7zCHeej3OlWl+QfwsplML0A/AGz25sGUp8bkK3KHdZCl
 Oxcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723749287; x=1724354087;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=C4Tdm0BLIKW4vLJ/tMJlCbjNPdC0nP6nH25zH31/otc=;
 b=ChK34hNDlldIK8EtGYE6k7kgnScxhUBzu/h3bxFZyZzAr0MV4xciFJGXiki5qh8CbQ
 RCp3VK49dhNEEFzgkZNNHUSO/4JcOg/eSJsadrulRR1L7+his5vDIyjBC7NiI4NRA2Zj
 PANq4kT0ny5BzkySXImBHi2reF3HlyLXa/o//rB9dEaH16zLGeQp8L7kDBLFD7au0gwB
 DQekHuW6lvgOrBReVZA0laKUUEOiBvWiif4VoPnJ/cYG4Mf4cStGll/Isb/BfvG4oPwx
 HNf2q1bcfZP3NzrR6oeowdtXaU7Jde98Mf1VNcvQjSZ2ldh5gfzZ/xZoT/1atxfHv9EF
 d1DQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXgJIWT/sF1YSFMISO9t6upq4hv7v68XirW1ya0CD6akL/RdMfeZQJi48VQifkC8cPzb1y6IWAaohUH8+1wwb4EdIGE4g8=
X-Gm-Message-State: AOJu0YxP6z2cSct991uE/3r7ZuGix8HDI9KFxG1PxXrmchG6hWq3qISZ
 B98dCT1kNtNKBCX5DkfbUPT6BTdpsIPVh7z+w3v7nJrJs2KDZ/Xq8vY8rxKkk3SaFrGmy78CtFu
 399qCf2FcfbMQ4GSBH71X4gfGvZSzvTEs1yk7Jw==
X-Google-Smtp-Source: AGHT+IGJQx/sQ691E3W6OF+ViiUX+rqxQzf51QUTpmDpO+JPAXVva3G373tcrxjTEk0qqN8t0V7fZkTbGpOLxbJ1WpU=
X-Received: by 2002:a2e:96c7:0:b0:2ef:1c07:475b with SMTP id
 38308e7fff4ca-2f3be5990b9mr4137091fa.15.1723749287144; Thu, 15 Aug 2024
 12:14:47 -0700 (PDT)
MIME-Version: 1.0
References: <20240814233645.944327-1-pierrick.bouvier@linaro.org>
 <CABgObfa8GTo06hm0oDT+GUy-_6z=FVH2xnLWFcpm39_=_p4LNQ@mail.gmail.com>
 <f31bac22-5fcc-4f01-9eb3-c9512daa41d7@linaro.org>
 <CABgObfZ2qiOg3WYerO7nUP4U+726f2=ToBiTdi=Jx18DRNkxhQ@mail.gmail.com>
In-Reply-To: <CABgObfZ2qiOg3WYerO7nUP4U+726f2=ToBiTdi=Jx18DRNkxhQ@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 15 Aug 2024 20:14:35 +0100
Message-ID: <CAFEAcA91B6BNu=dkYbSOZQzFcspk0NnFQV5VkiWE6CtxZnWg9w@mail.gmail.com>
Subject: Re: [PATCH 0/6] build contrib/plugins using meson
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Alexandre Iooss <erdnaxe@crans.org>, Thomas Huth <thuth@redhat.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::235;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x235.google.com
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

On Thu, 15 Aug 2024 at 19:38, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On Thu, Aug 15, 2024 at 8:04=E2=80=AFPM Pierrick Bouvier
> <pierrick.bouvier@linaro.org> wrote:
> > > One argument from moving contrib/plugins to meson is that the Windows
> > > case depends on libqemu_plugin_api.a which is built with meson(*);
> > > that said, libqemu_plugin_api.a should be installed - which would
> > > justify it being used from an "external" makefile.
> >
> > You need meson to build this lib in the first place, so I guess that
> > 99.9% of the people writing a plugin will have a qemu source tree (with
> > access to plugin headers), and first compile the lib.
>
> Note that the lib is built at configure time, not Make time.  It's not
> a normal library.
>
> > I am not convinced by the scenario where people build this out of tree
> > to be honest, but I may be wrong.
>
> The idea is that people copy the Makefile, and yeah I'm not sure
> either if they do it but it can be useful.

The original theory was that since plugins are supposed to
be independent of QEMU version that we should have the
build system also be independent of QEMU (and perhaps that
plugins might not be in the QEMU source tree at all some day).
That's why they're in contrib/ (though I am not a fan of
contrib/ as an organizational category in the filesystem...)

-- PMM

