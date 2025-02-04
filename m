Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0987C02194
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2025 14:54:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfKId-0001FC-6O; Tue, 04 Feb 2025 09:53:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tfKIb-0001F4-R0
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 09:53:13 -0500
Received: from mail-yw1-x112d.google.com ([2607:f8b0:4864:20::112d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tfKIa-000265-4R
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 09:53:13 -0500
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-6f6ae4846c7so35315257b3.1
 for <qemu-devel@nongnu.org>; Tue, 04 Feb 2025 06:53:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738680790; x=1739285590; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=A9Q8Ge+j1xa7blEz+k0liHP3yP5grLk7zy9GsQZOF2Q=;
 b=UyDye4cTdvm2f9cX2KYS3lHWZNuR53dKWjiKqnjNewE/uGKprUcYntGgwEFpZbic43
 yAxFNbjb8lnwgAN7d9FdSQW46kHHVSr2inwcTd0W1yTQIs37z5lz7hAQDZFCiK/CgsNO
 Wkjg1AUHprHcbqAdIdoQL0btWDcY5n1xmO3k6XKCJkz0B2ZiAzRKnB1Egz6LB71XHi0o
 QYUnbCx/2+QK/ea8aTk8pvjitgX/a6ie5OL52B5kwM8zL7E5RG3OwpeqLfnQ84NPrVWR
 9wTskwYEg1gUKPOdcZ+3oY7obb5ohhDMQpvFEVbJaNNk0o+e/UzL78cKpTxn4eWUAL9d
 yP9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738680790; x=1739285590;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=A9Q8Ge+j1xa7blEz+k0liHP3yP5grLk7zy9GsQZOF2Q=;
 b=q0CEMkdqQeHRrRhN2ZTL11dhSIXSAE9pjtvC/+DcrUnbW5IbW6G0Lc9cNUtGhaSuLd
 Ld72qnxyHQwqnUiQb9Rh6F+XaHFw4tehNAYYaqM3TnL1twdKsWIqpCGEvuoocDJ4WB0o
 o1JaTNKdcnG5a80PS2NnWirt3HDx6EsiPSQgTnQL04hlfrOTNmUylT5p1PTnb1nDAHGp
 N6pJMDZWnc88zFuO+CzmoYpXzOipoKxdJkP0Kv8l67rZ1vuCjxDA7W1X3JuP7MMst53V
 vsj27IfKHK/Lk7THbR5q99kScLN394r8ITFz+2I/rbGBZ36+BV8AFatSR0p8B6VDTlFm
 b9rg==
X-Gm-Message-State: AOJu0YyknPEwfc1kt51BA/xJmI2BCtLfYKhynfySo9J1bJySShF1m638
 EVvIWioX5rlhLjmUWC0PpiiZb8pXCEP4jVYo5P8FuoyZTlGlgAOaxjDfuzpKL9ROTL+HD1GgGi0
 2hJIxBzp4+7d5mvFNhLZRjQV0hlH2EzkXd6on9g==
X-Gm-Gg: ASbGncs7fYXxqWAcJCm+AeINQq/wfoO6YHLTsqzN7oYyNg2odv7B9LZ4L3vQ1k9uBlU
 rxJLPDu8ycZT/VAW5fJJKmy6Ap2YmDISZb+vhH6sK+PfiD5cJae7OslHiopXgbpxu8sESxh447Q
 ==
X-Google-Smtp-Source: AGHT+IFVPoqUv9kSvrlWcVLfWEwFYv9pXI/VFOKFYa6BQaafMZLcSw1+ka9xb1xcxZIWezBF84SajUrV3N9eU00X+bw=
X-Received: by 2002:a05:6902:f85:b0:e57:346f:5b12 with SMTP id
 3f1490d57ef6-e58a4b01f98mr15788524276.18.1738680790099; Tue, 04 Feb 2025
 06:53:10 -0800 (PST)
MIME-Version: 1.0
References: <20250116140315.2455143-1-dwmw2@infradead.org>
 <20250116140315.2455143-4-dwmw2@infradead.org>
 <CAFEAcA9CKgumt-6V_EjCipm1DYdYw5GETNoSbUKeRsGEVhNv_Q@mail.gmail.com>
 <2498d8fa34f6503879f99f671b58055bb6a63fdc.camel@infradead.org>
In-Reply-To: <2498d8fa34f6503879f99f671b58055bb6a63fdc.camel@infradead.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 4 Feb 2025 14:52:57 +0000
X-Gm-Features: AWEUYZmWJU1fMLui0Foh6FkZIQ-iSCgBLibUk13q72sxRHZaHv7XxsQqgjRDVpQ
Message-ID: <CAFEAcA9=Z11c3LkSqsODQ40EutN0KSvywxFAciFfj=OpvytuHw@mail.gmail.com>
Subject: Re: [PATCH v7 3/3] hw/acpi: Add vmclock device
To: David Woodhouse <dwmw2@infradead.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, 
 Cornelia Huck <cohuck@redhat.com>, Peter Hilber <quic_philber@quicinc.com>, 
 "Mohamed Abuelfotoh, Hazem" <abuehaze@amazon.com>, paul <paul@xen.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112d;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112d.google.com
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

On Tue, 4 Feb 2025 at 14:17, David Woodhouse <dwmw2@infradead.org> wrote:
>
> On Tue, 2025-02-04 at 13:49 +0000, Peter Maydell wrote:
> > On Thu, 16 Jan 2025 at 14:05, David Woodhouse <dwmw2@infradead.org>
> > wrote:
> > > +    qemu_register_reset(vmclock_handle_reset, vms);
> >
> > No new calls to qemu_register_reset(), please. This is
> > a device, use the device reset API.
>
> Ack. This was cargo-culted from vmgenid; should I fix that too?

Yes, please.

> Is commit c009a311e93 the right example to follow?

I guess so, but I don't understand why that code is
adding its own ResettableState and overriding rc->get_state.
Devices all already have a ResettableState.

This is annoyingly complicated because your device
is directly inheriting from TYPE_DEVICE, and not from
TYPE_SYSBUS_DEVICE. TYPE_DEVICE devices are not plugged into
any bus, so they don't get automatically reset on system
reset. TYPE_SYSBUS_DEVICE devices plug into the sysbus,
so they get reset when system reset walks the bus tree to
reset everything.

I would ideally like to figure out a more sensible design
for reset that doesn't require that either everything plugs
into a bus or else grotty hacks to arrange for it to get
reset manually, but that's a design problem that's been
on my todo list for some years now. My interim stance has
basically been "don't directly inherit from TYPE_DEVICE,
because then you won't get reset; prefer TYPE_SYSBUS_DEVICE
instead"...

thanks
-- PMM

