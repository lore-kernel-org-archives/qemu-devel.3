Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A396606A31C
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 21:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=HkitUon4
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xT4JY-0005oF-Ii; Mon, 16 Nov 2026 16:32:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xT4JU-0005lb-EI
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 16:32:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xT4JS-0000sz-AB
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 16:32:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794864748;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9SJPFCx+BQeKdpx5jMurmMZEixEwNyUGXo4z+wJ6Gys=;
 b=HkitUon4sLCw8ygpJKEkCOxsPMvlsoNjnewIY+drNbKWprm0aGisV47Ummnlqb3TNoZX7j
 4NrGSO+8Ydi//6WlvUhd+QYhnKlY4TPvWzDCVWzuJNP1kx/ZSrGINO7M2hAG3z4+5T78oU
 w9705qwUmWCAq70or/mxea/Gk5TJA20=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-349-2FLcDcIoOLGmrd4kqWfnaw-1; Mon,
 16 Nov 2026 16:32:27 -0500
X-MC-Unique: 2FLcDcIoOLGmrd4kqWfnaw-1
X-Mimecast-MFC-AGG-ID: 2FLcDcIoOLGmrd4kqWfnaw_1794864746
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D786118005B2; Mon, 16 Nov 2026 21:32:25 +0000 (UTC)
Received: from redhat.com (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 70CB330001A2; Mon, 16 Nov 2026 21:32:24 +0000 (UTC)
Date: Mon, 16 Nov 2026 21:32:21 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Markus Armbruster <armbru@redhat.com>, Yonggang Luo <luoyonggang@gmail.com>
Subject: Re: [PATCH 34/48] hw/core: implement TYPE_TARGET_SPECIFIC for machine
Message-ID: <avt2ZaDkcaUtRaGs@redhat.com>
References: <20261112133054.1977618-1-berrange@redhat.com>
 <20261112133054.1977618-35-berrange@redhat.com>
 <87493520-d995-493d-add9-7e53fd323d99@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87493520-d995-493d-add9-7e53fd323d99@oss.qualcomm.com>
User-Agent: Mutt/2.4.3 (2026-10-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Nov 16, 2026 at 01:25:36PM -0800, Pierrick Bouvier wrote:
> On 11/12/2026 5:30 AM, Daniel P. Berrangé wrote:
> > The Machine base class implements TYPE_TARGET_SPECIFIC since
> > its children will almost all be target specific.
> > 
> > When the 'targets' field is set to a non-zero value on a
> > machine type, it will block creation of an instance of the
> > machine unless the current selected target matches. This
> > allows the current 'is_available' callback to be removed.
> > 
> > Eventually only the 'none' machine is likely to leave the
> > 'targets' field set to 0, since it is universally creatable.
> >
> 
> Once all machines are correctly tagged per target, maybe we could simply
> forbid having 0.

Yes, contrary to my commit message 'none' machine should
be set to QEMU_ARCH_ALL, so nothing should end up with
a value of '0' in the end.

> 
> > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> > ---
> >  hw/core/machine.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/hw/core/machine.c b/hw/core/machine.c
> > index f7406537aa7..8692365ce89 100644
> > --- a/hw/core/machine.c
> > +++ b/hw/core/machine.c
> > @@ -1804,6 +1804,7 @@ static const TypeInfo machine_info = {
> >      .instance_finalize = machine_finalize,
> >      .interfaces = (const InterfaceInfo[]) {
> >          { TYPE_ALIASED },
> > +        { TYPE_TARGET_SPECIFIC },
> >          { }
> >      }
> >  };
> 

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


