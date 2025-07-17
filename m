Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB347C83F27
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Jul 2025 00:41:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucCed-0002Tf-EG; Wed, 16 Jul 2025 20:39:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1ucCeb-0002ON-8e
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 20:39:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1ucCeW-0004WA-OU
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 20:39:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752712751;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=PeeU82WFsHPg3QKNSZZ0camE5JgN5YWNHo/qkXP5kac=;
 b=hMLLGbW5GmCzT6DQdwgH8efKutbJZCd4/h7wfF3YJyT7x0w6AaYylBu9VgSWA0rnacr6Fa
 kFlFOBixb3VbcLEEKcQ7FPFFyo4KgyP1X1mL7GFxRO5vml1r8uPfFh+g3GiIbAzHuNmXw3
 CP6YZbiZra70fh0ZqSbB44th0xTlQIM=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-56-8zGe1JoXO7-DrdiR9iVMuw-1; Wed, 16 Jul 2025 20:39:09 -0400
X-MC-Unique: 8zGe1JoXO7-DrdiR9iVMuw-1
X-Mimecast-MFC-AGG-ID: 8zGe1JoXO7-DrdiR9iVMuw_1752712748
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-31366819969so377284a91.0
 for <qemu-devel@nongnu.org>; Wed, 16 Jul 2025 17:39:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752712748; x=1753317548;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PeeU82WFsHPg3QKNSZZ0camE5JgN5YWNHo/qkXP5kac=;
 b=NhTlLTnd3OVyCVOu0lLVTuI6uIFjbcVEIKnIbIPxdNp132dUGVEvHHQP8Y5ecxdN/7
 cHXccr90xGgjzEUw2p0JWkKk1GoRtwv8OgMFR6u0IvGfXfCUry0xO4ftczEOo9V2ooxe
 yqS1usRoumZ6Sqr66sA+jsdMgi0N5t8Ymno6q5oMR3JkNpNe08BRZLut2E429lqtzqEt
 UbmDSTY0ji4wPn5AgwgSIlTOEBc50yjfRDkRG96XXPJhNGozM/mbcaITJpH0b3qxpplW
 W9j2F1zPG3e+qeN0JjLjCvTJeYudR4Ow8lX0ffIqvX49BAWYmbdTw7NbpfBplWg8JWaM
 8lSg==
X-Gm-Message-State: AOJu0YzG/aprQXhcgOhM4HH7pBfBCfbT4XVLUnMCADPL4WoMR46EiTsF
 6+nJzCNalJeuNLdE4waBWddlU+EQKbQ/gezzKdCHXrFtHnp9FYc4T4CAYA7OsxgmXfoNzxoSzWK
 3mZICgAVMl9h5bu0Im/tN7M5N2Pewm8wZ48trd+a0Al5z9FEspkLcylwy
X-Gm-Gg: ASbGnctMq8i9kvD5QXXXstuFLFSAVOvnnynG8GCTAokYCdvrXpUYB4pCPNHwDEWO4XF
 Aj6AzNh5enrW1tw28MAk8IfSkDAZAva0qA6touwsUUaTJ/l+o36C8f74PPZRPwxWWGTBvgAwBxr
 s8ANQPQCnM5Df21snmbDTUZZ1xpeIYHPcRkvcNMXEeJ/AKW9iGTKADl51puuC3lUPy/AyvIfK6C
 SQ51xmX9Y8vjJz8/X9rCOVpZDoLwYieLhkcJ/DCW54jWrCwpXkDj5lAoJZ+OochGxLGdIoCN9Mv
 qVOV3STRUF6vzQXBKkDq8CIrJQD+wUx65lEGn1mCm+akQufPycm0
X-Received: by 2002:a17:90b:5610:b0:313:bdbf:36c0 with SMTP id
 98e67ed59e1d1-31c9e605f80mr8625937a91.0.1752712748430; 
 Wed, 16 Jul 2025 17:39:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEDSdJp5myLew/QT09GC24PCvOYBGv+VLI5PbhOrl3ZbGt6tBbCaQgCWD36FaD17Gh8F6aAwQ==
X-Received: by 2002:a17:90b:5610:b0:313:bdbf:36c0 with SMTP id
 98e67ed59e1d1-31c9e605f80mr8625893a91.0.1752712747980; 
 Wed, 16 Jul 2025 17:39:07 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.36.97.205])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-31c9f287c19sm2214424a91.31.2025.07.16.17.38.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Jul 2025 17:39:07 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
