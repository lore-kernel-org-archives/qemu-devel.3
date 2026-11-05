Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A46606A328
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2026 11:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=cZZ8Og9U
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOvK1-00077v-V0; Thu, 05 Nov 2026 06:07:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xOvJz-00077e-OI
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 06:07:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xOvJx-0001TQ-LY
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 06:07:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793876873;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=0d08p9GuGfhuCctsBUdpSTjaH731P9alS/QFsAP7+SA=;
 b=cZZ8Og9UXOsxpodzAvlIKalfdo4/QVxrcL++pjdwSz15snNWytdgUERxfLFOA7Wfh9TG5C
 k2yAOA7eU/40eBNqoRdtefRHYpcPVUGlnupPkD+FvPIQN3NW3Ask9SJ3MVzZ8Iu1g87Vhc
 nZlIWbIyJZB/erJNUBrqNJNBbhNlWm4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-78-Hj5rPtwkOHWuy65T6YO15A-1; Thu,
 05 Nov 2026 06:07:47 -0500
X-MC-Unique: Hj5rPtwkOHWuy65T6YO15A-1
X-Mimecast-MFC-AGG-ID: Hj5rPtwkOHWuy65T6YO15A_1793876865
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D6F3618002FB; Thu,  5 Nov 2026 11:07:44 +0000 (UTC)
Received: from redhat.com (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9B35C1956044; Thu,  5 Nov 2026 11:07:40 +0000 (UTC)
Date: Thu, 5 Nov 2026 11:07:37 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Yonggang Luo <luoyonggang@gmail.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 Song Gao <17746591750@163.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 Philippe Mathieu-Daude <philmd@mailo.com>,
 David Hildenbrand <david@kernel.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Fam Zheng <fam@euphon.net>, Max Filippov <jcmvbkbc@gmail.com>,
 qemu-s390x@nongnu.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Eric Farman <farman@linux.ibm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Cornelia Huck <cohuck@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: Re: [PATCH v2 11/12] hw/virtio/virtio-mem: register legacy-guest
 variant with is_available
Message-ID: <auxjeTD9e3H2dHlj@redhat.com>
References: <20261031164009.2048-1-luoyonggang@gmail.com>
 <20261031164009.2048-12-luoyonggang@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261031164009.2048-12-luoyonggang@gmail.com>
User-Agent: Mutt/2.4.3 (2026-10-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sun, Nov 01, 2026 at 12:40:06AM +0800, Yonggang Luo wrote:
> virtio-mem decided in class_init and realize whether x86 guests can
> leave unplugged memory accessible. Register a second virtio-mem type
> that adds virtio_mem_legacy_guests_properties and sets
> VirtIOMEMClass.has_legacy_guests. Select the two with
> target_base_i386() and target_not_base_i386().
> 
> Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> ---
>  hw/virtio/virtio-mem.c         | 52 +++++++++++++++++++++-------------
>  include/hw/virtio/virtio-mem.h |  2 ++
>  2 files changed, 34 insertions(+), 20 deletions(-)
> 
> diff --git a/hw/virtio/virtio-mem.c b/hw/virtio/virtio-mem.c
> index ee6a0c206af..ab2864d18c3 100644
> --- a/hw/virtio/virtio-mem.c
> +++ b/hw/virtio/virtio-mem.c
> @@ -15,6 +15,7 @@
>  #include "qemu/cutils.h"
>  #include "qemu/error-report.h"
>  #include "qemu/units.h"
> +#include "qemu/target-info.h"
>  #include "qemu/target-info-qapi.h"
>  #include "system/memory.h"
>  #include "system/numa.h"
> @@ -35,22 +36,6 @@
>  
>  static const VMStateDescription vmstate_virtio_mem_device_early;
>  
> -static bool virtio_mem_has_legacy_guests(void)
> -{
> -    /*
> -     * We only had legacy x86 guests that did not support
> -     * VIRTIO_MEM_F_UNPLUGGED_INACCESSIBLE. Other targets don't have
> -     * legacy guests.
> -     */
> -    switch (target_arch()) {
> -    case SYS_EMU_TARGET_I386:
> -    case SYS_EMU_TARGET_X86_64:
> -        return true;
> -    default:
> -        return false;
> -    }
> -}
> -
>  /*
>   * Let's not allow blocks smaller than 1 MiB, for example, to keep the tracking
>   * bitmap small.
> @@ -859,7 +844,7 @@ static void virtio_mem_device_realize(DeviceState *dev, Error **errp)
>      rb = vmem->memdev->mr.ram_block;
>      page_size = qemu_ram_pagesize(rb);
>  
> -    if (virtio_mem_has_legacy_guests()) {
> +    if (VIRTIO_MEM_GET_CLASS(vmem)->has_legacy_guests) {
>          switch (vmem->unplugged_inaccessible) {
>          case ON_OFF_AUTO_AUTO:
>              if (virtio_mem_has_shared_zeropage(rb)) {
> @@ -1635,9 +1620,6 @@ static void virtio_mem_class_init(ObjectClass *klass, const void *data)
>      RamDiscardSourceClass *rdsc = RAM_DISCARD_SOURCE_CLASS(klass);
>  
>      device_class_set_props(dc, virtio_mem_properties);
> -    if (virtio_mem_has_legacy_guests()) {
> -        device_class_set_props(dc, virtio_mem_legacy_guests_properties);
> -    }

Again IMHO the conditional property registration is an
unneccessary step. Just fold virtio_mem_legacy_guests_properties
into virtio_mem_properties.

In the realize() method, check virtio_mem_has_legacy_guests()
and reject values that are invalid for the non-x86 targets.


With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


