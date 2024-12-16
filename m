Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94B10E7717F
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2024 19:20:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNGcu-0004S8-Hm; Mon, 16 Dec 2024 14:19:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1tNGcp-0004Rd-GP
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 14:19:28 -0500
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1tNGcm-0003iq-PN
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 14:19:27 -0500
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-aabbb507998so277702466b.2
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2024 11:19:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734376762; x=1734981562; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xDOso7LWbJPOlcxvusbQVKc/YAolT9YoGZNfAA8A16g=;
 b=EDO4SbhWJR1lGcQ6IW23i8pnmC8XZfVVkUBmTlEPnQJTNAGyOpS7iu+3MTU//FnNPt
 AG09+yUfnHPajIvOnDdHXr7pcGCipIw9IlBTAY2wpG4FTK22jyFjB0HzpPDy6p3YWwmw
 YKKdqjOeT/TabdRdhafnITKbYi46DXQ19LP5M0WiYN/ISfY+hpKEXRyz2Hodn71kJu5N
 2Y7ppvshVPEQMY5Gv9CfQ0bFIPKH8HXJUW2y4pymXTfArnu4NR9Munf7WWSH2ERQFYEG
 n3iz7X/U4dt0ZVThF7RuwybPACQSm5pEWzFK0KN6iitzbZoLiY9fC2jeSTjbwTuVNbfg
 L1+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734376762; x=1734981562;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xDOso7LWbJPOlcxvusbQVKc/YAolT9YoGZNfAA8A16g=;
 b=YSt5x+XPqHHfx2xpagOCN3kHT0bwbQdGvM1WMetTPOUQn1mLP+f18/u005J/N3lWvi
 xaqWhLjML1iuFgM+Uq5NnHiWa0itUd1iKTYOUVsLcpOtWGtjcOBUCH2Qee1vNUbqT1w2
 cANutPIFDQOywqLUYlAi+TQBoFSgy8QvvC3sqL4an3fqqrqaKLslOaqN7+RbpYBFyhvg
 Fy/hdkiYdw4axxFF7erKg6fs6VOhD8+Qhnh+tN/+zbjdV+S01cNBKzUQkyPCSRWZGZgw
 pr9BpaS4kHOnTEQREsfxpGmGvT4nNz4H50hPtZ0V+umssGJIHkJfnAFOvyljVhDBsDRb
 rP3w==
X-Gm-Message-State: AOJu0Yw+b2CWZWcMqqbEvogpWcTchoQX4oY1SJvllFIMU7n3zxC3RlnU
 rZXNnAtTepSXAceA8GBPhxw0s6pYfLMUdAkaSsHY8xKHSbtqKkGCMR1CWSistUZgaVSXMOILunu
 BFNbPSn5kT1GvOBpSlfTIor3Eg7TSRlpx
X-Gm-Gg: ASbGncu63zdXwlPbMziNgxwQT0zcMq2ASLK8jFs3dMsmFwcwviI3RM1uKdxLUv2eN/k
 dLy5t9Tuo31dDfXSJBJUa2qe/rbT9ac2OavV6
X-Google-Smtp-Source: AGHT+IE36JRjIjbfIyRaSkGNHt79bUo5qHt7W91MNzyGTZpILOMT0ggZwWHnztwhPE7VLtdRYqY8l5HdvVk/4nUVkgE=
X-Received: by 2002:a17:907:7f29:b0:aa6:7b34:c1a8 with SMTP id
 a640c23a62f3a-aab77eaf35cmr1403834866b.55.1734376762006; Mon, 16 Dec 2024
 11:19:22 -0800 (PST)
MIME-Version: 1.0
References: <20241216015607.1795880-1-maobibo@loongson.cn>
In-Reply-To: <20241216015607.1795880-1-maobibo@loongson.cn>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Mon, 16 Dec 2024 14:19:10 -0500
Message-ID: <CAJSP0QV84ssXWHQrrWQrpwZS7Ko90eRnR46WS+jvNn5_3Zss=Q@mail.gmail.com>
Subject: Re: [PULL 00/18] loongarch-to-apply queue
To: Bibo Mao <maobibo@loongson.cn>
Cc: qemu-devel@nongnu.org, Song Gao <gaosong@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=stefanha@gmail.com; helo=mail-ej1-x629.google.com
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

