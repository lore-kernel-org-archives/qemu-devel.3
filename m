Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C5A3C30658
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2024 10:50:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sM3k9-0006WT-KL; Tue, 25 Jun 2024 06:49:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sM3k7-0006Q2-2p
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 06:49:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sM3k4-0006DC-9g
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 06:49:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719312579;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ClBPLObsjREV7Vn6vlOcFVrGHVT+p9j8iKNWAZlhSSU=;
 b=dR4UzHAce5c5ghA+Y6eL4Kc/a6IW3PpilW04C87yLsNWFH1yYOKhE5Se8uxWfVinl9B49W
 Z7W4LMKaRty6UEhN3EnIWwX+lBqffWHiOsmo4PyoM4/3tHb+x4yj+e08J70Bjg+wuGzh1Z
 YcR0SQ3KVPWzFujGkCT/vdDsU+qZPUU=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-596-RIyrXHTlPgemstyc24Xqmw-1; Tue, 25 Jun 2024 06:49:38 -0400
X-MC-Unique: RIyrXHTlPgemstyc24Xqmw-1
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-2ebd982d244so39314261fa.3
 for <qemu-devel@nongnu.org>; Tue, 25 Jun 2024 03:49:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719312576; x=1719917376;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ClBPLObsjREV7Vn6vlOcFVrGHVT+p9j8iKNWAZlhSSU=;
 b=NSpuGgk6gPa74tf6G1VGzvuKhiwZ0SW6+doOnBi3yGWFhKGFPwQUjjblxmV1WHokTB
 Cx1iUcdvHYiKNv3RPtCgwgcxpeJfgH+7gTq1x8huK4ARU/MQPuXv5mTc84s5+GvowvGS
 /sscavpIdNFFjh5o9V0Zq03UYl1afCwsIUJReneS8O/t8YaSdyK6F+7JoP0PLb8TMKer
 NtnIZCx6pu45ld24Z7Wg4qLVyPrHsXNysNyMHLqW/esNUfdH19BHPhalzj2fGyyWBixZ
 uv1fpuhHnrDN/LFi5zgAKfrnj1DgXl5BLW4HYqlMpex0eT6MaATJ1ocHvpai6s2S7QSD
 VsdA==
X-Gm-Message-State: AOJu0YyfUuvaCHgWpWlgmvbr6bYGEh4GfEqS70zoCHDmykhUg4YVJOS9
 p5UhWMhebBBO0/E9O+s1syOI20gXoJndr5rX3vIGEQg4w2me2IEdUBW+m30FjGxGLm32i1BrCDk
 JN0N/8+5uEeFpTdw9W9sEE0jaTjL3n233URJCf2eWvfTd/IzQz2o3GlqYm58N
X-Received: by 2002:a2e:9495:0:b0:2ec:529e:6522 with SMTP id
 38308e7fff4ca-2ec5b2b208cmr36358111fa.31.1719312576080; 
 Tue, 25 Jun 2024 03:49:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFbCzWgf3lkabBWkz8LJpcWPGWIg0DWZyziKgliIlaEDOGVHSLMQeDASJnb+BImt+xdZd7pQA==
X-Received: by 2002:a2e:9495:0:b0:2ec:529e:6522 with SMTP id
 38308e7fff4ca-2ec5b2b208cmr36357991fa.31.1719312575824; 
 Tue, 25 Jun 2024 03:49:35 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-366387cf523sm12614911f8f.25.2024.06.25.03.49.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Jun 2024 03:49:35 -0700 (PDT)
Date: Tue, 25 Jun 2024 12:49:34 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Sunil V L <sunilvl@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-riscv@nongnu.org, Paolo
 Bonzini <pbonzini@redhat.com>, =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau
 <marcandre.lureau@redhat.com>, "Daniel P . =?UTF-8?B?QmVycmFuZ8Op?="
 <berrange@redhat.com>, Thomas Huth <thuth@redhat.com>, Philippe
 =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>, "Michael S . Tsirkin"
 <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>, Laurent Vivier
 <lvivier@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Sia Jee Heng
 <jeeheng.sia@starfivetech.com>, Alistair Francis <alistair23@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Bin Meng <bmeng.cn@gmail.com>, Weiwei Li
 <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Subject: Re: [PATCH v3 09/15] tests/data/acpi/virt: Move ARM64 ACPI tables
 under aarch64/${machine} path
