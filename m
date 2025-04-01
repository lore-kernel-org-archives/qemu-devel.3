Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13759C36010
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Apr 2025 00:18:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzlng-0001kP-Bg; Tue, 01 Apr 2025 20:17:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tzlnd-0001jd-0d
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 20:17:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tzlna-0002zk-TW
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 20:17:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743553059;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GhT2bJaH8j4meBFfXz9ZI15r2hy18/03nb00p8MvWJU=;
 b=DVMQqhae/lskMSi1Nye3OISUuGZYwWy9+YzB0wfs0JVYgS0fAODLA2jSfsBzWonV6f1rBI
 eilfERavWqIJsfvJbgVtWTF8p7rVoZFsuM3GrXkYHfG77CnHY2cUq5qd/42CD6JT+9gMzr
 9SPGicdWSU/bXjtxovFz06I2oqsJOhg=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-195-xPNpqlbSNxWnkQNlAcsz7w-1; Tue,
 01 Apr 2025 20:17:34 -0400
X-MC-Unique: xPNpqlbSNxWnkQNlAcsz7w-1
X-Mimecast-MFC-AGG-ID: xPNpqlbSNxWnkQNlAcsz7w_1743553053
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BA24619560BC; Wed,  2 Apr 2025 00:17:32 +0000 (UTC)
Received: from localhost (unknown [10.2.16.38])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id F24D0195609D; Wed,  2 Apr 2025 00:17:31 +0000 (UTC)
Date: Tue, 1 Apr 2025 15:21:42 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: saman <saman@enumclass.cc>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org, Mads Ynddal <mads@ynddal.dk>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: Re: [PATCH] Rust: Add tracing and logging support for Rust code
Message-ID: <20250401192142.GD277986@fedora>
References: <20250401002633.738345-1-saman@enumclass.cc>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="LopqBG/p4LWDt1ee"
Content-Disposition: inline
In-Reply-To: <20250401002633.738345-1-saman@enumclass.cc>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_03_06=1.592,
 DKIMWL_WL_HIGH=-0.997, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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


