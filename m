Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFA94C61DD3
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 18:22:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2C3p-0005r0-1E; Thu, 03 Sep 2026 14:21:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1x2C3n-0005qr-Hy
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 14:21:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1x2C3k-0005LO-PC
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 14:21:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788459670;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IOYeTd5sOwkUmSVds7dgcG3nD9DOZbYF5GOvSdLRcGQ=;
 b=WuDG6AJO4ohcRw2wSI8wE35BlAneljERbRTYGYalPKPF822gt8y01zRdlBSBW1HyYaM/ja
 8m1QKa3uQhr6dmDjsyyzMn33JKG9H1VTcbtXVByIw9ugPQMz3vcvZjhEIJ842SIDQqTHrF
 HDUefI+V0IOZq4FMnoWOWlZ42ip84nY=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-348-Vayqh5uhMBmoHxiJTK_DtQ-1; Thu, 03 Sep 2026 14:21:08 -0400
X-MC-Unique: Vayqh5uhMBmoHxiJTK_DtQ-1
X-Mimecast-MFC-AGG-ID: Vayqh5uhMBmoHxiJTK_DtQ_1788459668
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-910342dc2cfso2160016d6.2
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 11:21:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1788459668; x=1789064468; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=IOYeTd5sOwkUmSVds7dgcG3nD9DOZbYF5GOvSdLRcGQ=;
 b=sKLxEEZUA8Gd0ZVxeX0LiFNXcgtS6yV/3FUbCUaCq5cwJjEuHjTCDLg/AvFfzpcKCl
 OW0ppL73nGUSmpNEK0NMXq2971YDkrPK2FED9YaEsRbiz/Bm5tC2CraXwiFf79ARZU6b
 Aey+e3E25901sAiVknxGMxw4pYaV9QP9PvqwuMUaZJ9yLfmXqzci3asZVUMcG+6DgwP2
 3yhC2BWH0rXwSdupIxJPC/EOI856o3/Vr8F7rdQ0HJuNM1cc9orsw+U+L0872CTQb4cN
 +plP/pVsZg5nfA6EwFjvdYtYQrbt+s3fPr+iext56JoCMIElFBSPekEL1e5P9mVXIami
 KLGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788459668; x=1789064468;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=IOYeTd5sOwkUmSVds7dgcG3nD9DOZbYF5GOvSdLRcGQ=;
 b=L3u+3HtG0KHhNrK2ZTdyR0lTO2vGRLsBeunjMkY6VUTIthP+NWH7o/5LIDzAtd9S2j
 uGVvh7gK/uV7vfKdtrg7SAftBvZ4+dg7SDnx5pwYxTnkoaCE322Hn+KtZjsO/9t2zGli
 lNREFBE24c+/fnaWPn8PnVMaaSbom1Av2pB3ND03DaJ/+q5LFXWVNSg6Ln7V5AlI46Bn
 aMGwrKPc/r81oEHMQTPVoGjA3fN37yfaRulZunWdARuYkMeXjapdYEJbXGX4jDq+BSSu
 a+7ZZHD3CcTEB7nPndG28n3KUOul0MxHWhgoEHEUyM8F7JIAN5+HxVQ/YK6oL3xZJurK
 yH/A==
X-Gm-Message-State: AFuF++nvgur9Q5sZAJaGBllcxvHDniLSXIAD2LlU9tBPFPON+dsm4l1r
 bwnh04+PVk5c14plrwn/9lwrEUbIzABoiJ7Dbp5X9FYWVg18I3AC8GVHmxJ7k8pg31kcIKMWT6l
 dKOhiesQ8rkMVxnw6Xmr+DvcvSZTqCZ0ckWLOCTPyOPkzlhvNIZOTSm3c
X-Gm-Gg: AYBFou3dWspEsOKBbLuXM/g1qfX4Uhkph0XViOW/0vq1IcihiKmfFxqBjYsAZXtS6AV
 k5GDoon6EhE33YuIQBmhtd19Rx5aeyg5/hRbceTDLav2ahdepuejf5LbunTX9T8hL2NXu+Jqr9N
 8K7Oh3GrUPXTXOQGFqkVpcMlvOQJOOrzG+Zr817KVj2atCaYiR7Q6nN/gX+929ineujabQXe19+
 KdkSRfOOsrU4s0tBt9DJao9r3xDAbeq52cBOpDVoxNuAuqUdveNY6HZhe1MZxzEhmyc4vG3vb08
 bOA2vvokTwuHp7nx4rpOQuz2p0eqcqzoIySYG9RmKjZ2axqcSLsCbT0hJLKaorRWFIGx
X-Received: by 2002:a05:622a:310:b0:530:596:f70d with SMTP id
 d75a77b69052e-530549a3497mr7285791cf.34.1788459667962; 
 Thu, 03 Sep 2026 11:21:07 -0700 (PDT)
