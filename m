Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 305E5C61DB8
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2024 15:51:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjKwO-0001fT-HL; Wed, 28 Aug 2024 11:50:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dorjoychy111@gmail.com>)
 id 1sjKwN-0001eL-9w
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 11:50:35 -0400
Received: from mail-ua1-x935.google.com ([2607:f8b0:4864:20::935])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dorjoychy111@gmail.com>)
 id 1sjKwK-0008Ko-SQ
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 11:50:34 -0400
Received: by mail-ua1-x935.google.com with SMTP id
 a1e0cc1a2514c-84310fb76f1so1784229241.2
 for <qemu-devel@nongnu.org>; Wed, 28 Aug 2024 08:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724860231; x=1725465031; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2NMJgy8mcpFd2zlX0DGVPCHhFNZOnfvcl/62TzroCq4=;
 b=kfhRJoqaK8caMPVNXnF05S4GKRCQXQi2xgpwXMWSWfhTj12g7MGVPf86xCkmRCm9Y4
 +H1OCUlxUDXAsh2u7DONsQs3lgSniuqcA7llMsYgz1JcGJwq5zY+QvmtVirr3NXtGrle
 vAuKWIUKpseWvlSx69Kqvcm2BG6zO3wfwYEQ7Rk0YykilT9ErHcVobzGpVFE1jCkNIP3
 Q2tUkiGkJ311SteEtDgHyR5aqtd0xt9i6L0WowXvA7dG5hfuLTbHhgoXTjRARuc48S2p
 bN9leeADgyxNk+Ljat2Gea94gq+oy9UWYqstYRzAJOeDckuYTXUVZvQkNLWIdSKWDfhV
 JvIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724860231; x=1725465031;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2NMJgy8mcpFd2zlX0DGVPCHhFNZOnfvcl/62TzroCq4=;
 b=MXHXHhl2cSyuTVttqG7faGuRCFVlIJ1Pqxzi2r8Hg5tZwnHSyWjrLdiOcHNNlrvLjE
 dGkiHTQSiMXgV4rQQFnsSnTUN9nnWc2hgp5Eqop1Fg4g2eQ6LHgMiYw7VwgSxyv5HX53
 5dR3d5dnElgljRYGqGVwaSTUy/sDKQqH31GIldL+lFIR0iHIeM/GqIWF8Pt3a0eeVZia
 vjLS822Ja0gxjqzS3lyLjyb5S1u5SlOy3jHdxfWPmN9N6nsTSL4KQBBIeAzPu6qZM4P8
 pBuivtIIbzk5rYc1oU0GaBHZF0ERBSztVdTDa/GLhDn9bKv771xp2FNXkL+nf4jv063c
 gA4Q==
X-Gm-Message-State: AOJu0Yw7yXAbfOscJ9HLOxikma4pCqbpLiT0Iil1d035rmGq8NpVHy+E
 F8Sjl1wfUSWocqGQbO48fkB3NN9YpMS2bgw0tfRDxYMrFmQ00pnfN+mzoJKLYPM5/a2l+C4dF3v
 gFxQtCpEXRPLtpKDfdFqcnNyda8c=
X-Google-Smtp-Source: AGHT+IGMN11u9eUcUeyaM+kvtBPWlTnXstWSfAtkQdWw4eeHzh8Sja+JStafVbqaJOIL6jMM+wFmMuqhEl1/xR+1bLI=
X-Received: by 2002:a05:6102:26d4:b0:498:d51a:989 with SMTP id
 ada2fe7eead31-49a5b108b50mr136461137.9.1724860231252; Wed, 28 Aug 2024
 08:50:31 -0700 (PDT)
MIME-Version: 1.0
References: <20240822150849.21759-1-dorjoychy111@gmail.com>
 <20240822150849.21759-8-dorjoychy111@gmail.com> <Zs9EpTY9N6kl1VNJ@redhat.com>
