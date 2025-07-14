Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F894C83F1B
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 11:12:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubH2m-0003l8-Vo; Mon, 14 Jul 2025 07:08:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ubGyw-0000Yk-VU
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 07:04:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ubGyt-0001VQ-D6
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 07:04:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752491062;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pkcK2mp/r9KYf+5t7Za+iWN90GIRah00on6p/UlJAyY=;
 b=JTGw6UgoAr6qQylAlAYg9T1X1WIzbDJ1qN31EAxbq9b5Pwh9D2SjloDooZHfyuujTGNL6E
 FEmM+d2d4Px3qpp5kkSY0kjSMApPgGv3ffSA/vkKhyVVMLj+kFAXZMIulMu//sMUFaZbZ4
 DG/yuj74p6xBJa7aaB/KUR0zBRENJc0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-508-31PKq43aMiG_9LIsXUrfLQ-1; Mon, 14 Jul 2025 07:04:21 -0400
X-MC-Unique: 31PKq43aMiG_9LIsXUrfLQ-1
X-Mimecast-MFC-AGG-ID: 31PKq43aMiG_9LIsXUrfLQ_1752491060
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3a4f3796779so1813760f8f.1
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 04:04:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752491059; x=1753095859;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pkcK2mp/r9KYf+5t7Za+iWN90GIRah00on6p/UlJAyY=;
 b=fXv98u+otcjg5pd7EdRiBCGfqV9wrHicV3QMti9yADRDdhXZ9AHCFiUyi5pnCI1EqU
 hy3GsQVbx0Vxl9oucjnVuG6ht+6NydEq41mV3mDXyoSTai1okayiIp2St7BSMt/81S8T
 DRoJCsgfoW+zEVF/wQRb7jOnqm0lCCY3OCrhizttp24ePQhABTbd5Oc3Ky4Vvec1J1iR
 Dbcl3h9mnMyN3Aa4Urjrv9mz7todJtMW3uEwurgyt4Qm3kEzuiFXvRPoDB5b7nBCmonx
 0aXqYX4S1vUGN4B2XOw5lXom690+CEeMMagILxNefeFDepxDWdtxRh7bdirUJrszZcrA
 uHbw==
X-Gm-Message-State: AOJu0YzVDuYezK3illhQv2+h4NOUedOVcOTLLgiGbFk1ANAh+8K7t8mj
 5XMuFUZgBM4QA6yMxgfBejVaopzxj7H/LxcUcP8tBzPisEwm/y17AqDA5IvpYoASldj51XqT0ou
 RNgYDS4w4Ob2bjbP9ZsJj+6OhTjp4Fck+tiH/+rZB+HJ/IPg05gtaIeFAALckSvm/uVpeT/r0RB
 LDX1YOd72/OAOkJjLVn6CtZ8GPzyE9js3KJ6cbUguz
X-Gm-Gg: ASbGncsg9U2CarN8X60u+iDCM8Uvg2ynWS/Yq1UpM4QvQ7HNRjAQ7bKoC/Z4iQ8GXeh
 KB2hojLUUU+xB9TPlY8IEml0HFaAffiN3YuPrikHFqEHTGuMWZCyI+vDXcx17aZCNOgxIBhxxQG
 LZ9MeqNjDs/7oa0nxppzcYFakPooftnd1BYK0jSYJMS0nOu9byfjbepZmAOJs5nQiaBBx8jgRov
 VormLLSiRxTpjkEh++21cVVHIA7evYAh8Dgo9lo8kw2bAGOe1pfJuTaOjHng6sah+gkwjekVpAP
 fH0daRe/BdcttpBEPIcxBE8LFlvpz6mFYqWTnV7g++U=
X-Received: by 2002:adf:9cc3:0:b0:3a4:fe9d:1b10 with SMTP id
 ffacd0b85a97d-3b5f189c2a8mr10310199f8f.45.1752491059327; 
 Mon, 14 Jul 2025 04:04:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEfsUz1OocMJPypWDY8fsShkos63HbK5Air1Cf7vEnUp60fxSY8t88dUGkt83e/PyOHgeqDQA==
X-Received: by 2002:adf:9cc3:0:b0:3a4:fe9d:1b10 with SMTP id
 ffacd0b85a97d-3b5f189c2a8mr10310155f8f.45.1752491058543; 
 Mon, 14 Jul 2025 04:04:18 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.73.155])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8e0d732sm12320114f8f.52.2025.07.14.04.04.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jul 2025 04:04:16 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 04/77] rust/qemu-api-macros: normalize TryInto output
Date: Mon, 14 Jul 2025 13:02:53 +0200
Message-ID: <20250714110406.117772-5-pbonzini@redhat.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250714110406.117772-1-pbonzini@redhat.com>
References: <20250714110406.117772-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Remove extraneous `;` and add missing trailing comma to TryInto derive
macro to match rustfmt style. We will add a test in the followup commit
and we would like the inlined output in the test body to be properly
formatted as well.

No functional changes intended.

Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20250704-rust_add_derive_macro_unit_tests-v1-1-ebd47fa7f78f@linaro.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/qemu-api-macros/src/lib.rs | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/rust/qemu-api-macros/src/lib.rs b/rust/qemu-api-macros/src/lib.rs
index 2cb79c799a2..5bbf8c6127a 100644
--- a/rust/qemu-api-macros/src/lib.rs
+++ b/rust/qemu-api-macros/src/lib.rs
@@ -199,7 +199,7 @@ fn derive_tryinto_body(
     let discriminants: Vec<&Ident> = variants.iter().map(|f| &f.ident).collect();
 
     Ok(quote! {
-        #(const #discriminants: #repr = #name::#discriminants as #repr;)*;
+        #(const #discriminants: #repr = #name::#discriminants as #repr;)*
         match value {
             #(#discriminants => core::result::Result::Ok(#name::#discriminants),)*
             _ => core::result::Result::Err(value),
@@ -227,7 +227,7 @@ pub const fn from_bits(value: #repr) -> Self {
                     #body
                 }) {
                     Ok(x) => x,
-                    Err(_) => panic!(#errmsg)
+                    Err(_) => panic!(#errmsg),
                 }
             }
         }
-- 
2.50.0


