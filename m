Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24698CA5FD4
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2026 17:23:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCgyk-0001p7-NH; Fri, 02 Oct 2026 13:23:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xCgxD-0008Ts-7x
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 13:21:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xCgxA-0003WN-0l
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 13:21:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790961707;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9w4jIAPaUQybA3EsxmBsJb1p/fnbPpxufD6dm+ex3Jo=;
 b=NpEGgLbyAHJVroTOFAc1/Q8AFkTuTbC+h8vS7ZYbDS0dd8MC9KAs+baR/qf7NJJbjS2cM7
 yY6c5Zzjlm5KZqu3Kn4Z7YA3nWvzRlTWHVIgE2d7Ghmi3bhExvLzPMnCArtu5zxMfOl3ci
 RJw/czHeJYQf3Qc8RrT3M7I68lSMdYc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-552-y1zeXxcEMaePaVYyLaVHJg-1; Fri,
 02 Oct 2026 13:21:43 -0400
X-MC-Unique: y1zeXxcEMaePaVYyLaVHJg-1
X-Mimecast-MFC-AGG-ID: y1zeXxcEMaePaVYyLaVHJg_1790961701
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9080F1801354; Fri,  2 Oct 2026 17:21:41 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B9CF1433; Fri,  2 Oct 2026 17:21:40 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 09/28] hw/net: mark e1000, e1000e, IGB, rtl8139 & sPAPR
 VLAN as secure
From: marcandre.lureau@redhat.com
To: =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, xen-devel@lists.xenproject.org, 
 qemu-riscv@nongnu.org, qemu-ppc@nongnu.org, qemu-block@nongnu.org, 
 qemu-s390x@nongnu.org, qemu-arm@nongnu.org
In-Reply-To: <20260911143627.2743803-10-berrange@redhat.com>
References: <20260911143627.2743803-1-berrange@redhat.com>
 <20260911143627.2743803-10-berrange@redhat.com>
Date: Fri, 02 Oct 2026 21:21:01 +0400
Message-Id: <179096166117.3025252.3399554700496925383.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=3195;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=+tdgjJRXFosxAEmGsg3dsoMhhj4DzUSDUOZcS2OqB2Y=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqv+gBMjIspCHTznfNZU7JF57wkV8PBkHXjvof1
 p5wZaOADoWJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCar/oAQAKCRDa6OEJdZac
 5WtfD/0Zj1WkqtuXuTJ8VTcQzQYbxbvIz9VU6P+lif52L+QHHdQ21YYM6Sy8FIrUBWUZco8vgDK
 GwEyfj1drJm3qZ8xlUa7VxVPXpkFQ1RcllwAykU0HVrC5MatPWUwU/ZxNIMf2jtux6fIYe7RQIq
 rkZTMkiztkzhBwXsDk8VnJzlfj6m4EwVJchW8Nd3dP8se1dzq9mfkz9cvSLSt+IfZOXxyadmXlc
 wak8ZD1CC3wEDs72d/7pBnQA7v7LD3nCRsyh5o1JKQz31ssNG1YKocOfEt7lKYv1TR5FGzTeZCQ
 oQ/9vH/WJVfB1aqDLL7RLAiuh7LuNhZJ5ANELS7kDQXHRpQPPGu6Xxv2GP5MR/oeV3c/WLSzmaa
 AuBMpBeUUzUar7Fta1LCk4unWf0aOIjsA2YSgh2NyDiDQodDH5cgAGNayQRgoBhA26pGXypUttf
 RwpbO9IfMp8a12IkbUYNsom156/YhTldVv2bTk70XIWgATx0H4654n/xWR5a2ZIx2LRmvej9qYV
 dchyuXHAxg1JeV3OuV2z3j7SyJoS+UOfMR9TQD1llwIs1wKsfnAix3TC+dPKLbQoJ6g7e7bbCHu
 ammVmErv9BT/w16BB1+sVuMWupFu/vDGJnFADgnXWXPVPOXdlVagcUO8K+xKEmtgh3VumGbSwAJ
 pMxuon8+bGqjDWQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.336,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

> Historically most NICs are only interesting for non-virtualization
> use cases and have not been written with malicious guests in mind.
> 
> As a general rule either virtio-net or xen-net should be used in
> all virtualized guests requiring a security boundary.
> 
> There are a handful of exceptions resulting from historical usage
> in the x86 world, to support virtualized guests lacking virtio
> support.
> 
> Thus the rtl8139, e1000, e1000e & IGB NICs are declared to provide
> a security boundary.
> 
> The PPC sPAPR Virutal LAN device is also marked secure.

Virtual

> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> Message-ID: <20260911143627.2743803-10-berrange@redhat.com>
>
> diff --git a/hw/net/e1000.c b/hw/net/e1000.c
> index 202ad404013a..da0667c40ec0 100644
> --- a/hw/net/e1000.c
> +++ b/hw/net/e1000.c
> @@ -1759,6 +1759,7 @@ static void e1000_register_types(void)
>          type_info.parent = TYPE_E1000_BASE;
>          type_info.class_data = info;
>          type_info.class_init = e1000_class_init;
> +        type_info.secure = true,

  type_info.secure = true;

>  
>          type_register_static(&type_info);
>      }
> diff --git a/hw/net/e1000e.c b/hw/net/e1000e.c
> index 9faf0c74c3d4..96737ddb51ac 100644
> --- a/hw/net/e1000e.c
> +++ b/hw/net/e1000e.c
> @@ -721,6 +721,7 @@ static const TypeInfo e1000e_info = {
>      .instance_size = sizeof(E1000EState),
>      .class_init = e1000e_class_init,
>      .instance_init = e1000e_instance_init,
> +    .secure = true,
>      .interfaces = (const InterfaceInfo[]) {
>          { INTERFACE_PCIE_DEVICE },
>          { }
> diff --git a/hw/net/igb.c b/hw/net/igb.c
> index c076807e7110..0bd03efea0cd 100644
> --- a/hw/net/igb.c
> +++ b/hw/net/igb.c
> @@ -635,6 +635,7 @@ static const TypeInfo igb_info = {
>      .instance_size = sizeof(IGBState),
>      .class_init = igb_class_init,
>      .instance_init = igb_instance_init,
> +    .secure = true,
>      .interfaces = (const InterfaceInfo[]) {
>          { INTERFACE_PCIE_DEVICE },
>          { }
> diff --git a/hw/net/rtl8139.c b/hw/net/rtl8139.c
> index 16479284eea9..38bc16f312fb 100644
> --- a/hw/net/rtl8139.c
> +++ b/hw/net/rtl8139.c
> @@ -3450,6 +3450,7 @@ static const TypeInfo rtl8139_info = {
>      .instance_size = sizeof(RTL8139State),
>      .class_init    = rtl8139_class_init,
>      .instance_init = rtl8139_instance_init,
> +    .secure        = true,
>      .interfaces = (const InterfaceInfo[]) {
>          { INTERFACE_CONVENTIONAL_PCI_DEVICE },
>          { },
> diff --git a/hw/net/spapr_llan.c b/hw/net/spapr_llan.c
> index 550848307d16..c7ac58273c6f 100644
> --- a/hw/net/spapr_llan.c
> +++ b/hw/net/spapr_llan.c
> @@ -873,6 +873,7 @@ static const TypeInfo spapr_vlan_info = {
>      .class_init    = spapr_vlan_class_init,
>      .instance_init = spapr_vlan_instance_init,
>      .instance_finalize = spapr_vlan_instance_finalize,
> +    .secure        = true,
>  };
>  
>  static void spapr_vlan_register_types(void)

Acked-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


