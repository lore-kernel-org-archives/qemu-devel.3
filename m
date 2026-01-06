Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D92BEC47BEA
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Jan 2026 11:22:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vd58s-0001l5-J9; Tue, 06 Jan 2026 06:22:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vd58j-0001k1-3v
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 06:22:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vd58g-0007UW-C1
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 06:22:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767698533;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=SO2gaarkPhvYTN8ofdsxA/9VmNgtd0v3O3fIEwCd9vE=;
 b=UsDSFoxj7v8urOZBacRhhP+M/HLZoiId7oT5sVBOqeDdFTpoOQbWi93DLq9VUfVJ5xpnvO
 UDYcFFoAwURSfRMbCv1D+ZgWZK+0d5hD5XjhbZ6lD4H94lyKWDsa19cywKgJbA3/MpESGy
 zxQx9IQQNiXzC517kx9F2MnkwjY4v9E=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-13-f-B61mhIMA-N1ztse98c9g-1; Tue,
 06 Jan 2026 06:22:12 -0500
X-MC-Unique: f-B61mhIMA-N1ztse98c9g-1
X-Mimecast-MFC-AGG-ID: f-B61mhIMA-N1ztse98c9g_1767698530
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D224819560B6; Tue,  6 Jan 2026 11:22:10 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.217])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 39F091800667; Tue,  6 Jan 2026 11:22:09 +0000 (UTC)
Date: Tue, 6 Jan 2026 11:22:05 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Zhao Liu <zhao1.liu@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 Xudong Hao <xudong.hao@intel.com>, Yu Chen <yu.c.chen@intel.com>
Subject: Re: [PATCH 10/10] dosc/cpu-models-x86: Add documentation for
 DiamondRapids
Message-ID: <aVzwXfbHVUpx1FQx@redhat.com>
References: <20251120071030.961230-1-zhao1.liu@intel.com>
 <20251120071030.961230-11-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251120071030.961230-11-zhao1.liu@intel.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

In $SUBJECT   s/dosc/docs/

On Thu, Nov 20, 2025 at 03:10:30PM +0800, Zhao Liu wrote:
> Current DiamondRapids hasn't supported cache model. Instead, document
> its special CPU & cache topology to allow user emulate with "-smp" &
> "-machine smp-cache".
> 
> Cc: Yu Chen <yu.c.chen@intel.com>
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> ---
>  docs/system/cpu-models-x86.rst.inc | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/docs/system/cpu-models-x86.rst.inc b/docs/system/cpu-models-x86.rst.inc
> index 6a770ca8351c..c4c8fc67a562 100644
> --- a/docs/system/cpu-models-x86.rst.inc
> +++ b/docs/system/cpu-models-x86.rst.inc
> @@ -71,6 +71,26 @@ mixture of host CPU models between machines, if live migration
>  compatibility is required, use the newest CPU model that is compatible
>  across all desired hosts.
>  
> +``DiamondRapids``
> +    Intel Xeon Processor.
> +
> +    Diamond Rapids product has a topology which differs from previous Xeon
> +    products. It does not support SMT, but instead features a dual core
> +    module (DCM) architecture. It also has core building blocks (CBB - die
> +    level in CPU topology). The cache hierarchy is organized as follows:
> +    L1 i/d cache is per thread, L2 cache is per DCM, and L3 cache is per
> +    CBB. This cache topology can be emulated for DiamondRapids CPU model
> +    using the smp-cache configuration as shown below:
> +
> +    Example:
> +
> +        ::
> +
> +            -machine smp-cache.0.cache=l1d,smp-cache.0.topology=thread,\
> +                     smp-cache.1.cache=l1i,smp-cache.1.topology=thread,\
> +                     smp-cache.2.cache=l2,smp-cache.2.topology=module,\
> +                     smp-cache.3.cache=l3,smp-cache.3.topology=die\
> +
>  ``ClearwaterForest``
>      Intel Xeon Processor (ClearwaterForest, 2025)
>  
> -- 
> 2.34.1
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


