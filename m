Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1292DE66886
	for <qemu-devel@archiver.kernel.org>; Sun, 21 Dec 2025 14:25:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vXKM7-0001T2-3Q; Sun, 21 Dec 2025 09:24:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <soumyajyotisarkar23@gmail.com>)
 id 1vXKLY-0001IZ-Ki
 for qemu-devel@nongnu.org; Sun, 21 Dec 2025 09:23:48 -0500
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <soumyajyotisarkar23@gmail.com>)
 id 1vXKLX-0001JP-6a
 for qemu-devel@nongnu.org; Sun, 21 Dec 2025 09:23:44 -0500
Received: by mail-pf1-x444.google.com with SMTP id
 d2e1a72fcca58-7fbbb84f034so2390688b3a.0
 for <qemu-devel@nongnu.org>; Sun, 21 Dec 2025 06:23:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1766327021; x=1766931821; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XdPuLFFZ3D4mmgZaO7d+HZBZoL5op64qzVNSL0sChe4=;
 b=CBISeN9A9j5z91qrwGP4+j/5+NF520twVOkjpR16f2PRQoy1oz29ozKreQHajlIlBR
 9ci5pzcVonqr1muFXAP9H0AqhrfO3grYP/cKnhz8jXDSqxL34gAHucRRV7p+iL8mUyxh
 hsbnYIGjYbvHfjRVMktdDH7n8Br5yTnq036CemldiahB/XR5q6EsguwMg9YQ5ovqQA08
 V6WMGcXQuVkbfkexAhkXPz7/ToroWbZz/MJ+3CosnJ3WffoMe9+W55OQy0FjqPVylcvT
 MGKFoI+2AnnSZINxDUUb/qBrPq4Kv1IN7QZaTvn5lYVLTOccNnfJix6x7kNgbAkMZhLX
 OgQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766327021; x=1766931821;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XdPuLFFZ3D4mmgZaO7d+HZBZoL5op64qzVNSL0sChe4=;
 b=iCOjMONayg1lPippgZ9wT/g0Xe0m6DA4qSeBx/YFx8ySf6Inb/e8WOTyEbsJjF+anI
 u9quB5Nn76qXFpdw3dkYBIjrm+5IJZfcjQ83zOFJDmS4TARwf78zGnykWpx6ugwQnrFG
 oVoFcdQJaGEyDCkjvMFbjGzbWD+h4mo5QEAUREdM4SMxrWK+rswQasw1iaI4iYxoCJlE
 zTb2r7ybig+acltsLmy4HhQkGf3HY5N1qd0mDi5ornM2wbriWV+BPg/83A5PbEqQskVW
 4wOEwxMlRa/1symgEwi7iO6hlSNo7h8jnBuPbi3659K1X5HuLN4PXtzi9oKQvESs4HiE
 AGgw==
X-Gm-Message-State: AOJu0Yyi4x5ukJlO7jCIwK7Ejt3IHx5jfyB+wfn9KIpARJ97qHZLVhj9
 8E1IKO9Z+I8qNCMG7A+1/TsLoNm7SEBq5BnqQXlhLqkcjCGMkJ75bb0jXz0h0qWU2+k=
X-Gm-Gg: AY/fxX7kQN18scyyMQmuRF4r+N5/VVMBKWYuTuDSDzfHSKwgEH78SIWoQga3NuuNAED
 CpGUotmGWeiL5CdU0rUH3oXwzAXq1eEIXO3dJJsV44eFaxkstzXZ/eWiDnfV8Viv+81jf+F6EFm
 UlRh8b/wpOPpB6nV/7M++oV1uW05ltaQkaD9uhcbH5XyUlhgzBaENgxhtTgdbtZlFTgjX3XlWhH
 61tUbllhZCJUv371AYyYqypB5T/hu3t4JmV5IOag+ELcBRSW9yi/2iBT4E8nk0wtuC6c2dlfGxK
 C4hneJ9n18rWMzrrek+UBE9Vs+fT2Hs4KtpS3/32f9x1hmfO6/b6RaACh0aPno8cvplR0NgqTrB
 vzr6MfpSFMD3COj3p0LS+P2ZOf9ojaktpFqavpy6DRfvG9WwyJ4bH4XY1apgwvVluQy5ZyEShgf
 dt8y09H3raH6jCDxI4z48=
X-Google-Smtp-Source: AGHT+IG28diYGF80RZ0QtpeanFRL2g6gItmMNsqtmbusPT3zdERd0iLHnEsiU7RtEdteUkFqcFVx+Q==
X-Received: by 2002:a05:6a00:1ca2:b0:7e8:4471:8e2 with SMTP id
 d2e1a72fcca58-7ff66f569e7mr7616635b3a.67.1766327021542; 
 Sun, 21 Dec 2025 06:23:41 -0800 (PST)
Received: from fedora.. ([118.151.210.82]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7ff7e48f258sm7590449b3a.47.2025.12.21.06.23.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 21 Dec 2025 06:23:41 -0800 (PST)
From: Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>
To: qemu-devel@nongnu.org, deller@gmx.de, sarkarsoumyajyoti23@gmail.com,
 mark.cave-ayland@ilande.co.uk, richard.henderson@linaro.org
Cc: Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>
Subject: [PATCH 06/10] scsi:ncr710:Mark command complete in status phase and
 fix disconnect
Date: Sun, 21 Dec 2025 19:53:13 +0530
Message-ID: <20251221142317.266293-7-soumyajyotisarkar23@gmail.com>
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

Set command_complete flag after status_phase and use_phase_clearing,
instead of full disconnect during message processing

Signed-off-by: Soumyajyotii Ssarkar<soumyajyotisarkar23@gmail.com>
---
 hw/scsi/ncr53c710.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/scsi/ncr53c710.c b/hw/scsi/ncr53c710.c
index 4b42fab754..3d7318c12e 100644
--- a/hw/scsi/ncr53c710.c
+++ b/hw/scsi/ncr53c710.c
@@ -997,6 +997,7 @@ static void ncr710_do_status(NCR710State *s)
     ncr710_set_phase(s, PHASE_MI);
     s->msg_action = NCR710_MSG_ACTION_DISCONNECT;
     ncr710_add_msg_byte(s, 0); /* COMMAND COMPLETE */
+    s->command_complete = NCR710_CMD_COMPLETE;
 }
 
 static void ncr710_do_msgin(NCR710State *s)
@@ -1041,7 +1042,7 @@ static void ncr710_do_msgin(NCR710State *s)
         ncr710_set_phase(s, PHASE_CO);
         break;
     case NCR710_MSG_ACTION_DISCONNECT:
-        ncr710_disconnect(s);
+        s->sstat2 &= ~PHASE_MASK;
         break;
     case NCR710_MSG_ACTION_DATA_OUT:
         ncr710_set_phase(s, PHASE_DO);
-- 
2.49.0


