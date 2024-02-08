Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5153BC48260
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Feb 2024 18:13:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rY8tl-0004k4-4o; Thu, 08 Feb 2024 13:13:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rY8tb-0004IS-A5
 for qemu-devel@nongnu.org; Thu, 08 Feb 2024 13:13:14 -0500
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rY8tS-0006kx-FZ
 for qemu-devel@nongnu.org; Thu, 08 Feb 2024 13:13:09 -0500
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-55a90a0a1a1so298488a12.0
 for <qemu-devel@nongnu.org>; Thu, 08 Feb 2024 10:13:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707415981; x=1708020781; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qwWWw6/AhfeHezI8OBy+gdgG3eOQyHTGWWLFzL2P+Mo=;
 b=iMKrJTI5G89jKVELuig+jjr6KJxQTLPRDGbFEpqYrcJokMuCrcrYKnB4vV4+futlSd
 AfztfM4YrKz/jPU1mBoznwI90vR9f4l9ixkwyMuDuoHJIgbLgsLOSpdX/kwocQjb5XW6
 Rbleb1BqVH9ndk1HgdNlkaAGr3+IVdzSigZfaKvYEoNH0RAMRDXN7O0gmJxbAufx8Dat
 4zldWNgrrDH4YJNY1QuaJ0ODqHPfSwtcqsPWVBB+UZ9inBh0jIec9cvQ7qbqDUuUHFvp
 vHprdjTXdlcrCj3cKQcYeqhJSdpNdEPMODYFCng1ou/o/kedIGn9EnuQNhLW/slF6IC5
 9+6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707415981; x=1708020781;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qwWWw6/AhfeHezI8OBy+gdgG3eOQyHTGWWLFzL2P+Mo=;
 b=vTPLiD9emvkV5CVg2xpzEtujFtUEW7ffNVHUwgd0i0cz7uAlDXakEygzwDsLJliN1F
 pr2Qi5cacuVdT5YCD9ihOkSDjsZSmlguauLjg1647txXyVjWjYJhJmByjDrE8/76LRri
 aIDQwvFxOcAMjCKxMCm/xw/eV3fb0QMocrwkPbxwiLdY3IoiEnNQcKQWMpalh1tI32tD
 Q9WEG6+ramaf1LzZFhyivfUQ7z6e5HjpDX9aXwS4UW54dW6APnUdd/Ko/0pJ/ZXzkRqd
 rpCrhrtjAaZokNZl9+1AOXuAgGGjRcXLhl97miAqRIjWbzupN2IaC1TehhxfME8YniID
 OJ8A==
X-Gm-Message-State: AOJu0YxxA1NGyiCJQNHvG9Ffs5gOt8zzRlE4HHkN4foh8dKeUc1GqNuy
 Ogug4bzWVXKHdbVvjSJ072oBWxqD5VIR0uMloPJZ9ZIql3UKWuuiFc3F5jcWia9EQx6mErlqEbB
 HjuA=
X-Google-Smtp-Source: AGHT+IF5BMfalEYcgl7odqRt1Gb2Pbj2dtl8y+1R9W7ZiWQ8kHZE0N5X8QNCNNRvPFGcacejFRkYbA==
X-Received: by 2002:a05:6402:1a48:b0:55f:e493:33b4 with SMTP id
 bf8-20020a0564021a4800b0055fe49333b4mr28068edb.15.1707415980948; 
 Thu, 08 Feb 2024 10:13:00 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCUxITh5WgxpxEnE0pCbPY+mJp69t0QXA6TXFqR3rOI55w+MctTFXycjLSOQV0oK20G6Q8pwA6IyIzSF0PWJhHplV7PODdE7gA//sj4lq3tN7D0I64VCJZZFbCWac5qdp1foL42qazV6gwWXDoczLime+0ZH57fSVsTlYJssXJXSfZn7fleQ7MnqTc0PUYpIjtTh/kMPOUP9O4Fl1HmRccBGyGcPmHUIiwGh1ytQuNtJRghivWX5u6f2UFuvkXFuVp7xj+ZcWE06qln9AkN6fV5+Hrsqczc8xcrqcDGyNr2lb/wjdeCp6eUQTghyLrHxBbe68Q7+xH7uXqyd3it8CvUpHrdk2itJvytCTUYjJXLEPEk=
Received: from m1x-phil.lan ([176.187.218.105])
 by smtp.gmail.com with ESMTPSA id
 g12-20020a056402320c00b0056038077ffasm1078573eda.38.2024.02.08.10.12.59
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 08 Feb 2024 10:13:00 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Zhao Liu <zhao1.liu@linux.intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-block@nongnu.org, John Snow <jsnow@redhat.com>, qemu-ppc@nongnu.org,
 Eduardo Habkost <eduardo@habkost.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yoshinori Sato <ysato@users.sourceforge.jp>
Subject: [PATCH v3 02/11] hw/rx/rx62n: Reduce inclusion of 'qemu/units.h'
Date: Thu,  8 Feb 2024 19:12:35 +0100
Message-ID: <20240208181245.96617-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240208181245.96617-1-philmd@linaro.org>
References: <20240208181245.96617-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x529.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

"qemu/units.h" is not used in the "hw/rx/rx62n.h"
header, include it in the source where it is.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/rx/rx62n.h | 1 -
 hw/rx/rx-gdbsim.c     | 1 +
 hw/rx/rx62n.c         | 1 +
 3 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/hw/rx/rx62n.h b/include/hw/rx/rx62n.h
index 73ceeb58e5..bcda583ab3 100644
--- a/include/hw/rx/rx62n.h
+++ b/include/hw/rx/rx62n.h
@@ -29,7 +29,6 @@
 #include "hw/timer/renesas_tmr.h"
 #include "hw/timer/renesas_cmt.h"
 #include "hw/char/renesas_sci.h"
-#include "qemu/units.h"
 #include "qom/object.h"
 
 #define TYPE_RX62N_MCU "rx62n-mcu"
diff --git a/hw/rx/rx-gdbsim.c b/hw/rx/rx-gdbsim.c
index 47c17026c7..bb4746c556 100644
--- a/hw/rx/rx-gdbsim.c
+++ b/hw/rx/rx-gdbsim.c
@@ -20,6 +20,7 @@
 #include "qemu/cutils.h"
 #include "qemu/error-report.h"
 #include "qemu/guest-random.h"
+#include "qemu/units.h"
 #include "qapi/error.h"
 #include "hw/loader.h"
 #include "hw/rx/rx62n.h"
diff --git a/hw/rx/rx62n.c b/hw/rx/rx62n.c
index 4dc44afd9d..d3f61a6837 100644
--- a/hw/rx/rx62n.c
+++ b/hw/rx/rx62n.c
@@ -23,6 +23,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
+#include "qemu/units.h"
 #include "hw/rx/rx62n.h"
 #include "hw/loader.h"
 #include "hw/sysbus.h"
-- 
2.41.0


