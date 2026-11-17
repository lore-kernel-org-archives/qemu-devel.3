Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF196606A323
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Nov 2026 10:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=hRItbYJ/
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTGXL-0002Sp-Hx; Tue, 17 Nov 2026 05:35:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xTGXI-0002SG-Av
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 05:35:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xTGXG-0005as-I0
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 05:35:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794911733;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EvAJaMSTqg7393/GssMoJ/QmGHhdnHzYjSXP94H476M=;
 b=hRItbYJ/H3+8Ii3dj1INyPIKDGRpRa/Oqth/76AO6h+YN3ESVzjY2kAEZZCXdQtyjWH0e9
 iox8D7DlKCryKqEoyzdcdhywNYeZ5Dh7xR8hnZH8N5t4jSR0lRnP8SLZuj54hSonuuomlc
 teJmo8AciyY8NqT6rDqtuGTxF/4g7MI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-386-xLJU4JaKO7Sp1ndaTrdYlA-1; Tue,
 17 Nov 2026 05:35:30 -0500
X-MC-Unique: xLJU4JaKO7Sp1ndaTrdYlA-1
X-Mimecast-MFC-AGG-ID: xLJU4JaKO7Sp1ndaTrdYlA_1794911729
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F28281800557; Tue, 17 Nov 2026 10:35:28 +0000 (UTC)
Received: from redhat.com (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0C177180055C; Tue, 17 Nov 2026 10:35:27 +0000 (UTC)
Date: Tue, 17 Nov 2026 10:35:25 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: System emulator security boundary policy now enforceable
Message-ID: <avwt7XWPt9WNo90r@redhat.com>
References: <avwn7izLPHpSmVun@redhat.com>
 <CAFEAcA9otxN=xhb7C8JRQ7HGNZqvzdpDjBaFQ7rCxDviip-rZA@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFEAcA9otxN=xhb7C8JRQ7HGNZqvzdpDjBaFQ7rCxDviip-rZA@mail.gmail.com>
User-Agent: Mutt/2.4.3 (2026-10-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 17, 2026 at 10:24:26AM +0000, Peter Maydell wrote:
> On Tue, 17 Nov 2026 at 10:10, Daniel P. Berrangé <berrange@redhat.com> wrote:
> >
> > With the latest pull request of mine that is merged, we now have
> > the mechanism for enforcement of the QEMU security boundary policy
> > with annotations completed across QOM classes for machine types,
> > devices and accelerators.
> >
> > For a bug disclosure affecting a system emulator to be accepted
> > as a security flaw the reproducer scenario must now pass without
> > warnings when adding the '-compat insecure-input' flag.
> 
> How does the marking work? I'm confused about what's going
> on with the pl011 UART (which is on the security boundary
> because the arm virt board uses it). Unlike hw/char/serial.c
> and some others, there's no ".secure = true" in hw/char/pl011.c.
> But it isn't being rejected by
> ./build/kvmonly/qemu-system-aarch64 -accel kvm -M virt -display none
> -compat insecure-input=reject -serial stdio
> 
> so presumably we have figured out it's secure somehow. What's
> the mechanism here?

Currently we've only marked things which are explicitly user
creatable. ie they appear in '-machine help', '-accel help'
or '-device help' lists.

If a machine type is marked as secure, then implicitly devices
which are built-in for that machine are also considered secure.
Similarly if a device is marked as secure, then implicitly
any QOM parents of that device are also secure.

In the next release cycle, I want to explicitly mark the
built-in devices to make this clear to developers, and also
explicitly mark parent types.

Then code can explicitly validate the built-in devices & parents,
so that we can detect if someone adds something inappropriate
in our security boundary without realizing implications.

> Speaking of pl011, there's also a rust implementation (which
> I am not using in this test). Do we mark both the C and Rust
> implementations as 'secure' ?

We still have Rust disabled by default. Did we ever declare it to
be production ready yet ? If we still consider it experimental then
the rust pl011 would be out of scope.

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


