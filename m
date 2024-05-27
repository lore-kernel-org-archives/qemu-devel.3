Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB709C25B79
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2024 20:34:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBh2K-0000KG-KW; Mon, 27 May 2024 16:33:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1sBh2E-0000JY-TM
 for qemu-devel@nongnu.org; Mon, 27 May 2024 16:33:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1sBh22-00056d-MT
 for qemu-devel@nongnu.org; Mon, 27 May 2024 16:33:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716842001;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=odPugm8THSPqYf4f5tU+1/qNMwqcxkJzHWmKYpxKtuU=;
 b=QZIu8PBI1UBwHb4FTILUdxIn7Hd7QHZcnc6dLumWAX0nN6vdcWIUl+qgjo5TLNo3Q2NJ1z
 W7IPNZ1xQ+SbSL55rRmRKQ3BKqvbu6gdjWB6wxkPS5rUQKkQSM+yhf8NDwkXecRoIAbjo8
 wAUABzI2JE1twZoLSSRRU+unNwx3C1w=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-35-VyTtkqFsMvqUxOpGRQ_OAQ-1; Mon, 27 May 2024 16:33:15 -0400
X-MC-Unique: VyTtkqFsMvqUxOpGRQ_OAQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 322D2800169;
 Mon, 27 May 2024 20:33:15 +0000 (UTC)
Received: from localhost (unknown [10.39.195.38])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 824A8492BC6;
 Mon, 27 May 2024 20:33:14 +0000 (UTC)
Date: Mon, 27 May 2024 16:33:12 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Zhao Liu <zhao1.liu@intel.com>
Cc: Mads Ynddal <mads@ynddal.dk>, Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [RFC 2/6] scripts/simpletrace-rust: Support Event & Arguments in
 trace module
Message-ID: <20240527203312.GC913874@fedora.redhat.com>
References: <20240527081421.2258624-1-zhao1.liu@intel.com>
 <20240527081421.2258624-3-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="BscPGuPHrykh5EYM"
Content-Disposition: inline
In-Reply-To: <20240527081421.2258624-3-zhao1.liu@intel.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.034,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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


