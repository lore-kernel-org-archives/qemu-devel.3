Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97E15C3ABCD
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 12:16:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uES4M-00081H-Ry; Mon, 12 May 2025 08:15:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uES3s-0007vJ-Cu
 for qemu-devel@nongnu.org; Mon, 12 May 2025 08:15:12 -0400
Received: from mail-yw1-x112f.google.com ([2607:f8b0:4864:20::112f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uES3p-0001rD-GH
 for qemu-devel@nongnu.org; Mon, 12 May 2025 08:15:12 -0400
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-707d3c12574so35100917b3.1
 for <qemu-devel@nongnu.org>; Mon, 12 May 2025 05:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747052106; x=1747656906; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=w3LoDMsjztJQ5/cbBs5QguRFNkq3R16LRxLV5XHiXu0=;
 b=R0em0pD0XMvWNcfkkopHCN3+FwTeqEQ+0VJPTdFpbKT6jo2tGHWVlVIH0ZIpZfVG9L
 iI2q8/42LWboxDLDqYSSj6czWYB1hyzYbDTkql21fCFVAOtJWodoZ5A/f0zXlREJbFy+
 dD8V9EewDnTagaHHSYlgNCwBAUxAmf3K0G6/9FCPr1FMvJde18CNyhAuXlPlPtQGy80C
 lCEqbc9Qqg5OIXfxuaG9eIuR+yry1Z519FPdd4O/NJr4ksXHYJLQ+WPwhQWm3IU7LcG0
 hlBuQoaVYh3cgFfiY4me/oDVvNPDYX4Kx6hlE2qkEkxviSIjDImkt9Uo2l3iJtgQ+gN5
 dn2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747052106; x=1747656906;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=w3LoDMsjztJQ5/cbBs5QguRFNkq3R16LRxLV5XHiXu0=;
 b=jpfNNrB8i1UwEkRDnRoqFSHA6V1jhBa98gXCtTO0O2gKFQ7yMB/GV5fFlfSFUU35Za
 kEFPG5anFFLifW68SbtPUKsl7QDY2Aj3JjUs4v2X8uiwkvvyZS3yHlgtYGTqLuhDSojM
 hanybkl16gGQxIqhC8yuynlPALog8Jl48hVyx/0uUGLDC8Y15x6vAboXC+gNhPIz4dPr
 vlOJ/KRrebhpGFeKCewZH/ATrB/tnjGSHLc8yoiwosC59IoHTTqnGL+JuNyqZjRL8svv
 6dKEHx0bXeyYe//M+CFke/syL04ZDe8dOKhcRU8J0QCI5gBuMVwSISk4dDgxJh9EY8XX
 91og==
X-Gm-Message-State: AOJu0YzRcmbcwG8StfNR8ueFl+ppOCH8eB5FIjvQlCp4NHywogIMLglp
 mnARU35KNUu5oF9zMIZDFPdjYoclYJJ2QUn292gsuJ0PMDec1pNnpDupMdPWqZomj5laZ+HnpHh
 0Z/crJMfRiLC/5nIpA0IT7oLL/koOCdJ132fsGw==
X-Gm-Gg: ASbGnct98jddILl74o+sYZrZhkmtKmgHVMQ/l3Lh20qJXg/u91iq+9LDp/rmXu2tHK6
 MnG537Q0Kt2lmpfm1YiaZH5aJ/t79aL1RN2f3Zfq8dbejiW9uRULOBEaR019qlvaNo6mpiab/K3
 vhCZ8o6o3UkzK5lTDJ2VSnn2TyQW7Z1SnDZA==
X-Google-Smtp-Source: AGHT+IFT5YufhK9NvbvclRGW1kP3mN9hKIW0OQgkXvM+XjnFaedA9AEn31BsIZOxXRYEHOIr1MDlOisth9WnKTegI3E=
X-Received: by 2002:a05:690c:9:b0:70b:6734:9f1 with SMTP id
 00721157ae682-70b67340a61mr28481487b3.15.1747052106557; Mon, 12 May 2025
 05:15:06 -0700 (PDT)
MIME-Version: 1.0
References: <20250508082943.446512-1-pbonzini@redhat.com>
 <20250508082943.446512-3-pbonzini@redhat.com>
In-Reply-To: <20250508082943.446512-3-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 12 May 2025 13:14:54 +0100
X-Gm-Features: AX0GCFsRyecOZsmq92ahjQNhYnMRo0Po9kU14W4tCW1108R2BG8v5cg_C4xpC6c
Message-ID: <CAFEAcA9JEC6+v79HJD9D10my-L7U+pfp-LwQEQM6ar9t-onsXg@mail.gmail.com>
Subject: Re: [PATCH 2/2] rust: pl011: Really use RX FIFO depth
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112f;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112f.google.com
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

On Thu, 8 May 2025 at 09:31, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> While we model a 16-elements RX FIFO since the PL011 model was
> introduced in commit cdbdb648b7c ("ARM Versatile Platform Baseboard
> emulation"), we only read 1 char at a time!

We could say that this is the Rust version of the C implementation's
commit 3e0f118f8259 ("hw/char/pl011: Really use RX FIFO depth").

> Have the IOCanReadHandler handler return how many elements are
> available, and use that in the IOReadHandler handler.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  docs/devel/rust.rst              |  2 +-
>  rust/hw/char/pl011/src/device.rs | 14 +++++++-------
>  2 files changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/docs/devel/rust.rst b/docs/devel/rust.rst
> index 4de86375021..171d908e0b0 100644
> --- a/docs/devel/rust.rst
> +++ b/docs/devel/rust.rst
> @@ -119,7 +119,7 @@ QEMU includes four crates:
>    for the ``hw/char/pl011.c`` and ``hw/timer/hpet.c`` files.
>
>  .. [#issues] The ``pl011`` crate is synchronized with ``hw/char/pl011.c``
> -   as of commit 02b1f7f61928.  The ``hpet`` crate is synchronized as of
> +   as of commit 3e0f118f82.  The ``hpet`` crate is synchronized as of
>     commit 1433e38cc8.  Both are lacking tracing functionality.
>
>  This section explains how to work with them.
> diff --git a/rust/hw/char/pl011/src/device.rs b/rust/hw/char/pl011/src/device.rs
> index 94b31659849..7f28bb25a9b 100644
> --- a/rust/hw/char/pl011/src/device.rs
> +++ b/rust/hw/char/pl011/src/device.rs
> @@ -580,19 +580,19 @@ fn write(&self, offset: hwaddr, value: u64, _size: u32) {
>      fn can_receive(&self) -> u32 {
>          let regs = self.regs.borrow();
>          // trace_pl011_can_receive(s->lcr, s->read_count, r);

This commented out tracepoint needs adjusting: the C version
is now
  trace_pl011_can_receive(s->lcr, s->read_count, fifo_depth, fifo_available)
where fifo_available is what we here open-code as
"regs.fifo_depth() - regs.read_count" in the return value.

I mention this because it affects whether you want to write
this open-coded or with a local variable.

> -        u32::from(regs.read_count < regs.fifo_depth())
> +        regs.fifo_depth() - regs.read_count
>      }
>
>      fn receive(&self, buf: &[u8]) {
> -        if buf.is_empty() {
> -            return;
> -        }
>          let mut regs = self.regs.borrow_mut();
> -        let c: u32 = buf[0].into();
> -        let update_irq = !regs.loopback_enabled() && regs.fifo_rx_put(c.into());
> +        let mut update_irq = false;
> +        for &c in buf {
> +            let c: u32 = c.into();
> +            update_irq |= !regs.loopback_enabled() && regs.fifo_rx_put(c.into());
> +        }

We're now checking loopback_enabled() on every iteration
(admittedly we previously also checked it for every character
but with the extra overhead of calling receive() too ;-))

Could we write this the same way the C code does with an
early-return before the for loop?

Also, the C version has a helpful comment about that:
    /*
     * In loopback mode, the RX input signal is internally disconnected
     * from the entire receiving logics; thus, all inputs are ignored,
     * and BREAK detection on RX input signal is also not performed.
     */

that it would be good to have in the Rust implementation so
we don't lose it as and when we drop the C impl.

> +
>          // Release the BqlRefCell before calling self.update()
>          drop(regs);
> -
>          if update_irq {
>              self.update();
>          }

thanks
-- PMM

