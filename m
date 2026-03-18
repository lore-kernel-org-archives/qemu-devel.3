Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18B5210854DC
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2026 09:43:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2nQv-0003XR-Ak; Wed, 18 Mar 2026 05:43:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1w2nQt-0003XG-AP
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 05:43:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1w2nQq-0007B5-8i
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 05:43:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773826994;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=15eJDsmtXNppXbfijQPClH+LvEEWfS0AnHMRug3dOZk=;
 b=FY3oQXzyXK/EyV5Gk4ZFtGvZ4/eiE9HXud7PUcc9mm9BWvenwy+cfJur2btN/n3eSSz8+F
 xOAw58s4qkrKdWGo5fuvPNTwxr70ACV0wgiTo5v5w8govBzPitx1zJnCwvAHD0KSqZdKLR
 iAsZGAm8Vcm548SxkN5NL0zz3I7ajtc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-455-KVj2Z523NqCLARyWFHPPNw-1; Wed,
 18 Mar 2026 05:43:12 -0400
X-MC-Unique: KVj2Z523NqCLARyWFHPPNw-1
X-Mimecast-MFC-AGG-ID: KVj2Z523NqCLARyWFHPPNw_1773826992
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D059A19560B6; Wed, 18 Mar 2026 09:43:11 +0000 (UTC)
Received: from redhat.com (unknown [10.44.33.194])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5630419560AB; Wed, 18 Mar 2026 09:43:10 +0000 (UTC)
Date: Wed, 18 Mar 2026 09:43:06 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH] rust: suggest passing --locked to "cargo install"
Message-ID: <abpzqslfxriaC5uD@redhat.com>
References: <20260318082113.1127992-1-pbonzini@redhat.com>
 <CAAjaMXbRGLX6=dnP0mh2q5G3ZUe4H_JBmmzskiwKOf=Ddsh0Jg@mail.gmail.com>
 <980ab0ed-d009-4e7b-a199-8edc8379e676@redhat.com>
 <CAAjaMXaRoghMM10Km=aMeGByibyc-bBqricaUCUORb6Rxxp2yQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAjaMXaRoghMM10Km=aMeGByibyc-bBqricaUCUORb6Rxxp2yQ@mail.gmail.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
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

On Wed, Mar 18, 2026 at 11:32:59AM +0200, Manos Pitsidianakis wrote:
> Hi Paolo,
> 
> On Wed, Mar 18, 2026 at 11:28 AM Paolo Bonzini <pbonzini@redhat.com> wrote:
> >
> > On 3/18/26 09:51, Manos Pitsidianakis wrote:
> > >> +      error('bindgen version ' + bindgen.version() + ' is unsupported. You can install a new version with "cargo install --locked bindgen-cli"')
> > >
> > > Am I missing something or is bindgen not in Cargo.lock? Also doesn't
> > > this depend on `cargo-install` being invoked in the same path as
> > > Cargo.lock, i.e. `rust/` subdir? (Not sure about this)
> >
> > Because the bindgen step is done in Meson it uses a bindgen binary that
> > is preinstalled in $PATH; it doesn't build bindgen-cli the way you'd see
> > it happen when done with build.rs(*).  Usually it can use the distro
> > package, but as you can see from the tests/lcitool/ part of the patch
> > it's too old for Ubuntu 22.04.
> >
> > The "cargo install bindgen-cli" command does not use QEMU's Cargo.lock,
> 
> So what does `--locked` do here? As per `--help`: "--locked Assert
> that `Cargo.lock` will remain unchanged" What Cargo.lock does it not
> change?

--locked ensures that cargo honours the Cargo.lock from the bindgen.git
repo, instead of pulling in arbitrarily newer dependencies. The
fixed versions of deps in bindgen's Cargo.lock are still compatible
with edition2021, but the latest deps are only compatible with edition2024,
and we need edition2021


With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


