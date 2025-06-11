Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09B2BC677C4
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Jun 2025 11:02:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPJDY-0006RV-2t; Wed, 11 Jun 2025 07:02:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1uPJDG-0006MT-6F
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 07:01:49 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1uPJDC-0004DU-Vv
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 07:01:44 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-607cf70b00aso7262535a12.2
 for <qemu-devel@nongnu.org>; Wed, 11 Jun 2025 04:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749639697; x=1750244497; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vt/SCwmnQlT6n+0Kv3RM9z5QLZhhYbVKruVNO0y729U=;
 b=WtN0GBszs0YvSc3LVDhbQC2XhkL3O6u3TYIlTOAlpN9Kxt1bKEpa6QjeDZx8dKCAji
 548IW15UGxHs3YNnRtKnS8dPp8mjHFJoZ79cGS/pcOm2jR+v1thAw2zfrBfObyDczCZ/
 IUtx3MNM0uLDei/L4SnOD/z1r6yDXbQ1TZ6lfAx2uYGZ0tucGGdQTNZeAOqxIAwZ+1Sc
 HrZprPdiZ1caqiuVOYywS7DuKzequTnUP9EV4gam5PHGbwtuKtFKK2PMsqjuQYJ6VWC6
 Y3/m2IJPygkCp2jtC3uodWb0zftlXuWTmLW7UcOErf5s1OG5KSsFlerEqBlOyRlYOref
 ZNqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749639697; x=1750244497;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vt/SCwmnQlT6n+0Kv3RM9z5QLZhhYbVKruVNO0y729U=;
 b=HNLZhaqjJHBWt3qLt5myMzC4079/9T501xDGk4BbBDITfpV6q/ua9T2+L6IR8H8gae
 qKE4ULlq38LbIKwMyC9RgrgSSKCrpDFQJxuAU8kMhPFPvEVhz5khtqmiCqxw2KRz7HZu
 7P1gp9DRZYAWQ7tcXXULCTYIGNM7A+VVDrTIzRXWsp8O4h11yvCQNcPaM5yGa9eUD4dS
 RIHgwqLcSOwPwXr+kYgmUK7nbNppwb+MSfBoVioU9pbSuoUo9bUG9PdITUpTVKG+ax7p
 NTeZO3XXFj46RScUDDa85viTqAG3+RHoXjUk8WPXqyrBh4Ph7Lq4NLiSSkQ6IzJkgq/F
 vRaQ==
X-Gm-Message-State: AOJu0YwBCHOBRN8S+M1+A0Bi5wTiXcriAbXl2pFTIgIcHyedY4kC45Ms
 y4VMB53b5MogRzp+vL1NcwbK1wgGd0/fXLVzJ4kyfOKVDAyaX5NcTUj2yO3pFw32rEjsm04MXdD
 +IcvlAL0/8m2RKUxPTZ9X9lnJOf2kxKhvr6ubyUJZGmdtnVATXZYAzcLVWQ==
X-Gm-Gg: ASbGncvjEE3endpg210a55QSM+XIRuCMGwa3h1q7Tq5POpqXja8NPfaCetqToTeKiJW
 V+WnwyKjk1Pd5p3+aQayzwh6+wvTVrtixRuvUjEg2ocACye2QAAmq5pYSs4r0MSqZ8kGjhhAq0k
 y5iqteXBWzWr1sry+k67qCFeWk7KEm/7qLofQB8+aiJjCf
X-Google-Smtp-Source: AGHT+IForeT7rKQlxG8UT9hg5Z6ri5RJJeknnkisRZKlYmr998RNQIoOCQgPK5Uh1ZZ4RkM907JGRio3dj39UVfBUGs=
X-Received: by 2002:a05:6402:1941:b0:602:48:ba35 with SMTP id
 4fb4d7f45d1cf-6084686a2c2mr2490064a12.13.1749639696981; Wed, 11 Jun 2025
 04:01:36 -0700 (PDT)
MIME-Version: 1.0
References: <20250610202110.2243-1-shentey@gmail.com>
 <20250610202110.2243-3-shentey@gmail.com>
In-Reply-To: <20250610202110.2243-3-shentey@gmail.com>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Wed, 11 Jun 2025 14:01:10 +0300
X-Gm-Features: AX0GCFueGHVhUMv8hjnKS8D9J0rpms8L-yAMYVK3iwonKZy--GkcLVhiWQMqz3o
Message-ID: <CAAjaMXbvKvGhWGbxj69vudOzCUbs+AJ+xmZ20jbPirZTHJZyKQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] rust/hw/char/pl011/src/device: Implement logging
To: Bernhard Beschow <shentey@gmail.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-rust@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ed1-x532.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Tue, Jun 10, 2025 at 11:21=E2=80=AFPM Bernhard Beschow <shentey@gmail.co=
m> wrote:
>
> Now that there is logging support in Rust for QEMU, use it in the pl011
> device.
>
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
>  rust/hw/char/pl011/src/device.rs | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/rust/hw/char/pl011/src/device.rs b/rust/hw/char/pl011/src/de=
vice.rs
> index be8387f6f2..17a4e9269c 100644
> --- a/rust/hw/char/pl011/src/device.rs
> +++ b/rust/hw/char/pl011/src/device.rs
> @@ -8,6 +8,8 @@
>      chardev::{CharBackend, Chardev, Event},
>      impl_vmstate_forward,
>      irq::{IRQState, InterruptSource},
> +    log::Log,
> +    log_mask,
>      memory::{hwaddr, MemoryRegion, MemoryRegionOps, MemoryRegionOpsBuild=
er},
>      prelude::*,
>      qdev::{Clock, ClockEvent, DeviceImpl, DeviceState, Property, ResetTy=
pe, ResettablePhasesImpl},
> @@ -275,8 +277,7 @@ pub(self) fn write(
>              DMACR =3D> {
>                  self.dmacr =3D value;
>                  if value & 3 > 0 {
> -                    // qemu_log_mask(LOG_UNIMP, "pl011: DMA not implemen=
ted\n");
> -                    eprintln!("pl011: DMA not implemented");
> +                    log_mask!(Log::Unimp, "pl011: DMA not implemented\n"=
);
>                  }
>              }
>          }
> @@ -538,7 +539,7 @@ fn read(&self, offset: hwaddr, _size: u32) -> u64 {
>                  u64::from(device_id[(offset - 0xfe0) >> 2])
>              }
>              Err(_) =3D> {
> -                // qemu_log_mask(LOG_GUEST_ERROR, "pl011_read: Bad offse=
t 0x%x\n", (int)offset);
> +                log_mask!(Log::GuestError, "pl011_read: Bad offset {offs=
et}\n");

Nit:

log_mask!(Log::GuestError, "pl011_read: Bad offset 0x{offset:x}\n");

Also, pl011_read is the C device function. You can put
`PL011State::read: ` instead.

>                  0
>              }
>              Ok(field) =3D> {
> @@ -570,7 +571,10 @@ fn write(&self, offset: hwaddr, value: u64, _size: u=
32) {
>                  .borrow_mut()
>                  .write(field, value as u32, &self.char_backend);
>          } else {
> -            eprintln!("write bad offset {offset} value {value}");
> +            log_mask!(
> +                Log::GuestError,
> +                "pl011_write: Bad offset {offset} value {value}\n"
> +            );

Ditto



--
Manos Pitsidianakis
Emulation and Virtualization Engineer at Linaro Ltd

