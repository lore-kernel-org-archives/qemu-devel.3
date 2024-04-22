Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5DB9C4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Apr 2024 12:53:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rytAE-0001gJ-U8; Mon, 22 Apr 2024 08:52:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1rytA6-0001Ys-2s
 for qemu-devel@nongnu.org; Mon, 22 Apr 2024 08:52:47 -0400
Received: from mail-lj1-x233.google.com ([2a00:1450:4864:20::233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1rytA4-0006Ol-EQ
 for qemu-devel@nongnu.org; Mon, 22 Apr 2024 08:52:45 -0400
Received: by mail-lj1-x233.google.com with SMTP id
 38308e7fff4ca-2dd615b6c44so14036941fa.0
 for <qemu-devel@nongnu.org>; Mon, 22 Apr 2024 05:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713790362; x=1714395162; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=016dPan8iD0jaVU8GbAMdou82zyqcKjvvzowQZ1c5wk=;
 b=VreUoioiBEbZvE/gNOfb1M3pCEcXJXOS+bYCaQOh4OqEdVdG7bjrXbgWZyvGaIhrpG
 DeG57aSXF4irN2rdGERL4KaCCeYwebbUd/0rlIbHHWJ8XLRhpBN865iBpGZEgXpcR7Ls
 Le1Kq5cWm76sY/S1Q4T+QmPpanVfmRoMfVOyQTccdYFe54FQGn/79y4C3EFfceIMtb7a
 l8CQcJjFRxYnagu1H6WM7NPH3aU70exfi6GpfrHtB9lLDL4yTC+oZ2fQexXg+sUFQHd0
 h77NvW6v0MTQ7Ed3+O2JFhmbNTUcGnq5wypAIW1voK2qCnU5K94bvgHQphkcccAYyjiN
 mU/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713790362; x=1714395162;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=016dPan8iD0jaVU8GbAMdou82zyqcKjvvzowQZ1c5wk=;
 b=Ry7T9D1ccMjcvO171B0g7V5hZR9iC0XZ+cfsOXP917vC7tEJtgJo3ppMFssHKIouq4
 wNqX2E/S4F8G/eE3xyf4rIkr/Bm+gCflJ4mKxLY8eQbBfiQpofsR3WsmHt7mRa4cIevD
 eqkiXjy/kesXVnSIIp+WzcO23PjacTV0TUc9V6KBHzfl1OG0raJ6iF9AMUsmpLOzHyeC
 tESlU9v9zUnJtWIMKUyYg5a0dvGx4t+TKSHUuLEBW54MBWpvfuP0L31kS+KSBYuS6Ps5
 bMlypLIsuDWo8KIyM6Mf+EY5GyYLliH/RTwj85S75+z+Qo+W48J2pbmCRYjnOh7O7elq
 NELw==
X-Gm-Message-State: AOJu0YwqFIfoWJWkstKVkJNp3D+vamI7BBPZ04oCzSo6RZtFIPNm3B5v
 fmdY+FQNIf3JMLkhzaRDhHKnGkAw95WJgw7vIy9TxyNtlsy79LHZnQlh4W4INqYIwI6GE8p/2qH
 v
X-Google-Smtp-Source: AGHT+IFN99FDses3uFukVhJUkq6/1Lb3OUcMf2Qh6An4MVy2EryRsR68TDkdYvRHy5nAfX10LSjwbA==
X-Received: by 2002:ac2:4bc3:0:b0:518:91fd:b343 with SMTP id
 o3-20020ac24bc3000000b0051891fdb343mr7364183lfq.68.1713790362127; 
 Mon, 22 Apr 2024 05:52:42 -0700 (PDT)
Received: from localhost.localdomain (adsl-53.37.6.0.tellas.gr. [37.6.0.53])
 by smtp.gmail.com with ESMTPSA id
 l10-20020a1709066b8a00b00a55bfb4e3b6sm593574ejr.217.2024.04.22.05.52.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Apr 2024 05:52:41 -0700 (PDT)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org,
	qemu-stable@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Zheyu Ma <zheyuma97@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v1 1/4] virtio-snd: add virtio_snd_is_config_valid()
Date: Mon, 22 Apr 2024 15:52:11 +0300
Message-ID: <491c651b075ac51f1c54f561bebaaac6dfc7f8de.1713789200.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1713789200.git.manos.pitsidianakis@linaro.org>
References: <cover.1713789200.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::233;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-lj1-x233.google.com
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

Factor out virtio_snd_config value validation in a separate function, in
order to re-use it in follow up commits.

Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 hw/audio/virtio-snd.c | 47 ++++++++++++++++++++++++++-----------------
 1 file changed, 29 insertions(+), 18 deletions(-)

diff --git a/hw/audio/virtio-snd.c b/hw/audio/virtio-snd.c
index c80b58bf5d..7ca9ed251c 100644
--- a/hw/audio/virtio-snd.c
+++ b/hw/audio/virtio-snd.c
@@ -1045,6 +1045,34 @@ virtio_snd_vm_state_change(void *opaque, bool running,
     }
 }
 
+static bool
+virtio_snd_is_config_valid(virtio_snd_config snd_conf, Error **errp)
+{
+    if (snd_conf.jacks > 8) {
+        error_setg(errp,
+                   "Invalid number of jacks: %"PRIu32
+                   ": maximum value is 8", snd_conf.jacks);
+        return false;
+    }
+    if (snd_conf.streams < 1 || snd_conf.streams > 64) {
+        error_setg(errp,
+                   "Invalid number of streams: %"PRIu32
+                   ": minimum value is 1, maximum value is 64",
+                   snd_conf.streams);
+        return false;
+    }
+
+    if (snd_conf.chmaps > VIRTIO_SND_CHMAP_MAX_SIZE) {
+        error_setg(errp,
+                  "Invalid number of channel maps: %"PRIu32
+                  ": VIRTIO v1.2 sets the maximum value at %"PRIu32,
+                  snd_conf.chmaps, VIRTIO_SND_CHMAP_MAX_SIZE);
+        return false;
+    }
+
+    return true;
+}
+
 static void virtio_snd_realize(DeviceState *dev, Error **errp)
 {
     ERRP_GUARD();
@@ -1055,24 +1083,7 @@ static void virtio_snd_realize(DeviceState *dev, Error **errp)
 
     trace_virtio_snd_realize(vsnd);
 
-    /* check number of jacks and streams */
-    if (vsnd->snd_conf.jacks > 8) {
-        error_setg(errp,
-                   "Invalid number of jacks: %"PRIu32,
-                   vsnd->snd_conf.jacks);
-        return;
-    }
-    if (vsnd->snd_conf.streams < 1 || vsnd->snd_conf.streams > 10) {
-        error_setg(errp,
-                   "Invalid number of streams: %"PRIu32,
-                    vsnd->snd_conf.streams);
-        return;
-    }
-
-    if (vsnd->snd_conf.chmaps > VIRTIO_SND_CHMAP_MAX_SIZE) {
-        error_setg(errp,
-                   "Invalid number of channel maps: %"PRIu32,
-                   vsnd->snd_conf.chmaps);
+    if (!virtio_snd_is_config_valid(vsnd->snd_conf, errp)) {
         return;
     }
 
-- 
γαῖα πυρί μιχθήτω


