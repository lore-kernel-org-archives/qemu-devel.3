Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 059CCC25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 07:05:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s78hF-000383-BG; Wed, 15 May 2024 03:05:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eauger@redhat.com>) id 1s78hA-00037V-Es
 for qemu-devel@nongnu.org; Wed, 15 May 2024 03:05:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eauger@redhat.com>) id 1s78h6-0004Rn-C4
 for qemu-devel@nongnu.org; Wed, 15 May 2024 03:04:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715756695;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hdDGUoAQsJClhYt/c3iAajgAXRqIlx6dH5HXnZzfYvw=;
 b=AQBSAoHBDADRUF/xKEkdSCrodfIHYAMumcYEh/ySrs1oWNxUaSLa6HyKYyaOTq/QAs/9tC
 OqIEi7Yvr4RFsOAZoEgkY/2MT5/rwmjySljJSc14BylUOvzXIwjNrwqgwDmFFRk3gT1JBi
 j1Wtl6e7ilBy98DhrWRdzEW9qW4vE8c=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-310-NxubbcU9NTG-ARnYQuAk6A-1; Wed, 15 May 2024 03:04:51 -0400
X-MC-Unique: NxubbcU9NTG-ARnYQuAk6A-1
Received: by mail-oi1-f197.google.com with SMTP id
 5614622812f47-3c9aa22159aso3020102b6e.0
 for <qemu-devel@nongnu.org>; Wed, 15 May 2024 00:04:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715756691; x=1716361491;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hdDGUoAQsJClhYt/c3iAajgAXRqIlx6dH5HXnZzfYvw=;
 b=H6dePRuJ2iHrYjTwqmsrsC+xXFgMU4JZRwmdq2fiJ8WwlD/DTL01uV0rfDQxD2CaXD
 /vBUVosb47W+SueEV1rNUrgBjD3CQTWujY1bqsEgCmdO/C4QBhPOR4/jDZTYcfhx0T3m
 tf4KEZG/yOJ8v3iqsdZ83w16+1gVvPQJnVqz6VcobjODTKDo0ntcXrZX+ijV3Adk827g
 V591Ty8HpetSCPqWj5onuXfitVzS4srEd8zAVDbkX0mn7yqJAEdVrUq/mHV86NzG6zEq
 TeKZax0T7f/tu3TpIyCGTTVSObgO8lPZD3ynQUIvcUQc2hWe/M/yfnrgtWeGTz14QQXY
 /8pw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUsCwpfX20BiCbAlg6GLm6RCzjuwVoCduEcmn8jhLwQdcFmsNTo4+19dtsIxlvMWzK1p+2k4vSyS2HgI637y8kz0zG1sh0=
X-Gm-Message-State: AOJu0Yz0GCun1cC3YZ1p0ZZsdvXoApCYH2miwYSl1vWwr7y0mIYQNmDU
 l/EwYSbT4U+RuEVeu235rfR4qsfuX93WF7Bsc0CuRrUcjp+sHKhlI6RTx5gXwns3MIfz5vo6GE7
 jage9npxZSio1RZvfAYNLlr/HNu/KlY1L1hLd7mzWqdBrVMKbWDn7
X-Received: by 2002:a05:6808:51:b0:3c9:6e6a:d5f2 with SMTP id
 5614622812f47-3c9971f0451mr13684301b6e.57.1715756690966; 
 Wed, 15 May 2024 00:04:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHNHeAGbV1NLISXEIkPDOwqymuI6FQevjUx6HfWZEQWOr2et06ifQ7mf96iyCl8vTrgY6EeYQ==
X-Received: by 2002:a05:6808:51:b0:3c9:6e6a:d5f2 with SMTP id
 5614622812f47-3c9971f0451mr13684284b6e.57.1715756690607; 
 Wed, 15 May 2024 00:04:50 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-792bf2fe9f0sm651128085a.90.2024.05.15.00.04.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 May 2024 00:04:50 -0700 (PDT)
Message-ID: <7d4c47ef-f312-4735-ab8b-1bbc841ed3a4@redhat.com>
Date: Wed, 15 May 2024 09:04:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/9] migration: Extend migration_file_set_error() with
 Error* argument
