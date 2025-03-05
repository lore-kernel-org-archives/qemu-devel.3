Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2241C19F32
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 23:22:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpy3F-0005Xs-C6; Wed, 05 Mar 2025 18:21:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sstabellini@kernel.org>)
 id 1tpy30-0005XS-UI
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 18:21:07 -0500
Received: from dfw.source.kernel.org ([139.178.84.217])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sstabellini@kernel.org>)
 id 1tpy2y-0002AM-B5
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 18:21:06 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 42A655C6972;
 Wed,  5 Mar 2025 23:18:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4B4AC4CEE7;
 Wed,  5 Mar 2025 23:20:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1741216853;
 bh=Mbtcg14xAK690NJj5CTSKIwwwr4xUJPM/PQF9haK9iY=;
 h=Date:From:To:cc:Subject:In-Reply-To:References:From;
 b=RdqbS9OP+cfiwzv4pqy7od1UnW597r5PjG9ZRRi0werZpHtAXorKDBiWlC5myoZkI
 21+Q0GX4He6oQv/JnAnaH/DEJtrV3oHqtEZMPmk8WrdzpGoE/a33pL/e5AxDvmNuYS
 +BCIDdq8H+Es66vWtlGUMPwkBipdaQFP/GfDRr8/ubqgzg/AmZCS7zXjZdfNeHe8/s
 o54f8LWVX9ll6sy1RXwJRtgaGpCPvZxeYDATGNSIPZ2VbTIplR24HFru9Eg+uuawkW
 Z9bwikpM2lqBsm0Zk2r4YanvElnOSsaeFpq7LjwhOMH1lcghb37bFTwIl20eFwHofU
 U2tymsIhx1GgQ==
Date: Wed, 5 Mar 2025 15:20:51 -0800 (PST)
From: Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@ubuntu-linux-20-04-desktop
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
cc: Stefano Stabellini <sstabellini@kernel.org>, peter.maydell@linaro.org, 
 richard.henderson@linaro.org, qemu-devel@nongnu.org, 
 vikram.garhwal@amd.com, Stefano Stabellini <stefano.stabellini@amd.com>, 
 Edgar.Iglesias@amd.com
Subject: Re: [PULL v5 09/11] hw/arm: introduce xenpvh machine
In-Reply-To: <a0982117-5602-49ee-9e0c-ef2f7c716e7b@linaro.org>
Message-ID: <alpine.DEB.2.22.394.2503051519550.1303386@ubuntu-linux-20-04-desktop>
References: <alpine.DEB.2.22.394.2306151649350.897208@ubuntu-linux-20-04-desktop>
 <20230615235254.1366267-9-sstabellini@kernel.org>
 <a0982117-5602-49ee-9e0c-ef2f7c716e7b@linaro.org>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-268722362-1741216802=:1303386"
Content-ID: <alpine.DEB.2.22.394.2503051520100.1303386@ubuntu-linux-20-04-desktop>
Received-SPF: pass client-ip=139.178.84.217;
 envelope-from=sstabellini@kernel.org; helo=dfw.source.kernel.org
X-Spam_score_int: -70
X-Spam_score: -7.1
X-Spam_bar: -------
X-Spam_report: (-7.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

--8323329-268722362-1741216802=:1303386
Content-Type: text/plain; CHARSET=UTF-8
Content-Transfer-Encoding: 8BIT
Content-ID: <alpine.DEB.2.22.394.2503051520101.1303386@ubuntu-linux-20-04-desktop>

+Edgar

On Wed, 5 Mar 2025, Philippe Mathieu-Daudé wrote:
> On 16/6/23 01:52, Stefano Stabellini wrote:
> > From: Vikram Garhwal <vikram.garhwal@amd.com>
> > 
> > Add a new machine xenpvh which creates a IOREQ server to register/connect
> > with
> > Xen Hypervisor.
> > 
> > Optional: When CONFIG_TPM is enabled, it also creates a tpm-tis-device, adds
> > a
> > TPM emulator and connects to swtpm running on host machine via chardev
> > socket
> > and support TPM functionalities for a guest domain.
> > 
> > Extra command line for aarch64 xenpvh QEMU to connect to swtpm:
> >      -chardev socket,id=chrtpm,path=/tmp/myvtpm2/swtpm-sock \
> >      -tpmdev emulator,id=tpm0,chardev=chrtpm \
> >      -machine tpm-base-addr=0x0c000000 \
> > 
> > swtpm implements a TPM software emulator(TPM 1.2 & TPM 2) built on libtpms
> > and
> > provides access to TPM functionality over socket, chardev and CUSE
> > interface.
> > Github repo: https://github.com/stefanberger/swtpm
> > Example for starting swtpm on host machine:
> >      mkdir /tmp/vtpm2
> >      swtpm socket --tpmstate dir=/tmp/vtpm2 \
> >      --ctrl type=unixio,path=/tmp/vtpm2/swtpm-sock &
> > 
> > Signed-off-by: Vikram Garhwal <vikram.garhwal@amd.com>
> > Signed-off-by: Stefano Stabellini <stefano.stabellini@amd.com>
> > Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>
> > ---
> >   docs/system/arm/xenpvh.rst    |  34 +++++++
> >   docs/system/target-arm.rst    |   1 +
> >   hw/arm/meson.build            |   2 +
> >   hw/arm/xen_arm.c              | 181 ++++++++++++++++++++++++++++++++++
> >   include/hw/arm/xen_arch_hvm.h |   9 ++
> >   include/hw/xen/arch_hvm.h     |   2 +
> >   6 files changed, 229 insertions(+)
> >   create mode 100644 docs/system/arm/xenpvh.rst
> >   create mode 100644 hw/arm/xen_arm.c
> >   create mode 100644 include/hw/arm/xen_arch_hvm.h
> 
> 
> > diff --git a/include/hw/xen/arch_hvm.h b/include/hw/xen/arch_hvm.h
> > index 26674648d8..c7c515220d 100644
> > --- a/include/hw/xen/arch_hvm.h
> > +++ b/include/hw/xen/arch_hvm.h
> > @@ -1,3 +1,5 @@
> >   #if defined(TARGET_I386) || defined(TARGET_X86_64)
> >   #include "hw/i386/xen_arch_hvm.h"
> > +#elif defined(TARGET_ARM) || defined(TARGET_ARM_64)
> 
> I suppose this is a typo and you meant TARGET_AARCH64 :)
> Luckily TARGET_AARCH64 defines TARGET_ARM.

Hi Philippe, it looks like this is an older patch.

Edgar, is this patch still valid?
--8323329-268722362-1741216802=:1303386--

