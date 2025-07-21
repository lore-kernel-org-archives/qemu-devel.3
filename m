Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4ECEFC83F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Jul 2025 11:35:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1udoiT-0007EC-T2; Mon, 21 Jul 2025 07:29:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1udoiC-0006yX-Op
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 07:29:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1udoi9-0000b4-59
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 07:29:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753097375;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=r0ZtwJu78fIFKUQVdqfEBLuK8HO1eTvK9U+QyWlvatQ=;
 b=CxtUtgEOob18D2ryXhmxj2k71FVuvsestWu4Wg73geV2q+Wp43UI37TCYCAsig36dLb6rt
 /r6t31CuKK0jS1TGMRWmuINDqxPDsQ9CBgfabjxO8NGDGUH1bKzl6l+YpSZI3UXvYm54qz
 7fxTWZqIx19+opSD8k3m8o7pKZ1qqNM=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-605-a4NHprjuPkuW5tVqVa4a2w-1; Mon, 21 Jul 2025 07:29:33 -0400
X-MC-Unique: a4NHprjuPkuW5tVqVa4a2w-1
X-Mimecast-MFC-AGG-ID: a4NHprjuPkuW5tVqVa4a2w_1753097372
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-313c3915345so6191042a91.3
 for <qemu-devel@nongnu.org>; Mon, 21 Jul 2025 04:29:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753097372; x=1753702172;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=r0ZtwJu78fIFKUQVdqfEBLuK8HO1eTvK9U+QyWlvatQ=;
 b=INC2LbCM9pIklWxJd+Pt2XgTRj48kkEaSkFNgq7Cg+sWFHi3E3YxhR+nNYGp37/a7e
 6sEzh04brqnEjZbPdahzEhKFfJLkdCV5Khg0LhbYhrut3vYFA2eZaiYst0/ag50bSvk5
 gGKvmsGpxhhYFTqm7rMMgE/FpU8oyzsKtAbP5NV1VfmWEQN72XMGg4G/XfGo32RyVfdz
 A4Nf48TZtos4hQpOt0i2Z4DJSTPfYjNtV87sWfj4o8xiFjaOOqtbO5Wbuge9XkJQRXcv
 H8uiDchhFzVmfcD1Myf92/ynZpM3ArVRgZjq5OQ1uHtPnbwIlHZhQbgKiiaRb8piKWxR
 m86A==
X-Gm-Message-State: AOJu0YziUePeyDueMpMm4qBa59EjIh1oFWg4Uo+I14NOS1l3jF5JzDI2
 VI2OzHLV45j1FxP1FIOtsr4+19c5jPRcTepDpKpSqgEyoVkZsih7cG4SSL+2ep+lZ6t0sQ7VBqc
 hCm1oY+4F5cLFuNbBc9tD3gSdXloYShuX4u3a1fn4fNjORfyFsJ6A8UC+
X-Gm-Gg: ASbGncts81e0/SKs51ZWRA4bwHklIOQwTW36rnCoCDSqw08wjanBsDjcgaKQeNrOp7p
 YYgh86mFvyGslu9ZRAlMYtwS5JvadtOERXkcZrn2JZcLQHY3GPcPSmOp4uuVYAdygEUxKON7OeE
 tKEFMmXCkvN6dY9xnqO0dLRyJtqymzDYvJXNIo+ABRcQc3EqC2EMjvwN/pnOJ3BPW6wkCEQAwSO
 1iuZA5SNQMOUlAG+OXb4rh7EsM8Ft2KZVqb2Xtyk7OTNCygFhBGtuDCbsCFhj49dKYAXuMyHmTi
 gn4zfHjaCl7iTkUoPBCeEeWAdLef8mOQJsVBZ2ydNn+s4mYCUZqJ
X-Received: by 2002:a17:90a:e70e:b0:313:279d:665c with SMTP id
 98e67ed59e1d1-31caf821883mr20846669a91.7.1753097372167; 
 Mon, 21 Jul 2025 04:29:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE1HKqCZrzrN6JZN7Exv6ReXoJWDXOJl/80K47oX6KP0w7dmwTErR2CHnPY18g5Vx/xIx8BRQ==
