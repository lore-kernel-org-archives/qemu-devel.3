Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0581EE63C8B
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Feb 2026 10:47:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuTT4-00054k-1K; Mon, 23 Feb 2026 05:47:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vuTT0-00054c-Bj
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 05:47:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vuTSx-0001Qq-Hx
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 05:47:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771843622;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=vq2XnKpuseRgq82tL5jyiKA4G1EIpc2Ic92Imq7cOTc=;
 b=HYqttRLoJpIkRPBi71B9/k21trxFDrS2WxtsC7Wq5hlYiEK5o+xN1zykm6eCj6VpeasKWR
 bd1msOAANJA1cOQ0Mq0kVNYQ+rjjj3KKB+kXu71RbwBufHtBjKH3sMYP8yIfzOVL01i2al
 dNFqoyPfsa48QiJiQ9JeL6rgxG1Ttg8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-499-EGUbvAYmM5eNsXiATytp1w-1; Mon,
 23 Feb 2026 05:46:58 -0500
X-MC-Unique: EGUbvAYmM5eNsXiATytp1w-1
X-Mimecast-MFC-AGG-ID: EGUbvAYmM5eNsXiATytp1w_1771843617
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3AED9195605A; Mon, 23 Feb 2026 10:46:57 +0000 (UTC)
Received: from redhat.com (unknown [10.45.226.11])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8A2521800669; Mon, 23 Feb 2026 10:46:53 +0000 (UTC)
Date: Mon, 23 Feb 2026 10:46:49 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: QEMU Development <qemu-devel@nongnu.org>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 Christian Ehrhardt <christian.ehrhardt@canonical.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: Re: migration: stable machine types?
Message-ID: <aZwwGW7ERvH555zg@redhat.com>
References: <eabe1076-d30c-4454-8558-a231b9cb228d@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <eabe1076-d30c-4454-8558-a231b9cb228d@tls.msk.ru>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -4
X-Spam_score: -0.5
X-Spam_bar: /
X-Spam_report: (-0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.798, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.79,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
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

On Sat, Feb 21, 2026 at 09:55:55AM +0300, Michael Tokarev wrote:
> Hi!
> 
> We had a few examples when a bugfix required for a stable series
> but it can't be applied because it breaks migration.  One recent
> example is https://bugs.launchpad.net/ubuntu/+source/qemu/+bug/2131822 -
> the fix has been cherry-picked for 10.0.x but had to be reverted.
> 
> I wonder if we can, sometimes, introduce additional machine types
> for stable series.
> 
> In this case, it might've been an intermediate 10.0.4 machine type,
> which is between 10.0 and 10.1 - with this additional change included.
> 
> If this machine is known to both 10.1-tobe and 10.0.4+, all migration
> should work fine in both directions.

Yep, any bug fix machine would need to be added to 'master' branch
too, and any intermediate stable branches - though the latter probably
wouldn't ever happen as machine version mistakes are usually discovered
reasonably soon.

> It is exactly the same situation and solution which has been implemented
> by ubuntu in the end, but using their own, distribution-specific,
> machine types.
> 
> Why can't we do the same in upstream qemu?

There is no constraint from a technical POV. The macros I introduced
for defining versioned machine types in a standardized manner, can
have variants provided that define "bug fix" machines for stable
branches. We have a pretty old example for Q35:

  hw/i386/pc_q35.c:DEFINE_Q35_MACHINE_BUGFIX(4, 0, 1);

We used to have another example for PPC, which used the _MACHINE_TAGGED
variant, which added a string suffix instead of a micro version number,
but I'd recommend we don't use string suffixes again, only micro versions.

The core reason we didn't do this in the past was the support workload,
as every extra machine type we add is one more thing to maintain...
previously this burden was forever, but at least now we have capped
versioned machines at 6 years / 18 minor releases total lifetime.
Thus if we did add bugfix machines, that burden is now capped and
thus more tolerable.


IOW, if you as stable maintainer want to add a bugfix machine, and
the subsystem maintainer for that machine is aggreeable to adding
it too, there is no fundamental blocker here.

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


