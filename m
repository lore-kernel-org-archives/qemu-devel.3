Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA130C5DF82
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 10:10:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwzi6-0006xn-QF; Thu, 20 Aug 2026 06:09:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wwzhn-0006pz-3z
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 06:09:03 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wwzhl-0008Lx-9V
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 06:09:02 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-480001972b8so742129f8f.2
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 03:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1787220539; x=1787825339; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=PGxOxbJCTHpjzoR3+U5OxJn0dZ4GKFvitmqy32ujxR0=;
 b=eoY5GgFtL85JNpX1SGZaYBeWKn0JVUjnUu6P3GRhud/UUIQPervRRKslkfivK0na+f
 wNp0uAXXq1rPtiVWrNcFAp1CWv3Lqt6/VG7nPAlhxAXspdSGGlEoMkbwrTzfewzHtsUA
 bpdh6wSjWMLWBs2ZAGlqqO43olm1el9HD9VN6wGSKy2wWKIsTRIs1MnLyGhd3LHLunJa
 6gxzUH+gid3QbVZhBmAzxp+jJ1LfoTBoiMrshYrvK57zjZRvrlH6ItYzPTZbPD/YxL86
 4x6FGBqf+9RlEqoZSB7Y3M4yCAn6wFbDK1NTcTWwBkfz86qkHxTq6t3g6IAtyY60CWKf
 0L/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787220539; x=1787825339;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=PGxOxbJCTHpjzoR3+U5OxJn0dZ4GKFvitmqy32ujxR0=;
 b=Wgm6kaF7F4nSK3UT6WRhw4FAmpnwa9STKVwa1zgU6PsOXr4+YODemmim58eeZuHiUC
 vWgWlUf9VxZWM150vzTVDa+BBoQtrwoEDZAigMJogruteS2S8LSNyZnk4Gf7Mtxb0VaQ
 bN9CDCzokVF/oDLGzzBGKdf2nm7c+tnMgiFz3LHa2kzbIZZeYVb6yyxM/fd+cgDuRt/U
 9GUs9ZXmjicVopu4AATagnkRgz9IYKp7HyEQ7ZCqW0utR4sBTF0afedeKdl3m/4NnBTq
 clVwcx8zKOrXDJTDehWOo7golrH3LuvvwRGVeCo1m4KI2KMzVvIKKU/FqLU5asFSC+OH
 tNjw==
X-Gm-Message-State: AFuF++kfPb8S1Ze49fgD4M6epmujNp8QUe1UCZJtoIoynSU52+se+tQ9
 5cFTs77PXY5MdBZqsMlfQDdoL9bL5jWFqesNF/y6rD1nPosQPdGAv8AcrjxlEP8qhW6jl/RlXIu
 bijni
X-Gm-Gg: AR+sD13VVDE2PUhMnwSDVUOJsU0zatvs0wGiRqorEpP9uiQvYJD+8gPuxpFbY+Or6TA
 okxwr3FSgSmfnC3pLFHJitevWXK8EPfjchXnYujNjFhffkgkoEjFi55zEz09zG702ZmNTdm0BOz
 a6UYRE7jdgSczA7ZRN0mkcLgEsSgJ46+jbsFMSUxM7aDhN2Sl+qSL8KA+QGw7UsI5qvRpTozd7F
 p3eu8ctoW4lLQ2cUX+I4hdhQ4L13Kke5zYT3YnbtuiPsaIS/N8gAcTopsDrbo8nvnqwkvLM7vzO
 ZI00MZP0tJ5DcQWW9ONS3vLGhHRt6ndHUI2F2ZH3K0cqDJOV//KMoW3f9B8PjE9aY7sltqAMvOu
 8ACPz8vyqTTIE0fDOfx/OhJVPV8k/f+7MRodVQlQAVoG8Y4nqblvv+i5urpL6MLVqHJuQ+hzR2w
 xoef/2w4gbR4KPcAy83xhBU5yY+dFZl0aGYJ71xuVP5hM/6CPcVZd9l+Lv3g==
X-Received: by 2002:a5d:5f95:0:b0:481:4dcd:aefa with SMTP id
 ffacd0b85a97d-482b1e95522mr16472987f8f.6.1787220539574; 
 Thu, 20 Aug 2026 03:08:59 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:a123:7b43:afd8:8b47])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482b1441b0fsm11678929f8f.4.2026.08.20.03.08.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2026 03:08:58 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 John Snow <jsnow@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v2 06/17] hw/ide: name the retired IDENTIFY DEVICE words the
 device fills in
Date: Thu, 20 Aug 2026 12:08:33 +0200
Message-ID: <20260820100844.411717-7-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260820100844.411717-1-den@openvz.org>
References: <20260820100844.411717-1-den@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=den@openvz.org; helo=mail-wr1-x42e.google.com
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

Words 4, 5 and 20 have carried an "XXX: retired, remove ?" since the
device was written, and word 21 is labelled a cache size when it is a
buffer size. ATA-4 8.12.13 retired words 4 and 5, 8.12.17 retired words
20 and 21, and ATA-5 keeps all four that way.

Retired is not a reason to drop them. ATA-5 3.2.3.6 says a retired word
that is still used shall have "the meaning or functionality as described
in previous standards", and that is what these carry: ATA-1 9.9.3, 9.9.4
and 9.9.7 define the unformatted bytes per track and per sector and the
buffer type, and the ATA-1 IDENTIFY table gives word 21 as the buffer
size in 512 byte increments. Software old enough to read them gets what
it expects, so answer the question rather than leave it open.

Word 22 is obsolete rather than retired (ATA-4 8.12.18) and already
carries its ATA-1 9.9.8 name, so leave it alone.

Cc: John Snow <jsnow@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Denis V. Lunev <den@openvz.org>
---
 hw/ide/core.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/ide/core.c b/hw/ide/core.c
index befbab9486..292908fb1c 100644
--- a/hw/ide/core.c
+++ b/hw/ide/core.c
@@ -141,12 +141,12 @@ static void ide_identify(IDEState *s)
     /* Words 1, 3 and 6 describe the default translation (ATA-5 8.16.8) */
     put_le16(p + 1, s->cylinders);
     put_le16(p + 3, s->drive_heads);
-    put_le16(p + 4, 512 * s->drive_sectors); /* XXX: retired, remove ? */
-    put_le16(p + 5, 512); /* XXX: retired, remove ? */
+    put_le16(p + 4, 512 * s->drive_sectors); /* ATA-1 unformatted bytes/trk */
+    put_le16(p + 5, 512); /* ATA-1 unformatted bytes per sector */
     put_le16(p + 6, s->drive_sectors);
     padstr((char *)(p + 10), s->drive_serial_str, 20); /* serial number */
-    put_le16(p + 20, 3); /* XXX: retired, remove ? */
-    put_le16(p + 21, 512); /* cache size in sectors */
+    put_le16(p + 20, 3); /* ATA-1 buffer type: dual ported, read caching */
+    put_le16(p + 21, 512); /* ATA-1 buffer size in 512 byte increments */
     put_le16(p + 22, 4); /* ecc bytes */
     padstr((char *)(p + 23), s->version, 8); /* firmware version */
     padstr((char *)(p + 27), s->drive_model_str, 40); /* model */
-- 
2.53.0


