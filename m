Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A774D1712B
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2024 19:37:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2yD3-0007Ka-EE; Mon, 21 Oct 2024 15:36:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t2yD1-0007KQ-FM
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 15:36:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t2yCz-0000YL-Jl
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 15:36:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729539411;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hwxpB8V3Gv6KmIaDIq4dlYpo6h6PP464LxV+DTTGiLo=;
 b=cCpTa7/m1FbcIo0D5szyDpThMw7Gjd2BIIC9ikAogoBvBmoMAaJ8HR1wDYJEtEZDosb1Rc
 O/q2E4ypJlXCpZeBuf2XlF+hp+KtXAD6wyM/uQOUCfQIjoUZdLzLTPFOqg4O5ee5mHuEy6
 +YkIQZwzhf54ylKvGar+2B6jnYxJ6Ig=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-554-OskBkHZ3M0CrDKetQiJFlQ-1; Mon, 21 Oct 2024 15:36:49 -0400
X-MC-Unique: OskBkHZ3M0CrDKetQiJFlQ-1
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-7b15a9d4b7cso373746285a.3
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2024 12:36:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729539408; x=1730144208;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hwxpB8V3Gv6KmIaDIq4dlYpo6h6PP464LxV+DTTGiLo=;
 b=N+ROwfOflqV4Y9CNHXrFnIclQ81ve0G6ABUgq26lSpmZeG8sSOfbA4J3RbBrPMTM4K
 0v6kOiez77EfE760MBGtdBIvjjZ1bi7nTMNLn2vy/fxu+O0YW2EooRVDvNn3sU+gYlJE
 OmLr4YfmntAl3q94gGE/S5Gh2CatwoZRQ/gTZ05tcBrqPYgpjOo1D/9bygkJorboTAwV
 zv7EDiXoQMfeYfhSQQUFHZlwaOIhRs8ctruEAp9IlPZW9Zh28b+W1g4gZ3vf7DGbH6Q8
 q0CetVZFFfSLgYVEtxR+FQ9sfwxiLPX9puVR5CBqqloREPlGCKWE73UJeqVpyvm9M4Ol
 GQZw==
X-Gm-Message-State: AOJu0YypWD2Z8wfWleirfRxScY629uK+JDoZ13YGpBRcf0PoAc8I2c9k
 wSp9IVsTCCWgqXfJ4pF+oeyXMrGiFQZWVh4OPdAsnF9H/r/2gyQwZyG1/XuENdrkUwU0LW3/Qdx
 o7uZtY00wYRDbSkBXfdY4Ehx7+lxF3adzM2kMza1k4/lyRE6x017j
X-Received: by 2002:a05:620a:1a91:b0:7b1:3b99:de14 with SMTP id
 af79cd13be357-7b157c077c0mr1433961585a.57.1729539408484; 
 Mon, 21 Oct 2024 12:36:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFyhGlkmsWUvKpT19sW2G0OICUYtNUFM+w0ueMn50qxYTwtTXYrfg87JRsR+HaqFyahzFs0qg==
X-Received: by 2002:a05:620a:1a91:b0:7b1:3b99:de14 with SMTP id
 af79cd13be357-7b157c077c0mr1433959285a.57.1729539408156; 
 Mon, 21 Oct 2024 12:36:48 -0700 (PDT)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b165a710b4sm199925985a.104.2024.10.21.12.36.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Oct 2024 12:36:47 -0700 (PDT)
Date: Mon, 21 Oct 2024 15:36:45 -0400
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
Subject: Re: [RFC V1 14/14] migration: allow commands during precreate and
 preconfig
Message-ID: <ZxatTbs30qouLDO8@x1n>
References: <1729178055-207271-1-git-send-email-steven.sistare@oracle.com>
 <1729178055-207271-15-git-send-email-steven.sistare@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1729178055-207271-15-git-send-email-steven.sistare@oracle.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.421,
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

