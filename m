Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A929FE77188
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2025 15:42:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tUpEo-0007Tt-8f; Mon, 06 Jan 2025 10:41:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tUpEm-0007TZ-Rz
 for qemu-devel@nongnu.org; Mon, 06 Jan 2025 10:41:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tUpEl-0007yj-47
 for qemu-devel@nongnu.org; Mon, 06 Jan 2025 10:41:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736178109;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=sOnGLcFR+2xrulLlXY2SQ22NMkAIw03LESdQT6s4Y5k=;
 b=PegbGVYFPu00ZVlpbltt1N5NAivHC0SmTDAc4V0eligg24+53ur90L7zH+BC7X5hajKK22
 HdMkQ2yiOvM0ZPwHSOBNqoV1qK78y2dvPSgiw4dbFx5m7y8d8w+BngTb1qsmlVXEyUSjNd
 g30j3sCWG7GNdvDLVh6aOhVGsClAalE=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-227-1LDlDECMPaKaMvAfP7PKEQ-1; Mon,
 06 Jan 2025 10:41:46 -0500
X-MC-Unique: 1LDlDECMPaKaMvAfP7PKEQ-1
X-Mimecast-MFC-AGG-ID: 1LDlDECMPaKaMvAfP7PKEQ
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 441921956096; Mon,  6 Jan 2025 15:41:44 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.124])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F15AA19560A2; Mon,  6 Jan 2025 15:41:42 +0000 (UTC)
Date: Mon, 6 Jan 2025 15:41:39 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Joelle van Dyne <j@getutm.app>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Re: [PATCH 0/2] Disable unavailable features on older macOS
Message-ID: <Z3v5s9LdZih68uBH@redhat.com>
References: <20241223040945.82871-1-j@getutm.app>
 <CAFEAcA9kzT2qwThGFvNmZ4VQgVEA189dmGYwHu-FZftfJFAU-g@mail.gmail.com>
 <CA+E+eSBMNgxptk0RzKVMuvuBJ9XZquooCxabDB8ezWjmTa4R_w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+E+eSBMNgxptk0RzKVMuvuBJ9XZquooCxabDB8ezWjmTa4R_w@mail.gmail.com>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.446,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Jan 06, 2025 at 07:26:20AM -0800, Joelle van Dyne wrote:
> If the policy is macOS 12 or later then you still need patch 2-3 because
> currently it is broken on macOS 12.

Actually our min baseline for macOS is currently macOS 14.

Per the doc Peter mentions, we officially target the most recent release
(macOS 15), plus the previous release (macOS 14) for a further 2 years.

Anything older may or may not work at any given time, depending on
whether we've done any cleanups that drop stuff only required by the
older versions.
 
> 
> On Monday, January 6, 2025, Peter Maydell <peter.maydell@linaro.org> wrote:
> 
> > On Mon, 23 Dec 2024 at 04:10, Joelle van Dyne <j@getutm.app> wrote:
> > > Some features require APIs introduced in a recent version of macOS.
> > Currently,
> > > this is not checked anywhere and so either the build will fail (if
> > building with
> > > an older version of Xcode) or will throw a warning and then crash if run
> > on an
> > > older machine. The correct way to handle this is with availabilty
> > checks. The
> > > checks are a clang extension that only works on Apple platforms but
> > these files
> > > are only built for Apple platforms already and link with Apple
> > frameworks.
> >
> > We deliberately only support macos 12 or later and don't want
> > to carry code workarounds to build on earlier versions
> > (see eg commit 3bf445fbb1 which removes old ifdeffery needed by 11).
> > This is part of our "supported build platforms" policy
> > documented in docs/about/build-platforms.rst.
> >
> > thanks
> > -- PMM
> >

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


