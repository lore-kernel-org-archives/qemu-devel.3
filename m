Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD18C606A329
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 09:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=MMoz7Qz9
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNoPD-0007Gs-KH; Mon, 02 Nov 2026 04:32:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xNoOq-0007FH-La
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 04:32:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xNoOm-0001XF-Jl
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 04:32:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793611935;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hxJMiQATaJOx0CBZVPCjmMU576s3Tbdh42Xq0LH5NNk=;
 b=MMoz7Qz9XlICk8kblB/U2OMDvBI24wN2VKjr+ii92OoQ5yHFTOH14G4Z/dD4c7h0bgrYwp
 CbI/E2P85ufYAlsJYI3q9WW0P3Muua2giwCV+o0xncRLFau3HTbUyad1V3JcssZRPmOyvK
 Cj9e5hGZJPcf03s8IWeJBwjRfMLFnoM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-84-Kx0zd-i-M4y7n9hyMeg1PQ-1; Mon,
 02 Nov 2026 04:32:11 -0500
X-MC-Unique: Kx0zd-i-M4y7n9hyMeg1PQ-1
X-Mimecast-MFC-AGG-ID: Kx0zd-i-M4y7n9hyMeg1PQ_1793611930
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6C4A51955F18; Mon,  2 Nov 2026 09:32:10 +0000 (UTC)
Received: from redhat.com (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AF5357E0; Mon,  2 Nov 2026 09:32:07 +0000 (UTC)
Date: Mon, 2 Nov 2026 09:32:04 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v4 13/14] docs: expand security docs with info about
 security status
Message-ID: <auhYlK5A2iPX5t85@redhat.com>
References: <20260910103628.2326622-1-berrange@redhat.com>
 <20260910103628.2326622-14-berrange@redhat.com>
 <87ik2fvhre.fsf@pond.sub.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87ik2fvhre.fsf@pond.sub.org>
User-Agent: Mutt/2.4.2 (2026-08-30)
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Nov 02, 2026 at 08:01:41AM +0100, Markus Armbruster wrote:
> Daniel P. Berrangé <berrange@redhat.com> writes:
> 
> > The description of virtualization vs non-virtualization use
> > cases is a crude approximation of the security characteristics
> > of QEMU devices.
> >
> > Document how QEMU can be probed to obtain information on the
> > security status of type classes, and how policies can be set
> > to inform or control their usage.
> >
> > Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> > ---
> >  docs/system/security.rst | 36 ++++++++++++++++++++++++++++++++++++
> >  1 file changed, 36 insertions(+)
> >
> > diff --git a/docs/system/security.rst b/docs/system/security.rst
> > index 8c42d1a6d8..75e39caede 100644
> > --- a/docs/system/security.rst
> > +++ b/docs/system/security.rst
> > @@ -158,6 +158,42 @@ an issue as a normal bug.
> >    usually not justify handling as security bugs, nor assignment
> >    of CVEs. They will be fixed as routine bugs when time allows.
> >  
> > +Security status reporting
> > +'''''''''''''''''''''''''
> > +
> > +The QEMU project annotates types to explicitly state whether they are
> > +considered to provide a security boundary or not. For machine, accelerator
> > +and device types, only those annotated with the "secure" flag will be
> > +eligible for CVE assignment. Annotations will be extended to other backend
> > +and object types over time, to make their security status explicit.
> > +
> > +It is possible to control or identify the usage of types that do not offer
> > +an explicit security boundary using the ``insecure-types`` parameter to the
> > +``-compat`` argument, which accepts three values:
> > +
> > + * accept: usage of any type will be permitted. This is the current
> > +   and historical default behaviour
> > + * warn: usage of types not explicitly declared secure will result
> > +   in a warning message, but still be permitted.
> > + * reject: usage of types not explicitly declared secure will result
> > +   in an error message, and will not be permitted.
> > +
> > +The compatibility policy will be honoured both at initial startup of
> > +QEMU and during any runtime alterations made with monitor commands.
> > +
> > +The status of any type class can be queried at runtime using the
> > +``qom-list-types`` command, whose returned information will flag any
> > +types declared as secure. The ``query-machines`` command will also
> > +reflect this same information for machine types.
> 
> Yes, member @secure of qom-list-type's return type ObjectTypeInfo and
> query-machine's return type MachineInfo.  However, nothing appears to be
> marked secure:
> 
>     --> {"execute": "qom-list-types", "arguments": {"secure": true}}
>     <-- {"return": []}
> 
> I did not expect this after reading the documentation.  Am I confused?
> 
> If not, what's the plan for the release?

I'm sending a PULL for this today:

   https://lists.gnu.org/archive/html/qemu-devel/2026-10/msg07775.html

and if a few more acks arrive for this:

  https://lists.gnu.org/archive/html/qemu-devel/2026-10/threads.html

i'll send a PULL for that too. Since it is only marking an annotation
I think we can do this even if past soft-freeze, as the patches are not
a functional behaviour change, just metadata.


With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


