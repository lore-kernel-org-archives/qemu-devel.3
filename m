Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8756EC5DF82
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 10:12:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwzhu-0006uV-8t; Thu, 20 Aug 2026 06:09:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wwzhl-0006pm-Kg
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 06:09:02 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wwzhj-0008Kt-Gt
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 06:09:01 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4954df200ddso16037005e9.0
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 03:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1787220538; x=1787825338; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=5m9uheqn5F5pEee9Tp/EbVvueEOqVOsxBiATdriU+vo=;
 b=jDArqZD84KJf/T8B64HqodvjHAHHeXyo/syTDSI966J2ewgmjpQh3euHIHGXdWf767
 4zG1210twm8cp++LUmt1+RLx6Vya+IztWSav7KeeYxy72Xnw7H6QX6TBxUjYQOz07dYu
 wf3kl6TZbGHDfvtu4UwjorROWv6skQQX05gIJyDY38fdkBqfEP8o+Qm8lO/f4zACNP14
 sUU/LsXLZURyUkIApwsylZ6CmtYJ3hIVNLnBqfGMNQCEAo561uRAy7ksfxOBQk65u1il
 n7wksN2MENJdJtbVRRAciJZGlj+L2WqjL2pfZXpLH7wfwlp+tWlAn3JfV2knaZ3bmw0Y
 O4fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787220538; x=1787825338;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=5m9uheqn5F5pEee9Tp/EbVvueEOqVOsxBiATdriU+vo=;
 b=MxCxGOZjLxvJzuLrhu4O6be9U7fcuFZESaQuCzVIu17CmS/8HwvQaztXhnbxvVkYKc
 4watFn2GtvORqgyup+yCZujWsrUsaPOJ/3h52xzs5p2I5XXeS4cAnG13epnca+yVQLGK
 vutVFJ72nu5PYTrY3NRjGVy+73shZ92IFgEG13USrnlF5s9C4LFTwUNP43x6tjLNOw0J
 t6YJ06DUFD3DNoSrxKYdHck9P+6iMEr/sw/WIQEIIqwxSkokG6swWxwkfn67JuMvVFw2
 H5QBgt3aekaz0Dw++/eCmzTiC4Exz2IIuw/HJff9eaPYudiR+c4LKeedFL0kcQoQ+8B9
 91Ug==
X-Gm-Message-State: AOJu0YzUz7d5xtsV4HuI7s9BA8Yl7QgqoNuzgHz2Y/tKCz2SWiWPC3+F
 OVBOW+hzElO/nN+vjoEaER9XyZa90kr3+RkRQcVCGC6NBcY6C08HV8HUj9e8WGnB/fGJeJL9V2m
 7S1+N
X-Gm-Gg: AR+sD11EL3q4LbEiAqHDn8bR+/1f3i3xO8XyJI3bCODuWkIrCVxIm9FdNwQjuVBxBVH
 NDAgtuy49Tlv53fnynGOz1QrBx7MlmW2jgeTMf/hWnjsasap5c+p596xeXGU0rQHsV2L7o5rGR+
 rtZ496PUTG295Ty9ROePDu/Jry5uMVXIDswWUI5Vt/1BVL2N+WpnRhR1IfuGb0qFXXdxLFWf/qo
 S6TjvMsKWDLZivIBEQ20LsMWeWe/IqlDzjUJinxVfqm3jeU5bcC+94xciul2xHrQhQMNvGwY4nF
 mXUnvah1LlYiUJgztIWjeQdnb6vTr040lK0fiAY4ng5W/BUNamY7dlxE+ztjifF6t/SV20gwL36
 XlopI4QPiQbKltQhCtJs3/4HTSEl77hMjY6Ao/yvvu1DSArrWLX/zS4Rwi268qJ4RdrAmJT8CHo
 bhIniRpP0Vi8JLJsDhwWY1MeXaLv1DedxcC0ItquYWjLfZCI4ICzhq1OurQg==
