Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58782C282D1
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Mar 2025 10:33:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trDwe-00081w-R3; Sun, 09 Mar 2025 06:31:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1trDwd-00081e-DQ
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 06:31:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1trDwb-00040l-SI
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 06:31:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741516301;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=c3qiG+kkygojNezILoTV1kBIMSGFFOkaYAkVQzTVlDk=;
 b=WPrS6pXIjABb61nhjgi/TcsJ/o9F7ukC7U+nEKsBtYDryrx0qW6chhHkiukkl1CLD38Yup
 eVqpUaaTJkqy8+EFt2jRMc3Upxf/VEB8rfQZg7FBGELKup0WSNFEPdE7givBAKiznzeJre
 pN49V9h6K2YlxYKbIHajES1xyqBtLN0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-592-I1qb1SVTMLGSMhONB75CTA-1; Sun, 09 Mar 2025 06:31:38 -0400
X-MC-Unique: I1qb1SVTMLGSMhONB75CTA-1
X-Mimecast-MFC-AGG-ID: I1qb1SVTMLGSMhONB75CTA_1741516298
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-43cebfa08ccso5198715e9.2
 for <qemu-devel@nongnu.org>; Sun, 09 Mar 2025 03:31:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741516297; x=1742121097;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=c3qiG+kkygojNezILoTV1kBIMSGFFOkaYAkVQzTVlDk=;
 b=bAE68axzBfevjj0lKtaW/wRd0TdkXNjMnNjhbvdEKpcDSQhwGVW+emvlb7qJKEK79Z
 i3415Sk510h30kawK0ePDUKcbl434MpWsxqYGRKt337LGRXxJqX9/CAD7uTk78JzcE+S
 iOySPcO6Ajqn7NXQgGZ8ucCnOSoN17bwKG+vX5TmkwZRnGsseJ+4A6xgLJGkwi2NFeLh
 TrtL8f6CSjXtcCLTdMWu4VvajgHcXzJxC8l5bCBEZm5o3hDLuhDxpqDritAzqq66Z+6D
 oqQYrgwPMjFCViWrR/gMoXcgMdQq3HzCEOun/r2U+3W+vFYIGai4Gjm4icml2FU/tXRr
 /rzA==
X-Gm-Message-State: AOJu0YwOtY9Kluj6nkuGo/TDLRH9b9f/HEYwbTS+xuTuEvtbCpLRcHW4
 rsqF5UIAVi6tPxYJXDny4uFq0Wu1LLzGywa71q1dC+BMAdfYEdWdVB3lLex6H9BlSyreTOfjp6w
 pJwGOuQkn1Rrn75qNE4uTcSSy6PCTjdYjTtxid7C8L79nPe79Bf4WcR4gR8C5vwKMqm96KNbZr1
 OPj0+rqrg2mJk2CuWJjOe2JNB1acjkcCBBmaJdDGU=
X-Gm-Gg: ASbGncs5WJPeb3lXYMc3AGR7kDeQm8+nEaqDy9q9kzBhuhpzsOaxNipeB7shCdc3sLh
 hTMizjhpSxdGNVjEvtWC0Y76Wt20svH++PUFUxFmHB7aKEj4xWWSzYsE3na/Ku/8e9OOzvhP4C8
 Ngmi3OHQ0MJAQO3Rdz5tqDT6NqmS684lawqvi86gGtuOrYgWeGSZs+UkXgFCFI2SKU7A33hZHQu
 FYsgoggshL2heM9UYj+Wj6CpZ0XwHHXc/D5v6gknch2sj9IwrC8hQEg+CFJRO3Om2xgFYnXYZrl
 oZ9ycx09sxcl0/OwknPwFA==
X-Received: by 2002:a05:600c:1d15:b0:43c:f75a:eb3c with SMTP id
 5b1f17b1804b1-43cf75aecf4mr2297665e9.21.1741516297181; 
 Sun, 09 Mar 2025 03:31:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHfxOf65Otv3A18xGvSzbYshD9D+3CNw2CkoIHVIt2KbEY6d3JaFnykfvXnO/Fjm3p9SG+PEA==
X-Received: by 2002:a05:600c:1d15:b0:43c:f75a:eb3c with SMTP id
 5b1f17b1804b1-43cf75aecf4mr2297545e9.21.1741516296741; 
 Sun, 09 Mar 2025 03:31:36 -0700 (PDT)
Received: from [192.168.10.48] ([176.206.122.167])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ced9a4b19sm34313535e9.29.2025.03.09.03.31.35
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Mar 2025 03:31:35 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 06/25] rust: hpet: embed Timer without the Option and Box
 indirection
