Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30488C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2024 16:33:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwljm-0004oV-2A; Tue, 16 Apr 2024 12:32:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rwljg-0004nV-H2
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 12:32:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rwlje-0004wX-I1
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 12:32:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713285161;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=0WY02Ebu4/JhSSet5dm+i0uDT+8jAlKYWWUPwC52I+M=;
 b=ZaiOkiLf1gYCbejqgwkrcZKr0HXaofBwsEtL4NV7Dufl5G1KMoSOr1E4TvEoxS/P3ZWGNG
 G94aiR3z9RbHmvrVEP9x1lZrJm4KYNINtM1Rn4CfT0dd3ZM8C1fkqx91jTC0Xdutqg6ccu
 Hk93iekb1ACUHaw9lQveNdIIdGhns7A=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-116-B00Hp3kFMveKBZ25EAAt_Q-1; Tue,
 16 Apr 2024 12:32:39 -0400
X-MC-Unique: B00Hp3kFMveKBZ25EAAt_Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3A39D3826100;
 Tue, 16 Apr 2024 16:32:39 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.173])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7C1252026962;
 Tue, 16 Apr 2024 16:32:38 +0000 (UTC)
Date: Tue, 16 Apr 2024 17:32:32 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Zhao Liu <zhao1.liu@intel.com>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Peter Dave Hello <hsu@peterdavehello.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Re: [PATCH] Add zh_TW Traditional Chinese translation
Message-ID: <Zh6oIH8Ihyn-9RwT@redhat.com>
References: <adPv4goMCNmjeDRUK1LGCAHIZdOxvMoFAqlU1bCnvTCPsCTUFRQnOQnThBC3oIzU9IczdS6aw1vKLQ-w7Zk9CRo5FfvINiaInut_U4VwbeI=@peterdavehello.org>
 <CAFEAcA_D1+BUk01mXNwRehxYqyXQU+Zu98sWBujauk5L2tHh3w@mail.gmail.com>
 <Zh6qLCvyiSk6YkVy@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Zh6qLCvyiSk6YkVy@intel.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.844,
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

On Wed, Apr 17, 2024 at 12:41:16AM +0800, Zhao Liu wrote:
> Hi Peter,
> 
> On Tue, Apr 16, 2024 at 02:27:45PM +0100, Peter Maydell wrote:
> > Date: Tue, 16 Apr 2024 14:27:45 +0100
> > From: Peter Maydell <peter.maydell@linaro.org>
> > Subject: Re: [PATCH] Add zh_TW Traditional Chinese translation
> > 
> > On Tue, 16 Apr 2024 at 14:00, Peter Dave Hello <hsu@peterdavehello.org> wrote:
> > >
> > > From: Peter Dave Hello <hsu@peterdavehello.org>
> > > Date: Tue, 16 Apr 2024 00:43:29 +0800
> > > Subject: [PATCH] Add a simple zh_TW Traditional Chinese translation
> > >
> > > This patch adds a basic zh_TW translation file for Taiwan Traditional
> > > Chinese users.
> > >
> > > Signed-off-by: Peter Dave Hello <hsu@peterdavehello.org>
> > 
> > This name in your Signed-off-by line doesn't match the
> > name you use in the .po file...
> > 
> > > ---
> > >  po/LINGUAS  |  1 +
> > >  po/zh_TW.po | 93 +++++++++++++++++++++++++++++++++++++++++++++++++++++
> > >  2 files changed, 94 insertions(+)
> > >  create mode 100644 po/zh_TW.po
> > >
> > > diff --git a/po/LINGUAS b/po/LINGUAS
> > > index 9b33a36..08163e8 100644
> > > --- a/po/LINGUAS
> > > +++ b/po/LINGUAS
> > > @@ -7,3 +7,4 @@ sv
> > >  tr
> > >  uk
> > >  zh_CN
> > > +zh_TW
> > > diff --git a/po/zh_TW.po b/po/zh_TW.po
> > > new file mode 100644
> > > index 0000000..d25557e
> > > --- /dev/null
> > > +++ b/po/zh_TW.po
> > > @@ -0,0 +1,93 @@
> > > +# Chinese translations for PACKAGE package.
> > > +# Copyright (C) 2024 THE PACKAGE'S COPYRIGHT HOLDER
> > > +# This file is distributed under the same license as the PACKAGE package.
> > 
> > Can you replace all these placeholder ALLCAPS items
> > with the right values, please?
> > 
> > > +# Peter Hsu <hsu@peterdavehello.org>, 2024.
> > > +#
> 
> Open source license is missing here.
> 
> And I checked the other .po files and found that none of them declare
> the open source license, are they missing it? Or does this case default
> to "GPL-2.0-or-later"?

Best practice is for every file to mention its license, ideally
using the "SPDX-Identifier"  tag syntax for new files.

If any file is missing a license header statement, then implicitly it
falls under the LICENSE file rules, which is GPL-2.0-or-later. 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


