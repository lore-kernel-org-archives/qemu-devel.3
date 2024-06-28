Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80270C2BBCA
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 04:55:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sN3dM-0000dE-5Z; Fri, 28 Jun 2024 00:54:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sN3cj-0008KN-T2
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 00:54:15 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sN3ce-00011D-My
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 00:54:10 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-42565cdf99cso2210035e9.3
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2024 21:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719550446; x=1720155246; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l1JW4AJQQbgrb8lXxKMuM1qRbY1uuDZlLJblyEzxQh4=;
 b=aFESUId6sKGtJtgaXKIHOEJqEOToclK7vaP0a2vvvdDTQvVvh6tXvmlX0RMOpNnsha
 8Zacrs2ZhUOC9D/m82JdSIp7OTmKvkn8AWIoScqatOUSw6Sk2F5uqaF8Ew3tgNYqRML6
 Z86p43D3AvfAetapuAmM4LAV0On2w2tgYID7TSDwSqzlP2+4AjCd12p1ASzX5AmPon5G
 h5cFVFuuil5vvKghLdctZJhCXMiYtfCM9d7yonfoEL0IZbKnRKLQkOXWOs7oVR6KLO+A
 gyrifAbO/1PRg+hKPhl1ntzGUIIX6aEYlB5ow0x8VVnjtrRTLonZa1EfXwUxbtXgnnxU
 jqeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719550446; x=1720155246;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=l1JW4AJQQbgrb8lXxKMuM1qRbY1uuDZlLJblyEzxQh4=;
 b=canzC4hrhZLVsaTuPDvKeJgrGg0sGTYE9t+vqNO4XN65+FMPCQOWlMErHeD4UaAix4
 mAeEXX2NIGlTq3+mz1khIdP4RrmqCCb9eHvYNEm3VC11IInA1aQj3Td3XI5aIAW8+Rk+
 KvvTC0V9uk4DPYxZ7BNiLP24FEDDwLgDAs+So+YtSE0ELAUEBdCCO2L1fiLhwgrvWye7
 AG5kNqt8Cu70JzjikRVrO2mWDkcUcKA9NTt5Zuif3Lm0Jlm2hPAJxCgBdZA0wsIjsLtY
 dinh7NoahcDXawlTE8bKHqqLEJsmFOsdOQJgxgdzaR2Asrt/7hICUzObzZZciDe4fF9p
 uraQ==
X-Gm-Message-State: AOJu0YxSv0cW4a7+DJMF9jUwnB100LjQT1etXsTO6d6eyzNDviC4e9Di
 79LdXIoKbDWRnBSnW4WtKx0BWqf/63v5FA0AacJq+z8dd5iO0VqzgHtakwGFv/m+6bx/HRWkdjX
 pBIl6ZQ==
X-Google-Smtp-Source: AGHT+IEWhmOU/D81BdfjCCs1DKW3lz2N1esxm3YQTepoMqzfPFaTdNAaXFPuCLpaPaO4WPynixn0lQ==
X-Received: by 2002:a05:600c:68cc:b0:425:5eec:bb84 with SMTP id
 5b1f17b1804b1-4255eecc517mr62922505e9.36.1719550446815; 
 Thu, 27 Jun 2024 21:54:06 -0700 (PDT)
Received: from m1x-phil.lan (cho94-h02-176-184-4-239.dsl.sta.abo.bbox.fr.
 [176.184.4.239]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4256af3c2afsm18117245e9.2.2024.06.27.21.54.04
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 27 Jun 2024 21:54:06 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Luc Michel <luc.michel@amd.com>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Sai Pavan Boddu <sai.pavan.boddu@amd.com>, Joel Stanley <joel@jms.id.au>,
 Bin Meng <bmeng.cn@gmail.com>, qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 08/12] hw/sd/sdcard: Remove sd_none enum from sd_cmd_type_t
Date: Fri, 28 Jun 2024 06:53:19 +0200
Message-ID: <20240628045323.86308-7-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240627164815.82606-1-philmd@linaro.org>
References: <20240627164815.82606-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

All handlers using the 'sd_none' enum got converted,
remove it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/sd/sd.h | 1 -
 hw/sd/sd.c         | 7 +------
 2 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/include/hw/sd/sd.h b/include/hw/sd/sd.h
index 29c76935a0..c1a35ab420 100644
--- a/include/hw/sd/sd.h
+++ b/include/hw/sd/sd.h
@@ -76,7 +76,6 @@ typedef enum  {
 } sd_uhs_mode_t;
 
 typedef enum {
-    sd_none = 0,
     sd_spi,
     sd_bc,     /* broadcast -- no response */
     sd_bcr,    /* broadcast with response */
diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 6a9d611429..7f93d363c7 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -526,17 +526,12 @@ static void sd_set_rca(SDState *sd, uint16_t value)
 static uint16_t sd_req_get_rca(SDState *s, SDRequest req)
 {
     switch (s->proto->cmd[req.cmd].type) {
-    case sd_none:
-        /* Called from legacy code not ported to SDProto array */
-        assert(!s->proto->cmd[req.cmd].handler);
-        /* fall-through */
     case sd_ac:
     case sd_adtc:
         return req.arg >> 16;
     case sd_spi:
-        g_assert_not_reached();
     default:
-        return 0;
+        g_assert_not_reached();
     }
 }
 
-- 
2.41.0


