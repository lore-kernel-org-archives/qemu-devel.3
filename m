Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C4E1C282D3
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 08:56:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpkYB-0003jP-KD; Wed, 05 Mar 2025 03:56:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tpkY6-0003j4-QJ
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 03:56:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tpkY4-0004yH-PM
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 03:56:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741164976;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hjCfr2SEmrTz7b9uHyNo5RX4QDfkw2rwXEAfztYOiIQ=;
 b=GlhEv0xKWMLuL6mwqQw01DdcnaQOh//Fy9QnHSabyGyvwIuL8WYtt8Pn0eLEQOGVlmfrJO
 1rl0YCWXm7PrCdTs+LQCtUmTtFmBSHoEuMI0ApdWZCNEYiSC9EEXjAMPQJGpefRVpLqW7n
 2uq41hq5oH7wxhuV71c1lFihpDuXho8=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-480-30uSZQLbPIWmvdFg--Zn_w-1; Wed,
 05 Mar 2025 03:56:07 -0500
X-MC-Unique: 30uSZQLbPIWmvdFg--Zn_w-1
X-Mimecast-MFC-AGG-ID: 30uSZQLbPIWmvdFg--Zn_w_1741164966
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1749C1955DDF; Wed,  5 Mar 2025 08:56:06 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.44])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B49EA1800255; Wed,  5 Mar 2025 08:56:02 +0000 (UTC)
Date: Wed, 5 Mar 2025 08:55:58 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: Re: [RFC PATCH 03/11] system: Introduce QemuArchBit enum
Message-ID: <Z8gRnioep_Jf5rb0@redhat.com>
References: <20250305005225.95051-1-philmd@linaro.org>
 <20250305005225.95051-4-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250305005225.95051-4-philmd@linaro.org>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.4.1 on 127.0.0.2
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On Wed, Mar 05, 2025 at 01:52:17AM +0100, Philippe Mathieu-Daudé wrote:
> Declare QEMU_ARCH_BIT_$target as QemuArchBit enum.
> Use them to declare QEMU_ARCH_$target bitmasks.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  meson.build                |  4 +--
>  include/system/arch_init.h | 65 +++++++++++++++++++++++++-------------
>  system/arch_init.c         |  2 +-
>  3 files changed, 46 insertions(+), 25 deletions(-)
> 
> diff --git a/meson.build b/meson.build
> index 0a2c61d2bfa..1ab02a5d48d 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -3357,8 +3357,8 @@ foreach target : target_dirs
>        config_target_data.set(k, v)
>      endif
>    endforeach
> -  config_target_data.set('QEMU_ARCH',
> -                         'QEMU_ARCH_' + config_target['TARGET_BASE_ARCH'].to_upper())
> +  config_target_data.set('QEMU_ARCH_BIT',
> +                         'QEMU_ARCH_BIT_' + config_target['TARGET_BASE_ARCH'].to_upper())
>    config_target_h += {target: configure_file(output: target + '-config-target.h',
>                                                 configuration: config_target_data)}
>  
> diff --git a/include/system/arch_init.h b/include/system/arch_init.h
> index d8b77440487..06e5527ec88 100644
> --- a/include/system/arch_init.h
> +++ b/include/system/arch_init.h
> @@ -1,29 +1,50 @@
>  #ifndef QEMU_ARCH_INIT_H
>  #define QEMU_ARCH_INIT_H
>  
> +#include "qemu/bitops.h"
>  
> -enum {
> -    QEMU_ARCH_ALL = -1,
> -    QEMU_ARCH_ALPHA = (1 << 0),
> -    QEMU_ARCH_ARM = (1 << 1),
> -    QEMU_ARCH_I386 = (1 << 3),
> -    QEMU_ARCH_M68K = (1 << 4),
> -    QEMU_ARCH_MICROBLAZE = (1 << 6),
> -    QEMU_ARCH_MIPS = (1 << 7),
> -    QEMU_ARCH_PPC = (1 << 8),
> -    QEMU_ARCH_S390X = (1 << 9),
> -    QEMU_ARCH_SH4 = (1 << 10),
> -    QEMU_ARCH_SPARC = (1 << 11),
> -    QEMU_ARCH_XTENSA = (1 << 12),
> -    QEMU_ARCH_OPENRISC = (1 << 13),
> -    QEMU_ARCH_TRICORE = (1 << 16),
> -    QEMU_ARCH_HPPA = (1 << 18),
> -    QEMU_ARCH_RISCV = (1 << 19),
> -    QEMU_ARCH_RX = (1 << 20),
> -    QEMU_ARCH_AVR = (1 << 21),
> -    QEMU_ARCH_HEXAGON = (1 << 22),
> -    QEMU_ARCH_LOONGARCH = (1 << 23),
> -};
> +typedef enum QemuArchBit {
> +    QEMU_ARCH_BIT_ALPHA         = 0,
> +    QEMU_ARCH_BIT_ARM           = 1,
> +    QEMU_ARCH_BIT_I386          = 3,
> +    QEMU_ARCH_BIT_M68K          = 4,
> +    QEMU_ARCH_BIT_MICROBLAZE    = 6,
> +    QEMU_ARCH_BIT_MIPS          = 7,
> +    QEMU_ARCH_BIT_PPC           = 8,
> +    QEMU_ARCH_BIT_S390X         = 9,
> +    QEMU_ARCH_BIT_SH4           = 10,
> +    QEMU_ARCH_BIT_SPARC         = 11,
> +    QEMU_ARCH_BIT_XTENSA        = 12,
> +    QEMU_ARCH_BIT_OPENRISC      = 13,
> +    QEMU_ARCH_BIT_TRICORE       = 16,
> +    QEMU_ARCH_BIT_HPPA          = 18,
> +    QEMU_ARCH_BIT_RISCV         = 19,
> +    QEMU_ARCH_BIT_RX            = 20,
> +    QEMU_ARCH_BIT_AVR           = 21,
> +    QEMU_ARCH_BIT_HEXAGON       = 22,
> +    QEMU_ARCH_BIT_LOONGARCH     = 23,
> +} QemuArchBit;

I'm somewhat inclined to say we should be defining this as a QemuArch
enum in QAPI, especially because that gives us the string <> int
conversion that you hand-code in a latter patch.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


