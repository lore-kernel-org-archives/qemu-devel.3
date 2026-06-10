Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0438CCD8CB9
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 16:42:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXM07-0001Ka-Q9; Wed, 10 Jun 2026 12:42:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1wXLzv-0001Iw-SO
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 12:41:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1wXLzu-0007R5-Bi
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 12:41:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781109696;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WHzS+xSDgpLqm0IW9+Av4rahES2s2WA2H2y3S9baq7Y=;
 b=WefLoI29gvnbsIxIPrpg8qxzdbDzP+93oCHb/mBc+XqB/pblxFzU7m2vZJOGKrx/NcQdKf
 PATzU8yLW23Xu8SmWqNGECsBw/2J1wJEK0uoDWeCLR2Vmuaf93H1u7qZ4RvUAoAieR4THK
 W3ssH8wB7/6cjb+iH5jVW0efjLAMufQ=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-250-_20z10OhPfCIe1zQThv4mg-1; Wed,
 10 Jun 2026 12:41:32 -0400
X-MC-Unique: _20z10OhPfCIe1zQThv4mg-1
X-Mimecast-MFC-AGG-ID: _20z10OhPfCIe1zQThv4mg_1781109691
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 531CD1944D69; Wed, 10 Jun 2026 16:41:31 +0000 (UTC)
Received: from dobby.home.kraxel.org (unknown [10.44.33.103])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 777183008DC3; Wed, 10 Jun 2026 16:41:30 +0000 (UTC)
Received: by dobby.home.kraxel.org (Postfix, from userid 1000)
 id E3A4F80660D; Wed, 10 Jun 2026 18:41:28 +0200 (CEST)
Date: Wed, 10 Jun 2026 18:41:28 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Luigi Leonardi <leonardi@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Stefano Garzarella <sgarzare@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Oliver Steffen <osteffen@redhat.com>
Subject: Re: [PATCH v2 1/2] hw/i386/microvm: pack device tree
Message-ID: <aimS0DUo-Ei_ksTM@dobby.home.kraxel.org>
References: <20260610-microvm_device_tree-v2-0-4fb44730c49f@redhat.com>
 <20260610-microvm_device_tree-v2-1-4fb44730c49f@redhat.com>
 <ail7WyMwmEBIquoM@dobby.home.kraxel.org>
 <aimFZtN9qURC4Reg@leonardi-redhat>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aimFZtN9qURC4Reg@leonardi-redhat>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, Jun 10, 2026 at 05:47:26PM +0200, Luigi Leonardi wrote:
> Hi Gerd,
> 
> On Wed, Jun 10, 2026 at 05:04:39PM +0200, Gerd Hoffmann wrote:
> >  Hi,
> > 
> > > +    ret = fdt_pack(ms->fdt);
> > 
> > I'm wondering whenever this is the best place to do it, or whenever the
> > igvm code should make a copy + pack it + place it in the directive, so
> > we do not depend on the machine code to do the packing for us.  When
> > doing a quick grep the packing seems to be a rare thing, there isn't a
> > single call in all arm code for example ...
> > 
> 
> True, it's rather rare throughout the codebase. If we do this here, when
> we will support other archs we would have to add `fdt_pack` to them as well.
> Is this your concern?

Yes.  Essentially igvm wants the fdt be packed so it fits into the
parameter area, so I think it is better to handle that in igvm instead
of depending this being done elsewhere for us.  I'm also not sure if
there is some specific reason to not pack the fdt (beyond nobody needed
that so far), i.e. if packing could break something.

take care,
  Gerd


