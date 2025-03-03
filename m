Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2871BC282C6
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Mar 2025 20:38:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpCX4-0000il-Eg; Mon, 03 Mar 2025 15:36:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1tpCWr-0000he-87
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 15:36:47 -0500
Received: from mail-ua1-x92b.google.com ([2607:f8b0:4864:20::92b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1tpCWh-0002LR-Sp
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 15:36:44 -0500
Received: by mail-ua1-x92b.google.com with SMTP id
 a1e0cc1a2514c-8671d8a9c3eso3941734241.3
 for <qemu-devel@nongnu.org>; Mon, 03 Mar 2025 12:36:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=philjordan-eu.20230601.gappssmtp.com; s=20230601; t=1741034194; x=1741638994;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=xQX+F52CrZxT5IYsWze/C+tjqJhaI6g7hnLoS8jTaVs=;
 b=KFrQ183aZEs7qlpDwuBqK9J4ntmrJGv2ZeLhKKqS3bfPzUP69aQ8KcujywxfZ+6627
 mZXZfav6V9FZsd7CtyBp2dQBXyJzT0cv8an/ZGq/FQMZB7oRKUCOJ7bBJY2SBEgxkksW
 a54xOu3bIyy8I7FKjigeA/wTkhlpv51s5obNtw7cZ0WZymXGTP8lroNcJazj1cWLr0DD
 eRp7552SROCVxkyghe2OlE8WBCmn6SPj5vf7WZ9GfA6Yhv///fiY3kipA34UT/gDk9wP
 MJtSmTXDWHASkVOse1aCLTqeNsdZCmPKZeKoBV2jv61JJrfutxl+4ls15TaEQBkf7Nkh
 eOQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741034194; x=1741638994;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xQX+F52CrZxT5IYsWze/C+tjqJhaI6g7hnLoS8jTaVs=;
 b=o4zZ6SE9rKLDsKMjfjWrtXvmzBlhM0YVlT3b4S6CgOMoKh1cns3BqM4qGQg1iG8Mfw
 BdaxkVKBHhy7kZZN3pyKkvQjzKNbLE4Dlv2yzWA+3USn8bapRWBX5mV57mPr/gjTbhgI
 Y7PQix9mOTaOyy/GxDKXEeCeWxGIE1XSyAoU0DOH6YJaor/LX6L3NGyn9EHp2l7USnTA
 PByd7jXk+Y9c5juaphuh0staLXrujDkMvs2aXJmU81vdVstBP4dZfrTugDmr2xD7Lfnr
 NnhsboRWCQFgu0VJOHTap6ds2d/jEu9BbZbG2+XY65HqNOL54qL7HXv0RUIzRvCFO25g
 h9AQ==
X-Gm-Message-State: AOJu0YzS/i62Ce2v/NRfxTticI4Jn0UO4n/I6sWwdxlQqNei9Fbwk9Ne
 okXrG9OuhUMDSXoG8f15qwHigVEQgv8oV0Qep/Mda3rNpzGZlzbdwIuKsTWBrbUBpT4uR6nrtwr
 jzZ4SDcM0oOw6A8SoHV5IRwSGZK7qNRnTSfmh
X-Gm-Gg: ASbGnctEoM0uu/bZV1vdENKq6gMtrS6F9mUyUOHg3CmdfV3ICEby1b09W0ULa/tXsJD
 lDSiwbX9y59FgOQacXj6h5t8Sf0QayLyq2CjJaXUJNg6W7u9L2WKZ/4+Sdb/CYMymBtvixVkieX
 uCzeaRvYLj+SjMvl94U742KJKEkA==
X-Google-Smtp-Source: AGHT+IGxmPl69VUqKfLNTsyWKJb9DQYUHdRL3zbTq+SKMDbiz/BL3K7px9fzrBkJs8e2ps/vmBTdYynORact56OQjU4=
X-Received: by 2002:a05:6102:2b8a:b0:4c1:7c38:135 with SMTP id
 ada2fe7eead31-4c17c3807dfmr5751166137.0.1741034194092; Mon, 03 Mar 2025
 12:36:34 -0800 (PST)
MIME-Version: 1.0
References: <20250112210056.16658-1-phil@philjordan.eu>
 <20250112210056.16658-12-phil@philjordan.eu>
 <2a4229cf-c789-41ed-ab46-0f0fd9efd19a@linaro.org>
In-Reply-To: <2a4229cf-c789-41ed-ab46-0f0fd9efd19a@linaro.org>
From: Phil Dennis-Jordan <phil@philjordan.eu>
Date: Mon, 3 Mar 2025 21:36:23 +0100
X-Gm-Features: AQ5f1JrtsqY2pzWLxRwusDISkqaLgddLICBPQy9d-zcfE57kCSx3Hp9stnwL4RE
Message-ID: <CAAibmn0tV_YLwJwcgfy5sZiPyeaBWE_FPOPEEE_0aZ7mMANFig@mail.gmail.com>
Subject: Re: [PATCH v17 11/11] hw/vmapple/vmapple: Add vmapple machine type
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, agraf@csgraf.de, peter.maydell@linaro.org, 
 pbonzini@redhat.com, mst@redhat.com, stefanha@redhat.com, kwolf@redhat.com, 
 hreitz@redhat.com, berrange@redhat.com, eduardo@habkost.net, 
 marcel.apfelbaum@gmail.com, marcandre.lureau@redhat.com, eblake@redhat.com, 
 armbru@redhat.com, qemu-block@nongnu.org, qemu-arm@nongnu.org, 
 Alexander Graf <graf@amazon.com>, Akihiko Odaki <akihiko.odaki@daynix.com>
Content-Type: multipart/alternative; boundary="000000000000ae6287062f761c1e"
Received-SPF: neutral client-ip=2607:f8b0:4864:20::92b;
 envelope-from=phil@philjordan.eu; helo=mail-ua1-x92b.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NEUTRAL=0.779 autolearn=no autolearn_force=no
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

--000000000000ae6287062f761c1e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 3 Mar 2025 at 19:20, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org=
>
wrote:

> On 12/1/25 22:00, Phil Dennis-Jordan wrote:
> > From: Alexander Graf <graf@amazon.com>
> >
> > Apple defines a new "vmapple" machine type as part of its proprietary
> > macOS Virtualization.Framework vmm. This machine type is similar to the
> > virt one, but with subtle differences in base devices, a few special
> > vmapple device additions and a vastly different boot chain.
> >
> > This patch reimplements this machine type in QEMU. To use it, you
> > have to have a readily installed version of macOS for VMApple,
> > run on macOS with -accel hvf, pass the Virtualization.Framework
> > boot rom (AVPBooter) in via -bios, pass the aux and root volume as pfla=
sh
> > and pass aux and root volume as virtio drives. In addition, you also
> > need to find the machine UUID and pass that as -M vmapple,uuid=3D
> parameter:
> >
> > $ qemu-system-aarch64 -accel hvf -M vmapple,uuid=3D0x1234 -m 4G \
> >      -bios
> /System/Library/Frameworks/Virtualization.framework/Versions/A/Resources/=
AVPBooter.vmapple2.bin
> >      -drive file=3Daux,if=3Dpflash,format=3Draw \
> >      -drive file=3Droot,if=3Dpflash,format=3Draw \
> >      -drive file=3Daux,if=3Dnone,id=3Daux,format=3Draw \
> >      -device vmapple-virtio-blk-pci,variant=3Daux,drive=3Daux \
> >      -drive file=3Droot,if=3Dnone,id=3Droot,format=3Draw \
> >      -device vmapple-virtio-blk-pci,variant=3Droot,drive=3Droot
> >
> > With all these in place, you should be able to see macOS booting
> > successfully.
> >
> > Known issues:
> >   - Currently only macOS 12 guests are supported. The boot process for
> >     13+ will need further investigation and adjustment.
> >
> > Signed-off-by: Alexander Graf <graf@amazon.com>
> > Co-authored-by: Phil Dennis-Jordan <phil@philjordan.eu>
> > Signed-off-by: Phil Dennis-Jordan <phil@philjordan.eu>
> > Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> > ---
>
>
> >   MAINTAINERS                 |   1 +
> >   contrib/vmapple/uuid.sh     |   9 +
> >   docs/system/arm/vmapple.rst |  63 ++++
> >   docs/system/target-arm.rst  |   1 +
> >   hw/vmapple/Kconfig          |  20 ++
> >   hw/vmapple/meson.build      |   1 +
> >   hw/vmapple/vmapple.c        | 618 +++++++++++++++++++++++++++++++++++=
+
> >   7 files changed, 713 insertions(+)
> >   create mode 100755 contrib/vmapple/uuid.sh
> >   create mode 100644 docs/system/arm/vmapple.rst
> >   create mode 100644 hw/vmapple/vmapple.c
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index e220744abf..3a3d9e19f4 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -2791,6 +2791,7 @@ M: Phil Dennis-Jordan <phil@philjordan.eu>
> >   S: Maintained
> >   F: hw/vmapple/*
> >   F: include/hw/vmapple/*
> > +F: docs/system/arm/vmapple.rst
> >
> >   Subsystems
> >   ----------
> > diff --git a/contrib/vmapple/uuid.sh b/contrib/vmapple/uuid.sh
> > new file mode 100755
> > index 0000000000..956e8c3afe
> > --- /dev/null
> > +++ b/contrib/vmapple/uuid.sh
> > @@ -0,0 +1,9 @@
> > +#!/bin/sh
> > +# Used for converting a guest provisioned using Virtualization.framewo=
rk
> > +# for use with the QEMU 'vmapple' aarch64 machine type.
> > +#
> > +# Extracts the Machine UUID from Virtualization.framework VM JSON file=
.
> > +# (as produced by 'macosvm', passed as command line argument)
> > +
> > +plutil -extract machineId raw "$1" | base64 -d | plutil -extract ECID
> raw -
> > +
> > diff --git a/docs/system/arm/vmapple.rst b/docs/system/arm/vmapple.rst
> > new file mode 100644
> > index 0000000000..5090a8997c
> > --- /dev/null
> > +++ b/docs/system/arm/vmapple.rst
> > @@ -0,0 +1,63 @@
>
> Alex, Phil, we now mandate a SPDX tag. Due to the license used in
> vmapple.c in this patch, are you OK with me squashing here:


Sorry about that, I forgot all about the SPDX tags in scripts and docs -
yes, please add that SPDX on uuid.sh. The vmapple.rst is Alex's creation (I
think I tweaked a few lines max) - but if that's the usual license we use
for documentation as well then it seems a reasonable assumption to use
GPL2+ there too if we don't hear from him.

Thanks for the doc syntax fix as well.

-- >8 --
> diff --git a/docs/system/arm/vmapple.rst b/docs/system/arm/vmapple.rst
> index 5090a8997c3..c5b1bcf45ea 100644
> --- a/docs/system/arm/vmapple.rst
> +++ b/docs/system/arm/vmapple.rst
> @@ -0,0 +1,2 @@
> +.. SPDX-License-Identifier: GPL-2.0-or-later
> +
> diff --git a/contrib/vmapple/uuid.sh b/contrib/vmapple/uuid.sh
> index 956e8c3afed..f5637221d23 100755
> --- a/contrib/vmapple/uuid.sh
> +++ b/contrib/vmapple/uuid.sh
> @@ -1,0 +2 @@
> +#
> @@ -6,0 +8,2 @@
> +#
> +# SPDX-License-Identifier: GPL-2.0-or-later
> ---
>
> ?
>
> > +VMApple machine emulation
> >
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +VMApple is the device model that the macOS built-in hypervisor called
> "Virtualization.framework"
> > +exposes to Apple Silicon macOS guests. The "vmapple" machine model in
> QEMU implements the same
> > +device model, but does not use any code from Virtualization.Framework.
> > +
> > +Prerequisites
> > +-------------
> > +
> > +To run the vmapple machine model, you need to
> > +
> > + * Run on Apple Silicon
> > + * Run on macOS 12.0 or above
> > + * Have an already installed copy of a Virtualization.Framework macOS
> 12 virtual
> > +   machine. Note that newer versions than 12.x are currently NOT
> supported on
> > +   the guest side. I will assume that you installed it using the
> > +   `macosvm <https://github.com/s-u/macosvm>` CLI.
> > +
> > +First, we need to extract the UUID from the virtual machine that you
> installed. You can do this
> > +by running the shell script in contrib/vmapple/uuid.sh on the
> macosvm.json file.
> > +
> > +.. code-block:: bash
> > +  :caption: uuid.sh script to extract the UUID from a macosvm.json fil=
e
> > +
> > +  $ contrib/vmapple/uuid.sh "path/to/macosvm.json"
> > +
> > +Now we also need to trim the aux partition. It contains metadata that
> we can just discard:
> > +
> > +.. code-block:: bash
> > +  :caption: Command to trim the aux file
> > +
> > +  $ dd if=3D"aux.img" of=3D"aux.img.trimmed" bs=3D$(( 0x4000 )) skip=
=3D1
> > +
> > +How to run
> > +----------
> > +
> > +Then, we can launch QEMU with the Virtualization.Framework pre-boot
> environment and the readily
> > +installed target disk images. I recommend to port forward the VM's ssh
> and vnc ports to the host
> > +to get better interactive access into the target system:
> > +
> > +.. code-block:: bash
> > +  :caption: Example execution command line
> > +
> > +  $ UUID=3D"$(contrib/vmapple/uuid.sh 'macosvm.json')"
> > +  $
> AVPBOOTER=3D"/System/Library/Frameworks/Virtualization.framework/Resource=
s/AVPBooter.vmapple2.bin"
> > +  $ AUX=3D"aux.img.trimmed"
> > +  $ DISK=3D"disk.img"
> > +  $ qemu-system-aarch64 \
> > +       -serial mon:stdio \
> > +       -m 4G \
> > +       -accel hvf \
> > +       -M vmapple,uuid=3D"$UUID" \
> > +       -bios "$AVPBOOTER" \
> > +       -drive file=3D"$AUX",if=3Dpflash,format=3Draw \
> > +       -drive file=3D"$DISK",if=3Dpflash,format=3Draw \
> > +       -drive file=3D"$AUX",if=3Dnone,id=3Daux,format=3Draw \
> > +       -drive file=3D"$DISK",if=3Dnone,id=3Droot,format=3Draw \
> > +       -device vmapple-virtio-blk-pci,variant=3Daux,drive=3Daux \
> > +       -device vmapple-virtio-blk-pci,variant=3Droot,drive=3Droot \
> > +       -netdev
> user,id=3Dnet0,ipv6=3Doff,hostfwd=3Dtcp::2222-:22,hostfwd=3Dtcp::5901-:59=
00 \
> > +       -device virtio-net-pci,netdev=3Dnet0
> > +
>

--000000000000ae6287062f761c1e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, 3 Mar 2=
025 at 19:20, Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@lina=
ro.org">philmd@linaro.org</a>&gt; wrote:<br></div><blockquote class=3D"gmai=
l_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,20=
4,204);padding-left:1ex">On 12/1/25 22:00, Phil Dennis-Jordan wrote:<br>
&gt; From: Alexander Graf &lt;<a href=3D"mailto:graf@amazon.com" target=3D"=
_blank">graf@amazon.com</a>&gt;<br>
&gt; <br>
&gt; Apple defines a new &quot;vmapple&quot; machine type as part of its pr=
oprietary<br>
&gt; macOS Virtualization.Framework vmm. This machine type is similar to th=
e<br>
&gt; virt one, but with subtle differences in base devices, a few special<b=
r>
&gt; vmapple device additions and a vastly different boot chain.<br>
&gt; <br>
&gt; This patch reimplements this machine type in QEMU. To use it, you<br>
&gt; have to have a readily installed version of macOS for VMApple,<br>
&gt; run on macOS with -accel hvf, pass the Virtualization.Framework<br>
&gt; boot rom (AVPBooter) in via -bios, pass the aux and root volume as pfl=
ash<br>
&gt; and pass aux and root volume as virtio drives. In addition, you also<b=
r>
&gt; need to find the machine UUID and pass that as -M vmapple,uuid=3D para=
meter:<br>
&gt; <br>
&gt; $ qemu-system-aarch64 -accel hvf -M vmapple,uuid=3D0x1234 -m 4G \<br>
&gt;=C2=A0 =C2=A0 =C2=A0 -bios /System/Library/Frameworks/Virtualization.fr=
amework/Versions/A/Resources/AVPBooter.vmapple2.bin<br>
&gt;=C2=A0 =C2=A0 =C2=A0 -drive file=3Daux,if=3Dpflash,format=3Draw \<br>
&gt;=C2=A0 =C2=A0 =C2=A0 -drive file=3Droot,if=3Dpflash,format=3Draw \<br>
&gt;=C2=A0 =C2=A0 =C2=A0 -drive file=3Daux,if=3Dnone,id=3Daux,format=3Draw =
\<br>
&gt;=C2=A0 =C2=A0 =C2=A0 -device vmapple-virtio-blk-pci,variant=3Daux,drive=
=3Daux \<br>
&gt;=C2=A0 =C2=A0 =C2=A0 -drive file=3Droot,if=3Dnone,id=3Droot,format=3Dra=
w \<br>
&gt;=C2=A0 =C2=A0 =C2=A0 -device vmapple-virtio-blk-pci,variant=3Droot,driv=
e=3Droot<br>
&gt; <br>
&gt; With all these in place, you should be able to see macOS booting<br>
&gt; successfully.<br>
&gt; <br>
&gt; Known issues:<br>
&gt;=C2=A0 =C2=A0- Currently only macOS 12 guests are supported. The boot p=
rocess for<br>
&gt;=C2=A0 =C2=A0 =C2=A013+ will need further investigation and adjustment.=
<br>
&gt; <br>
&gt; Signed-off-by: Alexander Graf &lt;<a href=3D"mailto:graf@amazon.com" t=
arget=3D"_blank">graf@amazon.com</a>&gt;<br>
&gt; Co-authored-by: Phil Dennis-Jordan &lt;<a href=3D"mailto:phil@philjord=
an.eu" target=3D"_blank">phil@philjordan.eu</a>&gt;<br>
&gt; Signed-off-by: Phil Dennis-Jordan &lt;<a href=3D"mailto:phil@philjorda=
n.eu" target=3D"_blank">phil@philjordan.eu</a>&gt;<br>
&gt; Reviewed-by: Akihiko Odaki &lt;<a href=3D"mailto:akihiko.odaki@daynix.=
com" target=3D"_blank">akihiko.odaki@daynix.com</a>&gt;<br>
&gt; ---<br>
<br>
<br>
&gt;=C2=A0 =C2=A0MAINTAINERS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A01 +<br>
&gt;=C2=A0 =C2=A0contrib/vmapple/uuid.sh=C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A09=
 +<br>
&gt;=C2=A0 =C2=A0docs/system/arm/vmapple.rst |=C2=A0 63 ++++<br>
&gt;=C2=A0 =C2=A0docs/system/target-arm.rst=C2=A0 |=C2=A0 =C2=A01 +<br>
&gt;=C2=A0 =C2=A0hw/vmapple/Kconfig=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=
=A0 20 ++<br>
&gt;=C2=A0 =C2=A0hw/vmapple/meson.build=C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A01=
 +<br>
&gt;=C2=A0 =C2=A0hw/vmapple/vmapple.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 | 618 ++++=
++++++++++++++++++++++++++++++++<br>
&gt;=C2=A0 =C2=A07 files changed, 713 insertions(+)<br>
&gt;=C2=A0 =C2=A0create mode 100755 contrib/vmapple/uuid.sh<br>
&gt;=C2=A0 =C2=A0create mode 100644 docs/system/arm/vmapple.rst<br>
&gt;=C2=A0 =C2=A0create mode 100644 hw/vmapple/vmapple.c<br>
&gt; <br>
&gt; diff --git a/MAINTAINERS b/MAINTAINERS<br>
&gt; index e220744abf..3a3d9e19f4 100644<br>
&gt; --- a/MAINTAINERS<br>
&gt; +++ b/MAINTAINERS<br>
&gt; @@ -2791,6 +2791,7 @@ M: Phil Dennis-Jordan &lt;<a href=3D"mailto:phil=
@philjordan.eu" target=3D"_blank">phil@philjordan.eu</a>&gt;<br>
&gt;=C2=A0 =C2=A0S: Maintained<br>
&gt;=C2=A0 =C2=A0F: hw/vmapple/*<br>
&gt;=C2=A0 =C2=A0F: include/hw/vmapple/*<br>
&gt; +F: docs/system/arm/vmapple.rst<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0Subsystems<br>
&gt;=C2=A0 =C2=A0----------<br>
&gt; diff --git a/contrib/vmapple/uuid.sh b/contrib/vmapple/uuid.sh<br>
&gt; new file mode 100755<br>
&gt; index 0000000000..956e8c3afe<br>
&gt; --- /dev/null<br>
&gt; +++ b/contrib/vmapple/uuid.sh<br>
&gt; @@ -0,0 +1,9 @@<br>
&gt; +#!/bin/sh<br>
&gt; +# Used for converting a guest provisioned using Virtualization.framew=
ork<br>
&gt; +# for use with the QEMU &#39;vmapple&#39; aarch64 machine type.<br>
&gt; +#<br>
&gt; +# Extracts the Machine UUID from Virtualization.framework VM JSON fil=
e.<br>
&gt; +# (as produced by &#39;macosvm&#39;, passed as command line argument)=
<br>
&gt; +<br>
&gt; +plutil -extract machineId raw &quot;$1&quot; | base64 -d | plutil -ex=
tract ECID raw -<br>
&gt; +<br>
&gt; diff --git a/docs/system/arm/vmapple.rst b/docs/system/arm/vmapple.rst=
<br>
&gt; new file mode 100644<br>
&gt; index 0000000000..5090a8997c<br>
&gt; --- /dev/null<br>
&gt; +++ b/docs/system/arm/vmapple.rst<br>
&gt; @@ -0,0 +1,63 @@<br>
<br>
Alex, Phil, we now mandate a SPDX tag. Due to the license used in<br>
vmapple.c in this patch, are you OK with me squashing here:</blockquote><di=
v><br></div><div>Sorry about that, I forgot all about the SPDX tags in scri=
pts and docs - yes, please add that SPDX on uuid.sh. The vmapple.rst is Ale=
x&#39;s creation (I think I tweaked a few lines max) - but if that&#39;s th=
e usual license we use for documentation as well then it seems a reasonable=
 assumption to use GPL2+ there too if we don&#39;t hear from him.</div><div=
>=C2=A0</div><div>Thanks for the doc syntax fix as well.</div><div><br></di=
v><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;borde=
r-left:1px solid rgb(204,204,204);padding-left:1ex">
-- &gt;8 --<br>
diff --git a/docs/system/arm/vmapple.rst b/docs/system/arm/vmapple.rst<br>
index 5090a8997c3..c5b1bcf45ea 100644<br>
--- a/docs/system/arm/vmapple.rst<br>
+++ b/docs/system/arm/vmapple.rst<br>
@@ -0,0 +1,2 @@<br>
+.. SPDX-License-Identifier: GPL-2.0-or-later<br>
+<br>
diff --git a/contrib/vmapple/uuid.sh b/contrib/vmapple/uuid.sh<br>
index 956e8c3afed..f5637221d23 100755<br>
--- a/contrib/vmapple/uuid.sh<br>
+++ b/contrib/vmapple/uuid.sh<br>
@@ -1,0 +2 @@<br>
+#<br>
@@ -6,0 +8,2 @@<br>
+#<br>
+# SPDX-License-Identifier: GPL-2.0-or-later<br>
---<br>
<br>
?<br>
<br>
&gt; +VMApple machine emulation<br>
&gt; +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
&gt; +<br>
&gt; +VMApple is the device model that the macOS built-in hypervisor called=
 &quot;Virtualization.framework&quot;<br>
&gt; +exposes to Apple Silicon macOS guests. The &quot;vmapple&quot; machin=
e model in QEMU implements the same<br>
&gt; +device model, but does not use any code from Virtualization.Framework=
.<br>
&gt; +<br>
&gt; +Prerequisites<br>
&gt; +-------------<br>
&gt; +<br>
&gt; +To run the vmapple machine model, you need to<br>
&gt; +<br>
&gt; + * Run on Apple Silicon<br>
&gt; + * Run on macOS 12.0 or above<br>
&gt; + * Have an already installed copy of a Virtualization.Framework macOS=
 12 virtual<br>
&gt; +=C2=A0 =C2=A0machine. Note that newer versions than 12.x are currentl=
y NOT supported on<br>
&gt; +=C2=A0 =C2=A0the guest side. I will assume that you installed it usin=
g the<br>
&gt; +=C2=A0 =C2=A0`macosvm &lt;<a href=3D"https://github.com/s-u/macosvm" =
rel=3D"noreferrer" target=3D"_blank">https://github.com/s-u/macosvm</a>&gt;=
` CLI.<br>
&gt; +<br>
&gt; +First, we need to extract the UUID from the virtual machine that you =
installed. You can do this<br>
&gt; +by running the shell script in contrib/vmapple/uuid.sh on the macosvm=
.json file.<br>
&gt; +<br>
&gt; +.. code-block:: bash<br>
&gt; +=C2=A0 :caption: uuid.sh script to extract the UUID from a macosvm.js=
on file<br>
&gt; +<br>
&gt; +=C2=A0 $ contrib/vmapple/uuid.sh &quot;path/to/macosvm.json&quot;<br>
&gt; +<br>
&gt; +Now we also need to trim the aux partition. It contains metadata that=
 we can just discard:<br>
&gt; +<br>
&gt; +.. code-block:: bash<br>
&gt; +=C2=A0 :caption: Command to trim the aux file<br>
&gt; +<br>
&gt; +=C2=A0 $ dd if=3D&quot;aux.img&quot; of=3D&quot;aux.img.trimmed&quot;=
 bs=3D$(( 0x4000 )) skip=3D1<br>
&gt; +<br>
&gt; +How to run<br>
&gt; +----------<br>
&gt; +<br>
&gt; +Then, we can launch QEMU with the Virtualization.Framework pre-boot e=
nvironment and the readily<br>
&gt; +installed target disk images. I recommend to port forward the VM&#39;=
s ssh and vnc ports to the host<br>
&gt; +to get better interactive access into the target system:<br>
&gt; +<br>
&gt; +.. code-block:: bash<br>
&gt; +=C2=A0 :caption: Example execution command line<br>
&gt; +<br>
&gt; +=C2=A0 $ UUID=3D&quot;$(contrib/vmapple/uuid.sh &#39;macosvm.json&#39=
;)&quot;<br>
&gt; +=C2=A0 $ AVPBOOTER=3D&quot;/System/Library/Frameworks/Virtualization.=
framework/Resources/AVPBooter.vmapple2.bin&quot;<br>
&gt; +=C2=A0 $ AUX=3D&quot;aux.img.trimmed&quot;<br>
&gt; +=C2=A0 $ DISK=3D&quot;disk.img&quot;<br>
&gt; +=C2=A0 $ qemu-system-aarch64 \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0-serial mon:stdio \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0-m 4G \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0-accel hvf \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0-M vmapple,uuid=3D&quot;$UUID&quot; \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0-bios &quot;$AVPBOOTER&quot; \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0-drive file=3D&quot;$AUX&quot;,if=3Dpflash=
,format=3Draw \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0-drive file=3D&quot;$DISK&quot;,if=3Dpflas=
h,format=3Draw \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0-drive file=3D&quot;$AUX&quot;,if=3Dnone,i=
d=3Daux,format=3Draw \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0-drive file=3D&quot;$DISK&quot;,if=3Dnone,=
id=3Droot,format=3Draw \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0-device vmapple-virtio-blk-pci,variant=3Da=
ux,drive=3Daux \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0-device vmapple-virtio-blk-pci,variant=3Dr=
oot,drive=3Droot \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0-netdev user,id=3Dnet0,ipv6=3Doff,hostfwd=
=3Dtcp::2222-:22,hostfwd=3Dtcp::5901-:5900 \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0-device virtio-net-pci,netdev=3Dnet0<br>
&gt; +<br>
</blockquote></div></div>

--000000000000ae6287062f761c1e--

