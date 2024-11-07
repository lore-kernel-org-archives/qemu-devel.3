Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E3A2D4337D
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2024 16:58:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t95pj-0005w3-3C; Thu, 07 Nov 2024 11:58:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t95pc-0005vB-Rz
 for qemu-devel@nongnu.org; Thu, 07 Nov 2024 11:58:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t95pa-0008CL-Qg
 for qemu-devel@nongnu.org; Thu, 07 Nov 2024 11:58:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730998680;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hD8D7pc1VOi/5QPPAdQs9Amy9e/NF6C0aPHm50kUvPQ=;
 b=KW8B0fxAdsyKNzNRo3+1q6EXRPezRDnDVI5R/1qkuO/qRyM5Gyb58NRDHKvT4zctOafdEj
 hFUQ0WC0RSl78v0UHK6fxdQ17QeD+gQ2WWAbIeg6Lb/5ni3qiwdp5Q0FZQ9sRNjYpOJezY
 /8dxIVAbtTQkkYyRo/EojX+QHJ7+Za0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-690-UL3YAcy7MiSjZkmXsEAytQ-1; Thu,
 07 Nov 2024 11:57:59 -0500
X-MC-Unique: UL3YAcy7MiSjZkmXsEAytQ-1
X-Mimecast-MFC-AGG-ID: UL3YAcy7MiSjZkmXsEAytQ
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7BFF81956057; Thu,  7 Nov 2024 16:57:57 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.55])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 882B6195E480; Thu,  7 Nov 2024 16:57:50 +0000 (UTC)
Date: Thu, 7 Nov 2024 16:57:46 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: Prasad Pandit <ppandit@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 qemu-devel@nongnu.org, Prasad Pandit <pjp@fedoraproject.org>
Subject: Re: [PATCH 2/5] migration/postcopy: magic value for postcopy channel
Message-ID: <Zyzxihj37-pfTQWx@redhat.com>
References: <ZyTnBwpOwXcHGGPJ@x1n>
 <CAE8KmOyzWRqpGDOyAK7V2X8+SWVt_kR1897tiFm7vdBNRRE2QA@mail.gmail.com>
 <ZykB3voFw_-ByWfh@x1n>
 <CAE8KmOzuGxdU7zp+vsf1yY_FP8bf-KTv7UJ+8h6bfmkE=0H-bA@mail.gmail.com>
 <ZyoW3ue3WTQ3Di1d@x1n>
 <CAE8KmOxW8K-YoCUbK5XOLeUQk8WCPB4UxbaQuUONhzsanvrLMw@mail.gmail.com>
 <87ldxw1p8k.fsf@suse.de>
 <CAE8KmOwM2wjkyUZL5v=3gjkUNa8VhA6oick35KMX-FO2-BidaQ@mail.gmail.com>
 <ZyyzjWY-1nPpPgSW@redhat.com> <ZyzoGvOaybHs4uMl@x1n>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZyzoGvOaybHs4uMl@x1n>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Thu, Nov 07, 2024 at 11:17:30AM -0500, Peter Xu wrote:
> On Thu, Nov 07, 2024 at 12:33:17PM +0000, Daniel P. Berrangé wrote:
> I'll comment on a few examples above, which I think some of them, even if
> handshake is ready, may still need mgmt layers to involve..
> 
> Multifd and postcopy are the two major features, and they, IMHO, all better
> need user involvements..
> 
> Multifd needs it because it relies on the channel being able to provide >1
> channels.  It means "| nc XXX > file" can stop working if we turn it on by
> default silently.

NB, my point was referring to a hypothetical alternative history,
where we had the handshake at the QEMU level from day 1. That
would neccessarily imply a bi-directional channel, so the 'nc'
use case would already have been  out of scope. That said, QEMU
could identify whether the channel it was told to use was
bi-directional or not, and thus not try to do multifd over
a non-socket transport.

So the general point still holds - if QEMU had this protocol
negotiation phase built-in, there would be more flexiblity in
introducing new features without layers above needing changes,
for every single one, just a subset.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


