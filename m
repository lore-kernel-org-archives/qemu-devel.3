Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17CBCC48BF6
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Mar 2024 15:26:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riFd4-0004XJ-K9; Thu, 07 Mar 2024 10:25:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1riFd2-0004W7-69
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 10:25:53 -0500
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1riFd0-0004gm-Bz
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 10:25:51 -0500
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-563d32ee33aso1191367a12.2
 for <qemu-devel@nongnu.org>; Thu, 07 Mar 2024 07:25:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709825149; x=1710429949; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PJxOAclKQrKBeMTfTkTD9ycvhPdDNXpKQnEPAhbjNMo=;
 b=I854rYtbhU+jpywQYB0t9khIw9iP5iPoETu1Q27GSHX7+BvXppSnlfRnO47gMJ03m+
 sRhx4XzmIyC/HuT0H2f/IoYTtUdR2xNzthux/lj1dz1F4MRlvcRVRbSqMCPyAKbR5pe1
 htdntgVPcJxV+wJc6ZhLdX2sMZ87PuyWFzPDC1VdT2af/qsu1cdhJt3LsOe+strVhy7n
 dzvAGWKDzn1cLyjOQlgikdfeBsTqCF1N6XHcuOQaovD7Ki1bZIH7xPbrVA6WK/jWVrXD
 bVspmpElOxmGwkS1I+bacE26dk8AvqzQEv09wBL4iX9UaytODfCnZKXyBuf7SUWE3cPR
 Aavg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709825149; x=1710429949;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PJxOAclKQrKBeMTfTkTD9ycvhPdDNXpKQnEPAhbjNMo=;
 b=pj+8LB7vnohPcVL64Z/l5iCPGym9E7+G49jtbInNSTYcWTWqRsacx3/n25uPozJS09
 uREoIAoP3E5LTR9mJlVo+xZmBdAo3xbYoVAdqD+cuUBB1XshpuqGvM3SXSuFLk/QxRk8
 k/Ng312AHqMb/LO1zZ2fIireeY0P1TXy9bfsNwHzF6ZjPTJBVzHTF8QMKhTBPZzvmmE1
 aNYZlwonxI3cuWSgZGT1Pf3YRO0pGXGPOzxI0LPFaRVB82TSykDvhR0e+sIs2YtUharX
 9/0N59ZngGMIO46R55eJp4Gpd1HNHaDGesUckcAxaNg89id9SJAYVau8u7bnpSpaBxAe
 vFQA==
X-Gm-Message-State: AOJu0YzPl3/lKt17qfNKa/fx2gTLwpKHxGq5uuSrTmxrpCkpJ9bLm9Zl
 A53i18A9gbBRwdd9MyB2j0s1IdUdFOHMUDLpOfVCMukH1OtouBnh6GkN7O7ZVFyPb2mkifk+WbV
 QZhusJVkzVLKRahrrblt+8zpx23Lafv6apTomlA==
X-Google-Smtp-Source: AGHT+IFftyMGj7m32Q6Tnjs5lr+yKr2Bhj8eszkHY2A1d+x0XrfqLfYYi4G3SjpgbyHAWm10oEH5sW7GSvfIoZzhZEs=
X-Received: by 2002:a50:8712:0:b0:565:6dde:ed2e with SMTP id
 i18-20020a508712000000b005656ddeed2emr71862edb.33.1709825148940; Thu, 07 Mar
 2024 07:25:48 -0800 (PST)
MIME-Version: 1.0
References: <20240307145207.247913-1-gaosong@loongson.cn>
 <CAFEAcA9g7yTRYLp3xE6p-Zh_RYpxn4MacbzRRi5UNFzKgP9QFw@mail.gmail.com>
In-Reply-To: <CAFEAcA9g7yTRYLp3xE6p-Zh_RYpxn4MacbzRRi5UNFzKgP9QFw@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 7 Mar 2024 15:25:38 +0000
Message-ID: <CAFEAcA9+P_i-GgLqKgcjg7DKBB9P4oBeZq5o-59V=17pAAQqkw@mail.gmail.com>
Subject: Re: [PULL 00/17] loongarch-to-apply queue
To: Song Gao <gaosong@loongson.cn>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52d.google.com
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

On Thu, 7 Mar 2024 at 15:23, Peter Maydell <peter.maydell@linaro.org> wrote=
:
>
> On Thu, 7 Mar 2024 at 14:52, Song Gao <gaosong@loongson.cn> wrote:
> >
> > The following changes since commit 8f6330a807f2642dc2a3cdf33347aa28a4c0=
0a87:
> >
> >   Merge tag 'pull-maintainer-updates-060324-1' of https://gitlab.com/st=
squad/qemu into staging (2024-03-06 16:56:20 +0000)
> >
> > are available in the Git repository at:
> >
> >   https://gitlab.com/gaosong/qemu.git tags/pull-loongarch-20240307
> >
> > for you to fetch changes up to 4dc2edfd6f8abfc38f0ba110502790aa5051b1b5=
:
> >
> >   hw/loongarch: Add cells missing from rtc node (2024-03-07 21:58:00 +0=
800)
> >
> > ----------------------------------------------------------------
> > pull-loongarch-20240307
> >
> > ----------------------------------------------------------------
> > Song Gao (17):
> >       hw/loongarch: Move boot fucntions to boot.c
> >       hw/loongarch: Add load initrd
> >       hw/loongarch: Add slave cpu boot_code
> >       hw/loongarch: Add init_cmdline
> >       hw/loongarch: Init efi_system_table
> >       hw/loongarch: Init efi_boot_memmap table
> >       hw/loongarch: Init efi_initrd table
> >       hw/loongarch: Init efi_fdt table
> >       hw/loongarch: Fix fdt memory node wrong 'reg'
> >       hw/loongarch: fdt adds cpu interrupt controller node
> >       hw/loongarch: fdt adds Extend I/O Interrupt Controller
> >       hw/loongarch: fdt adds pch_pic Controller
> >       hw/loongarch: fdt adds pch_msi Controller
> >       hw/loongarch: fdt adds pcie irq_map node
> >       hw/loongarch: fdt remove unused irqchip node
> >       hw/loongarch: Add cells missing from uart node
> >       hw/loongarch: Add cells missing from rtc node
>
> Hi; this failed to build on openbsd:

Also, please check that "make check" passes. I see this
failure:
https://gitlab.com/qemu-project/qemu/-/jobs/6343668904

>>> QTEST_QEMU_IMG=3D./qemu-img QTEST_QEMU_STORAGE_DAEMON_BINARY=3D./storag=
e-daemon/qemu-storage-daemon QTEST_QEMU_BINARY=3D./qemu-system-loongarch64 =
MALLOC_PERTURB_=3D138 PYTHON=3D/home/gitlab-runner/builds/E8PpwMky/0/qemu-p=
roject/qemu/build/pyvenv/bin/python3 G_TEST_DBUS_DAEMON=3D/home/gitlab-runn=
er/builds/E8PpwMky/0/qemu-project/qemu/tests/dbus-vmstate-daemon.sh /home/g=
itlab-runner/builds/E8PpwMky/0/qemu-project/qemu/build/tests/qtest/test-hmp=
 --tap -k
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
qemu-system-loongarch64: Need kernel filename
Broken pipe
../tests/qtest/libqtest.c:195: kill_qemu() tried to terminate QEMU
process but encountered exit status 1 (expected 0)
(test program exited with status code -6)
TAP parsing error: Too few tests run (expected 3, got 1)


Checks for filename arguments etc should generally be
guarded by "if (!qtest_enabled())" to avoid problems with
this category of test.

thanks
-- PMM

