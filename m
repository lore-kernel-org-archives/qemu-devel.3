Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D4FBEDEC12
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 06:18:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxfYL-0004EC-AI; Wed, 04 Mar 2026 01:17:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vxfY1-0004Cs-0C
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 01:17:30 -0500
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vxfXz-0003De-9Q
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 01:17:28 -0500
Received: from h205.csg.ci.i.u-tokyo.ac.jp (h205.csg.ci.i.u-tokyo.ac.jp
 [133.11.54.205]) (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 6246H77q067747
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 4 Mar 2026 15:17:17 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=v6Idt5M6E9tHdoXYyHcE87svc+qklUeVvG1RTj4ebPQ=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-Id:To:Subject:Date;
 s=rs20250326; t=1772605037; v=1;
 b=SXq8zv6YKmVaos6PFL7LPhgkezZYOtN6PebuLe5QW3B7phtT1F5iSKIvLx75RNBQ
 AW5mxLp+d3pmOTrtOoJij8KzO6ntYdIP6Oi+fb8YgFeNZZAVIkOkWvjPwFaiC3qA
 5q1UdanEVZ6XEv5UF3mf+0FdVMYWsIbew9ECxR7Fn9CbOLfl2kaDtMQNS/+PaGZx
 JG7RUze6ba/4qNcF/rr2KBd8avNWArfmCPtW4lMKOCEgJDyqHAIYsyWF0VlZ9QcR
 L7Z0yVbWrSWgWHPCsAAYW827taG8qUrRVR0iWpUG811PY7g1sRcPRr5cFFEF8RsE
 xBOmfCCmTVJ+IYelCbIuuw==
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Date: Wed, 04 Mar 2026 15:16:54 +0900
Subject: [PATCH v8 1/6] coreaudio: Remove unnecessary explicit casts
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260304-coreaudio-v8-1-bf1d40731e73@rsg.ci.i.u-tokyo.ac.jp>
References: <20260304-coreaudio-v8-0-bf1d40731e73@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260304-coreaudio-v8-0-bf1d40731e73@rsg.ci.i.u-tokyo.ac.jp>
To: Gerd Hoffmann <kraxel@redhat.com>,
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, devel@daynix.com,
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
X-Mailer: b4 0.15-dev-5ab4c
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -1
X-Spam_score: -0.2
X-Spam_bar: /
X-Spam_report: (-0.2 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.322,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=1.141, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

coreaudio had unnecessary explicit casts and they had extra whitespaces
around them so remove them.

Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
---
 audio/coreaudio.m | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/audio/coreaudio.m b/audio/coreaudio.m
index a28fa77d73ff..cbda4f143698 100644
--- a/audio/coreaudio.m
+++ b/audio/coreaudio.m
@@ -310,7 +310,7 @@ static OSStatus audioDeviceIOProc(
     UInt32 frameCount, pending_frames;
     void *out = outOutputData->mBuffers[0].mData;
     HWVoiceOut *hw = hwptr;
-    coreaudioVoiceOut *core = (coreaudioVoiceOut *) hwptr;
+    coreaudioVoiceOut *core = hwptr;
     size_t len;
 
     if (coreaudio_buf_lock (core, "audioDeviceIOProc")) {
@@ -394,11 +394,11 @@ static OSStatus init_out_device(coreaudioVoiceOut *core)
     }
 
     if (frameRange.mMinimum > core->frameSizeSetting) {
-        core->audioDevicePropertyBufferFrameSize = (UInt32) frameRange.mMinimum;
+        core->audioDevicePropertyBufferFrameSize = frameRange.mMinimum;
         warn_report("coreaudio: Upsizing buffer frames to %f",
                     frameRange.mMinimum);
     } else if (frameRange.mMaximum < core->frameSizeSetting) {
-        core->audioDevicePropertyBufferFrameSize = (UInt32) frameRange.mMaximum;
+        core->audioDevicePropertyBufferFrameSize = frameRange.mMaximum;
         warn_report("coreaudio: Downsizing buffer frames to %f",
                     frameRange.mMaximum);
     } else {

-- 
2.53.0


