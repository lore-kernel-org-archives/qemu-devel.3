Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6B76C3ABC3
	for <qemu-devel@archiver.kernel.org>; Tue, 13 May 2025 22:10:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uExoe-0005yY-6u; Tue, 13 May 2025 18:09:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uExob-0005yD-KF
 for qemu-devel@nongnu.org; Tue, 13 May 2025 18:09:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uExoY-0006Fa-Vc
 for qemu-devel@nongnu.org; Tue, 13 May 2025 18:09:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747174169;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Zu3c3yQaJI0eTdrhBLkZbEuJZdjCafKQO0sgBG9wQOg=;
 b=JvcldTcj1yXMc10uuOswJ4k6oEnk7QjpIKHC7QO1MmFH7/C8csdS7bV2mBdnuzexnqRD/E
 Bf4mJN3pH1cdNkyGgvyFcuY8gKXqMihiDJASqS+bTnmpDMy7CzS53svtm1K7m15daiq99l
 ACzXq6VQDcxBY0/mowmXT3QDf74Gw18=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-425-mm8ebHdoN3C_qr2xUxyf9Q-1; Tue, 13 May 2025 18:09:28 -0400
X-MC-Unique: mm8ebHdoN3C_qr2xUxyf9Q-1
X-Mimecast-MFC-AGG-ID: mm8ebHdoN3C_qr2xUxyf9Q_1747174168
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-6f53f748240so151207426d6.3
 for <qemu-devel@nongnu.org>; Tue, 13 May 2025 15:09:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747174167; x=1747778967;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Zu3c3yQaJI0eTdrhBLkZbEuJZdjCafKQO0sgBG9wQOg=;
 b=woMndpv1RLdUhXoJH3tZ1nl4bTZffjml656dR9UQ1/3zU0SNBt++4vGpJkLQesSVLq
 7KVoMGnDvALRm6/Hd48S+zgmWM5wWUliAmoZgaJGJPyBk1fjBMe4BRZuEp3wzQyrpX76
 5tDfLJod6zDF6Q7U3yKobtzRQJOyLcIatFSQBqP7IgwrVP2fevxq4Bm0dOxyV7ib1+5H
 u0p5hMJ+aIQVhkcMm+ITPH5sX7jrsYg7ENNyGXEDl0TAfiILmGGgfwwKfiuddyxBNy0U
 9yeTInW8OjHM7W8coCNQkUzA1tUihGAYbXBdy41RYX+KeuOOkkUa//rtldDb1JhFZsjE
 lOJQ==
X-Gm-Message-State: AOJu0YyeAi5HDVrK0ucVqziK2a+YP5X2U04kQPmCEqV5ox0l4r67t9B4
 vBOaN41aA1PgOv2rMdQJrq8GHUAs5XeO0AGN4HKW0RJE8zGJrm+ssoRP3vy5Eo5EboTkzc8Eyjg
 Pa1w+6IVOxChBYmD9Y0z0suGi7iLJ3KiJA5S0A03K5heLdWH6syi7p3oV+Y3rCzZAR/CkHEno2z
 DgipvKic5VT5ssNAaINKoa0SaIB8QFtLEw4w==
X-Gm-Gg: ASbGncv7x/S7DXGAoQsprXF29+nOttvPywfDDcNCkObQhV7bbc0tGhGzEICskHln3za
 PP51BX12mIq1yugmXDqyaYvFFa0hOYONmRqW1QpVCPikwdeeKUSVhupWvGswKIEj13D3q+jAX0A
 G/vckXxS8YEeKJvTaElK2mjR4Be9w9jTqdpoPs31GX4jfevRFP1buZhWyqerGpynT5rem993chv
 3yZrihkaf+F0NJ9QLtWhwvz4IWd0i6S8n/tXZwW4K+8FBGnTC4paRjxbgouP2P/2oUmXIABgsA5
X-Received: by 2002:a05:6214:400c:b0:6e4:4011:9df7 with SMTP id
 6a1803df08f44-6f896e3fdc3mr18536606d6.16.1747174166924; 
 Tue, 13 May 2025 15:09:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGIIz44PsQdxAa3TgeblnHt6ptETuqLhTvM0mqdmS5gVzZIrMelq2ZObxcEy8vbkp/lOrQFHw==
X-Received: by 2002:a05:6214:400c:b0:6e4:4011:9df7 with SMTP id
 6a1803df08f44-6f896e3fdc3mr18536136d6.16.1747174166461; 
 Tue, 13 May 2025 15:09:26 -0700 (PDT)
Received: from x1.com ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6f6e3a0c5e3sm71708616d6.63.2025.05.13.15.09.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 May 2025 15:09:25 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Prasad Pandit <ppandit@redhat.com>,
 Juraj Marcin <jmarcin@redhat.com>,
 "Dr . David Alan Gilbert" <dave@treblig.org>, peterx@redhat.com
Subject: [PATCH 0/3] migration: Some fix and enhancements to HMP "info migrate"
Date: Tue, 13 May 2025 18:09:20 -0400
Message-ID: <20250513220923.518025-1-peterx@redhat.com>
X-Mailer: git-send-email 2.49.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.549,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Patch 1 was a bug I found set capabilities, so it's pretty separate issue.

Patch 2-3 was an attempt that I made the HMP "info migrate" looks slightly
easier to read.  For me, it was almost never able to show correctly on what
I cared before in the current screen but I'll always need to scroll, as
it's normally very long.

I made it pretty condensed here, the new one looks like this now:

(qemu) info migrate
Status: postcopy-active
Time (ms): total=40504, setup=14, down=145
RAM info:
  Bandwidth (mbps): 6102.65
  Sizes (KB): psize=4, total=16777992
    transferred=37673019, remain=2136404,
    precopy=3, multifd=26108780, postcopy=11563855
  Pages: normal=9394288, zero=600672, rate_per_sec=185875
  Others: dirty_syncs=3, dirty_pages_rate=278378, postcopy_req=4078

Comments welcomed, thanks.

Peter Xu (3):
  migration: Allow caps to be set when preempt or multifd cap enabled
  migration/hmp: Dump global in "info migrate_parameters" instead
  migration/hmp: Add "info migrate -a", reorg the dump

 migration/migration-hmp-cmds.c | 162 +++++++++++++++++----------------
 migration/options.c            |   4 +-
 hmp-commands-info.hx           |   6 +-
 3 files changed, 89 insertions(+), 83 deletions(-)

-- 
2.49.0


