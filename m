Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5FEAC3DA5D
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2024 10:01:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWvHh-00043X-Rq; Thu, 25 Jul 2024 06:01:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sWvHg-0003wO-D5
 for qemu-devel@nongnu.org; Thu, 25 Jul 2024 06:01:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sWvHe-0004T5-E5
 for qemu-devel@nongnu.org; Thu, 25 Jul 2024 06:01:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721901671;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vIsbzFfxirS6rKR+qdsC2KdQw08HZtbdDgdwSAfv8Ks=;
 b=SP1aGsJnDF93FjFKM05EKLcwuojZEnuXdnpncJ6jn8wT72f5c7lfYW3i7Qz/q0reol83wt
 W6So4XV8H5JROtwCM5QVSRhv0oN7Qfim/HtX6Jl3BIMvUMNKSTqU6hev8clM6Q0FnQ6+Ei
 h8UFY1XIocQVVVM8CI0sbcsqkHdHdmk=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-389-GY7MncIUOeaO29BENe9F2g-1; Thu,
 25 Jul 2024 06:01:08 -0400
X-MC-Unique: GY7MncIUOeaO29BENe9F2g-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2F17F1956064; Thu, 25 Jul 2024 10:01:03 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.144])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 31B2B1955D42; Thu, 25 Jul 2024 10:00:59 +0000 (UTC)
Date: Thu, 25 Jul 2024 11:00:56 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Beraldo Leal <bleal@redhat.com>,
 Alex =?utf-8?B?QmVubsOp?= e <alex.bennee@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH 0/2] gitlab: expose installed package info in build logs
Message-ID: <ZqIiWH3XPsUJNAEG@redhat.com>
References: <20240724095505.33544-1-berrange@redhat.com>
 <h6b6l.5yloo5aflex@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <h6b6l.5yloo5aflex@linaro.org>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.136,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Jul 25, 2024 at 12:42:18PM +0300, Manos Pitsidianakis wrote:
> Hello Daniel,
> 
> On Wed, 24 Jul 2024 12:55, "Daniel P. Berrangé" <berrange@redhat.com> wrote:
> > Many times we see a build job start failing, we wonder if the installed
> > packages have changed since the last passing build. We can rarely
> > diagnose this, however, since we only have the new container image, not
> > the old one.
> > 
> 
> APT allows you to specify to pin package versions when installing; wouldn't
> that help ensure our tests are deterministic?

We want to be testing against latest packages because that reflects
what our users are likely to see on their own systems. IOW, having
failures after newly updated packages is a good thing - provided we
can easily identify what caused the breakage, to enable us to fix
it promptly - by promptly I mean same-day.

> Furthermore, a gitlab cron job pipeline can be set up to run every e.g. few
> months and inform of any updates so that we can manually bump them.

Only seeing breakage from new packages as long as a few months after it
happens is a bad thing. We benefit from fast detection and fast fixing.
In cases where the new package is broken, rather than QEMU, it is also
better to be able to report that back to the distro within days of them
rolling out the problem as it'll be fresh in their minds to fix.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


