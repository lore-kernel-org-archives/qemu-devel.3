Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 317D7CE7AE0
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2024 07:31:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smTR2-00062L-5c; Fri, 06 Sep 2024 03:31:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1smTR0-0005vx-Go
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 03:31:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1smTQy-0008K3-Q0
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 03:31:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725607866;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kAZjibxxz0GtWtc1oemf3IqnMbouYp7Up+8r1Wy12xQ=;
 b=M+bstGzuyFn5zAFua2x/IWpmptn006/K+9dDO7QZXxp/B0/MkTzMmiCKY7Kcj8QOAsnMOQ
 cKmYpb7VdOdSEOh0Nfr1BDuoegbeHcyxWZGkauLth6FPV8BcZbFuo84sfdbu5cLhCw+JoQ
 0Ye6baHZ9kQI70fm3bTrGONOHb9qL1w=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-637-h22vZSSMN6-TfRbk_HizNQ-1; Fri, 06 Sep 2024 03:31:04 -0400
X-MC-Unique: h22vZSSMN6-TfRbk_HizNQ-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-374baf9f142so861909f8f.2
 for <qemu-devel@nongnu.org>; Fri, 06 Sep 2024 00:31:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725607863; x=1726212663;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kAZjibxxz0GtWtc1oemf3IqnMbouYp7Up+8r1Wy12xQ=;
 b=VPffkaL9SYRNNCQx77t75XFQ69+nByKIw9LB1xqCPgzT0iBMaCs/xtkB+g+V7OMTu+
 tmheHSOuAMn/7B2sAhoWa7vSlrjiZNZZpXDy/SNfwmP+ZCemOyb6Q7tL6QQ4rsxOTDCZ
 hfeYi7vKwzbP50rUOfPFUwgWAbrq1jGEJGkLDc2tQiekVarvSd9O0CHHzFSORC7PIbZu
 3e7dG5+dMDc/bONxznD8jD8ZYMBefRSQveV7BlFKsO9EJ7zbI4MYg1JJeH7x+5dZSa3C
 njpdP967XuEojDba3/7Q74Oq5K808vZmOqEOf3lmVsHgUg+1PFCUXg+TXT+BHEcURaHT
 B+PQ==
X-Gm-Message-State: AOJu0YzGzI5qVPa70nbGPbR9f8YFNyCfRYoLAp0Be9XT9UtJFYPl0DOE
 OJK7XBV1PX6bk81GHztHaPor4ZrpLMCFOvOged7jPbJsKGGgV+os4k8DGOgqoONnU6mPQC7jXIS
 kW1AieaLZScjEh54MYpvCPYQ31DdMAWFY+sloe/oDShytBbRSesJ+NCBzoPbpc1pVMGDHq9Gc4d
 /VJdLbtcNdyF43RikSgrad1iFbH9M=
X-Received: by 2002:adf:f811:0:b0:374:cea0:7d3d with SMTP id
 ffacd0b85a97d-3788969ff56mr1005026f8f.53.1725607863297; 
 Fri, 06 Sep 2024 00:31:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFYrgd+FHErRmKq7CI8lZn4epT1Dr6OgxqLOzhjljvDyhXoAeypfowYtjf/8Fkob7ea4pP9v+6IyAN8gOvrFW4=
X-Received: by 2002:adf:f811:0:b0:374:cea0:7d3d with SMTP id
 ffacd0b85a97d-3788969ff56mr1005004f8f.53.1725607862746; Fri, 06 Sep 2024
 00:31:02 -0700 (PDT)
MIME-Version: 1.0
References: <20240423150951.41600-1-pbonzini@redhat.com>
 <20240423150951.41600-12-pbonzini@redhat.com>
 <7762115d-cf9d-4505-a3c7-6782433e2521@tls.msk.ru>
 <CABgObfbOZNudB3uycQGB31F0KXXhrVmhvi+wn9z9bANCmZQtZw@mail.gmail.com>
 <5e1eb96e-ad42-4053-9431-7fa5705495a7@tls.msk.ru>
