Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CABCC83F17
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 16:54:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubiuL-0008U9-AE; Tue, 15 Jul 2025 12:53:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1ubibQ-0001ro-3t
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 12:34:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1ubibO-00024z-1m
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 12:33:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752597236;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2IiM6oOq3bf8NGqHVqQwL/vI+ZcohsPzarKDhi0MFxw=;
 b=IxnR51z5otMn6Pg3ZooHKqk9gcxjfKsLJab7diZQF2feNa5i3WKXHkVv+gxGek75YKnOWO
 1Kl7tmGAECQTfzfi0KP9672Mgi1eQX5iMWyYgGSbgbh4Plc1EmlxxSMJGn1aL3en+0hQs+
 1WelNWvBhkz+KskCVzOjGxXs2hPKrAM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-647-e5Db-tDDOrKLfTbk-qmheQ-1; Tue,
 15 Jul 2025 12:33:53 -0400
X-MC-Unique: e5Db-tDDOrKLfTbk-qmheQ-1
X-Mimecast-MFC-AGG-ID: e5Db-tDDOrKLfTbk-qmheQ_1752597233
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E5BAF1800247
 for <qemu-devel@nongnu.org>; Tue, 15 Jul 2025 16:33:52 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.173])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B947B19560AF; Tue, 15 Jul 2025 16:33:50 +0000 (UTC)
Date: Tue, 15 Jul 2025 17:33:47 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Andrea Bolognani <abologna@redhat.com>
Cc: Cornelia Huck <cohuck@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH 2/2] watchdog: generic name for i6300esb
Message-ID: <aHaC6_2vdXJqdxLo@redhat.com>
References: <20250610143259.1056400-1-cohuck@redhat.com>
 <20250610143259.1056400-3-cohuck@redhat.com>
 <aEhnbN1pSYgdi4EZ@redhat.com>
 <CABJz62O3FKYfUOyCLMotgYgckWV1frSUb=MtTW2J4fDTEg_==g@mail.gmail.com>
 <877c09792e.fsf@redhat.com> <aHZ7rpYFMWai-7RL@redhat.com>
 <CABJz62P+p_uYiatXroauLkG2AH2TnjS8drbHxLPsgY+=QSB8Lw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABJz62P+p_uYiatXroauLkG2AH2TnjS8drbHxLPsgY+=QSB8Lw@mail.gmail.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
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

On Tue, Jul 15, 2025 at 09:16:24AM -0700, Andrea Bolognani wrote:
> On Tue, Jul 15, 2025 at 05:02:54PM +0100, Daniel P. Berrangé wrote:
> > On Tue, Jul 15, 2025 at 05:44:25PM +0200, Cornelia Huck wrote:
> > > Hmm. So
> > > - request a new PCI id (probably in the PCI_DEVICE_ID_REDHAT_* space)
> > > - restructure to have two devices base off the same core functionality
> > > - teach guest operating systems about the new device
> > > - teach management software like libvirt about the new device
> > >
> > > Not sure how fast we can get an ID (or even how to go about it.) The
> > > second step should be reasonably easy. The third step is the most
> > > complex one, but at least teaching Linux should hopefully be easy
> > > enough, and existing guest operating systems could continue to use the
> > > existing device. The last step is probably not that bad.
> > >
> > > I can start down that path, if we have some consensus that this is the
> > > right way to handle this.
> > >
> > > I'd still argue that patch 1 should be applied regardless :)
> >
> > This sounds like a hell of alot of busy work to fix a problem that, IIUC,
> > does not actually exist from a functional POV - it is merely a perception
> > issue that people might be put off by the "Intel 6300ESB" names.
> >
> > IMHO a better use of time is to expand documentation to clarify this is
> > just fine for all PCI architectures, and change nothing in either QEMU
> > or guest kernels.
> 
> Agreed that it's not the most high-reward endeavor, but IIRC users
> were getting genuinely confused and annoyed by the string "Intel"
> showing up in their aarch64 guests.

So be it, that's far from the only wierd thing in virt.

> You can point them to documentation over and over again, or you can
> work to prevent the confusion/annoyance from showing up in the first
> place. Which of the two approaches is a better use of anyone's time
> is up for debate.
> 
> I for one am grateful that someone put the time in all those years
> ago and, as a result, PCI and USB controllers don't suffer from the
> problem today. Ultimately it's up to Connie though.

The PCI/USB controller situation is not the same tradeoff though.
Those guest kernel drivers will identify and attach to these two
controllers regardless of their PCI vendor/product, via the PCI
class property. In that case changing the PCI ID and other device
metadata in QEMU is cheap as it has no negative impact on guest OS
driver compibility.

In the case of 6300ESB though the guest driver is tied directly to
the currently used PCI device product/vendor ID.

If we change this then we have actually created new functional
problems with guest/QEMU compatibility, in order to placate a
non-functional problem. That is not a good thing.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


