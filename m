Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C594ECD9A0
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 20:20:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vo5pP-0006Jh-KX; Thu, 05 Feb 2026 15:19:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vo5pN-0006Id-P2
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 15:19:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vo5pM-0006nN-09
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 15:19:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770322787;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=c1bvz1EH0fEsHty+NynpcXolWxZwKd5+1RT6pMMNjns=;
 b=Chv8QcDWHARNQWmO+5kV02PogZL21lfaT8Ru7SgwKzSU9lOw6an91hF1il41bITiTXxvaS
 JSKTJhcOdE2qu6OW6LvlWftWxoYjFB5HQV7eHeaQGfvemgXjrlsod8bSt/fsycPYL9U4oa
 frT0v/ru37Hu+yIzd51ek7jV+j12WNU=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-582-wGHgev5UOvGEgLdf-6SBVg-1; Thu, 05 Feb 2026 15:19:45 -0500
X-MC-Unique: wGHgev5UOvGEgLdf-6SBVg-1
X-Mimecast-MFC-AGG-ID: wGHgev5UOvGEgLdf-6SBVg_1770322785
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-501473ee94fso74384721cf.3
 for <qemu-devel@nongnu.org>; Thu, 05 Feb 2026 12:19:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770322785; x=1770927585; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=c1bvz1EH0fEsHty+NynpcXolWxZwKd5+1RT6pMMNjns=;
 b=TtCsrWDuPT4xR3yAJGHfKxP/+9tDAHDe/hQzLW/m17eayPxgc4GlLr6w2wl9YuZJ0u
 jAf8yxjF6AqwkMAl2DGxQMZIFaDXdcQnx2SnACNA8RfexGk4denAHbVdlYQfxOAqiH2b
 9AHoeXq5HPXsuRrmslCH2ABIeY6/aX5BGtvyYViCsqRYSePM1tgyP1tOy6aeznE1cjna
 yj1xVeqQcfHbk1xGX+j6FPMhRf3BFfZUOW0njCbYEsykA+oNCQAXWbgEZ1S3rYgFup6L
 Ucsuk8r5ZSDhcj4Nhao1tFpt26Q8mejwVHOmLbVBaS2jCORvMKgrNuQQIAmeMnggPcv4
 SdKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770322785; x=1770927585;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=c1bvz1EH0fEsHty+NynpcXolWxZwKd5+1RT6pMMNjns=;
 b=jDEpn6gmcoOipXotbMcMMVTLmcHhNPzkqXHfzDC7O4poXQsd9ThGiYDVGiZ3n5Bbm3
 mUYEyLs6NUna/+rmIgSjUzde/yGqkhGFiiMnp0C73b/tSUsqFRWPSZSzI+iscdtueybW
 kc/liPAZmt4lRwZHH82im0W4dX32FJT5a9wGjkifTSp44/MHwJ8/qf14yAurA+3pclDE
 JAjKFGZe+TLeYrWqWYJAp+838GPySG0mmyptM494yQOzrEWDP3Zoa+/53MtiDDTkBBbm
 6f61FTAqYamr9Ls8ZGvDe8nocPDTosZw6cRp7Vyt/+lyXuJiezbXaHj23wnVI8ODn0AD
 OaOQ==
X-Gm-Message-State: AOJu0Yxrrty7E/n3yRmMm28zd+amu6BK7Tc56xPAAQo8gUXvr3yD55iu
 9AVqIf4qpBYP6cXbZYFwU1wPw/Pkj+Xef88YK3VoJAywPdVMPis0SJkTLEwtwkCSRf6h0o+gqhu
 QwjrPLzTaMBClx5V4fm3kz40bg+yDM4DHk7MlrO5w9jfZF5Ao2b803wL5
X-Gm-Gg: AZuq6aLzEyTRzMOuN9aMFMXRnXEigssRz/Jhn0P7iK9jOJNPCT7KqHmzpjC0VDo2yP+
 cOmtYcby2ccSsg8ix9WpCtrx6/HW2lfgLTKBakJOCF7yeZ8EAjKbHRKiGRYpDCOrIR2F1v0LS2W
 YN0Xryx0kOGvt2h70EEuh7bR7dbjlD9tYvdprkfirhMKNZ1FXsj9P0drClsURtFgCeuMZPU7dKO
 Qb6KcXd+MyCNCbz2lc0xXiGmAoz9Cax6FB/7XXhEGotI908fZt7e7BxYlVW3oYVCOSCseNViT23
 e0hl6ShABuaxk1d4dx91IxubEo+g1JUjHwO+Jltx2P4+PcM6AM/ldeyMC1x8sFhI90UJXJ87JZU
 4+AQ=
X-Received: by 2002:ac8:5807:0:b0:4f1:83e3:c058 with SMTP id
 d75a77b69052e-506398a21aamr5467021cf.30.1770322785258; 
 Thu, 05 Feb 2026 12:19:45 -0800 (PST)
