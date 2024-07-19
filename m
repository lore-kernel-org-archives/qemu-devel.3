Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F06B2C3DA59
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2024 15:04:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUp97-0008EG-V4; Fri, 19 Jul 2024 11:03:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sUp96-0008Bb-Sd
 for qemu-devel@nongnu.org; Fri, 19 Jul 2024 11:03:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sUp93-0002gC-Fp
 for qemu-devel@nongnu.org; Fri, 19 Jul 2024 11:03:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721401417;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mpDZ98Hp3N7v83Rqg3uNWUZ5Xb13/ZkZk0nie4mxpII=;
 b=E0VTSw92v7Va/L/ofM0mi7sChA60QczR6EBzMG/JzxodO1Ei/i0st8clhU9Ul/iWXFdDpM
 pRCg0uRFKBpEjapMNnl1uXhgVfUyEndHdZVthIMPIgPony4kAbGPMi083wjyhwTvCqQRFI
 RL7RDq/Qn3wTBfh95iFsp1JFeCFatkQ=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-572-b_nNQcg0MgOH3Vj2FORu5A-1; Fri, 19 Jul 2024 11:03:34 -0400
X-MC-Unique: b_nNQcg0MgOH3Vj2FORu5A-1
Received: by mail-io1-f69.google.com with SMTP id
 ca18e2360f4ac-814fead45f2so55176239f.0
 for <qemu-devel@nongnu.org>; Fri, 19 Jul 2024 08:03:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721401414; x=1722006214;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mpDZ98Hp3N7v83Rqg3uNWUZ5Xb13/ZkZk0nie4mxpII=;
 b=SHpBAkodRvlhe/uolU7mZSk1HRdHr24Bi2ho5tFLMwTde9Rk/GLblZimKMsbWERPM/
 nHqifMnl9oqFoK71FiCKKUZl33yyJq+6RfFVTm92dEFaKKL2vubS5SXmTV6jjhNqqpjl
 wgAwzWZ6Zi9gpUZVduJicI7Fa7DpKn9m8/YIfBkYXY+DiWRw6hnDBWULN+iB99wPhL10
 P9820FGZOVVUJVPTfwBmOd0mHBybmr5Za+EIsFF/SBFmEEZaQToRUON6ES/eQEVYKY6z
 e+bjeVV8j3np8LfgTtMhN5aLOhuUFIWCBu+AAr64NqOXUzcrPQHozZzhbel/kOnJVyrx
 R97w==
X-Gm-Message-State: AOJu0YxZ+igzujbjnFNIQQBWCIgGLmOOdt3O9IWKYfTiNk4PSJYX7I4G
 z5QAMDuynt4Aw4TxxaR9de+Ni6N0gXYQ0ciwHRdZJCJkyVyd/szf0LPFeCCWWSAo7EYGMWo9nOt
 U0GyZ8jv5frC/+jAF/kzBuvCGKQBLNubovGwGekbukVNjUKJFhRC+
X-Received: by 2002:a05:6e02:154b:b0:383:297a:bdfb with SMTP id
 e9e14a558f8ab-398e5d23d65mr206045ab.2.1721401413715; 
 Fri, 19 Jul 2024 08:03:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGmh4xaoA1F/L0XwSemwfkQhVOLYC+LK5hxlflfQPmQRaYvlEiy0kGWXC98l2QJc4gMn37uKw==
X-Received: by 2002:a05:6e02:154b:b0:383:297a:bdfb with SMTP id
 e9e14a558f8ab-398e5d23d65mr205555ab.2.1721401413001; 
 Fri, 19 Jul 2024 08:03:33 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-397f7a283c8sm4791495ab.67.2024.07.19.08.03.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jul 2024 08:03:32 -0700 (PDT)
Date: Fri, 19 Jul 2024 11:03:31 -0400
From: Peter Xu <peterx@redhat.com>
To: Steve Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH V2 02/11] migration: cpr-state
Message-ID: <ZpqAQ6L6XtIyLREq@x1n>
References: <1719776434-435013-1-git-send-email-steven.sistare@oracle.com>
 <1719776434-435013-3-git-send-email-steven.sistare@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1719776434-435013-3-git-send-email-steven.sistare@oracle.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Sun, Jun 30, 2024 at 12:40:25PM -0700, Steve Sistare wrote:
