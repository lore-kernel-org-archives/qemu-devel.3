Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D930CC6B38
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 01:11:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHWQL-0007ei-Fg; Thu, 15 Oct 2026 21:07:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1xHWNS-0001de-5x
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 21:04:55 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1xHWNP-0004PV-Ce
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 21:04:53 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2e934449bb0so20567565ad.0
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 18:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792112687; x=1792717487; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5XxIluoWNJOPky+43A54tqXxiP/Qr347aDJgEPbhxic=;
 b=Ce1O7lwglUhcDT8OpEteU0uyoodE3wOwgGlbKzSh5M8KvLesXvGFBuMz3q8EsSVyR1
 xrQJQbITvJDDgAgoMvnmvGWXlCuoBFZXZOHTPCQjD5b8mXvkmDL3u7aGo7oi00TgvUC6
 D2PBr76NrHfq90HR5xQCS2KD3yJoWObPwep2viE6mG5Jgdb1byvg4OK+Rxut001iT4GC
 E+IZtavgB/kv0Z2zWeUiWP+GQpQlMS7gmAtA1K+6bc5FeWXVcIsvWYhaSNcrOI04h5ru
 BmhKPLkgpvcMVki1i8XDl7EMxBPshPB5B67Wq+mX7vZaEUa7dcI8bddteVnfNDOqURMh
 NhKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792112687; x=1792717487;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=5XxIluoWNJOPky+43A54tqXxiP/Qr347aDJgEPbhxic=;
 b=JpOZHAChizB2PgBEECFZ8KSZ3Uqb57a8lE+IT6vm/FuHMynwOXHWkLYPOLmgQWmye6
 UPCPgUSaBmNY/D6v41DNwD15pyqejKLQzpoC/u0W5h7mIKN/h2FI/S4UEY9CtFulAwzC
 MHv8Jb3uHlCvNY4JzuLq26kXATnokUPwmuNn7iCQpDGyTqudwWjGXppYfFSj7pGfZipY
 53pWnRq5wJwYd9DlD9eIGdjAxs2+n+gTjdQQqgWeXyAGQ5nZm8eBdi+y/edMzCpLjoK7
 ZL7ZcKiMTsKECfMREDyKkeIVJpHitrp6G9l3MpNXTdz1mzm0m+rz/W4e8i1e/tqtO/rB
 RR9Q==
X-Gm-Message-State: AFq9FYIUWOODO+VGtR7N48sTr9RK9ad0YZpH/ICX3jx0brXunTS2isY4
 DsDbTAWNBJ0XqJuQoqzA6/0s+cMA2X08S3e8jRVBnkumqnFio6g8zPAAzppa5A==
X-Gm-Gg: AYBFou0xNie6WLidjvWD9TBlQl0WMVB9xaX2DpLJSJlXqqtgyAgNaCdTc96c+VTwr4Z
 xCkdEUre4GL8TFp/40sX6uOLQaOY81XnslR7zYfsMIs0UggyPA+k57Z1EqmrXcGmjZzUF0fcP6h
 Wu1A5ZwqHy9INs1lH8iJ5ShxZinjU08dgHHFfnISIqn+43Sy0h3xEfWN1QcI1Xw9dR/XlTgxwKQ
 GAzvjQblvTdOnZejih9lmrFwYoFYhUDCTZkzVFpBZqCICc/t5sP8ObrmliG49Qj0v5ZW50zwYiK
 bEaeZHn7M5VUq3ynEfKEfZzAvnxxf7jfI6dKF+SFNXvRnrGsYiroC4EEQhSjZF9Uol2XtFs3rLA
 NjU7qmi/1fzct3exiTBvoclxAcuecvsbKogYp1BJ3938pw5nR7J/CfXEwLcLyQrpqP8WTWriUml
 O8qew1YD2KAkiaD+s4bGPjVythwTL4Gj6KW+XTtA6Qy3bVotXLVfBtUS1BOZbaBenhLhZnoR4Fo
 86RHyhNPkGKud5a
X-Received: by 2002:a17:903:2b0d:b0:2e9:8b2f:3572 with SMTP id
 d9443c01a7336-2e98b2f39b5mr2401715ad.26.1792112687109; 
 Thu, 15 Oct 2026 18:04:47 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e97e833f1asm2513995ad.43.2026.10.15.18.04.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 18:04:46 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Rick Richard <rick@sloservers.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 qemu-stable@nongnu.org, Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v2 41/50] tests/qtest/bios-tables-test: Allow changes to
 riscv64 virt SPCR
Date: Fri, 16 Oct 2026 11:02:28 +1000
Message-ID: <20261016010237.1102834-42-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261016010237.1102834-1-alistair.francis@wdc.com>
References: <20261016010237.1102834-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62b.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Rick Richard <rick@sloservers.com>

Allow changes to the riscv64 virt board SPCR -- we are going to fix
an error in the UART description there.

Signed-off-by: Rick Richard <rick@sloservers.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Message-ID: <20261005104008.214588-2-rick@sloservers.com>
Cc: qemu-stable@nongnu.org
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 tests/qtest/bios-tables-test-allowed-diff.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index dfb8523c8b..aae973048a 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1 +1,2 @@
 /* List of comma-separated changed AML files to ignore */
+"tests/data/acpi/riscv64/virt/SPCR",
-- 
2.55.0


