Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0203F53D6F
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2026 16:24:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2AjV-0006LD-Jo; Mon, 16 Mar 2026 12:23:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w2AjT-0006Kb-Uz
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 12:23:55 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w2AjS-0004FF-AL
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 12:23:55 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-482f454be5bso54299935e9.0
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2026 09:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773678232; x=1774283032; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+pakwbs8OavC8hzHEyQmhubZtlAHXD7me3nOdqARsjk=;
 b=GSErdulu9XtZ2sNfbTjcU0U9w4HS+/umfMlFV4fa7AhuwIKbub35heE2Dhte+ZPugr
 faCxZQH+iUWq9OLEI8M5mxFL0j0LlkNGuefoXeVNvcRFp8da8sJbUnFv35+KDShEyU7k
 uZ7pchEsK4NnF1T/CzKkAPXBJgNYqu5CAg3UjXCc4E50kNQJo9JIGQ+kEnSlX8JpegEn
 WHt2pEpJGc9ciu54Z7nJNfUYZNUuF24NdrI1EfteQWefpRVvqZd6fG8B+wRRAS5xTvTx
 30xJKIlUGxKiSQVFH1VsOeZAx/e6p7l0X3WGiBTD16u5q37DKHDe5FvOHWEHcaV90BRA
 egOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773678232; x=1774283032;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+pakwbs8OavC8hzHEyQmhubZtlAHXD7me3nOdqARsjk=;
 b=BVyTje8wv8feJddwM3xNPEGYur+yt5PgRi3cC4zxFr/VyA3m9qY1oLAsgMnxeQus+G
 iWG/jqPI2pl8fIUFVbzVLIVcEB6u3mfGQTf13nwOQbzBhddNiz8zrY45ghPmj0y7Tk/P
 Zc2KwuQhL8l5Qi/MG+9Kvz8Rc+FuWOfuo4IZ/0PFfZl+bSp/izenaedFccwsHEGZAwMS
 7BnCLhoAbtYQCA3Egj4OwZuxNGb3sn+riT5a9bBVIp7XlmDmJil44m9cjpl2QVL4E+OH
 9FLX7UyCsz2P4EA2uIfMXqtnEoZIna3i/m/C19ohD4ysKCUyQ8cIsNS1YdttzsAOI3ut
 fC7A==
X-Gm-Message-State: AOJu0Yw3/Rj9Eit7Ml7l65iDHdXNZcui+ZexUsYYqJgyIub5rsm/TUcl
 cgD2m0hZ31NUN/AtKeSRNak1Rt2of3g+mRon8UmJSg1k2dU6VMQOQ0UPlm0Z1SG26PA=
X-Gm-Gg: ATEYQzwHUmNOozmzMAOwWyZs5PRuPykmhFqN35P0dyCTdwUGiRoLoPjqHa8dFCf1wGt
 RxBSPLPuXNUvXhIyGpqIZv2CO0KpdSPLxO1lBiGfWy/FvwaYzNXavf3PJ0F+Y9XvxITLvGTfXwf
 HBXc1bE6UdtFutt2wDSjPZKPTNFEUh0zDPx13aIptu5Ufimqerz7Wg4jaNVtzXfwmoaxZTHcncJ
 URfJmqDTSAAcYTgYQDTS58GOJ9c0pH41jMVYOVjCyKmHidVZjLYDXBTeZdi/hK83F4T1oWNMIkB
 SvORL0BYbwugOomcz9ULiuch+TR8Pq05NetbRkAI36VTJXQBOrnlipyUfmjQ/ZACLkVwTDQDjxE
 Y9a7ddH1ir6aNVHBHqX6SnoZ/+20ZkXlxgvZXmUCZqs5XvR2UqiiMwModHiwccZClaTSyOKpbf8
 Ut7ITz4DZs9QU1ycvf9cU3Q5L8+1eJD3xP6eiErWTjertio34H4Nj+V+rFqi+1Gk7qv4wcQujQa
 y4O
X-Received: by 2002:a05:600c:3541:b0:485:3c11:de84 with SMTP id
 5b1f17b1804b1-4856eadbac7mr3345965e9.14.1773678232274; 
 Mon, 16 Mar 2026 09:23:52 -0700 (PDT)
Received: from [192.168.69.206] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4856ea9d7e1sm2834275e9.7.2026.03.16.09.23.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Mar 2026 09:23:51 -0700 (PDT)
Message-ID: <60fc2590-6c94-45df-a4ad-9d1a1edec504@linaro.org>
Date: Mon, 16 Mar 2026 17:23:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] vmstate: validate VMStateDescription::fields upon
 registration
