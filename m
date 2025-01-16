Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC26CC02183
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2025 09:20:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYM2O-0006Dn-2a; Thu, 16 Jan 2025 04:19:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tYM2M-0006DN-12
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 04:19:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tYM2J-0006ML-KN
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 04:19:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737019173;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NaNpcZC03XR556acppGo2qY5hiEOeo5x3/frL0+2vVA=;
 b=Cpno7KeyptS78uJ/qgwfvpZcnDnamTq/iIh3vSgzYQ8k50BWAspIhf7SLygXHi7d5lSQVk
 3Bq6IeyWMYjxFKEyVpMcjWKuKH6n0GP9GTgYtkjpxLeBIN9kPO1w/MiYChzepRemJkIjxu
 POL/zqRgVk4+7kfhc41YZcjRzX/D+nw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-207-JXV3InpaPnCKx61B3Hjx-w-1; Thu,
 16 Jan 2025 04:19:28 -0500
X-MC-Unique: JXV3InpaPnCKx61B3Hjx-w-1
X-Mimecast-MFC-AGG-ID: JXV3InpaPnCKx61B3Hjx-w
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7E83219560A1; Thu, 16 Jan 2025 09:19:27 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.111])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AC07619560AA; Thu, 16 Jan 2025 09:19:24 +0000 (UTC)
Date: Thu, 16 Jan 2025 09:19:20 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Zhao Liu <zhao1.liu@intel.com>,
 "Michael S . Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] docs/about: Change notes on x86 machine type deprecation
 into a general one
Message-ID: <Z4jPGGezEK3XRMl8@redhat.com>
References: <20250116064644.65670-1-thuth@redhat.com>
 <ad3d06df-f0ae-4508-b979-c838b3647510@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ad3d06df-f0ae-4508-b979-c838b3647510@linaro.org>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
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

On Thu, Jan 16, 2025 at 09:48:50AM +0100, Philippe Mathieu-Daudé wrote:
> On 16/1/25 07:46, Thomas Huth wrote:
> > We now have a general note about versioned machine types getting
> > deprecated and removed at the beginning of the deprecated.rst file,
> > so we should also have a general note about this in removed-features.rst
> > (which will also apply to versioned non-x86 machine types) instead of
> > listing individual old machine types in the document.
> > 
> > Signed-off-by: Thomas Huth <thuth@redhat.com>
> > ---
> >   docs/about/deprecated.rst       |  7 -------
> >   docs/about/removed-features.rst | 11 +++++------
> >   2 files changed, 5 insertions(+), 13 deletions(-)
> > 
> > diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
> > index 4a3c302962..7b42d6eecc 100644
> > --- a/docs/about/deprecated.rst
> > +++ b/docs/about/deprecated.rst
> > @@ -236,13 +236,6 @@ deprecated; use the new name ``dtb-randomness`` instead. The new name
> >   better reflects the way this property affects all random data within
> >   the device tree blob, not just the ``kaslr-seed`` node.
> > -``pc-i440fx-2.4`` up to ``pc-i440fx-2.12`` (since 9.1)
> > -''''''''''''''''''''''''''''''''''''''''''''''''''''''
> > -
> > -These old machine types are quite neglected nowadays and thus might have
> > -various pitfalls with regards to live migration. Use a newer machine type
> > -instead.
> > -
> >   PPC 405 ``ref405ep`` machine (since 9.1)
> >   ''''''''''''''''''''''''''''''''''''''''
> > diff --git a/docs/about/removed-features.rst b/docs/about/removed-features.rst
> > index c6616ce05e..156c0c253c 100644
> > --- a/docs/about/removed-features.rst
> > +++ b/docs/about/removed-features.rst
> > @@ -972,6 +972,11 @@ from Linux in 2021, and is not supported anymore by QEMU either.
> >   System emulator machines
> >   ------------------------
> > +Note: Versioned machine types that have been introduced in a QEMU version
> > +that has initially been released more than 6 years before are considered
> > +obsolete and will be removed without further notice in this document.
> > +Please use newer machine types instead.
> 
> This is an improvement. I still wonder if we shouldn't list them removed
> machines here, to help old users.
> 
>   Removed in 4.0:
>     - pc-0.10
>     - ...
>   Removed in 9.0:
>     - pc-i440fx-2.3
>   Remove in 10.0:
>     - pc-i440fx-2.4
>     - pc-i440fx-2.5
>     - pc-i440fx-2.6
>     - pc-q35-2.4
>     - pc-q35-2.5
>     - pc-q35-2.6
>     - ARM virt-2.6
>     ...
> 
> ?

A big part of the reason for the macros for machine type deprecation & then
skipping machine registration, was to eliminate repeated manual work that is
visible to users if forgotten. 

We still have the actual code deletion which is manual, but that's harmless
as even if forgotten, such that the code exists, the machine type will have
been entirely removed from view.

As such I'm pretty reluctant to suggest we create a new place which needs
manually updating when we remove machine types.

I wonder if its possible to get an auto-generated version number into the
documentation though ?

eg, so we can have an entry in 'deprecated.rst'

  Versioned machine types for x86_64, i386, aarch64  <other targets here>
  -----------------------------------------------------------------------

  In accordance with our versioned machine type deprecation policy,
  all machine types older than 7.0.0 have been deprecated.

and in 'removed-features.rst'

  Versioned machine types for x86_64, i386, aarch64  <other targets here>
  -----------------------------------------------------------------------

  In accordance with our versioned machine type removal policy,
  all machine types older than 4.1.0 have been removed.


where both '7.0.0' and '4.1.0' are variables substituted in by the
docs generator in some manner, so we never need touch them manually ?

NB, this auto-deletion logic is currently hacked to only come into
effect from 10.1.0 onwards, so we're 1 cycle too early currently
(see commit c9fd2d9a48ee3c195cf83cc611b87b09f02f0013)

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


