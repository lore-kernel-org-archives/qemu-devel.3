Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8B53606A326
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2026 08:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=al8a6xeK
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xPFB3-0007IU-Ow; Fri, 06 Nov 2026 03:20:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xPFB0-0007Hr-KU
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 03:19:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xPFAz-0006sL-0x
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 03:19:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793953195;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=Zuq5QYQ23TRCphE0lc/qoP1hitVFvq+O+/keAYHv0KY=;
 b=al8a6xeKBjkv7uYZTPsTPviYyGfjkHZkDnYZXotrDHhw9o8yosn5T0+lDqEN1S10b/x9U6
 k7NQyrYQtIcA2681jgpSNScwldxQdVxRgNgtl48Szy0h/uFQ72LCKQBfX1+1JKcFi4NSFA
 DyfJ5MRQYmGQlDP3689E30kglJoCfn4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-90-zouoKJ-hOpWcXPKJsxiZVw-1; Fri,
 06 Nov 2026 03:19:50 -0500
X-MC-Unique: zouoKJ-hOpWcXPKJsxiZVw-1
X-Mimecast-MFC-AGG-ID: zouoKJ-hOpWcXPKJsxiZVw_1793953189
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3BF8C1955EAA; Fri,  6 Nov 2026 08:19:48 +0000 (UTC)
Received: from redhat.com (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B88EC195608C; Fri,  6 Nov 2026 08:19:45 +0000 (UTC)
Date: Fri, 6 Nov 2026 08:19:42 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Yonggang Luo <luoyonggang@gmail.com>, qemu-devel@nongnu.org,
 Cleber Rosa <crosa@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 John Snow <jsnow@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Philippe Mathieu-Daude <philmd@mailo.com>
Subject: Re: [PATCH] meson: generate qemu-version.h with a custom target
Message-ID: <au2NnibVpewh5VwD@redhat.com>
References: <20261105181449.1691-1-luoyonggang@gmail.com>
 <CAFEAcA8ScuuOgjaYNpQOZS37yx=WBzZaKLcVGQs8Tj3JYB3jOw@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA8ScuuOgjaYNpQOZS37yx=WBzZaKLcVGQs8Tj3JYB3jOw@mail.gmail.com>
User-Agent: Mutt/2.4.3 (2026-10-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Nov 05, 2026 at 06:34:31PM +0000, Peter Maydell wrote:
> On Thu, 5 Nov 2026 at 18:15, Yonggang Luo <luoyonggang@gmail.com> wrote:
> >
> > configure_file() writes qemu-version.h at setup time. That result is
> > not a ninja edge, so a missing header is never rebuilt and compiles
> > that include it do not order on it. Generate the header with
> > custom_target and list it in genh. scripts/qemu-version.py reads
> > scripts/qemu-version.h.in and substitutes -version. An empty
> > pkgversion drops the QEMU_PKGVERSION line.
> >
> > Link: https://lore.kernel.org/qemu-devel/CAFEAcA8bGODxRfRzrimhGN1v2HtcWvApRsyucemZbMUUBVkYwA@mail.gmail.com/
> >
> > Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> 
> If we're going back to having an external script, the other
> way to fix this would be to just revert ab78ac76f44a12 and
> maybe fc35f2438770, since their commit messages suggest the
> main aim was to not have an external script.

I'm not clear what problem there was with an external script that these
were solving ? These also seem to have appeared in a pull request
without any prior posting for review, which is rather shortcutting our
normal dev process.

Personally I'd suggest we revert and then simplify the version handling
in a different way:

 * Remove the VERSION file and put the number in meson.build directly
 * Emit QEMU_PKGVERSION into build/config-host.h
 * Remove qemu/version.h and build/qemu-version.h

This avoids any need for rules to generate build/qemu-version.h
and config-host.h already has logic to regenerate itself when
meson.build changes.

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


