Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40C4BCCFA07
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Nov 2025 16:10:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGJbm-0006k5-3S; Tue, 04 Nov 2025 11:10:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vGJbb-0006gr-B4
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 11:10:00 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vGJbU-0007KR-T8
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 11:09:54 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-477563bcaacso6248865e9.1
 for <qemu-devel@nongnu.org>; Tue, 04 Nov 2025 08:09:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762272591; x=1762877391; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Nwbc35izo7jBkFp1Gk6qCqzfNIu+g3CB8xZ18Iq/760=;
 b=kNf7AtgRmbBkXF/7lw2/zIASn2xt5tfk6+s2aHErwmEwb/PZN9/mxVGWmInFSSR/zh
 PId5QyNGZSpD74rChE5xiUV3FDs6LMOjXbg8NyksmWTid3xYejrKitT1h+1nM1cUyUNj
 MAThusD60ICYbiou+dMGkYN8dQRskHMn2QzZvjOoddsbvopLY3CjphmCpmPkkumTaIxN
 0FCYni6LhDc66vzWYXG+0PR3/7KrF3xCpDlsjLeoClJyIx5DqkVX0+5ItF6hDDyXsP0z
 k/14NbaWkY8JjbTsKsdn5wxuLYdUx1SF7OlFnjE4xDnkAWmO5DV+w5GkWxbOp8dWXLI2
 yfow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762272591; x=1762877391;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Nwbc35izo7jBkFp1Gk6qCqzfNIu+g3CB8xZ18Iq/760=;
 b=q00RvWcFkGLTxjLl9X71Y/MNKsCbCWlUqLvXHxVjNBpgy4dYlvCuX+wBXVSa117D/z
 jQ1iUr7jDMPBTMEOgpiyCSqg2Dx2kHTGnBsjCahkG/I9VvdVRA6VcDPDx4m/EjgMHmK3
 2QLP7JnBJctJW+nCOjspEG82oXJfU5owlBIgisKJPyb8tBoJCS/I78SAvDYi0oT/2pIw
 C34TjfKaq3zVByLCHSN/9TKjz9fpbLE6pVbtB22lLlwuEbvvfsWE2VyA71tQmLJ4UsrQ
 WPKrkO30QIN2IlcoJyOq/0UC7+QrGDPEdfcaSa+IIdpmloV/jF8aM1OZDlqBPOJw7Q3p
 OIDw==
X-Gm-Message-State: AOJu0YztREuVnh/7E3cfhn68jdITwKxNz1aMJZp25oLZUOuoZ0N4jJOG
 Mky+h7F2pBn+MrKAegefMULa0bT7lkJOV8VB5GlSDGA1btGSwhDJWnrq6bitWk9auQdeUxaWTST
 aFLRn
X-Gm-Gg: ASbGncvCy9nuCLoT2KFFq5VNAtvvDCYVYGWjNM+kVV/qC1pM8Vao3hLY6f+ZjzyFMHk
 KPHWY6+XtH5I5XmdG6fYrXg9UI+9OVNYPTG06UVk5CZJQXlhfJ6KPsMsZaymSnnNa7LqGz8ZeVv
 6l9EAz23ZMPfwmIxat8cGcXK5JEev/fqeQKGTvrMUI86ChZm+bA1nSZKqnniIm3om2Okm5Dz+4O
 /R0qmWNBoCVIosnLY9Nkdhnq5lbiGe/6adyU7PEDIrL6Y4DFBSZtsfolL1OX/Xpt2ezj79vWaWy
 KcfVtFqlX4kU99QKgLHhQi2YVhHky/nFhXllUEstFe4FEzMHgI+nf7+QXPEFtVHGcY6FE0TZ+EG
 Ii9k4avMmr5OBUMzUEPWuz2I9gfLAUaD9oDxVUJVLMNVl+dUmUZiL0bXFDa+kn96BkB9g7CPPco
 ZuMKshv4q7MOYtr3oT
X-Google-Smtp-Source: AGHT+IEFoT73Z3EIBGH0Sfi3uO6PpjE2JgbZAbOE4R78rj0Ul2MVk3CeMsOPlJLqkVS3reMJzp4E5Q==
X-Received: by 2002:a05:600c:450e:b0:475:e007:bae0 with SMTP id
 5b1f17b1804b1-477307e47admr154977385e9.16.1762272591321; 
 Tue, 04 Nov 2025 08:09:51 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47754adcd08sm57314455e9.5.2025.11.04.08.09.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Nov 2025 08:09:50 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>,
 Fan Ni <fan.ni@samsung.com>, John Levon <john.levon@nutanix.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Alex Williamson <alex@shazbot.org>
Subject: [PATCH 5/9] scripts/clean-includes: Give the args in git commit
 messages
Date: Tue,  4 Nov 2025 16:09:39 +0000
Message-ID: <20251104160943.751997-6-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251104160943.751997-1-peter.maydell@linaro.org>
References: <20251104160943.751997-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32b.google.com
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

If clean-includes is creating a git commit for its changes,
currently it says only "created with scripts/clean-includes".
Add the command line arguments the user passed us, as useful
extra information.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 scripts/clean-includes | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/scripts/clean-includes b/scripts/clean-includes
index a45421d2ff7..694e12f062c 100755
--- a/scripts/clean-includes
+++ b/scripts/clean-includes
@@ -42,6 +42,9 @@
 GIT=no
 DUPHEAD=no
 
+# Save the original arguments in case we want to put them in
+# a git commit message
+ORIGARGS="$*"
 
 while true
 do
@@ -198,7 +201,8 @@ if [ "$GIT" = "yes" ]; then
     git commit --signoff -F - <<EOF
 $GITSUBJ: Clean up includes
 
-This commit was created with scripts/clean-includes.
+This commit was created with scripts/clean-includes:
+ ./scripts/clean-includes $ORIGARGS
 
 All .c should include qemu/osdep.h first.  The script performs three
 related cleanups:
-- 
2.43.0


