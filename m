Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F05E5C25B78
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 08:17:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBs1L-0004Tx-13; Tue, 28 May 2024 04:17:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sBs1K-0004Sj-1T
 for qemu-devel@nongnu.org; Tue, 28 May 2024 04:17:22 -0400
Received: from mgamail.intel.com ([192.198.163.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sBs1H-0001JA-L3
 for qemu-devel@nongnu.org; Tue, 28 May 2024 04:17:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1716884239; x=1748420239;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=lzRMQCT7nh2jOkyQciCKW7j96lmjebcgs0E+j5HqTqI=;
 b=TqCaEUvkikbX00YM7TPBHE7nGfZAlecjuh6VTZtr2X8/LQETeT/cd+w2
 Z36tNV5jrcI+fNt6AkcsfwQBvEcLHbrpAu9tb7EQLh2shEFoq2rW9MTLC
 gEGEBq/OiIAP25I1kMyhBfaLJuKkP7AAy0u7FTOHrkNUpf0hn4mD34p8f
 J5aQBIzOk+RmZ44YZ6WwYUuQ8FiP2ZYDaK0xNFxgSZ7iDYzGaerj4i2qe
 PQRHL0aASxlir48DnSXjMRni0xSmUQjIZb585K0TdNWXYFHZjgzeSqtdS
 3tmmu6KtW+LgA/B3e8W/X4YW7RuBUTwv/4cXOGnuqugy0CTx0QF7DiM1/ w==;
X-CSE-ConnectionGUID: dpSHdFpzREGHdOp7s/iT6w==
X-CSE-MsgGUID: 01TeV9RyS/Kr4A33cvUtgw==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="13039379"
X-IronPort-AV: E=Sophos;i="6.08,194,1712646000"; d="scan'208";a="13039379"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 May 2024 01:17:14 -0700
X-CSE-ConnectionGUID: XdKnxtI5Ryay6JpHWcJvgg==
X-CSE-MsgGUID: tGGCnmqoRFWRX1Eby1395w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,194,1712646000"; d="scan'208";a="39525182"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa004.fm.intel.com with ESMTP; 28 May 2024 01:17:12 -0700
Date: Tue, 28 May 2024 16:32:30 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Mads Ynddal <mads@ynddal.dk>, Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?B?TWF0aGlldS1EYXVk77+9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alex =?utf-8?B?QmVubu+/vWU=?= <alex.bennee@linaro.org>,
 Daniel P =?utf-8?B?LiBCZXJyYW5n77+9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [RFC 2/6] scripts/simpletrace-rust: Support Event & Arguments in
 trace module
Message-ID: <ZlWWnrwkipaq8x7n@intel.com>
References: <20240527081421.2258624-1-zhao1.liu@intel.com>
 <20240527081421.2258624-3-zhao1.liu@intel.com>
 <20240527203312.GC913874@fedora.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240527203312.GC913874@fedora.redhat.com>
Received-SPF: pass client-ip=192.198.163.19; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.034,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

> > +/*
> > + * Refer to the description of ALLOWED_TYPES in
> > + * scripts/tracetool/__init__.py.
> 
> Please don't reference the Python implementation because this will not
> age well. It may bitrot if the Python code changes or if the Python
> implementation is deprecated then the source file will go away
> altogether. Make the Rust implementation self-contained. If there are
> common file format concerns shared by implementations, then move that
> information to a separate document in docs/interop/ (i.e. a simpletrace
> file format specification).

Thanks for your guidance, will do.

> > + */
> > +const ALLOWED_TYPES: [&str; 20] = [
> > +    "int",
> > +    "long",
> > +    "short",
> > +    "char",
> > +    "bool",
> > +    "unsigned",
> > +    "signed",
> > +    "int8_t",
> > +    "uint8_t",
> > +    "int16_t",
> > +    "uint16_t",
> > +    "int32_t",
> > +    "uint32_t",
> > +    "int64_t",
> > +    "uint64_t",
> > +    "void",
> > +    "size_t",
> > +    "ssize_t",
> > +    "uintptr_t",
> > +    "ptrdiff_t",
> > +];
> > +
> > +const STRING_TYPES: [&str; 4] =
> > +    ["const char*", "char*", "const char *", "char *"];
> > +
> > +/* TODO: Support 'vcpu' property. */
> 
> The vcpu property was removed in commit d9a6bad542cd ("docs: remove
> references to TCG tracing"). Is this comment outdated or are you
> planning to bring it back?

Thanks! I have no plan for this, I just follow _VALID_PROPS[] in
scripts/tracetool/__init__.py. As you commented above, I think I should
just ignore it. ;-)

> > +const VALID_PROPS: [&str; 1] = ["disable"];

[snip]

> > +    pub fn build(arg_str: &str) -> Result<Arguments>
> > +    {
> > +        let mut args = Arguments::new();
> > +        for arg in arg_str.split(',').map(|s| s.trim()) {
> > +            if arg.is_empty() {
> > +                return Err(Error::EmptyArg);
> > +            }
> > +
> > +            if arg == "void" {
> > +                continue;
> > +            }
> > +
> > +            let (arg_type, identifier) = if arg.contains('*') {
> > +                /* FIXME: Implement rsplit_inclusive(). */
> > +                let p = arg.rfind('*').unwrap();
> > +                (
> > +                    /* Safe because arg contains "*" and p exists. */
> > +                    unsafe { arg.get_unchecked(..p + 1) },
> > +                    /* Safe because arg contains "*" and p exists. */
> > +                    unsafe { arg.get_unchecked(p + 1..) },
> > +                )
> > +            } else {
> > +                arg.rsplit_once(' ').unwrap()
> > +            };
> 
> Can you write this without unsafe? Maybe rsplit_once(' ') followed by a
> check for (_, '*identifier'). If the identifier starts with '*', then
> arg_type += ' *' and identifier = identifier[1:].

Clever idea! It should work, will try this way.

> > +
> > +            validate_c_type(arg_type)?;
> > +            args.props.push(ArgProperty::new(arg_type, identifier));
> > +        }
> > +        Ok(args)
> > +    }
> > +}
> > +

[snip]

> > +    pub fn build(line_str: &str, lineno: u32, filename: &str) -> Result<Event>
> > +    {
> > +        static RE: Lazy<Regex> = Lazy::new(|| {
> > +            Regex::new(
> > +                r#"(?x)
> > +                ((?P<props>[\w\s]+)\s+)?
> > +                (?P<name>\w+)
> > +                \((?P<args>[^)]*)\)
> > +                \s*
> > +                (?:(?:(?P<fmt_trans>".+),)?\s*(?P<fmt>".+))?
> 
> What is the purpose of fmt_trans?
> 
> > +                \s*"#,
> > +            )
> > +            .unwrap()
> 
> I wonder if regular expressions help here. It's not easy to read this
> regex and there is a bunch of logic that takes apart the matches
> afterwards. It might even be clearer to use string methods to split
> fields.

Yes, regular matching is a burden here (it's a "lazy simplification" on
my part), and I'll think if it's possible to avoid regular matching with
string methods.

> Please add a comment showing the format that's being parsed:
> 
>  // [disable] <name>(<type1> <arg1>[, <type2> <arg2>] ...) "<format-string>"
> 

OK.

> > +        });
> > +
> > +        let caps_res = RE.captures(line_str);
> > +        if caps_res.is_none() {
> > +            return Err(Error::UnknownEvent(line_str.to_owned()));
> > +        }
> > +        let caps = caps_res.unwrap();
> > +        let name = caps.name("name").map_or("", |m| m.as_str());
> > +        let props: Vec<String> = if caps.name("props").is_some() {
> > +            caps.name("props")
> > +                .unwrap()
> > +                .as_str()
> > +                .split_whitespace()
> > +                .map(|s| s.to_string())
> > +                .collect()
> > +        } else {
> > +            Vec::new()
> > +        };
> > +        let fmt: String =
> > +            caps.name("fmt").map_or("", |m| m.as_str()).to_string();
> > +        let fmt_trans: String = caps
> > +            .name("fmt_trans")
> > +            .map_or("", |m| m.as_str())
> > +            .to_string();
> > +
> > +        if fmt.contains("%m") || fmt_trans.contains("%m") {
> > +            return Err(Error::InvalidFormat(
> > +                "Event format '%m' is forbidden, pass the error 
> > +                as an explicit trace argument"
> > +                    .to_string(),
> > +            ));
> > +        }
> 
> I'm not sure simpletrace needs to check this. That's a job for tracetool
> the build-time tool that generates code from trace-events files.

Thanks for the clarification, this item has bothered me before, I also
noticed that simpletrace doesn't use it, but don't feel confident about
deleting it completely, I'll clean it up!

> > +        if fmt.ends_with(r"\n") {
> > +            return Err(Error::InvalidFormat(
> > +                "Event format must not end with a newline 
> > +                character"
> > +                    .to_string(),
> > +            ));
> > +        }

Thanks,
Zhao


