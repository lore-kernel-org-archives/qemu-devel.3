Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBFCDC53209
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 19:20:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woQro-00007s-0E; Mon, 27 Jul 2026 15:20:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1woQrl-00006u-0n
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 15:19:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1woQrj-0000MF-HZ
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 15:19:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785179994;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/txAZo0uKIIHRAZMetvN+bShmrwHuXg9vNoDM1Sc3Ec=;
 b=JNNY2dAsrkm1e232B22i3YIcW1p9BQRY4JDW57mS6E57cz66ekat0blvRZ64pfzg6/t6Nx
 5mEVt4/hmAQZTmRckj9KgCavCGcomfBY0z0QF+9aD1XI4wxzImogymgC0PSziY9PhAKG9N
 q3NruywEArMfLM35i0u2jFLug3/U6x4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-688-cOel_knzNfOad8K__TW7zg-1; Mon, 27 Jul 2026 15:19:53 -0400
X-MC-Unique: cOel_knzNfOad8K__TW7zg-1
X-Mimecast-MFC-AGG-ID: cOel_knzNfOad8K__TW7zg_1785179992
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-47f6e8b5996so3132769f8f.2
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 12:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1785179992; x=1785784792; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=/txAZo0uKIIHRAZMetvN+bShmrwHuXg9vNoDM1Sc3Ec=;
 b=dkdqKXUKY8gWanSxPzbvKFpauAWXMA5V2yr96n71clvodsQcgrSzHXx1DxuEbWDGlI
 VDL7++UGwYl2TaizaMO3DeLorFo5VTSGUG/FDa2JxpQsFDbEERhJ4qkOJPphjKnWgb5W
 Ksn23x3eMDXaspq6+L0k1Kq5hVOuTfCWI1ei4g5trMj8wdO9uWJhztAYOc+Jp/N/0e4e
 9tyjPBZ4Kl4T0kG3R7axlXUxVuR9rKf7Uxke3Q30INWCioar7+pLiGB3C2fvxWib1imG
 YMfSVbUWHchnzDykSKVOrlEXGgMc+tDV5jr7wjkGRYFFBb5COa71+zoqH/JpcxEmmed0
 Uv4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785179992; x=1785784792;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=/txAZo0uKIIHRAZMetvN+bShmrwHuXg9vNoDM1Sc3Ec=;
 b=FG1LCaaE23E4+FfrdmNHynzrMbh2PP0xrJV9vkA0+TH2+iNBZR5gf3wcV3aO0ma89n
 ct6y9kq/RuOmDKUMQ2Hs+Oi6PlT5yXgyCWV/VKn73hTsWgbr0qh8vG8Flfxlf7GS+DuA
 BUwLlnuxYAGPRmuAy8+o5LNh3MEgjGfS10+v5hYrOVp5o6Tzrttvdb1fMKFsvB18wf9Q
 bXYqfgBdEQJ5BSeonJEPedIPyPNi0mcmjQ35SoYJF9Ygo0h6M+M3rRVcjqNq/kKdXM7I
 Zhro5G1mO4u/MLqPkryk8H06srecHHf9MCeMRYqR/vxc157uIGstpUqCZkWtNiFHAsp0
 twKA==
X-Gm-Message-State: AOJu0Yy7qZOq74NzDdjy9cVlBSwltLBAcwesOvnvwmdMy3mXH1WZ6Ats
 ZtrRRShC9S4qChsbTHQlOo9teWHpwEJF4kudoo6MhmtKfBeNunMTwBvl05mhbhy/ezyGmENi/nE
 80UTK6Cq28VJBYQqW6yeAQUj2sYYdlr76pKwcorBXJRM2EZ6etinlCPYlydnFfPZAxCo6K98Nwy
 1VEQuM07TLCtVbMrRsZM1/5pYCjabIytXrxg==
