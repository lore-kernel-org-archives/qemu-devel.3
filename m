Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90DD7C02198
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2025 16:38:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiyh2-0007uk-5i; Fri, 14 Feb 2025 11:37:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tiygz-0007uD-4h
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 11:37:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tiygx-0003On-7Z
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 11:37:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739551044;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3fVKMF+PPgv0KUBsKA3U5DA2a5TEheTxHMzAFbNYv4A=;
 b=VPcMnef6ouiz9TpC9Z/Y1LctA7uSTXX6W2nXddXBkFdDjcFPGWiGsPTcUrJ18XL2Y71Hax
 HBQxl6V8ZQDmKpCszDhnisvYDh/aB6c8yLEmBrwMX6nOFxZ+QFZCH6xFUhoc0ZURVV9KzW
 c/5S/HJ/xEtDAMlnxrWSFnJm0v45ONk=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-215-sBO-I_UkM86PFsEQ8Hbr5w-1; Fri, 14 Feb 2025 11:37:22 -0500
X-MC-Unique: sBO-I_UkM86PFsEQ8Hbr5w-1
X-Mimecast-MFC-AGG-ID: sBO-I_UkM86PFsEQ8Hbr5w_1739551042
Received: by mail-oo1-f70.google.com with SMTP id
 006d021491bc7-5fc0058d68eso605270eaf.0
 for <qemu-devel@nongnu.org>; Fri, 14 Feb 2025 08:37:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739551042; x=1740155842;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3fVKMF+PPgv0KUBsKA3U5DA2a5TEheTxHMzAFbNYv4A=;
 b=Kok0itMZ5+669S3HRR51HP2hQGvRR8VUxBXryC3BVwu0XkB/SryKkBPze6Tnm9UE75
 sdtnRXkm8Sa3OnoHfvi/4teC4WnkAxV+XhHVwYTILPWWWcaPXR/9tlm22UP9Ie9Y+lmF
 lP5rUIky+4AkokbiOzBY9GtQ/QEYFeuuvPvBTovUxOfhmD6g8uBDQ+0oRjUT3aKxrQgu
 3dfnGB0MXhHHOLZ+WCHVX2ePZf5EX5NhTGT5USPv+WLZhVM7h96BscsHZaDYpSlZH1+v
 Kr1dzGLpyuURBEEalEGR65ViLyW3z+6XC6sodoPbXSBd1FHvJJWBwnW/LimTeTafQMFk
 Q6/A==
X-Gm-Message-State: AOJu0YwM9fzO3PYtTqt5Nv0QsyL+RpiL6HJgquf/U6VHSkKcgSzq5oxL
 CSOZiB4dk4qndEWmbv7tsoalaHfML7pEe9zk+/9S+JyCyXiEJHDrr1EzmoCfhcwoHvhZIhq82wJ
 o1e30fN5p2b4zb8dgWh+amcvB8QV+mye0vLK5b0JkA0cACye13iZv
X-Gm-Gg: ASbGnctCdhadZZbjniWLEWCzMUAr8uAqIvEBKfQQt5mW3BwIJkXJg/2EPN/bZs90sOR
 h0qBqVsiVmshPQnKUWxovexI01M3jXkXYWNzNEMB1b0MDL8lUy8MM0V4Ufm46ZDWAn6Hc/Y9UFQ
 TrPmH4y47pGfLig3Z0KQ+YUvoKcH4r+fC0JzOXZlWEuJAoq8YSWBOsOc/ne5dInzmrEeMYW50Vt
 2awfV3CnHx4myHIPQVBqhJLi2NhdYA9SUI9a+sYAKLR6alObyKNpTajJI4=
X-Received: by 2002:a05:6808:38ce:b0:3f3:b4d4:835 with SMTP id
 5614622812f47-3f3d8da186cmr5625344b6e.3.1739551042096; 
 Fri, 14 Feb 2025 08:37:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE794sU22Xtwn6P7uMLPZV0w+xWHI8RbLM1o61ZQ2ApTLPvh7mtjBb/vidEx4ZIyFYI+V3sMw==
X-Received: by 2002:a05:6808:38ce:b0:3f3:b4d4:835 with SMTP id
 5614622812f47-3f3d8da186cmr5625323b6e.3.1739551041751; 
 Fri, 14 Feb 2025 08:37:21 -0800 (PST)
