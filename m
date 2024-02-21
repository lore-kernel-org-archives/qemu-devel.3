Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B74FEC48BC3
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 15:28:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcoPm-0006JN-56; Wed, 21 Feb 2024 10:21:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rcoKo-0000sX-Uh
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 10:16:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rciWt-0008A4-4r
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 04:04:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708506278;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=D/Tk2oNGz3XzkXkLLisoFSz9dj2pFtxYP36p4UMDVJA=;
 b=IDlmQsj1bN3meeA+bN+lHGwT1nT4w4+dVg3n8zp8EN7ZNQJQfgVxHcc6sa67ry9LqcP2TO
 FNyza4AxP4vc0upDSEC2ptMK6NF+BzsVD0b/UYf2hVWNUMSInMZfbWSWUKK8469tb6Cm6S
 7dslXkAZI0WK1bnfqmBd4G7ntF+K9Xk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-107-VYTfrBoiOI2Qpvyj720P3w-1; Wed, 21 Feb 2024 04:04:36 -0500
X-MC-Unique: VYTfrBoiOI2Qpvyj720P3w-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-33d19eea6c3so177908f8f.2
 for <qemu-devel@nongnu.org>; Wed, 21 Feb 2024 01:04:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708506274; x=1709111074;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=D/Tk2oNGz3XzkXkLLisoFSz9dj2pFtxYP36p4UMDVJA=;
 b=XjCknjDH0wa0hJq7qLzlLFNXgarWNqXK8DJRYYoNo+kF0gEi7USlUKJfbFh5JgpoKF
 NOzVdtsNfhfJbcFqfiR/3TfMs8zANb+p6PPOdEXlDALvwlYePy5D3GvhyNpMLkhvl2sJ
 Z461Uxpb+7YVr+UTbCyGZYXinNQzaKisOpOQqh8O3qaoR+Q8Lgi9kyT1x/qH2V+Xh+jv
 N8/s+HD4F4ZXNivrkZkhQaT6kHwsltf9fnIlCJYTZ/Bx6jIb5FNQ+bJlKIwAe0dYncC1
 O21SVTf9xAAjy3fhkd1lIwVv1G+URZfrN4sF8ke/VxVHwX1nypJjGC/KGGeB7DFSd2bR
 SjfA==
X-Gm-Message-State: AOJu0YzWGN3pBW/HLZ51UWF/2lLIkCAxu735biAZiznNnwx+trKCUT6R
 yCsFWUS0fJrnmu0pfnFOhBHUny0dqwpGQPgKvZaQiTOoryvpuT5u7/S8u7TGZlZwP4OqgUWRsZM
 t3hQW65erRY4MFs1tPQp2onayAZfaLKwsmpInL6O7/yUcejQv0YkXDWFG2ksTDRLV3yIY/82t1O
 PFdYhDXvrZT1iBSDm6tbCo8cpGe0Sy0FyOxaA=
X-Received: by 2002:adf:e48d:0:b0:33d:269d:e222 with SMTP id
 i13-20020adfe48d000000b0033d269de222mr8076408wrm.23.1708506274046; 
 Wed, 21 Feb 2024 01:04:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEF7oRUKnAJyMAy3o9xqBbj0PoEmOEZl00rCk9Vh5gdSklmKvRFJJSbuAl22UMBuYU1gguNw0RPtNcKvKjmYUo=
X-Received: by 2002:adf:e48d:0:b0:33d:269d:e222 with SMTP id
 i13-20020adfe48d000000b0033d269de222mr8076392wrm.23.1708506273693; Wed, 21
 Feb 2024 01:04:33 -0800 (PST)
MIME-Version: 1.0
References: <20240220155352.416710-1-pbonzini@redhat.com>
 <8FECF57F-7897-4AF8-9AC1-46A927C0FEC0@gmail.com>
