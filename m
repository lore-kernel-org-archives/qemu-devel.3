Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B7E6C3DA64
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Aug 2024 21:05:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1saiP6-0008Qo-DE; Sun, 04 Aug 2024 17:04:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1saiP5-0008OB-N5
 for qemu-devel@nongnu.org; Sun, 04 Aug 2024 17:04:35 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1saiP4-0005gD-8K
 for qemu-devel@nongnu.org; Sun, 04 Aug 2024 17:04:35 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-a7de4364ca8so141865066b.2
 for <qemu-devel@nongnu.org>; Sun, 04 Aug 2024 14:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722805473; x=1723410273; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TXjCGVQS/+hcLwTR+qUNdXq2a9N5/772SuBnlrJC6HA=;
 b=AsTVICNjdSvtmOoOKrOPR4jI0s2QT9x0J1xU5GXxqQW+WsNVCWx0PglZpOLpzzld7N
 SqyB10oOQp9pSN+iHDQPpzI7mTsWqFPIYqujEuNTUsU6jKu6zJWMIPkjPcCp6gureznT
 KKAV1KTqPb/nZRM2vUWEzWjyb9Kf71S+sPqEFV+9bQtjU7WqsEz6E4g/eBrw+r50kcqb
 sftq1TO+fxeupAsewIkK+wLE9utMbdwWLW26QaFom+MNVBFQBY1gqO01iDYbqN3ldudY
 1kd83pPGcAninmbfs+CD+rcLvq1iYy0t8pqzHsMxy9/InVGobDGbSjjEli/ygaKR4vwe
 9G1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722805473; x=1723410273;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TXjCGVQS/+hcLwTR+qUNdXq2a9N5/772SuBnlrJC6HA=;
 b=l174QeU7z7UFiPma1E0DzOg84JpoB40fQ2KmAMziwIOUYc91HdH5FenLD+V1OoAs3G
 Hxj3cB+lkFGaD7PHBBoUrrRvrET/fHXFlM0+vy22CSmgi1tXjFJ3I+ETE3n/c8yBiiq6
 v61GsEndihpN9LK8e8UfDtDAAr1y1Rv2cGvsdXiQTS0A8qBhlBrZze9AzU3cIZSzCpcv
 M44iDdpJxsQRCDBeZTCEOb8hSYazMl3EGDmDDks4iAqsCtiEox0kRpcqmJsVMoESocic
 s4Eqzy1uRPXPmx7yYNIgT9QTCbsbrTYAy6ghCfCk2GF75/xc3jETesyhyB4X0+VjpNr7
 wTWg==
X-Gm-Message-State: AOJu0Yw37oeZiGba6k9mjNi3OBy44KCyLed/rKEosv7q4mi7fDJAqvmH
 S4eauaW+I81wWP6xUitvJzhLYLHyCeuq4fODOh7tE1N1KyxdWFPmHvpNH/t3KC7Vh51+xoelqes
 qc6E=
X-Google-Smtp-Source: AGHT+IFAI78lroo4zBkS9350SkmGgdPM0vLMvWdhx7R+YlY9viSj84iyZfMT5JWg/uUJLYSTMxhX3w==
X-Received: by 2002:a17:907:3f97:b0:a7a:a212:be4e with SMTP id
 a640c23a62f3a-a7dc4dbfe3dmr734661266b.7.1722805472711; 
 Sun, 04 Aug 2024 14:04:32 -0700 (PDT)
Received: from localhost.localdomain (adsl-146.37.6.160.tellas.gr.
 [37.6.160.146]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7dc9d437a5sm366348766b.101.2024.08.04.14.04.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Aug 2024 14:04:32 -0700 (PDT)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Mads Ynddal <mads@ynddal.dk>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Gustavo Romero <gustavo.romero@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, rowan.hart@intel.com,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [RFC PATCH v6 3/5] .gitattributes: add Rust diff and merge attributes
Date: Mon,  5 Aug 2024 00:04:14 +0300
Message-ID: <rust-pl011-rfc-v6-3.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <rust-pl011-rfc-v6.git.manos.pitsidianakis@linaro.org>
References: <rust-pl011-rfc-v6.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ej1-x635.google.com
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

Set rust source code to diff=rust (built-in with new git versions)
and merge=binary for Cargo.lock files (they should not be merged but
auto-generated by cargo)

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 .gitattributes | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/.gitattributes b/.gitattributes
index a217cb7bfe..6dc6383d3d 100644
--- a/.gitattributes
+++ b/.gitattributes
@@ -2,3 +2,6 @@
 *.h.inc         diff=c
 *.m             diff=objc
 *.py            diff=python
+*.rs            diff=rust
+*.rs.inc        diff=rust
+Cargo.lock      diff=toml merge=binary
-- 
γαῖα πυρί μιχθήτω


