Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EEEBC5B549
	for <qemu-devel@archiver.kernel.org>; Fri, 30 May 2025 08:04:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKuia-0002hL-OB; Fri, 30 May 2025 04:03:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uKuiX-0002eB-Cu
 for qemu-devel@nongnu.org; Fri, 30 May 2025 04:03:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uKuiV-0004fx-9s
 for qemu-devel@nongnu.org; Fri, 30 May 2025 04:03:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748592230;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1xUwrRORHhhFQcsqo0wojfaEACCcvTZjPhl1zMHXkSg=;
 b=JtvJ+Wjp84naohgyf5uZJoiLZ/LUWE/ErxVXnP5CYtG2Prr2z5FtI0QtQacbJWL1Pdsxq3
 DariQ9LZle6AiwBSvjRfc+Mspc49cqnQTwhMrRbCXCrk5n7IS95nQd/XvnCUdASUqw74hm
 I19yBKgNZWdKwwoxZNxpVtPMrKyUJdo=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-216-jq0EMrfoMf6fkTC-Dzberw-1; Fri, 30 May 2025 04:03:49 -0400
X-MC-Unique: jq0EMrfoMf6fkTC-Dzberw-1
X-Mimecast-MFC-AGG-ID: jq0EMrfoMf6fkTC-Dzberw_1748592228
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-604630fcce7so1639633a12.3
 for <qemu-devel@nongnu.org>; Fri, 30 May 2025 01:03:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748592227; x=1749197027;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1xUwrRORHhhFQcsqo0wojfaEACCcvTZjPhl1zMHXkSg=;
 b=ugMxucaZfSmREDK2TvSaF/cxo9y88SMfPRrTPLbaTh+7PoRJACdLgjj5CzkPyM2Mn0
 ekpOuHcZ332fG4qy37uKLGT8rPjLvZfS6n95wPjwFVXxVTcfrB2veFYKvv5QEQEUi26l
 ctGjBEFkHAYH2u6kpviZetLvPpXnNc7Yn7fB32CstlIE6LqOsjESyhRv0h+JtNXxh5GY
 HShCyFFppTtH1EA8TDnfv6kyC/3XOCMaEDaQ9le9dPkdpfEUacQPioPIncRy5lxc7X7d
 aACkrbQeFQKHRNBz3UYQMKnF9j62jQ8uRZ93bhAitLr3IVJclG5BOpMAlVzTQhZiQka+
 mwrA==
X-Gm-Message-State: AOJu0YygACgS8Xnav1MljyeBwyq33eyGD0Ny+pCOniDWpKNLRCKv3eU9
 nn3rnBm9tuzuh8KhFwAruah4d7Q48QIJ6Md39VblXn5a60Bx154BjdKFp3FHkK+tZVoi9f4kAGc
 Ev0PuF3HoOl7+gS05A7mkb0QgEg7HL5yWekKwXedfw5SN5S+ygao0yZ7TlSHJmCI2qHhPqhoo89
 OdxSUnjaneo1Mn1jZoUbXs4+TPICA2nyt87JUhSjgM
X-Gm-Gg: ASbGncuCg7i+fUr5uuW48/Yyjq7hsyV2FAGFHnRuWyO9HLv4NyFLzAF18h00nbEhCji
 TSLREXfFQZzDB3Yzfmz1M/QaGeZ4RMET4bdYq3qoOENTqzoywuZc3sKac9EypodwDcICdjjyJsZ
 E7rEV9BOPSM/QXnMVHdUc83lyIT07rLWKYpa8GGMFuMJldujitJWRwfBYRhoi+YtHgfdMVUB9UM
 DtVpgyqvl15wY2SHZglAiDIs1dmAWr96vgEwx0SmNT7hnHYFfdmSqM9zWZhSJE0bKhIJxzgd3xN
 js3GPTWSf4Lodw==
X-Received: by 2002:a05:6402:2747:b0:600:e549:3c19 with SMTP id
 4fb4d7f45d1cf-6056dd32172mr1890608a12.1.1748592227204; 
 Fri, 30 May 2025 01:03:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IENr6wMInrZzSNu4mB5xpd5xXz23G2fy9KRmV8MQ3JBJHdm0Yc0ynlIBVJr/49jhrxbX8/zqw==
X-Received: by 2002:a05:6402:2747:b0:600:e549:3c19 with SMTP id
 4fb4d7f45d1cf-6056dd32172mr1890307a12.1.1748592222087; 
 Fri, 30 May 2025 01:03:42 -0700 (PDT)
Received: from [192.168.122.1] ([151.49.64.79])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-605671437ebsm1244948a12.54.2025.05.30.01.03.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 May 2025 01:03:40 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org,
	Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 13/14] rust/hpet: Drop BqlCell wrapper for num_timers
Date: Fri, 30 May 2025 10:03:05 +0200
Message-ID: <20250530080307.2055502-14-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250530080307.2055502-1-pbonzini@redhat.com>
References: <20250530080307.2055502-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.902,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Zhao Liu <zhao1.liu@intel.com>

Now that the num_timers field is initialized as a property, someone may
change its default value using qdev_prop_set_uint8(), but the value is
fixed after the Rust code sees it first.  Since there is no need to modify
it after realize(), it is not to be necessary to have a BqlCell wrapper.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20250520152750.2542612-4-zhao1.liu@intel.com
[Remove .into() as well. - Paolo]
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/hw/timer/hpet/src/device.rs | 27 +++++++++++----------------
 1 file changed, 11 insertions(+), 16 deletions(-)

