Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85FC1C5AD49
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Jun 2025 13:45:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNXO2-0001aQ-QQ; Fri, 06 Jun 2025 09:45:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1uNXO0-0001aG-6Q
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 09:45:32 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1uNXNx-0005r9-In
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 09:45:31 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-607873cc6c4so558453a12.1
 for <qemu-devel@nongnu.org>; Fri, 06 Jun 2025 06:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1749217527; x=1749822327; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kdIVlOR19SETwDHK/mMphz9ksKNDA+CTLmc38J/QmHY=;
 b=hgRFqUY1PkZbwFkWwCf4CKmmWk8Snt0eYRuQomJ7vkXBzQ9j/Fm25YkqTcOveSNowJ
 +uXApjvzoAb8J+UCDzBEIMZH2UbZx/7XFcnOWpNWisY7ivbIFpOFoJiR6fZ5OHyn0NW7
 su4bchb+2aLTN6mQyGHarXKazYgDJvMim58gao6Nv2OdKJHpjb9OT8hzbPPfAP4uKeTC
 ZIawRoCMliUgs2Q6VU8vDzcNPM6RCrhgbSPJxz/mIi0IDoXUJJW/FKS2xl2oqjs39Uq+
 iM58kzXfrw9OVs3dvg0ggLc5D2VrEIzIaTDCHZSusOSwltrYBv1gAED+WCNVsbX04j/D
 Z1lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749217527; x=1749822327;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kdIVlOR19SETwDHK/mMphz9ksKNDA+CTLmc38J/QmHY=;
 b=hZ8uwNnyfNHPoDs2lhYbj/TWxlbcDEFD/yNVJAmEut1WHoZHC3HIgd5jbGNnCpnTFB
 6+c/gGDgKV4maYkZWW8skXccP/3kmwl4AaHcamuoUqvvoPcUWJoaHlnrwTgP4r6No/bo
 9DKNwFNicxy91TIcyb6z6ImXtNPMko5xMSTjafYHf7oPcFfkVkBtJK+bsgnD7XbQX82F
 8UPnFtv4gveU9khMuf8BaOnCpeNtln/o7wNPcUikN1xhQ9lTsfKkeQ9maYzN39aYFJ8l
 YLLfdenNFHEuhqZ+Xcy7MLWL+owL9R1huypVBhTWwo5dDDwOeuKjIpi0lch90iQmODvE
 NEFQ==
X-Gm-Message-State: AOJu0YxNA9MG3/VUSbFHjUDd2TnEDQ5BnshuGb00q+kS7tWDXVf5ZRHx
 /xEXRl0v50Z9B5Zv7mA4ybvrHyHX64TrAkYeulzUgBDsZrdzn7jgAkufZZuJKqOXrpP26PfnWhd
 eDQWli5qats9HBeiudglmuRHkMboHwc9JmA==
X-Gm-Gg: ASbGncvP0D+oDBuIBVOuOneMPBVFrcFWRvuJ7reWZq738YfuY9Qxugb4YGWVWaM3Y2l
 MPkM+iMqPuSh8djVfN3egI47AI1taGvW1jzurzHt8wkRIgvB+FLRRkQzBhVYs+Tekzro1MbFthh
 vsXsxqQ763Liz32c5cZhBzedxINgJq1/eR+IhXAJfo9g==
X-Google-Smtp-Source: AGHT+IHH3AINeGqSBQ/SCItDGmz6tM33gdSimyKV662znZw04cd+KDvFDcYKPczYutjOJQtJZUjD9bRXDWf+r/mQ4Ig=
X-Received: by 2002:a05:6402:27d1:b0:601:cf15:c093 with SMTP id
 4fb4d7f45d1cf-6072287002fmr6814246a12.14.1749217526262; Fri, 06 Jun 2025
 06:45:26 -0700 (PDT)
