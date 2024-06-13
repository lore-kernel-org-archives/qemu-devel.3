Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0787C27C6E
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2024 16:46:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHnZe-0003nj-FT; Thu, 13 Jun 2024 12:45:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sHnZd-0003nS-NW
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 12:45:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sHnZb-0007Gr-MM
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 12:45:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718297114;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RJk5AynidtytXu7RNnpAvBQjJGP0NFUo2Q+bpi4JW8A=;
 b=Yr/ZagBV7Cb7D+btXZhI0b5XoMvGQ8oIQ73/4cSgMzyVuzO2AUkBmJOcWedxELX8sAiZWc
 2dv0bvoAN7d4+zLK2wUp5uycskjK8dhpl0SvPSJ5+rAcjtPHQKPEsjwGhhK0cx6WSZ15jB
 V29qSY1VTTVQMCT45DtcvAFILG9g9B8=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-587-JtsNp5MPNkuHau01hhCJGw-1; Thu, 13 Jun 2024 12:45:13 -0400
X-MC-Unique: JtsNp5MPNkuHau01hhCJGw-1
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-440aedca77cso3447861cf.1
 for <qemu-devel@nongnu.org>; Thu, 13 Jun 2024 09:45:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718297110; x=1718901910;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RJk5AynidtytXu7RNnpAvBQjJGP0NFUo2Q+bpi4JW8A=;
 b=euLqR7ZQv+vtRThatdB6wRUX3cp0dx5LL4nWgqEM0Gv8Z02+AfAeWmZ0DvdD9ZK6SN
 g20yXWBPGTC2LaPUIwoFvsVjx08bKa1PyYW97jgx26OlQLH4YmX5mEgPNqpdjd+sWuJD
 b3u3lY6erxDacYrg5RqFOtTfeCSTZbm1hfRvE4hfO556ia2y0PYvpZs9ALL1mHX89RUS
 KA4i4o0kFTptD30IfiqFTbPqt+08yqif3Tpzx+/gLQZfNYeqVTJTJEKVARVlDwZPHLi4
 5EuYdmWz8EcDSegHXxbNMzv8iRaeG/T8nMDw+rKsPy4F0tpciaJKsL6h/UEc1A/EVpgk
 /bNQ==
X-Gm-Message-State: AOJu0Yx2vdAQU5sPiA977F4pSrF0gzWWax5D/N+KdYOMpQ3/npjGjv2g
 MNAmh9KlqnKC8DgHyCiqBPwKSzlIMTZZ9/TKAy6N5sUTTfMbCIwMvPOVeaeAEOqfx7QM0ziF8u7
 zi7aEOdLSEKv6h31dzZ2krc4NiyYwvnK+EJtuCX5cLsG81IUQkp/byp+WfXrQERfQwKFh/J5fDo
 FDfSFjQzTgeO0qYqPLC3GBwQ5G/Er+BWGeDw==
X-Received: by 2002:a05:6214:f6f:b0:6b0:7165:ca6f with SMTP id
 6a1803df08f44-6b2b018a031mr415876d6.6.1718297109615; 
 Thu, 13 Jun 2024 09:45:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHRlXcsolzy4mOC6BStBQ8oC6LSZcmwZOf05GnJuKMalwVS2j63YFO92F2atvrP091GlUjGDA==
X-Received: by 2002:a05:6214:f6f:b0:6b0:7165:ca6f with SMTP id
 6a1803df08f44-6b2b018a031mr415416d6.6.1718297108866; 
 Thu, 13 Jun 2024 09:45:08 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-441ef50497dsm7673021cf.36.2024.06.13.09.45.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Jun 2024 09:45:08 -0700 (PDT)
Date: Thu, 13 Jun 2024 12:45:06 -0400
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Jiri Denemark <jdenemar@redhat.com>, Prasad Pandit <ppandit@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Bandan Das <bdas@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH 0/4] migration: New postcopy state, and some cleanups
Message-ID: <ZmsiEr6kehDBYzFo@x1n>
References: <20240612144228.1179240-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240612144228.1179240-1-peterx@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.145,
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

