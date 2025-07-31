Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24967C87FD2
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Jul 2025 14:13:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhU1t-0004kC-EQ; Thu, 31 Jul 2025 10:13:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1uhTES-0003QS-7v
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 09:22:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1uhTEP-0007z5-65
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 09:22:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753968118;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=0pWCcll+MdaIyLr5cMqoeUdhytucWgHHnra+ZOfSJcg=;
 b=RxH3VYDIwoCchHAUdYydkGJOUSkCXsDL9i31aQTiEPTfPrf6Vom5OBwNjio3pbsbpvz2xh
 G29/7bK8sGShGZyI/vWh7TCiLtkHyXxF9XJ0tEn3GU2uASeMUl4FPElvn6bk0vl+CVECAQ
 xHDdW+l50KGJeRkjnLMSsyDagJEmw8M=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-425-DLe_C9C_Mn6D2lFlLxl5AA-1; Thu, 31 Jul 2025 09:21:57 -0400
X-MC-Unique: DLe_C9C_Mn6D2lFlLxl5AA-1
X-Mimecast-MFC-AGG-ID: DLe_C9C_Mn6D2lFlLxl5AA_1753968116
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2400499ab2fso7903605ad.0
 for <qemu-devel@nongnu.org>; Thu, 31 Jul 2025 06:21:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753968116; x=1754572916;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0pWCcll+MdaIyLr5cMqoeUdhytucWgHHnra+ZOfSJcg=;
 b=U4x2hYci3UqK5UfL+HiCSatf67QnyytMKpkgN7eTd5uMKCVdae48t8kW+PmOepdhJJ
 yETC9ID++r5ms28R9eaWcLBmE5yt5okv3krGxaV7iJLRch0t6x/5PM/+DG14LWuvVuIG
 KtPT4oqylrMf6Tnp3H6QCAxbpBkdfvMRfMeegQLwg3Nlo9/yG7zrLbGbZFW6ipM4rzsA
 AJWt9fo0WpUUvjTlyhvPmT54lMgUxiYvhCtYp/b7fqmXQLy3XCzKxylboLQThXZT8H6r
 wPlVS52s8f9MOquVlIiCOwoaquMO26AJQsDjh3Xx5paGgFJu/tNEcU+8Vj+59igy/yoI
 xkdg==
X-Gm-Message-State: AOJu0Yz4lCyNoYu9r9qjo5awC5K/67J715lpuDKCNGofRFkcm/wi1h2G
 m3Jvg6Y++Y3RpWKjuV4VLD680JxpPjB/wwo11Y9KXYBSrFgR0mM0LHDq3xX8ylAyr7a3QXifuab
 /uqGImGhcS+P48SM+sc9Bv9OUBgbw0qdutXSilA+wdnta3BdLPqk0PQi9I2iKY6+PvjGQdv7K8+
 uBS0zvGjFYAytwmASXDKSCHxOdbjWC34DJ8Hhl2r63Ug==
X-Gm-Gg: ASbGncvgx2DmfuRCAEI2f0DJtwif4Mo0VULxCHjbVB2N+UF16QCouXAxvO2aV6pAdm5
 IzCjoTAQ+QYsYBfnvIK+ikiGHMee+c2/ge0gh/Cz4weYFxGHCsWdGsx/pH5n3CCve1tPTVFUcFV
 rhMXZKX96ORPnGllLiB+rldpmnovPW609enEwfu9VzVlwPcjO4RzMNV/T5QrxBEyyi9Cfbo+D3k
 hpMROjrq+Cgf8NTX0h6z5xHfD+ZMsBMmGtCbzXNpyk1qvRLvbO3/E5KpK0iCsN+odQIYOnMGO/b
 FQ5ENVPDPsV5XWbqnoeAK+RkhqWbqGDAMzPFiIxsTjqYUQWBMsLc
