Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 039ABD24470
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2024 17:37:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1szJHE-00008T-Hr; Fri, 11 Oct 2024 13:18:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1szJ7c-0004Pd-PR
 for qemu-devel@nongnu.org; Fri, 11 Oct 2024 13:08:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1szEhQ-00063x-6A
 for qemu-devel@nongnu.org; Fri, 11 Oct 2024 08:24:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728649491;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=g+dX2FUQtzWNhwkn3zWaTuHUJbYQoJ6Z1NqaF2V0yzc=;
 b=MqLrBNmxhF+5H6wAdDn7fncr9UZdRaBLPrX7WeFf4xSo7p848knsQaGExIqwbR/S2OSo25
 U+jePJv8M9MHlp5cEuKxJKbB8suRQN6OeP8wU+SnWbLyonrrycPhKLpvx2XhCf5mImhpQn
 xc8AvqjQo7jcUtuiGeaoHt/+ANThefQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-596-AksBAiMbOV-YNTUkmYG2OA-1; Fri, 11 Oct 2024 08:24:48 -0400
X-MC-Unique: AksBAiMbOV-YNTUkmYG2OA-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-37d563a1af4so213974f8f.2
 for <qemu-devel@nongnu.org>; Fri, 11 Oct 2024 05:24:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728649487; x=1729254287;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=g+dX2FUQtzWNhwkn3zWaTuHUJbYQoJ6Z1NqaF2V0yzc=;
 b=v4ju05wqmrvzm3xxfjI9kjT3jKHLSpNQnjwOCrWmdZH4+H+CIluEbNbREyZKuwBITJ
 Gr9YO+H9AcA4v3dEJ1KtF59Vy1ADu13Ou793u2OPwq5dG6NdFXPmDR+kLLihywD89gSN
 2NdpK7DhlNg8W+8WY/fiNlFZtbcUp+pSPrl6yMmZ3QQVapzGAAorNj8r9E2zDY6z6iuT
 IF7H+GsBehwLMfiDcNfTILtaBacYH5LGRDB7giVYyKs0Z7DqGGV2wuNa0R/um0DWuUsm
 kyhUoz9EjNLCllTWYL8LLxVsEiJqEZHwt97gux+RMU6pUzujX+xZjKQdpnYRW4QDDJge
 /2AQ==
X-Gm-Message-State: AOJu0YzRFxKkhKcuCAqeqojdOXPKU+84QXrW/rVcAYoJ9HeVqVsqGWYh
 mTOAe/Y2eNnHvXFFljAQlHMhnfixsASj94DMnNdpxt5qPU+nJYHh24Lq37WlhZ4sogJfN1XxaXC
 MbXjHxvZlbcdCluOVMn9GHl+Nz9ka2sRvB4CNUT695yIj/FCY4o22
X-Received: by 2002:a5d:6911:0:b0:37d:37e4:f904 with SMTP id
 ffacd0b85a97d-37d552ee4fbmr1628537f8f.36.1728649486751; 
 Fri, 11 Oct 2024 05:24:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGUMsjgaUwxDujgtiYLBB6tvDkRVbyvU8RkZXSyq/UML0G6450MmDV3uFSqhIPG1VvYaKgJVg==
X-Received: by 2002:a5d:6911:0:b0:37d:37e4:f904 with SMTP id
 ffacd0b85a97d-37d552ee4fbmr1628524f8f.36.1728649486289; 
 Fri, 11 Oct 2024 05:24:46 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d4b9190dfsm3773645f8f.116.2024.10.11.05.24.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Oct 2024 05:24:45 -0700 (PDT)
Date: Fri, 11 Oct 2024 14:24:44 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, xieyongji@bytedance.com, kwolf@redhat.com,
 hreitz@redhat.com, Coiby.Xu@gmail.com, pbonzini@redhat.com,
 berrange@redhat.com, eduardo@habkost.net, mark.cave-ayland@ilande.co.uk,
 michael.roth@amd.com, kkostiuk@redhat.com, qemu-block@nongnu.org,
 philmd@linaro.org
