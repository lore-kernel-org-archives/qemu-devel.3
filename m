Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DD88C35FFA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Mar 2025 11:39:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1turkV-0005co-RF; Wed, 19 Mar 2025 07:38:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1turkU-0005cM-4X
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 07:38:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1turkR-0007Ij-Sa
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 07:38:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742384290;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ocesR8+jGIWg4E5yJGnpT8SyCa5b7n4gOvXpPa0DYVE=;
 b=VhRCWLu2m2FV37nxaJzZbubk1XbJgvB9182lc8oA3HnSQIWuNQtZsP5WPKhKtyrUXPfk4R
 PmJujXm/2YTk4EJvh+ZB7HiwfvHOCqiZy6NNkx1XeSmNlsMdFyg7WL1ASOL74zjfSPjhoo
 CHp6L8Pp+QC4uDocErH2TzI5YrRBdGc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-139-6YucDxKoMjaqww3IKg0w1A-1; Wed,
 19 Mar 2025 07:38:06 -0400
X-MC-Unique: 6YucDxKoMjaqww3IKg0w1A-1
X-Mimecast-MFC-AGG-ID: 6YucDxKoMjaqww3IKg0w1A_1742384286
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A3EF4188EE3C; Wed, 19 Mar 2025 11:37:52 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.112])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D897A1955D83; Wed, 19 Mar 2025 11:37:47 +0000 (UTC)
Date: Wed, 19 Mar 2025 11:37:40 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Kashyap Chamarthy <kchamart@redhat.com>
Subject: Re: [PATCH v2 4/4] docs/firmware: add feature flag for qemu variable
 store
Message-ID: <Z9qshApFGwvNAD5F@redhat.com>
References: <20250319110152.1309969-1-kraxel@redhat.com>
 <20250319110152.1309969-5-kraxel@redhat.com>
 <Z9qlWV_TsnndwIM4@redhat.com>
 <qimb4oxprocd2yz6chamb4a2z3oyuofm2gqwutz3l7jz4me7gi@ze5q2caadazj>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <qimb4oxprocd2yz6chamb4a2z3oyuofm2gqwutz3l7jz4me7gi@ze5q2caadazj>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.337,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
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

On Wed, Mar 19, 2025 at 12:30:34PM +0100, Gerd Hoffmann wrote:
> On Wed, Mar 19, 2025 at 11:07:05AM +0000, Daniel P. Berrangé wrote:
> > On Wed, Mar 19, 2025 at 12:01:51PM +0100, Gerd Hoffmann wrote:
> > > Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> > > ---
> > >  docs/interop/firmware.json | 5 ++++-
> > >  1 file changed, 4 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/docs/interop/firmware.json b/docs/interop/firmware.json
> > > index 57f55f6c5455..76df1043dae9 100644
> > > --- a/docs/interop/firmware.json
> > > +++ b/docs/interop/firmware.json
> > > @@ -214,13 +214,16 @@
> > >  #                  PL011 UART. @verbose-static is mutually exclusive
> > >  #                  with @verbose-dynamic.
> > >  #
> > > +# @qemu-vars: The firmware expects qemu to provide an efi variable
> > > +#             store, via "uefi-vars-sysbus" or "uefi-vars-x64" device.

I wonder if 'qemu-vars' is the right name here ? It feels like the specification
for such device is effectively defined by UEFI, with any hypervisor providing a
impl. Perhaps just call it 'uefi-vars-dev' or some name that's relevant for
what EDK2 calls it ?

> > 
> > It seems like this would imply mapping.device == memory,
> 
> edk2 doesn't care if you load it into flash or memory, both cases will
> work fine.  Using flash if we don't actually need it makes things more
> complicated for no good reason, so yes, I'd go write config files with
> mapping.device == memory.
> 
> > as if we had
> > mapping.device == flash, then we would need to extend FirmwareFlashMode
> > with an extra option ?
> 
> There is 'stateless' already for 'firmware image in r/o flash'.

What's the behaviour of UEFI if build with JSON vars support, but without
QEMU providing any JSON vars backend ?  If that happily runs stateless
in that case, then we could reuse the existing 'stateless' mode, without
having compat trouble with older libvirt that don't know about the
'qemu-vars' feature.

We would want to expand the 'stateless' docs to mention that this feature
flag indicates optional support for persistence in that case.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


