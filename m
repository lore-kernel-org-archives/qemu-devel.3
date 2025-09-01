Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45637CA0FF0
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Sep 2025 12:48:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ut3wc-0007xz-9i; Mon, 01 Sep 2025 08:47:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ut3wT-0007uW-Bn
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 08:47:27 -0400
Received: from mail-yw1-x1136.google.com ([2607:f8b0:4864:20::1136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ut3wL-0003Q5-Da
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 08:47:24 -0400
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-72019872530so38641677b3.1
 for <qemu-devel@nongnu.org>; Mon, 01 Sep 2025 05:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756730834; x=1757335634; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=secuoH1pp1SZwDzdp1awuyVn94TUSWevG5j6uqY1ls0=;
 b=UJZjCnP30rcL/tNS74mYpj8t8/nEG/YzUIqDyKBD29KtWjv+trQ25qU92ue85EJrvn
 Zk/r/lMpyTFMj2JncmvBfRUwKu6sfD8lpuFenI0LI6VOm4MKfd+0EzKFOW067EzC9qSr
 RjUyx/NgAdxx/0dRR6eiD0h6QMoInQbTyj+19iWuHItdYM9bw9K/6WYxFgJdF40mAcMG
 +GHQojIHOElOEarck4fKK85V/5b2ebaumAmXR+rJeKcVXWpa+Edwbx7B3nta35HiNaXP
 q/o0GCHpDjfv9UWr/I5wlOTHgu/FJ89fOZ43JLG5eO28JjES4Xubl/6A88rLIYZvdKJc
 cdew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756730834; x=1757335634;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=secuoH1pp1SZwDzdp1awuyVn94TUSWevG5j6uqY1ls0=;
 b=aU/FedUWq1KqEQxBCX5I8sMR+0Exw5c8+udvyLc3hDrvUH0F80QFY+ekEB1Fv2FWEA
 eni9n8ZhrHp8xdxfaEc0jeFuAKtBaByZ6tiGt6kwAQCP67+B0lxHXXqlkdAJOQ9hXI+b
 Dc1qLN687lToZMlwyFkByJ8qD/qvDWONeiRY2/8lQGgTFcQeT4DSwmJ8yHvuTKwHfyPe
 VK2Ig7VMdvztavOjfL5RMlkV79eCBbLob034aae1Me+eoo3zZQUoISA5jqLEAle4LrpD
 VAwesa945xZDnduTr0sfwAKDjw11GxTZViffzsu6OQQCaNQgtMh5OdCNNxJ1/nHIk9LZ
 66KQ==
X-Gm-Message-State: AOJu0Yz7Qxb7Ubi1QPzc84Nk85FymOwzDHuBlrPWn84bQ5vZxCJMzjS7
 16m9XIlUAVkKr/vsebZ1eG98Qkrshd4IHonnuwsR1rOLpQhpylVJX3+kskupV0CtrFAcYz5+Bdv
 EBHxWp6dGXjc/kEHdzUJRzFs6CROcTtDC3SycEEJP7w==
X-Gm-Gg: ASbGncsQr302+11X8DtUYUCxpH16DX29LeRIWIyx398cpVz8jSLBdnLAqU3DpFU4+D3
 dT8//2NY+kdbxi0vShBW677NuYwSLg4JCqQCxn8LsMJ2WZZG5ss8/WsF//kozRwCFBa4GlF12/j
 sKZqxc2BEc3kkjP1coB9BkTNjmOGnkQEpIuqC65wLH17xRD7sfAb6kXcW/BBBz1ah/4ubC3AMty
 DqVkGVW
X-Google-Smtp-Source: AGHT+IFqxTeBzs2i901/7Nl4EW87AA6qyQ5dGk58l7ACLIlMSekaoHURHM27j8UrhAvMFxAjI9dilfAih8NvaANOUtw=
X-Received: by 2002:a05:690c:6006:b0:71f:b944:1017 with SMTP id
 00721157ae682-722765844e4mr81590597b3.50.1756730833747; Mon, 01 Sep 2025
 05:47:13 -0700 (PDT)
MIME-Version: 1.0
References: <20250901-mr-v1-0-dd7cb6b1480b@rsg.ci.i.u-tokyo.ac.jp>
 <CAFEAcA89xRp51q2T4M3R=pOuHcGE9zJCGDpbXOz4cBhxrcU00Q@mail.gmail.com>
In-Reply-To: <CAFEAcA89xRp51q2T4M3R=pOuHcGE9zJCGDpbXOz4cBhxrcU00Q@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 1 Sep 2025 13:47:01 +0100
X-Gm-Features: Ac12FXzRGthQENhxqD9hzdi3UavyBKsYwurH8bR2m8rIR0u6qdHlq6Nupx-Bwsk
Message-ID: <CAFEAcA8FhKBXJcOYaCTcsewzt+gBhy4Sqkznf1=vf+g-69901g@mail.gmail.com>
Subject: Re: [PATCH 00/16] memory: Stop piggybacking on memory region owners
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>, 
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, Peter Xu <peterx@redhat.com>, 
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>, Helge Deller <deller@gmx.de>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 John Snow <jsnow@redhat.com>, 
 qemu-block@nongnu.org, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>, Jesper Devantier <foss@defmacro.it>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Nicholas Piggin <npiggin@gmail.com>, Harsh Prateek Bora <harshpb@linux.ibm.com>,
 qemu-ppc@nongnu.org, John Levon <john.levon@nutanix.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>, 
 Yanan Wang <wangyanan55@huawei.com>, BALATON Zoltan <balaton@eik.bme.hu>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, 
 David Gibson <david@gibson.dropbear.id.au>,
 Alexey Kardashevskiy <aik@ozlabs.ru>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Fabiano Rosas <farosas@suse.de>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1136;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1136.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Mon, 1 Sept 2025 at 13:35, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Mon, 1 Sept 2025 at 07:11, Akihiko Odaki
> <odaki@rsg.ci.i.u-tokyo.ac.jp> wrote:
> >
> > Supersedes: https://lore.kernel.org/qemu-devel/20250828-san-v9-0-c0dff4b8a487@rsg.ci.i.u-tokyo.ac.jp/
> > ("[PATCH v9 0/2] Fix check-qtest-ppc64 sanitizer errors")
> >
> > MemoryRegions used to "piggyback" on their owners instead of using their
> > reference counters due to the circular dependencies between them, which
> > caused memory leak.
> >
> > I tried to fix it with "[PATCH v9 0/2] Fix check-qtest-ppc64 sanitizer
> > errors" but it resulted in a lengthy discussion; ultimately it is
> > attributed to the fact that "piggybacking" is hard to understand and
> > forces us design trade-offs. It was also insufficient because it only
> > deals with the container-subregion pattern and did not deal with DMA.
>
> Unlike Peter Xu's proposed patch and your v9 patch you reference
> above, with this series I still see leaks doing a 'make check'
> on an ASAN build of the Arm targets. Here's a sample leak
> detected during the device-introspect-test:

I should mention that I'm using an lsan-suppressions.txt file
with the following entries:

# This is a set of suppressions for LeakSanitizer; you can use it
# by setting
#   LSAN_OPTIONS="suppressions=/path/to/scripts/lsan-suppressions.txt"
# register_init_block API is busted
leak:register_init_block
leak:canfd_populate_regarray
# qtest-only leak, not very important
leak:qemu_irq_intercept_in
# this is maybe a leak caused by g_test_trap_subprocess():
# in the subprocess, the cleanup functions that are supposed to free
# memory don't get run for some reason.
leak:qos_traverse_graph

plus various leak fixes which I've sent out over the past week or two:

[PATCH 0/3] hw: Fix qemu_init_irq() leaks
 https://patchew.org/QEMU/20250821154053.2417090-1-peter.maydell@linaro.org/

[PATCH] hw/char/max78000_uart: Destroy FIFO on deinit
https://patchew.org/QEMU/20250821154358.2417744-1-peter.maydell@linaro.org/

[PATCH] hw/gpio/pca9554: Avoid leak in pca9554_set_pin()
https://patchew.org/QEMU/20250821154459.2417976-1-peter.maydell@linaro.org/

[PATCH 0/2] hw: fix some leaks in xlnx devices
https://patchew.org/QEMU/20250826174956.3010274-1-peter.maydell@linaro.org/

[PATCH] hw/arm/boot: Correctly free the MemoryDeviceInfoList
https://patchew.org/QEMU/20250901102214.3748011-1-peter.maydell@linaro.org/

and with those patches plus the lsan-suppressions file plus either
Peter Xu's patch or your v9 patch I get a clean 'make check' run.

thanks
-- PMM

