Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B3A0C02181
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2025 09:52:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbGHo-0002se-4L; Fri, 24 Jan 2025 04:47:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tbGGH-0007cA-7Z
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 04:46:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tbGGE-0003xd-OG
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 04:46:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737711957;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5RWHadt6elK2BqfQZaH/RGR4cLbXUDpaxbkzpm020/U=;
 b=gCY5iro4CnPzkFZvOCfqPXbdsBlpisX6DqhpEGaelzXSfBUbyZGWsHwPLDLXEunxDR7ArZ
 savCTd2nOp4V5QDTGi5totRTL224hICo9kfmpq4I0zSxZki+ybr8MgJ7u8x00NZe22VO95
 mtTpHLjTckCTfFFpJayfrMbQN6/9yGo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-290-F0SLxbSbMweVcSuard8m4Q-1; Fri, 24 Jan 2025 04:45:55 -0500
X-MC-Unique: F0SLxbSbMweVcSuard8m4Q-1
X-Mimecast-MFC-AGG-ID: F0SLxbSbMweVcSuard8m4Q
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-436219070b4so8837975e9.1
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2025 01:45:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737711953; x=1738316753;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5RWHadt6elK2BqfQZaH/RGR4cLbXUDpaxbkzpm020/U=;
 b=h8cBPnVFPo1LT68ovBlg+hpHdRfMpyXUjp2SJHLge/D8DII0eDLh3Dgjzhg4mxMg16
 /8RAk7ey3T1SocQKd0oynj6BU/s+d0iKEMW0tUZnSlpixssg+kBbcs2tPoaVc6f9WAlO
 Vv8bN2J5CUQtfaFGvUQN5hqiBX80UXf0mBWYrfhtL0x5TF8VvoJI1GHb7vCcmN8o+h52
 WrWc/RsTIRJ/L0VxrTC8XVKSvnhTySdgL5UOSgpE1+1V3bgh0Ssa14poJssSEpUJa0C+
 jwLcOIKOyLPvojuoeplAW118XAkTQrD8+bPCsACiIUy6wbbSYJJ9DlubtQsQj/vSWPL2
 CAHw==
X-Gm-Message-State: AOJu0YxHmtZc65/jsRWQti/Mp11RMymVq6Bc/DxK+MLu8LCga47ujkCU
 wIOs7LmT1uOi5kUTDzf/P3Z1tpp5L+UOQ2B81vPpf83rFOJ/i7cJU+Xlbtdoyo1/mtdU/AcZ99m
 Er4EukXCTWg0vK4rO2yzn7OtzccNe+BU3LzR+vNPGS7MHj4ktqv3AdplpHARy7d53AaVqHYuNTC
 NobeF2cU1vAymgSl+rUt7KxhROo5OPCxyb94sHF7M=
X-Gm-Gg: ASbGnctcTu36xdNKLFmXi98OplZOEzk3pc6MIbwjCf5jXFVPbsLln/hg3qUMPgXLOe+
 jZf2Zd0DgE2S6WAMKN0HFdynBcc8eiiFvHPRBh4bPiT8bP1CuFtWOK4JC+HvwA9S2kcuk9LYEnK
 6kFSaVVgU9+1KtcRUy5nQP+ZZZ3aOXf8qoNJv0nu1w2RtCYCAPADNlOTGnK8WpZv9/JxjHim2j8
 unDZ+LczJfISCBRKASRyTZfVPlQom3nxL6AJ8sWAoerY2RJLlhhPRbCz4lxlRWeMvM0SZx4pw==
X-Received: by 2002:a05:600c:3b94:b0:434:e2ea:fc94 with SMTP id
 5b1f17b1804b1-438913cb620mr316034275e9.11.1737711953611; 
 Fri, 24 Jan 2025 01:45:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHkCDUrEDHQWQECI2bLf/gLV64mRVOJ+56Qdp1dHDW79rtrrH4WPyk3e4X1YxW5XWh0LT+hhQ==
X-Received: by 2002:a05:600c:3b94:b0:434:e2ea:fc94 with SMTP id
 5b1f17b1804b1-438913cb620mr316033945e9.11.1737711953146; 
 Fri, 24 Jan 2025 01:45:53 -0800 (PST)
Received: from [192.168.10.48] ([151.95.59.125])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438bd47f355sm20449095e9.4.2025.01.24.01.45.52
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jan 2025 01:45:52 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 34/48] rust: vmstate: make order of parameters consistent in
 vmstate_clock
Date: Fri, 24 Jan 2025 10:44:28 +0100
Message-ID: <20250124094442.13207-35-pbonzini@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250124094442.13207-1-pbonzini@redhat.com>
References: <20250124094442.13207-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.043,
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

Place struct_name before field_name, similar to offset_of.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/hw/char/pl011/src/device_class.rs | 2 +-
 rust/qemu-api/src/vmstate.rs           | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/rust/hw/char/pl011/src/device_class.rs b/rust/hw/char/pl011/src/device_class.rs
index e0d3532e956..b052d98803f 100644
--- a/rust/hw/char/pl011/src/device_class.rs
+++ b/rust/hw/char/pl011/src/device_class.rs
@@ -27,7 +27,7 @@ extern "C" fn pl011_clock_needed(opaque: *mut c_void) -> bool {
     minimum_version_id: 1,
     needed: Some(pl011_clock_needed),
     fields: vmstate_fields! {
-        vmstate_clock!(clock, PL011State),
+        vmstate_clock!(PL011State, clock),
     },
     ..Zeroable::ZERO
 };
diff --git a/rust/qemu-api/src/vmstate.rs b/rust/qemu-api/src/vmstate.rs
index 120933e60da..6ac432cf52f 100644
--- a/rust/qemu-api/src/vmstate.rs
+++ b/rust/qemu-api/src/vmstate.rs
@@ -457,7 +457,7 @@ macro_rules! vmstate_struct {
 #[doc(alias = "VMSTATE_CLOCK")]
 #[macro_export]
 macro_rules! vmstate_clock {
-    ($field_name:ident, $struct_name:ty) => {{
+    ($struct_name:ty, $field_name:ident) => {{
         $crate::bindings::VMStateField {
             name: ::core::concat!(::core::stringify!($field_name), "\0")
                 .as_bytes()
-- 
2.48.1


