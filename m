Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A9EAC27C5E
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2024 21:04:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sGmAQ-0001Yz-Mc; Mon, 10 Jun 2024 17:03:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>)
 id 1sGmAN-0001Y1-EL; Mon, 10 Jun 2024 17:02:59 -0400
Received: from mx.treblig.org ([2a00:1098:5b::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>)
 id 1sGmAK-0006Gz-Lj; Mon, 10 Jun 2024 17:02:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
 ; s=bytemarkmx;
 h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
 :Subject; bh=Y6FoNNlXR+KrEK2nSb6udr5/u8P0dwud0njdRHgqjDY=; b=om9Ss9sFuyH1EDUj
 1+NrhAamVxTRgfPcSD6QAjdlRkg+w1IEAcdj3eKBui6EytlS5EH5t3FXPpsVpTyKlnQhYSow05Rr3
 y8ER/F+6cMQzzOZ41qKDYOkb1xQk6X4tbDqlC4w+beMHALKB4WooWy8z3KbewJeTT6Ca0AeTyuGKE
 0xKGNPWxkfBTxgVxoEPtaP8AqaS8WB/MrnM2RGsGOQqJzf7ZAranf5FMU3WbZo6tgWIYRGY5DKzla
 jS6fcVPhAPYcevdToVvwnZeE/zGCMJnEDGtQp+luvpQeERlkvI66VJ1HvtkZtMesuWsBEC5h0vD/6
 wU5m+fs3FjJxau3lQg==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
 (envelope-from <dg@treblig.org>) id 1sGmAE-005QJ7-1k;
 Mon, 10 Jun 2024 21:02:50 +0000
Date: Mon, 10 Jun 2024 21:02:50 +0000
From: "Dr. David Alan Gilbert" <dave@treblig.org>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: Markus Armbruster <armbru@redhat.com>,
 Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, Yanan Wang <wangyanan55@huawei.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eric Farman <farman@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Eric Blake <eblake@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 qemu-s390x@nongnu.org, Eduardo Habkost <eduardo@habkost.net>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 1/3] hw/s390x: Declare target specific monitor commands
 in hmp-target.h
Message-ID: <Zmdp-uI1wleQN0Xr@gallifrey>
References: <20240610175852.21215-1-philmd@linaro.org>
 <20240610175852.21215-2-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240610175852.21215-2-philmd@linaro.org>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-21-amd64 (x86_64)
X-Uptime: 20:59:03 up 33 days, 8:13, 1 user, load average: 0.00, 0.02, 0.00
User-Agent: Mutt/2.2.12 (2023-09-09)
Received-SPF: pass client-ip=2a00:1098:5b::1; envelope-from=dg@treblig.org;
 helo=mx.treblig.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

