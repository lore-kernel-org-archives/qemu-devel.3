Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B40C606A322
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 21:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=R5p7H97G
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xT4Rx-0002Vv-Lu; Mon, 16 Nov 2026 16:41:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xT4Ro-0002Ur-Tu
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 16:41:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xT4Rm-0004PV-Rh
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 16:41:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794865265;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IPGtSdMpjV02EVX1BZW6RAONrNIlQqfB4sFRlykbMQc=;
 b=R5p7H97GxLUyBlknEPHIWmKi75ode516hUwxNUH/gDgQN2GsK5XjcsSFJKZXVAMmbBX1OI
 /L2ygJPH7mUwS87YlrN3iIPSmbJE8T+k8JurG4RPrT7l04OsLGXx2bhsf/elV88lcnS/DJ
 4EeWaMkNa/0sLKaSlkom1/1MlTcFxaI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-531-gNMS3JnIPuCOH45HibgRnA-1; Mon,
 16 Nov 2026 16:41:02 -0500
X-MC-Unique: gNMS3JnIPuCOH45HibgRnA-1
X-Mimecast-MFC-AGG-ID: gNMS3JnIPuCOH45HibgRnA_1794865260
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B178B19560B6; Mon, 16 Nov 2026 21:41:00 +0000 (UTC)
Received: from redhat.com (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4A20618004F5; Mon, 16 Nov 2026 21:40:59 +0000 (UTC)
Date: Mon, 16 Nov 2026 21:40:56 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Markus Armbruster <armbru@redhat.com>, Yonggang Luo <luoyonggang@gmail.com>
Subject: Re: [PATCH 06/48] hw/core: implement TYPE_ALIASED interface in
 machines
Message-ID: <avt4aNmLorhgCvh_@redhat.com>
References: <20261112133054.1977618-1-berrange@redhat.com>
 <20261112133054.1977618-7-berrange@redhat.com>
 <cb7bad9f-96d9-4a7f-ad40-ed19e14f83bb@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cb7bad9f-96d9-4a7f-ad40-ed19e14f83bb@oss.qualcomm.com>
User-Agent: Mutt/2.4.3 (2026-10-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, Nov 16, 2026 at 12:48:47PM -0800, Pierrick Bouvier wrote:
> On 11/12/2026 5:30 AM, Daniel P. Berrangé wrote:
> > Make the TYPE_MACHINE class implement the TYPE_ALIASED
> > interface which will replace use of the 'alias' parameter
> > in MachineClass. The current 'alias' records the user
> > facing machine name, while 'aliases' in TYPE_ALIASED
> > will report an internal type name alias.
> > 
> > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> > ---
> >  hw/core/machine.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/hw/core/machine.c b/hw/core/machine.c
> > index ed9bf8f5008..f7406537aa7 100644
> > --- a/hw/core/machine.c
> > +++ b/hw/core/machine.c
> > @@ -1802,6 +1802,10 @@ static const TypeInfo machine_info = {
> >      .instance_size = sizeof(MachineState),
> >      .instance_init = machine_initfn,
> >      .instance_finalize = machine_finalize,
> > +    .interfaces = (const InterfaceInfo[]) {
> > +        { TYPE_ALIASED },
> > +        { }
> > +    }
> >  };
> >  
> >  static void machine_register_types(void)
> 
> Since very few machines require this alias mechanism, would that be
> better to be add it where it's needed?

Unconditionally adding it is a simplication for other code in
the series. By doing this we can use the normal QOM cast
"ALIASED_CLASS(mc)" from the machine to the interface which
asserts on failure.

If we only did add the interface for a subset of machines, we have
to remember to use (AliasedClass*)object_class_dynamic_cast(OBJECT(mc))
and check the return value for NULL, which is both more verbose
and error prone.

So I thought the overhead of adding the interface to the Machine base
class was probably a reasonable tradeoff.

> 
> Not a strong opinion though:
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> 
> Regards,
> Pierrick
> 

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


