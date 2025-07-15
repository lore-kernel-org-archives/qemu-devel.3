Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D001AC83F22
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 16:38:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubiem-0006qs-GO; Tue, 15 Jul 2025 12:37:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1ubi7X-0001Ry-LI
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 12:03:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1ubi7V-0000yO-GJ
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 12:03:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752595384;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kCaInNiP39PndaLDw2IPQeArVXkWexA2m8cgYM3ea9Q=;
 b=FBwugkvG3HTRV0sTGwXX/JzEVOWVE4OygLjlH87CdZk/5rsGzIJVQVrrWEJcMRK0JiLIfm
 h9TpQTJIVnZha6+cPqwvydcK6bIvyAAlMAj85DwjnvqPMbsEpfQZe26kfWbl+HSfJEtGXQ
 zsHZRVyVwZC3ZU/Icnf3HdOHq2J7xCw=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-58-9yRh91dkOxKaGJXt1gScNw-1; Tue,
 15 Jul 2025 12:03:01 -0400
X-MC-Unique: 9yRh91dkOxKaGJXt1gScNw-1
X-Mimecast-MFC-AGG-ID: 9yRh91dkOxKaGJXt1gScNw_1752595380
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0E36C19560AD
 for <qemu-devel@nongnu.org>; Tue, 15 Jul 2025 16:03:00 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.173])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id ECC0630001B5; Tue, 15 Jul 2025 16:02:57 +0000 (UTC)
Date: Tue, 15 Jul 2025 17:02:54 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Andrea Bolognani <abologna@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH 2/2] watchdog: generic name for i6300esb
Message-ID: <aHZ7rpYFMWai-7RL@redhat.com>
References: <20250610143259.1056400-1-cohuck@redhat.com>
 <20250610143259.1056400-3-cohuck@redhat.com>
 <aEhnbN1pSYgdi4EZ@redhat.com>
 <CABJz62O3FKYfUOyCLMotgYgckWV1frSUb=MtTW2J4fDTEg_==g@mail.gmail.com>
 <877c09792e.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <877c09792e.fsf@redhat.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Jul 15, 2025 at 05:44:25PM +0200, Cornelia Huck wrote:
> On Tue, Jul 15 2025, Andrea Bolognani <abologna@redhat.com> wrote:
> 
> > On Tue, Jun 10, 2025 at 06:12:12PM +0100, Daniel P. Berrangé wrote:
> >> On Tue, Jun 10, 2025 at 04:32:59PM +0200, Cornelia Huck wrote:
> >> > The Intel 6300 Enterprise SouthBridge is a south bridge for a more or
> >> > less obscure embedded Intel system; however, the i6300esb watchdog
> >> > device we implement in QEMU is a virtual watchdog device that should
> >> > work well on any PCI-based machine, is well supported by Linux guests,
> >> > and used in many examples on how to set up a virtual watchdog.
> >> >
> >> > Let's use "virtual i6300ESB" in the description to make clear that
> >> > this device will work just fine on non-Intel platforms.
> >> >
> >> > Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> >> > ---
> >> >  hw/watchdog/wdt_i6300esb.c | 2 +-
> >> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> I'm not entirely sold on the idea that this is needed, but at the same
> >> time I won't object so
> >>
> >> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
> >
> > I would argue that this change is incorrect.
> >
> > While the QEMU device can be used for non-x86 VMs, it *is* faithfully
> > modelled after an Intel part, and the guest OS will recognize it as
> > such:
> >
> >   # lspci | grep 6300
> >   07:01.0 System peripheral: Intel Corporation 6300ESB Watchdog Timer
> >
> > What we actually need to do is create a new QEMU device with distinct
> > PCI IDs, same as we've done in the past for qemu-xhci, pcie-root-port
> > and pcie-to-pci-bridge.
> >
> > That will take a lot longer to integrate throughout the stack and be
> > supported across the various guest OS, but it's the only approach
> > that eventually leads to truly Intel-free non-x86 VMs.
> 
> Hmm. So
> - request a new PCI id (probably in the PCI_DEVICE_ID_REDHAT_* space)
> - restructure to have two devices base off the same core functionality
> - teach guest operating systems about the new device
> - teach management software like libvirt about the new device
> 
> Not sure how fast we can get an ID (or even how to go about it.) The
> second step should be reasonably easy. The third step is the most
> complex one, but at least teaching Linux should hopefully be easy
> enough, and existing guest operating systems could continue to use the
> existing device. The last step is probably not that bad.
> 
> I can start down that path, if we have some consensus that this is the
> right way to handle this.
> 
> I'd still argue that patch 1 should be applied regardless :)

This sounds like a hell of alot of busy work to fix a problem that, IIUC,
does not actually exist from a functional POV - it is merely a perception
issue that people might be put off by the "Intel 6300ESB" names.

IMHO a better use of time is to expand documentation to clarify this is
just fine for all PCI architectures, and change nothing in either QEMU
or guest kernels.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