Date: Sun,  9 Mar 2025 11:31:00 +0100
Message-ID: <20250309103120.1116448-7-pbonzini@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250309103120.1116448-1-pbonzini@redhat.com>
References: <20250309103120.1116448-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

This simplifies things for migration, since Option<Box<QEMUTimer>> does not
implement VMState.

This also shows a soundness issue because Timer::new() will leave a NULL
timer list pointer, which can then be dereferenced by Timer::modify().  It
will be fixed shortly.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/hw/timer/hpet/src/hpet.rs | 59 ++++++++++++++++------------------
 1 file changed, 28 insertions(+), 31 deletions(-)

diff --git a/rust/hw/timer/hpet/src/hpet.rs b/rust/hw/timer/hpet/src/hpet.rs
index be27eb0eff4..02c81ae048f 100644
--- a/rust/hw/timer/hpet/src/hpet.rs
+++ b/rust/hw/timer/hpet/src/hpet.rs
@@ -151,14 +151,14 @@ fn timer_handler(timer_cell: &BqlRefCell<HPETTimer>) {
 
 /// HPET Timer Abstraction
 #[repr(C)]
-#[derive(Debug, Default, qemu_api_macros::offsets)]
+#[derive(Debug, qemu_api_macros::offsets)]
 pub struct HPETTimer {
     /// timer N index within the timer block (`HPETState`)
     #[doc(alias = "tn")]
     index: usize,
-    qemu_timer: Option<Box<Timer>>,
+    qemu_timer: Timer,
     /// timer block abstraction containing this timer
-    state: Option<NonNull<HPETState>>,
+    state: NonNull<HPETState>,
 
     // Memory-mapped, software visible timer registers
     /// Timer N Configuration and Capability Register
@@ -181,32 +181,34 @@ pub struct HPETTimer {
 }
 
 impl HPETTimer {
-    fn init(&mut self, index: usize, state_ptr: *mut HPETState) -> &mut Self {
-        *self = HPETTimer::default();
-        self.index = index;
-        self.state = NonNull::new(state_ptr);
-        self
-    }
+    fn init(&mut self, index: usize, state: &HPETState) {
+        *self = HPETTimer {
+            index,
+            qemu_timer: Timer::new(),
+            state: NonNull::new(state as *const _ as *mut _).unwrap(),
+            config: 0,
+            cmp: 0,
+            fsb: 0,
+            cmp64: 0,
+            period: 0,
+            wrap_flag: 0,
+            last: 0,
+        };
 
-    fn init_timer_with_state(&mut self) {
-        self.qemu_timer = Some(Box::new({
-            let mut t = Timer::new();
-            t.init_full(
-                None,
-                CLOCK_VIRTUAL,
-                Timer::NS,
-                0,
-                timer_handler,
-                &self.get_state().timers[self.index],
-            );
-            t
-        }));
+        self.qemu_timer.init_full(
+            None,
+            CLOCK_VIRTUAL,
+            Timer::NS,
+            0,
+            timer_handler,
+            &state.timers[self.index],
+        )
     }
 
     fn get_state(&self) -> &HPETState {
         // SAFETY:
         // the pointer is convertible to a reference
-        unsafe { self.state.unwrap().as_ref() }
+        unsafe { self.state.as_ref() }
     }
 
     fn is_int_active(&self) -> bool {
@@ -330,7 +332,7 @@ fn arm_timer(&mut self, tick: u64) {
         }
 
         self.last = ns;
-        self.qemu_timer.as_ref().unwrap().modify(self.last);
+        self.qemu_timer.modify(self.last);
     }
 
     fn set_timer(&mut self) {
@@ -353,7 +355,7 @@ fn set_timer(&mut self) {
     fn del_timer(&mut self) {
         // Just remove the timer from the timer_list without destroying
         // this timer instance.
-        self.qemu_timer.as_ref().unwrap().delete();
+        self.qemu_timer.delete();
 
         if self.is_int_active() {
             // For level-triggered interrupt, this leaves interrupt status
@@ -581,13 +583,8 @@ fn handle_legacy_irq(&self, irq: u32, level: u32) {
     }
 
     fn init_timer(&self) {
-        let raw_ptr: *mut HPETState = self as *const HPETState as *mut HPETState;
-
         for (index, timer) in self.timers.iter().enumerate() {
-            timer
-                .borrow_mut()
-                .init(index, raw_ptr)
-                .init_timer_with_state();
+            timer.borrow_mut().init(index, self);
         }
     }
 
-- 
2.48.1


