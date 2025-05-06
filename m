Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3C9BC3ABBE
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 14:38:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCJQR-0001Kw-MT; Tue, 06 May 2025 10:37:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uCJPL-0008Jr-24
 for qemu-devel@nongnu.org; Tue, 06 May 2025 10:36:32 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uCJPJ-00018B-8m
 for qemu-devel@nongnu.org; Tue, 06 May 2025 10:36:30 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-43cf628cb14so47910745e9.1
 for <qemu-devel@nongnu.org>; Tue, 06 May 2025 07:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746542187; x=1747146987; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pvs8pGHXAqE+ZMrhpC+Do149+w0B/BO5bfUwReCuJQA=;
 b=XyILwATtLMoaPOWPysYvAr4MfbVLg3e+CiEL9W/+gLS6fK7Xkxo7YuPQT7Si5ExT6f
 jcWHYZ83uLWXRg29jrxDvmty+rERkyIl8c6kCad2UDrupTFBG7cwi2GcNg8QkIGUPg5m
 DeDtlqAkYQ+6ZkQhYsoHxrd4goO9QieY9aATcV3smmOcP8UxOjs1H/tdsl3H251tr2JC
 x3jbes2O3uCT8Y6Lc6Cz6pWBCw1YqvgW0OIC0LyAapyJbZptwmOFlY9xTcUTMWEKntrg
 LkQZNZFduJsDPHoLYtSgg8UboWFBprzAY0A9Xj24ywQy7t8s7cjlXdv4tD1A6HmSL1iT
 inHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746542187; x=1747146987;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pvs8pGHXAqE+ZMrhpC+Do149+w0B/BO5bfUwReCuJQA=;
 b=Tl3/uVclsBKeAQsTvITBU6S7++oJdqsDMTX9myB8vjWk8w4psW6wbckIKBgZQF73HJ
 cwbK22EdMXiPd+2nlV1Dm4bkvpzr7WnY447Kg+pjCrxdRsZqsdHzSUi8qrDkwRQGl5V4
 ucD9BoB/Uryygyik0UpHnQ0vCCgSAziWOE78TEFJCKlbGVWw7voMOw/QYUFpDHfua1eW
 a2gbySv2aQXLO0uftdX4hqi5iu9UetWN++Rcah/Pu07jmT0ykuVqwVmt7kAoG0lPIFJC
 QDilW+f8GHLyRi5khwXw9SiQuUhfVkU37Gs3VtdvbX0hCvmQ9ltiV4xNMVFG6YDzyRx9
 bx8w==
X-Gm-Message-State: AOJu0Yw1PHqlU5qbqDIVocnmPk4iyisTUxImHO0LyPdnNsYBRYnb27Rg
 Eu6a3uMV4+kVJpiHxlX/INgeqbrrA75UdJDH2JiGaLjJCk/OctUo22jJAoC18L4piix0NpoubaV
 G
X-Gm-Gg: ASbGncvZjBILRGOt9CLnDUxqL0Tpoez/S9awQ9ugs7K0POFDsiQPC/TKfo0tO0icXLZ
 b8g7h0LjN90iIVdzRKoIykQ8bkZXXLN/ysgSUbkVsRROXE/WyRGRsqCKeLWrD6X/AbQ/eGTIAEm
 E72J47O+xuMQgiRRjZHGgcHPC08oOLc72sU9S4TNNVUJuVvWBh1HOWuPFeAV04irDTvamWpEYA1
 f64htbHhs0ASodu5zke+TAWT03LIulS9TTXotOowaKz0Y6GbzYYXkx6Ue8ha1kiiLj4QdmWgz0K
 uzvbgJ2wDSfYTTCZzSCwVsZh6tt23/QmD9sGCViuY9FHiQZvdcOS7b0/Mxyasc6gDTzIexxf4z7
 bsP+Ftwv27xkd76P1eWoQTEzH31mQYXA=
X-Google-Smtp-Source: AGHT+IG6Ly53OevvI8vOtP9TJ0M9hnCQLN9KMm4VjUTmO63IBspcJC4YiTlMA/0RJ+4lNC539qRwXQ==
X-Received: by 2002:a05:600c:499a:b0:440:67d4:ec70 with SMTP id
 5b1f17b1804b1-441d3a49c65mr122995e9.8.1746542186681; 
 Tue, 06 May 2025 07:36:26 -0700 (PDT)
Received: from localhost.localdomain (91-163-26-170.subs.proxad.net.
 [91.163.26.170]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-441b2af2922sm215358495e9.17.2025.05.06.07.36.25
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 06 May 2025 07:36:25 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Gustavo Romero <gustavo.romero@linaro.org>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 15/22] hw/core/machine: Fix indentation
Date: Tue,  6 May 2025 16:35:04 +0200
Message-ID: <20250506143512.4315-16-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250506143512.4315-1-philmd@linaro.org>
References: <20250506143512.4315-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

From: Gustavo Romero <gustavo.romero@linaro.org>

Fix indentation for some elements in the hardware compat arrays.

Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20250504215639.54860-6-gustavo.romero@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/core/machine.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index ed01798d37c..b8ae155dfa1 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -41,7 +41,7 @@ GlobalProperty hw_compat_10_0[] = {};
 const size_t hw_compat_10_0_len = G_N_ELEMENTS(hw_compat_10_0);
 
 GlobalProperty hw_compat_9_2[] = {
-    {"arm-cpu", "backcompat-pauth-default-use-qarma5", "true"},
+    { "arm-cpu", "backcompat-pauth-default-use-qarma5", "true"},
     { "virtio-balloon-pci", "vectors", "0" },
     { "virtio-balloon-pci-transitional", "vectors", "0" },
     { "virtio-balloon-pci-non-transitional", "vectors", "0" },
@@ -58,12 +58,12 @@ GlobalProperty hw_compat_9_1[] = {
 const size_t hw_compat_9_1_len = G_N_ELEMENTS(hw_compat_9_1);
 
 GlobalProperty hw_compat_9_0[] = {
-    {"arm-cpu", "backcompat-cntfrq", "true" },
+    { "arm-cpu", "backcompat-cntfrq", "true" },
     { "scsi-hd", "migrate-emulated-scsi-request", "false" },
     { "scsi-cd", "migrate-emulated-scsi-request", "false" },
-    {"vfio-pci", "skip-vsc-check", "false" },
+    { "vfio-pci", "skip-vsc-check", "false" },
     { "virtio-pci", "x-pcie-pm-no-soft-reset", "off" },
-    {"sd-card", "spec_version", "2" },
+    { "sd-card", "spec_version", "2" },
 };
 const size_t hw_compat_9_0_len = G_N_ELEMENTS(hw_compat_9_0);
 
-- 
2.47.1


