Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AA61C5475B
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Mar 2024 03:42:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ri4e4-0000nF-JS; Wed, 06 Mar 2024 22:42:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1ri4e2-0000ms-OA
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 22:42:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1ri4e0-0002H2-PM
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 22:42:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709782927;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mXgI93MvArIHZk0roA8hzXyEZjpMVU6Y/TtLoru20Oc=;
 b=FLhW/PZKPk9LL291rvJUGHubqI309IKCg+YwDhlCDLZhFRKAw2E9qFpJSENCeG4M37owdO
 B5kB852XKmHXOG4TEZ9ta2AXaX8vwOdZp50UWKD1dku88D8N77CBh6PHkpRyqtjt7gRbNA
 OAtp0Wk2dZH4Si1+VwImF61HkVpskt4=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-49-Qwv3SbraP-CTVY9NktJJsw-1; Wed, 06 Mar 2024 22:42:05 -0500
X-MC-Unique: Qwv3SbraP-CTVY9NktJJsw-1
Received: by mail-ot1-f70.google.com with SMTP id
 46e09a7af769-6e4fe655c93so183790a34.1
 for <qemu-devel@nongnu.org>; Wed, 06 Mar 2024 19:42:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709782621; x=1710387421;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mXgI93MvArIHZk0roA8hzXyEZjpMVU6Y/TtLoru20Oc=;
 b=wmGpn2NlnoIb8/0DImRG3giD3wuEVm1bKAxXLhzNkhyuDJR9ub+GJKdC6LrCUNy1s3
 GoRRLMxv1/voH24CTu5DbeCXKYzdhfepC0a14sxkjLQVGpds6onu6nvn+NAT9lJr7in4
 zfcC5OM36u2F8zfi5XdRFvVvuS6FJAANWHD9e+NDn50c3rGHORWqzh6354V5jJp1rAnB
 Y5nDmymJyV5v10drbtNpx4qDiSWNUr119joh95AMOqwKKHYKETDD4kYHQOXwr3c9vfNK
 cP3DMd0jN0V7YUugi7z6CFdHub5GmqM2S/F3zQltGKAoupBvllVkrfNy2F/U1dV+F+QE
 JfGg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU3NADsc/OKIEQQsAMKfr7IrYP9golAo68+F6GpK5TQyKFbFP0T9u94aLBJj1BCM/WkAEemnw3iw3u68DHFVFukijMmb7Y=
X-Gm-Message-State: AOJu0YyEmtKvfLhkJ6MBFAvLRi7xODN3dle0khJ1dQwiot1bC/GBbM/Y
 kAQRiypzq490T3jwTFyGVVFpqtF+t4i9YRjSR4jGG9UR7obd8T8VJJf/ZIV4M0ecyPcC6Z+6RHz
 0DkLIHkSCig1FpkFy53z8lMqcgCFgB22xxSpZUwG9gLFWE5kHQ/i5
X-Received: by 2002:a05:6358:590c:b0:178:f482:6e59 with SMTP id
 g12-20020a056358590c00b00178f4826e59mr1059185rwf.3.1709782620980; 
 Wed, 06 Mar 2024 19:37:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFGHe2vSGDQ52w/jnag9+ORPF/RTl2ZvzLZVd2U+JQrmS+aHrXhLvsC2CMrGpaqhg5hKTuAFQ==
X-Received: by 2002:a05:6358:590c:b0:178:f482:6e59 with SMTP id
 g12-20020a056358590c00b00178f4826e59mr1059179rwf.3.1709782620544; 
 Wed, 06 Mar 2024 19:37:00 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 h11-20020a63210b000000b005e2b0671987sm11600738pgh.51.2024.03.06.19.36.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Mar 2024 19:37:00 -0800 (PST)
Date: Thu, 7 Mar 2024 11:36:48 +0800
From: Peter Xu <peterx@redhat.com>
To: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yu Zhang <yu.zhang@ionos.com>, Het Gala <het.gala@nutanix.com>,
 qemu-devel <qemu-devel@nongnu.org>, Fabiano Rosas <farosas@suse.de>,
 Jinpu Wang <jinpu.wang@ionos.com>,
 Alexei Pastuchov <alexei.pastuchov@ionos.com>,
 Elmar Gerdes <elmar.gerdes@ionos.com>
Subject: Re: Problem with migration/rdma
Message-ID: <Zek2UFoAyVrC7yh6@x1n>
References: <CAHEcVy7HXSwn4Ow_Kog+Q+TN6f_kMeiCHevz1qGM-fbxBPp1hQ@mail.gmail.com>
 <04da4267-8fe8-4653-90a2-f64e3be64037@linaro.org>
 <a0d9e2c2-3687-4b7d-8fac-887ce262c38a@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a0d9e2c2-3687-4b7d-8fac-887ce262c38a@fujitsu.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.365,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On Thu, Mar 07, 2024 at 02:41:37AM +0000, Zhijian Li (Fujitsu) via wrote:
