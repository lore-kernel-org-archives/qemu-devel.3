Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A465CD5BB6
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2024 12:02:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smBBp-0003rF-W3; Thu, 05 Sep 2024 08:02:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1smBBn-0003pn-PN
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 08:02:15 -0400
Received: from mail-lj1-x234.google.com ([2a00:1450:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1smBBl-0004Cm-Sp
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 08:02:15 -0400
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-2f4f2868783so8306351fa.2
 for <qemu-devel@nongnu.org>; Thu, 05 Sep 2024 05:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725537732; x=1726142532; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=z17vQgwnKU+6Bc+7yReaghb2hi/P0ToLQSFYem2vrHA=;
 b=gKTjIRn7BhRquA3onT78mrsChVUsaR+cXFTC1ri4Y/wkDDAy+s26B5Fj4BCnCvYEDS
 NMSzmvyeeGgn8JJ9RizgpQ+tRbtafa89UkNP3Z35YH4CfYmLmVFtSsbC9gZIOm6oV/dF
 Yn+/4W6cm/KQTdfeIMtbLgrDMV8CIX+q153XwsOQmcQo5g5tqFkj1oCzhNScMV6EFRhM
 jyiu70kBGyvZTEZnFYBrCjHq3b82V1jv2can3auFyCoMXkL1EDQESxCanIxo2GLR5t5S
 zgueG/GqWktByRKSgXYcIyk+A/gZVsk+/3VLDtsQYWgalPHQF/5abfDWo/a+vmuAgfRm
 eKNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725537732; x=1726142532;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=z17vQgwnKU+6Bc+7yReaghb2hi/P0ToLQSFYem2vrHA=;
 b=VceKwgPQ9nhG98ncK/LErLVYH9pZWcaHbt5gasfgNQXnaG0412lTdp3JjlGQISqQJK
 Lfz4l0GCLrLet5wsNj8q+/Jxz7a8QVeb3FqcTjwzwYauoz0dbenmTTHFWy4A6V4EmYp0
 njGNl9bWNB/aPrvrs9HBFDY1QgU7IC7Tsn346TvQW89KVSeK6DsoNEEcjeNII5WnBInD
 4iZNKDmKAjRQLkMWxGlPktowSnEvBq6FVF5B0qpFgTw3W9Mt5/j1oExjo0nJ7E8/FfIi
 ZmT1llwgc92Xvvv9r/PAEcMWKvyUILEqliv0iGx2HlDHbIxhHzePteltK8cdw+qwViW3
 u6ew==
X-Gm-Message-State: AOJu0YzPB7OzqcGizKv1lhErC5yISsxy1YPNNG7pg5OXKHP6QDg8imty
 jJKhf6n6tmHJAyWA9n4WQ0vaAbPRlv1MJP26bNO3DmflkOaFqdA9o8M/NaqEPK9cpkUIB3IDIca
 vN6eUoig1Ld/qLif43bnoXXpdhpaOKqmhCdK3rQ==
X-Google-Smtp-Source: AGHT+IEyILPzCwbaSdBt4kBRkHXbQOEe7A3XovNDX8ZNrYiba9t/kKqA17AYH+2SWUOUWXGUhC2ZuuXsMcaD3S4qcqk=
X-Received: by 2002:a2e:be21:0:b0:2f0:25dc:1894 with SMTP id
 38308e7fff4ca-2f61e025818mr158600731fa.2.1725537731600; Thu, 05 Sep 2024
 05:02:11 -0700 (PDT)
MIME-Version: 1.0
References: <20240904124417.14565-1-farosas@suse.de>
In-Reply-To: <20240904124417.14565-1-farosas@suse.de>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 5 Sep 2024 13:01:59 +0100
Message-ID: <CAFEAcA80bmCt0YmkCaocDn56OSwPLTO4ZZG+n4PXHi6K_z+Xng@mail.gmail.com>
Subject: Re: [PULL 00/34] Migration patches for 2024-09-04
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::234;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x234.google.com
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

On Wed, 4 Sept 2024 at 13:49, Fabiano Rosas <farosas@suse.de> wrote:
>
> The following changes since commit e638d685ec2a0700fb9529cbd1b2823ac4120c=
53:
>
>   Open 9.2 development tree (2024-09-03 09:18:43 -0700)
>
> are available in the Git repository at:
>
>   https://gitlab.com/farosas/qemu.git tags/migration-20240904-pull-reques=
t
>
> for you to fetch changes up to d41c9896f49076d1eaaa32214bd2296bd36d866c:
>
>   tests/qtest/migration: Add a check for the availability of the "pc" mac=
hine (2024-09-03 16:24:37 -0300)
>
> ----------------------------------------------------------------
> Migration pull request
>
> - Steve's cleanup of unused variable
> - Peter Maydell's fixes for several leaks in migration-test
> - Fabiano's flexibilization of multifd data structures for device
>   state migration
> - Arman Nabiev's fix for ppc e500 migration
> - Thomas' fix for migration-test vs. --without-default-devices

Hi. This generates a bunch of new warning messages when running
"make check":

105/845 qemu:qtest+qtest-x86_64 / qtest-x86_64/migration-test
           OK             256.17s   51
 subtests passed
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95 =E2=9C=80  =E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95
stderr:
warning: fd: migration to a file is deprecated. Use file: instead.
warning: fd: migration to a file is deprecated. Use file: instead.
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95

Can you investigate or suppress these, please?

I also see a complaint from the migration-compat-x86_64 job:
https://gitlab.com/qemu-project/qemu/-/jobs/7752621835

Traceback (most recent call last):
File "/builds/qemu-project/qemu/build-previous/scripts/vmstate-static-check=
er.py",
line 438, in <module>
sys.exit(main())
^^^^^^
File "/builds/qemu-project/qemu/build-previous/scripts/vmstate-static-check=
er.py",
line 395, in main
dest_data =3D json.load(args.dest)
^^^^^^^^^^^^^^^^^^^^
File "/usr/lib64/python3.11/json/__init__.py", line 293, in load
return loads(fp.read(),
^^^^^^^^^^^^^^^^
File "/usr/lib64/python3.11/json/__init__.py", line 346, in loads
return _default_decoder.decode(s)
^^^^^^^^^^^^^^^^^^^^^^^^^^
File "/usr/lib64/python3.11/json/decoder.py", line 337, in decode
obj, end =3D self.raw_decode(s, idx=3D_w(s, 0).end())
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
File "/usr/lib64/python3.11/json/decoder.py", line 353, in raw_decode
obj, end =3D self.scan_once(s, idx)
^^^^^^^^^^^^^^^^^^^^^^
json.decoder.JSONDecodeError: Unterminated string starting at: line
5085 column 7 (char 131064)
# Failed to run vmstate-static-checker.py
not ok 3 /x86_64/migration/vmstate-checker-script
Bail out!

I think this is probably a pre-existing failure, as
I also saw it on the previous pullreq:
https://gitlab.com/qemu-project/qemu/-/jobs/7751785881

But since this is a migration pullreq, could you have a look?

thanks
-- PMM

