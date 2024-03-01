Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D56DC54798
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Mar 2024 04:13:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rgGjG-0005KR-I7; Fri, 01 Mar 2024 23:12:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rgC1a-0003uI-BO
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 18:10:45 -0500
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rgC1Y-0005kF-Ub
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 18:10:42 -0500
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-6da202aa138so1999747b3a.2
 for <qemu-devel@nongnu.org>; Fri, 01 Mar 2024 15:10:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709334640; x=1709939440; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KYeT1V/wjgovpdrb0SONHx5NJHYkyLqzQDA/KKTsreA=;
 b=bfqqnoQXRtRu9rKmqZdnmlMhk0tdTgJzXJIUT59zAG1arQWm6Hpj1QAIg6CIpJBW1a
 0yZRluUF2/griNTzM85SXrU5j4IbQIRJ0GIEPDC4tCQAsHdzEVuDHmQbABCqFcQvU+kX
 fMVL4SaFktGze/Dcv9nJoPSLzs1kteE9rlKFqmuvY1Rpc+Qo634bzt37woi8/72X4tZt
 w2l0lNoVI+usYtiWIdNRm9THgSTMmuWuF4CRC8EuY9eZdTg05jE600AvyopV5i8nzFvq
 wer8nx6+suO0fOPtG+/q8PCEU6uQxEgrvuOqs2Y8QQpmvvKqTWzKrVCbeWK7OmW+bkg3
 5HxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709334640; x=1709939440;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KYeT1V/wjgovpdrb0SONHx5NJHYkyLqzQDA/KKTsreA=;
 b=Co/4c+kigvCJYmHFz8RabJXgzvPuHdwLqrAf6xbKP14TDkSCjmN+F5SgcmLWy2gpoc
 Mkw+ffA4CSnYaYQb0AiiBeKVSVGECX+mRQ/jzX+9pGyL2VnChY4fiYc2fHusVGTG8D0F
 OicgOS1If6J5+L0xhiCKatnl50gZxbkQtxxJByW0A+45B5F0QhUluGLTs+YKGHViOgNs
 412DIwv7qzm4AHQKcEvFnyyMc0l4GX+16WyABcwECptqXhAuO+HENg43AzxTxkMcqAxr
 wLBB9dPCXi6fhqSGFNCOUc5VwwZEs1qE8tAxHjxnIhyC82mdSMXX6vwO2Nxn85+WON7x
 9otw==
X-Gm-Message-State: AOJu0YwnS/IZWrEa5eAxuA1fwevHCntG/TsM/5Wj2hIkQ8eftrs/Rw33
 fuw2RMFsS4fydA2/hsuEDDITXnX386m1nhUHmYskY8U2kva042L3WBZWpUQlt1ZBbELv1d6Ntq1
 /
X-Google-Smtp-Source: AGHT+IGJh5ix0cyG+rqbDvsBx9duUZtS+JkxYUCrQUqduERa6SbOksHb3uU7JwefIXbCUs2yugHEpg==
X-Received: by 2002:a05:6a00:27a0:b0:6e5:5f6a:4966 with SMTP id
 bd32-20020a056a0027a000b006e55f6a4966mr3790759pfb.6.1709334639677; 
 Fri, 01 Mar 2024 15:10:39 -0800 (PST)
Received: from stoup.. (098-147-055-211.res.spectrum.com. [98.147.55.211])
 by smtp.gmail.com with ESMTPSA id
 c2-20020a634e02000000b005e438fe702dsm3449407pgb.65.2024.03.01.15.10.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Mar 2024 15:10:39 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Helge Deller <deller@gmx.de>
Subject: [PATCH 52/60] target/ppc: Enable TARGET_PAGE_BITS_VARY for user-only
Date: Fri,  1 Mar 2024 13:06:11 -1000
Message-Id: <20240301230619.661008-53-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240301230619.661008-1-richard.henderson@linaro.org>
References: <20240301230619.661008-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Since ppc binaries are generally built for multiple
page sizes, it is trivial to allow the page size to vary.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>
Acked-by: Helge Deller <deller@gmx.de>
Message-Id: <20240102015808.132373-33-richard.henderson@linaro.org>
---
 target/ppc/cpu-param.h | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/target/ppc/cpu-param.h b/target/ppc/cpu-param.h
index 0a0416e0a8..b7ad52de03 100644
--- a/target/ppc/cpu-param.h
+++ b/target/ppc/cpu-param.h
@@ -31,6 +31,13 @@
 # define TARGET_PHYS_ADDR_SPACE_BITS 36
 # define TARGET_VIRT_ADDR_SPACE_BITS 32
 #endif
-#define TARGET_PAGE_BITS 12
+
+#ifdef CONFIG_USER_ONLY
+/* Allow user-only to vary page size from 4k */
+# define TARGET_PAGE_BITS_VARY
+# define TARGET_PAGE_BITS_MIN 12
+#else
+# define TARGET_PAGE_BITS 12
+#endif
 
 #endif
-- 
2.34.1


