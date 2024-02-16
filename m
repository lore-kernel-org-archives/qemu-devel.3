Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60DD8C48BEB
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Feb 2024 08:02:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rat9q-0002zz-IS; Fri, 16 Feb 2024 03:01:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1rat9p-0002zi-Nd
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 03:01:17 -0500
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1rat9n-0008NE-P9
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 03:01:17 -0500
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-563ed3d221aso472072a12.0
 for <qemu-devel@nongnu.org>; Fri, 16 Feb 2024 00:01:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708070473; x=1708675273; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=duVkoJkGEMCXhzMsFHoRs8Bh8YPcbrDB7+YTnZXyp7Q=;
 b=gDU2++Z8Jqo1e7jPm/Lbxn+GDy0EngPK26+OMtV5Xi7Sy/xs9lP+PB8MhpUro671HO
 Av9GLZPFfppy+MrnPZREGncSKLz7VHTtdCN9IIf2HmXhaxNIBw31cHi+0aSE7ndMHCor
 /ZG9pSHGjmZGY5acHeK/yw0svq5z8tjbIWZSVtswPHD7rjUiSJL7RnvYCj0ke0/8ZZ+r
 29Pn1RFQLKB/aC+l2QaqfIQ8jPl482ugMaJJ/7npjvOyRWvEgR6f1kk2m6tMfVXuH3/z
 LZVmud9IdhzdAmYAI/keM9/EvsQQ7OH0QzzPXhonSmYFZU8jJZFNFjFYMKZ3JPFSuKge
 Hzig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708070473; x=1708675273;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=duVkoJkGEMCXhzMsFHoRs8Bh8YPcbrDB7+YTnZXyp7Q=;
 b=Id9ezhARtXufJF+gqyv4VMIwPSOtEr2jv/CX5VUpwW30YE32w+wBz5O2ZCgSwcDK2p
 VaZscofEW6m0lo4J/loZhh3O2a+u72z0MRBDT60YIiJWcZ2vZzS9pcIdgGm1EqlXjEVv
 WHp9UfB77+efs4I+NtINm4ko+2wHJeW8z50XVklOFIcY/gp5vew6BnK7QEjzjBvDYdKe
 aHtMfIzwbLJ1liUnLtkQmNF9XXYSfe31rSLLOCmmm6itFM/sKMZiEVofPEPayHo4Khyf
 zFjtqNLF4AY/UnXxWvlOl/cUe0g3HusKuxr68FHTemZj3/wj1oAN5mtOQ4YvDGp9cSCN
 efzA==
X-Gm-Message-State: AOJu0Yx04C4Sp7KGWLug0Ndaxj7justwnS9KLBZUqKloQDfGqhRK2aQv
 QXYty0zTibUv5RCN7qPK5HM0EWcN/tkEJac0RkwIDoaIfKf7DTrmEBNgLRvjxk7Y0nqVKPNdFpZ
 omuc=
X-Google-Smtp-Source: AGHT+IFh+CeDAMmRou/JG6nCLj1TuyoU/DgaYMLCd2Gl797vMrcUc8CvsCsyMiw5NFokk6Nwzd5Odg==
X-Received: by 2002:a17:907:20e9:b0:a3d:6cb1:1889 with SMTP id
 rh9-20020a17090720e900b00a3d6cb11889mr4315464ejb.23.1708070473380; 
 Fri, 16 Feb 2024 00:01:13 -0800 (PST)
Received: from meli.delivery (adsl-125.37.6.3.tellas.gr. [37.6.3.125])
 by smtp.gmail.com with ESMTPSA id
 ss15-20020a170907c00f00b00a3ddddbf67esm296874ejc.149.2024.02.16.00.01.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Feb 2024 00:01:13 -0800 (PST)
Date: Fri, 16 Feb 2024 09:58:40 +0200
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Cc: 
Subject: Re: [PATCH] i386: xen: fix compilation --without-default-devices
User-Agent: meli 0.8.5-rc.3
References: <20240209215914.131345-1-pbonzini@redhat.com>
In-Reply-To: <20240209215914.131345-1-pbonzini@redhat.com>
Message-ID: <8xvlw.n697vd5fmbz@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ed1-x532.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Fri, 09 Feb 2024 23:59, Paolo Bonzini <pbonzini@redhat.com> wrote:
>The xenpv machine type requires XEN_BUS, so select it.
>
>Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>---
> accel/Kconfig | 1 +
> 1 file changed, 1 insertion(+)
>
>diff --git a/accel/Kconfig b/accel/Kconfig
>index a30cf2eb483..794e0d18d21 100644
>--- a/accel/Kconfig
>+++ b/accel/Kconfig
>@@ -16,3 +16,4 @@ config KVM
> config XEN
>     bool
>     select FSDEV_9P if VIRTFS
>+    select XEN_BUS
>-- 
>2.43.0
>


Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

