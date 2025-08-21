Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F8A3CA0EEB
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Aug 2025 18:19:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1up9rg-0004Kk-Fi; Thu, 21 Aug 2025 14:18:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1up9rb-0004J0-Gh
 for qemu-devel@nongnu.org; Thu, 21 Aug 2025 14:18:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1up9rZ-0006v5-68
 for qemu-devel@nongnu.org; Thu, 21 Aug 2025 14:18:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755800291;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/pUjPh2N4JHzM8SWUBKFPf5lIM9RVqv9/YUncXrMrUc=;
 b=ZF29sioWrrpSdBzhjm5kFERJ8C1rqHTdK1wjkB2A2KwIP75/ArEXt3OokwNieloq9QpB9z
 2u5Id0vQBKhUngB52lZFr4N7d2qL3XCvzXtqQsizTm0Puet1/7EovZV475JZA9anSdWHra
 nl9GaJw7PhFKBiohCQf4BG1W0nIX3NY=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-461-qNY5mJBwN_qAk398QHNpRg-1; Thu, 21 Aug 2025 14:18:04 -0400
X-MC-Unique: qNY5mJBwN_qAk398QHNpRg-1
X-Mimecast-MFC-AGG-ID: qNY5mJBwN_qAk398QHNpRg_1755800284
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-7e8704e1baeso312304485a.1
 for <qemu-devel@nongnu.org>; Thu, 21 Aug 2025 11:18:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755800284; x=1756405084;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/pUjPh2N4JHzM8SWUBKFPf5lIM9RVqv9/YUncXrMrUc=;
 b=jJ9wK7B+41zf03FxcfXs86t0ZFBkNSEQlrLfH4UuppyrwvtEv59/u3qHMP+9bTSYfP
 zfNfGlcNhKgYGWCzcABYpniisVl/t0GPxMpqBn+6ksQjiYzim/xDclcQVUWiRLwWc74i
 jN7MQUlEnxt4cNUCwuZusSabM4A1tZ+yEJtSrMzWqfvfrYpdL9GFvuHBx/z4kJriM18b
 gJ8eAH9or450wbvVV5b5foOV13b2s4mzayuogzqlOXqq+pgm9SYeHZ8M7W4OJrHri2G6
 uvZnOpuV3Icip5arQov4inZV+SEBO6/rE5n24omSS8MoP/pkLmn3eDc/SMF55py8MF6z
 z++w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWPupotgy+AD/DWJlzAZAL2uPUvw8Fzqq8K7XLyG7eR7+mBy4LdLQE0rx9KndV7C4JUbFiZ7r+iAh6f@nongnu.org
X-Gm-Message-State: AOJu0YyXkNhcRnj5FoU4Lf2vYMLz2MPQNa0RBO78Mc8vsMk/s2H+pmkA
 Vv6DtO5Ar1desRRzubFEd1pshPImu6JcO8iH+BnOCb+ny38hpflNhXLgEcMb+NivzuYaA/9N8Od
 o1L3lbEBdp6daSFCrSGIe1SP5GNsbCNlBPQEfrlZymD0TSHhkcrlEVqDr
X-Gm-Gg: ASbGnctq6jDR+f6mKHY+MPbHhGkO1u5IUPQLG4CK2cuqEreeemgyK5Y4Xn4DcuXVeTA
 tbSj0Wys2Zf/KKvCtxbp1Arx8lPui2fBs3BIVWn/25CQhAONWg8vhRyiaI8552ioX06BPKsrZka
 aUlpMPW+tb7+q49nZIKw0WbD9fg2f+8AciyuMGDiq28bEEZlrErsskgwl9E6j7k+FGySbKtAaOP
 2Ze59OIAaq9duSR9bPVLl0NfcH+96SE1d9Xe1lcGBE7xjtSGB2B8o/jkuOscNs+CqXww6fgkvdF
 xRRvFd0ikaVpvZgT1lgoF5FU6tqWA3cw
X-Received: by 2002:a05:620a:1729:b0:7e9:f820:2b89 with SMTP id
 af79cd13be357-7ea110add5dmr38326885a.74.1755800283984; 
 Thu, 21 Aug 2025 11:18:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEfhYHXj49ZG2B0HMXJHZ29ikeCuNLHXtP+opx4ztbtpUD0yJT6ObTTsDFhVSKDEsfjEC9AgQ==
X-Received: by 2002:a05:620a:1729:b0:7e9:f820:2b89 with SMTP id
 af79cd13be357-7ea110add5dmr38320785a.74.1755800283393; 
 Thu, 21 Aug 2025 11:18:03 -0700 (PDT)
