Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 965F4C10F1A
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2024 15:13:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzHnJ-0005Ab-41; Tue, 23 Apr 2024 11:10:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rzHn9-0004gF-Fy
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 11:10:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rzHn5-0000HN-Sm
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 11:10:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713885036;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=+qj2Zekoq2Y6RPkbtnbVvyfO9neBSTU7GLx3cEusXR4=;
 b=gLwxMLmOdogme90kP37dPcxMqsPBG0uA1hKAfaIJq2VOhLEEcN/Bty9Bvd+tZAZmpTUjh8
 WtRSbO3dYYru8sBxQtYpkX55sdVM3fA0A5VKXOizp32m83II2MjKA5XJm6QlFxVlEyQKKd
 S9j8s6DJbEsmumPL0MgVwZxlmVV8VpQ=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-449-LVNoL3VrOuGxhLJ0Wj4dsQ-1; Tue,
 23 Apr 2024 11:10:28 -0400
X-MC-Unique: LVNoL3VrOuGxhLJ0Wj4dsQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3C2161C0C64D;
 Tue, 23 Apr 2024 15:10:28 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.127])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 30268406D72E;
 Tue, 23 Apr 2024 15:10:26 +0000 (UTC)
Date: Tue, 23 Apr 2024 16:10:24 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Helge Deller <deller@gmx.de>
Cc: Cole Robinson <crobinso@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 "Richard W.M. Jones" <rjones@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: Re: hppa-firmware.img missing build-id
Message-ID: <ZifPYEXIsELVWmgo@redhat.com>
References: <6c469c05-1bc5-4fd8-89f1-130f5aba5ff8@redhat.com>
 <d0e87002-ee5e-4a80-b850-1660bc5f2c80@redhat.com>
 <96f04d1a-2470-4118-8e07-b864f58f241e@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <96f04d1a-2470-4118-8e07-b864f58f241e@gmx.de>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.67,
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

On Tue, Apr 23, 2024 at 05:07:17PM +0200, Helge Deller wrote:
> On 4/23/24 16:58, Cole Robinson wrote:
> > On 4/23/24 10:11 AM, Cole Robinson wrote:
> > > Hi,
> > > 
> > > hppa-firmware.img and hppa-firmware64.img in qemu.git are missing ELF
> > > build-id annotations. rpm builds on Fedora will error if an ELF binary
> > > doesn't have build-id:
> > > 
> > > RPM build errors:
> > >      Missing build-id in
> > > /tmp/rpmbuild/BUILDROOT/qemu-9.0.0-1.rc2.fc41.x86_64/usr/share/qemu/hppa-firmware.img
> > >      Missing build-id in
> > > /tmp/rpmbuild/BUILDROOT/qemu-9.0.0-1.rc2.fc41.x86_64/usr/share/qemu/hppa-firmware64.img
> > >      Generating build-id links failed
> > > 
> > > I didn't hit this with qemu 8.2.* builds FWIW
> > > 
> > 
> > Though checking older bundled hppa-firmware binaries with `readelf` I
> > don't see build-id either, so now I'm not sure why those RPM builds were
> > passing.
> > 
> > FWIW the RPM check is deep in RPM code:
> > https://github.com/rpm-software-management/rpm/blob/68d0f3119c3d46b6184f4704edb51749ce9f819e/build/files.c#L1976
> > 
> > Maybe something else in hppa-firmware ELF headers caused this check to
> > be skipped in the past
> 
> Maybe Fedora ignores binaries which don't have the executable flag set?

Yes, that's probably it. qemu 9.0.0 has +x set on the hppa-firmware
images, while qemu 8.2.0 does not have +x set.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


