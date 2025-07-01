Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61B4CC83038
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 14:41:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWcA4-0005AL-Px; Tue, 01 Jul 2025 10:40:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uWcA0-000567-Pm
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 10:40:36 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uWc9x-0006o6-Kd
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 10:40:36 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-450cf0120cdso34552275e9.2
 for <qemu-devel@nongnu.org>; Tue, 01 Jul 2025 07:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751380826; x=1751985626; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4fPb3mcKHQMn+mt9R0xeKlU7lt/6avmr2iZZUVi63QQ=;
 b=iW7+ynYnO9WltRh1VJDQdIy4WERJwWmMIv/f5JBzmYDbKZAI9JZ0nbiuFA76nhrZda
 PGyNjkpRoLaUuJsqyRxE0/ZHk4l23B2F0KCG+6UiIUkiEPWz1+7VOm4lv1ZSEC1Sn7i0
 6upEF1K0AUWDNqiK+BGOY/AEorq26siSxlrBPnabyFK+y/Zi3XcPd75KjEFAH68MoN5t
 wJ+VLTRJ0ulK3gQ8/mfx3qosANxSGQLWcLsjSk/26XEg6APEiYEYHHfwtuAnfyujyxtA
 +9b2ZlRd3PQyfja+rgxlgDlhzCJe/aSqEseduEvPnCfi6xLPKXgRMcRc09YqsDhuhNfv
 PHDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751380826; x=1751985626;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4fPb3mcKHQMn+mt9R0xeKlU7lt/6avmr2iZZUVi63QQ=;
 b=aoiawGX6BGagQe7YhciJ0YuQqXqsVgdQ4WeyXEWWQy3fZcBANgFDwQyhuyxWHuDppk
 7TbkPnjoeXkAS9yhGEhAVurL45OYQPO8HH3f3AmerO2xb/PHOK/FkBVTXQ0Sa0WWxaBk
 //HVcz8SAfadqPN/8GwCvnqgJufKQqvqGckpCz99J9p2xhvDsvWOJWEe0ZWTzA8VoTQY
 eZNtoBoSlrWBpoj57U9HgV511U9konJsc+6eLPct6g1VOk1KG5ldCkerx3D03Ht+Einq
 mVhzCl+2Y+h8wkIjeuW2gSVK05JQsra3h2ATCZWmucizEr9h/OxUobnzyVZjWGTIxCGG
 9Vnw==
X-Gm-Message-State: AOJu0YwVp5IRyvkjTKzJYmswKg3peoed+BuzeMTgpWN0UruVhiWTWNPp
 whoelXTQJSfpilxxY7vJCMcagFZne+HrXWkR9yIBsTqOccWejk2DxmfPcVWezhx/FSdY1/42b+j
 4a9GE
X-Gm-Gg: ASbGncsEcCw1CApwiWdGgzUy7LIsUcZpzAejPLVu6C5pTU8LnNOspLeoOIPPhldkydB
 1g22M8FG0tK5unl+sNSpSoeG5dpsZEbkqK7r9T2PdbOewZ8Ozbta0bOfsSktpOZCiDVEkRIWLib
 68B1B1RtJPnZL/aMmYhZDDZfqlnBTdZolujzJQ3VramNzsvOZ2demkh0TTx25p8BAq2MRqBJw5D
 Vr5pYEAk0KqvEljGHf7bikJa4Vk8DOlx1Vhy0xNeXueTghU5Pzh2g5PoLNyUBByzTnK/74+M7gE
 hLb+Cvxg8RbSNBnRnpngQeP8aNKqvHyWv3ItI7Fj71Nr3yRhcn58Y6ueZ17Azb0Q8AylQgEAl/o
 /NU1vCDJkGR+Vf49DCVb3WxggU9lS2p+iSMJw
X-Google-Smtp-Source: AGHT+IGztxCRMG91WNgylMTXT82QO8ddZ5iWWoLA32uk6jnVtN1wqK9LqLYoaPwxm7vuVSzKiuKajA==
X-Received: by 2002:a05:600c:1552:b0:450:d61f:dd45 with SMTP id
 5b1f17b1804b1-453a7fa138dmr45666325e9.4.1751380826236; 
 Tue, 01 Jul 2025 07:40:26 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4538a406489sm170999455e9.27.2025.07.01.07.40.24
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 01 Jul 2025 07:40:25 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Julian Armistead <julian.armistead@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 01/68] system/runstate: Document
 qemu_add_vm_change_state_handler()
Date: Tue,  1 Jul 2025 16:39:09 +0200
Message-ID: <20250701144017.43487-2-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250701144017.43487-1-philmd@linaro.org>
References: <20250701144017.43487-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/system/runstate.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/system/runstate.h b/include/system/runstate.h
index fdd5c4a5172..b6e8d6beab7 100644
--- a/include/system/runstate.h
+++ b/include/system/runstate.h
@@ -14,6 +14,16 @@ void runstate_replay_enable(void);
 typedef void VMChangeStateHandler(void *opaque, bool running, RunState state);
 typedef int VMChangeStateHandlerWithRet(void *opaque, bool running, RunState state);
 
+/**
+ * qemu_add_vm_change_state_handler:
+ * @cb: the callback to invoke
+ * @opaque: user data passed to the callback
+ *
+ * Register a callback function that is invoked when the vm starts or stops
+ * running.
+ *
+ * Returns: an entry to be freed using qemu_del_vm_change_state_handler()
+ */
 VMChangeStateEntry *qemu_add_vm_change_state_handler(VMChangeStateHandler *cb,
                                                      void *opaque);
 VMChangeStateEntry *qemu_add_vm_change_state_handler_prio(
-- 
2.49.0


