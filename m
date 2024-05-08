Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D0F2C04FFE
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2024 18:23:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4lwm-0004Ju-KH; Wed, 08 May 2024 14:23:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1s4lwi-0004EG-4z
 for qemu-devel@nongnu.org; Wed, 08 May 2024 14:23:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1s4lwg-0001yR-3k
 for qemu-devel@nongnu.org; Wed, 08 May 2024 14:23:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715192591;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fUO+i2hCIs/ZiSTwde+zUaEOA6fbVjtI3WKGsMf8x0w=;
 b=OEZoUWuAFlOCpNGOijD7m8NvmD83BoB2HZYs8N/+QXoQS61qPL7Fvdcu+9pxALkj61RJ84
 qvWN/jmnVCx99XKs72r7VcunyvyqwK2IfES23LeLfyN5/uxx4paPNgLUfpuiZliOCfFlWP
 oFBC/S48NvSsjOo/GpQhbBUNY+njkwY=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-394-kxl30Qe0NZiVi7Yr3i8mZA-1; Wed, 08 May 2024 14:23:09 -0400
X-MC-Unique: kxl30Qe0NZiVi7Yr3i8mZA-1
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-2b2a1c121ebso17988a91.2
 for <qemu-devel@nongnu.org>; Wed, 08 May 2024 11:23:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715192588; x=1715797388;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fUO+i2hCIs/ZiSTwde+zUaEOA6fbVjtI3WKGsMf8x0w=;
 b=js6VENcDH+h7hiO/ieKgd2iBso+CwUV0fPopvNXEu1gc72b6Okj4EDCKW4bpRKDh0N
 X1W0zTu+sV8Gq1tQlEi+99AVr0MEXly3qa1or/i3PY8XVYkfL5O9WN89l/2eA0nikSoh
 ox79INhyzy4bc7JERVgFwSaILNIOZ3MyINeNJrAC41UpScviGA1i01IY+ib8u/SGiYZQ
 ac/M2nZptBJeIu9+viWgtMNkSZyDnAQ96JMOKnNypVK5TeEvzs2T/YSDL1sGvC6Cqgk1
 ZqVeeB8qNiing9tC3mm+9rn9olnTz5tnAbtELhMBaCxCCgPY+XaAEaBY9ahpM5aSWqHs
 H9qg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXohtRTFRP0eqo0ztLlkzc5O2c5Vd6p1CbHTugy9IdAGt2lDAKIBlSqcO9AsaKH4zcQI5tkB+35c+31oEC0s52BCWRBwvk=
X-Gm-Message-State: AOJu0YxP4wKDAVn7S7cUf+nZG4tivtngiiYAHynXuas843PyBoxL94Wt
 meVKNTInmst7FJRsNfDoluwr8iWRcZhGyjNjyljWo1u1ShG/pL36UERC+jCJ+b6bMIxkBZCLTFS
 1tqdYQ6edIspiiC1Q5M3qkp13P95C5GvpWq91odfNpJR7jHD0F7XP
X-Received: by 2002:a17:903:2351:b0:1dd:85eb:b11 with SMTP id
 d9443c01a7336-1eeb017a51fmr39491965ad.1.1715192588205; 
 Wed, 08 May 2024 11:23:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEEJuLlukH7LKw/vtZY/Fb/0EvyLFi5t1WLinjTiqg16l2xPOPD3Wg9BYStliC3HSH856IrAw==
X-Received: by 2002:a17:903:2351:b0:1dd:85eb:b11 with SMTP id
 d9443c01a7336-1eeb017a51fmr39491585ad.1.1715192587511; 
 Wed, 08 May 2024 11:23:07 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 e6-20020a170902784600b001eb6a881b88sm12478096pln.245.2024.05.08.11.23.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 May 2024 11:23:07 -0700 (PDT)
