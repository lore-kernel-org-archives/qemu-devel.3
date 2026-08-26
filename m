Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB901C5DF97
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 11:17:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzBbf-0007wD-2C; Wed, 26 Aug 2026 07:15:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wzBbb-0007qv-Ku
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 07:15:44 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wzBbZ-0004LT-IX
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 07:15:43 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-6a5e866bca0so804979a12.0
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 04:15:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1787742940; x=1788347740; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=GiST71Yts4LfFL9lI6doSLjjmUxdiZhCirIUAPAqYHk=;
 b=E5nusgqc5l1Cycc+mZ59wc2pbx9FLDhQuey17SKl29hpYWi2QIRH0b7nKACJF4KmVJ
 4BxWMNS3amTTMMU14jJkPruU9Fptl+zOdztXX4Ee7iG0fEUjs+OKGOEkYQsdWYTuJLL8
 B3TC7HhSVOWa4QITJj7CreLuhJKFRECsciw6O06S7hlGGi8fBIis3L8ZNHivTOgdpIEo
 JY8wBIwFnzJA8h5oIjXuLWWbP/2FBaWimjZnCy9jpxR9xa3M+OKsw0fg7OCl8AG8Ttxv
 sTwuX5dPrS2R/OnXcowELFYeImU3fUCP0rqtyxxXH8mRbsd7vfTTnfJZ5ainVf5/R/ud
 Gwjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787742940; x=1788347740;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=GiST71Yts4LfFL9lI6doSLjjmUxdiZhCirIUAPAqYHk=;
 b=Q2+sw0gO0Ar/UePzQvMCL+ierHO/7TnZeyqFRAXW/asP/8wsQSGHGV2BRooLlVplvy
 wy77X6MSzvoyvpNe0lr6YcWHUKCwd8MmMJTCdu4lIWqkWcgqAcQdcREUKH4/nQjWFl6r
 6pMHyQU68bodx1iQV+Y0w6kEo+/x3dKYCrNgnmD4qvqw1sNfvUjpjVjAFMv11pG1aZym
 pJdcPd572Ts8eYxIbo4XkTDo+unSba37Utbd9TmJsIg9JBa3wP+FYZ4TKqFfrxZ29bjb
 FCTDfaL3/qVAovCbtU3ONkjU9/GXQV8dgY/DLhTv7tyedJXVhz7pbaJ5D6wBUgylXSLK
 jiyQ==
X-Gm-Message-State: AFuF++lYtnTPZMCU3r+fxfpA9Z4qqmO2tkqaq8/pWSTIl118DPSkEaCO
 rUTBYB9q2QBEHdrFssyRe6FLAQrRly082BBj6xxLSToCrkx6AvPkkL5AW89FClDlxWhMSj1aQvK
 RvsKR
X-Gm-Gg: AR+sD11daUNZT7nJlgid5hzqKXMpK5Q9Gj5vkH15udMklUcFB13dHVTNJ0fkCz5Lu3n
 CGVjzJO/dWP74um2xGprpiLp90TNb41FmgTuDvPh8okEQk3guhnmOGsh6UYnlRLj8Ri1OhJIgwI
 fSDRXwKcLHNQyQev8UtR+5WqI1y6v4XQXCKpXd/Xi2FVxykFqSM7VjyQ15coJAmDyzAyNwYuJvM
 dokjx9ld6DZt54Q+hf1BOvjuhDCkxKSEiZg0W5xVJx0jrxPOMOsMWXrfS2t65wtv7N1lMglX8p2
 WgsX6VBghjhVSOCKENnMyj7LXV5iotBNZuFmobmxawIRUJRn7hBWkR+JV1OHahveUHQexMq4hV+
 6F3Ifwmo0t9jwnksn+O8yjQvmsJCG5YrTS26Q+TgW+FC47hI9KbQZuvKFa/09fZ/oEuszHVZY47
 7pEOntrAZ3vw878DL8FZkFCD9Dp2iwhYDN6LkmhpOLF6aI8O0G
X-Received: by 2002:a05:6402:a503:10b0:6a5:f1bb:8376 with SMTP id
 4fb4d7f45d1cf-6a5f1bb857emr1082944a12.3.1787742940047; 
 Wed, 26 Aug 2026 04:15:40 -0700 (PDT)
Received: from athena ([2a06:5b06:b600:300:8a5:68e8:91b1:8a17])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a5de8ea655sm3951724a12.12.2026.08.26.04.15.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 04:15:39 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 John Snow <jsnow@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PULL 09/28] hw/ide: restore the power-on device state before loading
Date: Wed, 26 Aug 2026 13:15:24 +0200
Message-ID: <20260826111524.3383479-10-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260826111524.3383479-1-den@openvz.org>
References: <20260826111524.3383479-1-den@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=den@openvz.org; helo=mail-ed1-x533.google.com
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

From: Denis V. Lunev <den@openvz.org>

Loading a snapshot reuses the IDEState of the machine it is loaded into:
load_snapshot() resets the machine and then feeds the stream into the
existing devices. The reset does not help, as ide_reset() restores the
logical CHS translation only when the guest asked for power-on defaults to
be reverted with SET FEATURES 0xCC.

A guest that replaced the translation with INITIALIZE DEVICE PARAMETERS
therefore keeps it across the load of a snapshot taken before it did,
while the restored guest expects the geometry of that moment. Every CHS
access then lands on a sector other than the one asked for, with no error
reported. s->reset_reverts survives a load the same way.

Add a pre_load restoring the defaults, which
docs/devel/migration/main.rst recommends for state a stream need not
carry, and which the following subsections rely on. The
RESET_TYPE_SNAPSHOT_LOAD marking that reset would be another way to
recognise the case, but no IDE controller can see it while they all use
device_class_set_legacy_reset().

Cc: John Snow <jsnow@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Fixes: 176e4961bb33 ("hw/ide/core.c: Implement ATA INITIALIZE_DEVICE_PARAMETERS command")
Signed-off-by: Denis V. Lunev <den@openvz.org>
---
 hw/ide/core.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/hw/ide/core.c b/hw/ide/core.c
index 048655b2d0..28219f5ef8 100644
--- a/hw/ide/core.c
+++ b/hw/ide/core.c
@@ -2863,6 +2863,18 @@ static int transfer_end_table_idx(EndTransferFunc *fn)
     return -1;
 }
 
+static int ide_drive_pre_load(void *opaque)
+{
+    IDEState *s = opaque;
+
+    /* The subsections below are sent only where the guest replaced these */
+    s->heads = s->drive_heads;
+    s->sectors = s->drive_sectors;
+    s->reset_reverts = false;
+
+    return 0;
+}
+
 static int ide_drive_post_load(void *opaque, int version_id)
 {
     IDEState *s = opaque;
@@ -2986,6 +2998,7 @@ const VMStateDescription vmstate_ide_drive = {
     .name = "ide_drive",
     .version_id = 3,
     .minimum_version_id = 0,
+    .pre_load = ide_drive_pre_load,
     .post_load = ide_drive_post_load,
     .fields = (const VMStateField[]) {
         VMSTATE_INT32(mult_sectors, IDEState),
-- 
2.53.0


