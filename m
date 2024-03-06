Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9403C54E41
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Mar 2024 06:13:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhkWy-0005Y4-8H; Wed, 06 Mar 2024 01:13:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rhkWP-000537-DW
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 01:12:59 -0500
Received: from mail-oi1-x232.google.com ([2607:f8b0:4864:20::232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rhkWN-0006HH-82
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 01:12:56 -0500
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-3c1a1e1e539so1330788b6e.1
 for <qemu-devel@nongnu.org>; Tue, 05 Mar 2024 22:12:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1709705574; x=1710310374;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Zd2GK/LwiDy+x5sdYIECrLQP++QUZzK/GPm/IzIIz+I=;
 b=scCFATSRbVvZ4Wd4InZJvDpdwm9y4Y8pWrwmPpkoGR9Dy0QMd8pildrUaXSPykBjhT
 Jx39wZFd74jPL7KuG0yF6linBi3CEJxoqrMIs7+CkQJk6AKF9b5zVgD/5izFeEWG4JaE
 YVIR99r0k9zv4kupMiQQNW8m+ErZHvAtj9Rw3ANFBvmAw3sEOXHfDbBbeC4LuHCOfPQP
 rVyCyxWXLd4oQpT1NuryrSvZWzKCp2ItunuKW3HPm0+iuKfHEIKfb5gCmjNrUrZDed3K
 Ecw8RtC55itYNpr8OsVFEb3rBZ4hDZid6NR/9jjEf0FDf7oVyBSwkPG4HOlGE3I+3z9o
 YH4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709705574; x=1710310374;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Zd2GK/LwiDy+x5sdYIECrLQP++QUZzK/GPm/IzIIz+I=;
 b=WJrcCWvoWQjVFfekpTxUQtNOmndHx3U1RJOfEBUxuIjZywW1RoTH1XLxhKSTO55gjZ
 L71vNmAjwu5ccve39+d6f+UrHgf1N8uSzygB2eF1yPxvL9jlszmDvJthPh+JeCmP72Uw
 WUtkhjaKsWRjQ2K3zHrHImcFZbtCh4yuHTQ6hrWbr4TPe2zbf5i7CoRjjtQs5OjUDu6b
 ZL5MNeTrs535VqoDeTjPjmw5foR0dduBkasbXGGTBXgoAkZMIApjpgUvXfAkmq+dNdtr
 s/e4RoDR/y8YxkyfpV79lTFD+c9zqkOzKVl/qtbhyrVXg/+/1gOYPmBX8LK2uSB5fS7I
 PRmw==
X-Gm-Message-State: AOJu0Yz43Y6v+YMY7x3qq2w52Uk/dlgdBi2Tw7Vf4lQzp9pZrfM+4P5G
 0VJ3yNLkWQwNlJsRgQf4No7dpNQMNoHmxGrt41XiwHQmfnJ670yj1vwCJkAodbg=
X-Google-Smtp-Source: AGHT+IHzrKNiScXKnyD/9oOuKRZMbkjY4vBBvsWyeDl429zMwXljBOoJ+YCEKQ/gbDkfAY9zAzSW6A==
X-Received: by 2002:a54:4687:0:b0:3c1:de7c:d6eb with SMTP id
 k7-20020a544687000000b003c1de7cd6ebmr3720948oic.49.1709705573852; 
 Tue, 05 Mar 2024 22:12:53 -0800 (PST)
Received: from localhost ([157.82.206.27]) by smtp.gmail.com with UTF8SMTPSA id
 d2-20020a63bd42000000b005dc832ed816sm8880860pgp.59.2024.03.05.22.12.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 Mar 2024 22:12:53 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Wed, 06 Mar 2024 15:12:19 +0900
Subject: [PATCH v3 13/19] contrib/elf2dmp: Use lduw_le_p() to read PDB
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240306-elf2dmp-v3-13-d74e6c3da49c@daynix.com>
References: <20240306-elf2dmp-v3-0-d74e6c3da49c@daynix.com>
In-Reply-To: <20240306-elf2dmp-v3-0-d74e6c3da49c@daynix.com>
To: Viktor Prutyanov <viktor.prutyanov@phystech.edu>, 
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.12.3
Received-SPF: none client-ip=2607:f8b0:4864:20::232;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-oi1-x232.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The relevant value may be unaligned and is little-endian.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 contrib/elf2dmp/pdb.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/contrib/elf2dmp/pdb.c b/contrib/elf2dmp/pdb.c
index 1c5051425185..492aca4434c8 100644
--- a/contrib/elf2dmp/pdb.c
+++ b/contrib/elf2dmp/pdb.c
@@ -19,6 +19,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/bswap.h"
 
 #include "pdb.h"
 #include "err.h"
@@ -186,7 +187,7 @@ static bool pdb_init_symbols(struct pdb_reader *r)
 
     r->symbols = symbols;
 
-    r->segments = *(uint16_t *)((const char *)symbols + sizeof(PDB_SYMBOLS) +
+    r->segments = lduw_le_p((const char *)symbols + sizeof(PDB_SYMBOLS) +
             symbols->module_size + symbols->offset_size +
             symbols->hash_size + symbols->srcmodule_size +
             symbols->pdbimport_size + symbols->unknown2_size +

-- 
2.44.0


