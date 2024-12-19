Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AF9AE77184
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2024 16:22:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOJFV-0001na-5p; Thu, 19 Dec 2024 11:19:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tOFOL-000660-4l
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 07:12:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tOFOJ-00088O-Jt
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 07:12:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734610351;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=01O/MAUKR9Ox+siVKoWDUrcgLu5PuJZFTnesxu9l5+0=;
 b=D8XlhHomxaaRw+d+SlPiTlOmCJLEBBwx+GMMyK/3EwPFptCfXWbR/DcU64q1BeHVGwVDCO
 ACUZe3YxM70Q8fWwfX3RafecgNPJmGykfonchIi2xA+Ujg4Wr85dXvRvFpi6eYSMKh9u3R
 LIAkZx39qY6k85PGnkjDIlcwa7T5Xmo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-112-TRCa2_BjOPS-jUWHaryMSw-1; Thu, 19 Dec 2024 07:12:29 -0500
X-MC-Unique: TRCa2_BjOPS-jUWHaryMSw-1
X-Mimecast-MFC-AGG-ID: TRCa2_BjOPS-jUWHaryMSw
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-43582d49dacso5929375e9.2
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2024 04:12:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734610348; x=1735215148;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=01O/MAUKR9Ox+siVKoWDUrcgLu5PuJZFTnesxu9l5+0=;
 b=Lgm1e2sGGU5aorUMMncCSTJwGgdnieBTXvSHnKGQHJRuyDaPL2yH64xbX2BnQocfah
 FsiLEARvOEjRZsfjspja5Y/vCuE6wFtCOtGLAIOREzZ5a9Ji/GzbF/of98fFsNgroNMw
 t2vSeY9JD0xRpkERo8QR3OxIPuN7XXKQGP69gd1Wuc1TOFJ8bMFuRl0fkuFDI+zVQViM
 0JU4PO16daXaJKUz5ZCleiTGsoowOAOI+EdSHSNeFHqDiQbse0w5y/yRQwQD/qOus9Q8
 x4CmOkpRZABtmk3nRZRCw0G/xo0QplmaI8k8/mIodELvmqTaRvx1ttdfAzKxvS6poHeW
 BjRg==
X-Gm-Message-State: AOJu0Yy88w5IZw/GBsHqDFfWcZsatcap9/C7g3/RPYFostu1jmrbnY8J
 PW572xS0VSBKQAXO132G8Wr/0m4ogJFw3QizylKvWRR6wv7DxOcVMjD37QUokb3X2/cctgN5Cwg
 Q+/qNyJLB7g3w1ApjKTGEKl4vUSGcMQyfvhipIXh1GnSARSRfmOobifrGPGrjxP3/KSYFHVObu5
 WF6aou7b3s64CQDdkp+Ktdg+lwFA+urjMG7wX9
X-Gm-Gg: ASbGnctRHMaj/oHOv96+KDTqbyJimHe6tDjSF8f901HBRL1z0kqjPya6JjKpsUi0RdH
 /Uct7JHpB2FZnG/vju80XjdCBeGdkFqTWQZn/PDXHkFd0AUmg1JPA6zF9AOC1XPh+NYkyA/xcUE
 p6x9s5+5xvjmPGFGq4gMNQ4iISCeObFssDELw5xpS6BSiveKhE1vwuvQoMih3pHaY6H8xIlzPNG
 r1NVAf40P0AQTSCo4/SOUUQpWJVezCcyf3V5fdnrzG3+RNcGuYNVGpaJyyH
X-Received: by 2002:a05:600c:3106:b0:434:fa61:fdfb with SMTP id
 5b1f17b1804b1-436553685ecmr62042035e9.18.1734610348028; 
 Thu, 19 Dec 2024 04:12:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFOoS7R67l/AhDZ0Ln78MMOHmR5MZkCb7FKxO8UAmuS44IcqYxGRbmWRC178Qgk4rNyEPsgBQ==
X-Received: by 2002:a05:600c:3106:b0:434:fa61:fdfb with SMTP id
 5b1f17b1804b1-436553685ecmr62041625e9.18.1734610347581; 
 Thu, 19 Dec 2024 04:12:27 -0800 (PST)
Received: from [192.168.10.47] ([151.81.118.45])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436611ea3d5sm16996935e9.5.2024.12.19.04.12.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2024 04:12:25 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: zhao1.liu@intel.com
Subject: [PATCH 04/10] rust: macros: check that #[derive(Object)] requires
 #[repr(C)]
Date: Thu, 19 Dec 2024 13:12:10 +0100
Message-ID: <20241219121216.416905-5-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241219121216.416905-1-pbonzini@redhat.com>
References: <20241219121216.416905-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.116,
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/qemu-api-macros/src/lib.rs | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/rust/qemu-api-macros/src/lib.rs b/rust/qemu-api-macros/src/lib.rs
index 778b698be45..0f04cca3841 100644
--- a/rust/qemu-api-macros/src/lib.rs
+++ b/rust/qemu-api-macros/src/lib.rs
@@ -54,6 +54,8 @@ fn is_c_repr(input: &DeriveInput, msg: &str) -> Result<(), CompileError> {
 }
 
 fn derive_object_or_error(input: DeriveInput) -> Result<proc_macro2::TokenStream, CompileError> {
+    is_c_repr(&input, "#[derive(Object)]")?;
+
     let name = &input.ident;
     let parent = &get_fields(&input, "#[derive(Object)]")?[0].ident;
 
-- 
2.47.1