Subject: Re: [PATCH v2 5/7] target/i386/cpu: Improve errors for out of
 bounds property values
Message-ID: <20241011142444.03f04d81@imammedo.users.ipa.redhat.com>
In-Reply-To: <20241010150144.986655-6-armbru@redhat.com>
References: <20241010150144.986655-1-armbru@redhat.com>
 <20241010150144.986655-6-armbru@redhat.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.15,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Thu, 10 Oct 2024 17:01:42 +0200
Markus Armbruster <armbru@redhat.com> wrote:

> The error message for a "stepping" value that is out of bounds is a
> bit odd:
> 
>     $ qemu-system-x86_64 -cpu qemu64,stepping=16
>     qemu-system-x86_64: can't apply global qemu64-x86_64-cpu.stepping=16: Property .stepping doesn't take value 16 (minimum: 0, maximum: 15)
> 
> The "can't apply global" part is an unfortunate artifact of -cpu's
> implementation.  Left for another day.
> 
> The remainder feels overly verbose.  Change it to
> 
>     qemu64-x86_64-cpu: can't apply global qemu64-x86_64-cpu.stepping=16: parameter 'stepping' can be at most 15
> 
> Likewise for "family", "model", and "tsc-frequency".
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  target/i386/cpu.c | 20 +++++++++-----------
>  1 file changed, 9 insertions(+), 11 deletions(-)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 4f8fa60432..de2c7041c5 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -31,7 +31,6 @@
>  #include "qapi/error.h"
>  #include "qemu/error-report.h"
>  #include "qapi/qapi-visit-machine.h"
> -#include "qapi/qmp/qerror.h"
>  #include "standard-headers/asm-x86/kvm_para.h"
>  #include "hw/qdev-properties.h"
>  #include "hw/i386/topology.h"
> @@ -5455,8 +5454,8 @@ static void x86_cpuid_version_set_family(Object *obj, Visitor *v,
>          return;
>      }
>      if (value > max) {
> -        error_setg(errp, QERR_PROPERTY_VALUE_OUT_OF_RANGE, "",
> -                   name ? name : "null", value, (int64_t)0, (int64_t)max);
> +        error_setg(errp, "parameter '%s' can be at most %" PRIu64,
> +                   name ? name : "null", max);
>          return;
>      }
>  
> @@ -5494,8 +5493,8 @@ static void x86_cpuid_version_set_model(Object *obj, Visitor *v,
>          return;
>      }
>      if (value > max) {
> -        error_setg(errp, QERR_PROPERTY_VALUE_OUT_OF_RANGE, "",
> -                   name ? name : "null", value, (int64_t)0, (int64_t)max);
> +        error_setg(errp, "parameter '%s' can be at most %" PRIu64,
> +                   name ? name : "null", max);
>          return;
>      }
>  
> @@ -5528,8 +5527,8 @@ static void x86_cpuid_version_set_stepping(Object *obj, Visitor *v,
>          return;
>      }
>      if (value > max) {
> -        error_setg(errp, QERR_PROPERTY_VALUE_OUT_OF_RANGE, "",
> -                   name ? name : "null", value, (int64_t)0, (int64_t)max);
> +        error_setg(errp, "parameter '%s' can be at most %" PRIu64,
> +                   name ? name : "null", max);
>          return;
>      }
>  
> @@ -5623,16 +5622,15 @@ static void x86_cpuid_set_tsc_freq(Object *obj, Visitor *v, const char *name,
>                                     void *opaque, Error **errp)
>  {
>      X86CPU *cpu = X86_CPU(obj);
> -    const int64_t min = 0;
>      const int64_t max = INT64_MAX;
>      int64_t value;
>  
>      if (!visit_type_int(v, name, &value, errp)) {
>          return;
>      }
> -    if (value < min || value > max) {
> -        error_setg(errp, QERR_PROPERTY_VALUE_OUT_OF_RANGE, "",
> -                   name ? name : "null", value, min, max);
> +    if (value < 0 || value > max) {
> +        error_setg(errp, "parameter '%s' can be at most %" PRId64,
> +                   name ? name : "null", max);
>          return;
>      }
>  


