Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0C9BC25B74
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2024 14:05:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCgON-0003lo-G0; Thu, 30 May 2024 10:04:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1sCgOL-0003lJ-Pn
 for qemu-devel@nongnu.org; Thu, 30 May 2024 10:04:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1sCgOK-00005f-5Z
 for qemu-devel@nongnu.org; Thu, 30 May 2024 10:04:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717077866;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hCmPzodcpjaqBAvPp9h5plRTq8Tn1tX2D8yUsgX5+Vk=;
 b=RaNo7DdUfgbglkY0hvCACot0rqWgNFY9tymQCkn6JZkAon/of5WLvgciY58iyrop5Yn0f5
 C2XDY25KUtTn9UFVQB7tiaHNMqzrtBIrXsskTKRHfrS93Pb7pX71oSGVgBYs5gFm92buIM
 Dp8QfjGH25zZCNmgZ3dWXoY5pALCuM0=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-641-3h2fko15Oke1Pe-F7YBg0A-1; Thu,
 30 May 2024 10:04:24 -0400
X-MC-Unique: 3h2fko15Oke1Pe-F7YBg0A-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 09C211C05136;
 Thu, 30 May 2024 14:04:24 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.192.101])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A7174400EAE;
 Thu, 30 May 2024 14:04:23 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 521F818000A9; Thu, 30 May 2024 16:04:22 +0200 (CEST)
Date: Thu, 30 May 2024 16:04:22 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org, 
 Eduardo Habkost <eduardo@habkost.net>, Eric Blake <eblake@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Subject: Re: [PATCH v2 4/4] vga/cirrus: deprecate, don't build by default
Message-ID: <usd6hvncbao47zklcb5qlpvjcuk7odryu57f45imxienyltlec@2ujm6g2gr2od>
References: <20240530112718.1752905-1-kraxel@redhat.com>
 <20240530112718.1752905-5-kraxel@redhat.com>
 <3efcf132-dec1-3765-e77e-3fd207224eeb@eik.bme.hu>
 <c928e9e7-21b2-4017-be45-b0a4b91f1d06@ilande.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c928e9e7-21b2-4017-be45-b0a4b91f1d06@ilande.co.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.085,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

  Hi,

> > > static const TypeInfo cirrus_vga_info = {
> > > diff --git a/hw/display/cirrus_vga_isa.c b/hw/display/cirrus_vga_isa.c
> > > index 84be51670ed8..3abbf4dddd90 100644
> > > --- a/hw/display/cirrus_vga_isa.c
> > > +++ b/hw/display/cirrus_vga_isa.c
> > > @@ -85,6 +85,7 @@ static void isa_cirrus_vga_class_init(ObjectClass
> > > *klass, void *data)
> > >     dc->realize = isa_cirrus_vga_realizefn;
> > >     device_class_set_props(dc, isa_cirrus_vga_properties);
> > >     set_bit(DEVICE_CATEGORY_DISPLAY, dc->categories);
> > > +    klass->deprecation_note = "use stdvga instead";
> > 
> > Excepr some old OSes work better with this than stdvga so could this be
> > left and not removed? Does it cause a lot of work to keep this device? I
> > thought it's stable already and were not many changes for it lately. If
> > something works why drop it?
> 
> Seconded: whilst stdvga is preferred, there are a lot of older OSs that work
> well in QEMU using the Cirrus emulation. I appreciate that the code could do
> with a bit of work, but is there a more specific reason that it should be
> deprecated?

Well, the cirrus has a 2d blitter implementation which I'd rate
problematic from both security and correctness point of view.

Also any guest new enough to still receive security updates can surely
use stdvga instead.  The "operating system museum" is IMHO pretty much
the only use case where it possibly might make sense to continue using
cirrus.

Having sayed that maybe the boolean classification -- be deprecated
or not -- is too simple.  The number of devices we can actually
deprecate and remove is probably relatively small.  But there also is
a large number of old-ish devices which only make sense in very few use
cases.  When running an old OS.  Or when emulating an old board.  Which
also tend to be not maintained very well because there are not many
users.  Maybe we need an "unsupported" state for them, with some
infrastructure like an easy way to compile qemu without unsupported
devices and an option to get warnings from qemu in case an unsupported
device is used.

take care,
  Gerd


