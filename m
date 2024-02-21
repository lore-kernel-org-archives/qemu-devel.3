Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A65FDC48BEB
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 15:41:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcoaC-0006YV-Lo; Wed, 21 Feb 2024 10:32:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rcoRY-00022h-5r
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 10:23:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rcmwb-0002xo-Dn
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 08:47:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708523247;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2Lnv/6r8peW0tWGlB14PSLVqplDxLheletLRi0gYn7c=;
 b=R5hucw6pBsy352Za9ww8mDv0cYbSmNl5F3L2zqqzx2fO+wsNWlcUW6Fjik/2R2hI4v9I+j
 IaAhvXMXfBeQhysc5eiuJWmNIsoVEIKNf3w68ILw4p+d1LhoFX0mq1xy3QsySWP8HAz0mE
 t2JSa8vK6c72Zs9q4pQOtz+CXRq6wCk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-281-NbHwVSuRMo2Z7QpyMKb87Q-1; Wed, 21 Feb 2024 08:47:26 -0500
X-MC-Unique: NbHwVSuRMo2Z7QpyMKb87Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 01E88863010
 for <qemu-devel@nongnu.org>; Wed, 21 Feb 2024 13:47:26 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.53])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DA54E200B436;
 Wed, 21 Feb 2024 13:47:24 +0000 (UTC)
Date: Wed, 21 Feb 2024 13:47:22 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Anthony Harivel <aharivel@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, mtosatti@redhat.com,
 qemu-devel@nongnu.org, vchundur@redhat.com
Subject: Re: [PATCH v3 2/3] tools: build qemu-vmsr-helper
Message-ID: <ZdX-6mJbpuMaRio9@redhat.com>
References: <20240125072214.318382-1-aharivel@redhat.com>
 <20240125072214.318382-3-aharivel@redhat.com>
 <Zbf0Fbhmg0tvMbxK@redhat.com>
 <CABgObfaRGL8eOs6NRBjEMjTa_7UGyAn+Pic2GP=XbE+Qg-oBCQ@mail.gmail.com>
 <ZbgAb3m6-rwUFxOO@redhat.com> <CZASCDCNT6TJ.1LP37HOBJVYGT@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CZASCDCNT6TJ.1LP37HOBJVYGT@fedora>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.05,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Wed, Feb 21, 2024 at 02:19:11PM +0100, Anthony Harivel wrote:
> Daniel P. Berrangé, Jan 29, 2024 at 20:45:
> > On Mon, Jan 29, 2024 at 08:33:21PM +0100, Paolo Bonzini wrote:
> > > On Mon, Jan 29, 2024 at 7:53 PM Daniel P. Berrangé <berrange@redhat.com> wrote:
> > > > > diff --git a/meson.build b/meson.build
> > > > > index d0329966f1b4..93fc233b0891 100644
> > > > > --- a/meson.build
> > > > > +++ b/meson.build
> > > > > @@ -4015,6 +4015,11 @@ if have_tools
> > > > >                 dependencies: [authz, crypto, io, qom, qemuutil,
> > > > >                                libcap_ng, mpathpersist],
> > > > >                 install: true)
> > > > > +
> > > > > +    executable('qemu-vmsr-helper', files('tools/i386/qemu-vmsr-helper.c'),
> > > >
> > > > I'd suggest 'tools/x86/' since this works fine on 64-bit too
> > > 
> > > QEMU tends to use i386 in the source to mean both 32- and 64-bit.
> >
> > One day we should rename that to x86 too :-)
> >
> > > > You never answered my question from the previous posting of this
> > > >
> > > > This check is merely validating the the thread ID in the message
> > > > is a child of the process ID connected to the socket. Any process
> > > > on the entire host can satisfy this requirement.
> > > >
> > > > I don't see what is limiting this to only QEMU as claimed by the
> > > > commit message, unless you're expecting the UNIX socket permissions
> > > > to be such that only processes under the qemu:qemu user:group pair
> > > > can access to the socket ? That would be a libvirt based permissions
> > > > assumption though.
> > > 
> > > Yes, this is why the systemd socket uses 600, like
> > > contrib/systemd/qemu-pr-helper.socket. The socket can be passed via
> > > SCM_RIGHTS by libvirt, or its permissions can be changed (e.g. 660 and
> > > root:kvm would make sense on a Debian system), or a separate helper
> > > can be started by libvirt.
> > > 
> > > Either way, the policy is left to the user rather than embedding it in
> > > the provided systemd unit.
> >
> > Ok, this code needs a comment to explain that we're relying on
> > socket permissions to control who/what can access the daemon,
> > combined with this PID+TID check to validate it is not spoofing
> > its identity, as without context the TID check looks pointless.
> 
> Hi Daniel,
> 
> would you prefer a comment in the code or a security section in the doc 
> (i.e docs/specs/rapl-msr.rst) ?

I think it is worth creating a docs/specs/rapl-msr.rst to explain the
overall design & usage & security considerations.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


