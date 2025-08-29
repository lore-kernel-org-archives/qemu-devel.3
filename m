Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7AC6CA0FFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 16:27:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNbO-0005mc-SA; Sat, 30 Aug 2025 11:34:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1us5J7-0004hX-DG
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 16:02:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1us5J1-0004Vu-JO
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 16:02:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756497756;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=oeUJ2WWP7HoGGvk5HadTQRJGJreECKIpIHTeFNUMKlc=;
 b=RwNppjASWb++cG5iY72yFIeFurJDEw9cjvX8bZtVR5JheiqT1H4S4Nsjf9iyIIkxJy8hbd
 8m6H/vqTpD+jpYicZzrURM/BPiIbM5j48Fyj+Czr4hh2XvOeeTeVkEsi8Ef185372MriYr
 15fyVaxd5y2AqFXewZhHSJSjIQFqN5Q=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-674-KebiuDDqN7yeocGUn-3BRQ-1; Fri, 29 Aug 2025 16:02:35 -0400
X-MC-Unique: KebiuDDqN7yeocGUn-3BRQ-1
X-Mimecast-MFC-AGG-ID: KebiuDDqN7yeocGUn-3BRQ_1756497754
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-325ce1082bcso3866877a91.0
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 13:02:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756497754; x=1757102554;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oeUJ2WWP7HoGGvk5HadTQRJGJreECKIpIHTeFNUMKlc=;
 b=j+Cj9C16tzHY4w5FDHLZfQt9EqiLUaxR5TxHTwnxK6lj7SSWEyjOmc6H7G1ZAoLunj
 W3HSFLtkhF7b4ZNorEABNYjpXahft/032GAqwK0+TTXLD1bO5kwKo99l47Ba2UzHzLHG
 KDl/+/fYwfw/ffTBQv2kkQ3xJAabgyc/akeG1lDawf3Mqc/ppb3b7ddWHrHHkE6lGOgS
 RRi9uYEFufI2GutShjAhkyMv4OSFWUWazCf2yA776f6qJusQWq9UQpkRK08OHAwMkGl6
 qKmci6Ys/3SrKhjfk9v5Hbm3NuHmvxfSALIu0RBUOkXI51HXnNrdzmOnUJRsFo5xJEtQ
 YVQQ==
X-Gm-Message-State: AOJu0YwO1fQ4W9I7KE8PdGf84Jp3HOsnnBE8P23lMXAXYyNqKETYTu7y
 wP9BW2HbYOSBStQxbybGOPISHetkWgfMWwOdCdSTssd0H79wVYf5+VafL4oW6TQqOtUUCOrn/w9
 jYVKL/sjy61nOLIkq+Q4rXOFSv7rzie2471WJByK4JSHj7+R4oZciWNb5
X-Gm-Gg: ASbGnctoOPXOohK8bFtnWVUAL+2dAtvIyvRNRBx3XRhco29jTKXqvCIM6LTxGlBt4Ln
 nfC+X5J3Fekka8tuZj43qZD8w5xPTXNkWfn0BDBhqwCFxRI3vnCAvoZqladURX1KS/wbwTFh1ZI
 XSxrh+XHmwnFGaDXc28wtIB5RW5mzPJHxpRtEASlfANsYo4wH4AnpfIJ4AA77zSMco9YfocgPQ0
 6zB672XuiMudhTJgUpcLlxKv3xhfY2zum80oOnsDusiV/7D3zgcJpJ7odJ+Mj32zQpf6o7Q9LMz
 TSLjdZnSdflNbR6Di5XdDrHrOoJesXxujddjeb+CsaWl+0AWkxtV1A==
X-Received: by 2002:a17:90b:510e:b0:327:f99c:d490 with SMTP id
 98e67ed59e1d1-327f99cd529mr3721907a91.37.1756497753482; 
 Fri, 29 Aug 2025 13:02:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH+s8Mkc9th0RuNcOZK5oZAZ4UVVI8XuZThqtBhwsN/dgXXCbOBxhcNL7LkQ/dap4q231yAbg==
X-Received: by 2002:a17:90b:510e:b0:327:f99c:d490 with SMTP id
 98e67ed59e1d1-327f99cd529mr3721841a91.37.1756497752790; 
 Fri, 29 Aug 2025 13:02:32 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.47.195.108])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-327d8f66f16sm3570543a91.0.2025.08.29.13.02.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 13:02:32 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
