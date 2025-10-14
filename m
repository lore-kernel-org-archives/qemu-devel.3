Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 281B9CCD184
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 13:39:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8fEj-0006Ay-S4; Tue, 14 Oct 2025 09:38:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v8fEe-00069D-GR
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 09:38:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v8fEZ-0001B0-Pa
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 09:38:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760449114;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=npqTcVShS0e/GZMLlgnWk6EwsCoh0Dh4KtuIlmkDB7E=;
 b=SffshJl3pPkC5QjbC5aOD4HYljzX5GGbEk9o/4BxuLGz3RDoZA+hUtBUNcu5KMLvwojbKw
 19YtJLeLbTQ5w7r25++QBwQq9BVeL5zAe/Mns9JkduNHoZlcO4oDXUZE9jl0j5baB2zwI5
 P4L0ak3RcoB2NL5KTHm/gpGAObvtkyc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-440-eOKegtuVM5-ZgLUPRDCbVw-1; Tue, 14 Oct 2025 09:38:33 -0400
X-MC-Unique: eOKegtuVM5-ZgLUPRDCbVw-1
X-Mimecast-MFC-AGG-ID: eOKegtuVM5-ZgLUPRDCbVw_1760449112
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-4256fae4b46so3787991f8f.0
 for <qemu-devel@nongnu.org>; Tue, 14 Oct 2025 06:38:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760449111; x=1761053911;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=npqTcVShS0e/GZMLlgnWk6EwsCoh0Dh4KtuIlmkDB7E=;
 b=OE0H/Rs7ALSEYMMzdIKxBUy6POdWGrD3ola706s7PPko1O5ebKifKuQcNGQtM5K0Xz
 YSbJSLN4FBJGdj+wb89zYIgdcENeqdAvYgzg7tobZribR9SrELJmPa8XgIZaKxlkPPW+
 StmgMii2g4US4drwdk+pcZPPJ9cK98SvOlg1FJwvemjBHq06YYC8+ZAp4K6buBIgfSGi
 cpIuvsqx050yT9AE0CYHLtqSreypcb17bAvkhT2xgII8INHF2zXJLxOKa2H+v9XSpFvH
 PS2XjYQbIqZv+fVSJTvLAr6ixx8jnrMqELYGQbnvqeEFMTiszOZ7axxKGbbpFhQgexS5
 E91A==
X-Gm-Message-State: AOJu0YzOOIdBLwJklE0Cxum3DCh+dlaPoJ6gih711eUjrcJsLdezV6vj
 00OWWxxN3M6Z7BBAxjIFXaNjLRtTUq9EqIh3uydtKWCeYUptmTQ3Z0Eu/Xt2lHKfW1y137OHNln
 YyUY5yVsFlZvIwwHDizhicJZuxrkCRka3SsaxhYrbdmBR98XdSfrocKPrZsMkPSgOcE5NigOp/i
 Dx1LMvL0ZI9jLItmfDDppKPDJRMbkAJnIp/ug2VwoD
X-Gm-Gg: ASbGncuVqqveIQ22gstM8PJI8a83rjrO/+7JAhX8KZ5BJ0a5OHeZX3EIeFLvTuRa//k
 ahtj6OiSFl0ME0pC9C6wZVTg/4oxG8rIg4d4IV8fZSGffW1ilOjO+9bhjF3hmCqbkt0paaINjR6
 O8gOa3gNw0J1YghnKpAV2ca9CZtP8Ie2blrzuc1BZbEDaM4RMLZsSEs5IHW0SVDMxF69NRtNyx/
 W7X7GXYkt58YErPKe4GAo50QBSES3LrhiOVck1O9AY1dFNjdI2tU4wxc7KH8+XjebdDYYgu7hCp
 VS/XPUYJW1tKKwM83JweHdP1xM/hcMcly1Nj2Admu1swJRZDWO1XKEUMLvH4dzq+JW66trVerV0
 tC0ewNVoTFXNfapgQFxKTh4JypuAfEAvMJiRdugu3Zuw=
