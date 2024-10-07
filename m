Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB6A8CFB43F
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2024 11:48:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxmD3-0005Gz-Hq; Mon, 07 Oct 2024 07:47:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sxmCy-0005Ga-AP
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 07:47:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sxmCw-0004ai-FB
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 07:47:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728301641;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QedhxdPw3WIHh9Hw0EwA61PJ5RIl1dSvfhJcTr5SSuk=;
 b=SlPJTzMFNF09yzd82/+Mzf4D4cmbyvqZIiFrtjS7HTdZ7vINJEKTgR7ET17eKrgIDXmaWe
 nVmsSHnUQXnSQ+WncEDogOU1qf+8ImNMOoB028ixtNj05g0J8dj1n0ndKyg3XgVS/FejDq
 3CNF7JKjkNA47LmNhx8afY4u+Ypzl1s=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-404-HfpDueGwMOuF4tAEkJEKsg-1; Mon,
 07 Oct 2024 07:47:18 -0400
X-MC-Unique: HfpDueGwMOuF4tAEkJEKsg-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C06E11964CF9; Mon,  7 Oct 2024 11:47:16 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.61])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 69457300018D; Mon,  7 Oct 2024 11:47:12 +0000 (UTC)
Date: Mon, 7 Oct 2024 12:47:08 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, manos.pitsidianakis@linaro.org,
 zhao1.liu@intel.com, junjie.mao@intel.com,
 pierrick.bouvier@linaro.org, alex.bennee@linaro.org
Subject: Re: [PULL 00/12] Rust initial PoC + meson changes for 2024-10-07
Message-ID: <ZwPKPGkpklnY9i5z@redhat.com>
References: <20241007110342.1298598-1-pbonzini@redhat.com>
 <ZwPB9SnTvkr082NA@redhat.com>
 <CABgObfYZgR9xNnP9mHWU92XZZ_VeFLHimkd-t-63KX_KWeDZ=A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABgObfYZgR9xNnP9mHWU92XZZ_VeFLHimkd-t-63KX_KWeDZ=A@mail.gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.153,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, Oct 07, 2024 at 01:26:52PM +0200, Paolo Bonzini wrote:
> On Mon, Oct 7, 2024 at 1:11 PM Daniel P. Berrangé <berrange@redhat.com> wrote:
> > The current dockerfiles don't include rust, and I see nothing
> > here updating them to add rust, so how is any of this getting
> > test coverage ?
> >
> > Even though this has Rust disabled by default, I would still
> > consider CI enablement to be a pre-requsite for merging even
> > basic Rust support.
> 
> I agree in general, but there's already a lot of work that can be
> parallelized and the idea of someone managing Rust-related patches
> out-of-tree was discarded. So this seemed to be the only way to
> proceed.
> 
> Right now only Fedora 39 and 40 (with updates) are able to compile
> QEMU with Rust enabled. Full CI enablement requires further work to
> reduce the minimum supported version of the compiler, after which
> rustc can be added to the libvirt-ci inputs and to the Dockerfiles.

Full CI enablement isn't a requirement until we want to turn on
Rust by default. It would be sufficient to have a single job in
CI using Fedora 40 that passes '--enable-rust' to demonstrate that
this at least working on one platform we expect.

> Adding a CI job that uses nightly rust (via rustup) is high on my
> priority list, but first of all I wanted to integrate clippy (because
> the main point of having a job with nightly rust is to have a heads-up
> on future clippy warnings). That said, I'm also not sure how one would
> go adding rustup to a container generated by lcitool (for example
> should I add a new dockerfile that is _based_ on one that already
> exists? would that change when Rust/rustc is added to that
> dockerfile?).

Having layered dockerfiles is something we try to aviod these days,
since each layer turns into another job dependancy in the CI
pipeline, expanding the number of stages.

If the job is merely to validate nightly clippy do we even need
any of the rest of the QEMU build deps present ?  Can we not just
use a generic pre-existing Rust container and only run clippy
in it.

If we want to actually build with the cutting edge, then I'd say
it is sufficient to have a container based on Fedora rawhide, since
that gives a heads up on what's soon to be impacting the next stable
distro release, upto 6 months ahead of time - we don't need to be
watching& debugging stuff that hasn't even been released by Rust
yet IMHO.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


