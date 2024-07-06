Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A696C2BD09
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jul 2024 14:59:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sQ6ri-00060e-Ai; Sat, 06 Jul 2024 10:58:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sQ6rd-00060D-Rl
 for qemu-devel@nongnu.org; Sat, 06 Jul 2024 10:58:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sQ6rb-0000jO-8N
 for qemu-devel@nongnu.org; Sat, 06 Jul 2024 10:58:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720277886;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WJzFYH1zQB6BOnAKeNRfOQkgjZsxCdizv5ttDgLLrGY=;
 b=DJqbzxIMPkL6ErKOReqVjM7rmZFmApmhHWjMETRTEZ6H1U2fRcNMDXM5zCBoj3B+PBxS1S
 poO6AKBhlnLNLh4USf7t50MhLN8YyyYw9DXJQDy8ImdJiinjK9gGgFwikWbOy6ijb19y7q
 mDolv/AYl/sTxKHt46Aty1U5u0MLNd4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-612-fZ4OVxthOsC7BZJmxmMhGQ-1; Sat, 06 Jul 2024 10:58:04 -0400
X-MC-Unique: fZ4OVxthOsC7BZJmxmMhGQ-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-426624f4ce3so1376285e9.1
 for <qemu-devel@nongnu.org>; Sat, 06 Jul 2024 07:58:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720277883; x=1720882683;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WJzFYH1zQB6BOnAKeNRfOQkgjZsxCdizv5ttDgLLrGY=;
 b=jL0HafXJCUOM0Nte1dftSsDX9U4Bmj2CpXQ5NHD1dTm6D+NyJcXh1YDjkjXvW0t7vZ
 dWWE21QnMknj20a6vbdtP4ShSg9bO1+56wiOJG54D/oFZB4yezNCKW8FHO7Vb0RKdz3Q
 6nhIt22zwIJTzou2lWU/8dl8d+S5wMfENFtDRyD38b7nUDg0ExAURMrsMr5xZfKJYCBk
 JFDda7cCwUojCjboH1Ad+6OrcVjTpD9tWu0CDZZUuJaXZfSYxE8x5Df5akO3Tn89kR7t
 zPspXupDAzVOSOzn3JmcuAOR/R3suMjC/GCBc5WPUcsDQxx4ldkOIuaKVcTGu8DIcF7S
 ahWg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWoWhPat/w04loTYDhno3atX/8gPj1RwRknM52Nuh5/fg+rSzEDxI10BAKgzovXSdaDlOJ8RpwXPGFcZxKdYS11Uj7UTfA=
X-Gm-Message-State: AOJu0YxMZh34qCBQR7LOZZtpZmaoc3A+ijPIAYJfzPUGCtrwAsZpcctC
 m95US+lVzUPC7AkZJ1ZuuaqYGbDB7JfcSmBgqoW0vZnRoqoDTKfVhe5oRB93D/JxpRXEbzA/nNR
 bW1gDx3aiULTvltppfxTFiv7s7VghBWpTvQHCzWg7Zbn3efxVCMgC
X-Received: by 2002:a05:600c:4998:b0:426:5ef5:bca9 with SMTP id
 5b1f17b1804b1-4265ef5c0e1mr15641615e9.13.1720277883473; 
 Sat, 06 Jul 2024 07:58:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHsnGh9apWVh+D1TiXHPmJ1dM3935ysIBguDnhoZ0NF5w8TwXigdo8tm3XrOwJkS+8KewCmaw==
X-Received: by 2002:a05:600c:4998:b0:426:5ef5:bca9 with SMTP id
 5b1f17b1804b1-4265ef5c0e1mr15641545e9.13.1720277883141; 
 Sat, 06 Jul 2024 07:58:03 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4264a1d6d22sm99063165e9.20.2024.07.06.07.58.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 06 Jul 2024 07:58:02 -0700 (PDT)
Date: Sat, 6 Jul 2024 16:58:02 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH] i386/cpu: Drop the check of phys_bits in
 host_cpu_realizefn()
Message-ID: <20240706165802.49ec3fd8@imammedo.users.ipa.redhat.com>
In-Reply-To: <20240704111231.2881016-1-xiaoyao.li@intel.com>
References: <20240704111231.2881016-1-xiaoyao.li@intel.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu,  4 Jul 2024 07:12:31 -0400
Xiaoyao Li <xiaoyao.li@intel.com> wrote:

> The check of cpu->phys_bits to be in range between
> [32, TARGET_PHYS_ADDR_SPACE_BITS] in host_cpu_realizefn()
> is duplicated with check in x86_cpu_realizefn().
> 
> Since the ckeck in x86_cpu_realizefn() is called later and can cover all
> teh x86 case. Remove the one in host_cpu_realizefn().
> 
> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  target/i386/host-cpu.c | 12 +-----------
>  1 file changed, 1 insertion(+), 11 deletions(-)
> 
> diff --git a/target/i386/host-cpu.c b/target/i386/host-cpu.c
> index 8b8bf5afeccf..b109c1a2221f 100644
> --- a/target/i386/host-cpu.c
> +++ b/target/i386/host-cpu.c
> @@ -75,17 +75,7 @@ bool host_cpu_realizefn(CPUState *cs, Error **errp)
>      CPUX86State *env = &cpu->env;
>  
>      if (env->features[FEAT_8000_0001_EDX] & CPUID_EXT2_LM) {
> -        uint32_t phys_bits = host_cpu_adjust_phys_bits(cpu);
> -
> -        if (phys_bits &&
> -            (phys_bits > TARGET_PHYS_ADDR_SPACE_BITS ||
> -             phys_bits < 32)) {
> -            error_setg(errp, "phys-bits should be between 32 and %u "
> -                       " (but is %u)",
> -                       TARGET_PHYS_ADDR_SPACE_BITS, phys_bits);
> -            return false;
> -        }
> -        cpu->phys_bits = phys_bits;
> +        cpu->phys_bits = host_cpu_adjust_phys_bits(cpu);
>      }
>      return true;
>  }


