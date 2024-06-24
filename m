Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 207D6C2D0D1
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2024 13:17:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLjXv-0002if-Bb; Mon, 24 Jun 2024 09:15:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sLjXp-0002Zp-Pf
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 09:15:43 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sLjXo-0005TC-2y
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 09:15:41 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-42172ed3487so32262695e9.0
 for <qemu-devel@nongnu.org>; Mon, 24 Jun 2024 06:15:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719234938; x=1719839738; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HxQAYADKfbhpE1hUX1tIATqcZpfO3HwJuZqR6r1E18w=;
 b=trNSHaPgnX4IaVip/hUksNO34idS2zor3C73sUoOxui5ToLnr5dwCPwfLPGVYYmhbi
 +pmxwL+8PXyHu0xEL9Hz1H27lEXbb3YAVso33gH93gQ9YM6tDIrjA+z1pLpSAOQz5w+/
 cggP5Vf0aT1i4WQMAvCtbfpNQID+mXayTTJEU9YXN1vrP/QsqWWocEU9L4qE3upRHecm
 fZZNJiQC1Gpg57ux5sRJvXfykcq/IHY9viTklOacRDCJUCa/+B4QP8qRQzwoUfEUyBPR
 A8b3UxOQdy9AVOLJ4lNxc9pCLKf8m03h6vr8PAU1OEe0pES892y1cROnahpb/PWq9Z0w
 bm9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719234938; x=1719839738;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HxQAYADKfbhpE1hUX1tIATqcZpfO3HwJuZqR6r1E18w=;
 b=n20sWrj78esjAuE0hZHX/wEPnjI+dhhLYOlrivP/v+EeMWklb+lYvP+JNsumfPjoc7
 xowJFcJ0FTSHwSmygmtBdRpju8BMhYisaUOQWPKGHNZfmpntttMSXzahuBOBVWms6Vm0
 H8r4WQaBXAgUT1JrhyNnn+rZ6yqkIqmxAV6rYxFyR9cIyQB8/hS2L5QBvRMqJpkdSpA5
 N1GNivO1kfrZiRPqCrVu5Jd3mbadETB2UJC8E6ch0NhVfT5VMBurBRu6kyEXFi6VBQuE
 eDwMqUi0HDD9cQhkDM43zji1Lqw7fBkHfmS+/Mk1tMp5d7Rwz7LP2SHbtRywFzlugB4s
 lWwQ==
X-Gm-Message-State: AOJu0YzfbL/WrUh+gYrh+WYC9+KvWltnDX+mJiPwPzCtk7KCZO3b28Bs
 McG1fDdEmSopnso54ieyQ1QsvLO2bsOHhm0LGh5gufef/JLehmMTQkAbpOTgOmlK7EAPLzSc6EM
 r
X-Google-Smtp-Source: AGHT+IHSMa+DmdpNjV5w300ZJgJlatZAoa6tIbFMsUeN8M86ygBiNCh4tV9oLT2NVnZydpjdwZUw6w==
X-Received: by 2002:a05:600c:3225:b0:421:9fc4:7490 with SMTP id
 5b1f17b1804b1-42489e3a9a0mr40156845e9.11.1719234938135; 
 Mon, 24 Jun 2024 06:15:38 -0700 (PDT)
Received: from m1x-phil.lan (bd137-h02-176-184-46-22.dsl.sta.abo.bbox.fr.
 [176.184.46.22]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42481921f16sm133394085e9.41.2024.06.24.06.15.37
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 24 Jun 2024 06:15:37 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 10/19] hw/sd/sdcard: Remove explicit entries for illegal
 commands
Date: Mon, 24 Jun 2024 15:14:31 +0200
Message-ID: <20240624131440.81111-11-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240624131440.81111-1-philmd@linaro.org>
References: <20240624131440.81111-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

NULL handler is already handled as illegal, no need to
duplicate (that keeps this array simpler to maintain).

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Tested-by: Cédric Le Goater <clg@redhat.com>
Message-Id: <20240621080554.18986-9-philmd@linaro.org>
---
 hw/sd/sd.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 08a6d0aff8..4afb6988c7 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -2147,12 +2147,6 @@ static const SDProto sd_proto_spi = {
     .cmd = {
         [0]         = sd_cmd_GO_IDLE_STATE,
         [1]         = spi_cmd_SEND_OP_COND,
-        [2 ... 4]   = sd_cmd_illegal,
-        [5]         = sd_cmd_illegal,
-        [7]         = sd_cmd_illegal,
-        [15]        = sd_cmd_illegal,
-        [26]        = sd_cmd_illegal,
-        [52 ... 54] = sd_cmd_illegal,
     },
     .acmd = {
         [41]        = spi_cmd_SEND_OP_COND,
@@ -2163,15 +2157,10 @@ static const SDProto sd_proto_sd = {
     .name = "SD",
     .cmd = {
         [0]         = sd_cmd_GO_IDLE_STATE,
-        [1]         = sd_cmd_illegal,
         [2]         = sd_cmd_ALL_SEND_CID,
         [3]         = sd_cmd_SEND_RELATIVE_ADDR,
-        [5]         = sd_cmd_illegal,
         [19]        = sd_cmd_SEND_TUNING_BLOCK,
         [23]        = sd_cmd_SET_BLOCK_COUNT,
-        [52 ... 54] = sd_cmd_illegal,
-        [58]        = sd_cmd_illegal,
-        [59]        = sd_cmd_illegal,
     },
 };
 
-- 
2.41.0


