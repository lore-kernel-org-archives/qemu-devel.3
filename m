Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DD27C25B76
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 07:32:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEl80-0005FN-No; Wed, 05 Jun 2024 03:32:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1sEl7z-0005F8-HS
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 03:32:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1sEl7x-0006XU-9S
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 03:32:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717572727;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=y+iBVhSNU4M3qeFFPy4R5QHKD1Q1ZTRSjw27uVm6uj4=;
 b=ZOTwTmwZqbjyFVlDlaJDlOorfPO6wrMj1X/1zgWBHS7ahNtWOl0fTvUVgKToc0TbnvYI9w
 ppmUigbuzmsYnGkJk96/WoF4A1OxEolU3+Gh/Rdy0sYabYB3uOturRSKb1WqccCDwXIl+P
 Br3rvkOgy7iF8wusq8olReOHCF7GgTg=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-70-8puAAlKFMgmD-ZCnYV2bTQ-1; Wed,
 05 Jun 2024 03:32:05 -0400
X-MC-Unique: 8puAAlKFMgmD-ZCnYV2bTQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DFB921C0512A;
 Wed,  5 Jun 2024 07:32:04 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.192.217])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 38C94111E419;
 Wed,  5 Jun 2024 07:32:02 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id DAE53180098E; Wed,  5 Jun 2024 09:32:01 +0200 (CEST)
Date: Wed, 5 Jun 2024 09:32:01 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org, 
 Eduardo Habkost <eduardo@habkost.net>, Eric Blake <eblake@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 4/4] vga/cirrus: deprecate, don't build by default
Message-ID: <5p5ixsnr3a2stdm2eqc27rumetsm52yiwhmhn4cyduqxweui3e@ux4cqs2biswg>
References: <20240530112718.1752905-1-kraxel@redhat.com>
 <20240530112718.1752905-5-kraxel@redhat.com>
 <3efcf132-dec1-3765-e77e-3fd207224eeb@eik.bme.hu>
 <c928e9e7-21b2-4017-be45-b0a4b91f1d06@ilande.co.uk>
 <Zl2rxIYdohROHXbg@redhat.com>
 <40853796-e4a1-48ef-a61c-ae4984864e45@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40853796-e4a1-48ef-a61c-ae4984864e45@linaro.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

> > Upstream QEMU's scope is to emulate pretty much arbitrary hardware that
> > may have existed at any point in time. Emulating Cirrus is very much
> > in scope upstream, and even if there are other better VGA devices, that
> > doesn't make emulation of Cirrus redundant.
> > 
> > Downstream is a different matter - if a downstream vendor wants to be
> > opinionated and limit the scope of devices they ship to customers, it
> > is totally valid to cull Cirrus.
> 
> Few years ago I suggested qemu_security_policy_taint() "which allows
> unsafe (read "not very maintained") code to 'taint' QEMU security
> policy." (Gerd FYI):
> https://lore.kernel.org/qemu-devel/20210908232024.2399215-1-philmd@redhat.com/
> 
> Upstream we could add a boolean in DeviceClass about device security
> status / maintenance (or enum or bitfield); then downstreams could
> use it to be sure unsafe devices aren't linked in.

Yes, I think it makes sense to maintain that information upstream.  It
is useful information to have.  Even if upstream isn't going to enforce
something qemu could print useful hints.

So, the question is whenever we want go for a simple bool, or go for a
bitfield giving more detailed information.  Bits I think could be
useful:

  (1) OBJECT_STATUS_DEPRECATED
      Stuff we actually want remove.  Very few cases, maybe usb-hub.

  (2) OBJECT_STATUS_UNSAFE
      "not very maintained".  Probably need a better name for this.

  (3) OBJECT_STATUS_OUTDATED
      Old device where newer / better alternatives exist.

Looking at the USB host adapters I'd attach 2+3 to ohci and 3 to uhci
and ehci.  In general there is a lot of overlap for (2) + (3) though.

We might also have recommendation bits such as:

  (4) OBJECT_STATUS_VIRTUALIZATON
      Devices recommended for virtualization use cases
      (all virtio, xhci, ...).
     
> > IOW, I think device deprecation *framework* is relevant to include
> > upstream, but most actual usage of it will be downstream.

When doing it at ObjectClass not DeviceClass level we get introspection
support for (almost) free, so I'd do it for ObjectClass even if the vast
majority of users will be devices.

> > Upstream might use *object* deprecation, if we replace an backend
> > implementation with a different one.

Sounds like having OBJECT_STATUS_DEPRECATED makes sense even if we don't
have any device actually using that.

take care,
  Gerd


