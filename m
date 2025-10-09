Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58365CCD187
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 10:21:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6nlE-0005XL-34; Thu, 09 Oct 2025 06:20:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v6nlB-0005Wz-7W
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 06:20:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v6nl3-00006f-RG
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 06:20:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760005221;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sXolzoq/y7USFoOhuZJbDmEd1lhrc3wc66MRwOmKPFo=;
 b=XFrQcELOl0iX+oYhhZdYUt5YOP4x96qoDx4XthNc0Qwtkg++H/7rjcq+x1UoyijLrUvm0M
 ifHE4G7/953Z8WTT+zl3b+aDzCyHKHfR+6qU1bjrg0ZWedAcZopDURU+6Gxayd6IDFdL89
 FKvBRkFW97vnmi9XIYcVVkk5IDnbdd0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-328-HKG0Gl0zNAq8uBa9BQuMqw-1; Thu,
 09 Oct 2025 06:20:18 -0400
X-MC-Unique: HKG0Gl0zNAq8uBa9BQuMqw-1
X-Mimecast-MFC-AGG-ID: HKG0Gl0zNAq8uBa9BQuMqw_1760005217
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 35FFB195609E; Thu,  9 Oct 2025 10:20:17 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.196])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 820C219560B4; Thu,  9 Oct 2025 10:20:14 +0000 (UTC)
Date: Thu, 9 Oct 2025 11:20:10 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Christian Speich <c.speich@avm.de>, qemu-devel@nongnu.org,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [PATCH] virtio: vhost-user-device: Make user creatable again
Message-ID: <aOeMWq_RbN8lLwSk@redhat.com>
References: <20250922081403-mutt-send-email-mst@kernel.org>
 <aNFF8wsycqqOTc-x@redhat.com>
 <20250922090748-mutt-send-email-mst@kernel.org>
 <kmdwf2xbgtvqiijw7mjd4ocqixvznaeszbr5zzfvuhaqrmpqn3@wdt4fhnocmxv>
 <20250922093013-mutt-send-email-mst@kernel.org>
 <87y0q6mscw.fsf@draig.linaro.org> <aNpBqlRmdOac7U99@redhat.com>
 <20250929042410-mutt-send-email-mst@kernel.org>
 <aNpaSpF_qY6z03Q3@redhat.com>
 <20251004133102-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251004133102-mutt-send-email-mst@kernel.org>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Sat, Oct 04, 2025 at 01:33:48PM -0400, Michael S. Tsirkin wrote:
> On Mon, Sep 29, 2025 at 11:07:06AM +0100, Daniel P. Berrangé wrote:
> > > Well that's because e.g. kvmtest actually depends on pci-testdev.
> > > IOW it's actually supported.
> > 
> > This again just sounds like a downstream 'support' rationalization.
> > I'm still not seeing a compelling reason why the vhost user generic
> > device should be disabled by default in upstream, especially if we
> > mark it as an experimental device with an x- prefix. 
> 
> We can do that. I am still somewhat puzzled by whether making
> it unsupported/experimental addresses the actual need, which
> seems to be to expose it to end users?

My interpretation is that simply having the device exist by default
in QEMU builds is the minimum bar. If we declare it supported, then
that is a "nice to have"  guarantee for long term.

> Once something is used in the field, we can't take it back
> whether we added x- to the name or not.
> 
> What are your thoughts if it's not marked as experimental?

In general my view is that we can't protect against user foolishness.
If they provide inappropriate configuration options to this device
and get broken behaviour, so be it.  If they file bugs against QEMU
our assistance will be very minimal - they get to do the debugging.

On our side as maintainers, the important question is whether exposing
this device ties our hands for future code development.

eg would it unacceptably limit our ability to refactor things in future,
while keeping compat for this exposed device ?

If it would be an undue burden, then it would be worth marking it as
experimental to give us the freedom to make incompatible changes.

If exposing the device has minimal burden anticipated on future work,
then no need to mark it experimental

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


