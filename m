Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1949E7718B
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jan 2025 08:02:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tStfe-0001tm-6m; Wed, 01 Jan 2025 03:01:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1tStfd-0001tJ-0T
 for qemu-devel@nongnu.org; Wed, 01 Jan 2025 03:01:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1tStfb-0002fp-IZ
 for qemu-devel@nongnu.org; Wed, 01 Jan 2025 03:01:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1735718493;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=FnZjgfMp2hnZzssqi/eKxK96bf9FbqeXP5z6jyJrV9E=;
 b=SnQga9XnM77FoFwvvnzOJ/CSZiqJ4zI8ZEyXqBTQfpwrUuGMuucY6K3+tTqR0Q2qn1ZZwS
 a9P52lxYlfNcwZu5josfq+X33fr8Qn8CBVCh03SBCWWM+xeHPbV7O/wwVum23QKLoUO3Qq
 XNa1J4h62fNge7iV2Tw8Vz+e4KRoZE4=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-416-Ac6cFFISN5WQh3v3_z7tYQ-1; Wed, 01 Jan 2025 03:01:32 -0500
X-MC-Unique: Ac6cFFISN5WQh3v3_z7tYQ-1
X-Mimecast-MFC-AGG-ID: Ac6cFFISN5WQh3v3_z7tYQ
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-2f2a9743093so14655583a91.3
 for <qemu-devel@nongnu.org>; Wed, 01 Jan 2025 00:01:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735718491; x=1736323291;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FnZjgfMp2hnZzssqi/eKxK96bf9FbqeXP5z6jyJrV9E=;
 b=UVuQ+u1jcFTg2um9NRxy8N6wQL3Xw67BFlUuudZEuUOnq72M95hdfKRbRoGVeyV9B+
 q5aH0TbcRqTBxE2nkWYeYa7SS62DhvPYp/TpebDe9+qbhk3M8WkJ16Sr8XZLL58kCIby
 YDx0YcRqvMSGSoCB03wFR8LaHe5/Cpo1FZ8JLc0fKQEE5LbIjkVvdc3TZuyNALwRwUmI
 ymmk7MEBzwZIZ47R9afehIANim6ylhOM6Z+2F0M0Hbk0HqvnGXWp5aIpWMFubvwgzWx8
 jy+3VzM+QtkCd740iiE0QW/i+v/OTOAGkuevunHHRDEO1zHVFtI2sgtnEQWPmV0crEzQ
 f80Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWfpCs9hsV7FVQsGGsIkhVVvZMJNa+a++vePPX+lsaD9zkj/zTnHZCeKTnsjHB72yK5wmi1vNydfd30@nongnu.org
X-Gm-Message-State: AOJu0YzMG182naWQZV2MzzXTsIqWQjEVHtgV/FA2Gzhy+aDuEjutRtYC
 NSH/znaEB49ICW3DqwC5lqN+HWDL0WOHcmf19FRD093sTqE33VK92ihZT6YKdxiVTzdaERWBnBH
 PiJ6owRDgAoruqMTeMY67JLeAqD0eh3M71JCo5KKlvkWjy5NjeXCJ
X-Gm-Gg: ASbGncto0jhjUDI3YvOjhiLsMenOKU1o54tw1nXBNb/Wbo/4FxS2RL3xM0HFvNeS1zE
 ATcDTkQaveC5kA00jqIBcDCivXhm1dLdVQv1GwMwbr80G+jhdxNnZfir8qFVL/JkGT3XqQy8sRa
 gMdtZeWTgO74icXC1pUHlamissEq0h9UJ9poTu86kl2J064EB7xxTnhjTnOpsmPOCQ83UAJtqyg
 /3tGW7lAn9aL5dFfF1sj3qSfzPWAualVU9I2eAEx/6HlmLDx6iexcnp0Rl9nJZa7/3UfNZU/+Bg
 Gw==
X-Received: by 2002:a17:90a:dfcd:b0:2ee:964e:67ce with SMTP id
 98e67ed59e1d1-2f452dee953mr57154292a91.3.1735718491084; 
 Wed, 01 Jan 2025 00:01:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGVQYOcO0capxlxAA3OcMq/8yY8q3+84XWEOmkIVC0alXpAxuvRiW8iZIJj0KESh9tlt9cBdA==
X-Received: by 2002:a17:90a:dfcd:b0:2ee:964e:67ce with SMTP id
 98e67ed59e1d1-2f452dee953mr57154261a91.3.1735718490644; 
 Wed, 01 Jan 2025 00:01:30 -0800 (PST)
Received: from localhost.localdomain ([115.96.136.4])
 by smtp.googlemail.com with ESMTPSA id
 98e67ed59e1d1-2f4477c852csm23730220a91.22.2025.01.01.00.01.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jan 2025 00:01:29 -0800 (PST)
From: Ani Sinha <anisinha@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Ani Sinha <anisinha@redhat.com>, qemu-trivial@nongnu.org,
 qemu-devel@nongnu.org
Subject: [PATCH] docs: update copyright date to the year 2025
Date: Wed,  1 Jan 2025 13:31:16 +0530
Message-ID: <20250101080116.1050336-1-anisinha@redhat.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.188,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

We are already in January 2025! Update copyright notices.

Cc: peter.maydell@linaro.org
Cc: qemu-trivial@nongnu.org
Signed-off-by: Ani Sinha <anisinha@redhat.com>
---
 docs/conf.py              | 2 +-
 include/qemu/help-texts.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/docs/conf.py b/docs/conf.py
index 164a8ee8b2..31bb9a3789 100644
--- a/docs/conf.py
+++ b/docs/conf.py
@@ -87,7 +87,7 @@
 
 # General information about the project.
 project = u'QEMU'
-copyright = u'2024, The QEMU Project Developers'
+copyright = u'2025, The QEMU Project Developers'
 author = u'The QEMU Project Developers'
 
 # The version info for the project you're documenting, acts as replacement for
diff --git a/include/qemu/help-texts.h b/include/qemu/help-texts.h
index 353ab2ad8b..bc8fab9169 100644
--- a/include/qemu/help-texts.h
+++ b/include/qemu/help-texts.h
@@ -2,7 +2,7 @@
 #define QEMU_HELP_TEXTS_H
 
 /* Copyright string for -version arguments, About dialogs, etc */
-#define QEMU_COPYRIGHT "Copyright (c) 2003-2024 " \
+#define QEMU_COPYRIGHT "Copyright (c) 2003-2025 " \
     "Fabrice Bellard and the QEMU Project developers"
 
 /* Bug reporting information for --help arguments, About dialogs, etc */
-- 
2.45.2