X-Received: by 2002:a17:903:986:b0:240:3584:6174 with SMTP id
 d9443c01a7336-24096a9da9bmr122574945ad.21.1753968115282; 
 Thu, 31 Jul 2025 06:21:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFwXZf8+1hggytZeZo0PLo2A3fLiTJHhcxu38zbs73PKG1FMzHZ4WE4aKOA9wnNI2rAZbTlwg==
X-Received: by 2002:a17:903:986:b0:240:3584:6174 with SMTP id
 d9443c01a7336-24096a9da9bmr122573665ad.21.1753968114233; 
 Thu, 31 Jul 2025 06:21:54 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.36.99.139])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3209a84d115sm2007034a91.36.2025.07.31.06.21.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Jul 2025 06:21:53 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
Subject: [PATCH v8 00/27] migration: propagate vTPM errors using Error objects
Date: Thu, 31 Jul 2025 18:50:40 +0530
Message-Id: <20250731-propagate_tpm_error-v8-0-28fd82fdfdb2@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKlti2gC/33PwU7DMAwG4FeZcqbIcZw44cR7IDSFxtl62FqlV
 QWa+u5ku1DUwvG35M/+b2qU0smoXg43VWTuxq6/1uCfDqo9x+tJmi7VrBDQgkNqhtIP8RQnOU7
 D5Sil9KX5yBTFtWiSAVU3hyK5+3yob+81n7tx6svX48is79P/vVk30KBmTZ6jDSa9FknnOD23/
 UXdwRnXCO8jWBFvQ4DWhxQxbBDzgzDgPmIqErxLgSyBRb9BaIVot49QRWoZHQCBuYUNYtfIH3V
 sRXQmcNl7EWc3iFshqPcRV5EsmQlEW9G8QXiN2H2EK5IsMhCRCfz7k2VZvgFbEHs2VQIAAA==
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=9659; i=armenon@redhat.com;
 h=from:subject:message-id; bh=xJaaRASMzPMfHx5T6q7qKXHCk9dn89YXLF/reyGR7Uo=;
 b=owGbwMvMwCWWVaVqcZPfqI/xtFoSQ0Z37pNT/eExd7z2Xv9k28Pie1ZBTonnK4+Q7o0pq7x3C
 024OOVjRykLgxgXg6yYIkvD1wDZpoDCiEjbl9dh5rAygQxh4OIUgIlkWTH8lSnq0zePq08K7JBc
 xnxep+jay42XL79R3vPEfdGBxIoX3Qz/Y3bL/SnhrXyYbs/099GxoPrzdqJrmmxZpRfpaXJNLjz
 ICwA=
X-Developer-Key: i=armenon@redhat.com; a=openpgp;
 fpr=80F5501D82507158593DE9D76A7A2538D90F328E
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armenon@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
Changes in v8:
- 3 new patches added:
  - patch 23:
	- Changes the error propagation by returning the most recent error
	  to the caller when both save device state and post_save fails.
  - patch 24:
	- Refactors the vmstate_save_state_v() function by adding wrapper
	  functions to separate concerns.
  - patch 25:
	- Removes the error variant of the vmstate_save_state()
	  function introduced in commit 969298f9d7.
- Use ERRP_GUARD() where there is an errp dereference or an error_prepend call.
- Pass &error_warn in place of NULL, in vmstate_load_state() calls so
  that the caller knows about the error.
- Remove unnecessary null check before setting errp. Dereferencing it is not required.
- Documentation for the new variants of post/pre save/load hooks added.
- Some patches, although they received a 'Reviewed-by' tag, have undergone few minor changes,
	Patch 1 : removed extra space
	Patch 2 : Commit message changed, refactoring the function to 
		always set errp and return.
	Patch 8 : Commit message changed.
	Patch 9 : use error_setg_errno instead of error_setg.
	Patch 27 : use error_setg_errno instead of error_setg.
