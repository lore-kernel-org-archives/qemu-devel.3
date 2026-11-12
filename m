Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB11E606A321
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Nov 2026 17:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=d+/5SIa2;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=M3j6mrl8
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRYvZ-0000Cp-DS; Thu, 12 Nov 2026 12:49:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tcalifano@redhat.com>)
 id 1xRYvR-00008s-Gd
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 12:49:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tcalifano@redhat.com>)
 id 1xRYvP-0001Za-GH
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 12:49:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794505766;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yqlF0e73IhEcX2gKNQKz17HOW9h+dGEhYA+z8LysMU0=;
 b=d+/5SIa2Hwzv60TUmLR6KtXQTWKhTZG2VY4dY1W0iBpAs8GHAUfE2bq7v1R03xu0AsnbjC
 XEFILU6+gdydDnLRdD9mJd8Yo8y0mjNOHLH/Ewv8V7M+NwONotP0Rw1dXR8pFJNgWsddnu
 xZje4tbyCrKQtYK/cSYh8fQUAt4hr/U=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-531-ZMnq-fPsP4K-yKSd7-vwbQ-1; Thu, 12 Nov 2026 12:49:25 -0500
X-MC-Unique: ZMnq-fPsP4K-yKSd7-vwbQ-1
X-Mimecast-MFC-AGG-ID: ZMnq-fPsP4K-yKSd7-vwbQ_1794505764
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-3adeba76cadso18890a91.1
 for <qemu-devel@nongnu.org>; Thu, 12 Nov 2026 09:49:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1794505764; x=1795110564; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=yqlF0e73IhEcX2gKNQKz17HOW9h+dGEhYA+z8LysMU0=;
 b=M3j6mrl8X4Qj92r4Ls2gx+Jl9UzGpD1SgM9Cl/QY0b1zbeT204bTsR7iQ08RE9uurc
 GL7/rhIEn/mLaaXMdyR6TiKxByQFWLHOXzbhsrOM37s7yUmJv/PVRQO0H7Djem5x+E50
 eiSui6I6RdEkBjl9Idppwh0ufyEEKyz9h00yExDdzKPNewk4QHk8tE/RRGLa9vM2w/aa
 KqhdoF39nqOP69d8u9eu57l6y3TSewLWR+VcYUZR5l7ETkY2fPxFoIhZ4OCGD/j/OwQz
 N0537QRkuWrRZCutgkmP2IHrgJbsqE9buUnqj7NwLB/QaDO2JiIH8bT5SvWctgRZBuVr
 Y+NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794505764; x=1795110564;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=yqlF0e73IhEcX2gKNQKz17HOW9h+dGEhYA+z8LysMU0=;
 b=0Jy+SPWnPQAtWfENhk1XhmLQgThrW+KTsmNs69D+n9TNkBhUP+EzwC0XRIvkYjaXc5
 l/HyCfEoKukRA8FlHZf6vbfW143aaM0x6EqZCf4y8cjygpraeUhbiGKZXbM1moIZIoTj
 CeaP+i4mOeEebOO3MbwbKVgqo0b8ZLHw7oSR5Fu2/eoES38lzua/7hoUQnXf/jwghYw8
 UE0hY+sHKsdYihIcOARmDquOpkst5rMoQaQW8ukPu7hu4P27CFN4XQ4Jau3jKTgWPNrC
 oWVuBzoYT2b+ZbD4jxVUriN7ew2bJgv9erQk5z0BweAMj06jI4uLqEDCNYHMzMyXJlPJ
 CdQg==
X-Gm-Message-State: APuU4Z95aZzfWoCUHsF77x9ZOTrbIXmbpzD2GQi0VCfanXHyOYEYZffQ
 e4dFOa4YFob1VTT0gfvcUPRZQ2Sd0yK+9ttU7JN9nx+RKZU3g0xc2U7c8WtlVpANEuyiy4S3Rqz
 tm2gsXH7gRSC8F1p6nA8N420ZUkvANFE2d7yDi/joljfanWzcr3+UkCariD/86B0Kk7hneC6KRO
 svP1k1fr9a5CY4HqkYy4X6qhd5zg2L+x6vxL6nj9/FVw==
