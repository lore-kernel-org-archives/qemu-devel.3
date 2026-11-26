Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E9C0606A31C
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Nov 2026 23:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=HgwuYpAf;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=Ztk+BIj8
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWihq-00085g-J2; Thu, 26 Nov 2026 18:16:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1xWihn-00083b-IB
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 18:16:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1xWihl-00061O-DR
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 18:16:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795735000;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=l1Qg3LQ3LO7V7dxn17KNCAY8BfJNlf4502KPIAbTvd4=;
 b=HgwuYpAfHP2YcA72qrIOHa8lz4aJ0BKIQniCRDPoQvS+OknRaEeZTVqBFzOAs8ttnFUVWd
 qTi0k+LbFmpDxx8zN5GiHPllAGNDfLBYGbqwXLVpYvDfIdKCScvjopx1Ud/l+bC298ELhk
 JC2uH108pIRJPFFRiUt/rZfzE9JnPNs=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-387-C4OLeRhyM0WRE2IEJQpZ3w-1; Thu, 26 Nov 2026 23:16:38 +0000
X-MC-Unique: C4OLeRhyM0WRE2IEJQpZ3w-1
X-Mimecast-MFC-AGG-ID: C4OLeRhyM0WRE2IEJQpZ3w_1795734998
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-9213e04641dso144971926d6.2
 for <qemu-devel@nongnu.org>; Thu, 26 Nov 2026 15:16:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1795734998; x=1796339798; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=l1Qg3LQ3LO7V7dxn17KNCAY8BfJNlf4502KPIAbTvd4=;
 b=Ztk+BIj8K0G1Glog0vP78jBZVYk3U0Xhoq0jH5A9RteADv//TeT0RgE1+Siyrd5jDB
 BhUWqXCYQ7mLx0lEdwDgxrw0xvPev1ONgYmXxcLOiDRTMqAydgRla0LGmfZbNke1Pqqm
 dHqAZfHZXyGgMrj/6o6UJSnwIreA0LJiKcNFOtCKgTZGVM/i8kyEiiwJoDsnTAjuPEPa
 X5jD/8ceyJpVne5ECEOf/CbMHiXLrTdsIdWnRKpthG2tg0l3IE/2aArBYqsekDyKKfxH
 lCX76NfV4f433NnqVPwiUiXyT5B/lsRToYA4xl/CmlqaGaUDyp62rmH6jLejygxZhJE5
 YHzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795734998; x=1796339798;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=l1Qg3LQ3LO7V7dxn17KNCAY8BfJNlf4502KPIAbTvd4=;
 b=fwuPA7o6g9Ndy6P2KKZz6fsITbW9NvA6MJDzMQDRYbWOYdRzQP/L6njtrgy9AamyAl
 29gTn5Hlyay1f6uEfJCKE1RAPgelFqjKYObp86Q+47Tx5b8t6U5o75k8TdhPO2y6etUb
 uYyw1RL2Mxr9HTEBYltjzcnMoCVR0wrcYr5kCyGxqKcbPLLkZdI1eNW0Cb/tjV4cd+PP
 BjxcQ20j+XNPw9/0QJIQCIlOc3qYP/DGIMuXpPEwOwE5JrAiWa4IwiQQ+v4rQOEs6QRc
 XhphYtqEbJGntMTaOHe7pvK1qALWFHo/qnD4hPAizteFPcWoTrY4ilOMYgANgsyWvNNI
 ZlEQ==
X-Gm-Message-State: APuU4Z+5r9iOnMTZPi7gNNVTjHWaTCIl+ZlMjHal14ieH/ex2WRekR/U
 gaztuFHX1p/spxDke1uaNzRwWUcvSDygOQmTie/HRgv+x+lHVCrJgsgV8mOrJPx8kkObne8fxix
 4kOuW87MigtXGkh67QwSwSD6bDeM2nrC+8J0yxol8U69LDaufUghIUMtFDnfcQCIdN4jJDJ6elE
 VQMN+43BblGJSIZhZK9DQ2KTtn2ZmwPczxyldjdg==
X-Gm-Gg: AZFdTZetkNOxNXVAsxgrWE5azqPccbJTeEO2MaNDW8C90khuoIW/JoakhjgmG0BPWnA
 J8GarbyoCzvOOrn4RxJoB2Z2FRCKwD2tS4gtK12KHJi4iyi7d9BeBPvQKOpUiy3oKovAW8pTuHI
 TLY6eTPTnDZptEerli+0P5xukS+Ug7AkFbd3ob2SjoyJENybGMFd5FwUs182SqFzHuSYkuvsLNq
 3Lu4uacv2fau/EVlX2qGpP3GHJLo9xpRHjOzFp1rfV6POCGSBvQvw9pO3+1JjNDnznRhQf8mZJi
 cOOUIQrbjMreKWtHAThUv98deHDm4IdkfmzOKLG7Bg+uPxgENfVGkgwS910QAUbBReDaC50sfnv
 OnI0BJy18TdqeoKPIOiuihIznDJf7ikI52vjIkkNKT98b
X-Received: by 2002:ac8:574e:0:b0:535:8519:6ebb with SMTP id
 d75a77b69052e-55d769316e0mr434382461cf.4.1795734997737; 
 Thu, 26 Nov 2026 15:16:37 -0800 (PST)
