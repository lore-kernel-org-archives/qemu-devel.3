Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0CDA606A323
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Nov 2026 19:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CF8uMFca
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWIWg-0002JA-NZ; Wed, 25 Nov 2026 14:19:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bogorodskiy@gmail.com>)
 id 1xWIV3-0001Yx-Sm
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 14:17:50 -0500
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bogorodskiy@gmail.com>)
 id 1xWIUz-0002Cc-Jt
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 14:17:48 -0500
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-c506a231b88so838673066b.3
 for <qemu-devel@nongnu.org>; Wed, 25 Nov 2026 11:17:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795634263; x=1796239063; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=MsXd5Z18Zkv4Ns3CfgNtsnIk8Aw0z6/F8SG1TkpxPH4=;
 b=CF8uMFcayslmSfwK7gNjufl40Ts182ybTnYGL35TgVSklEcH/yPnfsmzgn1psg5/A5
 01nhi1l46/ndaP1tbSMFsXFSlqrFOnASFlwVqUwGdcSBpKsIySaqiWEYpDylhXWxaFxy
 gwiHU+v6cIbis8K2K1LxH0W23LNf8jZbcBmpu2mWI7gum9Jykl0056RCZzKR2udWUOOY
 kRHBey56yRyY61JBZqpxFO5FaoJZZe1eREsY4B7JCZRm4FDCNsG1GpijSVpLvTee76tV
 fcy2QdUoADitQ/kiEXBpGBEWTgXcoyhYjvfU/NWDkTxLSjJ/SrnY3v5jwSmSOrmcJf4v
 isdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795634263; x=1796239063;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=MsXd5Z18Zkv4Ns3CfgNtsnIk8Aw0z6/F8SG1TkpxPH4=;
 b=cKPZnyKppEhx18coTNj50HB+C+6xH8hq0U8f4xj7sRjbNg18Gp7bcDSlCVVQASJbXB
 wcKqSWhe0yM6C16D4S0QeN6eAwObzKnXHXrIIJHHBKOGOeXqAkfhtNHFygOy9a75rLDm
 29l9yj9lq3T/PIYLeDZk0y086ZkL0/L2x0a0buX02Nf83OR32hzIzvUnHra2kDYWlG9/
 uWV3+BtHq0aSdnrKbG1laUW7vgyRXfOWjIyLcyn3VuESRQsPAiIRxpSRRuZFSrkvaHuY
 Z9BHisbkyjzBTsbTpiD/AkWkzx7SNohjIf9mr5+Zlz7cvyps5ZsZCimh3t03sKODdhA4
 G4eA==
X-Gm-Message-State: APuU4Z88hJ4/NFoRu6r1m9hT81YoxYNTPxN0+H83CMlB1TmmjaA3NOC6
 IBSXeCTKIp9ImUTwpiuiCmfUPWBZE0NwCGY4scJYAONh9r74q39K9lZTHr8tKyrPI6k=
X-Gm-Gg: AZFdTZel2j10vrdy6bntfLDCp6lRZB+KzbGNYoS7JT1DTo/a99WYo766GKb+1rQvfuA
 l/wLP1i2X3lfSfGPnocLAUwLWmbwqZQ0Fs8VtPQHTGuoL+UWkALGoJ/q1DKF7FzcuoN8MnW5spf
 n/Lo2kIWuTLagRjO4Yjya8dEUvTAU36syXzBe9Lf9Dg9+SbZl8mSn+JS4qgacZBziRKdmYXL7iZ
 KXZuhs64wmDmRh1Ti6xZQIknR8/K1O9hM7AlpuuYTuWIyrx6Rkbw6Rq+KHD7bPI5Bu/M2WR5qqW
 6yljCurEGf4NcKXFKcrYz3uoK0i/o7WdiqVbcdF4BDbyo0iiHXdpJcz8FKxOhCfDH2yIKZjyDh0
 rXavkXDgydc9n+UevPHTaJZukN0olc48Ve0ztfi+Y+TGlxajRP74XATCeTXxX+z+nz8YeTDpQVf
 LY2ZHIGRLl+TZPQAXUiFhjhpUqjbEE4KKPO0bQKzvlBbzZ2DKkvlTw3LPvqc1UccdcjEJ78sanE
 XzstUNuxhiDKHR4oTQXF71MOa0ScPhV4SgQuu18kLV52h77GbBwMVa3mZvitPDzCwhuApFsoSxn
 QYmUA602toIFp5T0+V6Q9Ngu+30ekw7fJ6lWppcwf5FdINcz+mvWjhDYVcw/8Ud9IDNV9HpFRa0
 QM/NBOIk4KE3QEkK15wm+LHnzeHDSrr5RrBQlGenLqcH4MakTGhy56vS6KAjz
X-Received: by 2002:a17:906:e203:b0:c42:82ac:b6a9 with SMTP id
 a640c23a62f3a-c513a85502cmr1112660066b.29.1795634263396; 
 Wed, 25 Nov 2026 11:17:43 -0800 (PST)
Received: from tulp.my.domain
 (2001-1c02-1a15-3000-2727-f7d1-9628-aa81.cable.dynamic.v6.ziggo.nl.
 [2001:1c02:1a15:3000:2727:f7d1:9628:aa81])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c513b003eacsm672686266b.81.2026.11.25.11.17.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 11:17:43 -0800 (PST)
From: Roman Bogorodskiy <bogorodskiy@gmail.com>
To: qemu-devel@nongnu.org
Cc: Roman Bogorodskiy <bogorodskiy@gmail.com>, Brad Smith <brad@comstyle.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v2 04/10] tests/qtest: unset socket timeout
Date: Wed, 25 Nov 2026 20:16:54 +0100
Message-ID: <20261125191701.93931-5-bogorodskiy@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261125191701.93931-1-bogorodskiy@gmail.com>
References: <20261125191701.93931-1-bogorodskiy@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=bogorodskiy@gmail.com; helo=mail-ej1-x62b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The qtest_socket_accept() sets a timeout on a listening
socket. FreeBSD also inherits this timeout for the accepted socket,
which breaks some tests. Explicitly set timeout on the accepted socket
to 0.

Signed-off-by: Roman Bogorodskiy <bogorodskiy@gmail.com>
Reviewed-by: Brad Smith <brad@comstyle.com>
---
 tests/qtest/libqtest.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/tests/qtest/libqtest.c b/tests/qtest/libqtest.c
index 7f66c1bbb3..8a7989811d 100644
--- a/tests/qtest/libqtest.c
+++ b/tests/qtest/libqtest.c
@@ -151,6 +151,19 @@ static int qtest_socket_accept(QTestState *s, int sock)
     }
     if (ret == -1) {
         fprintf(stderr, "%s failed: %s\n", __func__, strerror(errno));
+    } else {
+        /*
+         * Accepted sockets might inherit listener's timeout on
+         * BSD systems, so set it to 0 explicitly
+         */
+        memset(&timeout, 0, sizeof(timeout));
+        if (setsockopt(ret, SOL_SOCKET, SO_RCVTIMEO,
+                       (void *)&timeout, sizeof(timeout))) {
+            fprintf(stderr, "%s failed to set SO_RCVTIMEO: %s\n",
+                    __func__, strerror(errno));
+            close(ret);
+            return -1;
+        }
     }
 
     return ret;
-- 
2.56.0


