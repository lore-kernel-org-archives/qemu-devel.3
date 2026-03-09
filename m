Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C63FF3C241
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 12:13:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzZTV-0005dg-56; Mon, 09 Mar 2026 08:12:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vzZTM-0005dN-Hb
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 08:12:32 -0400
Received: from mail-yx1-xb133.google.com ([2607:f8b0:4864:20::b133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vzZTK-0007X3-VJ
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 08:12:32 -0400
Received: by mail-yx1-xb133.google.com with SMTP id
 956f58d0204a3-64aedd812baso10234370d50.3
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 05:12:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773058348; cv=none;
 d=google.com; s=arc-20240605;
 b=GIdbPQuv2Mh8E4DxrMvx++coFTEt8hzZ0UpEJOwbu6EMVqVsE/CSyjoIQJQ7By+evC
 6Nn8hcjM1Ww81/vJNjEhx1OTDFpleveA3tN3rZqtXWvGgxfliIZAY4Ti5jFfQcqXi0xf
 0X4bOOMbpNz7uQHZvOYZwELR4cGi3u6bJYusj6ple6UOAuBVAgbQt4cm/J6yushQ1U+d
 CQt7WkwRfqiHVyVsi+42+Ca4ApSWzthayV3sINVix+ttNXS6bTAegMGx/1gsx8C2UyOz
 MOkjSlV+PPD0leL0tOVLhov31PKP2F0UXpSbv3TZmJGUpOYB3ujNvABxS6TcqPLL0wle
 V2fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=uvLb66/lo4uCFWoSnpyGBo69e6D+rGMubYvJURA2pHg=;
 fh=SsjGpn254SwYopZZotds2xhbvlfgISU81Mr0+s+r16Q=;
 b=E4qv2R1fyUW0DVaVhFRY+xKoOzp3RFPm4FIY880/CRMgYZPN66yb8EZuxygeF+oWp1
 cEIJbyokCJcMafAQC6loGESXAtUxM3UQhjkmU0p/tbJ79AB3q8B20rZZu64F5LusNP2l
 op7Bq5FfHpB0RvQqwSZ5UwHOKJ4sfJhQR8IZu9wdShsnCMCyGzuNHBk5fEXWAgYtjAfE
 FLZY10vRBneZvTgVzmIiObXRHRL1LYWT4gfcRjOahmu5IVyacwWjREZZFTp+aPcNWcFl
 qI51kiVNY0ZAld/lyMrohtDCyH1lKL+YBkh3ndxKzIjhGlicoreVyuwVb3YBFSo9/Zu0
 bVgA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773058348; x=1773663148; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=uvLb66/lo4uCFWoSnpyGBo69e6D+rGMubYvJURA2pHg=;
 b=c2S2sWLZXhLbq+z7w1yfvOlOXZ43zx4hUnP9+2F7qEV70707uaRgTlS/2cc2+17neA
 GH0MeXe6I5VThgaAs6bOK2h6TrpgSkyeLkkd3CntZ8X2tVklgtfUiv1oosgqpQuo7qZC
 AVBKqtH6BZAzbP95Dq6WgjoPW6yrmJmHcYdQ66BJj0NUumI2Px9jLw5PMFppFRw+4t/z
 D36lPe7x7F/CSsUaBjjKA5imv64I39DhealwMg5nKTZ3vxqvFxPzi6s7yfbOXVa8obrY
 u6078d2mguKgZ1e/yBGFzeNceitu7IFKsru8J2/iIo49zA3SDiBrsHwdEGlH9Qg0mcXa
 onFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773058348; x=1773663148;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uvLb66/lo4uCFWoSnpyGBo69e6D+rGMubYvJURA2pHg=;
 b=BHWRFGt6Z+9wWtg0DUpmbd3UH7zDTrCtdUxC4B3pdHse+oZQycI49i2D5NrJ7fXVmt
 IgD8ROKWDYdQ6SA0YQOI1qb02E+dpRUaH2YTZe+qsbRqJ4SS8Fvu6zlh331ebQJ+F00c
 GT1AtTEPqD6ntVOGanCiQW1zT8WNUMx6llli0hW28jUdar97CsVm4njtZZTPjQft7uMT
 58zOmmbeMYJnVC8546Fa5QXkfEnwjl7336wgeQycaryngaLGWn3trlQOy61Q5psqzYcq
 9CGcKhSNVXNXuxb0BYnFA7kqh0MJRd74xi8I369GImmq+gflcOv7DCEycd0fpfXXkOCX
 h7NA==
X-Gm-Message-State: AOJu0Yx/5V9M2CUaPqjx8MCojlY6UzvOLjs+Bng088ls/it5EWnPwBkm
 9VxcHrd9zr7rWDsrCg4l+4R7nlQhkDEQlF+byQ2DKdw8/k/WFKUFFFUUImyKI3BWYD52yYT9Pmh
 ibKNMnXtYm7ulXbCKpAPedKqF9yZvHM0SI2hpoJrbBw==
X-Gm-Gg: ATEYQzwPoS8mcw+3AIhINkqzRHMS5LHhA18Y17+q8LMVAK6QEEo/halt4qKouMnBTru
 vDO+YJ6znqM2G6BDorRfJyVBwDQ0kdQaytVlGG3DWJvR0CHIeOK95jb48XCarGffksxHe88OJBY
 1GFgd5Hj7zm4ABKxD63YsgSGDDGFqBqBjLFT66tyn5BUp4yo4NrWtLBUOVzoeEvqt49rWYabb4J
 aua/WGJz1F5m8l9jV12yfJAGh17O7mRkIhtvkCqGe+NGqWzor3hFPPulYS6oC1cmIfD4QYl5WeT
 PSvvHltt/ZzRPFg0HDLPW2960gSS/W0kMMRSbhAKhjdS3WoQr0krpA0pLU8MHjqbGK0=
X-Received: by 2002:a05:690e:11cc:b0:63f:7de1:7acf with SMTP id
 956f58d0204a3-64d1414bbffmr10954769d50.22.1773058347781; Mon, 09 Mar 2026
 05:12:27 -0700 (PDT)
MIME-Version: 1.0
References: <CAFEAcA_3ed-jb+P8SVh6Pj8uGM+aYcCHTZgvzzHEUFW5zSn3rQ@mail.gmail.com>
 <87ldg11a22.fsf@suse.de>
In-Reply-To: <87ldg11a22.fsf@suse.de>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 9 Mar 2026 12:12:16 +0000
X-Gm-Features: AaiRm53NGCaBTfX-zqM8wCyP4VZorJumVE4Qhvcd4EXBDxgceLg85p8mwakUUuQ
Message-ID: <CAFEAcA-bFxkTpowTaup8fSpZT=XXMOu0=8UfNpr-J9g-vYDZxQ@mail.gmail.com>
Subject: Re: leaks in migration-test
To: Fabiano Rosas <farosas@suse.de>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Peter Xu <peterx@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b133;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb133.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, 9 Mar 2026 at 12:06, Fabiano Rosas <farosas@suse.de> wrote:
>
> Peter Maydell <peter.maydell@linaro.org> writes:
>
> > I'm continuing to work through leaks reported during "make check".
> > Some of them come from the migration-test. (For these to actually
> > appear in the log you need to run with QTEST_LOG=1, otherwise the
> > migration test framework will send stderr to /dev/null and the
> > tests will fail without printing the leak report.)
>
> I'm pretty sure something changed that caused this. In the past the
> leaks would be reported by the parent migration-test binary, so it
> wouldn't matter where QEMU sends stderr. I don't know if it's QEMU's
> build environment or something on my machine.

I think this depends on the kind of leak. If it's a leak in
the test binary itself (migration-test) then that will get
reported in the logs. If it's a leak in the QEMU process
that the test starts, then it depends on what migration-test
decides to do with that process's stderr. The leaks below
are all from QEMU proper, not the test binary.

> > The issue with this is that it means we need to suppress leak
> > reports in the whole migration-test binary, which means the
> > migration code will get no leak-detection coverage at all.
> > (Not all the leak paths have qmp_migrate_incoming() in their backtrace,
> > as you can see below.)
> >
> > We're getting pretty close to being able to get a complete "make check"
> > run with the leak sanitizer enabled, so it would be nice to not have
> > to suppress leak reports for this test at some point.
> >
>
> Go team! Let me just put the migration pull-request out and I'll look
> into this.

Thanks; that would be great, because I think some of these
leaks would be tricky to suppress via the scripts/lsan_suppressions.txt
file -- they don't come from migration-test itself so a suppression
based on the binary filename wouldn't match, and while some
of the reported backtraces go through functions like
migration_connect_incoming() that we could put in a suppression
for, some of them (like the first one quoted) don't go through
any migration-specific function, so there's no obvious function
to add a suppression for.

-- PMM

