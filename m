Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2A7BC3DA6D
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 12:02:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHLfs-0004w0-6q; Tue, 20 May 2025 08:02:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uHLfp-0004u9-TJ
 for qemu-devel@nongnu.org; Tue, 20 May 2025 08:02:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uHLfn-0006wT-G4
 for qemu-devel@nongnu.org; Tue, 20 May 2025 08:02:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747742537;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=exPkeRuTH0m/aTI9Vl7+XEFElqtVLulKLeIDwA5xPJ4=;
 b=AQKPwi9jMGyBM0FNVfSubF+sj/CtPI3R2DdqYLkZgkrQq9KgyIpdVCN97nM0yg+1gUmlPF
 OPkKwcePY1TjVzLzgyjtpKD+cZPVV3RgGeTHT5Iv8ATkny6CYQU6v+0nOL2bYp8+FDTNVd
 7qZydl1N0h0wO20OsJYd+nuI4SGL3k4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-397-Q9yqDxalOpKi9I4raq9Hjg-1; Tue,
 20 May 2025 08:02:12 -0400
X-MC-Unique: Q9yqDxalOpKi9I4raq9Hjg-1
X-Mimecast-MFC-AGG-ID: Q9yqDxalOpKi9I4raq9Hjg_1747742530
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BDCF71800370; Tue, 20 May 2025 12:02:09 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.49])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B600130001AA; Tue, 20 May 2025 12:02:04 +0000 (UTC)
Date: Tue, 20 May 2025 13:02:01 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Magnus Kulke <magnuskulke@linux.microsoft.com>
Cc: magnuskulke@microsoft.com, qemu-devel@nongnu.org, liuwe@microsoft.com,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Wei Liu <wei.liu@kernel.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Cameron Esfahani <dirty@apple.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Subject: Re: [RFC PATCH 06/25] accel/mshv: Add accelerator skeleton
Message-ID: <aCxvOfF3ytXYnhp1@redhat.com>
References: <20250520113018.49569-1-magnuskulke@linux.microsoft.com>
 <20250520113018.49569-7-magnuskulke@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250520113018.49569-7-magnuskulke@linux.microsoft.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.487,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, May 20, 2025 at 01:29:59PM +0200, Magnus Kulke wrote:
> Introduce the initial scaffold for the MSHV (Microsoft Hypervisor)
> accelerator backend. This includes the basic directory structure and
> stub implementations needed to integrate with QEMU's accelerator
> framework.
> 
> Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
> ---
>  accel/meson.build      |   1 +
>  accel/mshv/meson.build |   6 ++
>  accel/mshv/mshv-all.c  | 143 +++++++++++++++++++++++++++++++++++++++++
>  include/system/mshv.h  |  34 ++++++++++
>  4 files changed, 184 insertions(+)
>  create mode 100644 accel/mshv/meson.build
>  create mode 100644 accel/mshv/mshv-all.c
> 

> diff --git a/accel/mshv/mshv-all.c b/accel/mshv/mshv-all.c
> new file mode 100644
> index 0000000000..44605adf94
> --- /dev/null
> +++ b/accel/mshv/mshv-all.c

> +
> +static int mshv_init(MachineState *ms)
> +{
> +	error_report("unimplemented");
> +	abort();
> +}

Nit-picking - although you remove these lines in later patches,
lets remove the tabs from these lines.

> diff --git a/include/system/mshv.h b/include/system/mshv.h
> index bc8f2c228a..0858e47def 100644
> --- a/include/system/mshv.h
> +++ b/include/system/mshv.h
> @@ -16,6 +16,14 @@
>  #ifndef QEMU_MSHV_INT_H
>  #define QEMU_MSHV_INT_H
>  
> +#include "qemu/osdep.h"
> +#include "qemu/accel.h"
> +#include "hw/hyperv/hyperv-proto.h"
> +#include "hw/hyperv/linux-mshv.h"
> +#include "hw/hyperv/hvhdk.h"
> +#include "qapi/qapi-types-common.h"
> +#include "system/memory.h"
> +
>  #ifdef COMPILING_PER_TARGET
>  #ifdef CONFIG_MSHV
>  #define CONFIG_MSHV_IS_POSSIBLE
> @@ -28,6 +36,32 @@
>  #ifdef CONFIG_MSHV_IS_POSSIBLE
>  extern bool mshv_allowed;
>  #define mshv_enabled() (mshv_allowed)
> +
> +typedef struct MshvMemoryListener {
> +  MemoryListener listener;
> +  int as_id;
> +} MshvMemoryListener;
> +
> +typedef struct MshvAddressSpace {
> +    MshvMemoryListener *ml;
> +    AddressSpace *as;
> +} MshvAddressSpace;

Inconsistent mix of 2-space and 4-space
indents - stick with 4-space throughout

> +
> +typedef struct MshvState {
> +  AccelState parent_obj;
> +  int vm;
> +  MshvMemoryListener memory_listener;
> +  /* number of listeners */
> +  int nr_as;
> +  MshvAddressSpace *as;
> +} MshvState;
> +extern MshvState *mshv_state;
> +
> +struct AccelCPUState {
> +  int cpufd;
> +  bool dirty;
> +};
> +
>  #else /* CONFIG_MSHV_IS_POSSIBLE */
>  #define mshv_enabled() false
>  #endif
> -- 
> 2.34.1
> 
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


