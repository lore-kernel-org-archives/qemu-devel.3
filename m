Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 120FAD2629E
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Jan 2026 20:13:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viI5y-0006Rl-Pv; Tue, 20 Jan 2026 15:12:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1viI5x-0006RI-3H
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 15:12:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1viI5v-00037y-Dj
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 15:12:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768939973;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZCCPEnHyzdRlL9vQguqrxPQvHSShniYrUsasbOTX7oQ=;
 b=XsIHvj6XifZivPeglZrXTMmFZRl4gbzak28OiXwqA0pODwVIqJ8jxiiqVhxVTSTj40wZi8
 Jt0Zv+vGNHbGq5xpKHUlVuGlHfn4i5NbPbuEjcL9iV0X/qNm7A/n0X9bnSMgxs+2eb/TLg
 kuvcZrEvnGcJkvMMI3o2exNep49NJoY=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-55-viJL-AkAO1aW3I5247ZhuA-1; Tue, 20 Jan 2026 15:12:51 -0500
X-MC-Unique: viJL-AkAO1aW3I5247ZhuA-1
X-Mimecast-MFC-AGG-ID: viJL-AkAO1aW3I5247ZhuA_1768939971
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-8c6a241b5cdso867514785a.1
 for <qemu-devel@nongnu.org>; Tue, 20 Jan 2026 12:12:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768939971; x=1769544771; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ZCCPEnHyzdRlL9vQguqrxPQvHSShniYrUsasbOTX7oQ=;
 b=YfofZutJ5BBFfdisBkZI8TCdLlj/7KQ8jFpriH/IFHHDzvpgsLf78WlpWFBVe6Xo2z
 KcB3wBdpv7m08tjIh9Xqptv0PggKkEywtl5/NoM9vdgmmmkDPAmpzZSLSLqwA9aruWOC
 Ahf6YgEA1PGNGpYlKECz7lKC5xbKBwyYHjZIftr5ZubUY+nxWJ4U/QLslRNjgMWSQIRa
 /Dsbu5D96Z/L0dE9z9dd7+HN4HC3+6cgb2pZgerARvsgBHvPQOfTH2ntvHMdwZFuMN4A
 cgv05Hx3tLRkYwcm3NYB9y3i0TavE9uEFBd4Y7Z//59oy0fM6n8BSA+RDlz0BYunM3h8
 B9Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768939971; x=1769544771;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZCCPEnHyzdRlL9vQguqrxPQvHSShniYrUsasbOTX7oQ=;
 b=QXfrFo9UF197C+dRONRVA/kUmK2uacu7zyVZ/RiqI311RObIOb2Zo5ui599YUs3hQ8
 wtOVp74txL2F9WamEpOfUUYd36xbr0oXimZ5I0rv7f2UlJ6wq3HX8n6spl4b8UnQQB32
 XoqzV1f//ZUswF4xRlSsxnytYJs3VJMfejBswh8fapiIujy1OAu1lYKI4050vj9IhbaM
 fqc+HNMM8xluTzIUCRu5jJ/iiXIqYFW9UJB163F+PLuVhxHrCX85EmitnxqqDHhk41IG
 GQtlumxPBu9R7KsU0ns15wQBm6+qpswrjFdRBJRyZ+hGXfOShtla3gvyrOjuvvB+3M4y
 NmoA==
X-Gm-Message-State: AOJu0YzzoAcPBicfg6J+9gDK2pLjF52XkDd95biBouHxGUw4WHrGNZTv
 QOzjAC5uFJRfNQQVjksmrN4pMfND5CLIQvFvqyZ7cNoEuGp8zrl8UDKj7YT9S6CN7ucW2mkdous
 q+7LIrbbgUYX0vRIhDHpS5SUHszs7svFYxCNutBkRSyPX7eO4MqY4JgOj
X-Gm-Gg: AY/fxX6Sr/7PJv3r70gPr6UPkAQuSZhaoj24rHK3sIIxz9qGtLMN0cHuJrTgCyE9Q5J
 rZzPNfEFUmM3cP169p8pE0XsBsaUvbKCvQcb+X67LXxhH/cc67LyWy3Xa2dluHrU9rh8pdBTYkg
 ziRxDNUzDHysW1B/Ongne4+P6lrWhH9hGqGAUqxucvGaIJs+ZVPuP17qsisZL+hz7Pn4/sisOly
 CEI7N1tlcydMb+4jvDdmp88JrU9wq2vPN4w7fx/mRwGtsRaPA8blSwfzxzo3W+D+Du0IXxWATHB
 Hq+HeU5iR4CiJDSY9W5HU4/ZemV8pEjHyL4lC/qmxhVAd4QuKva12AQKQkTGqjwRiJnlcWDEvFM
 4Bfg=
X-Received: by 2002:a05:620a:3910:b0:8c3:6f1e:21ef with SMTP id
 af79cd13be357-8c6a6798f78mr2072307285a.83.1768939971276; 
 Tue, 20 Jan 2026 12:12:51 -0800 (PST)
