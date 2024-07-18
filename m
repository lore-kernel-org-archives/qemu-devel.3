Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AA5FC3DA49
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2024 12:24:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUQAA-0008Ih-P9; Thu, 18 Jul 2024 08:23:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <t-8ch@linutronix.de>)
 id 1sUQA6-0008BH-7F
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 08:23:07 -0400
Received: from galois.linutronix.de ([193.142.43.55])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <t-8ch@linutronix.de>)
 id 1sUQA1-0003ta-C5
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 08:23:04 -0400
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1721305379;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xNYyK17bpiByBadadWuWAioNKspo33nsXME0A+tKcno=;
 b=wh288e4Ew8kzb+73LqPgh/txcPTh4KXf8wGjMqlkmy33Hv1zt3RS7wWsDerPy+FbHQh9Rr
 S5ltm4KtHAJqZu7l0n/TZlN1pKhh9kLu4q0FejVDlI2IP4S9dWcdlvrOLOi3KdsOvH1px2
 +uhl/7Vo1hzzPIg/mC3nxZnT2G4+nYcZL7eVM5j5CZhL6Eh8PymzhCHqsiJZplmYJOQiVC
 A+MdU/wnXnb0aShPXUm1tAtr7IgdRKm1ddlhjei9d4N/G1cPjVK/f7js4MnZOvk1E53HtP
 UGxJveQiv4ZuW6A5O8ATk7+NBT1gImH5Gm0F5ckVA3ULp0jrE1wlc/O1Wse40Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1721305379;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xNYyK17bpiByBadadWuWAioNKspo33nsXME0A+tKcno=;
 b=3j89/tXDIM7mxyqTy71i4ZG5nBoFovKoO7wQGMkWKHSMhGL5DEleCacW2bZeJ/eHI00XN8
 T5ewe1Zy41WXYyCQ==
Date: Thu, 18 Jul 2024 14:21:48 +0200
Subject: [PATCH v5 4/4] docs: add test for firmware.json QAPI
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240718-qapi-firmware-json-v5-4-0dba12d7aaf5@linutronix.de>
References: <20240718-qapi-firmware-json-v5-0-0dba12d7aaf5@linutronix.de>
In-Reply-To: <20240718-qapi-firmware-json-v5-0-0dba12d7aaf5@linutronix.de>
To: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Kashyap Chamarthy <kchamart@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, 
 Hanna Czenczek <hreitz@redhat.com>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1721305377; l=948;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=guiw85EHcqaiDUdDat61xnuzERnU9TaIhr+rl/h3ve4=;
 b=9/rk8lsYLIrsD7k3WeZ6/2+jfkpyO/KRzP7p5WV1svH/LjPPAxGRcKMdpFsIbb1d8+qAlfkLC
 6N3zlO+eY6xAjeFKGbcf2ocg4N2ChVIFXAthK374YKCMYQk4Ehix63A
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=
Received-SPF: pass client-ip=193.142.43.55; envelope-from=t-8ch@linutronix.de;
 helo=galois.linutronix.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

To make sure that the QAPI description stays valid add a testcase.

Suggested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Link: https://lore.kernel.org/qemu-devel/d9ce0234-4beb-4b90-b14c-76810d3b81d7@linaro.org/
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 docs/meson.build | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/docs/meson.build b/docs/meson.build
index 9040f860ae1a..bcca45a342a3 100644
--- a/docs/meson.build
+++ b/docs/meson.build
@@ -99,3 +99,8 @@ if build_docs
   alias_target('html', sphinxdocs)
   alias_target('man', sphinxmans)
 endif
+
+test('QAPI firmware.json regression tests', python,
+     args: [qapi_gen.full_path(), '-o', meson.current_build_dir() / 'qapi',
+            meson.current_source_dir() / 'interop/firmware.json'],
+     env: test_env, suite: ['qapi-schema', 'qapi-interop'])

-- 
2.45.2


