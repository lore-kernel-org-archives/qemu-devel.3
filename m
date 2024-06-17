Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3196C2BA1A
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2024 21:23:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJJp9-0002B2-Bq; Mon, 17 Jun 2024 17:23:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sJJp7-0002AW-Ez
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 17:23:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sJJp5-0004Yf-OC
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 17:23:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718659410;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RuOcVk1sSSSsAjad/ZZll0/VFOcF3BHTK714KuEAMb8=;
 b=UyQObTypaJbeR00MG2HG8uXLC6RfMbn2Sx73cUIFXOEkd5sBrceZrTYHKZTRQ9Me4t5QOk
 C6fHdwWd6UqGsQBCiNSNIMxkXVX97GpSqcgYY8et5IIR35FJqaXT9GuPMvOUMV5sS37YN4
 CjYjhW+VBZ4qKTiSyOBhQ9Ln17JUvdo=
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com
 [209.85.222.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-354-WDidHvY8N52yWTSf7OzJmQ-1; Mon, 17 Jun 2024 17:23:28 -0400
X-MC-Unique: WDidHvY8N52yWTSf7OzJmQ-1
Received: by mail-ua1-f70.google.com with SMTP id
 a1e0cc1a2514c-80b8bb159beso240426241.2
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2024 14:23:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718659408; x=1719264208;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RuOcVk1sSSSsAjad/ZZll0/VFOcF3BHTK714KuEAMb8=;
 b=kWUFxpXpqb7rVrlOLBWPeqItY6cKtQTQxwlIv3W9bgubLEIhd81vRTRAofMZbf5Mw4
 uH3BPMsFC+7vLcDPk9nMDoMDbmdA9Dh++UUcug6X3l+MFmUpEt3yTqPaGnG4n4SSwRPX
 xviwXtEzjww64OcyPzqABLucbiZq5MZO/bToqbTRZVC4htsd1vBmu3scbuBAKPAIgJCd
 09pWRh+bkVhJLpGgti4KDxc572qwwlVK66Vb8I77n7NYuHy2V55y9tNnOYz8U6fNg/0h
 0a14tyj5+53fyYiYG2HqDiOips5noT+CjySWDbEfKd2nf0cEi4lrim/AAlXpLbxzxx3A
 CivA==
X-Gm-Message-State: AOJu0YwmSZ6n4HQ1USMxoPBZQSiOEHfjHg5Ckt5GM/pdFWJjjouOe5WA
 VBWuB9RYCJGbLh+FFjSp5v1+vEU1XCi21AnX5YkAXzUcmYnzJmJ6+P12MhsSk4YrL6OYJykjW+f
 1VyPPLBN8BfIzeBXP/mDsROme7lusQHofpkhSG50o6iyotJObi1Tk
X-Received: by 2002:a05:6102:c01:b0:48d:b0a3:fe25 with SMTP id
 ada2fe7eead31-48db0a400f5mr9631611137.1.1718659407546; 
 Mon, 17 Jun 2024 14:23:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGglYyER6IBdq9nvlB6KIMKvhRzgO8kIGr7i9uwEe0fCmhV6W3RYEmi4tYZ4fpwDSvmjyme+g==
X-Received: by 2002:a05:6102:c01:b0:48d:b0a3:fe25 with SMTP id
 ada2fe7eead31-48db0a400f5mr9631591137.1.1718659406983; 
 Mon, 17 Jun 2024 14:23:26 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-798ab4c2803sm457733085a.57.2024.06.17.14.23.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Jun 2024 14:23:26 -0700 (PDT)
Date: Mon, 17 Jun 2024 17:23:24 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Eric Blake <eblake@redhat.com>,
 Prasad Pandit <ppandit@redhat.com>,
 Jiri Denemark <jdenemar@redhat.com>, Bandan Das <bdas@redhat.com>
Subject: Re: [PATCH v2 08/10] tests/migration-tests: Always enable migration
 events
Message-ID: <ZnCpTHYho5v98DZo@x1n>
References: <20240617181534.1425179-1-peterx@redhat.com>
 <20240617181534.1425179-9-peterx@redhat.com>
 <87a5jjbb5n.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87a5jjbb5n.fsf@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.148,
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

On Mon, Jun 17, 2024 at 04:51:32PM -0300, Fabiano Rosas wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > Libvirt should always enable it, so it'll be nice qtest also cover that for
> > all tests.  Though this patch only enables it, no extra tests are done on
> > these events yet.
> >
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  tests/qtest/migration-test.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >
> > diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
> > index 13b59d4c10..9ae8892e26 100644
> > --- a/tests/qtest/migration-test.c
> > +++ b/tests/qtest/migration-test.c
> > @@ -841,6 +841,13 @@ static int test_migrate_start(QTestState **from, QTestState **to,
> >          unlink(shmem_path);
> >      }
> >  
> > +    /*
> > +     * Always enable migration events.  Libvirt always uses it, let's try
> > +     * to mimic as closer as that.
> > +     */
> > +    migrate_set_capability(*from, "events", true);
> > +    migrate_set_capability(*to, "events", true);
> > +
> 
> What do we do with the one at migrate_incoming_qmp()?

Hmm missed that..  I'll drop that one in this same patch and rewrite the
commit message.  New version attached:

===8<===
From 443fef4188d544362fc026b46784c15b82624642 Mon Sep 17 00:00:00 2001
From: Peter Xu <peterx@redhat.com>
Date: Mon, 17 Jun 2024 10:49:52 -0400
Subject: [PATCH] tests/migration-tests: Always enable migration events

Libvirt should always enable it, so it'll be nice qtest also cover that for
all tests on both sides.  migrate_incoming_qmp() used to enable it only on
dst, now we enable them on both, as we'll start to sanity check events even
on the src QEMU.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tests/qtest/migration-helpers.c | 2 --
 tests/qtest/migration-test.c    | 7 +++++++
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/tests/qtest/migration-helpers.c b/tests/qtest/migration-helpers.c
index 0ac49ceb54..797b1e8c1c 100644
--- a/tests/qtest/migration-helpers.c
+++ b/tests/qtest/migration-helpers.c
@@ -258,8 +258,6 @@ void migrate_incoming_qmp(QTestState *to, const char *uri, const char *fmt, ...)
     g_assert(!qdict_haskey(args, "uri"));
     qdict_put_str(args, "uri", uri);
 
-    migrate_set_capability(to, "events", true);
-
     rsp = qtest_qmp(to, "{ 'execute': 'migrate-incoming', 'arguments': %p}",
                     args);
 
diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index 640713bfd5..c015e801ac 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -851,6 +851,13 @@ static int test_migrate_start(QTestState **from, QTestState **to,
         unlink(shmem_path);
     }
 
+    /*
+     * Always enable migration events.  Libvirt always uses it, let's try
+     * to mimic as closer as that.
+     */
+    migrate_set_capability(*from, "events", true);
+    migrate_set_capability(*to, "events", true);
+
     return 0;
 }
 
-- 
2.45.0


-- 
Peter Xu


