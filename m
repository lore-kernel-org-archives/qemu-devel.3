Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7745CC54764
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 08:56:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcLse-0000bC-C9; Tue, 20 Feb 2024 03:53:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1rcLsb-0000VR-Kc
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 03:53:33 -0500
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1rcLsX-0008F8-9d
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 03:53:33 -0500
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-a3cc2f9621aso548708166b.1
 for <qemu-devel@nongnu.org>; Tue, 20 Feb 2024 00:53:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708419207; x=1709024007; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iVGSDDuh83CPH0ZtXdDBtmjkmYoWaBhCuelQOBGBJXM=;
 b=r4brvH6HJ/GfZN3mMe2U2ZhGV8FSuZPNeHNWOqVQLi873SInP4UmJ3gqWRKK/iv3NC
 oubYY67Pmd9kPcaOYUbVJMW8xbEHTmn5Id/OUISQWWD3YLr/oe22ryWA7ReJMn2ItLIR
 HCR3piTowuMkSqTz1yD4pi3RiD2KXMF6Vm52/ROUSNrSvhNvSCRUa/Y6pM7HpYx+Pwtz
 hhAjzqBdhecIm5agHgpIWBi5+fixR4uEmcCSKQjVVZM71mg2YqRy2ai/5gWRc3CTXf4X
 hUaInymicWdSQ9XJCpyw3xuWRFJCrFz5wBIxqWrw2idDGiZlUKiGVhIlwrn8M60ZLtkm
 qkVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708419207; x=1709024007;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iVGSDDuh83CPH0ZtXdDBtmjkmYoWaBhCuelQOBGBJXM=;
 b=AFZo4kXxfg8SHN8bf8VxGAo2NvnJmmp5RvcHrgfPAkc4GGr6sw/XOwD30Wm4zvFUSV
 9dKej+rBlgh0U6qtyK0U63CCY+QCUBY0iFXJfh56+lSM4CG+0+H9kt7vdS4TF8jWV+Jw
 RBapziRli60PSwvnKKpugC6JYJJb2jLw7M06YtbwviBc4zcMGNXf1ZLOj42JGNjus3IG
 RCSRF27Eb2bBus+Ni6m+e7/LwUybr/Rn8j6QxNmcS/MOX3/QJvzMx/SgJXVSqYrm2lM3
 j+OhsCC0gU4s6rqhwLAR2dTGgNnhvSrDCUDE4WqAVi7r7KViS1xpGBmGn+jPOQ4YRhIr
 NY7A==
X-Gm-Message-State: AOJu0YzEP04VrRBspVnSG7MVWfbBW9JjkhWRgISy9vbfKJEMVoY8RmAP
 GJatVhUcZ8f56yhopOhEk86WOvoMCilyXrcAXAEVxZ9iUCpa0X8SvgLlU5hRrUpFpZdBohj6b0U
 FC4Y=
X-Google-Smtp-Source: AGHT+IHE6LTWqTn4TCP9TiKtgZGQ3JJ/Tt0dG5+iRdrHh49z7Am7MlQk6hJZ4pYios2ZDJ/NaMIrvw==
X-Received: by 2002:a17:906:2785:b0:a3e:b523:6c8 with SMTP id
 j5-20020a170906278500b00a3eb52306c8mr2124297ejc.67.1708419206913; 
 Tue, 20 Feb 2024 00:53:26 -0800 (PST)
Received: from localhost.localdomain (adsl-245.37.6.163.tellas.gr.
 [37.6.163.245]) by smtp.gmail.com with ESMTPSA id
 cu3-20020a170906ba8300b00a3d014fa12esm3747876ejd.196.2024.02.20.00.53.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Feb 2024 00:53:26 -0800 (PST)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-trivial@nongnu.org
Cc: qemu-devel@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH v1 15/21] qapi/ui: correct typos
Date: Tue, 20 Feb 2024 10:52:22 +0200
Message-Id: <2b12236539211bfa887364cf7b621586addbb42e.1708419115.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1708419115.git.manos.pitsidianakis@linaro.org>
References: <cover.1708419115.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ej1-x629.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Correct typos automatically found with the `typos` tool
<https://crates.io/crates/typos>

Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 qapi/ui.json | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/qapi/ui.json b/qapi/ui.json
index b6d7e142b7..1448eaca73 100644
--- a/qapi/ui.json
+++ b/qapi/ui.json
@@ -63,7 +63,7 @@
 ##
 # @SetPasswordOptionsVnc:
 #
-# Options for set_password specific to the VNC procotol.
+# Options for set_password specific to the VNC protocol.
 #
 # @display: The id of the display where the password should be
 #     changed.  Defaults to the first.
@@ -125,7 +125,7 @@
 ##
 # @ExpirePasswordOptionsVnc:
 #
-# Options for expire_password specific to the VNC procotol.
+# Options for expire_password specific to the VNC protocol.
 #
 # @display: The id of the display where the expiration should be
 #     changed.  Defaults to the first.
-- 
γαῖα πυρί μιχθήτω


