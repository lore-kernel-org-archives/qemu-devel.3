Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B15A3CFB441
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2024 14:15:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxoVf-0006m8-4F; Mon, 07 Oct 2024 10:14:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sxoVa-0006kB-81
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 10:14:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sxoVY-0008WK-4I
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 10:14:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728310482;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=c7wzfOQjDmrlAN8w2h1rqw4y4gflZlENqJ8hcVtTKHk=;
 b=cqbNUvcwBwSzMojZuYnXNZiQ6gAPQ6AT/Nilya3+YB9jvrDgLymq47MZsqRMjKxUSWanKu
 T5jgwlPm72CLoBuIlMCFSuXsqK1DjyNdgDdgYgRUDBwdpoSMFGLCbfCfsiV9FTDrX2uY5u
 bFp6dEfahpxbukPZzpAIJkGaQdbI9Sg=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-663-3q5uwMk-PHqEXMybB_zADg-1; Mon, 07 Oct 2024 10:14:38 -0400
X-MC-Unique: 3q5uwMk-PHqEXMybB_zADg-1
Received: by mail-yw1-f197.google.com with SMTP id
 00721157ae682-6e2317d1cb7so66962827b3.3
 for <qemu-devel@nongnu.org>; Mon, 07 Oct 2024 07:14:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728310478; x=1728915278;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c7wzfOQjDmrlAN8w2h1rqw4y4gflZlENqJ8hcVtTKHk=;
 b=Mrfqx05/Tlv9B8RMEcs/rvbJojYjPNN0V0UIqPF5AM/lD8Uj4htNcQgRgK84gIYDCv
 JwxuQZhu7ig/367bNm5fKjwvwHf5yNLMtG9wCkBG0+ueonJZkTxVNSNlzrYNq6E3ge5x
 E66DbJY/TpFh/Xgsbnmg3+Z6iDNGS4+HkznUu7z66VRcXCXZbI684tc0aAksyGnzX6Ym
 Q9AsEN/rWBflkotCBOG1/4e704l/yKNHCiidUl4/05ZVr4PUQ9cWRCsifTbBaCoCmxa6
 IgY8ymWMyrPcXacI8VFOnjgCTaBlYESr6kOnYUQ22NPZbGPHIOYG/gIEWyCLgzFcBIrc
 BDjA==
X-Gm-Message-State: AOJu0Yx9WYiVMX18AkaAUKlnH1vfB0Cp5+63yT9emS6I1WJ21FiAy5y/
 iAourNRcz5SwXl1Jx4oh7AtnF7F9ZXIO8zDwEWqw6dojm1TsTVispDIy5fE349yo3xD3FwRquHl
 tFtdW/Fpsw7u+fCnpg7182cVpB1meGgRN4ufVtHVDmgUdRNxgXp3X
X-Received: by 2002:a05:690c:660f:b0:6dd:d119:58dd with SMTP id
 00721157ae682-6e2c7017952mr103002697b3.16.1728310478216; 
 Mon, 07 Oct 2024 07:14:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGFrg2qLTW+K9BJJg68jPPk1fZo1RY1bWb0kY0iVnbERxrDQaTUOm69SVNP9RDDGOv29srPJQ==
X-Received: by 2002:a05:690c:660f:b0:6dd:d119:58dd with SMTP id
 00721157ae682-6e2c7017952mr103002277b3.16.1728310477753; 
 Mon, 07 Oct 2024 07:14:37 -0700 (PDT)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6cba46cad11sm25855516d6.27.2024.10.07.07.14.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Oct 2024 07:14:37 -0700 (PDT)
Date: Mon, 7 Oct 2024 10:14:33 -0400
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
Subject: Re: [PATCH V2 02/13] migration: cpr-state
Message-ID: <ZwPsyRQVfmeNCt2z@x1n>
References: <1727725244-105198-1-git-send-email-steven.sistare@oracle.com>
 <1727725244-105198-3-git-send-email-steven.sistare@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1727725244-105198-3-git-send-email-steven.sistare@oracle.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.153,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Mon, Sep 30, 2024 at 12:40:33PM -0700, Steve Sistare wrote:
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
> Reviewed-by: Fabiano Rosas <farosas@suse.de>

Only two trivial comments below.