Subject: [PATCH v13 00/27] migration: propagate vTPM errors using Error objects
Date: Sat, 30 Aug 2025 01:31:40 +0530
Message-Id: <20250830-propagate_tpm_error-v13-0-a4e777b7eb2c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACUHsmgC/33SwW7DIAwG4Fepcl4m20Bsdtp7TFNFArQ5dIloV
 W2q+u4jvZSJZEcQfNj4vzXnkMZwbt52tyaF63gep6+8QPWya4aj+zqEdvR5oyEgAx3pdk7T7A7
 uEvaX+bQPKU2p7aN2oRtIeQVNvjmnEMfvB/vxmdfH8XyZ0s/jlSsuu/97V2yhJWTUws5Y5d9T8
 Ed3eR2mU7OAVyoRXkcoI2KshUGsd2QrRD0RBlpHVEasdN5qo8GQVIguEOzWEZ2R3AxaIGAeoEJ
 MiWy0YzKCUUMXRULoTIV0BUK4jnQZiSGyhoAmIFcIl4hZRzgj3hCD1lpZriuRAlEblcgyYoleK
 Proe6oQ+0QENiqxy5+Q0vkIgu/rdhBKRTbSBplRQdChz0NaqQWL0AqqDWZJba8ZnGLda6pTi0V
 sZWtEuOSWqRdQgYH98Ie53++/dISWDbUDAAA=
X-Change-ID: 20250624-propagate_tpm_error-bf4ae6c23d30
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, 
 Eric Farman <farman@linux.ibm.com>, Thomas Huth <thuth@redhat.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Matthew Rosato <mjrosato@linux.ibm.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>, 
 Nicholas Piggin <npiggin@gmail.com>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>, 
 Alex Williamson <alex.williamson@redhat.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Steve Sistare <steven.sistare@oracle.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 qemu-s390x@nongnu.org, qemu-ppc@nongnu.org, 
 Hailiang Zhang <zhanghailiang@xfusion.com>, 
 Stefan Berger <stefanb@linux.vnet.ibm.com>, 
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, 
 Arun Menon <armenon@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Stefan Berger <stefanb@linux.vnet.ibm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=12059; i=armenon@redhat.com;
 h=from:subject:message-id; bh=gcFypdY3WofssM7ZEFdIZog0amIm5kGK7RmG+HXfWAY=;
 b=owGbwMvMwCWWVaVqcZPfqI/xtFoSQ8YmdttNW074ZvttFvx8r6tDxHvFo39zIl97lN7N2pmdV
 di28MWPjlIWBjEuBlkxRZaGrwGyTQGFEZG2L6/DzGFlAhnCwMUpABPJ+sTwP1Bn6+0pC/mSbi+6
 lq7InSDH7Pr7umXJLUN25ckaXziLkxgZ2h6fy9eXaejiuWzyxPDG4+XXJwhGbAt/s77wuemKpu9
 1HAA=
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
 - Patches 1-23 focuses on pushing Error object into the functions
   that are important in the call stack where TPM errors are observed.
   We still need to make changes in rest of the functions in savevm.c
   such that they also incorporate the errp object for propagating errors.
 - Patches 12, 13, 20, are minor refactoring changes.
 - Patch 24 removes error variant of vmstate_save_state() function.
 - Patch 25 renames post_save() to cleanup_save()
 - Patch 26 introduces the new variants of the hooks in VMStateDescription
   structure. These hooks should be used in future implementations.
 - Patch 27 focuses on changing the TPM backend such that the errors are
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
Changes in v13:
- Akihiko suggested to use error_report_err() instead of warn_report_err().
  We must not prefix error messages with "warning:" unless the error is a non-critical
  failure that can be logged while the program continues to function.
- Removed error_prepend() with ERRP_GUARD() where it is not required within
  the series.
- Link to v12: https://lore.kernel.org/qemu-devel/20250821-propagate_tpm_error-v12-0-72b803e707dc@redhat.com

Changes in v12:
- Remove error_prepend() calls where no additional information is appended to
  the error string. This also allows us to remove unnecessary ERRP_GUARD().
- Avoid ambiguity by propagating clear messages in errp.
- Add clarity to commit messages throughout the series.
- Link to v11: https://lore.kernel.org/qemu-devel/20250813-propagate_tpm_error-v11-0-b470a374b42d@redhat.com

Changes in v11:
- Remove unnecessary NULL check in postcopy_ram_listen_thread.
- Change error_warn to error_fatal or pass local_err wherever appropriate, because,
  https://lore.kernel.org/qemu-devel/20250808080823.2638861-13-armbru@redhat.com/
  Most changes are in patches 2,24.
