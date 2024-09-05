Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A08AACD5BD7
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2024 16:28:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smFKs-0005X7-PW; Thu, 05 Sep 2024 12:27:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1smFKr-0005Vw-3d
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 12:27:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1smFKp-0008Rt-LN
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 12:27:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725553670;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KypJTrR1yl+wn8WDsv7b1dNMyskgXfN0RUOvrUCNm2Q=;
 b=LpvWO4+9po4rwlDYcyF2lE0dxoUg4yELGAO8zFf6OXSoWOmbymkIVtOSED+0xbQQYzWnJP
 PLimTBHsTPp8PWT+4zKiXikYI0LXjAwuVhQBIL2vNWj2rYz50CWHueNq0DFi+bDM5lbAvF
 YITZIHaSOu3XUyPHCfgdUUIKUpKPJFU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-340-QoynB_8oN8SarDgoMq-vNg-1; Thu, 05 Sep 2024 12:27:48 -0400
X-MC-Unique: QoynB_8oN8SarDgoMq-vNg-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-42bb9fa67d7so10414745e9.0
 for <qemu-devel@nongnu.org>; Thu, 05 Sep 2024 09:27:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725553667; x=1726158467;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KypJTrR1yl+wn8WDsv7b1dNMyskgXfN0RUOvrUCNm2Q=;
 b=ZY3m7EbvqAw17yTYC4ym1rAaGFpuMDYRIOV59LmXVni/us8XZwa7skCIBBpdA688gR
 9iHLyE2Tr/ZbsOFIW37zdBm8g3HpB4TVL6byJdHcO3WlivCh43EtHh+NBHAurxpwOrfw
 x8A/CL94xpgJUB3VtiXmZhJfdaklx1WyGTakkjxYADS6yS2Czi/WNJLa5WQz7pzyn/bD
 B5lPtPXRlYZoNck9DH7ijo0UY9QuyLTMdt2qTl4Ol7jEaLanGNIZUa3v04Okn2i74txr
 BoRWS7mpa5YnrLl4hyIE1x06wTre67FaFcx9kMWiBdgoURkmLos2dZqPa+xYiAOTRcuJ
 4wng==
X-Gm-Message-State: AOJu0Yz7eIjUAKIJ0PrjG53wKC1R7GdWquWsDvSxptx/dL40Y1AbwQjp
 L2spI0flmCbSHlm2rg/2QEaQ9DN3Uu+xOuW6FUsVqisnUiRRP9mnjLhikzYUoxV6lRuive82XQs
 xacRcDLjvAX7uoxDpfao6oJWs3BdAcYT5tLlkUu05t3pG03DPrrmZedf9C1wWB8+6IV6sa/u/RE
 xxoVtWD9N9kHkPosmeKUTpOcR41Bc=
X-Received: by 2002:adf:fecd:0:b0:374:bf18:6092 with SMTP id
 ffacd0b85a97d-374bf1866a6mr15761166f8f.38.1725553667436; 
 Thu, 05 Sep 2024 09:27:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG6A0qVUh2oFMRjvDUn8XDuWAUUyzIvs3Ukwnc7FLoxyluERrd/oAsLb11AkhS8HU67nkOq3nhxW2uRL8xyeWc=
X-Received: by 2002:adf:fecd:0:b0:374:bf18:6092 with SMTP id
 ffacd0b85a97d-374bf1866a6mr15761143f8f.38.1725553666918; Thu, 05 Sep 2024
 09:27:46 -0700 (PDT)
MIME-Version: 1.0
References: <20240423150951.41600-1-pbonzini@redhat.com>
 <20240423150951.41600-12-pbonzini@redhat.com>
 <7762115d-cf9d-4505-a3c7-6782433e2521@tls.msk.ru>
In-Reply-To: <7762115d-cf9d-4505-a3c7-6782433e2521@tls.msk.ru>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 5 Sep 2024 18:27:34 +0200
Message-ID: <CABgObfbOZNudB3uycQGB31F0KXXhrVmhvi+wn9z9bANCmZQtZw@mail.gmail.com>
Subject: Re: [PULL 11/63] hw/virtio: move stubs out of stubs/
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Sat, Aug 3, 2024 at 4:29=E2=80=AFAM Michael Tokarev <mjt@tls.msk.ru> wro=
te:
>
> 23.04.2024 18:08, Paolo Bonzini wrote:
> > Since the virtio memory device stubs are needed exactly when the
> > Kconfig symbol is not enabled, they can be placed in hw/virtio/ and
> > conditionalized on CONFIG_VIRTIO_MD.
> >
> > Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> > Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> > Message-ID: <20240408155330.522792-12-pbonzini@redhat.com>
> > Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> > ---
> >   stubs/virtio-md-pci.c =3D> hw/virtio/virtio-md-stubs.c | 0
> >   hw/virtio/meson.build                                | 2 ++
> >   stubs/meson.build                                    | 1 -
> >   3 files changed, 2 insertions(+), 1 deletion(-)
> >   rename stubs/virtio-md-pci.c =3D> hw/virtio/virtio-md-stubs.c (100%)
>
> FWIW, this broke a minimal microvm build for debian:
>
> /usr/bin/ld: libqemu-x86_64-softmmu.a.p/hw_i386_pc.c.o: in function `pc_m=
achine_device_pre_plug_cb':
> ./b/microvm/hw/i386/pc.c:1377: undefined reference to `virtio_md_pci_pre_=
plug'
> /usr/bin/ld: libqemu-x86_64-softmmu.a.p/hw_i386_pc.c.o: in function `pc_m=
achine_device_unplug_request_cb':
> ./b/microvm/hw/i386/pc.c:1427: undefined reference to `virtio_md_pci_unpl=
ug_request'
> /usr/bin/ld: libqemu-x86_64-softmmu.a.p/hw_i386_pc.c.o: in function `pc_m=
achine_device_unplug_cb':
> ./b/microvm/hw/i386/pc.c:1443: undefined reference to `virtio_md_pci_unpl=
ug'
> /usr/bin/ld: libqemu-x86_64-softmmu.a.p/hw_i386_pc.c.o: in function `pc_m=
achine_device_plug_cb':
> ./b/microvm/hw/i386/pc.c:1413: undefined reference to `virtio_md_pci_plug=
'
> collect2: error: ld returned 1 exit status

Does it not link hw/virtio-virtio-md-stubs.c? Can you send the
x86_64-softmmu-config-devices.mak file?

Paolo