MIME-Version: 1.0
References: <20250605162651.2614401-1-alex.bennee@linaro.org>
In-Reply-To: <20250605162651.2614401-1-alex.bennee@linaro.org>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Fri, 6 Jun 2025 09:45:14 -0400
X-Gm-Features: AX0GCFvujQyAgzVx5ATx8xsdLfoX_NMMd5OjhsMUhHChR3UNitZQlTDcy2VkB4s
Message-ID: <CAJSP0QX9-DAzHSsG=aE53=BafmsF2a40toQivAmyOdhWF4aDxQ@mail.gmail.com>
Subject: Re: [PULL 00/17] maintainer updates for May (testing, plugins,
 virtio-gpu)
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=stefanha@gmail.com; helo=mail-ed1-x532.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Thu, Jun 5, 2025 at 12:28=E2=80=AFPM Alex Benn=C3=A9e <alex.bennee@linar=
o.org> wrote:
>
> The following changes since commit 09be8a511a2e278b45729d7b065d30c68dd699=
d0:
>
>   Merge tag 'pull-qapi-2025-06-03' of https://repo.or.cz/qemu/armbru into=
 staging (2025-06-03 09:19:26 -0400)
>
> are available in the Git repository at:
>
>   https://gitlab.com/stsquad/qemu.git tags/pull-10.1-maintainer-may-2025-=
050625-1
>
> for you to fetch changes up to 66835968ca7246d385218be9776a80a5136563b7:
>
>   gdbstub: update aarch64-core.xml (2025-06-05 13:47:37 +0100)

I will wait for the discussion to reach a conclusion before merging
this pull request.

Stefan

>
> ----------------------------------------------------------------
> Maintainer updates for May 2025:
>
>   - expose ~/.cache/qemu to container builds
>   - disable debug info in CI
>   - allow boot.S to handle target el mode selection
>   - new arguments for ips plugin
>   - update virtio-gpu MAINTAINERS
>   - re-factoring of blob MemoryRegion handling
>   - remove extra draw call causing corruption
>   - support Venus fence contexts
>   - cleanup assets in size_memop
>   - fix include guard in gdbstub
>   - introduce qGDBServerVersion gdbstub query
>   - update gdb aarch64-core.xml to support bitfields
>
> ----------------------------------------------------------------
> Alex Benn=C3=A9e (11):
>       tests/docker: expose $HOME/.cache/qemu as docker volume
>       gitlab: disable debug info on CI builds
>       tests/tcg: make aarch64 boot.S handle different starting modes
>       contrib/plugins: add a scaling factor to the ips arg
>       contrib/plugins: allow setting of instructions per quantum
>       MAINTAINERS: add myself to virtio-gpu for Odd Fixes
>       MAINTAINERS: add Akihiko and Dmitry as reviewers
>       hw/display: re-arrange memory region tracking
>       include/exec: fix assert in size_memop
>       include/gdbstub: fix include guard in commands.h
>       gdbstub: assert earlier in handle_read_all_regs
>
> Dominik 'Disconnect3d' Czarnota (1):
>       gdbstub: Implement qGDBServerVersion packet
>
> Dongwon Kim (1):
>       ui/gtk-gl-area: Remove extra draw call in refresh
>
> Manos Pitsidianakis (2):
>       virtio-gpu: refactor async blob unmapping
>       gdbstub: update aarch64-core.xml
>
> Nabih Estefan (1):
>       tests/qtest: Avoid unaligned access in IGB test
>
> Yiwei Zhang (1):
>       virtio-gpu: support context init multiple timeline
>
>  MAINTAINERS                               |   5 +-
>  docs/about/emulation.rst                  |   4 +
>  include/exec/memop.h                      |   4 +-
>  include/gdbstub/commands.h                |   2 +-
>  include/system/memory.h                   |   1 +
>  contrib/plugins/ips.c                     |  49 ++++++++-
>  gdbstub/gdbstub.c                         |  19 +++-
>  hw/display/virtio-gpu-virgl.c             | 102 +++++++++++++-----
>  tests/qtest/libqos/igb.c                  |   4 +-
>  ui/gtk-gl-area.c                          |   1 -
>  .gitlab-ci.d/buildtest-template.yml       |   1 +
>  gdb-xml/aarch64-core.xml                  |  52 ++++++++-
>  tests/docker/Makefile.include             |  10 +-
>  tests/tcg/aarch64/Makefile.softmmu-target |   3 +-
>  tests/tcg/aarch64/system/boot.S           | 172 ++++++++++++++++++++++++=
+++++-
>  15 files changed, 382 insertions(+), 47 deletions(-)
>
> --
> 2.47.2
>
>