In-Reply-To: <Zs9EpTY9N6kl1VNJ@redhat.com>
From: Dorjoy Chowdhury <dorjoychy111@gmail.com>
Date: Wed, 28 Aug 2024 21:50:25 +0600
Message-ID: <CAFfO_h4vqP-c4gqGJeZRbBEyqaLjO30PgbbvvEi9XVWmyzEtcg@mail.gmail.com>
Subject: Re: [PATCH v5 7/8] machine/nitro-enclave: New machine type for AWS
 Nitro Enclaves
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, graf@amazon.com, agraf@csgraf.de, 
 stefanha@redhat.com, pbonzini@redhat.com, slp@redhat.com, 
 richard.henderson@linaro.org, eduardo@habkost.net, mst@redhat.com, 
 marcel.apfelbaum@gmail.com, philmd@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::935;
 envelope-from=dorjoychy111@gmail.com; helo=mail-ua1-x935.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Hi Daniel,

On Wed, Aug 28, 2024 at 9:39=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com> wrote:
>
> On Thu, Aug 22, 2024 at 09:08:48PM +0600, Dorjoy Chowdhury wrote:
> > AWS nitro enclaves[1] is an Amazon EC2[2] feature that allows creating
> > isolated execution environments, called enclaves, from Amazon EC2
> > instances which are used for processing highly sensitive data. Enclaves
> > have no persistent storage and no external networking. The enclave VMs
> > are based on the Firecracker microvm with a vhost-vsock device for
> > communication with the parent EC2 instance that spawned it and a Nitro
> > Secure Module (NSM) device for cryptographic attestation. The parent
> > instance VM always has CID 3 while the enclave VM gets a dynamic CID.
> >
> > An EIF (Enclave Image Format)[3] file is used to boot an AWS nitro encl=
ave
> > virtual machine. This commit adds support for AWS nitro enclave emulati=
on
> > using a new machine type option '-M nitro-enclave'. This new machine ty=
pe
> > is based on the 'microvm' machine type, similar to how real nitro encla=
ve
> > VMs are based on Firecracker microvm. For nitro-enclave to boot from an
> > EIF file, the kernel and ramdisk(s) are extracted into a temporary kern=
el
> > and a temporary initrd file which are then hooked into the regular x86
> > boot mechanism along with the extracted cmdline. The EIF file path shou=
ld
> > be provided using the '-kernel' QEMU option.
> >
> > In QEMU, the vsock emulation for nitro enclave is added using vhost-use=
r-
> > vsock as opposed to vhost-vsock. vhost-vsock doesn't support sibling VM
> > communication which is needed for nitro enclaves. So for the vsock
> > communication to CID 3 to work, another process that does the vsock
> > emulation in  userspace must be run, for example, vhost-device-vsock[4]
> > from rust-vmm, with necessary vsock communication support in another
> > guest VM with CID 3. Using vhost-user-vsock also enables the possibilit=
y
> > to implement some proxying support in the vhost-user-vsock daemon that
> > will forward all the packets to the host machine instead of CID 3 so
> > that users of nitro-enclave can run the necessary applications in their
> > host machine instead of running another whole VM with CID 3. The follow=
ing
> > mandatory nitro-enclave machine option has been added related to the
> > vhost-user-vsock device.
> >   - 'vsock': The chardev id from the '-chardev' option for the
> > vhost-user-vsock device.
> >
> > AWS Nitro Enclaves have built-in Nitro Secure Module (NSM) device which
> > has been added using the virtio-nsm device added in a previous commit.
> > In Nitro Enclaves, all the PCRs start in a known zero state and the fir=
st
> > 16 PCRs are locked from boot and reserved. The PCR0, PCR1, PCR2 and PCR=
8
> > contain the SHA384 hashes related to the EIF file used to boot the VM
> > for validation. The following optional nitro-enclave machine options
> > have been added related to the NSM device.
> >   - 'id': Enclave identifier, reflected in the module-id of the NSM
> > device. If not provided, a default id will be set.
> >   - 'parent-role': Parent instance IAM role ARN, reflected in PCR3
> > of the NSM device.
> >   - 'parent-id': Parent instance identifier, reflected in PCR4 of the
> > NSM device.
> >
> > [1] https://docs.aws.amazon.com/enclaves/latest/user/nitro-enclave.html
> > [2] https://aws.amazon.com/ec2/
> > [3] https://github.com/aws/aws-nitro-enclaves-image-format
> > [4] https://github.com/rust-vmm/vhost-device/tree/main/vhost-device-vso=
ck
> >
> > Signed-off-by: Dorjoy Chowdhury <dorjoychy111@gmail.com>
> > ---
> >  MAINTAINERS                              |   9 +
> >  backends/hostmem-memfd.c                 |   2 -
> >  configs/devices/i386-softmmu/default.mak |   1 +
> >  hw/core/machine.c                        |  71 ++---
> >  hw/core/meson.build                      |   3 +
> >  hw/i386/Kconfig                          |   6 +
> >  hw/i386/meson.build                      |   3 +
> >  hw/i386/microvm.c                        |   6 +-
> >  hw/i386/nitro_enclave.c                  | 355 +++++++++++++++++++++++
> >  include/hw/boards.h                      |   2 +
> >  include/hw/i386/microvm.h                |   2 +
> >  include/hw/i386/nitro_enclave.h          |  62 ++++
> >  include/sysemu/hostmem.h                 |   2 +
> >  13 files changed, 488 insertions(+), 36 deletions(-)
> >  create mode 100644 hw/i386/nitro_enclave.c
> >  create mode 100644 include/hw/i386/nitro_enclave.h
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index da4f698137..aa7846107e 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -1877,6 +1877,15 @@ F: hw/i386/microvm.c
> >  F: include/hw/i386/microvm.h
> >  F: pc-bios/bios-microvm.bin
> >
> > +nitro-enclave
> > +M: Alexander Graf <graf@amazon.com>
> > +M: Dorjoy Chowdhury <dorjoychy111@gmail.com>
> > +S: Maintained
> > +F: hw/core/eif.c
> > +F: hw/core/eif.h
>
> The eif.c/h files were added in the prevuous patch, so upto this line
> should be added in the previous patch.
>

