Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA611CCF9E0
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 06:11:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDcvd-0001a7-S8; Tue, 28 Oct 2025 02:11:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDcvO-0001Z7-7h
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 02:11:21 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDcvL-0006Wa-N6
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 02:11:17 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-475dc0ed8aeso27220245e9.2
 for <qemu-devel@nongnu.org>; Mon, 27 Oct 2025 23:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761631873; x=1762236673; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a2BKEZLhbi3WNQsizJN4liaZ3hgh6rI0ev3mSwYFKSc=;
 b=PvdduQJ2LUZuSjQpnaXMOQlBOd+cOj7ohImlpYF2sUY72T70WBqYrs4aYYfLGR9Y5+
 lvVeZhoyuaKcztxbuS2jXFkmQnNe//0NatJ2EyzO41eUAb9FyfV5Gk1DgJdvBK3prUx7
 IT7wce6nIMPuDmGeAWY1Do9x8c3bO7ykhD/wKGFJrE4zQZ1W70difmhQuk3komHTGtgs
 CdyWHPhyl/5UVt+3ZDlZLFjfIw9dVNRpzcdp0+JcaKCkMe7lNXCHeBj7LrFKv1iuELme
 BzYTZZQm3eFBOfQFNlPzhbmNugYrtW+kFR4dSGo9hmcEbLn973qNY8igePm/aQBSq1li
 7VUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761631873; x=1762236673;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=a2BKEZLhbi3WNQsizJN4liaZ3hgh6rI0ev3mSwYFKSc=;
 b=YmLXe03K/d5nHav7O/WjILDlQXbrJjhmnA0BK3KyZalTFSB6uqZO7sNq+RURlLA0pu
 yxfNw4PEItLN5tSHeWxgPxs3JYfRd7uDfYNIaP0ZY5VtrHSWFnJBAzd0la382uEmmOq8
 hVeJyExH4sjC3d4SwJ1vOwnMS/JZMd+XHHygvKTf1t0jGQZklDRapFA1YzVXCwPBMv9o
 MarRIvm6fgNKFLgr+Xp2PhfOqjLx6E97jVI3gIlavdSavuthTFJ73OX6seqdoh047MJK
 ByH9rojHFA9WicmDkcWJN8bC9WfBk1oNx3XcKteVAkWIZP+3rO6LGQupH1JYmVlkz/Kf
 Sqqw==
X-Gm-Message-State: AOJu0YyHp3uAnHX09SYBmkJP6vWmvnpfce7ralSsK+iTf7xP8mYDXeQP
 qxY2f3M7e4csqnmrufbZxxhvEYUmq7lEL1fUyIjL4t7Vw9AoS7iq35qCtp17kRpKM0xB9i4vHsn
 TyxRWMtk=
X-Gm-Gg: ASbGncvn9infA0ZHlgEoZzvHOJpnPZ/kycchQjUN/lhegtFtYT4G25+zX0Hqzi9AqKp
 x/QLoETI+UKb9hjaMxJD8M4erJffBd6F643L5elsa4vdQmKGJ8hXQEvBgd6waSPCeWHtfBS1I0Z
 //VrGarSJLMhKrTd0d25huulGAMdIcckqhzcste1d6YywX7UmNkySzfhWWcfr7GS5KoPJjlyQoq
 fUoIuAag8yfn4gi2qptgN6cF3COR6DlMj5QOyb2JuzQxZzMmsB+jHGCH4fq5hFhujjMdlMDhN/4
 fS5vkVS62vjEYUzXrbLlHJFPc4lAdwCxE7l0njsyPue8FJkWUsP7se1+lSWs2/3a4v5g7FAYduH
 7uJApALQjzawwoMuCOJUeTII+FbIUQmKy1s/rGI9zSIk/ceb+3CqSMEbUy01te04XGazVyibikl
 F2WYty0DvADTQ6H/XLxe1tjAhvBLsqp4VrdrBSaOWQwwDT0GwSHn50vaE=
X-Google-Smtp-Source: AGHT+IExfjkQaxr86iBkvG/IR0LuA6uXH+fNVb52V1qaoTri8EOO/aRFxqESRaWakazlUlf9jVVwpA==
X-Received: by 2002:a05:6000:1ac7:b0:427:45f:ee1a with SMTP id
 ffacd0b85a97d-429a7e559c3mr1836470f8f.25.1761631873123; 
 Mon, 27 Oct 2025 23:11:13 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429952d4494sm18399341f8f.21.2025.10.27.23.11.11
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 27 Oct 2025 23:11:12 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mads Ynddal <mads@ynddal.dk>, Cameron Esfahani <dirty@apple.com>,
 qemu-arm@nongnu.org, Roman Bolshakov <rbolshakov@ddn.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Peter Collingbourne <pcc@google.com>,
 Peter Maydell <peter.maydell@linaro.org>, Alexander Graf <agraf@csgraf.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 40/59] accel/hvf: Remove mac_slots
Date: Tue, 28 Oct 2025 06:42:16 +0100
Message-ID: <20251028054238.14949-41-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251028054238.14949-1-philmd@linaro.org>
References: <20251028054238.14949-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

This data structure is no longer used.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 accel/hvf/hvf-all.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/accel/hvf/hvf-all.c b/accel/hvf/hvf-all.c
index 97b367bd788..53efd54b97a 100644
--- a/accel/hvf/hvf-all.c
+++ b/accel/hvf/hvf-all.c
@@ -22,15 +22,6 @@
 
 bool hvf_allowed;
 
-struct mac_slot {
-    int present;
-    uint64_t size;
-    uint64_t gpa_start;
-    uint64_t gva;
-};
-
-struct mac_slot mac_slots[32];
-
 const char *hvf_return_string(hv_return_t ret)
 {
     switch (ret) {
-- 
2.51.0


