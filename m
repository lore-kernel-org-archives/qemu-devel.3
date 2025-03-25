Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72955C3600D
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Mar 2025 22:48:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txD0U-0002MF-1v; Tue, 25 Mar 2025 18:44:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1txD00-00010I-7Q
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 18:43:58 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1txCzx-0006zk-Gx
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 18:43:55 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-43ce70f9afbso60889485e9.0
 for <qemu-devel@nongnu.org>; Tue, 25 Mar 2025 15:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742942632; x=1743547432; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eP0RXPwsF3SX47mGX273slrVOKCgPW3RL9KKH1EnAUU=;
 b=y5Kg2eQrWYPcuhZoVCOgic3gwlOIjNWl9ZJ8oR0nCY3lIbNI0sMC9mh9XwYHMAspcr
 h43tzhoyH1e0T36HxGNSdduO3DQzeThDxkv3gTSaPgBpE6MCSDO+xNfcloTtb0KNABaU
 pmQKRkBZOTftWE/rsW7C06tkhMHaINzenmDKHbE2q866Tq0RG/F0uDgWHsM84jmJCIdD
 vLOP6mghI4E91ZirX82zuhNo6qUH4DM20ixXTt2rw3FQkIFIbDCpT4LXpqOPwBw5f5bZ
 WynyfwLzvbKQxGOqfGfoQVE7UTTc34KVKGXFHFbHm4B7oiJbnqfjAaHIidhNlh7eNSSB
 NFfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742942632; x=1743547432;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eP0RXPwsF3SX47mGX273slrVOKCgPW3RL9KKH1EnAUU=;
 b=TmtB6Osn3u+vbjgs6dBaDldgVFkNL3dXGxU/qfT+bAnZrB4IorUkojB64LjNN4abqm
 Y10Om6pMwWh+LlBTBnCiY/EndwP+ZiYAGYhbQAanIA3bhbAbOV5RTOF6t/qRSVWfrb/1
 dKkF18J5JIYSGhW+WM89656ZooXN4lAilU2ZRPAm7grUSwx3Hiy+qF9rH4ptn18WpycY
 ICzXKbhHgQ+z0fqj6EH8xjaR0I003sUP8lxtJ8c78U4i3+WW7gc6ePuK8s27FtLawvNr
 sI4iribx8GZCg7CXJgGA5UPqZBn7CPvNk6yibHbAFJk/b/6BBklyfnN9WzVw1qYcKgUa
 vCAQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVCD/dAvhIygI4dNGgYyMCZXUZei6ZKMzSDF0Mo069JqB4eK74V3zSPXiZ3+cM25ob1LoIi3YbbbvtX@nongnu.org
X-Gm-Message-State: AOJu0YzffC/LYGPaWqHZySf8xD2EzqzrXgPg9ruSf8CL0nLQLUthkFsU
 V2enydWR93zlfUpkrI4zsXnHHCmKyWPDYra1FCH4MF4kDuCn+AgvYRD1DRc5BEE=
X-Gm-Gg: ASbGnctr4D124jcU5evyoH+ivA3w7R1arEAJDgOkp5aVTCbPWtj8K50ow/LihPbjlDv
 bFPBDVp2I7MTo4ZYpdQ6hr1kzoF3EoicA+PH08YdCY9qHayhdiqj5I0R3A1uv6CutqYCFncGFkD
 AV+KJXZl8h8sQ4adJl7SCd/63ouGA+AgAd/+Obzg+RPP8HbUHKq9+8znSsF0L6I+1xDVYN6TBHi
 0QHPu4VTlRYbddCH4a+UK2zj/Vo5Bh7rAeXJDTk9CLa3+u+OIDVfFklyqDAcc1XITR/S0oYW+Db
 xyNqPOWcATSC4dhEsMRa5jEBBrFgPT01dEQZ3glUIEXxjRLCFSjh0DOCZliGlhRGLX6VsHi9ETC
 WWXaQAAAN/Ipj32O1DAk=
X-Google-Smtp-Source: AGHT+IFRD/qFLzoLgvBst6JqhurFyP69z55jO8SNGLjYctQKmdZPg3mLwjwd/KwbbwRGh7MUlT+PLg==
X-Received: by 2002:a05:6000:144e:b0:38f:28cb:4d35 with SMTP id
 ffacd0b85a97d-3997f902c76mr19201735f8f.13.1742942631785; 
 Tue, 25 Mar 2025 15:43:51 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d43f33237sm214876075e9.4.2025.03.25.15.43.49
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 25 Mar 2025 15:43:50 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Thomas Huth <thuth@redhat.com>,
	qemu-devel@nongnu.org
Cc: Ilya Leoshkevich <iii@linux.ibm.com>, BALATON Zoltan <balaton@eik.bme.hu>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Glenn Miles <milesg@linux.ibm.com>, Samuel Tardieu <sam@rfc1149.net>,
 qemu-block@nongnu.org, Patrick Leis <venture@google.com>,
 David Hildenbrand <david@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Tyrone Ting <kfting@nuvoton.com>, Eric Farman <farman@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Halil Pasic <pasic@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>, Alistair Francis <alistair@alistair23.me>,
 Bernhard Beschow <shentey@gmail.com>, Hanna Reitz <hreitz@redhat.com>,
 Hao Wu <wuhaotsh@google.com>, qemu-s390x@nongnu.org, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org
Subject: [PATCH-for-10.0 07/12] hw/misc/axp2xx: Categorize and add description
Date: Tue, 25 Mar 2025 23:43:05 +0100
Message-ID: <20250325224310.8785-8-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250325224310.8785-1-philmd@linaro.org>
References: <20250325224310.8785-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/misc/axp2xx.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/misc/axp2xx.c b/hw/misc/axp2xx.c
index af646878cd2..747af430479 100644
--- a/hw/misc/axp2xx.c
+++ b/hw/misc/axp2xx.c
@@ -232,6 +232,7 @@ static void axp2xx_class_init(ObjectClass *oc, void *data)
     ResettableClass *rc = RESETTABLE_CLASS(oc);
 
     rc->phases.enter = axp2xx_reset_enter;
+    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
     dc->vmsd = &vmstate_axp2xx;
     isc->event = axp2xx_event;
     isc->recv = axp2xx_rx;
@@ -250,7 +251,9 @@ static const TypeInfo axp2xx_info = {
 static void axp209_class_init(ObjectClass *oc, void *data)
 {
     AXP2xxClass *sc = AXP2XX_CLASS(oc);
+    DeviceClass *dc = DEVICE_CLASS(oc);
 
+    dc->desc = "AXP209 power system management";
     sc->reset_enter = axp209_reset_enter;
 }
 
@@ -263,7 +266,9 @@ static const TypeInfo axp209_info = {
 static void axp221_class_init(ObjectClass *oc, void *data)
 {
     AXP2xxClass *sc = AXP2XX_CLASS(oc);
+    DeviceClass *dc = DEVICE_CLASS(oc);
 
+    dc->desc = "AXP221 power system management";
     sc->reset_enter = axp221_reset_enter;
 }
 
-- 
2.47.1