X-Received: by 2002:a05:600c:46cb:b0:499:781e:25fc with SMTP id
 5b1f17b1804b1-499aa17d75bmr162099335e9.3.1787220537682; 
 Thu, 20 Aug 2026 03:08:57 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:a123:7b43:afd8:8b47])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482b1441b0fsm11678929f8f.4.2026.08.20.03.08.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2026 03:08:56 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 John Snow <jsnow@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-stable@nongnu.org
Subject: [PATCH v2 05/17] hw/ide: report the default CHS translation in
 IDENTIFY DEVICE
Date: Thu, 20 Aug 2026 12:08:32 +0200
Message-ID: <20260820100844.411717-6-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260820100844.411717-1-den@openvz.org>
References: <20260820100844.411717-1-den@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

IDENTIFY DEVICE words 1, 3 and 6 describe the default CHS translation,
and ATA-5 8.16.8 requires INITIALIZE DEVICE PARAMETERS to leave them
alone; the translation in effect is described by words 54 to 56 instead.
Words 3 and 6 were filled from s->heads and s->sectors, which the command
replaces, so a guest that selected a translation of its own was told that
its choice was what the drive came with, and could no longer find out the
default. Word 1 is already right, as no command changes s->cylinders.

Report s->drive_heads and s->drive_sectors, which ide_init_drive() keeps
for exactly this, along with the retired word 4 derived from them. The
CompactFlash data labels those words as the default geometry too, and
INITIALIZE DEVICE PARAMETERS is accepted for CFA drives, so fix both.

Cc: John Snow <jsnow@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Cc: qemu-stable@nongnu.org
Fixes: 176e4961bb33 ("hw/ide/core.c: Implement ATA INITIALIZE_DEVICE_PARAMETERS command")
Signed-off-by: Denis V. Lunev <den@openvz.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 hw/ide/core.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/hw/ide/core.c b/hw/ide/core.c
index 747fa71677..befbab9486 100644
--- a/hw/ide/core.c
+++ b/hw/ide/core.c
@@ -138,11 +138,12 @@ static void ide_identify(IDEState *s)
     memset(p, 0, sizeof(s->identify_data));
 
     put_le16(p + 0, 0x0040);
+    /* Words 1, 3 and 6 describe the default translation (ATA-5 8.16.8) */
     put_le16(p + 1, s->cylinders);
-    put_le16(p + 3, s->heads);
-    put_le16(p + 4, 512 * s->sectors); /* XXX: retired, remove ? */
+    put_le16(p + 3, s->drive_heads);
+    put_le16(p + 4, 512 * s->drive_sectors); /* XXX: retired, remove ? */
     put_le16(p + 5, 512); /* XXX: retired, remove ? */
-    put_le16(p + 6, s->sectors);
+    put_le16(p + 6, s->drive_sectors);
     padstr((char *)(p + 10), s->drive_serial_str, 20); /* serial number */
     put_le16(p + 20, 3); /* XXX: retired, remove ? */
     put_le16(p + 21, 512); /* cache size in sectors */
@@ -332,8 +333,8 @@ static void ide_cfata_identify(IDEState *s)
 
     put_le16(p + 0, 0x848a);                    /* CF Storage Card signature */
     put_le16(p + 1, s->cylinders);              /* Default cylinders */
-    put_le16(p + 3, s->heads);                  /* Default heads */
-    put_le16(p + 6, s->sectors);                /* Default sectors per track */
+    put_le16(p + 3, s->drive_heads);            /* Default heads */
+    put_le16(p + 6, s->drive_sectors);          /* Default sectors per track */
     /* *(p + 7) := nb_sectors >> 16 -- see ide_cfata_identify_size */
     /* *(p + 8) := nb_sectors       -- see ide_cfata_identify_size */
     padstr((char *)(p + 10), s->drive_serial_str, 20); /* serial number */
-- 
2.53.0


