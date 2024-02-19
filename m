Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 490CDC48BF8
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Feb 2024 15:54:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rc5xS-0002Ru-II; Mon, 19 Feb 2024 10:53:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rc5xR-0002Pa-9Y
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 10:53:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rc5xP-0002F7-GL
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 10:53:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708358006;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=8ns/PwRe/J423cCaUwa8i01r5zRGB3FwnM6fW4Zb6pU=;
 b=JWTIdsMG4QePl+236iEnsNSTuFwnqUzusxcY7LrCJbR4wacmGtSTOt/vSbdeBOuxlHwAip
 yGJ+NSIQqmt3YlAPnIuZ45gTs4jI92WCAmwBSOxk6VyOWUQHnuA8yO0A1HpW01fUjwR26g
 NYvGCHPDcogilddQ1eLfo4w7u/exvmU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-328-F4-1iHXhMjK_uR_mPnQJMw-1; Mon, 19 Feb 2024 10:53:24 -0500
X-MC-Unique: F4-1iHXhMjK_uR_mPnQJMw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8C0BF85A588;
 Mon, 19 Feb 2024 15:53:24 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.30])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D7F1E492BC6;
 Mon, 19 Feb 2024 15:53:23 +0000 (UTC)
Date: Mon, 19 Feb 2024 15:53:21 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Stefan Weil <sw@weilnetz.de>
Subject: Re: dropping 32-bit Windows host support
Message-ID: <ZdN5cbaqnJMTK5ts@redhat.com>
References: <CAFEAcA_BB5-eieVGuqqXn3aS-Vmc7OcTFmv5e=i5HgNw3Kp2FQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA_BB5-eieVGuqqXn3aS-Vmc7OcTFmv5e=i5HgNw3Kp2FQ@mail.gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.072,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Mon, Feb 19, 2024 at 03:37:31PM +0000, Peter Maydell wrote:
> Our msys2 32-bit Windows host CI job has been failing recently
> because upstream MSYS2 are starting to phase out 32-bit windows
> host support and are steadily removing i686 versions of packages.
> The latest is dtc:
> https://gitlab.com/qemu-project/qemu/-/issues/2177
> 
> The writing is clearly on the wall for their 32-bit support, judging
> from the "2023-12-13 - Starting to drop some 32-bit Packages" news
> item at https://www.msys2.org/news/ and associated discussion at
> https://github.com/msys2/MINGW-packages/discussions/19326 .
> 
> QEMU on a 32-bit host is not likely to be a great experience, and I
> suspect we don't have many users using 32-bit Windows who couldn't
> use the 64-bit version instead. Our Download page points users at
> MSYS2's packages, and they have already dropped the 32-bit QEMU
> package build. Stefan Weil's binaries page, which is the other thing
> we link to from Download, has no 32-bit version newer than 7.2.0.
> So anybody using 32-bit Windows QEMU must be building it themselves.
> Plus, we've already deprecated system emulation on 32-bit x86 hosts,
> so the only remaining "supported" config is with the NVMM or WHPX
> accelerators.

The other data point is that Win11 is 64-bit only, and IIUC,
Win10 was 64-bit only for new OEM installs too, only upgrades
or end user installs could choose 32-bit. 

> 
> I suggest that we should:
> 
>  * remove the msys2-32bit CI job entirely (we will still have at least
>    compile-time coverage via the cross-win32-system job)
>  * document that the 32-bit Windows support is deprecated in
>    docs/about/build-platforms.rst and deprecated.rst
>  * update our Download page to remove mention of 32-bit Windows
> 
> Any objections?

I think that's sane.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


