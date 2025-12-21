Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 258F5E66886
	for <qemu-devel@archiver.kernel.org>; Sun, 21 Dec 2025 14:25:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vXKM7-0001ct-GS; Sun, 21 Dec 2025 09:24:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <soumyajyotisarkar23@gmail.com>)
 id 1vXKLb-0001Io-Hj
 for qemu-devel@nongnu.org; Sun, 21 Dec 2025 09:23:53 -0500
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <soumyajyotisarkar23@gmail.com>)
 id 1vXKLa-0001Jf-10
 for qemu-devel@nongnu.org; Sun, 21 Dec 2025 09:23:47 -0500
Received: by mail-pf1-x442.google.com with SMTP id
 d2e1a72fcca58-7b89c1ce9easo3654752b3a.2
 for <qemu-devel@nongnu.org>; Sun, 21 Dec 2025 06:23:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1766327024; x=1766931824; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bsRWI5gndwtWwttnMKZAc/IN3m1275AuEyjWfFtSTCA=;
 b=TmFL8a9pK3CZugTQY3V3EKee2UBv+fNEmcP4Z7bup98dYwt6YFpUzE2ElXpB1zJNYX
 l6IGafeYC6SB0ZUk+1ARZsKWf61xKh85keAyEcoN65R3Ew0bSVv2raTsNg8HzqqFRu9O
 x/gyfKMjrN1/5qPhwAOMKnhNEPhX7UWgjflPfuU+WzfjmiUuE9ZIi8k8CtW9mPlIn15o
 5B4vAav3QtccUpIYKrgbfblRvt88u2kMRbBbRHqjkcERke/YrPXRfTVICjYHaoErNNom
 lmBNokRfPPt7uDfHdrDLCg+nDw+eh/516E2cn9v+WxA8YYgqUbHXMytWQ85wwWeUKYCS
 t9LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766327024; x=1766931824;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=bsRWI5gndwtWwttnMKZAc/IN3m1275AuEyjWfFtSTCA=;
 b=G167fKv9CDn2DpjjsMqmSfLwTkrcN0gIjU1fmClztCsy1CnVSLl8QGLhc/R1B9PvSc
 SR841WV+fsEMIBl/QpF6hbhj4aV5SDWyWBABTGHgCyvClHsWhpqUV2Qff5WrQm+Fwqf0
 eCwCNCHHrSJutTbwHLUzZmrmG6U5mWq8NaCoWxV15VxkfqOZ/Db64AzkcbarrvvBWSLY
 VkDEsF9eUAxpeTGOaoc6mvDrWT4GC8NAbOaugUdAXgRHyxMdSTFf0Tir6Wl6raIzLefp
 T9GUratEQUsyeLUfW4UpZrOJS7lYTQOAhqLK04S829TawYl/LQ3q/RJE5K+PNs/R0Ayu
 HlpA==
X-Gm-Message-State: AOJu0YzlL4c3A9c3Uq+eGhk/KjxYg9ybJG+vsB/ZdHxWEGoNMh5talcm
 XkJLPWpK7mBEqAWyRZZTCqFnblnW9rrP6+VxpfavQ0rE+RcMFezSCPdH7xURL0N9naA=
X-Gm-Gg: AY/fxX4eXMCEa+tW/0T6KulMWt5LEEC4wFz3kAesyzLdL9CF1S//4t1Hd1Ae9zUG12b
 Rzd5F80qXOaYK/VUDZFeLvDsTpLkVm6V1VoPegE9jOLq0Q5BmHa5Cc+AoMpsBYbPSsdlmZUgTv7
 MYdRICWriFETLe1sUC4IcyHZ+n5eM+M3ZZb/ZRbAyIJK237RC3mcw9P4weMHr/zzaI6hQgK+OHX
 zO7eEz8JCwvDSuxDTpf9KBN4FDBK3WgWLIWCJhiuB1WTAX9k2j3jW6aAHHMqzpPmiiLJ8rw3eGE
 TtbsZU2c8yL9Oz8rCAa9LEtcDGmayiq1uwPd4tm3TD1KEoDwqIajC0xretSFJau+pkJTUPTmWcN
 ZZdw8yLgCva/zNW1FxrMgxFnr/1CuYDy6DuJzRbs+bQrze1uivaGDU5ecF79FM27KW+6zXIG2jL
 FTUJNdsc0FgoO+HLRoeWY=
X-Google-Smtp-Source: AGHT+IGdc+xTBvozWdC+Gkz1WeNdvswNO5j6t4X6U4VfklluPQ/i4AFgioBPV7IDG6asSp5NucGj6w==
X-Received: by 2002:a05:6a00:1f17:b0:7f1:fad7:2ce with SMTP id
 d2e1a72fcca58-7ff679669d1mr8994532b3a.48.1766327024417; 
 Sun, 21 Dec 2025 06:23:44 -0800 (PST)
Received: from fedora.. ([118.151.210.82]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7ff7e48f258sm7590449b3a.47.2025.12.21.06.23.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 21 Dec 2025 06:23:44 -0800 (PST)
From: Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>
To: qemu-devel@nongnu.org, deller@gmx.de, sarkarsoumyajyoti23@gmail.com,
 mark.cave-ayland@ilande.co.uk, richard.henderson@linaro.org
Cc: Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>
Subject: [PATCH 07/10] scsi:ncr53c710: Add LUN scanning
Date: Sun, 21 Dec 2025 19:53:14 +0530
Message-ID: <20251221142317.266293-8-soumyajyotisarkar23@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251221142317.266293-1-soumyajyotisarkar23@gmail.com>
References: <20251221142317.266293-1-soumyajyotisarkar23@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::442;
 envelope-from=soumyajyotisarkar23@gmail.com; helo=mail-pf1-x442.google.com
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

Add multi-lun support by scanning all 8 luns when ANT bit is set

Signed-off-by: Soumyajyotii Ssarkar<soumyajyotisarkar23@gmail.com>
---
 hw/scsi/ncr53c710.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/hw/scsi/ncr53c710.c b/hw/scsi/ncr53c710.c
index 3d7318c12e..277aa2c3d3 100644
--- a/hw/scsi/ncr53c710.c
+++ b/hw/scsi/ncr53c710.c
@@ -1422,8 +1422,30 @@ again:
                         s->dsp = s->dnad;
                         break;
                     }
-                } else if (!scsi_device_find(&s->bus, 0, idbitstonum(id), 0)) {
+                }
+                bool device_exists = false;
+                if (insn & (1 << 24)) {
+                    /* ATN set - scan all LUNs for this target */
+                    for (int lun = 0; lun < 8; lun++) {
+                        SCSIDevice *dev = scsi_device_find(&s->bus, 0,
+                                                           idbitstonum(id),
+                                                           lun);
+                        if (dev) {
+                            device_exists = true;
+                            break;
+                        }
+                    }
+                } else {
+                    /* No ATN - check only LUN 0 */
+                    SCSIDevice *dev = scsi_device_find(&s->bus, 0,
+                                                       idbitstonum(id), 0);
+                    device_exists = dev != NULL;
+                }
+                if (!device_exists) {
                     ncr710_bad_selection(s, id);
+                    if (!(insn & (1 << 24)) && addr != 0) {
+                        s->dsp = addr;
+                    }
                     break;
                 } else {
                     /*
-- 
2.49.0


