Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A64A6E77184
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2024 17:00:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOJsU-0000Na-Dk; Thu, 19 Dec 2024 11:59:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tOJsS-0000Ik-Lg
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 11:59:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tOJsQ-0002jU-Ms
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 11:59:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734627594;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Zt3Xk6XYmeOTeYlUvbY4TwVyBTAAaK1QA4ZkgRPwOQo=;
 b=eBz5mvtmz00axaki7d4dKvcxdJFzex6wJHnQqQ15hXPdqFVAkAnrbXOKIdeXR+ibIRWLMj
 /vfIizAJzAcQay4KZ1eFm9BUBYlPwkP9KalsTeLVQnRdiO7dLTl9g5T+tXdC4NAbru6XtV
 KKMTndNRdYTa7aSLcXwiS8SPGb44hLk=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-677-H1jkHNZ_NUqFoXD7Ph5Rdw-1; Thu,
 19 Dec 2024 11:59:52 -0500
X-MC-Unique: H1jkHNZ_NUqFoXD7Ph5Rdw-1
X-Mimecast-MFC-AGG-ID: H1jkHNZ_NUqFoXD7Ph5Rdw
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id ABB1A1955F56; Thu, 19 Dec 2024 16:59:51 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.54])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 96B1B30044C1; Thu, 19 Dec 2024 16:59:49 +0000 (UTC)
Date: Thu, 19 Dec 2024 16:59:45 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Ani Sinha <anisinha@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 devel@lists.libvirt.org
Subject: Re: [RFC PATCH 04/10] hw/misc/vmcoreinfo: Rename VMCOREINFO_DEVICE
 -> TYPE_VMCOREINFO_DEVICE
Message-ID: <Z2RRARwT282Rj0aN@redhat.com>
References: <20241219153857.57450-1-philmd@linaro.org>
 <20241219153857.57450-5-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241219153857.57450-5-philmd@linaro.org>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.116,
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

On Thu, Dec 19, 2024 at 04:38:51PM +0100, Philippe Mathieu-Daudé wrote:
> Follow the assumed QOM type definition style, prefixing with 'TYPE_'.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  include/hw/misc/vmcoreinfo.h | 6 +++---
>  hw/misc/vmcoreinfo.c         | 8 ++++----
>  2 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/include/hw/misc/vmcoreinfo.h b/include/hw/misc/vmcoreinfo.h
> index da1066d540c..122c69686b0 100644
> --- a/include/hw/misc/vmcoreinfo.h
> +++ b/include/hw/misc/vmcoreinfo.h
> @@ -16,10 +16,10 @@
>  #include "standard-headers/linux/qemu_fw_cfg.h"
>  #include "qom/object.h"
>  
> -#define VMCOREINFO_DEVICE "vmcoreinfo"
> +#define TYPE_VMCOREINFO_DEVICE "vmcoreinfo"

Yes to adding TYPE_, but while there would also
drop _DEVICE.  IMHO the best practice is for
TYPE_<NNNN> where NNNN matches the "nnnn" name.
An extra suffix doesn't add value, unless we've
got some other symbol clashing which is almost
never the case.

>  typedef struct VMCoreInfoState VMCoreInfoState;
> -DECLARE_INSTANCE_CHECKER(VMCoreInfoState, VMCOREINFO,
> -                         VMCOREINFO_DEVICE)
> +DECLARE_INSTANCE_CHECKER(VMCoreInfoState, VMCOREINFO_DEVICE,
> +                         TYPE_VMCOREINFO_DEVICE)
>  
>  typedef struct fw_cfg_vmcoreinfo FWCfgVMCoreInfo;
>  
> diff --git a/hw/misc/vmcoreinfo.c b/hw/misc/vmcoreinfo.c
> index c5bb5c9fa52..9822615cfed 100644
> --- a/hw/misc/vmcoreinfo.c
> +++ b/hw/misc/vmcoreinfo.c
> @@ -37,7 +37,7 @@ static void vmcoreinfo_reset(void *opaque)
>  
>  static void vmcoreinfo_realize(DeviceState *dev, Error **errp)
>  {
> -    VMCoreInfoState *s = VMCOREINFO(dev);
> +    VMCoreInfoState *s = VMCOREINFO_DEVICE(dev);
>      FWCfgState *fw_cfg = fw_cfg_find();
>      /* for gdb script dump-guest-memory.py */
>      static VMCoreInfoState * volatile vmcoreinfo_state G_GNUC_UNUSED;
> @@ -48,13 +48,13 @@ static void vmcoreinfo_realize(DeviceState *dev, Error **errp)
>       */
>      if (!vmcoreinfo_find()) {
>          error_setg(errp, "at most one %s instance is permitted",
> -                   VMCOREINFO_DEVICE);
> +                   TYPE_VMCOREINFO_DEVICE);
>          return;
>      }
>  
>      if (!fw_cfg || !fw_cfg->dma_enabled) {
>          error_setg(errp, "%s device requires fw_cfg with DMA",
> -                   VMCOREINFO_DEVICE);
> +                   TYPE_VMCOREINFO_DEVICE);
>          return;
>      }
>  
> @@ -96,7 +96,7 @@ static void vmcoreinfo_device_class_init(ObjectClass *klass, void *data)
>  
>  static const TypeInfo vmcoreinfo_types[] = {
>      {
> -        .name           = VMCOREINFO_DEVICE,
> +        .name           = TYPE_VMCOREINFO_DEVICE,
>          .parent         = TYPE_DEVICE,
>          .instance_size  = sizeof(VMCoreInfoState),
>          .class_init     = vmcoreinfo_device_class_init,
> -- 
> 2.47.1
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


