Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1266BC2BD09
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2024 15:13:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOIiy-0005tl-NJ; Mon, 01 Jul 2024 11:13:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sOIiw-0005qk-RI
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 11:13:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sOIir-0006IE-Bv
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 11:13:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719846820;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0Ml9sb2LmoyAeXP7Y8puxVlPbqI3slpBz9D/NbacrJU=;
 b=g1oGCq5xPmhjyP1tLlLGu3N2ljsICXuajOv+6NUpOKadLG1fqWHi/z3bN7FF3b4YR5MHrh
 D70b6MEC0nKHWUA3YaDHbwMyeINcLT4w8eGfNhHviumdquok0X69+qJw9co+cIqQThLujo
 rWcvVZDB2ca9IbauTR+IEBxMKf2K1/E=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-410-dd_KEg1eNpmtJUv7j5gCYg-1; Mon, 01 Jul 2024 11:13:38 -0400
X-MC-Unique: dd_KEg1eNpmtJUv7j5gCYg-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-362a0c1041dso1738979f8f.1
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2024 08:13:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719846817; x=1720451617;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0Ml9sb2LmoyAeXP7Y8puxVlPbqI3slpBz9D/NbacrJU=;
 b=EuSK603Ik7r2i0StjX19n7jEFkf8+ix33Ztvrz5hkr+G7LEPaEvmWnUWDpx//1VeN6
 OPbkz37fUC+UXJ7ulGAXLN/dYAYCzcl1XSLhFc3Osj1BK0XTa9U2C76xFgC7XvpCJDO4
 02tkk+1mlFYUIv0Xfi9snZ5MH14F7iomF4JM2r6/ypmM56rs3YAmOp1FNMKRto8YJPKd
 3a4zf7ausIKAIw/MiLdOOFPBtOw+CzhGwfikhZAdphYW+eQcvApzpnxEwvB5UJPIh0Q8
 gUiZE9urwr6pHMQZsKK5mZwlGuBzMff0NbnKr0JT5tUujIEIP0pt/A12qj45mXz1S62v
 9pzQ==
X-Gm-Message-State: AOJu0Yy3vfNu6ORQ+iPj6GMi/zqRmrvWBHLyNtiC5IyqLQhIpXv8wTRM
 RQKyN2wyBcK8dlFGhEuZnuFAJNDPwzw+5/rU4kOAImNxPXWzkGBhXgr+UAwhz71HZvaH+U/Qcyw
 z55lzGQR5ILYRPRvF5BOjm3c4ltDNq26p9xXAWuWx1oMCyjI5XknbTXhsWuXaeImmu2kVj4h8c9
 JhrxD0tw76rmlrHlrQz/kFDIDdjhk=
X-Received: by 2002:a05:6000:d51:b0:360:9e68:d9e1 with SMTP id
 ffacd0b85a97d-367756bd5d6mr4207664f8f.40.1719846817186; 
 Mon, 01 Jul 2024 08:13:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFrG+MbumMfiAF55GHqo4Gi18PfoZQP11gYk3gr7u+gYzhl+4k6+hCr+7r20cEViHlL2yQoS3zZ+A4dKb/uQkk=
X-Received: by 2002:a05:6000:d51:b0:360:9e68:d9e1 with SMTP id
 ffacd0b85a97d-367756bd5d6mr4207647f8f.40.1719846816790; Mon, 01 Jul 2024
 08:13:36 -0700 (PDT)
MIME-Version: 1.0
References: <20240701114230.193307-1-w.bumiller@proxmox.com>
In-Reply-To: <20240701114230.193307-1-w.bumiller@proxmox.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 1 Jul 2024 17:13:24 +0200
Message-ID: <CABgObfaOeo1KmfWvJ0x1o9vdeLkL-rAZ026763XnXyCMOKx65A@mail.gmail.com>
Subject: Re: [PATCH 0/2] change some odd-looking atomic uses
To: Wolfgang Bumiller <w.bumiller@proxmox.com>
Cc: qemu-devel@nongnu.org, Stefan Weil <sw@weilnetz.de>,
 Kevin Wolf <kwolf@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Fam Zheng <fam@euphon.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Jul 1, 2024 at 1:52=E2=80=AFPM Wolfgang Bumiller <w.bumiller@proxmo=
x.com> wrote:
>
> I spotted the weird-looking pattern of:
>     atomic_set(atomic_load() <some operation> N)
> in a few palces and one variable in the graph-lock code which was used wi=
th
> atomics except for a single case, which also seemed suspicious.
>
> I'm not sure if there are any known compiler-optimizations or ordering
> semantics already ensuring that these operations are indeed working corre=
ctly
> atomically, so I thought I'd point them out and ask about it by sending
> patches.

Hi Wolfgang,

indeed the usage is intended - but thanks a lot for the patches, it's
certainly a good way to proceed!

Here's a quick explanation:

- bdrv_graph_co_rdlock()/bdrv_graph_co_rdunlock(): only one coroutine
can run in each AioContext at a time, so the writes to
bdrv_graph->reader_count are effectively thread-local. It's just reads
that need to be synchronized.

- aio_poll(): similar, as the writer is the thread for the AioContext,
while the readers are the other threads that call aio_notify() for
that AioContext.

- aio_ctx_prepare(): same idea as aio_poll(), in this case the writer
is the thread running the GLib event loop (almost always the main
thread, except with the Cocoa UI because macOS wants the main thread
for itself).


So why is this written in full instead of using fetch-add-store? From
most to least important:

- to make you think about who reads and who writes, i.e. to show that
no atomicity is needed

- because it's faster

The disadvantage of course is the verbosity.

Thanks,

Paolo

> In patch 2 the ordering is changed (see the note in its mail)
>
> Wolfgang Bumiller (2):
>   graph-lock: make sure reader_count access is atomic
>   atomics: replace fetch-use-store with direct atomic operations
>
>  block/graph-lock.c | 8 +++-----
>  util/aio-posix.c   | 3 +--
>  util/aio-win32.c   | 3 +--
>  util/async.c       | 2 +-
>  4 files changed, 6 insertions(+), 10 deletions(-)
>
> --
> 2.39.2
>
>Hi


