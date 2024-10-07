Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3B52CFB446
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2024 15:19:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxpVM-0006Rf-R6; Mon, 07 Oct 2024 11:18:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sxpVL-0006RV-Fj
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 11:18:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sxpVJ-0007kt-Ia
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 11:18:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728314310;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BjryFoA6HlRzYpU5WGDAFnrAZBvYd8o9Sy+YJipUgSc=;
 b=FYYGfcTE33IF2MUa1y26xwriZv/mAxUQRavP6dXAaV6gOqOH+akY4Jj7W5bA7G4klXXZ+U
 sKc7/N3QYsXbOVSHN7dpY53rRWHg2ShR/zG51LmuZxHBH1rnntRYqjkRTfgfxLh237TGYD
 GRjntc1B4ICsaZFWcb7gDSgFbkiXrXg=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-400-sJFb94ACMQ2gXFjwzt89Lg-1; Mon, 07 Oct 2024 11:18:29 -0400
X-MC-Unique: sJFb94ACMQ2gXFjwzt89Lg-1
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-6cb2e0f3242so49554396d6.2
 for <qemu-devel@nongnu.org>; Mon, 07 Oct 2024 08:18:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728314309; x=1728919109;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BjryFoA6HlRzYpU5WGDAFnrAZBvYd8o9Sy+YJipUgSc=;
 b=rtkuBcX4+lch6F9NVvRnHgBfmoOSULYqFsGcafnSqjQw+J+XQ/Gs5091VXSOQ7dkUi
 UbKcpwjSsjn5Q8uYHmLzGMMMLefDRGRLzYsX+TQvPct6ZBzyIRi+eSn6IC5CvitX+AkE
 wbHTBsxiCV1cVUIB+vL4qhNdvFGo3UOwp6qk2OdBiJePf9StEX0CpNUC0+Uv9TYfuOcz
 uLXDvx2VaILluvttRWN7xW6iVcE7bGUFatR7wSoToFzoKLGSiiU89fFeo4atBLSb4HmJ
 YTUpab3Jm79tP0k4lONNdUtiJ4yo/RFMHDEsv8QpOc1KBA2dsUC5UQ4nQq77ReHinLFG
 P2Cw==
X-Gm-Message-State: AOJu0YyKkkeTcPod6DdiTCfCBp+g6+IyowZSZ9W6CWZl0XG7TdJ2WXWp
 vVR9ljn1q0PBcuJRh2lBci6ImuJl8dVv2fl+1LaTWlm6vfWRF1RbA6IdlFhuJ8DJuqtxUG5khFI
 lA2vFByZQn0NIjAUgKUy5kKZjhRuxHe8f23Bom37xRYxpp3CLw/ql
X-Received: by 2002:a05:6214:4b0f:b0:6cb:3c08:31bf with SMTP id
 6a1803df08f44-6cb9a440c49mr212674806d6.12.1728314308933; 
 Mon, 07 Oct 2024 08:18:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE39eDIl3fy2RZuHzBiwjpshLGZD1lFx1qSUBmIhDy0lCpEjFMCNDaKIyoy++69K5Yft+3JlQ==
X-Received: by 2002:a05:6214:4b0f:b0:6cb:3c08:31bf with SMTP id
 6a1803df08f44-6cb9a440c49mr212674376d6.12.1728314308565; 
 Mon, 07 Oct 2024 08:18:28 -0700 (PDT)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6cba4751520sm26458366d6.83.2024.10.07.08.18.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Oct 2024 08:18:27 -0700 (PDT)
Date: Mon, 7 Oct 2024 11:18:23 -0400
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
Subject: Re: [PATCH V2 03/13] migration: save cpr mode
Message-ID: <ZwP7v5pZNsMuXPgW@x1n>
References: <1727725244-105198-1-git-send-email-steven.sistare@oracle.com>
 <1727725244-105198-4-git-send-email-steven.sistare@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1727725244-105198-4-git-send-email-steven.sistare@oracle.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
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

