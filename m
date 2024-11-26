Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73466D3B986
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2024 11:36:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFtre-0008VO-8J; Tue, 26 Nov 2024 06:36:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tFtrY-0008Pz-Ca
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 06:36:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tFtrV-0005wP-PK
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 06:36:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732620966;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mZDUYvYTKnZZO3PtW6asw5ha3SrWITHuZt3hl2ySrdQ=;
 b=DQpyWrqy9IgxrsF72aq35xtMV9XT1aId4paLTk+7FqkE/b6Bcv64Ok5Asq+zSJS9ILuzgu
 f5y0J9kRFpRMQ9QeXgJYUWOBbNTXhZVM2zKM7+ECMKshEoMjcl4PgVI+X9SazDZ0TvnGu/
 UhRADNR+rGKOV1xPsore2d1ss2F8hOA=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-550-8hNB7vEeMxCcb6sCar9eVg-1; Tue,
 26 Nov 2024 06:36:04 -0500
X-MC-Unique: 8hNB7vEeMxCcb6sCar9eVg-1
X-Mimecast-MFC-AGG-ID: 8hNB7vEeMxCcb6sCar9eVg
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B7F641955F35; Tue, 26 Nov 2024 11:36:03 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.147])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 49866195E485; Tue, 26 Nov 2024 11:36:00 +0000 (UTC)
Date: Tue, 26 Nov 2024 11:35:57 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH] meson.build: Refuse XCode versions < v15.0
Message-ID: <Z0WyndfeK7RiZJIC@redhat.com>
References: <20241126081054.244365-1-thuth@redhat.com>
 <6f883a0f-3fdb-4326-8262-c0482e30ea32@linaro.org>
 <Z0WTkQYWaNlnGipo@redhat.com>
 <f3c726b6-403d-462b-9973-eb51a8447f94@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f3c726b6-403d-462b-9973-eb51a8447f94@linaro.org>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_SBL_A=0.1 autolearn=ham autolearn_force=no
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

On Tue, Nov 26, 2024 at 12:11:43PM +0100, Philippe Mathieu-Daudé wrote:
> On 26/11/24 10:23, Daniel P. Berrangé wrote:
> > On Tue, Nov 26, 2024 at 09:57:15AM +0100, Philippe Mathieu-Daudé wrote:
> > > On 26/11/24 09:10, Thomas Huth wrote:
> > > > According to our support policy, we only support the two latest
> > > > major versions of macOS, and we already removed compatibility code
> > > > for older versions. However, it's still possible that people install
> > > > an older version of XCode on a recent version of macOS - which won't
> > > > be able to compile QEMU anymore, see for example the ticket here:
> > > > 
> > > >    https://gitlab.com/qemu-project/qemu/-/issues/2694
> > > 
> > > Wondering about this issue, it is possible to install concurrent
> > > XCode versions, which is useful i.e. when you build an application
> > > targeting multiple (and older) App Store releases. See:
> > > https://xcodereleases.com/
> > 
> > That's true of any platform. You can get many GCC versions for Debian
> > and Fedora too.
> > 
> > > Maybe we need to clarify our support policy that we only support
> > > the XCode released with the 2 latest major macOS versions?
> > 
> > We implicitly support the XCode versions that are the "default" with
> > the latest 2 macOS versions.
> 
> Implicit might not be sufficient for users, see #2694.

Well I'm not convinced the persno in that bug report would have
read the docs regardless. 

This patch takes care of making it explicit in a way that can't
be missed though.

> 
> > > > @@ -315,8 +315,8 @@ foreach lang : all_languages
> > > >        # ok
> > > >      elif compiler.get_id() == 'clang' and compiler.compiles('''
> > > >          #ifdef __apple_build_version__
> > > > -      # if __clang_major__ < 12 || (__clang_major__ == 12 && __clang_minor__ < 0)
> > > > -      #  error You need at least XCode Clang v12.0 to compile QEMU
> > > > +      # if __clang_major__ < 15 || (__clang_major__ == 15 && __clang_minor__ < 0)
> > > > +      #  error You need at least XCode Clang v15.0 to compile QEMU
> > > >          # endif
> > > >          #else
> > > >          # if __clang_major__ < 10 || (__clang_major__ == 10 && __clang_minor__ < 0)
> > > > @@ -325,7 +325,7 @@ foreach lang : all_languages
> > > >          #endif''')
> > > >        # ok
> > > >      else
> > > > -    error('You either need GCC v7.4 or Clang v10.0 (or XCode Clang v12.0) to compile QEMU')
> > > > +    error('You either need GCC v7.4 or Clang v10.0 (or XCode Clang v15.0) to compile QEMU')
> > > 
> > > BTW apparently CentOS 8 (which we don't support anymore IIRC)
> > > provides Clang 12.0.1, and also Ubuntu 22.04, Alpine 3.16.
> > > 
> > > I wonder if the relation with XCode __apple_build_version__ is
> > > always __clang_major__ + 3...
> > 
> > No, it isn't. It varies all over the place -
> > 
> > eg
> > 
> >  From xcode 11.3 to 11.4 they bump from llvm 8.0.0 to 9.0.0, while the
> > clang version goes from 11.0.0 to 11.0.3.
> > 
> >  From xcode 15.4 to 16.0 they from llmvm 16.0.0 to 17.0.6, while the
> > clang version goes from 15.0.0 to 16.0.0.
> > 
> > I can just about interpret a rule they're following, but relating that
> > to the upstream clang versions algorithmically is impossible.
> > 
> >    https://en.wikipedia.org/wiki/Xcode#Toolchain_versions
> 
> Doh...
> 
> Anyway, for this patch:
> 
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


