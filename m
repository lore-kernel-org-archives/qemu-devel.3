Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1737606A32F
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2026 11:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ZmdoW3/1
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOvhL-0007IL-4N; Thu, 05 Nov 2026 06:32:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xOvh8-0007GL-FX
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 06:31:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xOvh4-0004Xo-M2
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 06:31:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793878305;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=lb+MP0tYCb6NiSIuDgsCmStDOk6/2V8tFXdJ0ci7ea0=;
 b=ZmdoW3/1qtgVl5gm3GscilGFU8XXU/1ChbIzRfw0M3G++bTcNAbrDt4z3du4Ao4R2emU0A
 Q53z3Dd9DJcmdglELlTvcuHEoFkWk2udncevHbYHI0d+oBrXreInyQTUGV20XGi6bopRA7
 2QEcC8cAOtpwYDhFrLrQF6lcgTsMuRU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-350-4lHWUmw8OSqx341xRZ91EQ-1; Thu,
 05 Nov 2026 06:31:42 -0500
X-MC-Unique: 4lHWUmw8OSqx341xRZ91EQ-1
X-Mimecast-MFC-AGG-ID: 4lHWUmw8OSqx341xRZ91EQ_1793878300
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5CAB61955F1E; Thu,  5 Nov 2026 11:31:39 +0000 (UTC)
Received: from redhat.com (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D586218004FC; Thu,  5 Nov 2026 11:31:35 +0000 (UTC)
Date: Thu, 5 Nov 2026 11:31:32 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Yonggang Luo <luoyonggang@gmail.com>
Cc: qemu-devel@nongnu.org, David Hildenbrand <david@kernel.org>,
 Philippe Mathieu-Daude <philmd@mailo.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Cornelia Huck <cohuck@redhat.com>, Fam Zheng <fam@euphon.net>,
 qemu-s390x@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Eric Farman <farman@linux.ibm.com>
Subject: Re: [PATCH 1/3] hw/pci: Avoid guard loadparm with target_s390x() for
 s390x in class_init
Message-ID: <auxpFIkPTLAyvzz9@redhat.com>
References: <20261013200525.1340-1-luoyonggang@gmail.com>
 <20261013200525.1340-2-luoyonggang@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261013200525.1340-2-luoyonggang@gmail.com>
User-Agent: Mutt/2.4.3 (2026-10-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Oct 14, 2026 at 04:05:22AM +0800, Yonggang Luo wrote:
> This is for avoid call target_info() in class_init.
> Now we directly guard in pci_qdev_property_set_loadparm instead.
> Don't know if its an API break, but the smallest change.

Suggest to reword this as follows:

 With the multi-target work, the goal is to move to a single
 unified QOM tree that applies universally across all targets.
 This complements the migration away from instance level
 properties to class level properties, which again aims to
 ensure a fixed QOM object model for each class.

 This requires that properties are either unconditionally
 registered in the class, with invalid options rejected
 at runtime (for example, during realize()), or that distinct
 subclasses are used for specialized use cases that need a
 distinct impl for some targets.

 It is harmless to have the 'loadparm' property registered
 unconditionally so take the simple option.

The same can apply to the other patches

> 
> Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> ---
>  hw/pci/pci.c | 18 ++++++++++--------
>  1 file changed, 10 insertions(+), 8 deletions(-)

> 
> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> index 0efb4eb4bb0..9d3dcd52942 100644
> --- a/hw/pci/pci.c
> +++ b/hw/pci/pci.c
> @@ -2878,6 +2878,11 @@ static void pci_qdev_property_set_loadparm(Object *obj, const char *value,
>  {
>      void *lp_str;
>  
> +    if (!target_s390x()) {
> +        error_setg(errp, "'loadparm' is only supported on s390x");
> +        return;
> +    }
> +
>      if (object_property_get_int(obj, "bootindex", NULL) < 0) {
>          error_setg(errp, "'loadparm' is only valid for boot devices");
>          return;
> @@ -2895,14 +2900,11 @@ void pci_qdev_property_add_specifics(DeviceClass *dc)
>  {
>      ObjectClass *oc = OBJECT_CLASS(dc);
>  
> -    /* The loadparm property is only supported on s390x */
> -    if (target_s390x()) {
> -        object_class_property_add_str(oc, "loadparm",
> -                                      pci_qdev_property_get_loadparm,
> -                                      pci_qdev_property_set_loadparm);
> -        object_class_property_set_description(oc, "loadparm",
> -                                              "load parameter (s390x only)");
> -    }
> +    object_class_property_add_str(oc, "loadparm",
> +                                  pci_qdev_property_get_loadparm,
> +                                  pci_qdev_property_set_loadparm);
> +    object_class_property_set_description(oc, "loadparm",
> +                                          "load parameter (s390x only)");
>  }
>  
>  MemoryRegion *pci_address_space(PCIDevice *dev)
> -- 
> 2.55.0.windows.3
> 
> 

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


