Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D279CD5BB8
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2024 19:55:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smIZT-0000UX-1k; Thu, 05 Sep 2024 15:55:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1smIZS-0000Qi-9S
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 15:55:10 -0400
Received: from mail-lj1-x233.google.com ([2a00:1450:4864:20::233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1smIZQ-0005Fb-AQ
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 15:55:10 -0400
Received: by mail-lj1-x233.google.com with SMTP id
 38308e7fff4ca-2f4f505118fso13734201fa.3
 for <qemu-devel@nongnu.org>; Thu, 05 Sep 2024 12:55:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725566106; x=1726170906; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=HdMMiM8FBhh+JZDi5gOlvhIrUAb12USwbXo7UrbyQMY=;
 b=Mekype8TvqdKmkclwnlXGIQ313ToMUJrrUR60Esaw0izZEZEpt7cVPoWCZ7V1+d77M
 d+bHmGz5+T3ayELDY96oPa6CqkbLftAFERL3FK6iReoZjzYthtgd2goZ88zUAO/Les5B
 +Kymhoz+zFzcx0fG5HqNQN6kfDHZolRsbjcfaUZ9hGBWTdsvHbV1eMcfKOh7bvIHKo5H
 LpixfGNvVMbJgpSkbegpH3eIRAWKmcwE/n4JlhSv6MmGUgiGtTgT/Aa69sg3chQwN/td
 SVXxkwzCWGm9BJMw4BmLr1x98CbWOcrJeN6R/DKfK6CnH+/p+EfKVki0OmfLZy1mfocK
 D64Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725566106; x=1726170906;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HdMMiM8FBhh+JZDi5gOlvhIrUAb12USwbXo7UrbyQMY=;
 b=UqSIn5CPLvgwfhyIch0/1flUStwIt3/9H9JdgDMUWnHg924Pa1SWcUWwdgaolb/FdV
 RvWrKUn5Yi718L4/YlDu7zZdt/RISambGl7mbmZSONDzKKM7G/uFuTzjWivLAPxBNYIU
 49mQlaAUBs7S0tNPZkBVJm2pxEIUtH158LcR7HI7o3ZIOhRZTv/3yubrctKRg0fhZ1HZ
 eao5nP4G34TQHrdBHIkm4fsYrrYqG224M+8ip9RlY1OsCedrrDFwhhr5M+wH/ZxSvkrL
 C8xEw4dTdpG/ir2TkqBR/0KnI9JqokuBcE5bmKJxsKhebirRi61WddqLYk+KjkfA+qcy
 nuxg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXn3mjsncX7xykwvV3nQjwiJWe/aIeE0uzutg87knSfHc+XRGpR0NCwqHjCbdPUjqMXZNIY9tYbswq4@nongnu.org
X-Gm-Message-State: AOJu0Yxaov+zEmlW/cpOeEBP4wz8hUixVlQWShc0HyenNXE5VTOefE0L
 dtQ5r+mkgncY/TeTxtgqV+0jmOVOl/+v78+ODWTkg8JpQif1icL1CpRufCODvUdbkmIDmknd2CS
 EJx/n7zjVY4bzzXAoouKa8V/xUJ9z3UotJUvAgg==
X-Google-Smtp-Source: AGHT+IGKHPLif6iGkLbpMT268nMPXYNr7V4IYAqMbgrvMjLUZas7GrkEMbhMqIU87joTeo71H+4n6o6BvipxvZTApt4=
X-Received: by 2002:a05:651c:550:b0:2ef:1d8d:2201 with SMTP id
 38308e7fff4ca-2f751ef7db4mr1532331fa.23.1725566106180; Thu, 05 Sep 2024
 12:55:06 -0700 (PDT)
MIME-Version: 1.0
References: <20240905185445.8179-1-farosas@suse.de> <ZtoEvvdDO_3PsfDz@x1n>
 <87ttetlwsb.fsf@suse.de>
In-Reply-To: <87ttetlwsb.fsf@suse.de>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 5 Sep 2024 20:54:55 +0100
Message-ID: <CAFEAcA-1SWDYAsz_icPEXGOcbs0N0Aafn9cv69KASK8uPW6OrQ@mail.gmail.com>
Subject: Re: [PATCH] ci: migration: Don't run python tests in the compat job
To: Fabiano Rosas <farosas@suse.de>
Cc: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org, 
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Thomas Huth <thuth@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::233;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x233.google.com
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

On Thu, 5 Sept 2024 at 20:34, Fabiano Rosas <farosas@suse.de> wrote:
>
> Peter Xu <peterx@redhat.com> writes:
>
> > On Thu, Sep 05, 2024 at 03:54:45PM -0300, Fabiano Rosas wrote:
> >> The vmstate-checker-script test has a bug that makes it flaky. It was
> >> also committed by mistake and will be removed.
> >>
> >> Since the migration-compat job takes the tests from the build-previous
> >> job instead of the current HEAD, neither a fix or a removal of the
> >> test will take effect for this release.
> >>
> >> Disable the faulty/undesirable test by taking advantage that it only
> >> runs if the PYTHON environment variable is set. This also disables the
> >> analyze-migration-script test, but this is fine because that test
> >> doesn't have migration compatibility implications.
> >>
> >> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> >
> > Reviewed-by: Peter Xu <peterx@redhat.com>
> >
> > We should still merge your previous pull, right?  Looks like that's the
> > easiest indeed.
>
> As I mentioned there, that pull is not to blame for this situation, so
> my recommendation is to merge. However, there is still the suppression
> of the deprecation messages that Peter asked about. I'll send a series
> for that in a moment, but it requires qtest changes and probably a lot
> of discussion.

Looking at logs for other things I've merged, those deprecation
messages are already upstream. So I'm OK with giving your
pullreq as it stands another attempt at a merge.

thanks
-- PMM

