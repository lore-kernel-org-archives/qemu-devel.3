Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FAAB1091910
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2026 19:14:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3Iog-0004OL-If; Thu, 19 Mar 2026 15:13:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matyas.bobek@gmail.com>)
 id 1w3Iof-0004N1-9w
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 15:13:57 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <matyas.bobek@gmail.com>)
 id 1w3Iod-0000lA-Qo
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 15:13:57 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-485392de558so8598125e9.1
 for <qemu-devel@nongnu.org>; Thu, 19 Mar 2026 12:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773947634; x=1774552434; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xxHyhNtXhPVKNOqCpOT5PZ574T8yUIY7ZkK8dJCV2WI=;
 b=AG83IBe8YTU3RZF9XNdywXA73n+TQmoH0CjR3vA/+L11KWXscTJDvEJuFI975qvzIa
 bLn5UQv0Nqn4ZpSJkakiYiUeAUQWceXDQA8gstkUUqHRK09J4MtNN9EBOZ0AEMfGng7A
 oC2qDIkn746j2b1iVxNyDJxQWjR94uLnJffYn93MrSHXrgxv0QDPlGtMWFrG7LztVIh4
 zg4fIWA4/Wdb9dY68OFY5GgOSdpwW2JiMLEsT4vDH3gfWtsuCN6CBxkeEo6IPN34xEKy
 dVGU8YTfy1yTj+tEaL3P5mWdZo+G4Rb+VJ34aawNJVihTfrX3Z0komYH+x2gf32XC74Q
 B80A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773947634; x=1774552434;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xxHyhNtXhPVKNOqCpOT5PZ574T8yUIY7ZkK8dJCV2WI=;
 b=Db5U+w3+YJ8VSUq8HfYIW1LjHAQNmrU5C378ZCp6u+1gaKDh3XFbIyVdK7pJh9xeGN
 uSpWqENpRaVv60ubNcNzRjIZNF8YbFNYF7zOrpZZdVHl0odWI+u7L6W6gIMkXh2uhGJI
 mD3uYUsETokZVma83NW4h/DVpyyD5gykvQRgYkMpf1QbrQwyWcblVoUMo6ZTEWv43Lug
 EJqsUMppD3wMIYFzeeJ+o/ktSedJsklTHxRVsFjxAUPlq/dSfFfuGzBl6v4thvurXxGU
 6GAkhmyponWO/fZseRy7/yHOzDif4WW+/a1vyz2F8UXLHLB6axToNr9BSRMvI/cxbt9A
 SczA==
X-Gm-Message-State: AOJu0YwFWModZwfrkhoqa7otcfWiCWX0eYJd6/CKZiczItw5kBcZEd/X
 RNr9tZzSTp9hZDR8gxPHo13OToqLXI1oSAzPApdibWQ2QXLfYkX9f9K4epj1qYK5
X-Gm-Gg: ATEYQzwwQKu7Akm9aQwayDp3LQ27QG3X9b7X0HZ+iCJsKg4gAXs1X6gJnG/ZveD+K0d
 WMvEyLwy5QwXAdAC8kmJ8ob23ZjNZsiSb8yUPBsNsV/mCe9V+/hBsv9MVhpUqRKKRl4Gc/H+EIn
 BODRTncEjs5Up1uX4upVUIO/wuH1rdPWbq82sY8WSJzesJzSH3F3XWrUwXOTJlcg34dVBLs7U4+
 2i/aKnm/g4yZqVpMXmdVKOV+ErwQqCFegNk7IJ4P0QSlXilP03zHc6MahNduIoOUMOrLOH32GAu
 HcIpbbP8R0XaUfgJNdf7IazYiI1C6WqpqNvuj85+z7VUb4FCcg2cYC3b+CxPkb5Bksf5AY5LBi/
 ufN3yTNB9aLTIYeUjrIRXCPbpeMDV8j2ZwJf16yGBTbobNSrbdEkpVFbfyoK+Dm/S90AsnN2rKH
 bhwlzGWqlGLQEbP0TlGzCq4Ofadgb8DAg7vPepP2sS7ZS7ynu5hWo6DQ==
X-Received: by 2002:a05:600c:a43:b0:485:3f1c:d897 with SMTP id
 5b1f17b1804b1-486fedb586dmr4417925e9.9.1773947633832; 
 Thu, 19 Mar 2026 12:13:53 -0700 (PDT)
Received: from acidburn.pod.cvut.cz (acidburn.pod.cvut.cz. [147.32.90.2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b64714e2esm635921f8f.32.2026.03.19.12.13.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Mar 2026 12:13:53 -0700 (PDT)
From: =?UTF-8?q?Maty=C3=A1=C5=A1=20Bobek?= <matyas.bobek@gmail.com>
To: qemu-devel@nongnu.org, Matyas Bobek <bobekmat@fel.cvut.cz>,
 Pavel Pisa <pisa@fel.cvut.cz>, Bernhard Beschow <shentey@gmail.com>
Cc: qemu-arm@nongnu.org, Marc Kleine-Budde <mkl@pengutronix.de>,
 Oliver Hartkopp <socketcan@hartkopp.net>,
 Nikita Ostrenkov <n.ostrenkov@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Maty=C3=A1=C5=A1=20Bobek?= <matyas.bobek@gmail.com>
Subject: [PATCH v2 1/7] hw/arm/sabrelite: Open code DEFINE_MACHINE_ARM
Date: Thu, 19 Mar 2026 20:13:08 +0100
Message-ID: <0528e7cd5cff7ce171b0aad0093a5e77e07c139a.1773866323.git.matyas.bobek@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1773866323.git.matyas.bobek@gmail.com>
References: <cover.1773866323.git.matyas.bobek@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=matyas.bobek@gmail.com; helo=mail-wm1-x32b.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Open code the DEFINE_MACHINE_ARM macro in preparation of creating
SabreliteMachineState class. The name field in TypeInfo initializator
is left as string literal since the macro would expand into this.

Signed-off-by: Matyáš Bobek <matyas.bobek@gmail.com>
---
 hw/arm/sabrelite.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/hw/arm/sabrelite.c b/hw/arm/sabrelite.c
index db5669c5c2..40ee8196ac 100644
--- a/hw/arm/sabrelite.c
+++ b/hw/arm/sabrelite.c
@@ -114,4 +114,25 @@ static void sabrelite_machine_init(MachineClass *mc)
     mc->auto_create_sdcard = true;
 }
 
-DEFINE_MACHINE_ARM("sabrelite", sabrelite_machine_init)
+static void sabrelite_machine_class_init(ObjectClass *oc, const void *data)
+{
+    MachineClass *mc = MACHINE_CLASS(oc);
+
+    sabrelite_machine_init(mc);
+}
+
+static const TypeInfo sabrelite_machine_init_typeinfo = {
+    .name          = MACHINE_TYPE_NAME("sabrelite"),
+    .parent        = TYPE_MACHINE,
+    .class_init    = sabrelite_machine_class_init,
+    .instance_size = sizeof(MachineState),
+    .abstract      = false,
+    .interfaces    = arm_machine_interfaces,
+};
+
+static void sabrelite_machine_init_register_types(void)
+{
+    type_register_static(&sabrelite_machine_init_typeinfo);
+}
+
+type_init(sabrelite_machine_init_register_types)
-- 
2.53.0


