Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DF3ACAC5B9
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Sep 2025 15:56:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3G9N-000168-2t; Mon, 29 Sep 2025 11:50:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v3G95-00010P-8t
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 11:50:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v3G8k-0000aY-K5
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 11:50:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759161011;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1UYvpWRO/JEP1N+v0NfQMK0anDtilvG7xZppl/bh2cs=;
 b=CLKEl4YvEOJEOzgNw0+LGsTMJF26cASQG9x9XhwEMwESgo3imxEqHwL2geLc905Vfb1XRN
 f7SiUU9UwjIDysSYq7CPSi1PSdwfzaHxRDx7g1NpL0h93CgzGDaaGrXN6Je2LMB66fuOlF
 y+tpmBdUHadHBbEBeTy7Vj7TsjZ/hUg=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-287-LRocHlJWMlCvrdYNJRAjEw-1; Mon, 29 Sep 2025 11:50:08 -0400
X-MC-Unique: LRocHlJWMlCvrdYNJRAjEw-1
X-Mimecast-MFC-AGG-ID: LRocHlJWMlCvrdYNJRAjEw_1759161008
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-634c01ca90fso6518558a12.1
 for <qemu-devel@nongnu.org>; Mon, 29 Sep 2025 08:50:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759161007; x=1759765807;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1UYvpWRO/JEP1N+v0NfQMK0anDtilvG7xZppl/bh2cs=;
 b=MY7ufNWWXx1OPldrSTvnrGVC2d43103+NijW443WoZIQupr2MQPdqNiHxH/OPVA41s
 TZYwQlj8+cVDJLi6FQVomzpC56h+zfpJDn6wDmZXto3LrnnoLxFnHGGKNSpAuU+ao8Qi
 3HoWkEUkevHczYeZkZydKTtN2t1q6aam8sSGniep8SuUpa1iLvVd2SIsUyL3QpH7DSe8
 PptlwfrJCt9Gfyk/Ez2k4RNaaq6Ns3MJEFeYbYWyS8fNHZw8gyEXTSkRL8B88RLebWNN
 GxsZAzVPDyK+j6pk6vNhFGAqZLy04isLVpuMKxEvOJZ0NuBiB+fsqsiIUZZZXI4zVETU
 CYzA==
X-Gm-Message-State: AOJu0YyXikHsbSSuBtyiASA4Ln8bqfhJIkLuPv7SOGuXGVTHmhTzWru7
 0TuYx5qKr4vxb97m/MR6L8EWvZqtrP5IXRHALWZ8AN4pCTZY+7JK1EL1Gc0Bia9zlF8tkiwVqhP
 o5r2wlUes6DJ4vBXgvoyZVNPOwpxQ+9rFd7PmX0FpypnP53naDXYa0XxesO4uFqretcc56t4wUD
 j65a+7qdnhWCc0uMgwopH0A0USI6MTywJITNlV0uVf
X-Gm-Gg: ASbGncuUzmByL5SaJEO3s3+mEeN473PItNvktklkFeMKpq5NIKPKZeWXd/JIUhYycZE
 MCzO5DiWZpgdpxd3sUq1B5Tqk9BalLWNsefcvMhMpOJg8KsIIrJE3MTR8NHF655RwFUuRPYrbfb
 BZybOrbz4SQ/ODVz6cPuWBgWxYo6jPEqOPP7JtftNaJWeJ7FBUVoLspmdITCkb00eeU9kxbO4aT
 ninD4grvpJzsNzTgCD4mcYBZQwli9wcK1HGl1Fb28MuUE21D6RkIjou7Q1d4mU33wCtDLdz1msF
 JrsxvltA/ET+sNlE0vBr+JpCFCLo5NV2hAGhPge8C1vFiggoFhfT1MwrknPo/IuIuM8rlARgMp8
 DzBrRnCqiRep4xSaWOzL3s3lQEFivEk9sXgD6+xTptEhp8Q==
X-Received: by 2002:a17:907:86a6:b0:b30:c059:f663 with SMTP id
 a640c23a62f3a-b34bc970e65mr1744249466b.64.1759161007216; 
 Mon, 29 Sep 2025 08:50:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEIxmGgeQXdAZ75QQmrZZW4Hc3n5hES5tQ4jVsFmLv3QAstwb41N3BbgxYOJl9x+OFhq12wRQ==
X-Received: by 2002:a17:907:86a6:b0:b30:c059:f663 with SMTP id
 a640c23a62f3a-b34bc970e65mr1744245266b.64.1759161006602; 
 Mon, 29 Sep 2025 08:50:06 -0700 (PDT)
Received: from [192.168.10.48] ([176.206.127.188])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b3d277598bdsm332933166b.3.2025.09.29.08.50.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Sep 2025 08:50:05 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Tanish Desai <tanishdesai37@gmail.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Mads Ynddal <mads@ynddal.dk>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, qemu-rust@nongnu.org
Subject: [PATCH 10/16] rust: qdev: add minimal clock bindings
Date: Mon, 29 Sep 2025 17:49:32 +0200
Message-ID: <20250929154938.594389-11-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250929154938.594389-1-pbonzini@redhat.com>
References: <20250929154938.594389-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.513,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

Add the minimal support that is needed by pl011's event and tracepoint.

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/hw/core/src/qdev.rs | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/rust/hw/core/src/qdev.rs b/rust/hw/core/src/qdev.rs
index a4493dbf011..c3097a284d7 100644
--- a/rust/hw/core/src/qdev.rs
+++ b/rust/hw/core/src/qdev.rs
@@ -411,6 +411,39 @@ fn init_gpio_out(&self, pins: &[InterruptSource]) {
 
 impl<R: ObjectDeref> DeviceMethods for R where R::Target: IsA<DeviceState> {}
 
+impl Clock {
+    pub const PERIOD_1SEC: u64 = bindings::CLOCK_PERIOD_1SEC;
+
+    pub const fn period_from_ns(ns: u64) -> u64 {
+        ns * Self::PERIOD_1SEC / 1_000_000_000
+    }
+
+    pub const fn period_from_hz(hz: u64) -> u64 {
+        if hz == 0 {
+            0
+        } else {
+            Self::PERIOD_1SEC / hz
+        }
+    }
+
+    pub const fn period_to_hz(period: u64) -> u64 {
+        if period == 0 {
+            0
+        } else {
+            Self::PERIOD_1SEC / period
+        }
+    }
+
+    pub const fn period(&self) -> u64 {
+        // SAFETY: Clock is returned by init_clock_in with zero value for period
+        unsafe { &*self.0.as_ptr() }.period
+    }
+
+    pub const fn hz(&self) -> u64 {
+        Self::period_to_hz(self.period())
+    }
+}
+
 unsafe impl ObjectType for Clock {
     type Class = ObjectClass;
     const TYPE_NAME: &'static CStr =
-- 
2.51.0


