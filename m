Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 155E2CD3439
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 15:54:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wL129-00060S-Is; Thu, 07 May 2026 11:53:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wL127-0005vm-Nk
 for qemu-devel@nongnu.org; Thu, 07 May 2026 11:53:03 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wL125-00044p-OX
 for qemu-devel@nongnu.org; Thu, 07 May 2026 11:53:03 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-488af96f6b2so12026125e9.0
 for <qemu-devel@nongnu.org>; Thu, 07 May 2026 08:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778169180; x=1778773980; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=SuI/0Iy0vf4QgZARr662releQeW3onqVv+qjOrLL2hU=;
 b=UsReYeasiiKHY8vQ1bqj5c9XxFkAsTeE95MjqoG1O/HJTOx7ItcgruNAPx/y1SAIMU
 ut95m1YpOz5D5dAGKUehx879CcCSG6h9bw6caTGB2K+LgapeOKujk+j9sERihXtYg4nN
 vo4B6ut2kmLNwvifrBAIzgUitzh95swp49sn8P8dwCEAJICSadgMqAkrxFwr17jcLokr
 +O19ffZ+bUg4x4+JRoF0DwLN8d4qdEy2BmwOhq0ZbWlhf5+zuhczvf42a3rTzYfu/zTV
 d1Bx2QqjFZDnVtEFU2/CVWi7NUYIAJkBwymFQ9dUWLjkkorEU9qmNKFdp54+eDO3V34B
 OlPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778169180; x=1778773980;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=SuI/0Iy0vf4QgZARr662releQeW3onqVv+qjOrLL2hU=;
 b=J0fuOhSyobOAJisbIHby0kFjVX3IfIF2qJ6fGlvYRauRNsxphyDM9tpTy4XV3DQjb0
 5w+Ze8MaBTtJXYi9IkcEtecYjP7epsjxOCOXx1G8ukgvoUPT1vy4KEy2bNHzNIsBl6FO
 E+uQ7WqNCTM6Sjh/3XKEJvB/hXT23UoTVZypUvYu6X58DLrcxN8TaMjue95kR7ZmcGhV
 SIYbxjC0dWfHBakB+5Rsto/ZXIzKyJOrxDaJAcb0tuI5/DLbH4tVUw4FQILzZgHFRju9
 Z3MXUPhT0d73/W4cIe+jP9jqGxmaDU2E+2aiXVExMdGDLmvRVDXEukpE3pS+L5jZiZKG
 CiZg==
X-Gm-Message-State: AOJu0Yx8hOCp/59+qY2g3djqhWz9DG4dm+7KCQcor7yHA3E1RhzgcBUi
 q6RT7QBovcr8mBJda7Ku0IpRRfjn49rSshzr35WgLWFC1UeYnB+CrAK/+mV1aukOEfl1/xDR6UV
 odkGo
X-Gm-Gg: AeBDiesl0hO3f5Iz125fymilBiIle4kvW4yZjLxCigJFdV5BJClMaMgfEci0WQkHcNV
 UYv5DEsIpYO3aotj4sQquLP7HgWy9+VwkamOoWU5woc7dy35z3WpTuhMJhQqc0/5vEcNvv5x5Kp
 Gm/fidfA5Gtjh0YZaJLFAdYjeVsO0nqU1kb7boMcz8yD1jKsF97t8J4Omso62MHL0naNi9StMyj
 /mEHPP2MzZBF26vwfHg2fYIEFMiGLUYpe4qB6v2rTEbN9IURqmjSdgyfsm8BxgOByuUnNGucQQn
 TolqAEmQWCq7sYf5OqsTTJk4zKuCJzxKuw6FuiOZXx85e9IlmsA5ckZg6Jyqxzt1XjWVK/L/4c/
 iyHx+atcNHcuT/4tqWT5GE9PN0JLTVy9niSrYFL5wuigN6WfAzkbNTj4Rleokjqxh2S/VHXDy9e
 R64Y+UoJJfqAZeMT6spT39QM1GKy7RbKZhqmIN/AVu+4iLBZJu31Vx+uPSsyd/fDLGwGgRNoohL
 uWFhJKFcLI0kN3uCq1dKR6Gwuy5whA=
X-Received: by 2002:a05:600c:3548:b0:489:1c1f:35f1 with SMTP id
 5b1f17b1804b1-48e51e09706mr134453345e9.4.1778169180217; 
 Thu, 07 May 2026 08:53:00 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e5312df8dsm41552195e9.18.2026.05.07.08.52.59
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 08:52:59 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 67/67] hw/misc/bcm2835_rng: Specify valid memory access sizes
Date: Thu,  7 May 2026 16:51:54 +0100
Message-ID: <20260507155154.1886557-68-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260507155154.1886557-1-peter.maydell@linaro.org>
References: <20260507155154.1886557-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The BCM2835 RNG has 32-bit registers only; specify this in
the MemoryRegionOps so wrong-sized accesses are rejected rather
than getting to the assertions in the read and write functions,
and for clarity add the matching .impl constraints.

Cc: qemu-stable@nongnu.org
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3394
Fixes: 54a5ba13a9f ("target-arm: Implement BCM2835 hardware RNG")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20260501162700.4092512-1-peter.maydell@linaro.org
---
 hw/misc/bcm2835_rng.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/misc/bcm2835_rng.c b/hw/misc/bcm2835_rng.c
index e4d2c224c8..4492e325b4 100644
--- a/hw/misc/bcm2835_rng.c
+++ b/hw/misc/bcm2835_rng.c
@@ -93,6 +93,10 @@ static const MemoryRegionOps bcm2835_rng_ops = {
     .read = bcm2835_rng_read,
     .write = bcm2835_rng_write,
     .endianness = DEVICE_NATIVE_ENDIAN,
+    .impl.min_access_size = 4,
+    .impl.max_access_size = 4,
+    .valid.min_access_size = 4,
+    .valid.max_access_size = 4,
 };
 
 static const VMStateDescription vmstate_bcm2835_rng = {
-- 
2.43.0


