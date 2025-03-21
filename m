Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15596C36000
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Mar 2025 11:25:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvaVU-00042c-Pe; Fri, 21 Mar 2025 07:25:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tvaVK-0003w0-0j
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 07:25:34 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tvaVE-0004OM-30
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 07:25:33 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-43cef035a3bso13390075e9.1
 for <qemu-devel@nongnu.org>; Fri, 21 Mar 2025 04:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742556327; x=1743161127; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9vH8UmsTVl9pFvTYnHstPZudBd2C6Qn5erg4QfltUDw=;
 b=PgMx0PEs61XRjPmZ2ULXErS8IL9F08LY1PhBHHvaJAfksmgFE12RCD7PTzu84SMh9a
 j9LsYRIkxvKcjuhreejmM0otf+J4rjIIliIq5/1RvSMmCG35kCAwskyVWG66GANGF1V4
 eF2bisBvb7nL+VuyVF5T6WaaUTE+Q58qK88k/7aX7VmQqNmM6RNhiuUY5N1LfKZlzjTR
 AbLr/5rcG6I37CSFs8nlM7NcHbQXFfcuGMkukZ3Xvq1J2OpjoYIBK7W9NPmr2VjRvgwc
 VesnX4wyo5LnX3SiuQf8Xg7ys0Cv8ddDVbbyxmNtfaZRRHGTccRHdKyUNkUg2FDGSzhN
 +Ixw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742556327; x=1743161127;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9vH8UmsTVl9pFvTYnHstPZudBd2C6Qn5erg4QfltUDw=;
 b=oa5H2gJh3UW6aQeYOzgdnrWoPd73j4RUsD3Kn31dJ22M8dNUmTWK8VEB/pNX2pjyYS
 Ky7TuKNTx9YHD1hyD5iMClYRYMOku6sIjREKZU99/jQIk1QjoSnAU9vdq+NlObTSYsmB
 R2J7fLOqvKqO2XRNc9nmDdZJhwKYt5JMDW9FebYh3pvYb7VNpHYluX/Un0y/dQGZIG0B
 YXkDnX6JbzGxh92DiSXkjKJmnXBc621yCkZMRERwAXKeZ2oAlm21nP74nLmphutBBd5Z
 An1TBZCWedOeUHSPpMu259fnj8HAZyq4HOB5fUAzbrwUqdbbAFmvZfeShB8LMlLoeyxf
 Aa4w==
X-Forwarded-Encrypted: i=1;
 AJvYcCW5n3/in09DFw+5nbn/guNcTtHQVl3TWluk1a3APT9BYnvTuJ/Vti41CkRuHOWlDpH55nB5fUgXrsR+@nongnu.org
X-Gm-Message-State: AOJu0YyTWmk6FUY6N1uOFDConhqhvM31c+gMc+aUY5JIm2WHsVXJafDK
 ULXc9SuyXDuksGqmQ0+XiPQniYt31BIGOBUM/UCcDZLZyVkVMwnDr09LnrLMMRk=
X-Gm-Gg: ASbGncuJjlZpfB1HkcJJmIa6lQKavVGQLnIc/YZSmxs4vLGnIH2rAyCqGR/2wneMGJh
 ZCKJNJO29sUcQCubtEWAP7QFvPLpXC00/2CfKSUJST0q0gmzhQ/WbMscIRxSE0CJ4iJQR2GCMUA
 mpkCtr1lYorx6FGEJxZ/VXNg7/ATWGgSnfmcIQ3kQMv9xCJBSb1Rr0Am6LEOngRbg91Y1Ohq+Rp
 udrvNZtQQOkzDtU5OQJ08mwJjQ/n1Mz614ssbOoMjujRwq40dtCgQO7x8rnR7A6d7Fbv57oKIs2
 EGpZjGZRigS+fmeKo/DLzRJtyuPA/HlYfsBfPrys6ikBch2yeOI=
X-Google-Smtp-Source: AGHT+IGcpodxHAQlFCov7Dw/ip1/zNTc1GmhEQYpiunbDJ0QVNu+GnXexMWVNEIPpKuvrI2QNm5WRg==
X-Received: by 2002:a05:600c:138a:b0:43d:224:86b5 with SMTP id
 5b1f17b1804b1-43d509e38eemr24686085e9.4.1742556326636; 
 Fri, 21 Mar 2025 04:25:26 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3997f9e6767sm2132614f8f.66.2025.03.21.04.25.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Mar 2025 04:25:26 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v2 1/3] rust: assertions: add static_assert
Date: Fri, 21 Mar 2025 11:25:21 +0000
Message-ID: <20250321112523.1774131-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250321112523.1774131-1-peter.maydell@linaro.org>
References: <20250321112523.1774131-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x336.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Paolo Bonzini <pbonzini@redhat.com>

Add a new assertion that is similar to "const { assert!(...) }" but can be used
outside functions and with older versions of Rust.  A similar macro is found in
Linux, whereas the "static_assertions" crate has a const_assert macro that
produces worse error messages.

Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 rust/qemu-api/src/assertions.rs | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/rust/qemu-api/src/assertions.rs b/rust/qemu-api/src/assertions.rs
index 104dec39774..bba38cfda11 100644
--- a/rust/qemu-api/src/assertions.rs
+++ b/rust/qemu-api/src/assertions.rs
@@ -120,3 +120,25 @@ macro_rules! assert_match {
         );
     };
 }
+
+/// Assert at compile time that an expression is true.  This is similar
+/// to `const { assert!(...); }` but it works outside functions, as well as
+/// on versions of Rust before 1.79.
+///
+/// # Examples
+///
+/// ```
+/// # use qemu_api::static_assert;
+/// static_assert!("abc".len() == 3);
+/// ```
+///
+/// ```compile_fail
+/// # use qemu_api::static_assert;
+/// static_assert!("abc".len() == 2); // does not compile
+/// ```
+#[macro_export]
+macro_rules! static_assert {
+    ($x:expr) => {
+        const _: () = assert!($x);
+    };
+}
-- 
2.43.0