--BscPGuPHrykh5EYM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 27, 2024 at 04:14:17PM +0800, Zhao Liu wrote:
> Refer to scripts/tracetool/__init__.py, add Event & Arguments
> abstractions in trace module.
>=20
> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> ---
>  scripts/simpletrace-rust/Cargo.lock   |  52 ++++
>  scripts/simpletrace-rust/Cargo.toml   |   2 +
>  scripts/simpletrace-rust/src/trace.rs | 330 +++++++++++++++++++++++++-
>  3 files changed, 383 insertions(+), 1 deletion(-)
>=20
> diff --git a/scripts/simpletrace-rust/Cargo.lock b/scripts/simpletrace-ru=
st/Cargo.lock
> index 4a0ff8092dcb..3d815014eb44 100644
> --- a/scripts/simpletrace-rust/Cargo.lock
> +++ b/scripts/simpletrace-rust/Cargo.lock
> @@ -2,6 +2,15 @@
>  # It is not intended for manual editing.
>  version =3D 3
> =20
> +[[package]]
> +name =3D "aho-corasick"
> +version =3D "1.1.3"
> +source =3D "registry+https://github.com/rust-lang/crates.io-index"
> +checksum =3D "8e60d3430d3a69478ad0993f19238d2df97c507009a52b3c10addcd7f6=
bcb916"
> +dependencies =3D [
> + "memchr",
> +]
> +
>  [[package]]
>  name =3D "anstream"
>  version =3D "0.6.14"
> @@ -90,6 +99,18 @@ version =3D "1.70.0"
>  source =3D "registry+https://github.com/rust-lang/crates.io-index"
>  checksum =3D "f8478577c03552c21db0e2724ffb8986a5ce7af88107e6be5d2ee6e158=
c12800"
> =20
> +[[package]]
> +name =3D "memchr"
> +version =3D "2.7.2"
> +source =3D "registry+https://github.com/rust-lang/crates.io-index"
> +checksum =3D "6c8640c5d730cb13ebd907d8d04b52f55ac9a2eec55b440c8892f40d56=
c76c1d"
> +
> +[[package]]
> +name =3D "once_cell"
> +version =3D "1.19.0"
> +source =3D "registry+https://github.com/rust-lang/crates.io-index"
> +checksum =3D "3fdb12b2476b595f9358c5161aa467c2438859caa136dec86c26fdd2ef=
e17b92"
> +
>  [[package]]
>  name =3D "proc-macro2"
>  version =3D "1.0.83"
> @@ -108,11 +129,42 @@ dependencies =3D [
>   "proc-macro2",
>  ]
> =20
> +[[package]]
> +name =3D "regex"
> +version =3D "1.10.4"
> +source =3D "registry+https://github.com/rust-lang/crates.io-index"
> +checksum =3D "c117dbdfde9c8308975b6a18d71f3f385c89461f7b3fb054288ecf2a20=
58ba4c"
> +dependencies =3D [
> + "aho-corasick",
> + "memchr",
> + "regex-automata",
> + "regex-syntax",
> +]
> +
> +[[package]]
> +name =3D "regex-automata"
> +version =3D "0.4.6"
> +source =3D "registry+https://github.com/rust-lang/crates.io-index"
> +checksum =3D "86b83b8b9847f9bf95ef68afb0b8e6cdb80f498442f5179a29fad448fc=
c1eaea"
> +dependencies =3D [
> + "aho-corasick",
> + "memchr",
> + "regex-syntax",
> +]
> +
> +[[package]]
> +name =3D "regex-syntax"
> +version =3D "0.8.3"
> +source =3D "registry+https://github.com/rust-lang/crates.io-index"
> +checksum =3D "adad44e29e4c806119491a7f06f03de4d1af22c3a680dd47f1e6e17943=
9d1f56"
> +
>  [[package]]
>  name =3D "simpletrace-rust"
>  version =3D "0.1.0"
>  dependencies =3D [
>   "clap",
> + "once_cell",
> + "regex",
>   "thiserror",
>  ]
> =20
> diff --git a/scripts/simpletrace-rust/Cargo.toml b/scripts/simpletrace-ru=
st/Cargo.toml
> index b44ba1569dad..24a79d04e566 100644
> --- a/scripts/simpletrace-rust/Cargo.toml
> +++ b/scripts/simpletrace-rust/Cargo.toml
> @@ -8,4 +8,6 @@ license =3D "GPL-2.0-or-later"
> =20
>  [dependencies]
>  clap =3D "4.5.4"
> +once_cell =3D "1.19.0"
> +regex =3D "1.10.4"
>  thiserror =3D "1.0.20"
> diff --git a/scripts/simpletrace-rust/src/trace.rs b/scripts/simpletrace-=
rust/src/trace.rs
> index 3a4b06435b8b..f41d6e0b5bc3 100644
> --- a/scripts/simpletrace-rust/src/trace.rs
> +++ b/scripts/simpletrace-rust/src/trace.rs
> @@ -8,4 +8,332 @@
>   * SPDX-License-Identifier: GPL-2.0-or-later
>   */
> =20
> -pub struct Event {}
> +#![allow(dead_code)]
> +
> +use std::fs::read_to_string;
> +
> +use once_cell::sync::Lazy;
> +use regex::Regex;
> +use thiserror::Error;
> +
> +#[derive(Error, Debug)]
> +pub enum Error
> +{
> +    #[error("Empty argument (did you forget to use 'void'?)")]
> +    EmptyArg,
> +    #[error("Event '{0}' has more than maximum permitted argument count"=
)]
> +    InvalidArgCnt(String),
> +    #[error("{0} does not end with a new line")]
> +    InvalidEventFile(String),
> +    #[error("Invalid format: {0}")]
> +    InvalidFormat(String),
> +    #[error(
> +        "Argument type '{0}' is not allowed. \
> +        Only standard C types and fixed size integer \
> +        types should be used. struct, union, and \
> +        other complex pointer types should be \
> +        declared as 'void *'"
> +    )]
> +    InvalidType(String),
> +    #[error("Error at {0}:{1}: {2}")]
> +    ReadEventFail(String, usize, String),
> +    #[error("Unknown event: {0}")]
> +    UnknownEvent(String),
> +    #[error("Unknown properties: {0}")]
> +    UnknownProp(String),
> +}
> +
> +pub type Result<T> =3D std::result::Result<T, Error>;
> +
> +/*
> + * Refer to the description of ALLOWED_TYPES in
> + * scripts/tracetool/__init__.py.

Please don't reference the Python implementation because this will not
age well. It may bitrot if the Python code changes or if the Python
implementation is deprecated then the source file will go away
altogether. Make the Rust implementation self-contained. If there are
common file format concerns shared by implementations, then move that
information to a separate document in docs/interop/ (i.e. a simpletrace
file format specification).

> + */
> +const ALLOWED_TYPES: [&str; 20] =3D [
> +    "int",
> +    "long",
> +    "short",
> +    "char",
> +    "bool",
> +    "unsigned",
> +    "signed",
> +    "int8_t",
> +    "uint8_t",
> +    "int16_t",
> +    "uint16_t",
> +    "int32_t",
> +    "uint32_t",
> +    "int64_t",
> +    "uint64_t",
> +    "void",
> +    "size_t",
> +    "ssize_t",
> +    "uintptr_t",
> +    "ptrdiff_t",
> +];
> +
> +const STRING_TYPES: [&str; 4] =3D
> +    ["const char*", "char*", "const char *", "char *"];
> +
> +/* TODO: Support 'vcpu' property. */

