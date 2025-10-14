Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD6AECCD192
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 13:40:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8fEP-0005tX-S0; Tue, 14 Oct 2025 09:38:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v8fEN-0005t6-3B
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 09:38:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v8fEG-00016y-NL
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 09:38:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760449095;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xa/WqT0YQ5aqnmYvdDBWwUo/98Zjo9UlKye5iKQIlwk=;
 b=IgU3QsHf2U4ifurPBqR9WuSz7xg9lXKVHVZkC1mUctalrS1/IIOt524csLuZeCPtADlhJW
 P5s7bTQdQIYqJhh5cWf2FBy2M+Ap5iVOnHe1mLxD0n2yusEcRoI2Bf3KKfpoFJNmaHZY3N
 r7VFXDKxZwxHIiFpiNAYzN13391PY9c=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-684-PHH_l4XpOfypFNMXdrorng-1; Tue, 14 Oct 2025 09:38:14 -0400
X-MC-Unique: PHH_l4XpOfypFNMXdrorng-1
X-Mimecast-MFC-AGG-ID: PHH_l4XpOfypFNMXdrorng_1760449093
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-46e47d14dceso30834625e9.2
 for <qemu-devel@nongnu.org>; Tue, 14 Oct 2025 06:38:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760449091; x=1761053891;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xa/WqT0YQ5aqnmYvdDBWwUo/98Zjo9UlKye5iKQIlwk=;
 b=fCIcXHnqU8S2o/jibicl9qsTHVFI5jKck0e70zR3Pwbnttgg5/wf9Lp0P/1DfNQ91y
 pFc14nKbKhVA5XQX1m7mSrdEXwzzUieSx2WEDD67l/bZSd9N+k1WRGr02dctNt5/B4pk
 oSOvui3sSSnKvKc4updyioswBUHybbx3Pd9Ukgn9RTd58H8AZUegVDI5sKShpdk/Ugyf
 0/+TqOtcYZSLZsVvXD1Zr5O+kiPlLgZmHzKXiwraUTrPK3GxTDh7TIWkZ80bnNs6xFxo
 zCo5FezO8LdKza149JCtqaI/+OWuOPWVTWT1O1NeoBxG+ptsJedv8izKFtmtcsdPOjBa
 QRhw==
X-Gm-Message-State: AOJu0YzCtDi81F7eDFFIV7sWopuaGAa8RlYiDOfX3Qnz+j92UIVMUH3b
 ByX9dwHwtDiLLiXmp4fRanpKemiLXL+knFqpqUu/9ulhJ8hJ36hOENK1i2w2U48bP8st3LdRigH
 x6J1Ju+GwcElBeA4q8g/MCY24QJh3u/+0y7zh3+BGAE5pUgJWph8+/sDqCk85ISC7CdZOv8AEfl
 o242QtLnFXkDmQ0r6ZauBpt+1NSUEc41GJPwWxWfFE
X-Gm-Gg: ASbGncvNstQNzjWNHcYLlu1GN9+cK3TyzbR8WJaCW9pTsFmhIMZKr72vvO0DqjpWS8q
 1o8EX814PiWyiRFQ20pRmS25ZTDnWhI0FN/7cfcbYWH2rDqmfxIAg2xLbm1PFOePl2S+eJem+K9
 2NLdcnoz2XW8B1ajcRujIqCeW7W/V2f4Kj0QWMQJes2cxPLd0w3eaU6UQXGOBylrHBRxNkWDz88
 JsF0+xhvL+ogdKeGaJrI780UagmGxjLba5xlPhF+dZfmW3KpgMy8NzwX3h7mFWqGxiacWOvDZmY
 +vPuIaoef/WQ7ccVQ/z/JqAmYaSvTSNth1O4g7KJTYBpYAMdb+9PAEpsiQ65XoVb/Ky+8iUvXd9
 w5AOjU176LPQycu2m6t+b5V/RgFqop7EfMtfYbcrRfaU=
X-Received: by 2002:a05:600c:6487:b0:46e:39e1:fc27 with SMTP id
 5b1f17b1804b1-46fa9a8f0cemr160878715e9.5.1760449090997; 
 Tue, 14 Oct 2025 06:38:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGEmnR9yxFYmZ+ykpFC86rSk7rhuXi1POD3hloDWO1FImA+qcYW83S8RGrFU2CHfGy7/L1FIw==
X-Received: by 2002:a05:600c:6487:b0:46e:39e1:fc27 with SMTP id
 5b1f17b1804b1-46fa9a8f0cemr160878475e9.5.1760449090516; 
 Tue, 14 Oct 2025 06:38:10 -0700 (PDT)
Received: from [192.168.10.48] ([151.61.22.175])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426ce5e1024sm23587864f8f.42.2025.10.14.06.38.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Oct 2025 06:38:09 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 20/28] rust: migration: do not pass raw pointer to
 VMStateDescription::fields
Date: Tue, 14 Oct 2025 15:37:05 +0200
Message-ID: <20251014133713.1103695-20-pbonzini@redhat.com>
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

Pass a slice instead; a function that accepts a raw pointer should
arguably be declared as unsafe.

But since it is now much easier to forget vmstate_fields!, validate the
value (at least to some extent) before passing it to C.  (Unfortunately,
doing the same for subsections would require const ptr::is_null(), which
is only stable in Rust 1.84).

Suggested-by: Zhao Liu <zhao1.liu@intel.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/migration/src/vmstate.rs | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/rust/migration/src/vmstate.rs b/rust/migration/src/vmstate.rs
index 5f5708ad39e..2e320262f06 100644
--- a/rust/migration/src/vmstate.rs
+++ b/rust/migration/src/vmstate.rs
@@ -425,7 +425,7 @@ macro_rules! vmstate_fields {
                 ..::common::zeroable::Zeroable::ZERO
             }
         ];
-        _FIELDS.as_ptr()
+        _FIELDS
     }}
 }
 
@@ -677,8 +677,11 @@ pub const fn unplug_pending<F: for<'a> FnCall<(&'a T,), bool>>(mut self, _f: &F)
     }
 
     #[must_use]
-    pub const fn fields(mut self, fields: *const VMStateField) -> Self {
-        self.0.fields = fields;
+    pub const fn fields(mut self, fields: &'static [VMStateField]) -> Self {
+        if fields[fields.len() - 1].flags.0 != VMStateFlags::VMS_END.0 {
+            panic!("fields are not terminated, use vmstate_fields!");
+        }
+        self.0.fields = fields.as_ptr();
         self
     }
 
-- 
2.51.0


