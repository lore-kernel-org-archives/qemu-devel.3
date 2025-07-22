Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B436C83F27
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Jul 2025 16:54:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ueGFY-0006nW-HC; Tue, 22 Jul 2025 12:53:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1ueFMQ-0007Ds-05
 for qemu-devel@nongnu.org; Tue, 22 Jul 2025 11:56:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1ueFMM-0005Vd-Dt
 for qemu-devel@nongnu.org; Tue, 22 Jul 2025 11:56:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753199811;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=P2ZX8rYyfkzuq33ganJciWG3dEO2cOON/gr5yI+UVgE=;
 b=b+xvu+lgy2DFLHnURu8x166bGIt5HiqIdEI4EDOKaYzVHL2rOJaDhb8ItUS3CIURhu8db1
 JVbjpIvC+useJe7Gk4D57vW0ZIk5BeXozEndkl8bzrqH2pEpKpgT5QHR1dEoE+42XcJ4Zj
 e3XF5SjELmfXnxJwPn7YHQfmDK0z/rQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-683-8eGFGXGOPkac_49TRSXhoA-1; Tue,
 22 Jul 2025 11:56:48 -0400
X-MC-Unique: 8eGFGXGOPkac_49TRSXhoA-1
X-Mimecast-MFC-AGG-ID: 8eGFGXGOPkac_49TRSXhoA_1753199806
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5AC4B1800291; Tue, 22 Jul 2025 15:56:46 +0000 (UTC)
Received: from redhat.com (dhcp-16-135.lcy.redhat.com [10.42.16.135])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6163618016F9; Tue, 22 Jul 2025 15:56:42 +0000 (UTC)
Date: Tue, 22 Jul 2025 16:56:39 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Zhuoying Cai <zycai@linux.ibm.com>
Cc: thuth@redhat.com, richard.henderson@linaro.org, david@redhat.com,
 pbonzini@redhat.com, jrossi@linux.ibm.com, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, walling@linux.ibm.com, jjherne@linux.ibm.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 farman@linux.ibm.com, mjrosato@linux.ibm.com, iii@linux.ibm.com
Subject: Re: [PATCH v4 01/28] Add boot-certificates to s390-ccw-virtio
 machine type option
Message-ID: <aH-0t47zgKpDOebt@redhat.com>
References: <20250711211105.439554-1-zycai@linux.ibm.com>
 <20250711211105.439554-2-zycai@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250711211105.439554-2-zycai@linux.ibm.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.633,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Fri, Jul 11, 2025 at 05:10:37PM -0400, Zhuoying Cai wrote:
> Add boot-certificates as a parameter of s390-ccw-virtio machine type option.
> 
> The `boot-certificates=/path/dir:/path/file` parameter is implemented
> to provide path to either a directory or a single certificate.
> 
> Multiple paths can be delineated using a colon.
> 
> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
> ---
>  hw/s390x/s390-virtio-ccw.c         | 22 ++++++++++++++++++++++
>  include/hw/s390x/s390-virtio-ccw.h |  1 +
>  qemu-options.hx                    |  7 ++++++-
>  3 files changed, 29 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
> index c294106a74..167876295e 100644
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
> index 1f862b19a6..d42e6f502c 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -43,7 +43,8 @@ DEF("machine", HAS_ARG, QEMU_OPTION_machine, \
>  #endif
>      "                memory-backend='backend-id' specifies explicitly provided backend for main RAM (default=none)\n"
>      "                cxl-fmw.0.targets.0=firsttarget,cxl-fmw.0.targets.1=secondtarget,cxl-fmw.0.size=size[,cxl-fmw.0.interleave-granularity=granularity]\n"
> -    "                smp-cache.0.cache=cachename,smp-cache.0.topology=topologylevel\n",
> +    "                smp-cache.0.cache=cachename,smp-cache.0.topology=topologylevel\n"
> +    "                boot-certificates='/path/directory:/path/file' provide a path to a directory or a boot certificate\n",

I forgot to respond to your previous question about how to do
arrays for this. The command line exmaples here for cxl-fmw
and smp-cache conveniently illustrate the syntax.

It would be something like this on the CLI:

  boot-certs.0.path=/path/to/dir,boot-certs.1.path=/to/other/dir,boot-certs.2.path=/some/...



With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


