Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A61FE77188
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2025 15:13:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTMsd-0007U9-Hb; Thu, 02 Jan 2025 10:13:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tTMsY-0007Tl-VN
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 10:12:55 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tTMsX-0006UV-Dt
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 10:12:54 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-385df53e559so8988499f8f.3
 for <qemu-devel@nongnu.org>; Thu, 02 Jan 2025 07:12:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735830771; x=1736435571; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jzeo4aQg6DouqNm9ntCEUK8qegBuD5L5E5v2+2/k5ko=;
 b=Xq9KCM/lMMO8ea9iHnb35tjtVrBWw9SQeoSY45N/eb/Mu6cpeXb3bxIuIE6a4a72Qd
 pVwP+nrq3lYro0zeowBAX8SdJKaaVwE7nPOCBhYoFX92wr3+NJnk+8DZZvDmpmD6aAxP
 Wid9XX63cftl0Dy+dA4B4dqZbtBR1R5jQejwDxV00en0H5rjSUbe4yEQ1rt8OPiNaS1Z
 iS+uL3nEiysZ6QGi+z4pCvtZtGWAXILFOpkqOlGXiiwABj473LTZjbGyQkPQ+9Sk4UY2
 6ziQ3uzEOeJbhEE8hIGPznvht3OazG+Rjrcp8VxsUWUtOHXL4Kg4F7jhRScNZY5083Bb
 2yZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735830771; x=1736435571;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jzeo4aQg6DouqNm9ntCEUK8qegBuD5L5E5v2+2/k5ko=;
 b=iAZWoZFL7PloeXJjmQhzn57mNWIaCAyYV7plxDh6EOxtDPhZre3vLtJn+cE0DRbiA1
 r8nKgmagICup8k1vMIGKs/oTYBv6QmDXoXut3tEv52KF7dxv+AfDQoTjrK6Oy0C5xU6A
 A9b8+ZirYAF2APstP24Q4uQ9Wx4wrOQom3d+HM3AcB9aupgA0v17V7ou7o6cbtKbefx4
 bijgRVB2H/8smqxaXcg3Eko8RRJ39/63NDOIpcV/GxZqCHzkACmJ1l1WPHe7t50zW7rx
 6Te+1YrACmvD1wWfB1BPtff0Zh63Zja2qVy0Z8oEXbVUOQ8vOFbAhes1PncSE7/s4Ro5
 rSUQ==
X-Gm-Message-State: AOJu0YyQ4bkW56ci5vYNSmdK1ehHqOgYwYGKz8IhgPlu7GJeGIH/Jt/6
 rdc6k8UNHcduqbHoQtORweILrSgESIdYTEUW3YGW8+BQqGZRIl19aXb91486WTbYSbJH5RgoTBl
 iwTOpZw==
X-Gm-Gg: ASbGncvClFgX/wlmF7C6b9C5lOsvPUqlxxgLVvjAPiFnqRvgdy5Kc4vb/mYm2JKu1vs
 TjqbEmdy5IL7sk0uDuzUgBylV9zx27pQrxSaye9Y8sRQRTi/Gg0d7a2hWB0H3tKPF3tWqnE4iie
 4Ghdo/gEvFQdGAY073sxAhle/2hPOpBnPE1HT1HsRM/HKomMTNRDg1/S6QrXwnIvSW6QAnSBTb5
 0osi/cJK7ck4VZRLpDg4css678cBEz/XRkRjtUwJVzV50kY8KT+4n4bkkqvcKghCif5ltpTTKUe
 3T21ImyzPe/dcQtgkSKOCEXTyunaZeQ=
X-Google-Smtp-Source: AGHT+IE5KTt66gfZnmcmbIim6wK/o8LuuBjGW/26f7912+Ig6GDOP9dnvLZl2opUkB1bgMP9d+h6mg==
X-Received: by 2002:a5d:5e09:0:b0:385:ddd2:6ab7 with SMTP id
 ffacd0b85a97d-38a2240874bmr42102687f8f.52.1735830771342; 
 Thu, 02 Jan 2025 07:12:51 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a1c8acafesm38227583f8f.98.2025.01.02.07.12.50
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 02 Jan 2025 07:12:50 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-block@nongnu.org, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 David Hildenbrand <david@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Zhenwei Pi <pizhenwei@bytedance.com>, Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Xu <peterx@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 01/10] qdev: Expose qemu_create_machine()
Date: Thu,  2 Jan 2025 16:12:35 +0100
Message-ID: <20250102151244.59357-2-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250102151244.59357-1-philmd@linaro.org>
References: <20250102151244.59357-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

We need to create a 'fake' machine container for the
QOM API. We already have the system implementation
for qemu_create_machine(). Expose its prototype to
be able to add the user implementation.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/qdev-core.h | 2 ++
 system/vl.c            | 3 ++-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
index e6ef80b7fd0..bf8a0ee6486 100644
--- a/include/hw/qdev-core.h
+++ b/include/hw/qdev-core.h
@@ -1106,6 +1106,8 @@ void device_listener_unregister(DeviceListener *listener);
  */
 bool qdev_should_hide_device(const QDict *opts, bool from_json, Error **errp);
 
+void qemu_create_machine(QDict *qdict);
+
 typedef enum MachineInitPhase {
     /* current_machine is NULL.  */
     PHASE_NO_MACHINE,
diff --git a/system/vl.c b/system/vl.c
index 0843b7ab49b..33fbb9f32f3 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -28,6 +28,7 @@
 #include "qemu/units.h"
 #include "exec/cpu-common.h"
 #include "exec/page-vary.h"
+#include "hw/qdev-core.h"
 #include "hw/qdev-properties.h"
 #include "qapi/compat-policy.h"
 #include "qapi/error.h"
@@ -2128,7 +2129,7 @@ static void qemu_create_machine_containers(Object *machine)
     }
 }
 
-static void qemu_create_machine(QDict *qdict)
+void qemu_create_machine(QDict *qdict)
 {
     MachineClass *machine_class = select_machine(qdict, &error_fatal);
     object_set_machine_compat_props(machine_class->compat_props);
-- 
2.47.1


