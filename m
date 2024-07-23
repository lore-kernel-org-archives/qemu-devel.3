Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7F57C3DA63
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 18:13:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWJxR-0002DJ-4L; Tue, 23 Jul 2024 14:09:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1sWJwv-0001I5-GU
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 14:09:25 -0400
Received: from mail-il1-x129.google.com ([2607:f8b0:4864:20::129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1sWJwr-0001DG-Ni
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 14:09:21 -0400
Received: by mail-il1-x129.google.com with SMTP id
 e9e14a558f8ab-36da84df7adso349175ab.1
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2024 11:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1721758147; x=1722362947;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3HfMaHOOWW7MVPgIcUVzJcmEX/Y4bX1rEzWv+B3ibeI=;
 b=yK3jf1rPa6aKIBuKCRnT5wKASjdHnvvVd7IfK3ZVdrv4whgUBsLszxGyP/juDnTvM5
 Q0Gg09iMJLauMCaQCy8V3OqdDCv8DqhpQqwgnRE5AkdkbGO9FwIoJzOSe8T5XV3iUsyH
 EWQtSjYKOLsRFwpXCfmZ/3y3qMVTco1MrQLHtqPeCTTqmgD0nTISQyNaVBA5Yxsa48DW
 2P91hTs+07UlAMN1/XKjIB1UteT5rOxqzMjOi2eM81M493TQIxZeYU/Xyf+Wsme7TmsQ
 PKN+0KFhVg60pDXPK7Kt60tx3G8Wkz4SGFaictWw8chGBqNK2G8zW9XKNGZzyRt/NXT+
 OYpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721758147; x=1722362947;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3HfMaHOOWW7MVPgIcUVzJcmEX/Y4bX1rEzWv+B3ibeI=;
 b=B5t/3sDA/dQuoZrVZP1raCexnjhlI44h04IElK+RaNmJp63dunID9QtK96nN4rTc+a
 7yQT29Mg/YmxhayVCX+uuEomBZ56IPktRlTCjAnZ3dJrPnQvznpmTWOB3K/jXOZ30RrK
 RNYwMfQSMLn4U+cdA3HcHRF2RbgDwxEl4msisf2aDGCzvCRBLwqwJZ7YfeDtsdI7kX3J
 /Njjci9zIZ+WcyQyn5XCuupyaepZlcOFEL6S7gBm6+dfF02WgXn8c4+ZNIo2yErKsSPO
 v+5mM6/1i4ZwFaVGRWY++l9xhOy7OCNZG0Ev+HEfMDhmVb8jpqe8QWpIRxglMoPLArld
 Y0EA==
X-Gm-Message-State: AOJu0Yx6DlojaXuyU6hy4+igmwpkU326vLSu71TN7nL7WzDvpacvGtKN
 VgApR+Gxs33yeV5vQZe8IzCYJJbrV0IU05g4KRd2ntaIrLtDMta9Aaou9i9UqQBUdwT6jjRxqSe
 OhDk=
X-Google-Smtp-Source: AGHT+IHkiaJKN+a1VdNrfAMvycq1mqOgo6FuAOhnKEaF/VUBqHEmqB8kZUdeIVGwXsjAKftk0qITAA==
X-Received: by 2002:a05:6e02:2165:b0:37a:76af:3fca with SMTP id
 e9e14a558f8ab-39a0e322f2cmr24153175ab.3.1721758147361; 
 Tue, 23 Jul 2024 11:09:07 -0700 (PDT)
Received: from dune.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-397f7a2827csm33361775ab.53.2024.07.23.11.09.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jul 2024 11:09:06 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, Peter Maydell <peter.maydell@linaro.org>,
 Kyle Evans <kevans@freebsd.org>, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 10/14] bsd-user: Hard wire aarch64 to be 4k pages only
Date: Tue, 23 Jul 2024 12:07:21 -0600
Message-ID: <20240723180725.99114-11-imp@bsdimp.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240723180725.99114-1-imp@bsdimp.com>
References: <20240723180725.99114-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::129;
 envelope-from=imp@bsdimp.com; helo=mail-il1-x129.google.com
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


