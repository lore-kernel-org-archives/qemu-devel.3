Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BBE8C61DC2
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 10:39:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzXVw-0006HY-QZ; Thu, 27 Aug 2026 06:39:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wzXVu-0006BW-QJ
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 06:39:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wzXVs-0006cU-DC
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 06:39:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787827155;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Sh2ItbHMtt9R9prB2DjXICGhJMdpA/DTXqxNXtteEOo=;
 b=GQYElf3+oJ94kmmP1siv7qfT6+QiVTMHaitR4xrEreD4rSVChZwzRqzQiWJFIKHmuYQ412
 6/m+NIgeRT95PCCs6GrTgzuTHwND9+UrN3+g1zVDfhVAEazRFRsWMEBbhTLDyMtMgcnfsi
 fKB0vTUIecRVGNkPaFuO1wrfAWQxYHc=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-596-mEp1c4bQM6SkClcUvKskWQ-1; Thu,
 27 Aug 2026 06:39:13 -0400
X-MC-Unique: mEp1c4bQM6SkClcUvKskWQ-1
X-Mimecast-MFC-AGG-ID: mEp1c4bQM6SkClcUvKskWQ_1787827152
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 78A0E1955F7B; Thu, 27 Aug 2026 10:39:12 +0000 (UTC)
Received: from redhat.com (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4AE4E3000223; Thu, 27 Aug 2026 10:39:11 +0000 (UTC)
Date: Thu, 27 Aug 2026 11:39:08 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] system: improve -mon deprecation warning
Message-ID: <apATzOPQY3bQFzXk@redhat.com>
References: <20260824122942.85863-1-berrange@redhat.com>
 <CAFEAcA-P889KqaTK5NUDQ8Y4ZoeHqUTLFSdoGcO0T_9n05BduQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFEAcA-P889KqaTK5NUDQ8Y4ZoeHqUTLFSdoGcO0T_9n05BduQ@mail.gmail.com>
User-Agent: Mutt/2.4.0 (2026-06-19)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
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

On Thu, Aug 27, 2026 at 09:48:50AM +0100, Peter Maydell wrote:
> On Mon, 24 Aug 2026 at 13:29, Daniel P. Berrangé <berrange@redhat.com> wrote:
> >
> > Expand the text a bit to make the new syntax more explicit and point
> > users to the man page for further info.
> >
> > Reported-by: Peter Maydell <peter.maydell@linaro.org>
> > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> > ---
> >  system/vl.c | 7 +++++--
> >  1 file changed, 5 insertions(+), 2 deletions(-)
> >
> > diff --git a/system/vl.c b/system/vl.c
> > index 061cbdf860..d5b5392569 100644
> > --- a/system/vl.c
> > +++ b/system/vl.c
> > @@ -3239,8 +3239,11 @@ void qemu_init(int argc, char **argv)
> >                  default_monitor = 0;
> >                  break;
> >              case QEMU_OPTION_mon:
> > -                warn_report_once("'-mon' is deprecated, use '-object' with "
> > -                                 "'monitor-hmp' or 'monitor-qmp' types instead");
> > +                warn_report_once("'-mon' is deprecated. Switch to either "
> > +                                 "'-object monitor-hmp,id=ID,chardev=CHR-ID' "
> > +                                 "or '-object monitor-qmp,id=qmpNN,chardev=CHR-ID' "
> 
> why the difference in id=ID vs id=qmpNN ?

A mistake :-)

> > +                                 "instead. See '-object' docs in 'qemu(1)' for further "
> > +                                 "configuration guidance.");
> 
> Personally I think of the HTML docs as our primary documentation
> and the manpages as a kind of "not very well maintained extracted
> subset", so I wouldn't want to point people at qemu(1).

The manpages have full coverage of the CLI args with identical
content as the online manual.

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


