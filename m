Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D002E77188
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2025 23:31:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTr7k-0004BC-1E; Fri, 03 Jan 2025 18:30:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tTr7i-0004B3-BU
 for qemu-devel@nongnu.org; Fri, 03 Jan 2025 18:30:34 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tTr7g-00039F-DO
 for qemu-devel@nongnu.org; Fri, 03 Jan 2025 18:30:33 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-43623f0c574so86914105e9.2
 for <qemu-devel@nongnu.org>; Fri, 03 Jan 2025 15:30:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735947030; x=1736551830; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=5ZCn/ZiYxtAoYd8N7LalY96ql0AfzSwZqtrc5aLA6eg=;
 b=CTfLfIRbEupNi0wofVvqXRrA/kuG6z5CRVpWktL4lQsqMISDj1cO3d0nx7nvj2djEY
 BYefJbztZPRJ5jpOB4EsDlDcM8nHoJGmJoyeac9EnRItpSk/ZmckGFPQ71KI9DuLJisp
 cAHuMI5Ptf+fMKeD0TqupaoiluTD1dLBHuKNaDqlmuayUhemcPeM2CfHJIk4P58lkqeF
 BTG5L0rkaLQSvkCcfT0ixOKPzSIlVxEZxW7GvHwumeHM7aT6+Y1MQYko4as/CqUe1gdE
 mDCNxyRY/ukitCwsmaGrKzvP4hNIDYGQRvqKBBCvhZfJk7f8wwLWUx+PTBLCUXuu6yGP
 xXVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735947030; x=1736551830;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5ZCn/ZiYxtAoYd8N7LalY96ql0AfzSwZqtrc5aLA6eg=;
 b=XdrIZBssWG+fww+IaYYGDPpYSbuH8HBNRru0SoKis7ItSvYZHaH0j75xXWz39z9DiG
 7/hkaBU9CrrPCuwti3bGUpadYAt/Y1dNoQ7ZN1jVdEE+jXUUSqM9pCt01a5ZmjFfGGWH
 bM579arhNp82jvcqwD4amW7HofedcpUlobVpuP3T9hLVdpA/NFXmGaZ4Fn56AP7LFUkN
 L6Jduw5R4kKSKJDuT018SCZ4NMZqVFWmUicj55J6DTrWpmm7ncffyIOPkoDvJ5W+9DVD
 rVAdYkI+3dgjB4oFzuvadUpB7ntWsw2N25cltq71vfSsE15LIjg23Fx+l57t6c0NNfUl
 8tdA==
X-Gm-Message-State: AOJu0YyAdKMUatSuE8dDTCGDxQscIcvsbPHBHQQ30Kd3dFCK2VV31M81
 eJEGEz2b27MCrbD3na8KqxuYI8jtE1YuXTHRGoUZrk3V86QQ54hEIK4DBTSl4vclfUgdiXxQfjx
 /Lcc=
X-Gm-Gg: ASbGncsW8vEsDKnH0YqnOXg160HTAVVGOmnFN/oASeP0GKmpOo0NqXByIAwvUZhxlpD
 Kib0rXFKjVUihWu7zo7/PAxlF0zFbfciITdFOh9uPekZV8BGfcruGrcALuVvW0jWJNKnUXXHzCH
 239J8/oMm7ml46aSZMOFwPJNiQQBs3nrh2Sy4X/K5+uiU78fQV7FvHPpxMG2pdpxf7oLSvTSaS1
 BRXR89tv4IXcXuskdnH2audtdVvAN/k+4Z5w7WGUu/Y3Rjkl6VECt43Rc32xRbtdC2YKU9UPpGy
 XzO4QqAcj7JSW+YTmtiUGHeOcJmqNmw=
X-Google-Smtp-Source: AGHT+IGTImDKuKCBq2C0Ilm/ThoBhg/IaKJxEhd46PX7uLjbdebYymnDbQsgeToiwsLfqU7j1qsmQg==
X-Received: by 2002:a05:600c:1f85:b0:434:9936:c823 with SMTP id
 5b1f17b1804b1-43668646741mr471410825e9.18.1735947030196; 
 Fri, 03 Jan 2025 15:30:30 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436611ea42esm504285145e9.9.2025.01.03.15.30.27
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 03 Jan 2025 15:30:28 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Cleber Rosa <crosa@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH] MAINTAINERS: Remove myself as Avocado Framework reviewer
Date: Sat,  4 Jan 2025 00:30:26 +0100
Message-ID: <20250103233026.65717-1-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

While I was very enthusiast when Avocado was presented to
the QEMU community and pushed forward to have it integrated,
time passed and I lost interest. Be honest, remove my R: tag
to not give fake expectation I'd review patches related to
Avocado anymore.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2101b512175..8d7044e91fa 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4196,7 +4196,6 @@ F: tests/tcg/Makefile.target
 Integration Testing with the Avocado framework
 W: https://trello.com/b/6Qi1pxVn/avocado-qemu
 R: Cleber Rosa <crosa@redhat.com>
-R: Philippe Mathieu-Daudé <philmd@linaro.org>
 R: Wainer dos Santos Moschetta <wainersm@redhat.com>
 S: Odd Fixes
 F: tests/avocado/
-- 
2.47.1


