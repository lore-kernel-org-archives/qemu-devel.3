Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E24CC35FFA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Mar 2025 08:04:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuoOt-00081J-8p; Wed, 19 Mar 2025 04:03:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tuoOd-0007zR-JJ
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 04:03:28 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tuoOY-0004OG-5m
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 04:03:27 -0400
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-300f92661fcso6881304a91.3
 for <qemu-devel@nongnu.org>; Wed, 19 Mar 2025 01:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742371400; x=1742976200; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dry9IOvdEb4K5cPkJgeCnD2yv/gA9ubaGhE0+QsIwXs=;
 b=lAK23FisE2Y7HeOtHgqOGgR+NVAtnmonXrkSeMGil9M1Xi2L/MBaPl5dZl+ebrh6k5
 qQlC2fGnsMoENoyVmXOrz1O8/v13ZF3kYFjafm8Dim91gqgG2PvZj3lFD2wpttOUndR+
 XcAy0FJNNrMjwUGBZxyu7qsmOM7+pZL+qqvbRJHXxl/cAN9frvdEdqo0Xns+8qh9i27h
 a3ygqGufbBJqpgKyOrRM8DPfi0omutF2yNu1g7A5DiPdPzLz3xlQeQ0R8JoocVp+qyYU
 K8DAl2vyBQ4acJIZWcLLpdyhobh9u/MirmKK5BhBnPkXUgjKKlxHwkefqOVlD+twQrEs
 Xyag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742371400; x=1742976200;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dry9IOvdEb4K5cPkJgeCnD2yv/gA9ubaGhE0+QsIwXs=;
 b=eyY2lihf6IooDbr6b0lpCw23G39qMxu+f3SybGRf1ER77VyuKxjuU5MVCav+xFf5eX
 9w3ugD7uB4UEGnMgtP/M8GSTbbzJPzKFFUzHttgtRFbCRYfITPH3phTOkCzePVnL3Pp+
 iSnDohe/4KiWzjCTXUsK+hx9O3KI5ktyHBMrSDs7yjp5xZd3isArldYlu0B+aZJcGMMO
 4wbwkrbzd68HsaUsq46C5pNniBcvooQ3O9a37Z3LJj/RG49xn5PebGzakI+2M8l0pLNh
 a0rCumWZyIN27otPNi0fndNecRBjHO3SeCgm0Xu/l7RQFCo6nGx+cSHMbRDLkqkpJxTC
 2xVw==
X-Gm-Message-State: AOJu0YzMt+hjrwAakx+B9ATLoM9sQLo1U+K8Ez7y8XcvuiSgIdd7x9fT
 D8CtgWXyEA3Gp2x0AvMWz1EwjSIorUCbzkWdVyh6MWOcI4r3kaULA7iFqA==
X-Gm-Gg: ASbGncsPeCmdL4+J3YsSUyarvvL9Yl421W43n0H+ciYbmCt2pz79BtRoXlG1mts0WhS
 99ZWKlBuD3okSLAcg3gh1t7wRxkmx184tH5HQ+IRcvZf0rjIhWURlJ9GgJeeKYkr/6ZCcIMPkCx
 /w1EgoBHcH5xsXeY+fjdcxPBK7xL2ip8BOAJbGgtNga3OKxdmaQJ2pcQfYmJSfLGrIK0kvap9X4
 jC+oAvT939ff54HFPC8eiCDu3oJzHZIajgETa0CzRLhBbEJKHZ48N8yBgvBTHUmnkS8TequQEhp
 vIzdnSRXdd/b3k/qoRbtXdrrGfg66CJftrNRS0JyYPXOgH0a3tDhlAkLYY3+9jnhJVVP495kBZB
 QD+tqJBBwCTxGWPhhZOMWC0OlnurlMdvcH+gTe27bspBY6rjYLrju02lQvdI=
X-Google-Smtp-Source: AGHT+IEVEe/tidaXnTInfC24/j4+6jGOqUddwCz0+EZzxjw2cYORkRfjH7m06ny4Ik//kHswkPyyKQ==
X-Received: by 2002:a17:90b:55cc:b0:2ff:698d:ef74 with SMTP id
 98e67ed59e1d1-301be205905mr2563738a91.26.1742371399887; 
 Wed, 19 Mar 2025 01:03:19 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-225c6ba6c8dsm107725255ad.156.2025.03.19.01.03.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Mar 2025 01:03:19 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com,
 Santiago Monserrat Campanello <santimonserr@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>, Thomas Huth <thuth@redhat.com>
Subject: [PULL 01/10] docs/about/emulation: Fix broken link
Date: Wed, 19 Mar 2025 18:02:59 +1000
Message-ID: <20250319080308.609520-2-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250319080308.609520-1-alistair.francis@wdc.com>
References: <20250319080308.609520-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x102d.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Santiago Monserrat Campanello <santimonserr@gmail.com>

semihosting link to risc-v changed

Signed-off-by: Santiago Monserrat Campanello <santimonserr@gmail.com>
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2717
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20250305102632.91376-1-santimonserr@gmail.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 docs/about/emulation.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/docs/about/emulation.rst b/docs/about/emulation.rst
index 3bc3579434..a72591ee4d 100644
--- a/docs/about/emulation.rst
+++ b/docs/about/emulation.rst
@@ -171,7 +171,7 @@ for that architecture.
     - Unified Hosting Interface (MD01069)
   * - RISC-V
     - System and User-mode
-    - https://github.com/riscv/riscv-semihosting-spec/blob/main/riscv-semihosting-spec.adoc
+    - https://github.com/riscv-non-isa/riscv-semihosting/blob/main/riscv-semihosting.adoc
   * - Xtensa
     - System
     - Tensilica ISS SIMCALL
-- 
2.48.1


