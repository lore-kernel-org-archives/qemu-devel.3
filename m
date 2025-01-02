Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 707CEE77188
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2025 20:11:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTRXD-0005TM-Lf; Thu, 02 Jan 2025 15:11:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tTRXA-0005Sd-WC
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 15:11:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tTRX6-0000rQ-9t
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 15:11:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1735848661;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ckx+JeiHdZrAs+XUyFTIDDpt+QepLYAsLUq5WeTP9JM=;
 b=Zbpr89Zk4MXrxf1CRc0YVmXh/3USbYL7J2HxrlmEnL5pN+duZ2stIMhqp9UuUWm3BkaEzm
 E93AReW5usrCRfdVeIWwGS+04DyL5gKU4Z2BuNLAP/TI/cLP/N2Qv8V7QBa833GYWt7q5f
 O9+GogChC/FfRKxM8C+tTTpDCt0Z7O8=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-503-vbsy5CHmPnq7S65NRr0q_w-1; Thu, 02 Jan 2025 15:09:45 -0500
X-MC-Unique: vbsy5CHmPnq7S65NRr0q_w-1
X-Mimecast-MFC-AGG-ID: vbsy5CHmPnq7S65NRr0q_w
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-6d92efa9ff4so189518456d6.2
 for <qemu-devel@nongnu.org>; Thu, 02 Jan 2025 12:09:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735848585; x=1736453385;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ckx+JeiHdZrAs+XUyFTIDDpt+QepLYAsLUq5WeTP9JM=;
 b=oTzIN9MSl6RB8QixKQX16VpP++wzeqVJYExHKywk3fHkFwUsLqfmg5GbSKek/ESlxI
 QlPZQn/NOlwh0DsKyOrELL5yvVi5XnLdQwc5nUSVq3DZVrfjaH83lI4TIOu2vt/0aiJn
 WpT/MujGUZUQ3YYxGWSce8uhzO6hdbZXW/8qbX3QK6vsBDgGKWR1FjWzK8RB2QaX6K4O
 l6/xjujpwiQ+Qe+00oxEDZzSefqKWXzbGv5Vh72ATFBSrIYFBZtMfG7w/gdMWLWvEtsN
 3Dai+vwGHDtYiB1e4pZPF5XZ7Y1bX10hlfHMcV/m5JdLGUV8W9oBV1eGQ3tRyzxK6NRW
 AY7A==
X-Gm-Message-State: AOJu0Yziupz3kGEXz3PE68+19eZvrtST+stvH72KlKdtihmUMPaVvVc+
 TmeYo23qyMrUmjIa7oFlopyI1dM+ZfcXX6IEigASDNyD+mmhv3hXdcQZkyL0cGKw3ThJT1OQNvh
 YG8B9+7qgwLv2pLW8qxabewq2xPFb67THoFwywRov4HeHZEBkMxTH
X-Gm-Gg: ASbGncuLeRQ5A+0jStCQyCOhyKu3Xnm1y4anI15S52NZY7zQwJfBgwVG3PJEF3hHQ00
 NSxb2OPoTnAa4UPMQM6ul+YHv9iZM8xk+i8qBYizwwXnLRmMDhabkyWEZgwL7yD4stDJ0w3FTqW
 uximIHTVwMpHDWFXWdCIa3yfhbUHwDQJUy+UmWObHC3lW8G10xBIscmZHZp+VhHxNjGgZbTpMAL
 OZdZFSiijbyl6TJiE+uxvwP98ivn4KtO9GwIHOdhGpFrzVWNJvstiDwY9p21IWhjnaLqYLbb69f
 IrQCHjC56eBC8jVE5w==
X-Received: by 2002:a05:6214:449f:b0:6d8:a127:e744 with SMTP id
 6a1803df08f44-6dd23355f97mr808690876d6.20.1735848584751; 
 Thu, 02 Jan 2025 12:09:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFa7q2fIlt4zT+P4wcZFSCPrXQqpNixHvqHquxtDEu6PiinLX6ehsXD8t0vDYezhY6MPTkW+Q==
X-Received: by 2002:a05:6214:449f:b0:6d8:a127:e744 with SMTP id
 6a1803df08f44-6dd23355f97mr808690606d6.20.1735848584446; 
 Thu, 02 Jan 2025 12:09:44 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6dd18208364sm134585956d6.126.2025.01.02.12.09.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jan 2025 12:09:43 -0800 (PST)
