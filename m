Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22B9ECA0EDC
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Aug 2025 14:03:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umYXY-0006Yr-EG; Thu, 14 Aug 2025 10:02:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1umYXT-0006XW-Un
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 10:02:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1umYXQ-0007Pl-BA
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 10:02:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755180156;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WwDRndZ7FG1HvMv2PVL7IM1wc6vYaqgXCgF9q2PlmmI=;
 b=gI4AUwjk0bGRPedINoHzNbDFhbaGA8oD9mHxtBmv2NAZlva63+AvWT6WAvWQ1yizeGURoq
 Naw1I0rDFdAYb5DESJ+ULCGiJVl8cV6IJW5xH2iig/MLwbgd2A9IMejXv1zRa5M1D9reuh
 16qw8dMRJS6Lot14W+vnmiT90OgBi7U=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-563-zUAwa_RGMoSq0ktCASha5w-1; Thu, 14 Aug 2025 10:02:34 -0400
X-MC-Unique: zUAwa_RGMoSq0ktCASha5w-1
X-Mimecast-MFC-AGG-ID: zUAwa_RGMoSq0ktCASha5w_1755180154
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-4b109affec8so23492891cf.1
 for <qemu-devel@nongnu.org>; Thu, 14 Aug 2025 07:02:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755180153; x=1755784953;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WwDRndZ7FG1HvMv2PVL7IM1wc6vYaqgXCgF9q2PlmmI=;
 b=kr0fo0Cd57nzNsjmjVPMcN3NcT9ihWC7VQBVi4YbeI6nDmvy0O4SxQAnzG8vSse65k
 dfOF3pkDe6kxVqni3v4UXznZjuzY1JbENijG3XdIZtlCLNN+irNM4MhNAeHekTBbl2at
 Fs5RMdr3YNuAPjU8uLr5u0Et/WOF7uPU5u3GNY+9iQs86B9AMK7o0VKypr7kRDNxZr1o
 um0MVseTh9rQxh2wUKfn+jDXQGWeL6Co6lR/dUlv3lomVn4gM6NAUGwTpHtKEIQ4TCqw
 P7gr5/5BHi12QM9f8niktLQ1LjKzOsPvCyv2P5weQWfaqLnx3433X+UNtPxgGz/PYBNH
 qtMg==
X-Gm-Message-State: AOJu0YyFs9u2UaDZiUCXZjDBuBoWtJXi+biMWAOnQsgfbaC8fBrVY7bS
 +12l2LGZUSd6IwkGiuf8n2FQRr4AEopEcEq+06bMaKkzuMCy9eZ4ogvt+RC4jb4hsCAnwsdXkBq
 uPzy+rxYvev1X50xv4siPKjzL2diVaSbVM4SU5T+D/4Sfje5wZAQ09fowUrKe7Jff
X-Gm-Gg: ASbGncu0f2IgLOki7/oHUzAw9frJ+Sc4fof0AyI6VAD3W1s6vCI7/3XLHe1a6+t4Bmq
 O3K34Ki2MNxjY3BssFw0krOQjZla1pA9/l2k3QZdBUBRb2Hx8H5KNfIJGP2sRCJ5PVxVOl4Tue4
 fvRVf2XC1IdkcDYmEgMqFXZDzsC7+ClwZY8DVwg4y3PBILPiSmjzfOCGr5+KjreoDLbDJeZ8r69
 UfdAswlwzwAOFIfwpibICSX5y+YNjHYW10UI8zRVCZ+IMOAtpXu0CQuTL65OFv+44YOxEeqeP+j
 pbRty1eD0VpY7U4/9YhagRTz9kmNdeyi
X-Received: by 2002:a05:622a:4012:b0:4b0:7620:7351 with SMTP id
 d75a77b69052e-4b10a96ceb1mr48107301cf.13.1755180151922; 
 Thu, 14 Aug 2025 07:02:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGU+dF2xSmYcsjUxJENJZd3xZxSoCg8TYJRvZ5W+LOuRrfYpFoZoampQW8KVEanczgigl+EyQ==
