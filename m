Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8043DC3064D
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2024 05:55:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLz8h-0002GI-SZ; Tue, 25 Jun 2024 01:54:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sLz8f-0002DZ-Ol
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 01:54:45 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sLz8e-0001f1-8v
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 01:54:45 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-421a1b834acso42172975e9.3
 for <qemu-devel@nongnu.org>; Mon, 24 Jun 2024 22:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719294882; x=1719899682; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DSh3z/dbSRZy4hlbUrmDOZ6ZGH/UkGencdxAnicUEVY=;
 b=ek6BuXH12R2UURVh7SCD/ZV+v7CXyLk94XCMJ5H0xfwUAZFhn3ZD+K71MiUzgnhby/
 VuOAElUTC/DLbyyp0Om8k9ZORIRpp6aio1ULXPR3+VA1O8qqr74DlQL/KqOic/rIMNtv
 jhi4gKGQi/+6DOavXot09m8u75107WBTC5jhTafdTHw2u/RGbI2AY2R29QmuxAn0TcJ3
 dACecCQJAOAA1RSwAxYFW9ik1JSTuSwUT8/nf4QtpzUrdaNYdnoqrzB1krpa/jFRrOjP
 ChzQx7bJEfkgJb2Q1xwkAogJSzvUeex5usVPL/jGiKUgHPYTYbtnNIl1D0FjGfdQGcfo
 p13A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719294882; x=1719899682;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DSh3z/dbSRZy4hlbUrmDOZ6ZGH/UkGencdxAnicUEVY=;
 b=cAiXXkIgjlN4V3L9+LX2ATK4bZiZ6MB4fkM2txf0tsdGVyL+9e7/t+/3Rtk41pXiyC
 ZcQ3EG8eeOYuREqCQWUuHKT43ncbOa4mlw7ppYzIMrDQN2owxMuU75tTLp//yB69y3PF
 e7GHckokDXE5aUWdbKWm/bBW9V0UCPNsy/MFAW3JX6Q+N0YPSJb79FGCuPoKnVTeTPjJ
 6SDQMyJEI8xtTPDR1gCPcwPSp/IRRAvKDbCIFDmqrG5USFqirVu2Hl7OvXaOppfZKkXz
 WCS4lBgU2MMhmjFlCksQQyhrMjp0ftNdw8WI4cSRFXH1tboJFfBnBzgZ6B5zflS8KL3p
 hFiQ==
X-Gm-Message-State: AOJu0YyonwLAxnv5u/H5g4kugnFOd2A+q9znDgTkLqkSODSDhhLR+ukH
 P5Syf/Y2fEid2EuthcUYQ8DRcHLWdlqS0QcuMZpqfp0PsYFbRUSJtgpNZrNWBHVtaFkb6ehpOB8
 3
X-Google-Smtp-Source: AGHT+IGzJaLUcpGW6stykPVGFUOjtDyS1SM1TYU8/7Dv9+8rED77ui/ZV03612BKGtTfNyXRdDiZCw==
X-Received: by 2002:a05:600c:4f4d:b0:424:8f0d:c07f with SMTP id
 5b1f17b1804b1-4248f0dce13mr33943175e9.4.1719294882495; 
 Mon, 24 Jun 2024 22:54:42 -0700 (PDT)
Received: from m1x-phil.lan (bd137-h02-176-184-46-22.dsl.sta.abo.bbox.fr.
 [176.184.46.22]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-424817a9975sm155739065e9.14.2024.06.24.22.54.41
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 24 Jun 2024 22:54:42 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Bin Meng <bmeng.cn@gmail.com>
Subject: [PATCH v2 08/12] hw/sd/sdcard: Use READY_FOR_DATA definition instead
 of magic value
Date: Tue, 25 Jun 2024 07:53:49 +0200
Message-ID: <20240625055354.23273-9-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240625055354.23273-1-philmd@linaro.org>
References: <20240625055354.23273-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/sd/sd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 0742ba8b38..8816bd6671 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -557,7 +557,7 @@ FIELD(CSR, OUT_OF_RANGE,               31,  1)
 
 static void sd_set_cardstatus(SDState *sd)
 {
-    sd->card_status = 0x00000100;
+    sd->card_status = READY_FOR_DATA;
 }
 
 static void sd_set_sdstatus(SDState *sd)
-- 
2.41.0