diff --git a/rust/hw/timer/hpet/src/device.rs b/rust/hw/timer/hpet/src/device.rs
index cd439f90b7e..735b2fbef79 100644
--- a/rust/hw/timer/hpet/src/device.rs
+++ b/rust/hw/timer/hpet/src/device.rs
@@ -562,7 +562,7 @@ pub struct HPETState {
     /// HPET timer array managed by this timer block.
     #[doc(alias = "timer")]
     timers: [BqlRefCell<HPETTimer>; HPET_MAX_TIMERS],
-    num_timers: BqlCell<usize>,
+    num_timers: usize,
     num_timers_save: BqlCell<u8>,
 
     /// Instance id (HPET timer block ID).
@@ -570,11 +570,6 @@ pub struct HPETState {
 }
 
 impl HPETState {
-    // Get num_timers with `usize` type, which is useful to play with array index.
-    fn get_num_timers(&self) -> usize {
-        self.num_timers.get()
-    }
-
     const fn has_msi_flag(&self) -> bool {
         self.flags & (1 << HPET_FLAG_MSI_SUPPORT_SHIFT) != 0
     }
@@ -636,7 +631,7 @@ fn set_cfg_reg(&self, shift: u32, len: u32, val: u64) {
             self.hpet_offset
                 .set(ticks_to_ns(self.counter.get()) - CLOCK_VIRTUAL.get_ns());
 
-            for timer in self.timers.iter().take(self.get_num_timers()) {
+            for timer in self.timers.iter().take(self.num_timers) {
                 let mut t = timer.borrow_mut();
 
                 if t.is_int_enabled() && t.is_int_active() {
@@ -648,7 +643,7 @@ fn set_cfg_reg(&self, shift: u32, len: u32, val: u64) {
             // Halt main counter and disable interrupt generation.
             self.counter.set(self.get_ticks());
 
-            for timer in self.timers.iter().take(self.get_num_timers()) {
+            for timer in self.timers.iter().take(self.num_timers) {
                 timer.borrow_mut().del_timer();
             }
         }
@@ -671,7 +666,7 @@ fn set_int_status_reg(&self, shift: u32, _len: u32, val: u64) {
         let new_val = val << shift;
         let cleared = new_val & self.int_status.get();
 
-        for (index, timer) in self.timers.iter().take(self.get_num_timers()).enumerate() {
+        for (index, timer) in self.timers.iter().take(self.num_timers).enumerate() {
             if cleared & (1 << index) != 0 {
                 timer.borrow_mut().update_irq(false);
             }
@@ -725,7 +720,7 @@ fn post_init(&self) {
     }
 
     fn realize(&self) -> qemu_api::Result<()> {
-        if self.num_timers.get() < HPET_MIN_TIMERS || self.num_timers.get() > HPET_MAX_TIMERS {
+        if self.num_timers < HPET_MIN_TIMERS || self.num_timers > HPET_MAX_TIMERS {
             Err(format!(
                 "hpet.num_timers must be between {HPET_MIN_TIMERS} and {HPET_MAX_TIMERS}"
             ))?;
@@ -743,7 +738,7 @@ fn realize(&self) -> qemu_api::Result<()> {
             1 << HPET_CAP_COUNT_SIZE_CAP_SHIFT |
             1 << HPET_CAP_LEG_RT_CAP_SHIFT |
             HPET_CAP_VENDER_ID_VALUE << HPET_CAP_VENDER_ID_SHIFT |
-            ((self.get_num_timers() - 1) as u64) << HPET_CAP_NUM_TIM_SHIFT | // indicate the last timer
+            ((self.num_timers - 1) as u64) << HPET_CAP_NUM_TIM_SHIFT | // indicate the last timer
             (HPET_CLK_PERIOD * FS_PER_NS) << HPET_CAP_CNT_CLK_PERIOD_SHIFT, // 10 ns
         );
 
@@ -753,7 +748,7 @@ fn realize(&self) -> qemu_api::Result<()> {
     }
 
     fn reset_hold(&self, _type: ResetType) {
-        for timer in self.timers.iter().take(self.get_num_timers()) {
+        for timer in self.timers.iter().take(self.num_timers) {
             timer.borrow_mut().reset();
         }
 
@@ -781,7 +776,7 @@ fn decode(&self, mut addr: hwaddr, size: u32) -> HPETAddrDecode {
             GlobalRegister::try_from(addr).map(HPETRegister::Global)
         } else {
             let timer_id: usize = ((addr - 0x100) / 0x20) as usize;
-            if timer_id <= self.get_num_timers() {
+            if timer_id < self.num_timers {
                 // TODO: Add trace point - trace_hpet_ram_[read|write]_timer_id(timer_id)
                 TimerRegister::try_from(addr & 0x18)
                     .map(|reg| HPETRegister::Timer(&self.timers[timer_id], reg))
@@ -852,12 +847,12 @@ fn pre_save(&self) -> i32 {
          * also added to the migration stream.  Check that it matches the value
          * that was configured.
          */
-        self.num_timers_save.set(self.num_timers.get() as u8);
+        self.num_timers_save.set(self.num_timers as u8);
         0
     }
 
     fn post_load(&self, _version_id: u8) -> i32 {
-        for timer in self.timers.iter().take(self.get_num_timers()) {
+        for timer in self.timers.iter().take(self.num_timers) {
             let mut t = timer.borrow_mut();
 
             t.cmp64 = t.calculate_cmp64(t.get_state().counter.get(), t.cmp);
@@ -882,7 +877,7 @@ fn is_offset_needed(&self) -> bool {
     }
 
     fn validate_num_timers(&self, _version_id: u8) -> bool {
-        self.num_timers.get() == self.num_timers_save.get().into()
+        self.num_timers == self.num_timers_save.get().into()
     }
 }
 
-- 
2.49.0


