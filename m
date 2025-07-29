Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30A19C83F26
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Jul 2025 16:35:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugnIO-0001bT-Ef; Tue, 29 Jul 2025 12:35:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1ugmyZ-0000Kf-IL
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 12:15:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1ugmyE-0000bZ-Jf
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 12:14:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753805666;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yiGyH8B88F/ydwXBYIRpYlSr2t4V4le1i+Z6GB3eDs4=;
 b=CUz3flAu0Db5U4pJZYi3NOmNthdseWdxf/PtYySX5XGYm19rWI7RAbJARAKfNYUPaI651A
 6lHIA+R3EnYJuXRpp/qyKnIVYsOFVwFJOoBO3T2kfzOj7TY3zAi/uPKukoYLjL5rSZ/ych
 sMbq0OsXJ+E6LvnO+gvyHj2C8kBMKwM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-241-igJnR-3WP26gelfMpfaJQA-1; Tue,
 29 Jul 2025 12:09:15 -0400
X-MC-Unique: igJnR-3WP26gelfMpfaJQA-1
X-Mimecast-MFC-AGG-ID: igJnR-3WP26gelfMpfaJQA_1753805354
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6197519560A3
 for <qemu-devel@nongnu.org>; Tue, 29 Jul 2025 16:09:14 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.12])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 675BC180035E; Tue, 29 Jul 2025 16:09:12 +0000 (UTC)
Date: Tue, 29 Jul 2025 17:09:09 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Andrea Bolognani <abologna@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH 2/2] watchdog: generic name for i6300esb
Message-ID: <aIjyJVKZff5MAnkt@redhat.com>
References: <20250610143259.1056400-3-cohuck@redhat.com>
 <aEhnbN1pSYgdi4EZ@redhat.com>
 <CABJz62O3FKYfUOyCLMotgYgckWV1frSUb=MtTW2J4fDTEg_==g@mail.gmail.com>
 <877c09792e.fsf@redhat.com> <aHZ7rpYFMWai-7RL@redhat.com>
 <CABJz62P+p_uYiatXroauLkG2AH2TnjS8drbHxLPsgY+=QSB8Lw@mail.gmail.com>
 <aHaC6_2vdXJqdxLo@redhat.com> <874iva7so9.fsf@redhat.com>
 <aHkboV03D6lSzpgK@redhat.com> <87tt2v3s16.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87tt2v3s16.fsf@redhat.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Tue, Jul 29, 2025 at 06:01:25PM +0200, Cornelia Huck wrote:
> On Thu, Jul 17 2025, Daniel P. Berrangé <berrange@redhat.com> wrote:
> 
> > On Thu, Jul 17, 2025 at 05:17:42PM +0200, Cornelia Huck wrote:
> >> On Tue, Jul 15 2025, Daniel P. Berrangé <berrange@redhat.com> wrote:
> >> 
> >> > On Tue, Jul 15, 2025 at 09:16:24AM -0700, Andrea Bolognani wrote:
> >> >> You can point them to documentation over and over again, or you can
> >> >> work to prevent the confusion/annoyance from showing up in the first
> >> >> place. Which of the two approaches is a better use of anyone's time
> >> >> is up for debate.
> >> >> 
> >> >> I for one am grateful that someone put the time in all those years
> >> >> ago and, as a result, PCI and USB controllers don't suffer from the
> >> >> problem today. Ultimately it's up to Connie though.
> >> >
> >> > The PCI/USB controller situation is not the same tradeoff though.
> >> > Those guest kernel drivers will identify and attach to these two
> >> > controllers regardless of their PCI vendor/product, via the PCI
> >> > class property. In that case changing the PCI ID and other device
> >> > metadata in QEMU is cheap as it has no negative impact on guest OS
> >> > driver compibility.
> >> >
> >> > In the case of 6300ESB though the guest driver is tied directly to
> >> > the currently used PCI device product/vendor ID.
> >> >
> >> > If we change this then we have actually created new functional
> >> > problems with guest/QEMU compatibility, in order to placate a
> >> > non-functional problem. That is not a good thing.
> >> 
> >> I don't think the suggestion was to disable the existing driver on
> >> non-Intel setups, but to add a more generic one. Still, more work to get
> >> this actually propagated into guests than doing the change in
> >> QEMU. Before I start down that route, I'd like to know whether the issue
> >> is actually big enough to make investing time there worth it.
> >
> > If we're a mmgmt app provisioning a guest, we have to choose what
> > watchdog to create - either the old one which works everywhere
> > that currently has a driver, or the new one will will work in
> > far fewer places. We'll have to wire up guest OS info about
> > watchdogs into osinfo, and then wire up all the mgmt apps to
> > query this and take action based off it. All possible, but it
> > still feels like a huge waste of time to me.
> 
> The fact that the device is something emulated and not the Intel
> hardware device is actually visible to the guest:
> 
> 00:02.0 System peripheral: Intel Corporation 6300ESB Watchdog Timer
> 	Subsystem: Red Hat, Inc. QEMU Virtual Machine
> 	Flags: fast devsel
> 	Memory at 10804000 (32-bit, non-prefetchable) [size=16]
> 	Kernel driver in use: i6300ESB timer
> 	Kernel modules: i6300esb
> 
> (lspci -v so unfortunately not immediately obvious, but still)
> 
> AFAIK the BSDs do not have a driver for this device at the moment -- and
> given what turns up when searching for i6300ESB, someone implementing a
> driver is far more likely to pick the exising PCI ID.

I see vague references (with unfortunately 404 links) to FreeBSD
supporting some ICH watchdogs, which might mean it is compatible
with the q35 built-in watchdog that all x86 q35 machines get by
default. That wouldn't help non-x86 BSD though.

> Windows would also need some dance according to Yan's mail, for unclear
> benefits.

Off-list, Richard Jones pointed to the ACPI Watchdog WADT specification
from Microsoft which appears to the most viable solution for Windows
guests - at least from x86 POV, but hopefully any future Wndows aarch64
too:

  https://download.microsoft.com/download/a/f/7/af7777e5-7dcd-4800-8a0a-b18336565f5b/HardwareWDTSpec.doc

The ACPI watchdog sounds like potentially the best bet for a working
solution across Linux and Windows, on any arch that does ACPI.... if
we can just find someone to write a QEMU driver for it....

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


