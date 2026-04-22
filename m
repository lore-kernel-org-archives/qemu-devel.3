Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFF63F94CDC
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 08:06:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFSa8-0005W0-I4; Wed, 22 Apr 2026 04:05:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFSa7-0005VG-1d
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 04:05:11 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFSa5-0001Tp-Lv
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 04:05:10 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-43d03db7f87so3454325f8f.3
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2026 01:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776845108; x=1777449908; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jOgtzLw5d1r26Q0NFjivd0ZMxXlVly0h5YldDZ43mBk=;
 b=sPApzvG7CHqHOFGyC+PI1hl/2swx2/BlfflZF+ZdVfDMcEEBU0QuCLL8ubXqn0uACT
 Vq1Gh98MAO7QtuDPHCtmRFbLWOGJKxK3F5b0qPVP5dnjJYEJzDnUnFoRJ0wtUxxA3K3h
 w9wDEFd9a1tmOuJ49GbdHeeyav6rfbrKMN2n6FFRDt0ChrWscpMqpYfI3zjMjPe8mdb4
 OivxLG6+TwqN+et44Vt4VyY+RMwBotyRrWuNnsoWQlZhMW+o9psN0kTRYJn4XAfhko7a
 zYzsCO+5bG0l6OhbOTwU3tJzZW1S/Vq2WptsKlyXmldJ0m4ljNAqX/UvAF6ZtrdoHOGg
 zhhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776845108; x=1777449908;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jOgtzLw5d1r26Q0NFjivd0ZMxXlVly0h5YldDZ43mBk=;
 b=lN+/OTmf+7NoE0rL4geowTpgJhZGmTCIOTbecaEp/vBMquDzRQkgqQcC1cyGGYtQ1c
 7Jb6SDINtOvC+h0U2HTZ6t4ZiOxJvh5UcD+Tp0VI7sUK+l3bJc6HyAnlPJnTNOCMRXZd
 4BS3CSwalxQiMxrXi0Ddux3vJBs89zgh5vu10xmde1XqU5uvg9uC+R0YTAq1yZyEeZC0
 DH6yWrppZar94ROHFNG1Xz/TayIGNLZuttNhNnh1hI+Bc5YnTSYg87UjjuWh0B41Jqn3
 RvRYaKXDfl6/10qZtyvJeyuO+22y4gjCWeiFFeGUrYSdIalj/vgXKfVboh7r2nc3//bX
 Hgog==
X-Gm-Message-State: AOJu0Ywj29OyJGaS9xoFCsTCbflKeJgv816Lm2kYJ3EeaFbvClslHRfB
 Yi0XxmhXLK9/apwOex8skQ+XE9n8SRWwMVOdxoAwP11/ulrmy7OBaTRfTnJTy4CRHfj8hACmJWm
 OZTSOd9I=
X-Gm-Gg: AeBDievHxrfoU1+jGG19mJWOM8k2enBgrHhRt1umRUPtWuNrToQtJJiJaAAduhBUctl
 Q5H/134lLnnLxx/RssDaKe8Rz6CLn1vZQEkljQ7c5S0fyKg+bE51fDTziSvYAQbii/oEs3u82GN
 wmTNsyjKc7r6L/yAZEQurSZAzGMuLHYOB0IIHIDkc2yKeg2+7Gnqziy0Kdyo19jeSMlv5w+ilC+
 X3aZZ5hX7AOiOmBG3RjRM6u9avD3Km2CKh9fy3yVLB5q0MLOTt1DOdxOKZb7WdMfK7wbUnjxc+G
 faybaGvzkh9NqCLblI4DPmiKuYF4xEUQ3ytt8BhFpqEUnegAx0eZN680uy8UbYQENatGSHJSRYy
 2VGoibAaDrG71fk8cd0WelT1U37GdBHTWqR7gT0EpQmrbEWam+vCOrduvxKbU+iL0jEAWQO8fN9
 M3Z2/WmaONaYXYY5IN+xrVh907ap+bGufssVPP+u5u3yPUMCsrS2mrFvT/5fDIaiEQwvIyxU1/i
 Iv7AvYc+To=
X-Received: by 2002:a05:600c:2e56:b0:488:d243:8da9 with SMTP id
 5b1f17b1804b1-488fb73b2d3mr185133325e9.1.1776845107711; 
 Wed, 22 Apr 2026 01:05:07 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-489e124f6c7sm55798845e9.29.2026.04.22.01.05.06
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 22 Apr 2026 01:05:06 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Daniel P. Berrange" <berrange@redhat.com>
Subject: [PATCH v2 08/10] MAINTAINERS: Transfer FW schema specs section to
 Daniel
Date: Wed, 22 Apr 2026 10:04:03 +0200
Message-ID: <20260422080406.62638-9-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260422080406.62638-1-philmd@linaro.org>
References: <20260422080406.62638-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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

Pass the torch to Daniel, but demote the 'Firmware schema
specifications' section from 'Maintained' to 'Odd fixes'.

Suggested-by: Daniel P. Berrange <berrange@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 MAINTAINERS | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index e651d18879a..5aceda193c2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3963,10 +3963,9 @@ F: docs/specs/fsi.rst
 F: tests/qtest/aspeed_fsi-test.c
 
 Firmware schema specifications
-M: Philippe Mathieu-Daudé <philmd@linaro.org>
-R: Daniel P. Berrange <berrange@redhat.com>
+M: Daniel P. Berrange <berrange@redhat.com>
 R: Kashyap Chamarthy <kchamart@redhat.com>
-S: Maintained
+S: Odd fixes
 F: docs/interop/firmware.json
 
 EDK2 Firmware
-- 
2.53.0


