Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 164D1E7717F
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 20:49:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLq6c-0003Zg-Of; Thu, 12 Dec 2024 15:48:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tLq6b-0003Yz-4J
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 15:48:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tLq6X-0000tg-VZ
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 15:48:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734036487;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Nn85WydizSTH87FoQvlMn/9B+FNHjtBxFLnjNfiB2TY=;
 b=jGBa83GBRGqF1irlLRunqmDA+FRFFaWmuN8goMa5LBNQBJek70VDdec1YIKJ1BuIx1UrZZ
 wlB0PwXNDmnUo8BwrtubHmCmJLl19M1erGS0jB/IERgNw+04WTj5SMFGPA8JA1I8uCe+j9
 rPG2bi7ttffIrxbQSg1PFCdRqfzQjso=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-687-M2v_8kpYOpeTRKFi5VPLwA-1; Thu, 12 Dec 2024 15:48:05 -0500
X-MC-Unique: M2v_8kpYOpeTRKFi5VPLwA-1
X-Mimecast-MFC-AGG-ID: M2v_8kpYOpeTRKFi5VPLwA
Received: by mail-io1-f71.google.com with SMTP id
 ca18e2360f4ac-844d2a7ef6dso173351839f.0
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2024 12:48:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734036484; x=1734641284;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Nn85WydizSTH87FoQvlMn/9B+FNHjtBxFLnjNfiB2TY=;
 b=Hqw7qczZkKQ5VLaWUa27LwRmDKXC8cUPO7QpRtx4z/YWXSIAa75OdXtAuOEQpTb0xS
 xBZ/DjpWpLVf+JT6zSEZvXXCG0RZnl/J9Z8YIYbIUH/Ymzb/nI+iWFzDPMF8jKAV5yew
 xanpMNOp/eNBez+WKnWJmaYVognX4FJMhHAeyM1+N6seY30Nq1JqQlclGuCxsN9BhBiJ
 lQPGOiIJFcRPaVzHs4fhru+9SLLLE9Y3yJcmM7RaSSvtQ7pzB/9/b8EJHkt7tImDw/+8
 88rARs+KLTbJFTiDyuw2z58kHTujnghiv9l0mKBzm21AeWyGKR6bY9uBeJmF54mXIIal
 bSHg==
X-Gm-Message-State: AOJu0Yw6sY19t0GGjO8V7nO/PGzq3zImaYyHfgyPIZxdDgX95T31EZUI
 NuIYh6yXVdiVtlYUkwcugA8giPqX4+NBohqQnvuHyW+pHKpWaZZkBsD6PnFSKF9u/KIpeNH3HK+
 38k2QS4Njb/Svf4Md00tCgHL6qx0BvMMRksf/n9gJGXM9f+jZu9ld3eUa1cMw39p29R2CuHruw+
 LLvaYROk+Og7Ne0he9M5G+jQlJAH0k/6QjyQ==
X-Gm-Gg: ASbGnctX6qMnAq8co26zIwlvAD9EgSajCasjuqomHXpuLS65IhSY4ADW8kFXPdeexem
 BLFTiMTel/cZlpGSTPfLytYK6/nJVxhUjd9JcfXRMnNi0WLA3xIL5uV4RsA+fcVYuR7qFhxjM1x
 Kk18kCytRNbY4ke9BSOygD3XUjPd3BStSDVUe4xeWGHNCs0ANfnqyQOok+nUnVamkh/vkqPOBFV
 K852YInlUgGoeC5m80emjyAdziEZ0YQGmHQFTPHGFd5XSd6Ju+hMKhHeZUm+Li2H8EWC5B69eXY
 m6lW3KMrzfPzpDI8+LWqebc/y1AbbzFM
X-Received: by 2002:a05:6602:6d89:b0:841:81ef:70b9 with SMTP id
 ca18e2360f4ac-844e8b080e9mr32244939f.9.1734036483832; 
 Thu, 12 Dec 2024 12:48:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHs/1TMongD72F+Bd44I+CwZc4+LLxYE89RFASmSIbZYNzDd9j+wBoM5CrNral3zf21N4O/Jg==
X-Received: by 2002:a05:6602:6d89:b0:841:81ef:70b9 with SMTP id
 ca18e2360f4ac-844e8b080e9mr32241739f.9.1734036483418; 
 Thu, 12 Dec 2024 12:48:03 -0800 (PST)
