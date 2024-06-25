Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50C5DC2BBCA
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2024 08:43:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sM1lE-0007fk-GZ; Tue, 25 Jun 2024 04:42:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sM1lC-0007fZ-Pc
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 04:42:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sM1lB-0007zg-Dh
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 04:42:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719304960;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AN9nm1cJ5CO4K+jqisGd2tIBkkEi4+rYcOcPTpP2yuk=;
 b=PxVkZRWUkrdUsi+/PTk6EZRQBMk1KXVFGA7q+6ykaNcpdOqsqDVPheaARX8lAYiSNAT0DT
 HduRbkCLyNCAiMRb2CSS2BgbLLirEDVAq2cTK39T/JJxC1GVVLSwFa+tbKyy+TW/R8Vsf7
 FnXey4iicFS77gL9L2C4oRyWjglLIRY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-696-_KrTZLxeNV-vGUMcCyArbA-1; Tue, 25 Jun 2024 04:42:34 -0400
X-MC-Unique: _KrTZLxeNV-vGUMcCyArbA-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4217104c425so34920315e9.0
 for <qemu-devel@nongnu.org>; Tue, 25 Jun 2024 01:42:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719304954; x=1719909754;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AN9nm1cJ5CO4K+jqisGd2tIBkkEi4+rYcOcPTpP2yuk=;
 b=cMfoJSf3nkkq18OMpAMSbXtV9u1fKaPeVOo98H+R8lgFnw7zCJjZus6ygmBxFMqBoI
 48SxpccdWaiEHcy8q8NgpEi1P+1LQ0XMfHuQlAJ/dvR/Qp10M/ZZLCUHpNulAhh1SOvL
 y2a6j+wri2tjFO8mGYsfEq+1mIurjp8iuhWd24VBNe+2LuwIOYwDK637NRF0MTtYew1N
 0Q7d9f+Fe9KXir+hkwsoPlbtDJVF96QNQNaBGf9kaHH5fkBSUNmuUzWz+eucBCDrZSAF
 bapDFf+a9AIn6c5Mms8IBqNAIMYq5yvlhGMNZSRHXZ8RSmd03GLuXzO0aBDTlboFLBiV
 Ma3Q==
X-Gm-Message-State: AOJu0YyY3+iIButWwk3jtczPpykdgRmAK46Lhyd6FctJxJkSV0XPXNBL
 6XVFhae98iX5TD9vNPdu/L0m6eHPM6kZ/HcMEayE1F+bMjO6y+HBnaQezo6bALseVHXxA+ulhC2
 CBGJ4VsYrMH/80C9W6D89CVZ7SwxagFsEW0Ch+A/zMznddr9q4+qg
X-Received: by 2002:a05:600c:229a:b0:424:8e78:eed with SMTP id
 5b1f17b1804b1-4248e780f13mr47548115e9.22.1719304953749; 
 Tue, 25 Jun 2024 01:42:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEMN+hRG5mCzR3v7kWAmrsl9XstBvl7mKTHJQ38hToC31FwFvX130ljY0s/Hdv8VidzSHWymg==
X-Received: by 2002:a05:600c:229a:b0:424:8e78:eed with SMTP id
 5b1f17b1804b1-4248e780f13mr47547895e9.22.1719304953403; 
 Tue, 25 Jun 2024 01:42:33 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4247d208b3dsm206769395e9.34.2024.06.25.01.42.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Jun 2024 01:42:32 -0700 (PDT)
Date: Tue, 25 Jun 2024 10:42:30 +0200
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
 <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Alistair
 Francis <alistair.francis@wdc.com>
Subject: Re: [PATCH v3 01/15] uefi-test-tools/UefiTestToolsPkg: Add RISC-V
 support
Message-ID: <20240625104230.5bd9ad72@imammedo.users.ipa.redhat.com>
In-Reply-To: <20240621115906.1049832-2-sunilvl@ventanamicro.com>
References: <20240621115906.1049832-1-sunilvl@ventanamicro.com>
 <20240621115906.1049832-2-sunilvl@ventanamicro.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.207,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, 21 Jun 2024 17:28:52 +0530
Sunil V L <sunilvl@ventanamicro.com> wrote:

> Enable building the test application for RISC-V with appropriate
> dependencies updated.
> 
> Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> Acked-by: Gerd Hoffmann <kraxel@redhat.com>
> Acked-by: Alistair Francis <alistair.francis@wdc.com>

Acked-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  tests/uefi-test-tools/UefiTestToolsPkg/UefiTestToolsPkg.dsc | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/uefi-test-tools/UefiTestToolsPkg/UefiTestToolsPkg.dsc b/tests/uefi-test-tools/UefiTestToolsPkg/UefiTestToolsPkg.dsc
> index c8511cd732..0902fd3c73 100644
> --- a/tests/uefi-test-tools/UefiTestToolsPkg/UefiTestToolsPkg.dsc
> +++ b/tests/uefi-test-tools/UefiTestToolsPkg/UefiTestToolsPkg.dsc
> @@ -19,7 +19,7 @@
>    PLATFORM_VERSION        = 0.1
>    PLATFORM_NAME           = UefiTestTools
>    SKUID_IDENTIFIER        = DEFAULT
> -  SUPPORTED_ARCHITECTURES = ARM|AARCH64|IA32|X64
> +  SUPPORTED_ARCHITECTURES = ARM|AARCH64|IA32|X64|RISCV64
>    BUILD_TARGETS           = DEBUG
>  
>  [BuildOptions.IA32]
> @@ -60,6 +60,10 @@
>  
>  [LibraryClasses.IA32, LibraryClasses.X64]
>    BaseMemoryLib|MdePkg/Library/BaseMemoryLibRepStr/BaseMemoryLibRepStr.inf
> +  RegisterFilterLib|MdePkg/Library/RegisterFilterLibNull/RegisterFilterLibNull.inf
> +
> +[LibraryClasses.RISCV64]
> +  BaseMemoryLib|MdePkg/Library/BaseMemoryLib/BaseMemoryLib.inf
>  
>  [PcdsFixedAtBuild]
>    gEfiMdePkgTokenSpaceGuid.PcdDebugPrintErrorLevel|0x8040004F


