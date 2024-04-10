Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C465CD128A
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2024 16:12:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruaUV-0001V8-OY; Wed, 10 Apr 2024 12:08:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ruaTr-0000XV-71
 for qemu-devel@nongnu.org; Wed, 10 Apr 2024 12:07:23 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ruaTn-0002lD-IT
 for qemu-devel@nongnu.org; Wed, 10 Apr 2024 12:07:21 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-56e477db7fbso6642908a12.3
 for <qemu-devel@nongnu.org>; Wed, 10 Apr 2024 09:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712765238; x=1713370038; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tmrbaiUVNJN3VwkspX6n0mLGveiY6Yl+m30htubqYrE=;
 b=JVdI3/bJyAnRiH7HM0mKCBnRJihYXsZIOUsDWSD3sC5DjVTt6pGKrkp2JfW2S+DWmE
 adeWdhxLYuUs2HZexMoICMxAusqGH/0ogO2zYoLDb4bNcfjMmii8BcYH03bCNxJEPHg/
 aG9kkuGQJoDa0DvRO9zbrZYyhC/pLa3W4AmbcNktrCYyafp3z+T5hkZUwSrQcRsd8aDq
 ff5fBygq0kgRXVrd9+1Oyk+Yx4vvKVcFffYrBYmAbOo//pRMeHkJBLg1XtDLqpZ/7pPy
 xlh651SeqU0Ykk+SzGq4HJsy9KDfJ5y3lXFO1hKuWI+DuYQ0sj7wKBLtO5NEC18v6oR0
 7/Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712765238; x=1713370038;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tmrbaiUVNJN3VwkspX6n0mLGveiY6Yl+m30htubqYrE=;
 b=sRrYWvSF0NqNB6J56Fk3ChGKMMcj3wpJhNR63Zs0kK4OKVOaDdU706Ql5tAbW+uhJJ
 1oR9P3QWpWyW3R/B5wiepcAjWhyuVssb7Z/DM4Il/izDdRp9Llq2345n7V1NTWwWwP5C
 +S5jtFHgFzgl3QQzhDXowUxG3QMRnG20KUfzULdJpVf98vv58AT6FRros0wEXGa4oNoe
 2DLmm1F0xUpxiVkdI/GmxYRJRz6ObhwT4k/WxbCtndOwxM5d0fd+IUU2mf/HGpLXRapL
 cSXA6zUCQ41qbAoNMm6y8fMn/n3ljOybSbsKgF42JG3yaEPkDBzJA+ePhayNtjVqaM0Z
 +24Q==
X-Gm-Message-State: AOJu0YxtnDGpCeLf3Cm376W8T/+YgXvh68hnPVxjTX7uOZKnTdXQgtyQ
 LMcq0i/+DHXpQ3O0FAvHGnGMCh6HPORd2wCq0n3GG+B8xAQpXCuONkUkQLTcDnjqKV5y8QXrGhD
 M
X-Google-Smtp-Source: AGHT+IF4Hj4yM+NUJlh2q5C2+b+zKy6sx63eZVouiYM6yePYg4h/PddlxxkdJX1YEuebTRtCPJ5dVQ==
X-Received: by 2002:a50:d6da:0:b0:56e:230b:853c with SMTP id
 l26-20020a50d6da000000b0056e230b853cmr2079454edj.15.1712765236469; 
 Wed, 10 Apr 2024 09:07:16 -0700 (PDT)
Received: from m1x-phil.lan (arl95-h02-176-184-34-173.dsl.sta.abo.bbox.fr.
 [176.184.34.173]) by smtp.gmail.com with ESMTPSA id
 y9-20020a056402440900b0056e3707323bsm5824580eda.97.2024.04.10.09.07.15
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 10 Apr 2024 09:07:16 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-arm@nongnu.org, qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 John Snow <jsnow@redhat.com>
Subject: [PATCH 10/12] hw/ide/atapi: Use qemu_hexdump_line() to avoid sprintf()
Date: Wed, 10 Apr 2024 18:06:11 +0200
Message-ID: <20240410160614.90627-11-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240410160614.90627-1-philmd@linaro.org>
References: <20240410160614.90627-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x535.google.com
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

sprintf() is deprecated on Darwin since macOS 13.0 / XCode 14.1,
resulting in painful developper experience.

Use qemu_hexdump_line() to avoid sprintf() calls, silencing:

  [1367/1604] Compiling C object libcommon.fa.p/backends_tpm_tpm_util.c.o
  backends/tpm/tpm_util.c:355:18: warning: 'sprintf' is deprecated:
    This function is provided for compatibility reasons only.
    Due to security concerns inherent in the design of sprintf(3),
    it is highly recommended that you use snprintf(3) instead.
    [-Wdeprecated-declarations]
            p += sprintf(p, "\n");
                 ^

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/ide/atapi.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/hw/ide/atapi.c b/hw/ide/atapi.c
index 73ec373184..27b6aa59fd 100644
--- a/hw/ide/atapi.c
+++ b/hw/ide/atapi.c
@@ -24,6 +24,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/cutils.h"
 #include "hw/scsi/scsi.h"
 #include "sysemu/block-backend.h"
 #include "scsi/constants.h"
@@ -1309,12 +1310,7 @@ void ide_atapi_cmd(IDEState *s)
     trace_ide_atapi_cmd(s, s->io_buffer[0]);
 
     if (trace_event_get_state_backends(TRACE_IDE_ATAPI_CMD_PACKET)) {
-        /* Each pretty-printed byte needs two bytes and a space; */
-        char *ppacket = g_malloc(ATAPI_PACKET_SIZE * 3 + 1);
-        int i;
-        for (i = 0; i < ATAPI_PACKET_SIZE; i++) {
-            sprintf(ppacket + (i * 3), "%02x ", buf[i]);
-        }
+        char *ppacket = qemu_hexdump_line(buf, 0, ATAPI_PACKET_SIZE, false);
         trace_ide_atapi_cmd_packet(s, s->lcyl | (s->hcyl << 8), ppacket);
         g_free(ppacket);
     }
-- 
2.41.0


