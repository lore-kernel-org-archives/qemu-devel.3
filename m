Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EB1ACDB470
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2026 18:17:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wc5fy-0002cF-GE; Tue, 23 Jun 2026 14:16:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wc5ft-0002by-DR
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 14:16:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wc5fr-0006og-8g
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 14:16:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782238597;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=i44CFiphqmDebppFAQ1oyoAs0676tKxsut0iRyUKdAc=;
 b=MyZjxGcYv1281t8Kdkn4NoYh3MSqOo9fPqesk2EDwWTA4hch3A+UbOCQQ4K+5NYNRIiuNP
 4p+/JMfHJW/xDDsD+cktjgZCIVTJbaMz0xzYl+iUaXhCRoeb9H+LQCbKmJ+2G4VmXNzmNO
 ZGVH2Bf7FSQ5Vj/4eJ9zuwMm7SgOMxI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-112-YaAc2R8FOYKlJI3OjbRiyw-1; Tue,
 23 Jun 2026 14:16:34 -0400
X-MC-Unique: YaAc2R8FOYKlJI3OjbRiyw-1
X-Mimecast-MFC-AGG-ID: YaAc2R8FOYKlJI3OjbRiyw_1782238593
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 654A81955EA6; Tue, 23 Jun 2026 18:16:32 +0000 (UTC)
Received: from redhat.com (unknown [10.44.34.133])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 38B9D1800595; Tue, 23 Jun 2026 18:16:28 +0000 (UTC)
Date: Tue, 23 Jun 2026 19:16:25 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: "Dr. David Alan Gilbert" <dave@treblig.org>
Cc: qemu-devel@nongnu.org,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Christian Brauner <brauner@kernel.org>, devel@lists.libvirt.org,
 Markus Armbruster <armbru@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH v4 34/35] qemu-options: document new monitor-hmp and
 monitor-qmp objects
Message-ID: <ajrNeRrVjYZ3m_jT@redhat.com>
References: <20260623095551.2106712-1-berrange@redhat.com>
 <20260623095551.2106712-35-berrange@redhat.com>
 <ajrJU5TH4yOh0vnq@gallifrey>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ajrJU5TH4yOh0vnq@gallifrey>
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

On Tue, Jun 23, 2026 at 05:58:43PM +0000, Dr. David Alan Gilbert wrote:
> * Daniel P. Berrangé (berrange@redhat.com) wrote:
> > Add new docs for the `-object monitor-hmp` and `-object monitor-qmp`
> > options, updating `-mon` to state that it is legacy syntax sugar
> > for the new `-object` args.
> > 
> > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> > ---
> >  qemu-options.hx | 50 +++++++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 50 insertions(+)
> > 
> > diff --git a/qemu-options.hx b/qemu-options.hx
> > index c799286153..98c74cc9ff 100644
> > --- a/qemu-options.hx
> > +++ b/qemu-options.hx
> 
> <snip>
> 
> > @@ -5730,6 +5740,46 @@ SRST
> >      they are specified. Note that the 'id' property must be set. These
> >      objects are placed in the '/objects' path.
> >  
> > +    ``-object monitor-hmp,id=id,chardev=chardev_id,readline=on|off``
> > +        Set up a monitor running the Human Monitor Protocol,
> > +        connected to the chardev ``chardev_id``.
> > +
> > +        The ``id`` parameter is a unique ID that can be used
> > +        to dynamically delete the monitor at runtime. Note
> > +        that monitors created using the historical syntax
> > +        will be allocated IDs following the pattern ``hmpcompatNN``.
> > +        Mixing ``-object`` with the historical monitor syntax is
> > +        discouraged.
> > +
> > +        The ``readline`` parameter, which defaults to ``on``,
> > +        controls whether the monitor provides interactive
> > +        prompts
> 
> Missing full stop.
> So are you allowing a mode that I don't think was previously possible;
> HMP syntax but without readline?

Yeah, I guess that's true - the non-interactive mode was always there
internally but only accessible via the gdb stub.

> 'interactive prompts' seems a strange way of putting it - 'line editing'
> is more normal isn't it?

Sure, I can change that.


With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


