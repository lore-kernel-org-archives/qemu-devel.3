Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FBFEC48BF6
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Mar 2024 11:56:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riCM1-0007sC-4L; Thu, 07 Mar 2024 06:56:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1riCLv-0007rp-TN
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 06:56:00 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1riCLp-0002OL-Tg
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 06:55:58 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-412f55695d1so7252685e9.0
 for <qemu-devel@nongnu.org>; Thu, 07 Mar 2024 03:55:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709812551; x=1710417351; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=S2WmJe5+VMgo3q0Y6DtKVBoMQYi4KEJJ63YECSnGdAI=;
 b=OyNHCozvz0UkAIw4YujWJB4sG9kyLUhm0kQlSbnkbzNdqg+bcuBiZgy38XXKR+tZVs
 cQl69JuMN7u1D7e5aJfpyjsW0Cwq9X+/FYtHALY5KdmWqzHjuhJ5pKugaIkCHqDitcbU
 5uHbuyPxvlDneL51flnmdKDeF1pEgQ82WuZrjXc54DDE2CTaJa42IK0pf85DM2jWZYqj
 kP7bTtDMQ26E5t1rUqV1MiiGp1K8ExocIBj69+5H2s8KrGZVNkebv/Rcd/iznzun3f8h
 os7Ucn1DM27Vap5P3fvbcZyg72t7aJZLHZR2QMdh7g2qhyFY9atyAOYFDjNni1SttBov
 V68g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709812551; x=1710417351;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=S2WmJe5+VMgo3q0Y6DtKVBoMQYi4KEJJ63YECSnGdAI=;
 b=d0/PXjA2fg0uK/lfPCy5IZkqa6ZWqlStNRNqm3N40ii/gzYMNDlpvp8/H8orVZdWLN
 9swFmx3Rrcb5BgKyahR7lvHdH+14W6CyrgxKCGMSwLp55CySi++q4i6HXXFmKkg7gFwL
 MhOJ3jSQcX5jjqpBGT+zrwljxOlXuQOL9gfbFkwIthyqSsM/+z3a8qjQMexvjfR5DGuw
 ekQfVVQNZ7MxaiE7+mr10ILHHpU61+Ge/C5esLz7PGFma3f9bebK+WQ4+O2v0CwTKgEl
 Mj2X0+s43bC18juthdAnOJcB0m/FFRZJCyNUeKCwWcru86pA8gS+uLb2MpAEHV+ta9nT
 MUJQ==
X-Gm-Message-State: AOJu0YwElmmzjkVyslPUVdH8wbyF5kpRL6FVQZu0auDIPLdnXj7B5a5c
 BMX1gzIQCw67D8pm3AbWiCb/S2dVBBlHRW6R4RlzHsR/7+xknr1HSH7XHi4KCyLfCC7mfs1P5F9
 cvds=
X-Google-Smtp-Source: AGHT+IGSeoRtR4+ZIJLregRqLFeBUzAzoogr8Ud+254lhRno0eax5sWI6+KhquUo7luhLcS/qDwyrg==
X-Received: by 2002:a05:600c:5247:b0:412:9dd0:f7e7 with SMTP id
 fc7-20020a05600c524700b004129dd0f7e7mr13265305wmb.22.1709812551075; 
 Thu, 07 Mar 2024 03:55:51 -0800 (PST)
Received: from meli.delivery (adsl-101.109.242.224.tellas.gr.
 [109.242.224.101]) by smtp.gmail.com with ESMTPSA id
 r11-20020a05600c35cb00b004127057d6b9sm2517388wmq.35.2024.03.07.03.55.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Mar 2024 03:55:50 -0800 (PST)
Date: Thu, 07 Mar 2024 13:54:35 +0200
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
 Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: Re: [PATCH-for-9.0 4/9] hw/xen/hvm: Expose xen_memory_listener
 declaration
User-Agent: meli 0.8.5-rc.3
References: <20231114163123.74888-1-philmd@linaro.org>
 <20231114163123.74888-5-philmd@linaro.org>
In-Reply-To: <20231114163123.74888-5-philmd@linaro.org>
Message-ID: <9z7t0.nx533lxsltko@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x335.google.com
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

On Tue, 14 Nov 2023 18:31, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>There can only be a single xen_memory_listener definition
>in a qemu-system binary.
>
>Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>---
> include/hw/xen/xen-hvm-common.h | 1 +
> hw/arm/xen_arm.c                | 2 +-
> hw/i386/xen/xen-hvm.c           | 2 +-
> 3 files changed, 3 insertions(+), 2 deletions(-)
>
>diff --git a/include/hw/xen/xen-hvm-common.h b/include/hw/xen/xen-hvm-common.h
>index 83ed16f425..0fed15ed04 100644
>--- a/include/hw/xen/xen-hvm-common.h
>+++ b/include/hw/xen/xen-hvm-common.h
>@@ -18,6 +18,7 @@
> extern MemoryRegion xen_memory;
> extern MemoryListener xen_io_listener;
> extern DeviceListener xen_device_listener;
>+extern const MemoryListener xen_memory_listener;
> 
> //#define DEBUG_XEN_HVM
> 
>diff --git a/hw/arm/xen_arm.c b/hw/arm/xen_arm.c
>index b478d74ea0..39dcd74d07 100644
>--- a/hw/arm/xen_arm.c
>+++ b/hw/arm/xen_arm.c
>@@ -38,7 +38,7 @@
> #define TYPE_XEN_ARM  MACHINE_TYPE_NAME("xenpvh")
> OBJECT_DECLARE_SIMPLE_TYPE(XenArmState, XEN_ARM)
> 
>-static const MemoryListener xen_memory_listener = {
>+const MemoryListener xen_memory_listener = {
>     .region_add = xen_region_add,
>     .region_del = xen_region_del,
>     .log_start = NULL,
>diff --git a/hw/i386/xen/xen-hvm.c b/hw/i386/xen/xen-hvm.c
>index b64204ea94..a65a96f0de 100644
>--- a/hw/i386/xen/xen-hvm.c
>+++ b/hw/i386/xen/xen-hvm.c
>@@ -469,7 +469,7 @@ static void xen_log_global_stop(MemoryListener *listener)
>     xen_in_migration = false;
> }
> 
>-static const MemoryListener xen_memory_listener = {
>+const MemoryListener xen_memory_listener = {
>     .name = "xen-memory",
>     .region_add = xen_region_add,
>     .region_del = xen_region_del,
>-- 
>2.41.0
>
>


Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

