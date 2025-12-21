Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B991E66886
	for <qemu-devel@archiver.kernel.org>; Sun, 21 Dec 2025 14:23:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vXKLO-00015R-6U; Sun, 21 Dec 2025 09:23:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <soumyajyotisarkar23@gmail.com>)
 id 1vXKLM-00014o-Cc
 for qemu-devel@nongnu.org; Sun, 21 Dec 2025 09:23:32 -0500
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <soumyajyotisarkar23@gmail.com>)
 id 1vXKLK-0001HW-Sr
 for qemu-devel@nongnu.org; Sun, 21 Dec 2025 09:23:32 -0500
Received: by mail-pf1-x444.google.com with SMTP id
 d2e1a72fcca58-7d26a7e5639so3714969b3a.1
 for <qemu-devel@nongnu.org>; Sun, 21 Dec 2025 06:23:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1766327009; x=1766931809; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/eB1+81UReGK+nNy3DtIGogDj+pIktgWVFbWnsrHTFk=;
 b=OpJDWjI+WK9dgrfYkizVtcPg1MmFMdvauTysG3up6Y20NgESdG4ldz8SyD+KThQ/HB
 PbK3iBu/bw7UP39aFHm6q9XeTvAAbKFO/kkq764/j56cSxBiVEeUVhKWEAXZw7OmkO6w
 51dS3MEufOA49KfSW75rB5JRqMSSksV9hgAwHidLMfPO7GyCRcceNBP60nYai0MB4fDt
 m9XcMAwSXjooeke7gG4zQIqHmZhrWvMMA0lgRlY/VBUSA2lKnQg75Vhmry+AP9qqwsc6
 xfYqMQeeA4wS6pyAoCUhA8yZ0UqnkbViHOYShy+HbDz0SqWoWEQVtc/ftSaTxCeQkjUF
 CsZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766327009; x=1766931809;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/eB1+81UReGK+nNy3DtIGogDj+pIktgWVFbWnsrHTFk=;
 b=o8d7IyePiniLrgmJskg25p+8L9NbmC5dbQlU/O1N19sr2OcPSDcIL4S+N7W9Wv4LgS
 9smn1cTcwsZWlawqzc1qAkavIAwhkI/kIFjEcDs3Oz1UcI0DkWs05GAEVCq86HkHHMiA
 pFJy+GaLH1bTdHyd1dvIfP084ApYddtjvAaUTFMy9wSkeSj4BypDcZxnqc9YbiR5wPwa
 fL41wWLPfgjIYzj+jm8zEWToVzmtHrsG+gotOlUP4rtd0kgnx0OMpWnPaXDJ/ywzMCH/
 iTbhNsYZhwAnY3Ckoyee0cQEpUTHCAZY3uA3iPTxDXSUUDaTZ3m7cEXN/L8JVqGFsRbC
 qsUg==
X-Gm-Message-State: AOJu0Yzs92NvmkDUgdNn+LoF7+bU3fnCOH5mThECtL6PXYSqYYVFRcbU
 qb8urGrspHqc+5h3UShW7AFAs9B8Z0Fug6bdw3OMaUjxRNyM1gwcM5bM0h4I0MhN7O0=
X-Gm-Gg: AY/fxX46EceYzDLgLTK7xxYSHlHOlppyYOkzwK4e6CmayxCqVT2AMGBWpeTBv1CsX1F
 hxr+tgUK8H/KL7TIJhaqjIUgQr021LO5vtyrGJ2saIVpaZL/mdabG8vBR2151O67Zk6//QWJ8+e
 UQWDVDosVmX+DISWvcJ6r9xtbp79f+h5aQq1qao5BizrkrENyEbXEFQjIiYiDArP7LogLVvbDtc
 cdgTVZs/WOrs0geKsHDvTAJOp970XGFZRsD45t0RhSXVBXpCbzFYtaSsM0vRk9RI9nJDo3qSt1l
 HAf8y0eaLDzIqLrCjmvYzwbcifQKwo9RPxEDvc8hHP4n2XMaMA7YJErYWgttz6x6WgRXYQsStFY
 em7mgQVfCZXCtsvibz0bnAgy9h4gkHos1JnOuiQ+Awdnezfh5+mPcmnAFHPaKlsrRPTj7Z4wjaP
 oPwtOLZN/Rs96QdVHU0cs=
X-Google-Smtp-Source: AGHT+IHIJ4YvEiBn5LmDpQm+AqLliIJwtyflmTS9qRehiboqFUAiYm+zk5NG05kSd0rWPOEIpW2RYA==
X-Received: by 2002:a05:6a00:b60c:b0:7e8:450c:61ba with SMTP id
 d2e1a72fcca58-7ff6607e4a5mr8823881b3a.42.1766327008973; 
 Sun, 21 Dec 2025 06:23:28 -0800 (PST)
Received: from fedora.. ([118.151.210.82]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7ff7e48f258sm7590449b3a.47.2025.12.21.06.23.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 21 Dec 2025 06:23:28 -0800 (PST)
From: Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>
To: qemu-devel@nongnu.org, deller@gmx.de, sarkarsoumyajyoti23@gmail.com,
 mark.cave-ayland@ilande.co.uk, richard.henderson@linaro.org
Cc: Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>
Subject: [PATCH 02/10] scsi:ncr710: Fix use after free in command_complete
Date: Sun, 21 Dec 2025 19:53:09 +0530
Message-ID: <20251221142317.266293-3-soumyajyotisarkar23@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251221142317.266293-1-soumyajyotisarkar23@gmail.com>
References: <20251221142317.266293-1-soumyajyotisarkar23@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::444;
 envelope-from=soumyajyotisarkar23@gmail.com; helo=mail-pf1-x444.google.com
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

Add proper hba_private pointer cleanup in ncr710_command_complete.
This prevents use after free errors from occuring.

This was causing memory corruption in NetBSD device initialization
when commands complete and the request structures were freed while
still being referenced.

Signed-off-by: Soumyajyotii Ssarkar<soumyajyotisarkar23@gmail.com>
---
 hw/scsi/ncr53c710.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/hw/scsi/ncr53c710.c b/hw/scsi/ncr53c710.c
index bab2ea7210..ac1ca4cef8 100644
--- a/hw/scsi/ncr53c710.c
+++ b/hw/scsi/ncr53c710.c
@@ -798,7 +798,13 @@ void ncr710_command_complete(SCSIRequest *req, size_t resid)
 
     ncr710_set_phase(s, PHASE_ST);
 
-    if (req->hba_private == s->current) {
+    if (p) {
+        req->hba_private = NULL;
+        if (p == s->current) {
+            p->req = NULL;
+        } else {
+            ncr710_request_free(s, p);
+        }
         scsi_req_unref(req);
     }
 
-- 
2.49.0


