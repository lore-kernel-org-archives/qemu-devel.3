Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 414E3606A31E
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 11:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=EwhLAyO3
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLf8V-0005lE-E0; Tue, 27 Oct 2026 07:14:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xLf84-000523-78
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 07:14:08 -0400
Received: from mail-dl1-x1232.google.com ([2607:f8b0:4864:20::1232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xLf81-00033E-Gt
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 07:14:07 -0400
Received: by mail-dl1-x1232.google.com with SMTP id
 a92af1059eb24-14394530ec6so4803415c88.1
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 04:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1793099643; x=1793704443; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=WDcCR4dQxzUHXQ42p7u+Sy2JMMuPbZVHmLDwh+Cj3so=;
 b=EwhLAyO3Pg6fwwBtHKHZW9by2j4qHR7UnIy2iZ2jMJ1dPZ4BzSuDk2dVf9++5IutIp
 Z8Dlk8RQatPlEKkoIO4pMUfLx4a4rAAAjj2sh1g/APFGZ4l/qhjIe9iH6iz/kbzv9nVc
 LHR2vL2wNWgNaLQ3KjaapAff5FSgK4q+XIUy6nnE3vNM7yzdwBQqePdeonl4YpEKiOYQ
 A84wQSxNOMnPH+p8swE/S+mr/iBtVsBnJbHAZUMt/2t9ro1i1YuNQqTRI6o+Tp75XViW
 VLQLUr+NoRSAt0dFTrBwpWIrJRSDYr34RnqbpkgQJ+JVh/TrCfU3hmgBFJ9ezJfc5AWk
 Zy4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793099643; x=1793704443;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=WDcCR4dQxzUHXQ42p7u+Sy2JMMuPbZVHmLDwh+Cj3so=;
 b=t2JoFAfCXmk8mjWQ2rPzejE1R3cKJgkz13DfioidrTLc8K6yXs2OnoNd9kz7IkUTbS
 D7Zc0hmSn6yh4zw0G+7iPiC6ypDWr424sc3RNdPUUiBC06em4Z4sX5cjU0tNbp44EQ0W
 yut5Np/mgumtkh7JMuK3Wnk2sKazskDQJCPc/IbGT8OUwxheEAFUBUPaJT//Pq2S1kVF
 5MkHKlNiLmshgCAty47zQEFbUU5CI3F2e7l0Xgt4csomK0bfq/npQZQyzTUsTGU09AFR
 KR5Y+c9mxPPLJhoH4ulGxJ5+tMq/NAeDDneQ5+1ZPR8y3ruiupenjSUGr3gnzIsYAFtP
 4F0A==
X-Gm-Message-State: AFq9FYLfn2duIoHIGXbmUl8CVl6S4euF2Px0BzuU+qHjiS2xXGJxjMga
 RsupUqDbcT2FwQ1nZt4oxrdiA2Cf00jDOhLfLxjs89q+VDGV0qnWu0YQkayU7e23
X-Gm-Gg: AYBFou3eC7HBXsNbB6a1v2VkoYXv/QOiKg41nG7f0egpfSZ0BfLRL954H4/gL4dxUxJ
 7/KO9/3rWqa/Ey7Ezu4yyT5agy0fYn3QvGQkocXALa8HZtZrePykwFubEp6mFMfzRmC7d9DZmM5
 XBglHhZCEBJCfo0J+vpj1ubcu7vwP23SkWuGCGX7bovm/i+OVeswDTjVzsgOH8CZxLh1m9eYnpb
 Viq4eBxT9s8xQUeAPR+SAO8Vz9CRU+K3X8ATOpgpiVp+lEpzV2VAxxFkIdtob1jHEcGZtoAMCre
 rF16fP1qfghfBEK1Bol/ItAdn9Bk5iQDtQbIctJQk3WK5dK4PR9QfoJx7E86prw1LLbXdRC95f1
 Yn3Y17jcxMM5c/nEwUqYOQrdlJeOXEp/uQaAjpSXJSEFn9BKd1pgVvp6V43Fnui0Ts/aCm5mdXD
 3q99Z5dlJ9uKIBvNexPa9j64g2qkGc4iFkicLt2oqjPyjrA09Bnksuow4emFCNtY69tHR6otOIr
 sfwk4skzxkP21AY25Y9xDBncawqaQ7ZoiO4QgTocchnK5QcBV1Wgr+n+kgBT7+O/6ErfvTK4Wk2
 Of30/w2kHhLH
X-Received: by 2002:a05:7022:3f04:b0:196:c1ca:3489 with SMTP id
 a92af1059eb24-1991b420bf9mr13342737c88.0.1793099643009; 
 Tue, 27 Oct 2026 04:14:03 -0700 (PDT)
Received: from WIN-BH9M8FJACR9 ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 a92af1059eb24-198a0f83cedsm40453042c88.13.2026.10.27.04.13.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 04:14:02 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Song Gao <17746591750@163.com>, Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-riscv@nongnu.org, Philippe Mathieu-Daude <philmd@mailo.com>,
 Chao Liu <chao.liu@processmission.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Stafford Horne <shorne@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Eric Blake <eblake@redhat.com>, Weiwei Li <liwei1518@gmail.com>,
 Laurent Vivier <lvivier@redhat.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>, Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH v4 15/17] hw/xtensa/virt: use unique QOM name
Date: Tue, 27 Oct 2026 19:12:13 +0800
Message-ID: <20261027111216.392-16-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.52.0.windows.1
In-Reply-To: <20261027111216.392-1-luoyonggang@gmail.com>
References: <20261027111216.392-1-luoyonggang@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1232;
 envelope-from=luoyonggang@gmail.com; helo=mail-dl1-x1232.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Register the board as xtensa-virt when target_heterogeneous() is
true, and as virt otherwise. Keep the -M / help / migration name as
virt via machine_class_set_name().

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
---
 hw/xtensa/virt.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/hw/xtensa/virt.c b/hw/xtensa/virt.c
index 638007f6d32..4ddb6b54739 100644
--- a/hw/xtensa/virt.c
+++ b/hw/xtensa/virt.c
@@ -26,6 +26,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/target-info.h"
 #include "qapi/error.h"
 #include "system/reset.h"
 #include "hw/core/boards.h"
@@ -119,6 +120,7 @@ static void xtensa_virt_machine_class_init(ObjectClass *oc, const void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
     mc->desc = "virt machine (" XTENSA_DEFAULT_CPU_MODEL ")";
+    machine_class_set_name(mc, "virt");
     mc->init = xtensa_virt_init;
     mc->max_cpus = 32;
     mc->default_cpu_type = XTENSA_DEFAULT_CPU_TYPE;
@@ -128,7 +130,9 @@ static void xtensa_virt_machine_class_init(ObjectClass *oc, const void *data)
 static void xtensa_virt_machine_register_types(void)
 {
     const TypeInfo xtensa_virt_machine_typeinfo = {
-        .name          = MACHINE_TYPE_NAME("virt"),
+        .name          = target_heterogeneous() ?
+                         MACHINE_TYPE_NAME("xtensa-virt") :
+                         MACHINE_TYPE_NAME("virt"),
         .parent        = TYPE_MACHINE,
         .class_init    = xtensa_virt_machine_class_init,
         .instance_size = sizeof(MachineState),
-- 
2.52.0.windows.1


