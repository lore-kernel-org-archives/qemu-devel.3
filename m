Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BEB5E67482
	for <qemu-devel@archiver.kernel.org>; Sun, 21 Dec 2025 14:24:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vXKLK-0000yQ-Oi; Sun, 21 Dec 2025 09:23:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <soumyajyotisarkar23@gmail.com>)
 id 1vXKLJ-0000xu-7P
 for qemu-devel@nongnu.org; Sun, 21 Dec 2025 09:23:29 -0500
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <soumyajyotisarkar23@gmail.com>)
 id 1vXKLH-0001HH-SJ
 for qemu-devel@nongnu.org; Sun, 21 Dec 2025 09:23:28 -0500
Received: by mail-pf1-x443.google.com with SMTP id
 d2e1a72fcca58-7f0db5700b2so2925864b3a.0
 for <qemu-devel@nongnu.org>; Sun, 21 Dec 2025 06:23:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1766327006; x=1766931806; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BU0OmwMUtLRHOgUboEg+bahM1H9b5s2L6i2Kd1bJBh0=;
 b=GfLa3FFW1jO/kJy45MnD2CFmRWIqdLoxWL+0vSuZxGvwSsVT61MPBRGSkQ23aphlu5
 +10FKOVBGzZ2bUx2BHMyyC09CWf4ALF897Rd17A4XY9RyxFVrms+0kKzoQXNUnU/F5BQ
 M/P8xkGOxlXTcjDNkJuONAAdeEEwYpNapf8xG16rfar8L214ojuFJtZpGpkuI/7Cqt/l
 /aqbIhgoEjU7/nh7E3WPANnfC2EVu/LcHB+Y1jjMJVW6JalTbn95pDZn22yQDXgzh1VU
 NzhGBtljO5U8cjV0D9QkNkIEGFz8NlUj5XVhYku4zgQhv8lnaUj6peGXo0x0B4AulHwM
 eW1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766327006; x=1766931806;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BU0OmwMUtLRHOgUboEg+bahM1H9b5s2L6i2Kd1bJBh0=;
 b=JWnOVL9foYwfi9/UWb5XD0P9sOhy8+3dqfm/iEJ3S5FiLdCFPKsQF8ZS2KcubvQ4SI
 WJIj9JxLgNltyAxdjERChAVigmSNHjP31G+mnjVELmNpgfzPt7M4EL4CdUb12WYcgiBL
 9CMubbKupzafOWXZwvvv9QD9lRX6T7QL90hRgYsSts2conduJPqtmSTbC2T1nrPyzdX3
 jM6NNa1Heof8BkVYIBkdHl3woboiYYvfJWSmGgpKMUXcoIlVXrBtL6Bak3kvf0STMOg0
 3I9YTV0px+9LJD1fADzIVbelYnaDSBsryDzoQqzYcQk/6wQU8nsSraPYiru6ilhtskT0
 vX8g==
X-Gm-Message-State: AOJu0Yz5yPlWZ6DfCLOnmr5HMpXcHTgxOqXvrQktCSDCrVED5FRG0G3i
 iU5/YDns18ARBYhTjDW/7os9/J2whKSIPsak/XE2i25w+JB8iir0r+y9OQdHz//NZ8M=
X-Gm-Gg: AY/fxX5cnno5z26daFPuX/1qZU4blH1HoiMu4OODN5c32hagaW8uC/QJXdKyyyLM0jP
 K/2h4+8d6M/c/dqeTJxqGoKV6qKQv203loNp48uDnLccZInR6+87f+nORZneVUNjjMPxVsca9Na
 3t5frmceodyWNm5tF5syfZoN/z5a6Z22aHHVf96uFhibvqxWK68cm/oJ0tdWMIU8MYVaSuuQoxm
 XdCPpRPhU6LwnzMcVymQqdxnLhDLiQtM5vUxfKsSszb/K1CiytBKfJRcHTNTtLwkfpX27p4ife9
 g5GYbCx7huITDvD4YfQZ/s0HPfA+DOryQSRfIQiqOLsj492XnSUpq4ckeIvz7aw/+qQSusP1NB4
 vNRnVMhQBO4Vy801+1jkH7BCm+FNALwff0h6+QWuaQlMfXR6iwTIi+MCNl82taYeRLSPjRr/ZTf
 6SDNYfvtOV4U+oWXDYEu8=
X-Google-Smtp-Source: AGHT+IEb/Mt4ckukNcGnYaloX47doF7ZK15R/8y8FTB6MtG6vJdVxRIxKLbdSH9LkstE+0nLd5tgeg==
X-Received: by 2002:a05:6a00:e11:b0:7b8:8d43:fcd1 with SMTP id
 d2e1a72fcca58-7ff64215183mr6682163b3a.9.1766327006096; 
 Sun, 21 Dec 2025 06:23:26 -0800 (PST)
Received: from fedora.. ([118.151.210.82]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7ff7e48f258sm7590449b3a.47.2025.12.21.06.23.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 21 Dec 2025 06:23:25 -0800 (PST)
From: Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>
To: qemu-devel@nongnu.org, deller@gmx.de, sarkarsoumyajyoti23@gmail.com,
 mark.cave-ayland@ilande.co.uk, richard.henderson@linaro.org
Cc: Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>
Subject: [PATCH 01/10] scsi:ncr710: Add null pointer checks
Date: Sun, 21 Dec 2025 19:53:08 +0530
Message-ID: <20251221142317.266293-2-soumyajyotisarkar23@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251221142317.266293-1-soumyajyotisarkar23@gmail.com>
References: <20251221142317.266293-1-soumyajyotisarkar23@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::443;
 envelope-from=soumyajyotisarkar23@gmail.com; helo=mail-pf1-x443.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

Add nullpointer safety checks in ncr710_request_free() &
ncr710_request_cancelled() to prevent crashed while handing invalid req
structures

Added to preventing memory corruption, which occured during device
initialization

Signed-off-by: Soumyajyotii Ssarkar<soumyajyotisarkar23@gmail.com>
---
 hw/scsi/ncr53c710.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/hw/scsi/ncr53c710.c b/hw/scsi/ncr53c710.c
index 47a6983491..bab2ea7210 100644
--- a/hw/scsi/ncr53c710.c
+++ b/hw/scsi/ncr53c710.c
@@ -737,6 +737,12 @@ static void ncr710_add_msg_byte(NCR710State *s, uint8_t data)
 
 static void ncr710_request_free(NCR710State *s, NCR710Request *p)
 {
+    if (!p) {
+        return;
+    }
+    if (p->req && p->req->hba_private == p) {
+        p->req->hba_private = NULL;
+    }
     if (p == s->current) {
         s->current = NULL;
     }
@@ -747,8 +753,11 @@ void ncr710_request_cancelled(SCSIRequest *req)
 {
     NCR710State *s = ncr710_from_scsi_bus(req->bus);
     NCR710Request *p = (NCR710Request *)req->hba_private;
-    req->hba_private = NULL;
-    ncr710_request_free(s, p);
+    if (p) {
+        req->hba_private = NULL;
+        p->req = NULL;
+        ncr710_request_free(s, p);
+    }
     scsi_req_unref(req);
 }
 
-- 
2.49.0


