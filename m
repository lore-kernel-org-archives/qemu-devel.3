Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BEEDC83F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 23:34:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubSHh-0007Yd-Ic; Mon, 14 Jul 2025 19:08:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ubSGm-0004Ph-1X
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 19:07:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ubSGk-0005Yb-BW
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 19:07:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752534453;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=L7vnOqE9vYNzXZo7bToAkIslT5GpERjhTAHR0WEOusY=;
 b=Zd8eogKraZla5l/0zG8hi5Prn60+PDd5Lxyxa+QfHJ2dGE292DjCWeW3+om8a+HAs0tcr6
 CIj12Fqvc/2SxsE+ChfKoc4cjCf8K8vXUfRsoLJvGdTSghq9fBgGp8pB++lEFEovldB01w
 LSsLeUJwJ3/EjyQ9/SvDQX21Ith4ijw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-681-6tKhiRKWOYK-UbkGmFMcXA-1; Mon, 14 Jul 2025 19:07:32 -0400
X-MC-Unique: 6tKhiRKWOYK-UbkGmFMcXA-1
X-Mimecast-MFC-AGG-ID: 6tKhiRKWOYK-UbkGmFMcXA_1752534452
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4538f375e86so39562005e9.3
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 16:07:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752534451; x=1753139251;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L7vnOqE9vYNzXZo7bToAkIslT5GpERjhTAHR0WEOusY=;
 b=Cit84Lxw2q4p1LC0juOTVNCgq+aZS4svLTf26YCnEr1ipOp2mOc0fjpi9fqBndhErQ
 FsQAy4eCr7XWFm2w8SL+B3bLQmVLCM87PX2AWXQmLO9vRXffBZCDD9ERyoZpH95wlLT3
 Bu3Sfh57jCRDSxG22AVhi4SCH+SmXnB/F7tkl8aAxUunZvJQldotWIE7yu2pluyzEZjE
 jTt6JEdRwW5DTNfuVgq6Us4g/QR4cnrWNCBas+UU0If1wxF2fw6VzoNW6hRh/zbmtkFw
 Vg9jgB98+yvIx5K61j8R5WQwcJBzAjIyJ4N24UxrtOYQkTRCSPyYGCTejbzwwSeU3dek
 nP/A==
X-Gm-Message-State: AOJu0YxHqD9oIyd/8pBsT2ZS/GTkey3gQLad337aIgDfBFDLtQVG1oNe
 V4JEOAEcA9fSkV0zpnY2hbNGsgWsZAchwa3uRq0NLP8khPkbkB71el8TVUDd7Hj7PJH4N1vb2d2
 COW4LiDuNJ+urQu+WWjbQVbQousSgXGrkz9lWyaZpEwujrLf+njD5SHdJp3kBU6nns8Q6ClTPYL
 KU7URxPzT1kHHnS4LPSDzSYwCYQZ3JqmJh6w==
X-Gm-Gg: ASbGncuFJtPzEeOl4MXqdcbdnwpRhnUEJOH0Zl1Hf9fmGvDhQUdpLm5QHhH+R6kVIpd
 tJmtzyBo6Z9FEauY17cacL6PwI6CM/hXXko+zr1AxEukcCPelATyJlWFg/YrR6IqUpc4l8U3Yv0
 mR9bQJEunjr/Acd9WDT/sMeQea5WErybTW6Eda9BU9jzZ3q1nvaVsVpJKOYsE5roeaU5gaAkiA/
 OpfbFCy7+8xTUDQFQ2p4RYcoP5cVSt2iT0c1gxT59/PLNP6FeNq8bE6FBgwqmt9A1VedQc7D6Yd
 H68RK3HRCQbMScYziE6FIHgbVfk7fXQJ
X-Received: by 2002:a05:600c:4ecf:b0:456:1dd2:4e47 with SMTP id
 5b1f17b1804b1-456273e2869mr4110885e9.15.1752534451280; 
 Mon, 14 Jul 2025 16:07:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEMOWjx9YuSIHblq9C7KVh/Aeqjo2JAvJlZGv5t2sJVY748iPKsynCobQ31Mm0vyfik5lavfQ==
X-Received: by 2002:a05:600c:4ecf:b0:456:1dd2:4e47 with SMTP id
 5b1f17b1804b1-456273e2869mr4110685e9.15.1752534450739; 
 Mon, 14 Jul 2025 16:07:30 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:150d:fc00:de3:4725:47c6:6809])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454d5050d34sm186355975e9.9.2025.07.14.16.07.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jul 2025 16:07:30 -0700 (PDT)
Date: Mon, 14 Jul 2025 19:07:28 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 30/97] memory: Add permissions in IOMMUAccessFlags
Message-ID: <945a6b11323b353f7f404eef748b708f1cb335dc.1752534227.git.mst@redhat.com>
References: <cover.1752534227.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1752534227.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>

This will be necessary for devices implementing ATS.
We also define a new macro IOMMU_ACCESS_FLAG_FULL in addition to
IOMMU_ACCESS_FLAG to support more access flags.
IOMMU_ACCESS_FLAG is kept for convenience and backward compatibility.

Here are the flags added (defined by the PCIe 5 specification) :
    - Execute Requested
    - Privileged Mode Requested
    - Global
    - Untranslated Only

IOMMU_ACCESS_FLAG sets the additional flags to 0

Signed-off-by: Clement Mathieu--Drif <clement.mathieu--drif@eviden.com>
Message-Id: <20250628180226.133285-3-clement.mathieu--drif@eviden.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/system/memory.h | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/include/system/memory.h b/include/system/memory.h
index 46248d4a52..1672622d70 100644
--- a/include/system/memory.h
+++ b/include/system/memory.h
@@ -109,15 +109,34 @@ struct MemoryRegionSection {
 
 typedef struct IOMMUTLBEntry IOMMUTLBEntry;
 
-/* See address_space_translate: bit 0 is read, bit 1 is write.  */
+/*
+ * See address_space_translate:
+ *      - bit 0 : read
+ *      - bit 1 : write
+ *      - bit 2 : exec
+ *      - bit 3 : priv
+ *      - bit 4 : global
+ *      - bit 5 : untranslated only
+ */
 typedef enum {
     IOMMU_NONE = 0,
     IOMMU_RO   = 1,
     IOMMU_WO   = 2,
     IOMMU_RW   = 3,
+    IOMMU_EXEC = 4,
+    IOMMU_PRIV = 8,
+    IOMMU_GLOBAL = 16,
+    IOMMU_UNTRANSLATED_ONLY = 32,
 } IOMMUAccessFlags;
 
-#define IOMMU_ACCESS_FLAG(r, w) (((r) ? IOMMU_RO : 0) | ((w) ? IOMMU_WO : 0))
+#define IOMMU_ACCESS_FLAG(r, w)     (((r) ? IOMMU_RO : 0) | \
+                                    ((w) ? IOMMU_WO : 0))
+#define IOMMU_ACCESS_FLAG_FULL(r, w, x, p, g, uo) \
+                                    (IOMMU_ACCESS_FLAG(r, w) | \
+                                    ((x) ? IOMMU_EXEC : 0) | \
+                                    ((p) ? IOMMU_PRIV : 0) | \
+                                    ((g) ? IOMMU_GLOBAL : 0) | \
+                                    ((uo) ? IOMMU_UNTRANSLATED_ONLY : 0))
 
 struct IOMMUTLBEntry {
     AddressSpace    *target_as;
-- 
MST


