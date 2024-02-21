Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9C53C48BC3
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 02:25:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rccHu-00052y-Gy; Tue, 20 Feb 2024 21:24:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rccHn-0004nG-PW
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 21:24:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rccHl-0001PO-K3
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 21:24:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708482275;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=huio2ALf2p4uXHpD5A6ndGQ7nmt9yq2mMZgAu46/gDY=;
 b=C4GSF7AYIo7/2xoUPw2p6VYv6kLRiblpI7Vdt3SQEgVrdlLiOA1Wd7aLyP7dScYnGPWomp
 /Pco5TY+10vy2MVmX3yaSHKPCiIV2COgTK4Yj/ipSJLzhV5v75L5tmoQKx1Znm+Am8jHSO
 x3Sj+VnO08DR1keVllo/7eVFbfiKL1g=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-470-KTG3S2A0OGuRQHx-dHOj7g-1; Tue, 20 Feb 2024 21:24:34 -0500
X-MC-Unique: KTG3S2A0OGuRQHx-dHOj7g-1
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-6e46eae042bso275563b3a.1
 for <qemu-devel@nongnu.org>; Tue, 20 Feb 2024 18:24:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708482273; x=1709087073;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=huio2ALf2p4uXHpD5A6ndGQ7nmt9yq2mMZgAu46/gDY=;
 b=LxyzkHeCwAWVDxWg/vsmoSDgDdiluMItph9fhY0fO4iVHiyEv9fnGuNblgaknxRH1J
 PwE2upXGdWzFor3P4SzamXhsU9NYkSFDFijJzJbsQ+JLcLD/Vj53DkK6tx4TQzmTbzJw
 GG6LPxTPyD4T2009OyAWLFzlFd4mlFRHLBpfXcCgUw+ag5IodIF+gKZp8itp8bSoKmMf
 iEec+sEgU3m8bnS86f2n5BRUHOU8Hr9Cqz1F8NROMdhBIBLGmWCsg1C1HoC8UlPWK0A6
 G4WFkptKUl6W40lyRvqtjoi9j3BjyvJoS3qwVk68AYJMkVVNmvqtnuwFVny9hauu5UXK
 OJbQ==
X-Gm-Message-State: AOJu0YydXhPiLuNi3Q8sJ5m78bKQ12jsaNvnNxNT8M+ZDE8YSqTx/Av4
 m1D5xqXN8Cpj9xatbpM0G0Z9kiNnab1Rr0TSV8nY/TsnrKApoRwhjalv0CZype8elIjgddkVxHM
 wNQYA7QA6+/zc9HmsFNH1+RlbP+mKSMNH3fCYgRidPAMuh/9ZPqkC
X-Received: by 2002:a05:6a20:4286:b0:1a0:57d2:1f96 with SMTP id
 o6-20020a056a20428600b001a057d21f96mr16926033pzj.0.1708482272783; 
 Tue, 20 Feb 2024 18:24:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGeSOMSP8pa2eXuOz9/6+u8RTew7pYTCdgq68NwIqsbk23PXw689rlAxmcKQDMZcUhPxRtrmA==
X-Received: by 2002:a05:6a20:4286:b0:1a0:57d2:1f96 with SMTP id
 o6-20020a056a20428600b001a057d21f96mr16926018pzj.0.1708482272448; 
 Tue, 20 Feb 2024 18:24:32 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 sk17-20020a17090b2dd100b00298d2182f1asm390025pjb.55.2024.02.20.18.24.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Feb 2024 18:24:32 -0800 (PST)
Date: Wed, 21 Feb 2024 10:24:26 +0800
From: Peter Xu <peterx@redhat.com>
To: Het Gala <het.gala@nutanix.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "armbru@redhat.com" <armbru@redhat.com>,
 "berrange@redhat.com" <berrange@redhat.com>,
 "farosas@suse.de" <farosas@suse.de>
Subject: Re: [PATCH 1/3] qtest: migration: Enhance qtest migration functions
 to support 'channels' argument
