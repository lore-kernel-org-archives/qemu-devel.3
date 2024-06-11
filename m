Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21EE5C27C5E
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2024 08:19:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sGwiL-0003dO-Ig; Tue, 11 Jun 2024 04:18:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sGwiJ-0003cs-UG
 for qemu-devel@nongnu.org; Tue, 11 Jun 2024 04:18:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sGwiH-0002CS-QL
 for qemu-devel@nongnu.org; Tue, 11 Jun 2024 04:18:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718093919;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=VVHAuFT0IMEmESZKU9qnNisekpHWEQ+THEqd7fnks8M=;
 b=ToqRrS4Sx+E0SsEDqgdyO581lypT4Ee0UWXX3bU5YdodyHx6bs0Fb/oqPB1queIdR8Ze7l
 QRRRTXOCLLXemX1Zt+cdCxgMXjhtUyFdrlEU40IRU9EHOZLsOE8lS4xVeMQJhw+w1gKttq
 O35HpaAEwcmrVr1ugAHXwbiDTFakHO8=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-531-XvytCqiGP7CcPRs0F4nNvQ-1; Tue,
 11 Jun 2024 04:18:35 -0400
X-MC-Unique: XvytCqiGP7CcPRs0F4nNvQ-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 68A3E1955F10; Tue, 11 Jun 2024 08:18:33 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.73])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9A7311956048; Tue, 11 Jun 2024 08:18:28 +0000 (UTC)
Date: Tue, 11 Jun 2024 09:18:25 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Mads Ynddal <mads@ynddal.dk>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Gustavo Romero <gustavo.romero@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: Re: [RFC PATCH v1 0/6] Implement ARM PL011 in Rust
Message-ID: <ZmgIUfqDjJuw2Chl@redhat.com>
References: <cover.rust-pl011-rfc-v1.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.rust-pl011-rfc-v1.git.manos.pitsidianakis@linaro.org>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, Jun 10, 2024 at 09:22:35PM +0300, Manos Pitsidianakis wrote:
> What are the issues with not using the compiler, rustc, directly?
> -----------------------------------------------------------------
> [whataretheissueswith] Back to [TOC]
> 
> 1. Tooling
>    Mostly writing up the build-sys tooling to do so. Ideally we'd 
>    compile everything without cargo but rustc directly.
> 
>    If we decide we need Rust's `std` library support, we could 
>    investigate whether building it from scratch is a good solution. This 
>    will only build the bits we need in our devices.

Re-building 'std' for QEMU would be a no-go for many distros who
will expect QEMU to use the distro provided 'std' package. So at
most that would have to be an optional feature.

> 2. Rust dependencies
>    We could go without them completely. I chose deliberately to include 
>    one dependency in my UART implementation, `bilge`[0], because it has 
>    an elegant way of representing typed bitfields for the UART's 
>    registers.
> 
> [0]: Article: https://hecatia-elegua.github.io/blog/no-more-bit-fiddling/
>      Crates.io page: https://crates.io/crates/bilge
>      Repository: https://github.com/hecatia-elegua/bilge
> 
> Should QEMU use third-party dependencies?
> -----------------------------------------
> [shouldqemuusethirdparty] Back to [TOC]
> 
> In my personal opinion, if we need a dependency we need a strong 
> argument for it. A dependency needs a trusted upstream source, a QEMU 
> maintainer to make sure it us up-to-date in QEMU etc.

"strong" is a rather fuzzy term. In C we already have a huge number
of build dependencies

 $ wc -l tests/lcitool/projects/qemu.yml 
 127 tests/lcitool/projects/qemu.yml

we would have many more than that except that we're conservative
about adding deps on things because getting new libraries into
distros is quite painful, or we lag behind where we would want
to be to stick with compat for old distro versions.

In terms of Rust dependancies, I'd expect us to have fairly arbitrary
dependancies used. If the dep avoids QEMU maintainers having to
re-invent the wheel for something there is already a common crate
for, then it is a good thing to use it. I'd almost go as far as
encouraging use of external crates. Our maintainers should focus tmie
on writing code that's delivers compelling features to QEMU, rather
than re-creating common APIs that already have good crates.

> We already fetch some projects with meson subprojects, so this is not a 
> new reality. Cargo allows you to define "locked" dependencies which is 
> the same as only fetching specific commits by SHA. No suspicious 
> tarballs, and no disappearing dependencies a la left-pad in npm.
> 
> However, I believe it's worth considering vendoring every dependency by 
> default, if they prove to be few, for the sake of having a local QEMU 
> git clone buildable without network access.

A local git clone is already not buildable without network access,
given that you have to install countless extra distro packages
ahead of time. I think its reasonable to expect people working from
git to have to download rust deps. We should consider whether we
want vendoring in the release tarballs though.

> Should QEMU provide wrapping Rust APIs over QEMU internals?
> -----------------------------------------------------------
> [qemuprovidewrappingrustapis] Back to [TOC]
> 
> My personal opinion is no, with the reasoning being that QEMU internals 
> are not documented or stable. However I do not see why creating stable 
> opt-in interfaces is bad. It just needs someone to volunteer to maintain 
> it and ensure there are no breakages through versions.

I expect this will evolve organically with people providing wrappers
where appropriate to suit their development neds.

> Will QEMU now depend on Rust and thus not build on my XYZ platform?
> -------------------------------------------------------------------
> [qemudependonrustnotbuildonxyz] Back to [TOC]
> 
> No, worry about this in some years if this experiment takes off. Rust 
> has broad platform support and is present in most distro package 
> managers. In the future we might have gcc support for it as well.

Rust isn't going away, so if a platform wants to remain relevant
to the modern software world, then people who care about that
platform need to ensure Rust works on it. I wouldn't say that
QEMU needs to massively worry about this, since all the common
platforms are now covered precisely because Rust is becoming
so wildly used that a platform cannot ignore it.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


