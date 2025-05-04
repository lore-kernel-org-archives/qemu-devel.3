Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17D6DC369DC
	for <qemu-devel@archiver.kernel.org>; Sun,  4 May 2025 21:59:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBhLO-0007SN-5F; Sun, 04 May 2025 17:57:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uBhLL-0007QM-Iy
 for qemu-devel@nongnu.org; Sun, 04 May 2025 17:57:51 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uBhLK-0005BL-16
 for qemu-devel@nongnu.org; Sun, 04 May 2025 17:57:51 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-22c336fcdaaso42788485ad.3
 for <qemu-devel@nongnu.org>; Sun, 04 May 2025 14:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746395868; x=1747000668; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=56ybfnwzUbGIYEktCHIqmHOykTepTgv6Xlf9ny+yrcs=;
 b=Rh7ExY9fsx2UUMBh8pkC/L8n8hCJzjABBmGurLSwrVwpIdPravJusqbAlKXarfVI0v
 SorkEj3mzc1UM4deIB5zKIEuA3e3TBBiYOTWSvjLVROQR6zdrcJpVGznM26Fq6upFUE+
 Hpia/2hunK1aGwYI2zt1xl8r9WtLT2vCtSFo6CYfTqoVZWMY9z3poDeYBpWChGlcnAGc
 p/L7TxweVy4m7L179lxxGZuPKHTX810DfircD7k6ZaNq121bGafcyd2T/jd6GlzSMke4
 fUec6mEs9OMrOQmajmbQKcfxOtbW8rPjLdnbCDaZclolqvi22I9q63eXxs7QBwPyd8Kr
 kM2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746395868; x=1747000668;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=56ybfnwzUbGIYEktCHIqmHOykTepTgv6Xlf9ny+yrcs=;
 b=JZ4hII7qcMDq0JCXrBBcVIa0wZA3Qq5HcYyXFpMSFH4l2n3OCz6YSlPd/I+CBCvfwO
 nyw2Aotr1mGkayXJ2XC/Vf96zfJpWltSZZeVqo2R3ZPqW/To/GxiBkPIv8N9m17ygWvV
 L+cu1WPhyTj57Um035Ywh2u1A2Lj63lpmBQjIuRwlboPRWgkJmkretoAiKa4p7iOxZ91
 d5aL20W1oOkDkXmlYQ1uITs1wvo/lqIVS0fUg/QQDUV3HxQdgGKHLKpkwC5H7V78j6AD
 fro520ox4fLWFu9X+bAQ8hmG9RKz9L+WlZzIKgI/LgzMhrB+c+Qtt/gQU9NEK9JEtBvY
 5ORA==
X-Gm-Message-State: AOJu0YxZKqv/ay0F7Ewb8UJYbFfJ65o8lV3KmEo9upPZiEPu6W8OR/Uv
 PLIzKn6bEoYpNKe2B09Xeszg0U9beNw8FCbFUMR5ViKACVzM9nlRS2x4LIsavAPFGx0qShtEROO
 w5VQ=
X-Gm-Gg: ASbGncvMJtk60BvvdZunoQEo1M6E+/1lmNslHmsYmtcG7h8nIH9gtNeAhp05E78/f8Z
 EKb+uELwKj7/BWTo0VMJCp3b01DTTLw3mv73ygH/MV39N9Jha4RChZClY9SGyjDe+Vkv89ffEAG
 stk4ggP1odhQ9ivT2vZYpccLfnxX5oxAd/TvRefCktOYzRjexEHgUqsvGjRSHLp3Er7wBpJGltG
 cv9wbcr1BILQd/6E9TUuQvejXQTN5Dq61m35jo92vZXWuC4o4wzUIAQZnuQaQkm6a+SZYwd8UpE
 6c/YFjifLIJp62SP2vPzTEjjeAc6Zaplw/04XdKMwwFmhww7YwRilhmCxlM=
X-Google-Smtp-Source: AGHT+IHVPC4FyzJd0HAZEcXwZiKDeTCdiv/lusHXrf+t9gii4gUOEAFX9IdMsS6N6mTKZEpEIIVhiQ==
X-Received: by 2002:a17:902:d543:b0:21f:85af:4bbf with SMTP id
 d9443c01a7336-22e1e8f569bmr70470725ad.20.1746395868242; 
 Sun, 04 May 2025 14:57:48 -0700 (PDT)
Received: from gromero0.. ([200.150.181.215]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22e152204fesm41664875ad.137.2025.05.04.14.57.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 May 2025 14:57:47 -0700 (PDT)
From: Gustavo Romero <gustavo.romero@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, philmd@linaro.org, alex.bennee@linaro.org,
 gustavo.romero@linaro.org
Subject: [PATCH] hw/net/e1000: Remove stray empty comment in header
Date: Sun,  4 May 2025 21:56:32 +0000
Message-Id: <20250504215639.54860-4-gustavo.romero@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pl1-x62c.google.com
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

In the header file, remove a stray empty comment in the Offload Context
Descriptor struct.

Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
---
 hw/net/e1000x_regs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/net/e1000x_regs.h b/hw/net/e1000x_regs.h
index cd896fc0ca..e9a74de6f4 100644
--- a/hw/net/e1000x_regs.h
+++ b/hw/net/e1000x_regs.h
@@ -900,7 +900,7 @@ struct e1000_context_desc {
             uint16_t tucse;     /* TCP checksum end */
         } tcp_fields;
     } upper_setup;
-    uint32_t cmd_and_length;    /* */
+    uint32_t cmd_and_length;
     union {
         uint32_t data;
         struct {
-- 
2.34.1


