Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00E0B606C92E
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Nov 2026 10:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=HHc4kAlM
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRovY-0008D2-08; Fri, 13 Nov 2026 05:54:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xRovW-0008Cu-FK
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 05:54:38 -0500
Received: from mail-yx1-xb132.google.com ([2607:f8b0:4864:20::b132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xRovU-000122-H3
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 05:54:38 -0500
Received: by mail-yx1-xb132.google.com with SMTP id
 956f58d0204a3-6798af41644so539459d50.2
 for <qemu-devel@nongnu.org>; Fri, 13 Nov 2026 02:54:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794567275; cv=none;
 d=google.com; s=arc-20260327;
 b=OvGWSKEE0OP6RBoE0KcNYcy18FA6Y4VcU9FYi57fVERssZ8fAZ2p3nc+6c6PsDecWW
 y7hOTZKU7kglZVXENhOkR0XfWsb2OWt6VDI/MModuEQxaQ9wXWBT8EPNjO17J3DM0/r1
 mvsduVuAK2djr93jKHUEIoB+KzYSjws8lMNvPO/jSAikx6o7tLnjfMu8OU0V+I0UFFJq
 BxRpXMpyOaVxDFKTJd7RUDLSwedMxJUYaJCWQWPLFSP98V6M5k9JDASC1cgtnVu7QI2F
 cY2XsnG1n+bSVuAiHkCs0+M+HI64UsVNkgMhsj+RLhplMaELOduyRoT629egPia09A8I
 ExrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=ynEhXtMQRtbEX7RjisAR2N1A3/ELcd67s5djy0g23uU=;
 fh=y9CZtbXqSNOXxjAXW8o7F7qU42xCk0+1BRU6STfAOtY=;
 b=ZQ8IWh3ix/JU6GHyQQxF84RzD6Gv0js8UuLtJCYYgN2NN4idmTvvr8Ca3WVHRujb6/
 gRF+yMG6GyT0RE9oVgvcDHwxjDuX8x9kqUm1CjSCrjW3LgmDq9bqnyv0PYprdEYMPTk6
 q30+IbIQ+0LUVbw9brsbUqN9SlOedKPfRWaJE6ibYeYr42BLMjIehb92+vpptvroSbc/
 qNipIAARqmI5PjvMPqcghD6HzymSBzA7UgtJF8I6sUj9E8JB5EI+NdpVXxTJlAxM7oQ+
 7agmeOEKW+cM86uamAV7SxCIHmJsekxWhL3UgDOu1xKxd0rQHevoJ2QyHkbng5iB+djO
 KjFw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794567275; x=1795172075; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=ynEhXtMQRtbEX7RjisAR2N1A3/ELcd67s5djy0g23uU=;
 b=HHc4kAlMbvggP/f8f70jYJ5JfjYWjCfg2G1GjKj+hsgvp4S3dGL5/Zy/MtjvFpt5WG
 NBJITeegTr2G5JVfvOJuNV9++33yHQGcVOyTBFExXJKbDImOVbuUni4yk2bJ7ypKVse0
 9+zyt7xdlcD5GDQSFsqLY/FfgMJ+cpDU9N6jiXC3kJ/NOyTb2+xMH/V/c62H4UuZF+av
 3lCTfF/Xyg8aOvomIKcmEqXqmJEHC24SMz3ShZ3puLkgaU+pbamS9cEAmgd1khi2tWY8
 1qzRQAqMqdRwZqcRSX8mazyRxsKZgbCD/gn2ymFhs0NEFNSyyWVmd4s7GucBV7yWDMof
 j4WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794567275; x=1795172075;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=ynEhXtMQRtbEX7RjisAR2N1A3/ELcd67s5djy0g23uU=;
 b=HuZH7glfdwFK6xnyC2+eAZXWYELOiKCSmn++pa6TkHfoirSGJLnksfMeqzxlFy7VS4
 lx9D1m5fykApZEuZ1HFibUyqm840qL+Aah+/0BkfgdeM0ZHjD6mjuHGROq229f2kskig
 EnB9PWwpQMtj1zKeAAi3zoV2P2jDGjQg2euG7QY9NHE7KRenJNJEciZzqhniLXbHzj9R
 CPnuF/ATzPlZotR3OqqiE8B43n5YJDgVoHwcj4ycGBFKe7iFp0tG8fYpgaDt3uuPwAqZ
 CKxGA/dSMy30wFTujyOxwfmD2OEO0O/ZH3kftjK8YiuN3wT1Hee2dO4uYk8NEqK3+xrz
 P9/A==
X-Gm-Message-State: APuU4Z/8qh/Pm58ebf1op55TC+Mdf7GsgZIpiW4aSglYMmmjvn/rVOCp
 cf3GmL8ooOJG3F+vHD03QHTIHVnxA87fBnIgiAlRh710hCZ9LpowNSbwzzYnWG7S0JhS8bqBSel
 POgamPy5X7XC+zo/v0xN6sRZ/mMg6hWFie/2zDlmhdyFaqKCid5hnAE8=
X-Gm-Gg: AYBFou20MqxkH0BPHRYh2AunCTTQn1W8VQnlXQP71uszf43OS30uYwcdRzmx9q/y75f
 dcYLPTmzHaBQbS1havQeW9Nwy1E+KrAkZmY+VoEH+8J/8Zx/R92t6xQXyNj1+y2W2b2uw71nY6u
 BkTmzUs0S8ZVxBsgZWRdVrhwlc5v4yM1DGjGOb9nJPBvglX91R0FaPpTdaNIelLuE2VfubztJwA
 l2TScumr1s/ABmXLi7JkMizbbRzAZWtHlE73WP3JjAazO/tCT9Dz5PqBYdjv+UhlNR7cmCROCZ0
 aeZnRgvd+UTzCE/i0J6VBAlSiegtRAXYx7ejZoXMpII7Y18vCdwSYeZTK5hJVaevG1A5ui6l8Mb
 oN5e5tJ3SCxf486DYl5DWftTzm5M25xdebQazLZOkgJz0MSBmMdYdKtzPeEVCz31fyfWqEG8BHz
 QZ1aSgyrJFLMDXWDf6J2wW
X-Received: by 2002:a05:690e:4847:b0:679:b8fe:a6e8 with SMTP id
 956f58d0204a3-67d896b7bd3mr1131313d50.36.1794567274760; Fri, 13 Nov 2026
 02:54:34 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261106155858.3779237-1-peter.maydell@linaro.org>
In-Reply-To: <20261106155858.3779237-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 13 Nov 2026 10:54:23 +0000
X-Gm-Features: AclHuK9fyjIfXbA2bWpQvPdOex4oxnLX0zb7p-yrbseUCOds45RlERbVvcvplm4
Message-ID: <CAFEAcA9s6N6hu0=5y0vgBhDQu4PCsL4zkTQh_Mh--ZrwSkF5YA@mail.gmail.com>
Subject: Re: [PATCH 0/2] meson: Revert recent changes to qemu version header
 handling
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Yonggang Luo <luoyonggang@gmail.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 John Snow <jsnow@redhat.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Philippe Mathieu-Daude <philmd@mailo.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b132;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb132.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

I have been running into this all week, and not only with build
trees that were last built on some commit that preceded the
introduction of the relevant commits. RTH has reviewed this,
so I'm going to put these reverts into target-arm.next for a
pullreq to go out by Monday. We can figure out what our preferred
way of handling the version header is once we've fixed the breakage.

thanks
-- PMM

On Fri, 6 Nov 2026 at 15:59, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> This patchset is two git reverts, to revert ab78ac76f44a124 and
> fc35f24387703da. Those commits try to move the handling of version.h
> to entirely within the meson file with no external script, but
> unfortunately if you do that then there is no dependency information
> about it passed to ninja, so the file isn't recreated if it's
> missing. In particular this breaks incremental builds from a build
> tree that pre-dates those two commits.
>
> There's been some on-list discussion:
> https://lore.kernel.org/qemu-devel/20261105181449.1691-1-luoyonggang@gmail.com/
> Since it's not clear how we want to proceed, I'm posting this as
> the "revert to the situation we had before", so we can discuss
> what we want to do with a bit more leisure.
>
> thanks
> -- PMM
>
> Peter Maydell (2):
>   Revert "meson: rewrite scripts/qemu-version.sh directly in
>     meson.build"
>   Revert "include: introduce qemu/version.h"
>
>  meson.build                          | 29 +++++++++-------------------
>  include/qemu/version.h               | 20 -------------------
>  bsd-user/main.c                      |  2 +-
>  linux-user/main.c                    |  2 +-
>  monitor/qmp-cmds-control.c           |  2 +-
>  qemu-img.c                           |  2 +-
>  qemu-io.c                            |  2 +-
>  qemu-nbd.c                           |  2 +-
>  qga/main.c                           |  2 +-
>  scsi/qemu-pr-helper.c                |  2 +-
>  storage-daemon/qemu-storage-daemon.c |  2 +-
>  system/vl.c                          |  2 +-
>  tools/i386/qemu-vmsr-helper.c        |  3 ++-
>  tools/qemu-vnc/qemu-vnc.c            |  2 +-
>  util/module.c                        |  2 +-
>  scripts/qemu-version.h.in            |  1 -
>  scripts/qemu-version.sh              | 25 ++++++++++++++++++++++++
>  ui/cocoa.m                           |  2 +-
>  18 files changed, 49 insertions(+), 55 deletions(-)
>  delete mode 100644 include/qemu/version.h
>  delete mode 100644 scripts/qemu-version.h.in
>  create mode 100755 scripts/qemu-version.sh

