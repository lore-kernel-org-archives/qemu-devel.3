Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45A66CE7B10
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2024 13:31:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smZ1t-0004IT-7j; Fri, 06 Sep 2024 09:29:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>) id 1smZ1j-0003oB-2M
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 09:29:28 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>) id 1smZ1h-0008O0-FO
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 09:29:26 -0400
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-2d87a1f0791so1432638a91.2
 for <qemu-devel@nongnu.org>; Fri, 06 Sep 2024 06:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1725629363; x=1726234163; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MJiwXDwz+nyTyxWqXsY+0vn8Yh51cYsH0PxbsAp2eNI=;
 b=KTWAdBNt4HZ+8bFQEQ/LL+UtH1nTig3OYtpfmG5cwPFnDhYPWnAM9tRxKGXD4O7wCH
 IPQVC6z9FLX5moqSZx4HCIM84FMwyfn8uJKjq9txNSj9aNWrgpN2PO8mh3Mw/IAtllOE
 zAoOOuOT3jj5d+przxloQprFb4lKuYpVeRaDNZvWm9Dusc2e2rFbWvf7kFpVlHZ8iN1b
 LOfTjZK2IeimeKUqcENNnLybDe+kO0OOQs5YluhDXkvivOgIzpHrEbr6Ey0ZmWpeX5td
 P8FkKhfSFoEqOKofQfeQCrRqYOcbKWu1o9zECylg+VSAGLde8baWAT4uxsmkePZgQXL5
 sU5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725629363; x=1726234163;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MJiwXDwz+nyTyxWqXsY+0vn8Yh51cYsH0PxbsAp2eNI=;
 b=qd4H1qtR6dDJs1Znd3glx+lU4RuFuSmFJMXxcDE2NMQEzzJKKDLiog2b1P2WXzObgE
 vS5FzFzn+1O08hU6SJU16bpNL0EWd0BD69TsIUD0AnRJj6ltl05F2rjmt7/elCeuue7R
 D/eC6arPVMDkWLJ86dBBS+L2nw7tRU3tBxgCBGztgO9qdfj0G8rCFpib1p1nVzYKcF/s
 CYABjscy6ItXsWWcKf+hCHDUXFtpvGGQtA+TdRDv+prv/qhhA75YN8IIRUtIht75edtW
 eW5KShE2vQT9aJ67QhBPoVYx/i7GCgda04MZ1ssiZqDgnzJVjGvGCuDGrTukLSwFPRXM
 q/ww==
X-Gm-Message-State: AOJu0YynHl4vE/q3xUGjsqQtH0hHjMMK16GD4X81obmOgZqaoiUex5bD
 Ss0h9mCIifTJ31Rf5eIDnzT1Kjrd7+bpG5Qv9NFpSgEXPp+Yzy/uE35XpQ==
X-Google-Smtp-Source: AGHT+IHXUM4+mIx95aGi23jUKm5KMGhSUMSXBUuTM3Ra51fhTBXzNCLZU9OG+34RyUZGq46D8Fh6BQ==
X-Received: by 2002:a17:90b:390f:b0:2d3:de40:d767 with SMTP id
 98e67ed59e1d1-2dad5022ae7mr3156645a91.24.1725629363074; 
 Fri, 06 Sep 2024 06:29:23 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2dadc03d1f5sm1520384a91.26.2024.09.06.06.29.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Sep 2024 06:29:22 -0700 (PDT)
From: Guenter Roeck <linux@roeck-us.net>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 3/3] tmp105: Lower 4 bit of limit registers are always 0
Date: Fri,  6 Sep 2024 06:29:12 -0700
Message-ID: <20240906132912.3826089-4-linux@roeck-us.net>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240906132912.3826089-1-linux@roeck-us.net>
References: <20240906132912.3826089-1-linux@roeck-us.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=groeck7@gmail.com; helo=mail-pj1-x102e.google.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Per datasheet, "HIGH AND LOW LIMIT REGISTERS", the lower 4 bit
of the limit registers are unused and always report 0.
The lower 4 bit should not be used for temperature comparisons,
so mask the unused bits before storing the limits.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 hw/sensor/tmp105.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/sensor/tmp105.c b/hw/sensor/tmp105.c
index 22728798f7..5fd30f8d50 100644
--- a/hw/sensor/tmp105.c
+++ b/hw/sensor/tmp105.c
@@ -166,7 +166,7 @@ static void tmp105_write(TMP105State *s)
     case TMP105_REG_T_HIGH:
         if (s->len >= 3)
             s->limit[s->pointer & 1] = (int16_t)
-                    ((((uint16_t) s->buf[0]) << 8) | s->buf[1]);
+                    ((((uint16_t) s->buf[0]) << 8) | (s->buf[1] & 0xf0));
         tmp105_alarm_update(s);
         break;
     }
-- 
2.45.2


