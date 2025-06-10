Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 516D8C677C4
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Jun 2025 17:12:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uP2Wc-00030V-Sl; Tue, 10 Jun 2025 13:12:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uP2WY-0002ue-3f
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 13:12:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uP2WT-0006rJ-NA
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 13:12:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749575543;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=84WEd7XTKlGYxmL8Sv1xlos/gD/wZ0nvIM4QL2RAzLE=;
 b=Cz2EKVrwgxJdH+gwssGyhndS0k7jtNLJDOdo3AflrTIGdsv4uxsHZv/J0Yoi97ldXEN7Nr
 IjySMFX8hIk550PWJWJrgGaqY1K14hcPLSiWtPk+hFlWBJOsxIv3tGLu1K1setcJyScGEX
 LvBWcVw0NcP2K28QWLaeYHelICdMJ24=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-257-2c0evJulNcK_dyjipBjX9Q-1; Tue,
 10 Jun 2025 13:12:19 -0400
X-MC-Unique: 2c0evJulNcK_dyjipBjX9Q-1
X-Mimecast-MFC-AGG-ID: 2c0evJulNcK_dyjipBjX9Q_1749575538
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1F845195609E
 for <qemu-devel@nongnu.org>; Tue, 10 Jun 2025 17:12:18 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.87])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3F67230002C5; Tue, 10 Jun 2025 17:12:16 +0000 (UTC)
Date: Tue, 10 Jun 2025 18:12:12 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH 2/2] watchdog: generic name for i6300esb
Message-ID: <aEhnbN1pSYgdi4EZ@redhat.com>
References: <20250610143259.1056400-1-cohuck@redhat.com>
 <20250610143259.1056400-3-cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250610143259.1056400-3-cohuck@redhat.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Tue, Jun 10, 2025 at 04:32:59PM +0200, Cornelia Huck wrote:
> The Intel 6300 Enterprise SouthBridge is a south bridge for a more or
> less obscure embedded Intel system; however, the i6300esb watchdog
> device we implement in QEMU is a virtual watchdog device that should
> work well on any PCI-based machine, is well supported by Linux guests,
> and used in many examples on how to set up a virtual watchdog.
> 
> Let's use "virtual i6300ESB" in the description to make clear that
> this device will work just fine on non-Intel platforms.
> 
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> ---
>  hw/watchdog/wdt_i6300esb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

I'm not entirely sold on the idea that this is needed, but at the same
time I won't object so

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>


> 
> diff --git a/hw/watchdog/wdt_i6300esb.c b/hw/watchdog/wdt_i6300esb.c
> index bb8a2766b69b..5e5d8c48cfd7 100644
> --- a/hw/watchdog/wdt_i6300esb.c
> +++ b/hw/watchdog/wdt_i6300esb.c
> @@ -472,7 +472,7 @@ static void i6300esb_class_init(ObjectClass *klass, const void *data)
>      device_class_set_legacy_reset(dc, i6300esb_reset);
>      dc->vmsd = &vmstate_i6300esb;
>      set_bit(DEVICE_CATEGORY_WATCHDOG, dc->categories);
> -    dc->desc = "Intel 6300ESB";
> +    dc->desc = "virtual i6300ESB";
>  }
>  
>  static const TypeInfo i6300esb_info = {
> -- 
> 2.49.0
> 
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