Message-ID: <ZdVe2lC0xkxGgGJy@x1n>
References: <20240216090624.75445-1-het.gala@nutanix.com>
 <20240216090624.75445-2-het.gala@nutanix.com>
 <ZdRAo3XJ9xvs6Z4Q@x1n>
 <SJ2PR02MB9955B1E7FDF128EE745F121E98502@SJ2PR02MB9955.namprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <SJ2PR02MB9955B1E7FDF128EE745F121E98502@SJ2PR02MB9955.namprd02.prod.outlook.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.05,
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

On Tue, Feb 20, 2024 at 06:14:46PM +0000, Het Gala wrote:
> 
> 
> From: Peter Xu <peterx@redhat.com>
> Date: Tuesday, 20 February 2024 at 11:33 AM
> To: Het Gala <het.gala@nutanix.com>
> Cc: qemu-devel@nongnu.org <qemu-devel@nongnu.org>, armbru@redhat.com <armbru@redhat.com>, berrange@redhat.com <berrange@redhat.com>, farosas@suse.de <farosas@suse.de>
> Subject: Re: [PATCH 1/3] qtest: migration: Enhance qtest migration functions to support 'channels' argument
> On Fri, Feb 16, 2024 at 09:06:22AM +0000, Het Gala wrote:
> > Introduce support for adding a 'channels' argument to migrate_qmp_fail
> > and migrate_qmp functions within the migration qtest framework, enabling
> > enhanced control over migration scenarios.
> >
> > Signed-off-by: Het Gala <het.gala@nutanix.com>
> > ---
> >  tests/qtest/dbus-vmstate-test.c |  2 +-
> >  tests/qtest/migration-helpers.c | 93 ++++++++++++++++++++++++++++++---
> >  tests/qtest/migration-helpers.h | 11 ++--
> >  tests/qtest/migration-test.c    | 33 ++++++------
> >  4 files changed, 112 insertions(+), 27 deletions(-)
> >
> > diff --git a/tests/qtest/dbus-vmstate-test.c b/tests/qtest/dbus-vmstate-test.c
> > index 6c990864e3..0ca572e29b 100644
> > --- a/tests/qtest/dbus-vmstate-test.c
> > +++ b/tests/qtest/dbus-vmstate-test.c
> > @@ -229,7 +229,7 @@ test_dbus_vmstate(Test *test)
> >
> >      thread = g_thread_new("dbus-vmstate-thread", dbus_vmstate_thread, loop);
> >
> > -    migrate_qmp(src_qemu, uri, "{}");
> > +    migrate_qmp(src_qemu, uri, NULL, "{}");
> >      test->src_qemu = src_qemu;
> >      if (test->migrate_fail) {
> >          wait_for_migration_fail(src_qemu, true);
> > diff --git a/tests/qtest/migration-helpers.c b/tests/qtest/migration-helpers.c
> > index e451dbdbed..d153677887 100644
> > --- a/tests/qtest/migration-helpers.c
> > +++ b/tests/qtest/migration-helpers.c
> > @@ -13,6 +13,7 @@
> >  #include "qemu/osdep.h"
> >  #include "qemu/ctype.h"
> >  #include "qapi/qmp/qjson.h"
> > +#include "qapi/qmp/qlist.h"
> >
> >  #include "migration-helpers.h"
> >
> > @@ -43,7 +44,70 @@ bool migrate_watch_for_events(QTestState *who, const char *name,
> >      return false;
> >  }
> >
> > -void migrate_qmp_fail(QTestState *who, const char *uri, const char *fmt, ...)
> > +static char *socketAddressType_to_str(SocketAddressType type)
> > +{
> > +    switch (type) {
> > +    case SOCKET_ADDRESS_TYPE_INET:
> > +        return g_strdup("inet");
> > +    case SOCKET_ADDRESS_TYPE_UNIX:
> > +        return g_strdup("unix");
> > +    case SOCKET_ADDRESS_TYPE_FD:
> > +        return g_strdup("fd");
> > +    case SOCKET_ADDRESS_TYPE_VSOCK:
> > +        return g_strdup("vsock");
> > +    default:
> > +        return g_strdup("unknown address type");
> > +    }
> > +}
> 
> Use SocketAddressType_lookup?
> Ack, I guess combination of using qapi_enum_parse() and qapi_enum_lookup() would help me eliminate the need for creating this function itself. Let me do the changes in the next patch.  Thanks!

Ah, what I wanted to say was actually SocketAddressType_str.

> 
> > +
> > +static QList *MigrationChannelList_to_QList(MigrationChannelList *channels)
> > +{
> > +    MigrationChannel *channel = NULL;
> > +    MigrationAddress *addr = NULL;
> > +    SocketAddress *saddr = NULL;
> > +    g_autofree const char *addr_type = NULL;
> > +    QList *channelList = qlist_new();
> > +    QDict *channelDict = qdict_new();
> > +    QDict *addrDict = qdict_new();
> > +
> > +    channel = channels->value;
> > +    if (!channel || channel->channel_type == MIGRATION_CHANNEL_TYPE__MAX) {
> > +        fprintf(stderr, "%s: Channel or its type is NULL\n",
> > +                __func__);
> > +    }
> > +    g_assert(channel);
> > +    if (channel->channel_type == MIGRATION_CHANNEL_TYPE_MAIN) {
> > +        qdict_put_str(channelDict, "channel-type", g_strdup("main"));
> > +    }
> > +
> > +    addr = channel->addr;
> > +    if (!addr || addr->transport == MIGRATION_ADDRESS_TYPE__MAX) {
> > +        fprintf(stderr, "%s: addr or its transport is NULL\n",
> > +                __func__);
> > +    }
> > +    g_assert(addr);
> > +    if (addr->transport == MIGRATION_ADDRESS_TYPE_SOCKET) {
> > +        qdict_put_str(addrDict, "transport", g_strdup("socket"));
> > +    }
> > +
> > +    saddr = &addr->u.socket;
> > +    if (!saddr) {
> > +        fprintf(stderr, "%s: saddr is NULL\n", __func__);
> > +    }
> > +    g_assert(saddr);
> > +    addr_type = socketAddressType_to_str(saddr->type);
> > +    qdict_put_str(addrDict, "type", addr_type);
> > +    qdict_put_str(addrDict, "port", saddr->u.inet.port);
> > +    qdict_put_str(addrDict, "host", saddr->u.inet.host);
> > +
> > +    qdict_put_obj(channelDict, "addr", QOBJECT(addrDict));
> > +    qlist_append_obj(channelList, QOBJECT(channelDict));
> > +
> > +    return channelList;
> > +}
> > +
> > +void migrate_qmp_fail(QTestState *who, const char *uri,
> > +                      MigrationChannelList *channels, const char *fmt, ...)
> >  {
> >      va_list ap;
> >      QDict *args, *err;
> > @@ -52,8 +116,16 @@ void migrate_qmp_fail(QTestState *who, const char *uri, const char *fmt, ...)
> >      args = qdict_from_vjsonf_nofail(fmt, ap);
> >      va_end(ap);
> >
> > -    g_assert(!qdict_haskey(args, "uri"));
> > -    qdict_put_str(args, "uri", uri);
> > +    if (uri) {
> > +        g_assert(!qdict_haskey(args, "uri"));
> 
> IMHO we don't need to assert here?
> 
> Rather than doing this, we can also have tests covering when both are set,
> or when none are set, to make sure we fail properly in those wrong cases.
> (Neglecting your comments here based on Patch 3/3 comment).
> 
> > +        qdict_put_str(args, "uri", uri);
> > +    }
> > +
> > +    if (channels) {
> > +        g_assert(!qdict_haskey(args, "channels"));
> > +        QList *channelList = MigrationChannelList_to_QList(channels);
> > +        qdict_put_obj(args, "channels", QOBJECT(channelList));
> > +    }
> >
> >      err = qtest_qmp_assert_failure_ref(
> >          who, "{ 'execute': 'migrate', 'arguments': %p}", args);
> > @@ -68,7 +140,8 @@ void migrate_qmp_fail(QTestState *who, const char *uri, const char *fmt, ...)
> >   * Arguments are built from @fmt... (formatted like
> >   * qobject_from_jsonf_nofail()) with "uri": @uri spliced in.
> >   */
> > -void migrate_qmp(QTestState *who, const char *uri, const char *fmt, ...)
> > +void migrate_qmp(QTestState *who, const char *uri,
> > +                 MigrationChannelList *channels, const char *fmt, ...)
> >  {
> >      va_list ap;
> >      QDict *args;
> > @@ -77,8 +150,16 @@ void migrate_qmp(QTestState *who, const char *uri, const char *fmt, ...)
> >      args = qdict_from_vjsonf_nofail(fmt, ap);
> >      va_end(ap);
> >
> > -    g_assert(!qdict_haskey(args, "uri"));
> > -    qdict_put_str(args, "uri", uri);
> > +    if (uri) {
> > +        g_assert(!qdict_haskey(args, "uri"));
> > +        qdict_put_str(args, "uri", uri);
> > +    }
> > +
> > +    if (channels) {
> > +        g_assert(!qdict_haskey(args, "channels"));
> > +        QList *channelList = MigrationChannelList_to_QList(channels);
> > +        qdict_put_obj(args, "channels", QOBJECT(channelList));
> > +    }
> 
> Duplicated chunks; sign of adding some helper?
> I didn’t think of adding a helper function here as it was just 2 lines of code, already calling MigrationChannelList_to_QList() to avoid duplication. Even then if you have something in your mind to create some helper function, please suggest :)

migrate_qmp_attach_ports(QDict *args, const char *uri,
                         MigrationChannelList *channels)
{
    if (uri) {
        g_assert(!qdict_haskey(args, "uri"));
        qdict_put_str(args, "uri", uri);
    }

    if (channels) {
        g_assert(!qdict_haskey(args, "channels"));
        QList *channelList = MigrationChannelList_to_QList(channels);
        qdict_put_obj(args, "channels", QOBJECT(channelList));
    }
}

If you plan to work on migrate_incoming_qmp(), it'll also be reusable
there.

> 
> >
> >      qtest_qmp_assert_success(who,
> >                               "{ 'execute': 'migrate', 'arguments': %p}", args);
> > diff --git a/tests/qtest/migration-helpers.h b/tests/qtest/migration-helpers.h
> > index 3bf7ded1b9..52243bd2df 100644
> > --- a/tests/qtest/migration-helpers.h
> > +++ b/tests/qtest/migration-helpers.h
> > @@ -14,6 +14,7 @@
> >  #define MIGRATION_HELPERS_H
> >
> >  #include "libqtest.h"
> > +#include "migration/migration.h"
> >
> >  typedef struct QTestMigrationState {
> >      bool stop_seen;
> > @@ -25,15 +26,17 @@ typedef struct QTestMigrationState {
> >  bool migrate_watch_for_events(QTestState *who, const char *name,
> >                                QDict *event, void *opaque);
> >
> > -G_GNUC_PRINTF(3, 4)
> > -void migrate_qmp(QTestState *who, const char *uri, const char *fmt, ...);
> > +G_GNUC_PRINTF(4, 5)
> > +void migrate_qmp(QTestState *who, const char *uri,
> > +                 MigrationChannelList *channels, const char *fmt, ...);
> >
> >  G_GNUC_PRINTF(3, 4)
> >  void migrate_incoming_qmp(QTestState *who, const char *uri,
> >                            const char *fmt, ...);
> Just thinking, should also add ‘channels’ argument here I guess, would be helpful in future to add some tests where only ‘channels’ parameter wants to be added to the function ?

Sounds good.

Thanks,

-- 
Peter Xu