- Link to v7: https://lore.kernel.org/qemu-devel/20250725-propagate_tpm_error-v7-0-d52704443975@redhat.com

Changes in v7:
- Fix propagating errors in post_save_errp. The latest error encountered is
  propagated.
- user-strings in error_prepend() calls now end with a ': ' so that the print is pretty.
- Change the order of one of the patches.
- Link to v6: https://lore.kernel.org/qemu-devel/20250721-propagate_tpm_error-v6-0-fef740e15e17@redhat.com

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
Arun Menon (27):
      migration: push Error **errp into vmstate_subsection_load()
      migration: push Error **errp into vmstate_load_state()
      migration: push Error **errp into qemu_loadvm_state_header()
      migration: push Error **errp into vmstate_load()
      migration: push Error **errp into qemu_loadvm_section_start_full()
      migration: push Error **errp into qemu_loadvm_section_part_end()
      migration: Update qemu_file_get_return_path() docs and remove dead checks
      migration: make loadvm_postcopy_handle_resume() void
      migration: push Error **errp into loadvm_process_command()
      migration: push Error **errp into loadvm_handle_cmd_packaged()
      migration: push Error **errp into ram_postcopy_incoming_init()
      migration: push Error **errp into loadvm_postcopy_handle_advise()
      migration: push Error **errp into loadvm_postcopy_handle_listen()
      migration: push Error **errp into loadvm_postcopy_handle_run()
      migration: push Error **errp into loadvm_postcopy_ram_handle_discard()
      migration: push Error **errp into loadvm_handle_recv_bitmap()
      migration: push Error **errp into loadvm_process_enable_colo()
      migration: push Error **errp into loadvm_postcopy_handle_switchover_start()
      migration: push Error **errp into qemu_loadvm_state_main()
      migration: push Error **errp into qemu_loadvm_state()
      migration: push Error **errp into qemu_load_device_state()
      migration: Capture error in postcopy_ram_listen_thread()
      migration: Propagate last encountered error in vmstate_save_state_v() function
      migration: Refactor vmstate_save_state_v() function
      migration: Remove error variant of vmstate_save_state() function
      migration: Add error-parameterized function variants in VMSD struct
      backends/tpm: Propagate vTPM error on migration failure

 backends/tpm/tpm_emulator.c   |  40 ++---
 docs/devel/migration/main.rst |  24 +++
 hw/display/virtio-gpu.c       |   5 +-
 hw/pci/pci.c                  |   5 +-
 hw/s390x/virtio-ccw.c         |   4 +-
 hw/scsi/spapr_vscsi.c         |   4 +-
 hw/vfio/pci.c                 |   6 +-
 hw/virtio/virtio-mmio.c       |   5 +-
 hw/virtio/virtio-pci.c        |   4 +-
 hw/virtio/virtio.c            |   8 +-
 include/migration/colo.h      |   2 +-
 include/migration/vmstate.h   |  19 ++-
 migration/colo.c              |  13 +-
 migration/cpr.c               |  10 +-
 migration/migration.c         |  31 ++--
 migration/postcopy-ram.c      |   9 +-
 migration/postcopy-ram.h      |   2 +-
 migration/qemu-file.c         |   1 -
 migration/ram.c               |  12 +-
 migration/ram.h               |   4 +-
 migration/savevm.c            | 330 ++++++++++++++++++++++++------------------
 migration/savevm.h            |   7 +-
 migration/vmstate-types.c     |  23 +--
 migration/vmstate.c           | 190 ++++++++++++++++++------
 tests/unit/test-vmstate.c     |  26 ++--
 ui/vdagent.c                  |   5 +-
 26 files changed, 493 insertions(+), 296 deletions(-)
---
base-commit: 4e06566dbd1b1251c2788af26a30bd148d4eb6c1
change-id: 20250624-propagate_tpm_error-bf4ae6c23d30

Best regards,
-- 
Arun Menon <armenon@redhat.com>


