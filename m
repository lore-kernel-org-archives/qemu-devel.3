Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7236AD116F7
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Nov 2025 18:22:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vP36t-00032y-Vd; Fri, 28 Nov 2025 13:22:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vP36j-0002yo-71
 for qemu-devel@nongnu.org; Fri, 28 Nov 2025 13:22:13 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vP36h-00037i-JW
 for qemu-devel@nongnu.org; Fri, 28 Nov 2025 13:22:12 -0500
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-42b566859ecso2038427f8f.2
 for <qemu-devel@nongnu.org>; Fri, 28 Nov 2025 10:22:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764354120; x=1764958920; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GgY4wKPjvv9aRCmLjqgJ412b/n2ao+a4W2M6nwlctWM=;
 b=M3YI7FzRr0/VdR9MwX2T7oihLiSM38OiO/yiOk7kHD+i09Gv6DoxBdmHRIaXz19TNi
 fVshUi/jhGlXPGpeDhgGJts4Aq/I4MFma7g3YyW/FE5zVXKqr+fad7M5AzzF9XIEGnzC
 g+/EXLAWkH4Oawlqq9XQiD24WxUr9pZuTxdZGf6RVNbpE8S+BfCzp8Wmhr76zHhy53EZ
 QVZ5+wnMe5o5EkhOB3WAFyqn+D0ML4Ld+Dre+hI7ahf+paDXsFlXrtkHls5iV/HyOLpg
 aduGzJHqmyY29iLVvO578+yF681ZnlklxlCGt8/iO0mjYAg+2XCd+znfYV8sBrFlvzkH
 9oTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764354120; x=1764958920;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=GgY4wKPjvv9aRCmLjqgJ412b/n2ao+a4W2M6nwlctWM=;
 b=HvQAU3LxvHzimJFhnCS+HL2Xvq49+8kkPhzIFyBb5pWpmnRKsK33eaQN3aCOampK/I
 zPyNXlkHxrrCtP1OmoMQGslVqm6W0sa2eSYPh6DPbGtP2fbgeLCgib/ZeUGhxq3RlimG
 ZkX4qHBej7NzueMwchLQo8a6Ukx4qtdM5dXYWjvnibqcGg8sTxsa8Z85cNDNA5scUhmp
 REXJ/SWsiQvK2Zg3CrY/2gNDI3fIYWFOMo4OG3WfKqx3lPpYXypNjD1/ZBXt9TuyZTtJ
 iDK5yp0edGQr0mZp6PUmIhF/dVGmkdeAIng/P4EWB3YvYfq3JKWQOE7iRVb8zKPCjNzI
 ALKQ==
X-Gm-Message-State: AOJu0YwluUs8uslKEUIX4C35VN3CYIn+E6NHajyEaK0OnAZoQdn6BD8o
 CuLzq/EVHU2o2FGSqVlLB4wEEVitcinPq9DXDQpsBJgDUmivm3GPOxXMHIGuhXNKZpA=
X-Gm-Gg: ASbGncuohjxexG2bu/4pe5P3GXQQxX5F0okAxmaAexpmzMCTAvXy/a9em6J8cBWBKsS
 DLFaOVuvOXFXsFs06+QYkrFIqu0Wa1dNpoWgGUn+TGfNJdJahWMVqwNvBvetUJrWltm39/+H5mz
 dt9BSocmZxiTw8uk5QITxHrVhi8Qufsw8dQr8OLkjdVL0HM8pIiEJbYxlRqwHxIwmP6yVQQN79+
 P/KplU+4VT1k8UZSnXx5kCfoiYl1+Ec5qRGPQU43cicQ/ZEPaoIpPaeHoh/PsO6B/x3r8li9fxI
 RznmE4vx2smYaL86OP05N+DZ4aAeMAkuUPdvWMEX/uucOLJkbayJ4IRbPyGVW7YghSa+G1Wd4ak
 bl6ws/+aofwEMfzmy7mNoNPznXKCO0jlQ9A+b06R9e9KvlpRost7eb4PwtJpmSWfg2T+OD+yAK6
 Ot7R6OAiHGwYY=
X-Google-Smtp-Source: AGHT+IH+7s4qQYVhzcAEvMLiaxBPi9TuZ4xPrnEhqbmBmMUzuCV6RchHo3FuTQ3M7jrX+8WqS4/mDQ==
X-Received: by 2002:a05:6000:381:b0:42b:3ad7:fdd3 with SMTP id
 ffacd0b85a97d-42e0f21e953mr18429580f8f.18.1764354119986; 
 Fri, 28 Nov 2025 10:21:59 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42e1c5d6181sm11013710f8f.18.2025.11.28.10.21.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Nov 2025 10:21:58 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id ED3C45F8F9;
 Fri, 28 Nov 2025 18:21:57 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 2/5] tests/lcitool: add bzip2 to the minimal dependency list
Date: Fri, 28 Nov 2025 18:21:54 +0000
Message-ID: <20251128182157.4125745-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251128182157.4125745-1-alex.bennee@linaro.org>
References: <20251128182157.4125745-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42f.google.com
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

You cannot build any softmmu targets without it by default unless you
build with --disable-install-blobs.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/lcitool/projects/qemu-minimal.yml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/lcitool/projects/qemu-minimal.yml b/tests/lcitool/projects/qemu-minimal.yml
index 6bc232a1c3e..2a1ac51d402 100644
--- a/tests/lcitool/projects/qemu-minimal.yml
+++ b/tests/lcitool/projects/qemu-minimal.yml
@@ -4,6 +4,7 @@ packages:
  - bash
  - bc
  - bison
+ - bzip2
  - ccache
  - findutils
  - flex
-- 
2.47.3