X-Received: by 2002:a05:620a:3910:b0:8c3:6f1e:21ef with SMTP id
 af79cd13be357-8c6a6798f78mr2072301885a.83.1768939970673; 
 Tue, 20 Jan 2026 12:12:50 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8c6a72508f6sm1103131985a.34.2026.01.20.12.12.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Jan 2026 12:12:50 -0800 (PST)
Date: Tue, 20 Jan 2026 15:12:48 -0500
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Li Zhijian <lizhijian@fujitsu.com>,
 Hailiang Zhang <zhanghailiang@xfusion.com>, Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Zhang Chen <zhangckid@gmail.com>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Prasad Pandit <ppandit@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Yury Kotov <yury-kotov@yandex-team.ru>, Juraj Marcin <jmarcin@redhat.com>
Subject: Re: [PATCH 08/13] migration: Thread-ify precopy vmstate load process
Message-ID: <aW_hwEbY8Y3FyV7P@x1.local>
References: <20251022192612.2737648-9-peterx@redhat.com>
 <87y0m7df46.fsf@suse.de> <aWUYVvFVbhXCdVod@x1.local>
 <871pju1wlv.fsf@suse.de> <aWVim4LDYb4gMQLk@x1.local>
 <87fr89psu5.fsf@suse.de> <aWZ3q3NBBCl5KTYr@x1.local>
 <87jyxhmdp6.fsf@suse.de> <aW-v9YKkDO5bRKBQ@x1.local>
 <87cy34ktd0.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87cy34ktd0.fsf@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.087,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Tue, Jan 20, 2026 at 03:54:19PM -0300, Fabiano Rosas wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > On Fri, Jan 16, 2026 at 06:48:21PM -0300, Fabiano Rosas wrote:
> >> Another one for the pile:
> >> 
> >> #5  0x00007f0beda4fb32 in __assert_fail (assertion=0x55b8c3ed8cb8 "mode >= 0 ...) at assert.c:103
> >> #6  0x000055b8c3a1d7a9 in migrate_mode () at ../migration/options.c:882
> >> #7  0x000055b8c3a1084e in fill_source_migration_info (info=0x55b8f1291650) at ../migration/migration.c:1322
> >> #8  0x000055b8c3a10cae in qmp_query_migrate (errp=0x7fff5742ae80) at ../migration/migration.c:1438
> >> #9  0x000055b8c3d4bc2a in qmp_marshal_query_migrate (args=0x55b8f11f2280, ret=0x7f0becd25da8, errp=0x7f0becd25da0) at qapi/qapi-commands-migration.c:48
> >> #10 0x000055b8c3d9a13b in do_qmp_dispatch_bh (opaque=0x7f0becd25e40) at ../qapi/qmp-dispatch.c:128
> >> #11 0x000055b8c3dc6366 in aio_bh_call (bh=0x55b8f12922d0) at ../util/async.c:173
> >> #12 0x000055b8c3dc6482 in aio_bh_poll (ctx=0x55b8f10741e0) at ../util/async.c:220
> >> #13 0x000055b8c3da9832 in aio_poll (ctx=0x55b8f10741e0, blocking=false) at ../util/aio-posix.c:719
> >> #14 0x000055b8c3cea017 in monitor_cleanup () at ../monitor/monitor.c:676
> >> #15 0x000055b8c39ef646 in qemu_cleanup (status=0) at ../system/runstate.c:999
> >> #16 0x000055b8c3cec38e in qemu_default_main (opaque=0x0) at ../system/main.c:51
> >> #17 0x000055b8c3cec430 in main (argc=33, argv=0x7fff5742b208) at
> >> #../system/main.c:93
> >> 
> >> (gdb) p/x mode
> >> $8 = 0xcccccccc
> >
> > What's the reproducer?  Is it easy to reproduce?
> >
> 
> Just hammering some make check instances in parallel, as usual.
> 
> > I wonder if current_migration released already, or if monitor should still
> > process any QMP handler if the VM is shutting down..
> >
> 
> monitor_cleanup says it will continue dispatching and just never send a
> response to the command. It seems migration will need it's own way of
> tracking this.
> 
> Maybe as a first step we could clear current_migration at
> migration_instance_finalize().
> (I see device-introspect-test doesn't like it. I'll look into it)
> 
> > Is this only happening after this series applied?  I can't yet see how the
> > threadify affected it..
> 
> No, sorry, I posted here because I think this affects this series'
> assumptions about the BQL.

Aha, you reminded me on this work, remember to check it out (I forgot most
of it.. as usual..):

https://lore.kernel.org/qemu-devel/20241029211607.2114845-8-peterx@redhat.com

I also recall besides the singleton idea, we can also take a mutex and
release current_migration at finalize(), then fetch current_migration will
instead need to take a refcount and also with mutex held.

Anyway, thanks for looking into it.  Now, it's all yours. :)

-- 
Peter Xu


