Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10451CA5FB3
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2026 08:12:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCBu7-0000SH-Ej; Thu, 01 Oct 2026 04:12:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xCBts-0000RP-DY
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 04:12:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xCBtq-0001a6-LZ
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 04:12:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790842336;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=mf+BdivbsgbqMRxH9T6v92SkL4472atveyTw1KxR8fc=;
 b=ZJnhi/s3wme56EtoOik1ub2TVNKGeIchUVXl2rxyUGavs1VXxjmHT1pl/4p2xZ0UW9Hy2V
 u0N1Ig6F/5YKncL6Z/7hzgLggmr2xGvuhA04NLn6lEOUeu+3cgjh/f9IjylC1TNFx3Gy9f
 MwcZmjX5u8KRP79a8jtn0vrqMJsqyr8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-15-0MCY-0BKPW--Vf0MD47xJQ-1; Thu,
 01 Oct 2026 04:12:12 -0400
X-MC-Unique: 0MCY-0BKPW--Vf0MD47xJQ-1
X-Mimecast-MFC-AGG-ID: 0MCY-0BKPW--Vf0MD47xJQ_1790842332
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DF71B19792F8
 for <qemu-devel@nongnu.org>; Thu,  1 Oct 2026 08:12:11 +0000 (UTC)
Received: from redhat.com (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A4085180056E; Thu,  1 Oct 2026 08:12:09 +0000 (UTC)
Date: Thu, 1 Oct 2026 09:12:06 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: Luigi Leonardi <leonardi@redhat.com>, qemu-devel@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH] igvm: add command line parameter support
Message-ID: <ar4V1i54Czo45lQh@redhat.com>
References: <20260930-igvm_command_line-v1-1-62857007d89d@redhat.com>
 <87qzi9alml.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87qzi9alml.fsf@pond.sub.org>
User-Agent: Mutt/2.4.2 (2026-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 9
X-Spam_score: 0.9
X-Spam_bar: /
X-Spam_report: (0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.341,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
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

On Thu, Oct 01, 2026 at 10:08:34AM +0200, Markus Armbruster wrote:
> Luigi Leonardi <leonardi@redhat.com> writes:
> 
> > Add a "cmdline" property to the igvm-cfg object and a handler for the
> > IGVM_VHT_COMMAND_LINE directive, which copies the string into the
> > parameter area the directive points at.
> >
> > This command line is intended for the component running at VMPL0, such
> > as SVSM, rather than for the guest OS, whose own command line still
> > comes from -append. SVSM can use it to select the serial port it logs
> > to, for example.
> >
> > Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
> 
> [...]
> 
> > diff --git a/qapi/qom.json b/qapi/qom.json
> > index 5895c97750..d56bdef561 100644
> > --- a/qapi/qom.json
> > +++ b/qapi/qom.json
> > @@ -1004,11 +1004,15 @@
> >  #
> >  # @file: IGVM file to use to configure guest
> >  #
> > +# @cmdline: command line for the software loaded from the IGVM file,
> > +#     rather than for the guest OS.  Ignored if the IGVM file does
> > +#     not ask for one.  (since 11.2)
> > +#
> >  # Since: 10.1
> >  ##
> >  { 'struct': 'IgvmCfgProperties',
> >    'if': 'CONFIG_IGVM',
> > -  'data': { 'file': 'str' } }
> > +  'data': { 'file': 'str', '*cmdline': 'str' } }
> >  
> >  ##
> >  # @SevCommonProperties:
> 
> How is @cmdline going to be parsed?  By a shell?

This is something passed to the guest workflow. ie a kernel command
line string.

> For what it's worth, MigrationExecCommand uses ['str'].  Such values can
> be passed to exec()-like functions without parsing.

In this case we should treat 'cmdline' as an opaque strnig and not
try to place any semantics on its expected syntax.

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