Subject: [PATCH v5 00/23] migration: propagate vTPM errors using Error objects
Date: Thu, 17 Jul 2025 06:07:23 +0530
Message-Id: <20250717-propagate_tpm_error-v5-0-1f406f88ee65@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMNFeGgC/33PwW7CMAyA4VdBOS/IcZIm4bT3mBDKEkNzgFRuV
 W1CfXcCl4Godvwt+bN8FSNxoVHsNlfBNJex1EsL+7ERqY+XE8mSWwsEtNChkQPXIZ7iRIdpOB+
 IubL8PppIXUKdNYi2OTAdy89D/dq37ss4Vf59HJnVffq/NysJEpVTxrtog86fTLmP0zbVs7iDM
 z4jbh3BhngbAiQfcsTwhug/xAGuI7ohwXc5GGvAon9DzBOiunXENKQ9owIgOJfgBVmW5Qbhqwe
 UhgEAAA==
X-Change-ID: 20250624-propagate_tpm_error-bf4ae6c23d30
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, 
 Eric Farman <farman@linux.ibm.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>, 
 Thomas Huth <thuth@redhat.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>, 
 Nicholas Piggin <npiggin@gmail.com>, 
 Daniel Henrique Barboza <danielhb413@gmail.com>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, 
 Alex Williamson <alex.williamson@redhat.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Hailiang Zhang <zhanghailiang@xfusion.com>, 
 Steve Sistare <steven.sistare@oracle.com>, qemu-s390x@nongnu.org, 
 qemu-ppc@nongnu.org, Stefan Berger <stefanb@linux.vnet.ibm.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, 
 Matthew Rosato <mjrosato@linux.ibm.com>, Arun Menon <armenon@redhat.com>, 
 Stefan Berger <stefanb@linux.vnet.ibm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=7240; i=armenon@redhat.com;
 h=from:subject:message-id; bh=ovJd+leNG3KQs7cb4bjUmRlP0GDdSCTZiPZ3ewe7zmE=;
 b=owGbwMvMwCWWVaVqcZPfqI/xtFoSQ0aFmzjT3H8ipRIXHf8/1LqS6O28NkV+dZGDcGbHm4tJ4
 qYFX791lLIwiHExyIopsjR8DZBtCiiMiLR9eR1mDisTyBAGLk4BmIhBKMM//bnSHlppe7gVgiql
 Vyulvw9O0pvKkfRWTNZrkt3dC4saGRkeW7vujbkRfmTPO/kXnl+5amy/Tok+r6WqmRRkePmhkSw
 PAA==
X-Developer-Key: i=armenon@redhat.com; a=openpgp;
 fpr=80F5501D82507158593DE9D76A7A2538D90F328E
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armenon@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Hello,

Currently, when a migration of a VM with an encrypted vTPM
fails on the destination host (e.g., due to a mismatch in secret values),
the error message displayed on the source host is generic and unhelpful.

For example, a typical error looks like this:
"operation failed: job 'migration out' failed: Sibling indicated error 1.
operation failed: job 'migration in' failed: load of migration failed:
Input/output error"

This message does not provide any specific indication of a vTPM failure.
Such generic errors are logged using error_report(), which prints to
the console/monitor but does not make the detailed error accessible via
the QMP query-migrate command.

This series addresses the issue, by ensuring that specific TPM error
messages are propagated via the QEMU Error object.
To make this possible,
- A set of functions in the call stack is changed
  to incorporate an Error object as an additional parameter.
- Also, the TPM backend makes use of a new hook called post_load_errp()
  that explicitly passes an Error object.

It is organized as follows,
 - Patches 1-21 focuses on pushing Error object into the functions
   that are important in the call stack where TPM errors are observed.
   We still need to make changes in rest of the functions in savevm.c
   such that they also incorporate the errp object for propagating errors.
 - Patch 22 introduces the new variants of the hooks in VMStateDescription
   structure. These hooks should be used in future implementations.
 - Patch 23 focuses on changing the TPM backend such that the errors are
   set in the Error object.

While this series focuses specifically on TPM error reporting during
live migration, it lays the groundwork for broader improvements.
A lot of methods in savevm.c that previously returned an integer now capture
errors in the Error object, enabling other modules to adopt the
post_load_errp hook in the future.

One such change previously attempted:
https://lists.gnu.org/archive/html/qemu-devel/2021-02/msg01727.html

Resolves: https://issues.redhat.com/browse/RHEL-82826

Signed-off-by: Arun Menon <armenon@redhat.com>
---
Changes in v5:
- Solve a bug that set errp even though it was not NULL, pointed out by Fabiano in v4.
- Link to v4: https://lore.kernel.org/qemu-devel/20250716-propagate_tpm_error-v4-0-7141902077c0@redhat.com

Changes in v4:
- Split the patches into smaller ones based on functions. Pass NULL in the
  caller until errp is made available. Every function that has an
  Error **errp object passed to it, ensures that it sets the errp object
  in case of failure.
