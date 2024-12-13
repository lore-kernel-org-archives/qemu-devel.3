Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 188CEE7717D
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 11:32:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tM3uK-0006zf-DV; Fri, 13 Dec 2024 06:32:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tM3uH-0006zL-T4
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 06:32:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tM3uF-0002jo-EI
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 06:32:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734089543;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Wbyp8pml41NOEYQD9+28SfEXWxcKawZ6aVQgXGjoCXE=;
 b=PlJUZDavqTOtZzuTvcrdYiYHiykMVBREJQ0m/qUCEBKxy3e8JLQmJkEXp8pRurFCFrH1hM
 AuMyXfecsYmIiQ+HDfBdObrZxJsWLAlG2jpcnivvLnS4CEAuzKsceUJTf/uv21EdvxKhbe
 X+WfDP1qwxOKihG2mWPJ5yztCZJDmgg=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-643-sN9u5jFLPj2QqsQ0BVR8Hg-1; Fri,
 13 Dec 2024 06:32:20 -0500
X-MC-Unique: sN9u5jFLPj2QqsQ0BVR8Hg-1
X-Mimecast-MFC-AGG-ID: sN9u5jFLPj2QqsQ0BVR8Hg
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6C0BC19560A3; Fri, 13 Dec 2024 11:32:18 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.42])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4995030044C1; Fri, 13 Dec 2024 11:32:12 +0000 (UTC)
Date: Fri, 13 Dec 2024 11:32:08 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Jiahui Cen <cenjiahui@huawei.com>, qemu-devel@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Bernhard Beschow <shentey@gmail.com>
Subject: Re: [PATCH 3/6] hw/pci: Have PCI_BUS implement
 TYPE_FW_CFG_DATA_GENERATOR_INTERFACE
Message-ID: <Z1wbODM1V5E7oCU6@redhat.com>
References: <20241206181352.6836-1-philmd@linaro.org>
 <20241206181352.6836-4-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241206181352.6836-4-philmd@linaro.org>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.496,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

On Fri, Dec 06, 2024 at 07:13:49PM +0100, Philippe Mathieu-Daudé wrote:
> The FW_CFG_DATA_GENERATOR allows any object to produce
                           ^
                          ^^^
                         ^^^^^  insert word 'interface'

> blob of data consumable by the fw_cfg device. Implement

 ^ 'a' as in 'a blob of...'

> that for PCI bus objects.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  hw/pci/pci.c | 37 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 37 insertions(+)
> 
> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> index 1416ae202c3..8844251eceb 100644
> --- a/hw/pci/pci.c
> +++ b/hw/pci/pci.c
> @@ -46,6 +46,7 @@
>  #include "hw/pci/msix.h"
>  #include "hw/hotplug.h"
>  #include "hw/boards.h"
> +#include "hw/nvram/fw_cfg.h"
>  #include "qapi/error.h"
>  #include "qemu/cutils.h"
>  #include "pci-internal.h"
> @@ -216,11 +217,41 @@ static uint16_t pcibus_numa_node(PCIBus *bus)
>      return NUMA_NODE_UNASSIGNED;
>  }
>  
> +static GByteArray *pci_bus_fw_cfg_gen_data(Object *obj, Error **errp)
> +{
> +    PCIBus *bus = PCI_BUS(obj);
> +    GByteArray *byte_array;
> +    uint64_t extra_hosts = 0;
> +
> +    if (!bus) {
> +        return NULL;
> +    }

Returning NULL without setting 'errp'.

On the one hand I could see returning NULL, without errp, as being
useful semantics for "I have no data to add currently". THe callers
don't appear to distinguish NULL without errp, from NULL with errp.
They just propagate a failure return code up the stack.

The API docs for 'get_data' method don't say you can return NULL
without setting errp either.

> +
> +    QLIST_FOREACH(bus, &bus->child, sibling) {
> +        /* look for expander root buses */
> +        if (pci_bus_is_root(bus)) {
> +            extra_hosts++;
> +        }
> +    }
> +
> +    if (!extra_hosts) {
> +        return NULL;

Same.

> +    }
> +    extra_hosts = cpu_to_le64(extra_hosts);
> +
> +    byte_array = g_byte_array_new();
> +    g_byte_array_append(byte_array,
> +                        (const void *)&extra_hosts, sizeof(extra_hosts));
> +
> +    return byte_array;
> +}
> +
>  static void pci_bus_class_init(ObjectClass *klass, void *data)
>  {
>      BusClass *k = BUS_CLASS(klass);
>      PCIBusClass *pbc = PCI_BUS_CLASS(klass);
>      ResettableClass *rc = RESETTABLE_CLASS(klass);
> +    FWCfgDataGeneratorClass *fwgc = FW_CFG_DATA_GENERATOR_CLASS(klass);
>  
>      k->print_dev = pcibus_dev_print;
>      k->get_dev_path = pcibus_get_dev_path;
> @@ -232,6 +263,8 @@ static void pci_bus_class_init(ObjectClass *klass, void *data)
>  
>      pbc->bus_num = pcibus_num;
>      pbc->numa_node = pcibus_numa_node;
> +
> +    fwgc->get_data = pci_bus_fw_cfg_gen_data;
>  }
>  
>  static const TypeInfo pci_bus_info = {
> @@ -240,6 +273,10 @@ static const TypeInfo pci_bus_info = {
>      .instance_size = sizeof(PCIBus),
>      .class_size = sizeof(PCIBusClass),
>      .class_init = pci_bus_class_init,
> +    .interfaces = (InterfaceInfo[]) {
> +        { TYPE_FW_CFG_DATA_GENERATOR_INTERFACE },
> +        { }
> +    }
>  };
>  
>  static const TypeInfo cxl_interface_info = {
> -- 
> 2.45.2
> 
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