On Sun, 15 Dec 2024 at 20:56, Bibo Mao <maobibo@loongson.cn> wrote:
>
> The following changes since commit ca80a5d026a280762e0772615f1988db542b3a=
de:
>
>   Merge tag 'hw-misc-20241214' of https://github.com/philmd/qemu into sta=
ging (2024-12-14 08:42:53 -0500)
>
> are available in the Git repository at:
>
>   https://gitlab.com/bibo-mao/qemu.git tags/pull-loongarch-20241216
>
> for you to fetch changes up to efada537c6c49e414ae87ce66803d6d8543ad140:
>
>   hw/intc/loongarch_extioi: Code cleanup about loongarch_extioi (2024-12-=
16 09:05:14 +0800)
>
> ----------------------------------------------------------------
> pull-loongarch-20241216
>   v1 .. v2: Push patch again since forgot to push to upstream

Please take a look at following qtest failure from the
x64-freebsd-14-build CI job:

8/730 qemu:qtest+qtest-loongarch64 / qtest-loongarch64/qom-test ERROR
0.84s killed by signal 6 SIGABRT
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
Broken pipe
../tests/qtest/libqtest.c:205: kill_qemu() detected QEMU death from
signal 11 (Segmentation fault) (core dumped)
(test program exited with status code -6)
TAP parsing error: Too few tests run (expected 2, got 0)

https://gitlab.com/qemu-project/qemu/-/jobs/8656122662/viewer

You can reproduce the FreeBSD 14 environment using `make
vm-build-freebsd`. See `make vm-help` for more options.

Here is the merge tag where this happened. It probably also happens on
your pull request tag:
https://gitlab.com/qemu-project/qemu/-/commit/466535ecb37d28ef79aecc4550b7c=
d1160c6beac

If you find that there was an issue with the commits in your pull
request, please send a new pull request revision. If you find that the
issue was not caused by a commit in your pull request, please reply
here so we can discuss how to solve it.

Thanks,
Stefan

>
> ----------------------------------------------------------------
> Bibo Mao (18):
>       include: Add loongarch_pic_common header file
>       include: Move struct LoongArchPCHPIC to loongarch_pic_common header=
 file
>       hw/intc/loongarch_pch: Merge instance_init() into realize()
>       hw/intc/loongarch_pch: Rename LoongArchPCHPIC with LoongArchPICComm=
onState
>       hw/intc/loongarch_pch: Move some functions to file loongarch_pic_co=
mmon
>       hw/intc/loongarch_pch: Inherit from loongarch_pic_common
>       hw/intc/loongarch_pch: Add pre_save and post_load interfaces
>       hw/intc/loongarch_pch: Code cleanup about loongarch_pch_pic
>       include: Add loongarch_extioi_common header file
>       include: Move struct LoongArchExtIOI to header file loongarch_extio=
i_common
>       include: Rename LoongArchExtIOI with LoongArchExtIOICommonState
>       hw/intc/loongarch_extioi: Rename LoongArchExtIOI with LoongArchExtI=
OICommonState
>       hw/intc/loongarch_extioi: Add common realize interface
>       hw/intc/loongarch_extioi: Add unrealize interface
>       hw/intc/loongarch_extioi: Add common file loongarch_extioi_common
>       hw/intc/loongarch_extioi: Inherit from loongarch_extioi_common
>       hw/intc/loongarch_extioi: Add pre_save interface
>       hw/intc/loongarch_extioi: Code cleanup about loongarch_extioi
>
>  hw/intc/loongarch_extioi.c                | 110 +++++++++---------------=
-----
>  hw/intc/loongarch_extioi_common.c         | 113 ++++++++++++++++++++++++=
++++++
>  hw/intc/loongarch_pch_pic.c               | 106 +++++++++---------------=
----
>  hw/intc/loongarch_pic_common.c            |  97 ++++++++++++++++++++++++=
+
>  hw/intc/meson.build                       |   4 +-
>  hw/loongarch/virt.c                       |   2 +-
>  include/hw/intc/loongarch_extioi.h        |  84 +++-------------------
>  include/hw/intc/loongarch_extioi_common.h |  98 ++++++++++++++++++++++++=
++
>  include/hw/intc/loongarch_pch_pic.h       |  70 ++++--------------
>  include/hw/intc/loongarch_pic_common.h    |  82 ++++++++++++++++++++++
>  10 files changed, 488 insertions(+), 278 deletions(-)
>  create mode 100644 hw/intc/loongarch_extioi_common.c
>  create mode 100644 hw/intc/loongarch_pic_common.c
>  create mode 100644 include/hw/intc/loongarch_extioi_common.h
>  create mode 100644 include/hw/intc/loongarch_pic_common.h
>

