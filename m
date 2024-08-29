Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 961F9C6FD35
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2024 08:16:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjaJD-00065s-Hh; Thu, 29 Aug 2024 04:15:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sjaJB-00065M-IY
 for qemu-devel@nongnu.org; Thu, 29 Aug 2024 04:15:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sjaJ9-0005qs-30
 for qemu-devel@nongnu.org; Thu, 29 Aug 2024 04:15:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1724919305;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qUtV1kI8tOHAxxg1w7E5A/fVPUdWOcBMDtJXXVzCLn4=;
 b=HLBKYz39g1dmDpR15sMqgcMb1VxMn21tcyLpGk8ryEwTnJE9sigo0J5AxB8L7tG+FB0dHL
 B32BEcJExCPndcojPGIAaD7ZzIAEXpXJJVo2355CfejExwG8Dy+PKSCeV6t2pPxGtljy4q
 agkmgLceUzagkzsDSFjDFRhPqsKevis=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-478-wTr_hSt5N2CucU2BAh2qQQ-1; Thu,
 29 Aug 2024 04:15:01 -0400
X-MC-Unique: wTr_hSt5N2CucU2BAh2qQQ-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 067701955BEE; Thu, 29 Aug 2024 08:14:59 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.64])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0B2E11954B0D; Thu, 29 Aug 2024 08:14:52 +0000 (UTC)
Date: Thu, 29 Aug 2024 09:14:49 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Dorjoy Chowdhury <dorjoychy111@gmail.com>
Cc: qemu-devel@nongnu.org, graf@amazon.com, agraf@csgraf.de,
 stefanha@redhat.com, pbonzini@redhat.com, slp@redhat.com,
 richard.henderson@linaro.org, eduardo@habkost.net, mst@redhat.com,
 marcel.apfelbaum@gmail.com, philmd@linaro.org
Subject: Re: [PATCH v5 7/8] machine/nitro-enclave: New machine type for AWS
 Nitro Enclaves
Message-ID: <ZtAt-UyWFoSNmDwT@redhat.com>
References: <20240822150849.21759-1-dorjoychy111@gmail.com>
 <20240822150849.21759-8-dorjoychy111@gmail.com>
 <Zs9EpTY9N6kl1VNJ@redhat.com>
 <CAFfO_h4vqP-c4gqGJeZRbBEyqaLjO30PgbbvvEi9XVWmyzEtcg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFfO_h4vqP-c4gqGJeZRbBEyqaLjO30PgbbvvEi9XVWmyzEtcg@mail.gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, Aug 28, 2024 at 09:50:25PM +0600, Dorjoy Chowdhury wrote:
> Hi Daniel,
> 
> On Wed, Aug 28, 2024 at 9:39 PM Daniel P. Berrangé <berrange@redhat.com> wrote:
> >
> > On Thu, Aug 22, 2024 at 09:08:48PM +0600, Dorjoy Chowdhury wrote:
> > > AWS nitro enclaves[1] is an Amazon EC2[2] feature that allows creating
> > > isolated execution environments, called enclaves, from Amazon EC2
> > > instances which are used for processing highly sensitive data. Enclaves
> > > have no persistent storage and no external networking. The enclave VMs
> > > are based on the Firecracker microvm with a vhost-vsock device for
> > > communication with the parent EC2 instance that spawned it and a Nitro
> > > Secure Module (NSM) device for cryptographic attestation. The parent
> > > instance VM always has CID 3 while the enclave VM gets a dynamic CID.
> > >
> > > An EIF (Enclave Image Format)[3] file is used to boot an AWS nitro enclave
> > > virtual machine. This commit adds support for AWS nitro enclave emulation
> > > using a new machine type option '-M nitro-enclave'. This new machine type
> > > is based on the 'microvm' machine type, similar to how real nitro enclave
> > > VMs are based on Firecracker microvm. For nitro-enclave to boot from an
> > > EIF file, the kernel and ramdisk(s) are extracted into a temporary kernel
> > > and a temporary initrd file which are then hooked into the regular x86
> > > boot mechanism along with the extracted cmdline. The EIF file path should
> > > be provided using the '-kernel' QEMU option.
> > >
> > > In QEMU, the vsock emulation for nitro enclave is added using vhost-user-
> > > vsock as opposed to vhost-vsock. vhost-vsock doesn't support sibling VM
> > > communication which is needed for nitro enclaves. So for the vsock
> > > communication to CID 3 to work, another process that does the vsock
> > > emulation in  userspace must be run, for example, vhost-device-vsock[4]
> > > from rust-vmm, with necessary vsock communication support in another
> > > guest VM with CID 3. Using vhost-user-vsock also enables the possibility
> > > to implement some proxying support in the vhost-user-vsock daemon that
> > > will forward all the packets to the host machine instead of CID 3 so
> > > that users of nitro-enclave can run the necessary applications in their
> > > host machine instead of running another whole VM with CID 3. The following
> > > mandatory nitro-enclave machine option has been added related to the
> > > vhost-user-vsock device.
> > >   - 'vsock': The chardev id from the '-chardev' option for the
> > > vhost-user-vsock device.
> > >
> > > AWS Nitro Enclaves have built-in Nitro Secure Module (NSM) device which
> > > has been added using the virtio-nsm device added in a previous commit.
> > > In Nitro Enclaves, all the PCRs start in a known zero state and the first
> > > 16 PCRs are locked from boot and reserved. The PCR0, PCR1, PCR2 and PCR8
> > > contain the SHA384 hashes related to the EIF file used to boot the VM
> > > for validation. The following optional nitro-enclave machine options
> > > have been added related to the NSM device.
> > >   - 'id': Enclave identifier, reflected in the module-id of the NSM
> > > device. If not provided, a default id will be set.
> > >   - 'parent-role': Parent instance IAM role ARN, reflected in PCR3
> > > of the NSM device.
> > >   - 'parent-id': Parent instance identifier, reflected in PCR4 of the
> > > NSM device.
> > >
> > > [1] https://docs.aws.amazon.com/enclaves/latest/user/nitro-enclave.html
> > > [2] https://aws.amazon.com/ec2/
> > > [3] https://github.com/aws/aws-nitro-enclaves-image-format
> > > [4] https://github.com/rust-vmm/vhost-device/tree/main/vhost-device-vsock
> > >
> > > Signed-off-by: Dorjoy Chowdhury <dorjoychy111@gmail.com>
> > > ---
> > >  MAINTAINERS                              |   9 +
> > >  backends/hostmem-memfd.c                 |   2 -
> > >  configs/devices/i386-softmmu/default.mak |   1 +
> > >  hw/core/machine.c                        |  71 ++---
> > >  hw/core/meson.build                      |   3 +
> > >  hw/i386/Kconfig                          |   6 +
> > >  hw/i386/meson.build                      |   3 +
> > >  hw/i386/microvm.c                        |   6 +-
> > >  hw/i386/nitro_enclave.c                  | 355 +++++++++++++++++++++++
> > >  include/hw/boards.h                      |   2 +
> > >  include/hw/i386/microvm.h                |   2 +
> > >  include/hw/i386/nitro_enclave.h          |  62 ++++
> > >  include/sysemu/hostmem.h                 |   2 +
> > >  13 files changed, 488 insertions(+), 36 deletions(-)
> > >  create mode 100644 hw/i386/nitro_enclave.c
> > >  create mode 100644 include/hw/i386/nitro_enclave.h
> > >
> > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > index da4f698137..aa7846107e 100644
> > > --- a/MAINTAINERS
> > > +++ b/MAINTAINERS
> > > @@ -1877,6 +1877,15 @@ F: hw/i386/microvm.c
> > >  F: include/hw/i386/microvm.h
> > >  F: pc-bios/bios-microvm.bin
> > >
> > > +nitro-enclave
> > > +M: Alexander Graf <graf@amazon.com>
> > > +M: Dorjoy Chowdhury <dorjoychy111@gmail.com>
> > > +S: Maintained
> > > +F: hw/core/eif.c
> > > +F: hw/core/eif.h
> >
> > The eif.c/h files were added in the prevuous patch, so upto this line
> > should be added in the previous patch.
> >
> 
> Yeah, it makes sense to include it in the previous patch. Thanks!
> 
> > > +F: hw/i386/nitro_enclave.c
> > > +F: include/hw/i386/nitro_enclave.h
> >
> > These two lines can remain in this patch
> >
> > >  Machine core
> > >  M: Eduardo Habkost <eduardo@habkost.net>
> > >  M: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
> >
> >
> > > diff --git a/hw/core/meson.build b/hw/core/meson.build
> > > index a3d9bab9f4..5437a94490 100644
> > > --- a/hw/core/meson.build
> > > +++ b/hw/core/meson.build
> > > @@ -24,6 +24,9 @@ system_ss.add(when: 'CONFIG_REGISTER', if_true: files('register.c'))
> > >  system_ss.add(when: 'CONFIG_SPLIT_IRQ', if_true: files('split-irq.c'))
> > >  system_ss.add(when: 'CONFIG_XILINX_AXI', if_true: files('stream.c'))
> > >  system_ss.add(when: 'CONFIG_PLATFORM_BUS', if_true: files('sysbus-fdt.c'))
> > > +if libcbor.found() and gnutls.found()
> > > +  system_ss.add(when: 'CONFIG_NITRO_ENCLAVE', if_true: [files('eif.c'), zlib, libcbor, gnutls])
> > > +endif
> > >
> > >  system_ss.add(files(
> > >    'cpu-sysemu.c',
> >
> >
> > This change to meson.build should be in the previous patch, since
> > that's the one that introduces eif.c.
> >
> 
> 'CONFIG_NITRO_ENCLAVE' is introduced in this patch, so the
> meson.change above should stay in this patch, right?

Or we just move the changes to
configs/devices/i386-softmmu/default.mak & hw/i386/Kconfig
into the prevous patch too so CONFIG_NITRO_ENCLAVE is
available


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


