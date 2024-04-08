Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED635C67861
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2024 15:41:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rtr6n-0005B6-Ja; Mon, 08 Apr 2024 11:40:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rtr6m-0005Aw-0C
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 11:40:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rtr6k-00089S-9n
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 11:40:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712590829;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=U0ZSSzJ8sJDWeP52BwmOh9K4oF4sYPvXiJT2G4sOHsg=;
 b=Sac4pgXFflykXxcs87DWDtsUP420vcLU/0StLg2ftyUxdnuD2HNjM6LJ7zVnrFkjV1trUs
 wuBgcCquT9gPjxPbffJDWPYl+rZQKBDoeuZcm+L9GkAMOwCSyG5zo8CCFVj0o2G5whqq0g
 dVPtbS6rLp3SDkEKCTBnQJgbczoaemc=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-664-caXGk3_lPBKVD_S_tABJdg-1; Mon, 08 Apr 2024 11:40:25 -0400
X-MC-Unique: caXGk3_lPBKVD_S_tABJdg-1
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-6ecf193960bso469698b3a.0
 for <qemu-devel@nongnu.org>; Mon, 08 Apr 2024 08:40:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712590824; x=1713195624;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U0ZSSzJ8sJDWeP52BwmOh9K4oF4sYPvXiJT2G4sOHsg=;
 b=sd4nMD2UKahjsAWq6MySJxgnGyxBGTita0TiRZQJk/MdSfG4JkkoHp81/M6MuKIqWO
 FJ+mtvfWquH7aZFgb1T3/H+0QAdjUiuLyPUijJUmz/Jacv0KLJnfn/1nJG8+UDg4Ww4b
 zGrQTuWwpOS3+QtP+lZc/s3SdS3E4BgKWA+sJTXuvs9rp81lo44sbKmwHxCwPPK13sbl
 FBv7J6hABV2GqQ0P23rCsqrYTo+HDwk1w/wOFC1qxKEmbsBPXeeiHyQsvf9LReY1waKD
 Z3ut6fPEAw0aXQV5xrHGOClj+nM2O31MtmpdFjKgoPphz2TF/PlbmhZtt89Fa8CEqhzO
 ZYEw==
X-Gm-Message-State: AOJu0YzX3cYHpdMhGYTAXzlYjWlRJQhMkfh6sbiXcQAv0gFOQjQ/by8R
 lNNzRtiQ+eYb7TfNVAE694hNViNn/W59Muzo34+HwKh9P9I4gyCoPisxv1jLnh04vauSnPJMAiw
 SsyxSaVQwrhD3do8OCCRAuCmQlzfd5MC8xckheWogNen6E4ZaLlBE
X-Received: by 2002:a05:6a00:8b09:b0:6ec:f5d2:f641 with SMTP id
 if9-20020a056a008b0900b006ecf5d2f641mr9494596pfb.1.1712590824181; 
 Mon, 08 Apr 2024 08:40:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFupmCe2gMiUOCgPPHD7EeM+qqv8SnSBIO0Y/adqI6wo8WZf3NhKLYBvfail2coXsGb7xexwA==
X-Received: by 2002:a05:6a00:8b09:b0:6ec:f5d2:f641 with SMTP id
 if9-20020a056a008b0900b006ecf5d2f641mr9494553pfb.1.1712590823441; 
 Mon, 08 Apr 2024 08:40:23 -0700 (PDT)
