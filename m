Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0767C3064D
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2024 19:51:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMYen-0007JR-T9; Wed, 26 Jun 2024 15:50:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sMYem-0007JA-I2
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 15:50:16 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sMYeb-0002gl-2c
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 15:50:15 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1f9cd92b146so55801295ad.3
 for <qemu-devel@nongnu.org>; Wed, 26 Jun 2024 12:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719431393; x=1720036193; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DfnhjluiI4IZZVonHBRb763w0QLa0hN07g2FgRNiqJE=;
 b=z0O4ucgmJMWI/vMHYTu/CKbp8qIlPSlWFrtX3TM/ioZCUgBCbQ9UztUP7+QFhLdOEn
 ly62gQOOpTmFp6kx08FNmgx2C4iLUmzDCFBXwAY4SsM7HLkYzBolj+i+xEVJ8xl0977y
 P4W9bDLw98d//hPWmLMzV85ZFH+m+9gwkzbJW7xyx0YMyFiIw6HKXwtaKBfJGv8WVrDa
 eOu9DdrGs5LGShqEJOBw+oJFwqymmVgxzBG3RXSHoDgZ4cbKVtIoj75oHDTswam9+GGv
 QIAvTFXA5qU8M9mMvDSbqY1DTabe7vL+GsYU+qYe+Y3GV4qh6ygatNCoF3CY1v2Lbvaw
 bFDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719431393; x=1720036193;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DfnhjluiI4IZZVonHBRb763w0QLa0hN07g2FgRNiqJE=;
 b=PLG65TOTiLsjJStMBfpIAlLxUak0B+An0Chf9bNuLNHhfsNk0OQvah0g96LLK+g4AC
 BVyzK/MTfUsyAZKvfEL0io5kZu119oPszsZQOWU+qrXmgQzn+/Gc9srXIpnvkEHS/lO+
 sDccEu+HsWc1ykus6/gyZa7O2HqQ9GSczLQpFMzATGfDPQ+gjfEt92SQn+ofCltmcsqW
 H+VAIzCy+HH3hEXNFIfV53WOMJEfdSJ2LY+z5BtIYG4TESsRRCAAQdAmbcGCW1932y7y
 96p/vPSHo7FEHjqJKjVwmGS5D7CIfcPmW+iSKowePSSCtKnAzd8BXu8nt7Z0B1ftzy50
 zm/w==
X-Gm-Message-State: AOJu0YxO1eCrGB3/7Y/lHYK8qvNTBtTUR5V3O3jXDe6HjPV3+6h/o/Gj
 AeZYPDxsC3M59rPNcvgeJ7fMvq4XFQjaRRptkYOniMI0y7OUOyX2qKLcNuxh4xlXNTKTq0KtoAq
 A
X-Google-Smtp-Source: AGHT+IE5MnfGTGxsYJD6CJdp/lbYK4ez12HBxUkqgllB0mlDVn0vPYDJmNM5mwnA2smGrkXBMXYHqw==
X-Received: by 2002:a17:902:dac7:b0:1f9:a8c5:a288 with SMTP id
 d9443c01a7336-1fa1d62183amr143225975ad.37.1719431392818; 
 Wed, 26 Jun 2024 12:49:52 -0700 (PDT)
Received: from stoup.. (174-21-76-141.tukw.qwest.net. [174.21.76.141])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f9eb2f0318sm103734625ad.2.2024.06.26.12.49.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Jun 2024 12:49:52 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, alex.bennee@linaro.org, berrange@redhat.com,
 philmd@linaro.org
Subject: [PATCH 1/3] target/i386/sev: Cast id_auth_uaddr through uintptr_t
Date: Wed, 26 Jun 2024 12:49:48 -0700
Message-Id: <20240626194950.1725800-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240626194950.1725800-1-richard.henderson@linaro.org>
References: <20240626194950.1725800-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

This member is __u64 in the kernel structure.
Cast via uintptr_t to match the host's pointer size.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/i386/sev.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/target/i386/sev.c b/target/i386/sev.c
index 30b83f1d77..9dfdac69ab 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -2171,13 +2171,13 @@ sev_snp_guest_set_id_block(Object *obj, const char *value, Error **errp)
 
     finish->id_block_en = 0;
     g_free(sev_snp_guest->id_block);
-    g_free((guchar *)finish->id_block_uaddr);
+    g_free((void *)(uintptr_t)finish->id_block_uaddr);
 
     /* store the base64 str so we don't need to re-encode in getter */
     sev_snp_guest->id_block = g_strdup(value);
 
     finish->id_block_uaddr =
-        (uint64_t)qbase64_decode(sev_snp_guest->id_block, -1, &len, errp);
+        (uintptr_t)qbase64_decode(sev_snp_guest->id_block, -1, &len, errp);
 
     if (!finish->id_block_uaddr) {
         return;
@@ -2208,13 +2208,13 @@ sev_snp_guest_set_id_auth(Object *obj, const char *value, Error **errp)
     gsize len;
 
     g_free(sev_snp_guest->id_auth);
-    g_free((guchar *)finish->id_auth_uaddr);
+    g_free((void *)(uintptr_t)finish->id_auth_uaddr);
 
     /* store the base64 str so we don't need to re-encode in getter */
     sev_snp_guest->id_auth = g_strdup(value);
 
     finish->id_auth_uaddr =
-        (uint64_t)qbase64_decode(sev_snp_guest->id_auth, -1, &len, errp);
+        (uintptr_t)qbase64_decode(sev_snp_guest->id_auth, -1, &len, errp);
 
     if (!finish->id_auth_uaddr) {
         return;
-- 
2.34.1


