Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E965EC27C4F
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2024 16:09:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJbN4-0004Mn-Cc; Tue, 18 Jun 2024 12:07:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJbMx-0003yC-8l
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 12:07:40 -0400
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJbMv-0007yi-3h
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 12:07:39 -0400
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-a6efae34c83so695101766b.0
 for <qemu-devel@nongnu.org>; Tue, 18 Jun 2024 09:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718726855; x=1719331655; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VSnmDwNBD5C9wQDCycF4RnH2v2NxTyHLs0bPJHduo1E=;
 b=XX3Eje40VtMdJKpiZG9zfwykKlhSmFHcZCPEzfvp9KdJLR305k6otiZpp7Hbvl/7y+
 Y3AqrzRCHflUcAQF4W3k2nECjVTG+GDDq/g3tmZE6iY5hLzdWa6omFqMHd1R1Glrom7f
 TMVpordJiN2lV3Af0ifLPjtE9WkTpWf9JwCpN98GzV0M6IHCVEZ7iiftQgfq+Vg2JHlg
 4uElKD0afvIkulF3ES5R3yEBahgnifOlTz2JYDKQJYuJvCAGEska0OQNRHRhb6jrR43i
 3nhW2qppDDnc9scfABV6RKnwjXEHkWdXMr53ty5f59X6ANobo+igb0/UE7z9Pp+fVhMK
 Et6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718726855; x=1719331655;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VSnmDwNBD5C9wQDCycF4RnH2v2NxTyHLs0bPJHduo1E=;
 b=tbotw9kfZPawCKj0EwBSofdj838WsKd0Gh9QnWDS9oWDc9fz30Soq4tWNeuaK9UwpU
 zJGMgPtW/18/vxDsndeGgyAN8XGoatOBzZwzG7ZJVSxnILmI0N++hohrw/GIdluvJS/8
 ca5KLit03XVExHfhPboEFtRBal5o8CMILd3vhXiG2KTVIhoAUkR2w9e4hdtgCxLG3aws
 sYSiB/DvbUOmqKM6t+yInN/LK5RXn9q1sph3ch3q0LtD5fjMU2MNyZIwlgRjYiX+2z1y
 8c1qqQY4YPacsK2fJ03cG3pw8Fx5txUfmCdxdH77TjYH18oXwhnfdzeLaXDy9vUVjYES
 T+qA==
X-Gm-Message-State: AOJu0Yy+TxDRCwe2DSi0xSLwk9+K2/0uULpAFSEQs3LcxhHRgOd6uQ+D
 EPGdRe7u8T2BngOCOVGr3UkJWIIapRdOw88R9CsG5UXqD9c6l7/rBGI59WRnOB6xMuRVQ7HpVgC
 E
X-Google-Smtp-Source: AGHT+IEHocGy+iEC2fAlf8lmZ8xuIlCngHdrgL1HvEiLRk0iN+Phgq7eZ7f4+6QmPDOYRJiNkZJbRw==
X-Received: by 2002:a17:906:b182:b0:a6f:2a1d:b5cb with SMTP id
 a640c23a62f3a-a6f60d2c436mr731691166b.22.1718726855390; 
 Tue, 18 Jun 2024 09:07:35 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.212.55])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3607509c785sm14365407f8f.34.2024.06.18.09.07.34
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 18 Jun 2024 09:07:35 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 72/76] MAINTAINERS: drop spice+ui maintainership
Date: Tue, 18 Jun 2024 18:00:34 +0200
Message-ID: <20240618160039.36108-73-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240618160039.36108-1-philmd@linaro.org>
References: <20240618160039.36108-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x629.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Gerd Hoffmann <kraxel@redhat.com>

Remove myself from spice and ui entries.
Flip status to "Orphan" for entries which have nobody else listed.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Message-ID: <20240528083858.836262-5-kraxel@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 MAINTAINERS | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7cc6421e3b..cef54de759 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3058,8 +3058,7 @@ F: stubs/memory_device.c
 F: docs/nvdimm.txt
 
 SPICE
-M: Gerd Hoffmann <kraxel@redhat.com>
-S: Odd Fixes
+S: Orphan
 F: include/ui/qemu-spice.h
 F: include/ui/spice-display.h
 F: ui/spice-*.c
@@ -3069,7 +3068,6 @@ F: qapi/ui.json
 F: docs/spice-port-fqdn.txt
 
 Graphics
-M: Gerd Hoffmann <kraxel@redhat.com>
 M: Marc-André Lureau <marcandre.lureau@redhat.com>
 S: Odd Fixes
 F: ui/
-- 
2.41.0


