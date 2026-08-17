Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 652F0C5DF7D
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 20:55:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ww4KR-0006ZR-G2; Mon, 17 Aug 2026 16:53:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1ww4KI-0006X2-I9
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 16:52:59 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1ww4KG-0006hC-6g
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 16:52:57 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4998590d392so41044295e9.0
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2026 13:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1786999975; x=1787604775; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8CWVKBQSL5ewcOP0DFBT4Key4Rx+wNU5OMEqLgfB9Bw=;
 b=GTUFcBQyP2O5oWA1LAST09ADpNCe7EeLqlfyyjr0GKt3ytqvkq3hLq92rDqEqcjxuK
 zvZx5oKYCyqEk5kFdgxILU+VIqU8vmrJj9kMu8A74PI5kLnAMdbOFzCyKEwiXcPFm/TD
 v83CXYjlS5SJL+e2pj3ON9cYIM75mFk0K1o5e+Uyco2pqF+Mgzl39b/y8okF2EU3dZCV
 uR8Czw8UnJaTiwVBQhXFMYrXZZIgtmtb6frEG96SjLQKPsMQbCuBkFA5KUGwjaFrCq7V
 Y2L9MXiYEJfxZwH+O5tQYDyTY3THmuXXJaQnwtwWjZShzNvAqWXp+OnlhAHM/mI51fhh
 Q/nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786999975; x=1787604775;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=8CWVKBQSL5ewcOP0DFBT4Key4Rx+wNU5OMEqLgfB9Bw=;
 b=JHVTXDiWszC0xwHBa+hbpBW2qo0JfmCFwjkKBJ6bbXO+NzY7PdNMD/v/KWjAEL6jR3
 UTyII/TFvFDVg9DclyNosvIS21ClKyY3zC2T/KmUQLjOLrQF15ROUckP4wvaN5SBRIi8
 FgK8PK8ktQdAMNIjhOYL7AilOo8ZPtiV59nrcp0tlV2JID0z+Me4vthkyEAvpbUKlC6p
 /88QZR1c4P5cV3kLeyxOHQdD6Vkca47cxvk92bXDkhfomPjbrZeG8QrC66+774RuE1YS
 k6Z77PHSJ4V6FqPPzDLTV7PXQfXLo9J/WRNFE80JI1uB8ixIvhjiotR5rHWtoSBDd5AG
 kEJg==
X-Gm-Message-State: AOJu0YzqZFc+yC2adtBcsstYeBPjYCzIWSTrEKH651YHrhCGWwjwazHN
 y3ewY757eAaZM6tNM2/bA0FjEscvAanSm34+cf6Vc+rrnSjL3+830NveoCokAkx9T1Sw35H+DKE
 Ov01z
X-Gm-Gg: AR+sD10TMOx6lwlcyE8IkQ+godwzMPCCU88DCd4s2ShT+EHnULXiz4u2nkTjzlgOGhB
 K5cTAIVYNqSr8ANJ7JPQWj7TlfNqvMJLq1kf6a5BVe2H1csYV46ahGorlU7SjQhXSxyqVRPHPPj
 +ypGm9oO3SGfFxy82fG6NcdIYjB309h9OpYomMeQCZZ6zWsk0jERo2MrW6YjYkMUjh7xgrjMBB7
 BwkmRlh3Q3fcrPK9R1+YEBZ4EBEf+UZDLGrgPzXOMyWSkfVMN6e57uBS75+Rgi6N79FUqHgq47/
 +BNriX5bI+u5olUn5T93/xmg/chpFE7RYUeSw3v8ko+zsHUo5SRoUHd0k6ygFl1KOC7cr5XImSz
 KsXCzDE9g0XFQxBUTIfRyecvWFH2B5swAv/I2maEu1WwoOy/s4rX9OcYPHYSWR6ON2G3PaEwD8a
 oSAkLoXG/QJQskoLSpJDHS7mNzsOYLIE0WY55gGHor62ZDLlm/sA==
X-Received: by 2002:a05:600c:528d:b0:499:48be:3189 with SMTP id
 5b1f17b1804b1-4999fa84b7dmr57341815e9.0.1786999974703; 
 Mon, 17 Aug 2026 13:52:54 -0700 (PDT)
Received: from athena ([2a06:5b06:b600:300:f6f8:884c:b162:eaeb])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499961098cdsm202573365e9.6.2026.08.17.13.52.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2026 13:52:53 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 John Snow <jsnow@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH 07/15] hw/ide: restore the power-on device state before loading
Date: Mon, 17 Aug 2026 22:52:34 +0200
Message-ID: <20260817205242.1199851-8-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260817205242.1199851-1-den@openvz.org>
References: <20260817205242.1199851-1-den@openvz.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=den@openvz.org; helo=mail-wm1-x335.google.com
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
Fixes: 176e4961bb33 ("hw/ide/core.c: Implement ATA INITIALIZE_DEVICE_PARAMETERS command")
Signed-off-by: Denis V. Lunev <den@openvz.org>
---
 hw/ide/core.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/hw/ide/core.c b/hw/ide/core.c
index 9959437a63..3b67409eb4 100644
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


