Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10FE9C3DA6A
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2024 13:23:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUR44-0001Cx-3r; Thu, 18 Jul 2024 09:20:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sUR3n-00087O-7U
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 09:20:40 -0400
Received: from mail-lj1-x236.google.com ([2a00:1450:4864:20::236])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sUR3k-0004Tu-UC
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 09:20:38 -0400
Received: by mail-lj1-x236.google.com with SMTP id
 38308e7fff4ca-2eeb1051360so9681751fa.0
 for <qemu-devel@nongnu.org>; Thu, 18 Jul 2024 06:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721308835; x=1721913635; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ycUSfPxeZiE10T7Yl9GNK03Kd/Z6QrsxLJrBkHZa9cQ=;
 b=ONyu/4QlJR0LIPxZRLRAbRT0xL14BV4lKsouSKPjhzato+ksdG3KsUIE0PDhRZZSpu
 igHBN0lSzmUgYWZjTcTIChJVg0F+dhGESuVoM5KoELFYySpvz5qF8jyKC19QGsxZvKFH
 HYU+c5DmFAXCVxrsjCxgcnPWJfpBCnoFmVsHxi9gBoJ0QwB3K0JO3RyhgiUEyPxdPTKB
 BoYtaHQRCiDl2tuwSh/QAgS3Ct7OqvzCJSBxHLz4b0koKq57P+KX1LGVtlKEkSmfK7aW
 VtfFku/H5AbvhaocbPziFwb9TdMW+7DKzbccAIujRn06ZKxdeWKmE5bz15OqCGUt6Fqf
 Daww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721308835; x=1721913635;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ycUSfPxeZiE10T7Yl9GNK03Kd/Z6QrsxLJrBkHZa9cQ=;
 b=Y4clY3izNBgp+6rAgfzAOb2QOBjsU2lM7cda8R12ZR3zNm7lAiVTcEe1KJSxzZucIU
 7jJZ6CoGxRt4pzRENqPfBbrhSp4fsp5n23sjVjJISoDFAtX+9EUX+Dirx0A81yx9WPV4
 wYWynpWn5U83ECz3IRAmaMWtO8nx5jnFIKvvcP774ZZi2ICxMfiXEooHXWfdV8GRr9YS
 FCmHYnZmn7vyVgIIpN3txKQRP0rLkBI4tX8zKMtOPzHb++amh7+YmyCjD+A9PDYzjZz2
 JnrjJaKxa1DtyKatSllE8PHH0OD9QVa5WCqvcoYPSxjKbDlHaFVMVgiuYDtcIP8Q8CGd
 a0kw==
X-Gm-Message-State: AOJu0YwH7sY6Oj7TxDkCvRA7f3rgHVsiojCci39asoHBh0+ycjP2nHlJ
 /Zkr5CP43XYbk2LvnRN3PgrnEWXZwULIVlvCkB+wSblr4uLhGkCMxo+MJ8WXluWjnkFfWRQtDR6
 S
X-Google-Smtp-Source: AGHT+IFfEwO0aeb6EwFvVVFZ/5CtU8pNCPE9TvJKx5wRGVYv+gdeHjRW9gqBcCGNV9tsteLFCCqXHQ==
X-Received: by 2002:a2e:909a:0:b0:2ec:1810:e50a with SMTP id
 38308e7fff4ca-2ef05d25f33mr16399411fa.32.1721308835241; 
 Thu, 18 Jul 2024 06:20:35 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427d2a8e420sm14059315e9.35.2024.07.18.06.20.34
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jul 2024 06:20:34 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 10/26] hw/arm/smmu: Introduce CACHED_ENTRY_TO_ADDR
Date: Thu, 18 Jul 2024 14:20:12 +0100
Message-Id: <20240718132028.697927-11-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240718132028.697927-1-peter.maydell@linaro.org>
References: <20240718132028.697927-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::236;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x236.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Mostafa Saleh <smostafa@google.com>

Soon, smmuv3_do_translate() will be used to translate the CD and the
TTBx, instead of re-writting the same logic to convert the returned
cached entry to an address, add a new macro CACHED_ENTRY_TO_ADDR.

Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Mostafa Saleh <smostafa@google.com>
Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Message-id: 20240715084519.1189624-8-smostafa@google.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/smmu-common.h | 3 +++
 hw/arm/smmuv3.c              | 3 +--
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/hw/arm/smmu-common.h b/include/hw/arm/smmu-common.h
index 5cb30244646..f793b54388d 100644
--- a/include/hw/arm/smmu-common.h
+++ b/include/hw/arm/smmu-common.h
@@ -37,6 +37,9 @@
 #define VMSA_IDXMSK(isz, strd, lvl)         ((1ULL << \
                                              VMSA_BIT_LVL(isz, strd, lvl)) - 1)
 
+#define CACHED_ENTRY_TO_ADDR(ent, addr)      ((ent)->entry.translated_addr + \
+                                             ((addr) & (ent)->entry.addr_mask))
+
 /*
  * Page table walk error types
  */
diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index e71b842162a..dc63e07d683 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -951,8 +951,7 @@ epilogue:
     switch (status) {
     case SMMU_TRANS_SUCCESS:
         entry.perm = cached_entry->entry.perm;
-        entry.translated_addr = cached_entry->entry.translated_addr +
-                                    (addr & cached_entry->entry.addr_mask);
+        entry.translated_addr = CACHED_ENTRY_TO_ADDR(cached_entry, addr);
         entry.addr_mask = cached_entry->entry.addr_mask;
         trace_smmuv3_translate_success(mr->parent_obj.name, sid, addr,
                                        entry.translated_addr, entry.perm,
-- 
2.34.1


