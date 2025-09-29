Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AB9DCAC5B0
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Sep 2025 08:52:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v39ar-0007dE-Ak; Mon, 29 Sep 2025 04:50:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1v39ad-0007bs-CV
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 04:50:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1v39aJ-0000UP-SE
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 04:50:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759135806;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=7f3xF1BPa+a6dr/GIr7ZwxDVDBN/+BHYbPKoBxb58LA=;
 b=hxqadUE80ccPTjD9l7PBR9kwDAMZtnzIjs2O/1B8aSy1g14yXbGRXiVezAlrLt9GrtZpn7
 t6eJJvyNy2SPiXu0sEyoHs71EiVqHYACP6lrhLhPn9SkoiyMMd5pip+9O0j5abjT28s5tb
 l0hkjxyUKglhFFD3yq71MlWyWdKgLj0=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-582-iOHSRh-UOEK8Ax9AMZ1DEA-1; Mon, 29 Sep 2025 04:50:04 -0400
X-MC-Unique: iOHSRh-UOEK8Ax9AMZ1DEA-1
X-Mimecast-MFC-AGG-ID: iOHSRh-UOEK8Ax9AMZ1DEA_1759135804
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-77b73bddbdcso3822049b3a.1
 for <qemu-devel@nongnu.org>; Mon, 29 Sep 2025 01:50:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759135803; x=1759740603;
 h=in-reply-to:content-disposition:mime-version:references:reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7f3xF1BPa+a6dr/GIr7ZwxDVDBN/+BHYbPKoBxb58LA=;
 b=HB31gCsZv/mFy9tU6WJvL/zp/zxgvWnFEwz1ADmXu4NAAVsWTRL2LZitUQhcgOWxpP
 qxaCsQiJcl0VF3MlSKLpNvIrOB4azVQc6PhHhpSobdxiXUEvvtFWjfYaz3fmRhfHsB62
 RPIgdSt83qnBw/nzhS2Qq60bpUc7pJMgZMItN1X8RuRgWiSmP38h/Cfo8bOrfccqFZKV
 HxqWtE3W8SzqDHuNZzafr5wzi65+ZoCdULBLsZcZaBPErlx1bjDiiXvfogirMAQd5oLe
 zNKX8Oo2TRXcq9a8PyMK6xk+CBPcWtBN3xdnlwwHb0/oWqJc+ZzXbjfoZUI1S/MyQAAw
 5iMg==
X-Gm-Message-State: AOJu0Yxgmkc7yB/4MtnyitYzG4N1pPzDAmpPoeNIg5YoizbRZkso2Y8S
 bG7gpHC/8U5Z8+fbxxUuRrUMZ8ysDOV+y2jWokoQU+xoEw/fw+IRcrmUYSHjATiVB9YhPHjeKRB
 DCAzzYR6twCGYwq+oiGnaA2AVJ62diemhDMEn0GUQXF/Zk82zSGZVe1HrdYqzGjRbfec/3YvhGI
 aqcYTxhr1edp1ku7xC22es1y47XA06wslUBeJhK5w=
X-Gm-Gg: ASbGncs8lh3Uapbq79el/gAgKf7M2sN38nJXkv4famxNDt5s9zeqL6nvKSAoAzxWkEy
 MI/LpD3OpT9x3fiWyWybKtvAjtIUpjW3GG1KnDuQNyf7RkCH0n+cg1I4C8lTNY5MW44IgMbg6Ev
 Qs4tkkdLSzV9mIDsKrf617qnuLMHhvbeo5s8HR2xlUOgh/zYLFL2DX7seycsiRd08qXHVMVwekf
 NUYcao9hk7Ln3+NpQQsaRm2NmutFFaL1IAtprngoSWjfnoFHlYqzYSnTOpH+aqW2W9HKFS8Ut8x
 s7RvLlRBJeh30oxG6cKQY/qZogUGQyrPlP6cutkOiUfySsX7Kkx9
X-Received: by 2002:a05:6a00:8b93:b0:77f:df:5c3b with SMTP id
 d2e1a72fcca58-7812576ee6bmr5792878b3a.16.1759135803367; 
 Mon, 29 Sep 2025 01:50:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFOnetDXqaRlSLKk8Yn5w+dOX0EY4/jnRnOADTkPTdaNwQxKu2rsKPEHseNPDNSzDYbU2pJ7Q==
X-Received: by 2002:a05:6a00:8b93:b0:77f:df:5c3b with SMTP id
 d2e1a72fcca58-7812576ee6bmr5792824b3a.16.1759135802622; 
 Mon, 29 Sep 2025 01:50:02 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.36.104.48])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7810238e6fasm10415060b3a.1.2025.09.29.01.49.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Sep 2025 01:50:02 -0700 (PDT)
