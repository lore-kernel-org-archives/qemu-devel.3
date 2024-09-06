Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53FB4E6FE2D
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2024 15:50:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smbDV-0001NL-Lt; Fri, 06 Sep 2024 11:49:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1smbDU-0001GG-3i
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 11:49:44 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1smbDS-0008Bn-Ff
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 11:49:43 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-5c263118780so2446265a12.2
 for <qemu-devel@nongnu.org>; Fri, 06 Sep 2024 08:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725637781; x=1726242581; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vC9WnbFOdrpXQUX3BWmGZJypN5/VBj5S9SdVEOdGWIc=;
 b=jDt1OGHnD8SKd1floQySmZjpOHrHVcOgvpHtQo1QYPePn/n2/N2yka7aS6wikMBs49
 LZO/nVrIfcDj0ECe/qE8ABNAn59Hq5ojtzU+Y7hDc7hLw4i/Jlad9i3ZM7XSr7zDVjNw
 nzp4EYpsIq+KEU1af8ynZN9HLoklmKy00CyaLoiAWNSgJHRwEsCmVJfuq7MA7Pfqu59g
 8M1d1r1oBgnXjROlPSXlq3zhK/1Mtp02Y6Mg8Y/T2hFpipMLueorgSs3DrzaoDLAj8Zw
 aRSbF0ISEeFtCujRkfcfFWIDgv7opwsjo1sowVVRfogd9kk57+3BrQNpHpYKVMR+1EMX
 QGCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725637781; x=1726242581;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vC9WnbFOdrpXQUX3BWmGZJypN5/VBj5S9SdVEOdGWIc=;
 b=ps4YPZYOHo8xd6GHJgmvKHizDxNWRQq6rXMMEOwiTTuLPxIy34EZt8mC6OCvbr9U69
 USAylC/ybSvxuouQgrH+caNiBIwCaHOw1iTVcWJJh8jHcXDC/Oev30iD3K5MTGWwxj+T
 pnEzOAzPW62SlwOpb8IPPCkK69yKfoqUAlwou+L5W4eABCIm5CURcU7QsrE7kTvYRHwA
 D2AFByHUpBZuyWmzREgt3NzrlegKaV0W5Pmh1bn4LcmIMvbAEC9hhPaRVN5EXn6IC3yQ
 8j8zPDc6WhisKb70bK3l6Kp0epjQB/3nIA1b0ImWnQrl+y7drBGLtza025gxw8JnfApQ
 mdbA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUmpGmg3RD3bNRnzOc92a10GyKJoIWn5jQwUShFK/rEA2tMXGFaYqrg3T93WdXBAx0aGmuzQWtNregV@nongnu.org
X-Gm-Message-State: AOJu0Ywwo8/goS2tYKk9/GqSSxzECFP28He8xJZviYUx54Q+Wwe8wS+4
 Zzt5siZGI/eWQeF1QcaHXN4GXQeoa+yMz8l+UQl5pXt8UIj7uZSnjZGuuWVxQlY=
X-Google-Smtp-Source: AGHT+IGClyno7/InsWevzZBVn4ySxeMti/CIC5Jov2agpzD6xbGkx8GM4D06oZ099YFcw1qDwVmdFw==
X-Received: by 2002:a17:907:3689:b0:a86:7d62:4c28 with SMTP id
 a640c23a62f3a-a8a886667b6mr252359666b.30.1725637780821; 
 Fri, 06 Sep 2024 08:49:40 -0700 (PDT)
Received: from localhost.localdomain (225.13.23.93.rev.sfr.net. [93.23.13.225])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8a8e439feesm98449766b.74.2024.09.06.08.49.39
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 06 Sep 2024 08:49:40 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Guenter Roeck <linux@roeck-us.net>,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PATCH v2 5/5] hw/sensor/tmp105: Lower 4 bit of limit registers are
 always 0
Date: Fri,  6 Sep 2024 17:49:11 +0200
Message-ID: <20240906154911.86803-6-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240906154911.86803-1-philmd@linaro.org>
References: <20240906154911.86803-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x531.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Guenter Roeck <linux@roeck-us.net>

Per datasheet, "HIGH AND LOW LIMIT REGISTERS", the lower 4 bit
of the limit registers are unused and always report 0.
The lower 4 bit should not be used for temperature comparisons,
so mask the unused bits before storing the limits.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/sensor/tmp105.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/sensor/tmp105.c b/hw/sensor/tmp105.c
index f5101af919..9d7b911f59 100644
--- a/hw/sensor/tmp105.c
+++ b/hw/sensor/tmp105.c
@@ -171,7 +171,7 @@ static void tmp105_write(TMP105State *s)
     case TMP105_REG_T_HIGH:
         if (s->len >= 3) {
             s->limit[s->pointer & 1] = (int16_t)
-                    ((((uint16_t) s->buf[0]) << 8) | s->buf[1]);
+                    ((((uint16_t) s->buf[0]) << 8) | (s->buf[1] & 0xf0));
         }
         tmp105_alarm_update(s, false);
         break;
-- 
2.45.2


