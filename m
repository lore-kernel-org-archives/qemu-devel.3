Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08C21C3ABC0
	for <qemu-devel@archiver.kernel.org>; Thu,  8 May 2025 15:55:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uD3ao-0008Cc-2w; Thu, 08 May 2025 11:55:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uD3am-0007yX-4Z
 for qemu-devel@nongnu.org; Thu, 08 May 2025 11:55:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uD3aj-0005MY-QA
 for qemu-devel@nongnu.org; Thu, 08 May 2025 11:55:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746719721;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w3d91AHD4clB0RQ00C0mx2TAXwRVJvVkELCY+u8Jl1U=;
 b=PTipAO/7nz/iLuE1IxBYnrGCvaFmILcMvctw5iKWV5tsAgjvioDphGwmhIOy3MY1wo6wRP
 bLeUT3M3rNlKvfwOnIse9AZxc25b3zLHTLAVxnqRTbrlN2r1a1989y7un792Mm6u/ltZs+
 wYVqB+bB/ZFQ1479S0BDIfOsYrUZiy8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-19-uYY0jpVhPvq486ytN91hIg-1; Thu,
 08 May 2025 11:55:19 -0400
X-MC-Unique: uYY0jpVhPvq486ytN91hIg-1
X-Mimecast-MFC-AGG-ID: uYY0jpVhPvq486ytN91hIg_1746719718
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1275D1800446; Thu,  8 May 2025 15:55:17 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.138])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D95E918003FD; Thu,  8 May 2025 15:55:12 +0000 (UTC)
Date: Thu, 8 May 2025 16:55:09 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Francesco Lavra <francescolavra.fl@gmail.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, kvm@vger.kernel.org,
 qemu-devel@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>
Subject: Re: [PATCH v9 13/55] i386/tdx: Support user configurable
 mrconfigid/mrowner/mrownerconfig
Message-ID: <aBzT3TrdldaN-uqx@redhat.com>
References: <20250508150002.689633-1-xiaoyao.li@intel.com>
 <20250508150002.689633-14-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250508150002.689633-14-xiaoyao.li@intel.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.416,
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

