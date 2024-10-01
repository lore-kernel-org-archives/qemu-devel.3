Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2773CEACC5
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2024 14:08:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svdXN-0005uv-5g; Tue, 01 Oct 2024 10:07:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1svdXK-0005qp-WC
 for qemu-devel@nongnu.org; Tue, 01 Oct 2024 10:07:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1svdX3-0001WO-7x
 for qemu-devel@nongnu.org; Tue, 01 Oct 2024 10:07:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727791635;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=ujznXKr0TQUiECfO3RLoKbOSZFj5ptk2IB14cdGSCGA=;
 b=Wcc4bwdF/O7bGt9fwmBwetgDr5vz2cLeD4Uny9t8VaXjnd+ApNpWnNI+QKun7xRjgv0sld
 G5gpjNfquUIUNubvB2FfU3jPDqKwz3KW7tHym4w3STSneH8ntB5mCm7LeYog5evJsYzyxE
 JZsc4Ts3FkiCOAs3A3CxgxUz2iuiDcE=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-206-haCopkNrPlmvOsbuk_nZYw-1; Tue,
 01 Oct 2024 04:48:46 -0400
X-MC-Unique: haCopkNrPlmvOsbuk_nZYw-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (unknown
 [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 83F9B19626FE; Tue,  1 Oct 2024 08:48:45 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.186])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 15DE11979063; Tue,  1 Oct 2024 08:48:43 +0000 (UTC)
Date: Tue, 1 Oct 2024 09:48:40 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: John Snow <jsnow@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: Minimum sphinx version?
Message-ID: <Zvu3aIWyKEtUfHwN@redhat.com>
References: <CAFn=p-bfv=uRCGzODQDyK4mO1ct-7tG3REfN9pm0o=n2GBGKug@mail.gmail.com>
 <959ad3a2-505b-4d43-878f-027e359e8d54@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <959ad3a2-505b-4d43-878f-027e359e8d54@redhat.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
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

On Tue, Oct 01, 2024 at 10:28:50AM +0200, Paolo Bonzini wrote:
> On 9/30/24 19:16, John Snow wrote:
> > The current reality is that Sphinx 3.4.3 is our minimum because RHEL 9
> > offers that as the distro package and I have not dared bump our version
> > beyond that for fear of disrupting our ability to build docs on RHEL 9
> > without internet.
> > 
> > What I'd like to ask is: How adamant are we that we can build docs on
> > older platforms? Do we consider it part of our platform promise? Can we
> > bump Sphinx to a slightly newer version at the expense of offline doc
> > builds for RHEL 9?
> 
> Could we stop building QMP docs, if Sphinx is too old?  While at the same
> time keeping the same 3.x version and the ability to build man pages, which
> is the really important part.

I'm curious how much of SPhinx we actually leverage when generatnug
man pages ? Our content is primarily RST format. Would it be feasible
to just use rst2man for man pages, and just use sphinx for the HTML
docs ?

As I said in my other email though, IMHO, if the distro sphinx is too
old we should just auto-install the newer version that we need, as we
have set a precedent with meson. That way there's no need to disable
docs building

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


