Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01FCBCCD184
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 21:12:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6xvc-0004u9-VK; Thu, 09 Oct 2025 17:12:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v6xvb-0004te-B8
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 17:11:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v6xvZ-0004fe-JN
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 17:11:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760044313;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=9x2xBqXLvD3TD22ZGiq+KsjrIorcQc7dSOkJFfUH7FU=;
 b=Nwqc1r3TpR4ShKxvAOwndMOpAAfG3XRRqHsBX8TyZBGmDSZbPg3sGGZM3ev9vWzDqs/7Sw
 QXYtEpKewie7lh7FeQWOWXAWNZiED9+8ACOpU85EHyykjl2MM4BMwuTiRGmx19Cugj6ynT
 2R2bAQHinTdZfUztCkZ2X4GcbyuxXaA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-26-g9UTvYQiPpS_5Cj9xqYDmA-1; Thu, 09 Oct 2025 17:11:52 -0400
X-MC-Unique: g9UTvYQiPpS_5Cj9xqYDmA-1
X-Mimecast-MFC-AGG-ID: g9UTvYQiPpS_5Cj9xqYDmA_1760044311
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-46e39567579so7211805e9.0
 for <qemu-devel@nongnu.org>; Thu, 09 Oct 2025 14:11:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760044310; x=1760649110;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9x2xBqXLvD3TD22ZGiq+KsjrIorcQc7dSOkJFfUH7FU=;
 b=pC1DtVz6LGN/ih76hxCmipri+O7gKn7poNk1bolYoQnjundT14LXGO8YXyTYCta3lW
 qJR6gPYXYeIMFmKOfKbETPfqURyXVmJp8nHcX8Qjuv5HcUCj4GQTAJDy3Wt9eAezeQ/B
 OB9WA5B/BCbkVtyTRkGeE/cfU5WogTH3GBrs9QUkdlW6Wm+NISWm8USmIwHHA6iJVIjk
 iMzBNub7CmZzRPITj29lVL43BfGLv/JrzZBB99xuyX3z5ECtaeWkmDzItkNJfdtN3rRw
 9rvaG1EhEzdKrmaDu91oh+610IFFwvNacjZBkMm+BhCE1mQ/v7NX/co30dcc/Q3A4xEi
 +Rgg==
X-Gm-Message-State: AOJu0YyzMNT8jmTKIGCnyQlZw+BdQbtxo3gN6MD1TYcbUgbAik8mKSZU
 FfhZZTH2t0UJA/kltcSZjphjUi5fAU+D+Tk9gXhHDagsUl7mj5NDnRqHaJ0LSQRqMkS4dSZuYVm
 Xk4B9eaiT7TkYmP7ButngBJ2OQYSgkIm0pWzlSH5L1QXMLcPQF8/cCAGIpluV9wzofnSXtDXDVf
 Xw2RWfj4hz1a3lddC74GyZzHuKdDM3sHDxcR05cAVH
X-Gm-Gg: ASbGncsD72zsU4B+/UvSTjYKxeoYPGRR3oiqWEihnIxyFy4QCPwuABFZtRfItBzjbFY
 8xBSHmS04QXL83NSn6Fh0zc28nM9dKfRjb6uxpKxSLjgMSFdmRK7PXJNuG6MI47mtZDCyJyaMq1
 PM66r2OEYwkQ5Qa9G49EFGc0MdtnlULBc1oSNJ9K5M47NkU61shqQemIkvCQXc1+MnnYin+WUui
 9oaoa3hXfDdvhqaedS1GT4B9g8MUrEyQdQwo2b2UPCP4Sdgrz6lhCp2PZWu383V5wDVkjIkLgMG
 c809m2qgXd3RHDgLS1+XEb5ihNFVfm3cbOO6DsfZxmiSq1z1BQ5Nu3W2/xr+0X1REz4QqO2joCm
 43ZrJd8xOkVZyLIwGwXF5S8Y7+aZdNjiNod9mqY204d7uGf5m+Q==
X-Received: by 2002:a05:600c:3b08:b0:46e:53cb:9e7f with SMTP id
 5b1f17b1804b1-46fa9af830fmr64751275e9.18.1760044310311; 
 Thu, 09 Oct 2025 14:11:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEFwjdn4cazfc4hMvWgMhira4B/vpSl5YwgMX+hrU8h6QnaFKvmSFUEwqCrSbECMZT6p+QBoQ==
X-Received: by 2002:a05:600c:3b08:b0:46e:53cb:9e7f with SMTP id
 5b1f17b1804b1-46fa9af830fmr64751205e9.18.1760044309924; 
 Thu, 09 Oct 2025 14:11:49 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.231.162])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46fb49bd9e1sm11523455e9.12.2025.10.09.14.11.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Oct 2025 14:11:49 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH] rust: pl011: fix warning with new clippy
Date: Thu,  9 Oct 2025 23:11:48 +0200
Message-ID: <20251009211148.642966-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.438,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Newer versions of clippy are able to see that all the variants in
the PL011 word length enum end with "Bits", and complain about it.
Allow it.

Reported-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/hw/char/pl011/src/registers.rs | 1 +
 1 file changed, 1 insertion(+)

diff --git a/rust/hw/char/pl011/src/registers.rs b/rust/hw/char/pl011/src/registers.rs
index 0c3a4d7d214..fa572811b29 100644
--- a/rust/hw/char/pl011/src/registers.rs
+++ b/rust/hw/char/pl011/src/registers.rs
@@ -255,6 +255,7 @@ pub enum Mode {
 
 #[bitsize(2)]
 #[derive(Clone, Copy, Debug, Eq, FromBits, PartialEq)]
+#[allow(clippy::enum_variant_names)]
 /// `WLEN` Word length, field of [Line Control register](LineControl).
 ///
 /// These bits indicate the number of data bits transmitted or received in a
-- 
2.51.0