X-Received: by 2002:a05:6000:2681:b0:3fe:1d64:1871 with SMTP id
 ffacd0b85a97d-4266e8de136mr15802528f8f.43.1760449110631; 
 Tue, 14 Oct 2025 06:38:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEpn9TdcctsX5R2l6ZapaOFPFL00LPWCqLizUp9Qn7u93U+Blj2vpvXuCyvqYAeXdVUEkDs6w==
X-Received: by 2002:a05:6000:2681:b0:3fe:1d64:1871 with SMTP id
 ffacd0b85a97d-4266e8de136mr15802509f8f.43.1760449110183; 
 Tue, 14 Oct 2025 06:38:30 -0700 (PDT)
Received: from [192.168.10.48] ([151.61.22.175])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426ce5e8b31sm23828846f8f.54.2025.10.14.06.38.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Oct 2025 06:38:27 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 27/28] timer: constify some functions
Date: Tue, 14 Oct 2025 15:37:12 +0200
Message-ID: <20251014133713.1103695-27-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251014133540.1103268-1-pbonzini@redhat.com>
References: <20251014133540.1103268-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
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

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/qemu/timer.h | 6 +++---
 util/qemu-timer.c    | 8 ++++----
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/qemu/timer.h b/include/qemu/timer.h
index abd2204f3be..aec730ac257 100644
--- a/include/qemu/timer.h
+++ b/include/qemu/timer.h
@@ -699,7 +699,7 @@ void timer_mod_anticipate(QEMUTimer *ts, int64_t expire_time);
  *
  * Returns: true if the timer is pending
  */
-bool timer_pending(QEMUTimer *ts);
+bool timer_pending(const QEMUTimer *ts);
 
 /**
  * timer_expired:
@@ -710,7 +710,7 @@ bool timer_pending(QEMUTimer *ts);
  *
  * Returns: true if the timer has expired
  */
-bool timer_expired(QEMUTimer *timer_head, int64_t current_time);
+bool timer_expired(const QEMUTimer *timer_head, int64_t current_time);
 
 /**
  * timer_expire_time_ns:
@@ -720,7 +720,7 @@ bool timer_expired(QEMUTimer *timer_head, int64_t current_time);
  *
  * Returns: the expiry time in nanoseconds
  */
-uint64_t timer_expire_time_ns(QEMUTimer *ts);
+uint64_t timer_expire_time_ns(const QEMUTimer *ts);
 
 /**
  * timer_get:
diff --git a/util/qemu-timer.c b/util/qemu-timer.c
index 1fb48be281a..56f11b6a641 100644
--- a/util/qemu-timer.c
+++ b/util/qemu-timer.c
@@ -89,7 +89,7 @@ static inline QEMUClock *qemu_clock_ptr(QEMUClockType type)
     return &qemu_clocks[type];
 }
 
-static bool timer_expired_ns(QEMUTimer *timer_head, int64_t current_time)
+static bool timer_expired_ns(const QEMUTimer *timer_head, int64_t current_time)
 {
     return timer_head && (timer_head->expire_time <= current_time);
 }
@@ -475,12 +475,12 @@ void timer_mod_anticipate(QEMUTimer *ts, int64_t expire_time)
     timer_mod_anticipate_ns(ts, expire_time * ts->scale);
 }
 
-bool timer_pending(QEMUTimer *ts)
+bool timer_pending(const QEMUTimer *ts)
 {
     return ts->expire_time >= 0;
 }
 
-bool timer_expired(QEMUTimer *timer_head, int64_t current_time)
+bool timer_expired(const QEMUTimer *timer_head, int64_t current_time)
 {
     return timer_expired_ns(timer_head, current_time * timer_head->scale);
 }
@@ -649,7 +649,7 @@ void init_clocks(QEMUTimerListNotifyCB *notify_cb)
 #endif
 }
 
-uint64_t timer_expire_time_ns(QEMUTimer *ts)
+uint64_t timer_expire_time_ns(const QEMUTimer *ts)
 {
     return timer_pending(ts) ? ts->expire_time : -1;
 }
-- 
2.51.0


