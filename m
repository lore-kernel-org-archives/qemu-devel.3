Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74709C3DA70
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2024 17:00:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sXOIP-00009K-Gi; Fri, 26 Jul 2024 12:59:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sXOIO-00008W-9p
 for qemu-devel@nongnu.org; Fri, 26 Jul 2024 12:59:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sXOIL-0003D3-LH
 for qemu-devel@nongnu.org; Fri, 26 Jul 2024 12:59:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722013190;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=hSLu4jn027/cByGI588DmGtg3B2C9cOApNc9SFCcP60=;
 b=Y4iIKUal65kdGH8spAAV1BH7VaAUng/M0az1An+NhOeQSEN7JPzCLN5fs+qami2d7GKcAz
 9zTJmX0hyLma/woZ3zN+GwYdx4gETtxioGRTUkJCYCU8MNQTN5sgTpyVPs3N7Q3dj+UuMw
 ISc9meTuywct9ZmEJy2NlcZ32CLNS5s=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-321-LWUPQy5_MDCMauy4Cmhwhw-1; Fri,
 26 Jul 2024 12:59:46 -0400
X-MC-Unique: LWUPQy5_MDCMauy4Cmhwhw-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3D52E195609E; Fri, 26 Jul 2024 16:59:44 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.32])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id ADF7F1955D48; Fri, 26 Jul 2024 16:59:41 +0000 (UTC)
Date: Fri, 26 Jul 2024 17:59:38 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH] .gitlab-ci.d/cirrus.yml: Shorten the runtime of the
 macOS and FreeBSD jobs
Message-ID: <ZqPV-s_7yav0eUT4@redhat.com>
References: <20240429100113.53357-1-thuth@redhat.com>
 <035f854c-78ff-4a8a-9356-1c55dca381b8@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <035f854c-78ff-4a8a-9356-1c55dca381b8@redhat.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
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

On Fri, Jul 26, 2024 at 11:18:43AM +0200, Thomas Huth wrote:
> 
> Looks like the reduction of this patch was not enough, we've run out of
> Cirrus-CI compute time again ... does anybody have additional ideas how we
> could avoid that in the future?

QEMU keeps getting bigger, so our attempts to cut down on what we
build mean we keep testing a narrower & narrower subset of
functionality. We long ago culled the obvious wastage.

One thing is to optimize our code such that it is less expensive
for the compiler. I feel like we've done that periodically already
with refactoring header files. It is a complex problem with no
quick wins to reduce compile time. If someone knows of more low
hanging fruit though, speak up.

Cirrus CI supports a "bring your hardware" model. We could do
that for FreeBSD testing, by leveraging our existnig Azure
account further to provide VMs. If doing that though, it'd
be saner to just do it in GitLab context directly. This huas
the burn of *us* maintaining FreeBSD images,and updating
them every time a new FreeBSD is released. ie you can't just
stick on 12.0, because when 12.1 is released, the ports
packages get rebuilt against new 12.1 and frequently become
uninstallable on the older minor release. IOW, we would have
a continual burden in updating our images to track FreeBSD
minor releases. Also this doesn't solve our macOS needs since
you can't just run macOS in any VM, it has to be Apple HW.

Cirrus CI lets you buy more CI credits. IIUC we get 50 credits
free each month. I can't see QEMU's usage, since it is private
to admins only:

  https://cirrus-ci.com/settings/github/qemu

if it is anything like libvirt though, I'm going to expect that
most of our credits are consumed by macOS, not FreeBSD, since
Cirrus CI charges for macOS at a higher level.

To stop running out of credits I guess we'll want to buy an
extra 20 credits in each freeze period - ie 60 a year. They
charge $1 per credit.

Does the QEMU project have funds available to spend on things
like this ?  It unfortunately requires a credit card to buy
more credits, so somehow QEMU would have to re-imburse an
individual maintainer for the purchase.

Final option is to make contact with Cirrus CI owners, and
ask if they might wish to directly sponsor QEMU in terms of
granting us extra credits, in exchange for including them on
our sponsor's page https://www.qemu.org/sponsors/.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


