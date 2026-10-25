Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 100B2606A31A
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Oct 2026 18:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=WpipN0oo
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xL2eN-00079w-8b; Sun, 25 Oct 2026 14:08:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gessingate@gmail.com>)
 id 1xL2eL-00079f-1b
 for qemu-devel@nongnu.org; Sun, 25 Oct 2026 14:08:53 -0400
Received: from mail-qv1-xf33.google.com ([2607:f8b0:4864:20::f33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gessingate@gmail.com>)
 id 1xL2eJ-0001py-CM
 for qemu-devel@nongnu.org; Sun, 25 Oct 2026 14:08:52 -0400
Received: by mail-qv1-xf33.google.com with SMTP id
 6a1803df08f44-91b83459526so29826556d6.2
 for <qemu-devel@nongnu.org>; Sun, 25 Oct 2026 11:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792951729; x=1793556529; darn=nongnu.org;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=ib6BXzLlfrOULkf6YT/MLqXrgK2vkerO1gO3o0Pv2yc=;
 b=WpipN0ooeM6myOyvoNotbtyXB8XUI0a1n/jJoby3KHDln6P9f6VDOYUMOZkstzNfpD
 F0YAaVrL9qvgUZj4DI+RmgQ1j5PpI2pPxInsa8lsP5bBH/Bdojehgfzc2tU6hEDfMesT
 /4E9Fyu5CfnVTvy/AmtH+58OQghqQnBWyB8VR2+BBwqiN1uLx9TPZYg8hWYkdXNn/u5A
 HN4Q6EXEdhPAIJ8oN0LS+nUq6OZl6VIQ/OYj3xbwGRfYyBHxfBNzdPOjj6rusr/QTgdy
 WKPGp97K5MeQqH0JMDOWTbiSWSi8S73m5s/F/GCCXztDV2F/cT9vRoQmNFrXPKENfc9A
 wVpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792951729; x=1793556529;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=ib6BXzLlfrOULkf6YT/MLqXrgK2vkerO1gO3o0Pv2yc=;
 b=mcBaTIlsP0o9u0naUwl16DunI7HqtrKvpDAzPJddWrK1UgKBdmYWF1Qe7q3jYJVv9T
 +HDSojKqA1V7JGh5P6k9f3cJBbeYpxzzswrpCDRquxiy7P71WP9/Y0E/gVLB3YPaxUtb
 CFE6efsMPA66DkE2qOgjswZWlP9Fggn6AvQCpzARzScdXroQBxWyYsQaFhv22rs/9JBF
 Zo+arDXFPlFOZ872BYIearSZorUUflVSoTOtY1KRDBJKEGDx16LiYJohbKyOoRPq3LEx
 U/GSxViCDDAb5V1/QcbQXg1nYQ3NpsZxTfSLQd+3DKlRTNWXaSk+wyLMe032AMtlp8pu
 pR/g==
X-Gm-Message-State: AFq9FYISFSoH/pphrELxw3kMenN7E/eLBBrfdvY7/O1VeJawgGePhXZF
 v4dW+M+w/SHqRsOesUBAg4XrypIBMi48lPqaO8ZjKPWHgijBJmffPt+Z
X-Gm-Gg: AYBFou2qf5GAJ56R+D0Or8FD6sMaQZGQeqdEQNtaXzLdQLE9hYa2sVSmQxr0aW6AUbS
 svweH5cJpkAoWLIeN67jbnvI3PVH2CLlFUshKMmdMtBFziV5xERUFMyMfAPbofzmtklTG+tMeIl
 DgrsHaHpMQrnrNxtKoSPSvNO1kMUsw1Br/7yHxqUk4W30OhgmOafOXP0WHKLL91E89vISCbLv2o
 kaziB2YbMHOzOQmaRIC0uJ5NNZk1MnIwrL8Wmrct3XaA/bRT0KgfNZwYi8IB9Ft8CHFIKQhfGqz
 Fesh/k1m7+logoBrkhN3KUL60XK31MxSqOUN3IVsIF7kHgz1nUfW3OiBuwEbb7HaFL53qNaaAKU
 KXl1HUNmde58InQ8rPDdd9Ulaw2ZtJtXZ2dmeX2XJBRBbu9xeQbnjJqN3w3095R9Du971HI8qXd
 4EBqiWApN3AMtOZrYdr0EWXnceOP+MZI5+h179DuLdPfSbhHXTIG5y3cuk/8KPbCGjbzIVOhfk7
 Ho7o345GSdo0KxD0Tf/MnBM/B9YBRY5vM8HXIIi95Rdhjah0WF+mcy/Rd7G/PtfInx4Qr+YuhJJ
 MsgfX/7BDiyBlAM=
X-Received: by 2002:a05:6214:8085:b0:91c:61cc:179d with SMTP id
 6a1803df08f44-91c61cc17e8mr7021656d6.14.1792951728624; 
 Sun, 25 Oct 2026 11:08:48 -0700 (PDT)
Received: from [127.0.1.1] (95-24-99-141.broadband.corbina.ru. [95.24.99.141])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91c47c50e10sm51043246d6.25.2026.10.25.11.08.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Oct 2026 11:08:48 -0700 (PDT)
From: Timur Maksimov <gessingate@gmail.com>
Date: Sun, 25 Oct 2026 21:08:26 +0300
Subject: [PATCH] hw/misc/i2c-echo: fix quick smbus transfer
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261025-i2c-echo-quick-fix-v1-1-0e93185c150b@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2MWwqAIBAArxL73YJuZdBVog/TLZegh1IE0d2TP
 mdg5oHEUThBVzwQ+ZIk25pBlwW4YNeZUXxmIEVGKyIUcsgubHic4hac5MbKt9r4ZjQ1WcjhHjn
 rf9oP7/sBGgbaZGQAAAA=
X-Change-ID: 20261022-i2c-echo-quick-fix-3d716d5b642a
To: qemu-devel@nongnu.org
Cc: Klaus Jensen <its@irrelevant.dk>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Timur Maksimov <gessingate@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792951727; l=1108;
 i=gessingate@gmail.com; s=20261022; h=from:subject:message-id;
 bh=fU9C2o+5MePoZ4VFoNXPuURh4jbqKbl0yMza4y9NmLY=;
 b=1zh5O9JA0skQKy/Q7c54jGcZaa1gGKmnBS9mn9PtLNBxrAAnoOBl/nnMFuGIxmHt3PbOJygV7
 dBHaGkZAjP7DIeq4NOikraFlgSATSVj9dpt4joPqpeDWzeRCYNcR7so
X-Developer-Key: i=gessingate@gmail.com; a=ed25519;
 pk=xF4NKIzSbKMdte17nQ66S/q9m/A2gu6GiEWc8ZnyJmo=
Received-SPF: pass client-ip=2607:f8b0:4864:20::f33;
 envelope-from=gessingate@gmail.com; helo=mail-qv1-xf33.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Don't start asynchronous transfer when no tx data is provided.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4457
Signed-off-by: Timur Maksimov <gessingate@gmail.com>
---
 hw/misc/i2c-echo.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/hw/misc/i2c-echo.c b/hw/misc/i2c-echo.c
index 54d07db6fa..c02098cb70 100644
--- a/hw/misc/i2c-echo.c
+++ b/hw/misc/i2c-echo.c
@@ -90,9 +90,11 @@ static int i2c_echo_event(I2CSlave *s, enum i2c_event event)
         break;
 
     case I2C_FINISH:
-        state->pos = 0;
-        state->state = I2C_ECHO_STATE_START_SEND;
-        i2c_bus_master(state->bus, state->bh);
+        if (state->pos > 0) {
+            state->pos = 0;
+            state->state = I2C_ECHO_STATE_START_SEND;
+            i2c_bus_master(state->bus, state->bh);
+        }
 
         trace_i2c_echo_event(DEVICE(s)->canonical_path, "I2C_FINISH");
         break;

---
base-commit: d73149283205645625bfa9fe029cfb68e4c4a9ae
change-id: 20261022-i2c-echo-quick-fix-3d716d5b642a

-- 
Timur Maksimov <gessingate@gmail.com>


