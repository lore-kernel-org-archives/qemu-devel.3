Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D51FC87FCF
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Aug 2025 20:07:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umHj4-0001tE-0s; Wed, 13 Aug 2025 16:05:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1umHj2-0001t1-MN
 for qemu-devel@nongnu.org; Wed, 13 Aug 2025 16:05:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1umHiw-0001RX-Q7
 for qemu-devel@nongnu.org; Wed, 13 Aug 2025 16:05:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755115522;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IBAOi0/n0vx0gHk1/2THC2uxanB8CFbIFBKfpOvONq4=;
 b=TRV9idNYbSjLT1RoYaiODNQbZe0VQe1eY5ZhB94Oc3ZHUtcObc5lv1OBSw69ssY/xhBmzP
 ++jJ5jn693S2aS5e6M4TfFfY5MAQo5b1oudKDrzvn3qTuciAcC1rW2AD2R7+i1HmtK5Sud
 a1i8qLpY0waLugxQ17BgSIBo2q9Bdjg=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-653-Zzy5vDFhNnWbDy3fXso0ow-1; Wed, 13 Aug 2025 16:05:20 -0400
X-MC-Unique: Zzy5vDFhNnWbDy3fXso0ow-1
X-Mimecast-MFC-AGG-ID: Zzy5vDFhNnWbDy3fXso0ow_1755115520
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-4b109c8804dso7432831cf.3
 for <qemu-devel@nongnu.org>; Wed, 13 Aug 2025 13:05:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755115520; x=1755720320;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IBAOi0/n0vx0gHk1/2THC2uxanB8CFbIFBKfpOvONq4=;
 b=ZvXKz2xA4IZPpPa9LcqJGjfeam0F21MsVAf5rVQGKUBICDOla+o/DcWIQxbTPxb/uu
 fiNlsY/dJcSkcXBhLvDoxbKMRzLEgma7EKwZ06yvYfR8yCAzYANPN7QXwvtkNzm69V/Y
 fdiED1P5LV2onKljngQRwZKSiF5IAM4WniGpqOxRKu6j/ucJpRCW7HBe1tGc7rD7DHB2
 kz/BRTAEfJrPbg8qpWXVfmrqVFakByiksZ95Vo8x2DgXPPBgyw8dEGAQm4S+YEFxffdn
 5Vb3xpWujQRbory9Xcv68bLmHzcR3OBklYOmzGf1ee3/4UYym0IC8xvI5s+j0BgfVskq
 fBuw==
X-Gm-Message-State: AOJu0Yw46E/JkssQ4m8hg3060Cdq6Ft/g6h7KRuUD3+AMlnpNHtE6BQL
 Y8pwlideCWjwoBAk5e7rRLnAwyp7ZuYyaBMeK1bEANKVj43XsG51HhLj2Lb/3aagiQ644MLrUGW
 VFFg6QS+POFPfVYN0j2qufshBrp2BDgBIAMk7OUgLSCpSUVNIh1cv2S+e
X-Gm-Gg: ASbGnct3Wc6ZB04J3begRC0AcUMb1ImgKcdzta+oTmxEiyAazI6jiuYJuRiwvn/sqN/
 luvEK/X7f6VrgWywKeo6vYYYK4mf0ZGtUVmKvZbgWF/ZnOxGCvip+WrZftso0WFWU+B8EO3A/Z6
 p7aijA2w8XlT9yOPsyPi0gT3+MgBy1GeGB4ydHiYlYeqrZg+43a5ycrElbIlU/tEp2vo9riSzdx
 5glWy4BuFrWIp2EIav4TEmpnTAv5QI0KQJ5nxgYZztxccDURjQVffZ5Qwjb3ckLSU7xhVrhCvJf
 KiLsiRaXHXR3Z1tpNDy5gUz0P8F2BRWk
X-Received: by 2002:a05:622a:19a0:b0:4b0:ed9d:6251 with SMTP id
 d75a77b69052e-4b10a9bdd6fmr9106331cf.27.1755115519651; 
 Wed, 13 Aug 2025 13:05:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFsYw1z9VusOH87z7nuHEJndsEiL/CPWM9cCgMOKQHVhzXBKCCsM++U3LDvkJt9GbUvwfvV9w==
