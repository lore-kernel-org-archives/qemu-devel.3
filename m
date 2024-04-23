Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2479C04FFE
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2024 18:33:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzKvz-0007je-7C; Tue, 23 Apr 2024 14:32:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rzKvx-0007j2-4u
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 14:32:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rzKvv-00064x-DV
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 14:32:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713897118;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AoSBB9LISbyZ3XUGtz6gYFMniR2mt0gcof37y2hy1UI=;
 b=g7Uc8RTZ1sVTCl54mCyDGx2dFhMuKFQ5AOOortMd1+fKSL3lMIqkr6b7k0qfaHs7zXiDZp
 Kbsxc1qYh6M+tWzf5gEX90FkLbRJS17rtf8fDmp1Y0McTtsPmfcQA/MIaOHHLF1InucKaR
 RO2KKHUsJ8PCF9RkwJpyeNzkNq5YcTQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-155-O5YkWyuNNkKKM3e0ALTl3A-1; Tue, 23 Apr 2024 14:31:55 -0400
X-MC-Unique: O5YkWyuNNkKKM3e0ALTl3A-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3473168c856so3967194f8f.1
 for <qemu-devel@nongnu.org>; Tue, 23 Apr 2024 11:31:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713897114; x=1714501914;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AoSBB9LISbyZ3XUGtz6gYFMniR2mt0gcof37y2hy1UI=;
 b=rrz0v11Y9+wuxdEpxYeWW6BfKGXfLv1ECdFiBpQTKsFnLtiQDssecBV7il5FFHOmsa
 5tVaZArO3FbL7Rtn8rcuxjv0B7z95km9k34tA0wWlb7KntP18U68h4merAE2yC3GRsyK
 ut1NwPiXWNd579zxoGYWVRwSVxpr3kUKCdkiWzsV6G/UkyNSV0VVTBsnfFQ5Rbc/XzRb
 ijfiOwPu11ddgu2UN6Ent6NMYW4fo1loik0Ces7PGvmfOYI0OibbMvBF2CEsgMOQitlc
 RBdMRZLlXHqWyVE+LPxIjPwr/OE3m0+XKJbE0HsuteAYJ33vPQa1MI+nzhSPeU6WzDWa
 AyHA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUhVT8x13abQBaloKKJXSS8wKvlr3aIm8wjBaPe+aXsE7NiU7Z1c0x64OVkp8076apYdbZTghJkB2uMV1PvI6DM/fxVarA=
X-Gm-Message-State: AOJu0YyKyq5eat6hhmN8p2SgIvv+cZugQkESqjloo7kQN/GQCSsv+iBO
 41EnRusqpA/q/1+GB+3J45MlFb104jJhwewdb5I7JM+ILAFNKqCjV3UQCR1peqMlysWViyUhJUI
 igHVDJxzO9aKKdVeqbbvd+057RiVniJnFjIY4NSaBnVWGIaxU8jNRRGHNpWVxhoqsr3766HogR4
 G6nOgVM39DTMXjCESVto6AuwpEjEQ=
X-Received: by 2002:a5d:69c1:0:b0:341:adf8:23c5 with SMTP id
 s1-20020a5d69c1000000b00341adf823c5mr29254wrw.56.1713897114770; 
 Tue, 23 Apr 2024 11:31:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEIqHWYzBiU1KxI1MtsX/8KVh/TOdsYQWOIVC9kBMS09rK8AfO+RbBaJ1/jHhwJDYFXYZu4Yepd4JZuxY7mruU=
X-Received: by 2002:a5d:69c1:0:b0:341:adf8:23c5 with SMTP id
 s1-20020a5d69c1000000b00341adf823c5mr29240wrw.56.1713897114393; Tue, 23 Apr
 2024 11:31:54 -0700 (PDT)
MIME-Version: 1.0
References: <20240423131612.28362-1-pbonzini@redhat.com>
 <20240423131612.28362-4-pbonzini@redhat.com>
 <87mspkhs8d.fsf@suse.de> <f37f5b29-256b-4549-90d0-0f41da7788d0@linaro.org>