On Thu, May 08, 2025 at 10:59:19AM -0400, Xiaoyao Li wrote:
> From: Isaku Yamahata <isaku.yamahata@intel.com>
> 
> Three sha384 hash values, mrconfigid, mrowner and mrownerconfig, of a TD
> can be provided for TDX attestation. Detailed meaning of them can be
> found: https://lore.kernel.org/qemu-devel/31d6dbc1-f453-4cef-ab08-4813f4e0ff92@intel.com/
> 
> Allow user to specify those values via property mrconfigid, mrowner and
> mrownerconfig. They are all in base64 format.
> 
> example
> -object tdx-guest, \
>   mrconfigid=ASNFZ4mrze8BI0VniavN7wEjRWeJq83vASNFZ4mrze8BI0VniavN7wEjRWeJq83v,\
>   mrowner=ASNFZ4mrze8BI0VniavN7wEjRWeJq83vASNFZ4mrze8BI0VniavN7wEjRWeJq83v,\
>   mrownerconfig=ASNFZ4mrze8BI0VniavN7wEjRWeJq83vASNFZ4mrze8BI0VniavN7wEjRWeJq83v
> 
> Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
> Co-developed-by: Xiaoyao Li <xiaoyao.li@intel.com>
> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> Acked-by: Markus Armbruster <armbru@redhat.com>
> Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
> ---
> Changes in v9:
>  - return -1 directly when qbase64_decode() return NULL; (Daniel)
> 
> Changes in v8:
>  - it gets squashed into previous patch in v7. So split it out in v8;
> 
> Changes in v6:
>  - refine the doc comment of QAPI properties;
> 
> Changes in v5:
>  - refine the description of QAPI properties and add description of
>    default value when not specified;
> 
> Changes in v4:
>  - describe more of there fields in qom.json
>  - free the old value before set new value to avoid memory leak in
>    _setter(); (Daniel)
> 
> Changes in v3:
>  - use base64 encoding instread of hex-string;
> ---
>  qapi/qom.json         | 16 +++++++-
>  target/i386/kvm/tdx.c | 95 +++++++++++++++++++++++++++++++++++++++++++
>  target/i386/kvm/tdx.h |  3 ++
>  3 files changed, 113 insertions(+), 1 deletion(-)
> 
> diff --git a/qapi/qom.json b/qapi/qom.json
> index f229bb07aaec..a8379bac1719 100644
> --- a/qapi/qom.json
> +++ b/qapi/qom.json
> @@ -1060,11 +1060,25 @@
>  #     pages.  Some guest OS (e.g., Linux TD guest) may require this to
>  #     be set, otherwise they refuse to boot.
>  #
> +# @mrconfigid: ID for non-owner-defined configuration of the guest TD,
> +#     e.g., run-time or OS configuration (base64 encoded SHA384 digest).
> +#     Defaults to all zeros.
> +#
> +# @mrowner: ID for the guest TD’s owner (base64 encoded SHA384 digest).
> +#     Defaults to all zeros.
> +#
> +# @mrownerconfig: ID for owner-defined configuration of the guest TD,
> +#     e.g., specific to the workload rather than the run-time or OS
> +#     (base64 encoded SHA384 digest).  Defaults to all zeros.
> +#
>  # Since: 10.1
>  ##
>  { 'struct': 'TdxGuestProperties',
>    'data': { '*attributes': 'uint64',
> -            '*sept-ve-disable': 'bool' } }
> +            '*sept-ve-disable': 'bool',
> +            '*mrconfigid': 'str',
> +            '*mrowner': 'str',
> +            '*mrownerconfig': 'str' } }
>  
>  ##
>  # @ThreadContextProperties:
> diff --git a/target/i386/kvm/tdx.c b/target/i386/kvm/tdx.c
> index 3de3b5fa6a49..39fd964c6b27 100644
> --- a/target/i386/kvm/tdx.c
> +++ b/target/i386/kvm/tdx.c
> @@ -11,8 +11,10 @@
>  
>  #include "qemu/osdep.h"
>  #include "qemu/error-report.h"
> +#include "qemu/base64.h"
>  #include "qapi/error.h"
>  #include "qom/object_interfaces.h"
> +#include "crypto/hash.h"
>  
>  #include "hw/i386/x86.h"
>  #include "kvm_i386.h"
> @@ -240,6 +242,7 @@ int tdx_pre_create_vcpu(CPUState *cpu, Error **errp)
>      CPUX86State *env = &x86cpu->env;
>      g_autofree struct kvm_tdx_init_vm *init_vm = NULL;
>      Error *local_err = NULL;
> +    size_t data_len;
>      int retry = 10000;
>      int r = 0;
>  
> @@ -251,6 +254,45 @@ int tdx_pre_create_vcpu(CPUState *cpu, Error **errp)
>      init_vm = g_malloc0(sizeof(struct kvm_tdx_init_vm) +
>                          sizeof(struct kvm_cpuid_entry2) * KVM_MAX_CPUID_ENTRIES);
>  
> +    if (tdx_guest->mrconfigid) {
> +        g_autofree uint8_t *data = qbase64_decode(tdx_guest->mrconfigid,
> +                              strlen(tdx_guest->mrconfigid), &data_len, errp);
> +        if (!data) {
> +            return -1;
> +        }
> +        if (data_len != QCRYPTO_HASH_DIGEST_LEN_SHA384) {
> +            error_setg(errp, "TDX: failed to decode mrconfigid");

As a general guideline I'd always suggest including both the received
and expected values, when reporting an length check failure. Also
the error message is misleading - we successfully decoded the data,
the decoded data was simply the wrong length.

eg

            error_setg(errp, "TDX mrconfigid sha386 digest was %d bytes, expected %d bytes")
	               data_len, QCRYPTO_HASH_DIGEST_LEN_SHA384);


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


