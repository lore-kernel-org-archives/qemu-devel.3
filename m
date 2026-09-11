Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88EE9C88E4D
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 16:51:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x54St-0004C8-D6; Fri, 11 Sep 2026 12:51:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1x54Sp-0004AU-JV
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 12:51:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1x54Sg-0002hh-Cw
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 12:50:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789145448;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mNCCwd+rbPqirfm0wkJvjXVhjTPI0RhTanYIYxdf+Sc=;
 b=ZDFDZ3Z5FO0rNZV3BN8NiqWIMrIzN80Eo5/x2K4yHB9xn0KdcCz0ZSjsmhcWmkS4F11L+E
 KA9hnI2+rMlQQnFtPrH/N4YRIu1TvldZ+8kNRR9Osh+TZgCj7KeNH2jU9BzKolxLbJK9DU
 RphPjCg6fdMhp7Hs/oSe7pQte0tvAjU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-294-uChttM2tMFKEHHKjELXc6g-1; Fri,
 11 Sep 2026 12:50:43 -0400
X-MC-Unique: uChttM2tMFKEHHKjELXc6g-1
X-Mimecast-MFC-AGG-ID: uChttM2tMFKEHHKjELXc6g_1789145442
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D860919560BC; Fri, 11 Sep 2026 16:50:41 +0000 (UTC)
Received: from redhat.com (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E3B96180034C; Fri, 11 Sep 2026 16:50:39 +0000 (UTC)
Date: Fri, 11 Sep 2026 17:50:37 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: xen-devel@lists.xenproject.org, qemu-riscv@nongnu.org,
 qemu-ppc@nongnu.org, qemu-block@nongnu.org, qemu-s390x@nongnu.org,
 qemu-arm@nongnu.org
Subject: Re: [PATCH 15/28] hw: define most common PCI types as secure
Message-ID: <aqQxXXs4_NfDdkim@redhat.com>
References: <20260911143627.2743803-1-berrange@redhat.com>
 <20260911143627.2743803-16-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260911143627.2743803-16-berrange@redhat.com>
User-Agent: Mutt/2.4.0 (2026-06-19)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 37
X-Spam_score: 3.7
X-Spam_bar: +++
X-Spam_report: (3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 SUSPICIOUS_RECIPS=2.51 autolearn=no autolearn_force=no
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

On Fri, Sep 11, 2026 at 03:36:14PM +0100, Daniel P. Berrangé wrote:
> Essentially all PCI infrastructure is in scope for the virtualization
> use case, aside from the niche simba bridge.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>  hw/pci-bridge/gen_pcie_root_port.c  | 1 +
>  hw/pci-bridge/i82801b11.c           | 1 +
>  hw/pci-bridge/ioh3420.c             | 1 +
>  hw/pci-bridge/pci_bridge_dev.c      | 2 ++
>  hw/pci-bridge/pci_expander_bridge.c | 8 ++++++++
>  hw/pci-bridge/pcie_pci_bridge.c     | 1 +
>  hw/pci-bridge/pcie_root_port.c      | 1 +
>  hw/pci-bridge/xio3130_downstream.c  | 1 +
>  hw/pci-bridge/xio3130_upstream.c    | 1 +
>  hw/pci/pci.c                        | 7 +++++++
>  hw/pci/pci_bridge.c                 | 1 +
>  hw/pci/pci_host.c                   | 1 +
>  hw/pci/pcie_host.c                  | 1 +
>  hw/pci/pcie_port.c                  | 1 +
>  14 files changed, 28 insertions(+)
> 

> diff --git a/hw/pci-bridge/pci_expander_bridge.c b/hw/pci-bridge/pci_expander_bridge.c
> index 40ffbc4e08..bd5598b639 100644
> --- a/hw/pci-bridge/pci_expander_bridge.c
> +++ b/hw/pci-bridge/pci_expander_bridge.c

snip

> @@ -128,6 +130,7 @@ static const TypeInfo pxb_cxl_bus_info = {
>      .parent        = TYPE_CXL_BUS,
>      .instance_size = sizeof(PXBBus),
>      .class_init    = pxb_bus_class_init,
> +    .secure        = true,
>  };
>  

snip

>  static void pxb_cxl_realize(DeviceState *dev, Error **errp)
> @@ -249,6 +253,7 @@ static const TypeInfo cxl_host_info = {
>      .parent        = TYPE_PCI_HOST_BRIDGE,
>      .instance_size = sizeof(CXLHost),
>      .class_init    = pxb_cxl_host_class_init,
> +    .secure        = true,
>  };
>  
>  /*

snip

> @@ -540,6 +547,7 @@ static const TypeInfo pxb_cxl_dev_info = {
>      .parent        = TYPE_PXB_PCIE_DEV,
>      .instance_size = sizeof(PXBCXLDev),
>      .class_init    = pxb_cxl_dev_class_init,
> +    .secure        = true,
>      .interfaces =
>          (const InterfaceInfo[]){
>              { INTERFACE_CONVENTIONAL_PCI_DEVICE },

These three were a mistake. No CXL code is intended to be classed as
secure at this time.


With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


