Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8228AF8A14A
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2026 09:18:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDIry-0007e3-Q8; Thu, 16 Apr 2026 05:18:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wDIqf-0005He-Ox
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 05:17:21 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wDIqe-0007qJ-9y
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 05:17:21 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-488a9033b2cso93513025e9.2
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2026 02:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776331039; x=1776935839; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=q2V577G961STCISYwEEPKvXFA/Bc5cWtINI02EFduts=;
 b=xzP5fsbVddZi3BCTCQE2BU6z9Q0TGr2BO6K9JSkULt5Y36yaUf3Mex8WhkvRr4kk+i
 NMoTX57dHQ+oUZCO0lMxuimbtCBwBSfJj7PjslzsAWCjhD+EgJHXNw6iO+FEzW3+ZAth
 XMitysZ0ek9dk2v5OmEP2TLs3am/n4HNfSstZmdOjQ1jZdg96S4SgBAejTP5ZlhKRZ+O
 fS9zi4WsqcGah+WbnGZU//6e2ly6DJvA6REtjoZYTYBC0tKNgo3Zr5PCnr/Ech7popOD
 LPGSpG3b1QX87UPKWH8oX4O7Hmd0eALTkd7GeaPhf2WBpibpUl9wNe0ngHk8OhBOtNOx
 9Drw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776331039; x=1776935839;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=q2V577G961STCISYwEEPKvXFA/Bc5cWtINI02EFduts=;
 b=U2wiYlQzSFCIzBGx8oTSN4QzTCT1qGAdumQzR8jCv8G/0SwyW52iHELxI3vJdPUX01
 Rayg0vBSNMg20qZ2IgsHJKqfKiRTo0qvVI4CpWjdwRQ8eQKXXPag5kTLlJ2VI9LydcD/
 8m7GzdKvKN7PWTS2FdyGElHovH9Li4d5G6mYjvz05hrOEgHzBfbCntrMnbqZW7MuLjoo
 wgiZi0kwsQZOUAYIogkI1XdhRKh7kRVTQnkH/WDwCtXuaMrQBRYXkK5i6/mSguAhzUUm
 yiU3ThmgOuq4K5ZdwwBBUrorOpZ2vNpfIySup9EM6tnNreLhdUqhr+sz+uq9qRHIwr2W
 TPyg==
X-Gm-Message-State: AOJu0YxTptZ179nUUVowzYYj9zeEer+hWogmT0DrtHZXwu0bvYazdrx9
 SSWXZsWE1udk+6w3Mc1T5MCnLNW60iLIZTOeNpN4lr0usyTpzUzLJCqsbccnUhh79D+P8jcXK3v
 egux3BLY=
X-Gm-Gg: AeBDiesTW/mmilwAqRBow24we7/PRgjbFTUk4/9bj9QD4ap5yuwcf+2rPPfMfdC0Qp0
 dFqkT9pJZSH4I6b/9QHAhbBLkvqSc+a9rIRR3C+ezVe2LfBesg3FiVdFnkyFWW7PQBTVG7YxVbD
 +5IVxBRfU1ihBj+REm8VzBmxDFrc6E0YVTGusVMpsyJXSMqhDEcvandsM3FvsEgBWScHil7IZWu
 ORas8TcIDBH0hRcquCXEMFStKgG2AXiHB1FjD6212Fz5ROTpGV0nwcK+NI2OL2LmbBpDlI+7sJR
 oeBEdbYtZEDX/vqr6d/ZMjy5uGpJTzqbva67ndeyyF+kA8G4PjE3RMe7DT120ofgv/NLraz6GrR
 czZlpFlBUhQuMGQVC1oCyA4i45uR8XCSAT0f7oCPGSS7M4QpMQEou1TheqgcrppByLxP+PMrcuQ
 +js09a6h1xV5XGNKAwwQlwNuJg/mAUL3jcmRrkhuPklWOYD/wWylXXnIlz+iIUAozuPn+KWHuin
 JPvZjzvr7ggB1ZTDcbUdYzO5ADWbVRnYdEmhSjkbg==
X-Received: by 2002:a05:600c:45c9:b0:480:4a8f:2d5c with SMTP id
 5b1f17b1804b1-488d689cf9emr336114695e9.29.1776331038871; 
 Thu, 16 Apr 2026 02:17:18 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488f5818da1sm37186565e9.6.2026.04.16.02.17.17
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Apr 2026 02:17:17 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 22/28] MAINTAINERS: Remove Shannon Zhao
Date: Thu, 16 Apr 2026 10:16:48 +0100
Message-ID: <20260416091654.316158-23-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260416091654.316158-1-peter.maydell@linaro.org>
References: <20260416091654.316158-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32d.google.com
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

Shannon Zhao has not posted to qemu-devel in some years and did not
respond to a query about whether they still wished to be listed in
our MAINTAINERS file.  Remove them, on the assumption that they are
no longer active in QEMU.

This makes the "ARM ACPI Subsystem" orphan.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 MAINTAINERS | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 48dd571fd7..8f50575083 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2184,9 +2184,8 @@ F: docs/specs/acpi_pci_hotplug.rst
 F: docs/specs/acpi_hw_reduced_hotplug.rst
 
 ARM ACPI Subsystem
-M: Shannon Zhao <shannon.zhaosl@gmail.com>
 L: qemu-arm@nongnu.org
-S: Maintained
+S: Orphan
 F: hw/arm/virt-acpi-build.c
 
 RISC-V ACPI Subsystem
-- 
2.43.0


