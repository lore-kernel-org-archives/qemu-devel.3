Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B350C19F2E
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2025 13:59:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnePW-0003xF-7y; Thu, 27 Feb 2025 08:58:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <roy.hopkins@randomman.co.uk>)
 id 1tne6J-0006b7-LO
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 08:38:55 -0500
Received: from smtp-out-60.livemail.co.uk ([213.171.216.60]
 helo=smtp.livemail.co.uk)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <roy.hopkins@randomman.co.uk>)
 id 1tne6H-0003yK-El
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 08:38:55 -0500
Received: from localhost.localdomain (unknown [145.40.191.116])
 (Authenticated sender: roy.hopkins@randomman.co.uk)
 by smtp.livemail.co.uk (Postfix) with ESMTPSA id 42482401F3;
 Thu, 27 Feb 2025 13:38:27 +0000 (GMT)
From: Roy Hopkins <roy.hopkins@randomman.co.uk>
To: qemu-devel@nongnu.org
Cc: Roy Hopkins <roy.hopkins@randomman.co.uk>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P . Berrange" <berrange@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Sergio Lopez <slp@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Alistair Francis <alistair@alistair23.me>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Tom Lendacky <thomas.lendacky@amd.com>,
 Michael Roth <michael.roth@amd.com>, Ani Sinha <anisinha@redhat.com>,
 Joerg Roedel <jroedel@suse.com>
Subject: [PATCH v7 00/16] Introduce support for IGVM files
Date: Thu, 27 Feb 2025 13:38:08 +0000
Message-ID: <cover.1740663410.git.roy.hopkins@randomman.co.uk>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=213.171.216.60;
 envelope-from=roy.hopkins@randomman.co.uk; helo=smtp.livemail.co.uk
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 27 Feb 2025 08:58:26 -0500
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

Here is v7 of the set of patches to add support for IGVM files to QEMU. This is
based on commit 40efe733e10cc00e4fb4f9f5790a28e744e63c62 of qemu.

Firstly, apologies for the amount of time between the last version and this one.
I moved roles to a different company and, although I always planned to see this
patch series to completion, it took a while before I found time to setup a
development environment and be in a position to send a new version. I will
continue this series using a personal email address for now, hence the change
to the author and signed-off-by emails.

The only changes in this version are to rebase on the current master branch and
update commit metadata, including Signed-Off-By and Author emails for my
replacement email address, and to include the final Reviewed-By that were added
in the last review. There were no requested changes on the previous version [1]
so I believe this series is ready to merge.

As always, thanks to those that have been following along, reviewing and testing
this series. This v7 patch series is also available on github: [2]

For testing IGVM support in QEMU you need to generate an IGVM file that is
configured for the platform you want to launch. You can use the `buildigvm`
test tool [3] to allow generation of IGVM files for all currently supported
platforms. Patch 11/17 contains information on how to generate an IGVM file
using this tool.

Changes in v7:

* Update version numbers for IGVM support to 10.0
* Add Reviewed-by to relevant commits.
* Update Author email and sign-offs to my new email address

Patch summary:

1-11: Add support and documentation for processing IGVM files for SEV, SEV-ES,
SEV-SNP and native platforms. 

12-15: Processing of policy and SEV-SNP ID_BLOCK from IGVM file. 

16: Add pre-processing of IGVM file to support synchronization of 'SEV_FEATURES'
from IGVM VMSA to KVM.

[1] Link to v6:
https://lore.kernel.org/qemu-devel/cover.1727341768.git.roy.hopkins@suse.com/

[2] v7 patches also available here:
https://github.com/roy-hopkins/qemu/tree/igvm_master_v7

[3] `buildigvm` tool v0.2.0
https://github.com/roy-hopkins/buildigvm/releases/tag/v0.2.0

Roy Hopkins (16):
  meson: Add optional dependency on IGVM library
  backends/confidential-guest-support: Add functions to support IGVM
  backends/igvm: Add IGVM loader and configuration
  hw/i386: Add igvm-cfg object and processing for IGVM files
  i386/pc_sysfw: Ensure sysfw flash configuration does not conflict with
    IGVM
  sev: Update launch_update_data functions to use Error handling
  target/i386: Allow setting of R_LDTR and R_TR with
    cpu_x86_load_seg_cache()
  i386/sev: Refactor setting of reset vector and initial CPU state
  i386/sev: Implement ConfidentialGuestSupport functions for SEV
  docs/system: Add documentation on support for IGVM
  docs/interop/firmware.json: Add igvm to FirmwareDevice
  backends/confidential-guest-support: Add set_guest_policy() function
  backends/igvm: Process initialization sections in IGVM file
  backends/igvm: Handle policy for SEV guests
  i386/sev: Add implementation of CGS set_guest_policy()
  sev: Provide sev_features flags from IGVM VMSA to KVM_SEV_INIT2

 backends/confidential-guest-support.c       |  43 +
 backends/igvm-cfg.c                         |  52 ++
 backends/igvm.c                             | 967 ++++++++++++++++++++
 backends/igvm.h                             |  23 +
 backends/meson.build                        |   5 +
 docs/interop/firmware.json                  |  30 +-
 docs/system/i386/amd-memory-encryption.rst  |   2 +
 docs/system/igvm.rst                        | 173 ++++
 docs/system/index.rst                       |   1 +
 hw/i386/pc.c                                |  12 +
 hw/i386/pc_piix.c                           |  10 +
 hw/i386/pc_q35.c                            |  10 +
 hw/i386/pc_sysfw.c                          |  31 +-
 include/hw/i386/x86.h                       |   3 +
 include/system/confidential-guest-support.h |  88 ++
 include/system/igvm-cfg.h                   |  47 +
 meson.build                                 |   8 +
 meson_options.txt                           |   2 +
 qapi/qom.json                               |  17 +
 qemu-options.hx                             |  28 +
 scripts/meson-buildoptions.sh               |   3 +
 target/i386/cpu.h                           |   9 +-
 target/i386/sev.c                           | 850 +++++++++++++++--
 target/i386/sev.h                           | 124 +++
 24 files changed, 2454 insertions(+), 84 deletions(-)
 create mode 100644 backends/igvm-cfg.c
 create mode 100644 backends/igvm.c
 create mode 100644 backends/igvm.h
 create mode 100644 docs/system/igvm.rst
 create mode 100644 include/system/igvm-cfg.h

-- 
2.43.0


