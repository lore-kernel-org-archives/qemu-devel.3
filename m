Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAD0FC3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 18:10:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWJxe-0003bC-ES; Tue, 23 Jul 2024 14:10:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1sWJwx-0001JJ-IT
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 14:09:25 -0400
Received: from mail-il1-x132.google.com ([2607:f8b0:4864:20::132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1sWJwr-0001E7-OA
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 14:09:22 -0400
Received: by mail-il1-x132.google.com with SMTP id
 e9e14a558f8ab-376069031c7so21280985ab.0
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2024 11:09:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1721758151; x=1722362951;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tlPxaf48ESlCF6z303PSbBfya6HxzRZ782+k35fLNmg=;
 b=zMhxssiFwPFE0sNvuyCxoZbHTlYkZkXtQlNKWQcIccip1S1UlVM4DbVWTtYCFSaOjk
 1HQcxc3Js3IN/gLIrtUHyGdsFas6G2f1S2Kz+M4KU7demBxAWg1xS1ES+UryxjKyGbuc
 5kxIHShaGFv97b5N3bL1evJrwFieFD7pX7FPtqEXfU0giog0Xic2vELYgtdmYoPONFp7
 E8vJetfO/vJi664r3wAmVTY399Ll4QxnshrOQ5ia9uBJU18hpwCo5m1r5DWj4732mvPW
 1j4TDtEj4OqKsYAIPVJ9A4FRVSvntn6i3ug+r9MearFA9hOW3+EeezU+dl09Cr4o1qoQ
 n/7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721758151; x=1722362951;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tlPxaf48ESlCF6z303PSbBfya6HxzRZ782+k35fLNmg=;
 b=NMNiZrhwHCxLwPsbJ7vGS01AbgeERFSh04cB6KNqg6OOHWy2Wk1svq/CzDFxTR8G/Q
 VDBkGL+Xe1FeZhLrxAuHezjUztT2j20ssvbqZsfnTcg6WGZ6hxf4JsET8q4UtzBCxwUs
 cS6QycWX9iclrWf/OCUxKJYdSQLJ6c9WVxBLjvhfXikK76xY/FX4E2a1CreuxSDU6Xi6
 SeOAhTZS+ASzlQvWpGFxj8hS0PHm6hLLkzAzCxuVDKPCh5Nvv05ZoZfICuOpmKuWSiTv
 Lnt+ok/aaLXARswsxwL2uNGJdTXwZ3Yk3BPVXqEyld50KKdWy/Pj4mfQvByErhxg6CN7
 awDw==
X-Gm-Message-State: AOJu0YyeYNfMWUC5jCzdSq2wAO+z4u0c1+kUJnRpIWZcxF/H77Q6G8z2
 C69eDZ9brbc/LI3/Cnm8KL9OGCkUjyYNKwXhloWYpuflSHPqOk92Ocs/VrdvmG23mAq5qgXti+k
 03tg=
X-Google-Smtp-Source: AGHT+IG4L9aaxMSqIcVKbKW5gZcGI6jhCSElMramkfQj5k0l9x8tvQB0dHnjXlSufsXgUiaPVwMNOw==
X-Received: by 2002:a05:6e02:194e:b0:397:5d37:6205 with SMTP id
 e9e14a558f8ab-39a0c94b687mr40592935ab.28.1721758151331; 
 Tue, 23 Jul 2024 11:09:11 -0700 (PDT)
Received: from dune.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-397f7a2827csm33361775ab.53.2024.07.23.11.09.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jul 2024 11:09:10 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, Peter Maydell <peter.maydell@linaro.org>,
 Kyle Evans <kevans@freebsd.org>, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 14/14] bsd-user: Add aarch64 build to tree
Date: Tue, 23 Jul 2024 12:07:25 -0600
Message-ID: <20240723180725.99114-15-imp@bsdimp.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240723180725.99114-1-imp@bsdimp.com>
References: <20240723180725.99114-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::132;
 envelope-from=imp@bsdimp.com; helo=mail-il1-x132.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=unavailable autolearn_force=no
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

Add the aarch64 bsd-user fragments needed to build the new aarch64 code.

Signed-off-by: Warner Losh <imp@bsdimp.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 configs/targets/aarch64-bsd-user.mak | 3 +++
 1 file changed, 3 insertions(+)
 create mode 100644 configs/targets/aarch64-bsd-user.mak

diff --git a/configs/targets/aarch64-bsd-user.mak b/configs/targets/aarch64-bsd-user.mak
new file mode 100644
index 00000000000..8aaa5d8c802
--- /dev/null
+++ b/configs/targets/aarch64-bsd-user.mak
@@ -0,0 +1,3 @@
+TARGET_ARCH=aarch64
+TARGET_BASE_ARCH=arm
+TARGET_XML_FILES= gdb-xml/aarch64-core.xml gdb-xml/aarch64-fpu.xml gdb-xml/aarch64-pauth.xml
-- 
2.45.1


