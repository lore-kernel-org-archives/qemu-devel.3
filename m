Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5ACD8C27C53
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2024 20:40:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sK25x-00060J-6k; Wed, 19 Jun 2024 16:39:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sK25v-000609-I1
 for qemu-devel@nongnu.org; Wed, 19 Jun 2024 16:39:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sK25t-0005ca-N3
 for qemu-devel@nongnu.org; Wed, 19 Jun 2024 16:39:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718829588;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bVVUVR3xquXu0AT+1+sKFLBlPozIf995v/cGKhCubjI=;
 b=aP1Gk3V5I3kqgsyGYrBniF/zuZbEypxDeFu521VtN4Rqm75Lhp2Yka9PW/ukJmB3eb298k
 jmUVSxFR1GWOBkGxqQTb4k8LQ+WSpcN+ou62BJ+xUVPuPF+ODJPA8ot4jF0KRADDUp7pva
 0O4Tuv9Im6vyAI6Y/rZBsmHfGv3sWQM=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-619-k-e1ETmDMlKbEisEGYfJLQ-1; Wed, 19 Jun 2024 16:39:45 -0400
X-MC-Unique: k-e1ETmDMlKbEisEGYfJLQ-1
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-6ad5ebfaa68so709666d6.0
 for <qemu-devel@nongnu.org>; Wed, 19 Jun 2024 13:39:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718829584; x=1719434384;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bVVUVR3xquXu0AT+1+sKFLBlPozIf995v/cGKhCubjI=;
 b=V53w1eEv1c55jXXGTTWxg5pA6a9ABG8jy3q/AbDLoDp3SzWHXMKQ7/63vTfpSlKA4I
 QE2W7OIn9SXM6VXsMPBTlpVPxzlthtOxNKEP7RMy4wCgEXptZjwGBwza0ByrsHgbBe7w
 hgwP8N9/ccJ5xvfCkO/eJeq1+NFMzjpvtRI4DZZm1snsGP36mcp2YxtoDWtr0wRutXYc
 C4wG0Ca/c1l2/apC7RfidVfgPQuXK72VYBSPreZjiaqYTGRl8rXgw9injJAPRQ6f0ACp
 KjVgsGiz1HodcrhYdxLCphPL3cogb/z7nH9YgChYmgiPusOrQAKa/wjLwfnRuD7iKCIl
 cwhA==
X-Gm-Message-State: AOJu0YwHDuagFQqg8hxn/B/+oUDF/kZqBc2xlr7eOaJQilAaQLxmk9ZC
 gX107nLCTnLwa1XxlH2D2/JrXl6UuueBh2AI5I896G4Mt5lVYTi/h/0PM1maQLAZf0pDSrug1v+
 TCgBAM3KGsRANLQRb+AYj5rfy/Nw9MOGM8oRX4a+Sgd+9TOehTsbh
X-Received: by 2002:a05:620a:1713:b0:798:dc44:7856 with SMTP id
 af79cd13be357-79bb3e0df7fmr395180585a.2.1718829584295; 
 Wed, 19 Jun 2024 13:39:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFrSzNqdrx6M7Kt6Z85IW9c4+zfri7KN2r7I4MHnpzbSMP+lqa5M/ImO1kUCsV4uFvs+9BUNQ==
X-Received: by 2002:a05:620a:1713:b0:798:dc44:7856 with SMTP id
 af79cd13be357-79bb3e0df7fmr395177985a.2.1718829583605; 
 Wed, 19 Jun 2024 13:39:43 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-798aacae1c6sm633285585a.7.2024.06.19.13.39.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Jun 2024 13:39:43 -0700 (PDT)
Date: Wed, 19 Jun 2024 16:39:41 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Eric Blake <eblake@redhat.com>,
 Prasad Pandit <ppandit@redhat.com>,
 Jiri Denemark <jdenemar@redhat.com>, Bandan Das <bdas@redhat.com>
Subject: Re: [PATCH v2 08/10] tests/migration-tests: Always enable migration
 events
