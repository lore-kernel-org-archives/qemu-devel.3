Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D66BC4828F
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Feb 2024 21:16:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rYBkE-0001sD-CX; Thu, 08 Feb 2024 16:15:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1rYBkB-0001rP-LB; Thu, 08 Feb 2024 16:15:39 -0500
Received: from mail-lj1-x22a.google.com ([2a00:1450:4864:20::22a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1rYBk8-0005SU-Rx; Thu, 08 Feb 2024 16:15:39 -0500
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-2d0a4e8444dso3138381fa.2; 
 Thu, 08 Feb 2024 13:15:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707426931; x=1708031731; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0sTMKwAk9xU61UIhqd3j4DWJQwI+YQ3up8gs0TB6J0g=;
 b=IpADpmoHNMvIB8iVwpmK/BJh+aCVQWgRcHvWFrNguEU3kQMMFJVTfAW7UPg75s3vNP
 BBRzYTSbaJNhxBcXdOnxOb7B4VIrlWsYdhJs616jsTM6AQPWDmtI2iWOKkZbhhmU+8+q
 +pIFTRYN3lemw9fpsRhKsb1r0V5qjXPIUFEZ1zAoGTGrppmpMND8EidIeAJXqJ7nD0sz
 M9XCh+4f/qo3M5gXmSh+bA0c7psIAyUoHBwR8n68KGc8YNFz9x0OqvXW9is1DAT/4DkJ
 WMPv4Y4YSpTUlaZb661EL/Gq8QMNt2V5n/dnJ/TBj4D2Wya8Jen8PGlacJaTsJGPTYhV
 zAAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707426931; x=1708031731;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0sTMKwAk9xU61UIhqd3j4DWJQwI+YQ3up8gs0TB6J0g=;
 b=FKVfKWKTg1oqBk9SVWfMJEFCsMYejOsx1PAQD6qeoX8lMmxW4fcrAYzxCl5e3wSe2L
 ajRUGJyNUoCjFyGzdh2foMTm8qSHQkm7bqejr2uzqq1oM/34HLljxxTst/VhKjmowGCz
 hJZN9FYECS08e3A44jIkIfCP8UHUxN6LgxrCU95b/nad9V2+t6mszFy3cW9msbpS0JOy
 bm93bOozdKcjDKARNOcTbnI7/QqFM8hlZ66dP+3He0B4q7pQSwTtr9xtaiJF1FzISBY/
 RWrQ3Cxb+TNxHX4s8W+FUhk4a9hrBWpUbXMIcF2sNUY8JdLcAxLUN1NAGSeos9VzqEdP
 eREA==
X-Gm-Message-State: AOJu0Yx4xIUwk6HKylrARXHyC0uTNNpLgzFyW+KXzc4xK1gBjQ7olG/1
 3rYqiptwG9Ez3wQqb5LqDljWs//DnMnzXt38Y8Io9bvqUk0iQ2n/1m48+tiU/1LOip/wjUJ5mFe
 Gsv8et2pccD0EDysjLWgQ1y4t+zg=
X-Google-Smtp-Source: AGHT+IGPxMRbf9SnH5ew2XnOUSN/q2gVTtGewhK1ha+CuDp4/EuGiM8HE0DOWepP9/XjogqLb1LIz8GvD7+bZOkDA4M=
X-Received: by 2002:a2e:a0c5:0:b0:2d0:9b25:3417 with SMTP id
 f5-20020a2ea0c5000000b002d09b253417mr259956ljm.52.1707426930309; Thu, 08 Feb
 2024 13:15:30 -0800 (PST)
MIME-Version: 1.0
References: <20240202144755.671354-1-hreitz@redhat.com>
 <20240206165330.GB66397@fedora>
 <5c7c5239-f665-4845-8448-14226e1337cc@redhat.com>
In-Reply-To: <5c7c5239-f665-4845-8448-14226e1337cc@redhat.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Thu, 8 Feb 2024 16:15:14 -0500
Message-ID: <CAJSP0QUqvg88BGZF83EXFXTQwvwmUPGTJkPqTL-O1VVh-6FGZQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] block: Allow concurrent BB context changes
To: Hanna Czenczek <hreitz@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, 
 qemu-stable@nongnu.org, Kevin Wolf <kwolf@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::22a;
 envelope-from=stefanha@gmail.com; helo=mail-lj1-x22a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Wed, 7 Feb 2024 at 04:36, Hanna Czenczek <hreitz@redhat.com> wrote:
>
> On 06.02.24 17:53, Stefan Hajnoczi wrote:
>
> On Fri, Feb 02, 2024 at 03:47:53PM +0100, Hanna Czenczek wrote:
>
> Hi,
>
> Without the AioContext lock, a BB's context may kind of change at any
> time (unless it has a root node, and I/O requests are pending).  That
> also means that its own context (BlockBackend.ctx) and that of its root
> node can differ sometimes (while the context is being changed).
>
> blk_get_aio_context() doesn't know this yet and asserts that both are
> always equal (if there is a root node).  Because it's no longer true,
> and because callers don't seem to really care about the root node's
> context, we can and should remove the assertion and just return the BB's
> context.
>
> Beyond that, the question is whether the callers of
> blk_get_aio_context() are OK with the context potentially changing
> concurrently.  Honestly, it isn't entirely clear to me; most look OK,
> except for the virtio-scsi code, which operates under the general
> assumption that the BB's context is always equal to that of the
> virtio-scsi device.  I doubt that this assumption always holds (it is
> definitely not obvious to me that it would), but then again, this series
> will not make matters worse in that regard, and that is what counts for
> me now.
>
> One clear point of contention is scsi_device_for_each_req_async(), which
> is addressed by patch 2.  Right now, it schedules a BH in the BB
> context, then the BH double-checks whether the context still fits, and
> if not, re-schedules itself.  Because virtio-scsi's context is fixed,
> this seems to indicate to me that it wants to be able to deal with a
> case where BB and virtio-scsi context differ, which seems to break that
> aforementioned general virtio-scsi assumption.
>
> I don't agree with the last sentence: virtio-scsi's context isn't fixed.
>
> The AioContext changes when dataplane is started/stopped. virtio-scsi
> switches AioContext between the IOThread's AioContext and the main
> loop's qemu_aio_context.
>
> However, virtio-scsi virtqueue processing only happens in the IOThread's
> AioContext. Maybe this is what you meant when you said the AioContext is
> fixed?
>
>
> Specifically, I meant VirtIOSCSI.ctx, which is set only once in virtio_sc=
si_dataplane_setup().  That=E2=80=99s at least where the virtqueue notifier=
s are registered, so yes, virtqueue processing should at least be fixed to =
that context.  It seems like it=E2=80=99s always possible some things are p=
rocessed in the main thread (not just setup/teardown, but also e.g. TMF_LOG=
ICAL_UNIT_RESET), so to me it seems like virtio-scsi kind of runs in two co=
ntexts simultaneously.  Yes, when virtqueue processing is paused, all proce=
ssing VirtIOSCSI.ctx is stopped, but I wouldn=E2=80=99t say it switches con=
texts there.  It just stops processing some requests.
>
> Either way, virtio-scsi request processing doesn=E2=80=99t stop just beca=
use a scsi-hd device is hot-plugged or -unplugged.  If the BB changes conte=
xts in the hot-unplug path (while vq request processing is continuing in th=
e I/O thread), its context will differ from that of virtio-scsi.
>
> So should I just replace the =E2=80=9Cthe context is fixed=E2=80=9D and s=
ay that in this specific instance, virtio-scsi vq processing continues in t=
he I/O thread?
>
> The BH function is aware that the current AioContext might not be the
> same as the AioContext at the time the BH was scheduled. That doesn't
> break assumptions in the code.
>
> (It may be possible to rewrite virtio-blk, virtio-scsi, and core
> VirtIODevice ioeventfd code to use the simpler model where the
> AioContext really is fixed because things have changed significantly
> over the years, but I looked a few weeks ago and it's difficult work.)
>
> I'm just pointing out that I think this description is incomplete. I
> *do* agree with what this patch series is doing :).
>
>
> Well, this description won=E2=80=99t land in any commit log, so from my s=
ide, I=E2=80=99m not too worried about its correctness. O:)

Okay, I think we're in agreement. What you described in your reply
matches how I understand the code. No need to resend anything.

Stefan

