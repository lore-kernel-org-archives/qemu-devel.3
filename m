Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B03D4606D81A
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2026 10:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ajQfnAcF
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOv8X-0003DP-6Z; Thu, 05 Nov 2026 05:56:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xOv8U-00039U-CP
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 05:56:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xOv8S-0007GI-Cz
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 05:56:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793876159;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=xqkR82sXeQX53TbYRIA644367K0pl/wgQjooZejre8s=;
 b=ajQfnAcFD/0b3UkZrKgALeb0E8mCBCXu4fh7X1JpPld4V47v6W//ET0RBc3JtUiKUHyF45
 w54v1ZuQCu13TaszYarRcCQayvJCHjsbfnOMsFJnU/Wsx/HfHnGLI0XMf9DroYNpc5WSd1
 Zq7JvTis4lkjw9bwRlfxCX5dOStRl/8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-208-t2NGK5jCPKKe-6iy5u9jBw-1; Thu,
 05 Nov 2026 05:55:55 -0500
X-MC-Unique: t2NGK5jCPKKe-6iy5u9jBw-1
X-Mimecast-MFC-AGG-ID: t2NGK5jCPKKe-6iy5u9jBw_1793876153
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BBB8F1800578; Thu,  5 Nov 2026 10:55:52 +0000 (UTC)
Received: from redhat.com (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8A6741956089; Thu,  5 Nov 2026 10:55:47 +0000 (UTC)
Date: Thu, 5 Nov 2026 10:55:44 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Yonggang Luo <luoyonggang@gmail.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 Song Gao <17746591750@163.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 Philippe Mathieu-Daude <philmd@mailo.com>,
 David Hildenbrand <david@kernel.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Fam Zheng <fam@euphon.net>, Max Filippov <jcmvbkbc@gmail.com>,
 qemu-s390x@nongnu.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Eric Farman <farman@linux.ibm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Cornelia Huck <cohuck@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: Re: [PATCH v2 06/12] target/arm: register separate max-v8 CPU types
 for arm and aarch64
Message-ID: <auxgsFyzv-5UiyNk@redhat.com>
References: <20261031164009.2048-1-luoyonggang@gmail.com>
 <20261031164009.2048-7-luoyonggang@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261031164009.2048-7-luoyonggang@gmail.com>
User-Agent: Mutt/2.4.3 (2026-10-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sun, Nov 01, 2026 at 12:40:01AM +0800, Yonggang Luo wrote:
> max-v8 was one TypeInfo whose instance initializer was chosen from the
> selected target at registration. Register both initializers, and let
> target_arm() and target_aarch64() select which type is available.
> 
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> ---
>  target/arm/cpu.c            |  1 +
>  target/arm/cpu.h            |  1 +
>  target/arm/tcg/cpu-max-v8.c | 16 ++++++++++++----
>  3 files changed, 14 insertions(+), 4 deletions(-)
> 
> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> index 510fc9eeb3b..6eb55242980 100644
> --- a/target/arm/cpu.c
> +++ b/target/arm/cpu.c
> @@ -2695,6 +2695,7 @@ void arm_cpu_register(const ARMCPUInfo *info)
>          .instance_init = arm_cpu_instance_init,
>          .class_init = info->class_init ?: cpu_register_class_init,
>          .class_data = info,
> +        .is_available = info->is_available,
>      };
>  
>      type_info.name = g_strdup_printf("%s-" TYPE_ARM_CPU, info->name);
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index add993ef101..3240a8633ee 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -1203,6 +1203,7 @@ typedef struct ARMCPUInfo {
>      const char *deprecation_note;
>      void (*initfn)(Object *obj);
>      void (*class_init)(ObjectClass *oc, const void *data);
> +    bool (*is_available)(void);
>  } ARMCPUInfo;
>  
>  /**
> diff --git a/target/arm/tcg/cpu-max-v8.c b/target/arm/tcg/cpu-max-v8.c
> index 65f851f2006..e819d07e6ce 100644
> --- a/target/arm/tcg/cpu-max-v8.c
> +++ b/target/arm/tcg/cpu-max-v8.c
> @@ -121,10 +121,18 @@ void aarch32_max_v8_tcg_initfn(Object *obj)
>  
>  static void cpu_max_v8_register_type(void)
>  {
> -    static const ARMCPUInfo max_v8[2] = {
> -        { .name = "max-v8", .initfn = aarch32_max_v8_tcg_initfn },
> -        { .name = "max-v8", .initfn = aarch64_max_v8_tcg_initfn },
> +    static const ARMCPUInfo max_v8_aarch32 = {
> +        .name = "max-v8",
> +        .initfn = aarch32_max_v8_tcg_initfn,
> +        .is_available = target_arm,
>      };
> -    arm_cpu_register(&max_v8[target_aarch64()]);
> +    static const ARMCPUInfo max_v8_aarch64 = {
> +        .name = "max-v8",
> +        .initfn = aarch64_max_v8_tcg_initfn,
> +        .is_available = target_aarch64,
> +    };
> +
> +    arm_cpu_register(&max_v8_aarch32);
> +    arm_cpu_register(&max_v8_aarch64);
>  }
>  type_init(cpu_max_v8_register_type)

Conceptually these are two separate CPUs one 32-bit featureset
and one 64-bit featureset, but both given the same name. The
current code registers them only in the respective arm and aarch64
target binaries, but this CPU is an oddity overall.

More generally the aarch64 emulator includes all the 32-bit CPUs
that the arm emulator includes, and just adds extra 64-bit CPUs.
IOW, excluding the 32-bit max-v8 CPU is a special case - if it
were not for the clashing name, it would be included like all the
other 32-bit CPUs.

Thus rather than using is_available to continue to exclude it,
we must instead resolve the naming problem, such that both
models can be included concurrently.

One approach to this is to consider  the generic 'max-v8' name
to be an alias, that is resolved to the underlying real CPU
name 'max-v8-64' vs 'max-v8-32'. Allow the aliases to be
ambiguous, and either the selected target_info() disambiguates
aliases, or apps can use the canonical name instead of the alias.

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


