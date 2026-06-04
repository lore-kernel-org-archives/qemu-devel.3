Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7C83CD6E4A
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2026 14:02:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wV8dG-0002PS-3W; Thu, 04 Jun 2026 10:01:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1wV8d2-0002OB-1u
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 10:01:00 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1wV8cz-00027W-US
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 10:00:59 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-68cc6c7df99so1038230a12.1
 for <qemu-devel@nongnu.org>; Thu, 04 Jun 2026 07:00:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780581656; cv=none;
 d=google.com; s=arc-20240605;
 b=elvDvGsUg3j1TNN0+UZT9qxMKTwKe3jwW+IvBCRecWhXJux8JeQhEMyURbkayq8vtL
 h2FZkueR1vvZ8sXgVeRy9u7aFLCooQZB9BkGMkXL59KJ4SzogEJtoMknYzzbfVSKvkpQ
 Jo/ulX3PIV0wJeFDzgroNJCB5GKvlc5VCAy2nVzI1orTxw0RD57fOJNxE2tshzHiLGBT
 E6qIO5uBF++uTmTNtckvJ63pgS+P1J74iRmiMxNTKwKCMI8r31pBnUMWI0p8vqxK4kq/
 k+zO+e2/WW27kshkKAeF0Ns2J2oqZJtYzK8h7FewAQSQ/NBMxWJI7ydLXa9/Q4y8jUJy
 LmPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=6fEG4lkTc/kOHovGjwVdPULfG+0u37KPbhewkHGQ8wU=;
 fh=I4bPGmFuSJAUDPPBcEbiWZt2Bp8JKDYHn7NU1zWWO5c=;
 b=e+4FBApy78guG+HqMcpov/GEHEhCxl1WTfp2zoaB6Ggmo01NhpgtefOB6dr9nPFBet
 eq++oMtayNlZ/dxjQTVibwcSK9kWoavcD46thexAJ60POg2tUfkSbm5bs6gxIrRExqC2
 uGZj9EkQNp9yzH1KemngOfvuQdP+noQ9THsbCQ7dz6QRdrI7TlPT3ThCV8PTalnDFRtW
 Hmr+rC6gT0OTW4Uc21kX3H8LWJMr0bm+eUgWuiflfqgWMif4tahLR17zcar+OtI4WLBh
 fzaE0uZqdt5wfBzpljqynceV37TYRWmmt0z6Fpe7rioZjMfnGD28LHwDuBGSfXIEX7qr
 2EEg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780581656; x=1781186456; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6fEG4lkTc/kOHovGjwVdPULfG+0u37KPbhewkHGQ8wU=;
 b=sAkF9Z3FzyWzEirFABOCnz2SbnqhBdxCDXrB66kfbHp1dtlC/G94g20DkOAEyI0oWh
 DurL/cSFr9Wnm2xFvTYmWQFCeSP7fjtuV+SIyhTR9H0zvDLa2l9s/5z1ANFMsmCcjJ2g
 ICsGFM5H37Olk5qCBJpv9qBzPIFDJxe0TCUWNL+emFwC4mhUcCyAi9HFdSLaUDJvm8ER
 jJE8h0cNHUAE8J1oAH+yVneQtxt+a7i+kUMbkS9DjTrpBfBNE0dq0yE4tcJbPP9Ub6qf
 QRrTY46OXj3E1RfenPEmNhGJL7MivkLoCTzK7vkKlMX3ItIr1/BfiPa+Tsd9yPACDISf
 U3/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780581656; x=1781186456;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6fEG4lkTc/kOHovGjwVdPULfG+0u37KPbhewkHGQ8wU=;
 b=g5t4RoB177ZLNyfplwJkUpgEzkzNhy22F86tbqvRedtG2GOBjkjdq67QY6NVdmRbcW
 FiOlXQJd2YxkuqKnlgjn8roEB8FDM27mpL5MyJTBNwg/azvKgLpQB0y9EjJ9l082vP40
 reiiO9lUb53B96ECXL+PySm0sOeh5cIkTRV7NRbueNQLDmHzw0AbysJSRtaAauXVoDwg
 KbgQRkIMusTwYQWF1R+wvr7HgqA/E3LGTp5utk+blXAun3Lh+NT2G0Zw1MriW7k0ZjfU
 xItgo1ozA1X+aeJv4DwVOgVo0gqLKfUbmQYzswG2vIlX6qAvpELgDW0Hilz0YxNHYSXj
 z8wg==
