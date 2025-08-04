Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BBBEC87FCF
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Aug 2025 15:23:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uix25-0007BQ-Jk; Mon, 04 Aug 2025 11:23:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1uivXs-0006Fg-GX
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 09:48:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1uivXa-0002ba-Sy
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 09:47:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754315268;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5/eh/jwL+RZ/EYBgYWtEhJ5nGGrBj/YKTD9ih8imFIo=;
 b=cB5PpUdidMF3a1sdg9VTSCuL0rlyoaKL5Y1EP9cBXMIoce0pf7dkjhqbVQoOg0u8mympg2
 Dp2nO8HJgztLyO6WFo4c9b5fsiAS30KeZXj0KWki0lcDH324tdSyOQz55rG4E3tW/HP2ys
 RxNnJFrLB8bAdcg20JlCGkNkjFj9d4I=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-94-dXeUCgyOOBKc2vsqEmpx2w-1; Mon,
 04 Aug 2025 09:47:46 -0400
X-MC-Unique: dXeUCgyOOBKc2vsqEmpx2w-1
X-Mimecast-MFC-AGG-ID: dXeUCgyOOBKc2vsqEmpx2w_1754315265
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BD1A11955BE0; Mon,  4 Aug 2025 13:47:44 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.45.224.205])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 12F6F1800B71; Mon,  4 Aug 2025 13:47:44 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 8D3D118000AF; Mon, 04 Aug 2025 15:47:41 +0200 (CEST)
Date: Mon, 4 Aug 2025 15:47:41 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Oliver Steffen <osteffen@redhat.com>, qemu-devel@nongnu.org, 
 Paolo Bonzini <pbonzini@redhat.com>, Joerg Roedel <joerg.roedel@amd.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Eduardo Habkost <eduardo@habkost.net>, Stefano Garzarella <sgarzare@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [RFC 2/2] q35: add virtio-mmio slots
Message-ID: <us4ixdvznr7zjy7ycj2ntil6hbtlpqefma6e2h5ysecntzo2nn@vl5vug4ygqa5>
References: <20250701121815.523896-1-osteffen@redhat.com>
 <20250701121815.523896-3-osteffen@redhat.com>
 <aIzHUL5lbUvbuCfh@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aIzHUL5lbUvbuCfh@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, Aug 01, 2025 at 02:55:28PM +0100, Daniel P. Berrangé wrote:
> On Tue, Jul 01, 2025 at 02:18:15PM +0200, Oliver Steffen wrote:
> > From: Gerd Hoffmann <kraxel@redhat.com>
> > 
> > Add virtio-mmio slots to the q35 machine model, intended to be used by
> > an SVSM.
> > 
> > Disabled by default, enable using '-machine q35,x-svsm-virtio-mmio=on'.
> > 
> > When enabled it is possible to plug up to 4 virtio devices into the
> > slots virtio-mmio using '-device virtio-${kind}-device'.
> > 
> > The devices can be found at base address 0xfef00000, each slot on a
> > separate page.  No IRQ is wired up, the SVSM has to drive the devices
> > in polling mode.
> > 
> > The base addresses are communicated to the SVSM via the etc/hardware-info
> > fw_cfg file.
> 
> This feels a somewhat uncomfortable in that it ties QEMU to specific
> impl details of SVSM at a point in time.
> 
> With the IGVM support for loading guest firmware, we've avoided QEMU
> needing any knowledge of what the firmware actually is. It is just
> an opaque blob that is loaded based on its own IGVM metadata. This
> also made it possible for any hypervisor with IGVM support to be able
> to load any firmware, including SVSM or equiv impls.

Well, there isn't anything svsm-specific in there, it is just that svsm
is the only user right now (and I don't expect that to change anytime
soon).  But we could very well rename the option to "virtio-mmio=on".

> Is there any way to extend IGVM to express that it supports these
> 4 virtio-mmio slots, at the given address in polling mode, so that
> hypervisors can auto-discover this facility ?

You mean some igvm directive requesting that qemu creates virtio-mmio
slots?

Should be possible.  Not sure how much of a win that would actually be
though.  You still have to create the devices and the corresponding
backends on the qemu command line.

> Failing that, can we make it possible to create virtio-mmio slots
> on the QEMU command line, instead of hardcoding this SVSM-specific
> setup in QEMU code.

That would work too.

take care,
  Gerd


