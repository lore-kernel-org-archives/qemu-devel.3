Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2670ECFD629
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Jan 2026 13:09:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdTHl-00018a-Ri; Wed, 07 Jan 2026 08:09:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vdTHL-0000g5-V0
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 08:08:52 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vdTHK-0008PJ-LK
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 08:08:47 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-47aa03d3326so17445415e9.3
 for <qemu-devel@nongnu.org>; Wed, 07 Jan 2026 05:08:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767791324; x=1768396124; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DJoNOWWwAVi5nweAYNiEiLdsrSLisRr57TrUquxJYsM=;
 b=vgeMCXI/dUA16LTHmkgv6sm64ytGjDa4jk0bJCZrSECS4xid+h/D0CZy0S/8oswBgz
 leHb5+tU/c1YjKQ8b6Dsi/BIYnXB037Iptd0WOEY8Ff93DiL2odSM2wZu6t6yMaPwqfR
 9lZvHwCsMquHsnCjNGA0R66jMnWZP24Qo+4E/ebWVLfUI34XX2xj+wPZWfr+Ch3NOm54
 2T+MyR5bF/MNWdQXD5XzLqz5Dbup7UYhz86nD1buYcx0TR6wD5bVGZmUrhaik0zutLOX
 klzy2G1XadcIs8G3OLTOI7CYp4ZxKiFi/hdEyd4THi+zISTe048jEFqBtLSxoELDQTt7
 rAzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767791324; x=1768396124;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=DJoNOWWwAVi5nweAYNiEiLdsrSLisRr57TrUquxJYsM=;
 b=A9ezWMzkhRmKZy6fon9mAu5SgQG3T2JB74kHykV2WWJqxXn0er7lqEadait1QSVeO+
 52wgpf8NJ9vIFw1xhaCRTd34Wwaz4udysF1E3rTw2Mm3OWmByGS+BIEk5mfKd8KK2+ag
 YmtikW09yuVbMy/gitSU53KcZ+wDrGGOARGIq+YWYUEKx0aYTd/QYr4ZtAyO6wusQ1Ph
 Pde+Wqf5kEWH8dmKXfRQkbWOOcEksH+jnurNOvWzhZ08sF6+pqKcG8lPcXUOWAMsjg+u
 SjqlU6KgFrVWzsGu2ch1z+jqMLOgZ7kBgdBLM3IAJ3FCsVM/MajoWiFJiYHcodu5egxP
 yhQw==
X-Gm-Message-State: AOJu0YyOzepYAGeiOBp/Nz8pTNg8r0nW1cDjEkUegnj487FL9XAUTlmx
 wyQkIasB/eWZq3zvBUHqkq+QJ5EgHE5Ut/MDjjaLEiAiZmgbwQ2iHQqHyL0x08ZfEJW/TxVcziL
 z6/QH1Ig=
X-Gm-Gg: AY/fxX49UuX2eOurDkmubLejxJnJXTw8DePycfEhhgPabsy9rJT4rsFk4ZvDOGoxv4p
 eNyG5yD1rJQGq6TrJHc+HRbp9tE247wNVo34tV7tZG1FiSb0vHdYcRmouR6B2LM6UPIBqWRN28L
 C2qAe+PSIGjAawMW/qdXBC7Ds2m62POLEZ7a22SXk4o2dGwD3cgt8h0GlXaEIqxMV0sb4Iu67bi
 2zK/WIUAmSJ1jl1E2twRP8YmejyAzFRi+V0VgLy61gcQgrfeHPIE6QaYUAPllmpvTzMfqHWOJEl
 1Bhb5vtr7nNe74VunQR1aNZMLnlxeKCFgoCrN/Lm+NEFsdGY57aiqdkR4RY7phXQRlqymo514rF
 zDLW5N7vzW0QTvIZBpixw8JDUTjU0tI624LIBQ0jRZ41yXEgrMuWKm0XYa0h1cPkbfzDbbC8fbQ
 U4mr5Dm8QkDNX1k0NKlbkIHJxc+5lE+GP3Y9ZYeFSiGB4WKrJujRJPxXMoPWF9
X-Google-Smtp-Source: AGHT+IE4TGwzYCKv4QmKTHQNGqOy8Iy4cY8AdSoulzAm534dmQAjYumkPoFxmASgbiOKqBXNINBbpw==
X-Received: by 2002:a05:600c:444c:b0:477:7b16:5f77 with SMTP id
 5b1f17b1804b1-47d84b0b303mr27009795e9.3.1767791324526; 
 Wed, 07 Jan 2026 05:08:44 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d7f69e802sm98387165e9.8.2026.01.07.05.08.43
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 07 Jan 2026 05:08:43 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@kernel.org>,
 Thomas Huth <thuth@redhat.com>
Subject: [PATCH 05/18] target/s390x: Remove unused 'gdbstub/helpers.h' header
 in helper.c
Date: Wed,  7 Jan 2026 14:07:53 +0100
Message-ID: <20260107130807.69870-6-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260107130807.69870-1-philmd@linaro.org>
References: <20260107130807.69870-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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
---
 target/s390x/helper.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/target/s390x/helper.c b/target/s390x/helper.c
index 8d1e03f6768..a6c89ed0af3 100644
--- a/target/s390x/helper.c
+++ b/target/s390x/helper.c
@@ -21,7 +21,6 @@
 #include "qemu/osdep.h"
 #include "cpu.h"
 #include "s390x-internal.h"
-#include "gdbstub/helpers.h"
 #include "qemu/timer.h"
 #include "hw/s390x/ioinst.h"
 #include "system/hw_accel.h"
-- 
2.52.0


