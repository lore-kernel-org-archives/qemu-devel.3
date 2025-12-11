Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C746D41D7F
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Dec 2025 18:02:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTkz4-0000fS-Gj; Thu, 11 Dec 2025 13:01:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vTkyz-0000dP-7i
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 13:01:41 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vTkyw-00060A-Br
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 13:01:40 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-477770019e4so3998375e9.3
 for <qemu-devel@nongnu.org>; Thu, 11 Dec 2025 10:01:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765476097; x=1766080897; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jS5orBCRXtQ6207/qf1uOG+6aWOOe4PQGuReXIq6bSU=;
 b=aHQVbc8vJsdkfl8oC3cwVT1Gd/8TOBDCZeMmL3stT047Um9ZXyJ2oiOC2XfRf8eyC+
 I2tyu90lixJyS6E1BRJDM1Ojcffp1ahYaA6hggpLIpP3aExfK/GOlAtbsm88YcvNO60v
 dMCidheVszslh4uswYkZzAcCBROrvQNxyfl2WK4y1UDsEigE9BcAdvqiEMWyv/TM1B8w
 st/AdmKebESVVOuWcc14yRyj+orgu2eRZAo8rCW9jGXOEOvxMRkOgcgjlXvmxWdE2MYh
 xBdXu9v/DJhQd34xAWNdES4hO3ctwfN9vnguFuNvWEbHpUQJ85vzjXvcDJK4FjMc2sOr
 d6Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765476097; x=1766080897;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jS5orBCRXtQ6207/qf1uOG+6aWOOe4PQGuReXIq6bSU=;
 b=pfrq5Mtua+tKjJyWFe9+Rlh/SKWsVx7TBZ156mpp5FOr1QZEJxVWTT6rvd1QF4sZ9w
 NZWqlL2RlJLaP8pz8hm3yQqSMGCeVhXsC99MBWS97P5PMWqvv8aupX2mCPEOhqCSrHma
 7Rp/yJ1m2x1iMsBPKBy4jPL5sfsYG7FlfymHEBdhXfwn6mqBNk8J3L2oQzxdlFKa/y0x
 qN5Bp6irp9c0MLbjoNxx8Z9QhkQWf00HcgqXGxOD2M4Zlfc5nGXJUH/JVSYADMvhWAqq
 Pjs7QsWSEG6KxXuTwxvBjnw7OCOuVjVETixu1OqiDnHf/Rh+pJNpthu6UOoslriJdK1B
 zt1Q==
X-Gm-Message-State: AOJu0YzPTlB6slBL3SsD4dX1vxyX+8WguncDHOqGLKp/SmhBtVV9sPrT
 QoOedGcVf9w8ZXtn00P0SQKjzqFZg3rNaXix4MCtrfVghyJRDZx8nWrFY16mRdDjIUQ=
X-Gm-Gg: AY/fxX6WwVcrbZ9NrZdlakcCqYK+YiPQJsHjmMIwR984M6DRN3+YNNnTqt6bzRUzbEi
 rrOcxuQ7fI7XNg7CDFhtPYJAPfu+92eO2lNRh3fj2miRq5OREkRo7wJWs7ddRubTykeaZ/V0H3j
 DVloKrbGi5m+g1WqNq741w4d6xC1D0UMp0J2BOA9uy4zK0e2r3P67x5QQCiYlBWrFvvZ4Z2IoaA
 nFfRy+Wea0Y10wnnusx+3HCCqT6Boybhi091W+xaQLYnhmFUZ/WjR/ZgPSwxxH5u1OGPJQ2oW8q
 d4BdWdRL+s7NqFSy4Tejvft25Ae7td0cwHTlcoM7/IM8Wc+luRXhQHPv0DwnSrGJJtDGZ/bkVJx
 53g/2MLsxRaSuNMlQ0qdldHnh2f2Wnm5M4yuB3HD1OXLkIa7c2yBQFgbdWC4SaooJmn7hC9u7Nu
 dzvfAbuo/l7K8=
X-Google-Smtp-Source: AGHT+IEt4qbL5cL/X3c8mxr6zxzLnFxiLyRZ1RCidMgPJbwlVVe4/4qtU3lnweIVzFdm7dpyKVgyjw==
X-Received: by 2002:a05:600c:45c4:b0:477:a246:8398 with SMTP id
 5b1f17b1804b1-47a837fd4ffmr70061045e9.2.1765476094046; 
 Thu, 11 Dec 2025 10:01:34 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42fa8b8601csm7819940f8f.22.2025.12.11.10.01.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Dec 2025 10:01:33 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id AC56C5F87A;
 Thu, 11 Dec 2025 18:01:32 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Cleber Rosa <crosa@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 John Snow <jsnow@redhat.com>
Subject: [RFC PATCH 1/9] MAINTAINERS: fix missing names
Date: Thu, 11 Dec 2025 18:01:24 +0000
Message-ID: <20251211180132.3186564-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251211180132.3186564-1-alex.bennee@linaro.org>
References: <20251211180132.3186564-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32e.google.com
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

The form is Name <email> so lets fix that up before we enforce it.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 63e9ba521bc..05b644cfc9b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2519,7 +2519,7 @@ F: hw/virtio/vhost-user-snd*
 F: include/hw/virtio/vhost-user-snd.h
 
 vhost-user-scmi
-R: mzamazal@redhat.com
+R: Milan Zamazal <mzamazal@redhat.com>
 S: Supported
 F: hw/virtio/vhost-user-scmi*
 F: include/hw/virtio/vhost-user-scmi.h
-- 
2.47.3