X-Gm-Gg: AYBFou3uKmwiNGi3nuOLlwqvw8AcujRC6FL56Jam+lPbADq2+wyb6ed9Q3l2Hd0FtUx
 ELoappenhhXCBDpoe0A2EKtEK0S3NXodf6ofVbCoXneYadE8eHjvmnk2i7VeCTmTu1Fd5cKHcID
 53+F1Sanqu+4lBgY+1jucNViqJv4dF0l2XdV1pdAayMXbfP25zUhGzt39FTnOu3cOCDuK0IyHDT
 lmvpugMktQCPMDa1xulxLyV+R/1CNVp4XzbbPFCz8BYE938EqC8yi01vQ39fb6f0IP9SbP+q41w
 hRrvTPkk9A6Tvl5BYqNtKooiP7d8+PxYP2joA8qhvk5bROIVaODU0aXjy8vjE0Wx+dMla3451aw
 PbDoOdpjC17p/INg5sJk/7ePj/F7wpymeSHG9vA4uymITeQ==
X-Received: by 2002:a17:90b:37c3:b0:3b0:c11a:9026 with SMTP id
 98e67ed59e1d1-3b18300a02emr6487997a91.55.1794505764214; 
 Thu, 12 Nov 2026 09:49:24 -0800 (PST)
X-Received: by 2002:a17:90b:37c3:b0:3b0:c11a:9026 with SMTP id
 98e67ed59e1d1-3b18300a02emr6487972a91.55.1794505763678; 
 Thu, 12 Nov 2026 09:49:23 -0800 (PST)
Received: from tcalifan-p1g8.csb ([213.175.46.86])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b197ce55c1sm5557459a91.3.2026.11.12.09.49.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Nov 2026 09:49:22 -0800 (PST)
From: Tommaso Califano <tcalifano@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Junjie Cao <junjie.cao@linux.dev>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Tommaso Califano <tcalifano@redhat.com>, qemu-stable@nongnu.org
Subject: [PATCH 1/9] hw/usb/dev-mtp: Fix recursive delete of directories
Date: Thu, 12 Nov 2026 18:48:58 +0100
Message-ID: <20261112174907.158825-2-tcalifano@redhat.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261112174907.158825-1-tcalifano@redhat.com>
References: <20261112174907.158825-1-tcalifano@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=tcalifano@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

usb_mtp_deletefn() only recursed into the grandchildren of the target,
never deleting the files directly inside it. The directory was left
non-empty, so rmdir() on the host always failed, and objects nested more
than two levels deep were silently kept.

Recurse into every child of the target instead. Since the root directory
can now actually become empty, skip the root object itself: rmdir()'ing
it and freeing it would leave s->objects empty.

Cc: qemu-stable@nongnu.org
Fixes: ec6206a68f70 ("usb-mtp: Support delete of mtp objects")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4529
Suggested-by: Hui Peng <https://gitlab.com/benquike>
Signed-off-by: Tommaso Califano <tcalifano@redhat.com>
---
 hw/usb/dev-mtp.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/hw/usb/dev-mtp.c b/hw/usb/dev-mtp.c
index 8507e516ab..bc5a6f0891 100644
--- a/hw/usb/dev-mtp.c
+++ b/hw/usb/dev-mtp.c
@@ -1152,19 +1152,20 @@ enum {
 
 static int usb_mtp_deletefn(MTPState *s, MTPObject *o, uint32_t trans)
 {
-    MTPObject *iter, *iter2, *iter2_next;
+    MTPObject *iter, *iter_next;
     int ret = 0;
 
     /*
      * TODO: Add support for Protection Status
      */
 
-    QLIST_FOREACH(iter, &o->children, list) {
-        if (iter->format == FMT_ASSOCIATION) {
-            QLIST_FOREACH_SAFE(iter2, &iter->children, list, iter2_next) {
-                ret |= usb_mtp_deletefn(s, iter2, trans);
-            }
-        }
+    QLIST_FOREACH_SAFE(iter, &o->children, list, iter_next) {
+        ret |= usb_mtp_deletefn(s, iter, trans);
+    }
+
+    /* Avoid deleting the mtp root */
+    if (o->parent == NULL) {
+        return ret ? ret : DELETE_SUCCESS;
     }
 
     if (o->format == FMT_UNDEFINED_OBJECT) {
-- 
2.56.0


