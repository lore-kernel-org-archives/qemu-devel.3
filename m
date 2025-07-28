Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D24DCC87FCE
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Jul 2025 09:08:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugJqD-0003gI-3v; Mon, 28 Jul 2025 05:08:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1ugJpQ-00024L-8Q
 for qemu-devel@nongnu.org; Mon, 28 Jul 2025 05:07:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1ugJpI-0007zw-34
 for qemu-devel@nongnu.org; Mon, 28 Jul 2025 05:07:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753693634;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DPZVEG28TIy0bIDt9KcrNnRp88CnvQb+W6tCjW4zPnc=;
 b=RJhPlqCMIlD784AI9xkyvHaGedsMOpcpYvgFAeX+iRqtRnkEW3N2P64j3FOjPnJBvoq8di
 AF17o6mF/eX1G/xglIjA+MtWFQRZTTVzbMBPrnNWx7R3DfyceIAsHH1yXa6pO8/X3gtUU1
 pjTjU8oDMNXNdSAQ8dILmZwI31Pdsas=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-20-XVSQVeqKNmCWLJfZXi1g6w-1; Mon,
 28 Jul 2025 05:07:09 -0400
X-MC-Unique: XVSQVeqKNmCWLJfZXi1g6w-1
X-Mimecast-MFC-AGG-ID: XVSQVeqKNmCWLJfZXi1g6w_1753693628
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3BB0618002A5; Mon, 28 Jul 2025 09:07:08 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.32])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BD09119560A2; Mon, 28 Jul 2025 09:07:05 +0000 (UTC)
Date: Mon, 28 Jul 2025 10:07:02 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: =?utf-8?Q?Cl=C3=A9ment?= Chigot <chigot@adacore.com>
Cc: qemu-devel@nongnu.org, balaton@eik.bme.hu, qemu-ppc@nongnu.org,
 marcandre.lureau@redhat.com
Subject: Re: [PATCH] hw/display/sm501: fix missing error-report.h
Message-ID: <aIc9tpPyYWnv7HG2@redhat.com>
References: <20250728090518.963573-1-chigot@adacore.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250728090518.963573-1-chigot@adacore.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Mon, Jul 28, 2025 at 11:05:18AM +0200, Clément Chigot wrote:
> "qemu/error-report.h" was previously implicitly included. This is no
> longer the case following 012842c075520dbe1bd96a2fdcf4e218874ba443.
> 
> However, the issue predates this change as `error-report.h` should have
> been included when the `warn_report` call was introduced.
> 
> Fixes: fa140b9562 ("hw/sm501: allow compiling without PIXMAN")
> Signed-off-by: Clément Chigot <chigot@adacore.com>
> ---
>  hw/display/sm501.c | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>

> 
> diff --git a/hw/display/sm501.c b/hw/display/sm501.c
> index 6d2f18684c..bc091b3c9f 100644
> --- a/hw/display/sm501.c
> +++ b/hw/display/sm501.c
> @@ -26,6 +26,7 @@
>  #include "qemu/osdep.h"
>  #include "qemu/units.h"
>  #include "qapi/error.h"
> +#include "qemu/error-report.h"
>  #include "qemu/log.h"
>  #include "qemu/module.h"
>  #include "hw/usb/hcd-ohci.h"
> -- 
> 2.34.1
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


