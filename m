Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD4C4C25B74
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2024 13:19:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7b0M-0002gP-1o; Thu, 16 May 2024 09:18:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1s7b0K-0002fL-FT
 for qemu-devel@nongnu.org; Thu, 16 May 2024 09:18:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1s7b0I-0002c3-KY
 for qemu-devel@nongnu.org; Thu, 16 May 2024 09:18:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715865516;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=CwnIktJqlVWwGt+8SOtEAZjWeBK9rpXjyxzcpwPZwls=;
 b=LCkeOg6oR4cMiZbUBBb3gO7sIPvbwtxO4T1MI3nViXW5sChnCBmW+/D0Kc7AoEqotHvAWy
 V7lr4XYZ3mx+D0iyooXv2TqxBL0rDRBr+7wVCt5CFYFKgLh9HPYteR4Z9TT+wXs3ix3a7S
 3W/P5gFXgOQz0rUXOLLfeE4H2KbvKKU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-401-0kVeP3dhMZqDk4aYj46aag-1; Thu, 16 May 2024 09:18:32 -0400
X-MC-Unique: 0kVeP3dhMZqDk4aYj46aag-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7A3D081227E;
 Thu, 16 May 2024 13:18:32 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.51])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B235BC15BB1;
 Thu, 16 May 2024 13:18:31 +0000 (UTC)
Date: Thu, 16 May 2024 14:18:29 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH 2/4] MAINTAINERS: drop usb maintainership
Message-ID: <ZkYHpdwOJnHoX3KL@redhat.com>
References: <20240516120344.531521-1-kraxel@redhat.com>
 <20240516120344.531521-3-kraxel@redhat.com>
 <CAFEAcA8MenWrKkKUHY7Sair5iEqNz3VKqP=C7+cc1EW+jOdbnQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA8MenWrKkKUHY7Sair5iEqNz3VKqP=C7+cc1EW+jOdbnQ@mail.gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.022,
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

On Thu, May 16, 2024 at 02:11:52PM +0100, Peter Maydell wrote:
> On Thu, 16 May 2024 at 13:04, Gerd Hoffmann <kraxel@redhat.com> wrote:
> >
> > Remove myself from usb entries.
> > Flip status to "Orphan" for entries which have nobody else listed.
> 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 7f52e2912fc3..d81376f84746 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> 
> Thanks for your time and efforts in looking after these
> components in the past.
> 
> > @@ -2140,8 +2140,7 @@ F: tests/qtest/fuzz-sdcard-test.c
> >  F: tests/qtest/sdhci-test.c
> >
> >  USB
> > -M: Gerd Hoffmann <kraxel@redhat.com>
> > -S: Odd Fixes
> > +S: Orphan
> >  F: hw/usb/*
> >  F: stubs/usb-dev-stub.c
> >  F: tests/qtest/usb-*-test.c
> 
> Does RedHat have any corporate interest in finding somebody
> else to look after the USB components in future ?

It is a possibilty. We're still shipping USB stuff in RHEL, so we'll need
someone to keep an eye on things at least, which might conceivably turn
into a volunteer for maintainership. There's no one lined up right now
though, so consider it open season for any interested community member
to step forward.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