> Yu,
> 
> 
> On 07/03/2024 00:30, Philippe Mathieu-Daudé wrote:
> > Cc'ing RDMA migration reviewers/maintainers:
> > 
> > $ ./scripts/get_maintainer.pl -f migration/rdma.c
> > Li Zhijian <lizhijian@fujitsu.com> (reviewer:RDMA Migration)
> > Peter Xu <peterx@redhat.com> (maintainer:Migration)
> > Fabiano Rosas <farosas@suse.de> (maintainer:Migration)
> > 
> > On 5/3/24 22:32, Yu Zhang wrote:
> >> Hello Het and all,
> >>
> >> while I was testing qemu-8.2, I saw a lot of our migration test cases failed.
> >> After debugging the commits of the 8.2 branch, I saw the issue and mad a diff:
> >>
> >> diff --git a/migration/rdma.c b/migration/rdma.c
> >> index 6a29e53daf..f10d56f556 100644
> >> --- a/migration/rdma.c
> >> +++ b/migration/rdma.c
> >> @@ -3353,9 +3353,9 @@ static int qemu_rdma_accept(RDMAContext *rdma)
> >>           goto err_rdma_dest_wait;
> >>       }
> >>
> >> -    isock->host = rdma->host;
> >> +    isock->host = g_strdup_printf("%s", rdma->host);
> >>       isock->port = g_strdup_printf("%d", rdma->port);
> 
> 
> Thanks for your analysis.
> 
> It will be great if you send this as a patch.
> 
> 
> isock is defined as a _autoptr VVV
> 3333 _autoptr(InetSocketAddress) isock = g_new0(InetSocketAddress, 1);
> 
> I'm surprised that it seems the auto free scheme will free the member of isock as well
> see below valrind log. That will cause a double free.

Right, all the QAPI-free is a deep one.  Thanks for checking this up,
Zhijian.

Yu, would you please send a formal patch (better before this week ends) so
that I can include it for the last pull for 9.0 soft-freeze (March 12th)?
As 8.2 affected, please also attach proper tags:

Cc: qemu-stable <qemu-stable@nongnu.org>
Fixes: 3fa9642ff7 ("migration: convert rdma backend to accept MigrateAddress")

> 
> ==809138== Invalid free() / delete / delete[] / realloc()
> ==809138==    at 0x483A9F5: free (vg_replace_malloc.c:538)
> ==809138==    by 0x598F70C: g_free (in /usr/lib64/libglib-2.0.so.0.6600.8)
> ==809138==    by 0x79B6AD: qemu_rdma_cleanup (rdma.c:2432)
> ==809138==    by 0x79CEE6: qio_channel_rdma_close_rcu (rdma.c:3108)
> ==809138==    by 0xC2E339: call_rcu_thread (rcu.c:301)
> ==809138==    by 0xC2116A: qemu_thread_start (qemu-thread-posix.c:541)
> ==809138==    by 0x72683F8: ??? (in /usr/lib64/libpthread-2.32.so)
> ==809138==    by 0x73824C2: clone (in /usr/lib64/libc-2.32.so)
> ==809138==  Address 0x13daa070 is 0 bytes inside a block of size 14 free'd
> ==809138==    at 0x483A9F5: free (vg_replace_malloc.c:538)
> ==809138==    by 0x598F70C: g_free (in /usr/lib64/libglib-2.0.so.0.6600.8)
> ==809138==    by 0xC058CF: qapi_dealloc_type_str (qapi-dealloc-visitor.c:68)
> ==809138==    by 0xC09EF3: visit_type_str (qapi-visit-core.c:349)
> ==809138==    by 0xBDDECC: visit_type_InetSocketAddressBase_members (qapi-visit-sockets.c:29)
> ==809138==    by 0xBDE055: visit_type_InetSocketAddress_members (qapi-visit-sockets.c:67)
> ==809138==    by 0xBDE30D: visit_type_InetSocketAddress (qapi-visit-sockets.c:119)
> ==809138==    by 0xBDDB38: qapi_free_InetSocketAddress (qapi-types-sockets.c:51)
> ==809138==    by 0x792351: glib_autoptr_clear_InetSocketAddress (qapi-types-sockets.h:109)
> ==809138==    by 0x79236F: glib_autoptr_cleanup_InetSocketAddress (qapi-types-sockets.h:109)
> ==809138==    by 0x79D956: qemu_rdma_accept (rdma.c:3341)
> ==809138==    by 0x79F05A: rdma_accept_incoming_migration (rdma.c:4041)
> ==809138==  Block was alloc'd at
> ==809138==    at 0x4839809: malloc (vg_replace_malloc.c:307)
> ==809138==    by 0x5992BB8: g_malloc (in /usr/lib64/libglib-2.0.so.0.6600.8)
> ==809138==    by 0x59A7FE3: g_strdup (in /usr/lib64/libglib-2.0.so.0.6600.8)
> ==809138==    by 0x79C2A8: qemu_rdma_data_init (rdma.c:2731)
> ==809138==    by 0x79F183: rdma_start_incoming_migration (rdma.c:4081)
> ==809138==    by 0x76F200: qemu_start_incoming_migration (migration.c:581)
> ==809138==    by 0x77193A: qmp_migrate_incoming (migration.c:1735)
> ==809138==    by 0x74B3D3: qmp_x_exit_preconfig (vl.c:2718)
> ==809138==    by 0x74DB6F: qemu_init (vl.c:3753)
> ==809138==    by 0xA14F3F: main (main.c:47)

-- 
Peter Xu