X-Received: by 2002:a05:622a:310:b0:530:596:f70d with SMTP id
 d75a77b69052e-530549a3497mr7284971cf.34.1788459667294; 
 Thu, 03 Sep 2026 11:21:07 -0700 (PDT)
Received: from localhost ([174.91.117.74]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-53054116466sm2721401cf.6.2026.09.03.11.21.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 11:21:06 -0700 (PDT)
Date: Thu, 3 Sep 2026 14:20:55 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH 05/18] migration: Merge parameter structs instead of
 assigning one by one
Message-ID: <apm6h1ueJOL5zHyD@x1.local>
References: <20260902221547.1812481-1-farosas@suse.de>
 <20260902221547.1812481-6-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260902221547.1812481-6-farosas@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, Sep 02, 2026 at 07:15:33PM -0300, Fabiano Rosas wrote:
> Convert the code in migrate_params_test_apply() from an open-coded
> copy of every migration parameter to a merge operation using QAPI
> visitors and QDict.
> 
> The purpose of that routine is to update a temporary structure
> (pre-populated with the current migration parameters), with the values
> received from the user via QAPI. As a result, the temporary structure
> will then contain the "to be applied" parameters and it's validated
> before being used to overwrite the parameters currently in use.
> 
> The update is currently done as follows:
> 
> where 'params' is the user input from QAPI,
> for each parameter:
> 
>   a) check if the option is present
>      params->has_<name> == true
>      params-><name> != NULL // for strings
> 
>   b) if the parameter is a pointer, free the to-be-assigned member and
>      allocate memory for the copy from params
> 
>   c) assign the user provided value to the temporary structure.
> 
> Step (a) is the same in principle as what the QAPI visitors do at
> visit_type_MigrationParameters_members().
> 
> Steps (b) and (c) are roughly the same as what the QDict
> implementation does when qdict_del() and qdict_put_obj() are combined.
> 
> Therefore, replace the open-coded function with
> migrate_params_merge(), which achieves the same goal, but uses
> visitors and QDict. This hides the details of QAPI (has_*) from the
> migration code and avoids the need to update
> migrate_params_test_apply() every time a new migration parameter is
> added.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Nice,

Reviewed-by: Peter Xu <peterx@redhat.com>

Nitpicks only, inline,

