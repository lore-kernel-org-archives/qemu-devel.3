Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3833C28B2E
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 08:30:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trYVg-0006oc-OP; Mon, 10 Mar 2025 04:29:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1trYVd-0006nd-3u
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 04:29:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1trYVX-0005zz-N2
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 04:29:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741595346;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oVjbBJxeizQKwyH9IYKCuRHaFa6Vx3kvMheG1OPh2D4=;
 b=BXDdD3WP+JJPyeahz6tbwvhdC+I5H1dTlOrQiUMF8XL6Dt1vEG7cY0WQnVibZkvNp+2mUp
 28k9NqLk69ojiFkkxneDRfCmU8CNeJTnaxBwk9q4OlBLQAVRc7cEzYRx1JJhDtelebIDX3
 /mq1A/4W0PoagOxeonS9ns8IR+j+oJ4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-121-sZhbqclgOM6kFRVzYvjuCg-1; Mon, 10 Mar 2025 04:29:02 -0400
X-MC-Unique: sZhbqclgOM6kFRVzYvjuCg-1
X-Mimecast-MFC-AGG-ID: sZhbqclgOM6kFRVzYvjuCg_1741595341
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3913037ac4eso2067978f8f.2
 for <qemu-devel@nongnu.org>; Mon, 10 Mar 2025 01:29:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741595341; x=1742200141;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oVjbBJxeizQKwyH9IYKCuRHaFa6Vx3kvMheG1OPh2D4=;
 b=jU8gaXyBon8iRpJEL7tmd6vY0amqKcdeG379HxYzBszA56sM53BSmW5gtWZlr/77bU
 12A/awvJcLN8W69LD5gr9TmWpodr0XrMscr8TOiWDGq9jj9SHgjiU+YBPwMaJ0K188GU
 yroQQRzZLsb7kTLQ9xzpjoz2kooHfJXuFOzwRTAbs5JWxrHEKULYQjMsMnGvWAzn6GsK
 LSSjNpAmQ+gXvP/H2JvSREzlP3m8dpcOBxqI4ggOxOu4J2y99htLCp+Pmh36vVIhyZzW
 LhlTBL4yxaGFOPuUDX2Edn9V/Wh2ikc7vtx/KfOoHAjJ7lWwPRxJdLajiqzO/vvewNha
 OILA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVn0OtagtHZ1VCIbc6ojx7OI0bkjqUy+va9DvPcKA5mDsIzLzSRJf3MMTws8xay0dj3XC97ige/HnnI@nongnu.org
X-Gm-Message-State: AOJu0Yz87/khptjGIQdalmipKjXCxbycrs+5MQzc0B/FrrIDnyMVepqT
 JvuZzy+L4v88Uh+RxqsWt1zVTN86vMNvB816Oj2ZObsJRLluaDPeVr6ZKfnR0NnBHhpxDnIKdTp
 /Z3KN6E4prHiZxlR/mHVT3npIIOiei+uIOUelhZnT6YDtJoWkeiC+
X-Gm-Gg: ASbGncucUc8MmFoRsmHS/QkCOhcR3T2r9f0OFS1kXDbXt+qYmus66W/1gT5rtxJlGto
 br4AlBuK78TbjOKlkme24V4uPoJw4qkEnmEaUVWgt3DKYc7A7LM8V9l2mGSJ1YPeJq+5ZVNKVGp
 6lZ68wZFQzjmA6DgxQ1gnh0halEvWqrY7Re7sM7MwiY/1AGx1dtmIIDrXbMlfnJ22DwY/SAb1BZ
 lN48bqffAVl0WKwSEa9h/vRZwN8CMylLPVx77cET32mxa0cuFDws3wRHVHKqsXF8NLcU0CKD+vJ
 2r2o0EyzbABvSXPPMOOeJ6IWErzCQ8SVHviPdC2u/T7xQ/KP6uYicgcLYijB6Gk=
X-Received: by 2002:a05:6000:1564:b0:390:e7c1:59c0 with SMTP id
 ffacd0b85a97d-39132d7b834mr7461703f8f.26.1741595341269; 
 Mon, 10 Mar 2025 01:29:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG/fGEoXcdfMlt63beLE5rNQAhJ3draZYtFDcErJMWsY/uZoh4ZX9iQIidqn0/hJZ55v0WD7Q==
X-Received: by 2002:a05:6000:1564:b0:390:e7c1:59c0 with SMTP id
 ffacd0b85a97d-39132d7b834mr7461682f8f.26.1741595340861; 
 Mon, 10 Mar 2025 01:29:00 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912bfb7ae4sm13782577f8f.5.2025.03.10.01.28.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Mar 2025 01:29:00 -0700 (PDT)
