Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80EBFC25B78
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2024 07:46:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCaUR-00030V-L4; Thu, 30 May 2024 03:46:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sCaUJ-0002pj-V2
 for qemu-devel@nongnu.org; Thu, 30 May 2024 03:46:19 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sCaUI-0003Nb-Al
 for qemu-devel@nongnu.org; Thu, 30 May 2024 03:46:15 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-420180b5922so8049035e9.2
 for <qemu-devel@nongnu.org>; Thu, 30 May 2024 00:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717055172; x=1717659972; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=01WlZSY18T45T+CzrK5D3m5TP/teYv3HLGHIpCdLE80=;
 b=YaBFc0cgXXzfDwjgJDMLmZUppgkjKXoR/kAAzz0MDD4n6B+l73B5DacVqwM8Kshq+g
 TXUhCkLyh7quUfPNsLyDtO/x4Yp3IcMx1Sh+Wo4yzd3LTLg9MNW63fTFfX4PIgOT43c8
 /AyWVmeUgOVaEWUk/Znni8yxGh0hGFWItc2lhlqUNCkAaAjz29xoVRsK8NoGpD9iCxZI
 wLjivIheEdhUwz2GJhoe9VDAkJhiioNGewAxA7ZB8PQVTMYHhHTuX+vP3i1RgiFx44r2
 0GD9kFkQER+ASaxoRQPCd9X44YjqOOup33wGwqZfiWjzkXUJ3KAPUUYdpO2kCdoX4FqX
 O0kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717055172; x=1717659972;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=01WlZSY18T45T+CzrK5D3m5TP/teYv3HLGHIpCdLE80=;
 b=OXOjYo3HZVWVkp0Umcf+FZAFNmP+AWZOm2SG0RO+1i/YVpyIIscsV4JowaQWLa1QD+
 JdNFf//55ahC8Sj6L1bYmwfwsEi3j9al5222Tchf6QgPRJOyWCX+rDIrdCRBqEHe+rrY
 VveTJMzwPKoSoCN4tki6ygylDR/mwp69qDJh+oP7tjAighqs+wqoSQHpeAezVKoli1rK
 gQ41c5yFOI5DsIgOCJSFeTMn0PSMtoU9HWXYDoJtwIvanTo0XtuRs7h+c53TFJL9KfN2
 5/6NRLNi6sNABQS/vfALzyJXZD4kSZF8RD15MbvxrzydFYeraFxDfO0RSeq3sUSUGosj
 p4fA==
X-Gm-Message-State: AOJu0YxUQ2scPcAV16PNsyyCbLP+OSOECRUzLAyGGs1rAbUBhDC+wVK4
 rX1S/g2/MNNMBSoCXXd0vTCq2eBpxLq2lmhQrq0M8cFj322N/3PrK6w+dzgViTluEzAwRwtFHBx
 7
X-Google-Smtp-Source: AGHT+IExIAMHosxoFlC17GavGzKZ3fn87oEyWmjfUV+OpNYjgF4oM6rWA2m11IPbjkI2nnteE0SyYg==
X-Received: by 2002:a05:600c:3d97:b0:420:fdce:6052 with SMTP id
 5b1f17b1804b1-42127931d7cmr15072205e9.41.1717055171744; 
 Thu, 30 May 2024 00:46:11 -0700 (PDT)
Received: from m1x-phil.lan (xbn44-h02-176-184-35-50.dsl.sta.abo.bbox.fr.
 [176.184.35.50]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3557a08a878sm16571046f8f.43.2024.05.30.00.46.09
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 30 May 2024 00:46:11 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dave@treblig.org>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-s390x@nongnu.org, devel@lists.libvirt.org,
 Eric Farman <farman@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Markus Armbruster <armbru@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eric Blake <eblake@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 3/4] hw/s390x: Deprecate the HMP 'dump_skeys' command
Date: Thu, 30 May 2024 09:45:43 +0200
Message-ID: <20240530074544.25444-4-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240530074544.25444-1-philmd@linaro.org>
References: <20240530074544.25444-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Prefer 'dump_s390_skeys' which is target agnostic.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/s390x/s390-skeys.c | 2 ++
 hmp-commands.hx       | 4 ++--
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/hw/s390x/s390-skeys.c b/hw/s390x/s390-skeys.c
index e7dab52a6e..12ec8a808e 100644
--- a/hw/s390x/s390-skeys.c
+++ b/hw/s390x/s390-skeys.c
@@ -120,6 +120,8 @@ void hmp_dump_s390_skeys(Monitor *mon, const QDict *qdict)
 
 void hmp_dump_skeys(Monitor *mon, const QDict *qdict)
 {
+    monitor_printf(mon, "This command is deprecated"
+                        " (replaced by 'dump-s390-skeys')\n");
     hmp_dump_s390_skeys(mon, qdict);
 }
 
diff --git a/hmp-commands.hx b/hmp-commands.hx
index c12e2c2bd9..04ae897134 100644
--- a/hmp-commands.hx
+++ b/hmp-commands.hx
@@ -1138,14 +1138,14 @@ ERST
         .name       = "dump-skeys",
         .args_type  = "filename:F",
         .params     = "",
-        .help       = "Save guest storage keys into file 'filename'.\n",
+        .help       = "deprecated synonym for dump-s390-skeys.",
         .cmd        = hmp_dump_skeys,
     },
 #endif
 
 SRST
 ``dump-skeys`` *filename*
-  Save guest storage keys to a file.
+  This is a deprecated synonym for the dump-s390-skeys command.
 ERST
 
 #if defined(TARGET_S390X)
-- 
2.41.0


