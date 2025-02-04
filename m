Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A41CC02194
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2025 13:49:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfJJ1-0007PM-SQ; Tue, 04 Feb 2025 08:49:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tfJIu-0007Ob-CT
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 08:49:30 -0500
Received: from mail-yb1-xb31.google.com ([2607:f8b0:4864:20::b31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tfJIs-0003tZ-Pl
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 08:49:28 -0500
Received: by mail-yb1-xb31.google.com with SMTP id
 3f1490d57ef6-e46ac799015so5203027276.0
 for <qemu-devel@nongnu.org>; Tue, 04 Feb 2025 05:49:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738676964; x=1739281764; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PqmKvTAo8vJKL8x/cBnDeiJX2TphckueguYxeGyz9fg=;
 b=x0UIC9k5l+u5NoPtheSoTvxGhnwlPiknGUWWIjCY0OiPbj0hr4Mo/c2fmaDgW5i5NK
 BGj/q5qRQz8PAfJUTOA4qmt+3fF5+F+YSt6+NTtXGDxoGOEY6v2zAczIlsV2D0ZMZWhL
 a+o608QeCRxIo8jQGEY0WSY8PudMAHrVCmd/5lV56yVTzFysrH78d/gvtoSvB5IyJLnX
 Ex6px3EnbMErG0s+dd4Zq+PYzeCEfZnPD2XbZhIgsw8vfqdTzgw88tJbPG+oSsmtUq6u
 ufrm+vj7e9GR0AZJUlHxhfqc5x7DQq8zZZe7MEOUOCmCmHxUb6UrN7TojvYWeG4npjs/
 OcNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738676964; x=1739281764;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PqmKvTAo8vJKL8x/cBnDeiJX2TphckueguYxeGyz9fg=;
 b=ZJ5zBwSwDM6oynIrcykn+hitl/FizS1fhnk+zZIrUsMLmOVt7BHlZifhPfqp6popVg
 DUciErARfbWbEjU3dIaXejrYt/0MZKABxlk1Td+pDxXaipnhZMIvNZEqtxNPzFDOs+rd
 ji9i9qr8cYB8hf9jzCiEyQs9xJlwMp13ffAD/W65IlOm4OSML+bKvZ8ktq6QyuOaw7+x
 DSYQb12pNg+d/pcY4yw7qbccBHY0Uf4bma7b161keQ6rXMVMV9SwekchQ5hhgLGRu8YV
 t62bW5Qnl5AGfQr6WqJvcg/wzKILYHKoT5mpaM3NpclHFf7x6BpAHUi0jzikjoJ3knDz
 cWEg==
X-Gm-Message-State: AOJu0YzgikGULgcjfgBmS5kKIQum7hz5lD79WyMF73LfJg5ckmhZ695b
 myHEwGnJlhBgG1yug33VNtsHqupHHlZWK6eXvzB6fTr6bNfFGDnc2cdXeO8lwsa/ndUNIPZLyeY
 zI0jhqCCDNEFEcZlZv4nfsB7s5imr1daBtZDhmA==
X-Gm-Gg: ASbGnctMD7vvuEEW8Wamc350O3Du0lzB9pKHjSK94VtjSUIZfLWMROf910bSwzr2jj+
 Uwk2j5gPcNKHhfVmdKbDvMKBGMKwM1gJFGDttqlwsJOzMeiXipqs9ZUi001m9VfW/CsTYiw99ZA
 ==
X-Google-Smtp-Source: AGHT+IH8hD1qzdqzkaD/ZETbwmmuVdPcjE7tUwnUy2FzAePipnTMz+ZefaFLYR+Rv/AG9WXvIUzvhkJ3Iw5kxXzrzYw=
X-Received: by 2002:a5b:404:0:b0:e58:11f6:db7b with SMTP id
 3f1490d57ef6-e58a4bab0aamr14718165276.30.1738676963907; Tue, 04 Feb 2025
 05:49:23 -0800 (PST)
MIME-Version: 1.0
References: <20250116140315.2455143-1-dwmw2@infradead.org>
 <20250116140315.2455143-4-dwmw2@infradead.org>
In-Reply-To: <20250116140315.2455143-4-dwmw2@infradead.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 4 Feb 2025 13:49:12 +0000
X-Gm-Features: AWEUYZn-7MFPy6zkUkkSYNqix8gf3NmSwqtNZESnhSKSHAvzzwD2k9syZIz2j1A
Message-ID: <CAFEAcA9CKgumt-6V_EjCipm1DYdYw5GETNoSbUKeRsGEVhNv_Q@mail.gmail.com>
Subject: Re: [PATCH v7 3/3] hw/acpi: Add vmclock device
To: David Woodhouse <dwmw2@infradead.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, 
 Cornelia Huck <cohuck@redhat.com>, Peter Hilber <quic_philber@quicinc.com>, 
 "Mohamed Abuelfotoh, Hazem" <abuehaze@amazon.com>, paul <paul@xen.org>,
 David Woodhouse <dwmw@amazon.co.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b31;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb31.google.com
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

On Thu, 16 Jan 2025 at 14:05, David Woodhouse <dwmw2@infradead.org> wrote:
>
> From: David Woodhouse <dwmw@amazon.co.uk>
>
> The vmclock device addresses the problem of live migration with
> precision clocks. The tolerances of a hardware counter (e.g. TSC) are
> typically around =C2=B150PPM. A guest will use NTP/PTP/PPS to discipline =
that
> counter against an external source of 'real' time, and track the precise
> frequency of the counter as it changes with environmental conditions.

Hi; I see this has already gone into git, but:

> +static void vmclock_realize(DeviceState *dev, Error **errp)
> +{
> +    VmclockState *vms =3D VMCLOCK(dev);
> +
> +    /*
> +     * Given that this function is executing, there is at least one VMCL=
OCK
> +     * device. Check if there are several.
> +     */
> +    if (!find_vmclock_dev()) {
> +        error_setg(errp, "at most one %s device is permitted", TYPE_VMCL=
OCK);
> +        return;
> +    }
> +
> +    vms->physaddr =3D VMCLOCK_ADDR;
> +
> +    e820_add_entry(vms->physaddr, VMCLOCK_SIZE, E820_RESERVED);
> +
> +    memory_region_init_ram(&vms->clk_page, OBJECT(dev), "vmclock_page",
> +                           VMCLOCK_SIZE, &error_abort);
> +    memory_region_set_enabled(&vms->clk_page, true);
> +    vms->clk =3D memory_region_get_ram_ptr(&vms->clk_page);
> +    memset(vms->clk, 0, VMCLOCK_SIZE);
> +
> +    vms->clk->magic =3D cpu_to_le32(VMCLOCK_MAGIC);
> +    vms->clk->size =3D cpu_to_le16(VMCLOCK_SIZE);
> +    vms->clk->version =3D cpu_to_le16(1);
> +
> +    /* These are all zero and thus default, but be explicit */
> +    vms->clk->clock_status =3D VMCLOCK_STATUS_UNKNOWN;
> +    vms->clk->counter_id =3D VMCLOCK_COUNTER_INVALID;
> +
> +    qemu_register_reset(vmclock_handle_reset, vms);

No new calls to qemu_register_reset(), please. This is
a device, use the device reset API.

> +
> +    vmclock_update_guest(vms);
> +}

Can you send a patch to fix this, please?

thanks
-- PMM

