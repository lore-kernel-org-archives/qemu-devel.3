Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E00BC43602
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 13:39:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgjWw-0003YW-UO; Mon, 06 Jul 2026 09:38:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wgjWh-0003WZ-Iv
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 09:38:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wgjWf-000487-HR
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 09:38:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783345099;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pQdPqY+wAikWN3gwvCmtBFpcuv1uTbeL+chUHITrhLQ=;
 b=O/SGJIkSwm/5VIQpkUofV+XifLtAr1LjQqFKXyb1cVNAngKNUkrHXqfl3Z4MW+1HBu6pVl
 tAt/njrO+F1Jyt8uF/TVocNJ7SXn8yGXwER/JojKKRDys/3awBTFBllvUw9Iw0CPsEL0FD
 OCu9qiE2RNkGuYHtJr7YNT/+zAVVJIE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-102-L3VOiqcPOryYK7074rxmeg-1; Mon,
 06 Jul 2026 09:38:13 -0400
X-MC-Unique: L3VOiqcPOryYK7074rxmeg-1
X-Mimecast-MFC-AGG-ID: L3VOiqcPOryYK7074rxmeg_1783345092
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9D66A18052E5; Mon,  6 Jul 2026 13:38:11 +0000 (UTC)
Received: from redhat.com (unknown [10.44.48.165])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2E4553000715; Mon,  6 Jul 2026 13:38:07 +0000 (UTC)
Date: Mon, 6 Jul 2026 14:38:04 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Christian Brauner <brauner@kernel.org>, devel@lists.libvirt.org
Subject: Re: [PATCH v6 33/34] qemu-options: document new monitor-hmp and
 monitor-qmp objects
Message-ID: <akuvvI6hUu0d7wWH@redhat.com>
References: <20260702160337.1910921-1-berrange@redhat.com>
 <20260702160337.1910921-34-berrange@redhat.com>
 <87echgpesc.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87echgpesc.fsf@pond.sub.org>
User-Agent: Mutt/2.3.2 (2026-04-26)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, Jul 06, 2026 at 12:56:35PM +0200, Markus Armbruster wrote:
> Daniel P. Berrangé <berrange@redhat.com> writes:
> 
> > Add new docs for the `-object monitor-hmp` and `-object monitor-qmp`
> > options, updating `-mon` to state that it is legacy syntax sugar
> > for the new `-object` args.
> >
> > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> > ---
> >  qemu-options.hx | 61 ++++++++++++++++++++++++++++++++++++++++++++++---
> >  1 file changed, 58 insertions(+), 3 deletions(-)
> >
> > diff --git a/qemu-options.hx b/qemu-options.hx
> > index e44b47de68..1aa548c39b 100644
> > --- a/qemu-options.hx
> > +++ b/qemu-options.hx
> > @@ -4955,6 +4955,11 @@ SRST
> >      port). The default device is ``vc`` in graphical mode and ``stdio``
> >      in non graphical mode. Use ``-monitor none`` to disable the default
> >      monitor.
> > +
> > +    The use of ``-monitor dev`` is syntax sugar for creating a character
> 
> For what it's worth, Wikipedia redirects "syntax sugar" to "syntactic
> sugar", and uses only the latter in the article.

Ok will use that

> 
> Could also use "shorthand".  Matter of taste.
> 
> > +    device from ``dev`` and pairing it with ``-object monitor-hmp``.
> > +    Both the character device and monitor object will be given an ID
> > +    ``compat_monitorNNN`` where ``NNN`` is a counter starting from 0.
> >  ERST
> >  DEF("qmp", HAS_ARG, QEMU_OPTION_qmp, \
> >      "-qmp dev        like -monitor but opens in 'control' mode\n",
> > @@ -4966,9 +4971,10 @@ SRST
> >  
> >          -qmp tcp:localhost:4444,server=on,wait=off
> >  
> > -    Not all options are configurable via this syntax; for maximum
> > -    flexibility use the ``-mon`` option and an accompanying ``-chardev``.
> > -
> > +    The use of ``-monitor dev`` is syntax sugar for creating a character
> 
> Pasto, you mean ``-qmp dev``.

/face-palm

> 
> > +    device from ``dev`` and pairing it with ``-object monitor-qmp``.
> > +    Both the character device and monitor object will be given an ID
> > +    ``compat_monitorNNN`` where ``NNN`` is a counter starting from 0.
> >  ERST
> >  DEF("qmp-pretty", HAS_ARG, QEMU_OPTION_qmp_pretty, \
> >      "-qmp-pretty dev like -qmp but uses pretty JSON formatting\n",
> > @@ -4997,6 +5003,16 @@ SRST
> >        -mon chardev=mon1,mode=control,pretty=on
> >  
> >      enables the QMP monitor on localhost port 4444 with pretty-printing.
> > +
> > +    The use of ``-mon mode=readline`` is historical syntax sugar
> 
> What does "historical" mean?  The next patch replaces it by
> "deprecated".  Suggest to scratch it here.

ok.


> > @@ -5747,6 +5763,45 @@ SRST
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
> 
> ``compat_monitorNNN``
> 
> > +        Mixing ``-object`` with the historical monitor syntax is
> > +        discouraged.
> 
> Clearer, I think: "with -monitor and -mon".
> 
> The next patch deprecates -mon, and then this could become just "with
> -monitor".

ok

> 
> > +
> > +        The ``readline`` parameter, which defaults to ``on``,
> > +        controls whether the monitor provides line editing.
> > +
> > +    ``-object monitor-qmp,id=id,chardev=chardev_id,pretty=on|off,close-action=none|delete``
> > +        Set up a monitor running the QEMU Monitor Protocol,
> > +        connected to the chardev ``chardev_id``.
> > +
> > +        The ``id`` parameter is a unique ID that can be used
> > +        to dynamically delete the monitor at runtime. Note
> > +        that monitors created using the historical syntax
> > +        will be allocated IDs following the pattern ``qmpcompatNN``.
> 
> ``compat_monitorNNN``
> 
> > +        Mixing ``-object`` with the historical monitor syntax is
> > +        discouraged.
> 
> "with -qmp, -qmp-pretty, and -mon".
> 
> The next patch deprecates -mon, and then this could become just "with
> -qmp and -qmp-pretty".

ok

> 
> > +
> > +        The ``pretty`` parameter, which defaults to ``off``,
> > +        controls whether the monitor responses are pretty
> > +        printed as multi-line indented JSON, as opposed to
> > +        constrained to a single line without extraneous
> > +        whitespace.
> > +
> > +        The ``close-action`` parameter, which defaults to ``none``,
> > +        controls what happens when the connection to the monitor
> > +        is terminated by the user. If set to ``delete``, then the
> > +        ``monitor-qmp`` object and its associated character
> > +        device are both immediately deleted. This can be useful
> > +        if an extra monitor was hotplugged for a specific task
> 
> Comma after task?

I don't think its needed, but people are horribly inconsistent in
use of , before and in English no matter what.

> 
> > +        and should be unplugged when completed.
> > +
> >      ``-object memory-backend-file,id=id,size=size,mem-path=dir,share=on|off,discard-data=on|off,merge=on|off,dump=on|off,prealloc=on|off,host-nodes=host-nodes,policy=default|preferred|bind|interleave,align=align,offset=offset,readonly=on|off,rom=on|off|auto``
> >          Creates a memory file backend object, which can be used to back
> >          the guest RAM with huge pages.
> 

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