- Link to v10: https://lore.kernel.org/qemu-devel/20250808-propagate_tpm_error-v10-0-3e81a1d419b2@redhat.com

Changes in v10:
- Remove the patch to propagate most recent error and the patch of refactoring
  vmstate_save_state_v(): 23,24. They are not required because we intend to keep
  the design as is.
- Added 2 new patches
  - patch 25: Rename post_save() to cleanup_save() and make it void
  - patch 20: Return -1 on memory allocation failure in ram.c
- Pass &error_warn or &error_fatal to capture error or exit on error.
- Link to v9: https://lore.kernel.org/qemu-devel/20250805-propagate_tpm_error-v9-0-123450810db7@redhat.com

Changes in v9:
- Re ordering patches such that error is reported in each one of them.
- format specifier enclosed in '' changed i.e. '%d' changed to %d
- Reporting errors where they were missed before. Setting errp to NULL
  in case of retry.
- Link to v8: https://lore.kernel.org/qemu-devel/20250731-propagate_tpm_error-v8-0-28fd82fdfdb2@redhat.com

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
      migration: push Error **errp into loadvm_process_command()
      migration: push Error **errp into loadvm_handle_cmd_packaged()
      migration: push Error **errp into qemu_loadvm_state()
      migration: push Error **errp into qemu_load_device_state()
      migration: push Error **errp into qemu_loadvm_state_main()
      migration: push Error **errp into qemu_loadvm_section_start_full()
      migration: push Error **errp into qemu_loadvm_section_part_end()
      migration: Update qemu_file_get_return_path() docs and remove dead checks
      migration: make loadvm_postcopy_handle_resume() void
      migration: push Error **errp into ram_postcopy_incoming_init()
      migration: push Error **errp into loadvm_postcopy_handle_advise()
      migration: push Error **errp into loadvm_postcopy_handle_listen()
      migration: push Error **errp into loadvm_postcopy_handle_run()
      migration: push Error **errp into loadvm_postcopy_ram_handle_discard()
      migration: push Error **errp into loadvm_handle_recv_bitmap()
      migration: Return -1 on memory allocation failure in ram.c
      migration: push Error **errp into loadvm_process_enable_colo()
      migration: push Error **errp into loadvm_postcopy_handle_switchover_start()
      migration: Capture error in postcopy_ram_listen_thread()
      migration: Remove error variant of vmstate_save_state() function
      migration: Rename post_save() to cleanup_save() and make it void
      migration: Add error-parameterized function variants in VMSD struct
      backends/tpm: Propagate vTPM error on migration failure

 backends/tpm/tpm_emulator.c   |  40 ++---
 docs/devel/migration/main.rst |  21 ++-
 hw/display/virtio-gpu.c       |   5 +-
 hw/pci/pci.c                  |   5 +-
 hw/ppc/spapr_pci.c            |   5 +-
 hw/s390x/virtio-ccw.c         |   4 +-
 hw/scsi/spapr_vscsi.c         |   6 +-
 hw/vfio/pci.c                 |   9 +-
 hw/virtio/virtio-mmio.c       |   5 +-
 hw/virtio/virtio-pci.c        |   4 +-
 hw/virtio/virtio.c            |  13 +-
 include/migration/colo.h      |   2 +-
 include/migration/vmstate.h   |  20 ++-
 migration/colo.c              |  10 +-
 migration/cpr.c               |   6 +-
 migration/migration.c         |  33 ++---
 migration/postcopy-ram.c      |   9 +-
 migration/postcopy-ram.h      |   2 +-
 migration/qemu-file.c         |   1 -
 migration/ram.c               |  16 +-
 migration/ram.h               |   4 +-
 migration/savevm.c            | 334 ++++++++++++++++++++++++------------------
 migration/savevm.h            |   7 +-
 migration/vmstate-types.c     |  53 ++++---
 migration/vmstate.c           | 115 ++++++++++-----
 target/arm/machine.c          |   6 +-
 tests/unit/test-vmstate.c     |  83 +++++++++--
 ui/vdagent.c                  |   8 +-
 28 files changed, 516 insertions(+), 310 deletions(-)
---
base-commit: 59f504bb43366594e97cf496c9a9ccf59be00b73
change-id: 20250624-propagate_tpm_error-bf4ae6c23d30

Best regards,
-- 
Arun Menon <armenon@redhat.com>


