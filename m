Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68E6DC25B75
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2024 14:38:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFEFb-0007lm-2W; Thu, 06 Jun 2024 10:37:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sFEFa-0007la-2O
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 10:37:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sFEFY-0001yW-9R
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 10:37:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717684674;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=XTL7wDH/bkQv8y1LPQlgV4mxjFz6bvErRSUqQto+yNU=;
 b=Ib4ahi/OqazmBF6xnkjkICsLZoEeszKK0vL5UBWG4O5VJQH0gubVF1gZKiMTK+AVbJNu17
 NYGC0yRWAK0QmZoFuUlprvirx71ZjieDvQtBTGMY6G1A5sI6439i94LaDRY3SZL4tZtfsP
 iM32tCBfX0KcmVeDejlAJszR3HAAiaM=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-650-Uc8bOvDDM3Cqd4tSbFpJ0Q-1; Thu,
 06 Jun 2024 10:37:50 -0400
X-MC-Unique: Uc8bOvDDM3Cqd4tSbFpJ0Q-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6B2F219B9AAF; Thu,  6 Jun 2024 14:37:48 +0000 (UTC)
Received: from redhat.com (unknown [10.39.193.201])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E16A63001E83; Thu,  6 Jun 2024 14:37:45 +0000 (UTC)
Date: Thu, 6 Jun 2024 15:37:42 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH v3 3/4] vga/cirrus: mark as not secure
Message-ID: <ZmHJtrpvbMorfUm1@redhat.com>
References: <20240606143010.1318226-1-kraxel@redhat.com>
 <20240606143010.1318226-4-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240606143010.1318226-4-kraxel@redhat.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On Thu, Jun 06, 2024 at 04:30:09PM +0200, Gerd Hoffmann wrote:

What's the justification for declaring cirrus to be insecure ?

It is shipped as a driver in RHEL for years, was the default graphics
adapter for most of this time, and bugs in it are considered CVEs
still.

> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  hw/display/cirrus_vga.c     | 1 +
>  hw/display/cirrus_vga_isa.c | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/hw/display/cirrus_vga.c b/hw/display/cirrus_vga.c
> index 150883a97166..1f4c55b21415 100644
> --- a/hw/display/cirrus_vga.c
> +++ b/hw/display/cirrus_vga.c
> @@ -3007,6 +3007,7 @@ static void cirrus_vga_class_init(ObjectClass *klass, void *data)
>      dc->vmsd = &vmstate_pci_cirrus_vga;
>      device_class_set_props(dc, pci_vga_cirrus_properties);
>      dc->hotpluggable = false;
> +    klass->not_secure = true;
>  }
>  
>  static const TypeInfo cirrus_vga_info = {
> diff --git a/hw/display/cirrus_vga_isa.c b/hw/display/cirrus_vga_isa.c
> index 84be51670ed8..535a631b4b09 100644
> --- a/hw/display/cirrus_vga_isa.c
> +++ b/hw/display/cirrus_vga_isa.c
> @@ -85,6 +85,7 @@ static void isa_cirrus_vga_class_init(ObjectClass *klass, void *data)
>      dc->realize = isa_cirrus_vga_realizefn;
>      device_class_set_props(dc, isa_cirrus_vga_properties);
>      set_bit(DEVICE_CATEGORY_DISPLAY, dc->categories);
> +    klass->not_secure = true;
>  }
>  
>  static const TypeInfo isa_cirrus_vga_info = {
> -- 
> 2.45.2
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