Received: from x1.local ([2604:7a40:2041:2b00::1000])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-3f3da9fdf72sm1364857b6e.33.2025.02.14.08.37.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Feb 2025 08:37:20 -0800 (PST)
Date: Fri, 14 Feb 2025 11:37:17 -0500
From: Peter Xu <peterx@redhat.com>
To: Steve Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Yi Liu <yi.l.liu@intel.com>,
 Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH V2 02/45] migration: cpr helpers
Message-ID: <Z69xPYAJcOjlSpff@x1.local>
References: <1739542467-226739-1-git-send-email-steven.sistare@oracle.com>
 <1739542467-226739-3-git-send-email-steven.sistare@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1739542467-226739-3-git-send-email-steven.sistare@oracle.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.732,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Fri, Feb 14, 2025 at 06:13:44AM -0800, Steve Sistare wrote:
> Add cpr_needed_for_reuse, cpr_resave_fd helpers, cpr_is_incoming, and
> cpr_open_fd, for use when adding cpr support for vfio and iommufd.
> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> ---
>  include/migration/cpr.h |  6 ++++++
>  migration/cpr.c         | 44 ++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 50 insertions(+)
> 
> diff --git a/include/migration/cpr.h b/include/migration/cpr.h
> index 3a6deb7..6ad04d4 100644
> --- a/include/migration/cpr.h
> +++ b/include/migration/cpr.h
> @@ -18,15 +18,21 @@
>  void cpr_save_fd(const char *name, int id, int fd);
>  void cpr_delete_fd(const char *name, int id);
>  int cpr_find_fd(const char *name, int id);
> +void cpr_resave_fd(const char *name, int id, int fd);
> +int cpr_open_fd(const char *path, int flags, const char *name, int id,
> +                bool *reused, Error **errp);
>  
>  MigMode cpr_get_incoming_mode(void);
>  void cpr_set_incoming_mode(MigMode mode);
> +bool cpr_is_incoming(void);
>  
>  int cpr_state_save(MigrationChannel *channel, Error **errp);
>  int cpr_state_load(MigrationChannel *channel, Error **errp);
>  void cpr_state_close(void);
>  struct QIOChannel *cpr_state_ioc(void);
>  
> +bool cpr_needed_for_reuse(void *opaque);
> +
>  QEMUFile *cpr_transfer_output(MigrationChannel *channel, Error **errp);
>  QEMUFile *cpr_transfer_input(MigrationChannel *channel, Error **errp);
>  
> diff --git a/migration/cpr.c b/migration/cpr.c
> index 584b0b9..12c489b 100644
> --- a/migration/cpr.c
> +++ b/migration/cpr.c
> @@ -95,6 +95,39 @@ int cpr_find_fd(const char *name, int id)
>      trace_cpr_find_fd(name, id, fd);
>      return fd;
>  }
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

How bad it is to trigger this?

I wonder if cpr_save_fd() should have checked this already on duplicated
entries; it looks risky there too if this happens to existing cpr_save_fd()
callers.

> +    }
> +}
> +
> +int cpr_open_fd(const char *path, int flags, const char *name, int id,
> +                bool *reused, Error **errp)
> +{
> +    int fd = cpr_find_fd(name, id);
> +
> +    if (reused) {
> +        *reused = (fd >= 0);
> +    }
> +    if (fd < 0) {
> +        fd = qemu_open(path, flags, errp);
> +        if (fd >= 0) {
> +            cpr_save_fd(name, id, fd);
> +        }
> +    }
> +    return fd;
> +}
> +
>  /*************************************************************************/
>  #define CPR_STATE "CprState"
>  
> @@ -128,6 +161,11 @@ void cpr_set_incoming_mode(MigMode mode)
>      incoming_mode = mode;
>  }
>  
> +bool cpr_is_incoming(void)
> +{
> +    return incoming_mode != MIG_MODE_NONE;
> +}

Maybe it'll be helpful to document either this function or incoming_mode;
it's probably not yet obvious to most readers incoming_mode is only set to
!NONE during a small window when VM loads.

> +
>  int cpr_state_save(MigrationChannel *channel, Error **errp)
>  {
>      int ret;
> @@ -222,3 +260,9 @@ void cpr_state_close(void)
>          cpr_state_file = NULL;
>      }
>  }
> +
> +bool cpr_needed_for_reuse(void *opaque)
> +{
> +    MigMode mode = migrate_mode();

Nit: can drop the var.

> +    return mode == MIG_MODE_CPR_TRANSFER;
> +}
> -- 
> 1.8.3.1
> 

-- 
Peter Xu


