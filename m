Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89F55C61DD6
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2026 17:51:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1p72-0008Ir-3C; Wed, 02 Sep 2026 13:51:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1x1p6x-0008HP-JN
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 13:51:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1x1p6v-0004GV-Hb
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 13:50:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788371456;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=VnUc12l6yh2oGa7qbMhdE28rw+smndZgJh06752uTlA=;
 b=DIB3GjJ1Tfj6kQKDTDJadEPYy4zNvKpIrdX2xqehZqNZXqqiRJTTIwWxXVxFI0JSNhXWwG
 hbtNVzSOLoYJTeNH3VRaejeBGrI2c87GyaDtt/Yj7ZSZQM9iH45fmBOthwr91sRZjMioZ+
 M6uXfy6Vs8b/V+nqgEzdsIAABCAAhRM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-32-4zaCeJQVNyKx9dG9_5GjBg-1; Wed,
 02 Sep 2026 13:50:54 -0400
X-MC-Unique: 4zaCeJQVNyKx9dG9_5GjBg-1
X-Mimecast-MFC-AGG-ID: 4zaCeJQVNyKx9dG9_5GjBg_1788371454
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0166B180AE2F
 for <qemu-devel@nongnu.org>; Wed,  2 Sep 2026 17:50:54 +0000 (UTC)
Received: from redhat.com (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 71A0B195608A; Wed,  2 Sep 2026 17:50:52 +0000 (UTC)
Date: Wed, 2 Sep 2026 18:50:49 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Thomas Huth <thuth@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: Async machine appliance for testing (python)
Message-ID: <aphh-XHBjGicZDD7@redhat.com>
References: <CAFn=p-aVpKptC=G6yTWWuQoeG+peChgw60uJdOXr7B8r=m=iBQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFn=p-aVpKptC=G6yTWWuQoeG+peChgw60uJdOXr7B8r=m=iBQ@mail.gmail.com>
User-Agent: Mutt/2.4.0 (2026-06-19)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Aug 31, 2026 at 04:51:36PM -0400, John Snow wrote:
> WIth the upgrade to 3.12 imminent, now might be a good time for me to
> revisit the work I started when I converted QMP from sync to an async
> library. I have a draft of the library I wrote some time ago, but it's
> probably in somewhat dodgy shape after a year or two of being ignored.
> 
> Before I dig in, I wanted to ask if this would be a helpful project.
> The main selling points would be:
> 
> (1) Ability to split it out from the main QEMU tree, like QMP was, for
> use in external testing
> (2) Better stream management so console information is consumed and
> logged reliably without deadlocks due to pipes hitting their buffer
> limit

I can't remember the specific details, but I do recall some
scenarios where it would have been valuable to have the console
output continuously streamed to the log file on disk, while
at the same time retainining the ability to do expected
output matching from the API.

> (3) Removing multiprocess and multithread processing of console and
> stdout/stderr logging from test suites in favor of using async
> user-threads for (hopefully) simpler, more straightforward processing
> and customization.

Which tests were you refering to here ?  I didn't think we had
python tests using multiprocess/multithread ?

Tangentially related, in debugging failures of the functional
test suite, and to a lesser extent I/O tests / qmp-shell, I've
often found myself heavily confused by the asyncio call paths
and control flow, making it really hard to debug.

In particular I've never fully figured out how to get qmp-shell
to have a clean exit path without stack traces being thrown.

I'm unclear if this is related to our having QEMUMachine class
expose a sync API on top of an async QMP class (square peg in
a round hole situation), or if this is just something inherent
to Python asyncio APIs, or probably a bit of both ?

If switching to a fully async API throughout the stack makes
debugging simpler, I'd welcome it.

> (4) Ability to add listeners/event handlers to watch for specific
> patterns and trigger asynchronously when they occur; i.e. ability to
> handle and watch for specific patterns in an arbitrary order without
> deadlocking your test
> (5) Centralized timeout setting and handling.

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


