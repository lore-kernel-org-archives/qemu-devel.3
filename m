Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62E49C02183
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2025 11:42:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXfFt-0005C1-0g; Tue, 14 Jan 2025 06:38:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tXfFg-00056y-Df
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 06:38:32 -0500
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tXfFe-0005Q4-G5
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 06:38:32 -0500
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-5d3d14336f0so9218364a12.3
 for <qemu-devel@nongnu.org>; Tue, 14 Jan 2025 03:38:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736854709; x=1737459509; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JhuWbz37w1Y1jozAto2PdaStriGQyF5dVt49ZcJCRfQ=;
 b=wrPmxuh5qgxEsvFT/w9ColFq7CFUTz2nSqDz4VR5zEiLpR7Zk+bkpPaiZRRkvY4r2Q
 uVgihEo8WKGuR1k30pR8/jU2h7eTSaWmel3nPZFTWIhpD+NTTS+5mymjiIQPBKss8T+m
 O3qI257pqgMb3Ga+39+tp5g8EcoeTB8aQhQVIAP0DNDNze7+gzL4EKl6QTzvmwddZfHz
 3xD4HkZJlnD+gb0mztEy2htxd+UsxA+IGSQKS4X4ChsLH+a1axpiH8gxiWiTKLSlv13B
 2cTxW8rwgmmCAcNiWgrnuyAcw62BKPACBs6hHSO6SQu/5dmzRN4fPvCfDlFj5r5XjO2d
 nZBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736854709; x=1737459509;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JhuWbz37w1Y1jozAto2PdaStriGQyF5dVt49ZcJCRfQ=;
 b=m8xmPMoOAzqP3yJgty9XGmWdvYOtBNJAQPfR15WtaK6BG/o8puuu4Uxvt3jBj5PYTh
 VmxjK7ujpWEQkCjMd6s2377PYejqySxTDfbjwYUpXLf7vBJzPCXvDs8Nye0Yh7xMZ8F3
 e/7QPIlNjdAnS1dhvoiRv0farjjzWBEDEvF9ulhPuOcLfUbkx2T9tVvWUFNTvPdzOvmi
 domUr0FcQop7GOX/VjQajuH0Qmh9cJznZT/2FXBRPknvtdhbHzKBQDpY6H6DCCQO3EhM
 Iui1RFrZ8i4eUb6245C+pqPvtHp7IGsLq7OOIRLGtbKn4ERq43WbChINC1CrDteYeotv
 lg5Q==
X-Gm-Message-State: AOJu0YyqEpnGMNBJcBaFt3X8nQpc8Br3BPKv//u9VTGGqFqVMo7ItJkm
 iIKAHyMFcScQmavlw26JGWF2ec2aeQJMPYVtRYj+Kz2CZu4n9n3n2jLvh4nayF9meuEac5jTGls
 B8v0=
X-Gm-Gg: ASbGncvwygms+rTwcPLZ2JeCSXbLXrpqq21bFRoW2hnUY5N3YxqOL98C6+oDhGqy0LW
 r5Iu3gEf4s4tLicxMG5CeAkSDKd539v5i9sdb4MHcB4O0n2zgOzRLywYYAE2NyD+MgoP4y3TRMK
 bkZG3CgPFMv6G+d8x+YYWgS7PXxKq1CemiGFSRZZ17LgPbQm5xJpzKekN/gXMbLddF8Q9lZR18c
 dvlf7ACKUZrTQTymE6zcqbs5rtcr5S+tSLNy9Hwz4EGcfTHOT7QzkU=
X-Google-Smtp-Source: AGHT+IFKkemRyuRcCVj7lg8AL+r70yww2bUC5tH0NctssZn6fTQWNnEnN8ayHWo+c4iWUXkUTvUR9w==
X-Received: by 2002:a05:6402:540e:b0:5d0:b51c:8478 with SMTP id
 4fb4d7f45d1cf-5d972e0e274mr22202061a12.12.1736854708901; 
 Tue, 14 Jan 2025 03:38:28 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5d99008c37csm6173423a12.6.2025.01.14.03.38.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jan 2025 03:38:26 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 946EF5F9D8;
 Tue, 14 Jan 2025 11:38:22 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefan Weil <sw@weilnetz.de>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v2 09/37] system: squash usb_parse into a single function
Date: Tue, 14 Jan 2025 11:37:53 +0000
Message-Id: <20250114113821.768750-10-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250114113821.768750-1-alex.bennee@linaro.org>
References: <20250114113821.768750-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x530.google.com
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

We don't need to wrap usb_device_add as usb_parse is already gated
with an if (machine_usb(current_machine)) check. Instead just assert
and directly fail if usbdevice_create returns NULL.

Message-Id: <20250109170619.2271193-10-alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 system/vl.c | 22 ++++------------------
 1 file changed, 4 insertions(+), 18 deletions(-)

diff --git a/system/vl.c b/system/vl.c
index 7e3e6fb353..e769132ba3 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -811,31 +811,17 @@ static void configure_msg(QemuOpts *opts)
 /***********************************************************/
 /* USB devices */
 
-static int usb_device_add(const char *devname)
+static int usb_parse(const char *cmdline)
 {
-    USBDevice *dev = NULL;
+    g_assert(machine_usb(current_machine));
 
-    if (!machine_usb(current_machine)) {
+    if (!usbdevice_create(cmdline)) {
+        error_report("could not add USB device '%s'", cmdline);
         return -1;
     }
-
-    dev = usbdevice_create(devname);
-    if (!dev)
-        return -1;
-
     return 0;
 }
 
-static int usb_parse(const char *cmdline)
-{
-    int r;
-    r = usb_device_add(cmdline);
-    if (r < 0) {
-        error_report("could not add USB device '%s'", cmdline);
-    }
-    return r;
-}
-
 /***********************************************************/
 /* machine registration */
 
-- 
2.39.5