> ---
>  include/migration/cpr.h |  26 ++++++
>  migration/cpr.c         | 217 ++++++++++++++++++++++++++++++++++++++++++++++++
>  migration/meson.build   |   1 +
>  migration/migration.c   |   6 ++
>  migration/trace-events  |   5 ++
>  system/vl.c             |   7 ++
>  6 files changed, 262 insertions(+)
>  create mode 100644 include/migration/cpr.h
>  create mode 100644 migration/cpr.c
> 
> diff --git a/include/migration/cpr.h b/include/migration/cpr.h
> new file mode 100644
> index 0000000..e7b898b
> --- /dev/null
> +++ b/include/migration/cpr.h
> @@ -0,0 +1,26 @@
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
> +#define QEMU_CPR_FILE_MAGIC     0x51435052
> +#define QEMU_CPR_FILE_VERSION   0x00000001
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
> +void cpr_state_close(void);
> +struct QIOChannel *cpr_state_ioc(void);
> +
> +#endif
> diff --git a/migration/cpr.c b/migration/cpr.c
> new file mode 100644
> index 0000000..e50fc75
> --- /dev/null
> +++ b/migration/cpr.c
> @@ -0,0 +1,217 @@
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
> +    } else if (old_fd != fd) {
> +        error_setg(&error_fatal,
> +                   "internal error: cpr fd '%s' id %d value %d "
> +                   "already saved with a different value %d",
> +                   name, id, fd, old_fd);
> +    }
> +}

I remember I commented this, maybe not.. cpr_walk_fd() and cpr_resave_fd()
are not used in this series.  Suggest introduce them only when they're
used.

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
> +static QEMUFile *cpr_state_file;
> +
> +QIOChannel *cpr_state_ioc(void)
> +{
> +    return qemu_file_get_ioc(cpr_state_file);
> +}
> +
> +int cpr_state_save(Error **errp)
> +{
> +    int ret;
> +    QEMUFile *f;
> +
> +    /* set f based on mode in a later patch in this series */
> +    return 0;
> +
> +    qemu_put_be32(f, QEMU_CPR_FILE_MAGIC);
> +    qemu_put_be32(f, QEMU_CPR_FILE_VERSION);
> +
> +    ret = vmstate_save_state(f, &vmstate_cpr_state, &cpr_state, 0);
> +    if (ret) {
> +        error_setg(errp, "vmstate_save_state error %d", ret);
> +        qemu_fclose(f);
> +        return ret;
> +    }
> +
> +    /*
> +     * Close the socket only partially so we can later detect when the other
> +     * end closes by getting a HUP event.
> +     */
> +    qemu_fflush(f);
> +    qio_channel_shutdown(qemu_file_get_ioc(f), QIO_CHANNEL_SHUTDOWN_WRITE,
> +                         NULL);

What happens if we send everything and close immediately?

I didn't see how this cached file is used later throughout the whole
series.  Is it used in some follow up series?

> +    cpr_state_file = f;
> +    return 0;
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
> +    if (v != QEMU_CPR_FILE_MAGIC) {
> +        error_setg(errp, "Not a migration stream (bad magic %x)", v);
> +        qemu_fclose(f);
> +        return -EINVAL;
> +    }
> +    v = qemu_get_be32(f);
> +    if (v != QEMU_CPR_FILE_VERSION) {
> +        error_setg(errp, "Unsupported migration stream version %d", v);
> +        qemu_fclose(f);
> +        return -ENOTSUP;
> +    }
> +
> +    ret = vmstate_load_state(f, &vmstate_cpr_state, &cpr_state, 1);
> +    if (ret) {
> +        error_setg(errp, "vmstate_load_state error %d", ret);
> +        qemu_fclose(f);
> +        return ret;
> +    }
> +
> +    /*
> +     * Let the caller decide when to close the socket (and generate a HUP event
> +     * for the sending side).
> +     */
> +    cpr_state_file = f;
> +    return ret;
> +}
> +
> +void cpr_state_close(void)
> +{
> +    if (cpr_state_file) {
> +        qemu_fclose(cpr_state_file);
> +        cpr_state_file = NULL;
> +    }
> +}
> diff --git a/migration/meson.build b/migration/meson.build
> index 66d3de8..e5f4211 100644
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
> index ae2be31..834b0a2 100644
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
> @@ -2123,6 +2124,10 @@ void qmp_migrate(const char *uri, bool has_channels,
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
> @@ -2147,6 +2152,7 @@ void qmp_migrate(const char *uri, bool has_channels,
>                            MIGRATION_STATUS_FAILED);
>      }
>  
> +out:
>      if (local_err) {
>          if (!resume_requested) {
>              yank_unregister_instance(MIGRATION_YANK_INSTANCE);
> diff --git a/migration/trace-events b/migration/trace-events
> index c65902f..5356fb5 100644
> --- a/migration/trace-events
> +++ b/migration/trace-events
> @@ -341,6 +341,11 @@ colo_receive_message(const char *msg) "Receive '%s' message"
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
> index 752a1da..565d932 100644
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
> @@ -3720,6 +3721,12 @@ void qemu_init(int argc, char **argv)
>  
>      qemu_create_machine(machine_opts_dict);
>  
> +    /*
> +     * Load incoming CPR state before any devices are created, because it
> +     * contains file descriptors that are needed in device initialization code.
> +     */
> +    cpr_state_load(&error_fatal);
> +
>      suspend_mux_open();
>  
>      qemu_disable_default_devices();
> -- 
> 1.8.3.1
> 

-- 
Peter Xu


