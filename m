Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2FC2D4A5EB
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Jan 2026 03:37:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhfx7-000769-9t; Sun, 18 Jan 2026 22:29:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1vhfwm-000747-1T
 for qemu-devel@nongnu.org; Sun, 18 Jan 2026 22:28:59 -0500
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1vhfwh-0004CY-V2
 for qemu-devel@nongnu.org; Sun, 18 Jan 2026 22:28:54 -0500
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-b87693c981fso660347566b.1
 for <qemu-devel@nongnu.org>; Sun, 18 Jan 2026 19:28:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768793330; x=1769398130; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=EYJLV56iBM6f2CAPR/OaWTgYNek6WyVhOLZFWs67dfY=;
 b=T6hGO8rkxYXU5mW0pl0CkUZwXd3OaIy64ErCcR+Ltxw4DtjzJ7sDOA7YE877dlkHqu
 0p2NOzYXlVBCWUrHBEPrelazGx5Ss85y4OPTWhJUcClBYTRwonfQS8k3ddBqpFTWOQrK
 NmgU44H9Hx64wQUzB5ay/PPKkHJ/ofscfgMmS95pf5ZdWk24BG4OPwTNHktKKWheF4Ml
 9pQSX/RUiweX9rc8N5WNiG2IaZkVmkWLS82q0gjgNYSF6pgOfTjyIxDEl4X5Om3AOWR0
 mHYKDBgvVfJcqCHmgboFXOkd/3yp5SMbA0xzgBndYecq5KLUzbeF+CHtXjn09KADTh8b
 7FJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768793330; x=1769398130;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=EYJLV56iBM6f2CAPR/OaWTgYNek6WyVhOLZFWs67dfY=;
 b=YsoJ4+ABFqvxOFA6BIufRMGP1CHPmJVKpeTJpbUmMKDGg7TOCexAFlShROX8c0DDk0
 n1AdBGogMUHQCY4Gx0nJm5/WQ5d2ZjDZwZoIGmAfUIJ55dImkkgujJsCFbJd5F2D4KMB
 QffY8dLxfvAqvsFp9X9a8NKksOWquSQC1j1nTmFIeGEURFh4De1UHud/om6geOxnonTS
 Q/mmINqUndWovVF+h67HHZspVGsFRyC9mM87VOUXytAiYPTC8594iq1okBwx7W27isJP
 M+GyrEa4xXbifUnaMjVtdoKkep5pLAPu+4oms04qlU7tYMWFrvUc3H/ix7Zo1u3TDjzN
 Fhsg==
X-Gm-Message-State: AOJu0Yy3rZuklPRFgai1aNB7Zdx+5me7ifT4BXTxt258evV/IcYbmdjl
 tY1jvwoqwDGn724KEoCunT731D39HIQ5JB+Dwm2KYiiKeHqfB2Lb+yGV
X-Gm-Gg: AY/fxX78O8NwRNJk8au+l0hssm6KAyVJXzqso4c6OCWwdr6Jj/0OmZyl7cvqjxtvhOl
 7X/QzWodsl14Q3R7z6H3J2Ri14jIPPDkrrkgUWD2sRTr0cuQhBxNpLr78BxsGFak3xUr5s4+c/X
 6W0Lc+DNSGrCWI5/fYRerwof2PQo1pfv3qMAbhXMenuVQ37XUCVKi0QnjLYu1jbEGhHv2y+TiKE
 m4sqTgzZmWV5nB1vbvfBdng4XttaPUoeTjF9gOilJ2a882zM60Nmh5WMiFRR8vSUqX+4PG5MDLY
 hZftwGL9DH+729PCzZCrDoK61gcO1WC5L9+3L6NNqMB981f3IzuiFykuzG6IqA3T5FT4IUdXdn9
 CrQwpZvMXsi0KIPL2zBPElKVAcF8Zl0F7F6+GD8FLtUAjiF2BGiLPBzKQ+dl6eT7VdMKJZvsZjX
 t3rKNpiXOTqfwu0wJLA0honBlKWWAtcxW+uwYbcwhf
X-Received: by 2002:a17:907:2d13:b0:b73:210a:44e with SMTP id
 a640c23a62f3a-b8792f79a90mr837146766b.30.1768793329605; 
 Sun, 18 Jan 2026 19:28:49 -0800 (PST)
Received: from localhost (mem-185.47.220.165.jmnet.cz. [185.47.220.165])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b8795a31bffsm971514166b.68.2026.01.18.19.28.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Jan 2026 19:28:49 -0800 (PST)
From: Filip Hejsek <filip.hejsek@gmail.com>
Date: Mon, 19 Jan 2026 04:27:54 +0100
Subject: [PATCH v6 11/12] ui/console-vc: forward text console size to vc
 chardev
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260119-console-resize-v6-11-33a7b0330a7a@gmail.com>
References: <20260119-console-resize-v6-0-33a7b0330a7a@gmail.com>
In-Reply-To: <20260119-console-resize-v6-0-33a7b0330a7a@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Laurent Vivier <lvivier@redhat.com>, Amit Shah <amit@kernel.org>, 
 Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Maximilian Immanuel Brandtner <maxbr@linux.ibm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768793314; l=985;
 i=filip.hejsek@gmail.com; s=20250912; h=from:subject:message-id;
 bh=Dz/ZVAAQqNSBQH68WEO3GF5YMnfs80jcIVMunKrAJOw=;
 b=EXu4DLD+p8RNBQmUAHb6xDDI2VJ3WKRF/vMGfhSxjI8q7rVHdAK59I/eJVr+dMdBPh/RCdD5n
 t3SVGrnqMQ5B1U6slU5YLpziopNYZwW19XJPiBSojMTdQYxPFziLKGC
X-Developer-Key: i=filip.hejsek@gmail.com; a=ed25519;
 pk=nakB8gEK3oi+Q/5dBTMCy/LgZL47NP60z1jeDR6O/WU=
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=filip.hejsek@gmail.com; helo=mail-ej1-x62b.google.com
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

Update the vc chardev size when the size of a text console is recomputed.

NOTE: It seems wrong that the dpy_text_resize callback is not called
      when the size is recomputed. I believe this is a bug, although it
      doesn't matter much because the only user of the callback is
      ui/ncurses and it only uses the size of fixed consoles.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Filip Hejsek <filip.hejsek@gmail.com>
---
 ui/console-vc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/ui/console-vc.c b/ui/console-vc.c
index 830842064d..a3a90440d5 100644
--- a/ui/console-vc.c
+++ b/ui/console-vc.c
@@ -414,6 +414,9 @@ static void text_console_resize(QemuTextConsole *t)
     }
     g_free(t->cells);
     t->cells = cells;
+
+    /* XXX Shouldn't qemu_text_console_update_size() also be called here? */
+    qemu_chr_resize(t->chr, t->width, t->height);
 }
 
 static void vc_put_lf(VCChardev *vc)

-- 
2.52.0


