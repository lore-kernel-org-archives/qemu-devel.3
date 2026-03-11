Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44465104950E
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 09:32:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0FvF-0006lo-LE; Wed, 11 Mar 2026 05:32:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1w0Fv3-0006lD-6C
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 05:31:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1w0Fv1-0002oe-4a
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 05:31:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773221514;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=jkvx31t9gR5JlTmGPN0dtXMZryBIOqOv+dGCKIDCz/Y=;
 b=SV4eyZGf82Vaik+UJqy4rWd78uPbkk9KWXUuDZYkSKoJ6minTeO8NGDr9UrSznCKcDG6nh
 ZRJMGgEm962Wo0wppujKooV74dLEx2V5ZVcNMsadYdindrUGhywi2VUq2zFgc3EO5Na0VR
 pdh+jVe/r47Xbho6l8csGnBFESslDAo=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-253-ESnZQ-JZNy-6dCiixXBElQ-1; Wed,
 11 Mar 2026 05:31:50 -0400
X-MC-Unique: ESnZQ-JZNy-6dCiixXBElQ-1
X-Mimecast-MFC-AGG-ID: ESnZQ-JZNy-6dCiixXBElQ_1773221509
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7765E18002CF; Wed, 11 Mar 2026 09:31:49 +0000 (UTC)
Received: from redhat.com (unknown [10.44.33.160])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A15BF180066F; Wed, 11 Mar 2026 09:31:46 +0000 (UTC)
Date: Wed, 11 Mar 2026 09:31:42 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: nia <nia@netbsd.org>, Peter Maydell <peter.maydell@linaro.org>,
 Fabiano Rosas <farosas@suse.de>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: Minimal GCC version for QEMU
Message-ID: <abE2fnEDSg4z6y0B@redhat.com>
References: <20260309155219.62400-1-philmd@linaro.org>
 <20260309155219.62400-28-philmd@linaro.org>
 <87h5qn23v5.fsf@suse.de>
 <CAFEAcA-vsS0Q9kGVbmwEyLQcoANaHg5S754DNvqXOOnqoY-LMg@mail.gmail.com>
 <eb7c065a-ff9f-41d9-a80f-51123af20603@redhat.com>
 <abA5BBSQ0cHstmqM@redhat.com>
 <6660d0a8-c5f8-4f4c-a097-9aa1fb1501b6@redhat.com>
 <abCj2IxC44wlkmqo@homeworld.netbsd.org>
 <1c26bf07-1d19-4764-9f6f-28b47a7f0f8b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1c26bf07-1d19-4764-9f6f-28b47a7f0f8b@redhat.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
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

On Wed, Mar 11, 2026 at 08:28:01AM +0100, Thomas Huth wrote:
> On 11/03/2026 00.06, nia wrote:
> > On Tue, Mar 10, 2026 at 04:47:30PM +0100, Thomas Huth wrote:
> > > According to that URL from NetBSD that I posted above, they are still using
> > > LLVM 10.0 in NetBSD 10 ... which is also our current minimum version of
> > > Clang, so I assume we're still stuck with Clang v10 for a while?
> > 
> > Since I was CCed in this discussion - can I ask why qemu is targeting
> > compiler versions instead of C standard revisions?
> 
>  Hi!
> 
> QEMU already uses std=gnu11. The problem is that different compiler versions
> emit different warnings, and with older compilers, there are often warnings
> that are false positives (see e.g.
> https://lore.kernel.org/qemu-devel/87h5qn23v5.fsf@suse.de/ that just has
> been posted to the mailing list recently). The QEMU project tries to avoid
> supporting operating systems / build environments that are too old (see
> https://www.qemu.org/docs/master/about/build-platforms.html), we often just
> don't have the capacity in the developer community to handle that, so that's
> why we put compiler checks into place to avoid wrong expectations for the
> users.

Furthermore, the minimum GCC + CLang versions are what we use to
determine what GNU C standard revision we can set as our baseline.
For example see this previous commit:

  commit 8a9d3d564093dbd5a7339085406e840893944d21
  Author: Richard Henderson <richard.henderson@linaro.org>
  Date:   Mon Jun 14 16:31:36 2021 -0700

    configure: Use -std=gnu11
    
    Now that the minimum gcc version is 7.5, we can use C11.
    This will allow lots of cleanups to the code, currently
    hidden behind macros in include/qemu/compiler.h.



With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