X-Received: by 2002:a05:622a:4012:b0:4b0:7620:7351 with SMTP id
 d75a77b69052e-4b10a96ceb1mr48105451cf.13.1755180150466; 
 Thu, 14 Aug 2025 07:02:30 -0700 (PDT)
Received: from x1.local ([174.89.135.121]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4b06ac5bd99sm155053911cf.21.2025.08.14.07.02.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Aug 2025 07:02:30 -0700 (PDT)
Date: Thu, 14 Aug 2025 10:02:18 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, armbru@redhat.com,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 22/24] tests/qtest/migration: Adapt the capabilities
 helper to take a config
Message-ID: <aJ3sajYBVgRGXg6e@x1.local>
References: <20250630195913.28033-1-farosas@suse.de>
 <20250630195913.28033-23-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250630195913.28033-23-farosas@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, Jun 30, 2025 at 04:59:11PM -0300, Fabiano Rosas wrote:
> Allow migrate_start_set_capabilities() to set the config object
> instead of setting the capabilities via calls to
> migrate-set-capabilities.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>  tests/qtest/migration/framework.c | 31 +++++++++++++++++++++++++++++++
>  tests/qtest/migration/framework.h |  1 +
>  2 files changed, 32 insertions(+)
> 
> diff --git a/tests/qtest/migration/framework.c b/tests/qtest/migration/framework.c
> index 407c9023c0..9ff5576328 100644
> --- a/tests/qtest/migration/framework.c
> +++ b/tests/qtest/migration/framework.c
> @@ -211,6 +211,37 @@ static QList *migrate_start_get_qmp_capabilities(const MigrateStart *args)
>  static void migrate_start_set_capabilities(QTestState *from, QTestState *to,
>                                             MigrateStart *args)
>  {
> +    if (args->config) {
> +        const char *cap_multifd;
> +        bool multifd;
> +
> +        for (uint8_t i = 0; i < MIGRATION_CAPABILITY__MAX; i++) {
> +            const char *cap = MigrationCapability_lookup.array[i];
> +
> +            if (!args->caps[i]) {
> +                continue;
> +            }
> +
> +            qdict_put_bool(args->config, cap, true);
> +        }
> +
> +        if (!args->defer_target_connect) {
> +            qdict_put_bool(args->config, "events", true);
> +        }

This will disable events on src too when defer_target_connect is set.
Maybe it's ok to just not test "events" on src for those (almost cpr ones),
but maybe worth mentioning if so.

> +
> +        cap_multifd = MigrationCapability_str(MIGRATION_CAPABILITY_MULTIFD);
> +        multifd = qdict_get_try_bool(args->config, cap_multifd, false);

I get you, but when args->cap[] is still around it's a bit weird to not
just use args->cap[MIGRATION_CAPABILITY_MULTIFD].

I also saw the next patch that we'll also support both "if (config)
... else ...".  If we decide to switchover at some point, shall we have one
patch converting all existing usages (including removing args->cap[]) to
use ->config?

The only outliers should be the parameters we set only after QMP migrate /
migrate_incoming.

> +
> +        if (multifd) {
> +            qdict_put_int(args->config, "multifd-channels",
> +                          MULTIFD_TEST_CHANNELS);
> +            qdict_put_int(args->config, "multifd-channels",
> +                          MULTIFD_TEST_CHANNELS);
> +        }
> +
> +        return;
> +    }
> +
>      /*
>       * MigrationCapability_lookup and MIGRATION_CAPABILITY_ constants
>       * are from qapi-types-migration.h.
> diff --git a/tests/qtest/migration/framework.h b/tests/qtest/migration/framework.h
> index 01e425e64e..9b281d6757 100644
> --- a/tests/qtest/migration/framework.h
> +++ b/tests/qtest/migration/framework.h
> @@ -128,6 +128,7 @@ typedef struct {
>       * migration_set_capabilities().
>       */
>      bool caps[MIGRATION_CAPABILITY__MAX];
> +    QDict *config;
>  } MigrateStart;
>  
>  typedef enum PostcopyRecoveryFailStage {
> -- 
> 2.35.3
> 

-- 
Peter Xu


