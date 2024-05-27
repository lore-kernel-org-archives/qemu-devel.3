Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9CA8C25B74
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2024 20:40:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBh8J-0001jA-TM; Mon, 27 May 2024 16:39:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1sBh8H-0001ii-Vx
 for qemu-devel@nongnu.org; Mon, 27 May 2024 16:39:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1sBh8G-00062G-06
 for qemu-devel@nongnu.org; Mon, 27 May 2024 16:39:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716842386;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2tcVvc7/gmUI+En2DF5+8LvKpn+hRad6sq3pZJzpBbc=;
 b=exJZHKLQMR6I2Gx8ZVG487cG8WGdOjwlRVkR4FgBvECGuTO9PmaeygBuIMoZYflXTUf+ES
 VSX7sbS0hKHxdjXdIcZZ9QN2Q8sY8Sr639L3Yq776dW36p7/5mvSuz7qhOKj2hagX7Zc4n
 yL0AJauJlGSZiz0TeElOmeH6UsccPPc=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-100-y12cYT7qNYy6Hepy_xNTXA-1; Mon,
 27 May 2024 16:39:41 -0400
X-MC-Unique: y12cYT7qNYy6Hepy_xNTXA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 09A201C0512D;
 Mon, 27 May 2024 20:39:41 +0000 (UTC)
Received: from localhost (unknown [10.39.195.38])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 65B93C15BED;
 Mon, 27 May 2024 20:39:40 +0000 (UTC)
Date: Mon, 27 May 2024 16:39:38 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Zhao Liu <zhao1.liu@intel.com>
Cc: Mads Ynddal <mads@ynddal.dk>, Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [RFC 3/6] scripts/simpletrace-rust: Add helpers to parse trace
 file
Message-ID: <20240527203938.GD913874@fedora.redhat.com>
References: <20240527081421.2258624-1-zhao1.liu@intel.com>
 <20240527081421.2258624-4-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="b5pIa4HhrhO5w80p"
Content-Disposition: inline
In-Reply-To: <20240527081421.2258624-4-zhao1.liu@intel.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.034,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