> CPR must save state that is needed after QEMU is restarted, when devices
> are realized.  Thus the extra state cannot be saved in the migration stream,
> as objects must already exist before that stream can be loaded.  Instead,
> define auxilliary state structures and vmstate descriptions, not associated
> with any registered object, and serialize the aux state to a cpr-specific
> stream in cpr_state_save.  Deserialize in cpr_state_load after QEMU
> restarts, before devices are realized.
> 
> Provide accessors for clients to register file descriptors for saving.
> The mechanism for passing the fd's to the new process will be specific
> to each migration mode, and added in subsequent patches.
> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> ---
>  include/migration/cpr.h |  21 ++++++
>  migration/cpr.c         | 188 ++++++++++++++++++++++++++++++++++++++++++++++++
>  migration/meson.build   |   1 +
>  migration/migration.c   |   6 ++
>  migration/trace-events  |   5 ++
>  system/vl.c             |   3 +
>  6 files changed, 224 insertions(+)
>  create mode 100644 include/migration/cpr.h
>  create mode 100644 migration/cpr.c
> 
> diff --git a/include/migration/cpr.h b/include/migration/cpr.h
> new file mode 100644
> index 0000000..8e7e705
> --- /dev/null
> +++ b/include/migration/cpr.h
> @@ -0,0 +1,21 @@
> +/*
> + * Copyright (c) 2021, 2024 Oracle and/or its affiliates.
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> + * See the COPYING file in the top-level directory.
> + */
> +
> +#ifndef MIGRATION_CPR_H
> +#define MIGRATION_CPR_H
> +
> +typedef int (*cpr_walk_fd_cb)(int fd);
> +void cpr_save_fd(const char *name, int id, int fd);
> +void cpr_delete_fd(const char *name, int id);
> +int cpr_find_fd(const char *name, int id);
> +int cpr_walk_fd(cpr_walk_fd_cb cb);
> +void cpr_resave_fd(const char *name, int id, int fd);
> +
> +int cpr_state_save(Error **errp);
> +int cpr_state_load(Error **errp);
> +
> +#endif
> diff --git a/migration/cpr.c b/migration/cpr.c
> new file mode 100644
> index 0000000..313e74e
> --- /dev/null
> +++ b/migration/cpr.c
> @@ -0,0 +1,188 @@
> +/*
> + * Copyright (c) 2021-2024 Oracle and/or its affiliates.
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> + * See the COPYING file in the top-level directory.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qapi/error.h"
> +#include "migration/cpr.h"
> +#include "migration/misc.h"
> +#include "migration/qemu-file.h"
> +#include "migration/savevm.h"
> +#include "migration/vmstate.h"
> +#include "sysemu/runstate.h"
> +#include "trace.h"
> +
> +/*************************************************************************/
> +/* cpr state container for all information to be saved. */
> +
> +typedef QLIST_HEAD(CprFdList, CprFd) CprFdList;
> +
> +typedef struct CprState {
> +    CprFdList fds;
> +} CprState;
> +
> +static CprState cpr_state;
> +
> +/****************************************************************************/
> +
> +typedef struct CprFd {
> +    char *name;
> +    unsigned int namelen;
> +    int id;
> +    int fd;

[1]

> +    QLIST_ENTRY(CprFd) next;
> +} CprFd;
> +
> +static const VMStateDescription vmstate_cpr_fd = {
> +    .name = "cpr fd",
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .fields = (VMStateField[]) {
> +        VMSTATE_UINT32(namelen, CprFd),
> +        VMSTATE_VBUFFER_ALLOC_UINT32(name, CprFd, 0, NULL, namelen),
> +        VMSTATE_INT32(id, CprFd),
> +        VMSTATE_INT32(fd, CprFd),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
> +void cpr_save_fd(const char *name, int id, int fd)
> +{
> +    CprFd *elem = g_new0(CprFd, 1);
> +
> +    trace_cpr_save_fd(name, id, fd);
> +    elem->name = g_strdup(name);
> +    elem->namelen = strlen(name) + 1;
> +    elem->id = id;
> +    elem->fd = fd;
> +    QLIST_INSERT_HEAD(&cpr_state.fds, elem, next);
> +}
> +
> +static CprFd *find_fd(CprFdList *head, const char *name, int id)
> +{
> +    CprFd *elem;
> +
> +    QLIST_FOREACH(elem, head, next) {
> +        if (!strcmp(elem->name, name) && elem->id == id) {
> +            return elem;
> +        }
> +    }
> +    return NULL;
> +}
> +
> +void cpr_delete_fd(const char *name, int id)
> +{
> +    CprFd *elem = find_fd(&cpr_state.fds, name, id);
> +
> +    if (elem) {
> +        QLIST_REMOVE(elem, next);
> +        g_free(elem->name);
> +        g_free(elem);
> +    }
> +
> +    trace_cpr_delete_fd(name, id);
> +}
> +
> +int cpr_find_fd(const char *name, int id)
> +{
> +    CprFd *elem = find_fd(&cpr_state.fds, name, id);
> +    int fd = elem ? elem->fd : -1;
> +
> +    trace_cpr_find_fd(name, id, fd);
> +    return fd;
> +}
> +
> +int cpr_walk_fd(cpr_walk_fd_cb cb)
> +{
> +    CprFd *elem;
> +
> +    QLIST_FOREACH(elem, &cpr_state.fds, next) {
> +        if (elem->fd >= 0 && cb(elem->fd)) {
> +            return 1;
> +        }
> +    }
> +    return 0;
> +}
> +
> +void cpr_resave_fd(const char *name, int id, int fd)
> +{
> +    CprFd *elem = find_fd(&cpr_state.fds, name, id);
> +    int old_fd = elem ? elem->fd : -1;
> +
> +    if (old_fd < 0) {
> +        cpr_save_fd(name, id, fd);

I don't think I know well on when old_fd<0 would happen yet, as this series
doesn't look like to use this function at all.  From that POV, maybe nice
to add a comment above [1] for "fd" field.

Meanwhile, do we need to remove the old_fd<0 element here, or is it
intended to keep that and the new CprFD?

> +    } else if (old_fd != fd) {
> +        error_setg(&error_fatal,
> +                   "internal error: cpr fd '%s' id %d value %d "
> +                   "already saved with a different value %d",
> +                   name, id, fd, old_fd);
> +    }
> +}
> +/*************************************************************************/
> +#define CPR_STATE "CprState"
> +
> +static const VMStateDescription vmstate_cpr_state = {
> +    .name = CPR_STATE,
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .fields = (VMStateField[]) {
> +        VMSTATE_QLIST_V(fds, CprState, 1, vmstate_cpr_fd, CprFd, next),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +/*************************************************************************/
> +
> +int cpr_state_save(Error **errp)
> +{
> +    int ret;
> +    QEMUFile *f;
> +
> +    /* set f based on mode in a later patch in this series */
> +    return 0;
> +
> +    qemu_put_be32(f, QEMU_VM_FILE_MAGIC);
> +    qemu_put_be32(f, QEMU_VM_FILE_VERSION);

Having magic/version makes sense to me, though I'd suggest we use CPR new
magic/versions, so that if we see an binary dump we know what it is, and we
don't mixup a CPR image against a migration stream image.

> +
> +    ret = vmstate_save_state(f, &vmstate_cpr_state, &cpr_state, 0);

s/0/NULL/

> +    if (ret) {
> +        error_setg(errp, "vmstate_save_state error %d", ret);
> +    }

Can consider using vmstate_save_state_with_err().

> +
> +    qemu_fclose(f);
> +    return ret;
> +}
> +
> +int cpr_state_load(Error **errp)
> +{
> +    int ret;
> +    uint32_t v;
> +    QEMUFile *f;
> +
> +    /* set f based on mode in a later patch in this series */
> +    return 0;
> +
> +    v = qemu_get_be32(f);
> +    if (v != QEMU_VM_FILE_MAGIC) {
> +        error_setg(errp, "Not a migration stream (bad magic %x)", v);
> +        qemu_fclose(f);
> +        return -EINVAL;
> +    }
> +    v = qemu_get_be32(f);
> +    if (v != QEMU_VM_FILE_VERSION) {
> +        error_setg(errp, "Unsupported migration stream version %d", v);
> +        qemu_fclose(f);
> +        return -ENOTSUP;
> +    }
> +
> +    ret = vmstate_load_state(f, &vmstate_cpr_state, &cpr_state, 1);
> +    if (ret) {
> +        error_setg(errp, "vmstate_load_state error %d", ret);
> +    }

Simiarly, can use vmstate_save_state_with_err().

> +
> +    qemu_fclose(f);
> +    return ret;
> +}
> +
> diff --git a/migration/meson.build b/migration/meson.build
> index 5ce2acb4..87feb4c 100644
> --- a/migration/meson.build
> +++ b/migration/meson.build
> @@ -13,6 +13,7 @@ system_ss.add(files(
>    'block-dirty-bitmap.c',
>    'channel.c',
>    'channel-block.c',
> +  'cpr.c',
>    'dirtyrate.c',
>    'exec.c',
>    'fd.c',
> diff --git a/migration/migration.c b/migration/migration.c
> index 3dea06d..e394ad7 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -27,6 +27,7 @@
>  #include "sysemu/cpu-throttle.h"
>  #include "rdma.h"
>  #include "ram.h"
> +#include "migration/cpr.h"
>  #include "migration/global_state.h"
>  #include "migration/misc.h"
>  #include "migration.h"
> @@ -2118,6 +2119,10 @@ void qmp_migrate(const char *uri, bool has_channels,
>          }
>      }
>  
> +    if (cpr_state_save(&local_err)) {
> +        goto out;
> +    }
> +
>      if (addr->transport == MIGRATION_ADDRESS_TYPE_SOCKET) {
>          SocketAddress *saddr = &addr->u.socket;
>          if (saddr->type == SOCKET_ADDRESS_TYPE_INET ||
> @@ -2142,6 +2147,7 @@ void qmp_migrate(const char *uri, bool has_channels,
>                            MIGRATION_STATUS_FAILED);
>      }
>  
> +out:
>      if (local_err) {
>          if (!resume_requested) {
>              yank_unregister_instance(MIGRATION_YANK_INSTANCE);
> diff --git a/migration/trace-events b/migration/trace-events
> index 0b7c332..173f2c0 100644
> --- a/migration/trace-events
> +++ b/migration/trace-events
> @@ -340,6 +340,11 @@ colo_receive_message(const char *msg) "Receive '%s' message"
>  # colo-failover.c
>  colo_failover_set_state(const char *new_state) "new state %s"
>  
> +# cpr.c
> +cpr_save_fd(const char *name, int id, int fd) "%s, id %d, fd %d"
> +cpr_delete_fd(const char *name, int id) "%s, id %d"
> +cpr_find_fd(const char *name, int id, int fd) "%s, id %d returns %d"
> +
>  # block-dirty-bitmap.c
>  send_bitmap_header_enter(void) ""
>  send_bitmap_bits(uint32_t flags, uint64_t start_sector, uint32_t nr_sectors, uint64_t data_size) "flags: 0x%x, start_sector: %" PRIu64 ", nr_sectors: %" PRIu32 ", data_size: %" PRIu64
> diff --git a/system/vl.c b/system/vl.c
> index 03951be..6521ee3 100644
> --- a/system/vl.c
> +++ b/system/vl.c
> @@ -77,6 +77,7 @@
>  #include "hw/block/block.h"
>  #include "hw/i386/x86.h"
>  #include "hw/i386/pc.h"
> +#include "migration/cpr.h"
>  #include "migration/misc.h"
>  #include "migration/snapshot.h"
>  #include "sysemu/tpm.h"
> @@ -3713,6 +3714,8 @@ void qemu_init(int argc, char **argv)
>  
>      qemu_create_machine(machine_opts_dict);
>  
> +    cpr_state_load(&error_fatal);

Might be good to add a rich comment here explaining the decision on why
loading here; I think most of the tricks lie here.  E.g., it needs to be
before XXX and it needs to be after YYY.

Thanks,

> +
>      suspend_mux_open();
>  
>      qemu_disable_default_devices();
> -- 
> 1.8.3.1
> 

-- 
Peter Xu


