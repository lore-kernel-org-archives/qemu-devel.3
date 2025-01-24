Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5933CC0218B
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2025 04:48:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbBbX-0002CI-TU; Thu, 23 Jan 2025 23:47:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tbBbW-0002C3-6k
 for qemu-devel@nongnu.org; Thu, 23 Jan 2025 23:47:38 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tbBbU-0004Zb-R6
 for qemu-devel@nongnu.org; Thu, 23 Jan 2025 23:47:37 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-21680814d42so27383395ad.2
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2025 20:47:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1737694055; x=1738298855;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=fWOg7aqqH8nu4hr/5SdBWnNPemUm1VuYD9oCJuZW3aE=;
 b=Yf7sW242y2ERKrpgJORkeLjo86ekfEL6eH3sBZ9d1b6A8UA/nf0MzkEUDXp/N+rIf8
 nJryKhv+gIT2fyCGH4ssRRyvG0MP9KqB7Fch5KyP/kVN3SyM8/0Ge9qBHcORPvhyvlXf
 TQNWMSWS/oN8Pepqbv77tnOo+vphKP7AXKSN8Dxzb/FrSKjRXjo06txxwDimoYtVZLiq
 GNzsUb4nuKAXjEiR/EsMCjt5CBzLFyGQQi+qDz1nsHlMFMAGd+n91bu4jHoatPJEHHPa
 65RMPpHk+/7FTy1/V1BVbYpVjBmmlthYR6/VKSUCjJy0WrLTvdBtXwZxdLKQ0KsJHAtM
 Qdjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737694055; x=1738298855;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fWOg7aqqH8nu4hr/5SdBWnNPemUm1VuYD9oCJuZW3aE=;
 b=JtA6iSawGieQcrAjIX+FwnkfOCCuyGpcW3ZQsGkt0zaNWkyXBdoaqfWADigM+h9v5Y
 W/NmahUPCWs5dy5Ff5I8UbGdjY+8bEHm1pb7DoUKCdtoCKJNj8LlFrEhbw1LKbWCCzTq
 3guy5pjAfwmIRg2Dbp4wLDnG3UtxYuHXU6060E9FaIRZmyL9f3CCEOTCHrxjGIoD5iAT
 oyxo39Rl35WF/qlyKn3CZOWMgwccYoCkHxQYK/qH2UqVlcd2EwfHP+iG4/yyB5JgA6kg
 QZRve3U5EYjrDZWHQAymAvF7mox3GAJ6STqbhfPcHEJbJC7mm0LQAzPlpw5xqQC1GMDa
 Uukg==
X-Gm-Message-State: AOJu0YyKOsMC8/5/QYDXUTnH8LcL5tCpSAhsC6QTL2D6jjAqNpQUKKdq
 Y11djh03lsX1RTwWwkVSXLUefe0LC0aJlmITwPZyGCCg5skdxX5AseGOOCJjxFc=
X-Gm-Gg: ASbGncuLzRAfqVuE+o0XfxrbHtW0TmfJHTbrPvSrUufGW948JSjBNG+penskD2vSfcp
 fE5dTDSgIV06UuErzq49LFTRd89HAWGzwW6fneomZPDKbc/zap1TJa7zZH5j+DboHOsKHhOLPHw
 Ev5cxMdhWLGs8l7Vo8aWcE4oh2u2H5MBUA4epucP6jruX0VZy38q+aWRTjPWfb4BBtoZD+XzBsc
 GfWR3q+aIQcx5xpm1O+j8hFXBV+lHaN5xdtm/OGtv7HY0iQk1Md4qLJnC036zquQRbGgpDbWbt0
 JSdH6BAy
X-Google-Smtp-Source: AGHT+IEPyTfoIfaOFcNA3mKbm3rw1E6lj09kAm3vncu8SxIPog25Xj5NILL0mlaA9gfh8EvfVoY/CA==
X-Received: by 2002:a05:6a20:a12a:b0:1e6:51d2:c8a3 with SMTP id
 adf61e73a8af0-1eb21481781mr42563687637.10.1737694055163; 
 Thu, 23 Jan 2025 20:47:35 -0800 (PST)
Received: from localhost ([157.82.207.107])
 by smtp.gmail.com with UTF8SMTPSA id
 d2e1a72fcca58-72f8a6b323esm886124b3a.60.2025.01.23.20.47.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Jan 2025 20:47:34 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Fri, 24 Jan 2025 13:47:11 +0900
Subject: [PATCH v6 1/5] coreaudio: Remove unnecessary explicit casts
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250124-coreaudio-v6-1-11fbcb6c47cf@daynix.com>
References: <20250124-coreaudio-v6-0-11fbcb6c47cf@daynix.com>
In-Reply-To: <20250124-coreaudio-v6-0-11fbcb6c47cf@daynix.com>
To: Gerd Hoffmann <kraxel@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Christian Schoenebeck <qemu_oss@crudebyte.com>, 
 BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, devel@daynix.com, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14.2
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62e.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

coreaudio had unnecessary explicit casts and they had extra whitespaces
around them so remove them.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 audio/coreaudio.m | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/audio/coreaudio.m b/audio/coreaudio.m
index cadd729d50537850d81718b9284efed5877d9185..0b67347ad7e8c43a77af308a1a3a654dd7084083 100644
--- a/audio/coreaudio.m
+++ b/audio/coreaudio.m
@@ -309,7 +309,7 @@ static OSStatus audioDeviceIOProc(
     UInt32 frameCount, pending_frames;
     void *out = outOutputData->mBuffers[0].mData;
     HWVoiceOut *hw = hwptr;
-    coreaudioVoiceOut *core = (coreaudioVoiceOut *) hwptr;
+    coreaudioVoiceOut *core = hwptr;
     size_t len;
 
     if (coreaudio_buf_lock (core, "audioDeviceIOProc")) {
@@ -392,10 +392,10 @@ static OSStatus init_out_device(coreaudioVoiceOut *core)
     }
 
     if (frameRange.mMinimum > core->frameSizeSetting) {
-        core->audioDevicePropertyBufferFrameSize = (UInt32) frameRange.mMinimum;
+        core->audioDevicePropertyBufferFrameSize = frameRange.mMinimum;
         dolog ("warning: Upsizing Buffer Frames to %f\n", frameRange.mMinimum);
     } else if (frameRange.mMaximum < core->frameSizeSetting) {
-        core->audioDevicePropertyBufferFrameSize = (UInt32) frameRange.mMaximum;
+        core->audioDevicePropertyBufferFrameSize = frameRange.mMaximum;
         dolog ("warning: Downsizing Buffer Frames to %f\n", frameRange.mMaximum);
     } else {
         core->audioDevicePropertyBufferFrameSize = core->frameSizeSetting;

-- 
2.48.1


