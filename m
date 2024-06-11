Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B835C25B76
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2024 11:11:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sGzOG-0004JE-BT; Tue, 11 Jun 2024 07:10:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sGzOE-0004J0-K0
 for qemu-devel@nongnu.org; Tue, 11 Jun 2024 07:10:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sGzOA-0001ET-2U
 for qemu-devel@nongnu.org; Tue, 11 Jun 2024 07:10:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718104203;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aKM+jJXQ4GPhQ9PCmctoLmu/PbjxF0+sxcgo311of9c=;
 b=T3p0elE32tipwsQKlhv9xMmDMd6/qgpnufIJLcICuA8PMc6wZb/J+U+H6cheO2yz3gS7Rw
 5fleUY1ein2aJjMStr0LmyTErjQkRPidN+Pq2mEDxH/OjnloC4bxfFnQrperG/krXC4Yt2
 E6B/I83IezFN4znjlOFXsGMLYg1pjz0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-564-5F-U4k71PwaXo3Q9RXty2Q-1; Tue,
 11 Jun 2024 07:09:55 -0400
X-MC-Unique: 5F-U4k71PwaXo3Q9RXty2Q-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 58AB9194511A; Tue, 11 Jun 2024 11:09:49 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.73])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1CF1519560AD; Tue, 11 Jun 2024 11:09:42 +0000 (UTC)
Date: Tue, 11 Jun 2024 12:09:39 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Mads Ynddal <mads@ynddal.dk>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alex =?utf-8?B?QmVubsOp?= e <alex.bennee@linaro.org>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Gustavo Romero <gustavo.romero@linaro.org>
Subject: Re: [RFC PATCH v1 0/6] Implement ARM PL011 in Rust
Message-ID: <Zmgwcwcs-HbHpVf-@redhat.com>
References: <cover.rust-pl011-rfc-v1.git.manos.pitsidianakis@linaro.org>
 <d910708f-ed55-4eee-8f66-8703cb45081c@linaro.org>
 <evt7n.ggoypj31l14q@linaro.org> <ZmgtfgqOOKeipIDd@redhat.com>
 <ewxal.5kz7id1gqls@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ewxal.5kz7id1gqls@linaro.org>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
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

On Tue, Jun 11, 2024 at 01:58:10PM +0300, Manos Pitsidianakis wrote:
> On Tue, 11 Jun 2024 13:57, "Daniel P. Berrangé" <berrange@redhat.com> wrote:
> > On Mon, Jun 10, 2024 at 11:29:36PM +0300, Manos Pitsidianakis wrote:
> > > On Mon, 10 Jun 2024 22:37, Pierrick Bouvier <pierrick.bouvier@linaro.org> wrote:
> > > > Hello Manos,
> > > > > On 6/10/24 11:22, Manos Pitsidianakis wrote:
> > > > > Hello everyone,
> > > > > > > This is an early draft of my work on implementing a very
> > > simple device,
> > > > > in this case the ARM PL011 (which in C code resides in hw/char/pl011.c
> > > > > and is used in hw/arm/virt.c).
> > > > > > > The device is functional, with copied logic from the C code
> > > but with
> > > > > effort not to make a direct C to Rust translation. In other words, do
> > > > > not write Rust as a C developer would.
> > > > > > > That goal is not complete but a best-effort case. To give a
> > > specific
> > > > > example, register values are typed but interrupt bit flags are not (but
> > > > > could be). I will leave such minutiae for later iterations.
> > 
> > snip
> > 
> > > > Maybe it could be better if build.rs file was *not* needed for new
> > > > devices/folders, and could be abstracted as a detail of the python
> > > > wrapper script instead of something that should be committed.
> > > 
> > > 
> > > That'd mean you cannot work on the rust files with a LanguageServer, you
> > > cannot run cargo build or cargo check or cargo clippy, etc. That's why I
> > > left the alternative choice of including a manually generated bindings file
> > > (generated.rs.inc)
> > 
> > I would not expect QEMU developers to be running 'cargo <anything>'
> > directly at all.
> > 
> > QEMU's build system is 'meson' + 'ninja' with a 'configure' + 'make'
> > convenience facade.
> > 
> > Any use of 'cargo' would be an internal impl detail of meson rules
> > for building rust code, and developers should still exclusively work
> > with 'make' or 'ninja' to run builds & tests.
> 
> No, that's not true. If I wrote the pl011 device with this workflow I'd just
> waste time using meson. Part of the development is making sure the library
> type checks, compiles, using cargo to run style formatting, to check for
> lints, perhaps run tests. Doing this only through meson is an unnecessary
> complication.

I don't see why it should waste time, when we ultimately end up calling
the same underlying tools. We need to have a consistent experiance for
developers working on QEMU, not have to use different tools for different
parts of QEMU depending on whether a piece of code happens to be rust
or C.

> To compile and run QEMU with a rust component, sure, you'd use meson.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