On Wed, Jun 12, 2024 at 10:42:24AM -0400, Peter Xu wrote:
> The major goal of this patchset is patch 4, which introduced a new postcopy
> state so that we will send an event in postcopy reconnect failures that
> Libvirt would prefer to have.  There's more information for that issue in
> the commit message alone.
> 
> Patch 1-2 are cleanups that are not directly relevant but I found/stored
> that could be good to have.  I made it simple by putting them together in
> one thread to make patch management easier, but I can send them separately
> when necessary.
> 
> Patch 3 is also a cleanup, but will be needed for patch 4 as dependency.
> 
> Comments welcomed, thanks.
> 
> CI: https://gitlab.com/peterx/qemu/-/pipelines/1328309702
>     (msys2-64bit is failing, but doesn't look relevant)

I forgot to update the doc file, I'll attach one more patch when repost,
attached here for early comments.

I also forgot to copy QAPI maintainers; It turns out I start to forget how
to send patches.. sorry. I'll do that in v2.

===8<===
From b4693c1576fb3741ca25962bd91f31c2afb60863 Mon Sep 17 00:00:00 2001
From: Peter Xu <peterx@redhat.com>
Date: Wed, 12 Jun 2024 11:18:27 -0400
Subject: [PATCH] migration/docs: Update postcopy recover session for SETUP
 phase

Firstly, the "Paused" state was added in the wrong place before. The state
machine section was describing PostcopyState, rather than MigrationStatus.
Drop the Paused state descriptions.

Then in the postcopy recover session, add more information on the state
machine for MigrationStatus in the lines.  Add the new RECOVER_SETUP phase.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 docs/devel/migration/postcopy.rst | 31 ++++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/docs/devel/migration/postcopy.rst b/docs/devel/migration/postcopy.rst
index 6c51e96d79..a15594e11f 100644
--- a/docs/devel/migration/postcopy.rst
+++ b/docs/devel/migration/postcopy.rst
@@ -99,17 +99,6 @@ ADVISE->DISCARD->LISTEN->RUNNING->END
     (although it can't do the cleanup it would do as it
     finishes a normal migration).
 
- - Paused
-
-    Postcopy can run into a paused state (normally on both sides when
-    happens), where all threads will be temporarily halted mostly due to
-    network errors.  When reaching paused state, migration will make sure
-    the qemu binary on both sides maintain the data without corrupting
-    the VM.  To continue the migration, the admin needs to fix the
-    migration channel using the QMP command 'migrate-recover' on the
-    destination node, then resume the migration using QMP command 'migrate'
-    again on source node, with resume=true flag set.
-
  - End
 
     The listen thread can now quit, and perform the cleanup of migration
@@ -221,7 +210,8 @@ paused postcopy migration.
 
 The recovery phase normally contains a few steps:
 
-  - When network issue occurs, both QEMU will go into PAUSED state
+  - When network issue occurs, both QEMU will go into **POSTCOPY_PAUSED**
+    migration state.
 
   - When the network is recovered (or a new network is provided), the admin
     can setup the new channel for migration using QMP command
@@ -229,9 +219,20 @@ The recovery phase normally contains a few steps:
 
   - On source host, the admin can continue the interrupted postcopy
     migration using QMP command 'migrate' with resume=true flag set.
-
-  - After the connection is re-established, QEMU will continue the postcopy
-    migration on both sides.
+    Source QEMU will go into **POSTCOPY_RECOVER_SETUP** state trying to
+    re-establish the channels.
+
+  - When both sides of QEMU successfully reconnects using a new or fixed up
+    channel, they will go into **POSTCOPY_RECOVER** state, some handshake
+    procedure will be needed to properly synchronize the VM states between
+    the two QEMUs to continue the postcopy migration.  For example, there
+    can be pages sent right during the window when the network is
+    interrupted, then the handshake will guarantee pages lost in-flight
+    will be resent again.
+
+  - After a proper handshake synchronization, QEMU will continue the
+    postcopy migration on both sides and go back to **POSTCOPY_ACTIVE**
+    state.  Postcopy migration will continue.
 
 During a paused postcopy migration, the VM can logically still continue
 running, and it will not be impacted from any page access to pages that
-- 
2.45.0


-- 
Peter Xu


