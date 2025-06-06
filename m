Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00C24C5AD49
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Jun 2025 12:37:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNWIe-0002uy-Nw; Fri, 06 Jun 2025 08:35:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uNWIc-0002tp-QW
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 08:35:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uNWIR-0005va-Im
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 08:35:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749213342;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SNmC5Do3yi81y5Ng9JdAMfDVJMpEljlycID+S3omCnY=;
 b=YnFMifeQS5oRdYQ1NI8Y8GW87kNkA1IOWJQFwvArr5/t4r3HQgk6m/9SxpHFUzZ4SbV8xr
 WeW558rsgQSeS1lGuNRK4D+2oRiUQYFv7uY3Ww3+aau4Qk2gMlMU8t1uSlG4uuW30e9X6i
 0z7rVIri4W9vh5DkY8T+7JDNFlgO9Y8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-6-Y86l-Q-yMZe_YbZAZVqoLA-1; Fri, 06 Jun 2025 08:35:41 -0400
X-MC-Unique: Y86l-Q-yMZe_YbZAZVqoLA-1
X-Mimecast-MFC-AGG-ID: Y86l-Q-yMZe_YbZAZVqoLA_1749213340
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3a4e713e05bso1028640f8f.3
 for <qemu-devel@nongnu.org>; Fri, 06 Jun 2025 05:35:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749213339; x=1749818139;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SNmC5Do3yi81y5Ng9JdAMfDVJMpEljlycID+S3omCnY=;
 b=nuyOA1ZQXI1H54m0i3CNrgUknWmqSjs+/SNVhixh4JJZo+O8y7rR4uibljmXRv14nl
 UlPAEj1fUXAP+I8XDsUrAPQH+1J1u2xlgnHs39bR3vQ4HiqqhNPnxULMiHd5/ZrrpTsW
 /L0iOvwPqf87Zb8eABxXLcTCeJg+JsWWW/F0daALXcC0DahWg3zHPHii0yNmZcQb5J3T
 hwvHe5L2pNMonMD/s1mO5kUehoOQdIRROTXTA5WLcxHIPhT7anLg5vmPesIePTYhoxDN
 9Wjb/YZFhN/JHsAZhiVFFwfepl4dvNre66kZipgelbZiuTKEK9HPLCaap4yUNg2P/SXg
 DUdw==
X-Gm-Message-State: AOJu0YwqFVQngRDgjy7dAWN+qXDyYADx7IvlXGVQS8uFwH2F2K0i3nrm
 YG4BBf0huko0Vuxz5cHtN3Onf8Ruk2zZIk2/SNZ05H0RHoRy0U9K7reoN8nIoIqTqVb5cHxCwPG
 r+jmHuOunw3fwB6xG3WxobWCAWs+ZPvwyPAn+v/J8GD57EgyvJij3EJHH5CS9F3+fcZxyPwtMCQ
 HUcsDvHBm2WcIofmyU0Q0xXd86vpNCDQqLrEuhXIL0
X-Gm-Gg: ASbGncvWV889POr6ZbrY+FV0K9yZ8n/BB1VrDJEJ61HDe9bXq4NaoSnTAiuRjisI8yC
 T2XQFXpwGD+2Yir3JvLukgmt3C7KB/LnKgoNO42wxgeLIYF9EKL3XzpY7Wt2KP4UgAEwhVCZ6pH
 sigU9KWdqpXqLuprZ4bycR/Lbwjv4I94v7drwV33JqADksMJPE37sylfxIjrs6/DNdqJOf1HizN
 ZjNk+zp1naCxQxfooxPHeRBI1KKZ6jNrXgUD4yFtYE6/nlvvrxJMK30Ui8N42oYfrSIpP/zq70s
 iHlznt+4UwoOCjiC5rnlil6p
X-Received: by 2002:a05:6000:40c7:b0:3a4:f7db:6ff7 with SMTP id
 ffacd0b85a97d-3a5319b49c3mr2852726f8f.52.1749213339643; 
 Fri, 06 Jun 2025 05:35:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGeUaWmJFlwhY46ZFAr8nObJJPkZg76+/fVFdZxDI+CegX6bt1cg2c5VGsgM7TXuZO8psMChQ==
X-Received: by 2002:a05:6000:40c7:b0:3a4:f7db:6ff7 with SMTP id
 ffacd0b85a97d-3a5319b49c3mr2852708f8f.52.1749213339193; 
 Fri, 06 Jun 2025 05:35:39 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.64.79])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-452137278adsm22950255e9.31.2025.06.06.05.35.36
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Jun 2025 05:35:36 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 15/31] rust: make TryFrom macro more resilient
Date: Fri,  6 Jun 2025 14:34:29 +0200
Message-ID: <20250606123447.538131-16-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250606123447.538131-1-pbonzini@redhat.com>
References: <20250606123447.538131-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.104,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

If the enum includes values such as "Ok", "Err", or "Error", the TryInto
macro can cause errors.  Be careful and qualify identifiers with the full
path, or in the case of TryFrom<>::Error do not use the associated type
at all.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/qemu-api-macros/src/lib.rs | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/rust/qemu-api-macros/src/lib.rs b/rust/qemu-api-macros/src/lib.rs
index 103470785e3..c18bb4e036f 100644
--- a/rust/qemu-api-macros/src/lib.rs
+++ b/rust/qemu-api-macros/src/lib.rs
@@ -203,8 +203,8 @@ fn derive_tryinto_body(
     Ok(quote! {
         #(const #discriminants: #repr = #name::#discriminants as #repr;)*;
         match value {
-            #(#discriminants => Ok(#name::#discriminants),)*
-            _ => Err(value),
+            #(#discriminants => core::result::Result::Ok(#name::#discriminants),)*
+            _ => core::result::Result::Err(value),
         }
     })
 }
@@ -236,7 +236,8 @@ pub const fn from_bits(value: #repr) -> Self {
         impl core::convert::TryFrom<#repr> for #name {
             type Error = #repr;
 
-            fn try_from(value: #repr) -> Result<Self, Self::Error> {
+            #[allow(ambiguous_associated_items)]
+            fn try_from(value: #repr) -> Result<Self, #repr> {
                 #body
             }
         }
-- 
2.49.0