X-Received: by 2002:ac8:574e:0:b0:535:8519:6ebb with SMTP id
 d75a77b69052e-55d769316e0mr434381901cf.4.1795734997093; 
 Thu, 26 Nov 2026 15:16:37 -0800 (PST)
Received: from localhost ([142.188.212.246]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-92134a08552sm199552756d6.34.2026.11.26.15.16.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Nov 2026 15:16:36 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Juraj Marcin <jmarcin@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, peterx@redhat.com,
 Fabiano Rosas <farosas@suse.de>, Gavin Shan <gshan@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH for-12.0 v2 2/9] rust/hpet: Move vmstate_validate!() check
 into post_load
Date: Thu, 26 Nov 2026 18:16:24 -0500
Message-ID: <20261126231631.3392756-3-peterx@redhat.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261126231631.3392756-1-peterx@redhat.com>
References: <20261126231631.3392756-1-peterx@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Zhao Liu <zhao1.liu@intel.com>

To pave way for removing VMSTATE_VALIDATE() (and vmstate_validate!()),
move the usage of hpet into post_load. To make it safer, loading the
timers with the num_timers, then only check against the wire number at
last.

In addition, drop the test_fn() in the VMStateField of HPETState.timers
- this was duplicated, but now the check in post_load is enough
(and test_fn should not be used for validation).

Originally-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20261124095814.437738-3-zhao1.liu@intel.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 rust/hw/timer/hpet/src/device.rs | 45 ++++++++++++++++----------------
 1 file changed, 23 insertions(+), 22 deletions(-)

diff --git a/rust/hw/timer/hpet/src/device.rs b/rust/hw/timer/hpet/src/device.rs
index 89ba7a5c4d..c7a2b7f6c2 100644
--- a/rust/hw/timer/hpet/src/device.rs
+++ b/rust/hw/timer/hpet/src/device.rs
@@ -934,10 +934,15 @@ fn pre_save(&self) -> Result<(), migration::Infallible> {
         Ok(())
     }
 
-    fn post_load(&self, _version_id: u8) -> Result<(), migration::Infallible> {
+    fn post_load(&self, _version_id: u8) -> Result<(), migration::InvalidError> {
         let mut regs = self.regs.borrow_mut();
         let cnt = regs.counter;
 
+        /* FIXME: use post_load_errp() to print error message. */
+        if !self.validate_num_timers() {
+            return Err(migration::InvalidError);
+        }
+
         for tn_regs in regs.tn_regs.iter_mut().take(self.num_timers) {
             tn_regs.update_cmp64(cnt);
             tn_regs.last = CLOCK_VIRTUAL.get_ns() - NANOSECONDS_PER_SECOND;
@@ -956,7 +961,7 @@ fn is_offset_needed(&self) -> bool {
         self.regs.borrow().is_hpet_enabled()
     }
 
-    fn validate_num_timers(&self, _version_id: u8) -> bool {
+    fn validate_num_timers(&self) -> bool {
         self.num_timers == self.num_timers_save.get().into()
     }
 }
@@ -1082,8 +1087,6 @@ fn restore_migrated_state(
 
 impl_vmstate_struct!(HPETTimerMigration, VMSTATE_HPET_TIMER);
 
-const VALIDATE_TIMERS_NAME: &CStr = c"num_timers must match";
-
 // HPETRegistersMigration is generated by ToMigrationState macro.
 impl_vmstate_struct!(
     HPETRegistersMigration,
@@ -1099,24 +1102,22 @@ fn restore_migrated_state(
         .build()
 );
 
-const VMSTATE_HPET: VMStateDescription<HPETState> =
-    VMStateDescriptionBuilder::<HPETState>::new()
-        .name(c"hpet")
-        .version_id(2)
-        .minimum_version_id(2)
-        .pre_save(&HPETState::pre_save)
-        .post_load(&HPETState::post_load)
-        .fields(vmstate_fields! {
-            vmstate_of!(HPETState, regs),
-            vmstate_of!(HPETState, num_timers_save),
-            vmstate_validate!(HPETState, VALIDATE_TIMERS_NAME, HPETState::validate_num_timers),
-            vmstate_of!(HPETState, timers[0 .. num_timers_save], HPETState::validate_num_timers).with_version_id(0),
-        })
-        .subsections(vmstate_subsections!(
-            VMSTATE_HPET_RTC_IRQ_LEVEL,
-            VMSTATE_HPET_OFFSET,
-        ))
-        .build();
+const VMSTATE_HPET: VMStateDescription<HPETState> = VMStateDescriptionBuilder::<HPETState>::new()
+    .name(c"hpet")
+    .version_id(2)
+    .minimum_version_id(2)
+    .pre_save(&HPETState::pre_save)
+    .post_load(&HPETState::post_load)
+    .fields(vmstate_fields! {
+        vmstate_of!(HPETState, regs),
+        vmstate_of!(HPETState, num_timers_save),
+        vmstate_of!(HPETState, timers[0 .. num_timers]).with_version_id(0),
+    })
+    .subsections(vmstate_subsections!(
+        VMSTATE_HPET_RTC_IRQ_LEVEL,
+        VMSTATE_HPET_OFFSET,
+    ))
+    .build();
 
 impl DeviceImpl for HPETState {
     const VMSTATE: Option<VMStateDescription<Self>> = Some(VMSTATE_HPET);
-- 
2.56.0


