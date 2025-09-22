Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32316CAC5A7
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Sep 2025 09:07:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0cVh-00039j-V4; Mon, 22 Sep 2025 05:07:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v0cVS-00039J-IW
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 05:06:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v0cVP-0002ao-2g
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 05:06:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758531998;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nTy4j9pXhnFqcdukWPOvecyj1pSE9WkFcgRVuR6M6Fk=;
 b=UjGLHgbdbvIoJBpN3DF3Z1rMpEfDFFBSUXP2oI2FrGoETpo4fUE09ImATnAWV6edK3d+Dg
 xbbpGDzdgXl6wnXJn0St2e4hUsxfgDEravlhpsDlOW8K4/6UnTtTMyX6msyhWVm6eZftiA
 chd+xa3GwqZU/M3+1ErCD3yCHKS3HBE=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-65-nEW9ukCzP1quvhMQGEOtzw-1; Mon,
 22 Sep 2025 05:06:34 -0400
X-MC-Unique: nEW9ukCzP1quvhMQGEOtzw-1
X-Mimecast-MFC-AGG-ID: nEW9ukCzP1quvhMQGEOtzw_1758531992
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 518E019560AE; Mon, 22 Sep 2025 09:06:32 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.69])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5835C18004A3; Mon, 22 Sep 2025 09:06:27 +0000 (UTC)
Date: Mon, 22 Sep 2025 10:06:24 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Ed Maste <emaste@freebsd.org>, Thomas Huth <thuth@redhat.com>,
 Li-Wen Hsu <lwhsu@freebsd.org>,
 Yonggang Luo <luoyonggang@gmail.com>, Warner Losh <imp@bsdimp.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Kohei Tokunaga <ktokunaga.mail@gmail.com>, Kyle Evans <kevans@freebsd.org>
Subject: Re: [PATCH 14/24] tests: move mips to debian-legacy-test-cross
Message-ID: <aNERkB5WhM4ePIHn@redhat.com>
References: <20250919133320.240145-1-marcandre.lureau@redhat.com>
 <20250919133320.240145-15-marcandre.lureau@redhat.com>
 <aM1m13xBnM9WU_E3@redhat.com>
 <CAMxuvayXSdVaz=i56T686oKpKf5gE4y6YaPgedPBKGQEPx0v8w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMxuvayXSdVaz=i56T686oKpKf5gE4y6YaPgedPBKGQEPx0v8w@mail.gmail.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On Mon, Sep 22, 2025 at 12:38:09PM +0400, Marc-André Lureau wrote:
> Hi
> 
> On Fri, Sep 19, 2025 at 6:21 PM Daniel P. Berrangé <berrange@redhat.com>
> wrote:
> 
> > On Fri, Sep 19, 2025 at 05:33:08PM +0400, marcandre.lureau@redhat.com
> > wrote:
> > > From: Marc-André Lureau <marcandre.lureau@redhat.com>
> > >
> > > We are updating debian which dropped support for it:
> > >
> > https://www.debian.org/releases/trixie/release-notes/issues.html#mips-architectures-removed
> >
> > If Debian 13 has dropped it, why aren't we just keeping the mips
> > dockerfiles on 12 ?
> >
> > The debian-legacy-test-cross a manually written dockerfile that
> > has almost none of our deps installed, and is still on 11 which
> > is outside our support matrix now. So I don't think we should
> > be expanding use of debian-legacy-test-cross, ideally it would
> > be removed entirely.
> >
> >
> debian-legacy-test-cross is for tests/tcg. Debian 11 supports more
> architecture than 12 or 13..

If there are architectures in 11 that can't be tested in 12,
then from QEMU's POV that is now an untestable feature, since
11 is outside our support target and we don't want to be
holding back our support platforms for this.

> > > diff --git a/tests/lcitool/refresh b/tests/lcitool/refresh
> > > index 6f98a91277..917ff4abfb 100755
> > > --- a/tests/lcitool/refresh
> > > +++ b/tests/lcitool/refresh
> > > @@ -215,16 +215,6 @@ try:
> > >                                              "x86_64-linux-user,"
> > >
> > "i386-softmmu,i386-linux-user"))
> > >
> > > -    generate_dockerfile("debian-mips64el-cross", "debian-12",
> > > -                        cross="mips64el",
> > > -                        trailer=cross_build("mips64el-linux-gnuabi64-",
> > > -
> > "mips64el-softmmu,mips64el-linux-user"))
> > > -
> > > -    generate_dockerfile("debian-mipsel-cross", "debian-12",
> > > -                        cross="mipsel",
> > > -                        trailer=cross_build("mipsel-linux-gnu-",
> > > -
> > "mipsel-softmmu,mipsel-linux-user"))
> > > -
> >
> > I'm not seeing the need to remove these, when they could just
> > stay on -12, when the next commit updates the other arches
> > to -13.
> >
> 
> Indeed.. it depends how much we want to keep covering. We already don't
> cover all qemu cross compilations. The question is do we want to keep
> cross-compiling for soon unsupported arches?
> 
> @Bennée, Alex <alex.bennee@linaro.org> might know, thanks

A feature remains fully supported for production use the while time it
is marked as deprecated. Provided one of our current supported platforms
has the ability to test it, there should be no change to our testing
status of deprecated features. Given that -12 is still a supported
platform we should continue to use that, and certainly not replace it
with -11 which is an unsupported platform.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


