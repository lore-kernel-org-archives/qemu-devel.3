Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9039DECE58A
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2024 20:13:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snkkC-00019V-LO; Mon, 09 Sep 2024 16:12:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1snkkB-000141-5e
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 16:12:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1snkk7-000557-RO
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 16:12:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725912731;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0yCYyH1EuoqCtDP/Ff8kG1W6vFMEFbXZwtdKjoE01Z8=;
 b=ApZ5F63nEi/dFTGL9S9rm2npClBrqe5TfrnkzFStAwj1BbFwq+x/bgEf7c/Snf/OSoKHhF
 0UmA7/harmPLQmdRGL9p6zQL72C+kuSXhrdXPwkw1uRIUp1XYCVE85eATK73q3LBEg+TVM
 cUOSGPhMAY2mLl7dmcTIHnOFHa2IjkQ=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-339-vMVvLR7oMFqcJjtHR__zGA-1; Mon, 09 Sep 2024 16:12:10 -0400
X-MC-Unique: vMVvLR7oMFqcJjtHR__zGA-1
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-458353d3635so25799041cf.0
 for <qemu-devel@nongnu.org>; Mon, 09 Sep 2024 13:12:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725912729; x=1726517529;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0yCYyH1EuoqCtDP/Ff8kG1W6vFMEFbXZwtdKjoE01Z8=;
 b=RQc63Lcut7QY7GAEpMoR6nSyKZ1pw+ue8gCUAzlS9j4cMtfVjhwzUMseWdfuMCdMa0
 L5gUyMUfjEHKJhYGYnKOiiTQ/BwvMIRyk2cgKGZ52b0FI4HfTCsD24j5zweL6DK2jow4
 xG30LOoqf6WL2n7/J6IlfPnbBe7dlZbSWShm2hncDgA/sLt2CxRiHcLeQErfZRgzQKVK
 KkyD/PcWkStI9HMKgYJCP1dO+mkLtgHc9wpgXqAgnoP0H1MbuBhPbBXxNNrsUGmRwz1X
 a3n5twHsrolzL6Xoait3EbVg3qtz2jNI8kCno8yv8EBgwQIaLH1SL5JL5p1kIyLwXgwi
 En7g==
X-Gm-Message-State: AOJu0YzzO8iEOS7RTIUVBXVHMi/MFN3k8dssTWlcNQ+04UWmEqkUVNKL
 1ImJJHh3TdUxCUNdMhGiDAIlbQhqVjnsDu8PD1swhZZoVTY+Vmo/O30uJ0g/Clq3t0ejrPE0/Ca
 MihX1zjLyU6GU41RMpVNdHo7suq5wMAVfnJncuoNBtKZscOSlhw9yXlO5gt0CglpsL5wvGX6YTy
 KUa65PWt4irT3E9E2mteB6GHRrLkzxHRdWwQ==
X-Received: by 2002:a05:622a:1105:b0:458:3ab3:84f9 with SMTP id
 d75a77b69052e-4583c71e612mr18030971cf.9.1725912729365; 
 Mon, 09 Sep 2024 13:12:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHiWn1w8zUW8ErmVutZLM011NNQdBen3vzF2zH0CPX5HEI06hiVq8oBjkWciZ17sNBr1r9s8g==
X-Received: by 2002:a05:622a:1105:b0:458:3ab3:84f9 with SMTP id
 d75a77b69052e-4583c71e612mr18030401cf.9.1725912728895; 
 Mon, 09 Sep 2024 13:12:08 -0700 (PDT)
Received: from x1n.redhat.com (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-45822f93978sm22838561cf.83.2024.09.09.13.12.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Sep 2024 13:12:07 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, "Denis V. Lunev" <den@openvz.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 9/9] system: improve migration debug
Date: Mon,  9 Sep 2024 16:11:47 -0400
Message-ID: <20240909201147.3761639-10-peterx@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240909201147.3761639-1-peterx@redhat.com>
References: <20240909201147.3761639-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: "Denis V. Lunev" <den@openvz.org>

Right now migration_throttle() tracepoint lacks very important
important information, i.e. no one could easily say how much the guest
is throttled. This makes difficult to debug guest quality of service
during migration.

This patch adds one more tracepoint into cpu_throttle_set() which is
actually doing this job.

Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Peter Xu <peterx@redhat.com>
CC: Fabiano Rosas <farosas@suse.de>
CC: Paolo Bonzini <pbonzini@redhat.com>
Link: https://lore.kernel.org/r/20240905191941.310592-1-den@openvz.org
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 system/cpu-throttle.c | 3 +++
 system/trace-events   | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/system/cpu-throttle.c b/system/cpu-throttle.c
index c951a6c65e..7632dc6143 100644
--- a/system/cpu-throttle.c
+++ b/system/cpu-throttle.c
@@ -28,6 +28,7 @@
 #include "qemu/main-loop.h"
 #include "sysemu/cpus.h"
 #include "sysemu/cpu-throttle.h"
+#include "trace.h"
 
 /* vcpu throttling controls */
 static QEMUTimer *throttle_timer;
@@ -95,6 +96,8 @@ void cpu_throttle_set(int new_throttle_pct)
      */
     bool throttle_active = cpu_throttle_active();
 
+    trace_cpu_throttle_set(new_throttle_pct);
+
     /* Ensure throttle percentage is within valid range */
     new_throttle_pct = MIN(new_throttle_pct, CPU_THROTTLE_PCT_MAX);
     new_throttle_pct = MAX(new_throttle_pct, CPU_THROTTLE_PCT_MIN);
diff --git a/system/trace-events b/system/trace-events
index 2ed1d59b1f..074d001e90 100644
--- a/system/trace-events
+++ b/system/trace-events
@@ -44,3 +44,6 @@ dirtylimit_state_finalize(void)
 dirtylimit_throttle_pct(int cpu_index, uint64_t pct, int64_t time_us) "CPU[%d] throttle percent: %" PRIu64 ", throttle adjust time %"PRIi64 " us"
 dirtylimit_set_vcpu(int cpu_index, uint64_t quota) "CPU[%d] set dirty page rate limit %"PRIu64
 dirtylimit_vcpu_execute(int cpu_index, int64_t sleep_time_us) "CPU[%d] sleep %"PRIi64 " us"
+
+# cpu-throttle.c
+cpu_throttle_set(int new_throttle_pct)  "set guest CPU throttled by %d%%"
-- 
2.45.0


