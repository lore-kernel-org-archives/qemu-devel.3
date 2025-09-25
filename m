Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93624CAC5A5
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Sep 2025 09:25:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1iC5-0004Eu-Dd; Thu, 25 Sep 2025 05:23:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v1iC3-0004E7-NL
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 05:23:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v1iBt-0005Cr-Sc
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 05:23:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758792178;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EDNDT4FNoK6GQ8eN6psaSruvoKJiTaRx0npiYqCJdRA=;
 b=H5D3cESAHT2ClUshP3nZM/pflcZe7dI5QqspQ0Sv1nJocfJD72l8PFW8pjI7Irr/fqFDjV
 Of+ixAV5WGl+UfH/Rwb8eYxQNBHXnoYn1zfdYcs0kdJzzCEV6fYoCJ/BQEFQEE2dG6yCo0
 yi8n8yM+3z6WvK99/fQkW2QaOgQPQok=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-201-WTxLzeHHOQaW33-TgPlJSg-1; Thu,
 25 Sep 2025 05:22:53 -0400
X-MC-Unique: WTxLzeHHOQaW33-TgPlJSg-1
X-Mimecast-MFC-AGG-ID: WTxLzeHHOQaW33-TgPlJSg_1758792171
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D92D919774DD; Thu, 25 Sep 2025 09:22:49 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.163])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 006961800579; Thu, 25 Sep 2025 09:22:41 +0000 (UTC)
Date: Thu, 25 Sep 2025 10:22:38 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Bernhard Beschow <shentey@gmail.com>, Thomas Huth <thuth@redhat.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, qemu-riscv@nongnu.org,
 qemu-ppc@nongnu.org, Huacai Chen <chenhuacai@kernel.org>,
 qemu-s390x@nongnu.org, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Song Gao <gaosong@loongson.cn>, Bibo Mao <maobibo@loongson.cn>,
 P J P <pjp@fedoraproject.org>
Subject: Re: [RFC PATCH] docs/system/security: Restrict "virtualization use
 case" to specific machines
Message-ID: <aNUJ3mzbyELmXam8@redhat.com>
References: <20250908125058.220973-1-peter.maydell@linaro.org>
 <20250908104125-mutt-send-email-mst@kernel.org>
 <aL7zAV3xh-idgX8P@redhat.com>
 <9b91b4f3-2b26-4008-a783-ec1d30030389@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9b91b4f3-2b26-4008-a783-ec1d30030389@linaro.org>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.444,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Thu, Sep 25, 2025 at 02:05:17AM +0200, Philippe Mathieu-Daudé wrote:
> On 8/9/25 17:15, Daniel P. Berrangé wrote:
> > On Mon, Sep 08, 2025 at 10:45:40AM -0400, Michael S. Tsirkin wrote:
> > > On Mon, Sep 08, 2025 at 01:50:57PM +0100, Peter Maydell wrote:
> > > > Currently our security policy defines a "virtualization use case"
> > > > where we consider bugs to be security issues, and a
> > > > "non-virtualization use case" where we do not make any security
> > > > guarantees and don't consider bugs to be security issues.
> > > > 
> > > > The rationale for this split is that much code in QEMU is older and
> > > > was not written with malicious guests in mind, and we don't have the
> > > > resources to audit, fix and defend it.  So instead we inform users
> > > > about what the can in practice rely on as a security barrier, and
> > > > what they can't.
> > > > 
> > > > We don't currently restrict the "virtualization use case" to any
> > > > particular set of machine types.  This means that we have effectively
> > > > barred ourselves from adding KVM support to any machine type that we
> > > > don't want to put into the "bugs are security issues" category, even
> > > > if it would be useful for users to be able to get better performance
> > > > with a trusted guest by enabling KVM. This seems an unnecessary
> > > > restriction, and in practice the set of machine types it makes
> > > > sense to use for untrusted-guest virtualization is quite small.
> > > > 
> > > > Specifically, we would like to be able to enable the use of
> > > > KVM with the imx8 development board machine types, but we don't
> > > > want to commit ourselves to having to support those SoC models
> > > > and device models as part of QEMU's security boundary:
> > > > https://lore.kernel.org/qemu-devel/20250629204851.1778-3-shentey@gmail.com/
> > > > 
> > > > This patch updates the security policy to explicitly list the
> > > > machine types we consider to be useful for the "virtualization
> > > > use case".
> > > 
> > > This use-case sounds reasonable to me. I also imagine that
> > > some machines can get fixed down the road perhaps to
> > > the point where they enter the "virtualization use case".
> > > 
> > > However, since we are
> > > getting this elaborate, would my old idea of a runtime flag
> > > make sense now?
> > > 
> > > To recap, the idea was to add a "-virt" flag that will
> > > block any machines, devices and so on not considered
> > > part of the "virtualization use case".
> > > 
> > > We could also create a mechanism for downstreams to
> > > tweak this as they see fit.
> > 
> > I would not consider "virtualization use case" to be something we
> > want to represent in code. It was just a crude hack for the docs
> > to approximate what we wanted to /initially/ aim to support.
> > 
> > The ideal theoretical end state would be for everything to be
> > in scope for security fixes, but we'll probably never get that
> > far. The reality is that we have a granular decision likely at
> > the level of individaul QOM/QDev types.
> > 
> > If we wanted any flag it would be better expressed as something
> > like "security-boundary=yes|no', and then each object would need
> > to have a tri-state property "security-boundary=undefined|yes|no".
> > 
> > Initially everything would be in the 'undefined' category and
> > over a long series of patches we would then reclassify as much
> > as possible to "yes" or "no".
> 
> I find "yes" to give too much trust and fragile, since it is easy
> to introduce (security) bug and discover them later, usually too late.

This isn't promising that QEMU is free of security bugs - that is
impossible to claim for anything. It is telling the user that this
is a set of features that have been written with a credible attempt
to provide a security boundary, and thus they can rely on them to
confine untrusted workloads.

> FTR our previous discussion about taintable runtime API:
> https://lore.kernel.org/qemu-devel/YVWRw0ZKq3G6P5YP@redhat.com/

I think it is good to treat each piece of information as independent.
ie something can be considered secure, while at the same time also
be deprecated. Or something can be considered suitable for production
usage, while also being insecure. e.g. TCG can be used in production,
but you shouldn't used it with untrusted guests. I'm not sure that
a notion of "production" really makes sense at all, as that is
somewhat dependent on use case and the user's POV.

I'd see three pieces of useful info - deprecation status (bool),
security status (bool),  maintainer status (enum), and each can be
tackled independently, not least to make the work more practical. 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


