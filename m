Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FA4CE69E9F
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2024 11:08:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIQlm-0003wJ-BT; Tue, 03 Dec 2024 06:08:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tIQlk-0003vu-J0
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 06:08:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tIQli-0006Cj-MJ
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 06:08:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733224117;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=gVrncpTVy2Tx3GTDsT+1piyz47cr7SCUqh7htMZUHVc=;
 b=bYHP6N8ZkeXFlLqHWd0jcG8zMehUwF0dPET0Eu3HoqWBOZFMccpsHw01o9Z0P8NBDPj4ai
 VxQ6ob+G0RFLRAomxl72YANVr0l98rxoDz4ls5fvBMk+3Jmd9mOn6jTPcpz8R2ET0kA+G4
 9U+Oyw07QVGvOjOAtTgRJxgJh61nsLA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-582-oo7bFmRrMzysSOmTR1Sd4g-1; Tue,
 03 Dec 2024 06:08:34 -0500
X-MC-Unique: oo7bFmRrMzysSOmTR1Sd4g-1
X-Mimecast-MFC-AGG-ID: oo7bFmRrMzysSOmTR1Sd4g
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C0E80195608B; Tue,  3 Dec 2024 11:08:32 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.37])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A0FDD1956089; Tue,  3 Dec 2024 11:08:29 +0000 (UTC)
Date: Tue, 3 Dec 2024 11:08:25 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: "Gao,Shiyuan" <gaoshiyuan@baidu.com>
Cc: "eduardo@habkost.net" <eduardo@habkost.net>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "mst@redhat.com" <mst@redhat.com>,
 "zhao1.liu@intel.com" <zhao1.liu@intel.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Re: [PATCH 1/1] pcie-root-port: Fast PCIe root ports for new machine
Message-ID: <Z07mqQsWJ299QmAs@redhat.com>
References: <BB513C15-DFE1-40B0-91B6-914D70D3EFB2@baidu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <BB513C15-DFE1-40B0-91B6-914D70D3EFB2@baidu.com>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Dec 03, 2024 at 10:58:22AM +0000, Gao,Shiyuan via wrote:
> > Some hardware devices now support PCIe 5.0, so change the default
> > speed of the PCIe root port on new machine types.
> >
> > For passthrough Nvidia H20, this will be able to increase the h2d/d2h
> > bandwidth ~17%.
> >
> > Origin:
> > [CUDA Bandwidth Test] - Starting...
> > Running on...
> >
> > Device 0: NVIDIA H20
> > Quick Mode
> >
> > Host to Device Bandwidth, 1 Device(s)
> > PINNED Memory Transfers
> >    Transfer Size (Bytes)    Bandwidth(MB/s)
> >    33554432            45915.4
> >
> > Device to Host Bandwidth, 1 Device(s)
> > PINNED Memory Transfers
> >    Transfer Size (Bytes)    Bandwidth(MB/s)
> >    33554432            45980.3
> >
> > Device to Device Bandwidth, 1 Device(s)
> > PINNED Memory Transfers
> >    Transfer Size (Bytes)    Bandwidth(MB/s)
> >    33554432            1842886.8
> >
> > Result = PASS
> >
> > With this patch:
> > [CUDA Bandwidth Test] - Starting...
> > Running on...
> >
> > Device 0: NVIDIA H20
> > Quick Mode
> >
> > Host to Device Bandwidth, 1 Device(s)
> > PINNED Memory Transfers
> >    Transfer Size (Bytes)	Bandwidth(MB/s)
> >    33554432			53682.0
> >
> > Device to Host Bandwidth, 1 Device(s)
> > PINNED Memory Transfers
> >    Transfer Size (Bytes)	Bandwidth(MB/s)
> >    33554432			53766.0
> >
> > Device to Device Bandwidth, 1 Device(s)
> > PINNED Memory Transfers
> >    Transfer Size (Bytes)	Bandwidth(MB/s)
> >    33554432			1842555.1
> >
> > Result = PASS
> >
> > Signed-off-by: Gao Shiyuan <gaoshiyuan@baidu.com>
> > ---
> > hw/core/machine.c                  | 1 +
> > hw/pci-bridge/gen_pcie_root_port.c | 2 +-
> > 2 files changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/hw/core/machine.c b/hw/core/machine.c
> > index a35c4a8fae..afef55626d 100644
> > --- a/hw/core/machine.c
> > +++ b/hw/core/machine.c
> > @@ -38,6 +38,7 @@
> >
> > GlobalProperty hw_compat_9_1[] = {
> >      { TYPE_PCI_DEVICE, "x-pcie-ext-tag", "false" },
> > +    { "pcie-root-port", "x-speed", "16" },
> > };
> > const size_t hw_compat_9_1_len = G_N_ELEMENTS(hw_compat_9_1);
> >
> > diff --git a/hw/pci-bridge/gen_pcie_root_port.c b/hw/pci-bridge/gen_pcie_root_port.c
> > index 784507c826..c24ce1f2d1 100644
> > --- a/hw/pci-bridge/gen_pcie_root_port.c
> > +++ b/hw/pci-bridge/gen_pcie_root_port.c
> > @@ -142,7 +142,7 @@ static Property gen_rp_props[] = {
> >      DEFINE_PROP_SIZE("pref64-reserve", GenPCIERootPort,
> >                       res_reserve.mem_pref_64, -1),
> >      DEFINE_PROP_PCIE_LINK_SPEED("x-speed", PCIESlot,
> > -                                speed, PCIE_LINK_SPEED_16),
> > +                                speed, PCIE_LINK_SPEED_32),
> >      DEFINE_PROP_PCIE_LINK_WIDTH("x-width", PCIESlot,
> >                                  width, PCIE_LINK_WIDTH_32),
> >      DEFINE_PROP_END_OF_LIST()
> > --
> > 2.34.1
> 
> Ping.

There was a question from Jonathan Cameron on the original posting of this
patch that is awaiting your answer....

Regardless, at this time in the release cycle its too late for 9.2, so this
patch would likely need to be adapted for the 10.0 release and to use the
hw_compat_9_2 that will then be added.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


