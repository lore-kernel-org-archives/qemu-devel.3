Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5434E7DF11
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 17:35:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vmxpL-00053C-Ct; Mon, 02 Feb 2026 12:35:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vmxpJ-00051w-Kk
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 12:35:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vmxpG-0003wk-Ta
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 12:35:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770053700;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=rhfKrOZuol5rNfBf5U7VihejPsNFkgswiojaUMt4INE=;
 b=CRNvoSUGKxP27Cfo4VFWtANCOvc0kMt8J5wRAqKay7suLuRxmaJdwLiAN6CjDNohkG8Zsr
 hdqYOPBbpd7v30RQZFcEvy5IB5fprSj1m7ANtC6RG+hh3qX7M8iotedP1CO/kj4enCrqFH
 LJjCdfeaHiLcQl3T6Pmna+66iKUk6WI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-623-GexrOyugMNKDu-CDs6oYig-1; Mon,
 02 Feb 2026 12:34:55 -0500
X-MC-Unique: GexrOyugMNKDu-CDs6oYig-1
X-Mimecast-MFC-AGG-ID: GexrOyugMNKDu-CDs6oYig_1770053694
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 74E1D1954B17; Mon,  2 Feb 2026 17:34:54 +0000 (UTC)
Received: from redhat.com (unknown [10.45.226.68])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 35BFD1956053; Mon,  2 Feb 2026 17:34:51 +0000 (UTC)
Date: Mon, 2 Feb 2026 17:34:48 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 Cornelia Huck <cohuck@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Subject: Re: [PULL 00/21] Plugins patches for 2026-01-29
Message-ID: <aYDgONbUOWdUi7SO@redhat.com>
References: <20260129173811.138036-1-pierrick.bouvier@linaro.org>
 <2d69de6e-da9f-4f90-b805-9553bb72c78d@linaro.org>
 <7ac8fe1f-8098-4417-a97b-1a82c0fd23ca@linaro.org>
 <CAFEAcA_zghZeA0PzivCY9vCcFk6rVLwvP3in35rA=bF8yrdeyQ@mail.gmail.com>
 <878qdbtam7.fsf@redhat.com>
 <23be2c83-01ea-495d-b14e-496bd3e0a687@nutanix.com>
 <bd097ad0-d18e-42fc-9746-db4d448b71fa@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <bd097ad0-d18e-42fc-9746-db4d448b71fa@linaro.org>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Mon, Feb 02, 2026 at 09:30:31AM -0800, Pierrick Bouvier wrote:
> On 2/2/26 8:55 AM, Mark Cave-Ayland wrote:
> > On 02/02/2026 15:42, Cornelia Huck wrote:
> > 
> > > On Mon, Feb 02 2026, Peter Maydell <peter.maydell@linaro.org> wrote:
> > > 
> > > > On Mon, 2 Feb 2026 at 04:04, Richard Henderson
> > > > <richard.henderson@linaro.org> wrote:
> > > > > 
> > > > > On 1/30/26 04:41, Pierrick Bouvier wrote:
> > > > > > On 1/29/26 9:37 AM, Pierrick Bouvier wrote:
> > > > > > >          contrib/plugins: add empty cpp plugin
> > > > 
> > > > Hi; this fails to build for me on Linux (Ubuntu 24.04) with clang:
> > > > 
> > > > In file included from ../../contrib/plugins/cpp.cpp:33:
> > > > /usr/bin/../lib/gcc/x86_64-linux-gnu/14/../../../../include/c++/14/coroutine:38:3:
> > > > error: "the <coroutine> header requires -fcoroutines"
> > > >      38 | # error "the <coroutine> header requires -fcoroutines"
> > > >         |   ^
> > > > 1 error generated.
> > > 
> > > Fails for me as well on Fedora 42 (x86_64) with gcc:
> > > 
> > > In file included from ../qemu/contrib/plugins/cpp.cpp:33:
> > > /usr/include/c++/15/coroutine:43:3: error: #error "the <coroutine> header requires -fcoroutines"
> > >      43 | # error "the <coroutine> header requires -fcoroutines"
> > >         |   ^~~~~
> > > 
> > > (It works for me on an aarch64 RHEL 9 system.)
> > 
> > Is this with a clean build? I had exactly the same error message
> > earlier, but I was able to fix it by destroying my build/ directory,
> > then re-running configure followed again by make.
> > 
> 
> Thanks for the reports everyone.
> 
> I tried it on ubuntu LTS and didn't encounter this problem.
> What is happening is that meson unfortunately caches default_options set,
> including the C++ standard version in our case.
> Thus, you indeed need to clean and rebuild once.
> 
> The solution for this would be to not use default_options and add the flag
> to qemu_cflags instead. It's the same limitation if we change the default
> warning level, or any other option set with default_options.

If that's correct as the root cause, then it feels like this is a meson bug
that ought to be reported upstream. Any meson.build default_options changes
that affect the compiler behaviour should invalidate cache in the same way
as when we modify qemu_cflags.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


