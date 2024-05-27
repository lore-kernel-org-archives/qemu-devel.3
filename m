Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7140C25B74
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2024 20:44:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBhCh-0002un-Gp; Mon, 27 May 2024 16:44:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1sBhCb-0002ty-FG
 for qemu-devel@nongnu.org; Mon, 27 May 2024 16:44:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1sBhCY-0006mr-JF
 for qemu-devel@nongnu.org; Mon, 27 May 2024 16:44:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716842653;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CDa/Wv0imbqv+r6bLlBZTwDJNFoQ5/dajvre0QNFrVc=;
 b=hh7u7cf1TlUK1/YxspuqwU1KCQtqWejk42ma4cpqci6bLwS7zfmEET73UtmIEl4uPQVNym
 Nqr9DuM1LuIem/jmEyj7xx3TYAy03xwD4UcbgxZSUz73LGta08Oo7HHNg3BKjEDET/oWXs
 Yy+vBq9i3lBwocehFlS3bZvNgJwqBWs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-567-0C1n2SboNumNrKOF1YNlBw-1; Mon, 27 May 2024 16:44:09 -0400
X-MC-Unique: 0C1n2SboNumNrKOF1YNlBw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 699E9101A525;
 Mon, 27 May 2024 20:44:09 +0000 (UTC)
Received: from localhost (unknown [10.39.195.38])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9235EC15BED;
 Mon, 27 May 2024 20:44:08 +0000 (UTC)
Date: Mon, 27 May 2024 16:44:06 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Zhao Liu <zhao1.liu@intel.com>
Cc: Mads Ynddal <mads@ynddal.dk>, Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [RFC 4/6] scripts/simpletrace-rust: Parse and check trace recode
 file
Message-ID: <20240527204406.GE913874@fedora.redhat.com>
References: <20240527081421.2258624-1-zhao1.liu@intel.com>
 <20240527081421.2258624-5-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="mcc/3NXhJlZJglzb"
Content-Disposition: inline
In-Reply-To: <20240527081421.2258624-5-zhao1.liu@intel.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
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