To: Fabiano Rosas <farosas@suse.de>, Roman Kiryanov <rkir@google.com>,
 peterx@redhat.com
Cc: qemu-devel@nongnu.org, whollins@google.com, jansene@google.com,
 jpcottin@google.com
References: <20260313233538.1519319-1-rkir@google.com> <87341zsvmc.fsf@suse.de>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Content-Language: en-US
In-Reply-To: <87341zsvmc.fsf@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 16/3/26 15:21, Fabiano Rosas wrote:

> -- >8 --
>  From 9bd63109e970ff231eb321e627f622910f9977ca Mon Sep 17 00:00:00 2001
> From: Fabiano Rosas <farosas@suse.de>
> Date: Mon, 16 Mar 2026 11:16:22 -0300
> Subject: [PATCH] fixup! vmstate: validate VMStateDescription::fields upon
>   registration
> 
> ---
>   hw/acpi/acpi-cpu-hotplug-stub.c | 4 +++-
>   hw/acpi/acpi-mem-hotplug-stub.c | 4 +++-
>   hw/acpi/acpi-pci-hotplug-stub.c | 4 +++-
>   3 files changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/acpi/acpi-cpu-hotplug-stub.c b/hw/acpi/acpi-cpu-hotplug-stub.c
> index 72c5f05f5c..4332f3fb7d 100644
> --- a/hw/acpi/acpi-cpu-hotplug-stub.c
> +++ b/hw/acpi/acpi-cpu-hotplug-stub.c
> @@ -3,7 +3,9 @@
>   #include "hw/acpi/cpu.h"
>   
>   /* Following stubs are all related to ACPI cpu hotplug */
> -const VMStateDescription vmstate_cpu_hotplug;
> +const VMStateDescription vmstate_cpu_hotplug = {
> +    .fields = (const VMStateField[]) { VMSTATE_END_OF_LIST() },
> +};
>   
>   void cpu_hotplug_hw_init(MemoryRegion *as, Object *owner,
>                            CPUHotplugState *state, hwaddr base_addr)
> diff --git a/hw/acpi/acpi-mem-hotplug-stub.c b/hw/acpi/acpi-mem-hotplug-stub.c
> index 7ad0fdcdf2..36c12a4e5f 100644
> --- a/hw/acpi/acpi-mem-hotplug-stub.c
> +++ b/hw/acpi/acpi-mem-hotplug-stub.c
> @@ -2,7 +2,9 @@
>   #include "hw/acpi/memory_hotplug.h"
>   #include "migration/vmstate.h"
>   
> -const VMStateDescription vmstate_memory_hotplug;
> +const VMStateDescription vmstate_memory_hotplug = {
> +    .fields = (const VMStateField[]) { VMSTATE_END_OF_LIST() },
> +};
>   
>   void acpi_memory_hotplug_init(MemoryRegion *as, Object *owner,
>                                 MemHotplugState *state, hwaddr io_base)
> diff --git a/hw/acpi/acpi-pci-hotplug-stub.c b/hw/acpi/acpi-pci-hotplug-stub.c
> index d58ea726a8..3e3a484d3e 100644
> --- a/hw/acpi/acpi-pci-hotplug-stub.c
> +++ b/hw/acpi/acpi-pci-hotplug-stub.c
> @@ -2,7 +2,9 @@
>   #include "hw/acpi/pcihp.h"
>   #include "migration/vmstate.h"
>   
> -const VMStateDescription vmstate_acpi_pcihp_pci_status;
> +const VMStateDescription vmstate_acpi_pcihp_pci_status = {
> +    .fields = (const VMStateField[]) { VMSTATE_END_OF_LIST() },
> +};
>   
>   void acpi_pcihp_init(Object *owner, AcpiPciHpState *s,
>                        MemoryRegion *address_space_io, uint16_t io_base)

Missing:

-- >8 --
diff --git a/hw/display/ramfb-stubs.c b/hw/display/ramfb-stubs.c
index b83551357bb..283af44ecec 100644
--- a/hw/display/ramfb-stubs.c
+++ b/hw/display/ramfb-stubs.c
@@ -2,7 +2,9 @@
  #include "qapi/error.h"
  #include "hw/display/ramfb.h"

-const VMStateDescription ramfb_vmstate = {};
+const VMStateDescription ramfb_vmstate = {
+    .fields = (const VMStateField[]) { VMSTATE_END_OF_LIST() },
+};

  void ramfb_display_update(QemuConsole *con, RAMFBState *s)
  {
---

Otherwise LGTM (agreeing with Peter to post separately as
a preliminary Fixes patch).

