Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12C85C87FCE
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Jul 2025 08:35:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufwop-0001qH-2o; Sun, 27 Jul 2025 04:33:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1ufwoZ-0001G7-Qj
 for qemu-devel@nongnu.org; Sun, 27 Jul 2025 04:33:04 -0400
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1ufwoW-0000B1-Rp
 for qemu-devel@nongnu.org; Sun, 27 Jul 2025 04:33:03 -0400
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-ae0dd7ac1f5so675881166b.2
 for <qemu-devel@nongnu.org>; Sun, 27 Jul 2025 01:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753605179; x=1754209979; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YwfzgUA5DnLjY6SQjt9FXqBLKfUf1HAmMnkrm1jg7bQ=;
 b=unJJWfIkoFPnNJeHau2lVifdx6mBsmZPfXDpoAMlAd/S6pW9bN1gzI4XEJB/VLLOUX
 9Dqanulz6ooAbO6DSh9nTDk2Efwxo+eTXIPR8e8UbRYec5n0AhM3BrAhLeHcPDx3kpQu
 C+jli6MUCUGPz0pe1ID27RAW4TeK1tzFuptku9IQjeUgYYN1ezCOxFRIb5VZXMacnCOX
 9qz5thlZ2HAHb/5lXllnqwZVgk7LaMN+Ym1SMNXdAngTrAu9XnXuBEwDyw1Ch3f9Eujy
 Jftmz8SCOBsp0kUgRuxAUeokBF34SsLVfdl3glEeBglxl38qAzUtxuwJ1yRw7FLW0vk7
 8SoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753605179; x=1754209979;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YwfzgUA5DnLjY6SQjt9FXqBLKfUf1HAmMnkrm1jg7bQ=;
 b=j6kWmEyLo0vTqZRGzYuU7YXPuiQKtFxFAClyq/dI+0qIQnJb7ppmUC5+ofI0L/fSQQ
 bsfBNJ/sJe8dgzVnavgPujENFi6hZAPxODewjjvHPL1V1ke+n9fPWPNeuvHqg/kkzCyW
 Dv3fmHtaVkRvS4gavXRDNfeTUMEDAObGDIeDGLMfglHzNpEISa3h+nPWf0mcHTsR86hl
 Ml3PR1bYicAHVU+bnTpAkEin+Zt4mK6FVUkoJQa0zmAS6Vy/Wqp9gz+f5xEkaEMCnQ9t
 SC7S2E55zXWkq0hl5hW3VfgwRQzT8szzy6QlUp0BiMLmtZXN9T0FAHiIX6koKbElkBB9
 8F/g==
X-Gm-Message-State: AOJu0YyXKxu/AHylwoQhyTwu7oB4mA26hmBJydrkJ3kcLa7e5bSaJCU/
 G3p7z02McDbxwGcfB9OTTYeYJ7/P7QTIWcrsGIzj7knCNBt6Sj2aeFKTgdgiicewNypLsLbEQGx
 1kBrL
X-Gm-Gg: ASbGncsfFY7VYyErYUwCdrPfLpjk2bEnmBa3U1SFDLCIsmugvy6ktDaIOrFWe9noEFf
 pVFApo6lfYvCN53ziT04Cew3X89T7ddl1iw1nFVJQEwk4UUCAuAL8gRk1WLORSLhZ+lVk8gZxPr
 K+4LxSs5UbpasWz5mdZf0lz+TsgCfFi+Zb103TRQCz0nc3jqYGTlN7nlDePBw/n57/4JarqT3hU
 2wEqKwqyBdrMaTkFKLW5NGQl+dEnnBlU31Lz/ZXOG6mvL6zHgM4IPhokgAGq11sAnE7yVPffYlQ
 WAq+W+Cqn1pn3GZ8hshtqCtohPH6aEMyxRih3lCvYupKwC9QGGOlP3uNOoQoXZiUYyJIswzCIeB
 xHXN0u09Aw44fU4B65hKfeDM=
X-Google-Smtp-Source: AGHT+IGwBEz0mwJQ/BrW7++YmEaeawbhQYEP3P3iqkHvco1wv2eZrnIYEjJSexF5QCIlGEjX6LTStg==
X-Received: by 2002:a17:907:3e23:b0:ae7:cb7:9005 with SMTP id
 a640c23a62f3a-af618f0346dmr747917066b.35.1753605177712; 
 Sun, 27 Jul 2025 01:32:57 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-af635aa42cfsm257450166b.103.2025.07.27.01.32.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Jul 2025 01:32:55 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 43CED5F878;
 Sun, 27 Jul 2025 09:32:54 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PULL 02/14] docs/system: reword the TAP notes to remove tarball ref
Date: Sun, 27 Jul 2025 09:32:41 +0100
Message-ID: <20250727083254.3826585-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250727083254.3826585-1-alex.bennee@linaro.org>
References: <20250727083254.3826585-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x630.google.com
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

We don't ship the tarball and users should generally look to the
distribution specific packaging.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/560
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-ID: <20250725154517.3523095-3-alex.bennee@linaro.org>

diff --git a/docs/system/devices/net.rst b/docs/system/devices/net.rst
index 4d787c3aeb0..7d76fe88c45 100644
--- a/docs/system/devices/net.rst
+++ b/docs/system/devices/net.rst
@@ -21,11 +21,17 @@ configure it as if it was a real ethernet card.
 Linux host
 ^^^^^^^^^^
 
-As an example, you can download the ``linux-test-xxx.tar.gz`` archive
-and copy the script ``qemu-ifup`` in ``/etc`` and configure properly
-``sudo`` so that the command ``ifconfig`` contained in ``qemu-ifup`` can
-be executed as root. You must verify that your host kernel supports the
-TAP network interfaces: the device ``/dev/net/tun`` must be present.
+A distribution will generally provide specific helper scripts when it
+packages QEMU. By default these are found at ``/etc/qemu-ifup`` and
+``/etc/qemu-ifdown`` and are called appropriately when QEMU wants to
+change the network state.
+
+If QEMU is being run as a non-privileged user you may need properly
+configure ``sudo`` so that network commands in the scripts can be
+executed as root.
+
+You must verify that your host kernel supports the TAP network
+interfaces: the device ``/dev/net/tun`` must be present.
 
 See :ref:`sec_005finvocation` to have examples of command
 lines using the TAP network interfaces.
-- 
2.47.2


