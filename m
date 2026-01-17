Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 254ECC98315
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Jan 2026 16:30:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vh9BF-0003B6-P9; Sat, 17 Jan 2026 11:29:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vh9BD-00039I-Nn
 for qemu-devel@nongnu.org; Sat, 17 Jan 2026 11:29:39 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vh9BC-0006Ba-7h
 for qemu-devel@nongnu.org; Sat, 17 Jan 2026 11:29:39 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4801c731d0aso16346805e9.1
 for <qemu-devel@nongnu.org>; Sat, 17 Jan 2026 08:29:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768667376; x=1769272176; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LxWCcW++Lxcknn8mz+ztokq5YZ0Nmxk+SbAcg0xOxLM=;
 b=OHhBRwW0Ycj63M23i9TOvEP5YRcKnCQ0D7aKpYeBwRmLVNTnLAgqUfN6jn15mvxJ4Z
 2eRKoVSPruccXGgjG3aL8XApRAifENvQty/tKvBFuPYuGvpUuM6EnPDrY0ZdoMC3C8AN
 RfANj0/rhypycszaU+C6hQSVqyDiC5Vyou4q+LGclkcBEqC/V7Wq8GT39QLNdmz4De9/
 8gn9f/XCbsXrIbR8aQMlansiMbtV8E9GZ7RF7Rhu3BNfzWIi8nMxl07XX9lZMrUPrmLw
 pJ3zsXZ2cHeCODAxhhbNiPGF04yb1Sj47Gu4mcemZX/DVLzbml/FJMQUzPT6z/2KiPlH
 cs3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768667376; x=1769272176;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LxWCcW++Lxcknn8mz+ztokq5YZ0Nmxk+SbAcg0xOxLM=;
 b=GTsimJDWfkRAobTE70IW3DtXAbi7zd9+BASFg5eCN0oWxrLtvVMfAs7TWFC0h/LfOt
 oUodGrf+JpygMV+IHY44ubAftAxluuZ1QU2FwdxaWEtWb9GaHX9eJHYKSvr5rgZlwD1T
 ctHQtkPdTXOmEzA3KKT+jqeyOilM/SoQsBgavdqksfQmVsITObim+AGtgW+9CSKo0gxp
 aWjm7a8KB2SCWhKpYRg1XfZPihplru3VZeDsWuQkPJmoPiQiYT4G4rN9ppEkuho+qGJq
 bgmp2IA7B2RBAGMbo3Z7vsXPkhV6mDeuFlZoF+ObP2cbz0ByIjuOK/egF59iQEnr9xQ/
 mZBA==
X-Gm-Message-State: AOJu0Yyo+5DsCiwfKZDMcBUOguqSiZbpQx1MnRWtwo+DK+ZA4S7nb+I2
 H1V2WugTMQwGqV0GqSINmtTIeGFsAP6YxujSNhani/cWT1w7bVYB5VHYO+sA4LNiMdwWde/01fI
 gDrydGQE=
X-Gm-Gg: AY/fxX53zf2wQWHXkEUhRxJ58oAUk7poTdVLEyl+whwlanJJSvzpL9EUdDZrDMX+JA0
 bvCYaAZ0B3N/aOc/dUWuMC99mV/E1MYIe+iJ+mm78e5k2P8ge/aijof9F3ZbkSaINDOzHSAQffq
 rZAdsV5tc5S6WmO4A8HpTPxIBLHb4a4ABLde/531DoGgveOKE/L3fV6Uc8hyu54oN+N6YyP7UDE
 DWNL/JuuasvWk8oeAPFoz8Ncbn6UO+oc/6apLpXdxm7+aiaFLzOUoVs6U9F8hZaTpMq37t61rCT
 /3yLBluBbVKyccXksjvA6hBfbQVISGSPwKSkAg64gwXeBvo4gd9us65wSDmH641fSmMnWyHix87
 6fXif3pouRqJlInHeasC9GGMNiV9Sd5a0NrrDYtPwq5PDJ8XtmD7u7DfqOLYirAvoa83YIXx5SR
 b6+iHfJ6rBU5zbfpWv5EXsWLyfxLv0aDa6EB1bxdW3HIf8pHCin2t/EH/eV9vM
X-Received: by 2002:a05:600c:1991:b0:47e:e4ff:e2ac with SMTP id
 5b1f17b1804b1-4801e356cebmr78919055e9.33.1768667376019; 
 Sat, 17 Jan 2026 08:29:36 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4801e86c197sm101328235e9.1.2026.01.17.08.29.34
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 17 Jan 2026 08:29:35 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 kvm@vger.kernel.org
Subject: [PATCH v2 1/8] target/i386: Include missing 'svm.h' header in 'sev.h'
Date: Sat, 17 Jan 2026 17:29:19 +0100
Message-ID: <20260117162926.74225-2-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260117162926.74225-1-philmd@linaro.org>
References: <20260117162926.74225-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

otarget/i386/cpu.h:2820:#include "svm.h"
target/i386/sev.h:17:#include "target/i386/svm.h"

"target/i386/sev.h" uses the vmcb_seg structure type, which
is defined in "target/i386/svm.h". Current builds succeed
because the files including "target/i386/sev.h" also include
"monitor/hmp-target.h", itself including "cpu.h" and finally
"target/i386/svm.h".

Include the latter, otherwise removing "cpu.h" from
"monitor/hmp-target.h" triggers:

  ../target/i386/sev.h:62:21: error: field has incomplete type 'struct vmcb_seg'
     62 |     struct vmcb_seg es;
        |                     ^

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/i386/sev.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/i386/sev.h b/target/i386/sev.h
index 9db1a802f6b..4358df40e48 100644
--- a/target/i386/sev.h
+++ b/target/i386/sev.h
@@ -14,6 +14,8 @@
 #ifndef I386_SEV_H
 #define I386_SEV_H
 
+#include "target/i386/svm.h"
+
 #ifndef CONFIG_USER_ONLY
 #include CONFIG_DEVICES /* CONFIG_SEV */
 #endif
-- 
2.52.0


