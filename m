Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52425C3DA7F
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2024 20:58:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sehYB-0005nk-6N; Thu, 15 Aug 2024 16:58:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sehY7-0005n3-Jv
 for qemu-devel@nongnu.org; Thu, 15 Aug 2024 16:58:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sehY5-0005qJ-Pk
 for qemu-devel@nongnu.org; Thu, 15 Aug 2024 16:58:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1723755499;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6slHL7aVF0fT90D42htMSsIqFksjeppYyWBBIUJ7k+o=;
 b=KkMrQdrUrK5FiTzBDGUWyVD5nzJ2lb+6QY5f4JhmrqCqw99sZ9UCfhaREC5BKCEnQ3bVq8
 FNwQdLxdPdaJeQjdcHEdXSpq83R7NOF3kAvDqwyw7r+B2FD3UTyRvM7+jbkpnDp1vWb1yP
 hjC3eberTuVTFEpU88OeI9MN3z0v2m4=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-657-mFmG4EOyM2SJpkyROVHN-w-1; Thu, 15 Aug 2024 16:58:15 -0400
X-MC-Unique: mFmG4EOyM2SJpkyROVHN-w-1
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-4503ee1b5d6so2657901cf.3
 for <qemu-devel@nongnu.org>; Thu, 15 Aug 2024 13:58:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723755495; x=1724360295;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6slHL7aVF0fT90D42htMSsIqFksjeppYyWBBIUJ7k+o=;
 b=SMVQKWYphbm8b2fOzw4GhBDul6NUK7QKwhfbfXsT95FRV1lwSyKuPpnsWWAODzvoDk
 lZw1Vf2cd7m49gE99p9L6i7KyixIXl0AKBrk3UxGQo+V0pN79LyA5tt6SPviyErgunq9
 3gAlws+DifrxJELDhPWbUl3SBRX044I0oRXB9LUcg7VKN2pF5/dmtX1KDOkPpzP4FHYY
 cV/Ku9Lm2PKFyNTALXC0NgUSADlWJcKtsIhp+a30bJ6dezyJpRcZDi8ceqCv0UHKXTl2
 P7m0UJ+QJ+u6jwnDPcniroxHL42bUxJ2iHk2mv4JHjkjV0Vl6ctc4RHuQhQqEPU5qzsA
 7Ecg==
X-Gm-Message-State: AOJu0Yx6aKa3YhUiQL2WkwT4Ghel4EstB1w2TQLIb5s7xgjyPbI+/dYC
 5Iy9EQ8du3fykPKt0hyB9dkN92/o56fnmiIiDMhSW5CKBntr2ugtOVYojMMIyA4Wpd0/F622CIB
 ODl6CoqlP8aVih5vnwCagHyB16LTKZwWOncjaQlhF5ODR5wZl8OMO
X-Received: by 2002:a05:622a:653:b0:450:349:1170 with SMTP id
 d75a77b69052e-453741d9e0dmr6445281cf.6.1723755494953; 
 Thu, 15 Aug 2024 13:58:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH1vbGUuNxOJXRhtc0kv4A55AcV7QmZYm7igzysnfCYl9gJwA5J4ZiTQ517o6U4aAVvOIXlFA==
X-Received: by 2002:a05:622a:653:b0:450:349:1170 with SMTP id
 d75a77b69052e-453741d9e0dmr6445101cf.6.1723755494432; 
 Thu, 15 Aug 2024 13:58:14 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-45369fd72aasm9411121cf.9.2024.08.15.13.58.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Aug 2024 13:58:13 -0700 (PDT)
Date: Thu, 15 Aug 2024 16:58:11 -0400
From: Peter Xu <peterx@redhat.com>
To: Steve Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [RFC V1 1/6] migration: SCM_RIGHTS for QEMUFile
Message-ID: <Zr5r4_lyKAPVZY3Y@x1n>
References: <1719776648-435073-1-git-send-email-steven.sistare@oracle.com>
 <1719776648-435073-2-git-send-email-steven.sistare@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1719776648-435073-2-git-send-email-steven.sistare@oracle.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.131,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Sun, Jun 30, 2024 at 12:44:03PM -0700, Steve Sistare wrote:
> Define functions to put/get file descriptors to/from a QEMUFile, for qio
> channels that support SCM_RIGHTS.  Maintain ordering such that
>   put(A), put(fd), put(B)
> followed by
>   get(A), get(fd), get(B)
> always succeeds.  Other get orderings may succeed but are not guaranteed.
> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>