The vcpu property was removed in commit d9a6bad542cd ("docs: remove
references to TCG tracing"). Is this comment outdated or are you
planning to bring it back?

> +const VALID_PROPS: [&str; 1] =3D ["disable"];
> +
> +fn validate_c_type(arg_type: &str) -> Result<()>
> +{
> +    static RE_TYPE: Lazy<Regex> =3D Lazy::new(|| Regex::new(r"\*").unwra=
p());
> +    let bits: Vec<String> =3D
> +        arg_type.split_whitespace().map(|s| s.to_string()).collect();
> +    for bit in bits {
> +        let res =3D RE_TYPE.replace_all(&bit, "");
> +        if res.is_empty() {
> +            continue;
> +        }
> +        if res =3D=3D "const" {
> +            continue;
> +        }
> +        if !ALLOWED_TYPES.contains(&res.as_ref()) {
> +            return Err(Error::InvalidType(res.to_string()));
> +        }
> +    }
> +    Ok(())
> +}
> +
> +pub fn read_events(fname: &str) -> Result<Vec<Event>>
> +{
> +    let fstr =3D read_to_string(fname).unwrap();
> +    let lines =3D fstr.lines().map(|s| s.trim()).collect::<Vec<_>>();
> +    let mut events =3D Vec::new();
> +
> +    /*
> +     * lines() in Rust: Line terminators are not included in the lines
> +     * returned by the iterator, so check whether line_str is empty.
> +     */
> +    for (lineno, line_str) in lines.iter().enumerate() {
> +        if line_str.is_empty() || line_str.starts_with('#') {
> +            continue;
> +        }
> +
> +        let event =3D Event::build(line_str, lineno as u32 + 1, fname);
> +        if let Err(e) =3D event {
> +            return Err(Error::ReadEventFail(
> +                fname.to_owned(),
> +                lineno,
> +                e.to_string(),
> +            ));
> +        } else {
> +            events.push(event.unwrap());
> +        }
> +    }
> +
> +    Ok(events)
> +}
> +
> +#[derive(Clone)]
> +pub struct ArgProperty
> +{
> +    pub c_type: String,
> +    pub name: String,
> +}
> +
> +impl ArgProperty
> +{
> +    fn new(c_type: &str, name: &str) -> Self
> +    {
> +        ArgProperty {
> +            c_type: c_type.to_string(),
> +            name: name.to_string(),
> +        }
> +    }
> +
> +    pub fn is_string(&self) -> bool
> +    {
> +        let arg_strip =3D self.c_type.trim_start();
> +        STRING_TYPES.iter().any(|&s| arg_strip.starts_with(s))
> +            && arg_strip.matches('*').count() =3D=3D 1
> +    }
> +}
> +
> +#[derive(Default, Clone)]
> +pub struct Arguments
> +{
> +    /* List of (type, name) tuples or arguments properties. */
> +    pub props: Vec<ArgProperty>,
> +}
> +
> +impl Arguments
> +{
> +    pub fn new() -> Self
> +    {
> +        Arguments { props: Vec::new() }
> +    }
> +
> +    pub fn len(&self) -> usize
> +    {
> +        self.props.len()
> +    }
> +
> +    pub fn build(arg_str: &str) -> Result<Arguments>
> +    {
> +        let mut args =3D Arguments::new();
> +        for arg in arg_str.split(',').map(|s| s.trim()) {
> +            if arg.is_empty() {
> +                return Err(Error::EmptyArg);
> +            }
> +
> +            if arg =3D=3D "void" {
> +                continue;
> +            }
> +
> +            let (arg_type, identifier) =3D if arg.contains('*') {
> +                /* FIXME: Implement rsplit_inclusive(). */
> +                let p =3D arg.rfind('*').unwrap();
> +                (
> +                    /* Safe because arg contains "*" and p exists. */
> +                    unsafe { arg.get_unchecked(..p + 1) },
> +                    /* Safe because arg contains "*" and p exists. */
> +                    unsafe { arg.get_unchecked(p + 1..) },
> +                )
> +            } else {
> +                arg.rsplit_once(' ').unwrap()
> +            };

Can you write this without unsafe? Maybe rsplit_once(' ') followed by a
check for (_, '*identifier'). If the identifier starts with '*', then
arg_type +=3D ' *' and identifier =3D identifier[1:].

> +
> +            validate_c_type(arg_type)?;
> +            args.props.push(ArgProperty::new(arg_type, identifier));
> +        }
> +        Ok(args)
> +    }
> +}
> +
> +/* TODO: Support original, event_trans, event_exec if needed. */
> +#[derive(Default, Clone)]
> +pub struct Event
> +{
> +    /* The event name. */
> +    pub name: String,
> +    /* Properties of the event. */
> +    pub properties: Vec<String>,
> +    /* The event format string. */
> +    pub fmt: Vec<String>,
> +    /* The event arguments. */
> +    pub args: Arguments,
> +    /* The line number in the input file. */
> +    pub lineno: u32,
> +    /* The path to the input file. */
> +    pub filename: String,
> +}
> +
> +impl Event
> +{
> +    #[allow(clippy::too_many_arguments)]
> +    pub fn new(
> +        name: &str,
> +        mut props: Vec<String>,
> +        fmt: Vec<String>,
> +        args: Arguments,
> +        lineno: u32,
> +        filename: &str,
> +    ) -> Result<Self>
> +    {
> +        let mut event =3D Event {
> +            name: name.to_string(),
> +            fmt: fmt.clone(),
> +            args,
> +            lineno,
> +            filename: filename.to_string(),
> +            ..Default::default()
> +        };
> +
> +        event.properties.append(&mut props);
> +
> +        if event.args.len() > 10 {
> +            return Err(Error::InvalidArgCnt(event.name));
> +        }
> +
> +        let unknown_props: Vec<String> =3D event
> +            .properties
> +            .iter()
> +            .filter_map(|p| {
> +                if !VALID_PROPS.contains(&p.as_str()) {
> +                    Some(p.to_string())
> +                } else {
> +                    None
> +                }
> +            })
> +            .collect();
> +        if !unknown_props.is_empty() {
> +            return Err(Error::UnknownProp(format!("{:?}", unknown_props)=
));
> +        }
> +
> +        if event.fmt.len() > 2 {
> +            return Err(Error::InvalidFormat(
> +                format!("too many arguments ({})", event.fmt.len()).to_s=
tring(),
> +            ));
> +        }
> +
> +        Ok(event)
> +    }
> +
> +    pub fn build(line_str: &str, lineno: u32, filename: &str) -> Result<=
Event>
> +    {
> +        static RE: Lazy<Regex> =3D Lazy::new(|| {
> +            Regex::new(
> +                r#"(?x)
> +                ((?P<props>[\w\s]+)\s+)?
> +                (?P<name>\w+)
> +                \((?P<args>[^)]*)\)
> +                \s*
> +                (?:(?:(?P<fmt_trans>".+),)?\s*(?P<fmt>".+))?

What is the purpose of fmt_trans?

> +                \s*"#,
> +            )
> +            .unwrap()

I wonder if regular expressions help here. It's not easy to read this
regex and there is a bunch of logic that takes apart the matches
afterwards. It might even be clearer to use string methods to split
fields.

Please add a comment showing the format that's being parsed:

 // [disable] <name>(<type1> <arg1>[, <type2> <arg2>] ...) "<format-string>"


> +        });
> +
> +        let caps_res =3D RE.captures(line_str);
> +        if caps_res.is_none() {
> +            return Err(Error::UnknownEvent(line_str.to_owned()));
> +        }
> +        let caps =3D caps_res.unwrap();
> +        let name =3D caps.name("name").map_or("", |m| m.as_str());
> +        let props: Vec<String> =3D if caps.name("props").is_some() {
> +            caps.name("props")
> +                .unwrap()
> +                .as_str()
> +                .split_whitespace()
> +                .map(|s| s.to_string())
> +                .collect()
> +        } else {
> +            Vec::new()
> +        };
> +        let fmt: String =3D
> +            caps.name("fmt").map_or("", |m| m.as_str()).to_string();
> +        let fmt_trans: String =3D caps
> +            .name("fmt_trans")
> +            .map_or("", |m| m.as_str())
> +            .to_string();
> +
> +        if fmt.contains("%m") || fmt_trans.contains("%m") {
> +            return Err(Error::InvalidFormat(
> +                "Event format '%m' is forbidden, pass the error=20
> +                as an explicit trace argument"
> +                    .to_string(),
> +            ));
> +        }

I'm not sure simpletrace needs to check this. That's a job for tracetool
the build-time tool that generates code from trace-events files.

> +        if fmt.ends_with(r"\n") {
> +            return Err(Error::InvalidFormat(
> +                "Event format must not end with a newline=20
> +                character"
> +                    .to_string(),
> +            ));
> +        }
> +        let mut fmt_vec =3D vec![fmt];
> +        if !fmt_trans.is_empty() {
> +            fmt_vec.push(fmt_trans);
> +        }
> +
> +        let args =3D
> +            Arguments::build(caps.name("args").map_or("", |m| m.as_str()=
))?;
> +        let event =3D Event::new(name, props, fmt_vec, args, lineno, fil=
ename)?;
> +
> +        Ok(event)
> +    }
> +}
> --=20
> 2.34.1
>=20

--BscPGuPHrykh5EYM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmZU7ggACgkQnKSrs4Gr
c8jHXQf/XHlOFpX55fQt5jivgQVZHHONV39P661YRY6Ir1Afm6xbiUr4CyBaDnEl
+hvwxwaT5mbUnIBny34SeJQEInJihwmiBqNV8mZDUeu93bYh+ytRIJMedeIDuLHy
FbeljUdrrq8rc3WA6V/MYQv0Gj6hMaSeTXiZjapXmN8444hfhfRqlZzvZxZidvec
iin3lRBVPCD0JyFGTEECQk106fscXUOIct1imQ14CBCtuvONPc+bqVKJ6PZgO9K2
hesiC3IuE2HX5mPc4v3uqv5qTRkvanlpdr1ftzyMhzlqM2tNRo1HG5SwvQLmKt01
/OfsM2E7eETV+xU9WHhENWSSoR7DMA==
=9KCp
-----END PGP SIGNATURE-----

--BscPGuPHrykh5EYM--


