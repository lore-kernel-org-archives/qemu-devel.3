Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 514CEC3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2024 09:01:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1scLUZ-0000J3-G5; Fri, 09 Aug 2024 05:00:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1scLUX-0000Ep-9Z
 for qemu-devel@nongnu.org; Fri, 09 Aug 2024 05:00:57 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1scLUV-0004tN-LY
 for qemu-devel@nongnu.org; Fri, 09 Aug 2024 05:00:57 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-368313809a4so1684138f8f.0
 for <qemu-devel@nongnu.org>; Fri, 09 Aug 2024 02:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723194053; x=1723798853; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=wdNs2+O9KQW+Tn/V+l6owBLuH0Fbvc2TS9Xg6LAqRd0=;
 b=nXcyl3pom/WndOHHxVH/qORyM8jD5LLkrg4NIupqGRTOAUnFOrX0HgqCv4Hqm3iz+d
 84epSVBCxruMKDEF2OvML7rmECLKSsrA1hxeXqLeG3kWOX4qkL4eY7yKtpu6aNoI/NhP
 cltB2yf/9I7C1D3NL9rKaw04vVIdm/BvD0in2hju6JRJHQyto+YgjqBXwsofEWqBAeKy
 +rcINVbpuRCNIeyWNDlu7ssAdSFoKDEoOc0G/kEm4/RrTMw3i8ZkliU1hzS52WVpXtUE
 2ZyA3F8N+cGiF/PJGLy/Q5Luz//MiHKo+cgBby3TPSWX3euX7vFaiqqfdZqK8AYZ1uVI
 KA1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723194053; x=1723798853;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wdNs2+O9KQW+Tn/V+l6owBLuH0Fbvc2TS9Xg6LAqRd0=;
 b=q9Xsn2B/xJBx3WhGfQ6yCu9HMcU/wRgXzUkSVoACiYTqx0iBD6/+kRkUEqO7/0x19w
 zsE39DSFlTZ23YxYPv+8SoxHuxyxd/k/jEBxqMv3q+5L8Uge2gTelXu/GPcYwQcjMjzu
 wAFwhly8kull0XyCMlWaRt/geENf6NkPpHU+OewnIyFl0q9BNm8RHkpzLZV1AWK4/g22
 jffLlTyVRoae0XfKrFsVjkIBktFsGiC8W+VIC8KYpOSqnniJ5rFkSp2QI0/lUX0ZEaaa
 VMy7ct4GY/GzVDcyIot6nRpvxATTUQHKB+v7Jit+EptivQa9AjOAs0lY2xnL1dzbdscG
 vMgg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUGjzXOcf7z7gSwHuULigZUxYH572CuT/vh74K72b+RhtyOOp2+a4wKsiDnItlSG5WajJjRLMKX+3n1/Oa5cfDzDHoYEz4=
X-Gm-Message-State: AOJu0Yz0HVVhJaK9AFuJ6Lr4hgzV8f33wTwcDmuq5z2/C71LTWrENNIR
 XTBzaDbAbLT5Dt3iOj9pWqEMGlVKqL1yj6PnZy2gifUDEN2qNXAWzvyVdV1HZQXxNUcAOaAzt4x
 FVp+O7Qw2Jmnzp/hQy08SWTYeI5K1qAcy/MWEdICpn9MFzoy+
X-Google-Smtp-Source: AGHT+IHsiXG2fHGXdwGOC3AgxhJRVajjBLXfHihaF7G8B5W1c+1mjigd+k1li+ljlNFLX04MjdwPCILOnUAQ+tW92zw=
X-Received: by 2002:a5d:6691:0:b0:368:6bb:f79e with SMTP id
 ffacd0b85a97d-36d6829eadbmr831839f8f.4.1723194053252; Fri, 09 Aug 2024
 02:00:53 -0700 (PDT)
MIME-Version: 1.0
References: <20240809035134.699830-1-gshan@redhat.com>
 <20240809035134.699830-2-gshan@redhat.com>
In-Reply-To: <20240809035134.699830-2-gshan@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 9 Aug 2024 10:00:42 +0100
Message-ID: <CAFEAcA_KWo2fkiFJ4CrznNkti7bdp_QTXWEdc2nJtd-a6=SPpw@mail.gmail.com>
Subject: Re: [PATCH 1/4] hw/arm/virt: hide virt_kvm_type() on !CONFIG_KVM
To: Gavin Shan <gshan@redhat.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, pbonzini@redhat.com, 
 philmd@linaro.org, richard.henderson@linaro.org, shan.gavin@gmail.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x431.google.com
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

On Fri, 9 Aug 2024 at 04:52, Gavin Shan <gshan@redhat.com> wrote:
>
> virt_kvm_type() and mc->kvm_type() are only needed when CONFIG_KVM
> is enabled. It's reasonable to hide them when CONFIG_KVM is disabled.
>
> Signed-off-by: Gavin Shan <gshan@redhat.com>
> ---
>  hw/arm/virt.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index 719e83e6a1..83be57db37 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -2991,6 +2991,7 @@ static HotplugHandler *virt_machine_get_hotplug_handler(MachineState *machine,
>   * for arm64 kvm_type [7-0] encodes the requested number of bits
>   * in the IPA address space
>   */
> +#ifdef CONFIG_KVM
>  static int virt_kvm_type(MachineState *ms, const char *type_str)
>  {
>      VirtMachineState *vms = VIRT_MACHINE(ms);
> @@ -3025,6 +3026,7 @@ static int virt_kvm_type(MachineState *ms, const char *type_str)
>       */
>      return fixed_ipa ? 0 : requested_pa_size;
>  }
> +#endif /* CONFIG_KVM */
>
>  static void virt_machine_class_init(ObjectClass *oc, void *data)
>  {
> @@ -3084,7 +3086,9 @@ static void virt_machine_class_init(ObjectClass *oc, void *data)
>  #endif
>      mc->valid_cpu_types = valid_cpu_types;
>      mc->get_default_cpu_node_id = virt_get_default_cpu_node_id;
> +#ifdef CONFIG_KVM
>      mc->kvm_type = virt_kvm_type;
> +#endif
>      assert(!mc->get_hotplug_handler);
>      mc->get_hotplug_handler = virt_machine_get_hotplug_handler;
>      hc->pre_plug = virt_machine_device_pre_plug_cb;

This adds extra ifdefs to the source code -- is there any
reason why we need them? If nothing goes wrong, I'd
prefer not to clutter the source with thme.

thanks
-- PMM

