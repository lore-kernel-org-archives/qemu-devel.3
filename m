Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A12BD0D16F
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Jan 2026 20:08:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdZoY-0000u9-2E; Wed, 07 Jan 2026 15:07:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vdZoX-0000sQ-41
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 15:07:29 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vdZoV-0002ER-MQ
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 15:07:28 -0500
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-4327555464cso1402619f8f.1
 for <qemu-devel@nongnu.org>; Wed, 07 Jan 2026 12:07:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767816445; x=1768421245; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZWMc4WL1iZ2nlap7wLR/rlH3SJpk6YkkPq0Z4p6mp40=;
 b=pH3hl1pjvVI6bRv6pEhisuciwiBvOOh0SnXEAbLts230v6zD/J/BIPCe9HlvVQADMj
 Y49tWcuFGwSF2sSD9B+m8g4YGAJ8+70IrGcnR1fsxQAxrZHh2ZSTJH4PWx0CmAIH5woD
 7+kWb8vImj6dMwpFdJRscHcYN0Mw0QbSFcMtTqdRH1wPJV73AJ43EC8dbTDZxXVqXTkj
 7KPTgllxzRDV+IsySZuTf/BXIKariLl7i5qoZvXKXYVXe3ME8A0aUOXIjccTOB2F63KF
 TtjJEY0la1AQi48I3WPvAxuXHyiZGIKiR3TP2D1JaL9cI5M9SnCXzANt0MsRKbpakKqH
 qNiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767816445; x=1768421245;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ZWMc4WL1iZ2nlap7wLR/rlH3SJpk6YkkPq0Z4p6mp40=;
 b=qqg6eb/yRG75jSk/6VY/mIC/BPAEMPlXl4Ri5RXij6MHM591J5HBAgPriq2OfNsWO2
 dD3yE74D7Bn+MJqssOYBL+46Bc78dlmAXQ6suIarNSKdWy1lCsblDiJmdM4BwzH6IqSF
 3oOlXF9NUBiZRsknTBx7BwsUUSmSUiVDe+2xJzQFfzL5zRD8VvoFunBwTQC//RmWRqT0
 1Po9U32DfGOfevp0Wrv4+JMEoUvOAOjY6N8F5m/kTGhC41Fx3+PAm+I067XitAQxtA8N
 gE9VJYem2fK6p3VCvx+AfVRbvwy6O4DqSgYgeqD/ifxMnmnxNBrGshGxlcpVo5L5T3eX
 xhqQ==
X-Gm-Message-State: AOJu0YwTutZdneyWFIfMFne83DbPUCJtCQEVTdH1tGT5rBVZhCxuKtDv
 wmcfap4CnBwNO6VyynuRNq8BeCO7a1FVDFFrrwu4g/zA76evAW0RYjm95PpJkNp5N4d3PYKzeVj
 5GH6Ef9A=
X-Gm-Gg: AY/fxX70Gtd+e5gcNkwVyV4XnKfhIUMI+Vw42ZZNQ/LG4YCXvT6gNpkMLUXDX4Y5NS+
 /oVyVEDKVCTMY9G7NHvjy7GFMRs6HWpGtJY1Y/OvRJqRdpxwjWuGTcrjY0WjoJU8MQ9WP9I13/J
 hH8Aj+NCU2Ui3Ac+80gAAeuKmszaXaMwnb0srvcH7z0TSUB3qF3IIkHqFT0yu5idUlMFcWOeZq8
 2suSe64UPr97d7gXujOAMSz9ic2CiVdLWWbz19M38cA11NcgeiuKgFbv5n1XNBbfr6aAg2qrKGk
 NS49V69nA4Nvam5ciscdIV7pIr2QZSl8RGPkIHEm4S+PKHZ2jbZ3vMaAMRlFfCiYLFLbJ5rlyIj
 oF1ZiHb3QmCJVa/BXP53M527ashdWRjjDv3MbvQ4IAS1F7QWe0lNLXIWolFg5G8AEcYgUuT4+D2
 LRmzhC2wBS2eeFquBAj8JQjL2Q/f7lP0mmEu31K7YxcrP1kygcLi3rAeBaLxo9
X-Google-Smtp-Source: AGHT+IHixEHXcFZ5JVQHFlForqYCZ6z3W7y2yendeDa7+bX+aaEW/9ncENyFKuSmk2KdBVft3nwDyQ==
X-Received: by 2002:a05:6000:400d:b0:432:5bf9:cf17 with SMTP id
 ffacd0b85a97d-432c3772962mr4238634f8f.9.1767816445269; 
 Wed, 07 Jan 2026 12:07:25 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd0daa78sm12163749f8f.6.2026.01.07.12.07.24
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 07 Jan 2026 12:07:24 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Yoshinori Sato <yoshinori.sato@nifty.com>, Anton Johansson <anjo@rev.ng>,
 Richard Henderson <richard.henderson@linaro.org>,
 Bastian Koppelmann <kbastian@rumtueddeln.de>,
 Stafford Horne <shorne@gmail.com>, Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 3/9] target/tricore: Build system units in common source set
Date: Wed,  7 Jan 2026 21:06:56 +0100
Message-ID: <20260107200702.54582-4-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260107200702.54582-1-philmd@linaro.org>
References: <20260107200702.54582-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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

Since commit range 809b460f305..cd08bcaa36b we remove all
uses of the target_ulong type in target/rx/. Use the meson
target_common_system_arch[] source set to prevent further
uses of target-specific types.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/tricore/meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/tricore/meson.build b/target/tricore/meson.build
index 45f49f01288..f40daee61ed 100644
--- a/target/tricore/meson.build
+++ b/target/tricore/meson.build
@@ -12,4 +12,4 @@ tricore_ss.add(zlib)
 tricore_system_ss = ss.source_set()
 
 target_arch += {'tricore': tricore_ss}
-target_system_arch += {'tricore': tricore_system_ss}
+target_common_system_arch += {'tricore': tricore_system_ss}
-- 
2.52.0


