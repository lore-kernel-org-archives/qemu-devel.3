Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BE4EC52D6D
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2024 13:30:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZsLu-0006Rk-2n; Fri, 02 Aug 2024 09:29:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1sZsLs-0006NY-T3
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 09:29:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1sZsLq-00085h-LV
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 09:29:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722605385;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=90xAsBuOOYjdiokNeQD7LW3bmHIn+VdSC3YEsFgMFto=;
 b=RQ2w06enBq2t2xfFpVAupoL3dnZ4G9S8GAvZwLcN57uYezvkIaBaB+XoXpTVWHFXKzh3zI
 jl5+HIo469JEr+8TEVKuqNX3/wv7eaQS+EjWdlnJdsTiEzCobmLjEjMknJW+pZmBGWDnQN
 71l8hlz0mrIXldEFs/QHBeIslvUjy4U=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-12-JXQ7x9RgMRisbljpNJoe7w-1; Fri,
 02 Aug 2024 09:29:42 -0400
X-MC-Unique: JXQ7x9RgMRisbljpNJoe7w-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CC8D219560BA; Fri,  2 Aug 2024 13:29:40 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.72])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 99889300019A; Fri,  2 Aug 2024 13:29:37 +0000 (UTC)
Date: Fri, 2 Aug 2024 08:29:34 -0500
From: Eric Blake <eblake@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, 
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Stefan Hajnoczi <stefanha@redhat.com>, 
 "Denis V. Lunev" <den@openvz.org>, Jiri Pirko <jiri@resnulli.us>
Subject: Re: [PATCH 2/5] docs/interop/nbd.txt: Convert to rST
Message-ID: <rsoycspsvfkmgynqiatse6o6yt7ksrulvnjg67w7cwm6rneuwb@hnir3hx54yup>
References: <20240801170131.3977807-1-peter.maydell@linaro.org>
 <20240801170131.3977807-3-peter.maydell@linaro.org>
 <okjnkgp7cfoa53ubbkeotfanyijak7x4avhlwa3ydfwzpo2qk4@7vni4uw4ihtc>
 <CAFEAcA9mLPDUx3hntXEwJ=3dD6BQiSq5Q4GeQkhW9N_seCdHNg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA9mLPDUx3hntXEwJ=3dD6BQiSq5Q4GeQkhW9N_seCdHNg@mail.gmail.com>
User-Agent: NeoMutt/20240425
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.124,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, Aug 02, 2024 at 09:39:41AM GMT, Peter Maydell wrote:
> On Thu, 1 Aug 2024 at 19:39, Eric Blake <eblake@redhat.com> wrote:
> >
> > On Thu, Aug 01, 2024 at 06:01:28PM GMT, Peter Maydell wrote:
> > > Convert nbd.txt to rST format.
> > >
> > > -F: docs/interop/nbd.txt
> > > +F: docs/interop/nbd.rst
> >
> > Upstream NBD has a link to the nbd.txt page; I'll have to update that
> > link to the new name.  Is it worth creating a git symlink so the old
> > name remains a stable point to link to (even though it is no longer
> > purely text)?
> 
> I'm not super enthusiastic about doing that -- we haven't created
> symlinks for any of the other document conversions we've done.

Okay, a stability symlink is not necessary.  Currently, the NBD spec
points to the raw qemu.txt because nothing is rendered into our online
pages; but I plan to instead point it into the rendered version
reachable from https://www.qemu.org/docs/master/interop/index.html
once your patch lands.  I also found a typo in that page (right next
to where nbd will appear), so I'm submitting that patch as a followup
to this thread, if that's okay.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