Yeah, it makes sense to include it in the previous patch. Thanks!

> > +F: hw/i386/nitro_enclave.c
> > +F: include/hw/i386/nitro_enclave.h
>
> These two lines can remain in this patch
>
> >  Machine core
> >  M: Eduardo Habkost <eduardo@habkost.net>
> >  M: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
>
>
> > diff --git a/hw/core/meson.build b/hw/core/meson.build
> > index a3d9bab9f4..5437a94490 100644
> > --- a/hw/core/meson.build
> > +++ b/hw/core/meson.build
> > @@ -24,6 +24,9 @@ system_ss.add(when: 'CONFIG_REGISTER', if_true: files=
('register.c'))
> >  system_ss.add(when: 'CONFIG_SPLIT_IRQ', if_true: files('split-irq.c'))
> >  system_ss.add(when: 'CONFIG_XILINX_AXI', if_true: files('stream.c'))
> >  system_ss.add(when: 'CONFIG_PLATFORM_BUS', if_true: files('sysbus-fdt.=
c'))
> > +if libcbor.found() and gnutls.found()
> > +  system_ss.add(when: 'CONFIG_NITRO_ENCLAVE', if_true: [files('eif.c')=
, zlib, libcbor, gnutls])
> > +endif
> >
> >  system_ss.add(files(
> >    'cpu-sysemu.c',
>
>
> This change to meson.build should be in the previous patch, since
> that's the one that introduces eif.c.
>

'CONFIG_NITRO_ENCLAVE' is introduced in this patch, so the
meson.change above should stay in this patch, right?

Regards,
Dorjoy

