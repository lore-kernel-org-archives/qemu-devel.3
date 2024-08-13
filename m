Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED60DC52D7B
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2024 10:22:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdof0-00086y-7t; Tue, 13 Aug 2024 06:21:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sdoey-0007zx-8j
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 06:21:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sdoev-0006Dd-OX
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 06:21:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1723544503;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bbshnt6YM4vxz2y0yn7F3Hoq+Ulrbak4XdKn0SKRHHY=;
 b=EeLdbqIImDhR0v1jfJ8c9q0t6dVrqRuelXdRxBvUnzy8guc56D67eCvdr8GVQJuhAKgdjH
 Ys3ZDD1f4u5doxlAwe+oPGWI3SZRlxq/Qvjem2WsDQDSRl1P4OoXZPR9jvOjM+FbapZT9X
 tABD47ViG/p0HLSDh0SlzZFSFqFrnKA=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-686-EjMwKTT-PjSC2QyRqjdBXg-1; Tue, 13 Aug 2024 06:21:42 -0400
X-MC-Unique: EjMwKTT-PjSC2QyRqjdBXg-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-a77e044ff17so344615466b.3
 for <qemu-devel@nongnu.org>; Tue, 13 Aug 2024 03:21:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723544501; x=1724149301;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bbshnt6YM4vxz2y0yn7F3Hoq+Ulrbak4XdKn0SKRHHY=;
 b=oaYo2SXVgC7PhQqidKMIgQYx57ha+nyOwDTXxazfx00t28D1rjZ4G947qWuqv2/6Ey
 CbWJhocOFjAHVqwSupfEyQkQLcFCQPEKh45c5ArPI0QMFy92r7ZMR0kBu7opLIu8PRUS
 96jduuP8+rRqZ8kyCHCuZJxypqV2zZkCw8lcIkdr/abD6zZIagyJDZqBZ/L5GYqp2h7+
 Mletaky09XWxFljaBXtS1+WLg0vl/OhFy/9F8uIFr+zxSQliE3QjEGneTEyLnMTfOxW0
 W2c9Hh+MbVd2QEYHAbr1TBfxmycUaTRir15SoETwHBENruKLMAQEuvTlZeiDQXuXTJZK
 4Z8g==
X-Gm-Message-State: AOJu0YxsridT8mmgZ01jf1aGlbtBrbQtn5lL3UhEgc470/lAYomgFcO4
 ENilIsVcfoFPJvRXJfm2lvvXbqYwlCPzHbWgjDj7rSesgNFEB/z3wXJGrRQivbwaEarKtOo9K16
 bcO6Y6HeY58bew80+2Le5kMwgLeG9VnYhUco+OaDuWJpMqbL7maxL
X-Received: by 2002:a17:906:6a0b:b0:a7d:3de1:4abd with SMTP id
 a640c23a62f3a-a80ed24cb2cmr191870466b.39.1723544500826; 
 Tue, 13 Aug 2024 03:21:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF9AthSI6gYvygZdsb77DFi7ZCi3FmgsMnTjcISjlltr0Ydc7XvhZxH3Mp/5zhjvtQ15SbEZw==
X-Received: by 2002:a17:906:6a0b:b0:a7d:3de1:4abd with SMTP id
 a640c23a62f3a-a80ed24cb2cmr191867066b.39.1723544500024; 
 Tue, 13 Aug 2024 03:21:40 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:346:dcde:9c09:aa95:551d:d374])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a80f3fa69c3sm57736966b.55.2024.08.13.03.21.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Aug 2024 03:21:39 -0700 (PDT)
Date: Tue, 13 Aug 2024 06:21:32 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Roy Hopkins <roy.hopkins@suse.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Sergio Lopez <slp@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Tom Lendacky <thomas.lendacky@amd.com>,
 Michael Roth <michael.roth@amd.com>, Ani Sinha <anisinha@redhat.com>,
 =?iso-8859-1?Q?J=F6rg?= Roedel <jroedel@suse.com>
Subject: Re: [PATCH v4 00/17] Introduce support for IGVM files
Message-ID: <20240813062034-mutt-send-email-mst@kernel.org>
References: <cover.1720004383.git.roy.hopkins@suse.com>
 <20240720142552-mutt-send-email-mst@kernel.org>
 <1498c181139068d2297abd61dbee39cd82ab4e26.camel@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1498c181139068d2297abd61dbee39cd82ab4e26.camel@suse.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.126,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Aug 13, 2024 at 10:53:58AM +0100, Roy Hopkins wrote:
> On Sat, 2024-07-20 at 14:26 -0400, Michael S. Tsirkin wrote:
> > On Wed, Jul 03, 2024 at 12:05:38PM +0100, Roy Hopkins wrote:
> > > Here is v4 of the set of patches to add support for IGVM files to QEMU. This
> > > is
> > > based on commit 1a2d52c7fc of qemu.
> > > 
> > > This version addresses all of the review comments from v3 along with a
> > > couple of
> > > small bug fixes. This is a much smaller increment than in the previous
> > > version
> > > of the series [1]. Thanks once again to the reviewers that have been looking
> > > at
> > > this series. This v4 patch series is also available on github: [2]
> > > 
> > > The previous version had a build issue when building without debug enabled.
> > > Patch 8/17 has been added to fix this and I've updated my own process to
> > > test
> > > both debug and release builds of QEMU.
> > > 
> > > For testing IGVM support in QEMU you need to generate an IGVM file that is
> > > configured for the platform you want to launch. You can use the `buildigvm`
> > > test tool [3] to allow generation of IGVM files for all currently supported
> > > platforms. Patch 11/17 contains information on how to generate an IGVM file
> > > using this tool.
> > 
> > PC things:
> > 
> > Acked-by: Michael S. Tsirkin <mst@redhat.com>
> > 
> > 
> 
> Hi Michael,
> 
> Thanks for this. Can I add your ack to all commits, or just the PC specific
> ones?
> 
> Regards,
> Roy