Message-ID: <cbaf536a-e182-40c7-9517-803b9035bbc7@redhat.com>
Date: Mon, 10 Mar 2025 09:28:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/21] system: Declare qemu_[min/max]rampagesize() in
 'system/hostmem.h'
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Tony Krowiak <akrowiak@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>,
 Halil Pasic <pasic@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 David Hildenbrand <david@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Tomita Moeko
 <tomitamoeko@gmail.com>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Eric Farman <farman@linux.ibm.com>, Eduardo Habkost <eduardo@habkost.net>,
 Peter Xu <peterx@redhat.com>, kvm@vger.kernel.org,
 Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-s390x@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Jason Herne <jjherne@linux.ibm.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Richard Henderson <richard.henderson@linaro.org>
References: <20250308230917.18907-1-philmd@linaro.org>
 <20250308230917.18907-7-philmd@linaro.org>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250308230917.18907-7-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org




On 3/9/25 12:09 AM, Philippe Mathieu-Daudé wrote:
> Both qemu_minrampagesize() and qemu_maxrampagesize() are
> related to host memory backends, having the following call
> stack:
>
>   qemu_minrampagesize()
>      -> find_min_backend_pagesize()
>          -> object_dynamic_cast(obj, TYPE_MEMORY_BACKEND)
>
>   qemu_maxrampagesize()
>      -> find_max_backend_pagesize()
>         -> object_dynamic_cast(obj, TYPE_MEMORY_BACKEND)
>
> Having TYPE_MEMORY_BACKEND defined in "system/hostmem.h":
>
>   include/system/hostmem.h:23:#define TYPE_MEMORY_BACKEND "memory-backend"
>
> Move their prototype declaration to "system/hostmem.h".
>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric
> ---
>  include/exec/ram_addr.h    | 3 ---
>  include/system/hostmem.h   | 3 +++
>  hw/ppc/spapr_caps.c        | 1 +
>  hw/s390x/s390-virtio-ccw.c | 1 +
>  hw/vfio/spapr.c            | 1 +
>  5 files changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/include/exec/ram_addr.h b/include/exec/ram_addr.h
> index 94bb3ccbe42..ccc8df561af 100644
> --- a/include/exec/ram_addr.h
> +++ b/include/exec/ram_addr.h
> @@ -101,9 +101,6 @@ static inline unsigned long int ramblock_recv_bitmap_offset(void *host_addr,
>  
>  bool ramblock_is_pmem(RAMBlock *rb);
>  
> -long qemu_minrampagesize(void);
> -long qemu_maxrampagesize(void);
> -
>  /**
>   * qemu_ram_alloc_from_file,
>   * qemu_ram_alloc_from_fd:  Allocate a ram block from the specified backing
> diff --git a/include/system/hostmem.h b/include/system/hostmem.h
> index 5c21ca55c01..62642e602ca 100644
> --- a/include/system/hostmem.h
> +++ b/include/system/hostmem.h
> @@ -93,4 +93,7 @@ bool host_memory_backend_is_mapped(HostMemoryBackend *backend);
>  size_t host_memory_backend_pagesize(HostMemoryBackend *memdev);
>  char *host_memory_backend_get_name(HostMemoryBackend *backend);
>  
> +long qemu_minrampagesize(void);
> +long qemu_maxrampagesize(void);
> +
>  #endif
> diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
> index 904bff87ce1..9e53d0c1fd1 100644
> --- a/hw/ppc/spapr_caps.c
> +++ b/hw/ppc/spapr_caps.c
> @@ -34,6 +34,7 @@
>  #include "kvm_ppc.h"
>  #include "migration/vmstate.h"
>  #include "system/tcg.h"
> +#include "system/hostmem.h"
>  
>  #include "hw/ppc/spapr.h"
>  
> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
> index 51ae0c133d8..1261d93b7ce 100644
> --- a/hw/s390x/s390-virtio-ccw.c
> +++ b/hw/s390x/s390-virtio-ccw.c
> @@ -41,6 +41,7 @@
>  #include "hw/s390x/tod.h"
>  #include "system/system.h"
>  #include "system/cpus.h"
> +#include "system/hostmem.h"
>  #include "target/s390x/kvm/pv.h"
>  #include "migration/blocker.h"
>  #include "qapi/visitor.h"
> diff --git a/hw/vfio/spapr.c b/hw/vfio/spapr.c
> index 9b5ad05bb1c..1a5d1611f2c 100644
> --- a/hw/vfio/spapr.c
> +++ b/hw/vfio/spapr.c
> @@ -12,6 +12,7 @@
>  #include <sys/ioctl.h>
>  #include <linux/vfio.h>
>  #include "system/kvm.h"
> +#include "system/hostmem.h"
>  #include "exec/address-spaces.h"
>  
>  #include "hw/vfio/vfio-common.h"