Message-ID: <20240625124934.23f86cb3@imammedo.users.ipa.redhat.com>
In-Reply-To: <20240621115906.1049832-10-sunilvl@ventanamicro.com>
References: <20240621115906.1049832-1-sunilvl@ventanamicro.com>
 <20240621115906.1049832-10-sunilvl@ventanamicro.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.151,
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

On Fri, 21 Jun 2024 17:29:00 +0530
Sunil V L <sunilvl@ventanamicro.com> wrote:

> Same machine name can be used by different architectures. Hence, create
> aarch64 folder and move all aarch64 related AML files for virt machine
> inside.
> 
> Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  tests/data/acpi/{ => aarch64}/virt/APIC             | Bin
>  .../data/acpi/{ => aarch64}/virt/APIC.acpihmatvirt  | Bin
>  tests/data/acpi/{ => aarch64}/virt/APIC.topology    | Bin
>  tests/data/acpi/{ => aarch64}/virt/DBG2             | Bin
>  tests/data/acpi/{ => aarch64}/virt/DSDT             | Bin
>  .../data/acpi/{ => aarch64}/virt/DSDT.acpihmatvirt  | Bin
>  tests/data/acpi/{ => aarch64}/virt/DSDT.memhp       | Bin
>  tests/data/acpi/{ => aarch64}/virt/DSDT.pxb         | Bin
>  tests/data/acpi/{ => aarch64}/virt/DSDT.topology    | Bin
>  tests/data/acpi/{ => aarch64}/virt/FACP             | Bin
>  tests/data/acpi/{ => aarch64}/virt/GTDT             | Bin
>  .../data/acpi/{ => aarch64}/virt/HMAT.acpihmatvirt  | Bin
>  tests/data/acpi/{ => aarch64}/virt/IORT             | Bin
>  tests/data/acpi/{ => aarch64}/virt/MCFG             | Bin
>  tests/data/acpi/{ => aarch64}/virt/NFIT.memhp       | Bin
>  tests/data/acpi/{ => aarch64}/virt/PPTT             | Bin
>  .../data/acpi/{ => aarch64}/virt/PPTT.acpihmatvirt  | Bin
>  tests/data/acpi/{ => aarch64}/virt/PPTT.topology    | Bin
>  tests/data/acpi/{ => aarch64}/virt/SLIT.memhp       | Bin
>  tests/data/acpi/{ => aarch64}/virt/SPCR             | Bin
>  .../data/acpi/{ => aarch64}/virt/SRAT.acpihmatvirt  | Bin
>  tests/data/acpi/{ => aarch64}/virt/SRAT.memhp       | Bin
>  tests/data/acpi/{ => aarch64}/virt/SRAT.numamem     | Bin
>  tests/data/acpi/{ => aarch64}/virt/SSDT.memhp       | Bin
>  tests/data/acpi/{ => aarch64}/virt/VIOT             | Bin
>  25 files changed, 0 insertions(+), 0 deletions(-)
>  rename tests/data/acpi/{ => aarch64}/virt/APIC (100%)
>  rename tests/data/acpi/{ => aarch64}/virt/APIC.acpihmatvirt (100%)
>  rename tests/data/acpi/{ => aarch64}/virt/APIC.topology (100%)
>  rename tests/data/acpi/{ => aarch64}/virt/DBG2 (100%)
>  rename tests/data/acpi/{ => aarch64}/virt/DSDT (100%)
>  rename tests/data/acpi/{ => aarch64}/virt/DSDT.acpihmatvirt (100%)
>  rename tests/data/acpi/{ => aarch64}/virt/DSDT.memhp (100%)
>  rename tests/data/acpi/{ => aarch64}/virt/DSDT.pxb (100%)
>  rename tests/data/acpi/{ => aarch64}/virt/DSDT.topology (100%)
>  rename tests/data/acpi/{ => aarch64}/virt/FACP (100%)
>  rename tests/data/acpi/{ => aarch64}/virt/GTDT (100%)
>  rename tests/data/acpi/{ => aarch64}/virt/HMAT.acpihmatvirt (100%)
>  rename tests/data/acpi/{ => aarch64}/virt/IORT (100%)
>  rename tests/data/acpi/{ => aarch64}/virt/MCFG (100%)
>  rename tests/data/acpi/{ => aarch64}/virt/NFIT.memhp (100%)
>  rename tests/data/acpi/{ => aarch64}/virt/PPTT (100%)
>  rename tests/data/acpi/{ => aarch64}/virt/PPTT.acpihmatvirt (100%)
>  rename tests/data/acpi/{ => aarch64}/virt/PPTT.topology (100%)
>  rename tests/data/acpi/{ => aarch64}/virt/SLIT.memhp (100%)
>  rename tests/data/acpi/{ => aarch64}/virt/SPCR (100%)
>  rename tests/data/acpi/{ => aarch64}/virt/SRAT.acpihmatvirt (100%)
>  rename tests/data/acpi/{ => aarch64}/virt/SRAT.memhp (100%)
>  rename tests/data/acpi/{ => aarch64}/virt/SRAT.numamem (100%)
>  rename tests/data/acpi/{ => aarch64}/virt/SSDT.memhp (100%)
>  rename tests/data/acpi/{ => aarch64}/virt/VIOT (100%)
> 
> diff --git a/tests/data/acpi/virt/APIC b/tests/data/acpi/aarch64/virt/APIC
> similarity index 100%
> rename from tests/data/acpi/virt/APIC
> rename to tests/data/acpi/aarch64/virt/APIC
> diff --git a/tests/data/acpi/virt/APIC.acpihmatvirt b/tests/data/acpi/aarch64/virt/APIC.acpihmatvirt
> similarity index 100%
> rename from tests/data/acpi/virt/APIC.acpihmatvirt
> rename to tests/data/acpi/aarch64/virt/APIC.acpihmatvirt
> diff --git a/tests/data/acpi/virt/APIC.topology b/tests/data/acpi/aarch64/virt/APIC.topology
> similarity index 100%
> rename from tests/data/acpi/virt/APIC.topology
> rename to tests/data/acpi/aarch64/virt/APIC.topology
> diff --git a/tests/data/acpi/virt/DBG2 b/tests/data/acpi/aarch64/virt/DBG2
> similarity index 100%
> rename from tests/data/acpi/virt/DBG2
> rename to tests/data/acpi/aarch64/virt/DBG2
> diff --git a/tests/data/acpi/virt/DSDT b/tests/data/acpi/aarch64/virt/DSDT
> similarity index 100%
> rename from tests/data/acpi/virt/DSDT
> rename to tests/data/acpi/aarch64/virt/DSDT
> diff --git a/tests/data/acpi/virt/DSDT.acpihmatvirt b/tests/data/acpi/aarch64/virt/DSDT.acpihmatvirt
> similarity index 100%
> rename from tests/data/acpi/virt/DSDT.acpihmatvirt
> rename to tests/data/acpi/aarch64/virt/DSDT.acpihmatvirt
> diff --git a/tests/data/acpi/virt/DSDT.memhp b/tests/data/acpi/aarch64/virt/DSDT.memhp
> similarity index 100%
> rename from tests/data/acpi/virt/DSDT.memhp
> rename to tests/data/acpi/aarch64/virt/DSDT.memhp
> diff --git a/tests/data/acpi/virt/DSDT.pxb b/tests/data/acpi/aarch64/virt/DSDT.pxb
> similarity index 100%
> rename from tests/data/acpi/virt/DSDT.pxb
> rename to tests/data/acpi/aarch64/virt/DSDT.pxb
> diff --git a/tests/data/acpi/virt/DSDT.topology b/tests/data/acpi/aarch64/virt/DSDT.topology
> similarity index 100%
> rename from tests/data/acpi/virt/DSDT.topology
> rename to tests/data/acpi/aarch64/virt/DSDT.topology
> diff --git a/tests/data/acpi/virt/FACP b/tests/data/acpi/aarch64/virt/FACP
> similarity index 100%
> rename from tests/data/acpi/virt/FACP
> rename to tests/data/acpi/aarch64/virt/FACP
> diff --git a/tests/data/acpi/virt/GTDT b/tests/data/acpi/aarch64/virt/GTDT
> similarity index 100%
> rename from tests/data/acpi/virt/GTDT
> rename to tests/data/acpi/aarch64/virt/GTDT
> diff --git a/tests/data/acpi/virt/HMAT.acpihmatvirt b/tests/data/acpi/aarch64/virt/HMAT.acpihmatvirt
> similarity index 100%
> rename from tests/data/acpi/virt/HMAT.acpihmatvirt
> rename to tests/data/acpi/aarch64/virt/HMAT.acpihmatvirt
> diff --git a/tests/data/acpi/virt/IORT b/tests/data/acpi/aarch64/virt/IORT
> similarity index 100%
> rename from tests/data/acpi/virt/IORT
> rename to tests/data/acpi/aarch64/virt/IORT
> diff --git a/tests/data/acpi/virt/MCFG b/tests/data/acpi/aarch64/virt/MCFG
> similarity index 100%
> rename from tests/data/acpi/virt/MCFG
> rename to tests/data/acpi/aarch64/virt/MCFG
> diff --git a/tests/data/acpi/virt/NFIT.memhp b/tests/data/acpi/aarch64/virt/NFIT.memhp
> similarity index 100%
> rename from tests/data/acpi/virt/NFIT.memhp
> rename to tests/data/acpi/aarch64/virt/NFIT.memhp
> diff --git a/tests/data/acpi/virt/PPTT b/tests/data/acpi/aarch64/virt/PPTT
> similarity index 100%
> rename from tests/data/acpi/virt/PPTT
> rename to tests/data/acpi/aarch64/virt/PPTT
> diff --git a/tests/data/acpi/virt/PPTT.acpihmatvirt b/tests/data/acpi/aarch64/virt/PPTT.acpihmatvirt
> similarity index 100%
> rename from tests/data/acpi/virt/PPTT.acpihmatvirt
> rename to tests/data/acpi/aarch64/virt/PPTT.acpihmatvirt
> diff --git a/tests/data/acpi/virt/PPTT.topology b/tests/data/acpi/aarch64/virt/PPTT.topology
> similarity index 100%
> rename from tests/data/acpi/virt/PPTT.topology
> rename to tests/data/acpi/aarch64/virt/PPTT.topology
> diff --git a/tests/data/acpi/virt/SLIT.memhp b/tests/data/acpi/aarch64/virt/SLIT.memhp
> similarity index 100%
> rename from tests/data/acpi/virt/SLIT.memhp
> rename to tests/data/acpi/aarch64/virt/SLIT.memhp
> diff --git a/tests/data/acpi/virt/SPCR b/tests/data/acpi/aarch64/virt/SPCR
> similarity index 100%
> rename from tests/data/acpi/virt/SPCR
> rename to tests/data/acpi/aarch64/virt/SPCR
> diff --git a/tests/data/acpi/virt/SRAT.acpihmatvirt b/tests/data/acpi/aarch64/virt/SRAT.acpihmatvirt
> similarity index 100%
> rename from tests/data/acpi/virt/SRAT.acpihmatvirt
> rename to tests/data/acpi/aarch64/virt/SRAT.acpihmatvirt
> diff --git a/tests/data/acpi/virt/SRAT.memhp b/tests/data/acpi/aarch64/virt/SRAT.memhp
> similarity index 100%
> rename from tests/data/acpi/virt/SRAT.memhp
> rename to tests/data/acpi/aarch64/virt/SRAT.memhp
> diff --git a/tests/data/acpi/virt/SRAT.numamem b/tests/data/acpi/aarch64/virt/SRAT.numamem
> similarity index 100%
> rename from tests/data/acpi/virt/SRAT.numamem
> rename to tests/data/acpi/aarch64/virt/SRAT.numamem
> diff --git a/tests/data/acpi/virt/SSDT.memhp b/tests/data/acpi/aarch64/virt/SSDT.memhp
> similarity index 100%
> rename from tests/data/acpi/virt/SSDT.memhp
> rename to tests/data/acpi/aarch64/virt/SSDT.memhp
> diff --git a/tests/data/acpi/virt/VIOT b/tests/data/acpi/aarch64/virt/VIOT
> similarity index 100%
> rename from tests/data/acpi/virt/VIOT
> rename to tests/data/acpi/aarch64/virt/VIOT


