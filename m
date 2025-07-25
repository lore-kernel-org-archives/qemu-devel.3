Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA399C87FCA
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Jul 2025 15:46:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufKcb-0003kh-L3; Fri, 25 Jul 2025 11:46:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1ufKby-00032O-Jm
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 11:45:34 -0400
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1ufKbv-0002Rw-GS
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 11:45:30 -0400
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-ae361e8ec32so374364266b.3
 for <qemu-devel@nongnu.org>; Fri, 25 Jul 2025 08:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753458325; x=1754063125; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bIabl8p/7XQ226I10wjA7oVAu+HYDoNW8uJ8FZl1Lqc=;
 b=Q6Xfvra23FueRnXMvnjvuPgpwoyRObRBMgv1XBaM3YXNwlD3azzjJcWBGbYTK7GLX2
 zCJJtLzRHmG8EWiK5Nh8lab4MUf1FMVcBUa8b8dFhkfRNeg0/mGCyBOLGLxbG2Xv96Fj
 DlES/2M0CDqcAJvy2MDVw9mcBzInHZZhTuFHCBH1TRsMBAXTGn9LxvuoF7iCCKC5hqM6
 F0VEirZYVq5N5iOo3u33Cf9I6oOPZPJsZbmZel/BS+y6vLhgcWeHYQ8FwxNJ+6Z4kiIZ
 tEN0kzfJKqXOhEyTKS/b4HV2YgukBmsiOHSOaoqX+9OyA9/oHAN/AzI/0lUJCOFi6exZ
 UhUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753458325; x=1754063125;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bIabl8p/7XQ226I10wjA7oVAu+HYDoNW8uJ8FZl1Lqc=;
 b=tzecT+iwHUhtZ/SVj4canqN2XTrcfpAcNAI0/YsRTlNqKp5FXu4YXXCCEEyxUkM4/F
 4tAK6kqk1P9AHe+bz3v83aXoGBx1Z8g6mhYsJ3Q3KkOMdPi+xFomAKu0wNpav+ZtY902
 bSFLOCtntnYtIKMsNZ5ev9vFoQi1EqElV/fmnRJbiYVgfWFDNoq5kA4tEZyzdR1SJPgj
 49lmIs9i2IkUjuuLVOKhOfq9ApUFZpUbkFmtS0czELKUb1HtvZiyjfJt5Wvq5ZEQV2WJ
 So2S+nTy2D0uS7hvasXg+cr+me8OGKEJovZIzRRQDZGVV8szqMrx3XFv3tbTapoGf4cZ
 DdYA==
X-Gm-Message-State: AOJu0Yy0ep0JXQaqS0Mn1fBcCD0aIHswPKWn/nUsimkuDVwbQ6qxsgHb
 irQG0SU7vTYw7xjXag1MTcNskPWi6vZAv86YBCyNCgUm4fDYDY0sPXGwMbsZaa2dlWc=
X-Gm-Gg: ASbGncvX5bAt993JMLXN5lXX8VxZAKJPvPH7qwuIGGSU9T9YVDeVsdymZ0mcFzXYSrF
 LwCaaBX+rKTO+J4MMrIimeYSlHn7P58CRhuOh0sDC3L6TjNMgIDZiryQYp3kPs2ymJ0YvrtXcPM
 /c1PfnOSusu9HtExKL/SzDYvTwteZIy5NHedaVHZpLJWHconKRBjfkBDRbD/VWLmB1SI5+l87xl
 q4LMgjxKzxCxLEZwUsb72+UmzhbFgdRK0PC7QAfd9c/8wGRfbQvVmPMAlL/hm0PNoY5Bqo3M80U
 qH3F+dSuY6yQbSNYTNJf0xY+XzeRCE17iVkXeiPN85ZwBZ6ctURTW2psz8aKo6TNANtbMaBVBPG
 oRq/oz5WiSG11wUgEvDYNPrU=
X-Google-Smtp-Source: AGHT+IGUHgGU9K5KfE7qyK/BSFlnnFrvzH/XwqMn0NT9jZ7X9voCtyepF8BDOavjc7QbDmzXrrJSTg==
X-Received: by 2002:a17:907:5c7:b0:ad5:7bc4:84be with SMTP id
 a640c23a62f3a-af619dffbc2mr324176966b.52.1753458325085; 
 Fri, 25 Jul 2025 08:45:25 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-af635860003sm10452266b.10.2025.07.25.08.45.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Jul 2025 08:45:20 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 0B4455F876;
 Fri, 25 Jul 2025 16:45:18 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PATCH for 10.1 v2 02/14] docs/system: reword the TAP notes to remove
 tarball ref
Date: Fri, 25 Jul 2025 16:45:05 +0100
Message-ID: <20250725154517.3523095-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250725154517.3523095-1-alex.bennee@linaro.org>
References: <20250725154517.3523095-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x634.google.com
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

We don't ship the tarball and users should generally look to the
distribution specific packaging.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/560
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 docs/system/devices/net.rst | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/docs/system/devices/net.rst b/docs/system/devices/net.rst
index 4d787c3aeb0..7d76fe88c45 100644
--- a/docs/system/devices/net.rst
+++ b/docs/system/devices/net.rst
@@ -21,11 +21,17 @@ configure it as if it was a real ethernet card.
 Linux host
 ^^^^^^^^^^
 
-As an example, you can download the ``linux-test-xxx.tar.gz`` archive
-and copy the script ``qemu-ifup`` in ``/etc`` and configure properly
-``sudo`` so that the command ``ifconfig`` contained in ``qemu-ifup`` can
-be executed as root. You must verify that your host kernel supports the
-TAP network interfaces: the device ``/dev/net/tun`` must be present.
+A distribution will generally provide specific helper scripts when it
+packages QEMU. By default these are found at ``/etc/qemu-ifup`` and
+``/etc/qemu-ifdown`` and are called appropriately when QEMU wants to
+change the network state.
+
+If QEMU is being run as a non-privileged user you may need properly
+configure ``sudo`` so that network commands in the scripts can be
+executed as root.
+
+You must verify that your host kernel supports the TAP network
+interfaces: the device ``/dev/net/tun`` must be present.
 
 See :ref:`sec_005finvocation` to have examples of command
 lines using the TAP network interfaces.
-- 
2.47.2


