Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BA08D6D226
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Dec 2025 13:50:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vWENu-00086F-70; Thu, 18 Dec 2025 08:49:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vWENm-00085R-Jb
 for qemu-devel@nongnu.org; Thu, 18 Dec 2025 08:49:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vWENk-0002fp-3m
 for qemu-devel@nongnu.org; Thu, 18 Dec 2025 08:49:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766065766;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TkUTDCM1LjnUxWNUFQKot/1mVWD7+4DriKR9XDn3imw=;
 b=YvBCG6ODGQ2q9pkM8i14u6/nYuf9nMvUO9e6ZfV+5BlB5GYOvpoyEzUlIrbivncZ0F7qYF
 S/bAxjP6ykqlosDZ6cbQkNk8gQ3BB1CagOgowpDWOpcv6wqOGSXRjw+rwJ8QgDnATw8Vrl
 TOF1ICYpdWPZ9CznpOuomfRoxWIg+RA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-558-hPOF6vI_OZiDsx__VZ7oTw-1; Thu,
 18 Dec 2025 08:49:24 -0500
X-MC-Unique: hPOF6vI_OZiDsx__VZ7oTw-1
X-Mimecast-MFC-AGG-ID: hPOF6vI_OZiDsx__VZ7oTw_1766065763
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 624981956046
 for <qemu-devel@nongnu.org>; Thu, 18 Dec 2025 13:49:23 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.225])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0DA4A1956056; Thu, 18 Dec 2025 13:49:19 +0000 (UTC)
Date: Thu, 18 Dec 2025 13:49:13 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: Report on MAINTAINERS coverage
Message-ID: <aUQGWes2pCSWTDfe@redhat.com>
References: <87h5toc61n.fsf@pond.sub.org> <aUP5znRDyuBlpGvW@redhat.com>
 <871pkrdi6w.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <871pkrdi6w.fsf@pond.sub.org>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Thu, Dec 18, 2025 at 02:37:43PM +0100, Markus Armbruster wrote:
> Daniel P. Berrangé <berrange@redhat.com> writes:
> 
> > On Thu, Dec 18, 2025 at 01:45:24PM +0100, Markus Armbruster wrote:
> >> Which unmaintained files are we still changing?  Unmaintained files
> >> sorted by number of commits in the past year (since v9.2.0):
> >> 
> >>     $ for i in `cat unmaintained-files`; do echo -n "$i "; git-rev-list v9.2.0.. $i | wc -l; done | awk '{ printf "%7d %s\n", $2, $1 }' | sort -rn
> >> 
> >>     107 tests/functional/meson.build
> >
> > Opps, that's a mistake. It should of course be under the
> > general maint heading "Functional testing framework"
> 
> Thanks!  I can patch that.
> 
> What about the other uncovered files in tests/functional/?

> tests/functional/aarch64/meson.build

[snip many more]

I'd wildcard   tests/functional/*/meson.build under the
general maint.

> tests/functional/acpi-bits/bits-config/bits-cfg.txt
> tests/functional/acpi-bits/bits-tests/smbios.py2
> tests/functional/acpi-bits/bits-tests/smilatency.py2
> tests/functional/acpi-bits/bits-tests/testacpi.py2
> tests/functional/acpi-bits/bits-tests/testcpuid.py2

I expected those to already be covered by:

  ACPI/FUNCTIONAL/BIOSBITS
  M: Ani Sinha <anisinha@redhat.com>
  M: Michael S. Tsirkin <mst@redhat.com>
  S: Supported
  F: tests/functional/acpi-bits/*
  F: tests/functional/x86_64/test_acpi_bits.py
  F: docs/devel/testing/acpi-bits.rst

but I guess tests/functional/acpi-bits/*  doesn't recurse
into subdirs ?

> tests/functional/arm/test_max78000fthr.py

Added by Thomas but not sure what maintainers category it should go
under.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


