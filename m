Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEB6CEDEC12
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 06:17:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxfYC-0004E0-Cd; Wed, 04 Mar 2026 01:17:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vxfY2-0004D2-AQ
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 01:17:30 -0500
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vxfXz-0003Do-OK
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 01:17:30 -0500
Received: from h205.csg.ci.i.u-tokyo.ac.jp (h205.csg.ci.i.u-tokyo.ac.jp
 [133.11.54.205]) (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 6246H77p067747
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 4 Mar 2026 15:17:17 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=vY+4Rsvg0HuZUdHE/2Ro9vn7o9zZJTMljh3ei5y/9SE=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-Id:To:Subject:Date;
 s=rs20250326; t=1772605037; v=1;
 b=AxByF8kHq1nT5X60F1U/DrNsxyetgs2vcEL25sZFk1i0g+9crOr+v50pTSPlr6kx
 kTXLASkbRM/upirnXO3O2esFmt8NzMhg6tFikIHsxQrqZ5KWmxLRkX5oWeIMyqK7
 3B1ffMz0GbMWWaegYM1/nTUlqyEjv+eU8v75zRre7fHzIqKaO8UDhEtjAdScnrpg
 GT5WrCOaopxROjSZZRZ6j+5h6Zu19ZmBM63ID2xnxT0nz/vUL3indRmJo+J0mS3x
 9eFKmyJQkhN7WToH3foL/BMHrk2hH/6xPtEbTIJtP9X0NNVIfJW8srhP9gx+XidQ
 yRUR0oLNEI46vk8e5FSU1w==
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Subject: [PATCH v8 0/6] coreaudio fixes
Date: Wed, 04 Mar 2026 15:16:53 +0900
Message-Id: <20260304-coreaudio-v8-0-bf1d40731e73@rsg.ci.i.u-tokyo.ac.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFXOp2kC/3XOPW4DIRCG4atY1CGCZfhLlXtYLoCBmCKLxSYrW
 9bePWMrBdEq5Yd4Xs2dLbnXvLC3w531vNaltpmGezmwdA7zR+YVabNJTFpI4XlqPYdvrI0n78A
 ImyW6xOj/pedSr8/W8UT7XJev1m/P9Koer78VqYfKqrjgEaOJKepYfHnHcJvr9TW1T/bIrDBSO
 1IgWhxCCUC4wI7qgU5qpJqocVZhgUnqIHbUjBRGaohKWehek8Cm/cH2X2qJevQB0EuMyv6h27b
 9ABpPaJuPAQAA
X-Change-ID: 20250109-coreaudio-c984607e1d8c
To: Gerd Hoffmann <kraxel@redhat.com>,
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, devel@daynix.com,
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Phil Dennis-Jordan <phil@philjordan.eu>
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

This series contains two fixes for coreaudio. See each one for details.

Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
---
Changes in v8:
- Rebased.
- Link to v7: https://lore.kernel.org/qemu-devel/20250124-coreaudio-v7-0-9d9a4d91db37@daynix.com

Changes in v7:
- Added patch "coreaudio: Remove extra whitespaces".
- Link to v6: https://lore.kernel.org/qemu-devel/20250124-coreaudio-v6-0-11fbcb6c47cf@daynix.com

Changes in v6:
- Added patch "coreaudio: Remove unnecessary explicit casts".
- Link to v5: https://lore.kernel.org/qemu-devel/20250123-coreaudio-v5-0-6873df4215a0@daynix.com

Changes in v5:
- Added patch "coreaudio: Improve naming", removing verbose names like
  outputDeviceID and audioDevicePropertyBufferFrameSize altogether.
- Link to v4: https://lore.kernel.org/r/20250117-coreaudio-v4-0-f8d4fa4cb5f4@daynix.com

Changes in v4:
- Splitted patch "audio: Add functions to initialize buffers" from
  patch "coreaudio: Initialize the buffer for device change".
- Changed the message of patch "coreaudio: Commit the result of init in
  the end" to tell that early returns happen when there is a fatal error
  or the device gets unplugged.
- Link to v3: https://lore.kernel.org/r/20250115-coreaudio-v3-0-bdb6bcb5bf9f@daynix.com

---
Akihiko Odaki (6):
      coreaudio: Remove unnecessary explicit casts
      coreaudio: Remove extra whitespaces
      coreaudio: Improve naming
      coreaudio: Commit the result of init in the end
      audio: Add functions to initialize buffers
      coreaudio: Initialize the buffer for device change

 audio/audio_int.h       |   2 +
 audio/audio-mixeng-be.c |  24 ++++--
 audio/coreaudio.m       | 206 +++++++++++++++++++++++++-----------------------
 3 files changed, 127 insertions(+), 105 deletions(-)
---
base-commit: ffcf1a7981793973ffbd8100a7c3c6042d02ae23
change-id: 20250109-coreaudio-c984607e1d8c

Best regards,
--  
Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>


