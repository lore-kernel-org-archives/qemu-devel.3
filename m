Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E6DBC3DA61
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2024 22:07:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWk8B-0001Go-4g; Wed, 24 Jul 2024 18:06:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1sWk81-0000dl-C8
 for qemu-devel@nongnu.org; Wed, 24 Jul 2024 18:06:34 -0400
Received: from mail-io1-xd33.google.com ([2607:f8b0:4864:20::d33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1sWk7x-0006cj-Vv
 for qemu-devel@nongnu.org; Wed, 24 Jul 2024 18:06:31 -0400
Received: by mail-io1-xd33.google.com with SMTP id
 ca18e2360f4ac-819c1f53617so11155539f.2
 for <qemu-devel@nongnu.org>; Wed, 24 Jul 2024 15:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1721858788; x=1722463588;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3HfMaHOOWW7MVPgIcUVzJcmEX/Y4bX1rEzWv+B3ibeI=;
 b=1FdLU/J38OAIL/tfOChYrJnC2Oks3YNRUHOHMZV0fpqmLDk5/i/zYvOOKlKJbdKEIB
 anAF+Ri5x2e7wyH6WSerykYLFL9YxC9iaPP4I4OsNWSYPSkK3OT0uyHJDOGlYrsIBILs
 rprkol1OmiPU/KycdkuRCEBxo/UZwIwqf22oeffF0xJlgtP5QXJZ0wBEnilFmC4hw849
 PkqKegtRbwSO87QJ6Yn+S+7iIEFcARUPJm80GLnLT421cUKoGtFUOZNzu1ihJemYGW58
 J4FhgOBUr+R/U9cRhRRTBPn5EQGsLohLcsNnLbCnx4pSQitswdAXEGss4mQFXez9H8V2
 dACQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721858788; x=1722463588;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3HfMaHOOWW7MVPgIcUVzJcmEX/Y4bX1rEzWv+B3ibeI=;
 b=rd3B3+35Ufuxyb5A2rf4tkiSCdpvS/PucsMfhYU2M/GxnROxFk5bqQmYLsedtOVAs2
 gj1M8nE6iHRd9svgtI9L2t9bR0E8mrhxErqvMeG3kXNFkIfCPIDPE6JFfUtmLICLC2x3
 /WXtsRpgMQ1FaV+eg/vbzitBhwK/nbenvSP5Jq1jS9tgM8xG1yg2anUB5elf//U7blbM
 l9dkOxu9HccuJF3NG2NeMwHFPJx6nKTK8YgUt1SjRn1DVVTEHE2NSEhPyZh0Dj3l8qqD
 zC+Gxo2wuXmjgjzJKKYnCQxe+kwldmjH3REHy3jiZ5o54kn+aDfz7vMbZ9ak7RL8ajxS
 vyMw==
X-Gm-Message-State: AOJu0YySUTw2K6gy5cyFZefcKujtUzhN7iKkxbTxZTwyo3npYjbxe58+
 R6s9drFpo4qgsGdH4EZc/y/CPKhfQzMclnCTPqKAMG21iU7aIJbKKes0mkgEhDrD3NMamnNdLai
 AzzA=
X-Google-Smtp-Source: AGHT+IEj6lEzlE+RYvLT7k390NHzXgap5W50/DzyAHwGuNjK6P4650rf4/BJa9tXvpVpoSEbLT4Hxw==
X-Received: by 2002:a05:6602:2ccf:b0:806:f495:3b34 with SMTP id
 ca18e2360f4ac-81f7bcf7d6cmr139694139f.2.1721858788497; 
 Wed, 24 Jul 2024 15:06:28 -0700 (PDT)
Received: from dune.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4c29fa983f8sm10086173.47.2024.07.24.15.06.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jul 2024 15:06:27 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, Warner Losh <imp@bsdimp.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 10/15] bsd-user: Hard wire aarch64 to be 4k pages only
Date: Wed, 24 Jul 2024 16:04:43 -0600
Message-ID: <20240724220449.10398-11-imp@bsdimp.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240724220449.10398-1-imp@bsdimp.com>
References: <20240724220449.10398-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::d33;
 envelope-from=imp@bsdimp.com; helo=mail-io1-xd33.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=unavailable autolearn_force=no
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

Only support 4k pages for aarch64 binaries. The variable page size stuff
isn't working just yet, so put in this lessor-of-evils kludge until that
is complete.

Signed-off-by: Warner Losh <imp@bsdimp.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu-param.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/target/arm/cpu-param.h b/target/arm/cpu-param.h
index 2d5f3aa312c..fa6cae0e3aa 100644
--- a/target/arm/cpu-param.h
+++ b/target/arm/cpu-param.h
@@ -21,9 +21,13 @@
 #ifdef CONFIG_USER_ONLY
 # ifdef TARGET_AARCH64
 #  define TARGET_TAGGED_ADDRESSES
+# ifdef __FreeBSD__
+#  define TARGET_PAGE_BITS 12
+# else
 /* Allow user-only to vary page size from 4k */
 #  define TARGET_PAGE_BITS_VARY
 #  define TARGET_PAGE_BITS_MIN  12
+# endif
 # else
 #  define TARGET_PAGE_BITS 12
 # endif
-- 
2.45.1


