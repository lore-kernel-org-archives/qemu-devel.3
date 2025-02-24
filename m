Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2FCAC021B3
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2025 04:07:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmPkQ-0005JL-0Q; Sun, 23 Feb 2025 23:07:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tmPkM-0005Iz-7q
 for qemu-devel@nongnu.org; Sun, 23 Feb 2025 23:07:10 -0500
Received: from mail-vs1-xe34.google.com ([2607:f8b0:4864:20::e34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tmPkK-0008LU-LI
 for qemu-devel@nongnu.org; Sun, 23 Feb 2025 23:07:09 -0500
Received: by mail-vs1-xe34.google.com with SMTP id
 ada2fe7eead31-4be55c93be1so793780137.0
 for <qemu-devel@nongnu.org>; Sun, 23 Feb 2025 20:07:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740370027; x=1740974827; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9nZVENxUSm4i5rjCa09MLdiVG5ZNPpYXlxpeT7y3A4U=;
 b=ci6XGyf1MJxANIULpIWf1wygJIlRX2de5nDSN3/hP74spdfinn7dhhhYPCKQJNXlhr
 rwL5oOxxdQdDwNJi6S3X94XYro4Awrh4T24HH3LScIDA4dK7o7FSrqhmQnATln0rfVec
 exchXzX1YFpX6y8rXUkGT/Vtk6SKIi6LN+ECB19AmQIMr/rxmbR/VlRHMzY8vxlXUN0G
 9e2r9vWpfyydlmoQCMUdNtQCozrMBIzwO1v86FYiPvqETVZtyBlMfGQO9OAuQxeN4bin
 1cOadZEdC6PAge77B4MZYIy3tUPXn6iM1AgqfDK+YTQCy2MZarbJ5geiLrbMmOD5aBjZ
 dh8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740370027; x=1740974827;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9nZVENxUSm4i5rjCa09MLdiVG5ZNPpYXlxpeT7y3A4U=;
 b=gKN1F84k13WFRNnow1a4+hcWv6RdJUSPYlmtSXHD+eyFfopS2Hs64ewy0e1+rTJgX0
 W7HQQY/y+aamWUKXj1qQ2S8Bu5LwL9fsHnwQ0fYhQZQmti/L1SsQNNN5O/eUyHY4TrhC
 spGwcnpSuC/MZS0bnoht60oCy7i+wvUZ1dMVe/qwrs6TbgekjJjOAC7vUTjTCr/9JnEN
 T6++oLEeAkG9VZhhLviZB0EzvL//CGU8KZYRGZh8IIWz22ZqVrzfmd7RYSbqNBhmH11w
 vEH0m3YybzIRX9VIKQPzSxa5QCaaok9UvjqXZ5EC1uWhuFpsLNaX4AvCKDPZqSt/prHS
 BrMw==
X-Gm-Message-State: AOJu0YxfQIx6VlEIdurT15tIqRSipVod7P+c2yhH3lblVMCZ4uCulE08
 978tpiaymf06fpKSFeZZ0YQZVX1ZhuWMPplfWtzrqaw1Ivcm2ZRqAL3zf/20vvXn2meIfAmbx+m
 C6kGJmQThmC6/1kL6nrdhRXXYuCs=
X-Gm-Gg: ASbGnctvdYRfetmwBMxk7sVwtD8KOnlC0nJq2j9+pMb/R4EiIr2YwiVMaQMcZzhPa1U
 XuYYCaRahlOHxnlxNhWeWhR3IwHSDSyw/G703ACg6ixKB0S+5ArCTthxKoVGggNP4QhmxBPULfh
 aLSEWkkz3sNMKfOod+sQnIFWx8EIyJYzZwfVl5
X-Google-Smtp-Source: AGHT+IFkbEl1dxEgcVCBV/vTt6uEN3nGXKz8ONmp/te1z6cuafnOOtePxyHzFDtvE9SLW3gFsn3/AOE6mmEDdiAS2dM=
X-Received: by 2002:a05:6102:3e04:b0:4bb:baa0:371d with SMTP id
 ada2fe7eead31-4bfc022c858mr7147042137.24.1740370027258; Sun, 23 Feb 2025
 20:07:07 -0800 (PST)
MIME-Version: 1.0
References: <tencent_308D5C2C7DFE0CDC38AD1906113460287F05@qq.com>
In-Reply-To: <tencent_308D5C2C7DFE0CDC38AD1906113460287F05@qq.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 24 Feb 2025 14:06:40 +1000
X-Gm-Features: AWEUYZmILDWuvDYQyxsmvx8cb3umx0SbROZNXtIXfddc86COYflyKNRkIWYj69Q
Message-ID: <CAKmqyKPoXWewA7f+b_QOCvaSdpkR+gCchikkytMUcTTuwnVR3A@mail.gmail.com>
Subject: Re: Perf in QEMU
To: =?UTF-8?B?6JOd6Imy55qE5qKm5oOz?= <1058183524@qq.com>
Cc: qemu-devel <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e34;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe34.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Tue, Feb 18, 2025 at 11:56=E2=80=AFPM =E8=93=9D=E8=89=B2=E7=9A=84=E6=A2=
=A6=E6=83=B3 <1058183524@qq.com> wrote:
>
> Hello!
>
>     I am a graduate student currently studying in school. Recently, I use=
d QEMU 9.0.2 to create virtual machines with ARM, x86, and RISC-V architect=
ures for experiments. During the process, I found that the =E2=80=98perf st=
at=E2=80=99 command does not support the collection of certain metrics, suc=
h as: instructions, cache-misses, cache-references, etc. I am unsure whethe=
r this issue is due to my operations or if QEMU itself does not support the=
se metrics.

There are a range of different pieces that need to be in place to
support perf. From architecture support to kernel support. You will
need to investigate each architecture to see what is supported in QEMU
and the guest software that you are running. I would expect
instruction counts to work on the major architectures though. But that
will be up to you to dig into to see what is supported.

QEMU itself doesn't model caches and the instruction count (if
supported for the architecture in QEMU) is not going to be exact. You
can use a TCG plugin to model a cache [1] though if that's something
you need.

1: https://www.qemu.org/2021/08/19/tcg-cache-modelling-plugin/

Alistair

>
>     Therefore, I would like to ask you whether QEMU virtual machines supp=
ort the collection of the above metrics.
>
>     I apologize for bothering you, and I hope you will be able to reply a=
t your convenience. Thank you very much!
>

