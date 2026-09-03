Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6102DC624A4
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 11:38:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x25lL-0007Di-Fs; Thu, 03 Sep 2026 07:37:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1x25lK-0007DY-4z
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 07:37:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1x25lI-0000kh-HX
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 07:37:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788435463;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=R8+A7jqH6US/7RLrR8qrqTEgZf/Y6bdlZnvS8Zb9Rds=;
 b=LPLoDKH52Nd+ecTUk80kChZzJYdcQyMdjx0dz3duZbFmJpzFQ0LA19ZhuxuIM35ADD2yGV
 YuLeM8l0ZWoLVbswnmqDNwi8gBt1bM9UzdGbgQWl9bpolp2E4i+YIQhF2/Xvb0DXpwENEe
 sNJxy6Qfl+n8BrpxiPcZbSwsD6TA7UA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-576-2pGrYNx2Mf-C1LIpF379EA-1; Thu,
 03 Sep 2026 07:37:39 -0400
X-MC-Unique: 2pGrYNx2Mf-C1LIpF379EA-1
X-Mimecast-MFC-AGG-ID: 2pGrYNx2Mf-C1LIpF379EA_1788435458
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 618D018052D4; Thu,  3 Sep 2026 11:37:38 +0000 (UTC)
Received: from redhat.com (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AD5C9434; Thu,  3 Sep 2026 11:37:36 +0000 (UTC)
Date: Thu, 3 Sep 2026 12:37:33 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@mailo.com>
Subject: Re: [PATCH 1/4] meson: simplify clang version checks
Message-ID: <aplb_a250Tvj_jXE@redhat.com>
References: <20260903103548.2142568-1-berrange@redhat.com>
 <20260903103548.2142568-2-berrange@redhat.com>
 <CAMxuvazkHrYr6z_MgRNhGXptZHdxS=oufBbrEnc6MuF+2q6-SA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMxuvazkHrYr6z_MgRNhGXptZHdxS=oufBbrEnc6MuF+2q6-SA@mail.gmail.com>
User-Agent: Mutt/2.4.0 (2026-06-19)
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Sep 03, 2026 at 03:35:48PM +0400, Marc-André Lureau wrote:
> Hi
> 
> On Thu, Sep 3, 2026 at 2:35 PM Daniel P. Berrangé <berrange@redhat.com> wrote:
> >
> > The checks for the clang minor versions are currently redundant since
> > there can never be a minor version less than zero. Going forward it
> > is likely sufficient to always pick a NN.0.0 release as the min CLang
> > version, so drop the minor version checks.
> >
> > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> 
> This is basically since your commit 2a85a08c998. I'm happy if that is
> enough on macos:
> Acked-by: Marc-André Lureau <marcandre.lureau@redhat.com>

Yes, we should arguably add a "Fixes: 2a85a08c998", since that
introduced the bogus  < 0 comparison.

> 
> 
> > ---
> >  meson.build | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/meson.build b/meson.build
> > index 5c9de307b0..70e2755149 100644
> > --- a/meson.build
> > +++ b/meson.build
> > @@ -330,11 +330,11 @@ foreach lang : all_languages
> >      # ok
> >    elif compiler.get_id() == 'clang' and compiler.compiles('''
> >        #ifdef __apple_build_version__
> > -      # if __clang_major__ < 15 || (__clang_major__ == 15 && __clang_minor__ < 0)
> > +      # if __clang_major__ < 15
> >        #  error You need at least XCode Clang v15.0 to compile QEMU
> >        # endif
> >        #else
> > -      # if __clang_major__ < 10 || (__clang_major__ == 10 && __clang_minor__ < 0)
> > +      # if __clang_major__ < 10
> >        #  error You need at least Clang v10.0 to compile QEMU
> >        # endif
> >        #endif''')
> > --
> > 2.55.0
> >
> 

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


