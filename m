Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51460C54E58
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 22:32:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkAal-0007MJ-5n; Tue, 12 Mar 2024 18:27:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rkAaH-00054R-Fl
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 18:27:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rkAaF-0004KV-1p
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 18:26:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710282414;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Co9AeQNCftuPr7tCy5EYmuY1ACdZWH3K/U2GLTPiBGU=;
 b=NWefr1AgBJc2mGmjCInRapboJJFVvYRfU3sIQbT/9Bt4JsYD+uLioCX9xOkSEkNBbnwQgW
 BJRhhLEf/xgBrvHeE2P7NwxHEBmPZqVmeWBMqGBTupkvdXoyMrs8s0ZnKZQrWyWCYlkJTp
 A9Ueke4OqQwgKxMeS9/Dy4piY7Xo+Bs=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-527-ukHqRQMDN02SZFWnyRFuUA-1; Tue, 12 Mar 2024 18:26:53 -0400
X-MC-Unique: ukHqRQMDN02SZFWnyRFuUA-1
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-2d449d2db37so16056741fa.3
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 15:26:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710282411; x=1710887211;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Co9AeQNCftuPr7tCy5EYmuY1ACdZWH3K/U2GLTPiBGU=;
 b=vLhANlPA2mupHYEKQP3iut4/2MiamIp1/W5votkU1ZhkZZQ95gvkfgOzamEwPVhAM/
 jjrH32WrV51vmuIhgnQmbSj3sdxtoDvbj5dnBNEcxDhhqHRD05dUMNJrj7w3rjMpCT1u
 P8s8NPmyCmd391gALQ97qwyXuvKM2VvFZWvJ4CkRp6/DFFwXO4xM5wdOuovY5eKylRGR
 usttTrn7Ju0ARakjxagX+YEe5JJaTSdzf0f47DRNcVY9+ES/BXjgGOW4R5BuLFUiiB80
 KRUXnkessW6SFSicQ2hhLDgWSATB4PbZuCnTnkma3YR23F975oKyvQ9xEBYvMnhHEA3c
 DOig==
X-Gm-Message-State: AOJu0Yz1E5uDNF6nSy9rGysVJySOyg9+M6MRdeIOtWUGx+f2pn2Pum1p
 1xsDI3bqF3VLB8UYUNlK4raOk86zycc8m+isb2p/YIQYP/iqltWfkGShBEnRsPZ/il9irLG3PDB
 FhBXaARz4q9swjdTkKKCSrK6x7fcyF0rmxXN51lxzNnpvaA8VYtikcrDEfpmGCXV2+5n2QhPl9I
 X+AK8/z0FaP7qJbCxYRZ76AHdyGfWrycR+
X-Received: by 2002:a2e:a454:0:b0:2d2:a9d6:c435 with SMTP id
 v20-20020a2ea454000000b002d2a9d6c435mr6934965ljn.34.1710282411015; 
 Tue, 12 Mar 2024 15:26:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHLp6eB82URiPUxCOpRJfGkhOb8Y8+bEpirUtvEcKr+D8VxJnR1qOiEZA6ZAfDaTvQw/ep+EQ==
X-Received: by 2002:a2e:a454:0:b0:2d2:a9d6:c435 with SMTP id
 v20-20020a2ea454000000b002d2a9d6c435mr6934945ljn.34.1710282410304; 
 Tue, 12 Mar 2024 15:26:50 -0700 (PDT)
Received: from redhat.com ([2.52.134.16]) by smtp.gmail.com with ESMTPSA id
 sa38-20020a1709076d2600b00a453123b111sm4217921ejc.120.2024.03.12.15.26.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Mar 2024 15:26:49 -0700 (PDT)
Date: Tue, 12 Mar 2024 18:26:47 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 David Hildenbrand <david@redhat.com>,
 Raphael Norwitz <raphael@enfabrica.net>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Mario Casquero <mcasquer@redhat.com>
Subject: [PULL 25/68] libvhost-user: Mark mmap'ed region memory as
 MADV_DONTDUMP
Message-ID: <52767e1063beaa17d59c739efd0b9c342923929d.1710282274.git.mst@redhat.com>
References: <cover.1710282274.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1710282274.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
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

From: David Hildenbrand <david@redhat.com>

We already use MADV_NORESERVE to deal with sparse memory regions. Let's
also set madvise(MADV_DONTDUMP), otherwise a crash of the process can
result in us allocating all memory in the mmap'ed region for dumping
purposes.

This change implies that the mmap'ed rings won't be included in a
coredump. If ever required for debugging purposes, we could mark only
the mapped rings MADV_DODUMP.

Ignore errors during madvise() for now.

Reviewed-by: Raphael Norwitz <raphael@enfabrica.net>
Acked-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20240214151701.29906-15-david@redhat.com>
Tested-by: Mario Casquero <mcasquer@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 subprojects/libvhost-user/libvhost-user.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/subprojects/libvhost-user/libvhost-user.c b/subprojects/libvhost-user/libvhost-user.c
index 61fb3050b3..a879149fef 100644
--- a/subprojects/libvhost-user/libvhost-user.c
+++ b/subprojects/libvhost-user/libvhost-user.c
@@ -460,6 +460,12 @@ _vu_add_mem_reg(VuDev *dev, VhostUserMemoryRegion *msg_region, int fd)
     DPRINT("    mmap_addr:       0x%016"PRIx64"\n",
            (uint64_t)(uintptr_t)mmap_addr);
 
+#if defined(__linux__)
+    /* Don't include all guest memory in a coredump. */
+    madvise(mmap_addr, msg_region->memory_size + mmap_offset,
+            MADV_DONTDUMP);
+#endif
+
     /* Shift all affected entries by 1 to open a hole at idx. */
     r = &dev->regions[idx];
     memmove(r + 1, r, sizeof(VuDevRegion) * (dev->nregions - idx));
-- 
MST


