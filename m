Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A985606A32F
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2026 09:30:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOtll-0006jG-4W; Thu, 05 Nov 2026 04:28:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1xOtlI-0006c6-U7
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 04:28:01 -0500
Received: from mail-pf1-f174.google.com ([209.85.210.174])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1xOtlG-0006uN-Pm
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 04:28:00 -0500
Received: by mail-pf1-f174.google.com with SMTP id
 d2e1a72fcca58-8a07078200fso730210b3a.2
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2026 01:27:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793870877; x=1794475677;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=YPLH85BN1FQ6/VjPz8nyN4WwRSjc/tOK4cGRVQRwlAA=;
 b=LqfBM4Ie3IXEAGr6wy4UttaWSvL9nKAV9B891y+YeeTOWWvmOeRu5N8hvqrV/NPCXt
 zjnIAndqpCfhaqTYC0NdVY1XQE1GajRjpwL1AAN7WkXCvOVKHHRhOK7iuX5tJ8s3vy7u
 wXqhQN1aHBSyIfklGBO43+GQss5Yb3cMel2yXwsESTGMmw2vvRWJV5WsSozsSJPvNmIk
 Sbj8C/sCIXbUDmJ22R7QyhDFvQua2XpDqIioF1w0TVBQ0AJ8Aa2jcQOvCUmRX1yY7pGr
 EuMURibPoLCU7XvsQtDdYLHwczrV+pLRrFXwHdfNeGyV3Tox6zIod335xOF+Z9f7CD+Y
 3HjQ==
X-Gm-Message-State: APuU4Z/ko9CkYIvpMdzHZ1xRI+OcDym4J2iAo9mhDu0H1L6lPQhLPUjk
 pSgcGrKcR1sNdciAKtJhUG7dxElHmhgZV4Rt6i0LV8UxAZXHj+CaHVXdDU2+tYQJ3kA=
X-Gm-Gg: AYBFou0iIpyEmq1Z/1O1hAZm4vHlptMmIdcm6ydgtjuJUhDHGawxhRTqNiUtliQJqbB
 m4krAw+INBsKsEuw0lVcMqjQfv8zR6II+MYIlcuO07S1aVfJQJsAu6pqXhllkrSayE2c5hCayTZ
 bpwEl48A8rJ2cMVvhO+wqQ+hIu+551+LAywUJ3OkYWLHj3IpqAiLBo6lznZXrp6gqJho8h0tUXL
 Uo6d+E7eoAzXWhM1W2wVPmHmWk3wip6K5jrcwng28PgHeNPjEuOJlK/Xxcr34cgeY5/26X3ThcX
 NXtFSniFeS9185ho61zre222l2AYs4n9vaoEbB24F1QrU3dtuCbkwLO8SZAHmWQSLuPcvLSPedE
 ofjM0fugBJCu8EnQsDnrUYkJcWB0c8ULhMMi7hcVmp1Q95EuELdh6cv13vCX7xNXy+sQ+/kwoG9
 thKe+2L/tE39HKBRBBpvM3W/YnntxFz+Z1sRtbBFqOWJnA2A/xdM4+wNmLXgQB6GuWi7DOZ4V5T
 GBvXDAIJNBydPnhuU6vqCpq7PBM/eRBJZ/9CweYNFV6ZRbXybSZQo/tTF+jeclTf3GxzZP5hNYF
 pDvvb4rNdeNGn7oQrHhM5m6Ae5m2cSImR+g79xkW8PcIB4KZxp9xaesN6VZCjkxAKgMAC3U/81g
 3
X-Received: by 2002:a05:6a00:6301:b0:8ac:3a71:38a6 with SMTP id
 d2e1a72fcca58-8ac3a71603dmr8841515b3a.52.1793870877117; 
 Thu, 05 Nov 2026 01:27:57 -0800 (PST)
Received: from localhost (118-163-122-149.hinet-ip.hinet.net.
 [118.163.122.149]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8b09c024a45sm1790162b3a.56.2026.11.05.01.27.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 01:27:56 -0800 (PST)
Date: Thu, 05 Nov 2026 17:25:40 +0800
Subject: [PATCH 01/16] hw/sensor: tmp421: do not report a stale errno on a
 parse failure
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261105-sensor-tmp421-v1-1-c46853f5e1f0@free.fr>
References: <20261105-sensor-tmp421-v1-0-c46853f5e1f0@free.fr>
In-Reply-To: <20261105-sensor-tmp421-v1-0-c46853f5e1f0@free.fr>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, eblot@meta.com, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Jamin Lin <jamin_lin@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>, 
 qemu-arm@nongnu.org, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Emmanuel Blot <emmanuel.blot@free.fr>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793870742; l=1336;
 i=emmanuel.blot@free.fr; s=20260602; h=from:subject:message-id;
 bh=GFEfhIFJh8BOQmlbaRUAQhaRBhXcQfPvzbeClZRBxBk=;
 b=SnUnMVbEDiOUUppxJSOZyrhMoIdPtXywSWLyUL3FSZ5SGalDeO3g4fEqZ7VOcLdlRarxUjrrS
 bqxyYgtDqFPDBVOzS8OQSE+LpVw23ryDYEF2OZjxhok5xds19WX3DIp
X-Developer-Key: i=emmanuel.blot@free.fr; a=ed25519;
 pk=0qFrZ21FAAN8OfVsSoVcCFTk/NMYOWzxJz4paSAVm0g=
Received-SPF: pass client-ip=209.85.210.174; envelope-from=eblot.ml@gmail.com;
 helo=mail-pf1-f174.google.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-to:  Emmanuel Blot <emmanuel.blot@free.fr>
From:  Emmanuel Blot via qemu development <qemu-devel@nongnu.org>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The temperature property accessors decode the channel index out of the
property name and report a failure with error_setg_errno(). sscanf()
does not set errno when it matches fewer items than expected, so the
message is suffixed with whatever unrelated error was left behind by an
earlier call. The bounds check right below already uses plain
error_setg() for the same condition.

Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
---
 hw/sensor/tmp421.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/sensor/tmp421.c b/hw/sensor/tmp421.c
index 0e4d0d0ec2..84c6ebec41 100644
--- a/hw/sensor/tmp421.c
+++ b/hw/sensor/tmp421.c
@@ -118,7 +118,7 @@ static void tmp421_get_temperature(Object *obj, Visitor *v, const char *name,
     int tempid;
 
     if (sscanf(name, "temperature%d", &tempid) != 1) {
-        error_setg_errno(errp, errno, "error reading %s", name);
+        error_setg(errp, "error reading %s", name);
         return;
     }
 
@@ -155,7 +155,7 @@ static void tmp421_set_temperature(Object *obj, Visitor *v, const char *name,
     }
 
     if (sscanf(name, "temperature%d", &tempid) != 1) {
-        error_setg_errno(errp, errno, "error reading %s", name);
+        error_setg(errp, "error reading %s", name);
         return;
     }
 

-- 
2.53.0-Meta