Message-ID: <ZnNCDUoh9Ii8izOp@x1n>
References: <20240617181534.1425179-1-peterx@redhat.com>
 <20240617181534.1425179-9-peterx@redhat.com>
 <87a5jjbb5n.fsf@suse.de> <ZnCpTHYho5v98DZo@x1n>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZnCpTHYho5v98DZo@x1n>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Mon, Jun 17, 2024 at 05:23:24PM -0400, Peter Xu wrote:
> On Mon, Jun 17, 2024 at 04:51:32PM -0300, Fabiano Rosas wrote:
> > Peter Xu <peterx@redhat.com> writes:
> > 
> > > Libvirt should always enable it, so it'll be nice qtest also cover that for
> > > all tests.  Though this patch only enables it, no extra tests are done on
> > > these events yet.
> > >
> > > Signed-off-by: Peter Xu <peterx@redhat.com>
> > > ---
> > >  tests/qtest/migration-test.c | 7 +++++++
> > >  1 file changed, 7 insertions(+)
> > >
> > > diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
> > > index 13b59d4c10..9ae8892e26 100644
> > > --- a/tests/qtest/migration-test.c
> > > +++ b/tests/qtest/migration-test.c
> > > @@ -841,6 +841,13 @@ static int test_migrate_start(QTestState **from, QTestState **to,
> > >          unlink(shmem_path);
> > >      }
> > >  
> > > +    /*
> > > +     * Always enable migration events.  Libvirt always uses it, let's try
> > > +     * to mimic as closer as that.
> > > +     */
> > > +    migrate_set_capability(*from, "events", true);
> > > +    migrate_set_capability(*to, "events", true);
> > > +
> > 
> > What do we do with the one at migrate_incoming_qmp()?
> 
> Hmm missed that..  I'll drop that one in this same patch and rewrite the
> commit message.  New version attached:
> 
> ===8<===
> From 443fef4188d544362fc026b46784c15b82624642 Mon Sep 17 00:00:00 2001
> From: Peter Xu <peterx@redhat.com>
> Date: Mon, 17 Jun 2024 10:49:52 -0400
> Subject: [PATCH] tests/migration-tests: Always enable migration events
> 
> Libvirt should always enable it, so it'll be nice qtest also cover that for
> all tests on both sides.  migrate_incoming_qmp() used to enable it only on
> dst, now we enable them on both, as we'll start to sanity check events even
> on the src QEMU.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  tests/qtest/migration-helpers.c | 2 --
>  tests/qtest/migration-test.c    | 7 +++++++
>  2 files changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/qtest/migration-helpers.c b/tests/qtest/migration-helpers.c
> index 0ac49ceb54..797b1e8c1c 100644
> --- a/tests/qtest/migration-helpers.c
> +++ b/tests/qtest/migration-helpers.c
> @@ -258,8 +258,6 @@ void migrate_incoming_qmp(QTestState *to, const char *uri, const char *fmt, ...)
>      g_assert(!qdict_haskey(args, "uri"));
>      qdict_put_str(args, "uri", uri);
>  
> -    migrate_set_capability(to, "events", true);
> -

Unfortunately this will break virtio-net-failover test... as it uses
migrate_incoming_qmp() without using test_migrate_start().

I'll leave it there for now, perhaps adding a comment.

>      rsp = qtest_qmp(to, "{ 'execute': 'migrate-incoming', 'arguments': %p}",
>                      args);
>  
> diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
> index 640713bfd5..c015e801ac 100644
> --- a/tests/qtest/migration-test.c
> +++ b/tests/qtest/migration-test.c
> @@ -851,6 +851,13 @@ static int test_migrate_start(QTestState **from, QTestState **to,
>          unlink(shmem_path);
>      }
>  
> +    /*
> +     * Always enable migration events.  Libvirt always uses it, let's try
> +     * to mimic as closer as that.
> +     */
> +    migrate_set_capability(*from, "events", true);
> +    migrate_set_capability(*to, "events", true);
> +
>      return 0;
>  }
>  
> -- 
> 2.45.0
> 
> 
> -- 
> Peter Xu

-- 
Peter Xu