Received: from x1.local ([174.89.135.121]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7e87e19b14dsm1171008085a.39.2025.08.21.11.18.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Aug 2025 11:18:02 -0700 (PDT)
Date: Thu, 21 Aug 2025 14:17:49 -0400
From: Peter Xu <peterx@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, John Snow <jsnow@redhat.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Alexey Kardashevskiy <aik@ozlabs.ru>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org, qemu-ppc@nongnu.org,
 devel@daynix.com
Subject: Re: [PATCH v8 2/2] memory: Do not create circular reference with
 subregion
Message-ID: <aKdizYeNGocXvTzv@x1.local>
References: <20250110-san-v8-0-57a5a1be1bcf@daynix.com>
 <20250110-san-v8-2-57a5a1be1bcf@daynix.com>
 <CAFEAcA-aTYebu-5s4AeBfE3oLQfxTwCpeosoj0TU8E_XPu_ZDg@mail.gmail.com>
 <CAFEAcA-ygHuA5BH+oftCGDKZOh8CHbiUKE4v=-iXvCaKzG4kHQ@mail.gmail.com>
 <aKctCjv8newNIX71@x1.local>
 <CAFEAcA8DV40fGsci76r4yeP1P-SP_QjNRDD2OzPxjx5wRs0GEg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA8DV40fGsci76r4yeP1P-SP_QjNRDD2OzPxjx5wRs0GEg@mail.gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Thu, Aug 21, 2025 at 03:47:06PM +0100, Peter Maydell wrote:
> On Thu, 21 Aug 2025 at 15:28, Peter Xu <peterx@redhat.com> wrote:
> > > On Thu, 21 Aug 2025 at 13:40, Peter Maydell <peter.maydell@linaro.org> wrote:
> > > > In memory_region_unref_subregion(), subregion->container is NULL.
> > > >
> > > > This is because in memory_region_del_subregion() we do:
> > > >
> > > >     subregion->container = NULL;
> > > >
> > > > and then after that we call
> > > >     memory_region_unref_subregion(subregion);
> > > > which dereferences subregion->container.
> > > >
> > > > Won't this always SEGV ?
> 
> > Peter, could you try the v3 version patch 8/9 instead?
> >
> > https://lore.kernel.org/all/20240708-san-v3-8-b03f671c40c6@daynix.com/
> >
> > I still prefer that one, and I hope that one doesn't have this issue.
> 
> That one fails like this:
> qemu-system-arm: ../../system/memory.c:1799: memory_region_finalize:
> Assertion `!mr->container' failed.
> 
> See the discussion on v2 (which was the same for this patch):
> https://lore.kernel.org/all/CAFEAcA9KTSjwF1rABpM5nv9UFuKqZZk6+Qo4PEF4+rTirNi5fQ@mail.gmail.com/

My apologies, it was a long discussion and I totally forgot that..

I remember I provided a draft somewhere during the discussion, anyway.. I
redid it, and attached a formal patch below that will contain the removal
of the mr->container check (plus auto-detach when it happens).  The hope is
this should work.. and comparing to the v8 of Akihiko's, it won't make MR's
own refcount any more complicated.

If necessary, I can send a formal patch.

Thanks,

===8<===
From f985c54af3e276b175bcb02725a5fb996c3f5fe5 Mon Sep 17 00:00:00 2001
From: Peter Xu <peterx@redhat.com>
Date: Thu, 21 Aug 2025 12:59:02 -0400
Subject: [PATCH] memory: Fix leaks due to owner-shared MRs circular references

Currently, QEMU refcounts the MR by always taking it from the owner.

It should be non-issue if all the owners of MRs will properly detach all
the MRs from their parents by memory_region_del_subregion() when the owner
will be freed.  However, it turns out many of the device emulations do not
do that properly.  It might be a challenge to fix all of such occurances.

Without fixing it, QEMU faces circular reference issue when an owner can
contain more than one MRs, then when they are linked within each other in
form of subregions, those links keep the owner alive forever, causing
memory leaks even if all the external refcounts are released for the owner.

To fix that, teach memory API to stop refcount on MRs that share the same
owner because if they share the lifecycle of the owner, then they share the
same lifecycle between themselves.

Meanwhile, allow auto-detachments of MRs during finalize() of MRs even
against its container, as long as they belong to the same owner.

The latter is needed because now it's possible to have MR finalize() happen
in any order when they exactly share the same lifespan.  In this case, we
should allow finalize() to happen in any order of either the parent or
child MR, however it should be guaranteed that the mr->container shares the
same owner of this MR to be finalized.

Proper document this behavior in code.

This patch is heavily based on the work done by Akihiko Odaki:

https://lore.kernel.org/r/CAFEAcA8DV40fGsci76r4yeP1P-SP_QjNRDD2OzPxjx5wRs0GEg@mail.gmail.com

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 docs/devel/memory.rst |  9 +++++++--
 system/memory.c       | 45 ++++++++++++++++++++++++++++++++++---------
 2 files changed, 43 insertions(+), 11 deletions(-)

diff --git a/docs/devel/memory.rst b/docs/devel/memory.rst
index 57fb2aec76..1367c7caf7 100644
--- a/docs/devel/memory.rst
+++ b/docs/devel/memory.rst
@@ -158,8 +158,13 @@ ioeventfd) can be changed during the region lifecycle.  They take effect
 as soon as the region is made visible.  This can be immediately, later,
 or never.
 
-Destruction of a memory region happens automatically when the owner
-object dies.
+Destruction of a memory region happens automatically when the owner object
+dies.  Note that the MRs under the same owner can be destroyed in any order
+when the owner object dies.  It's because the MRs will share the same
+lifespan of the owner, no matter if its a container or child MR.  It's
+suggested to always cleanly detach the MRs under the owner object when the
+owner object is going to be destroyed, however it is not required, as the
+memory core will automatically detach the links when MRs are destroyed.
 
 If however the memory region is part of a dynamically allocated data
 structure, you should call object_unparent() to destroy the memory region
diff --git a/system/memory.c b/system/memory.c
index 5646547940..d7f6ad9be2 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -1796,16 +1796,36 @@ static void memory_region_finalize(Object *obj)
 {
     MemoryRegion *mr = MEMORY_REGION(obj);
 
-    assert(!mr->container);
-
-    /* We know the region is not visible in any address space (it
-     * does not have a container and cannot be a root either because
-     * it has no references, so we can blindly clear mr->enabled.
-     * memory_region_set_enabled instead could trigger a transaction
-     * and cause an infinite loop.
+    /*
+     * Each memory region (that can be dynamically freed..) must has an
+     * owner, and it always has the same lifecycle of its owner.  It means
+     * when reaching here, the memory region's owner refcount is zero.
+     *
+     * Here it is possible that the MR has:
+     *
+     * (1) mr->container set, which means this MR can be a subregion of a
+     *     container MR, in this case it must share the same owner
+     *     (otherwise the container should have kept a refcount of this
+     *     MR's owner), or,
+     *
+     * (2) mr->subregions non-empty, which means this MR can be a container
+     *     of other MRs (share the owner or not).
+     *
+     * We know the MR, or any MR that is attached to this one as either
+     * container or children, is not visible in any address space, because
+     * otherwise the address space should have taken at least one refcount
+     * of this MR's owner.  So we can blindly clear mr->enabled.
+     *
+     * memory_region_set_enabled instead could trigger a transaction and
+     * cause an infinite loop.
      */
     mr->enabled = false;
     memory_region_transaction_begin();
+    if (mr->container) {
+        /* Must share the owner; see above comments */
+        assert(mr->container->owner == mr->owner);
+        memory_region_del_subregion(mr->container, mr);
+    }
     while (!QTAILQ_EMPTY(&mr->subregions)) {
         MemoryRegion *subregion = QTAILQ_FIRST(&mr->subregions);
         memory_region_del_subregion(mr, subregion);
@@ -2625,7 +2645,10 @@ static void memory_region_update_container_subregions(MemoryRegion *subregion)
 
     memory_region_transaction_begin();
 
-    memory_region_ref(subregion);
+    if (mr->owner != subregion->owner) {
+        memory_region_ref(subregion);
+    }
+
     QTAILQ_FOREACH(other, &mr->subregions, subregions_link) {
         if (subregion->priority >= other->priority) {
             QTAILQ_INSERT_BEFORE(other, subregion, subregions_link);
@@ -2683,7 +2706,11 @@ void memory_region_del_subregion(MemoryRegion *mr,
         assert(alias->mapped_via_alias >= 0);
     }
     QTAILQ_REMOVE(&mr->subregions, subregion, subregions_link);
-    memory_region_unref(subregion);
+
+    if (mr->owner != subregion->owner) {
+        memory_region_unref(subregion);
+    }
+
     memory_region_update_pending |= mr->enabled && subregion->enabled;
     memory_region_transaction_commit();
 }
-- 
2.50.1


-- 
Peter Xu


