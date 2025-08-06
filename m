Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DAEFC87FD1
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Aug 2025 09:32:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujaSR-0001x2-Qe; Wed, 06 Aug 2025 05:29:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1ujaLI-0005mV-NV
 for qemu-devel@nongnu.org; Wed, 06 Aug 2025 05:22:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1ujaLF-00011A-UZ
 for qemu-devel@nongnu.org; Wed, 06 Aug 2025 05:21:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754472104;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=uO+coN0Tp7S+cJLk4t10/T14LEW5dBrVhG8kLyAH2T4=;
 b=aMCj+rGRRT5vUA47+xYt4cDKR/p+SVByivtjqwxefmY2sDT0zwHyNPdaI1bP8cBlwHFlNa
 UZy8RhYucuOZnPmF79LINJFhIvEqKo43fHSuuM8uqxEtgQno8mSQ5VzmxrUwpBYA+P+sYG
 jdcIqLCtogYSRCB5VTVFwN9eW0OIYxc=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-163-DSIrQAqvOy-S_1skDIuq_Q-1; Wed,
 06 Aug 2025 05:21:41 -0400
X-MC-Unique: DSIrQAqvOy-S_1skDIuq_Q-1
X-Mimecast-MFC-AGG-ID: DSIrQAqvOy-S_1skDIuq_Q_1754472100
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A44E419560AE; Wed,  6 Aug 2025 09:21:39 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.223])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1454F1800280; Wed,  6 Aug 2025 09:21:36 +0000 (UTC)
Date: Wed, 6 Aug 2025 10:21:33 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 qemu-devel@nongnu.org, qemu-rust@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 alex.bennee@linaro.org
Subject: Re: [PATCH RFC 0/5] rust: implement tracing
Message-ID: <aJMeKejagnSK9s2_@redhat.com>
References: <20250804-rust_trace-v1-0-b20cc16b0c51@linaro.org>
 <aJIrpoEhrl7aLBMg@redhat.com>
 <CAAjaMXa6ManykYJJk--vNZT7oeBW9UR2v6WixaaQ8LUCSjy9Ug@mail.gmail.com>
 <aJI0mr5HDgtE9HIc@redhat.com>
 <CAAjaMXZ0Dho+5FSyc4zkOZXZT6UvHtjgmpj6_0QZQcH_AD9=VQ@mail.gmail.com>
 <aJJFVgkt7R49ZwIF@redhat.com>
 <CAAjaMXYhWsWPoDdfoNyTGrJSRfiYJDqBkv8fC87+Zi3YCtU06Q@mail.gmail.com>
 <ad404bb4-93fb-4a27-995f-734e647c1da0@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ad404bb4-93fb-4a27-995f-734e647c1da0@redhat.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Wed, Aug 06, 2025 at 11:02:53AM +0200, Paolo Bonzini wrote:
> On 8/5/25 22:06, Manos Pitsidianakis wrote:
> > > If you're thinking this is all rather complicated, you'd be right,
> > > which is why for initial feature parity I figured the simplest is
> > > likely to just wrap the existing QEMU inline probe function, so
> > > Rust doesn't need to know about the different backends... yet...
> 
> It's not too hard to add individual backends (other than dtrace---see
> below--and ust which doesn't build for me(*) and I wanted to deprecate).
> Tanish is pretty close to being able to post initial work.

If we want to drop some backends that's fine, as IMHO we've got
needlessly many there.

> > Yes, that indeed makes sense.  Generated C trace headers statically
> > linked to a standalone trace crate library for each subsystem, that
> > rust qemu crates can link to in return is the cleanest solution for
> > this approach IMHO, because doing this kind of codegen via macros
> > needs interaction with meson to generate the C sources and then run
> > bindgen all while compiling this one crate which is a single meson lib
> > target.
> > 
> > It might be possible to generate the equivalent of the C code for each
> > backend just like this RFC generates only the log backend code, I'll
> > take a look out of curiosity...
> > 
> > > FWIW, the original DTrace authors created a Rust crate with native
> > > rust integration of dynamic probes.
> > > 
> > >    https://github.com/oxidecomputer/usdt
> > > 
> > > I think that (somehow) we probably want to integrate that with QEMU
> > > and its tracetool.
> 
> This unfortunately only works for macOS and Solaris.  It also has quite a
> few dependencies (~25) on other crates.  There is also a "probe" crate
> (https://github.com/cuviper/probe-rs) that is minimal and (currently)
> specific to Linux, which is what I planned to use.
> 
> By the way, while I like the idea of using Rust format strings, there are
> parts of tracetool (e.g. format/log_stap.py) that need the printf strings,
> and also backends (e.g. backend/syslog.py) that call into libc and therefore
> need to use printf format strings.  So I think we're stuck.

Note, I would describe our format strings as printf-like/light. We certainly
do NOT allow the full range of C library formats, because we need to be able
to pass the format strings to systemtap, which is likewise merely printf-like.

Do don't really do any significant upfront validation on the format specifiers
beyond checking for invalid %m and newlines. In practical terms though the
only things we can use are

  %x %u %d %s %p

with optional 'l', 'll' or 'z' modifiers and digit precision for the int
formats. Anything beyond that will likely fail with systemtap. We ought
to move validation for this to the parsing phase to strongly enforce this
limited syntax.

IOW, in any tracetool format generator for rust, we could fairly easily
translate the format string from printf-like to rust style.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


