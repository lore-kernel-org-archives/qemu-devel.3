Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E630EC43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 16:58:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wh97n-0005qB-KT; Tue, 07 Jul 2026 12:58:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wh97k-0005pD-5e
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 12:58:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wh97i-0005Cd-D6
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 12:58:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783443497;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=eI51u9TksxJvnAZUGrM6ipy7pCLKiNUfJCTNH1LjrD4=;
 b=DLcKOjDylIk4Ht7rdKTVLBRPnr27r6bZ0r99S6LfMIiBLvXoDBleAOV4OTX4ShnHDqPJEs
 /zjFbmJnEzwFc3ccZkhMzYl51BYTgQpqubK2GfGMAU+qrCMv91oz2iWCasVopAJ2d0HZbg
 abmV4DNew1BmalLu+PTo+xWdJd19XX0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-288-PL1tCEQXM7elaiNPBY48-w-1; Tue,
 07 Jul 2026 12:58:14 -0400
X-MC-Unique: PL1tCEQXM7elaiNPBY48-w-1
X-Mimecast-MFC-AGG-ID: PL1tCEQXM7elaiNPBY48-w_1783443492
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BF4B01806CAB; Tue,  7 Jul 2026 16:58:12 +0000 (UTC)
Received: from redhat.com (unknown [10.44.33.142])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 620A41800756; Tue,  7 Jul 2026 16:58:10 +0000 (UTC)
Date: Tue, 7 Jul 2026 17:58:06 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Cc: pbonzini@redhat.com, richard.henderson@linaro.org, mst@redhat.com,
 mtosatti@redhat.com, qemu-devel@nongnu.org
Subject: Re: [PATCH 8/9] hw/i386/pc_sysfw.c: convert pflash0 and pflash1
 object props to class props
Message-ID: <ak0wHkWQpXX5H45e@redhat.com>
References: <20260703090814.2993188-1-mark.caveayland@nutanix.com>
 <20260703090814.2993188-9-mark.caveayland@nutanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260703090814.2993188-9-mark.caveayland@nutanix.com>
User-Agent: Mutt/2.3.2 (2026-04-26)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, Jul 03, 2026 at 10:08:01AM +0100, Mark Cave-Ayland wrote:
> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
> ---
>  include/hw/i386/pc.h | 2 ++
>  hw/i386/pc.c         | 8 ++++++++
>  hw/i386/pc_sysfw.c   | 7 +------
>  3 files changed, 11 insertions(+), 6 deletions(-)
> 
> diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
> index 309de2eda1..16cb0ec01f 100644
> --- a/include/hw/i386/pc.h
> +++ b/include/hw/i386/pc.h
> @@ -40,6 +40,8 @@ typedef struct PCMachineState {
>  
>      Object *alias_pcspk;
>      Object *alias_rtc_time;
> +    Object *alias_pflash0;
> +    Object *alias_pflash1;
>  
>      /* Configuration options: */
>      uint64_t max_ram_below_4g;
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index 13c9c1bfc8..11eef176f4 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -1762,6 +1762,14 @@ static void pc_machine_class_init(ObjectClass *oc, const void *data)
>                                     offsetof(X86MachineState, acpi_dev),
>                                     object_property_allow_set_link,
>                                     OBJ_PROP_LINK_STRONG);
> +    object_class_property_add_alias(oc, "pflash0",
> +                                    offsetof(PCMachineState, alias_pflash0),
> +                                    TYPE_PFLASH_CFI01,
> +                                    "drive");
> +    object_class_property_add_alias(oc, "pflash1",
> +                                    offsetof(PCMachineState, alias_pflash1),
> +                                    TYPE_PFLASH_CFI01,
> +                                    "drive");
>  }
>  
>  static const TypeInfo pc_machine_info = {
> diff --git a/hw/i386/pc_sysfw.c b/hw/i386/pc_sysfw.c
> index 1a41a5972b..441e777191 100644
> --- a/hw/i386/pc_sysfw.c
> +++ b/hw/i386/pc_sysfw.c
> @@ -85,8 +85,7 @@ static PFlashCFI01 *pc_pflash_create(PCMachineState *pcms,
>      qdev_prop_set_uint8(dev, "width", 1);
>      qdev_prop_set_string(dev, "name", name);
>      object_property_add_child(OBJECT(pcms), name, OBJECT(dev));
> -    object_property_add_alias(OBJECT(pcms), alias_prop_name,
> -                              OBJECT(dev), "drive");
> +    object_property_set_alias(OBJECT(pcms), alias_prop_name, OBJECT(dev));
>      /*
>       * The returned reference is tied to the child property and
>       * will be removed with object_unparent.
> @@ -109,16 +108,12 @@ void pc_system_flash_create(PCMachineState *pcms)
>  
>  void pc_system_flash_cleanup_unused(PCMachineState *pcms)
>  {
> -    char *prop_name;
>      int i;
>  
>      assert(PC_MACHINE_GET_CLASS(pcms)->pci_enabled);
>  
>      for (i = 0; i < ARRAY_SIZE(pcms->flash); i++) {
>          if (!qdev_is_realized(DEVICE(pcms->flash[i]))) {
> -            prop_name = g_strdup_printf("pflash%d", i);
> -            object_property_del(OBJECT(pcms), prop_name);
> -            g_free(prop_name);
>              object_unparent(OBJECT(pcms->flash[i]));
>              pcms->flash[i] = NULL;
>          }

Does this externally change visible behaviour ?

The pc_system_flash_cleanup_unused method is run in the instance
init method, and will purge the 'pflash0' and 'pflash1' properties
if they were never set.

IIUC with the new code pflash0 and pflash1 will always be visible,
but would be unset, as object_property_set_alias would not have
been called.

THe new behaviour is arguably better - IMHO properties should
always be present, and use "unset" as an explicit state.

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


