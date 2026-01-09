Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 332C8D26D6B
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 15:58:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1veEsk-0004ST-QC; Fri, 09 Jan 2026 10:58:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1veEsh-0004QU-Vc
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 10:58:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1veEsf-00061Q-JE
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 10:58:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767974307;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ebq5eOcYODOnA3Tdbk039zvtLhwNGEzw910sYbcx4E8=;
 b=HC33k4jU3RG6r28U3KZR80mLutW8pFJ6B0XR08LqRz2c0Qd4FkZ1wG1xGoLPJM2jC6nXVB
 oawoGPT59pgaUr4qBebhYl7uG4T+wJNS9yP1RrpFw2wXFx5+3Z6YgVckWlmNNMk8G6kJ+/
 DseZ6cWLtRChM/s4KvGOSRm9606rBtw=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-108-FViR_5TTPRaEoHCqsaZm5A-1; Fri,
 09 Jan 2026 10:58:24 -0500
X-MC-Unique: FViR_5TTPRaEoHCqsaZm5A-1
X-Mimecast-MFC-AGG-ID: FViR_5TTPRaEoHCqsaZm5A_1767974303
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6C132180044D; Fri,  9 Jan 2026 15:58:22 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.39])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6A8C31955F67; Fri,  9 Jan 2026 15:58:18 +0000 (UTC)
Date: Fri, 9 Jan 2026 15:58:15 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 4/8] hw/pci-host/q35: Remove Q35PCIHost::pci_hole64_fix
 field
Message-ID: <aWEll_ENkNVVBbWy@redhat.com>
References: <20250501223522.99772-1-philmd@linaro.org>
 <20250501223522.99772-5-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250501223522.99772-5-philmd@linaro.org>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This patch did not get merged so far, so in case it is resurrected
I wanted to warn that even though we're going to be removing machine
types that use it, we might want to keep the property.

In this issue

  https://gitlab.com/qemu-project/qemu/-/issues/1947#note_2994552211

being able to disable the pci_hole64_fix is indicated as a possible
fix for a Windows XP  BSOD.

Perhaps there is a better way to avoid the root cause of the BSOD,
but if not this knob would be useful to retain.


On Fri, May 02, 2025 at 12:35:18AM +0200, Philippe Mathieu-Daudé wrote:
> The Q35PCIHost::pci_hole64_fix boolean was only set in
> the pc_compat_2_10[] array, via the 'x-pci-hole64-fix=off'
> property. We removed all machines using that array, lets
> remove that property and all the code around it.



> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  include/hw/pci-host/q35.h | 1 -
>  hw/pci-host/q35.c         | 6 ++----
>  2 files changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/include/hw/pci-host/q35.h b/include/hw/pci-host/q35.h
> index ddafc3f2e3d..75810528205 100644
> --- a/include/hw/pci-host/q35.h
> +++ b/include/hw/pci-host/q35.h
> @@ -63,7 +63,6 @@ struct Q35PCIHost {
>      PCIExpressHost parent_obj;
>      /*< public >*/
>  
> -    bool pci_hole64_fix;
>      MCHPCIState mch;
>  };
>  
> diff --git a/hw/pci-host/q35.c b/hw/pci-host/q35.c
> index 1951ae440cc..f6e29cc4fc8 100644
> --- a/hw/pci-host/q35.c
> +++ b/hw/pci-host/q35.c
> @@ -116,13 +116,12 @@ static void q35_host_get_pci_hole_end(Object *obj, Visitor *v,
>  static uint64_t q35_host_get_pci_hole64_start_value(Object *obj)
>  {
>      PCIHostState *h = PCI_HOST_BRIDGE(obj);
> -    Q35PCIHost *s = Q35_HOST_DEVICE(obj);
>      Range w64;
>      uint64_t value;
>  
>      pci_bus_get_w64_range(h->bus, &w64);
>      value = range_is_empty(&w64) ? 0 : range_lob(&w64);
> -    if (!value && s->pci_hole64_fix) {
> +    if (!value) {
>          value = pc_pci_hole64_start();
>      }
>      return value;
> @@ -156,7 +155,7 @@ static void q35_host_get_pci_hole64_end(Object *obj, Visitor *v,
>      pci_bus_get_w64_range(h->bus, &w64);
>      value = range_is_empty(&w64) ? 0 : range_upb(&w64) + 1;
>      hole64_end = ROUND_UP(hole64_start + s->mch.pci_hole64_size, 1ULL << 30);
> -    if (s->pci_hole64_fix && value < hole64_end) {
> +    if (value < hole64_end) {
>          value = hole64_end;
>      }
>      visit_type_uint64(v, name, &value, errp);
> @@ -181,7 +180,6 @@ static const Property q35_host_props[] = {
>                       mch.above_4g_mem_size, 0),
>      DEFINE_PROP_BOOL(PCI_HOST_PROP_SMM_RANGES, Q35PCIHost,
>                       mch.has_smm_ranges, true),
> -    DEFINE_PROP_BOOL("x-pci-hole64-fix", Q35PCIHost, pci_hole64_fix, true),
>  };
>  
>  static void q35_host_class_init(ObjectClass *klass, const void *data)
> -- 
> 2.47.1
> 
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


