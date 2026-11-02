Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1A9F6070C8B
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 17:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=a4Ij5m53
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNvQU-0008LA-Iw; Mon, 02 Nov 2026 12:02:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xNvOs-0007tc-Ov
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 12:01:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xNvOp-0005NW-L8
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 12:00:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793638845;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=aN/0jFvNgXUAYUs36umrmLTaQs6tc3N7GHUKT94B10o=;
 b=a4Ij5m53n9isfsWd+SpH8LAkX0zv4pulmBbxTVNzLY9wwvu14kVYuAbpYLmOdqYF2fwXSD
 0CJRf61ofzvBpSQ1Hy8IaiLttu/ey62jVMKoYijPsjBcJ+Peir14IxsZ6zKBu1udi98CTt
 D7vWov2nCHfKzK3Yg8WJYYpIWS2yR8U=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-85-yiTtz0k-OgKMHyDJwRg5pQ-1; Mon,
 02 Nov 2026 12:00:43 -0500
X-MC-Unique: yiTtz0k-OgKMHyDJwRg5pQ-1
X-Mimecast-MFC-AGG-ID: yiTtz0k-OgKMHyDJwRg5pQ_1793638841
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5CD4118011FD; Mon,  2 Nov 2026 17:00:41 +0000 (UTC)
Received: from redhat.com (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6298630000E3; Mon,  2 Nov 2026 17:00:35 +0000 (UTC)
Date: Mon, 2 Nov 2026 17:00:32 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Filip Hejsek <filip.hejsek@gmail.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>,
 Laurent Vivier <laurent@vivier.eu>, Eric Blake <eblake@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 qemu-block@nongnu.org, "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Mark Kanda <mark.kanda@oracle.com>, Ben Chaney <bchaney@akamai.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>
Subject: Re: [PATCH v3] treewide: use qemu_dup() instead of dup()
Message-ID: <aujBsK64BzPSfeEI@redhat.com>
References: <20261015-use-qemu-dup-v3-1-ca02b5927725@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261015-use-qemu-dup-v3-1-ca02b5927725@gmail.com>
User-Agent: Mutt/2.4.2 (2026-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Filip

I had to drop this patch as it does not build  on Windows.

The qemu_dup() definition is wrapped to exclude Windows builds.

I think we need to make qemu_dup() be unconditional so it is
build on Windows too.

On Thu, Oct 15, 2026 at 03:34:43AM +0200, Filip Hejsek wrote:
> Use qemu_dup() to ensure the cloexec flag is set on dup'd fds.
> 
> The only direct users of dup() are now guest syscalls in the user
> emulators and the implementation of qemu_dup() itself.
> 
> Signed-off-by: Filip Hejsek <filip.hejsek@gmail.com>
> ---
> For each call I replaced, I checked how the resulting fd is used
> afterwards. In summary:
> 
> hw/virtio/virtio.c:
>     the fd is passed to memory_region_init_ram_from_fd, used for mmaping
> 
> io/channel-file.c:
>     the fd is passed to qio_channel_file_new_fd, used for reading/writing
> 
> migration/cpr-exec.c:
>     the cloexec flag is cleared
> 
> qemu-nbd.c:
>     the fd is stored into old_stderr, then dup2'd back to STDERR_FILENO
> 
> system/vl.c:
>     no change in behavior, the code was already setting the cloexec flag
> 
> ui/dmabuf.c:
>     the function is called by qemu_spice_gl_update, which passes the fds
>     to SPICE server
> 
> tests/qtest/bios-tables-test.c:
>     temp dup of stdout, dup2'd back to STDOUT_FILENO
> 
> tests/unit/test-util-sockets.c:
>     one fd is dup'd again and returned from mock monitor_get_fd; another
>     is converted to string and given as address to socket_connect
> 
> tests/unit/test-vmstate.c:
>     passed to qio_channel_file_new_fd to create a channel
> 
> Changes in v3:
> - Also replace the use in migration/cpr-exec.c and the tests
> - Link to v2: https://lore.kernel.org/qemu-devel/20261013-use-qemu-dup-v2-1-12ecd94263b7@gmail.com
> 
> Changes in v2:
> - Replace the use in qemu-nbd.c too
> - Changed commit message
> - Link to v1: https://lore.kernel.org/qemu-devel/20261012-use-qemu-dup-v1-1-03d94852a6c8@gmail.com
> ---
>  hw/virtio/virtio.c             | 2 +-
>  io/channel-file.c              | 2 +-
>  migration/cpr-exec.c           | 2 +-
>  qemu-nbd.c                     | 2 +-
>  system/vl.c                    | 9 +--------
>  tests/qtest/bios-tables-test.c | 2 +-
>  tests/unit/test-util-sockets.c | 6 +++---
>  tests/unit/test-vmstate.c      | 2 +-
>  ui/dmabuf.c                    | 2 +-
>  9 files changed, 11 insertions(+), 18 deletions(-)
> 
> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> index c9f9e5b511..70779fbd56 100644
> --- a/hw/virtio/virtio.c
> +++ b/hw/virtio/virtio.c
> @@ -3204,7 +3204,7 @@ VirtioSharedMemoryMapping *virtio_shared_memory_mapping_new(uint8_t shmid,
>          return NULL;
>      }
>  
> -    fd = dup(fd);
> +    fd = qemu_dup(fd);
>      if (fd < 0) {
>          error_report("Failed to duplicate fd: %s", strerror(errno));
>          return NULL;
> diff --git a/io/channel-file.c b/io/channel-file.c
> index 5cef75a67c..3f707e80c9 100644
> --- a/io/channel-file.c
> +++ b/io/channel-file.c
> @@ -48,7 +48,7 @@ qio_channel_file_new_fd(int fd)
>  QIOChannelFile *
>  qio_channel_file_new_dupfd(int fd, Error **errp)
>  {
> -    int newfd = dup(fd);
> +    int newfd = qemu_dup(fd);
>  
>      if (newfd < 0) {
>          error_setg_errno(errp, errno, "Could not dup FD %d", fd);
> diff --git a/migration/cpr-exec.c b/migration/cpr-exec.c
> index daa50916d2..2f38db30bb 100644
> --- a/migration/cpr-exec.c
> +++ b/migration/cpr-exec.c
> @@ -44,7 +44,7 @@ bool cpr_exec_persist_state(QEMUFile *f, Error **errp)
>  {
>      QIOChannelFile *fioc = QIO_CHANNEL_FILE(qemu_file_get_ioc(f));
>      /* coverity[leaked_storage] - mfd intentionally kept open across exec() */
> -    int mfd = dup(fioc->fd);
> +    int mfd = qemu_dup(fioc->fd);
>      char val[16];
>  
>      /* Remember mfd in environment for post-exec load */
> diff --git a/qemu-nbd.c b/qemu-nbd.c
> index ed5895861b..db1a70b008 100644
> --- a/qemu-nbd.c
> +++ b/qemu-nbd.c
> @@ -975,7 +975,7 @@ int main(int argc, char **argv)
>  
>              /* Remember parent's stderr if we will be restoring it. */
>              if (opts.verbose /* fork_process is set */) {
> -                opts.old_stderr = dup(STDERR_FILENO);
> +                opts.old_stderr = qemu_dup(STDERR_FILENO);
>                  if (opts.old_stderr < 0) {
>                      error_report("Could not dup original stderr: %s",
>                                   strerror(errno));
> diff --git a/system/vl.c b/system/vl.c
> index 468a9fc247..9381e3d7f7 100644
> --- a/system/vl.c
> +++ b/system/vl.c
> @@ -614,14 +614,7 @@ static int parse_add_fd(void *opaque, QemuOpts *opts, Error **errp)
>          return -1;
>      }
>  
> -#ifdef F_DUPFD_CLOEXEC
> -    dupfd = fcntl(fd, F_DUPFD_CLOEXEC, 0);
> -#else
> -    dupfd = dup(fd);
> -    if (dupfd != -1) {
> -        qemu_set_cloexec(dupfd);
> -    }
> -#endif
> +    dupfd = qemu_dup(fd);
>      if (dupfd == -1) {
>          error_setg_errno(errp, errno, "error duplicating fd");
>          return -1;
> diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
> index f6dfa4131b..c4838322fb 100644
> --- a/tests/qtest/bios-tables-test.c
> +++ b/tests/qtest/bios-tables-test.c
> @@ -529,7 +529,7 @@ static void test_acpi_asl(test_data *data)
>                      const char *diff_cmd = diff_env ? diff_env : "diff -U 16";
>                      char *diff = g_strdup_printf("%s %s %s", diff_cmd,
>                                                   exp_sdt->asl_file, sdt->asl_file);
> -                    int out = dup(STDOUT_FILENO);
> +                    int out = qemu_dup(STDOUT_FILENO);
>                      int ret G_GNUC_UNUSED;
>                      int dupret;
>  
> diff --git a/tests/unit/test-util-sockets.c b/tests/unit/test-util-sockets.c
> index 006f5e579c..c47ad6c82d 100644
> --- a/tests/unit/test-util-sockets.c
> +++ b/tests/unit/test-util-sockets.c
> @@ -62,7 +62,7 @@ int monitor_get_fd(Monitor *mon, const char *fdname, Error **errp)
>          error_setg(errp, "No fd named %s", fdname);
>          return -1;
>      }
> -    return dup(mon_fd);
> +    return qemu_dup(mon_fd);
>  }
>  
>  /*
> @@ -115,7 +115,7 @@ static void test_socket_fd_pass_name_bad(void)
>  
>      cur_mon = g_malloc(1); /* Fake a monitor */
>      mon_fdname = "myfd";
> -    mon_fd = dup(STDOUT_FILENO);
> +    mon_fd = qemu_dup(STDOUT_FILENO);
>      g_assert_cmpint(mon_fd, >, STDERR_FILENO);
>  
>      addr.type = SOCKET_ADDRESS_TYPE_FD;
> @@ -189,7 +189,7 @@ static void test_socket_fd_pass_num_bad(void)
>      int fd, sfd;
>  
>      g_assert(cur_mon == NULL);
> -    sfd = dup(STDOUT_FILENO);
> +    sfd = qemu_dup(STDOUT_FILENO);
>  
>      addr.type = SOCKET_ADDRESS_TYPE_FD;
>      addr.u.fd.str = g_strdup_printf("%d", sfd);
> diff --git a/tests/unit/test-vmstate.c b/tests/unit/test-vmstate.c
> index 23f3173070..57f1e3263f 100644
> --- a/tests/unit/test-vmstate.c
> +++ b/tests/unit/test-vmstate.c
> @@ -42,7 +42,7 @@ static QEMUFile *open_test_file(bool write)
>      QIOChannel *ioc;
>      QEMUFile *f;
>  
> -    fd = dup(temp_fd);
> +    fd = qemu_dup(temp_fd);
>      g_assert(fd >= 0);
>      lseek(fd, 0, SEEK_SET);
>      if (write) {
> diff --git a/ui/dmabuf.c b/ui/dmabuf.c
> index 497f82cc61..6d5dffdf84 100644
> --- a/ui/dmabuf.c
> +++ b/ui/dmabuf.c
> @@ -95,7 +95,7 @@ void qemu_dmabuf_dup_fds(QemuDmaBuf *dmabuf, int *fds, int nfds)
>      assert(nfds >= dmabuf->num_planes);
>  
>      for (i = 0; i < dmabuf->num_planes; i++) {
> -        fds[i] = dmabuf->fd[i] >= 0 ? dup(dmabuf->fd[i]) : -1;
> +        fds[i] = dmabuf->fd[i] >= 0 ? qemu_dup(dmabuf->fd[i]) : -1;
>      }
>  }
>  
> 
> ---
> base-commit: 615ece3c406b262996e569f29ea6eed0d81c4d8d
> change-id: 20261012-use-qemu-dup-38628dbac3ee
> 
> Best regards,
> --  
> Filip Hejsek <filip.hejsek@gmail.com>
> 

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


