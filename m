Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1DB7C3064D
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 07:11:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sN5kj-0001du-3v; Fri, 28 Jun 2024 03:10:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sN5kf-0001an-Ts
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 03:10:33 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sN5ke-0004oG-0j
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 03:10:33 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-424ad289949so2356075e9.2
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2024 00:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719558630; x=1720163430; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=UmLMWLzqSVJb3i4hpxGU8DfPCxonGkzeRg9cK3jhrKk=;
 b=gle7YFHVHnN8fzx/OoqwuWCmUV7ficAJMEJJGXfUlhPUxWG0QHH6Ry5xC86PS5v1BS
 cVlvBPevbQVV3WtLmEmgHeR8+zIPpDezhegdWJ0q2okRDNJEgttpHOoO7AQpAn5XtgC6
 Lb+3frzjXu12RY8Wmqsi+CjsoNS1jA3fy2AJ5rAH6nBnaHHsGlI0CqICQMQdriORWIuD
 NDMU0dskfL8iPhP4djKDSi4bV2DPTTEcvadz8OxXVuwSiehB1BgQshc/pEiSRN5s9LMX
 Md7CpBXpLUqTlc2WYySpQTPNw3wLaRxqA49K+ylrprCFrIkz1DBWAQ7LFwmLQCJy0Oxc
 F34A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719558630; x=1720163430;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UmLMWLzqSVJb3i4hpxGU8DfPCxonGkzeRg9cK3jhrKk=;
 b=OXGpWuggw74Nw+62oOzh9Kji9PDRTuIL4+qwILYnrlqDE9qrAMxgv+W502N0bkS7kw
 PkjgzxxSKoMB9qurxs9h1g0QNmtU7xrebtMqJcbfyQwC8XRnWu4N8eVRjTK8HUjf5uWM
 t1RMSy7Y6MqPXZGOgiqRvMAIjFquaYsDcWu2f2xR0kiAUYfGDfyTLmTsw/HE6v1BLyf/
 RWa9i4Ifj85OguAvyUb/272sthZOmXbMgJBHtXDczqdwQ1aTTl1Yy3Jr2hG/rxr17JfX
 kE83UBhDLtggJD+qoPTR1YgcXjMyJ/f5GY2281uYOLyDaYJc35cZq3f766IazPsNcdEZ
 NUtA==
X-Gm-Message-State: AOJu0YzixmNbILfzR+1b+0haQfpI7WRaoeCbXENxi3Yl7XyGM5VWWbhv
 vr29qea1nNTN3dNFZJQ3duVwn7cprCpx098wDpuG9oaZEbNFoPtplWHghijV0i104kLjYNxYoqb
 CDHw=
X-Google-Smtp-Source: AGHT+IEVKKxrVnSmWTEszfSSmarhUWZExfRHOE/2CmzMsFvJSvVmT8/wrTJ2+2Nj7zkX00MdtsSsAQ==
X-Received: by 2002:a05:6000:2ab:b0:366:ec2c:8642 with SMTP id
 ffacd0b85a97d-366ec2c867dmr11327181f8f.10.1719558630329; 
 Fri, 28 Jun 2024 00:10:30 -0700 (PDT)
Received: from m1x-phil.lan (cho94-h02-176-184-4-239.dsl.sta.abo.bbox.fr.
 [176.184.4.239]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3675a0e16b3sm1337514f8f.61.2024.06.28.00.10.29
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 28 Jun 2024 00:10:29 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PATCH v42 84/98] hw/sd/sdcard: Register unimplemented command
 handlers
Date: Fri, 28 Jun 2024 09:02:00 +0200
Message-ID: <20240628070216.92609-85-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240628070216.92609-1-philmd@linaro.org>
References: <20240628070216.92609-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

Per the spec v4.5 these commands are mandatory,
but we don't implement them.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/sd/sd.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index ebcd8c1e43..9a2bfeaab6 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -2385,24 +2385,30 @@ static const SDProto sd_proto_emmc = {
     .cmd = {
         [0]  = {0,  sd_bc,   "GO_IDLE_STATE", sd_cmd_GO_IDLE_STATE},
         [2]  = {0,  sd_bcr,  "ALL_SEND_CID", sd_cmd_ALL_SEND_CID},
+        [4]  = {0,  sd_bc,   "SEND_DSR", sd_cmd_unimplemented},
         [7]  = {0,  sd_ac,   "(DE)SELECT_CARD", sd_cmd_DE_SELECT_CARD},
         [9]  = {0,  sd_ac,   "SEND_CSD", sd_cmd_SEND_CSD},
         [10] = {0,  sd_ac,   "SEND_CID", sd_cmd_SEND_CID},
         [12] = {0,  sd_ac,   "STOP_TRANSMISSION", sd_cmd_STOP_TRANSMISSION},
         [13] = {0,  sd_ac,   "SEND_STATUS", sd_cmd_SEND_STATUS},
+        [14] = {0,  sd_adtc, "BUSTEST_R", sd_cmd_unimplemented},
         [15] = {0,  sd_ac,   "GO_INACTIVE_STATE", sd_cmd_GO_INACTIVE_STATE},
         [16] = {2,  sd_ac,   "SET_BLOCKLEN", sd_cmd_SET_BLOCKLEN},
         [17] = {2,  sd_adtc, "READ_SINGLE_BLOCK", sd_cmd_READ_SINGLE_BLOCK},
+        [19] = {0,  sd_adtc, "BUSTEST_W", sd_cmd_unimplemented},
         [23] = {2,  sd_ac,   "SET_BLOCK_COUNT", sd_cmd_SET_BLOCK_COUNT},
         [24] = {4,  sd_adtc, "WRITE_SINGLE_BLOCK", sd_cmd_WRITE_SINGLE_BLOCK},
         [27] = {4,  sd_adtc, "PROGRAM_CSD", sd_cmd_PROGRAM_CSD},
         [28] = {6,  sd_ac,   "SET_WRITE_PROT", sd_cmd_SET_WRITE_PROT},
         [29] = {6,  sd_ac,   "CLR_WRITE_PROT", sd_cmd_CLR_WRITE_PROT},
         [30] = {6,  sd_adtc, "SEND_WRITE_PROT", sd_cmd_SEND_WRITE_PROT},
+        [31] = {6,  sd_adtc, "SEND_WRITE_PROT_TYPE", sd_cmd_unimplemented},
         [35] = {5,  sd_ac,   "ERASE_WR_BLK_START", sd_cmd_ERASE_WR_BLK_START},
         [36] = {5,  sd_ac,   "ERASE_WR_BLK_END", sd_cmd_ERASE_WR_BLK_END},
         [38] = {5,  sd_ac,   "ERASE", sd_cmd_ERASE},
+        [39] = {9,  sd_ac,   "FAST_IO", sd_cmd_unimplemented},
         [42] = {7,  sd_adtc, "LOCK_UNLOCK", sd_cmd_LOCK_UNLOCK},
+        [49] = {0,  sd_adtc, "SET_TIME", sd_cmd_unimplemented},
         [55] = {8,  sd_ac,   "APP_CMD", sd_cmd_APP_CMD},
         [56] = {8,  sd_adtc, "GEN_CMD", sd_cmd_GEN_CMD},
     },
-- 
2.41.0