Content-Language: en-US
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Markus Armbruster <armbru@redhat.com>
References: <20240514153130.394307-1-clg@redhat.com>
 <20240514153130.394307-4-clg@redhat.com>
From: Eric Auger <eauger@redhat.com>
In-Reply-To: <20240514153130.394307-4-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eauger@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.974,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Hi Cédric,

On 5/14/24 17:31, Cédric Le Goater wrote:
> Use it to update the current error of the migration stream if
> available and if not, simply print out the error. Next changes will
> update with an error to report.
> 
> Reviewed-by: Avihai Horon <avihaih@nvidia.com>
> Acked-by: Fabiano Rosas <farosas@suse.de>
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> ---
> 
>  Changes in v6:
> 
>  - Commit log improvements (Avihai)
>  
>  include/migration/misc.h | 2 +-
>  hw/vfio/common.c         | 2 +-
>  hw/vfio/migration.c      | 4 ++--
>  migration/migration.c    | 6 ++++--
>  4 files changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/include/migration/misc.h b/include/migration/misc.h
> index bf7339cc1e6430226127fb6a878d06b458170858..bfadc5613bac614a316e5aed7da95d8c7845cf42 100644
> --- a/include/migration/misc.h
> +++ b/include/migration/misc.h
> @@ -97,7 +97,7 @@ void migration_add_notifier_mode(NotifierWithReturn *notify,
>  
>  void migration_remove_notifier(NotifierWithReturn *notify);
>  bool migration_is_running(void);
> -void migration_file_set_error(int err);
> +void migration_file_set_error(int ret, Error *err);
>  
>  /* True if incoming migration entered POSTCOPY_INCOMING_DISCARD */
>  bool migration_in_incoming_postcopy(void);
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index b5102f54a6474a50c6366e8fbce23812d55e384e..ed5ee6349ced78b3bde68d2ee506f78ba1a9dd9c 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -150,7 +150,7 @@ bool vfio_viommu_preset(VFIODevice *vbasedev)
>  static void vfio_set_migration_error(int err)
nit: I would have renamed err into ret here to avoid any further confusion.
>  {
>      if (migration_is_setup_or_active()) {
> -        migration_file_set_error(err);
> +        migration_file_set_error(err, NULL);
>      }
>  }
>  
> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
> index 06ae40969b6c19037e190008e14f28be646278cd..bf2fd0759ba6e4fb103cc5c1a43edb180a3d0de4 100644
> --- a/hw/vfio/migration.c
> +++ b/hw/vfio/migration.c
> @@ -726,7 +726,7 @@ static void vfio_vmstate_change_prepare(void *opaque, bool running,
>           * Migration should be aborted in this case, but vm_state_notify()
>           * currently does not support reporting failures.
>           */
> -        migration_file_set_error(ret);
> +        migration_file_set_error(ret, NULL);
>      }
>  
>      trace_vfio_vmstate_change_prepare(vbasedev->name, running,
> @@ -756,7 +756,7 @@ static void vfio_vmstate_change(void *opaque, bool running, RunState state)
>           * Migration should be aborted in this case, but vm_state_notify()
>           * currently does not support reporting failures.
>           */
> -        migration_file_set_error(ret);
> +        migration_file_set_error(ret, NULL);
>      }
>  
>      trace_vfio_vmstate_change(vbasedev->name, running, RunState_str(state),
> diff --git a/migration/migration.c b/migration/migration.c
> index e88b24f1e6cbe82dad3f890c00e264d2ab6ad355..70d66a441bf04761decf91dbe57ce52c57fde58f 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -2994,13 +2994,15 @@ static MigThrError postcopy_pause(MigrationState *s)
>      }
>  }
>  
> -void migration_file_set_error(int err)
> +void migration_file_set_error(int ret, Error *err)
>  {
>      MigrationState *s = current_migration;
>  
>      WITH_QEMU_LOCK_GUARD(&s->qemu_file_lock) {
>          if (s->to_dst_file) {
> -            qemu_file_set_error(s->to_dst_file, err);
> +            qemu_file_set_error_obj(s->to_dst_file, ret, err);
> +        } else if (err) {
> +            error_report_err(err);
>          }
>      }
>  }
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric


