Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9216FC3DA7F
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2024 15:32:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1secRO-00060P-3P; Thu, 15 Aug 2024 11:31:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1secRF-0005za-4J
 for qemu-devel@nongnu.org; Thu, 15 Aug 2024 11:31:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1secRB-0006NB-52
 for qemu-devel@nongnu.org; Thu, 15 Aug 2024 11:30:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1723735851;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2h5IbGwSkZOKDR8626UCF206S0ixmbVJwcLHbnWbiZ4=;
 b=E8XDepLuPSn6xrqJTUa/40AOA8Ll8cdd4+lcOP7IBHSOR4UA+m/YJKBJWpu6O5I8Kk/9Ua
 jbHCOToi7BmO/MSjwZxeZW7w8fDTV4V+EZLXePuCU9NTL3+nqY2/wD4tszsN2xnljtijWz
 9WXdZxmFYiqCsD4W8zQDV3xcU8OVubM=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-639-p0op27OaNaWM43ex4EQZGg-1; Thu, 15 Aug 2024 11:30:48 -0400
X-MC-Unique: p0op27OaNaWM43ex4EQZGg-1
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-2ef3157ae4cso10100001fa.2
 for <qemu-devel@nongnu.org>; Thu, 15 Aug 2024 08:30:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723735847; x=1724340647;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2h5IbGwSkZOKDR8626UCF206S0ixmbVJwcLHbnWbiZ4=;
 b=Orn2kGTaUohg+Tu78snYWkFXOhAHWE4+dRnkkz6D4xwXi0dnQeGLR029sIx1UnpMYo
 OWuDY6xWYmREcsnlDSAJiWOBP86SfbgM2U3Uy3mP81MVo8xG1bm3Sg9mzSyqYYIbDhTG
 BGWai6RuOrx9GyXFnofRGlszg+8qhvM6LiMwkHuGE5F9XoJWvAzZ94VR3mBQflG8N6WQ
 T9mRc1sn7E+lCIF2d+yeqlf6YydrFbVsqadOaqg1XBH8jXXZFi7pBnandbX0p1jOh3YH
 SDaWMKofQ2st2LV89vOfHpFPZLzLs0wqH/yyxVJSIOifKCBNPfLxbWpHsdiIsfXkqFfp
 YkUw==
X-Gm-Message-State: AOJu0YxIRj544rrjIgvkhQRYUPQymJx3xq5IrrvgDxkHLJBFj1onwEFq
 PzGHhDQSI2GlUOKPkBDFAmUpUrNQJiANZ+/V4yR+JZrolVHlky2YC9oHz8aLYVwHT8mEoI/r/mm
 1L7sWmm1BpLIC4A7mhuIrsmr++TLFl8ozE39sToLiHb9K0iwQuU8u
X-Received: by 2002:a05:651c:198b:b0:2f1:922f:8751 with SMTP id
 38308e7fff4ca-2f3be3dde54mr1159951fa.0.1723735846673; 
 Thu, 15 Aug 2024 08:30:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH3lQ5VlSPFLZpdbYZJg61XHFgmwccmyq+tyzUf+db8z83VbQ0WT7zVP/EouBUiuQahn6dAYQ==
X-Received: by 2002:a05:651c:198b:b0:2f1:922f:8751 with SMTP id
 38308e7fff4ca-2f3be3dde54mr1159221fa.0.1723735845713; 
 Thu, 15 Aug 2024 08:30:45 -0700 (PDT)
Received: from redhat.com ([2a02:14f:178:8f0f:2cfe:cb96:98c4:3fd0])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a83838cefafsm116289566b.49.2024.08.15.08.30.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Aug 2024 08:30:45 -0700 (PDT)
Date: Thu, 15 Aug 2024 11:30:40 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: qemu-devel@nongnu.org, Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: Re: [RFC PATCH 0/2] async: rework async event API for replay
Message-ID: <20240815113029-mutt-send-email-mst@kernel.org>
References: <20240815132838.615330-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240815132838.615330-1-npiggin@gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.131,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Thu, Aug 15, 2024 at 11:28:35PM +1000, Nicholas Piggin wrote:
> Continuing the conversation from the thread about record/replay
> virtio fix. Here is a sketch of how we could improve the naming
> convention so users of bh don't have to know about record/replay.
> 
> Thanks,
> Nick

The API looks ok to me.

> Nicholas Piggin (2):
>   async: rework async event API for replay
>   async: add debugging assertions for record/replay in bh APIs
> 
>  docs/devel/replay.rst              |  7 ++--
>  include/block/aio.h                | 35 +++++++++++++++--
>  include/sysemu/replay.h            |  2 +-
>  block.c                            |  4 +-
>  block/block-backend.c              | 24 +++++++-----
>  block/io.c                         |  5 ++-
>  block/iscsi.c                      |  5 ++-
>  block/nfs.c                        | 10 +++--
>  block/null.c                       |  4 +-
>  block/nvme.c                       |  8 ++--
>  hw/ide/core.c                      |  7 ++--
>  hw/scsi/scsi-bus.c                 |  6 +--
>  monitor/monitor.c                  |  2 +-
>  monitor/qmp.c                      |  5 ++-
>  qapi/qmp-dispatch.c                |  4 +-
>  replay/replay-events.c             | 25 ++++++------
>  stubs/replay-tools.c               |  2 +-
>  util/aio-wait.c                    |  2 +-
>  util/async.c                       | 63 ++++++++++++++++++++++++++++--
>  util/main-loop.c                   |  2 +-
>  util/thread-pool.c                 |  8 ++--
>  scripts/block-coroutine-wrapper.py |  2 +-
>  22 files changed, 164 insertions(+), 68 deletions(-)
> 
> -- 
> 2.45.2


