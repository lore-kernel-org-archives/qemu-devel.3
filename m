Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED571C61DD3
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 11:06:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x25Gf-0001yy-MB; Thu, 03 Sep 2026 07:06:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1x25Ge-0001yp-Qm
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 07:06:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1x25Gd-0002mU-0N
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 07:06:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788433561;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IoUlyW6kXpnHUboRruLST61iWcxmkwEtvggD0pT6BNM=;
 b=ACrwdYN85y5gqNpEduieaY2C4WjyDdC+zKpZlAICdx/X09rFNnWnRPztcHVZkyeFqciCTD
 VJhH63+Kts88tEvocgFj7kkZlJlqPjJwxT8o0SEyIAxFOsBUu3mN4nhvlbuQ7SuXhReHCG
 SPagjrO8+mO+DX46edQsmGSdoXN6k4k=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-195-v6hK1rtbPq2ywVQze1My-A-1; Thu,
 03 Sep 2026 07:05:53 -0400
X-MC-Unique: v6hK1rtbPq2ywVQze1My-A-1
X-Mimecast-MFC-AGG-ID: v6hK1rtbPq2ywVQze1My-A_1788433552
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C45B0185FE5F; Thu,  3 Sep 2026 11:05:51 +0000 (UTC)
Received: from redhat.com (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DBB547DA; Thu,  3 Sep 2026 11:05:48 +0000 (UTC)
Date: Thu, 3 Sep 2026 12:05:45 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: marcandre.lureau@redhat.com, qemu-devel@nongnu.org,
 Thomas Huth <thuth@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v2 32/32] hw/display: mark most display adapters as
 insecure
Message-ID: <aplUiXukbS5riuCi@redhat.com>
References: <20250926140144.1998694-1-berrange@redhat.com>
 <20250926140144.1998694-33-berrange@redhat.com>
 <178708450916.1320462.1427984683087351414.b4-review@b4>
 <d807df94-16d5-28a8-756e-b7971068e2c7@eik.bme.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d807df94-16d5-28a8-756e-b7971068e2c7@eik.bme.hu>
User-Agent: Mutt/2.4.0 (2026-06-19)
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, Aug 19, 2026 at 01:18:18PM +0200, BALATON Zoltan wrote:
> On Wed, 19 Aug 2026, marcandre.lureau@redhat.com wrote:
> > > Most of thte display adapters are emulating old hardware which is not
> > > relevant to virtualization use cases.
> > > 
> > > The exceptions that should be considered secure are Cirrus (PCI, not
> > > ISA), Bochs, QXL, RAMFB, VGA (PCI, MMIO, not ISA) and VMWare VGA.
> > > 
> > > The Cirrus PCI decision is borderline. It has been heavily used with
> > > virtualization in the past, but these days VGA / RAMFB are strongly
> > > recommended instead. Due to its historical usage though, we can
> > > consider the code fairly mature, even if no longer hugely relevant
> > > to virtualization use cases.
> > > 
> > > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> > > Message-ID: <20250926140144.1998694-33-berrange@redhat.com>
> > > 
> > > diff --git a/hw/display/artist.c b/hw/display/artist.c
> > > index 3c884c92437c..caab4d1d4c52 100644
> > > --- a/hw/display/artist.c
> > > +++ b/hw/display/artist.c
> > > @@ -1504,6 +1504,7 @@ static const TypeInfo artist_info = {
> > >      .instance_size = sizeof(ARTISTState),
> > >      .instance_init = artist_initfn,
> > >      .class_init    = artist_class_init,
> > > +    .secure        = false,
> > >  };
> > > 
> > >  static void artist_register_types(void)
> > > diff --git a/hw/display/ati.c b/hw/display/ati.c
> > > index f7c0006a879d..6e332e02d2fb 100644
> > > --- a/hw/display/ati.c
> > > +++ b/hw/display/ati.c
> > > @@ -1080,6 +1080,7 @@ static const TypeInfo ati_vga_info = {
> > >      .instance_size = sizeof(ATIVGAState),
> > >      .class_init = ati_vga_class_init,
> > >      .instance_init = ati_vga_init,
> > > +    .secure = false,
> 
> I've missed the original series but why isn't the default false and devices
> that are secured set it to true? That way a new device would not be set
> secure unless the author explicitly sets it which seems better than assuming
> devices are secure when most of them aren't. Or if false is already the
> default why is it set everywhere? Isn't it enough to mark secure devices?

In the first version I was explicitly tracking "secure" and "insecure"
and "undefined".

Markus made the point that from an external consumer POV we should
treat "insecure" and "undefined" as the same.

Internally, however, I still wanted to keep track of what devices we
had put some intelligent thought into for classification purposes.
IOW, the absence of ".secure = " is effectively our TODO list.

Perhaps this is overkill though. What really matters is that we get
an accurate list for ".secure = true" as quickly as possible, and
once that's more or less complete, the '.secure = false' markers
probably cease to retain any value.

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