In-Reply-To: <5e1eb96e-ad42-4053-9431-7fa5705495a7@tls.msk.ru>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 6 Sep 2024 09:30:50 +0200
Message-ID: <CABgObfZwHLj93bt7GhVyD6Ui8RwbNT-dWw-y6T=mBD37fKfmcA@mail.gmail.com>
Subject: Re: [PULL 11/63] hw/virtio: move stubs out of stubs/
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Fri, Sep 6, 2024 at 9:08=E2=80=AFAM Michael Tokarev <mjt@tls.msk.ru> wro=
te:
>
> 05.09.2024 19:27, Paolo Bonzini wrote:
> > On Sat, Aug 3, 2024 at 4:29=E2=80=AFAM Michael Tokarev <mjt@tls.msk.ru>=
 wrote:
> >>
> >> 23.04.2024 18:08, Paolo Bonzini wrote:
> >>> Since the virtio memory device stubs are needed exactly when the
> >>> Kconfig symbol is not enabled, they can be placed in hw/virtio/ and
> >>> conditionalized on CONFIG_VIRTIO_MD.
> >>>
> >>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> >>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> >>> Message-ID: <20240408155330.522792-12-pbonzini@redhat.com>
> >>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> >>> ---
> >>>    stubs/virtio-md-pci.c =3D> hw/virtio/virtio-md-stubs.c | 0
> >>>    hw/virtio/meson.build                                | 2 ++
> >>>    stubs/meson.build                                    | 1 -
> >>>    3 files changed, 2 insertions(+), 1 deletion(-)
> >>>    rename stubs/virtio-md-pci.c =3D> hw/virtio/virtio-md-stubs.c (100=
%)
> >>
> >> FWIW, this broke a minimal microvm build for debian:
> >>
> >> /usr/bin/ld: libqemu-x86_64-softmmu.a.p/hw_i386_pc.c.o: in function `p=
c_machine_device_pre_plug_cb':
> >> ./b/microvm/hw/i386/pc.c:1377: undefined reference to `virtio_md_pci_p=
re_plug'
> >> /usr/bin/ld: libqemu-x86_64-softmmu.a.p/hw_i386_pc.c.o: in function `p=
c_machine_device_unplug_request_cb':
> >> ./b/microvm/hw/i386/pc.c:1427: undefined reference to `virtio_md_pci_u=
nplug_request'
> >> /usr/bin/ld: libqemu-x86_64-softmmu.a.p/hw_i386_pc.c.o: in function `p=
c_machine_device_unplug_cb':
> >> ./b/microvm/hw/i386/pc.c:1443: undefined reference to `virtio_md_pci_u=
nplug'
> >> /usr/bin/ld: libqemu-x86_64-softmmu.a.p/hw_i386_pc.c.o: in function `p=
c_machine_device_plug_cb':
> >> ./b/microvm/hw/i386/pc.c:1413: undefined reference to `virtio_md_pci_p=
lug'
> >> collect2: error: ld returned 1 exit status
> >
> > Does it not link hw/virtio-virtio-md-stubs.c?
>
> The complete link line (it's done by using `cc -m64 @qemu-system-x86_64.r=
sp`) is attached.
>
> Yes, it does NOT link md-stubs.
>
> >   Can you send the
> > x86_64-softmmu-config-devices.mak file?
>
> Yeah, it was in my first email (to which you replied), here it is again:

No I meant the full config in the build directory. Anyway I could
reproduce this, the issue shows up because VIRTIO_MEM and VIRTIO_PMEM
are effectively PCI only but hw/virtio/Kconfig doesn't list the
dependency.

The fix is to either add CONFIG_VIRTIO_PCI=3Dy to microvm-devices.mak,
or to remove CONFIG_VIRTIO_MEM and CONFIG_VIRTIO_PMEM.

I'll shortly send a patch that will turn this into a compilation
failure with the following error

The following clauses were found for VIRTIO_MEM
    CONFIG_VIRTIO_MEM=3Dy
    config VIRTIO_MEM depends on VIRTIO_PCI
...
KconfigDataError: contradiction between clauses when setting VIRTIO_MEM

Paolo


