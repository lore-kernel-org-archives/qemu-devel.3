Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B244D1BDD0
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 17:34:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t80sM-0005Tj-55; Mon, 04 Nov 2024 12:28:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t80sJ-0005Qy-8w
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 12:28:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t80sD-0000M5-QU
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 12:28:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730741297;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CxXq4sNnvBqcxAcyP5/LFmCvhOPA1QvyNHAcrsKDVpE=;
 b=LJlMWePJGepDKB82KZ+NHSLOkMTOZuM1tGPneFDuhcZ8nrIJloMC409DtUUBWEFK5HxfdH
 LUYxi6pftyiJPUJcog+77Kw3VSLi9fo1AYiQiQlTNGxxO9znXcQjnwYrq0v+/IoxXBl2cB
 ZCQzp+dRvYawQA9vtyPHO2UIVoIcuFk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-570-6CI_PGD3NmWFV-kTnGmGlg-1; Mon, 04 Nov 2024 12:28:16 -0500
X-MC-Unique: 6CI_PGD3NmWFV-kTnGmGlg-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4314f1e0f2bso29049145e9.1
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2024 09:28:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730741294; x=1731346094;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CxXq4sNnvBqcxAcyP5/LFmCvhOPA1QvyNHAcrsKDVpE=;
 b=R9NtEwURyAtDTzwGqvWjHGxDSC5rCJWCzaJMBC+OqRmAQHwQgjXwT2EviNH2MniWCV
 tZ8+hbZ53VaUzm0Rk54GQXyCm6NTZLVD5vwqv9D31dusoVE+XkWhFcrWbS7wD4ki3fgg
 yZV2YpmvH7Cb1PCkoFiPi1V3w97xtGG2tAOUkG+irp6pRVvGtt9ngjKtRoXIkmVcj/Jg
 KnBaYs+ys1z174LkRFT5Zoyb/JWj6wyoFbpfQ/hdJSRJRDyg50+cIAEHHbhflfvAdfx+
 PD0xnBfgWa/PQuUxQVnbnUCrbBoXLjztIFQAGQvCQYc9vAo0ZmGyW1AtmdN54GPAT9yJ
 1FEg==
X-Gm-Message-State: AOJu0YziHFWCXmm8HTXzlawmgV6V4als4sfIPWaWr3PRGzbPnsHn0ZsH
 cbNwO7JdI3HoTauMTkH1QnkCBBHcUqKXrGiUu831jGfmySRxyeX0Lfzc6mfUeHzv10l5J9UYoah
 u1sDpsNNzpG2m1BPqrY39oSr9kAAGpqmzeYWXKvOUt4mB/8ibeYbR8DUVvCNt+qcliQoUmsOlLY
 CHsVQaNJoJOZEQMtAVxlN7TRyZl4kiojYFWnT9h8k=
X-Received: by 2002:a05:600c:1d27:b0:431:52a3:d9ea with SMTP id
 5b1f17b1804b1-432831c1ff1mr118529595e9.0.1730741294030; 
 Mon, 04 Nov 2024 09:28:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEMILYGsmvvv+3hE9LiKBc+hzuPrz4wymD4pf61/j3m7fhpdMHMI21QLlirS5Sxm9CcMOSvow==
X-Received: by 2002:a05:600c:1d27:b0:431:52a3:d9ea with SMTP id
 5b1f17b1804b1-432831c1ff1mr118529225e9.0.1730741293606; 
 Mon, 04 Nov 2024 09:28:13 -0800 (PST)
Received: from [192.168.10.3] ([151.49.226.83])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-431bd91096asm194447775e9.13.2024.11.04.09.28.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Nov 2024 09:28:12 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Junjie Mao <junjie.mao@hotmail.com>, Kevin Wolf <kwolf@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 23/40] rust/pl011: remove commented out C code
Date: Mon,  4 Nov 2024 18:27:02 +0100
Message-ID: <20241104172721.180255-24-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241104172721.180255-1-pbonzini@redhat.com>
References: <20241104172721.180255-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

This code juxtaposed what should be happening according to the C device
model but is not needed now that this has been reviewed (I hope) and its
validity checked against what the C device does (I hope, again).

No functional change.

Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Link: https://lore.kernel.org/r/20241024-rust-round-2-v1-8-051e7a25b978@linaro.org
---
 rust/hw/char/pl011/src/device.rs | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/rust/hw/char/pl011/src/device.rs b/rust/hw/char/pl011/src/device.rs
index 051c59f39ae..98357db04e8 100644
--- a/rust/hw/char/pl011/src/device.rs
+++ b/rust/hw/char/pl011/src/device.rs
@@ -192,7 +192,6 @@ pub fn read(
                 0
             }
             Ok(DR) => {
-                // s->flags &= ~PL011_FLAG_RXFF;
                 self.flags.set_receive_fifo_full(false);
                 let c = self.read_fifo[self.read_pos];
                 if self.read_count > 0 {
@@ -200,11 +199,9 @@ pub fn read(
                     self.read_pos = (self.read_pos + 1) & (self.fifo_depth() - 1);
                 }
                 if self.read_count == 0 {
-                    // self.flags |= PL011_FLAG_RXFE;
                     self.flags.set_receive_fifo_empty(true);
                 }
                 if self.read_count + 1 == self.read_trigger {
-                    //self.int_level &= ~ INT_RX;
                     self.int_level &= !registers::INT_RX;
                 }
                 // Update error bits.
@@ -374,13 +371,6 @@ fn loopback_mdmctrl(&mut self) {
          * dealt with here.
          */
 
-        //fr = s->flags & ~(PL011_FLAG_RI | PL011_FLAG_DCD |
-        //                  PL011_FLAG_DSR | PL011_FLAG_CTS);
-        //fr |= (cr & CR_OUT2) ? PL011_FLAG_RI  : 0;
-        //fr |= (cr & CR_OUT1) ? PL011_FLAG_DCD : 0;
-        //fr |= (cr & CR_RTS)  ? PL011_FLAG_CTS : 0;
-        //fr |= (cr & CR_DTR)  ? PL011_FLAG_DSR : 0;
-        //
         self.flags.set_ring_indicator(self.control.out_2());
         self.flags.set_data_carrier_detect(self.control.out_1());
         self.flags.set_clear_to_send(self.control.request_to_send());
@@ -391,10 +381,6 @@ fn loopback_mdmctrl(&mut self) {
         let mut il = self.int_level;
 
         il &= !Interrupt::MS;
-        //il |= (fr & PL011_FLAG_DSR) ? INT_DSR : 0;
-        //il |= (fr & PL011_FLAG_DCD) ? INT_DCD : 0;
-        //il |= (fr & PL011_FLAG_CTS) ? INT_CTS : 0;
-        //il |= (fr & PL011_FLAG_RI)  ? INT_RI  : 0;
 
         if self.flags.data_set_ready() {
             il |= Interrupt::DSR as u32;
@@ -500,10 +486,8 @@ pub fn put_fifo(&mut self, value: c_uint) {
         let slot = (self.read_pos + self.read_count) & (depth - 1);
         self.read_fifo[slot] = value;
         self.read_count += 1;
-        // s->flags &= ~PL011_FLAG_RXFE;
         self.flags.set_receive_fifo_empty(false);
         if self.read_count == depth {
-            //s->flags |= PL011_FLAG_RXFF;
             self.flags.set_receive_fifo_full(true);
         }
 
-- 
2.47.0


