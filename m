Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A56ACF8840
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2024 16:35:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swlGr-0007Ii-RX; Fri, 04 Oct 2024 12:35:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1swlGJ-0006QL-1V
 for qemu-devel@nongnu.org; Fri, 04 Oct 2024 12:34:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1swlGG-00069Q-Pp
 for qemu-devel@nongnu.org; Fri, 04 Oct 2024 12:34:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728059674;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mUn5c3pfQStI53Zd5c7QBE8d3u2NmM4zj5U6cf4nThw=;
 b=WhufGUE0stSbsi2A5O9zPzZl5K2bFMVQCGYSF/XNdo84LtQwFj/ALJSYQG5X19hxfkR5pA
 p31XiQ0tJ1vad6/Ea8C53UoUyZP2HYY3wCSZ+xjfhEj1iCErRRDJ8NvTSmyZHIiWRUoX2P
 jwoKKbP6IFX6lrWXMvxtJy91newqXH0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-550-1AHYwE1wMze52jC-k4kiuA-1; Fri, 04 Oct 2024 12:34:32 -0400
X-MC-Unique: 1AHYwE1wMze52jC-k4kiuA-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-37cd23c9226so1457957f8f.0
 for <qemu-devel@nongnu.org>; Fri, 04 Oct 2024 09:34:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728059671; x=1728664471;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mUn5c3pfQStI53Zd5c7QBE8d3u2NmM4zj5U6cf4nThw=;
 b=mLvjzYXk+moI0cfXVnMYxDHO8tM1oRs+Yc2moHHO6Hcvlo2/nARP+gWLIMgT3ARg8W
 XnYOvNCYMwppS1axD2HwdYSqWioT/6Sml7zzlJB3pCRadzWFE8aJml+p1OGtuZFChV+j
 jeNpWyRFfzNnqvFSk3Z+X95c9MixH4MRN803BpIwr9+NdCYST4a/bngvW3ZZEXwhL7dr
 EmU20d2cYkB0wONPfq0pr9Al6BHVkLgxSV6+4DWsYMWYfYr0wsm20VzHFx9QyncSZ7EZ
 p2t5S/ommwC3INRuxYoCwxKdV7PXApaPmqII1QhtbxfCXKEHw3S8RohSFJyM+7sZe3rW
 qABQ==
X-Gm-Message-State: AOJu0Yzri1u31J5cFEkPSxp9/iKg1s3/0RPfbbyiQQmFAjtWsLlEe965
 c0PplLnGC6JW3f2n2TgQT26npx+E3nzAE0QSwbAFwvtKMU+91ohNw0HJXIU7ZeiVA7oiSmVYD2t
 eslL6pqZLdifNtK4ATQTCJ4PG4yFsWYmF0Ob1E5EuhhYFl041esjPIEcPNyMMFol5lYf9/QkoHW
 dLMkpDP4eoHefotFNL4hIacnFvQZMLx2TunhVEM84=
X-Received: by 2002:adf:e84c:0:b0:37c:c9bc:1be6 with SMTP id
 ffacd0b85a97d-37d049f1696mr4894225f8f.16.1728059671213; 
 Fri, 04 Oct 2024 09:34:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF6gmi0oaYzGhsHfQThqMQqQ5urlDPyPAZIY9iDoMG5e9M2WeYUlDnvJNfI9f5B2B82gMsC9A==
X-Received: by 2002:adf:e84c:0:b0:37c:c9bc:1be6 with SMTP id
 ffacd0b85a97d-37d049f1696mr4894207f8f.16.1728059670760; 
 Fri, 04 Oct 2024 09:34:30 -0700 (PDT)
Received: from avogadro.local ([151.95.43.71])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42f86b1d672sm19469335e9.28.2024.10.04.09.34.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Oct 2024 09:34:30 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Richard W.M. Jones" <rjones@redhat.com>
Subject: [PULL 04/23] tests/unit: remove block layer code from
 test-nested-aio-poll
Date: Fri,  4 Oct 2024 18:33:56 +0200
Message-ID: <20241004163415.951106-5-pbonzini@redhat.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20241004163415.951106-1-pbonzini@redhat.com>
References: <20241004163415.951106-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.146,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

GCC is reporting a NULL pointer dereference when compiling aio_wait_kick()
with LTO.

The issue is that test-nested-aio-poll.c does not call qemu_init_main_loop().
It doesn't _need_ to because it never calls AIO_WAIT_WHILE(), but it seems
that LTO does not do enough dead-code elimination to catch that.

Fortunately aio_wait_kick() is only used in few places, and only in block
layer or system emulation code; and this test only needs the core event loop
functionality.  It does not even need iothreads.   So remove everything that
calls aio_wait_kick(), which is nice for coverage compared to adding the call
to qemu_init_main_loop().

Reported-by: Richard W.M. Jones <rjones@redhat.com>
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2434
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/unit/meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/unit/meson.build b/tests/unit/meson.build
index 21d101301bc..d5248ae51de 100644
--- a/tests/unit/meson.build
+++ b/tests/unit/meson.build
@@ -116,7 +116,7 @@ if have_block
   if host_os != 'windows'
     tests += {
       'test-image-locking': [testblock],
-      'test-nested-aio-poll': [testblock],
+      'test-nested-aio-poll': [],
     }
   endif
   if config_host_data.get('CONFIG_REPLICATION')
-- 
2.46.1


