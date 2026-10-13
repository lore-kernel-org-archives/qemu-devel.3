Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15CFDCC6B03
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 07:54:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGXK1-00021Z-EO; Tue, 13 Oct 2026 03:53:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xGXJz-000212-6P
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 03:53:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xGXJw-0002Xs-Tm
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 03:53:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791877991;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XLB3L+I+q9Qod+AMzEBwjRytE8KoH0VDpmVYMWPuBdE=;
 b=CZjofhM5kZ3ibycs9+Fw0OiT0oE9NG30FEJBZAtu/HrR3iOvfuvMzbkXtpS3T5C6G9u+m4
 4sLuceoIUJ/wcJ+w5thp+Wo6xX037VHcD+TiEKPG+drBg6Juym+K8AIIUn2oGDf4L3Qvcz
 p1Ca/pzEIv0Cpyp+9NSSfye1RrWYrB8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-259-EjmdCesiOXKiDzuovxM_0g-1; Tue,
 13 Oct 2026 07:53:04 +0000
X-MC-Unique: EjmdCesiOXKiDzuovxM_0g-1
X-Mimecast-MFC-AGG-ID: EjmdCesiOXKiDzuovxM_0g_1791877983
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7AF9C195422F; Tue, 13 Oct 2026 07:53:02 +0000 (UTC)
Received: from redhat.com (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7ADF9180034F; Tue, 13 Oct 2026 07:52:59 +0000 (UTC)
Date: Tue, 13 Oct 2026 08:52:56 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Filip Hejsek <filip.hejsek@gmail.com>
Cc: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>,
 Laurent Vivier <laurent@vivier.eu>, qemu-trivial@nongnu.org
Subject: Re: [PATCH TRIVIAL] treewide: use qemu_dup() instead of dup()
Message-ID: <as3jWHX-ukeyaR6j@redhat.com>
References: <20261012-use-qemu-dup-v1-1-03d94852a6c8@gmail.com>
 <CAMxuvazc5iHk=GDysFHVFN0xtf-g75AobhoKdPXaR6_Qz=dDNg@mail.gmail.com>
 <90fe897aa35405fbada7a440c3fab848d81ea2b0.camel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <90fe897aa35405fbada7a440c3fab848d81ea2b0.camel@gmail.com>
User-Agent: Mutt/2.4.2 (2026-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Mon, Oct 12, 2026 at 10:12:34PM +0200, Filip Hejsek wrote:
> Hello,
> 
> On Mon, 2026-10-12 at 23:54 +0400, Marc-André Lureau wrote:
> > Hi
> > 
> > On Mon, Oct 12, 2026 at 11:44 PM Filip Hejsek <filip.hejsek@gmail.com> wrote:
> > > 
> > > Make the use of qemu_dup() more consistent and eliminate the possibility
> > > of accidentally creating non-cloexec fds.
> > > 
> > 
> > Not so trivial, in my humble opinion, as there might have been some
> > reason it was avoided.
> > 
> 
> You're right, I shouldn't have tagged this as TRIVIAL.
> 
> I've actually intentionally left some dup()s unchanged for exactly this
> reason. They are the ones in qemu-nbd.c, migration/cpr-exec.c, and
> under linux-user/ and bsd-user/. I also didn't touch the tests, as I
> didn't consider evaluating them to be worth the effort.

IMHO, everything must be switched to use qemu_dup.  If a few callers
actually want the FD to remain open across execve, then they should
explicitly call qemu_clear_cloexec().  THis makes the intended
behaviour clear, as opposed to looking like a potential mistake.

> 
> I should have put this info in the commit message...
> 
> > > [...]
> > 
> > After review I think these changes are valid. These changes shouldn't
> > impact the exec() code paths in qemu.
> > 
> > Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> > 
> 
> Thanks for reviewing this.
> 
> Filip
> 

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


