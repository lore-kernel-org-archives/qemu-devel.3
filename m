Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6440D6B084
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Jan 2026 16:11:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlUav-00010Y-DH; Thu, 29 Jan 2026 11:10:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vlUag-0000KF-0Y
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 11:09:55 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vlUad-0006gv-4P
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 11:09:53 -0500
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-43246af170aso797052f8f.0
 for <qemu-devel@nongnu.org>; Thu, 29 Jan 2026 08:09:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769702989; x=1770307789; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=CDGtUlFBjW+MvjyohX5qDrWSkViGIe1RMZVwu2N7z9g=;
 b=XovYe2VbJZRhgykXFoRHtbKW8TJZajqEXA7OfIXHMcsR05mi3ERi/VBNYcRFhRTpv2
 jAhYI07Fn/OHViA23tZ8moBp/mkNlB7sPqGQJvRpPv8X+0xuVVGlVTaWJ0xcXNSyL+qn
 5BT5DUIqYqqOqx4H9Z5w6ro5IwpneU1u60mu4hxsgNyW7j+p4Ei3xQ+yJHAQS7Tss5GQ
 K/CzuQJOn1g6YjaeHt5jeYyFrW+tYkYagE9wA8sYhQGKotNs0FVlKLoJ/wtSlsI2M35o
 HiNqUQam2R3i/ItAhM6onvbUqRv11wFWinlxX/WsMzNUB5UiiVvHfnRVXeT4zvnSrlYB
 zK7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769702989; x=1770307789;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=CDGtUlFBjW+MvjyohX5qDrWSkViGIe1RMZVwu2N7z9g=;
 b=JzjCvljeMIZ2c0WrWl+TREGei9cy/LpHO1M76UqgxM2hFEVzOVW0Qa79xXqrVTkHq7
 FJdH5qbIr+gdClGIFRzIP2+apBfRTghC4XT0Jt1wB53UKqF1cSsgOJnBWHQZT1nPBuCd
 v26PRIu0yxTglF0AtOht+Ygsp5c/j49m/YIs1EFrJxLdu/RtzhVSZf5zW36+qdyTozY3
 QV3Yp6LnkGxw+2dWPziF+iErFuXac0+3iAJ6ep634LZgftK3EUWdivQIVcGabHDwTQwN
 /APo9RYvUWdz9/Fi59eBAiuxqVVeP7DKQ8M/YnikhLkKB5u9ldISEs41Xp+D1eCCcSua
 fUTQ==
X-Gm-Message-State: AOJu0Yz4RMh17Jo46vWI7ahq9nhbKrWHYksQKYDQaS5xMMyu9fwUfYea
 b2ih1qQMhgA4wIObq7mRB5FkT5cePwDgJVEmtG48TFjrWpXqPksMUr4okZkPjNv7PogfylYY22U
 8vmHiCx8=
X-Gm-Gg: AZuq6aJZN0FJnZWtNe6l/Y31lWIP+A8kOBOFzpRnjlXK7zi8rfEZrQulXXKcctg3r3f
 pL55Co0aaScSmCbJa8MVcxNmtoRg3vb6HeTqX4ZRL/Jw0BK5zlz/9FhNrn2O3rhO9xZNA3U5mxt
 Mt3NGHNwGI1gYE5rTV1t7f1Bm2CGNYMGw4Vk+9jfOGY5mOPfOkpjF01F2bi6ZAhNZClL5xLaMBP
 VB9FQMkRyjzipgc0mUZ0qzcfxeQC6xFQqtpbqkLVmWe5Z0mZ4hx5VRc9lG8HEQF3dvohMpCbWUn
 NSfpkxXVEI353To7WD/clHzy8jtEtJvvN+1NgQywSeCQYRWoYLoK6SeGXPRfKM3grmH8Hc80WWV
 GeWrpnY5m5BE1dV/+50thg5LYhxugDOYYub3MjizQ2WDsaZpFEKwankvPTeptJSubIzAzDATuCx
 iZy+4r2NrU+h3ms4AR3XaM5sHPGYpXkA==
X-Received: by 2002:a05:6000:1ace:b0:435:a135:777d with SMTP id
 ffacd0b85a97d-435ea09c3bamr4822319f8f.9.1769702988576; 
 Thu, 29 Jan 2026 08:09:48 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e10edf62sm16762185f8f.13.2026.01.29.08.09.47
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Jan 2026 08:09:47 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 24/43] tests/qtest/bios-tables-test: Prepare for IORT revison
 upgrade
Date: Thu, 29 Jan 2026 16:08:58 +0000
Message-ID: <20260129160917.1415092-25-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260129160917.1415092-1-peter.maydell@linaro.org>
References: <20260129160917.1415092-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x435.google.com
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

From: Shameer Kolothum <skolothumtho@nvidia.com>

Subsequent patch will upgrade IORT revision to 5 to add support
for IORT RMR nodes.

Add the affected IORT blobs to allowed-diff list for bios-table
tests.

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
Message-id: 20260126104342.253965-25-skolothumtho@nvidia.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 tests/qtest/bios-tables-test-allowed-diff.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index dfb8523c8b..3279638ad0 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1 +1,5 @@
 /* List of comma-separated changed AML files to ignore */
+"tests/data/acpi/aarch64/virt/IORT",
+"tests/data/acpi/aarch64/virt/IORT.its_off",
+"tests/data/acpi/aarch64/virt/IORT.smmuv3-legacy",
+"tests/data/acpi/aarch64/virt/IORT.smmuv3-dev",
-- 
2.43.0