Received: from x1n ([99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 fb39-20020a056a002da700b006ecfc3a8d6csm6662168pfb.124.2024.04.08.08.40.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Apr 2024 08:40:23 -0700 (PDT)
Date: Mon, 8 Apr 2024 11:40:19 -0400
From: Peter Xu <peterx@redhat.com>
To: Het Gala <het.gala@nutanix.com>
Cc: qemu-devel@nongnu.org, thuth@redhat.com, lvivier@redhat.com,
 pbonzini@redhat.com, farosas@suse.de, prerna.saxena@nutanix.com
Subject: Re: [PATCH 2/2] Call args->connect_channels to actually test
 multifd_tcp_channels_none qtest
Message-ID: <ZhQP45IJfh_8qBVV@x1n>
References: <20240407132125.159528-1-het.gala@nutanix.com>
 <20240407132125.159528-3-het.gala@nutanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240407132125.159528-3-het.gala@nutanix.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.494,
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

On Sun, Apr 07, 2024 at 01:21:25PM +0000, Het Gala wrote:
> Earlier, without args->connect_channels, multifd_tcp_channels_none would
> call uri internally even though connect_channels was introduced in
> function definition. To actually call 'migrate' QAPI with modified syntax,
> args->connect_channels need to be passed.
> Double free happens while setting correct migration ports. Fix that.
> 
> Fixes: (tests/qtest/migration: Add multifd_tcp_plain test using list of
>         channels instead of uri)

[1]

> Signed-off-by: Het Gala <het.gala@nutanix.com>
> ---
>  tests/qtest/migration-helpers.c | 2 --
>  tests/qtest/migration-test.c    | 2 +-
>  2 files changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/tests/qtest/migration-helpers.c b/tests/qtest/migration-helpers.c
> index b2a90469fb..b1d06187ab 100644
> --- a/tests/qtest/migration-helpers.c
> +++ b/tests/qtest/migration-helpers.c
> @@ -146,8 +146,6 @@ static void migrate_set_ports(QTestState *to, QList *channel_list)
>                  qdict_put_str(addrdict, "port", addr_port);
>          }
>      }
> -
> -    qobject_unref(addr);

Firstly, this doesn't belong to the commit you were pointing at above [1].
Instead this line is part of:

  tests/qtest/migration: Add migrate_set_ports into migrate_qmp to update migration port value

You may want to split them?

Side note: I didn't review carefully on the whole patchset, but I think
it's preferred to not include any dead code like what you did with
"tests/qtest/migration: Add migrate_set_ports into migrate_qmp to update
migration port value".  It'll be better to me if we introduce code that
will be used already otherwise reviewing such patch is a pain, same to when
we follow up stuff later like this.

More importantly.. why free?  I'll paste whole thing over, and raise my
questions.

static void migrate_set_ports(QTestState *to, QList *channel_list)
{
    QDict *addr;
    QListEntry *entry;
    g_autofree const char *addr_port = NULL;   <--------- this points to sub-field of "addr", if we free "addr", why autofree here?

    addr = migrate_get_connect_qdict(to);

    QLIST_FOREACH_ENTRY(channel_list, entry) {
        QDict *channel = qobject_to(QDict, qlist_entry_obj(entry));
        QDict *addrdict = qdict_get_qdict(channel, "addr");

        if (qdict_haskey(addrdict, "port") &&
            qdict_haskey(addr, "port") &&
            (strcmp(qdict_get_str(addrdict, "port"), "0") == 0)) {
                addr_port = qdict_get_str(addr, "port");
                qdict_put_str(addrdict, "port", addr_port);  <--------- shouldn't we g_strdup() instead of dropping the below unref()?
        }
    }

    qobject_unref(addr);
}

>  }
>  
>  bool migrate_watch_for_events(QTestState *who, const char *name,
> diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
> index 584d7c496f..5d6d8cd634 100644
> --- a/tests/qtest/migration-test.c
> +++ b/tests/qtest/migration-test.c
> @@ -1728,7 +1728,7 @@ static void test_precopy_common(MigrateCommon *args)
>          goto finish;
>      }
>  
> -    migrate_qmp(from, to, args->connect_uri, NULL, "{}");
> +    migrate_qmp(from, to, args->connect_uri, args->connect_channels, "{}");
>  
>      if (args->result != MIG_TEST_SUCCEED) {
>          bool allow_active = args->result == MIG_TEST_FAIL;
> -- 
> 2.22.3
> 

-- 
Peter Xu


