Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA1A2C25B7A
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2024 10:49:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9jWj-0000Qu-Ic; Wed, 22 May 2024 06:48:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1s9jWf-0000Q6-S4
 for qemu-devel@nongnu.org; Wed, 22 May 2024 06:48:53 -0400
Received: from mail-oa1-x2d.google.com ([2001:4860:4864:20::2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1s9jWd-0002le-V7
 for qemu-devel@nongnu.org; Wed, 22 May 2024 06:48:53 -0400
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-23f9d07829bso2580885fac.3
 for <qemu-devel@nongnu.org>; Wed, 22 May 2024 03:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1716374930; x=1716979730;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=CwpNU0IOG2gR/Zc+cT2zm9xVHtaU1yJX2qDLOGZQyH4=;
 b=bvU2muSuSiBfvEEbPrKXCVK2tiQdF1FRSGQ1GmDrZawgSynPRP1G9vgTsGREbv/4Om
 R5rH1LZ1RtAJ/wIvOW3KgNKElwLvamwjNTB19ePNwQKggJllH/B8uwoJfTst9pUghpXO
 gZH2kOYfc2142ac2aY3yL56VrgRo9tKXtGQHBud4ZE5Cm812t/suSPbUsMdEQaw/MwCq
 BWv3/+ZPcaNCg1Hh9T5PfVa43D43edw8tIfKBSuQEDvN/DVWaYVh0/88K36sAiLmUgvx
 ztU3RkColKMaF1fxS7+tO58GySnPVF8tLnBAvAI7u7Q3JLwHZSsH5MKo5XnRGyujscAl
 hCdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716374930; x=1716979730;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CwpNU0IOG2gR/Zc+cT2zm9xVHtaU1yJX2qDLOGZQyH4=;
 b=Y9o1pEUpMbtJ8f2t7rTP2+/5IPIRPbiDavXP+gnqcddzsKbXmcs8/DURYvafx1pP0F
 U8xyRFsqxc2bZ3oNCSEseAIAFoJ0bnrklHXdjxA0CyYOfcIbngDZm4LsnnVZioCpZ+z4
 hIV9SFk8w9F/f/eTXu1kn2hMgBj0Lg9V7B430NmFwQUWpGMK+Grx9lTUmJ9uMzDcKw5Y
 jWMI/2YGuiLAAZjc3zVDBZb0fkCkvu0TgJ6HifnKdBPwVwvdN0yZwlhfeXzt3i4BJUwj
 u+A+ZQlw7CQe2Z94Qy4hDZ2abQWPaMxkfypk7jMJmwYjIdzlTgkS4Gb0XVXACqvlHC+5
 pY0Q==
X-Gm-Message-State: AOJu0Yx8vgaxsMuCZ0+vwFbK4/Zf3VC4c+sNScHAcxghIzDfSCM+T4RM
 Ll16vi48Ro9H/VQQKcIrbnJNbVpTkTvJ01+9Ntxh9zzwr7ctajL4TNBrcbDCkYg=
X-Google-Smtp-Source: AGHT+IE8UFIJdykobh8QqUszSeIPn4HDpPAWe+UJfgwwqU/dw3STvADjez3vQtZPEktAjqZcYnYTeA==
X-Received: by 2002:a05:6870:6113:b0:24c:553d:7ac4 with SMTP id
 586e51a60fabf-24c686fa93emr1751595fac.0.1716374930528; 
 Wed, 22 May 2024 03:48:50 -0700 (PDT)
Received: from localhost ([157.82.204.135])
 by smtp.gmail.com with UTF8SMTPSA id
 d2e1a72fcca58-6f4d2afa7b5sm22120756b3a.163.2024.05.22.03.48.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 May 2024 03:48:50 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Wed, 22 May 2024 19:48:36 +0900
Subject: [PATCH v3 1/3] qemu-keymap: Free xkb allocations
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240522-xkb-v3-1-c429de860fa1@daynix.com>
References: <20240522-xkb-v3-0-c429de860fa1@daynix.com>
In-Reply-To: <20240522-xkb-v3-0-c429de860fa1@daynix.com>
To: Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Wainer dos Santos Moschetta <wainersm@redhat.com>, 
 Beraldo Leal <bleal@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Laurent Vivier <lvivier@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>, 
 Laurent Vivier <laurent@vivier.eu>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-01a33
Received-SPF: none client-ip=2001:4860:4864:20::2d;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-oa1-x2d.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

This fixes LeakSanitizer complaints with xkbcommon 1.6.0.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 qemu-keymap.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/qemu-keymap.c b/qemu-keymap.c
index 8c80f7a4ed65..7a9f38cf9863 100644
--- a/qemu-keymap.c
+++ b/qemu-keymap.c
@@ -237,6 +237,9 @@ int main(int argc, char *argv[])
     xkb_state_unref(state);
     state = NULL;
 
+    xkb_keymap_unref(map);
+    xkb_context_unref(ctx);
+
     /* add quirks */
     fprintf(outfile,
             "\n"

-- 
2.45.1


