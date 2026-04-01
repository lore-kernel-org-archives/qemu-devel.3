Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC5C41061B31
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2026 04:11:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7mue-0008Sr-HX; Wed, 01 Apr 2026 00:10:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1w7mua-0008Se-CT
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 00:10:36 -0400
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1w7muY-0001hy-Dh
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 00:10:35 -0400
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-b980785a0bfso904978366b.3
 for <qemu-devel@nongnu.org>; Tue, 31 Mar 2026 21:10:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775016631; cv=none;
 d=google.com; s=arc-20240605;
 b=dd2ZxP439KlCSIXK1ydc7kV0Tm3Fuz8etYJmlbum3ieWJc84Z+/+nj/9/7oUVIEVyk
 0Up8LGPhdcwHDdHYyBKzpOUwASCNWgbJ9ez807l2ueIc5BARJufZ9OxRRcwG3nmOKN34
 1xH4cte64Siooh9h9+pEtHvN+MTKPx2Tez0eSIsUyrRENcJmGNWaA+/eBS2yPfA+s1hO
 oQbWIRSwZJrWwdJ81TEWgno+UObPOOuzYDRxCAFOgTJv6cd17oxkOfNj+M0N5MARBNqf
 FUUMPu3WzBVZg6cmBEetIgMm1ZcVOcrlVuk3h2B7M5junkzzvjzaeUVaxFAtVOufMeCq
 qkOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Ynbp0qAPffH2felEEWrSPRozwlEWW0iZHX5z55ON3r4=;
 fh=qPovkGfmccDg8rfmnb1xyr9osXWJWLP94c8qWTGZbGc=;
 b=fcGPmdENaLD50KjILaCfqsjblHHmG0iJ2nSijn1WeGRszKkbbRdAPtCfJsFTA0yElL
 1GIOlnAAwY9QIVHwgIZm7S3S9rWTa5XI+nnS3oMboRRr1YjbCxnc+31/KJixiJDrhvkh
 aA4it27BiExIn+jrI3M+20LHaZr9dUU3NZ3JlzPBIJhpepQu6pA7z9Gacri9n8oCSeR0
 iu/9l9ljMXO12D2sXLvGAW1h7lcHwsSuxAAaapSiWXCMAFYRy0dsArAW7UY2K9cCMzMP
 HBfx3NmsyQt59IwwaENzjuq69yfpyKRcO46bp/95o61YAgfbzJLJpbNLePvrtgtdy56K
 zBmQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775016631; x=1775621431; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ynbp0qAPffH2felEEWrSPRozwlEWW0iZHX5z55ON3r4=;
 b=L8+BDLnTidlF58NYojq+EQHsXUNjTlEitt36wkmlMsommyKQxDdCZAaH14dgr4ehd2
 /7h18rL6lYRNcHKsYe9QsfEA29jY1eG79rZq8enIFCorSfYV9oqm6pi0tZn1TH96rjgv
 6Fd+Y16jiPB8p0oxggWIk+oZJbHIITwi7H1Nx38D9BiKfY2BeuNmSaaKKM0tejLVsBgh
 CVUNzvntWUCND/prFuPh/XusizYo/JSiWulYO+z7yHm2ceai1k9mf9m/+o7zgKIXBvKY
 rjA+Hq2+dH+q3KAcKzmMrm4QwTVUuvko8Q732JOYSfLXvdxrv4WYPKD5k1RR7gWYF54a
 817A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775016631; x=1775621431;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Ynbp0qAPffH2felEEWrSPRozwlEWW0iZHX5z55ON3r4=;
 b=joD2g2r1Wa0i9WBtakfi/B+dO8ieF7QDlGl5VLwwpPMhehdK2qyE2UONLbmjX0ZsHg
 T7uauvEtOMU1pgY4uGjUJWGPW/k/8561mcs6YXYgYI3Ybc36Ba+IJ2YGy4+fOaD+oTwj
 w4rT64+EPTild+SYSDmuUX434n9WEWDwlxgERFZxk27OoY47GrIgBxBvpK9QP/mFW1A4
 1e5pzdpTYTmE245voHSHIVg7ZS+cDzmIMMGgsXRj9T9l041XX5toVOTLihU40G2jSiej
 F2qku4lOsmKd6ClxGrfG7w/V8OpoF18UjWYlzqvxp6fwcIoiJgy5yPfH0G3bqftntpwn
 4O/w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUoQs057PStuAh65rUayvB0G3BsxcClffPT1ID/sdAgyl9Y5B7g8xz9oz0cl9wm/k8Z2BiKWRpeKMMU@nongnu.org