It's a slight pity that we'll extend fd to qemufiles, rather than changing
qemufiles back to iochannels.. for the long term we want to remove qemufile.

Would you think we can start to introduce iochannel-compatible vmstate
loader from cpr-[exec/transfer] here?  The idea is that we'd want
vmstate_load_iochannel() then take that from an iochannel and start getting
rid of qemufile API.  It'll already bring two benefits:

  - We don't need this patch then I assume, but stick with iochannel API

  - We can have Error** as last parameter of vmstate_load_iochannel(), then
    as we discussed in the other thread cpr_state_load() can fail with
    explicit errors without error_report()s (and as you pointed out, the
    load side of Error** support is yet missing)

There's a 3rd potential benefit, and will come to play when we want to
allow multifd threads to load device states / VMSDs at some point, as
multifd doesn't maintain qemufiles, but only iochannels.

I'm not sure whether it adds too much to you yet, but I'm curious how you
think about it.

Thanks,

> ---
>  migration/qemu-file.c  | 83 +++++++++++++++++++++++++++++++++++++++++++++++---
>  migration/qemu-file.h  |  2 ++
>  migration/trace-events |  2 ++
>  3 files changed, 83 insertions(+), 4 deletions(-)
> 
> diff --git a/migration/qemu-file.c b/migration/qemu-file.c
> index b6d2f58..424c27d 100644
> --- a/migration/qemu-file.c
> +++ b/migration/qemu-file.c
> @@ -37,6 +37,11 @@
>  #define IO_BUF_SIZE 32768
>  #define MAX_IOV_SIZE MIN_CONST(IOV_MAX, 64)
>  
> +typedef struct FdEntry {
> +    QTAILQ_ENTRY(FdEntry) entry;
> +    int fd;
> +} FdEntry;
> +
>  struct QEMUFile {
>      QIOChannel *ioc;
>      bool is_writable;
> @@ -51,6 +56,9 @@ struct QEMUFile {
>  
>      int last_error;
>      Error *last_error_obj;
> +
> +    bool fd_pass;
> +    QTAILQ_HEAD(, FdEntry) fds;
>  };
>  
>  /*
> @@ -109,6 +117,8 @@ static QEMUFile *qemu_file_new_impl(QIOChannel *ioc, bool is_writable)
>      object_ref(ioc);
>      f->ioc = ioc;
>      f->is_writable = is_writable;
> +    f->fd_pass = qio_channel_has_feature(ioc, QIO_CHANNEL_FEATURE_FD_PASS);
> +    QTAILQ_INIT(&f->fds);
>  
>      return f;
>  }
> @@ -310,6 +320,10 @@ static ssize_t coroutine_mixed_fn qemu_fill_buffer(QEMUFile *f)
>      int len;
>      int pending;
>      Error *local_error = NULL;
> +    g_autofree int *fds = NULL;
> +    size_t nfd = 0;
> +    int **pfds = f->fd_pass ? &fds : NULL;
> +    size_t *pnfd = f->fd_pass ? &nfd : NULL;
>  
>      assert(!qemu_file_is_writable(f));
>  
> @@ -325,10 +339,9 @@ static ssize_t coroutine_mixed_fn qemu_fill_buffer(QEMUFile *f)
>      }
>  
>      do {
> -        len = qio_channel_read(f->ioc,
> -                               (char *)f->buf + pending,
> -                               IO_BUF_SIZE - pending,
> -                               &local_error);
> +        struct iovec iov = { f->buf + pending, IO_BUF_SIZE - pending };
> +        len = qio_channel_readv_full(f->ioc, &iov, 1, pfds, pnfd, 0,
> +                                     &local_error);
>          if (len == QIO_CHANNEL_ERR_BLOCK) {
>              if (qemu_in_coroutine()) {
>                  qio_channel_yield(f->ioc, G_IO_IN);
> @@ -348,9 +361,65 @@ static ssize_t coroutine_mixed_fn qemu_fill_buffer(QEMUFile *f)
>          qemu_file_set_error_obj(f, len, local_error);
>      }
>  
> +    for (int i = 0; i < nfd; i++) {
> +        FdEntry *fde = g_new0(FdEntry, 1);
> +        fde->fd = fds[i];
> +        QTAILQ_INSERT_TAIL(&f->fds, fde, entry);
> +    }
> +
>      return len;
>  }
>  
> +int qemu_file_put_fd(QEMUFile *f, int fd)
> +{
> +    int ret = 0;
> +    QIOChannel *ioc = qemu_file_get_ioc(f);
> +    Error *err = NULL;
> +    struct iovec iov = { (void *)" ", 1 };
> +
> +    /*
> +     * Send a dummy byte so qemu_fill_buffer on the receiving side does not
> +     * fail with a len=0 error.  Flush first to maintain ordering wrt other
> +     * data.
> +     */
> +
> +    qemu_fflush(f);
> +    if (qio_channel_writev_full(ioc, &iov, 1, &fd, 1, 0, &err) < 1) {
> +        error_report_err(error_copy(err));
> +        qemu_file_set_error_obj(f, -EIO, err);
> +        ret = -1;
> +    }
> +    trace_qemu_file_put_fd(f->ioc->name, fd, ret);
> +    return 0;
> +}
> +
> +int qemu_file_get_fd(QEMUFile *f)
> +{
> +    int fd = -1;
> +    FdEntry *fde;
> +
> +    if (!f->fd_pass) {
> +        Error *err = NULL;
> +        error_setg(&err, "%s does not support fd passing", f->ioc->name);
> +        error_report_err(error_copy(err));
> +        qemu_file_set_error_obj(f, -EIO, err);
> +        goto out;
> +    }
> +
> +    /* Force the dummy byte and its fd passenger to appear. */
> +    qemu_peek_byte(f, 0);
> +
> +    fde = QTAILQ_FIRST(&f->fds);
> +    if (fde) {
> +        qemu_get_byte(f);       /* Drop the dummy byte */
> +        fd = fde->fd;
> +        QTAILQ_REMOVE(&f->fds, fde, entry);
> +    }
> +out:
> +    trace_qemu_file_get_fd(f->ioc->name, fd);
> +    return fd;
> +}
> +
>  /** Closes the file
>   *
>   * Returns negative error value if any error happened on previous operations or
> @@ -361,11 +430,17 @@ static ssize_t coroutine_mixed_fn qemu_fill_buffer(QEMUFile *f)
>   */
>  int qemu_fclose(QEMUFile *f)
>  {
> +    FdEntry *fde, *next;
>      int ret = qemu_fflush(f);
>      int ret2 = qio_channel_close(f->ioc, NULL);
>      if (ret >= 0) {
>          ret = ret2;
>      }
> +    QTAILQ_FOREACH_SAFE(fde, &f->fds, entry, next) {
> +        warn_report("qemu_fclose: received fd %d was never claimed", fde->fd);
> +        close(fde->fd);
> +        g_free(fde);
> +    }
>      g_clear_pointer(&f->ioc, object_unref);
>      error_free(f->last_error_obj);
>      g_free(f);
> diff --git a/migration/qemu-file.h b/migration/qemu-file.h
> index 11c2120..3e47a20 100644
> --- a/migration/qemu-file.h
> +++ b/migration/qemu-file.h
> @@ -79,5 +79,7 @@ size_t qemu_get_buffer_at(QEMUFile *f, const uint8_t *buf, size_t buflen,
>                            off_t pos);
>  
>  QIOChannel *qemu_file_get_ioc(QEMUFile *file);
> +int qemu_file_put_fd(QEMUFile *f, int fd);
> +int qemu_file_get_fd(QEMUFile *f);
>  
>  #endif
> diff --git a/migration/trace-events b/migration/trace-events
> index 173f2c0..064b22d 100644
> --- a/migration/trace-events
> +++ b/migration/trace-events
> @@ -88,6 +88,8 @@ put_qlist_end(const char *field_name, const char *vmsd_name) "%s(%s)"
>  
>  # qemu-file.c
>  qemu_file_fclose(void) ""
> +qemu_file_put_fd(const char *name, int fd, int ret) "ioc %s, fd %d -> status %d"
> +qemu_file_get_fd(const char *name, int fd) "ioc %s -> fd %d"
>  
>  # ram.c
>  get_queued_page(const char *block_name, uint64_t tmp_offset, unsigned long page_abs) "%s/0x%" PRIx64 " page_abs=0x%lx"
> -- 
> 1.8.3.1
> 

-- 
Peter Xu


