Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81983C61DC7
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 11:17:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzBbe-0007vd-IR; Wed, 26 Aug 2026 07:15:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wzBba-0007qn-9z
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 07:15:44 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wzBbY-0004Kl-3V
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 07:15:42 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-6a5f1d0af69so260512a12.0
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 04:15:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1787742938; x=1788347738; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=fbFPcumdwqQtTm/8eCl+Gz40GixriWu5Kdq29TJDuH0=;
 b=paKp1lLRUMSZZSO0LdC7ZK/MMnIMfMOhpt6/pRCxFDnpOmKQQk2iGatcJFEne2eNF5
 vRO0bUcegI9xFosTtuI91tev+++1AWa2D1KeRCwRGU1yQVKytiziLaAVls1ORZPHQHYs
 eM/aYdaNOp3z8gzM4CW7HWE8riu06+v7XFPDqX7JeE0LOPwSyBVvE5906rD0rkrZWuyU
 4LfPOu5mJZENaQqr9bR/KILp3Wn978dNpmrDcYuxWLDprUTkd458TcC2hxrsgs73M2gu
 /ZO5jKUDponRh9yBTOMe8oJFHZSx1crCaLw81Zup8SOkHgNqJ9XzcV1YJ/ViooXka/na
 4jrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787742938; x=1788347738;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=fbFPcumdwqQtTm/8eCl+Gz40GixriWu5Kdq29TJDuH0=;
 b=jFkwzp8nzT7BuzxtpwpigCZ+S6hcy8hDGUo+6L4L55lGsf7IRHViSspOW5FQQGA2k/
 u1rtUv7KecHTDyhSUHoukLEBseaBvlWZA6rlo4oIjZ+2icK6L0e8yY1VUyWyIplIrHXW
 UJifottw6XIvSLbfw6u+BKOK0IR3MeL7u3SDOatV3Mix/5tzx1LHvmcCEKeWcGcOz3wJ
 tCGOWloVqDMxeirCfIq/zhS5V7gW1MEO+8GDD8UvumI1GzO5thh06i0b0Y8l59tmmTpN
 ZgagIruPwTn63Al1LsRAVPezc3DxxbGvS4TsqYx3MnG9lbp0zZeItvXY2vM1Z5TNkV3M
 oSgw==
X-Gm-Message-State: AFuF++nZ6Nd2iUVCQowve4WvbLx0neShzV5UI87VU4R681B/Uu8EkNkQ
 du0X64HozCfESE5TFa+ldsZMyhY+SmVyRVZ+C7behOide1HYm57Gq5jX57jSq09BWyKOZHNDyV6
 EKcyh
X-Gm-Gg: AR+sD10bY3iBvwr/oVAV9R0LWKcLdXKGySp0om1QDcUUuVR9QNyXzn3xtS2X+U7fkJu
 nz08TAlQ5utGxUwFUcayB3SKGfcPp6g1eNG3Dl4C33xuS/YPbJhp/OnN7B6xJ+ByLXm8E6TJN0l
 UQxNmqua3YdiUu3hpE+7/ABVD3OSSeaFS3pjlq9XOAcevE/9qchV3l4Kg/drxi8sRdHjT4jUJ+L
 XXSknGkGrvhAqrY1jnWzkwnGQ6EFMpDF/69d9OZ+LXEUxw+oQlv6g+J0FFW0NlLLFxyiBfb6ru2
 Fs7b/SoZmr40gZDK8+Ny0k1W/WDD3ZPDgdOSzbCsG/4wLPmDIa81hqSZ/zM5fDPp0UDgTyg3P6K
 8LCKnCUhEdBqFdHTuoJMhNtyMDCRqgvvlFNJK1oesEcz3rf2xaRiOZotY6YrUdes2hOzIm2wKl4
 l7C59VPgLDVisY/zR6qfNKI+CWr/TanHqVrzli+yLCa8CtTcpm
X-Received: by 2002:a05:6402:504d:b0:69e:8ad:5162 with SMTP id
 4fb4d7f45d1cf-6a5df5cff84mr7962517a12.1.1787742938600; 
 Wed, 26 Aug 2026 04:15:38 -0700 (PDT)
Received: from athena ([2a06:5b06:b600:300:8a5:68e8:91b1:8a17])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a5de8ea655sm3951724a12.12.2026.08.26.04.15.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 04:15:37 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 John Snow <jsnow@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PULL 08/28] hw/ide: keep the IDENTIFY DEVICE current geometry in sync
Date: Wed, 26 Aug 2026 13:15:23 +0200
Message-ID: <20260826111524.3383479-9-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260826111524.3383479-1-den@openvz.org>
References: <20260826111524.3383479-1-den@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=den@openvz.org; helo=mail-ed1-x536.google.com
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

From: Denis V. Lunev <den@openvz.org>

Bit 0 of IDENTIFY DEVICE word 53 says that words 54 to 58 describe the CHS
translation in effect, and ATA-5 8.16.8 has INITIALIZE DEVICE PARAMETERS
set words 55 and 56 to the heads and sectors per track it was given. The
data is built once and then cached, so those words kept describing
whatever was in effect when a guest first asked for IDENTIFY DEVICE: the
device reported one geometry while addressing the medium with another, and
nothing reported an error. The revert SET FEATURES 0xCC asks for on the
next reset left the same disagreement.

Do not drop the cached data on a change, as parts of it are guest state
rather than a description of the drive: SET FEATURES records the write
cache setting in word 85, which ide_drive_post_load() reads back after
migration. Refresh the affected words in place instead, the way
ide_identify_size() does for the capacity words.

An ATAPI device has no translation but does take SET FEATURES 0xCC, so
leave its IDENTIFY PACKET DEVICE data alone, where those words differ.

Cc: John Snow <jsnow@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Fixes: 176e4961bb33 ("hw/ide/core.c: Implement ATA INITIALIZE_DEVICE_PARAMETERS command")
Signed-off-by: Denis V. Lunev <den@openvz.org>
---
 hw/ide/core.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/hw/ide/core.c b/hw/ide/core.c
index e5fd570575..048655b2d0 100644
--- a/hw/ide/core.c
+++ b/hw/ide/core.c
@@ -1360,6 +1360,10 @@ static void ide_reset(IDEState *s)
         s->reset_reverts = false;
         s->heads         = s->drive_heads;
         s->sectors       = s->drive_sectors;
+        /* An ATAPI device takes SET FEATURES 0xCC but has no translation */
+        if (s->identify_set && s->drive_kind != IDE_CD) {
+            ide_identify_chs(s);
+        }
     }
     if (s->drive_kind == IDE_CFATA)
         s->mult_sectors = 0;
@@ -1668,6 +1672,9 @@ static bool cmd_specify(IDEState *s, uint8_t cmd)
 
     s->heads = (s->select & (ATA_DEV_HS)) + 1;
     s->sectors = s->nsector;
+    if (s->identify_set) {
+        ide_identify_chs(s);
+    }
     ide_bus_set_irq(s->bus);
 
     return true;
-- 
2.53.0


