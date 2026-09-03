Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10BA0C61DD3
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 08:16:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x22cV-0003dH-I8; Thu, 03 Sep 2026 04:16:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1x22cF-0003cl-QF
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 04:16:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1x22cE-0000mH-3z
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 04:16:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788423368;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OPq8iS3twaNdDkBur64Tu36RCg9afvdVUMg6rfIi7ns=;
 b=bTPJ9Wq0YqH1fv5cWj3ry+pFqMyVcGhaBZ1hHfJw4B2708U40AgaBb34jGXyfgX+2Pz7Is
 cvgFG+/8qB/DzuaoB2HtsqJLXR8e6+J75oXX8gpotWeU+jX1PVezfb2dYDv+n2rdhPkLTi
 s3UJA8GNh/cvGIKrhbYKMfLf0VJ/M18=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-395-xlMq9xR6P-KQjdBkYCfAZQ-1; Thu,
 03 Sep 2026 04:16:05 -0400
X-MC-Unique: xlMq9xR6P-KQjdBkYCfAZQ-1
X-Mimecast-MFC-AGG-ID: xlMq9xR6P-KQjdBkYCfAZQ_1788423364
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5D60D1925763; Thu,  3 Sep 2026 08:16:04 +0000 (UTC)
Received: from redhat.com (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3690A18005AD; Thu,  3 Sep 2026 08:16:03 +0000 (UTC)
Date: Thu, 3 Sep 2026 09:16:00 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH] agents: Add a skill for finding your way around QEMU
Message-ID: <apkswHHNCXFL-s0R@redhat.com>
References: <20260903073656.540570-1-pbonzini@redhat.com>
 <apkq9lLdyqXPXWmD@redhat.com>
 <CABgObfYDqp8ZPKXeh8WnxKooMPFhFP5A1qUbyaqzTjKKHAoehw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABgObfYDqp8ZPKXeh8WnxKooMPFhFP5A1qUbyaqzTjKKHAoehw@mail.gmail.com>
User-Agent: Mutt/2.4.0 (2026-06-19)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
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

On Thu, Sep 03, 2026 at 10:10:59AM +0200, Paolo Bonzini wrote:
> On Thu, Sep 3, 2026 at 10:08 AM Daniel P. Berrangé <berrange@redhat.com> wrote:
> > On Thu, Sep 03, 2026 at 09:36:56AM +0200, Paolo Bonzini wrote:
> > > +## Finding things
> > > +
> > > +`MAINTAINERS` is the authoritative map from file patterns to subsystems
> > > +and maintainers; use it to work out who owns code and which tree a
> > > +change goes through.
> >
> > Does the tree actually matter to agents or contributors sending patches ?
> > I would tend to say "use it to work out which maintainers to CC when
> > sending patches".  The receiving maintainer(s) will decide which tree
> > it will go through.
> 
> s/work out/suggest/ - since sending should still be a human act even
> with the proposal under discussion.

Or maybe we just instruct it to run 'get_maintainers.pl' to
work out the CC list ? That script is deterministic and thus
would not typically need human oversight, which will know will
often be skipped even if we require oversight in policy.

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


