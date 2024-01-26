Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51568C47422
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jan 2024 15:56:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTOZ4-0006fZ-23; Fri, 26 Jan 2024 10:56:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rTOZ1-0006eq-HH
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 10:56:19 -0500
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rTOYy-0003K5-Hd
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 10:56:19 -0500
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-55cef56c6f9so480698a12.3
 for <qemu-devel@nongnu.org>; Fri, 26 Jan 2024 07:56:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706284575; x=1706889375; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GpvuW6VklVVM7eW1BtYVkaHnC0A1XyBpz9Sgh8jHrHY=;
 b=G0T+bHqQ8/kv101KNULr7w1SyYGDYtj9lqy9bw8L8t9VFF6q4OMVvtFRmbLQXhDmVL
 ji/dwcN31Uqc/LNRhWWQ5i6xStvACa3rVy29EDxn5jTRozciVIk3JzBTTOhPOwCi7S8Y
 RLnRr8mAmEW/mqPx9xyl9m6pVqIaDoC6jppjQvHvblD4bVgn2GALyud1aCbW0fFTOnSY
 omhrmyuyO0dvMVw0Urm1ZiPCM5sJVF1sjz1L+z5b3sDnT0TWr2nrVfcBjBJKNsAyQ0+O
 N55gy2tIs8xZBe1pdvCiuL9nul9cyPOg5l2kq0wcLCMlysNkzA1vTXrhrHIgQxFw9UII
 DrqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706284575; x=1706889375;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GpvuW6VklVVM7eW1BtYVkaHnC0A1XyBpz9Sgh8jHrHY=;
 b=vaOTid1iV9n5AHAzGTOjkvv0UFq6hFMmLZoQtxAC4CqNphm+1AVoS1A0DdNE8g7e2v
 v8H+S4v/Xutdvn2gJqmN+Jp1PJvAdy11wOV/dP28g5h/hgQ2YrCDu+f2H/WNaTadAVK+
 UH3USe3FmYbRvIVVCOq6iXbK5pTZSwoO4vhAyZLaNolS1QBZHUPEK+CpeZwRiJodNSFD
 zDP/zvGiTBeOA/aJnmvohHWAzIedcLX3fKhssIGrwUfupOGVORm1HHDExud2uF4yy1QT
 rSYWsKXFO04fQJEYS+g3qAVZS/SrQezPt1/XGskceiK3f6h5Srbapl9XKIJq7LhLGj1c
 HTlw==
X-Gm-Message-State: AOJu0Yx9odiUmK7GY4jGkkUaHUJWP+xOQqhrkaPhvU1rfQPS0vvT2iiD
 /OeI8ko8yS0tsh9Hl0GwD2YFQuoaQorT1OCJPGU1V29A3g9+6WffZiNRuem+9jgvkBn9kVWSTaC
 iDsZ8oOOM5fLu1YdxRXzA2Nzich2W/riCYXoYSQ==
X-Google-Smtp-Source: AGHT+IHc6CV8bqi9GTSU0ONNi4snSi1GqPCjJV/NH9n742qqocropkO9EY3D+VX0p3n9NoMoiRY9dEOd8BdlGAOTxrI=
X-Received: by 2002:aa7:c611:0:b0:55c:7ab7:d357 with SMTP id
 h17-20020aa7c611000000b0055c7ab7d357mr1023716edq.14.1706284574871; Fri, 26
 Jan 2024 07:56:14 -0800 (PST)
MIME-Version: 1.0
References: <20240126133217.996306-1-clg@kaod.org>
In-Reply-To: <20240126133217.996306-1-clg@kaod.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 26 Jan 2024 15:56:03 +0000
Message-ID: <CAFEAcA8Q66Qw7spMOcBju0v-=C=x10hz1rwPWxjCzYWhdkX8Ww@mail.gmail.com>
Subject: Re: [PULL 00/17] aspeed queue
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x532.google.com
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

On Fri, 26 Jan 2024 at 13:33, C=C3=A9dric Le Goater <clg@kaod.org> wrote:
>
> The following changes since commit e029fe22caad9b75c7ab69bd4e84853c11fb71=
e0:
>
>   Merge tag 'pull-qapi-2024-01-26' of https://repo.or.cz/qemu/armbru into=
 staging (2024-01-26 10:21:27 +0000)
>
> are available in the Git repository at:
>
>   https://github.com/legoater/qemu/ tags/pull-aspeed-20240126
>
> for you to fetch changes up to b40769f4b49d15485ffaaa7acade3e3593ee6daa:
>
>   hw/fsi: Update MAINTAINER list (2024-01-26 14:22:08 +0100)
>
> ----------------------------------------------------------------
> aspeed queue:
>
> * Update of buildroot images to 2023.11 (6.6.3 kernel)
> * Check of the valid CPU type supported by aspeed machines
> * Simplified models for the IBM's FSI bus and the Aspeed
>   controller bridge
>
> ----------------------------------------------------------------

Looks like you have an endianness bug, either in the device
or in the test. From the s390 runner:

https://gitlab.com/qemu-project/qemu/-/jobs/6029422595

232/847 qemu:qtest+qtest-arm / qtest-arm/aspeed-fsi-test ERROR 0.38s
killed by signal 6 SIGABRT
>>> PYTHON=3D/home/gitlab-runner/builds/-LCfcJ2T/0/qemu-project/qemu/build/=
pyvenv/bin/python3 QTEST_QEMU_STORAGE_DAEMON_BINARY=3D./storage-daemon/qemu=
-storage-daemon QTEST_QEMU_BINARY=3D./qemu-system-arm G_TEST_DBUS_DAEMON=3D=
/home/gitlab-runner/builds/-LCfcJ2T/0/qemu-project/qemu/tests/dbus-vmstate-=
daemon.sh MALLOC_PERTURB_=3D82 QTEST_QEMU_IMG=3D./qemu-img /home/gitlab-run=
ner/builds/-LCfcJ2T/0/qemu-project/qemu/build/tests/qtest/aspeed-fsi-test -=
-tap -k
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95 =E2=9C=80 =E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95
stderr:
**
ERROR:../tests/qtest/aspeed-fsi-test.c:152:test_fsi0_getcfam_addr0:
assertion failed (curval =3D=3D 0x152d02c0): (3221368085 =3D=3D 355271360)
(test program exited with status code -6)

where 3221368085 is 0xC0022D15, and 355271360 is 0x152D02C0...

thanks
-- PMM