On Thu, Oct 17, 2024 at 08:14:15AM -0700, Steve Sistare wrote:
> Allow various migration commands during the precreate and preconfig phases
> so migration may be set up and initiated at that time.
> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> ---
>  hmp-commands.hx     |  2 ++
>  qapi/migration.json | 16 +++++++++++-----
>  qapi/misc.json      |  3 ++-
>  3 files changed, 15 insertions(+), 6 deletions(-)
> 
> diff --git a/hmp-commands.hx b/hmp-commands.hx
> index 06746f0..c0f34e9 100644
> --- a/hmp-commands.hx
> +++ b/hmp-commands.hx
> @@ -959,6 +959,7 @@ ERST
>          .params     = "uri",
>          .help       = "Continue an incoming migration from an -incoming defer",
>          .cmd        = hmp_migrate_incoming,
> +        .flags      = "p",
>      },
>  
>  SRST
> @@ -1000,6 +1001,7 @@ ERST
>          .help       = "Enable/Disable the usage of a capability for migration",
>          .cmd        = hmp_migrate_set_capability,
>          .command_completion = migrate_set_capability_completion,
> +        .flags      = "p",
>      },

How about "info migrate_capabilities / migrate_parameters"?

>  
>  SRST
> diff --git a/qapi/migration.json b/qapi/migration.json
> index 3af6aa1..0468c07 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -373,7 +373,8 @@
>  #           }
>  #        }
>  ##
> -{ 'command': 'query-migrate', 'returns': 'MigrationInfo' }
> +{ 'command': 'query-migrate', 'returns': 'MigrationInfo',
> +  'allow-preconfig': true }
>  
>  ##
>  # @MigrationCapability:
> @@ -527,7 +528,8 @@
>  #     <- { "return": {} }
>  ##
>  { 'command': 'migrate-set-capabilities',
> -  'data': { 'capabilities': ['MigrationCapabilityStatus'] } }
> +  'data': { 'capabilities': ['MigrationCapabilityStatus'] },
> +  'allow-preconfig': true }

migrate-set-parameters?

>  
>  ##
>  # @query-migrate-capabilities:
> @@ -551,7 +553,9 @@
>  #           {"state": false, "capability": "x-colo"}
>  #        ]}
>  ##
> -{ 'command': 'query-migrate-capabilities', 'returns':   ['MigrationCapabilityStatus']}
> +{ 'command': 'query-migrate-capabilities',
> +  'returns':   ['MigrationCapabilityStatus'],
> +  'allow-preconfig': true }
>  
>  ##
>  # @MultiFDCompression:
> @@ -1297,7 +1301,8 @@
>  #        }
>  ##
>  { 'command': 'query-migrate-parameters',
> -  'returns': 'MigrationParameters' }
> +  'returns': 'MigrationParameters',
> +  'allow-preconfig': true }
>  
>  ##
>  # @migrate-start-postcopy:
> @@ -1751,7 +1756,8 @@
>  { 'command': 'migrate-incoming',
>               'data': {'*uri': 'str',
>                        '*channels': [ 'MigrationChannel' ],
> -                      '*exit-on-error': 'bool' } }
> +                      '*exit-on-error': 'bool' },
> +  'allow-preconfig': true }
>  
>  ##
>  # @xen-save-devices-state:
> diff --git a/qapi/misc.json b/qapi/misc.json
> index 559b66f..ce60493 100644
> --- a/qapi/misc.json
> +++ b/qapi/misc.json
> @@ -241,7 +241,8 @@
>  { 'command': 'human-monitor-command',
>    'data': {'command-line': 'str', '*cpu-index': 'int'},
>    'returns': 'str',
> -  'features': [ 'savevm-monitor-nodes' ] }
> +  'features': [ 'savevm-monitor-nodes' ],
> +  'allow-preconfig': true }
>  
>  ##
>  # @getfd:
> -- 
> 1.8.3.1
> 

-- 
Peter Xu


