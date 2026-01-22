Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD3EAC44500
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Jan 2026 09:44:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1virEa-0003wB-FE; Thu, 22 Jan 2026 04:44:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1virEU-0003ua-DQ
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 04:44:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1virER-0006Xk-QY
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 04:44:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769075043;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iWSeVGR5Az7f1QxzGbto8973a5PabYn6MIU3GHaoFMk=;
 b=WuExmNvigjvAMfwRO83iLUhH07+Zd9bl7Wl5JTG9PFwkW9A5otZtAul24TCR8LQlmakX7S
 bshxNH5ffm7xJZa2/pr4Este7csqlTAzcEf+hlvnQ0wbzrEIWFf5xoSfOxAcGA7cmBn0GY
 1FzQAoKzu8UweackdDWq6vAPSYeTDEY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-507-fhLhafuZPJKgsvn72Ab8Uw-1; Thu,
 22 Jan 2026 04:44:00 -0500
X-MC-Unique: fhLhafuZPJKgsvn72Ab8Uw-1
X-Mimecast-MFC-AGG-ID: fhLhafuZPJKgsvn72Ab8Uw_1769075039
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6BEAA1800613; Thu, 22 Jan 2026 09:43:59 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.63])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8508C30002DC; Thu, 22 Jan 2026 09:43:56 +0000 (UTC)
Date: Thu, 22 Jan 2026 09:43:53 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-trivial@nongnu.org,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Michael Roth <michael.roth@amd.com>,
 Kostiantyn Kostiuk <kkostiuk@redhat.com>
Subject: Re: [PATCH] Replace CONFIG_WIN32 with CONFIG_WIN64
Message-ID: <aXHxWbvjB9Lz6dKO@redhat.com>
References: <20260122090352.9901-1-thuth@redhat.com>
 <aXHtxBfuIRsJ3P_M@redhat.com>
 <CAFEAcA8QNKwmOndVbq3eTkihpKjD0t01mAJ7DJLOQA3JqkkmWw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFEAcA8QNKwmOndVbq3eTkihpKjD0t01mAJ7DJLOQA3JqkkmWw@mail.gmail.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.069,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Thu, Jan 22, 2026 at 09:37:37AM +0000, Peter Maydell wrote:
> On Thu, 22 Jan 2026 at 09:30, Daniel P. Berrangé <berrange@redhat.com> wrote:
> >
> > On Thu, Jan 22, 2026 at 10:03:52AM +0100, Thomas Huth wrote:
> > > From: Thomas Huth <thuth@redhat.com>
> > >
> > > We stopped supported 32-bit Windows hosts a while ago already, so
> > > let's rename CONFIG_WIN32 to CONFIG_WIN64 now to make it clear
> > > that this switch is not about 32-bit Windows anymore.
> > >
> > > The patch has been created with a simple sed statement:
> > >
> > >  sed -i s/CONFIG_WIN32/CONFIG_WIN64/g $(grep -rl CONFIG_WIN32 *)
> > >
> > > Signed-off-by: Thomas Huth <thuth@redhat.com>
> 
> > > @@ -2422,7 +2422,7 @@ config_host_data.set('CONFIG_GCOV', get_option('b_coverage'))
> > >  config_host_data.set('CONFIG_LIBUDEV', libudev.found())
> > >  config_host_data.set('CONFIG_LINUX', host_os == 'linux')
> > >  config_host_data.set('CONFIG_POSIX', host_os != 'windows')
> > > -config_host_data.set('CONFIG_WIN32', host_os == 'windows')
> > > +config_host_data.set('CONFIG_WIN64', host_os == 'windows')
> >
> > While relevant to qapi file conditions, from a C code pov all of these
> > are redundant as the compiler has all these facts built-in
> >
> >   #ifdef CONFIG_LINUX =>    #ifdef __linux__
> >   #ifdef CONFIG_POSIX =>    #if !defined(_WIN32)
> >   #ifdef CONFIG_WIN32 =>    #ifdef _WIN32
> 
> checkpatch will warn about use of __linux__, though, so
> hopefully we don't get more of them in new code:

I guess I'd ask why we consider __linux__ to be worse than CONFIG_LINUX ?

Every contributor we know __linux__, but CONFIG_LINUX  needs QEMU specific
knowledge. It feels like we should prefer the choice that everyone will know
*provided* they're both functionally equivalent.

> WARNING: architecture specific defines should be avoided
> #4761: FILE: block/file-posix.c:4761:
> +#ifdef __linux__

That warning has never made that much sense when I've seen it appear,
as __linux__ isn't an architecture, its an OS :-)

> It fails to catch _WIN32 because it's looking for "__".

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


