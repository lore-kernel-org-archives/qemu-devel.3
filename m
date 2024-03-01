Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AC1BC48BF6
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Mar 2024 02:30:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfseU-00040Q-9d; Thu, 29 Feb 2024 21:29:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1rfseS-0003yO-OM
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 21:29:32 -0500
Received: from mail-oo1-xc2c.google.com ([2607:f8b0:4864:20::c2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1rfseR-0005PY-6b
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 21:29:32 -0500
Received: by mail-oo1-xc2c.google.com with SMTP id
 006d021491bc7-59fdcf8ebbcso966597eaf.3
 for <qemu-devel@nongnu.org>; Thu, 29 Feb 2024 18:29:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1709260169; x=1709864969; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9QASZ+kUUj+8Xo1I0M095jiimdEHlGS7QcRB7kGSAjM=;
 b=At3xnI9CynzdhegHkjKGvWF2o2xTfim8N76glp0wRSYl0TsukYLIuMehXiICZUYODI
 X7VRGDT/lJ+i+97H75O8wlFAxHrH6WUxf2tHHFcovyG8YDbrD5gIUMXh20ZqeGl9iD1D
 1IijNsLLDkrjQRRNY07F8A+LIZYXnE3A+EpBcpVqQsJnklutHnvGMkuljA+WxOBdKzYe
 D2GW919s93KnzxWB9F32yTcAKfmW7rS6l3YpcssjEfjNtl9g5c5hHg6RYdCJ+dUpC04U
 6SDmcOpChxn+Xd7RTcNVts24Y5Xqc3HfXOr8PlxOPHcB2wX/ta1O7qaUjw8hI1Su7HT9
 GcVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709260169; x=1709864969;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9QASZ+kUUj+8Xo1I0M095jiimdEHlGS7QcRB7kGSAjM=;
 b=pHs7H4m3ZaLjXDimcKJTRTTATEmc/jpRyF++0BLxsFB3AEi8wvEuEhRFN0TgnzT+VP
 EXiM/4nRQVh9r4g+iRrPzYHFhTXGp2cQ5vuFaNaCQDOC/LcQqRL93lKZp5CAegenxwa3
 UVe/noHTDwvEHPFhIQyj0m+lsBV9k8Qp70/bAieiBq50SQNGpCa/zPgyG+wRazLg/ds9
 ZwO1guLIgl4VCWD4cwZNuH0oEsNx/Qd6T4XooduZSSI3ezUiHOycRL+b3l26wrqURBkx
 DbMCURNE1KBBFozWLr0Vs8Gc3AUXV+Ck2kmUSCvYcmExIcpxnznFBydu1Al+D2/zeyST
 dYMw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXuLLF5VXzzKSKisvyrj5ENKnEoaNQe83j4B0Qe2XSJaxWPfg+41+eOuYfM38xco/85ButT73WVTcFAPKqRmG1PtXEfRgs=
X-Gm-Message-State: AOJu0YxkaoTAkl0lBWrC3vdAflAeE5IMq5iis+lvRnVgtfgJDjS3usXS
 ljLjKj5q3dNQrM8PE+uosfSqegiOjakTvCXaZKI9ov1ypFegmrCQpZlZGahBBuY=
X-Google-Smtp-Source: AGHT+IHCUMJESzCLFs5UxLwPYWIGP8OUZsg6oDToiPo7NJOAwQ4Jm0UUY3ZFp2VGaZ1igCC6/JhJuw==
X-Received: by 2002:a05:6359:4117:b0:17b:ef19:ee7d with SMTP id
 kh23-20020a056359411700b0017bef19ee7dmr354422rwc.26.1709260169160; 
 Thu, 29 Feb 2024 18:29:29 -0800 (PST)
Received: from n231-230-216.byted.org ([130.44.212.120])
 by smtp.gmail.com with ESMTPSA id
 qo13-20020a056214590d00b0068d11cf887bsm1384107qvb.55.2024.02.29.18.29.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Feb 2024 18:29:28 -0800 (PST)
From: Hao Xiang <hao.xiang@bytedance.com>
To: pbonzini@redhat.com, berrange@redhat.com, eduardo@habkost.net,
 peterx@redhat.com, farosas@suse.de, eblake@redhat.com, armbru@redhat.com,
 thuth@redhat.com, lvivier@redhat.com, jdenemar@redhat.com,
 marcel.apfelbaum@gmail.com, philmd@linaro.org, wangyanan55@huawei.com,
 qemu-devel@nongnu.org
Cc: Hao Xiang <hao.xiang@bytedance.com>
Subject: [PATCH v4 4/7] migration/multifd: Enable multifd zero page checking
 by default.
Date: Fri,  1 Mar 2024 02:28:26 +0000
Message-Id: <20240301022829.3390548-5-hao.xiang@bytedance.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240301022829.3390548-1-hao.xiang@bytedance.com>
References: <20240301022829.3390548-1-hao.xiang@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2c;
 envelope-from=hao.xiang@bytedance.com; helo=mail-oo1-xc2c.google.com
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

Set default "zero-page-detection" option to "multifd". Now zero page
checking can be done in the multifd threads and this becomes the
default configuration. We still provide backward compatibility
where zero page checking is done from the migration main thread.

Signed-off-by: Hao Xiang <hao.xiang@bytedance.com>
---
 migration/options.c | 2 +-
 qapi/migration.json | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/migration/options.c b/migration/options.c
index 3c603391b0..3c79b6ccd4 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -181,7 +181,7 @@ Property migration_properties[] = {
                       MIG_MODE_NORMAL),
     DEFINE_PROP_ZERO_PAGE_DETECTION("zero-page-detection", MigrationState,
                        parameters.zero_page_detection,
-                       ZERO_PAGE_DETECTION_LEGACY),
+                       ZERO_PAGE_DETECTION_MULTIFD),
 
     /* Migration capabilities */
     DEFINE_PROP_MIG_CAP("x-xbzrle", MIGRATION_CAPABILITY_XBZRLE),
diff --git a/qapi/migration.json b/qapi/migration.json
index 846d0411d5..ca9561fbf1 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -903,7 +903,7 @@
 #        (Since 8.2)
 #
 # @zero-page-detection: Whether and how to detect zero pages.
-#     See description in @ZeroPageDetection.  Default is 'legacy'.
+#     See description in @ZeroPageDetection.  Default is 'multifd'.
 #     (since 9.0)
 #
 # Features:
@@ -1100,7 +1100,7 @@
 #        (Since 8.2)
 #
 # @zero-page-detection: Whether and how to detect zero pages.
-#     See description in @ZeroPageDetection.  Default is 'legacy'.
+#     See description in @ZeroPageDetection.  Default is 'multifd'.
 #     (since 9.0)
 #
 # Features:
@@ -1333,7 +1333,7 @@
 #        (Since 8.2)
 #
 # @zero-page-detection: Whether and how to detect zero pages.
-#     See description in @ZeroPageDetection.  Default is 'legacy'.
+#     See description in @ZeroPageDetection.  Default is 'multifd'.
 #     (since 9.0)
 #
 # Features:
-- 
2.30.2