In-Reply-To: <8FECF57F-7897-4AF8-9AC1-46A927C0FEC0@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 21 Feb 2024 10:04:21 +0100
Message-ID: <CABgObfb+BK4s0VtwQUDkdzvwhTwRAXim-pJ-Lg1nWvbhuOm55w@mail.gmail.com>
Subject: Re: [PATCH] vl, pc: turn -no-fd-bootchk into a machine property
To: Bernhard Beschow <shentey@gmail.com>
Cc: qemu-devel@nongnu.org, philmd@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.05,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Tue, Feb 20, 2024 at 11:43=E2=80=AFPM Bernhard Beschow <shentey@gmail.co=
m> wrote:
>
>
>
> Am 20. Februar 2024 15:53:52 UTC schrieb Paolo Bonzini <pbonzini@redhat.c=
om>:
> >Add a fd-bootchk property to PC machine types, so that -no-fd-bootchk
> >returns an error if the machine does not support booting from floppies
> >and checking for boot signatures therein.
> >
> >Suggested-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> >Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> >---
> > include/hw/i386/pc.h |  2 +-
> > hw/i386/pc.c         | 30 +++++++++++++++++++++++++-----
> > system/globals.c     |  1 -
> > system/vl.c          |  2 +-
> > qemu-options.hx      |  2 +-
> > 5 files changed, 28 insertions(+), 9 deletions(-)
> >
> >diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
> >index 02a0deedd3c..e5382a02e7a 100644
> >--- a/include/hw/i386/pc.h
> >+++ b/include/hw/i386/pc.h
> >@@ -50,6 +50,7 @@ typedef struct PCMachineState {
> >     bool hpet_enabled;
> >     bool i8042_enabled;
> >     bool default_bus_bypass_iommu;
> >+    bool fd_bootchk;
> >     uint64_t max_fw_size;
> >
> >     /* ACPI Memory hotplug IO base address */
> >@@ -147,7 +148,6 @@ OBJECT_DECLARE_TYPE(PCMachineState, PCMachineClass, =
PC_MACHINE)
> > GSIState *pc_gsi_create(qemu_irq **irqs, bool pci_enabled);
> >
> > /* pc.c */
> >-extern int fd_bootchk;
> >
> > void pc_acpi_smi_interrupt(void *opaque, int irq, int level);
> >
> >diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> >index 28194014f82..31f4bb25a3e 100644
> >--- a/hw/i386/pc.c
> >+++ b/hw/i386/pc.c
> >@@ -399,8 +399,8 @@ static int boot_device2nibble(char boot_device)
> >     return 0;
> > }
> >
> >-static void set_boot_dev(MC146818RtcState *s, const char *boot_device,
> >-                         Error **errp)
> >+static void set_boot_dev(PCMachineState *pcms, MC146818RtcState *s,
> >+                         const char *boot_device, Error **errp)
> > {
> > #define PC_MAX_BOOT_DEVICES 3
> >     int nbds, bds[3] =3D { 0, };
> >@@ -420,12 +420,14 @@ static void set_boot_dev(MC146818RtcState *s, cons=
t char *boot_device,
> >         }
> >     }
> >     mc146818rtc_set_cmos_data(s, 0x3d, (bds[1] << 4) | bds[0]);
> >-    mc146818rtc_set_cmos_data(s, 0x38, (bds[2] << 4) | (fd_bootchk ? 0x=
0 : 0x1));
> >+    mc146818rtc_set_cmos_data(s, 0x38, (bds[2] << 4) | !pcms->fd_bootch=
k);
> > }
> >
> > static void pc_boot_set(void *opaque, const char *boot_device, Error **=
errp)
> > {
> >-    set_boot_dev(opaque, boot_device, errp);
> >+    PCMachineState *pcms =3D PC_MACHINE(current_machine);
> >+
> >+    set_boot_dev(pcms, opaque, boot_device, errp);
> > }
> >
> > static void pc_cmos_init_floppy(MC146818RtcState *rtc_state, ISADevice =
*floppy)
> >@@ -617,6 +619,9 @@ void pc_cmos_init(PCMachineState *pcms,
> >     mc146818rtc_set_cmos_data(s, 0x5c, val >> 8);
> >     mc146818rtc_set_cmos_data(s, 0x5d, val >> 16);
> >
> >+    object_property_add_bool(obj, "fd-bootchk", pc_machine_get_fd_bootc=
hk,
> >+                             pc_machine_set_fd_bootchk);
>
> Isn't it possible to turn this into a class property or add the property =
in pc_machine_initfn()? Aggregating properties in one place seems more comp=
rehensible to me.

Sure, I placed it in pc_cmos_init because rtc_state is already created here=
.

Paolo