I reviewed the pc things and skimmed the rest. So reviewed-by
for pc things and Ack for the rest.

> > > Changes in v4:
> > > 
> > > * Remove unused '#ifdef CONFIG_IGVM' sections
> > > * Add "'if': 'CONFIG_IGVM'" for IgvmCfgProperties in qom.json
> > > * Use error_fatal instead of error_abort in suggested locations
> > > * Prevent addition of bios code when an IGVM file is provided and
> > > pci_enabled is false
> > > * Add patch 6/17 to fix error handling from sev_encrypt_flash()
> > > * Revert unrequired changes to return values in sev/*_launch_update()
> > > functions
> > > * Add documentation to igvm.rst to describe how to use 'buildigvm'
> > > * Various convention and code style changes as suggested in reviews
> > > * Fix handling of sev_features for kernels that do not support KVM_SEV_INIT2
> > > * Move igvm-cfg from MachineState to X86MachineState
> > > 
> > > Patch summary:
> > > 
> > > 1-12: Add support and documentation for processing IGVM files for SEV, SEV-
> > > ES,
> > > SEV-SNP and native platforms. 
> > > 
> > > 13-16: Processing of policy and SEV-SNP ID_BLOCK from IGVM file. 
> > > 
> > > 17: Add pre-processing of IGVM file to support synchronization of
> > > 'SEV_FEATURES'
> > > from IGVM VMSA to KVM.
> > > 
> > > [1] Link to v3:
> > > https://lore.kernel.org/qemu-devel/cover.1718979106.git.roy.hopkins@suse.com/
> > > 
> > > [2] v4 patches also available here:
> > > https://github.com/roy-hopkins/qemu/tree/igvm_master_v4
> > > 
> > > [3] `buildigvm` tool v0.2.0
> > > https://github.com/roy-hopkins/buildigvm/releases/tag/v0.2.0
> > > 
> > > Roy Hopkins (17):
> > >   meson: Add optional dependency on IGVM library
> > >   backends/confidential-guest-support: Add functions to support IGVM
> > >   backends/igvm: Add IGVM loader and configuration
> > >   hw/i386: Add igvm-cfg object and processing for IGVM files
> > >   i386/pc_sysfw: Ensure sysfw flash configuration does not conflict with
> > >     IGVM
> > >   sev: Fix error handling in sev_encrypt_flash()
> > >   sev: Update launch_update_data functions to use Error handling
> > >   target/i386: Allow setting of R_LDTR and R_TR with
> > >     cpu_x86_load_seg_cache()
> > >   i386/sev: Refactor setting of reset vector and initial CPU state
> > >   i386/sev: Implement ConfidentialGuestSupport functions for SEV
> > >   docs/system: Add documentation on support for IGVM
> > >   docs/interop/firmware.json: Add igvm to FirmwareDevice
> > >   backends/confidential-guest-support: Add set_guest_policy() function
> > >   backends/igvm: Process initialization sections in IGVM file
> > >   backends/igvm: Handle policy for SEV guests
> > >   i386/sev: Add implementation of CGS set_guest_policy()
> > >   sev: Provide sev_features flags from IGVM VMSA to KVM_SEV_INIT2
> > > 
> > >  docs/interop/firmware.json                 |   9 +-
> > >  docs/system/i386/amd-memory-encryption.rst |   2 +
> > >  docs/system/igvm.rst                       | 173 ++++
> > >  docs/system/index.rst                      |   1 +
> > >  meson.build                                |   8 +
> > >  qapi/qom.json                              |  17 +
> > >  backends/igvm.h                            |  23 +
> > >  include/exec/confidential-guest-support.h  |  96 +++
> > >  include/hw/i386/x86.h                      |   3 +
> > >  include/sysemu/igvm-cfg.h                  |  54 ++
> > >  target/i386/cpu.h                          |   9 +-
> > >  target/i386/sev.h                          | 124 +++
> > >  backends/confidential-guest-support.c      |  43 +
> > >  backends/igvm-cfg.c                        |  66 ++
> > >  backends/igvm.c                            | 958 +++++++++++++++++++++
> > >  hw/i386/pc.c                               |  12 +
> > >  hw/i386/pc_piix.c                          |  10 +
> > >  hw/i386/pc_q35.c                           |  10 +
> > >  hw/i386/pc_sysfw.c                         |  31 +-
> > >  target/i386/sev.c                          | 844 ++++++++++++++++--
> > >  backends/meson.build                       |   5 +
> > >  meson_options.txt                          |   2 +
> > >  qemu-options.hx                            |  25 +
> > >  scripts/meson-buildoptions.sh              |   3 +
> > >  24 files changed, 2447 insertions(+), 81 deletions(-)
> > >  create mode 100644 docs/system/igvm.rst
> > >  create mode 100644 backends/igvm.h
> > >  create mode 100644 include/sysemu/igvm-cfg.h
> > >  create mode 100644 backends/igvm-cfg.c
> > >  create mode 100644 backends/igvm.c
> > > 
> > > -- 
> > > 2.43.0
> > 
> 


