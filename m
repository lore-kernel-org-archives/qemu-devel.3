Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89BB0C54E49
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Mar 2024 12:02:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riCQp-00020T-Fr; Thu, 07 Mar 2024 07:01:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1riCQf-000208-Sg
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 07:00:55 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1riCQd-0004NW-3X
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 07:00:52 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-412e783c94fso6794685e9.1
 for <qemu-devel@nongnu.org>; Thu, 07 Mar 2024 04:00:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709812848; x=1710417648; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=twWUN2kiBJHMBkCBDehi/T5jG7Og4Pb2CjHBjUGsfYE=;
 b=VxIw4/ri2DxCHvo5qWzX8H/V4vAZyn1IoGUQcNfgnCbdkvEdLHP3o5dPRDdDmBpbtV
 NmtZQTJ8bz+7V8cIMaWtZqxRf/ZOxXuZkJjlgS7kVhVdaOfQcsyFvHlI3T9BWEau4rnT
 KKxIJWECaG09JIqQUCUNTsUB0PaB6lxxIPpLejKOHkEo32OWMy9FIaQU/CXznYPhkagu
 oP7Irb0dDCjLzBdgSjldiKZzX4/j8zjQL7eTXOrj5YHSWtGXG68zj55ZP/rrNE/Gm/Yi
 y5+lU2MPu7dVv3aSSmsO2s+D5t2o87qqkf0h9jm0pwuF4Yzuihpgn641w6MaeG5WHxDt
 hwzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709812848; x=1710417648;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=twWUN2kiBJHMBkCBDehi/T5jG7Og4Pb2CjHBjUGsfYE=;
 b=tBw05k0RMQOV3QdyKbboQDsa2wQTVPmkeU9YYXdAyRKfzm3CHVTFMlVnAVmokWSRho
 TjYKByxoJEkvQVf65UnmlFKInkA6B1O81luJntQeySnn10l0gaelK4wZJQUyKhf+9DFe
 2Q+M3b/Sb7nzcxjFcINyoAJEmfAu4m2Imil0jQ5/PZZTMicspC31Git43Uusp/mcFUSJ
 aMAPD6AaSv43TY5vTHXdpxfnCoZb4gnAklU/5yUtdXujmTmFwgQzzJ9XBGRz0GVU5z9M
 P9ZbtugGsVGrTwihowRXaAFpNsE77z/5mq2V0Sf957aKj3C/7sTuaC7yRFlcD8IVrZM1
 Zscw==
X-Gm-Message-State: AOJu0YwrNZm7oQZ2vuvCJr++HecahydEGxKbxm+aa3XQlf7ih1jKiG68
 itFZGZ0Vce7RTrXwfpsa/bGzYKyt7xUUs7luFsEr8zq0qycprp1Oy/I2I5oI6sfwoEpper6S9WN
 5sLg=
X-Google-Smtp-Source: AGHT+IHpiLitTFNjn86v2ggcN10vD7epyc0jEhUeO7saXhtlWV7ljeU238OFndl2+3dWsKcBM0XbgQ==
X-Received: by 2002:a05:600c:5252:b0:412:de1f:cdfb with SMTP id
 fc18-20020a05600c525200b00412de1fcdfbmr9194532wmb.20.1709812848632; 
 Thu, 07 Mar 2024 04:00:48 -0800 (PST)
Received: from meli.delivery (adsl-101.37.6.0.tellas.gr. [37.6.0.101])
 by smtp.gmail.com with ESMTPSA id
 v23-20020a05600c215700b00412e84e59d8sm2356539wml.44.2024.03.07.04.00.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Mar 2024 04:00:48 -0800 (PST)
Date: Thu, 07 Mar 2024 13:58:43 +0200
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
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: Re: [RFC PATCH-for-9.0 6/9] hw/xen/hvm: Initialize xen_physmap QLIST
 in xen_read_physmap()
User-Agent: meli 0.8.5-rc.3
References: <20231114163123.74888-1-philmd@linaro.org>
 <20231114163123.74888-7-philmd@linaro.org>
In-Reply-To: <20231114163123.74888-7-philmd@linaro.org>
Message-ID: <9z81a.ekdgcipljjf2@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x32d.google.com
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
>xen_read_physmap() is the first function requiring
>xen_physmap QLIST being initialized. Move the init
>call there.
>
>Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>---
> hw/i386/xen/xen-hvm.c | 4 +++-
> 1 file changed, 3 insertions(+), 1 deletion(-)
>
>diff --git a/hw/i386/xen/xen-hvm.c b/hw/i386/xen/xen-hvm.c
>index 789779d02c..3b9c31c1c8 100644
>--- a/hw/i386/xen/xen-hvm.c
>+++ b/hw/i386/xen/xen-hvm.c
>@@ -532,6 +532,8 @@ void xen_read_physmap(XenIOState *state)
>     char path[80], *value = NULL;
>     char **entries = NULL;
> 
>+    QLIST_INIT(&xen_physmap);
>+
>     snprintf(path, sizeof(path),
>             "/local/domain/0/device-model/%d/physmap", xen_domid);
>     entries = xs_directory(state->xenstore, 0, path, &num);
>@@ -575,6 +577,7 @@ void xen_read_physmap(XenIOState *state)
> #else
> void xen_read_physmap(XenIOState *state)
> {
>+    QLIST_INIT(&xen_physmap);
> }
> #endif
> 
>@@ -595,7 +598,6 @@ void xen_hvm_init_pc(PCMachineState *pcms, MemoryRegion **ram_memory)
> 
>     xen_register_ioreq(state, max_cpus, &xen_memory_listener);
> 
>-    QLIST_INIT(&xen_physmap);
>     xen_read_physmap(state);
> 
>     suspend.notify = xen_suspend_notifier;
>-- 
>2.41.0
>
>

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

