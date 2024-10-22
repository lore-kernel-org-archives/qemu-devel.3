Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 935B7CDD0E1
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 20:12:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3LEx-0001o4-Gp; Tue, 22 Oct 2024 16:12:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nenut@skiff.uberspace.de>)
 id 1t3LEv-0001nu-82
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 16:12:25 -0400
Received: from mailgate02.uberspace.is ([185.26.156.114])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nenut@skiff.uberspace.de>)
 id 1t3LEr-0005RI-0p
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 16:12:23 -0400
Received: from skiff.uberspace.de (skiff.uberspace.de [185.26.156.131])
 by mailgate02.uberspace.is (Postfix) with ESMTPS id ECDCD1813C0
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2024 22:12:11 +0200 (CEST)
Received: (qmail 2084 invoked by uid 990); 22 Oct 2024 20:12:11 -0000
Authentication-Results: skiff.uberspace.de;
	auth=pass (plain)
Received: from unknown (HELO unkown) (::1)
 by skiff.uberspace.de (Haraka/3.0.1) with ESMTPSA;
 Tue, 22 Oct 2024 22:12:11 +0200
MIME-Version: 1.0
Date: Tue, 22 Oct 2024 20:12:11 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
From: "Julian Ganz" <nenut@skiff.uberspace.de>
Message-ID: <7199e215469e3916f1d08351b3a8febffcc21d8b@skiff.uberspace.de>
TLS-Required: No
Subject: Re: [RFC PATCH v2 0/7] tcg-plugins: add hooks for interrupts,
 exceptions and traps
To: "=?utf-8?B?QWxleCBCZW5uw6ll?=" <alex.bennee@linaro.org>
Cc: "Pierrick Bouvier" <pierrick.bouvier@linaro.org>, "Julian Ganz"
 <neither@nut.email>, qemu-devel@nongnu.org
In-Reply-To: <87wmi0ms45.fsf@draig.linaro.org>
References: <20231021122502.26746-1-neither@nut.email>
 <cover.1729355735.git.neither@nut.email>
 <fad67d3f-5b8d-45f6-a1aa-666852a0dad4@linaro.org>
 <8929cd79ce653b55e7cb166300782cb13727da3b@skiff.uberspace.de>
 <f7e574bb-a780-4f5b-a511-ab9f0aa86f31@linaro.org>
 <ab29d100610abcc59ce2305a1ace1ac0b53340a3@skiff.uberspace.de>
 <87wmi0ms45.fsf@draig.linaro.org>
X-Rspamd-Bar: /
X-Rspamd-Report: BAYES_HAM(-0.00088) MIME_GOOD(-0.1)
X-Rspamd-Score: -0.10088
Received-SPF: pass client-ip=185.26.156.114;
 envelope-from=nenut@skiff.uberspace.de; helo=mailgate02.uberspace.is
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi, Alex,

October 22, 2024 at 10:58 AM, "Alex Benn=C3=A9e" wrote:
> How easy would it be to expose a Rust API? I'm curious because now we
> are looking to integrate Rust into QEMU we could consider transitioning
> to a Rust API for plugins. It has been done before:
>=20
>=20 https://github.com/novafacing/qemu-rs/tree/main/qemu-plugin-sys
>=20
>=20and
>=20
>=20 https://github.com/novafacing/qemu-rs/tree/main/qemu-plugin
>=20
>=20I'm curious as to what it would look like. I don't know how tenable i=
t
> would be to run 2 plugin APIs side-by-side long term though. We would
> probably want to make a choice. Also how would that affect other C like
> APIs like python?

I'm maybe not an expert w.r.t. plugins with Rust, but here are my
thoughts:

Calling C code from Rust is obviously not an issue. For ideomatic Rust
(not littered with "unsafe") you want an abstraction over that, but as
Qemu is C you need that somewhere anyway.

Things that are generally easy to handle are opaque types behind
pointers (this is probably true for most language binding) and C
strings, as long as you can figure out who owns them and how long they
live. Things in the current API which make things a bit awkward are
(probably) unions and Glib-types such as the GArray returned by
qemu_plugin_get_registers. Also, you can use Rust functions for
callbacks, but ideally you want to allow using all types implementing
the Fn trait, e.g. closures carrying some context. For that, you need to
transport that context from the point of registration to the callback,
i.e. you need some udata. Not all callbacks have udata, but looking
closer the ones lacking it are those you register only once, which means
we could have some "static" storage for those context. It's not ideal,
but not a show-stopper either. I didn't check how the qemu-plugin crate
handles that situation.

With a native Rust interface, you would not have those problems.
However, for plugins you would need a dylib interface, which comes with
restrictions. In particular, you cannot use generics in the interface.
To allow for the very extension we want the interface would make heavy
use of Box<dyn SomeTrait>, in particular Box<dyn Fn(...) -> ...>.

The awkward thing about those is that you cannot simply convert them
into a void pointer because the "dyn" means fat pointers are involved:
unlike in C++, the vtable is embedded in the "pointer". Since we want to
invoke those from the C side, we need another level of indirection which
lets us operate on an opaque Rust type through non-generic functions
that then does the thing we want to the boxed thing. Ironically, you
don't have the same problem with a Rust plugin developed against a C
interface because you can just use a generic function unpacking (i.e.
casting) the context and throw its instantiation's pointer over the
fence.

So... I'm not sure about the benefits of a native Rust plugin API
compared to the qemu-plugin crate or something similar. Especially
considering that we would want to use the very same callback registry in
the back, anyway. That is, if you want feature parity between the
different plugin APIs.

There are some things that would make language bindings easier in
general, but some of those would involve breaking changes and may not
be worth it.

Regards,
Julian

