Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89B28D2F03E
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 14:57:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkkUD-0004YQ-0D; Tue, 27 Jan 2026 09:56:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vkkUB-0004Qo-1y
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 09:56:07 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vkkU7-0000v8-9g
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 09:56:06 -0500
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-4359a302794so3635553f8f.1
 for <qemu-devel@nongnu.org>; Tue, 27 Jan 2026 06:56:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769525761; x=1770130561; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=yh8dbk8eN6lKAOTOaFVpUQyeavGmim79o3pvdOsCFfQ=;
 b=o/5TDyA01iCerKC11LDQMhiTuuAUOx14XJmJIdLhhBg1rMaoDvVCia0yVN/XLn4f+O
 sBqB828j6IlrKXV6caafCqRBPs2N9JxOpFwZkoPnMVd1g2PUR69+X0YA7XHERZ/Ex95t
 d6iM0cp27LfUdOlc+q6gYJcp10Nzhei0GGUxFiGEBvSPLFS1X9L1smVJ5Vk0F5TZmapb
 N5/7b7BV08JX9YhEaJ4JvAHbgwoM6GbtS6UsUlMuTqKf8nj9bETwArqA3pdwEQCXdFLx
 TSJZYqbcH6iRp4Sftl8yaqquTioJ8LbD9D8THCztmwTjylJmsEOvsRAzBwoUR7JRLQFR
 VCIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769525761; x=1770130561;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yh8dbk8eN6lKAOTOaFVpUQyeavGmim79o3pvdOsCFfQ=;
 b=LFrkde/vo/kkspzECm3TPjLnnkVBBdxbItCoapcH8HYIPgVSdh2wYPUwgletG9oyV+
 TWOCfkzCXT3kbFw7TMNi5NOrjnZPRrM0/Mb0kFHNhZx/oNacNXmvZ4HhTRheK3oVac5G
 uojAUw1uDlQpDqyE1TdheClVXAbzdAOfzBaO31M0LTc7O4BagDZHS7KWKH+JQqyyfJl6
 mN/+zsZx4zIFWJasmdJ5YeNs+ZlPZOuOa8QfPmkZjoX0hvsx7kfft9S/AoM6PdhiodWT
 07Ux5PJTVx4Vj1PUT1saNEKmgK+AlNU5Q6VCuJh+cTG6K1fICVguKFkRaX/JSLKvvJZ5
 9mcA==
X-Gm-Message-State: AOJu0YzwJPPk5Ynx5ovT8H/AN+rKrE6y/s3KdHgaYNHBWZh0GOwgPYon
 xPEQBYOqjJ+NMQuK+wXQHNfiB8GwCv5rzA1HZR4oYSZLY8oi9mC2sbKK4kxoa6byAVE=
X-Gm-Gg: AZuq6aKMEvUxaXGzVwyeOM8AkTKdSolNQp7g9WJSgYSWIDSYR4Uc7xSJxUocnaSlFLe
 JhdrKdOoa3BfNuccSrdOyKIiTEWdFFEONRohvfWAIK/yMe0K0HOrJYmZz5b/tDStodesEpNdZzv
 kLzqoCNGfewspeT81JnsNExwgSC9ZgAvp3zYNrp2z/cM/ec2d9p5HJyl8nYPP0P2vy+aS34wqTY
 BXuFWzhIPMX5q0RO/dL7SM2QHpMhGoj6dAhy+7UVmKS4fY2a5Nnd8bzMnMG+Akf/2xMIJnJIneR
 H7Dt/bvkO3roqLe9rf0RtyJ9ymSTPQ0HNqpuqIRl8C3fOqB6FJsLs2KjvY2OTpjrsE8hHHuXCdj
 DHF9idyoAClOVYeOk+JL33+XrcZnEjm4XeCYERlnfuUi1+CCLX1PMMbOEmqSidpjkHAvZkr7Iy3
 Xay+Lys0nwe4Y=
X-Received: by 2002:a05:6000:2088:b0:432:4c01:db00 with SMTP id
 ffacd0b85a97d-435dd06f676mr3083067f8f.27.1769525760753; 
 Tue, 27 Jan 2026 06:56:00 -0800 (PST)
Received: from draig.lan ([185.124.0.126]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435b1f744e2sm40806710f8f.31.2026.01.27.06.55.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jan 2026 06:56:00 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 3D6D15F7DC;
 Tue, 27 Jan 2026 14:55:59 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2] docs/system: update FEAT_BBML[12] references
Date: Tue, 27 Jan 2026 14:55:55 +0000
Message-ID: <20260127145555.3070590-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x434.google.com
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

It looks like the features were renamed to include the levels at some
point. To make it easier to match features up to the Arm ARM update to
use the full name.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v2
  - move level 1/2 into the () section
---
 docs/system/arm/emulation.rst | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
index 3f30ea5a30e..e0d5f9886e1 100644
--- a/docs/system/arm/emulation.rst
+++ b/docs/system/arm/emulation.rst
@@ -26,7 +26,8 @@ the following architecture extensions:
 - FEAT_ASID16 (16 bit ASID)
 - FEAT_ASID2 (Concurrent use of two ASIDs)
 - FEAT_ATS1A (Address Translation operations that ignore stage 1 permissions)
-- FEAT_BBM at level 2 (Translation table break-before-make levels)
+- FEAT_BBML1 (Translation table break-before-make level 1)
+- FEAT_BBML2 (Translation table break-before-make level 2)
 - FEAT_BF16 (AArch64 BFloat16 instructions)
 - FEAT_BTI (Branch Target Identification)
 - FEAT_CCIDX (Extended cache index)
-- 
2.47.3


