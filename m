Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E669FC71151
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Jun 2025 14:09:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uQ55G-0004Bz-Ap; Fri, 13 Jun 2025 10:08:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uQ550-0004AU-L2
 for qemu-devel@nongnu.org; Fri, 13 Jun 2025 10:08:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uQ54y-0001We-9v
 for qemu-devel@nongnu.org; Fri, 13 Jun 2025 10:08:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749823703;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=81vpRbPBsl4TxnkuqSVUCogqP7kEXR/iTLHp+dsYNmM=;
 b=EnoM5/vCssczljZdFGDxQBoE62Etyd6BM23Img2ZV3ClhsV3gKofpJi2CZ3B8QCnqEvvSR
 PeMr3n7ARy+q6cVG/ITJQfqjmY/hzTr2j+r8/TKntOtEacMzXk10Jqcok0/3uElkR/RVDb
 b1Dnqw2RUIG/cdm+IIZZYdZLcq2w4Ao=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-605-6WtMKKLbPGmKBks8W2fb0Q-1; Fri, 13 Jun 2025 10:08:21 -0400
X-MC-Unique: 6WtMKKLbPGmKBks8W2fb0Q-1
X-Mimecast-MFC-AGG-ID: 6WtMKKLbPGmKBks8W2fb0Q_1749823701
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-4a441a769c7so43897141cf.3
 for <qemu-devel@nongnu.org>; Fri, 13 Jun 2025 07:08:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749823700; x=1750428500;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=81vpRbPBsl4TxnkuqSVUCogqP7kEXR/iTLHp+dsYNmM=;
 b=tDtcOYrcHJQqmPEVjhzETp5Ixnc//0zyKq/kHokvkugqFJKUXhTrkCKsSDuVP755eH
 62CQt4cFWFGIbAMbtSjQi3fASIRWBdo+kbKtsJYlloGDeRxGavzITzG1+P5dxyjnEzQI
 6Hl1V5S09HriDYBoy5CHmUCS1lbavF1lUIGvBk/CmNSDj1AU7GsAA3VtEevDwSWkaEm8
 vdZOJPrRw/AJ3Am9dSsgAm37JpsW0Y4iT1HNOovMOot7IdgpL1JihYMsNv9dWCqVjDXB
 ZwOpvjL+Vfoq569tq952p8RTq6D+C13bi7rLshGf1P3DZeoA9+LMrMdTeOgHWicWiHBx
 mfhg==
X-Gm-Message-State: AOJu0YxjFeZSO91v9q/NOYQNbLPKU65vUk7CDCgMMqIO5vJO3MYc3ZJR
 EO2r5lCUH9OLdjbIXTjApTDtKCHrSBm1+Nch5AyUwPGxNVzrc5wfv5yBHQyVUiavjfHlovnyg+i
 570RuGTjo+8e2HO7Iyh7XZWVxSwrvc3bRKywGqeEeZU5XiT3sGhbJxAsBVdVH2yYZVnrVHMKESv
 O/JkYc21BOXkVRPIDIe/XH1zwQqyf6gO42A2xMNw==
X-Gm-Gg: ASbGncve3CzkdqMrD8scgqko64VlMi5fYaytKfctIoNe++NmgWyluT47NJdffSYyrCz
 FM9Qpir2WFke3hYytJT6GZjiRL2t5PAyZ30LczTTLCRE7kcjQ4tLIcmbaAS8HX3dUBH48FVmZzF
 cIbF8zJJ+S2JbfLX9vx8EW++ov/BT2faOJJ2Ox0C4Jy++nS4gMQeQDA7X8sIsbIiu4qdkcMU/WB
 xd9HrXfXu7urDVnwvnxHDVmygCkHYvAVPTQxxP0rUIn41kdO2GEhVusBA9X3e/XW1pWYLxxV8hu
 FX2dG8tJbCI=
X-Received: by 2002:a05:622a:4c11:b0:4a7:1446:4001 with SMTP id
 d75a77b69052e-4a72feedb8amr45183241cf.24.1749823700205; 
 Fri, 13 Jun 2025 07:08:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH4HLYN8v/5xHROP0ltWtOSfOaLhMxOQTTFEabBLoz+E7A0nmQNWAdq2pu08ZOh2UwF7CiZrg==
X-Received: by 2002:a05:622a:4c11:b0:4a7:1446:4001 with SMTP id
 d75a77b69052e-4a72feedb8amr45182871cf.24.1749823699735; 
 Fri, 13 Jun 2025 07:08:19 -0700 (PDT)
Received: from x1.com ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4a72a52a1ddsm17384111cf.81.2025.06.13.07.08.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Jun 2025 07:08:19 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, Juraj Marcin <jmarcin@redhat.com>,
 Mario Casquero <mcasquer@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Yanfei Xu <yanfei.xu@bytedance.com>
Subject: [PATCH v3 11/11] migration/postcopy: Avoid clearing dirty bitmap for
 postcopy too
Date: Fri, 13 Jun 2025 10:08:01 -0400
Message-ID: <20250613140801.474264-12-peterx@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250613140801.474264-1-peterx@redhat.com>
References: <20250613140801.474264-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

This is a follow up on the other commit "migration/ram: avoid to do log
clear in the last round" but for postcopy.

https://lore.kernel.org/r/20250514115827.3216082-1-yanfei.xu@bytedance.com

I can observe more than 10% reduction of average page fault latency during
postcopy phase with this optimization:

  Before: 268.00us (+-1.87%)
  After:  232.67us (+-2.01%)

The test was done with a 16GB VM with 80 vCPUs, running a workload that
busy random writes to 13GB memory.

Cc: Yanfei Xu <yanfei.xu@bytedance.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/ram.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/migration/ram.c b/migration/ram.c
index a1d0e8ada2..cd4aafd15c 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -835,8 +835,10 @@ static inline bool migration_bitmap_clear_dirty(RAMState *rs,
      * protections isn't needed as we know there will be either (1) no
      * further writes if migration will complete, or (2) migration fails
      * at last then tracking isn't needed either.
+     *
+     * Do the same for postcopy due to the same reason.
      */
-    if (!rs->last_stage) {
+    if (!rs->last_stage && !migration_in_postcopy()) {
         /*
          * Clear dirty bitmap if needed.  This _must_ be called before we
          * send any of the page in the chunk because we need to make sure
-- 
2.49.0


