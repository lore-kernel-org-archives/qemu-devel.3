Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3ECDBCCD1A5
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 18:42:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBHIq-0008Ds-51; Tue, 21 Oct 2025 14:41:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vBHIn-0008Cs-Ew
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 14:41:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vBHIl-0004OY-Kb
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 14:41:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761072102;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XNj6muN3REu90/r8+JwwKM3AGlDFFoXJNEx1Ju3t0lU=;
 b=CSn3z5JjZZ4sNFmVr5eYOtPLDtVpEYolBgkbCbDDdgI+Ui6ma3vazQi0L8e9nOBAcO4YWU
 HPPjFi04BVdN7l39pwv2l+UbjIizxZawafKvBjfpo7dLp3nFwTJO2Rl3pfokeg09wWkH8C
 OklC91VJvE3iWf/dEoYYb3DuVBdN9jU=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-102-nB6os1LSNVK2UcUmQhRo2Q-1; Tue, 21 Oct 2025 14:41:41 -0400
X-MC-Unique: nB6os1LSNVK2UcUmQhRo2Q-1
X-Mimecast-MFC-AGG-ID: nB6os1LSNVK2UcUmQhRo2Q_1761072101
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-87c1cc5a75dso311150706d6.0
 for <qemu-devel@nongnu.org>; Tue, 21 Oct 2025 11:41:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761072101; x=1761676901;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XNj6muN3REu90/r8+JwwKM3AGlDFFoXJNEx1Ju3t0lU=;
 b=s7Czqpx95BOyoRRTu/6g2G6Fnj0kwKu59W6QhpP+HozsW03FGFHC/r7BTVx37manon
 11ZOTQQP/ZZ93hT53c8DdXxrXRbfVCOaI09qvYYAe1JKNNl3NAqrh/qSOWtg4i+cNg+y
 Fd1CcvKCa5i2k4HbiUB+I/gYS0mKZ94f2P4l0XS0uS/xhtbs5jS9xxQZ1R7o3aT38S3A
 oDLG8/wcwNynO0DMUpOUnsZAVqUS5eLfGA7ktYaJ9YoxpSQH1ykddRHcJTfx7+8uE1IQ
 S736dLF0yaxsv6CmZxxOOy4VGFgCeuduPTaTnnIWbAvWdAe2Lrw5Uk5x0CGydFoqKTyB
 aOpA==
X-Gm-Message-State: AOJu0YxBytT11st91Ky5P5eJFdOOwxYv0ruR2VSZ5QqcpzD+NJyP3QFT
 Ekg3xIGQqDsbqJz0GfUfiTeYLtCA9ppmS9s4FNT2xhHLasWqWf6204FN9NyRbd/J+duGZbIIfLX
 9sVxr1rbtm5Ci3eIaGBFdMLuchYLtziGAwO7RE4qYyYAT6oo5cbv4cBD0e65zX7uBQj87xPQN4n
 RCwMdawOsbHfjHBTm9dxdwnPQv3kK2tSGcB8c+Jw==
X-Gm-Gg: ASbGncurclzdLklKNwVhjr5Bzo3lOFPNv3tIPZiI2Aa2W7nDr6FtlUfzOlI+BcDYbdi
 VAfFKUOTYyFUBXaHnbJjnsdZDBv/q3+f8gp3/x4qpCfyK72oq9rYZGqv9YLLY60PP3i3jKGOOMC
 clSHGus25lyAEvicVZPh8n1FmnN3Zc5IpNM/5mSruOc9KPKcQFdNBP0jHkwnoNcuPJmUHLSz2y5
 r+dYfbso79z8I9E/pEoAO+mxaTRGQ/XzcgA1eYQRl1aVpKBMF67FypRH0pAT6D24LP7so/3N37S
 RhZ0w6MiZdN6Y62w7vTCG/7D/3AdZk+Jbn9Viwp8fNcMGNrVVfVygC9Xta8xvXnH
X-Received: by 2002:a05:6214:1c0d:b0:820:8fa6:1312 with SMTP id
 6a1803df08f44-87c20426b0emr201034286d6.0.1761072100742; 
 Tue, 21 Oct 2025 11:41:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHv2SbAAI00QdBhHdK+EUwHTq3n6TvuybtxEyqg6FXcHK14qq/G5S/DME5KeTlY0gBkfSZggA==
X-Received: by 2002:a05:6214:1c0d:b0:820:8fa6:1312 with SMTP id
 6a1803df08f44-87c20426b0emr201033986d6.0.1761072100223; 
 Tue, 21 Oct 2025 11:41:40 -0700 (PDT)
Received: from x1.com ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-87cf51fd3easm74244966d6.10.2025.10.21.11.41.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Oct 2025 11:41:39 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Arun Menon <armenon@redhat.com>, peterx@redhat.com,
 Fabiano Rosas <farosas@suse.de>, Peter Maydell <peter.maydell@linaro.org>,
 Juraj Marcin <jmarcin@redhat.com>
Subject: [PATCH 3/3] migration/cpr: Fix UAF in cpr_exec_cb() when execvp()
 fails
Date: Tue, 21 Oct 2025 14:41:32 -0400
Message-ID: <20251021184132.2635958-4-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251021184132.2635958-1-peterx@redhat.com>
References: <20251021184132.2635958-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Per reported and analyzed by Peter:

https://lore.kernel.org/r/CAFEAcA82ih8RVCm-u1oxiS0V2K4rV4jMzNb13pAV=e2ivmiDRA@mail.gmail.com

Fix the issue by moving the error_setg_errno() earlier.  When at it, clear
argv variable after freed.

Resolves: Coverity CID 1641397
Fixes: a3eae205c6 ("migration: cpr-exec mode")
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/cpr-exec.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/migration/cpr-exec.c b/migration/cpr-exec.c
index 3cf44634a9..15c9895a11 100644
--- a/migration/cpr-exec.c
+++ b/migration/cpr-exec.c
@@ -149,10 +149,10 @@ static void cpr_exec_cb(void *opaque)
      * exec should only fail if argv[0] is bogus, or has a permissions problem,
      * or the system is very short on resources.
      */
-    g_strfreev(argv);
+    error_setg_errno(&err, errno, "execvp %s failed", argv[0]);
+    g_clear_pointer(&argv, g_strfreev);
     cpr_exec_unpreserve_fds();
 
-    error_setg_errno(&err, errno, "execvp %s failed", argv[0]);
     error_report_err(error_copy(err));
     migrate_set_state(&s->state, s->state, MIGRATION_STATUS_FAILED);
     migrate_set_error(s, err);
-- 
2.50.1