- A few more functions within loadvm_process_command() now handle errors using
  the errp object. I've converted these for consistency, taking Daniel's
  patches (link above) as a reference.
- Along with the post_load_errp() hook, other duplicate hooks are also introduced.
  This will enable us to migrate to the newer versions eventually.
- Fix some semantic errors, like using error_propagate_prepend() in places where
  we need to preserve existing behaviour of accumulating the error in local_err
  and then propagating it to errp. This can be refactored in a later commit.
- Add more information in commit messages explaining the changes.
- Link to v3: https://lore.kernel.org/qemu-devel/20250702-propagate_tpm_error-v3-0-986d94540528@redhat.com

Changes in v3:
- Split the 2nd patch into 2. Introducing post_load_with_error() hook
  has been separated from using it in the backends TPM module. This is
  so that it can be acknowledged.
- Link to v2: https://lore.kernel.org/qemu-devel/20250627-propagate_tpm_error-v2-0-85990c89da29@redhat.com

Changes in v2:
- Combine the first two changes into one, focusing on passing the
  Error object (errp) consistently through functions involved in
  loading the VM's state. Other functions are not yet changed.
- As suggested in the review comment, add null checks for errp
  before adding error messages, preventing crashes.
  We also now correctly set errors when post-copy migration fails.
- In process_incoming_migration_co(), switch to error_prepend
  instead of error_setg. This means we now null-check local_err in
  the "fail" section before using it, preventing dereferencing issues.
- Link to v1: https://lore.kernel.org/qemu-devel/20250624-propagate_tpm_error-v1-0-2171487a593d@redhat.com

---
Arun Menon (23):
      migration: push Error **errp into vmstate_subsection_load()
      migration: push Error **errp into vmstate_load_state()
      migration: push Error **errp into qemu_loadvm_state_header()
      migration: push Error **errp into vmstate_load()
      migration: push Error **errp into qemu_loadvm_section_start_full()
      migration: push Error **errp into qemu_loadvm_section_part_end()
      migration: push Error **errp into loadvm_process_command()
      migration: push Error **errp into loadvm_handle_cmd_packaged()
      migration: push Error **errp into ram_postcopy_incoming_init()
      migration: push Error **errp into loadvm_postcopy_handle_advise()
      migration: push Error **errp into loadvm_postcopy_handle_listen()
      migration: push Error **errp into loadvm_postcopy_handle_run()
      migration: push Error **errp into loadvm_postcopy_ram_handle_discard()
      migration: make loadvm_postcopy_handle_resume() void
      migration: push Error **errp into loadvm_handle_recv_bitmap()
      migration: push Error **errp into loadvm_process_enable_colo()
      migration: push Error **errp into loadvm_postcopy_handle_switchover_start()
      migration: push Error **errp into qemu_loadvm_state_main()
      migration: push Error **errp into qemu_loadvm_state()
      migration: push Error **errp into qemu_load_device_state()
      migration: Capture error in postcopy_ram_listen_thread()
      migration: Add error-parameterized function variants in VMSD struct
      backends/tpm: Propagate vTPM error on migration failure

 backends/tpm/tpm_emulator.c |  39 +++---
 hw/display/virtio-gpu.c     |   2 +-
 hw/pci/pci.c                |   2 +-
 hw/s390x/virtio-ccw.c       |   2 +-
 hw/scsi/spapr_vscsi.c       |   2 +-
 hw/vfio/pci.c               |   2 +-
 hw/virtio/virtio-mmio.c     |   2 +-
 hw/virtio/virtio-pci.c      |   2 +-
 hw/virtio/virtio.c          |   4 +-
 include/migration/colo.h    |   2 +-
 include/migration/vmstate.h |  13 +-
 migration/colo.c            |  10 +-
 migration/cpr.c             |   4 +-
 migration/migration.c       |  19 +--
 migration/postcopy-ram.c    |   9 +-
 migration/postcopy-ram.h    |   2 +-
 migration/ram.c             |  14 +--
 migration/ram.h             |   4 +-
 migration/savevm.c          | 293 +++++++++++++++++++++++++-------------------
 migration/savevm.h          |   7 +-
 migration/vmstate-types.c   |  10 +-
 migration/vmstate.c         |  83 +++++++++----
 tests/unit/test-vmstate.c   |  18 +--
 ui/vdagent.c                |   2 +-
 24 files changed, 321 insertions(+), 226 deletions(-)
---
base-commit: f96b157ebb93f94cd56ebbc99bc20982b8fd86ef
change-id: 20250624-propagate_tpm_error-bf4ae6c23d30

Best regards,
-- 
Arun Menon <armenon@redhat.com>


