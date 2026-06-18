Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA345CD98ED
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2026 08:19:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wa7xD-0004PO-A9; Thu, 18 Jun 2026 04:18:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wa7xA-0004PG-S6
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 04:18:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wa7x9-0005f7-DY
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 04:18:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781770701;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9Mje5Jy9zIGSCFWg5m9wY2cI1SZhzyP+oMyLjT7eImE=;
 b=br6ovlMG2giijzrhESTGwBnv53rmnkWP18pRKrxd7PwSKeLC9KA5/cbTCNigydV7eWrciS
 +wXCcCGViwzubXXSCOZ414GjBcPXzgxWj3ScoZiBm37YAigPvD3710Wsroek+eABPyoJbf
 9ejCR8z/9B2P8yyfKDQWrkZKoRAZt3I=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-586-spM73e0QMVe0dj_hNZsDYQ-1; Thu,
 18 Jun 2026 04:18:16 -0400
X-MC-Unique: spM73e0QMVe0dj_hNZsDYQ-1
X-Mimecast-MFC-AGG-ID: spM73e0QMVe0dj_hNZsDYQ_1781770695
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9C34E1956096; Thu, 18 Jun 2026 08:18:14 +0000 (UTC)
Received: from redhat.com (unknown [10.44.49.28])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 71113180058D; Thu, 18 Jun 2026 08:18:11 +0000 (UTC)
Date: Thu, 18 Jun 2026 09:18:07 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Christian Brauner <brauner@kernel.org>, devel@lists.libvirt.org,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@mailo.com>
Subject: Re: [PATCH v2 23/35] qemu-options: document new monitor-hmp and
 monitor-qmp objects
Message-ID: <ajOpv-0AMLozKHUL@redhat.com>
References: <20260610123415.2883603-1-berrange@redhat.com>
 <20260610123415.2883603-24-berrange@redhat.com>
 <178112600376.209622.16416561470304910231.b4-review@b4>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <178112600376.209622.16416561470304910231.b4-review@b4>
User-Agent: Mutt/2.3.2 (2026-04-26)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Jun 11, 2026 at 01:13:23AM +0400, marcandre.lureau@redhat.com wrote:
> On Wed, 10 Jun 2026 13:34:03 +0100, Daniel P. Berrangé <berrange@redhat.com> wrote:
> > diff --git a/qemu-options.hx b/qemu-options.hx
> > index 96ae41f787b..031417b79d2 100644
> > --- a/qemu-options.hx
> > +++ b/qemu-options.hx
> > @@ -5709,6 +5719,34 @@ SRST
> >      they are specified. Note that the 'id' property must be set. These
> >      objects are placed in the '/objects' path.
> >  
> > +    ``-object monitor-hmp,id=id,chardev=chardv_id,readline=on|off``
> 
> chardev_id
> 
> > +        Set up a monitor running the Human Monitor Protocol,
> > +        connected to the chardev ``chrid``.
> 
> chardev_id
> 
> > +
> > +        The ``id`` parameter is a unique ID that can be used
> > +        to dynamically delete the monitor at runtime.
> 
> Maybe update the doc at last patch of the series?

Yes, I'll move it to the end.

> 
> > +
> > +        The ``readline`` parameter, which defaults to ``on``,
> > +        controls whether the monitor provides interactive
> > +        prompts
> 
> .
> 
> > +
> > +    ``-object monitor-qmp,id=id,chardev=chardev_id,pretty=on|off``
> > +        Set up a monitor running the QEMU Monitor Protocol,
> > +        connected to the chardev ``chrid``.
> 
> chardev_id
> 
> > +
> > +        The ``id`` parameter is a unique ID that can be used
> > +        to dynamically delete the monitor at runtime. Note
> > +        that monitors created using the historical syntax
> > +        will be allocated IDs following the pattern ``monNN``.
> 
> "qmpcompatN" and "hmpcompatN"
> 
> -- 
> Marc-André Lureau <marcandre.lureau@redhat.com>
> 

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