--b5pIa4HhrhO5w80p
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 27, 2024 at 04:14:18PM +0800, Zhao Liu wrote:
> Refer to scripts/simpletrace.py, add the helpers to read the trace file
> and parse the record type field, record header and log header.
>=20
> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> ---
>  scripts/simpletrace-rust/src/main.rs | 151 +++++++++++++++++++++++++++
>  1 file changed, 151 insertions(+)
>=20
> diff --git a/scripts/simpletrace-rust/src/main.rs b/scripts/simpletrace-r=
ust/src/main.rs
> index 2d2926b7658d..b3b8baee7c66 100644
> --- a/scripts/simpletrace-rust/src/main.rs
> +++ b/scripts/simpletrace-rust/src/main.rs
> @@ -14,21 +14,172 @@
>  mod trace;
> =20
>  use std::env;
> +use std::fs::File;
> +use std::io::Error as IOError;
> +use std::io::ErrorKind;
> +use std::io::Read;
> =20
>  use clap::Arg;
>  use clap::Command;
>  use thiserror::Error;
>  use trace::Event;
> =20
> +const RECORD_TYPE_MAPPING: u64 =3D 0;
> +const RECORD_TYPE_EVENT: u64 =3D 1;
> +
>  #[derive(Error, Debug)]
>  pub enum Error
>  {
>      #[error("usage: {0} [--no-header] <trace-events> <trace-file>")]
>      CliOptionUnmatch(String),
> +    #[error("Failed to read file: {0}")]
> +    ReadFile(IOError),
> +    #[error("Unknown record type ({0})")]
> +    UnknownRecType(u64),
>  }
> =20
>  pub type Result<T> =3D std::result::Result<T, Error>;
> =20
> +enum RecordType
> +{
> +    Empty,
> +    Mapping,
> +    Event,
> +}
> +
> +#[repr(C)]
> +#[derive(Clone, Copy, Default)]
> +struct RecordRawType
> +{
> +    rtype: u64,
> +}
> +
> +impl RecordType
> +{
> +    fn read_type(mut fobj: &File) -> Result<RecordType>
> +    {
> +        let mut tbuf =3D [0u8; 8];
> +        if let Err(e) =3D fobj.read_exact(&mut tbuf) {
> +            if e.kind() =3D=3D ErrorKind::UnexpectedEof {
> +                return Ok(RecordType::Empty);
> +            } else {
> +                return Err(Error::ReadFile(e));
> +            }
> +        }
> +
> +        /*
> +         * Safe because the layout of the trace record requires us to pa=
rse
> +         * the type first, and then there is a check on the validity of =
the
> +         * record type.
> +         */
> +        let raw_t =3D
> +            unsafe { std::mem::transmute::<[u8; 8], RecordRawType>(tbuf)=
 };

A safe alternative: https://doc.rust-lang.org/std/primitive.u64.html#method=
=2Efrom_ne_bytes?

> +        match raw_t.rtype {
> +            RECORD_TYPE_MAPPING =3D> Ok(RecordType::Mapping),
> +            RECORD_TYPE_EVENT =3D> Ok(RecordType::Event),
> +            _ =3D> Err(Error::UnknownRecType(raw_t.rtype)),
> +        }
> +    }
> +}
> +
> +trait ReadHeader
> +{
> +    fn read_header(fobj: &File) -> Result<Self>
> +    where
> +        Self: Sized;
> +}
> +
> +#[repr(C)]
> +#[derive(Clone, Copy)]
> +struct LogHeader
> +{
> +    event_id: u64,
> +    magic: u64,
> +    version: u64,
> +}
> +
> +impl ReadHeader for LogHeader
> +{
> +    fn read_header(mut fobj: &File) -> Result<Self>
> +    {
> +        let mut raw_hdr =3D [0u8; 24];
> +        fobj.read_exact(&mut raw_hdr).map_err(Error::ReadFile)?;
> +
> +        /*
> +         * Safe because the size of log header (struct LogHeader)
> +         * is 24 bytes, which is ensured by simple trace backend.
> +         */
> +        let hdr =3D
> +            unsafe { std::mem::transmute::<[u8; 24], LogHeader>(raw_hdr)=
 };

Or u64::from_ne_bytes() for each field.

> +        Ok(hdr)
> +    }
> +}
> +
> +#[derive(Default)]
> +struct RecordInfo
> +{
> +    event_id: u64,
> +    timestamp_ns: u64,
> +    record_pid: u32,
> +    args_payload: Vec<u8>,
> +}
> +
> +impl RecordInfo
> +{
> +    fn new() -> Self
> +    {
> +        Default::default()
> +    }
> +}
> +
> +#[repr(C)]
> +#[derive(Clone, Copy)]
> +struct RecordHeader
> +{
> +    event_id: u64,
> +    timestamp_ns: u64,
> +    record_length: u32,
> +    record_pid: u32,
> +}
> +
> +impl RecordHeader
> +{
> +    fn extract_record(&self, mut fobj: &File) -> Result<RecordInfo>
> +    {
> +        let mut info =3D RecordInfo::new();
> +
> +        info.event_id =3D self.event_id;
> +        info.timestamp_ns =3D self.timestamp_ns;
> +        info.record_pid =3D self.record_pid;
> +        info.args_payload =3D vec![
> +            0u8;
> +            self.record_length as usize
> +                - std::mem::size_of::<RecordHeader>()
> +        ];
> +        fobj.read_exact(&mut info.args_payload)
> +            .map_err(Error::ReadFile)?;
> +
> +        Ok(info)
> +    }
> +}
> +
> +impl ReadHeader for RecordHeader
> +{
> +    fn read_header(mut fobj: &File) -> Result<Self>
> +    {
> +        let mut raw_hdr =3D [0u8; 24];
> +        fobj.read_exact(&mut raw_hdr).map_err(Error::ReadFile)?;
> +
> +        /*
> +         * Safe because the size of record header (struct RecordHeader)
> +         * is 24 bytes, which is ensured by simple trace backend.
> +         */
> +        let hdr: RecordHeader =3D
> +            unsafe { std::mem::transmute::<[u8; 24], RecordHeader>(raw_h=
dr) };

Or u64::from_ne_bytes() and u32::from_ne_bytes() for all fields.

> +        Ok(hdr)
> +    }
> +}
> +
>  pub struct EventArgPayload {}
> =20
>  trait Analyzer
> --=20
> 2.34.1
>=20

--b5pIa4HhrhO5w80p
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmZU74oACgkQnKSrs4Gr
c8g7vAgAxLq317AaJtnEj5kSBGwt1x5Uxl64jFmx2cBdy1qgbuuw0dZpBEyFysGH
VMd7gTgcWRFo1dv6ckyL81Egwny9Pph+4L0lMCRugmN6bS892PJ5ENn2JGb+iQwG
/aPegR1U8WEK2kPjz7+LQUVLbf7K3YG6Hzcltc1EeHTWohr4E+wPw+uZL9zyIP3V
obD3iSss2z3TszjSZdObUukQKy0jjA+zwR3bx1ONXHQVYSaM5uLre8nmnHRs72/P
gZi23u1UlbYwXYgmkAPfWhg4RGpVVhBJb48yQv0vyTf3d44RZCv1MMVfRyY80xl1
OEgc7y0EAn5pzmly0QJLqB8uzIPhnA==
=vCtG
-----END PGP SIGNATURE-----

--b5pIa4HhrhO5w80p--


