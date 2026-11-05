Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21019606A326
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2026 09:30:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOtm7-0006xu-9D; Thu, 05 Nov 2026 04:28:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1xOtm2-0006sn-FD
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 04:28:46 -0500
Received: from mail-pg1-f181.google.com ([209.85.215.181])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1xOtm0-0006xP-7M
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 04:28:45 -0500
Received: by mail-pg1-f181.google.com with SMTP id
 41be03b00d2f7-cc4c02ddd62so1071729a12.0
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2026 01:28:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793870922; x=1794475722;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=1BfKbNBFOgpv4Y4gegCRNCEDAhIiNTLP3qGg6/c2kSc=;
 b=KWWkdJDYeUZXyT77aPEfi2q6u+ITwomuySeUT2blk14gKnL3EPdGcGWGfiIe3zCTCM
 E7gUkyXwd1Vo4jxnhzHYasi0d7sRJKiomKyJDIncsSJT+ZdT9Qxxg5EYzU7bDb8u7oBY
 jFzvtVDdof+BZgyOWd4nMwAHig7LxAu7N2ipq0EXojahXN4y3bhzE9h3l0nwDlYuLUrU
 WQZKUOYVtREZHzNO2MM7N0X9/Rp5YlVBBCvd+ThwA6R6uIQS5wLFGKNvgJslvEtdzUW6
 nSSUCi3vIMIh5qs5F0eaQPyH1qnW5znbGDwXf4z3kB+ipfrDkSQ+JGVvG00Mfn+Jni5y
 hYpA==
X-Gm-Message-State: APuU4Z91M+v+MAyXjsB3/oRsVh0Mnr/fG9G8ALdDinvTZTNIsgKnjx//
 rU/VaGH0A1wCzeQlPplyQMxcEUgiSc9QgSuSh8XKALLIpebLfWrLD2bNk/aUIw==
X-Gm-Gg: AYBFou3NubKSqoBKq+hu62oBC65Cov0T4sVjNrhl8yW1M+hNUAI4ecZ5zfhfF7kdIm0
 O5r77G44gfxGHS1ZzuKq3ei9t1JRKD5Zd4LtV5Sv8SDgIos9SLq3EegtxUThOUxgpIjWH2IjjNC
 UeXXSfAiliERO3VZVmckOuXq++9YTt1n3uDUyuyYOu3pEfzfv1BF6C1UGvwdDSNoRLcYn5k30Da
 SYvGnLdEgvHcN0ypc6Pd+tmYkzFUpIU6F4eSjoFtX96o8upmMMsNi3k/GOvISZ2/wXNVEI3+WjK
 hLYirsbDSWNESfY1CKxmgFspowl2xPwrsDuK5+F1ceoEY3cfyx5Mr0gDtx5eEcO74U8J1QRpOrm
 eQ5iPmWsc1KoWZ55n7kDbxrRe2F8yGL5N4Vecw5utGU73SOhOR6pcLt8ZoPnbqojKNBw4esqc1r
 TtFFVbEmkuIT7ZmDPHXvVE4sMVUgU7fuGTB4w3A6Ec7SVCuuYzcdpzc0aGmD65oZaGUiFnQUKs/
 EjY1tIcASAZ4i7qOVvO/tg3SYN5O5PLNsMpZ+/9YSbYK9nsdH8b3saZKpMNP27aAgV5ucWZ0Mar
 ATcQH2jI+CMHNGcRFN85tybN32ReMayJkiJ0GesvTbYWTQUdRBjKDjqVBvkEPsAWVCghh3md2OZ
 u
X-Received: by 2002:a17:90b:2d04:b0:3a7:82ef:bcdd with SMTP id
 98e67ed59e1d1-3ae898392c2mr15401312a91.41.1793870922455; 
 Thu, 05 Nov 2026 01:28:42 -0800 (PST)
Received: from localhost (118-163-122-149.hinet-ip.hinet.net.
 [118.163.122.149]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b0b32812a6sm2905960a91.11.2026.11.05.01.28.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 01:28:42 -0800 (PST)
Date: Thu, 05 Nov 2026 17:25:46 +0800
Subject: [PATCH 07/16] hw/sensor: tmp421: describe the temperature properties
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261105-sensor-tmp421-v1-7-c46853f5e1f0@free.fr>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793870743; l=763;
 i=emmanuel.blot@free.fr; s=20260602; h=from:subject:message-id;
 bh=rdU7Q4ra6hFL/RukQf2lAq3++tTLRvjIbFGIs0BPyVk=;
 b=gHy6jygsujU3TkBwYzMUu50wtfF+0PSbeqDLhd0/lsBaXVnEZGGP/k3MIVvZKNgBcC9+ifQ6w
 wpEcfwTeFETCkS9fdzKjI7Gmk2xAE6pr84pjXYLOScuNQT6fOGoFhfD
X-Developer-Key: i=emmanuel.blot@free.fr; a=ed25519;
 pk=0qFrZ21FAAN8OfVsSoVcCFTk/NMYOWzxJz4paSAVm0g=
Received-SPF: pass client-ip=209.85.215.181; envelope-from=eblot.ml@gmail.com;
 helo=mail-pg1-f181.google.com
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

Attach a description to each temperature property so it shows up in
qom-list-properties.

Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
---
 hw/sensor/tmp421.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/sensor/tmp421.c b/hw/sensor/tmp421.c
index 8c789a2a09..87cbd9dd4b 100644
--- a/hw/sensor/tmp421.c
+++ b/hw/sensor/tmp421.c
@@ -394,6 +394,8 @@ static void tmp421_initfn(Object *obj)
         object_property_add(obj, name, "int", &int_type_info,
                             tmp421_get_temperature,
                             tmp421_set_temperature, NULL, NULL);
+        object_property_set_description(obj, name,
+                            "Temperature, in millidegrees Celsius");
     }
 }
 

-- 
2.53.0-Meta


