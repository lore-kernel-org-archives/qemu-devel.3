Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E841C3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 20:40:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWMIT-000578-W3; Tue, 23 Jul 2024 16:39:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sWMIQ-0004su-Tc
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 16:39:42 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sWMIP-0003yB-7w
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 16:39:42 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-427d8f1f363so34183875e9.2
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2024 13:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721767178; x=1722371978; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PVW3Gx4VWf1FcJPawzcx0DDSK91Xb6uFhCXhyBk+SmU=;
 b=xEZFmD0DTPUjTsBSWySthtoHcR2rj1cTmeg7RaOyDAjWEccmOXcSo8msHOJg9fuB9S
 n4godjE7L8/OIK27BGwWsW0ZQgQW6L6CZUEZtAxs5g4mh6bwaJOu4Z3n3jpy43NsXs3i
 s0kD7SOb9La/Di3I/EBHD5Z2dZNjI5PWjSRsR6GHfftNqsQ4xki6ISleAIO2H2q+OpfV
 fXIPnUtoEk2Q7q3Xp0BF5C0DaFQHe89KoKfjsN4x5OQcM2UntT3MlgKO6149LHjLvox4
 geCVTfRUiN8nE4q9vqMHI+pbW3TVZQq4UMm+TDKNPdadkHokbkJvSx6p/0TMzohmePhd
 4Ong==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721767178; x=1722371978;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PVW3Gx4VWf1FcJPawzcx0DDSK91Xb6uFhCXhyBk+SmU=;
 b=MX44lc2e0y2ZD7i5v4/mxSdQ5nNlbkIXVp9SODVK3BO8bUbItR4dRI+X17vm+m7YU0
 OyBN0Qi9/j5yjjjmQJsU5zyVNcCQYTkOItXJqb5gDtz/X7reYdda0vKxkWRQK6VdtHos
 gklm6CeW+SIcf5xvhZI7PUouOn21WZFZmfS6QWijFJlGzjxkg/po49sMCTPx8tlqQCaY
 O5jY3GEojtHGPYoCiwddF5T/vZ3ytg5l4eZ05GGK/a3VqlL/aKG0vTK102pZw+0CtOjO
 o8VR37zKE7I/tMMZfvcjUnEr7QZPob9zgoSY0jos9W5V/OzTkTtYu8HjzRMjn59f9CvF
 um/A==
X-Gm-Message-State: AOJu0Yxrt+yWpwLGd6roEbl8IFu4J9ce8LkM9Q4/Qw4CJQIoAdgwya1i
 JSmcp3mB/LrfpAgS62e8J1+ve9Sb2jksp/bsNd2tqj9ghnzXaxnadJynWAhRoI6eSQlEmXBaaBA
 fCOA=
X-Google-Smtp-Source: AGHT+IGPnUCRIxKQjeJQhzrmQRtve4PC+GVadf60BN//tmj6GLFOC2kNB8foVk/9XRalUt8dBgUAGA==
X-Received: by 2002:a05:600c:3ba9:b0:426:647b:1bfc with SMTP id
 5b1f17b1804b1-427dc5584d8mr66747675e9.30.1721767178238; 
 Tue, 23 Jul 2024 13:39:38 -0700 (PDT)
Received: from localhost.localdomain
 (vbo91-h01-176-184-50-4.dsl.sta.abo.bbox.fr. [176.184.50.4])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427f935954fsm575655e9.9.2024.07.23.13.39.37
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 23 Jul 2024 13:39:37 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 07/28] docs/interop/firmware.json: add new enum FirmwareFormat
Date: Tue, 23 Jul 2024 22:38:34 +0200
Message-ID: <20240723203855.65033-8-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240723203855.65033-1-philmd@linaro.org>
References: <20240723203855.65033-1-philmd@linaro.org>
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

From: Thomas Weißschuh <thomas.weissschuh@linutronix.de>

Only a small subset of all blockdev drivers make sense for firmware
images. Introduce and use a new enum to represent this.

This also reduces the dependency on firmware.json from the global qapi
definitions.

Claim "Since: 3.0" for the new enum, because that's correct for its
members, and the members are what matters in the interface.

Suggested-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Message-ID: <20240719-qapi-firmware-json-v6-1-c2e3de390b58@linutronix.de>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 docs/interop/firmware.json | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/docs/interop/firmware.json b/docs/interop/firmware.json
index 54a1fc6c104..d5d4c17f230 100644
--- a/docs/interop/firmware.json
+++ b/docs/interop/firmware.json
@@ -15,7 +15,6 @@
 ##
 
 { 'include' : 'machine.json' }
-{ 'include' : 'block-core.json' }
 
 ##
 # @FirmwareOSInterface:
@@ -200,6 +199,20 @@
              'enrolled-keys', 'requires-smm', 'secure-boot',
              'verbose-dynamic', 'verbose-static' ] }
 
+##
+# @FirmwareFormat:
+#
+# Formats that are supported for firmware images.
+#
+# @raw: Raw disk image format.
+#
+# @qcow2: The QCOW2 image format.
+#
+# Since: 3.0
+##
+{ 'enum': 'FirmwareFormat',
+  'data': [ 'raw', 'qcow2' ] }
+
 ##
 # @FirmwareFlashFile:
 #
@@ -219,7 +232,7 @@
 ##
 { 'struct' : 'FirmwareFlashFile',
   'data'   : { 'filename' : 'str',
-               'format'   : 'BlockdevDriver' } }
+               'format'   : 'FirmwareFormat' } }
 
 
 ##
-- 
2.41.0


