Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3965DC54E41
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Mar 2024 00:15:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ri1Pb-0002sy-OM; Wed, 06 Mar 2024 19:15:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1ri1Pa-0002sl-IT
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 19:15:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1ri1PY-0007sK-Np
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 19:15:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709770499;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=W8G8PpZqFA/uVDbGya+JXbZO+YcoIxy06Z1t6yPZvRI=;
 b=O5DGJiP/Brl706BUM4q8NAwcZ6De1T4jdSN6UtWESXq3IEyFIUhkqF69ChBxISpiaJPQrC
 eMwcL/xl1kdVi9lxaShmZiyhE6dcQ/Y5e6oVi/+Kn3hktdFqwZ9Stb7e9ic7+hfdnQhHSf
 3TZCkBZHARH2Uc8+LrymYE3RPt1HM0k=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-543-ko_5A-xZNPysnQjB0zyVmA-1; Wed, 06 Mar 2024 19:14:57 -0500
X-MC-Unique: ko_5A-xZNPysnQjB0zyVmA-1
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-1dc2d4c7310so827775ad.0
 for <qemu-devel@nongnu.org>; Wed, 06 Mar 2024 16:14:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709770497; x=1710375297;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=W8G8PpZqFA/uVDbGya+JXbZO+YcoIxy06Z1t6yPZvRI=;
 b=EH/sdIHe0eDPqRbq+a4z7itjnyM/iVDn7gf4I451FTouTEcaJE++vm8/MRggDLDxb+
 vlkWvk9PUfN4SrkJsav31y4h8EW0+T3uhbtNwGWaISKNYWObfvPcCNvn96l7VfmUEr4o
 I17jeHOGHc+PNsKKHAWN6KR6tBamF1erpgrnSRJM16ybJGZGFRWIYZIqjTpNAyKS93G3
 a1koQQwt3YdLwDyDSTxzT6dI9xdCOYldRAf1S6OfaUhTXT1ydtmjxnhmsNitIuSMSc33
 EYhiJyZZdh6NuraVHkNwpElqNkAP3qjRHUxThxIYgwqS07xRNecDhIdSQYUGJZHst2yU
 pUiA==
X-Gm-Message-State: AOJu0Yy5ZfkvzS+dBYbXIR43BpPk9brAIuwqSk5iWCUGgS/jboV+7ZH3
 i1MIdiGCRPD0RNbpOADnt0EDBIgM9ZPPJ2JaTIE6N2Cz8gGbyHzmE1gwCK+32xz8QNGQdkmRb4t
 JLFkdn4jVMFITD9lmrXXGtoqera3ZdVM4y53OA7UcHwTXXUlZjyf/
X-Received: by 2002:a17:902:ea06:b0:1dd:e36:1b8a with SMTP id
 s6-20020a170902ea0600b001dd0e361b8amr601653plg.1.1709770496910; 
 Wed, 06 Mar 2024 16:14:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHG29T3vIVVQRRXMVAxKUzRWNdWsGgiXXr/Bnecz4l54Crju5R1xGO5DIz+SDrElOxisqV88w==
X-Received: by 2002:a17:902:ea06:b0:1dd:e36:1b8a with SMTP id
 s6-20020a170902ea0600b001dd0e361b8amr601641plg.1.1709770496507; 
 Wed, 06 Mar 2024 16:14:56 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 le8-20020a170902fb0800b001dc8db3150asm13256697plb.199.2024.03.06.16.14.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Mar 2024 16:14:56 -0800 (PST)
Date: Thu, 7 Mar 2024 08:14:49 +0800
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, berrange@redhat.com
Subject: Re: [PATCH v2] migration/multifd: Don't fsync when closing
 QIOChannelFile
Message-ID: <ZekG-fTq51VRJFz1@x1n>
References: <20240305195629.9922-1-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240305195629.9922-1-farosas@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.365,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Tue, Mar 05, 2024 at 04:56:29PM -0300, Fabiano Rosas wrote:
> Commit bc38feddeb ("io: fsync before closing a file channel") added a
> fsync/fdatasync at the closing point of the QIOChannelFile to ensure
> integrity of the migration stream in case of QEMU crash.
> 
> The decision to do the sync at qio_channel_close() was not the best
> since that function runs in the main thread and the fsync can cause
> QEMU to hang for several minutes, depending on the migration size and
> disk speed.
> 
> To fix the hang, remove the fsync from qio_channel_file_close().
> 
> At this moment, the migration code is the only user of the fsync and
> we're taking the tradeoff of not having a sync at all, leaving the
> responsibility to the upper layers.
> 
> Fixes: bc38feddeb ("io: fsync before closing a file channel")
> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Since 9.0 is reaching and it's important we avoid such hang, I queued this
version.

However to make sure we can still remember why we do this after a few
years, I added a rich comment and will squash into this patch:

=======

diff --git a/migration/multifd.c b/migration/multifd.c
index 0a8fef046b..bf9d483f7a 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -714,6 +714,22 @@ static bool multifd_send_cleanup_channel(MultiFDSendParams *p, Error **errp)
          * released because finalize() of the iochannel is only
          * triggered on the last reference and it's not guaranteed
          * that we always hold the last refcount when reaching here.
+         *
+         * Closing the fd explicitly has the benefit that if there is any
+         * registered I/O handler callbacks on such fd, that will get a
+         * POLLNVAL event and will further trigger the cleanup to finally
+         * release the IOC.
+         *
+         * FIXME: It should logically be guaranteed that all multifd
+         * channels have no I/O handler callback registered when reaching
+         * here, because migration thread will wait for all multifd channel
+         * establishments to complete during setup.  Since
+         * migrate_fd_cleanup() will be scheduled in main thread too, all
+         * previous callbacks should guarantee to be completed when
+         * reaching here.  See multifd_send_state.channels_created and its
+         * usage.  In the future, we could replace this with an assert
+         * making sure we're the last reference, or simply drop it if above
+         * is more clear to be justified.
          */
         qio_channel_close(p->c, &error_abort);
         object_unref(OBJECT(p->c));

========

Thanks,

-- 
Peter Xu


