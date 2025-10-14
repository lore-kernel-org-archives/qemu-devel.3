Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EFD6CCD192
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 13:39:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8fEw-0006Ui-EX; Tue, 14 Oct 2025 09:38:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v8fEn-0006JU-CY
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 09:38:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v8fEc-0001Bt-T5
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 09:38:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760449117;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Uh/pxSQ/Sd1WhNbQxNStDv+XeBlFCMlLdX4UKvDjl8Q=;
 b=dZj4RFqsmj8ykWu3Q3bhWUHa+Z1+o2iozaMFqOqF5s1qkw9HlmKUDVRAS3bukCYskXuIZx
 yH50sWwJTlpvnCk64S1heaZzQnvRI1MFMSpCyZiOvOGJT1Puc+80oQ4rwICTRil19H48lo
 BaNayTyPNfE4DhsVkI7PKXWzMAIxjAI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-675-kvZuiuB0OEqCLwaWK8519g-1; Tue, 14 Oct 2025 09:38:35 -0400
X-MC-Unique: kvZuiuB0OEqCLwaWK8519g-1
X-Mimecast-MFC-AGG-ID: kvZuiuB0OEqCLwaWK8519g_1760449115
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-46e36686ca1so49926475e9.2
 for <qemu-devel@nongnu.org>; Tue, 14 Oct 2025 06:38:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760449114; x=1761053914;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Uh/pxSQ/Sd1WhNbQxNStDv+XeBlFCMlLdX4UKvDjl8Q=;
 b=NU8sEqxdrBCvEVqpRlXiUfG5b051vUcRwArLmzEWLSaQJhDwNqW0q3rdFVvbhwiSsl
 h/fE0HlIb/PiSO53sPE/OloI8kRoqXchVSuhRSJjVJSLVnKN1fDjKNBXl92OZheT9tT7
 QbtgacCFzJi7o85hntwHs58a8xBqcKmzphbHeifo/m7TnCAf7FGDTOiOkLTo4gWbA48R
 v1dP1d2bmrKWraL8oG8IfCbzFTkNiQ8hQIPdjoR0Xl13R/SmR6CbL9oi1pjKh+GAgx6S
 m3agGG1x09Ve27tIyvBse//3FlP9sJzDQIz4pNQoueecsNo+zuQV7/VLdjqNp5PFGZuV
 EZiA==
X-Gm-Message-State: AOJu0YwAeDYuNC7IrE+ULHCeR5h7632h6xG3Yl0tC4nqF/9ag25Hkrwn
 0dLx6XjItFfl5p2S1RKO2u4Tjnv/68VizI1fT5nZfMLt/X6T37kHKpBsfhsPdnDsSpp2xFJ6EYk
 +OJoe911FEE7wbdkb1RFnhLEvCQBQR98cKb6BWo+O5jlQb7OU3gJw71ouHbfEKYmWXLCWuFX/QU
 ULmNherPjYZMxmpP1fGqIRBy/YTpC5u3ht+hzQEbvj
X-Gm-Gg: ASbGncsrEwaQ5YLsF7B3I4MyHwKtDqtNMZSDNLF2qGS8pnvSA43Nrf5rEPx/Tyk2SO0
 e0L3jWaV9UXcE88Cwcq9P6Q7wWH0khJF3Kd9jWnCQiVTUfjli6yxBqVLGugimbheTTeISYudlcb
 8O6Q14eW78YCVqdkuqyGjGrDoZ6mNy1c965y0IhfODFpCl2ZrkC0VInsxrCk6FiT8yfLhF6Y3Md
 izxTbd6hlxl/m6+J/PCOPZQ7G8PrzRBofIDXwdDTkvYdDAL95poUlBSN2xTXlTTh8tss+5pbMHx
 7OKLB+CNzAOJbd/njZSZUYArL5xIheM65SSuu1MNh/u4iJhSNjiY3Qs28ims9TGPFihJbfHNzzE
 BmQWAnbkvpfl8nToicrtHwQ6BqAHKA0I7NQDy1zed4Gs=
X-Received: by 2002:a05:600c:c091:b0:46e:59bd:f7d3 with SMTP id
 5b1f17b1804b1-46fae33dffamr98424775e9.20.1760449114183; 
 Tue, 14 Oct 2025 06:38:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE21Pc7pirquGQfHgv3GbUAv+Qiye+ZBS8YQ2zNUOpUiNxmh7qAInM154RCSTudFmqOfSUp+w==
X-Received: by 2002:a05:600c:c091:b0:46e:59bd:f7d3 with SMTP id
 5b1f17b1804b1-46fae33dffamr98424655e9.20.1760449113763; 
 Tue, 14 Oct 2025 06:38:33 -0700 (PDT)
Received: from [192.168.10.48] ([151.61.22.175])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46fab36ed3bsm163774515e9.0.2025.10.14.06.38.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Oct 2025 06:38:31 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 28/28] rust: migration: implement ToMigrationState as part of
 impl_vmstate_bitsized
Date: Tue, 14 Oct 2025 15:37:13 +0200
Message-ID: <20251014133713.1103695-28-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251014133540.1103268-1-pbonzini@redhat.com>
References: <20251014133540.1103268-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
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

This is most likely desirable, and is the easiest way to migrate
a bit-sized value without peeking at the innards of the bilge crate.

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/migration/src/vmstate.rs | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/rust/migration/src/vmstate.rs b/rust/migration/src/vmstate.rs
index 445fe7fbc08..42e5df8d818 100644
--- a/rust/migration/src/vmstate.rs
+++ b/rust/migration/src/vmstate.rs
@@ -296,6 +296,25 @@ unsafe impl $crate::vmstate::VMState for $type {
                                           as ::bilge::prelude::Number>::UnderlyingType
                                          as $crate::vmstate::VMState>::VARRAY_FLAG;
         }
+
+        impl $crate::migratable::ToMigrationState for $type {
+            type Migrated = <<$type as ::bilge::prelude::Bitsized>::ArbitraryInt
+                                          as ::bilge::prelude::Number>::UnderlyingType;
+
+            fn snapshot_migration_state(&self, target: &mut Self::Migrated) -> Result<(), $crate::InvalidError> {
+                *target = Self::Migrated::from(*self);
+                Ok(())
+            }
+
+            fn restore_migrated_state_mut(
+                &mut self,
+                source: Self::Migrated,
+                version_id: u8,
+            ) -> Result<(), $crate::InvalidError> {
+                *self = Self::from(source);
+                Ok(())
+            }
+        }
     };
 }
 
-- 
2.51.0