X-Gm-Message-State: AOJu0YwfGcB+oDUEkv1DL7AhNB6UOzfK94sneC8JlNhCIAkvBPGPqUsU
 CHPVTqg2tt162Hd+6VL8eDutryRZzvHCWipY3q+E2HpXWoczeZCFZC+g1TLehX1TY2Aeyk+B/u7
 0211BcjnGWMUs2kMLbcVwBZZq8pI8DdA=
X-Gm-Gg: Acq92OGOW/4WitQov/ds0q1U13yoILleGWwRMQbDIKY8iZ1ws7WdNpVZ9IqRhbLSRuQ
 PC+/W1we9K2H4TDbNgdbp80vw6eaq1tG2RhjdNvCtwvvEAQzQ7CzB+FDYFuaq5m8HMQpAQ5kegN
 TGu66gBz7t/JS9Dp5V9ixGOWcPSeJaLavtXJUkrpXBZeeAMhmZXVMs60vW3kpToQscgwRJOMaZS
 0QdCGJa96WIAbFs2fgJ7NwGmae/IKK/OyrW4vH2rphS8pFQD7mRZzqFlS8OZBtVffTmG3AqBIOG
 OhOqtk8zih7N5Raj63PEF+ylzFhjCKuVtOtg5xhxfLh84mykR18V
X-Received: by 2002:a05:6402:1f4f:b0:66e:cf8d:6970 with SMTP id
 4fb4d7f45d1cf-68e711f6842mr4155314a12.20.1780581655854; Thu, 04 Jun 2026
 07:00:55 -0700 (PDT)
MIME-Version: 1.0
References: <20260603223430.3311916-1-connorkite@gmail.com>
 <20260603223430.3311916-3-connorkite@gmail.com>
In-Reply-To: <20260603223430.3311916-3-connorkite@gmail.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Thu, 4 Jun 2026 10:00:43 -0400
X-Gm-Features: AVHnY4J-BwNveI_Xzie0uSJiGXTQgRTgmZ2wfY-WAt9eoALe_uPL0A87C_IcVuU
Message-ID: <CAJSP0QUX+9mkuU1YQYwKbWwpMTuisy8Lbko-oL-fFZZusAF3nw@mail.gmail.com>
Subject: Re: [PATCH 2/2] vhost-user: Add memory-isolation qdev property
To: ConKite <connorkite@gmail.com>
Cc: qemu-devel@nongnu.org, hreitz@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=stefanha@gmail.com; helo=mail-ed1-x52b.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, Jun 3, 2026 at 6:35=E2=80=AFPM ConKite <connorkite@gmail.com> wrote=
:
>
> In support of future work to add a memory isolation mode to vhost-user de=
vices, a
> qdev property, "memory-isolation", is added to all vhost-user devices. Th=
is is
> simply a bool representing whether the mode is active or not.
>
> Signed-of-by: Connor Kite <connorkite@gmail.com>
>
> ---
>  hw/block/vhost-user-blk.c            | 1 +
>  hw/display/vhost-user-gpu.c          | 1 +
>  hw/scsi/vhost-user-scsi.c            | 1 +
>  hw/virtio/vhost-user-base.c          | 3 ++-
>  hw/virtio/vhost-user-fs.c            | 1 +
>  hw/virtio/vhost-user-scmi.c          | 1 +
>  hw/virtio/vhost-user-vsock.c         | 1 +
>  include/hw/virtio/vhost-user-base.h  | 1 +
>  include/hw/virtio/vhost-user-blk.h   | 1 +
>  include/hw/virtio/vhost-user-fs.h    | 1 +
>  include/hw/virtio/vhost-user-scmi.h  | 1 +
>  include/hw/virtio/vhost-user-vsock.h | 1 +
>  include/hw/virtio/virtio-gpu.h       | 1 +
>  include/hw/virtio/virtio-scsi.h      | 1 +
>  14 files changed, 15 insertions(+), 1 deletion(-)

This patch can be applied after the memory isolation internals are
merged in the future. For now it should stay out-of-tree because it's
a user-visible option that is currently unimplemented.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

