Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 715E4D339AE
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2024 18:19:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5UK1-00078O-UV; Mon, 28 Oct 2024 14:18:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3c9UfZwcKCtwTCLRSPCEMMEJC.AMKOCKS-BCTCJLMLELS.MPE@flex--venture.bounces.google.com>)
 id 1t5UK0-00078G-DY
 for qemu-devel@nongnu.org; Mon, 28 Oct 2024 14:18:32 -0400
Received: from mail-yw1-x1149.google.com ([2607:f8b0:4864:20::1149])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3c9UfZwcKCtwTCLRSPCEMMEJC.AMKOCKS-BCTCJLMLELS.MPE@flex--venture.bounces.google.com>)
 id 1t5UJz-0003D4-0i
 for qemu-devel@nongnu.org; Mon, 28 Oct 2024 14:18:32 -0400
Received: by mail-yw1-x1149.google.com with SMTP id
 00721157ae682-6e31e5d1739so88055297b3.1
 for <qemu-devel@nongnu.org>; Mon, 28 Oct 2024 11:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1730139508; x=1730744308; darn=nongnu.org;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=MszgHz6U1SsbgRCIInP3e0iz2h3jiNjZDulrVnstPC4=;
 b=oPxlFh2jZQCbWupdWmHB/bUWqzDhSamOptRUp5r47vAzOqr4koEahIEI/pFUhUuHY+
 Mz8m5XzCl1z1CImE6JIuxcWR5zp/CTG9Bp5ajFbvbZf6+KLgFv4a2vQ/IoIHshJLz3Ao
 02kV14dLCYkz1Expzfr8+mLUDlajikd6DkayAg75ONn19jAh0FDkieI9TVy5/lDfxTkT
 tplODvvPKLHi6kwSTMkglQWKPQMC6OG6T5YnmNLw1sY85dUX+gwNKGdUp/aU/WYCyXDA
 89/eEAFrmt5hKWZH79cQrEOja4VA1k36rKoZeXDbLS/b11V8tUVJvYSemiKDErZ4lpzx
 X4+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730139508; x=1730744308;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MszgHz6U1SsbgRCIInP3e0iz2h3jiNjZDulrVnstPC4=;
 b=Nqi9Qq6sbqnfmGm717V+f6bsEFSD/joJ3GHUy+2dWTAxxuDvq6WzSfea+J7mbrTemc
 Mu3rKTb8wzFfoh8gRlg8RntP7T52JUxc27Ul+q8WP6O9S0liXY4wPze+LoSdW3Oa05uR
 XzRZ5+BjmkKo8AeduSCpDl4bQy/GYUzlnnXcVbTBxatyjvxa78hUs2hVrjoBUPLwPgzr
 AMnDJrrntFl9F2ycKtEEUiI+dUY/C0pkuBuSjW7/rgqIQuTjkM5Q61b1pj0ZreRs2ojg
 eEoLQ6JFlbhCqu9rh1Zs05efWP2jlp3wy5jbCGJuN4tSHa5jU1fZVgTWIDyX0f3OF1eX
 1enA==
X-Gm-Message-State: AOJu0YyfaS8+LH1OMLeVUNf5kJ7oVIE0B4S8MjCOr7stcS2RFMmUMOkY
 R4geMvNuyYH3htXlMHtRuaM+Lfgi88SFW+VvraoZyJ9JRpmqlixRubWmRbKDXleQ7R+vRll6dmH
 I6qf5cw==
X-Google-Smtp-Source: AGHT+IGQGxQkNCw7yU7MN3BpCjUOHTxQ95PoAS0giKuSlE5KEATCtivulQSVcrskDdUyvO400xcVgWyl8MaD
X-Received: from venture.c.googlers.com
 ([fda3:e722:ac3:cc00:c2:1635:ac12:d1ad])
 (user=venture job=sendgmr) by 2002:a05:690c:3512:b0:6db:afa4:75d3 with SMTP
 id 00721157ae682-6e9d8ad1e98mr7866427b3.3.1730139507659; Mon, 28 Oct 2024
 11:18:27 -0700 (PDT)
Date: Mon, 28 Oct 2024 18:18:21 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Message-ID: <20241028181821.1440988-1-venture@google.com>
Subject: [PATCH] linux-user: Add missing mmap include
From: Patrick Leis <venture@google.com>
To: laurent@vivier.eu, peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, Peter Foley <pefoley@google.com>, 
 Patrick Leis <venture@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1149;
 envelope-from=3c9UfZwcKCtwTCLRSPCEMMEJC.AMKOCKS-BCTCJLMLELS.MPE@flex--venture.bounces.google.com;
 helo=mail-yw1-x1149.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
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

From: Peter Foley <pefoley@google.com>

error: use of undeclared identifier 'MAP_FIXED_NOREPLACE'

Signed-off-by: Patrick Leis <venture@google.com>
Signed-off-by: Peter Foley <pefoley@google.com>
---
 linux-user/user-mmap.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/linux-user/user-mmap.h b/linux-user/user-mmap.h
index b94bcdcf83..de769f9253 100644
--- a/linux-user/user-mmap.h
+++ b/linux-user/user-mmap.h
@@ -18,6 +18,8 @@
 #ifndef LINUX_USER_USER_MMAP_H
 #define LINUX_USER_USER_MMAP_H
 
+#include "linux/mman.h"
+
 /*
  * Guest parameters for the ADDR_COMPAT_LAYOUT personality
  * (at present this is the only layout supported by QEMU).
-- 
2.47.0.163.g1226f6d8fa-goog