> ---
>  migration/options.c | 201 +++++++++++++++-----------------------------
>  1 file changed, 66 insertions(+), 135 deletions(-)
> 
> diff --git a/migration/options.c b/migration/options.c
> index 6b787950808..de091d2eee3 100644
> --- a/migration/options.c
> +++ b/migration/options.c
> @@ -20,6 +20,9 @@
>  #include "qapi/qapi-commands-migration.h"
>  #include "qapi/qapi-visit-migration.h"
>  #include "qapi/qmp/qerror.h"
> +#include "qapi/qobject-input-visitor.h"
> +#include "qapi/qobject-output-visitor.h"
> +#include "qobject/qdict.h"
>  #include "qobject/qnull.h"
>  #include "system/runstate.h"
>  #include "migration/colo.h"
> @@ -1074,6 +1077,28 @@ static void tls_opt_to_str(StrOrNull *opt)
>      opt->u.s = g_strdup("");
>  }
>  
> +static QDict *migrate_params_to_dict(MigrationParameters *p, Error **errp)
> +{
> +    QObject *obj = NULL;
> +    Visitor *v = qobject_output_visitor_new(&obj);
> +
> +    if (visit_type_MigrationParameters(v, NULL, &p, errp)) {
> +        visit_complete(v, &obj);
> +    }
> +    visit_free(v);
> +    return qobject_to(QDict, obj);
> +}
> +
> +static MigrationParameters *migrate_params_from_dict(QDict *d, Error **errp)
> +{
> +    Visitor *v = qobject_input_visitor_new(QOBJECT(d));
> +    MigrationParameters *tmp = NULL;
> +
> +    visit_type_MigrationParameters(v, NULL, &tmp, errp);
> +    visit_free(v);
> +    return tmp;
> +}
> +
>  /*
>   * query-migrate-parameters expects all members of MigrationParameters
>   * to be present, but we cannot mark them non-optional in QAPI because
> @@ -1166,6 +1191,39 @@ static void migrate_post_update_params(MigrationParameters *new, Error **errp)
>      }
>  }
>  
> +static bool migrate_params_merge(MigrationParameters *in1,
> +                                 MigrationParameters *in2,

Perhaps rename in1/in2/d1/d2 similarly with "cur" / "new" / ..?  As in1 and
in2 are not equal: when merge it only overwrites in1 with in2, not vice
versa.

> +                                 MigrationParameters **out,
> +                                 Error **errp)
> +{
> +    g_autoptr(QDict) d1 = NULL;
> +    g_autoptr(QDict) d2 = NULL;
> +    const QDictEntry *e;
> +
> +    d1 = migrate_params_to_dict(in1, errp);
> +    if (!d1) {
> +        return false;
> +    }
> +
> +    d2 = migrate_params_to_dict(in2, errp);
> +    if (!d2) {
> +        return false;
> +    }
> +
> +    for (e = qdict_first(d2); e; e = qdict_next(d2, e)) {
> +        const char *key = qdict_entry_key(e);
> +        QObject *value = qdict_entry_value(e);
> +
> +        qdict_del(d1, key);

IIUC this line can be dropped due to a smart enough qdict_put_obj().

> +        qobject_ref(value);
> +        qdict_put_obj(d1, key, value);
> +    }
> +
> +    *out = migrate_params_from_dict(d1, errp);
> +
> +    return !!*out;
> +}
> +
>  /*
>   * Check whether the parameters are valid. Error will be put into errp
>   * (if provided). Return true if valid, otherwise false.
> @@ -1328,133 +1386,6 @@ bool migrate_params_check(MigrationParameters *params, Error **errp)
>      return true;
>  }
>  
> -static void migrate_params_test_apply(MigrationParameters *params,
> -                                      MigrationParameters *dest)
> -{
> -    MigrationState *s = migrate_get_current();
> -
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
> -    }
> -
> -    if (params->has_cpu_throttle_tailslow) {
> -        dest->cpu_throttle_tailslow = params->cpu_throttle_tailslow;
> -    }
> -
> -    if (params->tls_creds) {
> -        qapi_free_StrOrNull(dest->tls_creds);
> -        dest->tls_creds = QAPI_CLONE(StrOrNull, params->tls_creds);
> -    }
> -
> -    if (params->tls_hostname) {
> -        qapi_free_StrOrNull(dest->tls_hostname);
> -        dest->tls_hostname = QAPI_CLONE(StrOrNull, params->tls_hostname);
> -    }
> -
> -    if (params->tls_authz) {
> -        qapi_free_StrOrNull(dest->tls_authz);
> -        dest->tls_authz = QAPI_CLONE(StrOrNull, params->tls_authz);
> -    }
> -
> -    if (params->has_max_bandwidth) {
> -        dest->max_bandwidth = params->max_bandwidth;
> -    }
> -
> -    if (params->has_avail_switchover_bandwidth) {
> -        dest->avail_switchover_bandwidth = params->avail_switchover_bandwidth;
> -    }
> -
> -    if (params->has_downtime_limit) {
> -        dest->downtime_limit = params->downtime_limit;
> -    }
> -
> -    if (params->has_x_checkpoint_delay) {
> -        dest->x_checkpoint_delay = params->x_checkpoint_delay;
> -    }
> -
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
> -        qapi_free_BitmapMigrationNodeAliasList(dest->block_bitmap_mapping);
> -        dest->block_bitmap_mapping = QAPI_CLONE(BitmapMigrationNodeAliasList,
> -                                                params->block_bitmap_mapping);
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
> -
> -    if (params->has_x_rdma_chunk_size) {
> -        dest->x_rdma_chunk_size = params->x_rdma_chunk_size;
> -    }
> -
> -    if (params->has_cpr_exec_command) {
> -        qapi_free_strList(dest->cpr_exec_command);
> -        dest->cpr_exec_command = QAPI_CLONE(strList, params->cpr_exec_command);
> -    }
> -}
> -
>  /*
>   * Caller must ensure the has_* fields of @params are true so they all
>   * get copied and the pointer members don't dangle.
> @@ -1472,7 +1403,8 @@ static void migrate_params_apply(MigrationParameters *params)
>  
>  void qmp_migrate_set_parameters(MigrationParameters *input, Error **errp)
>  {
> -    MigrationParameters new;
> +    MigrationParameters *cur = &migrate_get_current()->parameters;
> +    g_autoptr(MigrationParameters) new = NULL;
>  
>      /*
>       * Convert QTYPE_QNULL and NULL to the empty string (""). Even
> @@ -1486,14 +1418,13 @@ void qmp_migrate_set_parameters(MigrationParameters *input, Error **errp)
>      tls_opt_to_str(input->tls_hostname);
>      tls_opt_to_str(input->tls_authz);
>  
> -    migrate_params_test_apply(input, &new);
> +    /* merge input on top of current */
> +    if (!migrate_params_merge(cur, input, &new, errp)) {
> +        return;
> +    }
>  
> -    if (migrate_params_check(&new, errp)) {
> -        migrate_params_apply(&new);
> +    if (migrate_params_check(new, errp)) {
> +        migrate_params_apply(new);
>          migrate_post_update_params(input, errp);
>      }
> -
> -    migrate_tls_opts_free(&new);
> -    qapi_free_BitmapMigrationNodeAliasList(new.block_bitmap_mapping);
> -    qapi_free_strList(new.cpr_exec_command);
>  }
> -- 
> 2.53.0
> 

-- 
Peter Xu