In-Reply-To: <f37f5b29-256b-4549-90d0-0f41da7788d0@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 23 Apr 2024 20:31:43 +0200
Message-ID: <CABgObfZ-dUiBhjyL04vz8UoaZvkKCO-a+O63TxxgBEzOrCgt_Q@mail.gmail.com>
Subject: Re: [PATCH 03/22] arm: switch boards to "default y"
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel <qemu-devel@nongnu.org>
Content-Type: multipart/alternative; boundary="000000000000af81f20616c7c434"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.67,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

--000000000000af81f20616c7c434
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Il mar 23 apr 2024, 20:12 Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> h=
a
scritto:

> Hi Fabiano,
>
> On 23/4/24 20:02, Fabiano Rosas wrote:
> > Paolo Bonzini <pbonzini@redhat.com> writes:
> >
> >> For ARM targets, boards that require TCG are already using "default y"=
.
> >> Switch ARM_VIRT to the same selection mechanism.
> >>
> >> No changes to generated config-devices.mak file.
> >>
> >> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> >> ---
> >>   configs/devices/arm-softmmu/default.mak | 3 ++-
> >>   hw/arm/Kconfig                          | 2 ++
> >>   2 files changed, 4 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/configs/devices/arm-softmmu/default.mak
> b/configs/devices/arm-softmmu/default.mak
> >> index c1cfb3bcf75..31f77c20269 100644
> >> --- a/configs/devices/arm-softmmu/default.mak
> >> +++ b/configs/devices/arm-softmmu/default.mak
> >> @@ -5,7 +5,8 @@
> >>   # CONFIG_PCI_DEVICES=3Dn
> >>   # CONFIG_TEST_DEVICES=3Dn
> >>
> >> -CONFIG_ARM_VIRT=3Dy
> >> +# Boards are selected by default, uncomment to keep out of the build.
> >> +# CONFIG_ARM_VIRT=3Dn
> >>
> >>   # These are selected by default when TCG is enabled, uncomment them =
to
> >>   # keep out of the build.
> >> diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
> >> index 893a7bff66b..1e7cd01087f 100644
> >> --- a/hw/arm/Kconfig
> >> +++ b/hw/arm/Kconfig
> >> @@ -1,5 +1,7 @@
> >>   config ARM_VIRT
> >>       bool
> >> +    default y
> >> +    depends on ARM
> >>       imply PCI_DEVICES
> >
> > We lose pci.c when building --without-default-devices:
> >
> > $ arch
> > aarch64
> > $ ../configure --target-list=3Daarch64-softmmu,arm-softmmu
> > --disable-linux-user --without-default-devices
> > $ make
> > ...
> > libqemu-aarch64-softmmu.fa.p/target_arm_kvm.c.o: in function
> `kvm_arch_fixup_msi_route':
> > ../target/arm/kvm.c:1548: undefined reference to
> `pci_device_iommu_address_space'
>

I guess we can add something like

config AARCH64
    select PCI if KVM

Paolo

IIRC QEMU isn't yet ready to be built with --without-default-devices
> but without any machine, you need to explicit at least one. For
> example you can use --with-devices-aarch64=3Dminimal, or define a
> config with only the Virt machine.


Paolo


> Regards,
>
> Phil.
>
>