X-Gm-Message-State: AOJu0YxMjFBgcODEnv4rVtyoJe8bQeL08s9vp48JxavEAj6KhVJU4bV/
 OkF3UK30Gljyxq92/mPphFr72pcgSs+PKeLeDTCzBsN946uwzGyTjU5vg+uF7qcRQEDfGYbhZ0I
 kh+WU0xiWPE0RgnnbVxNHTIbRpuSYMdc=
X-Gm-Gg: ATEYQzxtx0VzCT7Y+31hn3EZIR9uZHcTE9AFbFb8AdUyuFzdCvxtXSPAY7KAYfox8LS
 tb80UYkyhDe3efURY2BVMnIPsEqay8CPLmOhbY705BwHv5e9AydcHyA4bkdwg5RjrQ5wJpiWdLX
 2fiuc4SK4wLqWkuc4xQ108xKySiKCiqLBO6cJYZZAPxqnsnMXDC9AD3vj/5Q/HBViNWZUYOoXMu
 S04k0Ka7W9Ux9ErzBojywlowNOFZjeNqKD1cq9Z2vkZ/4CFHWN4C+/kqRHHzEmkBucIQu1TD7+V
 XxvwXQ3447zYHyovMEkgx+3c4YPhwrpkkWEAdQ==
X-Received: by 2002:a17:907:a688:b0:b98:4551:e796 with SMTP id
 a640c23a62f3a-b9c13b3ce61mr139857066b.30.1775016630998; Tue, 31 Mar 2026
 21:10:30 -0700 (PDT)
MIME-Version: 1.0
References: <20260326144835.67911-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20260326144835.67911-1-heinrich.schuchardt@canonical.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 1 Apr 2026 14:10:04 +1000
X-Gm-Features: AQROBzCCet4N93HC-iiAVMCxH36qBeUxU0qoi21xVXcl0b0QXlHq-w-xV76CSeg
Message-ID: <CAKmqyKMn+SZzyU_xjNDpALRpAqfne89FQSGW3tQR=ZaB4vYX7Q@mail.gmail.com>
Subject: Re: [PATCH v2] hw/acpi: correct field sequence in SPCR table
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Sia Jee Heng <jeeheng.sia@starfivetech.com>, Ani Sinha <anisinha@redhat.com>, 
 qemu-devel@nongnu.org, Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=alistair23@gmail.com; helo=mail-ej1-x62c.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Fri, Mar 27, 2026 at 12:49=E2=80=AFAM Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> On LoongArch and RISC-V invalid SPCR tables are created:
>
> Terrminal Type : 00
> Language : 03
>
> The correct values are:
>
> Terrminal Type : 03
> Language : 00
>
> This is due to commit 7dd0b070fa09 ("hw/arm/virt-acpi-build.c: Migrate
> SPCR creation to common location") that swapped the fields.
>
> See the specification of the table in
> https://learn.microsoft.com/en-us/windows-hardware/drivers/bringup/serial=
-port-console-redirection-table
>
> This page shows version 1.10. But the sequence of the fields was not chan=
ged
> since version 1.0.
>
> Our LoongArch and ARM code uses version 1.07 of the specification.
> Our RISC-V code uses version 1.10 of the specification.
>
> Fixes: 7dd0b070fa09 ("hw/arm/virt-acpi-build.c: Migrate SPCR creation to =
common location")
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> Origin: https://lore.kernel.org/qemu-devel/20260326121947.51200-1-heinric=
h.schuchardt@canonical.com/T/#u
> Bug-Ubuntu: https://bugs.launchpad.net/ubuntu/+source/qemu/+bug/2146419

Thanks!

Applied to riscv-to-apply.next

Alistair

> ---
> v2:
>         Mention the different specification versions used by our code.
> v1:
>         https://lore.kernel.org/qemu-devel/20260326121947.51200-1-heinric=
h.schuchardt@canonical.com/T/#u
> ---
>  hw/acpi/aml-build.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
> index 4b37405088..a999320e61 100644
> --- a/hw/acpi/aml-build.c
> +++ b/hw/acpi/aml-build.c
> @@ -2115,10 +2115,10 @@ void build_spcr(GArray *table_data, BIOSLinker *l=
inker,
>      build_append_int_noprefix(table_data, f->stop_bits, 1);
>      /* Flow Control */
>      build_append_int_noprefix(table_data, f->flow_control, 1);
> -    /* Language */
> -    build_append_int_noprefix(table_data, f->language, 1);
>      /* Terminal Type */
>      build_append_int_noprefix(table_data, f->terminal_type, 1);
> +    /* Language */
> +    build_append_int_noprefix(table_data, f->language, 1);
>      /* PCI Device ID  */
>      build_append_int_noprefix(table_data, f->pci_device_id, 2);
>      /* PCI Vendor ID */
> --
> 2.53.0
>
>

