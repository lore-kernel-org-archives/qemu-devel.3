Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14A31CF11C6
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2024 10:22:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syqHe-0006Rs-Bu; Thu, 10 Oct 2024 06:20:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r.peniaev@gmail.com>)
 id 1syqHd-0006Qj-1t
 for qemu-devel@nongnu.org; Thu, 10 Oct 2024 06:20:37 -0400
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <r.peniaev@gmail.com>)
 id 1syqHb-0003Y9-As
 for qemu-devel@nongnu.org; Thu, 10 Oct 2024 06:20:36 -0400
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-a994c322aefso341655066b.1
 for <qemu-devel@nongnu.org>; Thu, 10 Oct 2024 03:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1728555634; x=1729160434; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/B3uUlTe/WJMxVfEt4kkHWNRgsgqgpvt34BgS/aXzq0=;
 b=KitXSroHn6XrczbWDQWUI4ufYCuYsfD6p/ODQVm2ArV5CGrKkgPATeQmkdWdTgWj+V
 k4JElsQQ4sbdshmcIA9afcutU9UURkkQZ1HvcAmGnXHLMX+K7E7WnvDsyLo9znLv77xc
 V7m51Cdorf83Igy13dFuxWIazwCgovqJQ1Duhb4MXOcQ4qQGiucZ/wh5vrIlfqHcJCJ9
 aUsavhLA07NmWUERtzZFN8nsn7efzvuyja9/nnhOAov9gslv7YA/Jwul1FBgPyFSXm6Q
 K4vpYyhZI6003TnBiyraO5KqcGcyv8iQtCGxtAUV1ehS198DMx4zDDPS3EE4omQ4+A46
 Yugg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728555634; x=1729160434;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/B3uUlTe/WJMxVfEt4kkHWNRgsgqgpvt34BgS/aXzq0=;
 b=EuiXQTJ0duMJvPaxmGPTWtbPW85/0c7hT3BK4+S9NEQLH/dUk5rQEtTHKpJ+vSJ/vU
 Ec4cNVRDfacyT/HnbTiMJvwOcMLZd+ziMYn9YWiDB46WoalxjmJqvNGqbgq1QwsreQRY
 h/xhM9NYL3CMYgCBexUnxkN+t1BfDnbDehnaYZHmz6NqVMXkR4EqbVhZswGMS9gKbiin
 +AnxexPYnWYNtveQs52skEhAPtmgu3Q7WqfLjAx55vHCshrVAGXo2ehpTCZJYPHEkCh2
 kyZ3j+hKlGJ6djaz6kl8a36OLJf6ZNVItrk4JWWyMgjKnc/4qpukM8SiEhGoccG6rgL0
 GPxg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXV6TUfac091hiSM/FxaFXf9gVOtDQ2HocthDO1sGbueNKU63oLILmGixIqpS37FwcFZbRj8FXTgjb0@nongnu.org
X-Gm-Message-State: AOJu0Yw4mOy6ZUgQMRO7JOfs0HTj7iIT5V95Kl5Z5T/9v8ZbPI8+nPms
 8O1t1uoSoSLP++YYUi8VgFD5uZYQv33sPj44cSeT9EqLgm0QojDsgBAAsQ==
X-Google-Smtp-Source: AGHT+IHD7o2J07QLYqLkFfDnkC1JRDTpXLO6DjL5U90wWNGqiHauVuPhfJkWfB/OKKCkUhec+I/xRA==
X-Received: by 2002:a17:906:7312:b0:a77:ca3b:996c with SMTP id
 a640c23a62f3a-a99a110835amr274730066b.16.1728555633750; 
 Thu, 10 Oct 2024 03:20:33 -0700 (PDT)
Received: from finn.fritz.box ([2a02:8109:8384:1400:eb7f:8fd0:f96c:766b])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a99a7f2436fsm68240266b.53.2024.10.10.03.20.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Oct 2024 03:20:33 -0700 (PDT)
From: Roman Penyaev <r.peniaev@gmail.com>
To: 
Cc: Roman Penyaev <r.peniaev@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Subject: [PATCH v3 4/7] chardev/char: introduce `mux-be-id=ID` option
Date: Thu, 10 Oct 2024 12:18:35 +0200
Message-Id: <20241010101838.331032-5-r.peniaev@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241010101838.331032-1-r.peniaev@gmail.com>
References: <20241010101838.331032-1-r.peniaev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=r.peniaev@gmail.com; helo=mail-ej1-x629.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Patch introduces `mux-be-id=ID` option for all chardev devices.
This is necessary to attach chardev to `mux-be` for backend
multiplexing. Actual implementation wimplementation will follow.

Signed-off-by: Roman Penyaev <r.peniaev@gmail.com>
Cc: "Marc-André Lureau" <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org
---
 chardev/char.c | 3 +++
 qapi/char.json | 6 +++++-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/chardev/char.c b/chardev/char.c
index d38a0c76a51e..ec9a6c4d2499 100644
--- a/chardev/char.c
+++ b/chardev/char.c
@@ -933,6 +933,9 @@ QemuOptsList qemu_chardev_opts = {
         },{
             .name = "mux",
             .type = QEMU_OPT_BOOL,
+        },{
+            .name = "mux-be-id",
+            .type = QEMU_OPT_STRING,
         },{
             .name = "signal",
             .type = QEMU_OPT_BOOL,
diff --git a/qapi/char.json b/qapi/char.json
index e04535435034..fb0dedb24383 100644
--- a/qapi/char.json
+++ b/qapi/char.json
@@ -199,11 +199,15 @@
 # @logappend: true to append instead of truncate (default to false to
 #     truncate)
 #
+# @mux-be-id: id of the mux-be device for backend multiplexing
+#     (since: 9.2)
+#
 # Since: 2.6
 ##
 { 'struct': 'ChardevCommon',
   'data': { '*logfile': 'str',
-            '*logappend': 'bool' } }
+            '*logappend': 'bool',
+            '*mux-be-id': 'str' } }
 
 ##
 # @ChardevFile:
-- 
2.34.1


