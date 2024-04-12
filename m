Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C58E6C41513
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2024 07:34:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rvBQF-00072G-1z; Fri, 12 Apr 2024 03:34:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rvBQ5-0006zQ-0U
 for qemu-devel@nongnu.org; Fri, 12 Apr 2024 03:33:57 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rvBQ3-00077c-Cd
 for qemu-devel@nongnu.org; Fri, 12 Apr 2024 03:33:56 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-6ecee5c08e6so678885b3a.3
 for <qemu-devel@nongnu.org>; Fri, 12 Apr 2024 00:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712907234; x=1713512034; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7ZOZ2GpOHx19JGGX2PLqgY++2k2pqd50fzr6oa/q3CU=;
 b=znqmiNVrFi4ywHzeFmQIarTlblzjn7NzQwUZMZEJ0VvKzavwAn+dgfvC4I9BFNi6UC
 2JmL0I9UnASgsccFyL7cz1P9vql2I7BCS6gf6ncE/pB3Znpj+wFTVq4ep+ULhaHgHT+O
 GqJdo65emWbjeyQPCWoXXr/iw3PAazHOigIF3l4p3+dzhVV7Tn8e7ZxH7GheUmFb0pnV
 CHmD4r0b8UjiVZR25enm8Yr583pmlr7vyVSz/wnjKU+vetSgKv2VIeRLvRz+ynnegESe
 dJ3SQ1a9K+z1kMP4OiqfH0XX/WTW8RFpIB5ZCyjsxhiwJWNEJ3iHxNOeYsLFjN3Q74sj
 h4OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712907234; x=1713512034;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7ZOZ2GpOHx19JGGX2PLqgY++2k2pqd50fzr6oa/q3CU=;
 b=c40jbfhoYCBASNCeSULZ94yl8ow40MMf+zS37ag82hMsxhrCGgZTqSKBU5vQTBIuEj
 wC2oQZz3DkyDFPLP/Ho2ZE4MYT/18/Sb7Bd+T0tR3Akfz1roWg69o88AQ+9CfIABy0D2
 /e19Wi9fGLtsURNeAcqJUqGDsSbh91VwkkQUawdbFxT3MnIfYER4qHE262MWXBnzHjS8
 97bE5DHKcSkpQDSRTnPu1YmBKoqkeE8+MiFd0gsmfsQwVTMNny/WjVD/rKaJAApdeGNx
 tR3soCWEeOydZlOoezNkbZMkaHfK6pjVO3Y/ymU3vjoB81avKjSgIMFFJhex8KC+9Qj2
 WudA==
X-Gm-Message-State: AOJu0YygnwAEKIU914vJkxJ69SbeEymbK7sddwTf215ialpX+yVVHF5d
 3MHyEz19tG6Z7BMH3T3pTWUimjBSpg3jUg3ZqztRETimRWKggFYZZEjUmOwT6+D8bWb9cAnx6TR
 Y
X-Google-Smtp-Source: AGHT+IF4hK5KeYcySNx2BTTIdwfYvcWhcY1vOBmicawSMj+BPgoo3a5mSDkZvImdkg/v/GtOUBJUjw==
X-Received: by 2002:a05:6a20:2591:b0:1a9:5136:13ba with SMTP id
 k17-20020a056a20259100b001a9513613bamr2713325pzd.14.1712907234026; 
 Fri, 12 Apr 2024 00:33:54 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 e5-20020a17090301c500b001e556734814sm2206099plh.134.2024.04.12.00.33.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Apr 2024 00:33:53 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 08/27] hw/scsi/scsi-disk: Use qemu_hexdump_line to avoid
 sprintf
Date: Fri, 12 Apr 2024 00:33:27 -0700
Message-Id: <20240412073346.458116-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240412073346.458116-1-richard.henderson@linaro.org>
References: <20240412073346.458116-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

sprintf() is deprecated on Darwin since macOS 13.0 / XCode 14.1.
Using qemu_hexdump_line both fixes the deprecation warning and
simplifies the code base.

Note that this drops the "0x" prefix to every byte, which should
be of no consequence to tracing.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/scsi/scsi-disk.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
index 4bd7af9d0c..f386a2f01c 100644
--- a/hw/scsi/scsi-disk.c
+++ b/hw/scsi/scsi-disk.c
@@ -2648,19 +2648,12 @@ static const SCSIReqOps *const scsi_disk_reqops_dispatch[256] = {
 
 static void scsi_disk_new_request_dump(uint32_t lun, uint32_t tag, uint8_t *buf)
 {
-    int i;
     int len = scsi_cdb_length(buf);
-    char *line_buffer, *p;
+    g_autoptr(GString) str = NULL;
 
     assert(len > 0 && len <= 16);
-    line_buffer = g_malloc(len * 5 + 1);
-
-    for (i = 0, p = line_buffer; i < len; i++) {
-        p += sprintf(p, " 0x%02x", buf[i]);
-    }
-    trace_scsi_disk_new_request(lun, tag, line_buffer);
-
-    g_free(line_buffer);
+    str = qemu_hexdump_line(NULL, buf, len, 1, 0);
+    trace_scsi_disk_new_request(lun, tag, str->str);
 }
 
 static SCSIRequest *scsi_new_request(SCSIDevice *d, uint32_t tag, uint32_t lun,
-- 
2.34.1


