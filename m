Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D0E3C369DC
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 21:07:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAb7b-0003Ny-4x; Thu, 01 May 2025 17:07:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uAb7J-0002hA-3e
 for qemu-devel@nongnu.org; Thu, 01 May 2025 17:06:49 -0400
Received: from mail-il1-x12a.google.com ([2607:f8b0:4864:20::12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uAb7H-0006kk-K2
 for qemu-devel@nongnu.org; Thu, 01 May 2025 17:06:48 -0400
Received: by mail-il1-x12a.google.com with SMTP id
 e9e14a558f8ab-3d7f111e9e1so15688715ab.1
 for <qemu-devel@nongnu.org>; Thu, 01 May 2025 14:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746133606; x=1746738406; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pT5M0lz4iXxP6eQat70i7GTGsl8o8UafTe6D3H+LKG8=;
 b=Sua5MDqv7+6kbyAqjpct4jTdLQdqHqv0IN5nm61nsYJ5oko+xCpP0FaSGXQrt4x2kz
 HPMfOt6CDVHsFVaekaf3aGxjsemz9+90wqyYKOBZMJbeko1U6JCQ1ncv5zwyNsR+7uCT
 lUOsJQtpHnneU9UCRnozttz0HTE3s5d8HLdzUfZFP7332y6qS5xPB78DRT3z5BuYDXPg
 zHezqZRJ32bbNvsTmy/NTI7jbu3e1dkPoPYloJiiMTwzm2TXD9ogoBtHOJ1GeDoXEQg2
 4OMCSKuKVKXIyG27Q42OaWrmUr5UWj+/1sgOFwvE9JDJYjnNn/TWujAWjDoqKE+kEa2H
 WTng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746133606; x=1746738406;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pT5M0lz4iXxP6eQat70i7GTGsl8o8UafTe6D3H+LKG8=;
 b=k3fDjbHxesh7wskVBgObOmDgFDUZDMht8hTqXhbgQG85tPCW4clkUYbgnssJMD80E7
 O/WwKDiEpzaop79aqbB5qtG/OZHfqKcV0qi6KIpt2oJYDYGB8ITOzoX+FqXxc4HN31Np
 2LSm2ngE9kUUZCBPt9E3rtSWI6u3qnc8A5aDQetl/MpIp4GHEaL0s/ZUMqrI2BE3CAe9
 c/MLMVQ5U2quTjCCmLyhQkbKfH5W/SmIwWBBOh6lVHUYSXnqUUdC2hTX5N6mtEuPouzz
 FKibBVkvyKiuu1Pcfe/k0/UyzYSs3Qd1WmZjeTTOU11A/8F5ERy5kxSXlPof20wInEcl
 OPXA==
X-Gm-Message-State: AOJu0Yy139C/nAAjJFYA5pjO5tp8YQO4fHhmaX8W/+522xWT4R2Fsiia
 MYK2/66j/kAAs4yh1mVVAR1bkUBsx1Xg19vKmQ50QqU0rAAP+QV1yKMm4r2qPEb1Vfv/mo/DEvk
 b
X-Gm-Gg: ASbGnct3wdKD6W9/48b+0xLet8fybJnsntJclyZedANecZ4nQ3W6s7Sgt95A8ybzms0
 /wneDWZsBc/TnIVbEskPoAFYjQiyU74yTzJlBD/hta9VWkUO1m3rH8sDVS94GL0XswLag9NWSN0
 WQ1ADmyfXanyelwkbr4dErP96ZjosczXKA3ctrTIeuvOt5J3v4UHkMY5ezUI7ahyS+pcPpotfrL
 hxAmiM470Gntk+VwOSEI4y9KA6l+flfSUSuacFVTtz3CdgeVUBrKLmffRrWDHJbCMu0KbjnOrmv
 uf065jw6suMvw3czj0cNnGaSCYhCAGA3l47RuKbKc32ga+cGSQ8zcKkbpMzNMElzBzdkjJl8xPN
 u0Lx59pS3sY3Qkr4=
X-Google-Smtp-Source: AGHT+IFyZ7FYEZ0ZSdsw26U2Xktrm0Lfl9GBgVwXW2Vqi07mLib4x0Rm3VfQIgDk4i4z9prW/R11gw==
X-Received: by 2002:a05:6e02:3784:b0:3d8:21ae:d9c with SMTP id
 e9e14a558f8ab-3d97c154012mr5765095ab.5.1746133606161; 
 Thu, 01 May 2025 14:06:46 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f88aac7e27sm44626173.138.2025.05.01.14.06.42
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 01 May 2025 14:06:45 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Cl=C3=A9ment=20Mathieu--Drif?=
 <clement.mathieu--drif@eviden.com>, Zhao Liu <zhao1.liu@intel.com>,
 Hanna Reitz <hreitz@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 qemu-block@nongnu.org, Jason Wang <jasowang@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Ani Sinha <anisinha@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Yi Liu <yi.l.liu@intel.com>
Subject: [PATCH 12/18] hw/nvram/fw_cfg: Inline fw_cfg_file_slots()
Date: Thu,  1 May 2025 23:04:50 +0200
Message-ID: <20250501210456.89071-13-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250501210456.89071-1-philmd@linaro.org>
References: <20250501210456.89071-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::12a;
 envelope-from=philmd@linaro.org; helo=mail-il1-x12a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Now than fw_cfg_file_slots() only returns
FW_CFG_FILE_SLOTS_DFLT, we can inline it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/nvram/fw_cfg.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
index 71c41c979d7..de65ee8342e 100644
--- a/hw/nvram/fw_cfg.c
+++ b/hw/nvram/fw_cfg.c
@@ -255,15 +255,10 @@ static void fw_cfg_write(FWCfgState *s, uint8_t value)
     /* nothing, write support removed in QEMU v2.4+ */
 }
 
-static inline uint16_t fw_cfg_file_slots(const FWCfgState *s)
-{
-    return FW_CFG_FILE_SLOTS_DFLT;
-}
-
 /* Note: this function returns an exclusive limit. */
 static inline uint32_t fw_cfg_max_entry(const FWCfgState *s)
 {
-    return FW_CFG_FILE_FIRST + fw_cfg_file_slots(s);
+    return FW_CFG_FILE_FIRST + FW_CFG_FILE_SLOTS_DFLT;
 }
 
 static int fw_cfg_select(FWCfgState *s, uint16_t key)
@@ -845,13 +840,13 @@ void fw_cfg_add_file_callback(FWCfgState *s,  const char *filename,
     int order = 0;
 
     if (!s->files) {
-        dsize = sizeof(uint32_t) + sizeof(FWCfgFile) * fw_cfg_file_slots(s);
+        dsize = sizeof(uint32_t) + sizeof(FWCfgFile) * FW_CFG_FILE_SLOTS_DFLT;
         s->files = g_malloc0(dsize);
         fw_cfg_add_bytes(s, FW_CFG_FILE_DIR, s->files, dsize);
     }
 
     count = be32_to_cpu(s->files->count);
-    assert(count < fw_cfg_file_slots(s));
+    assert(count < FW_CFG_FILE_SLOTS_DFLT);
 
     /* Find the insertion point, sorting by file name. */
     for (index = count;
@@ -926,7 +921,7 @@ void *fw_cfg_modify_file(FWCfgState *s, const char *filename,
         }
     }
 
-    assert(index < fw_cfg_file_slots(s));
+    assert(index < FW_CFG_FILE_SLOTS_DFLT);
 
     /* add new one */
     fw_cfg_add_file_callback(s, filename, NULL, NULL, NULL, data, len, true);
-- 
2.47.1


