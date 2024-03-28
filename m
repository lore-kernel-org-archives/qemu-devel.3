Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C3B8C54E67
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Mar 2024 10:46:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpnHM-0007Rc-9P; Thu, 28 Mar 2024 06:46:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rpnHJ-0007RC-R4
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 06:46:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rpnHH-0003nu-Mg
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 06:46:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711622794;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=1QtCjFWofqRPetD+IzTYz0DRdth8mg+2bA45w5bXDOc=;
 b=T4VeShopxFym1dlUscjxP0ykqkhN7/lEaXOgeb38MdiUZnPp/L31ua7zn/ac2Gj7Zhffez
 K8CYA6l3voFS+iqNGK4P7PnBNd/h2N3GAFEQABGLADMgBVfvWef+vQ8jdi+Vit/v67rd/b
 kc+drvaF5QSEVhlQFYURoW7b87tnzfY=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-618-GZctPhmFPDyDsuQoEjOFaQ-1; Thu,
 28 Mar 2024 06:46:32 -0400
X-MC-Unique: GZctPhmFPDyDsuQoEjOFaQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 184153CBDFBD
 for <qemu-devel@nongnu.org>; Thu, 28 Mar 2024 10:46:32 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.135])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 25E582166B31;
 Thu, 28 Mar 2024 10:46:31 +0000 (UTC)
Date: Thu, 28 Mar 2024 10:46:24 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Anthony Harivel <aharivel@redhat.com>
Cc: pbonzini@redhat.com, mtosatti@redhat.com, qemu-devel@nongnu.org,
 vchundur@redhat.com, rjarry@redhat.com
Subject: Re: [PATCH v4 2/3] tools: build qemu-vmsr-helper
Message-ID: <ZgVKgARidIFQZF5M@redhat.com>
References: <20240318151216.32833-1-aharivel@redhat.com>
 <20240318151216.32833-3-aharivel@redhat.com>
 <ZfwbIywC504XWxkl@redhat.com> <D05B8SENZ5MO.52MU1G4SOBY0@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <D05B8SENZ5MO.52MU1G4SOBY0@fedora>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Mar 28, 2024 at 11:27:50AM +0100, Anthony Harivel wrote:
> Hi Daniel, 
> 
> My apologies for all the missed feedback in v2. 
> I'll be more organized for my next iteration. 
> 
> For this specific comment below, I would like to make sure I'm testing 
> the right way. 
> 
> > > diff --git a/meson.build b/meson.build
> > > index b375248a7614..376da49b60ab 100644
> > > --- a/meson.build
> > > +++ b/meson.build
> > > @@ -4052,6 +4052,11 @@ if have_tools
> > >                 dependencies: [authz, crypto, io, qom, qemuutil,
> > >                                libcap_ng, mpathpersist],
> > >                 install: true)
> > > +
> > > +    executable('qemu-vmsr-helper', files('tools/i386/qemu-vmsr-helper.c'),
> > > +               dependencies: [authz, crypto, io, qom, qemuutil,
> > > +                              libcap_ng, mpathpersist],
> > > +               install: true)
> > >    endif
> >
> > Missed feedback from v2 saying this must /only/ be built
> > on x86 architectures. It fails to build on others due
> > to the ASM usage eg
> >
> > https://gitlab.com/berrange/qemu/-/jobs/6445384073
> >
> 
> To recreate your build system, I need to, for example, compile with the 
> following configuration for arm64 (aarch64):
> 
> ../configure --enable-werror --disable-docs --enable-fdt=system 
> --disable-user --cross-prefix=aarch64-linux-gnu- 
> --target-list-exclude="arm-softmmu cris-softmmu i386-softmmu 
> microblaze-softmmu mips-softmmu mipsel-softmmu mips64-softmmu 
> ppc-softmmu riscv32-softmmu sh4-softmmu sparc-softmmu xtensa-softmmu"
> 
> This is cross-compiling on x86 right?
> Because on my laptop I've got the following error: 
> 
> WARNING: unrecognized host CPU, proceeding with 'uname -m' output 'x86_64'
> python determined to be '/usr/bin/python3'
> python version: Python 3.12.2
> mkvenv: Creating non-isolated virtual environment at 'pyvenv'
> mkvenv: checking for meson>=0.63.0
> 
> ERROR: Unrecognized host OS (uname -s reports 'Linux')
> 
> It looks like it wants to build natively on aarch64.
> Maybe I need to create a VM with aarch64 Debian and compile natively?
> Might take a long time but I'm not sure this is the best way.

You can do this all with our Debian cross build containers locally

Either build the container fresh

   podman build --tag qemuarm64 -f tests/docker/dockerfiles/debian-arm64-cross.docker

Or pull down the one from CI

   podman pull registry.gitlab.com/qemu-project/qemu/qemu/debian-arm64-cross


Inside the container you just need to clone your QEMU repo and then run

   ./configure $QEMU_CONFIGURE_OPTS --target-list=x86_64-softmmu


$QEMU_CONFIGURE_OPTS expands to the args needed for a cross-compile,
as it set by the container itself.


Alternatively fork the project on gitlab, and then push your branch
to your fork, while requesting  CI

  git push -o ci.variable=QEMU_CI=1  <gitlab remote> <branch name>

then in the gitlab UI, you can press play on the individual jobs
you want to test. See docs/devel/testing.rst for info on that.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