--mcc/3NXhJlZJglzb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 27, 2024 at 04:14:19PM +0800, Zhao Liu wrote:
> Refer to scripts/simpletrace.py, parse and check the simple trace
> backend binary trace file.
>=20
> Note, in order to keep certain backtrace information to get frame,
> adjust the cargo debug level for release version to "line-tables-only",
> which slows down the program, but is necessary.
>=20
> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> ---
>  scripts/simpletrace-rust/Cargo.lock  |  79 +++++++++
>  scripts/simpletrace-rust/Cargo.toml  |   4 +
>  scripts/simpletrace-rust/src/main.rs | 253 ++++++++++++++++++++++++++-
>  3 files changed, 329 insertions(+), 7 deletions(-)
>=20
> diff --git a/scripts/simpletrace-rust/Cargo.lock b/scripts/simpletrace-ru=
st/Cargo.lock
> index 3d815014eb44..37d80974ffe7 100644
> --- a/scripts/simpletrace-rust/Cargo.lock
> +++ b/scripts/simpletrace-rust/Cargo.lock
> @@ -2,6 +2,21 @@
>  # It is not intended for manual editing.
>  version =3D 3
> =20
> +[[package]]
> +name =3D "addr2line"
> +version =3D "0.21.0"
> +source =3D "registry+https://github.com/rust-lang/crates.io-index"
> +checksum =3D "8a30b2e23b9e17a9f90641c7ab1549cd9b44f296d3ccbf309d2863cfe3=
98a0cb"
> +dependencies =3D [
> + "gimli",
> +]
> +
> +[[package]]
> +name =3D "adler"
> +version =3D "1.0.2"
> +source =3D "registry+https://github.com/rust-lang/crates.io-index"
> +checksum =3D "f26201604c87b1e01bd3d98f8d5d9a8fcbb815e8cedb41ffccbeb4bf59=
3a35fe"
> +
>  [[package]]
>  name =3D "aho-corasick"
>  version =3D "1.1.3"
> @@ -60,6 +75,33 @@ dependencies =3D [
>   "windows-sys",
>  ]
> =20
> +[[package]]
> +name =3D "backtrace"
> +version =3D "0.3.71"
> +source =3D "registry+https://github.com/rust-lang/crates.io-index"
> +checksum =3D "26b05800d2e817c8b3b4b54abd461726265fa9789ae34330622f2db9ee=
696f9d"
> +dependencies =3D [
> + "addr2line",
> + "cc",
> + "cfg-if",
> + "libc",
> + "miniz_oxide",
> + "object",
> + "rustc-demangle",
> +]
> +
> +[[package]]
> +name =3D "cc"
> +version =3D "1.0.98"
> +source =3D "registry+https://github.com/rust-lang/crates.io-index"
> +checksum =3D "41c270e7540d725e65ac7f1b212ac8ce349719624d7bcff99f8e2e488e=
8cf03f"
> +
> +[[package]]
> +name =3D "cfg-if"
> +version =3D "1.0.0"
> +source =3D "registry+https://github.com/rust-lang/crates.io-index"
> +checksum =3D "baf1de4339761588bc0619e3cbc0120ee582ebb74b53b4efbf79117bd2=
da40fd"
> +
>  [[package]]
>  name =3D "clap"
>  version =3D "4.5.4"
> @@ -93,18 +135,48 @@ version =3D "1.0.1"
>  source =3D "registry+https://github.com/rust-lang/crates.io-index"
>  checksum =3D "0b6a852b24ab71dffc585bcb46eaf7959d175cb865a7152e35b348d1b2=
960422"
> =20
> +[[package]]
> +name =3D "gimli"
> +version =3D "0.28.1"
> +source =3D "registry+https://github.com/rust-lang/crates.io-index"
> +checksum =3D "4271d37baee1b8c7e4b708028c57d816cf9d2434acb33a549475f78c18=
1f6253"
> +
>  [[package]]
>  name =3D "is_terminal_polyfill"
>  version =3D "1.70.0"
>  source =3D "registry+https://github.com/rust-lang/crates.io-index"
>  checksum =3D "f8478577c03552c21db0e2724ffb8986a5ce7af88107e6be5d2ee6e158=
c12800"
> =20
> +[[package]]
> +name =3D "libc"
> +version =3D "0.2.155"
> +source =3D "registry+https://github.com/rust-lang/crates.io-index"
> +checksum =3D "97b3888a4aecf77e811145cadf6eef5901f4782c53886191b2f693f247=
61847c"
> +
>  [[package]]
>  name =3D "memchr"
>  version =3D "2.7.2"
>  source =3D "registry+https://github.com/rust-lang/crates.io-index"
>  checksum =3D "6c8640c5d730cb13ebd907d8d04b52f55ac9a2eec55b440c8892f40d56=
c76c1d"
> =20
> +[[package]]
> +name =3D "miniz_oxide"
> +version =3D "0.7.3"
> +source =3D "registry+https://github.com/rust-lang/crates.io-index"
> +checksum =3D "87dfd01fe195c66b572b37921ad8803d010623c0aca821bea2302239d1=
55cdae"
> +dependencies =3D [
> + "adler",
> +]
> +
> +[[package]]
> +name =3D "object"
> +version =3D "0.32.2"
> +source =3D "registry+https://github.com/rust-lang/crates.io-index"
> +checksum =3D "a6a622008b6e321afc04970976f62ee297fdbaa6f95318ca343e3eebb9=
648441"
> +dependencies =3D [
> + "memchr",
> +]
> +
>  [[package]]
>  name =3D "once_cell"
>  version =3D "1.19.0"
> @@ -158,10 +230,17 @@ version =3D "0.8.3"
>  source =3D "registry+https://github.com/rust-lang/crates.io-index"
>  checksum =3D "adad44e29e4c806119491a7f06f03de4d1af22c3a680dd47f1e6e17943=
9d1f56"
> =20
> +[[package]]
> +name =3D "rustc-demangle"
> +version =3D "0.1.24"
> +source =3D "registry+https://github.com/rust-lang/crates.io-index"
> +checksum =3D "719b953e2095829ee67db738b3bfa9fa368c94900df327b3f07fe6e794=
d2fe1f"
> +
>  [[package]]
>  name =3D "simpletrace-rust"
>  version =3D "0.1.0"
>  dependencies =3D [
> + "backtrace",
>   "clap",
>   "once_cell",
>   "regex",
> diff --git a/scripts/simpletrace-rust/Cargo.toml b/scripts/simpletrace-ru=
st/Cargo.toml
> index 24a79d04e566..23a3179de01c 100644
> --- a/scripts/simpletrace-rust/Cargo.toml
> +++ b/scripts/simpletrace-rust/Cargo.toml
> @@ -7,7 +7,11 @@ authors =3D ["Zhao Liu <zhao1.liu@intel.com>"]
>  license =3D "GPL-2.0-or-later"
> =20
>  [dependencies]
> +backtrace =3D "0.3"
>  clap =3D "4.5.4"
>  once_cell =3D "1.19.0"
>  regex =3D "1.10.4"
>  thiserror =3D "1.0.20"
> +
> +[profile.release]
> +debug =3D "line-tables-only"
> diff --git a/scripts/simpletrace-rust/src/main.rs b/scripts/simpletrace-r=
ust/src/main.rs
> index b3b8baee7c66..f9a71d8dc243 100644
> --- a/scripts/simpletrace-rust/src/main.rs
> +++ b/scripts/simpletrace-rust/src/main.rs
> @@ -13,17 +13,24 @@
> =20
>  mod trace;
> =20
> +use std::collections::HashMap;
>  use std::env;
>  use std::fs::File;
>  use std::io::Error as IOError;
>  use std::io::ErrorKind;
>  use std::io::Read;
> +use std::mem::size_of;
> =20
> +use backtrace::Backtrace;
>  use clap::Arg;
>  use clap::Command;
>  use thiserror::Error;
>  use trace::Event;
> =20
> +const DROPPED_EVENT_ID: u64 =3D 0xfffffffffffffffe;
> +const HEADER_MAGIC: u64 =3D 0xf2b177cb0aa429b4;
> +const HEADER_EVENT_ID: u64 =3D 0xffffffffffffffff;
> +
>  const RECORD_TYPE_MAPPING: u64 =3D 0;
>  const RECORD_TYPE_EVENT: u64 =3D 1;
> =20
> @@ -32,10 +39,25 @@ pub enum Error
>  {
>      #[error("usage: {0} [--no-header] <trace-events> <trace-file>")]
>      CliOptionUnmatch(String),
> +    #[error("Invalid event name ({0})")]
> +    InvalidEventName(String),
> +    #[error("Not a valid trace file, header id {0} !=3D {1}")]
> +    InvalidHeaderId(u64, u64),
> +    #[error("Not a valid trace file, header magic {0} !=3D {1}")]
> +    InvalidHeaderMagic(u64, u64),
>      #[error("Failed to read file: {0}")]
>      ReadFile(IOError),
> +    #[error(
> +        "event {0} is logged but is not declared in the trace events \
> +        file, try using trace-events-all instead."
> +    )]
> +    UnknownEvent(String),
>      #[error("Unknown record type ({0})")]
>      UnknownRecType(u64),
> +    #[error("Unknown version {0} of tracelog format!")]
> +    UnknownVersion(u64),
> +    #[error("Log format {0} not supported with this QEMU release!")]
> +    UnsupportedVersion(u64),
>  }
> =20
>  pub type Result<T> =3D std::result::Result<T, Error>;
> @@ -98,19 +120,22 @@ struct LogHeader
>      version: u64,
>  }
> =20
> +const LOG_HDR_LEN: usize =3D size_of::<LogHeader>();
> +
>  impl ReadHeader for LogHeader
>  {
>      fn read_header(mut fobj: &File) -> Result<Self>
>      {
> -        let mut raw_hdr =3D [0u8; 24];
> +        let mut raw_hdr =3D [0u8; LOG_HDR_LEN];
>          fobj.read_exact(&mut raw_hdr).map_err(Error::ReadFile)?;
> =20
>          /*
>           * Safe because the size of log header (struct LogHeader)
>           * is 24 bytes, which is ensured by simple trace backend.
>           */
> -        let hdr =3D
> -            unsafe { std::mem::transmute::<[u8; 24], LogHeader>(raw_hdr)=
 };
> +        let hdr =3D unsafe {
> +            std::mem::transmute::<[u8; LOG_HDR_LEN], LogHeader>(raw_hdr)
> +        };
>          Ok(hdr)
>      }
>  }
> @@ -142,6 +167,8 @@ struct RecordHeader
>      record_pid: u32,
>  }
> =20
> +const REC_HDR_LEN: usize =3D size_of::<RecordHeader>();
> +
>  impl RecordHeader
>  {
>      fn extract_record(&self, mut fobj: &File) -> Result<RecordInfo>
> @@ -167,20 +194,232 @@ impl ReadHeader for RecordHeader
>  {
>      fn read_header(mut fobj: &File) -> Result<Self>
>      {
> -        let mut raw_hdr =3D [0u8; 24];
> +        let mut raw_hdr =3D [0u8; REC_HDR_LEN];
>          fobj.read_exact(&mut raw_hdr).map_err(Error::ReadFile)?;
> =20
>          /*
>           * Safe because the size of record header (struct RecordHeader)
>           * is 24 bytes, which is ensured by simple trace backend.
>           */
> -        let hdr: RecordHeader =3D
> -            unsafe { std::mem::transmute::<[u8; 24], RecordHeader>(raw_h=
dr) };
> +        let hdr: RecordHeader =3D unsafe {
> +            std::mem::transmute::<[u8; REC_HDR_LEN], RecordHeader>(raw_h=
dr)
> +        };
>          Ok(hdr)
>      }
>  }
> =20
> -pub struct EventArgPayload {}
> +#[derive(Clone)]
> +pub struct EventArgPayload
> +{
> +    raw_val: Option<u64>,
> +    raw_str: Option<String>,
> +}
> +
> +impl EventArgPayload
> +{
> +    fn new(raw_val: Option<u64>, raw_str: Option<String>) -> Self
> +    {
> +        EventArgPayload { raw_val, raw_str }
> +    }
> +
> +    fn get_payload_str(
> +        offset: &mut usize,
> +        args_payload: &[u8],
> +    ) -> Result<EventArgPayload>
> +    {
> +        let length =3D u32::from_le_bytes(
> +            args_payload[*offset..(*offset + 4)].try_into().unwrap(),
> +        );
> +        *offset +=3D 4;
> +        let raw_str: &[u8] =3D args_payload
> +            .get(*offset..(*offset + length as usize))
> +            .unwrap();
> +        *offset +=3D length as usize;
> +        Ok(EventArgPayload::new(
> +            None,
> +            Some(String::from_utf8_lossy(raw_str).into_owned()),
> +        ))
> +    }
> +
> +    fn get_payload_val(
> +        offset: &mut usize,
> +        args_payload: &[u8],
> +    ) -> Result<EventArgPayload>
> +    {
> +        let raw_val =3D u64::from_le_bytes(
> +            args_payload[*offset..(*offset + 8)].try_into().unwrap(),
> +        );
> +        *offset +=3D 8;
> +        Ok(EventArgPayload::new(Some(raw_val), None))
> +    }
> +}
> +
> +#[derive(Clone)]
> +struct EventEntry
> +{
> +    event: Event,
> +    event_id: u64,
> +    timestamp_ns: u64,
> +    record_pid: u32,
> +    rec_args: Vec<EventArgPayload>,
> +}
> +
> +impl EventEntry
> +{
> +    fn new(
> +        event: &Event,
> +        event_id: u64,
> +        timestamp_ns: u64,
> +        record_pid: u32,
> +    ) -> Self
> +    {
> +        EventEntry {
> +            event: event.clone(),
> +            event_id,
> +            timestamp_ns,
> +            record_pid,
> +            rec_args: Vec::new(),
> +        }
> +    }
> +}
> +
> +fn get_mapping(mut fobj: &File) -> Result<(u64, String)>
> +{
> +    let mut event_id_buf =3D [0u8; 8];
> +    fobj.read_exact(&mut event_id_buf)
> +        .map_err(Error::ReadFile)?;
> +    let event_id =3D u64::from_le_bytes(event_id_buf);
> +
> +    let mut len_buf =3D [0u8; 4];
> +    fobj.read_exact(&mut len_buf).map_err(Error::ReadFile)?;
> +
> +    let len =3D u32::from_le_bytes(len_buf);
> +    let mut name_buf =3D vec![0u8; len as usize];
> +    fobj.read_exact(&mut name_buf).map_err(Error::ReadFile)?;
> +    let name =3D String::from_utf8(name_buf.clone())
> +        .map_err(|_| Error::InvalidEventName(format!("{:?}", name_buf)))=
?;
> +
> +    Ok((event_id, name))
> +}
> +
> +fn read_record(fobj: &File) -> Result<RecordInfo>
> +{
> +    let hdr =3D RecordHeader::read_header(fobj)?;
> +    let info =3D hdr.extract_record(fobj)?;
> +    Ok(info)
> +}
> +
> +fn read_trace_header(fobj: &File) -> Result<()>
> +{
> +    let log_hdr =3D LogHeader::read_header(fobj)?;
> +    if log_hdr.event_id !=3D HEADER_EVENT_ID {
> +        return Err(Error::InvalidHeaderId(log_hdr.event_id, HEADER_EVENT=
_ID));
> +    }
> +    if log_hdr.magic !=3D HEADER_MAGIC {
> +        return Err(Error::InvalidHeaderMagic(log_hdr.magic, HEADER_MAGIC=
));
> +    }
> +    if ![0, 2, 3, 4].contains(&(log_hdr.version as i64)) {
> +        return Err(Error::UnknownVersion(log_hdr.version));
> +    }
> +    if log_hdr.version !=3D 4 {
> +        return Err(Error::UnsupportedVersion(log_hdr.version));
> +    }
> +    Ok(())
> +}
> +
> +fn read_trace_records(
> +    events: &Vec<Event>,
> +    fobj: &File,
> +    analyzer: &mut Formatter,
> +    read_header: bool,
> +) -> Result<Vec<String>>
> +{
> +    /* backtrace::Backtrace needs this env variable. */
> +    env::set_var("RUST_BACKTRACE", "1");
> +    let bt =3D Backtrace::new();
> +    let raw_frame =3D bt.frames().first().unwrap();
> +    let frameinfo =3D raw_frame.symbols().first().unwrap();
> +
> +    let dropped_event =3D Event::build(
> +        "Dropped_Event(uint64_t num_events_dropped)",
> +        frameinfo.lineno().unwrap() + 1,
> +        frameinfo.filename().unwrap().to_str().unwrap(),
> +    )
> +    .unwrap();

Is the backtrace necessary? This trick was used in Python where it's
part of the standard library, but I don't think there is any need for
Dropped_Event to refer to this line in the source code.

Maybe Rust has a way to do this at compile-time or you can hardcode
values instead.

> +
> +    let mut event_mapping =3D HashMap::new();
> +    for e in events {
> +        event_mapping.insert(e.name.clone(), e.clone());
> +    }
> +
> +    let drop_str =3D "dropped".to_string();
> +    event_mapping.insert(drop_str.clone(), dropped_event.clone());
> +    let mut event_id_to_name: HashMap<u64, String> =3D HashMap::new();
> +    event_id_to_name.insert(DROPPED_EVENT_ID, drop_str.clone());
> +
> +    if !read_header {
> +        for (event_id, event) in events.iter().enumerate() {
> +            event_id_to_name.insert(event_id as u64, event.name.clone());
> +        }
> +    }
> +
> +    let mut fmt_strs =3D Vec::new();
> +    loop {
> +        let rtype =3D RecordType::read_type(fobj)?;
> +        match rtype {
> +            RecordType::Empty =3D> {
> +                break;
> +            }
> +            RecordType::Mapping =3D> {
> +                let (event_id, event_name) =3D
> +                    get_mapping(fobj).expect("Error reading mapping");
> +                event_id_to_name.insert(event_id, event_name);
> +                continue;
> +            }
> +            RecordType::Event =3D> {
> +                let rec =3D read_record(fobj).expect("Error reading reco=
rd");
> +                let event_name =3D
> +                    event_id_to_name.get(&rec.event_id).unwrap().to_stri=
ng();
> +                let event =3D event_mapping
> +                    .get(&event_name)
> +                    .ok_or(Error::UnknownEvent(event_name))?;
> +
> +                let mut entry =3D EventEntry::new(
> +                    event,
> +                    rec.event_id,
> +                    rec.timestamp_ns,
> +                    rec.record_pid,
> +                );
> +                let mut offset =3D 0;
> +
> +                for arg in &event.args.props {
> +                    let payload =3D if arg.is_string() {
> +                        EventArgPayload::get_payload_str(
> +                            &mut offset,
> +                            &rec.args_payload,
> +                        )?
> +                    } else {
> +                        EventArgPayload::get_payload_val(
> +                            &mut offset,
> +                            &rec.args_payload,
> +                        )?
> +                    };
> +                    entry.rec_args.push(payload);
> +                }
> +
> +                let fmt =3D analyzer.process_event(
> +                    &entry.rec_args,
> +                    &entry.event,
> +                    entry.event_id,
> +                    entry.timestamp_ns,
> +                    entry.record_pid,
> +                )?;
> +                fmt_strs.push(fmt);
> +            }
> +        }
> +    }
> +    Ok(fmt_strs)
> +}
> =20
>  trait Analyzer
>  {
> --=20
> 2.34.1
>=20

--mcc/3NXhJlZJglzb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmZU8JYACgkQnKSrs4Gr
c8gwngf/ZxDjs/1rtZDsUue0bRz45a0Qrte34ToZGCefX/voqqoLYOVHoBy9+H3H
Sf3i8g28ploK4Ptgqda27aPZb2psKVwgtIFLuZjUKHI4/4okSGamo3h5Ny47sQ0s
CBce8tsUrmosuakw3Y/2+f8gYlN//aNq37kqb1KCLIPZ3PbdMWPFqxSvK9Os5wR2
zCXXSSkGzxEeX2lUHrkIJ3/0aEYu5djsnO2z4jhTWLWDZGFmvIpdZmAZ1Qa5QUBl
R2A+3eGSgfblTZDZMrozUMoDsfpQaWhrvjQ0Ze2PBFziLMfYZSttCxJQUC7hAlGx
eadl6Qt0W0ODphmk3v4lWcnMLMBpCQ==
=hrf0
-----END PGP SIGNATURE-----

--mcc/3NXhJlZJglzb--


