Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C287C5B555
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Jun 2025 14:00:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNXcf-00085u-5t; Fri, 06 Jun 2025 10:00:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uNXcX-00082P-BE
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 10:00:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uNXcU-0007SW-8s
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 10:00:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749218427;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=1DOWjtFGNOiNd39ETu+hWPfpxH3ng1XZNtIFFOYp18s=;
 b=V6dt1WGghre14x+DtKMbysi6Ms4C3X6bOOBq3h8AFberwXlLp6BuUO8iAYTV0YhLZIZtSZ
 Lu1hOFwsTYkD00dES08uHbRv9D1L3NtpQGl9/wu2kOjUe1gJg3YdT2CQE/DZv+wVJBoW1d
 91a3V9Hs0MHQW1jEYXwbrb9ngkhHrtk=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-54-j_1oI6qIMK-lW7USqtjrBA-1; Fri,
 06 Jun 2025 10:00:24 -0400
X-MC-Unique: j_1oI6qIMK-lW7USqtjrBA-1
X-Mimecast-MFC-AGG-ID: j_1oI6qIMK-lW7USqtjrBA_1749218422
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9F96B1800A00; Fri,  6 Jun 2025 14:00:22 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.55])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1816018003FC; Fri,  6 Jun 2025 14:00:16 +0000 (UTC)
Date: Fri, 6 Jun 2025 15:00:13 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Zhuoying Cai <zycai@linux.ibm.com>
Cc: thuth@redhat.com, richard.henderson@linaro.org, david@redhat.com,
 pbonzini@redhat.com, walling@linux.ibm.com, jjherne@linux.ibm.com,
 jrossi@linux.ibm.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, farman@linux.ibm.com, iii@linux.ibm.com,
 eblake@redhat.com, armbru@redhat.com, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
Subject: Re: [PATCH v3 01/28] Add boot-certificates to s390-ccw-virtio
 machine type option
Message-ID: <aEL0bVhOFaCQbiBS@redhat.com>
References: <20250604215657.528142-1-zycai@linux.ibm.com>
 <20250604215657.528142-2-zycai@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250604215657.528142-2-zycai@linux.ibm.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.104,
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

On Wed, Jun 04, 2025 at 05:56:29PM -0400, Zhuoying Cai wrote:
> Add boot-certificates as a parameter of s390-ccw-virtio machine type option.
> 
> The `boot-certificates=/path/dir:/path/file` parameter is implemented
> to provide path to either a directory or a single certificate.
> 
> Multiple paths can be delineated using a colon.

How do users specify paths which contain a colon as a valid
character ?

Ideally we should be using array properties when we need
a list of parameters.

> 
> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
> ---
>  hw/s390x/s390-virtio-ccw.c         | 22 ++++++++++++++++++++++
>  include/hw/s390x/s390-virtio-ccw.h |  1 +
>  qemu-options.hx                    |  7 ++++++-
>  3 files changed, 29 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
> index f20e02de9f..144ef52f34 100644
> --- a/hw/s390x/s390-virtio-ccw.c
> +++ b/hw/s390x/s390-virtio-ccw.c
> @@ -798,6 +798,22 @@ static void machine_set_loadparm(Object *obj, Visitor *v,
>      g_free(val);
>  }
>  
> +static inline char *machine_get_boot_certificates(Object *obj, Error **errp)
> +{
> +    S390CcwMachineState *ms = S390_CCW_MACHINE(obj);
> +
> +    return g_strdup(ms->boot_certificates);
> +}
> +
> +static void machine_set_boot_certificates(Object *obj, const char *str,
> +                                          Error **errp)
> +{
> +    S390CcwMachineState *ms = S390_CCW_MACHINE(obj);
> +
> +    g_free(ms->boot_certificates);
> +    ms->boot_certificates = g_strdup(str);
> +}
> +
>  static void ccw_machine_class_init(ObjectClass *oc, const void *data)
>  {
>      MachineClass *mc = MACHINE_CLASS(oc);
> @@ -851,6 +867,12 @@ static void ccw_machine_class_init(ObjectClass *oc, const void *data)
>              "Up to 8 chars in set of [A-Za-z0-9. ] (lower case chars converted"
>              " to upper case) to pass to machine loader, boot manager,"
>              " and guest kernel");
> +
> +    object_class_property_add_str(oc, "boot-certificates",
> +                                  machine_get_boot_certificates,
> +                                  machine_set_boot_certificates);
> +    object_class_property_set_description(oc, "boot-certificates",
> +            "provide path to a directory or a single certificate for secure boot");
>  }
>  
>  static inline void s390_machine_initfn(Object *obj)
> diff --git a/include/hw/s390x/s390-virtio-ccw.h b/include/hw/s390x/s390-virtio-ccw.h
> index 526078a4e2..45adc8bce6 100644
> --- a/include/hw/s390x/s390-virtio-ccw.h
> +++ b/include/hw/s390x/s390-virtio-ccw.h
> @@ -31,6 +31,7 @@ struct S390CcwMachineState {
>      uint8_t loadparm[8];
>      uint64_t memory_limit;
>      uint64_t max_pagesize;
> +    char *boot_certificates;
>  
>      SCLPDevice *sclp;
>  };
> diff --git a/qemu-options.hx b/qemu-options.hx
> index 7eb8e02b4b..6d01f8c4b2 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -43,7 +43,8 @@ DEF("machine", HAS_ARG, QEMU_OPTION_machine, \
>  #endif
>      "                memory-backend='backend-id' specifies explicitly provided backend for main RAM (default=none)\n"
>      "                cxl-fmw.0.targets.0=firsttarget,cxl-fmw.0.targets.1=secondtarget,cxl-fmw.0.size=size[,cxl-fmw.0.interleave-granularity=granularity]\n"
> -    "                smp-cache.0.cache=cachename,smp-cache.0.topology=topologylevel\n",
> +    "                smp-cache.0.cache=cachename,smp-cache.0.topology=topologylevel\n"
> +    "                boot-certificates='/path/directory:/path/file' provide a path to a directory or a boot certificate\n",
>      QEMU_ARCH_ALL)
>  SRST
>  ``-machine [type=]name[,prop=value[,...]]``
> @@ -200,6 +201,10 @@ SRST
>          ::
>  
>              -machine smp-cache.0.cache=l1d,smp-cache.0.topology=core,smp-cache.1.cache=l1i,smp-cache.1.topology=core
> +
> +    ``boot-certificates='/path/directory:/path/file'``
> +        Provide a path to a directory or a boot certificate on the host [s390x only].
> +        A colon may be used to delineate multiple paths.
>  ERST
>  
>  DEF("M", HAS_ARG, QEMU_OPTION_M,
> -- 
> 2.49.0
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


