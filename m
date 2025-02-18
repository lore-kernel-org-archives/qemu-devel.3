Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94AAEC021AA
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2025 19:31:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkTIm-0005ZG-Lz; Tue, 18 Feb 2025 14:30:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sstabellini@kernel.org>)
 id 1tkTIU-0005WW-Ep; Tue, 18 Feb 2025 14:30:23 -0500
Received: from dfw.source.kernel.org ([139.178.84.217])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sstabellini@kernel.org>)
 id 1tkTIR-0007J3-Ll; Tue, 18 Feb 2025 14:30:22 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 8D0DF5C544A;
 Tue, 18 Feb 2025 19:29:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3091AC4CEE2;
 Tue, 18 Feb 2025 19:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1739907014;
 bh=D0SmKXnflUF1ENknpmghSoPwbGW+dV6iEGQTiKLiGkM=;
 h=Date:From:To:cc:Subject:In-Reply-To:References:From;
 b=Q9b0bNzo2GKJ3P5Xaenndxxjunnkiowf73I3YoZMkGzz/9m3DI5W6nlgJZbijiPdE
 y05lVFMBHQkfh29eo3Hia6sY/NC6jyoMwGGIS4ox0x1aA9txS0r3CSNtf47kb7XXn3
 2jw0eyggkxm0fYjvyx72eXB8AzDztykIyjtKjKH3IH6K+v4fMajnUj6LQJ1OXH5JTH
 PSwyUXYMNnC71CMOUmru8M9Q8+uBE5k5nGif0Wl9US2432af4b9M1yHqUyJ7WRhu03
 ZA/NlJiRNrF5IKgzuIDvdc+iGOLJFcUhQEGwjz/Pk1FsfXo0Mz0T6lvieZMho5k24X
 jVzw/uqhFU4WA==
Date: Tue, 18 Feb 2025 11:30:10 -0800 (PST)
From: Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@ubuntu-linux-20-04-desktop
To: Andrew Cooper <andrew.cooper3@citrix.com>
cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 qemu-devel@nongnu.org, David Woodhouse <dwmw2@infradead.org>, 
 "open list:X86 Xen CPUs" <xen-devel@lists.xenproject.org>, 
 Paul Durrant <paul@xen.org>, Stefano Stabellini <sstabellini@kernel.org>, 
 Anthony PERARD <anthony@xenproject.org>, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, 
 Stefano Stabellini <sstabellini@kernel.org>, 
 Thomas Huth <thuth@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 qemu-arm <qemu-arm@nongnu.org>, 
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Subject: Re: [PULL 3/9] meson: Disallow 64-bit on 32-bit Xen emulation
In-Reply-To: <9b22d0ff-5902-4ec7-ae54-e974482ebd87@citrix.com>
Message-ID: <alpine.DEB.2.22.394.2502181120100.1085376@ubuntu-linux-20-04-desktop>
References: <20250208205725.568631-1-richard.henderson@linaro.org>
 <20250208205725.568631-4-richard.henderson@linaro.org>
 <aeaf0f19-0f14-4a02-9c51-09521e7c75e1@linaro.org>
 <9b22d0ff-5902-4ec7-ae54-e974482ebd87@citrix.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed;
 BOUNDARY="8323329-1975763779-1739906423=:1085376"
Content-ID: <alpine.DEB.2.22.394.2502181121020.1085376@ubuntu-linux-20-04-desktop>
Received-SPF: pass client-ip=139.178.84.217;
 envelope-from=sstabellini@kernel.org; helo=dfw.source.kernel.org
X-Spam_score_int: -74
X-Spam_score: -7.5
X-Spam_bar: -------
X-Spam_report: (-7.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.423,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_HI=-5, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1975763779-1739906423=:1085376
Content-Type: text/plain; CHARSET=UTF-8
Content-Transfer-Encoding: 8BIT
Content-ID: <alpine.DEB.2.22.394.2502181121021.1085376@ubuntu-linux-20-04-desktop>

On Tue, 18 Feb 2025, Andrew Cooper wrote:
> On 18/02/2025 11:20 am, Philippe Mathieu-Daudé wrote:
> > Hi,
> >
> > Adding Xen community.
> >
> > On 8/2/25 21:57, Richard Henderson wrote:
> >> Require a 64-bit host binary to spawn a 64-bit guest.
> >>
> >> Reviewed-by: Thomas Huth <thuth@redhat.com>
> >> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> >> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> >> ---
> >>   meson.build | 9 +++++++--
> >>   1 file changed, 7 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/meson.build b/meson.build
> >> index 1af8aeb194..911955cfa8 100644
> >> --- a/meson.build
> >> +++ b/meson.build
> >> @@ -304,9 +304,14 @@ else
> >>   endif
> >>   accelerator_targets = { 'CONFIG_KVM': kvm_targets }
> >>   -if cpu in ['x86', 'x86_64']
> >> +if cpu == 'x86'
> >> +  xen_targets = ['i386-softmmu']
> >> +elif cpu == 'x86_64'
> >>     xen_targets = ['i386-softmmu', 'x86_64-softmmu']
> >> -elif cpu in ['arm', 'aarch64']
> >> +elif cpu == 'arm'
> >> +  # i386 emulator provides xenpv machine type for multiple
> >> architectures
> >> +  xen_targets = ['i386-softmmu']
> >
> > Is actually someone *testing* this config? I'm having hard time building
> > it, so am very suspicious about how it runs, and start to wonder if I'm
> > not just wasting my time (as could be our CI).
> 
> It was intentional.  I believe it was Stefano (CC'd) who introduced it.
> 
> Xen uses qemu-system-i386 everywhere because qemu-system-x86_64 doesn't
> make compatible VMs.  I'm not sure why; I suspect it's bugs in the Xen
> machine types, but I don't know QEMU well enough to be sure.
> 
> Another thing that (at least, was) tied to qemu-system-i386 was using
> Qemu as a XenBlk <-> QCOW adapter, at which point it wasn't even really
> a system emulator, just a paravirtual disk implementation.
> 
> This is, AIUI, what ARM wants with the xenpv machine.  If there's a
> better way to do this, please do say.
> 
> 
> Looking through Xen's CI, I can't see any of the ARM builds building
> QEMU at all.  I think it's quite possible it's not tested any more.

Hi all,

I answered on a similar question recently:
https://marc.info/?l=qemu-devel&m=173862237031104&w=2

In short, while QEMU for x86 HVM guest is required, QEMU is not required
for x86 PVH guests, and ARM guests. The model is different and QEMU is
only providing PV backends or virtio backends if the VM is configured
that way. You can have a fully functional VM without QEMU (or other
virtio backends provider).

In this context, the original integration of QEMU for Xen on ARM was
done reusing the qemu-system-i386 target. But Edgar recently upstreamed
a much better newer machine that is cleaner, simpler and faster: XenPVH
(see hw/arm/xen-pvh.c and hw/i386/xen/xen-pvh.c). So we don't need
qemu-system-i386 on either ARM32 or ARM64 anymore.

Moreover, for ARM32 specifically, I think it would be OK to remove QEMU
support for ARM32 Xen machines in general because of the reasons I wrote
in the other email and above here.
--8323329-1975763779-1739906423=:1085376--

