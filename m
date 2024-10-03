Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B19ACF857A
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2024 10:59:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swJY4-0004NS-8t; Thu, 03 Oct 2024 06:59:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1swJY2-0004N6-HG
 for qemu-devel@nongnu.org; Thu, 03 Oct 2024 06:59:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1swJY0-0003H2-PX
 for qemu-devel@nongnu.org; Thu, 03 Oct 2024 06:59:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727953143;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=ve8SluRQWsJbUb/sHWf136hFfh9On4akHKETqQ/MBbU=;
 b=ckLKYjDONAeDLxudOZFLIsA/+SqI+ev2PYkr2YfOigwjIeYix2zHCe1S8qwaWu85IhxZZn
 G8Jgic1ttQ7tmbJe1k0ZhrfBN5CDGP/OqxuUraFhF2vIrOmFBhJYhP5eims662iyZCWJ47
 +zEKXDQqKC73iyGYzJEkUcufKKWD41U=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-645-dGSBT1kKPYqBgXTHWC2KAA-1; Thu,
 03 Oct 2024 06:58:58 -0400
X-MC-Unique: dGSBT1kKPYqBgXTHWC2KAA-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C8B34195609E; Thu,  3 Oct 2024 10:58:52 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.46])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 348901956086; Thu,  3 Oct 2024 10:58:33 +0000 (UTC)
Date: Thu, 3 Oct 2024 11:58:27 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Warner Losh <imp@bsdimp.com>
Cc: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel <qemu-devel@nongnu.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Hanna Reitz <hreitz@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 pkg-qemu-devel@lists.alioth.debian.org,
 Michael Tokarev <mjt@tls.msk.ru>, ncopa@alpinelinux.org,
 bofh@freebsd.org, emulation@freebsd.org, virtualization@gentoo.org,
 dilfridge@gentoo.org, hi@alyssa.is, edolstra+nixpkgs@gmail.com,
 brad@comstyle.com, Paolo Bonzini <pbonzini@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, dvzrv@archlinux.org,
 anatol.pomozov@gmail.com, Miroslav Rezanina <mrezanin@redhat.com>
Subject: Re: Rust BoF and maintainer minutes and planning the roadmap to Rust
Message-ID: <Zv540yb8V1sSnZP3@redhat.com>
References: <871q16fq9c.fsf@draig.linaro.org>
 <CANCZdfoU4stiEDJKOUEpU-ek_tOBHe0rBH3G9S2Wymc8jHKzCQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CANCZdfoU4stiEDJKOUEpU-ek_tOBHe0rBH3G9S2Wymc8jHKzCQ@mail.gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, Oct 03, 2024 at 02:53:08AM -0600, Warner Losh wrote:

> commitment by the Rust community is troubling. Even more troubling because
> rust still uses the old FreeBSD 11 compat syscalls, despite upgraded
> being available for years at this point (though maybe this info has changed
> in the last month or two, the years long delay in moving off the interfaces
> that the FreeBSD project obsoleted about 8 years ago is troubling on its
> own).

Is this problem resolved by this change updating to FreeBSD 12 ABI:

  https://github.com/rust-lang/libc/pull/3434

Or is there more beyond that which remains an issue ?

Also what's the best source of truth about Rust support in FreeBSD 
eg I see this:

  https://wiki.freebsd.org/Rust

 Reports i386, amd64, armv6, armv7, aarch64, power64, power64le
 and riscv64

and then this

  https://www.freshports.org/lang/rust

but doesn't say anything about riscv64, and armv6/i386 is listed as
"N/A" for FreeBSD 15 - are those arches no longer supported in 15 ?

power64le is outdated there compared to other arches

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