Date: Thu, 2 Jan 2025 15:09:41 -0500
From: Peter Xu <peterx@redhat.com>
To: Steven Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH V5 22/23] migration-test: cpr-transfer
Message-ID: <Z3byhQ_GHWKAZVpC@x1n>
References: <1735057028-308595-1-git-send-email-steven.sistare@oracle.com>
 <1735057028-308595-23-git-send-email-steven.sistare@oracle.com>
 <Z2sTHg-t0wB4g3Mh@x1n>
 <4becdc50-7f43-4683-9c76-cb75105ee998@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4becdc50-7f43-4683-9c76-cb75105ee998@oracle.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.185,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Jan 02, 2025 at 01:35:01PM -0500, Steven Sistare wrote:
> On 12/24/2024 3:01 PM, Peter Xu wrote:
> > On Tue, Dec 24, 2024 at 08:17:07AM -0800, Steve Sistare wrote:
> > > Add a migration test for cpr-transfer mode.  Defer the connection to the
> > > target monitor, else the test hangs because in cpr-transfer mode QEMU does
> > > not listen for monitor connections until we send the migrate command to
> > > source QEMU.
> > > 
> > > To test -incoming defer, send a migrate incoming command to the target,
> > > after sending the migrate command to the source, as required by
> > > cpr-transfer mode.
> > > 
> > > Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> > > ---
> > >   tests/qtest/migration/cpr-tests.c | 60 +++++++++++++++++++++++++++++++++++++++
> > >   tests/qtest/migration/framework.c | 19 +++++++++++++
> > >   tests/qtest/migration/framework.h |  3 ++
> > >   3 files changed, 82 insertions(+)
> > > 
> > > diff --git a/tests/qtest/migration/cpr-tests.c b/tests/qtest/migration/cpr-tests.c
> > > index 44ce89a..b221980 100644
> > > --- a/tests/qtest/migration/cpr-tests.c
> > > +++ b/tests/qtest/migration/cpr-tests.c
> > > @@ -44,6 +44,62 @@ static void test_mode_reboot(void)
> > >       test_file_common(&args, true);
> > >   }
> > > +static void *test_mode_transfer_start(QTestState *from, QTestState *to)
> > > +{
> > > +    migrate_set_parameter_str(from, "mode", "cpr-transfer");
> > > +    return NULL;
> > > +}
> > > +
> > > +/*
> > > + * cpr-transfer mode cannot use the target monitor prior to starting the
> > > + * migration, and cannot connect synchronously to the monitor, so defer
> > > + * the target connection.
> > > + */
> > > +static void test_mode_transfer_common(bool incoming_defer)
> > > +{
> > > +    g_autofree char *cpr_path = g_strdup_printf("%s/cpr.sock", tmpfs);
> > > +    g_autofree char *mig_path = g_strdup_printf("%s/migsocket", tmpfs);
> > > +    g_autofree char *uri = g_strdup_printf("unix:%s", mig_path);
> > > +
> > > +    const char *opts = "-machine aux-ram-share=on -nodefaults";
> > > +    g_autofree const char *cpr_channel = g_strdup_printf(
> > > +        "cpr,addr.transport=socket,addr.type=unix,addr.path=%s",
> > > +        cpr_path);
> > > +    g_autofree char *opts_target = g_strdup_printf("-incoming %s %s",
> > > +                                                   cpr_channel, opts);
> > > +
> > > +    g_autofree char *connect_channels = g_strdup_printf(
> > > +        "[ { 'channel-type': 'main',"
> > > +        "    'addr': { 'transport': 'socket',"
> > > +        "              'type': 'unix',"
> > > +        "              'path': '%s' } } ]",
> > > +        mig_path);
> > 
> > So this test already uses json-format channels, IMHO we probably don't need
> > MigrateCommon.cpr_channel anymore?  We could put them all here. Then..
> 
> The previous version of this patch did that, and did not define cpr_channel,
> but you did not like how, in addition to using args->connect_channels, I
> defined the main uri in args->connect_uri and passed it to migrate_incoming_qmp.
> 
> The constraint I must satisfy is that main + cpr channels must be passed to
> migrate_qmp, but only the main channel can be passed to migrate_incoming_qmp.

Hmm true, I see now.

> 
> I could instead define an optional args->incoming_channels, passed to
> migrate_incoming_qmp, and only set by cpr.  Then the channel parsing extensions
> could be eliminated.
> 
> This current patch with its channel parsing support does make
> test_mode_transfer_common nicer in one way: the cpr channel is only described
> once, in dotted keys format.  A V6 that defines args->incoming_channels will
> need to define it once using dotted keys, to be embedded in startup args, and
> again in json in args->connect_uri.
> 
> I don't feel strongly either way: keep V5, or define incoming_channels.

Me too, please choose whatever easier for you.

Thanks,

-- 
Peter Xu


