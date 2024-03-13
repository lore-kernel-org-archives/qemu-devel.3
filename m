Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A0C7C54791
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Mar 2024 15:12:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkQH1-000156-Rg; Wed, 13 Mar 2024 11:12:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rkQGy-0000kL-HR
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 11:12:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rkQGt-0006ry-SB
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 11:12:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710342717;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bKhw1pZct8Sh5lSMhj56vimtUG0mx1MK9XxubYRdB94=;
 b=IjRe4laBVdn4PaOqE24IfnZJ7HqskqsIDebqWlOizGvU/Rb2mcV/uTJRq0I4Avqf3RliNz
 hUNJKpd0jUhp07w0Sw1uyQcqrd6kBDqtaN8C3rqMzGB5AddNRRQypaQPXHimmzF4BygfJX
 MK414ke1vLrinpwFTKnNzNb232ZD4Ig=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-436-QwqlfnShPxCPGcGZ1p3m6Q-1; Wed, 13 Mar 2024 11:11:45 -0400
X-MC-Unique: QwqlfnShPxCPGcGZ1p3m6Q-1
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-690becce69eso17858766d6.1
 for <qemu-devel@nongnu.org>; Wed, 13 Mar 2024 08:11:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710342705; x=1710947505;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bKhw1pZct8Sh5lSMhj56vimtUG0mx1MK9XxubYRdB94=;
 b=Chji0RrdPqwIV4yTrRT3y8sOTq+3MUwMOQ9GdGd4Tj/D4jwOpEIMKEITJ4ZHRyuwp2
 J9BiRyvaKgtCE9xpZ1Go5mWnlnpTdgk4/NOgauRe/iXPbr1UZixr/kivF92F04CwB5AS
 lc8CjZ0H05nwS06V2uspFJkeIGaw3vnRXNOqn5R8RDuDPmlIFa+DmZQv7jxYf0+w7hlj
 5r5WzToBo+CIVPm2aTffM8o9P6r/HxViOvLwgxDAK9o74t9ECOYVr1zIrZ04v/qDONAj
 L9Djsrg/F2ZQbSPuT6ki6J3uMjvhP2Am4mzjGLabW4Oq2Q80e1ocu0L29Sk7HL55Zmy0
 vnGg==
X-Gm-Message-State: AOJu0Yw8EhLU43OHvSC2gqKfN50SezveJJCtHZElY5wNhrCgv33MFDOa
 kJ7sDgC0GUmAaKNhpMLpiQYun/itbbapJ+ZPxw0mL/R6D9Tr7UZYs2O4Wak0+S5fmVoIb7mQLf/
 GKsMhRKXkOd4aiQyr0tdtLySJmuFgC2VxGiYObXMDDc+NnYfR9YUJ
X-Received: by 2002:a0c:f508:0:b0:690:b02c:2a5f with SMTP id
 j8-20020a0cf508000000b00690b02c2a5fmr12479713qvm.4.1710342705099; 
 Wed, 13 Mar 2024 08:11:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHXUidInEO1Uqa0k7HQoo+nuU+NGIr/UJtS05Zbskr/OY1XT8pL6FhGAJ/UluWoDnd8kwGHqw==
X-Received: by 2002:a0c:f508:0:b0:690:b02c:2a5f with SMTP id
 j8-20020a0cf508000000b00690b02c2a5fmr12479652qvm.4.1710342703963; 
 Wed, 13 Mar 2024 08:11:43 -0700 (PDT)