On Mon, Sep 30, 2024 at 12:40:34PM -0700, Steve Sistare wrote:
> Save the mode in CPR state, so the user does not need to explicitly specify
> it for the target.  Modify migrate_mode() so it returns the incoming mode on
> the target.
> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> ---
>  include/migration/cpr.h |  7 +++++++
>  migration/cpr.c         | 23 ++++++++++++++++++++++-
>  migration/migration.c   |  1 +
>  migration/options.c     |  9 +++++++--
>  4 files changed, 37 insertions(+), 3 deletions(-)
> 
> diff --git a/include/migration/cpr.h b/include/migration/cpr.h
> index e7b898b..ac7a63e 100644
> --- a/include/migration/cpr.h
> +++ b/include/migration/cpr.h
> @@ -8,9 +8,16 @@
>  #ifndef MIGRATION_CPR_H
>  #define MIGRATION_CPR_H
>  
> +#include "qapi/qapi-types-migration.h"
> +
> +#define MIG_MODE_NONE           -1
> +
>  #define QEMU_CPR_FILE_MAGIC     0x51435052
>  #define QEMU_CPR_FILE_VERSION   0x00000001
>  
> +MigMode cpr_get_incoming_mode(void);
> +void cpr_set_incoming_mode(MigMode mode);
> +
>  typedef int (*cpr_walk_fd_cb)(int fd);
>  void cpr_save_fd(const char *name, int id, int fd);
>  void cpr_delete_fd(const char *name, int id);
> diff --git a/migration/cpr.c b/migration/cpr.c
> index e50fc75..7514c4e 100644
> --- a/migration/cpr.c
> +++ b/migration/cpr.c
> @@ -21,10 +21,23 @@
>  typedef QLIST_HEAD(CprFdList, CprFd) CprFdList;
>  
>  typedef struct CprState {
> +    MigMode mode;
>      CprFdList fds;
>  } CprState;
>  
> -static CprState cpr_state;
> +static CprState cpr_state = {
> +    .mode = MIG_MODE_NONE,
> +};
> +
> +MigMode cpr_get_incoming_mode(void)
> +{
> +    return cpr_state.mode;
> +}
> +
> +void cpr_set_incoming_mode(MigMode mode)
> +{
> +    cpr_state.mode = mode;
> +}
>  
>  /****************************************************************************/
>  
> @@ -124,11 +137,19 @@ void cpr_resave_fd(const char *name, int id, int fd)
>  /*************************************************************************/
>  #define CPR_STATE "CprState"
>  
> +static int cpr_state_presave(void *opaque)
> +{
> +    cpr_state.mode = migrate_mode();
> +    return 0;
> +}
> +
>  static const VMStateDescription vmstate_cpr_state = {
>      .name = CPR_STATE,
>      .version_id = 1,
>      .minimum_version_id = 1,
> +    .pre_save = cpr_state_presave,
>      .fields = (VMStateField[]) {
> +        VMSTATE_UINT32(mode, CprState),
>          VMSTATE_QLIST_V(fds, CprState, 1, vmstate_cpr_fd, CprFd, next),
>          VMSTATE_END_OF_LIST()
>      }
> diff --git a/migration/migration.c b/migration/migration.c
> index 834b0a2..df00e5c 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -416,6 +416,7 @@ void migration_incoming_state_destroy(void)
>          mis->postcopy_qemufile_dst = NULL;
>      }
>  
> +    cpr_set_incoming_mode(MIG_MODE_NONE);
>      yank_unregister_instance(MIGRATION_YANK_INSTANCE);
>  }
>  
> diff --git a/migration/options.c b/migration/options.c
> index 147cd2b..cc85a84 100644
> --- a/migration/options.c
> +++ b/migration/options.c
> @@ -22,6 +22,7 @@
>  #include "qapi/qmp/qnull.h"
>  #include "sysemu/runstate.h"
>  #include "migration/colo.h"
> +#include "migration/cpr.h"
>  #include "migration/misc.h"
>  #include "migration.h"
>  #include "migration-stats.h"
> @@ -768,8 +769,12 @@ uint64_t migrate_max_postcopy_bandwidth(void)
>  
>  MigMode migrate_mode(void)
>  {
> -    MigrationState *s = migrate_get_current();
> -    MigMode mode = s->parameters.mode;
> +    MigMode mode = cpr_get_incoming_mode();
> +
> +    if (mode == MIG_MODE_NONE) {
> +        MigrationState *s = migrate_get_current();
> +        mode = s->parameters.mode;
> +    }

Is this trying to avoid interfering with what user specified?

I can kind of get the point of it, but it'll also look pretty werid in this
case that user can set the mode but then when query before cpr-transfer
incoming completes it won't read what was set previously, but what was
migrated via the cpr channel.

And IIUC it is needed to migrate this mode in cpr stream so as to avoid
another new qemu cmdline on dest qemu.  If true this needs to be mentioned
in the commit message; so far it reads like it's optional, then it's not
clear why only cpr-mode needs to be migrated not other migration parameters.

If that won't get right easily, I wonder whether we could just overwrite
parameters.mode directly by the cpr stream.  After all IIUC that's before
QMP is available, so there's no legal way to set it, then no legal way that
it overwrites an user input?

>  
>      assert(mode >= 0 && mode < MIG_MODE__MAX);
>      return mode;
> -- 
> 1.8.3.1
> 

-- 
Peter Xu


