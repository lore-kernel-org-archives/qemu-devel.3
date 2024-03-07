Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDDF4C54E49
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Mar 2024 11:46:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riCCi-0002oL-Bn; Thu, 07 Mar 2024 06:46:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1riCCc-0002nR-Qh
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 06:46:23 -0500
Received: from mail-lf1-x130.google.com ([2a00:1450:4864:20::130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1riCCa-0007A5-PN
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 06:46:22 -0500
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-512b3b04995so575174e87.3
 for <qemu-devel@nongnu.org>; Thu, 07 Mar 2024 03:46:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709811977; x=1710416777; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=3FEKikgmbE/r5zzOA+k0Nr1gqI/iXTequF89jFi37Kw=;
 b=Z36s6xhVAc9ZmFLjTnCoRv9XWYy6Grc0ktoRpiklBS0qCZxny84w+5m+U0xuZNXBR6
 wIHLYKY5ikOvDMCzxYibHIubFH/tX9Gqf7WHhFXzR/iVbTaltF1l+2m7RUBn9aBSNVdE
 YUcBNVQLQllCSLIujUuWdbNEDMfo2eeYNjB/dvqsTe44qPMRJaZd9XvR25lppO+fV4L4
 BRvHhjeUHRd1+VuFwqDn8jnoG8ahIO6UxPI4Y0Ahp8sWUpGGcyMC5c7YBu78OUxQKNKi
 O/GIiFMHLQusKdCVLXvUc3SkSTMSu/TmIHzwiCjtia8wPRqs+Wmc/TsAY7+iN/0xLoEx
 e9wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709811977; x=1710416777;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3FEKikgmbE/r5zzOA+k0Nr1gqI/iXTequF89jFi37Kw=;
 b=hs+JbmUeQuIwwEDzP02va7DJnyxWNqVeM/h/86IlpukMv+QzrtCWqxlFhTP0uLn49K
 vIClFe77xPFdvbmBc7UfRF0mWUJuoXZ378BCGXuNzLVhvQsL29wYaQ1gdYOsstLzhiLp
 tLqVVcZITnWDBgKdHAVz6tTXyMmRExlm6is/vr6PDWmBRoLxSMmsdoNQHMEYinvijLew
 ddzGzuRaLgaWyp8U22APSix2asRwUtLlIAn+lB7YlYunYpDxPyGgmp/FQYUNPZ2PXDI/
 UV1Xhi3qvUGHXJm00MYrAAkZ+Mkx8epixcq+iRhDq4IS3lRGgwmkWuamspIxkAB8L66+
 4k3g==
X-Gm-Message-State: AOJu0Yz8TmhStO5CqjpJ3MBfTf4XtP4NeQbaUVnWGyNXRK90q1diwOnS
 H3vLdS+Xefg5yFc7Ombkt0zXQnN9aFx4nbY4WV8Le+4ZYKQAz6GtPsyMCLlnksLpkNPfkTaEeTV
 2BQw=
X-Google-Smtp-Source: AGHT+IFH3wkwuGOA+F/yj5AIdWusXZJacoA67XWG5i8L99raCDY6RqXWR5e9a7fc4f3xfADZKnZc2w==
X-Received: by 2002:ac2:5223:0:b0:513:4777:f8c9 with SMTP id
 i3-20020ac25223000000b005134777f8c9mr1204156lfl.6.1709811976634; 
 Thu, 07 Mar 2024 03:46:16 -0800 (PST)
Received: from meli.delivery (adsl-101.37.6.0.tellas.gr. [37.6.0.101])
 by smtp.gmail.com with ESMTPSA id
 j33-20020a05600c1c2100b00413101235b0sm1951412wms.2.2024.03.07.03.46.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Mar 2024 03:46:16 -0800 (PST)
Date: Thu, 07 Mar 2024 13:43:50 +0200
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org,
 Philippe Mathieu-Daud=?UTF-8?B?w6kg?=<philmd@linaro.org>
Cc: Anthony Perard <anthony.perard@citrix.com>, Paul Durrant <paul@xen.org>,
 David Woodhouse <dwmw@amazon.co.uk>, Thomas Huth <thuth@redhat.com>,
 qemu-arm@nongnu.org, Stefano Stabellini <sstabellini@kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alex Benn=?UTF-8?B?w6k=?= e <alex.bennee@linaro.org>,
 xen-devel@lists.xenproject.org,
 Philippe Mathieu-Daud=?UTF-8?B?w6kg?=<philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: Re: [PATCH-for-9.0 1/9] hw/xen/hvm: Inline TARGET_PAGE_ALIGN() macro
User-Agent: meli 0.8.5-rc.3
References: <20231114163123.74888-1-philmd@linaro.org>
 <20231114163123.74888-2-philmd@linaro.org>
In-Reply-To: <20231114163123.74888-2-philmd@linaro.org>
Message-ID: <9z7d2.v9odatywozfr@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::130;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-lf1-x130.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Tue, 14 Nov 2023 18:31, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>Use TARGET_PAGE_SIZE to calculate TARGET_PAGE_ALIGN.
>
>Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>---
> hw/i386/xen/xen-hvm.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/hw/i386/xen/xen-hvm.c b/hw/i386/xen/xen-hvm.c
>index f1c30d1384..8aa6a1ec3b 100644
>--- a/hw/i386/xen/xen-hvm.c
>+++ b/hw/i386/xen/xen-hvm.c
>@@ -678,7 +678,7 @@ void xen_arch_set_memory(XenIOState *state, MemoryRegionSection *section,
>     trace_xen_client_set_memory(start_addr, size, log_dirty);
> 
>     start_addr &= TARGET_PAGE_MASK;
>-    size = TARGET_PAGE_ALIGN(size);
>+    size = ROUND_UP(size, TARGET_PAGE_SIZE);
> 
>     if (add) {
>         if (!memory_region_is_rom(section->mr)) {
>-- 
>2.41.0
>
>

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