X-Received: by 2002:ac8:5807:0:b0:4f1:83e3:c058 with SMTP id
 d75a77b69052e-506398a21aamr5466581cf.30.1770322784730; 
 Thu, 05 Feb 2026 12:19:44 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8953c03fc95sm3130776d6.26.2026.02.05.12.19.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Feb 2026 12:19:44 -0800 (PST)
Date: Thu, 5 Feb 2026 15:19:43 -0500
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, armbru@redhat.com, ppandit@redhat.com
Subject: Re: [PATCH v2 2/9] migration: Use QAPI_CLONE_MEMBERS in
 migrate_params_test_apply
Message-ID: <aYT7X3db3-X3fgnT@x1.local>
References: <20260202224101.20568-1-farosas@suse.de>
 <20260202224101.20568-3-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260202224101.20568-3-farosas@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Mon, Feb 02, 2026 at 07:40:54PM -0300, Fabiano Rosas wrote:
> Use QAPI_CLONE_MEMBERS instead of making an assignment. The QAPI
> method makes the handling of the TLS strings more intuitive because it
> clones them as well.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>  migration/options.c | 26 ++++++++++++--------------
>  1 file changed, 12 insertions(+), 14 deletions(-)
> 
> diff --git a/migration/options.c b/migration/options.c
> index dcd5e07504..4161648268 100644
> --- a/migration/options.c
> +++ b/migration/options.c
> @@ -1264,9 +1264,9 @@ bool migrate_params_check(MigrationParameters *params, Error **errp)
>  static void migrate_params_test_apply(MigrationParameters *params,
>                                        MigrationParameters *dest)
>  {
> -    *dest = migrate_get_current()->parameters;
> +    MigrationState *s = migrate_get_current();
>  
> -    /* TODO use QAPI_CLONE() instead of duplicating it inline */
> +    QAPI_CLONE_MEMBERS(MigrationParameters, dest, &s->parameters);
>  
>      if (params->has_throttle_trigger_threshold) {
>          dest->throttle_trigger_threshold = params->throttle_trigger_threshold;
> @@ -1285,24 +1285,18 @@ static void migrate_params_test_apply(MigrationParameters *params,
>      }
>  
>      if (params->tls_creds) {
> +        qapi_free_StrOrNull(dest->tls_creds);
>          dest->tls_creds = QAPI_CLONE(StrOrNull, params->tls_creds);
> -    } else {
> -        /* clear the reference, it's owned by s->parameters */
> -        dest->tls_creds = NULL;
>      }
>  
>      if (params->tls_hostname) {
> +        qapi_free_StrOrNull(dest->tls_hostname);
>          dest->tls_hostname = QAPI_CLONE(StrOrNull, params->tls_hostname);
> -    } else {
> -        /* clear the reference, it's owned by s->parameters */
> -        dest->tls_hostname = NULL;
>      }
>  
>      if (params->tls_authz) {
> +        qapi_free_StrOrNull(dest->tls_authz);
>          dest->tls_authz = QAPI_CLONE(StrOrNull, params->tls_authz);
> -    } else {
> -        /* clear the reference, it's owned by s->parameters */
> -        dest->tls_authz = NULL;
>      }
>  
>      if (params->has_max_bandwidth) {
> @@ -1359,8 +1353,9 @@ static void migrate_params_test_apply(MigrationParameters *params,
>      }
>  
>      if (params->has_block_bitmap_mapping) {
> -        dest->has_block_bitmap_mapping = true;

Changing this line seems all fine, IIUC it's because migrate_params_check()
always checks block_bitmap_mapping directly ignoring the has_* here,
meanwhile if check passed, migrate_params_apply() will read the has_* but
only read the one in params.

I wonder if we want to split a separate patch removing this line only, or
maybe add a comment into commit log for this change (can be done when merge
too if this is the only change).

The change itself looks good:

Reviewed-by: Peter Xu <peterx@redhat.com>

> -        dest->block_bitmap_mapping = params->block_bitmap_mapping;
> +        qapi_free_BitmapMigrationNodeAliasList(dest->block_bitmap_mapping);
> +        dest->block_bitmap_mapping = QAPI_CLONE(BitmapMigrationNodeAliasList,
> +                                                params->block_bitmap_mapping);
>      }
>  
>      if (params->has_x_vcpu_dirty_limit_period) {
> @@ -1384,7 +1379,8 @@ static void migrate_params_test_apply(MigrationParameters *params,
>      }
>  
>      if (params->has_cpr_exec_command) {
> -        dest->cpr_exec_command = params->cpr_exec_command;
> +        qapi_free_strList(dest->cpr_exec_command);
> +        dest->cpr_exec_command = QAPI_CLONE(strList, params->cpr_exec_command);
>      }
>  }
>  
> @@ -1540,4 +1536,6 @@ void qmp_migrate_set_parameters(MigrationParameters *params, Error **errp)
>      }
>  
>      migrate_tls_opts_free(&tmp);
> +    qapi_free_BitmapMigrationNodeAliasList(tmp.block_bitmap_mapping);
> +    qapi_free_strList(tmp.cpr_exec_command);
>  }
> -- 
> 2.51.0
> 

-- 
Peter Xu