--000000000000af81f20616c7c434
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">Il mar 23 apr 2024, 20:12 Philippe Mathieu-Daud=C3=A9 =
&lt;<a href=3D"mailto:philmd@linaro.org" target=3D"_blank" rel=3D"noreferre=
r">philmd@linaro.org</a>&gt; ha scritto:<br></div><blockquote class=3D"gmai=
l_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left=
:1ex">Hi Fabiano,<br>
<br>
On 23/4/24 20:02, Fabiano Rosas wrote:<br>
&gt; Paolo Bonzini &lt;<a href=3D"mailto:pbonzini@redhat.com" rel=3D"norefe=
rrer noreferrer" target=3D"_blank">pbonzini@redhat.com</a>&gt; writes:<br>
&gt; <br>
&gt;&gt; For ARM targets, boards that require TCG are already using &quot;d=
efault y&quot;.<br>
&gt;&gt; Switch ARM_VIRT to the same selection mechanism.<br>
&gt;&gt;<br>
&gt;&gt; No changes to generated config-devices.mak file.<br>
&gt;&gt;<br>
&gt;&gt; Signed-off-by: Paolo Bonzini &lt;<a href=3D"mailto:pbonzini@redhat=
.com" rel=3D"noreferrer noreferrer" target=3D"_blank">pbonzini@redhat.com</=
a>&gt;<br>
&gt;&gt; ---<br>
&gt;&gt;=C2=A0 =C2=A0configs/devices/arm-softmmu/default.mak | 3 ++-<br>
&gt;&gt;=C2=A0 =C2=A0hw/arm/Kconfig=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 2 ++<br>
&gt;&gt;=C2=A0 =C2=A02 files changed, 4 insertions(+), 1 deletion(-)<br>
&gt;&gt;<br>
&gt;&gt; diff --git a/configs/devices/arm-softmmu/default.mak b/configs/dev=
ices/arm-softmmu/default.mak<br>
&gt;&gt; index c1cfb3bcf75..31f77c20269 100644<br>
&gt;&gt; --- a/configs/devices/arm-softmmu/default.mak<br>
&gt;&gt; +++ b/configs/devices/arm-softmmu/default.mak<br>
&gt;&gt; @@ -5,7 +5,8 @@<br>
&gt;&gt;=C2=A0 =C2=A0# CONFIG_PCI_DEVICES=3Dn<br>
&gt;&gt;=C2=A0 =C2=A0# CONFIG_TEST_DEVICES=3Dn<br>
&gt;&gt;=C2=A0 =C2=A0<br>
&gt;&gt; -CONFIG_ARM_VIRT=3Dy<br>
&gt;&gt; +# Boards are selected by default, uncomment to keep out of the bu=
ild.<br>
&gt;&gt; +# CONFIG_ARM_VIRT=3Dn<br>
&gt;&gt;=C2=A0 =C2=A0<br>
&gt;&gt;=C2=A0 =C2=A0# These are selected by default when TCG is enabled, u=
ncomment them to<br>
&gt;&gt;=C2=A0 =C2=A0# keep out of the build.<br>
&gt;&gt; diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig<br>
&gt;&gt; index 893a7bff66b..1e7cd01087f 100644<br>
&gt;&gt; --- a/hw/arm/Kconfig<br>
&gt;&gt; +++ b/hw/arm/Kconfig<br>
&gt;&gt; @@ -1,5 +1,7 @@<br>
&gt;&gt;=C2=A0 =C2=A0config ARM_VIRT<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0bool<br>
&gt;&gt; +=C2=A0 =C2=A0 default y<br>
&gt;&gt; +=C2=A0 =C2=A0 depends on ARM<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0imply PCI_DEVICES<br>
&gt; <br>
&gt; We lose pci.c when building --without-default-devices:<br>
&gt; <br>
&gt; $ arch<br>
&gt; aarch64<br>
&gt; $ ../configure --target-list=3Daarch64-softmmu,arm-softmmu<br>
&gt; --disable-linux-user --without-default-devices<br>
&gt; $ make<br>
&gt; ...<br>
&gt; libqemu-aarch64-softmmu.fa.p/target_arm_kvm.c.o: in function `kvm_arch=
_fixup_msi_route&#39;:<br>
&gt; ../target/arm/kvm.c:1548: undefined reference to `pci_device_iommu_add=
ress_space&#39;<br></blockquote></div></div><div dir=3D"auto"><br></div><di=
v dir=3D"auto">I guess we can add something like</div><div dir=3D"auto"><br=
></div><div dir=3D"auto">config AARCH64</div><div dir=3D"auto">=C2=A0 =C2=
=A0 select PCI if KVM</div><div dir=3D"auto"><br></div><div dir=3D"auto">Pa=
olo</div><div dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_=
quote"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-=
left:1px #ccc solid;padding-left:1ex">
IIRC QEMU isn&#39;t yet ready to be built with --without-default-devices<br=
>
but without any machine, you need to explicit at least one. For<br>
example you can use --with-devices-aarch64=3Dminimal, or define a<br>
config with only the Virt machine.</blockquote></div></div><div dir=3D"auto=
"><br></div><div dir=3D"auto">Paolo</div><div dir=3D"auto"><br></div><div d=
ir=3D"auto"><div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
Regards,<br>
<br>
Phil.<br>
<br>
</blockquote></div></div></div>

--000000000000af81f20616c7c434--


