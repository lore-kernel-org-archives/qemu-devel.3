Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A482CA5FAD
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Jan 2026 16:40:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viEmU-0004AD-UB; Tue, 20 Jan 2026 11:40:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1viEmM-00045l-Lb
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 11:40:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1viEmK-0004b7-UZ
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 11:40:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768927227;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=J4bdzK+GQFc6FT9ZvTY7eJHAk92kiMIl8G2Ubr4qVZM=;
 b=gCxpJS+7JyDArCiT2T7co+pcNAt6usyL7G01Ufhv6LN3mmLaCZh+wSu1RYLLxr6PbdVgw+
 9NppE/qn9peI6zDsR/d3/NiPfK9f3uJZg5TL9CyZYFVdYt5WPoCxj75EpNLYGMPEzsvaI7
 cRdjtOwYvefNsj2rZKZfKKpAX00OMU0=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-374-gGZiuKjjOf-m9K5yb5HKlg-1; Tue, 20 Jan 2026 11:40:25 -0500
X-MC-Unique: gGZiuKjjOf-m9K5yb5HKlg-1
X-Mimecast-MFC-AGG-ID: gGZiuKjjOf-m9K5yb5HKlg_1768927225
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-8c6a4c50fe5so186837185a.3
 for <qemu-devel@nongnu.org>; Tue, 20 Jan 2026 08:40:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768927225; x=1769532025; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=J4bdzK+GQFc6FT9ZvTY7eJHAk92kiMIl8G2Ubr4qVZM=;
 b=Glol0YW8pXiRchTmHLkIVmen9F3uknR5AgRS7cUKGyjoGChDQX6saVokKdmaiKDge1
 bvE+MPQdwrFONkpGKvxgvO3p7kTE9h5GTuYTkLyASFQiTWWdRYzrQWvxAo9sJ7/0KUdF
 wcrs/0XR/Ydl1nFffm+cGEMMV6HV7gsGj7T6dMRjRoM2tEbPfIPipx/bOWqby/R2ucQe
 jUkJ4WS1ZdSyxk8bvW6ByvCFQCQbM/6ztXcQIypUVshk9jfAZjNfFeoHW17/mNYpGuEg
 klfTp+ZRCKYKvmKCbRS5+yDk3ZLONLWFw5YuAMe+0Ok1Cq35aCcDUVocD26szfCrjI8a
 sDPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768927225; x=1769532025;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=J4bdzK+GQFc6FT9ZvTY7eJHAk92kiMIl8G2Ubr4qVZM=;
 b=lCVNPmjVzyehTwduKVSxJ9V2yE67mH+NcnVDlJg6DL8jOcF/A+wIgH3UFDY29ZhNjH
 HM27h90yysEm3eCTtgFOQ1W1Po1tZeGdiVNk9Uy4sbkE0/1OvI60CuwNpgAl+fvWO5YD
 hh5wbAoAgeYbyyZe7qzzSpOagHzTn2Gp7PW4yK+tFjHgTmlvlF1PhG2bJuhjX208YuR5
 PZJCmMkRH930PUfSx66VG/yG6qJm3zFnRbR5a5BGDnolWBA4qwNWKS0su5MRAZmy3mew
 60J3KKn7L7TPOOI/k8TXd/KGNktVNb9ABhMtR1kFrm1Dlo3tm9fiwrFALv8RXjDAhztn
 trYA==
X-Gm-Message-State: AOJu0Yy4giu8225vf1x5wsx/J3Mxk41AZB0zcCVQyiNjUneMN4cAgidT
 qHkFAfuBBNGIO3TK0BtZqIuwlCdHZb4Fs50GhWKsXIXQOkZ2Fr1X4gyNrMmzwvftCvsCIKWMaQy
 iUFxUhDJ3kYpU8zG8s7UmuWLfvm6noVCl1u0e4zcQM8QWSLHq7VR3OhRK
