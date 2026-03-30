Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A270A10F3DFA
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2026 14:25:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7DXp-0007OF-OF; Mon, 30 Mar 2026 10:24:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1w7DXk-0007Mu-3z
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 10:24:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1w7DXg-0001bg-FN
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 10:24:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774880675;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=z3o2b4uAHF0UTlZleC6Oz5iqhcWsWzrDCPii39COgO0=;
 b=U+rXcRWwpepyGYD9PVETwzD4nhPs9M8rMXAk4+OHXNjP2AL2/lLxbDENPSwhtHKv9aA4sZ
 4laVRAFLXAZxvZkmaHkzXfOjeErXVS719UPh5n5ra2lMI3Snu8WUbkc3g0xpWYfwVtPVTF
 8fCCwQErog4IF/NCgD8H3erPYjOjV/o=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-683-kEACc6VnM6OSbKCtjBOUtA-1; Mon,
 30 Mar 2026 10:24:31 -0400
X-MC-Unique: kEACc6VnM6OSbKCtjBOUtA-1
X-Mimecast-MFC-AGG-ID: kEACc6VnM6OSbKCtjBOUtA_1774880670
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 634BF1944F0D; Mon, 30 Mar 2026 14:24:30 +0000 (UTC)
Received: from redhat.com (unknown [10.44.36.79])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EAFF2180058B; Mon, 30 Mar 2026 14:24:26 +0000 (UTC)
Date: Mon, 30 Mar 2026 15:24:23 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Stepan Popov <Stepan.Popov@kaspersky.com>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH] meson: add missing semicolon in
 pthread_condattr_setclock test
Message-ID: <acqHl1CIduLYbOb6@redhat.com>
References: <20260330131406.87080-1-Stepan.Popov@kaspersky.com>
 <CAMxuvawBPPBfBhLy-9H43fPT64M6iJV+LZiE0CmqP6BfJkAFQA@mail.gmail.com>
 <acp8VmIN1cwNAxE-@redhat.com>
 <CAFEAcA8Rt6VwDksVHjEAWKsYc15JGjry=kozHsx8PrwW6sEH2A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFEAcA8Rt6VwDksVHjEAWKsYc15JGjry=kozHsx8PrwW6sEH2A@mail.gmail.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 27
X-Spam_score: 2.7
X-Spam_bar: ++
X-Spam_report: (2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SBL_CSS=3.335,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1, RCVD_IN_VALIDITY_RPBL_BLOCKED=1,
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

On Mon, Mar 30, 2026 at 03:19:40PM +0100, Peter Maydell wrote:
> On Mon, 30 Mar 2026 at 14:36, Daniel P. Berrangé <berrange@redhat.com> wrote:
> >
> > On Mon, Mar 30, 2026 at 05:32:33PM +0400, Marc-André Lureau wrote:
> > > Hi
> > >
> > > On Mon, Mar 30, 2026 at 5:21 PM Stepan Popov <Stepan.Popov@kaspersky.com> wrote:
> > > >
> > > > The test code was missing a semicolon after the pthread_condattr_t
> > > > variable declaration.
> > > >
> > > > Signed-off-by: Stepan Popov <Stepan.Popov@kaspersky.com>
> > >
> > > Fixes: 657ac98b58 ("thread-posix: use monotonic clock for QemuCond and
> > > QemuSemaphore")
> >
> > IOW, that commit has been dead code since it was first added years ago,
> > we've never used the monotonic clock
> 
> Yes. So are we confident enough in that never-tested feature to want to
> enable it at this point in the release cycle, or should we hold off on
> this bugfix until 11.1 ?

IMHO waiting until 11.1 is the prudent approach. This is not a
regression fix and clearly no one noticed it wasn't doing anything
for 3 years since it was introduced, so fixing it can't be that
urgent ?


With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


