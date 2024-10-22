Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9786CD1CDA0
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 06:19:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t38EU-0002Ks-LH; Tue, 22 Oct 2024 02:19:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1t38ET-0002KO-EO
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 02:19:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1t38ER-0002Gn-9e
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 02:19:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729577940;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BuWcZ3n09y9C6DzxjBmjyO4STg+7ChC2ZlDcQCn3tuw=;
 b=APXCYUSAjJr2vZ4Nv3/gqJjqnhdoYixLiIOskOhi3QXhCvyAoMvHT4m9T1npnpkcmEsXHP
 uWo4+bxJvzDldoVNRC0IqKesA41dbU9UmNph1mgmL7Jey/kP850L3Hr0qSQnY+SgaKSOmc
 pADuNCBSft4mqDJk3CYluSen1MbrCsU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-657-KNuDmRCiMH2RsW5aPZVynw-1; Tue, 22 Oct 2024 02:18:58 -0400
X-MC-Unique: KNuDmRCiMH2RsW5aPZVynw-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-43152cd2843so39110645e9.3
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2024 23:18:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729577937; x=1730182737;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BuWcZ3n09y9C6DzxjBmjyO4STg+7ChC2ZlDcQCn3tuw=;
 b=Be0A41ip0iBWzwOm3fARz/7cjy1B6oPqw33XxMB6fC7GPY0WkfrZxtAoL+poeXmKqB
 ha6SoGqZvHhyLd6NF3v3c5/yxy6mvNsFJPN0kUaUDsgcqlP2hxpmlIYLCT/4Rhqv2s2Q
 cBYbTXvGhvsH5EHulqaIINXpQl72cudkotHwT0OhmofsBkwKBaH0nOCJl0rdTtqU8kij
 naVzUvPPnh0F9TM59HNJn2ESKaSWPJOyBFur6GFYAd8m6a6kyGC436mRJ+Fxw7TnCsJD
 oxFNaBn7xRyywVZdelqaoOH+A8e8XUD3dGOPZ9u2k0oReTgJoElWmmpkxtOcasBUIz76
 SZNA==
X-Gm-Message-State: AOJu0YxvwxRsJnqV2AxyRuHtURLPqqBMGYIJm4nb2DSvRWpbTBgUOSDE
 AN86O/i2n7EW0aGokzi1jGtMdes3Ce14JwyitqydVmKqyi2MKWn/VCary/KwVRJDIxTCxZ7z1sn
 /YudqV191RgKfHNlYAh4OnaE6PTTxxlago1YLM3mBlvnv0hpvWrQ//GZcUVSS9fE/El0qGST8L0
 IeM6qtOx2x8sMce0TN1D9eRDBA3C8=
X-Received: by 2002:a05:600c:4ed3:b0:42f:8287:c24d with SMTP id
 5b1f17b1804b1-4317b8edf96mr20234825e9.21.1729577937180; 
 Mon, 21 Oct 2024 23:18:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGq3ZVrfLLiM8eJYJiphVKIfNwuoJtCjWXMWW3c+F62YMuueEoQM7D1yLP0/pgPHIC9LM+RRDdQl/mdR3cFiFA=
X-Received: by 2002:a05:600c:4ed3:b0:42f:8287:c24d with SMTP id
 5b1f17b1804b1-4317b8edf96mr20234625e9.21.1729577936760; Mon, 21 Oct 2024
 23:18:56 -0700 (PDT)
MIME-Version: 1.0
References: <20241021215220.982325-1-peterx@redhat.com>
In-Reply-To: <20241021215220.982325-1-peterx@redhat.com>
From: Prasad Pandit <ppandit@redhat.com>
Date: Tue, 22 Oct 2024 11:48:40 +0530
Message-ID: <CAE8KmOzV676+zxwihtWASimTAEMtR1-JCh=5c8ayQCazKw8VWg@mail.gmail.com>
Subject: Re: [PATCH] migration: Deprecate query-migrationthreads command
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, "Dr . David Alan Gilbert" <dave@treblig.org>, 
 Juraj Marcin <jmarcin@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, Julia Suvorova <jusual@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.421,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.699,
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

On Tue, 22 Oct 2024 at 03:22, Peter Xu <peterx@redhat.com> wrote:
> To summarize, the major reason of the deprecation is due to no sensible way
> to consume the API properly:
>
>   (1) The reported list of threads are incomplete (ignoring destination
>       threads and non-multifd threads).
>
>   (2) For CPU pinning, there's no way to properly pin the threads with
>       the API if the threads will start running right away after migration
>       threads can be queried, so the threads will always run on the default
>       cores for a short window.
>
>   (3) For VM debugging, one can use "-name $VM,debug-threads=on" instead,
>       which will provide proper names for all migration threads.
>
> [1] https://lore.kernel.org/r/20240930195837.825728-1-peterx@redhat.com
> [2] https://lore.kernel.org/r/20241011153417.516715-1-peterx@redhat.com
>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  docs/about/deprecated.rst | 8 ++++++++
>  qapi/migration.json       | 6 +++++-
>  migration/threadinfo.c    | 4 ++++
>  3 files changed, 17 insertions(+), 1 deletion(-)
>
> diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
> index ce38a3d0cf..ffb147e896 100644
> --- a/docs/about/deprecated.rst
> +++ b/docs/about/deprecated.rst
> @@ -147,6 +147,14 @@ options are removed in favor of using explicit ``blockdev-create`` and
>  ``blockdev-add`` calls. See :doc:`/interop/live-block-operations` for
>  details.
>
> +``query-migrationthreads`` (since 9.2)
> +'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
> +
> +To be removed with no replacement, as it reports only a limited set of
> +threads (for example, it only reports source side of multifd threads,
> +without reporting any destination threads, or non-multifd source threads).
> +For debugging purpose, please use ``-name $VM,debug-threads=on`` instead.
> +
>  Incorrectly typed ``device_add`` arguments (since 6.2)
>  ''''''''''''''''''''''''''''''''''''''''''''''''''''''
>
> diff --git a/qapi/migration.json b/qapi/migration.json
> index 3af6aa1740..a71a9f0cd3 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -2284,12 +2284,16 @@
>  #
>  # Returns information of migration threads
>  #
> +# Features:
> +# @deprecated: This command is deprecated with no replacement yet.
> +#
>  # Returns: @MigrationThreadInfo
>  #
>  # Since: 7.2
>  ##
>  { 'command': 'query-migrationthreads',
> -  'returns': ['MigrationThreadInfo'] }
> +  'returns': ['MigrationThreadInfo'],
> +  'features': ['deprecated'] }
>

Sounds reasonable.
Reviewed-by: Prasad Pandit <pjp@fedoraproject.org>

Thank you.
---
  - Prasad


