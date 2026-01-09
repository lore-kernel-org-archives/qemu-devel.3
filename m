Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6AA9D232C9
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 06:56:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ve6PE-0003ZS-UW; Fri, 09 Jan 2026 01:55:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1ve6P2-0003TX-3m
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 01:55:20 -0500
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1ve6P0-0002nq-7A
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 01:55:19 -0500
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-bc274b8b15bso2586077a12.1
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 22:55:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1767941716; x=1768546516; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=azluCpwuy12fnH7pKEXgjFpDbSYy56nGenJ1NmQ5bGY=;
 b=gg6BIIfUM6lyu4hVG+nEadAosd57srg9+bnQJq/QO4SKKfZnHMyHSg3qMJq0ZrRub9
 Yt13Uz4GR91+yqjytnjKfCkBBQr0n32klh8uVtQBjjWJtP6eh60un6k246vQqAqCyrfd
 i1XEYtPfEbwglp8EdQ1tt1oRQWudT7nPXfSVziVsHjlMf79PSlCq2LUAthgldPsJ3xF7
 tdVbwMtsBc4V9C7/zqh4yJfRbICBGXs7We8NI53T11FwxvIqTJScQzRSGnuq79DSQ2Hu
 6qKkynzC4lzzFxG4vYeavsOoI4ItY4QR/ARGFReUUzhldLPlzkg/lDbSbLpnmiZCfIab
 QOTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767941716; x=1768546516;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=azluCpwuy12fnH7pKEXgjFpDbSYy56nGenJ1NmQ5bGY=;
 b=KG7OGQkaTaMrLZ6REO98Hcxxd8YJKHmxeh4DrkNxrY8FY7o2e1ke/WqUMyQNXqkJO5
 M+fC6NJBod4edz9UMzVoHKs+9F9uFJBXojotjoXQWo6/mkJ4263thgU3Chz4dzuOU+iT
 W30AgeUsmFC4BkR+bWaZRaWOVCf2rxFQ4nbhNkYimLZDPL+blnsuYnVqwsv7sht0Yjy5
 3bIg5/4Hm9FyRgQZ++1eR8af3NrwSwOmBWK7+r/z3ylXKL4bNCF/K6u3XFKM/rNKOawj
 4eg12uo3OpS9uyYVfaN38dmlmRrNOCS0Cp4RsloFf2CqjTTKXhXitkTpHZs9apE+D/iU
 tUsA==
X-Gm-Message-State: AOJu0YwO+d1x7UCsmf6PWsvBFb3dDkXITUQX3s2rdcFViXyuMAxC8VCJ
 4bLa2QCK5kekxiYwn4DPWGM8qHnpA+wmJpiS9rTPYn7FzyoWUFCReTd3JtyBKA==
X-Gm-Gg: AY/fxX7v56upAcKowwTPiHCmLnfwsPPGhhMyQkRotsfgJelWXkuzEen8NerkJXiYsin
 6/K82w4HTkdE9VV8yi7NaoR2O+zflRlCD5n6l9LPy5PxPE4Kyz9e2v9bt2Lgtp1h8fF6iKuvRIf
 3vm0iU+gS4ByN1Vp00RMHwpZ6afg6QkcC/M5zJh/NcRu9jx23xxr9e9TlepzN/esyGVTudwtlxv
 BcijzQt/8TA3ZErvl8ujq6b0eHzcqpMLZr3wABgiZ94dhLnq5W3LiXXB4Kwo4TL/hD0TqXYo+iW
 v/HsZE3a2SQC4U5gklRdavTf+WbWMZFYT+PEibt4uGrFXi8xgNmxRfcl/gXdrNLJv9QAscJJVcc
 afiHfYYD6oQlL06geEyoqg4azc4djHyvKGw2RF4KntCJYOC5F5BQirRijDXsCfCnXdEXIlY2/cv
 pwiMznPNph0hEaPr+0ZQcmXIHgXICLUOK65LVls0Y6201dbAqS4Ky5qgnGF6vN6Bob2na0ARh3Q
 cv7I/ZMgXYAjBSYaXM=
X-Google-Smtp-Source: AGHT+IGErp3A98ZOoRlmVrTxH6GDwlqxmjsuiYquey8BwXUEzP9v5US/KA03RiQutz1eJo8pMOMb6Q==
X-Received: by 2002:a05:6a20:a10e:b0:33c:2154:d4f4 with SMTP id
 adf61e73a8af0-3898f9975b1mr8479748637.49.1767941716428; 
 Thu, 08 Jan 2026 22:55:16 -0800 (PST)
Received: from toolbx.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c4cc02ecfaasm9953644a12.14.2026.01.08.22.55.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jan 2026 22:55:15 -0800 (PST)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 02/34] hw/core/loader: Fixup whitespace for get_image_size()
Date: Fri,  9 Jan 2026 16:54:27 +1000
Message-ID: <20260109065459.19987-3-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20260109065459.19987-1-alistair.francis@wdc.com>
References: <20260109065459.19987-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x536.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Alistair Francis <alistair.francis@wdc.com>

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by:Vishal Chourasia <vishalc@linux.ibm.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20251030015306.2279148-1-alistair.francis@wdc.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/core/loader.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/hw/core/loader.c b/hw/core/loader.c
index 8252616fdd..b7638ccd72 100644
--- a/hw/core/loader.c
+++ b/hw/core/loader.c
@@ -75,14 +75,20 @@ int64_t get_image_size(const char *filename, Error **errp)
 {
     int fd;
     int64_t size;
+
     fd = qemu_open(filename, O_RDONLY | O_BINARY, errp);
-    if (fd < 0)
+
+    if (fd < 0) {
         return -1;
+    }
+
     size = lseek(fd, 0, SEEK_END);
+
     if (size < 0) {
         error_setg_errno(errp, errno, "lseek failure: %s", filename);
         return -1;
     }
+
     close(fd);
     return size;
 }
-- 
2.52.0