X-Gm-Gg: AY/fxX5joxYVE0UEjOHAtV2IRCseE2xJhOB3XaY0VbdyHvpqImdIyj78a18UYu7V9ez
 wQvY3BGr3U6ltP92jonWYUQOxY8HNCfDfMt1eBKztxfgGJBlxE1oAdi8M03pWi0hxVU/hX1nG1Z
 2OByX2Nj3Gilt5RH1NVJA5rddJYkJdQhFcHvGj6OT31mIgaJWY1ok47dEV8sJFTaMO/IJetCvYz
 +4940ia4CLrMhjx0ZoKDCd5bAItBgIcKaK6jwKRn/bQG6UgJaU5d4XqQrhuS0rgxIiN+4CjF+iO
 rQMW4L89KMHXYxemIyzmofSDKXSCb6kzgOvDFXuDOaG4oqgQKZLUmt8+gglK3zlYuup71IAOLA5
 e1jY=
X-Received: by 2002:a05:620a:480b:b0:8b2:f0dd:2a97 with SMTP id
 af79cd13be357-8c6a690623bmr1882420885a.37.1768927224758; 
 Tue, 20 Jan 2026 08:40:24 -0800 (PST)
X-Received: by 2002:a05:620a:480b:b0:8b2:f0dd:2a97 with SMTP id
 af79cd13be357-8c6a690623bmr1882407385a.37.1768927222930; 
 Tue, 20 Jan 2026 08:40:22 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8c6a71c14a9sm1066419485a.22.2026.01.20.08.40.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Jan 2026 08:40:22 -0800 (PST)
Date: Tue, 20 Jan 2026 11:40:21 -0500
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
Message-ID: <aW-v9YKkDO5bRKBQ@x1.local>
References: <20251022192612.2737648-1-peterx@redhat.com>
 <20251022192612.2737648-9-peterx@redhat.com>
 <87y0m7df46.fsf@suse.de> <aWUYVvFVbhXCdVod@x1.local>
 <871pju1wlv.fsf@suse.de> <aWVim4LDYb4gMQLk@x1.local>
 <87fr89psu5.fsf@suse.de> <aWZ3q3NBBCl5KTYr@x1.local>
 <87jyxhmdp6.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87jyxhmdp6.fsf@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.087,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, Jan 16, 2026 at 06:48:21PM -0300, Fabiano Rosas wrote:
> Another one for the pile:
> 
> #5  0x00007f0beda4fb32 in __assert_fail (assertion=0x55b8c3ed8cb8 "mode >= 0 ...) at assert.c:103
> #6  0x000055b8c3a1d7a9 in migrate_mode () at ../migration/options.c:882
> #7  0x000055b8c3a1084e in fill_source_migration_info (info=0x55b8f1291650) at ../migration/migration.c:1322
> #8  0x000055b8c3a10cae in qmp_query_migrate (errp=0x7fff5742ae80) at ../migration/migration.c:1438
> #9  0x000055b8c3d4bc2a in qmp_marshal_query_migrate (args=0x55b8f11f2280, ret=0x7f0becd25da8, errp=0x7f0becd25da0) at qapi/qapi-commands-migration.c:48
> #10 0x000055b8c3d9a13b in do_qmp_dispatch_bh (opaque=0x7f0becd25e40) at ../qapi/qmp-dispatch.c:128
> #11 0x000055b8c3dc6366 in aio_bh_call (bh=0x55b8f12922d0) at ../util/async.c:173
> #12 0x000055b8c3dc6482 in aio_bh_poll (ctx=0x55b8f10741e0) at ../util/async.c:220
> #13 0x000055b8c3da9832 in aio_poll (ctx=0x55b8f10741e0, blocking=false) at ../util/aio-posix.c:719
> #14 0x000055b8c3cea017 in monitor_cleanup () at ../monitor/monitor.c:676
> #15 0x000055b8c39ef646 in qemu_cleanup (status=0) at ../system/runstate.c:999
> #16 0x000055b8c3cec38e in qemu_default_main (opaque=0x0) at ../system/main.c:51
> #17 0x000055b8c3cec430 in main (argc=33, argv=0x7fff5742b208) at
> #../system/main.c:93
> 
> (gdb) p/x mode
> $8 = 0xcccccccc

What's the reproducer?  Is it easy to reproduce?

I wonder if current_migration released already, or if monitor should still
process any QMP handler if the VM is shutting down..

Is this only happening after this series applied?  I can't yet see how the
threadify affected it..

-- 
Peter Xu


