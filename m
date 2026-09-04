Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44E52C61DD6
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 12:54:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2TQN-0001ii-6k; Fri, 04 Sep 2026 08:53:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x2TQL-0001hO-Ho
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 08:53:41 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x2TQI-0000iW-FM
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 08:53:41 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-48442ea8f59so1558723f8f.1
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2026 05:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788526416; x=1789131216; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=JJ3oSIlwkgO166qtPLmdFiaD5BrdgwjhX5Ej2Tw2czA=;
 b=uNtI7o79XgJPxrHDwfZwPHm97UBMIRA4rh/MYEbjMapTZA4O6TiqnLM9TCkAJlMrwd
 uG53/48dmLHoPtpOs39VCrh2PdsLtthRDC9qjuAbCZBC0Bf7RfKvbUhKnCDP8IW3fEQz
 jzsmcQz9Gj6cCPNxr4lxiYhPhpApgakXx9bxa15tsy/GZ0SekVjfyhN+HuolncX+8kcW
 QSbHbo5dcng4uHtqiWySewYJaP2ttViV8a+ecVKzunfJPSFUVl+4AAxtBRVgALQyXSMX
 VZxqqcHBQz3BKpzZ3SJ39jONTmMrjyg8ivO3tQyNy6KVlpkXtzm7NJupveGTLosS9fUU
 rQtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788526416; x=1789131216;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=JJ3oSIlwkgO166qtPLmdFiaD5BrdgwjhX5Ej2Tw2czA=;
 b=PZhOS6ojYc8pWdS+gqvrCXciUHf2gmWnSq4p2w9GgIjZVoLRkrPC6aHieIAq9sqOpf
 bk3S8qKWkoJUOucN77Wb64P++k1ymp0qOSo1M8qvUABtGb38dz4eiGQS/UZgOIL8ntHP
 o3gmDZVcmRCUD/El7N+W/GRo/qNO6QOx1k1BzBhe4NqC2CfCZYD1U2WKICcb0MJtId8o
 hbu4M1HmsBJsnqKbVCId5suZ/0wxszyTgrbBctw9s2XU08pvdIgAG1ky0FXOsbDIXPx/
 6yR1ETI2KoQ8mFek3gmpeez/D+1q9R/poGQ6G6BDUp/TwVH8UY4dYnbQAew1PoLdQALx
 Ap+g==
X-Gm-Message-State: AFuF++liQkniPxcKLcXgzzTwRPsCN628MCXf1UTAfGVYmPE8NqvH4cMz
 4/p+vCtJlCt87c/dtsdIGEEOfSzfyiLQ9jadSAAf9LsfmDY9Ftygh+dzp93Y0vFlfWg=
X-Gm-Gg: AYBFou0ROYJyX7eAMJyOikR0nCZ/D3WHW93BukzMr6CSN2bcREwQejnU4Wu4MRrgq38
 vrQvQ6BFewy1c90vCBFQcIv4qTOY9yDjQ9dhbr0VjpxwY2SI7p1x1Hrf+BDomwmcZvA9XGoE/bE
 UFX6IA1cPRzP3Wf1O4Blnv+uYtV2CBjr5ytgL1zuZawIhIadux9S3LwspLjQqgYuvytOdZRXtVS
 7d8WDcWbnz3SpQNdNG2Frlkg9YIaumGoF9iTFDx5AK0k7tud2YpghMJa3DBxaSz+Rf7rTbtWU5A
 judAIPsi/XmYxdl7A6FZRyzRWU3xB4QFKCQGDl+eBGGoF+nnQ6/+h8vS/dUp+grkGNsFZiUkK0d
 pSdUOuNICYLtND3+N1BxhBwcym1Vkz8AGJWFCD2D+K3Ji0uuAdtJFFEZW3ocbY74OHMILVl3byi
 2Z7rip0AsfYT5tzpaLNUkowgCs3hm0Enx/dNbQKXCtv2fB66Ka6LRq0C/PpYO6
X-Received: by 2002:a05:600c:4881:b0:49c:f13d:ffec with SMTP id
 5b1f17b1804b1-49cf13e05cemr76500315e9.16.1788526416596; 
 Fri, 04 Sep 2026 05:53:36 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4858bcefd59sm3457161f8f.19.2026.09.04.05.53.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 05:53:31 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 06AD661D32;
 Fri, 04 Sep 2026 13:46:12 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Aniket Sahu <asahu1x@linux.ibm.com>, Alexandre Iooss <erdnaxe@crans.org>
Subject: [PULL 072/105] plugins/api.c: identify or1k pc register and mark it
 as read only
Date: Fri,  4 Sep 2026 13:45:26 +0100
Message-ID: <20260904124604.2207440-73-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260904124604.2207440-1-alex.bennee@linaro.org>
References: <20260904124604.2207440-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42b.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

plugin registers.c checks if at least one register is read-only, which
was missing for target or1k.

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Aniket Sahu <asahu1x@linux.ibm.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Message-ID: <20260827221506.91574-73-pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/plugins/api.c b/plugins/api.c
index eb982f9aad7..3520c96f411 100644
--- a/plugins/api.c
+++ b/plugins/api.c
@@ -425,6 +425,7 @@ static const char rip_str[] = "rip"; /* x86_64-specific name for PC */
 static const char pswa_str[] = "pswa"; /* s390x-specific name for PC */
 static const char iaoq_str[] = "iaoq"; /* HP/PA-specific name for PC */
 static const char rpc_str[] = "rpc"; /* microblaze-specific name for PC */
+static const char ppc_str[] = "ppc"; /* or1k-specific name for PC */
 static GArray *create_register_handles(GArray *gdbstub_regs)
 {
     GArray *find_data = g_array_new(true, true,
@@ -449,6 +450,7 @@ static GArray *create_register_handles(GArray *gdbstub_regs)
             || g_strcmp0(desc.name, pswa_str) == 0
             || g_strcmp0(desc.name, iaoq_str) == 0
             || g_strcmp0(desc.name, rpc_str) == 0
+            || g_strcmp0(desc.name, ppc_str) == 0
            ) {
             desc.is_readonly = true;
             plugin_ro_bit = 1;
-- 
2.47.3


