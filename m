Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA194EC1105
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Feb 2026 16:25:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuYkF-0005gh-5I; Mon, 23 Feb 2026 11:25:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vuYkD-0005er-39
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 11:25:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vuYkA-0000ps-Nq
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 11:25:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771863908;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6SWX5bxNN8QwbIb2BzT3lRnyYI6WRdyTch9E/k+gcl4=;
 b=ZYPFiIfQE17Xz0xprBao5+4vo4RSC2i91BzJIVhiGwUCrzPguc0uKSpV79kHHBygn3crkQ
 bO6qylgOu1Gy3Xmw2ZDZrxxNw6VEz3lYIPihCNzfDVNa1l4TiczzJ0kjRE9TwMpd3+w1aU
 poiCozcfZoXqCf5AQ8GLMDAYXglZ8z4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-371-B7anA2ZrPI-N_gOYWYbdXQ-1; Mon,
 23 Feb 2026 11:25:06 -0500
X-MC-Unique: B7anA2ZrPI-N_gOYWYbdXQ-1
X-Mimecast-MFC-AGG-ID: B7anA2ZrPI-N_gOYWYbdXQ_1771863906
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9EB6C180034D; Mon, 23 Feb 2026 16:25:05 +0000 (UTC)
Received: from redhat.com (unknown [10.45.226.11])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7A7B619560A3; Mon, 23 Feb 2026 16:25:03 +0000 (UTC)
Date: Mon, 23 Feb 2026 16:24:59 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 qemu-rust@nongnu.org
Subject: Re: [PATCH v2 00/16] rust: QObject and QAPI bindings
Message-ID: <aZx_Wy1-eBsTEB1s@redhat.com>
References: <20260108131043.490084-1-pbonzini@redhat.com>
 <aZwjpfu-qCCSoHdx@redhat.com>
 <bedbf511-c46a-4468-bf65-cc452c621765@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bedbf511-c46a-4468-bf65-cc452c621765@redhat.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -1
X-Spam_score: -0.2
X-Spam_bar: /
X-Spam_report: (-0.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1.179, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.717,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
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

On Mon, Feb 23, 2026 at 04:54:07PM +0100, Paolo Bonzini wrote:
> On 2/23/26 10:53, Daniel P. Berrangé wrote:
> > On Thu, Jan 08, 2026 at 02:10:27PM +0100, Paolo Bonzini wrote:
> > > This adds two related parts of the Rust bindings:
> > > 
> > > - QAPI code generator that creates Rust structs from the JSON
> > >    description.  The structs are *not* ABI compatible with the
> > >    C ones, instead they use native Rust data types.
> > > 
> > > - QObject bindings and (de)serialization support, which can be used to
> > >    convert QObjects to and from QAPI structs.
> > > 
> > > Unfortunately Rust code is not able to use visitors, other than by
> > > creating an intermediate QObject.  This is because of the different
> > > architecture of serde vs. QAPI visitors, and because visitor's
> > > dual-purpose functions, where the same function is used by both input and
> > > output visitors, rely heavily on the structs using the same representation
> > > as the visitor arguments (for example NUL-terminated strings).
> > > 
> > > The serde format implementation was co-authored by me and Marc-André.
> > > Marc-André did all the bug fixing and integration testing.
> > > 
> > > As an example of how this would be used, the marshaling functions for
> > > QMP commands would look like this:
> > 
> > Can you give more of the big picture about what follows this ?  From
> > this example you're showing, are you suggesting that you'll be soon
> > moving QMP command impls from C to Rust ?
> 
> The reasons for Marc-André and I to do this was just as an exploration. The
> patches show a different way to do what he had already tackled in 2022, and
> allow a direct comparison the relative benefits between a more Rust-focused
> approach and a more direct translation of QEMU's C code.
> 
> Marc-André indeed had command implementations in Rust and that would be an
> obvious next step to continue on the QAPI side.  On the other hand, the
> QObject part (without QAPI structs) also works as a step towards more QOM
> integration, especially with respect to properties and backends.  Having a
> full-blown QObject implementation to move around bools is perhaps
> over-engineered, but is also an easy way to make a generic implementation
> that works for all QAPI types.
> 
> The block layer also needs QAPI for option parsing, so Kevin's work on block
> layer bindings would also benefit from having this integration.
> 
> In other words, there is no real big picture from me other than "someone
> needs to do the hard part for others": QOM, QAPI and the build system are
> the three central components from which all other bindings branch out.  Zhao
> and Marc-André have helped a lot with this work, and they also showed how to
> use these hard parts (see Zhao's vm-memory work and Marc-André's GStreamer
> backend), now it's also time for others to try and to take inspiration from
> Rust for improving the C side of things.

I guess the thing I'm wondering about when I ask about the big picture
is to understand tne interoperability implications of this impl approach,
given the starting point that the Rust & C structs are *not* ABI compatible.


If we're anticipating that the Rust usage flows up from a Rust QMP command
handler, then the data is in the Rust struct right from the entry point
and perhaps the interoperability needs are reduced in scope.

If we're anticipating a calls back & forth between C & Rust code, that
directly handle the deserialized structs, then we have an open interop
question. Is the implication that we round-trip via JSON every time we
need to swap between a Rust struct and C struct for a given type ? Or
will we have a direct struct<->struct conversion mechanism ? Or is there
something else entirely ?

I feel a bit lost in how to evaluate this series without seeing some
real world usage, in a way that exposes the possible implications of
the lack of C/Rust ABI compat in the structs.

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


