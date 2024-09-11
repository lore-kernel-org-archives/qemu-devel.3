Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FB8AEE49BC
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 15:00:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soOli-0006Zz-8z; Wed, 11 Sep 2024 10:56:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1soOig-0002ck-KS
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 10:53:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1soOid-0007IU-1t
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 10:53:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726066398;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4veiozMEGfv+9OEJSb+cGyfH7FXaz+7Wyk7isIZPzXI=;
 b=VBZloT7g8sNtsVS+csbWn3h0Zy6zGrhaVDLTSaTHcnVNRgaTMvRnRgq/gjJwVvD8pbiO8H
 Y7KBftllqj8H9wL3GBEnw4L+tbG06lXsag569BW4YfcKfjAl3g/FFvgrHLpe283QdgrdnN
 SfAN22RyhJRwKcPw383LpNJhoAj4dFM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-76-JNxwyFy8OGS6N0S9wd4tQA-1; Wed, 11 Sep 2024 09:52:23 -0400
X-MC-Unique: JNxwyFy8OGS6N0S9wd4tQA-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-374b981dd62so1079003f8f.3
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2024 06:52:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726062742; x=1726667542;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4veiozMEGfv+9OEJSb+cGyfH7FXaz+7Wyk7isIZPzXI=;
 b=YuGQU+Y439gQWsqF1oLI37OSiObE1Te/gi8Ih/q49GvZXVvnA8s5ACtzS+1CipTwtw
 FjaWI8Bov6utRAjqWLz95an+xiB9GTEklaB+894hP0bcfX+uysog8EdbUmdwo0VAC6eN
 4zAdSKOMw5Q5i0A8PFbBBe2F97ubiJdHoG0AcaO+HLHkkV/PX2Q3vWx+gcqfr3VHASiy
 kmoQpnEh/y8sCQ9+68G6ZL2rVQuf1u2XYnprF/NfamLCTqRzLa8ESxM5kAAWhf+QU0C5
 UXlxOi7zzwkuk/QU5xgikXhKgaxiZomaeFJ4+XrKbTqiqqI8RB+oedD/vFDIG9evv86V
 dq5Q==
X-Gm-Message-State: AOJu0YxkaoLhlzxiIwTkHUxyfXOVaLkY5UBLgiCJC1kc03cxh4ayD4r0
 Zlef37Yh/EPGavQ4NhEpqXR7Clx5u+1yPhwFdeboNfKYYd+HkxfgV1F+QzluzWZqbbpOgbaasWC
 7G/oBccmt8sYYlo15KHtXtcx0cRrvCE27GI5IRkrwhkaAmjB52dPL5ZPJ/8oVZqPtWtrkIbZOfa
 D9tgeWAyKXWaQpxYp+aRBHU8x1CI2NKg==
X-Received: by 2002:a05:6000:156e:b0:378:7e94:d613 with SMTP id
 ffacd0b85a97d-378b07f6ad8mr2411386f8f.42.1726062741683; 
 Wed, 11 Sep 2024 06:52:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE3fvnhE/laytZOuXh9GtvogEZU9g8iP2CK+EAn9uPy3+gHAc7EKj5dFV1iyfaiUOt7pcxJ0Q==
X-Received: by 2002:a05:6000:156e:b0:378:7e94:d613 with SMTP id
 ffacd0b85a97d-378b07f6ad8mr2411344f8f.42.1726062740959; 
 Wed, 11 Sep 2024 06:52:20 -0700 (PDT)
Received: from redhat.com ([2.55.9.133]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c3ebd46886sm5388659a12.34.2024.09.11.06.52.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Sep 2024 06:52:20 -0700 (PDT)
Date: Wed, 11 Sep 2024 09:52:18 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 David Hildenbrand <david@redhat.com>, Gavin Shan <gshan@redhat.com>,
 Juraj Marcin <jmarcin@redhat.com>
Subject: [PULL 17/18] virtio-mem: don't warn about THP sizes on a kernel
 without THP support
Message-ID: <95b717a8154b955de2782305f305b63f357b0576.1726062663.git.mst@redhat.com>
References: <cover.1726062663.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1726062663.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: David Hildenbrand <david@redhat.com>

If the config directory in sysfs does not exist at all, we are dealing
with a system that does not support THPs. Simply use 1 MiB block size
then, instead of warning "Could not detect THP size, falling back to
..." and falling back to the default THP size.

Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Gavin Shan <gshan@redhat.com>
Cc: Juraj Marcin <jmarcin@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20240910163433.2100295-1-david@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/virtio-mem.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/hw/virtio/virtio-mem.c b/hw/virtio/virtio-mem.c
index ef64bf1b4a..4075f3d4ce 100644
--- a/hw/virtio/virtio-mem.c
+++ b/hw/virtio/virtio-mem.c
@@ -88,6 +88,7 @@ static uint32_t virtio_mem_default_thp_size(void)
 static uint32_t thp_size;
 
 #define HPAGE_PMD_SIZE_PATH "/sys/kernel/mm/transparent_hugepage/hpage_pmd_size"
+#define HPAGE_PATH "/sys/kernel/mm/transparent_hugepage/"
 static uint32_t virtio_mem_thp_size(void)
 {
     gchar *content = NULL;
@@ -98,6 +99,12 @@ static uint32_t virtio_mem_thp_size(void)
         return thp_size;
     }
 
+    /* No THP -> no restrictions. */
+    if (!g_file_test(HPAGE_PATH, G_FILE_TEST_EXISTS)) {
+        thp_size = VIRTIO_MEM_MIN_BLOCK_SIZE;
+        return thp_size;
+    }
+
     /*
      * Try to probe the actual THP size, fallback to (sane but eventually
      * incorrect) default sizes.
-- 
MST