Received: from x1n (cpe688f2e2cb7c3-cm688f2e2cb7c0.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 r6-20020a0cf606000000b0069046d929a3sm4756337qvm.145.2024.03.13.08.11.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Mar 2024 08:11:43 -0700 (PDT)
Date: Wed, 13 Mar 2024 11:11:41 -0400
From: Peter Xu <peterx@redhat.com>
To: Steve Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Markus Armbruster <armbru@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>
Subject: Re: [PATCH] migration: cpr-reboot documentation
Message-ID: <ZfHCLeuer6DXTRWe@x1n>
References: <1710338119-330923-1-git-send-email-steven.sistare@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1710338119-330923-1-git-send-email-steven.sistare@oracle.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.971,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Mar 13, 2024 at 06:55:19AM -0700, Steve Sistare wrote:
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>

Thanks a lot.  This looks much better..  queued it for 9.0-rc0.

One note below.

> ---
>  docs/devel/migration/CPR.rst      | 147 ++++++++++++++++++++++++++++++++++++++
>  docs/devel/migration/features.rst |   1 +
>  2 files changed, 148 insertions(+)
>  create mode 100644 docs/devel/migration/CPR.rst
> 
> diff --git a/docs/devel/migration/CPR.rst b/docs/devel/migration/CPR.rst
> new file mode 100644
> index 0000000..63c3647
> --- /dev/null
> +++ b/docs/devel/migration/CPR.rst
> @@ -0,0 +1,147 @@
> +CheckPoint and Restart (CPR)
> +============================
> +
> +CPR is the umbrella name for a set of migration modes in which the
> +VM is migrated to a new QEMU instance on the same host.  It is
> +intended for use when the goal is to update host software components
> +that run the VM, such as QEMU or even the host kernel.  At this time,
> +cpr-reboot is the only available mode.
> +
> +Because QEMU is restarted on the same host, with access to the same
> +local devices, CPR is allowed in certain cases where normal migration
> +would be blocked.  However, the user must not modify the contents of
> +guest block devices between quitting old QEMU and starting new QEMU.
> +
> +CPR unconditionally stops VM execution before memory is saved, and
> +thus does not depend on any form of dirty page tracking.

Note that this is not completely true in reality even if conceptally true..

static void ram_init_bitmaps(RAMState *rs)
{
    qemu_mutex_lock_ramlist();

    WITH_RCU_READ_LOCK_GUARD() {
        ram_list_init_bitmaps();
        /* We don't use dirty log with background snapshots */
        if (!migrate_background_snapshot()) {
            memory_global_dirty_log_start(GLOBAL_DIRTY_MIGRATION);
            migration_bitmap_sync_precopy(rs, false);
        }
    }
    ...
}

If you want we can make it true in reality with some further changes.  I
don't think this matters a huge deal in reality as of now, but note that
Cedric is planning to add support to allow ram setup() to even fail, e.g.,
when there's no enough VFIO dirty tracking resources on the device.

It means it might still be ideal this can be fixed some day so that cpr
will bypass the tracking operations in code when attached with a VFIO
device that is capable of precopy live migration (but in this case
HW/driver support will be ignored for a cpr upgrade), because there's a
chance memory_global_dirty_log_start() will fail then even if the tracking
unit won't be used.

> +
> +cpr-reboot mode
> +---------------
> +
> +In this mode, QEMU stops the VM, and writes VM state to the migration
> +URI, which will typically be a file.  After quitting QEMU, the user
> +resumes by running QEMU with the ``-incoming`` option.  Because the
> +old and new QEMU instances are not active concurrently, the URI cannot
> +be a type that streams data from one instance to the other.
> +
> +Guest RAM can be saved in place if backed by shared memory, or can be
> +copied to a file.  The former is more efficient and is therefore
> +preferred.
> +
> +After state and memory are saved, the user may update userland host
> +software before restarting QEMU and resuming the VM.  Further, if
> +the RAM is backed by persistent shared memory, such as a DAX device,
> +then the user may reboot to a new host kernel before restarting QEMU.
> +
> +This mode supports VFIO devices provided the user first puts the
> +guest in the suspended runstate, such as by issuing the
> +``guest-suspend-ram`` command to the QEMU guest agent.  The agent
> +must be pre-installed in the guest, and the guest must support
> +suspend to RAM.  Beware that suspension can take a few seconds, so
> +the user should poll to see the suspended state before proceeding
> +with the CPR operation.
> +
> +Usage
> +^^^^^
> +
> +It is recommended that guest RAM be backed with some type of shared
> +memory, such as ``memory-backend-file,share=on``, and that the
> +``x-ignore-shared`` capability be set.  This combination allows memory
> +to be saved in place.  Otherwise, after QEMU stops the VM, all guest
> +RAM is copied to the migration URI.
> +
> +Outgoing:
> +  * Set the migration mode parameter to ``cpr-reboot``.
> +  * Set the ``x-ignore-shared`` capability if desired.
> +  * Issue the ``migrate`` command.  It is recommended the the URI be a
> +    ``file`` type, but one can use other types such as ``exec``,
> +    provided the command captures all the data from the outgoing side,
> +    and provides all the data to the incoming side.
> +  * Quit when QEMU reaches the postmigrate state.
> +
> +Incoming:
> +  * Start QEMU with the ``-incoming defer`` option.
> +  * Set the migration mode parameter to ``cpr-reboot``.
> +  * Set the ``x-ignore-shared`` capability if desired.
> +  * Issue the ``migrate-incoming`` command.
> +  * If the VM was running when the outgoing ``migrate`` command was
> +    issued, then QEMU automatically resumes VM execution.
> +
> +Example 1
> +^^^^^^^^^
> +::
> +
> +  # qemu-kvm -monitor stdio
> +  -object memory-backend-file,id=ram0,size=4G,mem-path=/dev/dax0.0,align=2M,share=on -m 4G
> +  ...
> +
> +  (qemu) info status
> +  VM status: running
> +  (qemu) migrate_set_parameter mode cpr-reboot
> +  (qemu) migrate_set_capability x-ignore-shared on
> +  (qemu) migrate -d file:vm.state
> +  (qemu) info status
> +  VM status: paused (postmigrate)
> +  (qemu) quit
> +
> +  ### optionally update kernel and reboot
> +  # systemctl kexec
> +  kexec_core: Starting new kernel
> +  ...
> +
> +  # qemu-kvm ... -incoming defer
> +  (qemu) info status
> +  VM status: paused (inmigrate)
> +  (qemu) migrate_set_parameter mode cpr-reboot
> +  (qemu) migrate_set_capability x-ignore-shared on
> +  (qemu) migrate_incoming file:vm.state
> +  (qemu) info status
> +  VM status: running
> +
> +Example 2: VFIO
> +^^^^^^^^^^^^^^^
> +::
> +
> +  # qemu-kvm -monitor stdio
> +  -object memory-backend-file,id=ram0,size=4G,mem-path=/dev/dax0.0,align=2M,share=on -m 4G
> +  -device vfio-pci, ...
> +  -chardev socket,id=qga0,path=qga.sock,server=on,wait=off
> +  -device virtserialport,chardev=qga0,name=org.qemu.guest_agent.0
> +  ...
> +
> +  (qemu) info status
> +  VM status: running
> +
> +  # echo '{"execute":"guest-suspend-ram"}' | ncat --send-only -U qga.sock
> +
> +  (qemu) info status
> +  VM status: paused (suspended)
> +  (qemu) migrate_set_parameter mode cpr-reboot
> +  (qemu) migrate_set_capability x-ignore-shared on
> +  (qemu) migrate -d file:vm.state
> +  (qemu) info status
> +  VM status: paused (postmigrate)
> +  (qemu) quit
> +
> +  ### optionally update kernel and reboot
> +  # systemctl kexec
> +  kexec_core: Starting new kernel
> +  ...
> +
> +  # qemu-kvm ... -incoming defer
> +  (qemu) info status
> +  VM status: paused (inmigrate)
> +  (qemu) migrate_set_parameter mode cpr-reboot
> +  (qemu) migrate_set_capability x-ignore-shared on
> +  (qemu) migrate_incoming file:vm.state
> +  (qemu) info status
> +  VM status: paused (suspended)
> +  (qemu) system_wakeup
> +  (qemu) info status
> +  VM status: running
> +
> +Caveats
> +^^^^^^^
> +
> +cpr-reboot mode may not be used with postcopy, background-snapshot,
> +or COLO.
> diff --git a/docs/devel/migration/features.rst b/docs/devel/migration/features.rst
> index 9d1abd2..d5ca7b8 100644
> --- a/docs/devel/migration/features.rst
> +++ b/docs/devel/migration/features.rst
> @@ -11,3 +11,4 @@ Migration has plenty of features to support different use cases.
>     vfio
>     virtio
>     mapped-ram
> +   CPR
> -- 
> 1.8.3.1
> 

-- 
Peter Xu