Date: Mon, 29 Sep 2025 14:19:48 +0530
From: Arun Menon <armenon@redhat.com>
To: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
Cc: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
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
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 qemu-s390x@nongnu.org, qemu-ppc@nongnu.org,
 Hailiang Zhang <zhanghailiang@xfusion.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Subject: Re: [PATCH v14 00/27] migration: propagate vTPM errors using Error
 objects
Message-ID: <aNpILAhr8LaMFbcL@armenon-kvm.bengluru.csb>
References: <20250918-propagate_tpm_error-v14-0-36f11a6fb9d3@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250918-propagate_tpm_error-v14-0-36f11a6fb9d3@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armenon@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.539,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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
Reply-To: armenon@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, Sep 18, 2025 at 08:53:17PM +0530, Arun Menon wrote:
> Hello,
> 
> Currently, when a migration of a VM with an encrypted vTPM
> fails on the destination host (e.g., due to a mismatch in secret values),
> the error message displayed on the source host is generic and unhelpful.
> 
> For example, a typical error looks like this:
> "operation failed: job 'migration out' failed: Sibling indicated error 1.
> operation failed: job 'migration in' failed: load of migration failed:
> Input/output error"
> 
> This message does not provide any specific indication of a vTPM failure.
> Such generic errors are logged using error_report(), which prints to
> the console/monitor but does not make the detailed error accessible via
> the QMP query-migrate command.
> 
> This series addresses the issue, by ensuring that specific TPM error
> messages are propagated via the QEMU Error object.
> To make this possible,
> - A set of functions in the call stack is changed
>   to incorporate an Error object as an additional parameter.
> - Also, the TPM backend makes use of a new hook called post_load_errp()
>   that explicitly passes an Error object.
> 
> It is organized as follows,
>  - Patches 1-23 focuses on pushing Error object into the functions
>    that are important in the call stack where TPM errors are observed.
>    We still need to make changes in rest of the functions in savevm.c
>    such that they also incorporate the errp object for propagating errors.
>  - Patches 12, 13, 20, are minor refactoring changes.
>  - Patch 24 removes error variant of vmstate_save_state() function.
>  - Patch 25 renames post_save() to cleanup_save()
>  - Patch 26 introduces the new variants of the hooks in VMStateDescription
>    structure. These hooks should be used in future implementations.
>  - Patch 27 focuses on changing the TPM backend such that the errors are
>    set in the Error object.
> 
> While this series focuses specifically on TPM error reporting during
> live migration, it lays the groundwork for broader improvements.
> A lot of methods in savevm.c that previously returned an integer now capture
> errors in the Error object, enabling other modules to adopt the
> post_load_errp hook in the future.
> 
> One such change previously attempted:
> https://lists.gnu.org/archive/html/qemu-devel/2021-02/msg01727.html
> 
> Resolves: https://issues.redhat.com/browse/RHEL-82826
> 
> Signed-off-by: Arun Menon <armenon@redhat.com>
> ---
> Changes in v14:
> - Addressed two regressions introduced in
>   [PATCH 07/27] migration: push Error **errp into qemu_loadvm_state()
>   thanks to Akihiko's suggestions.
>   a) duplicate error reporting: The previous patch introduced a duplicate
>      error message when 'exit_on_error' is false and the migration failed.
>      This is not trivial to fix because there is one such scenario in postcopy
>      migration where querying the error message using the QMP client or libvirt
>      is not possible as the destination abruptly exits.
>      However, the logic to print error is put into a separate specific path and
>      a comment is added in this path, which can be improved in future to catch the
>      specific case.
>   b) Ignoring the error in the migration state and reporting local_err:
>      Solved this by restoring the patch 07.
> - Link to v13: https://lore.kernel.org/qemu-devel/20250830-propagate_tpm_error-v13-0-a4e777b7eb2c@redhat.com
> 
> Changes in v13:
> - Akihiko suggested to use error_report_err() instead of warn_report_err().
>   We must not prefix error messages with "warning:" unless the error is a non-critical
>   failure that can be logged while the program continues to function.
> - Removed error_prepend() with ERRP_GUARD() where it is not required within
>   the series.
> - Link to v12: https://lore.kernel.org/qemu-devel/20250821-propagate_tpm_error-v12-0-72b803e707dc@redhat.com
> 
> Changes in v12:
> - Remove error_prepend() calls where no additional information is appended to
>   the error string. This also allows us to remove unnecessary ERRP_GUARD().
> - Avoid ambiguity by propagating clear messages in errp.
> - Add clarity to commit messages throughout the series.
> - Link to v11: https://lore.kernel.org/qemu-devel/20250813-propagate_tpm_error-v11-0-b470a374b42d@redhat.com
> 
> Changes in v11:
> - Remove unnecessary NULL check in postcopy_ram_listen_thread.
> - Change error_warn to error_fatal or pass local_err wherever appropriate, because,
>   https://lore.kernel.org/qemu-devel/20250808080823.2638861-13-armbru@redhat.com/
>   Most changes are in patches 2,24.
> - Link to v10: https://lore.kernel.org/qemu-devel/20250808-propagate_tpm_error-v10-0-3e81a1d419b2@redhat.com
> 
> Changes in v10:
> - Remove the patch to propagate most recent error and the patch of refactoring
>   vmstate_save_state_v(): 23,24. They are not required because we intend to keep
>   the design as is.
> - Added 2 new patches
>   - patch 25: Rename post_save() to cleanup_save() and make it void
>   - patch 20: Return -1 on memory allocation failure in ram.c
> - Pass &error_warn or &error_fatal to capture error or exit on error.
> - Link to v9: https://lore.kernel.org/qemu-devel/20250805-propagate_tpm_error-v9-0-123450810db7@redhat.com
> 
> Changes in v9:
> - Re ordering patches such that error is reported in each one of them.
> - format specifier enclosed in '' changed i.e. '%d' changed to %d
> - Reporting errors where they were missed before. Setting errp to NULL
>   in case of retry.
> - Link to v8: https://lore.kernel.org/qemu-devel/20250731-propagate_tpm_error-v8-0-28fd82fdfdb2@redhat.com
> 
> Changes in v8:
> - 3 new patches added:
>   - patch 23:
> 	- Changes the error propagation by returning the most recent error
> 	  to the caller when both save device state and post_save fails.
>   - patch 24:
> 	- Refactors the vmstate_save_state_v() function by adding wrapper
> 	  functions to separate concerns.
>   - patch 25:
> 	- Removes the error variant of the vmstate_save_state()
> 	  function introduced in commit 969298f9d7.
> - Use ERRP_GUARD() where there is an errp dereference or an error_prepend call.
> - Pass &error_warn in place of NULL, in vmstate_load_state() calls so
>   that the caller knows about the error.
> - Remove unnecessary null check before setting errp. Dereferencing it is not required.
> - Documentation for the new variants of post/pre save/load hooks added.
> - Some patches, although they received a 'Reviewed-by' tag, have undergone few minor changes,
> 	Patch 1 : removed extra space
> 	Patch 2 : Commit message changed, refactoring the function to
> 		always set errp and return.
> 	Patch 8 : Commit message changed.
> 	Patch 9 : use error_setg_errno instead of error_setg.
> 	Patch 27 : use error_setg_errno instead of error_setg.
> - Link to v7: https://lore.kernel.org/qemu-devel/20250725-propagate_tpm_error-v7-0-d52704443975@redhat.com
> 
> Changes in v7:
> - Fix propagating errors in post_save_errp. The latest error encountered is
>   propagated.
> - user-strings in error_prepend() calls now end with a ': ' so that the print is pretty.
> - Change the order of one of the patches.
> - Link to v6: https://lore.kernel.org/qemu-devel/20250721-propagate_tpm_error-v6-0-fef740e15e17@redhat.com
> 
> Changes in v6:
> - Incorporated review comments from Daniel and Akihiko, related to few
>   semantic errors and improve error logging.
> - Add one more patch that removes NULL checks after calling
>   qemu_file_get_return_path() because it does not fail.
> - Link to v5: https://lore.kernel.org/qemu-devel/20250717-propagate_tpm_error-v5-0-1f406f88ee65@redhat.com
> 
> Changes in v5:
> - Solve a bug that set errp even though it was not NULL, pointed out by Fabiano in v4.
> - Link to v4: https://lore.kernel.org/qemu-devel/20250716-propagate_tpm_error-v4-0-7141902077c0@redhat.com
> 
> Changes in v4:
> - Split the patches into smaller ones based on functions. Pass NULL in the
>   caller until errp is made available. Every function that has an
>   Error **errp object passed to it, ensures that it sets the errp object
>   in case of failure.
> - A few more functions within loadvm_process_command() now handle errors using
>   the errp object. I've converted these for consistency, taking Daniel's
>   patches (link above) as a reference.
> - Along with the post_load_errp() hook, other duplicate hooks are also introduced.
>   This will enable us to migrate to the newer versions eventually.
> - Fix some semantic errors, like using error_propagate_prepend() in places where
>   we need to preserve existing behaviour of accumulating the error in local_err
>   and then propagating it to errp. This can be refactored in a later commit.
> - Add more information in commit messages explaining the changes.
> - Link to v3: https://lore.kernel.org/qemu-devel/20250702-propagate_tpm_error-v3-0-986d94540528@redhat.com
> 
> Changes in v3:
> - Split the 2nd patch into 2. Introducing post_load_with_error() hook
>   has been separated from using it in the backends TPM module. This is
>   so that it can be acknowledged.
> - Link to v2: https://lore.kernel.org/qemu-devel/20250627-propagate_tpm_error-v2-0-85990c89da29@redhat.com
> 
> Changes in v2:
> - Combine the first two changes into one, focusing on passing the
>   Error object (errp) consistently through functions involved in
>   loading the VM's state. Other functions are not yet changed.
> - As suggested in the review comment, add null checks for errp
>   before adding error messages, preventing crashes.
>   We also now correctly set errors when post-copy migration fails.
> - In process_incoming_migration_co(), switch to error_prepend
>   instead of error_setg. This means we now null-check local_err in
>   the "fail" section before using it, preventing dereferencing issues.
> - Link to v1: https://lore.kernel.org/qemu-devel/20250624-propagate_tpm_error-v1-0-2171487a593d@redhat.com
> 
> ---
> Arun Menon (27):
>       migration: push Error **errp into vmstate_subsection_load()
>       migration: push Error **errp into vmstate_load_state()
>       migration: push Error **errp into qemu_loadvm_state_header()
>       migration: push Error **errp into vmstate_load()
>       migration: push Error **errp into loadvm_process_command()
>       migration: push Error **errp into loadvm_handle_cmd_packaged()
>       migration: push Error **errp into qemu_loadvm_state()
>       migration: push Error **errp into qemu_load_device_state()
>       migration: push Error **errp into qemu_loadvm_state_main()
>       migration: push Error **errp into qemu_loadvm_section_start_full()
>       migration: push Error **errp into qemu_loadvm_section_part_end()
>       migration: Update qemu_file_get_return_path() docs and remove dead checks
>       migration: make loadvm_postcopy_handle_resume() void
>       migration: push Error **errp into ram_postcopy_incoming_init()
>       migration: push Error **errp into loadvm_postcopy_handle_advise()
>       migration: push Error **errp into loadvm_postcopy_handle_listen()
>       migration: push Error **errp into loadvm_postcopy_handle_run()
>       migration: push Error **errp into loadvm_postcopy_ram_handle_discard()
>       migration: push Error **errp into loadvm_handle_recv_bitmap()
>       migration: Return -1 on memory allocation failure in ram.c
>       migration: push Error **errp into loadvm_process_enable_colo()
>       migration: push Error **errp into loadvm_postcopy_handle_switchover_start()
>       migration: Capture error in postcopy_ram_listen_thread()
>       migration: Remove error variant of vmstate_save_state() function
>       migration: Rename post_save() to cleanup_save() and make it void
>       migration: Add error-parameterized function variants in VMSD struct
>       backends/tpm: Propagate vTPM error on migration failure
> 
>  backends/tpm/tpm_emulator.c   |  40 ++---
>  docs/devel/migration/main.rst |  21 ++-
>  hw/display/virtio-gpu.c       |   5 +-
>  hw/pci/pci.c                  |   5 +-
>  hw/ppc/spapr_pci.c            |   5 +-
>  hw/s390x/virtio-ccw.c         |   4 +-
>  hw/scsi/spapr_vscsi.c         |   6 +-
>  hw/vfio/pci.c                 |   9 +-
>  hw/virtio/virtio-mmio.c       |   5 +-
>  hw/virtio/virtio-pci.c        |   4 +-
>  hw/virtio/virtio.c            |  13 +-
>  include/migration/colo.h      |   2 +-
>  include/migration/vmstate.h   |  20 ++-
>  migration/colo.c              |  10 +-
>  migration/cpr.c               |   6 +-
>  migration/migration.c         |  38 ++---
>  migration/postcopy-ram.c      |   9 +-
>  migration/postcopy-ram.h      |   2 +-
>  migration/qemu-file.c         |   1 -
>  migration/ram.c               |  16 +-
>  migration/ram.h               |   4 +-
>  migration/savevm.c            | 334 ++++++++++++++++++++++++------------------
>  migration/savevm.h            |   7 +-
>  migration/vmstate-types.c     |  53 ++++---
>  migration/vmstate.c           | 115 ++++++++++-----
>  target/arm/machine.c          |   6 +-
>  tests/unit/test-vmstate.c     |  83 +++++++++--
>  ui/vdagent.c                  |   8 +-
>  28 files changed, 523 insertions(+), 308 deletions(-)
> ---
> base-commit: f0007b7f03e2d7fc33e71c3a582f2364c51a226b
> change-id: 20250624-propagate_tpm_error-bf4ae6c23d30
> 
> Best regards,
> -- 
> Arun Menon <armenon@redhat.com>
> 

Hi,
Gentle ping for the series.
Is there something more to be done to improve this before queueing it?
TIA.


Regards,
Arun Menon