X-Received: by 2002:a17:90a:e70e:b0:313:279d:665c with SMTP id
 98e67ed59e1d1-31caf821883mr20846624a91.7.1753097371672; 
 Mon, 21 Jul 2025 04:29:31 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.36.101.21])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23e3b5e3c89sm56150465ad.18.2025.07.21.04.29.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Jul 2025 04:29:31 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
Subject: [PATCH v6 00/24] migration: propagate vTPM errors using Error objects
Date: Mon, 21 Jul 2025 16:59:05 +0530
Message-Id: <20250721-propagate_tpm_error-v6-0-fef740e15e17@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIIkfmgC/33PTWrDMBAF4KsErasyGv131XuUEFRpHGuRyMjGN
 ATfvUo2dbHb5RuY7/HubKSaaWRvhzurNOcxl2sL5uXAYh+uZ+I5tcwQUINBxYdahnAOE52m4XK
 iWkvln50KZCLKJIG1z6FSl7+e6sex5T6PU6m3Z8ksHtf/vVlw4CisUM4G7WV6r5T6ML3GcmEPc
 MY1YvcRbIjT3kN0PgX0G0T+IBZwH5EN8c4kr7QCjW6DqBUizD6iGtLGCA8I1kbYIHqN/DFHN0R
 0CkznHJHRv5BlWb4ByurzLssBAAA=
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
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Stefan Berger <stefanb@linux.vnet.ibm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=7724; i=armenon@redhat.com;
 h=from:subject:message-id; bh=7J0znC18jEgkYFfYar9ns8MZ9NX1hrTNXc6koZDxfw4=;
 b=owGbwMvMwCWWVaVqcZPfqI/xtFoSQ0adyoRlqWwzPeZoGj5a4/MwMJ9XnmVzXKDtt+S7Kfsvz
 Hzdl3Sto5SFQYyLQVZMkaXha4BsU0BhRKTty+swc1iZQIYwcHEKwETMTjAy7Le9uWgDi0jN0XWX
 t8vtE353bp/u2nOfTa3Yf5oxtOm/9GH4Zz27627M2pMay+1Sjv6cL9+hfZ/v72WFBaxCUh2vbju
 mMgIA
X-Developer-Key: i=armenon@redhat.com; a=openpgp;
 fpr=80F5501D82507158593DE9D76A7A2538D90F328E
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armenon@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.926,
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
Changes in v6:
- Incorporated review comments from Daniel and Akihiko, related to few
  semantic errors and improve error logging.
- Add one more patch that removes NULL checks after calling 
  qemu_file_get_return_path() because it does not fail.
- Link to v5: https://lore.kernel.org/qemu-devel/20250717-propagate_tpm_error-v5-0-1f406f88ee65@redhat.com

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
Arun Menon (24):
      migration: push Error **errp into vmstate_subsection_load()
      migration: push Error **errp into vmstate_load_state()
      migration: push Error **errp into qemu_loadvm_state_header()
      migration: push Error **errp into vmstate_load()
      migration: push Error **errp into qemu_loadvm_section_start_full()
      migration: push Error **errp into qemu_loadvm_section_part_end()
      migration: Update qemu_file_get_return_path() docs and remove dead checks
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
 migration/colo.c            |  12 +-
 migration/cpr.c             |   4 +-
 migration/migration.c       |  31 ++---
 migration/postcopy-ram.c    |   9 +-
 migration/postcopy-ram.h    |   2 +-
 migration/qemu-file.c       |   1 -
 migration/ram.c             |  14 +-
 migration/ram.h             |   4 +-
 migration/savevm.c          | 309 +++++++++++++++++++++++++-------------------
 migration/savevm.h          |   7 +-
 migration/vmstate-types.c   |  10 +-
 migration/vmstate.c         |  94 ++++++++++----
 tests/unit/test-vmstate.c   |  18 +--
 ui/vdagent.c                |   2 +-
 25 files changed, 342 insertions(+), 247 deletions(-)
---
base-commit: f96b157ebb93f94cd56ebbc99bc20982b8fd86ef
change-id: 20250624-propagate_tpm_error-bf4ae6c23d30

Best regards,
-- 
Arun Menon <armenon@redhat.com>