--LopqBG/p4LWDt1ee
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 31, 2025 at 07:26:33PM -0500, saman wrote:
> This change introduces initial support for tracing and logging in Rust-ba=
sed
> QEMU code. As an example, tracing and logging have been implemented in the
> pl011 device, which is written in Rust.
>=20
> - Updated `rust/wrapper.h` to include the `qemu/log.h` and `hw/char/trace=
=2Eh` header.
> - Added log.rs to wrap `qemu_log_mask` and `qemu_log_mask_and_addr`
> - Modified `tracetool` scripts to move C function implementation from
>   header to .c
> - Added log and trace in rust version of PL011 device
>=20
> Future enhancements could include generating idiomatic Rust APIs for trac=
ing
> using the tracetool scripts
>=20
> Signed-off-by: saman <saman@enumclass.cc>
> ---
>  include/qemu/log-for-trace.h        |  5 +--
>  rust/hw/char/pl011/src/device.rs    | 34 +++++++++++++++---
>  rust/hw/char/pl011/src/registers.rs | 20 +++++++++++
>  rust/qemu-api/meson.build           |  1 +
>  rust/qemu-api/src/lib.rs            |  1 +
>  rust/qemu-api/src/log.rs            | 54 +++++++++++++++++++++++++++++
>  rust/wrapper.h                      |  2 ++
>  scripts/tracetool/format/c.py       | 16 +++++++++
>  scripts/tracetool/format/h.py       | 11 ++----
>  util/log.c                          |  5 +++
>  10 files changed, 131 insertions(+), 18 deletions(-)
>  create mode 100644 rust/qemu-api/src/log.rs
>=20
> diff --git a/include/qemu/log-for-trace.h b/include/qemu/log-for-trace.h
> index d47c9cd446..ad5cd0dd24 100644
> --- a/include/qemu/log-for-trace.h
> +++ b/include/qemu/log-for-trace.h
> @@ -24,10 +24,7 @@ extern int qemu_loglevel;
>  #define LOG_TRACE          (1 << 15)
> =20
>  /* Returns true if a bit is set in the current loglevel mask */
> -static inline bool qemu_loglevel_mask(int mask)
> -{
> -    return (qemu_loglevel & mask) !=3D 0;
> -}
> +bool qemu_loglevel_mask(int mask);
> =20
>  /* main logging function */
>  void G_GNUC_PRINTF(1, 2) qemu_log(const char *fmt, ...);
> diff --git a/rust/hw/char/pl011/src/device.rs b/rust/hw/char/pl011/src/de=
vice.rs
> index bf88e0b00a..42385a7bf6 100644
> --- a/rust/hw/char/pl011/src/device.rs
> +++ b/rust/hw/char/pl011/src/device.rs
> @@ -2,15 +2,21 @@
>  // Author(s): Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
>  // SPDX-License-Identifier: GPL-2.0-or-later
> =20
> -use std::{ffi::CStr, mem::size_of, ptr::addr_of_mut};
> +use std::{
> +    ffi::{CStr, CString},
> +    mem::size_of,
> +    ptr::addr_of_mut,
> +};
> =20
>  use qemu_api::{
>      chardev::{CharBackend, Chardev, Event},
>      impl_vmstate_forward,
>      irq::{IRQState, InterruptSource},
> +    log::Mask,
>      memory::{hwaddr, MemoryRegion, MemoryRegionOps, MemoryRegionOpsBuild=
er},
>      prelude::*,
>      qdev::{Clock, ClockEvent, DeviceImpl, DeviceState, Property, ResetTy=
pe, ResettablePhasesImpl},
> +    qemu_log_mask,
>      qom::{ObjectImpl, Owned, ParentField},
>      static_assert,
>      sysbus::{SysBusDevice, SysBusDeviceImpl},
> @@ -298,7 +304,7 @@ pub(self) fn write(
>              DMACR =3D> {
>                  self.dmacr =3D value;
>                  if value & 3 > 0 {
> -                    // qemu_log_mask(LOG_UNIMP, "pl011: DMA not implemen=
ted\n");
> +                    qemu_log_mask!(Mask::log_unimp, "pl011: DMA not impl=
emented\n");
>                      eprintln!("pl011: DMA not implemented");
>                  }
>              }
> @@ -535,11 +541,21 @@ fn read(&self, offset: hwaddr, _size: u32) -> u64 {
>                  u64::from(device_id[(offset - 0xfe0) >> 2])
>              }
>              Err(_) =3D> {
> -                // qemu_log_mask(LOG_GUEST_ERROR, "pl011_read: Bad offse=
t 0x%x\n", (int)offset);
> +                qemu_log_mask!(
> +                    Mask::log_guest_error,
> +                    "pl011_read: Bad offset 0x%x\n",
> +                    offset as i32
> +                );
>                  0
>              }
>              Ok(field) =3D> {
> +                let regname =3D field.as_str();
>                  let (update_irq, result) =3D self.regs.borrow_mut().read=
(field);
> +                let c_string =3D CString::new(regname).expect("CString::=
new failed");
> +                let name_ptr =3D c_string.as_ptr();
> +                unsafe {
> +                    qemu_api::bindings::trace_pl011_read(offset as u32, =
result, name_ptr);
> +                }

I didn't look closely to see whether CString::new(field.as_str()) boils
down to allocating a new string or just pointing to a NUL-terminated
string constant in the .rodata section of the binary, but this looks
suspicious.

It has the pattern:

  ...do work to produce trace event arguments...
  trace_foo(arg1, arg2, arg3);

Tracing is intended to be as low-overhead as possible when trace events
are disabled but compiled in. The work to produce event arguments must
be done only when the trace event is enabled.

--LopqBG/p4LWDt1ee
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmfsPMUACgkQnKSrs4Gr
c8gCiwf+JLMo2CC3ET7B+3e2/u9s6RDBDQg5vBQFMwGJntWplp+vq3i5KW8NgmUY
ToPifGnVf/Qe68LzepcXB1gXX5O764VciPmCjWvHkpPJKKE4vR1VoNuMWOrrru1P
RElhPATLuEqueAtASzoTGIVbubaQjy0fAanQL8qUPCbZDRoueWdB5G1jCy8u9fZN
Gh1vrYotgDVNaYGthX+kst8aP9u+dIBXJIuDfc64wYV8O8lUIysFByyV+PbgmzYa
/HHRO62q14f2JAbBm9IcKKQ1yD5iNZCC1hypJtdx5+f6Ne2WLRPoDV5T861d23Nq
lscnGgIfvMwOau/PjpnMT04RW1lLNA==
=FGKn
-----END PGP SIGNATURE-----

--LopqBG/p4LWDt1ee--


