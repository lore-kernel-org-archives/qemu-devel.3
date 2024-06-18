Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76E1EC27C4F
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2024 15:37:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJatF-0006bv-6F; Tue, 18 Jun 2024 11:36:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zheyuma97@gmail.com>)
 id 1sJatD-0006bH-Ok; Tue, 18 Jun 2024 11:36:55 -0400
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zheyuma97@gmail.com>)
 id 1sJatC-0002kt-4b; Tue, 18 Jun 2024 11:36:55 -0400
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-a6ef8bf500dso633339566b.0; 
 Tue, 18 Jun 2024 08:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1718725012; x=1719329812; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=QhbL8CkusD649lr7/uCKnJLNVOjDQnum1nYhn69OEEQ=;
 b=JO5cFyaAmr7x7bifPKAU0orq/DzbYLz+xrZZyM9Sqn7b9mUq8kgLF0U+veYCdVO2Gd
 mCIgeQXDg8VEuSi+TBYjMeELYJ1Lo4xAsO6JGtMLV+ZaZLsokZY1KIrcT2OLv8ocCCXl
 73j4LCe3UMJuhBdkV207IFLYyfRY/emj/IThZZNMqtU+bfJrPKF5nvV0t+QjM1dzxuYp
 5/oFpL+llhahRFckAJbY77dBM+fzxas+K9EVQpzJfI11rL8pX0Qh/5xwaZlAeSPxQvLg
 i/a4aAUdv7QHH0zVDm02z8KulK//evIdG4uwDpe86fWVTRe2lCwD9n4ZdVodplx+8mK+
 qtbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718725012; x=1719329812;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QhbL8CkusD649lr7/uCKnJLNVOjDQnum1nYhn69OEEQ=;
 b=pLumtaN0dlR8gfrpf51FAvmXvPXL6Wa2KCc7OVJaOudWzztNiZsVZohf4Im9Uj0ase
 inZyFt0aK1nbvCRJm/n+e8ZETL3mrfGAoVsImdY4SLOmVH00zzA9fYaGfiTV+GLwMEzy
 dyyiq7qnLbe9KA02dXL7GXbrr3xq2e9QBI/ASsilRFcHqgec+GdaCrJ33nRPeYtj+asd
 NCAfDeWSMoTYX6HbHTgJ9XyO6R0XDY/9Df7IUdO3JC/y1+omfE7cvXW6Q5ebwG8m5EQ2
 Lc3AnrwfLg66b6MXTKxMRdbe310TpqSBcdG62spVBHZ0FsoF5IygOQV8pVZCOjLYJKfg
 NAgA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVVxME2B0V2y7FEUpEfvknWsFnRWeieM83AM5eqxSKJzaTgSlXSXCMOaVWYTQQNEuwRqk2sh3E8AHSNnlUlOLvFRCQGcYKRye71toRVVUgeIcescaKQlRVywPA=
X-Gm-Message-State: AOJu0YypMuUM2ZUZhsi9rWuITrctAIcsthrcwx4PRUHbi5zLTVKBN3ZX
 DiWHI9dWR1JIXwcqKc69nvKalaCBREv03EcbqW0J6RDh6s7x39mNJnNGa/hZDA==
X-Google-Smtp-Source: AGHT+IFzL+E7GN/4jv7L1+9wB94b1pLRQuAO/kpOetdUlM5IE8jq/ng4zAenL3ry7HZddW/ANs5gSQ==
X-Received: by 2002:a17:906:1854:b0:a6f:1dbb:d38b with SMTP id
 a640c23a62f3a-a6f60d2bd6dmr861595066b.28.1718725011933; 
 Tue, 18 Jun 2024 08:36:51 -0700 (PDT)
Received: from wing.epfl.ch (dhcp-122-dist-b-021.epfl.ch. [128.178.122.21])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6f56db62e5sm625400866b.84.2024.06.18.08.36.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Jun 2024 08:36:51 -0700 (PDT)
From: Zheyu Ma <zheyuma97@gmail.com>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: Zheyu Ma <zheyuma97@gmail.com>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Subject: [PATCH] adb: Fix assertion failure in adb_request() by
 blocking/unblocking autopoll
Date: Tue, 18 Jun 2024 17:36:01 +0200
Message-Id: <20240618153602.3169932-1-zheyuma97@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=zheyuma97@gmail.com; helo=mail-ej1-x62c.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

This commit addresses an assertion failure in the adb_request()
function. The failure occurs because the autopoll feature is not
properly blocked/unblocked during an ADB request. By calling
adb_autopoll_block() at the beginning and adb_autopoll_unblock() at
the end of the adb_request() function, we ensure that autopolling is
correctly managed.

Reproducer:
cat << EOF | qemu-system-m68k -display none
-machine accel=qtest, -m 512M -machine q800 -qtest stdio
write 0x5000166d 0x1 0x10
write 0x5000000b 0x1 0x10
EOF

Signed-off-by: Zheyu Ma zheyuma97@gmail.com
---
 hw/input/adb.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/input/adb.c b/hw/input/adb.c
index aff7130fd0..2d65ad3f4d 100644
--- a/hw/input/adb.c
+++ b/hw/input/adb.c
@@ -98,10 +98,12 @@ int adb_request(ADBBusState *s, uint8_t *obuf, const uint8_t *buf, int len)
 
     trace_adb_bus_request(buf[0] >> 4, adb_commands[buf[0] & 0xf], len);
 
-    assert(s->autopoll_blocked);
+    adb_autopoll_block(s);
 
     ret = do_adb_request(s, obuf, buf, len);
 
+    adb_autopoll_unblock(s);
+
     trace_adb_bus_request_done(buf[0] >> 4, adb_commands[buf[0] & 0xf], ret);
     return ret;
 }
-- 
2.34.1


