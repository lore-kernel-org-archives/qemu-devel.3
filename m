Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66296E7718B
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Dec 2024 12:19:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tR9JK-0007aK-A8; Fri, 27 Dec 2024 07:19:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1tR9JG-0007ZX-Jk
 for qemu-devel@nongnu.org; Fri, 27 Dec 2024 07:19:18 -0500
Received: from mail-vs1-xe30.google.com ([2607:f8b0:4864:20::e30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1tR9JB-0005to-Uu
 for qemu-devel@nongnu.org; Fri, 27 Dec 2024 07:19:18 -0500
Received: by mail-vs1-xe30.google.com with SMTP id
 ada2fe7eead31-4afe6a8d2e1so3826311137.1
 for <qemu-devel@nongnu.org>; Fri, 27 Dec 2024 04:19:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=philjordan-eu.20230601.gappssmtp.com; s=20230601; t=1735301952; x=1735906752;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=M+2N/U6FtPJ9UQqwBoTgTe4SF4lUe7aN4+USflgGiB8=;
 b=duCDLsnbxCs3LkqFsgrHmO/P4L6jnlmAU/T7/gqqKWyyxZ0NGNUbOt/nDXk1mD/oaK
 EM+aFQNG16Mg+IM1NNNfyodjmOFb90uU3yJsVs52VejeO+G5dWNnQMcPbfKr0MpZr/sW
 3RM+oSpIyyqoOLAUhsAGfFKZbzUadk+qUNltvN2doygQpUK57aQfl81MhWnCV7ft5+Gl
 ZFjv9PKqVbXRb/M3mm0LBfTCxU8mTj9/9cD2gkpUr2sI/v6Kp/43+GSB0+Ao0pY6n9Nc
 gVhPIznBjh8G1bKfXJEhNuUWYGwVO75I1blTM+gsf+YKSncpLDFnSyXxDPaUug2aA10O
 rNiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735301952; x=1735906752;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=M+2N/U6FtPJ9UQqwBoTgTe4SF4lUe7aN4+USflgGiB8=;
 b=lTDvmKWvA1YSaz/CoJQshW66vvrE6sK6U74zKjRVZLeBJRcQfVvW6LIpieKICh9H8N
 kOjU9s/fnTdFbd/e81qGrq3/pPpsYLyz7CtgoJBDH0UECxUpCPrh0uEoOcV7fo3JGX+V
 zA8pLkm9Rdff66XZhMHrWPpUcv0kq4Zk9gnO1jizVj++5UK+qHAqJgx0DqxHznkZI6wT
 CCXx/m1Vx5Sn8grPJD2ePY7+rjlUKOPL0FCiB/snPed0NssuL1VDIh0kXfuqVqhJ41ap
 sC/TFJX54bO3GNQJcVnQ8wNnKwOQQ021WrwyY74EMjJQ5Ryyep6MtMZli0bV3x03YIOX
 p80A==
X-Gm-Message-State: AOJu0Yx9t57QVjSd6zHQk4VkiHaInlXJ2LuMGTZ3AgQz4Irp7CxGmEx8
 woyhKsSJyf2/xZLvnNPvKFSGm6uiMqCldP1mkFm8i89GX5jmp84ougzm8fpW6zzThRhI5MUVIeu
 8se8Drw3ZMWrzalCi7X0mhz3cWzXBkGK549tf
X-Gm-Gg: ASbGnctu4I93j6PMfC6rXB3tNMXV0xPKmFXmD9hZY/coOR0ZLalHjdBwFhmDonHefhN
 4dv1xmcexS2FIkCNC2pBLT0lKZfOz4vBF+mYTJA==
X-Google-Smtp-Source: AGHT+IG5qGAauOM4i22qiowsVNmWo9tOdnO2Qf9bt9lY0bwHN2O0zzCqFfTQeHM0EkmI5TxeaghhDrfVPGt14hdHH4M=
X-Received: by 2002:a05:6102:41a7:b0:4af:ef82:ce8d with SMTP id
 ada2fe7eead31-4b2cd48bab9mr19089639137.0.1735301952350; Fri, 27 Dec 2024
 04:19:12 -0800 (PST)
MIME-Version: 1.0
References: <20241223221645.29911-1-phil@philjordan.eu>
 <8554330d-fd9b-4fa5-b37c-161f70b71f7d@linaro.org>
In-Reply-To: <8554330d-fd9b-4fa5-b37c-161f70b71f7d@linaro.org>
From: Phil Dennis-Jordan <phil@philjordan.eu>
Date: Fri, 27 Dec 2024 13:19:01 +0100
Message-ID: <CAAibmn3PGD5oN9nAeUaqYkAxsH1CWhAQrkqGEaFUd7Ohr-uRfg@mail.gmail.com>
Subject: Re: [PATCH v16 00/14] macOS PV Graphics and new vmapple machine type
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, agraf@csgraf.de, peter.maydell@linaro.org, 
 pbonzini@redhat.com, rad@semihalf.com, quic_llindhol@quicinc.com, 
 stefanha@redhat.com, mst@redhat.com, slp@redhat.com, 
 richard.henderson@linaro.org, eduardo@habkost.net, marcel.apfelbaum@gmail.com, 
 gaosong@loongson.cn, jiaxun.yang@flygoat.com, chenhuacai@kernel.org, 
 kwolf@redhat.com, hreitz@redhat.com, shorne@gmail.com, palmer@dabbelt.com, 
 alistair.francis@wdc.com, bmeng.cn@gmail.com, liwei1518@gmail.com, 
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com, jcmvbkbc@gmail.com, 
 marcandre.lureau@redhat.com, berrange@redhat.com, akihiko.odaki@daynix.com, 
 qemu-arm@nongnu.org, qemu-block@nongnu.org, qemu-riscv@nongnu.org, 
 balaton@eik.bme.hu
Content-Type: multipart/alternative; boundary="00000000000072c57a062a3f78d8"
Received-SPF: neutral client-ip=2607:f8b0:4864:20::e30;
 envelope-from=phil@philjordan.eu; helo=mail-vs1-xe30.google.com
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

--00000000000072c57a062a3f78d8
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 23 Dec 2024 at 23:58, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g>
wrote:

> On 23/12/24 23:16, Phil Dennis-Jordan wrote:
> > This patch set introduces a new ARM and macOS HVF specific machine type
> > called "vmapple", as well as a family of display devices based on the
> > ParavirtualizedGraphics.framework in macOS. One of the display adapter
> > variants, apple-gfx-mmio, is required for the new machine type, while
> > apple-gfx-pci can be used to enable 3D graphics acceleration with x86-6=
4
> > macOS guest OSes.
> >
> > Previous versions of this patch set were submitted semi-separately:
> > the original vmapple patch set by Alexander Graf included a monolithic
> > implementation of apple-gfx-mmio. I subsequently reviewed and reworked
> > the latter to support the PCI variant of the device as well and submitt=
ed
> > the result in isolation. As requested in subsequent review, I have now
> > recombined this with the original vmapple patch set, which I have updat=
ed
> > and improved in a few ways as well.
> >
> > The vmapple machine type approximates the configuration in macOS's own
> > Virtualization.framework when running arm64 macOS guests. In addition t=
o
> > generic components such as a GICv3 and an XHCI USB controller, it
> > includes nonstandard extensions to the virtio block device, a special
> > "hardware" aes engine, a configuration device, a pvpanic variant, a
> > "backdoor" interface, and of course the apple-gfx paravirtualised displ=
ay
> > adapter.
> >
> > There are currently a few limitations to this which aren't intrinsic,
> > just imperfect emulation of the VZF, but it's good enough to be just
> > about usable for some purposes:
> >
> >   * macOS 12 guests only. Versions 13+ currently fail during early boot=
.
> >   * macOS 11+ arm64 hosts only, with hvf accel. (Perhaps some differenc=
es
> >     between Apple M series CPUs and TCG's aarch64 implementation? macOS
> >     hosts only because ParavirtualizedGraphics.framework is a black box
> >     implementing most of the logic behind the apple-gfx device.)
> >   * PCI devices use legacy IRQs, not MSI/MSI-X. As far as I can tell,
> >     we'd need to include the GICv3 ITS, but it's unclear to me what
> >     exactly needs wiring up.
> >   * Due to a quirk (bug?) in the macOS XHCI driver when MSI-X is not
> >     available, correct functioning of the USB controller (and thus
> >     keyboard/tablet) requires a small workaround in the XHCI controller
> >     device. This is part of another patch series:
> >     https://patchew.org/QEMU/20241208191646.64857-1-phil@philjordan.eu/
> >   * The guest OS must first be provisioned using
> Virtualization.framework;
> >     the disk images can subsequently be used in Qemu. (See docs.)
> >
> > The apple-gfx device can be used independently from the vmapple machine
> > type, at least in the PCI variant. It mainly targets x86-64 macOS guest=
s
> > from version 11 on, but also includes a UEFI bootrom for basic
> > framebuffer mode. macOS 11 is also required on the host side, as well
> > as a GPU that supports the Metal API. On the guest side, this provides
> > 3D acceleration/GPGPU support with a baseline Metal feature set,
> > irrespective of the host GPU's feature set. A few limitations in the
> > current integration:
> >
> >   * Although it works fine with TCG, it does not work correctly
> >     cross-architecture: x86-64 guests on arm64 hosts appear to make
> >     some boot progress, but rendering is corrupted. I suspect
> >     incompatible texture memory layouts; I have no idea if this is
> >     fixable.
> >   * ParavirtualizedGraphics.framework and the guest driver support
> >     multi-headed configurations. The current Qemu integration always
> >     connects precisely 1 display.
> >   * State serialisation and deserialisation is currently not
> >     implemented, though supported in principle by the framework.
> >     Both apple-gfx variants thus set up a migration blocker.
> >   * Rendering efficiency could be better. The GPU-rendered guest
> >     framebuffer is copied to system memory and uses Qemu's usual
> >     CPU-based drawing. For maximum efficiency, the Metal texture
> >     containing the guest framebuffer could be drawn directly to
> >     a Metal view in the host window, staying on the GPU. (Similar
> >     to the OpenGL/virgl render path on other platforms.)
>
>
> > v15 -> v16
> >
> >   * 14 patches now, as patch 8 has already been pulled. (Thanks
> Philippe!)
> >   * Fixed a bunch of conflicts with upstream code motion:
> >      - DEFINE_PROP_END_OF_LIST removal (4/14 - apple-gfx mode list, 7/1=
4
> -
> >        pvpanic-mmio, 10/14 - bdif, 11/14 - cfg device, and
> >        12/14 - vmapple-virtio-blk)
> >      - sysemu->system move/rename: (1/14 - ui/qemu-main, 2/14 -
> apple-gfx,
> >        9/14 - aes, 10/14 - bdif, 14/14 - vmapple machine type)
> >   * 14/14 (vmapple machine type):
> >      - Moved compatibility setting for removing legacy mode from
> virtio-pci
> >        to proper global property table rather than (ab)using sugar
> property.
> >      - Removed a few superfluous #includes during sysemu rename cleanup=
.
> >      - Removed machine type versioning as it's not necessary (yet?)
> >      - Made memory map array const
>
> Great.
>
> > Alexander Graf (8):
> >    hw: Add vmapple subdir
> >    hw/misc/pvpanic: Add MMIO interface
> >    gpex: Allow more than 4 legacy IRQs
> >    hw/vmapple/aes: Introduce aes engine
> >    hw/vmapple/bdif: Introduce vmapple backdoor interface
> >    hw/vmapple/cfg: Introduce vmapple cfg region
> >    hw/vmapple/virtio-blk: Add support for apple virtio-blk
> >    hw/vmapple/vmapple: Add vmapple machine type
> >
> > Phil Dennis-Jordan (6):
> >    ui & main loop: Redesign of system-specific main thread event handli=
ng
> >    hw/display/apple-gfx: Introduce ParavirtualizedGraphics.Framework
> >      support
> >    hw/display/apple-gfx: Adds PCI implementation
> >    hw/display/apple-gfx: Adds configurable mode list
> >    MAINTAINERS: Add myself as maintainer for apple-gfx, reviewer for HV=
F
> >    hw/block/virtio-blk: Replaces request free function with g_free
>
> If there are no objection or further comments, I'm taking this
> series and will post a PR after xmas & testing.


Thanks Phil, much appreciated! Enjoy your time off.

I've just posted an updated -v3 of my xhci patch series as v2 suffered from
the same breakage as this patch set. I recommend applying that one on top
for testing vmapple. It helps when you can use keyboard and mouse properly
and don't need to mess around with VNC.

All the best,
Phil

--00000000000072c57a062a3f78d8
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, 23 Dec =
2024 at 23:58, Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@lin=
aro.org">philmd@linaro.org</a>&gt; wrote:<br></div><blockquote class=3D"gma=
il_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,2=
04,204);padding-left:1ex">On 23/12/24 23:16, Phil Dennis-Jordan wrote:<br>
&gt; This patch set introduces a new ARM and macOS HVF specific machine typ=
e<br>
&gt; called &quot;vmapple&quot;, as well as a family of display devices bas=
ed on the<br>
&gt; ParavirtualizedGraphics.framework in macOS. One of the display adapter=
<br>
&gt; variants, apple-gfx-mmio, is required for the new machine type, while<=
br>
&gt; apple-gfx-pci can be used to enable 3D graphics acceleration with x86-=
64<br>
&gt; macOS guest OSes.<br>
&gt; <br>
&gt; Previous versions of this patch set were submitted semi-separately:<br=
>
&gt; the original vmapple patch set by Alexander Graf included a monolithic=
<br>
&gt; implementation of apple-gfx-mmio. I subsequently reviewed and reworked=
<br>
&gt; the latter to support the PCI variant of the device as well and submit=
ted<br>
&gt; the result in isolation. As requested in subsequent review, I have now=
<br>
&gt; recombined this with the original vmapple patch set, which I have upda=
ted<br>
&gt; and improved in a few ways as well.<br>
&gt; <br>
&gt; The vmapple machine type approximates the configuration in macOS&#39;s=
 own<br>
&gt; Virtualization.framework when running arm64 macOS guests. In addition =
to<br>
&gt; generic components such as a GICv3 and an XHCI USB controller, it<br>
&gt; includes nonstandard extensions to the virtio block device, a special<=
br>
&gt; &quot;hardware&quot; aes engine, a configuration device, a pvpanic var=
iant, a<br>
&gt; &quot;backdoor&quot; interface, and of course the apple-gfx paravirtua=
lised display<br>
&gt; adapter.<br>
&gt; <br>
&gt; There are currently a few limitations to this which aren&#39;t intrins=
ic,<br>
&gt; just imperfect emulation of the VZF, but it&#39;s good enough to be ju=
st<br>
&gt; about usable for some purposes:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0* macOS 12 guests only. Versions 13+ currently fail during=
 early boot.<br>
&gt;=C2=A0 =C2=A0* macOS 11+ arm64 hosts only, with hvf accel. (Perhaps som=
e differences<br>
&gt;=C2=A0 =C2=A0 =C2=A0between Apple M series CPUs and TCG&#39;s aarch64 i=
mplementation? macOS<br>
&gt;=C2=A0 =C2=A0 =C2=A0hosts only because ParavirtualizedGraphics.framewor=
k is a black box<br>
&gt;=C2=A0 =C2=A0 =C2=A0implementing most of the logic behind the apple-gfx=
 device.)<br>
&gt;=C2=A0 =C2=A0* PCI devices use legacy IRQs, not MSI/MSI-X. As far as I =
can tell,<br>
&gt;=C2=A0 =C2=A0 =C2=A0we&#39;d need to include the GICv3 ITS, but it&#39;=
s unclear to me what<br>
&gt;=C2=A0 =C2=A0 =C2=A0exactly needs wiring up.<br>
&gt;=C2=A0 =C2=A0* Due to a quirk (bug?) in the macOS XHCI driver when MSI-=
X is not<br>
&gt;=C2=A0 =C2=A0 =C2=A0available, correct functioning of the USB controlle=
r (and thus<br>
&gt;=C2=A0 =C2=A0 =C2=A0keyboard/tablet) requires a small workaround in the=
 XHCI controller<br>
&gt;=C2=A0 =C2=A0 =C2=A0device. This is part of another patch series:<br>
&gt;=C2=A0 =C2=A0 =C2=A0<a href=3D"https://patchew.org/QEMU/20241208191646.=
64857-1-phil@philjordan.eu/" rel=3D"noreferrer" target=3D"_blank">https://p=
atchew.org/QEMU/20241208191646.64857-1-phil@philjordan.eu/</a><br>
&gt;=C2=A0 =C2=A0* The guest OS must first be provisioned using Virtualizat=
ion.framework;<br>
&gt;=C2=A0 =C2=A0 =C2=A0the disk images can subsequently be used in Qemu. (=
See docs.)<br>
&gt; <br>
&gt; The apple-gfx device can be used independently from the vmapple machin=
e<br>
&gt; type, at least in the PCI variant. It mainly targets x86-64 macOS gues=
ts<br>
&gt; from version 11 on, but also includes a UEFI bootrom for basic<br>
&gt; framebuffer mode. macOS 11 is also required on the host side, as well<=
br>
&gt; as a GPU that supports the Metal API. On the guest side, this provides=
<br>
&gt; 3D acceleration/GPGPU support with a baseline Metal feature set,<br>
&gt; irrespective of the host GPU&#39;s feature set. A few limitations in t=
he<br>
&gt; current integration:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0* Although it works fine with TCG, it does not work correc=
tly<br>
&gt;=C2=A0 =C2=A0 =C2=A0cross-architecture: x86-64 guests on arm64 hosts ap=
pear to make<br>
&gt;=C2=A0 =C2=A0 =C2=A0some boot progress, but rendering is corrupted. I s=
uspect<br>
&gt;=C2=A0 =C2=A0 =C2=A0incompatible texture memory layouts; I have no idea=
 if this is<br>
&gt;=C2=A0 =C2=A0 =C2=A0fixable.<br>
&gt;=C2=A0 =C2=A0* ParavirtualizedGraphics.framework and the guest driver s=
upport<br>
&gt;=C2=A0 =C2=A0 =C2=A0multi-headed configurations. The current Qemu integ=
ration always<br>
&gt;=C2=A0 =C2=A0 =C2=A0connects precisely 1 display.<br>
&gt;=C2=A0 =C2=A0* State serialisation and deserialisation is currently not=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0implemented, though supported in principle by the f=
ramework.<br>
&gt;=C2=A0 =C2=A0 =C2=A0Both apple-gfx variants thus set up a migration blo=
cker.<br>
&gt;=C2=A0 =C2=A0* Rendering efficiency could be better. The GPU-rendered g=
uest<br>
&gt;=C2=A0 =C2=A0 =C2=A0framebuffer is copied to system memory and uses Qem=
u&#39;s usual<br>
&gt;=C2=A0 =C2=A0 =C2=A0CPU-based drawing. For maximum efficiency, the Meta=
l texture<br>
&gt;=C2=A0 =C2=A0 =C2=A0containing the guest framebuffer could be drawn dir=
ectly to<br>
&gt;=C2=A0 =C2=A0 =C2=A0a Metal view in the host window, staying on the GPU=
. (Similar<br>
&gt;=C2=A0 =C2=A0 =C2=A0to the OpenGL/virgl render path on other platforms.=
)<br>
<br>
<br>
&gt; v15 -&gt; v16<br>
&gt; <br>
&gt;=C2=A0 =C2=A0* 14 patches now, as patch 8 has already been pulled. (Tha=
nks Philippe!)<br>
&gt;=C2=A0 =C2=A0* Fixed a bunch of conflicts with upstream code motion:<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 - DEFINE_PROP_END_OF_LIST removal (4/14 - apple-gf=
x mode list, 7/14 -<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 pvpanic-mmio, 10/14 - bdif, 11/14 - cfg dev=
ice, and<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 12/14 - vmapple-virtio-blk)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 - sysemu-&gt;system move/rename: (1/14 - ui/qemu-m=
ain, 2/14 - apple-gfx,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 9/14 - aes, 10/14 - bdif, 14/14 - vmapple m=
achine type)<br>
&gt;=C2=A0 =C2=A0* 14/14 (vmapple machine type):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 - Moved compatibility setting for removing legacy =
mode from virtio-pci<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 to proper global property table rather than=
 (ab)using sugar property.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 - Removed a few superfluous #includes during sysem=
u rename cleanup.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 - Removed machine type versioning as it&#39;s not =
necessary (yet?)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 - Made memory map array const<br>
<br>
Great.<br>
<br>
&gt; Alexander Graf (8):<br>
&gt;=C2=A0 =C2=A0 hw: Add vmapple subdir<br>
&gt;=C2=A0 =C2=A0 hw/misc/pvpanic: Add MMIO interface<br>
&gt;=C2=A0 =C2=A0 gpex: Allow more than 4 legacy IRQs<br>
&gt;=C2=A0 =C2=A0 hw/vmapple/aes: Introduce aes engine<br>
&gt;=C2=A0 =C2=A0 hw/vmapple/bdif: Introduce vmapple backdoor interface<br>
&gt;=C2=A0 =C2=A0 hw/vmapple/cfg: Introduce vmapple cfg region<br>
&gt;=C2=A0 =C2=A0 hw/vmapple/virtio-blk: Add support for apple virtio-blk<b=
r>
&gt;=C2=A0 =C2=A0 hw/vmapple/vmapple: Add vmapple machine type<br>
&gt; <br>
&gt; Phil Dennis-Jordan (6):<br>
&gt;=C2=A0 =C2=A0 ui &amp; main loop: Redesign of system-specific main thre=
ad event handling<br>
&gt;=C2=A0 =C2=A0 hw/display/apple-gfx: Introduce ParavirtualizedGraphics.F=
ramework<br>
&gt;=C2=A0 =C2=A0 =C2=A0 support<br>
&gt;=C2=A0 =C2=A0 hw/display/apple-gfx: Adds PCI implementation<br>
&gt;=C2=A0 =C2=A0 hw/display/apple-gfx: Adds configurable mode list<br>
&gt;=C2=A0 =C2=A0 MAINTAINERS: Add myself as maintainer for apple-gfx, revi=
ewer for HVF<br>
&gt;=C2=A0 =C2=A0 hw/block/virtio-blk: Replaces request free function with =
g_free<br>
<br>
If there are no objection or further comments, I&#39;m taking this<br>
series and will post a PR after xmas &amp; testing.</blockquote><div><br></=
div><div>Thanks Phil, much appreciated! Enjoy your time off.<br></div><div>=
<br></div><div>I&#39;ve just posted an updated -v3 of my xhci patch series =
as v2 suffered from the same breakage as this patch set. I recommend applyi=
ng that one on top for testing vmapple. It helps when you can use keyboard =
and mouse properly and don&#39;t need to mess around with VNC.</div><div><b=
r></div><div>All the best,</div><div>Phil</div><div><br></div></div></div>

--00000000000072c57a062a3f78d8--