Received: from x1n.redhat.com (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-844e57b48fcsm20807839f.35.2024.12.12.12.48.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Dec 2024 12:48:02 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 peterx@redhat.com, Peter Maydell <peter.maydell@linaro.org>,
 s_sourceforge@nedprod.com, Maxim Levitsky <mlevitsk@redhat.com>
Subject: [PATCH v2 0/3] scripts/qemu-gdb: Make coroutine dumps to work with
 coredumps
Date: Thu, 12 Dec 2024 15:47:58 -0500
Message-ID: <20241212204801.1420528-1-peterx@redhat.com>
X-Mailer: git-send-email 2.47.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.496,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

v1: https://lore.kernel.org/r/20241211201739.1380222-1-peterx@redhat.com

Changelog: in previous v1, I got a wrong cut-off accident in commit
message, which is now fixed (along with some small touchup elsewhere).
When at it, I also tried to make it look even better to be as close as gdb
bt, so it looks like this now:

  Coroutine at 0x7f9f4c57c748:
  #0  0x55ae6c0dc9a8 in qemu_coroutine_switch<+120> () at ../util/coroutine-ucontext.c:321
  #1  0x55ae6c0da2f8 in qemu_aio_coroutine_enter<+356> () at ../util/qemu-coroutine.c:293
  #2  0x55ae6c0da3f1 in qemu_coroutine_enter<+34> () at ../util/qemu-coroutine.c:316
  #3  0x55ae6baf775e in migration_incoming_process<+43> () at ../migration/migration.c:876
  #4  0x55ae6baf7ab4 in migration_ioc_process_incoming<+490> () at ../migration/migration.c:1008
  #5  0x55ae6bae9ae7 in migration_channel_process_incoming<+145> () at ../migration/channel.c:45
  #6  0x55ae6bb18e35 in socket_accept_incoming_migration<+118> () at ../migration/socket.c:132
  #7  0x55ae6be939ef in qio_net_listener_channel_func<+131> () at ../io/net-listener.c:54
  #8  0x55ae6be8ce1a in qio_channel_fd_source_dispatch<+78> () at ../io/channel-watch.c:84
  #9  0x7f9f5b26728c in g_main_context_dispatch_unlocked.lto_priv<+315> ()
  #10  0x7f9f5b267555 in g_main_context_dispatch<+36> ()
  #11  0x55ae6c0d91a7 in glib_pollfds_poll<+90> () at ../util/main-loop.c:287
  #12  0x55ae6c0d9235 in os_host_main_loop_wait<+128> () at ../util/main-loop.c:310
  #13  0x55ae6c0d9364 in main_loop_wait<+203> () at ../util/main-loop.c:589
  #14  0x55ae6bac212a in qemu_main_loop<+41> () at ../system/runstate.c:835
  #15  0x55ae6bfdf522 in qemu_default_main<+19> () at ../system/main.c:37
  #16  0x55ae6bfdf55f in main<+40> () at ../system/main.c:48
  #17  0x7f9f59d42248 in __libc_start_call_main<+119> ()
  #18  0x7f9f59d4230b in __libc_start_main_impl<+138> ()

Coroutines are used in many cases in block layers. It's also used in live
migration when on destination side, and it'll be handy to diagnose crashes
within a coroutine when we want to also know what other coroutines are
doing.

This series adds initial support for that, not pretty but it should start
working.  Since we can't use the trick to modify registers on the fly in
non-live gdb sessions, we do manual unwinds.

One thing to mention is there's a similar but more generic solution
mentioned on the list from Niall:

https://lore.kernel.org/r/f0ebccca-7a17-4da8-ac4a-71cf6d69abc3@mtasv.net

That adds more dependency on both gdb and qemu in the future, however more
generic.  So this series is an intermediate quick solution as for now,
which should work for most older qemu/gdb binaries too.

Thanks,

Peter Xu (3):
  scripts/qemu-gdb: Always do full stack dump for python errors
  scripts/qemu-gdb: Simplify fs_base fetching for coroutines
  scripts/qemu-gdb: Support coroutine dumps in coredumps

 scripts/qemu-gdb.py          |   2 +
 scripts/qemugdb/coroutine.py | 102 +++++++++++++++++++++++++----------
 2 files changed, 77 insertions(+), 27 deletions(-)

-- 
2.47.0


