Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07BF7C4345F
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2024 09:04:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2opj-00067n-1M; Fri, 03 May 2024 05:03:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s2oph-00067D-4E
 for qemu-devel@nongnu.org; Fri, 03 May 2024 05:03:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s2opf-0001HJ-OG
 for qemu-devel@nongnu.org; Fri, 03 May 2024 05:03:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714727034;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=qgjfWeusw3ypjW1zwAQk121EmUzU0LKiLAl7WbBfwVQ=;
 b=P1UMllN42Yejk6IxgA2rIHFo1aa37nnJ7CE6zpk1t5mHz71OUEbm/JG8/XJiaEXk6b1Ve3
 GRVW53yi91wXwTPod7fd5c7g0NUAY+cjABGL7I2mOvxB4mCaHua+yNZtL69rrezc6CXc1i
 neK2NDk1E9Mzqzo7WM+4ro9fDchm2ek=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-297-Z3Xt5PbiP8Wii40PSaigJw-1; Fri, 03 May 2024 05:03:52 -0400
X-MC-Unique: Z3Xt5PbiP8Wii40PSaigJw-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-a524b774e39so261093466b.1
 for <qemu-devel@nongnu.org>; Fri, 03 May 2024 02:03:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714727031; x=1715331831;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qgjfWeusw3ypjW1zwAQk121EmUzU0LKiLAl7WbBfwVQ=;
 b=PZcQKtu5wmoSEpGUpZ9Hih80qMgZ3N6CRFfRLeGrXff3J/9aU92G1JvaVDTKkwd+GI
 lvAkhUX6n7ZTxlpnxGZAg6dhZySKoNOpSqow+SJXHJ4AbErzlirPTuCNjuyAKEEisr42
 JU9CeQR7QggREe1tybYAxsgvCr6wcUPSciXEelx2mMpJkN5/WP2PzXW2659uQBhRfaBP
 qscNck9Qsy3uOdVjzfKKG5jxqbse8FY/B1t0t/u2OY2TrKHTC506KTMHOJ8PPHBZ9LIw
 tFeHpoJtg+bQekr7+lBMMs8gJUz2ZHFDdhFNG8IOsXsZbCSblRnTpjf1AeukjB9dwYdS
 JLcg==
X-Gm-Message-State: AOJu0YyVN02TfotgHD2AIsOlA5+6+NjEfbjJbtaB54Cuw+az2++ZSUMy
 KQ4JtV1e4lacx/npt+I1TbzJrED6HAJV4na19huxu6c423t/Ks3CeKvMHYL2aa7ZK9J+mrNxilU
 A5AOKJKv1/acN4yItsCx4CdLX1nmuUNtci6UPeMfwspB/T3OXKzak4zfXWSf1ObtOnGuL0lUkC1
 YjM0+9usF7TqhhAnsm5XLNT4sx0iEjksGtkYY+
X-Received: by 2002:a17:907:c81:b0:a59:9ba6:5c82 with SMTP id
 gi1-20020a1709070c8100b00a599ba65c82mr118125ejc.21.1714727031134; 
 Fri, 03 May 2024 02:03:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFSrPw9S2fyhXV6XoDb/V/W1YmEEEfEoo1v4sW3670G35DBmmoILyQkIOxftWxpFwSsKkdGtw==
X-Received: by 2002:a17:907:c81:b0:a59:9ba6:5c82 with SMTP id
 gi1-20020a1709070c8100b00a599ba65c82mr118109ejc.21.1714727030567; 
 Fri, 03 May 2024 02:03:50 -0700 (PDT)
Received: from avogadro.local ([151.95.155.52])
 by smtp.gmail.com with ESMTPSA id
 t23-20020a1709064f1700b00a5544063372sm1467568eju.162.2024.05.03.02.03.49
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 May 2024 02:03:49 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] migration: do not include coroutine_int.h
Date: Fri,  3 May 2024 11:03:49 +0200
Message-ID: <20240503090349.193319-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.476,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Migration code needs no private fields of the coroutine backend.
Include the "regular" coroutine.h header.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 migration/migration.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/migration/migration.h b/migration/migration.h
index 8045e39c26f..6c612c03819 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -19,7 +19,7 @@
 #include "qapi/qapi-types-migration.h"
 #include "qapi/qmp/json-writer.h"
 #include "qemu/thread.h"
-#include "qemu/coroutine_int.h"
+#include "qemu/coroutine.h"
 #include "io/channel.h"
 #include "io/channel-buffer.h"
 #include "net/announce.h"
-- 
2.44.0


