Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 502F0CAC5BB
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Oct 2025 12:57:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6Thw-0006qS-Tb; Wed, 08 Oct 2025 08:55:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v6Tho-0006ph-OY
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 08:55:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v6ThY-00013R-SO
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 08:55:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759928125;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zUngyVXXbX7BqG9Pug5vK+32w9zuU8yH3Tx3vNqI0so=;
 b=b0y5y387aDMXSO+oMpUmoXO/wMhM/LZPZsZxEcWT8wf5Bnv711VRRGhyMduxU5H3KTvI/k
 Tv4oGQcLz/QmhraHmVPUy5F0GbHyY3YAglMsaFcvJiIPE7GDTQliPKlBKwJwY+f4v+W5q4
 503UZfZBCy1uqen8J6/7AorJ88yzVrU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-563-jAv2X7ESPfmXjljEP7CZ_Q-1; Wed,
 08 Oct 2025 08:55:22 -0400
X-MC-Unique: jAv2X7ESPfmXjljEP7CZ_Q-1
X-Mimecast-MFC-AGG-ID: jAv2X7ESPfmXjljEP7CZ_Q_1759928121
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DE4FF19560AA; Wed,  8 Oct 2025 12:55:20 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.74])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7DA7319560A2; Wed,  8 Oct 2025 12:55:14 +0000 (UTC)
Date: Wed, 8 Oct 2025 13:55:09 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Hanna Reitz <hreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org
Subject: Re: [PATCH 3/4] tests: add nbd and luks to the I/O test suites
Message-ID: <aOZfLYcJZ-6dslcK@redhat.com>
References: <20251008113552.747002-1-berrange@redhat.com>
 <20251008113552.747002-4-berrange@redhat.com>
 <bc904027-5b58-4057-8ef5-15e4ebcca767@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bc904027-5b58-4057-8ef5-15e4ebcca767@redhat.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, Oct 08, 2025 at 01:55:12PM +0200, Thomas Huth wrote:
> On 08/10/2025 13.35, Daniel P. Berrangé wrote:
> > This introduces new suits for running I/O tests on NBD and LUKS
> > drivers, giving new make targets
> > 
> >   * make check-block-luks
> >   * make check-block-nbd
> > 
> > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> > ---
> >   tests/qemu-iotests/meson.build | 4 +++-
> >   1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/tests/qemu-iotests/meson.build b/tests/qemu-iotests/meson.build
> > index 939a14ffae..5735d67c8c 100644
> > --- a/tests/qemu-iotests/meson.build
> > +++ b/tests/qemu-iotests/meson.build
> > @@ -23,7 +23,9 @@ qemu_iotests_formats = {
> >     'raw': 'slow',
> >     'qed': 'thorough',
> >     'vmdk': 'thorough',
> > -  'vpc': 'thorough'
> > +  'vpc': 'thorough',
> > +  'nbd': 'thorough',
> > +  'luks': 'thorough',
> >   }
> 
> Before we do that, I'd first see a solution for the problem that I described
> in my series here:
> 
> https://lore.kernel.org/qemu-devel/20250910153727.226217-1-thuth@redhat.com/
> 
> which, by the way, contains a patch that is very similar to yours here.

IIUC, the problem you're concerned with is that 'make check SPEED=thorough'
is running too much, and you want to stop running skipped tests directly.

My view is that running "make check SPEED=thorough" is undesirable in
general, even before either of our patch series. I'd say it is almost
never what people actually want to use, and is only picked because of
the lack of a better option. That's why I thought 'make check-block-qed'
(and equiva for other formats) was a better option, as it gives a make
target that matches a specific testing use case. With that in mind, IMHO
it is less important if 'make check SPEED=thorough' waste a bit of time
launched irrelevant tests.

> Also not sure whether we should add "nbd" to the "formats" list - it's a
> protocol, and not a format, isn't it?

Yes, technically there are two distinct axis  formats vs protocols, but
from the POV of running the 'check' script the boundary is rather blurred.

You can run './check -nbd' and './check -qcow2', or both combined. The main
limit that you can only pick a single format and single protocol at a time.

IMHO for test suites it is preferrable to keep a flat namespace, rather
than creating a matrix of suites for protocol vs format combniations.

Perhaps the meson.build variable should just be renamed from _formats
to something else.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


