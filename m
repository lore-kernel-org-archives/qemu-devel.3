Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 697F4FF495E
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2026 13:36:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7CnF-0000t8-6H; Mon, 30 Mar 2026 09:36:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1w7CnE-0000t0-4n
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 09:36:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1w7CnC-0001Nd-G1
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 09:36:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774877792;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZAVMw/J9sOw5s/263CAdqtyiSYdIqqu6CLr3o2x8kYc=;
 b=Jt6AvWf+JMSw01CuIM0PoAe9tdXv3M3t670x0696/oMkM+MNfXgFWUTnF97OFyys/snVLZ
 uuqLDorIhfL3tmuSohyn3QnJimLIAUU+rvjrhbct/BwGwbssYD8oxCma95F3/1C/KuNLf7
 /x9ebS0aPQb2Q8vdxcTCgw6xnCwHjEE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-537-XMuazWTkPM6LyQZ--GT1sw-1; Mon,
 30 Mar 2026 09:36:29 -0400
X-MC-Unique: XMuazWTkPM6LyQZ--GT1sw-1
X-Mimecast-MFC-AGG-ID: XMuazWTkPM6LyQZ--GT1sw_1774877788
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 010CD1955D9A; Mon, 30 Mar 2026 13:36:28 +0000 (UTC)
Received: from redhat.com (unknown [10.44.36.79])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AD12230001A1; Mon, 30 Mar 2026 13:36:25 +0000 (UTC)
Date: Mon, 30 Mar 2026 14:36:22 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: Stepan Popov <Stepan.Popov@kaspersky.com>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH] meson: add missing semicolon in
 pthread_condattr_setclock test
Message-ID: <acp8VmIN1cwNAxE-@redhat.com>
References: <20260330131406.87080-1-Stepan.Popov@kaspersky.com>
 <CAMxuvawBPPBfBhLy-9H43fPT64M6iJV+LZiE0CmqP6BfJkAFQA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMxuvawBPPBfBhLy-9H43fPT64M6iJV+LZiE0CmqP6BfJkAFQA@mail.gmail.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 27
X-Spam_score: 2.7
X-Spam_bar: ++
X-Spam_report: (2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SBL_CSS=3.335,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1, RCVD_IN_VALIDITY_RPBL_BLOCKED=1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Mon, Mar 30, 2026 at 05:32:33PM +0400, Marc-André Lureau wrote:
> Hi
> 
> On Mon, Mar 30, 2026 at 5:21 PM Stepan Popov <Stepan.Popov@kaspersky.com> wrote:
> >
> > The test code was missing a semicolon after the pthread_condattr_t
> > variable declaration.
> >
> > Signed-off-by: Stepan Popov <Stepan.Popov@kaspersky.com>
> 
> Fixes: 657ac98b58 ("thread-posix: use monotonic clock for QemuCond and
> QemuSemaphore")

IOW, that commit has been dead code since it was first added years ago,
we've never used the monotonic clock

> Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> > ---
> >  meson.build | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/meson.build b/meson.build
> > index d7c4095b39..5447504ea8 100644
> > --- a/meson.build
> > +++ b/meson.build
> > @@ -2882,7 +2882,7 @@ config_host_data.set('CONFIG_PTHREAD_CONDATTR_SETCLOCK', cc.links(osdep_prefix +
> >
> >    int main(void)
> >    {
> > -    pthread_condattr_t attr
> > +    pthread_condattr_t attr;
> >      pthread_condattr_init(&attr);
> >      pthread_condattr_setclock(&attr, CLOCK_MONOTONIC);
> >      return 0;
> > --
> > 2.34.1
> >
> 

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


