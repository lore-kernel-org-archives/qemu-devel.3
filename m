Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 013BBC5AD49
	for <qemu-devel@archiver.kernel.org>; Tue, 27 May 2025 23:14:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uK3Tr-0003IF-Kc; Tue, 27 May 2025 19:13:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uK3Tp-0003Hw-ET
 for qemu-devel@nongnu.org; Tue, 27 May 2025 19:13:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uK3Tn-0001D3-W8
 for qemu-devel@nongnu.org; Tue, 27 May 2025 19:13:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748387587;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Fnl0jufKoCdqJWKPPonqmHJMaxm0iVprfOvoshe4GEw=;
 b=H3YG6e2NcH1mwyyIqT1Af6UCVmRLJb0KS7oBYL9wFaxXID+7XpGOMCUtf+jm9UuVmYiDOM
 xqQYDgvInlW2iS3dhQJxx0KEJ0p8ecrjZdmLkme4s03c5rib3cNFLhDiL4GrTSB+GyCHTp
 Ahq4IJrm3NM7UfUKsInrskd28jJJGfY=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-635-eH28219XMAGvUCjS8pflkw-1; Tue, 27 May 2025 19:13:06 -0400
X-MC-Unique: eH28219XMAGvUCjS8pflkw-1
X-Mimecast-MFC-AGG-ID: eH28219XMAGvUCjS8pflkw_1748387585
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-4767348e239so59445271cf.0
 for <qemu-devel@nongnu.org>; Tue, 27 May 2025 16:13:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748387585; x=1748992385;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Fnl0jufKoCdqJWKPPonqmHJMaxm0iVprfOvoshe4GEw=;
 b=MhNpUquxnSDjdaAtiXkY5yPOLxPOAefSyTBEbHazqIXURHE+ihleVbHMmoAPwRAxl9
 Sa8vWJoZEFleZ1IR0N2+XMQB2t8bRxppDM9lULAAWqcr6X/kaTTSIvDelo1PKbeRSChg
 zCTR6plWZ9XczlZCjy6IcSVFqLv0Fz/WTC2qYzNPOG/DL15xG9NXXpo8vQO4Soczzkcq
 EMTmystDG3Mj72bsRcidLxHDUzdztWwXgN20J4nu94qQD2l7dps1aD0k+cGXS+eNYN3v
 ncpWzFdyCZi5amcH1gMSTnM0gqmIZ/mJOfuAXyh1Tzr9Hv3OGzuKmBOyG7vMUMnuuXYD
 S9+A==
X-Gm-Message-State: AOJu0YykwYQlATuYXI50vICEfPQxJnbNsO/c0SUMx8NIhBKW4+oF8uUg
 TmPhSxZOVn34mp2IP+3v4OTfInKbPmT5RLZAAyT5uFRtPd3WUPh7U/mxjid5dx/HjXNLKTdpp12
 +Lzc3vThfJyOtZbi/wzonyhLykpI2rCqs2S14HQ4hUljjFxLO2kh6tpb0DxDTFEUZGKiq7Oc8hf
 ajiNEiNzo3vGqwW+QMCxM1odzCCv1Lud94qg6Byw==
X-Gm-Gg: ASbGnct6tW9d+wliyWFG/MPrwZR+PiKKuQEo+0x+oKXixm0u+GXopL/Pt9V3SEyMcPE
 fYawBCLoWfIl0gspf0v+/8ToS0o+pQ0dJSsTEzUMZG+kqB7PUX7nXI8D3WEkRMJTSvookFZLrzp
 GtysmHy8U37VL5Rq23T62FCuCqUnXobeBw9L51VzBvnm2Txf+WIpOAnU99G0kNAvYpA2ydIZUOc
 c9uB8miSiaab9Ui0+cvbnyoGrpMKTSuolSiVsJ47Oy4ZyVdg2zGNJ4fHdzNV44T63mRhQYJCTAI
X-Received: by 2002:a05:622a:544a:b0:499:1f1e:ddf3 with SMTP id
 d75a77b69052e-49f467532e4mr270546541cf.19.1748387584978; 
 Tue, 27 May 2025 16:13:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IETs+Kl5GYcefT1FqlI0lZOmFcbTsQEYEEOATUDxERn6C+RN4ZxOT6Od6l8gfncUULNgs3SNw==
X-Received: by 2002:a05:622a:544a:b0:499:1f1e:ddf3 with SMTP id
 d75a77b69052e-49f467532e4mr270546131cf.19.1748387584597; 
 Tue, 27 May 2025 16:13:04 -0700 (PDT)
Received: from x1.com ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4a2f939cad3sm1984441cf.79.2025.05.27.16.13.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 May 2025 16:13:03 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Dr . David Alan Gilbert" <dave@treblig.org>, peterx@redhat.com,
 Alexey Perevalov <a.perevalov@samsung.com>,
 Fabiano Rosas <farosas@suse.de>, Juraj Marcin <jmarcin@redhat.com>
Subject: [PATCH 07/13] migration/postcopy: Add blocktime fault counts per-vcpu
Date: Tue, 27 May 2025 19:12:42 -0400
Message-ID: <20250527231248.1279174-8-peterx@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250527231248.1279174-1-peterx@redhat.com>
References: <20250527231248.1279174-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.907,
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

Add a field to count how many remote faults one vCPU has taken.  So far
it's still not used, but will be soon.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/postcopy-ram.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index 5cbc7aa77e..46a8fdb6c2 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -116,6 +116,8 @@ typedef struct PostcopyBlocktimeContext {
     uint64_t *vcpu_blocktime_start;
     /* blocktime per vCPU */
     uint64_t *vcpu_blocktime_total;
+    /* count of faults per vCPU */
+    uint64_t *vcpu_faults_count;
     /* page address per vCPU */
     uintptr_t *vcpu_addr;
     /* total blocktime when all vCPUs are stopped */
@@ -136,6 +138,7 @@ static void destroy_blocktime_context(struct PostcopyBlocktimeContext *ctx)
 {
     g_free(ctx->vcpu_blocktime_start);
     g_free(ctx->vcpu_blocktime_total);
+    g_free(ctx->vcpu_faults_count);
     g_free(ctx->vcpu_addr);
     g_free(ctx);
 }
@@ -155,6 +158,7 @@ static struct PostcopyBlocktimeContext *blocktime_context_new(void)
 
     ctx->vcpu_blocktime_start = g_new0(uint64_t, smp_cpus);
     ctx->vcpu_blocktime_total = g_new0(uint64_t, smp_cpus);
+    ctx->vcpu_faults_count = g_new0(uint64_t, smp_cpus);
     ctx->vcpu_addr = g_new0(uintptr_t, smp_cpus);
     ctx->exit_notifier.notify = migration_exit_cb;
     qemu_add_exit_notifier(&ctx->exit_notifier);
@@ -855,6 +859,7 @@ void mark_postcopy_blocktime_begin(uintptr_t addr, uint32_t ptid,
     dc->last_begin = current_us;
     dc->vcpu_blocktime_start[cpu] = current_us;
     dc->vcpu_addr[cpu] = addr;
+    dc->vcpu_faults_count[cpu]++;
 
     /*
      * The caller should only inject a blocktime entry when the page is
-- 
2.49.0


