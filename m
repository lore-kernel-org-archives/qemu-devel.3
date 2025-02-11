Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62E5BC0219B
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2025 22:52:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thz62-0005bh-OD; Tue, 11 Feb 2025 17:51:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1thz61-0005bT-AF
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 17:51:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1thz5y-00052V-8G
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 17:51:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739314267;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0ArIgTFYZEsCzE0iuv6JP2PM8E5g69hywmt07dGImK4=;
 b=hFwibjyzausMc6kaQCn1xRoJvHE1bRn96TVwHy18HunmnTSOtEv4RYbHjm0UfzqAPrSZS/
 IuK49xM5QgMFLwVr/cBr97u2x0194TgSnFD/ZkOTw4OxHFGoUDBWxWxV/q0oECN33TNh6P
 LVQ0r+W9768HS54WNsq218VcS/51e0k=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-221-n1ClbUsFP4eJFnMMRT_mCQ-1; Tue, 11 Feb 2025 17:51:06 -0500
X-MC-Unique: n1ClbUsFP4eJFnMMRT_mCQ-1
X-Mimecast-MFC-AGG-ID: n1ClbUsFP4eJFnMMRT_mCQ
Received: by mail-oo1-f72.google.com with SMTP id
 006d021491bc7-5fc5eb91ab2so4392803eaf.2
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2025 14:51:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739314265; x=1739919065;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0ArIgTFYZEsCzE0iuv6JP2PM8E5g69hywmt07dGImK4=;
 b=BoF0V6jBWkUWu2uVHIX6917QimpQIs8XbZhZOXuS123CJq0h1xMFfXFzi9iggMyQgP
 LHduzKHs9lZgPrdohBzNRQbyvkcugFrtr1twg6eC/SVZgROqdVlAyZamiPObzxTsL/X+
 PGItgcmLLpo505rlIgjcYiIRRCFIrh8gfCXTTGg0Jerbi1TM4v4lR9CxSN0IqdSrccjp
 8wr4ZhS2EqArVs8OU93JIuD57N16ReBbqnzRNnkFa1pIeHPs46IXwFzkDK9AvPIySkTP
 ToRWPDsJDuRxbfDxk7oo8bDaQFgTGiEfsbxarAWjRvVn5gnRNBHDuZjPC7YNN2E4984q
 iS5w==
X-Gm-Message-State: AOJu0YzzKVlwBeEhIY/wryLWcraxt63Jj3DKgdqs3t8IW2SDC8iTcs1S
 RumZikHGTAC+T0fvVIpejXLCgLtSlG7afHindlux1qIDb4D6WWEvluWuacxm4zKlWG6ig0Nwtkh
 Aw2mxvO55ii4StAGTIS8fwXsNj13kUDC2Q10LcTPvFdcXzzyi2zVIQE0645aPJ5JSFSHCQdU0bt
 ikOKgeQtHD7OyrJUaABanX5Wsx4SvSlMrymw==
X-Gm-Gg: ASbGncteEad/29q6orP8joFb8CcTh2Ez3qvq7z6WovLNDrMC/2woPfTmOGRqYRvxdpM
 3aXSRc9W0fyz8hthFryUqKIUKvisEJGQIgogggrhtFgVE96t14QxIFaf20l4qQ8ssmTj3MrzdPS
 SJcg0I4aqYRILsoZzSRuJ+dSeaZCThldnjqOXCXcViknZ5NcsrBq0LLPqPofjZaxHB/Yk4CXrbU
 ecjJJaFUDN+9MVHtV30WxniQNBTN87kcn6OcBdX5MV26BAvTpTdpKvb
X-Received: by 2002:a05:6820:161e:b0:5fc:947b:c337 with SMTP id
 006d021491bc7-5fca141b8bcmr768850eaf.0.1739314265042; 
 Tue, 11 Feb 2025 14:51:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG0QtoAj7YScHU6hKZ6TE7PCH+WlOG5xicGY808DUUNerDrm7xAi0Lh8DfPAQE1748nNQUgfg==
X-Received: by 2002:a05:6820:161e:b0:5fc:947b:c337 with SMTP id
 006d021491bc7-5fca141b8bcmr768840eaf.0.1739314264693; 
 Tue, 11 Feb 2025 14:51:04 -0800 (PST)
Received: from x1.com ([2604:7a40:2041:2b00::1000])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5fca0992fd0sm482515eaf.34.2025.02.11.14.51.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Feb 2025 14:51:03 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org,
	Stefan Hajnoczi <stefanha@redhat.com>
Cc: peterx@redhat.com, Paolo Bonzini <pbonzini@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 William Roche <william.roche@oracle.com>
Subject: [PULL 01/14] system/physmem: take into account fd_offset for file
 fallocate
Date: Tue, 11 Feb 2025 17:50:45 -0500
Message-ID: <20250211225059.182533-2-peterx@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250211225059.182533-1-peterx@redhat.com>
References: <20250211225059.182533-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: William Roche <william.roche@oracle.com>

Punching a hole in a file with fallocate needs to take into account the
fd_offset value for a correct file location.
But guest_memfd internal use doesn't currently consider fd_offset.

Fixes: 4b870dc4d0c0 ("hostmem-file: add offset option")

Signed-off-by: William Roche <william.roche@oracle.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Link: https://lore.kernel.org/r/20250122194053.3103617-2-william.roche@oracle.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 system/physmem.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/system/physmem.c b/system/physmem.c
index 67c9db9daa..235015f3ea 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -3797,18 +3797,19 @@ int ram_block_discard_range(RAMBlock *rb, uint64_t start, size_t length)
             }
 
             ret = fallocate(rb->fd, FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE,
-                            start, length);
+                            start + rb->fd_offset, length);
             if (ret) {
                 ret = -errno;
-                error_report("%s: Failed to fallocate %s:%" PRIx64 " +%zx (%d)",
-                             __func__, rb->idstr, start, length, ret);
+                error_report("%s: Failed to fallocate %s:%" PRIx64 "+%" PRIx64
+                             " +%zx (%d)", __func__, rb->idstr, start,
+                             rb->fd_offset, length, ret);
                 goto err;
             }
 #else
             ret = -ENOSYS;
             error_report("%s: fallocate not available/file"
-                         "%s:%" PRIx64 " +%zx (%d)",
-                         __func__, rb->idstr, start, length, ret);
+                         "%s:%" PRIx64 "+%" PRIx64 " +%zx (%d)", __func__,
+                         rb->idstr, start, rb->fd_offset, length, ret);
             goto err;
 #endif
         }
@@ -3855,6 +3856,7 @@ int ram_block_discard_guest_memfd_range(RAMBlock *rb, uint64_t start,
     int ret = -1;
 
 #ifdef CONFIG_FALLOCATE_PUNCH_HOLE
+    /* ignore fd_offset with guest_memfd */
     ret = fallocate(rb->guest_memfd, FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE,
                     start, length);
 
-- 
2.47.0