* Philippe Mathieu-Daudé (philmd@linaro.org) wrote:
> "monitor/hmp-target.h" is meant to hold target-specific commands.
> Move s390x specific commands there, slightly simplifying hmp-target.c.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  include/hw/s390x/storage-attributes.h | 4 ----
>  include/hw/s390x/storage-keys.h       | 4 ----
>  include/monitor/hmp-target.h          | 5 +++++
>  hw/s390x/s390-skeys.c                 | 2 ++
>  hw/s390x/s390-stattrib.c              | 2 ++
>  monitor/hmp-target.c                  | 5 -----
>  6 files changed, 9 insertions(+), 13 deletions(-)
> 
> diff --git a/include/hw/s390x/storage-attributes.h b/include/hw/s390x/storage-attributes.h
> index 8921a04d51..4916c75936 100644
> --- a/include/hw/s390x/storage-attributes.h
> +++ b/include/hw/s390x/storage-attributes.h
> @@ -13,7 +13,6 @@
>  #define S390_STORAGE_ATTRIBUTES_H
>  
>  #include "hw/qdev-core.h"
> -#include "monitor/monitor.h"
>  #include "qom/object.h"
>  
>  #define TYPE_S390_STATTRIB "s390-storage_attributes"
> @@ -73,7 +72,4 @@ static inline Object *kvm_s390_stattrib_create(void)
>  }
>  #endif
>  
> -void hmp_info_cmma(Monitor *mon, const QDict *qdict);
> -void hmp_migrationmode(Monitor *mon, const QDict *qdict);
> -
>  #endif /* S390_STORAGE_ATTRIBUTES_H */
> diff --git a/include/hw/s390x/storage-keys.h b/include/hw/s390x/storage-keys.h
> index aa2ec2aae5..1d9b7ead44 100644
> --- a/include/hw/s390x/storage-keys.h
> +++ b/include/hw/s390x/storage-keys.h
> @@ -13,7 +13,6 @@
>  #define S390_STORAGE_KEYS_H
>  
>  #include "hw/qdev-core.h"
> -#include "monitor/monitor.h"
>  #include "qom/object.h"
>  
>  #define TYPE_S390_SKEYS "s390-skeys"
> @@ -114,7 +113,4 @@ void s390_skeys_init(void);
>  
>  S390SKeysState *s390_get_skeys_device(void);
>  
> -void hmp_dump_skeys(Monitor *mon, const QDict *qdict);
> -void hmp_info_skeys(Monitor *mon, const QDict *qdict);
> -
>  #endif /* S390_STORAGE_KEYS_H */
> diff --git a/include/monitor/hmp-target.h b/include/monitor/hmp-target.h
> index b679aaebbf..024cff0052 100644
> --- a/include/monitor/hmp-target.h
> +++ b/include/monitor/hmp-target.h
> @@ -61,4 +61,9 @@ void hmp_gva2gpa(Monitor *mon, const QDict *qdict);
>  void hmp_gpa2hva(Monitor *mon, const QDict *qdict);
>  void hmp_gpa2hpa(Monitor *mon, const QDict *qdict);
>  
> +void hmp_dump_skeys(Monitor *mon, const QDict *qdict);
> +void hmp_info_skeys(Monitor *mon, const QDict *qdict);
> +void hmp_info_cmma(Monitor *mon, const QDict *qdict);
> +void hmp_migrationmode(Monitor *mon, const QDict *qdict);
> +

Could you please add a comment here saying that these are all s390,
since it's not obvious from their names.
(and if we're lucky the other s390 commands will stay with them).

Dave

>  #endif /* MONITOR_HMP_TARGET_H */
> diff --git a/hw/s390x/s390-skeys.c b/hw/s390x/s390-skeys.c
> index 5c535d483e..7b2ccb94a5 100644
> --- a/hw/s390x/s390-skeys.c
> +++ b/hw/s390x/s390-skeys.c
> @@ -23,6 +23,8 @@
>  #include "sysemu/kvm.h"
>  #include "migration/qemu-file-types.h"
>  #include "migration/register.h"
> +#include "monitor/hmp-target.h"
> +#include "monitor/monitor.h"
>  
>  #define S390_SKEYS_BUFFER_SIZE (128 * KiB)  /* Room for 128k storage keys */
>  #define S390_SKEYS_SAVE_FLAG_EOS 0x01
> diff --git a/hw/s390x/s390-stattrib.c b/hw/s390x/s390-stattrib.c
> index c4259b5327..9b4b8d8d0c 100644
> --- a/hw/s390x/s390-stattrib.c
> +++ b/hw/s390x/s390-stattrib.c
> @@ -19,6 +19,8 @@
>  #include "exec/ram_addr.h"
>  #include "qapi/error.h"
>  #include "qapi/qmp/qdict.h"
> +#include "monitor/hmp-target.h"
> +#include "monitor/monitor.h"
>  #include "cpu.h"
>  
>  /* 512KiB cover 2GB of guest memory */
> diff --git a/monitor/hmp-target.c b/monitor/hmp-target.c
> index 1eb72ac1bf..0466474354 100644
> --- a/monitor/hmp-target.c
> +++ b/monitor/hmp-target.c
> @@ -36,11 +36,6 @@
>  #include "qapi/error.h"
>  #include "qemu/cutils.h"
>  
> -#if defined(TARGET_S390X)
> -#include "hw/s390x/storage-keys.h"
> -#include "hw/s390x/storage-attributes.h"
> -#endif
> -
>  /* Make devices configuration available for use in hmp-commands*.hx templates */
>  #include CONFIG_DEVICES
>  
> -- 
> 2.41.0
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

