Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96FB7C43458
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2026 08:16:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weq7F-0004Po-1D; Wed, 01 Jul 2026 04:16:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1weq7C-0004PY-I0
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 04:16:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1weq7A-0000fe-SM
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 04:16:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782893772;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ckmKp8kjaueEBQsWaKhsx/Osmi0E/wlF3h6qoYSEaas=;
 b=hns6uOhUj9leeXJHsRGSt1dzDokuqEqLPplFiOPC0qnC2ADuT4UxEALlEePq8H5vISAbzC
 RHK9Xif0CYs/g9DhE3dtw/iPhgJSvhseIZX+yQb2S/Ny99kQYzZEJgW/na8CI5eOANdLb0
 QjMWuTLnPiaeh+YaapKTHyp5yF1DjAU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-294-0OD7unq0PjqcAg5Wrd7NSw-1; Wed,
 01 Jul 2026 04:16:11 -0400
X-MC-Unique: 0OD7unq0PjqcAg5Wrd7NSw-1
X-Mimecast-MFC-AGG-ID: 0OD7unq0PjqcAg5Wrd7NSw_1782893769
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4BA5F1955D5B; Wed,  1 Jul 2026 08:16:09 +0000 (UTC)
Received: from redhat.com (unknown [10.44.33.35])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 898373000C23; Wed,  1 Jul 2026 08:16:05 +0000 (UTC)
Date: Wed, 1 Jul 2026 09:16:01 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, devel@lists.libvirt.org,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Christian Brauner <brauner@kernel.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Peter Krempa <pkrempa@redhat.com>
Subject: Re: [PATCH v5 34/35] qemu-options: document new monitor-hmp and
 monitor-qmp objects
Message-ID: <akTMwaEFe3eR7Dpi@redhat.com>
References: <20260624173752.2928717-1-berrange@redhat.com>
 <20260624173752.2928717-35-berrange@redhat.com>
 <87qzln6ugf.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87qzln6ugf.fsf@pond.sub.org>
User-Agent: Mutt/2.3.2 (2026-04-26)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Jul 01, 2026 at 09:27:12AM +0200, Markus Armbruster wrote:
> Daniel P. Berrangé <berrange@redhat.com> writes:
> 
> > Add new docs for the `-object monitor-hmp` and `-object monitor-qmp`
> > options, updating `-mon` to state that it is legacy syntax sugar
> > for the new `-object` args.
> >
> > Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> > Tested-by: Peter Krempa <pkrempa@redhat.com>
> > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> > ---
> >  qemu-options.hx | 49 +++++++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 49 insertions(+)
> >
> > diff --git a/qemu-options.hx b/qemu-options.hx
> > index c799286153..a804d5b880 100644
> > --- a/qemu-options.hx
> > +++ b/qemu-options.hx
> > @@ -4980,6 +4980,16 @@ SRST
> >        -mon chardev=mon1,mode=control,pretty=on
> >  
> >      enables the QMP monitor on localhost port 4444 with pretty-printing.
> > +
> > +    The use of ``-mon mode=readline`` is historical syntax sugar
> > +    for the new ``-object monitor-hmp`` option, each use of which
> > +    creates an object with the ID ``hmpcompatNNN`` where ``NNN`` is
> > +    a counter starting from 0.
> > +
> > +    The use of ``-mon mode=control`` is historical syntax sugar
> > +    for the new ``-object monitor-qmp`` option, each use of which
> > +    creates an object with the ID ``qmpcompatNNN`` where ``NNN`` is
> > +    a counter starting from 0.
> >  ERST
> 
> Should we document how -monitor, -qmp, and -qmp-pretty map to -object
> and -chardev?

I thought they already described how they were mapped to -mon,
but I see I was mistaken. It is worth a followup patch to
improve their docs, especially given your points around the
implicit "id" value they have internally.

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


