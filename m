Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D263C8303C
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Jul 2025 09:12:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uYhsk-0004VI-8d; Mon, 07 Jul 2025 05:11:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uYhsd-0004Td-Ln
 for qemu-devel@nongnu.org; Mon, 07 Jul 2025 05:11:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uYhsb-0001RH-4T
 for qemu-devel@nongnu.org; Mon, 07 Jul 2025 05:11:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751879473;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1fekg3BwsFGugQRAdgJvL8jSTwhU3kN5ndAQsd0O1rY=;
 b=OP7pn6e/O7JTmxER3nVNECJfHi31YdZ5pbYcwUpSTzPjsS1EPC+orQNqtd2iYH/oFXvR8+
 MQcbFmWiAJEUASaFn3ZcmZmbCuAZ2eO3JkSow6LBcLu/Yca8njQuGfWJR4ikPIv1atxlh0
 vDF9Q0LXtsIwv9qfVmwUwqCpa1iu7No=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-43-o8iRl1nbNmW3M0v7PEzy3A-1; Mon,
 07 Jul 2025 05:11:09 -0400
X-MC-Unique: o8iRl1nbNmW3M0v7PEzy3A-1
X-Mimecast-MFC-AGG-ID: o8iRl1nbNmW3M0v7PEzy3A_1751879469
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C499219560A1; Mon,  7 Jul 2025 09:11:08 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.155])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2A7A119560AD; Mon,  7 Jul 2025 09:11:02 +0000 (UTC)
Date: Mon, 7 Jul 2025 10:10:59 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, John Snow <jsnow@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: Re: Build platform guarantees, docs, tests, and snakes in the garden
Message-ID: <aGuPI4w505EoScGK@redhat.com>
References: <CAFn=p-YuqzXvWF-cGLUc0LVVMe2Rinx9+LOjvpHRY-vRrPyJow@mail.gmail.com>
 <23559c8d-149a-4ec6-adaa-fe0a8f8533f1@redhat.com>
 <87qzz9myd0.fsf@pond.sub.org>
 <CABgObfaqauR5SDe67ueAg9-VvJBxM5+LqrYTF3CYjjzzmY8d+w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABgObfaqauR5SDe67ueAg9-VvJBxM5+LqrYTF3CYjjzzmY8d+w@mail.gmail.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

On Wed, Jul 02, 2025 at 03:24:09PM -0400, Paolo Bonzini wrote:
> Il mar 24 giu 2025, 02:45 Markus Armbruster <armbru@redhat.com> ha scritto:
> 
> > > ... I think I value this a bit higher than Markus, but not really
> > because of offline builds.  Rather, keeping the "accepted" key lower (i.e.
> > supporting the packaged sphinx on a wide range of distros) makes it easier
> > to bump the "installed" key when needed, as in this failure to run 5.3.0
> > under Python 3.13.
> >
> > Showing my ignorance again...  I don't understand how keeping "accepted"
> > lower helps.
> >
> 
> Because it makes it easier to use distro Python. If distro Python is
> <accepted, configure's will try to use the "installed" version. If that
> version in turn is too new for distro Python, you're screwed. So you want
> to be as conservative as needed for accepted, but not more.
> 
> Regarding fool or pioneer: for sure we're extraordinarily kind towards
> distros. To some extent we have to do that because of 1) the possible
> competition of other VMMs that completely ignore distros (e.g. because they
> just use cargo)—packaging is an area where C still has an edge and we want
> to keep that edge 2) we're an infrastructure component that can't just tell
> users to grab a flatpak.
> 
> The distro policy (mostly conceived by Dan) has served us well, with only
> small adjustments needed to have newish version of Meson/Rust(*), and
> non-prehistoric versions of Python. I don't see a need to change it, since
> at this point we have the tools needed to manage the complexity.

Note that much of the commentary about distros versions has been in
relation to the distro packagers, but that was not my only target
in writing the distro policy. It was equally aimed at contributors
using such distros, as well as 3rd party vendors building solutions
on top of designated distro versions

You can say contributors should just pick newer containers for their
build env, or manually download newer deps, or have QEMU build fancy
scripts to auto-download newer deps. All of those options have a cost
to them, as compared to using what is already present in the distro.

In terms of 3rd party vendors, they can have similar roles to a distro
vendor, but are more likely to package up newer QEMU versions to run
on pre-existing distros.

A further goal of the support policy was to provide a mechanism to
eliminate exactly these kind of mail threads. Before we had the policy,
every single time someone wanted to bump the min version of any dep
we would have debates over whether it was OK or not, there was always
someone who wanted the old version of the distro forever.  Defining
the policy has allowed us to unconditionally bump the min versions of
our times on a usually reasonable timeframe, without needing to engage
in debate. We can just point people to our support policy when they
complained that they really wanted old versions X, Y, & Z.

Every time we make an exception to the policy, we undermine the benefits
we obtain from it, taking us back the old world where our min versions
were an inconsistent & arbitrary set, with little clear understanding
of when we would change, either by maintainers or users.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


