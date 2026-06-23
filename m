Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84691CDB470
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2026 10:12:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wby7Z-0001lo-Li; Tue, 23 Jun 2026 06:12:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wby7Y-0001lI-1F
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 06:12:44 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wby7W-00073D-9T
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 06:12:43 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-45fe59255beso2673064f8f.1
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2026 03:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782209561; x=1782814361; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gNNca2rTmvNpkzZ5xlkT0oe0NJHUtNG/NtDCClGF7RI=;
 b=NnQ/ZAINqfF+N6iJRZx+6Mprhr6IqqtblUevuppOAIt1KPfzkuS7c2IJSDz4v7H7kM
 ANKI/zgEYXboGhRaBOgmNJZE3+42GaXbXGD/TO9qSbPXqK114QoZrnC+w5/aZFiGIxxs
 XnhMukUDPEPZYL6MZQWXLyAk+Gp9O3qF5l2Zx6K/orHD3HwsSyVSc5qToymQA0efVVVE
 EjLNoKPA1GehENf5QSMFl2Q8gQg2pLuhvsRR1ekH7JrtmkjuPt06J+hwCGgL5z32S5a3
 Z0kEMcZ4uuJEd7Lz5IwA3Q6mZbb21lHqnu8ftuS8B0x0rcZ6iJ1jpOGffu7+6YcJNeLW
 XZfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782209561; x=1782814361;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gNNca2rTmvNpkzZ5xlkT0oe0NJHUtNG/NtDCClGF7RI=;
 b=ME1QIMp3S6GgSprXtfI8IeRRK4iRjin99sTAU4sITyrgv2BYlJ1f6utOz05oD7UrLO
 oEb2EfB/gxjOukIiACe4FnBlhF19mp0BKTvbNDQQv7TTdxNckxKsmvBtRkWyqeOjQRN3
 6p6eALw3eD+oLY4UhI4w8Xi1MIAtW/e2x+lhWfkrdyilv5zlu80M3H1Iwo1/aLyHCxb7
 HiGxeliKyyU+3JNqT5Ok5HtqGCRQ55q41xAnqCS878e/+Ee8dKh84zGy8vkFHzXiaE9g
 nY79Y18VrpEaOrwV2WmHncBcFm1xMRjGbufd1oI2nrGb/nzYeXpBj3hk41i9B6VJpj20
 ZDJQ==
X-Gm-Message-State: AOJu0YywvEXhzp4clCFo0DNMzXn83dYz95WtWvAzCaQEmU2/4xWSGtgq
 o5LD4Wwaoh38sgMofMDEhCWCmxbbLyRiEan6ZZF7EvEZ6mG0KS6ji6oXg/hIDZyB+fE=
X-Gm-Gg: AfdE7cn+GjRVs1eNWSZIA3NpaGKGVDId9k1frLETLKdzhEFZHi/wYalwolg0InyED8E
 oj3e6/qZHnNjDRO2PKaVXYH4bpmuhmAwbeUesmhL7EaBq+/72MQ2kzBUs45u/IWHcGP2PyjhkMO
 aMFaKqtWDJBgeMTM3mjUCRgaFo8+SGXzwix2vkA3L0FD7kWmq4YJLc3nwNgXjKsqoIfmy83jUj4
 tbt1cNM9E3Lb0NHrm+ptxnA0f0HSnaFyLiFumXe1bWJF/kZdNetkXY3eg/sdMsur2dbg4QXWw8G
 RbtFwGK4NjqH/jq1j4slP0cUXWr2LAfluWdT3FOoJNdQAzCtKdLt1iSOqMll8yiC8wFje+ipqap
 2F0+6FrDwVZebire6K6lAjw7hH8zGr9DBO43AMTGCYfYKsQlOnUjFNNWJdrLH/V/5UGqfl8zb3D
 HSVl7daVIet9zy
X-Received: by 2002:a5d:544e:0:b0:460:3210:b6eb with SMTP id
 ffacd0b85a97d-46adb872d46mr1946643f8f.43.1782209560617; 
 Tue, 23 Jun 2026 03:12:40 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-466667881bfsm36264691f8f.22.2026.06.23.03.12.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2026 03:12:39 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 9ADDF5F9D4;
 Tue, 23 Jun 2026 11:12:38 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Thomas Huth <thuth@redhat.com>, John Snow <jsnow@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Subject: [PULL v2 2/7] python/qemu: split console from harness args
Date: Tue, 23 Jun 2026 11:12:33 +0100
Message-ID: <20260623101238.3806547-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260623101238.3806547-1-alex.bennee@linaro.org>
References: <20260623101238.3806547-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x430.google.com
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

Before we mess with the console output lets create a new helper just
for that.

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20260619155657.944220-3-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/python/qemu/machine/machine.py b/python/qemu/machine/machine.py
index e8973a87394..18ee5ec0147 100644
--- a/python/qemu/machine/machine.py
+++ b/python/qemu/machine/machine.py
@@ -306,7 +306,11 @@ def _harness_args(self) -> List[str]:
                 moncdev = f"socket,id=mon,path={self._monitor_address}"
             args.extend(['-chardev', moncdev, '-mon',
                          'chardev=mon,mode=control'])
+        return args
 
+    @property
+    def _console_args(self) -> List[str]:
+        args: List[str] = []
         for _ in range(self._console_index):
             args.extend(['-serial', 'null'])
         if self._console_set:
@@ -372,6 +376,7 @@ def _pre_launch(self) -> None:
             self._wrapper,
             [self._binary],
             self._harness_args,
+            self._console_args,
             self._base_args,
             self._args
         ))
-- 
2.47.3