Date: Wed, 8 May 2024 14:23:04 -0400
From: Peter Xu <peterx@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org,
 armbru@redhat.com, Claudio Fontana <cfontana@suse.de>,
 Jim Fehlig <jfehlig@suse.com>
Subject: Re: [PATCH 8/9] migration: Add support for fdset with multifd + file
Message-ID: <ZjvDCA9QvTI-zFf9@x1n>
References: <20240426142042.14573-1-farosas@suse.de>
 <20240426142042.14573-9-farosas@suse.de>
 <Zjs9nI_Wgi5UIJba@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zjs9nI_Wgi5UIJba@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.582,
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

On Wed, May 08, 2024 at 09:53:48AM +0100, Daniel P. Berrangé wrote:
> On Fri, Apr 26, 2024 at 11:20:41AM -0300, Fabiano Rosas wrote:
> > Allow multifd to use an fdset when migrating to a file. This is useful
> > for the scenario where the management layer wants to have control over
> > the migration file.
> > 
> > By receiving the file descriptors directly, QEMU can delegate some
> > high level operating system operations to the management layer (such
> > as mandatory access control). The management layer might also want to
> > add its own headers before the migration stream.
> > 
> > Enable the "file:/dev/fdset/#" syntax for the multifd migration with
> > mapped-ram. The requirements for the fdset mechanism are:
> > 
> > On the migration source side:
> > 
> > - the fdset must contain two fds that are not duplicates between
> >   themselves;
> > - if direct-io is to be used, exactly one of the fds must have the
> >   O_DIRECT flag set;
> > - the file must be opened with WRONLY both times.
> > 
> > On the migration destination side:
> > 
> > - the fdset must contain one fd;
> > - the file must be opened with RDONLY.
> > 
> > Signed-off-by: Fabiano Rosas <farosas@suse.de>
> > ---
> >  docs/devel/migration/main.rst       | 18 ++++++++++++++
> >  docs/devel/migration/mapped-ram.rst |  6 ++++-
> >  migration/file.c                    | 38 ++++++++++++++++++++++++++++-
> >  3 files changed, 60 insertions(+), 2 deletions(-)
> > 
> > diff --git a/docs/devel/migration/main.rst b/docs/devel/migration/main.rst
> > index 54385a23e5..50f6096470 100644
> > --- a/docs/devel/migration/main.rst
> > +++ b/docs/devel/migration/main.rst
> > @@ -47,6 +47,24 @@ over any transport.
> >    QEMU interference. Note that QEMU does not flush cached file
> >    data/metadata at the end of migration.
> >  
> > +  The file migration also supports using a file that has already been
> > +  opened. A set of file descriptors is passed to QEMU via an "fdset"
> > +  (see add-fd QMP command documentation). This method allows a
> > +  management application to have control over the migration file
> > +  opening operation. There are, however, strict requirements to this
> > +  interface:
> > +
> > +  On the migration source side:
> > +    - if the multifd capability is to be used, the fdset must contain
> > +      two file descriptors that are not duplicates between themselves;
> > +    - if the direct-io capability is to be used, exactly one of the
> > +      file descriptors must have the O_DIRECT flag set;
> > +    - the file must be opened with WRONLY.
> > +
> > +  On the migration destination side:
> > +    - the fdset must contain one file descriptor;
> > +    - the file must be opened with RDONLY.
> > +
> >  In addition, support is included for migration using RDMA, which
> >  transports the page data using ``RDMA``, where the hardware takes care of
> >  transporting the pages, and the load on the CPU is much lower.  While the
> > diff --git a/docs/devel/migration/mapped-ram.rst b/docs/devel/migration/mapped-ram.rst
> > index fa4cefd9fc..e6505511f0 100644
> > --- a/docs/devel/migration/mapped-ram.rst
> > +++ b/docs/devel/migration/mapped-ram.rst
> > @@ -16,7 +16,7 @@ location in the file, rather than constantly being added to a
> >  sequential stream. Having the pages at fixed offsets also allows the
> >  usage of O_DIRECT for save/restore of the migration stream as the
> >  pages are ensured to be written respecting O_DIRECT alignment
> > -restrictions (direct-io support not yet implemented).
> > +restrictions.
> >  
> >  Usage
> >  -----
> > @@ -35,6 +35,10 @@ Use a ``file:`` URL for migration:
> >  Mapped-ram migration is best done non-live, i.e. by stopping the VM on
> >  the source side before migrating.
> >  
> > +For best performance enable the ``direct-io`` capability as well:
> > +
> > +    ``migrate_set_capability direct-io on``
> > +
> >  Use-cases
> >  ---------
> >  
> > diff --git a/migration/file.c b/migration/file.c
> > index b9265b14dd..3bc8bc7463 100644
> > --- a/migration/file.c
> > +++ b/migration/file.c
> > @@ -17,6 +17,7 @@
> >  #include "io/channel-file.h"
> >  #include "io/channel-socket.h"
> >  #include "io/channel-util.h"
> > +#include "monitor/monitor.h"
> >  #include "options.h"
> >  #include "trace.h"
> >  
> > @@ -54,10 +55,18 @@ static void file_remove_fdset(void)
> >      }
> >  }
> >  
> > +/*
> > + * With multifd, due to the behavior of the dup() system call, we need
> > + * the fdset to have two non-duplicate fds so we can enable direct IO
> > + * in the secondary channels without affecting the main channel.
> > + */
> >  static bool file_parse_fdset(const char *filename, int64_t *fdset_id,
> >                               Error **errp)
> >  {
> > +    FdsetInfoList *fds_info;
> > +    FdsetFdInfoList *fd_info;
> >      const char *fdset_id_str;
> > +    int nfds = 0;
> >  
> >      *fdset_id = -1;
> >  
> > @@ -71,6 +80,32 @@ static bool file_parse_fdset(const char *filename, int64_t *fdset_id,
> >          return false;
> >      }
> >  
> > +    if (!migrate_multifd() || !migrate_direct_io()) {
> > +        return true;
> > +    }
> > +
> > +    for (fds_info = qmp_query_fdsets(NULL); fds_info;
> > +         fds_info = fds_info->next) {
> > +
> > +        if (*fdset_id != fds_info->value->fdset_id) {
> > +            continue;
> > +        }
> > +
> > +        for (fd_info = fds_info->value->fds; fd_info; fd_info = fd_info->next) {
> > +            if (nfds++ > 2) {
> > +                break;
> > +            }
> > +        }
> > +    }
> > +
> > +    if (nfds != 2) {
> > +        error_setg(errp, "Outgoing migration needs two fds in the fdset, "
> > +                   "got %d", nfds);
> > +        qmp_remove_fd(*fdset_id, false, -1, NULL);
> > +        *fdset_id = -1;
> > +        return false;
> > +    }
> > +
> >      return true;
> >  }
> 
> Related to my thoughts in an earlier patch, where I say that use of fdsets
> ought to be transparent to QEMU code, I'm not a fan of having this logic
> in migration code.
> 
> IIUC, the migration code will call  qio_channel_file_new_path twice,
> once with O_DIRECT and once without. This should trigger two calls
> into monitor_fdset_dup_fd_add with different flags. If we're matching
> flags in that monitor_fdset_dup_fd_add(), then if only 1 FD was
> provided, are we not able to report an error there ?

Right, this sounds working.

For a real sanity check, we may want to somehow check the two fds returned
from qio_channel_file_new_path() to point to the same file underneath.

What mentioned in the other thread (kcmp with KCMP_FILE) might not work, as
the whole purpose of having two fds is to make sure they have different
struct file to back the fd (and only one of them has O_DIRECT).  fstat()
might work in this case over the st_ino field, etc. maybe fstatfs() too but
perhaps that's over cautious.  Just a pain to use two fds as a start..

Thanks,

-- 
Peter Xu


