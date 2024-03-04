Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECFD7C48BF6
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Mar 2024 18:06:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhCgs-0002KC-SM; Mon, 04 Mar 2024 13:05:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rhCgq-0002IR-Bz
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 13:05:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rhCgl-0006kU-Hb
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 13:05:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709575495;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=snQzYUDnWdw0MG7Qo1Bv4X9whUPfDBq91Q5ADGcqhiQ=;
 b=RKlKI0CEnGPuIl1wbYuJgIRj0r83F3ty/ZinZNx8uXIyjwHgovLhMsqUCdAaDObMvc3XRa
 sNOw6oZh/dT9hxsGl8r7/IjNKROnaUamjyhhm+UVu0+NVC8ALpjqDFL6nuVUpFQfcflRdJ
 nZYDB9Uxzg45UsKZ1BGbmpKDR86J2z0=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-680-wex_cxKkNemqaSg9yv_d_A-1; Mon,
 04 Mar 2024 13:04:52 -0500
X-MC-Unique: wex_cxKkNemqaSg9yv_d_A-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E3A0D28AC1EB;
 Mon,  4 Mar 2024 18:04:51 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.54])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3AEB0492BD8;
 Mon,  4 Mar 2024 18:04:51 +0000 (UTC)
Date: Mon, 4 Mar 2024 18:04:49 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 qemu-stable@nongnu.org
Subject: Re: [PATCH v2] docs/conf.py: Remove usage of distutils
Message-ID: <ZeYNQdqW2bBA4gNL@redhat.com>
References: <20240304130403.129543-1-thuth@redhat.com>
 <CAFEAcA8rac2nEzrVWUWfRHAWYLmC6dSDMK=j6msD_SdPpn6ZtA@mail.gmail.com>
 <3262c873-b845-4286-a71f-a53b96bbc8a9@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3262c873-b845-4286-a71f-a53b96bbc8a9@redhat.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.571,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Mon, Mar 04, 2024 at 06:11:58PM +0100, Thomas Huth wrote:
> On 04/03/2024 17.56, Peter Maydell wrote:
> > On Mon, 4 Mar 2024 at 13:04, Thomas Huth <thuth@redhat.com> wrote:
> > > 
> > > The macOS jobs in our CI recently started failing, complaining that
> > > the distutils module is not available anymore. And indeed, according to
> > > https://peps.python.org/pep-0632/ it's been deprecated since a while
> > > and now likely got removed in recent Python versions.
> > 
> > This doesn't seem to be sufficient to fix the macos CI:
> > something in glib seems to still be using it.
> > 
> > https://gitlab.com/qemu-project/qemu/-/jobs/6313212803
> > 
> > [281/6553] Generating ui/dbus-display gdbus-codegen with a custom command
> > FAILED: ui/dbus-display1.h ui/dbus-display1.c
> > /opt/homebrew/Cellar/glib/2.78.4/bin/gdbus-codegen
> > ui/dbus-display1.xml --glib-min-required 2.64 --output-directory
> > /private/var/folders/xc/tpssff9959345bnqq4c6tlww0000gn/T/cirrus-ci-build/build/ui
> > --interface-prefix org.qemu. --c-namespace QemuDBus --generate-c-code
> > dbus-display1
> ...
> > ModuleNotFoundError: No module named 'distutils'
> 
> Looking at the glib sources, I think this has been fixed here:
> 
>  https://gitlab.gnome.org/GNOME/glib/-/commit/6ef967a0f930ce37a8c9b5aff96969
> 
> The fix will be in glib 2.79, unfortunately homebrew still seems to use glib
> 2.78 ...
> 
> We could maybe temporarily work-around the problem by disabling the dbus
> code in the CI job? Or just wait for homebrew to update the package?

File a bug against homebrew. IME they are very quick (1-3 days) at
putting out fixes for things like this, especially if you point them
to the upstream solution. 


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


