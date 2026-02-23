Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F462E98E0F
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Feb 2026 10:01:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuSkE-0004qL-SO; Mon, 23 Feb 2026 05:00:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vuSjw-0004mi-He
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 05:00:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vuSjq-00007T-ED
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 05:00:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771840824;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=mkifKJUyseT6sckzAhSiI3qikmFTo129/PNCDGCgzt4=;
 b=euRq1F1Iz4XvHZINMELBILnTMlYVOXhghF8ZTgNCR63dLw1i93nTjZ1UsrmzYbiWSl8X9H
 qM3XEtsL/42nWI3r5fkyXb0ELNOUm8aefEYlDgBwwuNVzeMq4dmvbeuQqQmL0DZWMmth1u
 Z25GHrsqn4gpLFS7W+EdnOSc51BciJc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-562-jQHAoUgVN8C_rYQ9qB_W2Q-1; Mon,
 23 Feb 2026 05:00:19 -0500
X-MC-Unique: jQHAoUgVN8C_rYQ9qB_W2Q-1
X-Mimecast-MFC-AGG-ID: jQHAoUgVN8C_rYQ9qB_W2Q_1771840818
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5DB6218005B7; Mon, 23 Feb 2026 10:00:18 +0000 (UTC)
Received: from redhat.com (unknown [10.45.226.11])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E5BE01955F22; Mon, 23 Feb 2026 10:00:15 +0000 (UTC)
Date: Mon, 23 Feb 2026 10:00:12 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, Peter Krempa <pkrempa@redhat.com>,
 qemu-devel@nongnu.org, Juraj Marcin <jmarcin@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Prasad Pandit <ppandit@redhat.com>
Subject: Re: [PATCH v2 0/2] migration: feature removals for 11.0
Message-ID: <aZwlLFddXXnbBYyj@redhat.com>
References: <20260115225503.3083355-1-peterx@redhat.com>
 <aZQ0q2r6w3OkSP2f@angien.pipo.sk> <87ms17lihr.fsf@pond.sub.org>
 <aZYtQLZfhRr61Dvh@x1.local> <87jyw96vtx.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87jyw96vtx.fsf@pond.sub.org>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

On Thu, Feb 19, 2026 at 08:23:06AM +0100, Markus Armbruster wrote:
> Peter Xu <peterx@redhat.com> writes:
> > I don't know if that'll work because logically we can also copy anyone or
> > lists only when sending patches (e.g. with "git send-email --cc")..
> 
> For what it's worth, scripts/get_maintainer.pl would have told us to cc:
> libvirt with this line:
> 
>     devel@lists.libvirt.org (open list:Incompatible changes)
> 
> > For now, I'll just remember to always copy libvirt list on touching
> > deprecation file.  My apologize if it caused any unwanted surprise.
> 
> We cannot and do not expect a patch submitter to know and remember
> everything.  We rely on tooling and review to catch misses in time.
> Doesn't always work, because nothing and nobody's perfect.

If any contributor is sending patches to QEMU, please don't use the raw
'git send-email' command directly. Instead use 'git-publish' which wraps
'send-email' with logic that automatically consults get_maintainer.pl.

This means you'll always CC the required people by default, and have
to conciously make an effort to drop them from the CC list.

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


