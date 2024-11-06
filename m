Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17B08D59F52
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2024 17:09:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8jXM-0004kV-Ky; Wed, 06 Nov 2024 12:09:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1t8jXL-0004fM-2b
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 12:09:43 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1t8jXJ-0004Z4-9n
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 12:09:42 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-43168d9c6c9so213725e9.3
 for <qemu-devel@nongnu.org>; Wed, 06 Nov 2024 09:09:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730912978; x=1731517778; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=rxvyr7YLNSV95iSHc4+IrcMEjKmsBzFU/HpuuURz0hM=;
 b=tf4Eum9npmRKXNV1i9KyayxKg9LU9YEqAlMl1TjsFi8ph6OIrTIpjARJI8XrTPrLy0
 0mbTRNWoRT4qY9ex7LvJjgsFs9bjaGOgNkVra7alDD7vPGdPwLgSFNoTyAFXXGsD/usB
 XmAqqFnG5cydMUZHifByzYYrJ2sk6QFLbKDghBkO9uLUFgF7+AtSWsJtL0Q76L0fUmFn
 365euUsE25oeLJPVTCWO3xMg+9+HwuTYoMH0Z/u1WYNJMrHGyiFfXAYPccYK5wn/zz/H
 LYvMNFsM12PjZItZ234aZHy+WtTX9iHwIKPjaPtomxrgtCOHg0HsX7vlCp+0NhUl+MlP
 Xg/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730912978; x=1731517778;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rxvyr7YLNSV95iSHc4+IrcMEjKmsBzFU/HpuuURz0hM=;
 b=kSDMICixRzB8mU9DIHU4688xsV0lFNp1keGVrN7ljAL+pEyhM1B7gtMaMO8PABoZMz
 PnsBtwE9zZ9quhdDs7UTmqtasusKEusmpmkIL502Ij/xxCMv/1IWnTlr02R5LVEZWpd6
 qn/nfIQxqg0ywgpcyhFMJ0KYFoGolFB+UDO7JtmZhIRG/ejldbsXB3JhzuMhQxmHqRAl
 YuW3gO+gcSHbm+I3R0Gyekg6b4bPp+ZPxR0ZoW7gByhYKowLlhPkYfYUMRqduKOuAxkz
 mL9hEk4qLZlchHOq3bcVWViY6057oBeQhZyjfh/nUgw+ljNMD62YSdGgkTq/0WDcL1oc
 GjBQ==
X-Gm-Message-State: AOJu0YyyDI21/YjzRtaTjPPuguYO3LBup6+ysHiyrcXbePoHPlv+ooFs
 6ECX/Kg8wXWMrWwtYkYitCFXoXNOKpw7OQIon/BI6DrGpSpSZb3J7I6kWRJ2LN1z45yG/gK8/Py
 L+oUCPM8r
X-Google-Smtp-Source: AGHT+IG5PK9opnjQgBCyzEBd10z5fzem05OmDIRLqYOAzP6c2WwzcX7khyvhLs9WSxFQsAX76TncIQ==
X-Received: by 2002:a05:600c:1390:b0:431:5d4f:73a3 with SMTP id
 5b1f17b1804b1-4319acb226amr355344995e9.18.1730912978534; 
 Wed, 06 Nov 2024 09:09:38 -0800 (PST)
Received: from linaro.. ([193.32.126.165]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432aa6b2d13sm28918935e9.12.2024.11.06.09.09.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Nov 2024 09:09:38 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Cleber Rosa <crosa@redhat.com>, Mahmoud Mandour <ma.mandourr@gmail.com>,
 John Snow <jsnow@redhat.com>
Subject: [PATCH v3 0/3] plugins: generate list of symbols automatically
Date: Wed,  6 Nov 2024 09:09:20 -0800
Message-Id: <20241106170923.2976750-1-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-wm1-x32d.google.com
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

Now that meson build for plugins was merged, we can cleanup another part with
the symbols file.
It has to be kept in sync between the header (qemu-plugin.h) and the symbols
file. This has proved to be error prone and tedious.

We solve this by generating this list from header directly using a python
script. Dependencies are triggered correctly, and the file is regenerated if the
header is modified, as expected.

Pierrick Bouvier (3):
  plugins: add missing export for qemu_plugin_num_vcpus
  plugins: detect qemu plugin API symbols from header
  plugins: eradicate qemu-plugins.symbols static file

 MAINTAINERS                    |  1 +
 include/qemu/qemu-plugin.h     |  1 +
 plugins/meson.build            | 12 +++++--
 plugins/qemu-plugins.symbols   | 59 ----------------------------------
 scripts/qemu-plugin-symbols.py | 45 ++++++++++++++++++++++++++
 5 files changed, 56 insertions(+), 62 deletions(-)
 delete mode 100644 plugins/qemu-plugins.symbols
 create mode 100755 scripts/qemu-plugin-symbols.py

-- 
2.39.5