X-Gm-Gg: AR+sD13if+4OMCBNBEJhFip+RfusTq1V/b8AsApcM0+LryZCZWwsBS+I//5+jk2h2Dy
 1CmhWOoyh/GMfpdyLbaFChs9gIvKYzATxuUSldRwLM38QWwDRyy0O2S/GCwAdk0CfRCIhnc7sG6
 x/qaVJy4Zoclg6m0PK2QUfU88nkptVbVZpMF61ri4H4akyQ1WairNflXa3F2jiHwi8mi9AikofD
 x02atKcDbwpoWRKN81BKC6838uNucMxcpy460laEBYdbyuOb0eUxf366bTrdbhtDLdA+EkTukO5
 J8ZWdsrLrSzfEBePrzNO7EtAapMj6IITDZyR/q8d7DD2lTU44hgnErLVbEsQ8mlQ4raX8Jk9ldK
 kzJaNCquLTO0RpKxLqVpopQ==
X-Received: by 2002:a05:6000:2311:b0:47f:81c4:36b4 with SMTP id
 ffacd0b85a97d-47f9fc8871dmr14046694f8f.14.1785179992007; 
 Mon, 27 Jul 2026 12:19:52 -0700 (PDT)
X-Received: by 2002:a05:6000:2311:b0:47f:81c4:36b4 with SMTP id
 ffacd0b85a97d-47f9fc8871dmr14046659f8f.14.1785179991446; 
 Mon, 27 Jul 2026 12:19:51 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-28-14.inter.net.il. [80.230.28.14])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85bdac28sm50182920f8f.16.2026.07.27.12.19.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2026 12:19:50 -0700 (PDT)
Date: Mon, 27 Jul 2026 15:19:49 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, jasowangio@gmail.com,
 qemu-stable@nongnu.org, dong ling <dongling226655@outlook.com>
Subject: [PULL v2 06/30] hw/virtio: reject zero-length packed indirect
 descriptor table
Message-ID: <6dbdc271f56b42e921a662b65a862f503eb4448e.1785179875.git.mst@redhat.com>
References: <cover.1785179875.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1785179875.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Laurent Vivier <lvivier@redhat.com>

The split-ring path already rejects a zero-length indirect descriptor
table since commit 7423192912af ("virtio: add checks for the size of
the indirect table"). The packed-ring path is missing the same check,
allowing a guest to trigger an assertion in address_space_cache_init()
with a packed indirect descriptor that has len=0.

Add the same !desc.len check to the packed-ring indirect validation
in both virtqueue_packed_get_avail_bytes() and virtqueue_packed_pop().

Fixes: 86044b24e865 ("virtio: basic packed virtqueue support")
Cc: jasowangio@gmail.com
Cc: qemu-stable@nongnu.org
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3984
Reported-by: dong ling <dongling226655@outlook.com>
Signed-off-by: Laurent Vivier <lvivier@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20260715115040.2186274-1-lvivier@redhat.com>
---
 hw/virtio/virtio.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 7c19080db5..2d33622daf 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -1475,7 +1475,7 @@ static void virtqueue_packed_get_avail_bytes(VirtQueue *vq,
         }
 
         if (desc.flags & VRING_DESC_F_INDIRECT) {
-            if (desc.len % sizeof(VRingPackedDesc)) {
+            if (!desc.len || (desc.len % sizeof(VRingPackedDesc))) {
                 virtio_error(vdev, "Invalid size for indirect buffer table");
                 goto err;
             }
@@ -1927,7 +1927,7 @@ static void *virtqueue_packed_pop(VirtQueue *vq, size_t sz)
     vring_packed_desc_read(vdev, &desc, desc_cache, i, true);
     id = desc.id;
     if (desc.flags & VRING_DESC_F_INDIRECT) {
-        if (desc.len % sizeof(VRingPackedDesc)) {
+        if (!desc.len || (desc.len % sizeof(VRingPackedDesc))) {
             virtio_error(vdev, "Invalid size for indirect buffer table");
             goto done;
         }
-- 
MST