X-Received: by 2002:a05:622a:19a0:b0:4b0:ed9d:6251 with SMTP id
 d75a77b69052e-4b10a9bdd6fmr9105671cf.27.1755115519007; 
 Wed, 13 Aug 2025 13:05:19 -0700 (PDT)
Received: from x1.local ([174.89.135.171]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4b069ca56e5sm145275281cf.40.2025.08.13.13.05.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Aug 2025 13:05:18 -0700 (PDT)
Date: Wed, 13 Aug 2025 16:05:06 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, armbru@redhat.com
Subject: Re: [PATCH v2 14/24] migration: Use visitors in
 migrate_params_test_apply
Message-ID: <aJzv8hm87PVIOSLj@x1.local>
References: <20250630195913.28033-1-farosas@suse.de>
 <20250630195913.28033-15-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250630195913.28033-15-farosas@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Jun 30, 2025 at 04:59:03PM -0300, Fabiano Rosas wrote:
> Convert the code in migrate_params_test_apply() from an open-coded
> copy of every migration parameter to a copy using visitors. The
> current code has conditionals for each parameter's has_* field, which
> is exactly what the visitors do.
> 
> This hides the details of QAPI from the migration code and avoids the
> need to update migrate_params_test_apply() every time a new migration
> parameter is added. Both were very confusing and while the visitor
> code can become a bit involved, there is no need for new contributors
> to ever touch it.
> 
> Change the name of the function to a more direct reference of what it
> does: merging the user params with the temporary copy.
> 
> Move the QAPI_CLONE_MEMBERS into the caller, so QAPI_CLONE can be used
> and there's no need to allocate memory in the migration
> code. Similarly, turn 'tmp' into a pointer so the proper qapi_free_
> routine can be used.
> 
> An extra call to migrate_mark_all_params_present() is now needed
> because the visitors update the has_ field for non-present fields, but
> we actually want them all set so migrate_params_apply() can copy all
> of them.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>  migration/options.c | 157 +++++++++++++++-----------------------------
>  1 file changed, 54 insertions(+), 103 deletions(-)
> 
> diff --git a/migration/options.c b/migration/options.c
> index 6619b5f21a..695bec5b8f 100644
> --- a/migration/options.c
> +++ b/migration/options.c
> @@ -20,6 +20,10 @@
>  #include "qapi/qapi-commands-migration.h"
>  #include "qapi/qapi-visit-migration.h"
>  #include "qapi/qmp/qerror.h"
> +#include "qapi/qobject-input-visitor.h"
> +#include "qapi/qobject-output-visitor.h"
> +#include "qapi/visitor.h"
> +#include "qobject/qdict.h"
>  #include "qobject/qnull.h"
>  #include "system/runstate.h"
>  #include "migration/colo.h"
> @@ -1223,120 +1227,63 @@ bool migrate_params_check(MigrationParameters *params, Error **errp)
>      return true;
>  }
>  
> -static void migrate_params_test_apply(MigrationParameters *params,
> -                                      MigrationParameters *dest)
> +static bool migrate_params_merge(MigrationParameters *dst,
> +                                 MigrationParameters *src, Error **errp)
>  {
> -    MigrationState *s = migrate_get_current();
> +    QObject *ret_out = NULL;
> +    Visitor *v;
> +    bool ok;
>  
> -    QAPI_CLONE_MEMBERS(MigrationParameters, dest, &s->parameters);
> -
> -    if (params->has_throttle_trigger_threshold) {
> -        dest->throttle_trigger_threshold = params->throttle_trigger_threshold;
> -    }
> -
> -    if (params->has_cpu_throttle_initial) {
> -        dest->cpu_throttle_initial = params->cpu_throttle_initial;
> -    }
> -
> -    if (params->has_cpu_throttle_increment) {
> -        dest->cpu_throttle_increment = params->cpu_throttle_increment;
> +    /* free memory from pointers that are about to be assigned */
> +    if (src->has_block_bitmap_mapping) {
> +        qapi_free_BitmapMigrationNodeAliasList(dst->block_bitmap_mapping);

There're quite a few similar cases like this one in this series (including
the rest below parameters below), where we free stuff but keep the dangling
pointer around for a while (..hopefully!)..

Should we still try to reset the pointers?  Am I the only one that is
nervous with it?

>      }
>  
> -    if (params->has_cpu_throttle_tailslow) {
> -        dest->cpu_throttle_tailslow = params->cpu_throttle_tailslow;
> +    if (src->tls_creds) {
> +        qapi_free_StrOrNull(dst->tls_creds);
>      }
>  
> -    if (params->tls_creds) {
> -        qapi_free_StrOrNull(dest->tls_creds);
> -        dest->tls_creds = QAPI_CLONE(StrOrNull, params->tls_creds);
> +    if (src->tls_hostname) {
> +        qapi_free_StrOrNull(dst->tls_hostname);
>      }
>  
> -    if (params->tls_hostname) {
> -        qapi_free_StrOrNull(dest->tls_hostname);
> -        dest->tls_hostname = QAPI_CLONE(StrOrNull, params->tls_hostname);
> +    if (src->tls_authz) {
> +        qapi_free_StrOrNull(dst->tls_authz);
>      }
>  
> -    if (params->tls_authz) {
> -        qapi_free_StrOrNull(dest->tls_authz);
> -        dest->tls_authz = QAPI_CLONE(StrOrNull, params->tls_authz);
> +    /* read in from src */
> +    v = qobject_output_visitor_new(&ret_out);
> +    ok = visit_type_MigrationParameters(v, NULL, &src, errp);
> +    if (!ok) {
> +        goto out;
>      }
> +    visit_complete(v, &ret_out);
> +    visit_free(v);
>  
> -    if (params->has_max_bandwidth) {
> -        dest->max_bandwidth = params->max_bandwidth;
> +    /*
> +     * Write to dst but leave existing fields intact (except for has_*
> +     * which will be updated according to their presence in src).
> +     */
> +    v = qobject_input_visitor_new(ret_out);
> +    ok = visit_start_struct(v, NULL, NULL, 0, errp);
> +    if (!ok) {
> +        goto out;
>      }
> -
> -    if (params->has_avail_switchover_bandwidth) {
> -        dest->avail_switchover_bandwidth = params->avail_switchover_bandwidth;
> +    ok = visit_type_MigrationParameters_members(v, dst, errp);
> +    if (!ok) {
> +        goto out;
>      }
> -
> -    if (params->has_downtime_limit) {
> -        dest->downtime_limit = params->downtime_limit;
> +    ok = visit_check_struct(v, errp);
> +    visit_end_struct(v, NULL);
> +    if (!ok) {
> +        goto out;
>      }
>  
> -    if (params->has_x_checkpoint_delay) {
> -        dest->x_checkpoint_delay = params->x_checkpoint_delay;
> -    }
> +out:
> +    visit_free(v);
> +    qobject_unref(ret_out);

IIUC this is essential the trick we used to play before QAPI_CLONE, before
commit a15fcc3cf69e.

https://lore.kernel.org/all/1465490926-28625-15-git-send-email-eblake@redhat.com/

Yes, looks similar..

QAPI_CLONE_MEMBERS() will copy everything, which we do not want here. We
only want to copy where has_* is set.  So it's indeed a sligntly different
request versus the current clone API.

IIUC that can be implemented using a similar qapi clone visitor, however
instead of g_memdup() on the structs/lists first (or in the case of
QAPI_CLONE_MEMBERS, we did *dst=*src), we lazy copy all the fields.

I wished this is a generic API we could use.  I think it means we'll
maintain this ourselves.  Maybe it's OK.

>  
> -    if (params->has_multifd_channels) {
> -        dest->multifd_channels = params->multifd_channels;
> -    }
> -    if (params->has_multifd_compression) {
> -        dest->multifd_compression = params->multifd_compression;
> -    }
> -    if (params->has_multifd_qatzip_level) {
> -        dest->multifd_qatzip_level = params->multifd_qatzip_level;
> -    }
> -    if (params->has_multifd_zlib_level) {
> -        dest->multifd_zlib_level = params->multifd_zlib_level;
> -    }
> -    if (params->has_multifd_zstd_level) {
> -        dest->multifd_zstd_level = params->multifd_zstd_level;
> -    }
> -    if (params->has_xbzrle_cache_size) {
> -        dest->xbzrle_cache_size = params->xbzrle_cache_size;
> -    }
> -    if (params->has_max_postcopy_bandwidth) {
> -        dest->max_postcopy_bandwidth = params->max_postcopy_bandwidth;
> -    }
> -    if (params->has_max_cpu_throttle) {
> -        dest->max_cpu_throttle = params->max_cpu_throttle;
> -    }
> -    if (params->has_announce_initial) {
> -        dest->announce_initial = params->announce_initial;
> -    }
> -    if (params->has_announce_max) {
> -        dest->announce_max = params->announce_max;
> -    }
> -    if (params->has_announce_rounds) {
> -        dest->announce_rounds = params->announce_rounds;
> -    }
> -    if (params->has_announce_step) {
> -        dest->announce_step = params->announce_step;
> -    }
> -
> -    if (params->has_block_bitmap_mapping) {
> -        dest->block_bitmap_mapping = params->block_bitmap_mapping;
> -    }
> -
> -    if (params->has_x_vcpu_dirty_limit_period) {
> -        dest->x_vcpu_dirty_limit_period =
> -            params->x_vcpu_dirty_limit_period;
> -    }
> -    if (params->has_vcpu_dirty_limit) {
> -        dest->vcpu_dirty_limit = params->vcpu_dirty_limit;
> -    }
> -
> -    if (params->has_mode) {
> -        dest->mode = params->mode;
> -    }
> -
> -    if (params->has_zero_page_detection) {
> -        dest->zero_page_detection = params->zero_page_detection;
> -    }
> -
> -    if (params->has_direct_io) {
> -        dest->direct_io = params->direct_io;
> -    }
> +    return ok;
>  }
>  
>  static void migrate_params_apply(MigrationParameters *params)
> @@ -1353,7 +1300,9 @@ static void migrate_params_apply(MigrationParameters *params)
>  
>  void qmp_migrate_set_parameters(MigrationParameters *params, Error **errp)
>  {
> -    MigrationParameters tmp;
> +    MigrationState *s = migrate_get_current();
> +    g_autoptr(MigrationParameters) tmp = QAPI_CLONE(MigrationParameters,
> +                                                    &s->parameters);
>  
>      /*
>       * Convert QTYPE_QNULL and NULL to the empty string (""). Even
> @@ -1367,7 +1316,9 @@ void qmp_migrate_set_parameters(MigrationParameters *params, Error **errp)
>      tls_opt_to_str(&params->tls_hostname);
>      tls_opt_to_str(&params->tls_authz);
>  
> -    migrate_params_test_apply(params, &tmp);
> +    if (!migrate_params_merge(tmp, params, errp)) {
> +        return;
> +    }
>  
>      /*
>       * Mark block_bitmap_mapping as present now while we have the
> @@ -1377,10 +1328,10 @@ void qmp_migrate_set_parameters(MigrationParameters *params, Error **errp)
>          migrate_get_current()->has_block_bitmap_mapping = true;
>      }
>  
> -    if (migrate_params_check(&tmp, errp)) {
> -        migrate_params_apply(&tmp);
> +    if (migrate_params_check(tmp, errp)) {
> +        /* mark all present, so they're all copied */
> +        migrate_mark_all_params_present(tmp);

Ah, I just asked a question in the previous patch on what happens if some
of the fields will be present.  Looks like this line is the answer?

This isn't very obvious.  Maybe some comment in migrate_params_apply()
would slightly help (which mentions it must be used when all parameters are
set)?  Or some way to assert it?

> +        migrate_params_apply(tmp);
>          migrate_post_update_params(params, errp);
>      }
> -
> -    migrate_tls_opts_free(&tmp);
>  }
> -- 
> 2.35.3
> 

-- 
Peter Xu


