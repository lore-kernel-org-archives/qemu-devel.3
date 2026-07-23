Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56186C531CB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2026 10:05:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmqIL-0007yc-2r; Thu, 23 Jul 2026 06:04:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wmqIJ-0007yS-H9
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 06:04:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wmqIG-0002Nd-Po
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 06:04:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784801083;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5WRUaJbni6vcBjhVxqamFiRPEz5/7SWpop7d2WAnofI=;
 b=BClD79PpS9Seu+JVjOskZKbWPO6YX71schWKg8CPiuPkgHm3GPS5Eq7bhnxm1KkP3TFFeZ
 kbO8zzaHRJVE3JHdzQ2pObqpnJ1uFaBflaIVkG6vPRZv2HsXn+npTtHjUUV8VWyVM9vMgV
 H0gSUkKD/Vwc71QoAFRBnQaJcq/C4Ok=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-253-jon-8CuEOsmpa2u4JNo79g-1; Thu,
 23 Jul 2026 06:04:39 -0400
X-MC-Unique: jon-8CuEOsmpa2u4JNo79g-1
X-Mimecast-MFC-AGG-ID: jon-8CuEOsmpa2u4JNo79g_1784801078
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 05F141955F54; Thu, 23 Jul 2026 10:04:38 +0000 (UTC)
Received: from redhat.com (unknown [10.44.32.196])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 911D11956054; Thu, 23 Jul 2026 10:04:36 +0000 (UTC)
Date: Thu, 23 Jul 2026 11:04:33 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Cc: qemu-devel@nongnu.org, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: Re: [PATCH] docs/system/security: exclude uninitialized stack
 variables as bugs
Message-ID: <amHnMY-ghjJ8euxv@redhat.com>
References: <20260723094622.1515831-1-berrange@redhat.com>
 <CAJ+F1CJu27KiD8n1K1p+hUH7HBGSGwObTAUXhiVW_VMohv6ySw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJ+F1CJu27KiD8n1K1p+hUH7HBGSGwObTAUXhiVW_VMohv6ySw@mail.gmail.com>
User-Agent: Mutt/2.4.0 (2026-06-19)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: permerror client-ip=170.10.129.124;
 envelope-from=berrange@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, T_SPF_PERMERROR=0.01 autolearn=no autolearn_force=no
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

On Thu, Jul 23, 2026 at 01:59:30PM +0400, Marc-André Lureau wrote:
> On Thu, Jul 23, 2026 at 1:46 PM Daniel P. Berrangé <berrange@redhat.com> wrote:
> >
> > The -ftrivial-auto-var-init=zero usage guarantees implicit zero
> > initializers for all stack variables. Thus most bug reports relying
> > on undefined behaviour from lack of variable initialization will
> > not be security issues, or even bugs.
> >
> > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> 
> Still worth to explicitly clear or set the variable though, since it's
> not standard C otherwise and sometimes 0 is not the correct value.

Yes, certainly we should make it explicit for reviewer sanity
if nothing else.


With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


