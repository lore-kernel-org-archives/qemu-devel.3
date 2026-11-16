Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F7D2606A322
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 21:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=P+1M0crv
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xT4gK-0005aE-7i; Mon, 16 Nov 2026 16:56:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xT4gH-0005YE-KL
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 16:56:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xT4gF-0005G5-UH
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 16:56:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794866163;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=D1vBlRcQBkOgLgu4BQzHmgOCzbV74dOo1duWJsLkJ20=;
 b=P+1M0crv+sv23xs+OZoBSCtwfK3GAWSKkEhZjJY3a/agb8gNulimWz8j8elhR+nyorrR0C
 FSepF6ClcvvemBJlyxUKAI1e0GB651geL7+VWRtNXCzHbbuch+M5E99ZAuuH5bZEFlpMAj
 vsJXTPY26B08Z8sDkKniHA2K4C/AJXc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-561-4o1N2SO0M_ailhwiekZdDg-1; Mon,
 16 Nov 2026 16:55:57 -0500
X-MC-Unique: 4o1N2SO0M_ailhwiekZdDg-1
X-Mimecast-MFC-AGG-ID: 4o1N2SO0M_ailhwiekZdDg_1794866156
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 635311800361; Mon, 16 Nov 2026 21:55:56 +0000 (UTC)
Received: from redhat.com (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D9A1E1956049; Mon, 16 Nov 2026 21:55:54 +0000 (UTC)
Date: Mon, 16 Nov 2026 21:55:51 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Markus Armbruster <armbru@redhat.com>, Yonggang Luo <luoyonggang@gmail.com>
Subject: Re: [PATCH 36/48] hw/arm: declare arm machine targets
Message-ID: <avt756EId-ud8GnL@redhat.com>
References: <20261112133054.1977618-1-berrange@redhat.com>
 <20261112133054.1977618-37-berrange@redhat.com>
 <ccd0d13c-fe75-4b78-8b40-af3f90d05204@oss.qualcomm.com>
 <8d9d4799-a516-4078-ad1e-7340a976c118@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8d9d4799-a516-4078-ad1e-7340a976c118@oss.qualcomm.com>
User-Agent: Mutt/2.4.3 (2026-10-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Nov 16, 2026 at 01:43:41PM -0800, Pierrick Bouvier wrote:
> On 11/16/2026 1:42 PM, Pierrick Bouvier wrote:
> > On 11/12/2026 5:30 AM, Daniel P. Berrangé wrote:
> >> This prevents creation of arm machines unless the current selected
> >> target is arm and enables removal of the 'is_available' callback.
> >>
> >> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> >> ---
> >>  hw/arm/aspeed_ast27x0-fc.c  | 5 ++++-
> >>  hw/arm/aspeed_ast27x0_evb.c | 7 +++++--
> >>  hw/arm/raspi.c              | 9 ++++++---
> >>  hw/arm/raspi4b.c            | 6 ++++--
> >>  hw/arm/virt.c               | 6 ++++--
> >>  5 files changed, 23 insertions(+), 10 deletions(-)
> >>
> > 
> > Could we have a variadic function to set target instead?
> > 
> > This way we would only see
> > targets = qemu_arch(SYS_EMU_TARGET_A, SYS_EMU_TARGET_B), and not expose
> > QEMU_ARCH_BIT at all.
> >
> 
> Compared to alias, this one is pretty important since in the end *all*
> machines will have a list of targets associated.

Yeah, that sounds like a nice idea for improvement.

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


