Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA51C106B534
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2026 21:18:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5VcX-0001M7-Ru; Wed, 25 Mar 2026 17:18:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w5Vc4-000165-7M
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 17:18:05 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w5Vc1-0001XX-Nb
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 17:18:03 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-486fb439299so3038715e9.0
 for <qemu-devel@nongnu.org>; Wed, 25 Mar 2026 14:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774473480; x=1775078280; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3NHfcewKXbZp0JQoxYRv0EAYvd3pedgucecsXHnlRB4=;
 b=xF8e/hCdSc18e59/1M3x7d4exZJGOqKSqqmAzcrxq/NVjkTZYRVcCCLq96smp3hn/U
 Fcb7+OEiHuiJ3ZyiKWz0BEyMFOjthjq4OSYi4NPx2SRi4+jG6x1jufmQOMGXHIyEEBoh
 HEzZAyer2bDOj2upUhPnxI+lc6ZWVf8ZshMc3F4V/Bx0rUI1stc4SYZcDH9WMihgk5Nl
 HR1eujvDsQrYAWTz4tKT/juv4JhrsNMq3xBmGE+wPAUy0G5Q6oHJzUx0jj3i+9xjut2N
 WszzOCNaEulcvn05P18UXx/PYpNFivxmDvpe/8hEJZ0ZUypGuTYjNjJ+o7PEZrCHbEnE
 Ln+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774473480; x=1775078280;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3NHfcewKXbZp0JQoxYRv0EAYvd3pedgucecsXHnlRB4=;
 b=DtTp7AG0j9TfxqzPQhl7wO/j/i9JxlKR40z/TSOYqNN893t6DMVknG3l10KcAxQIOz
 ONTFGhGWiug78sPDBL8p/09pGQMj6ZG9dG5k7uIJjuL9yEcCwZH5MdWTlys/S2Mki28S
 OJEx7Fetge+1+JrpjuuGdfBYs21QRM44Atm8goEPwp9zmCuML1gkWHxqLrhuzhdrCMlT
 529kKRf10tze3+FXgB4mJycEYjodEl/VNlKwQgvSyKYnDVZpoIj8fRBJQQWWy/Qe9kM2
 gEph46w/YvgicF9AO6H++iBXcvLX230tynVS6lL9CtmhvDpLHTlRFtC5vyN9yeqFF2H4
 Fg8Q==
X-Gm-Message-State: AOJu0YzukBLReAIIALFguUL98/8/euc1Lr+ODLJ9Wh64lx4sx/uhSBMO
 n17UlHwmuhV2U6LK7GTnnmhu7PTCu7Z6DaM+OfS7EdvepOlk3cRtFBoTDySfObXrY2EEvVbZmbQ
 Za8WdtDM=
X-Gm-Gg: ATEYQzx7effxamP/8o9ZQxExjVGa7MKZKYCdAMEUc9/TyJBbDBxAcaBfvS1WleNaokN
 tDrJbhvXAWmFt9cgVrzPHmddCpK+MUtev4WQT+mM3yN6oKGDjg7908uP9utZVTU5HOF3Ysg6MMs
 27QQbJblZmy5vhQYySihbCWkqxZ6OmkmcvCLfeoI7amDuQRk6qIhllXfKu3z/fLCvhrtx/EriKt
 Okp1ty1nbltaSUVcESJDinSqV63HJwMYQ88F5FO7MiM+HK5Mr9zmrtgW4B6SsERgNNf5+zvEriC
 KtzZoh95En4ted7PGceCj7+dtlyOpwbIZh/bMGcjpD/S0+p7pk8wu/ju3eqsLrw8PYVpBFDmyDz
 GlLEQG25ZEErfMZOz83rNcaO+Vcin04GINkQlI3MvKXlmphTq6bZ0OZj62mqt6+X8/iHFnnao0z
 YdKlftOTAWmSnMFd2P3VHN0jqR/vB3G4btedD1kmNjclm3rDO0IlsL9MnaNfIZO6okSFMBCaufv
 n8hylmXDvo=
X-Received: by 2002:a05:600c:4343:b0:487:76c:5c97 with SMTP id
 5b1f17b1804b1-4871607e665mr40730755e9.32.1774473479732; 
 Wed, 25 Mar 2026 14:17:59 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4871fb3fc8esm8777515e9.11.2026.03.25.14.17.58
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 25 Mar 2026 14:17:59 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Glenn Miles <milesg@linux.ibm.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Fabiano Rosas <farosas@suse.de>,
 Alistair Francis <alistair.francis@wdc.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-riscv@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Anton Johansson <anjo@rev.ng>,
 Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-11.1 04/10] migration: Remove unused target-specific macros
Date: Wed, 25 Mar 2026 22:17:22 +0100
Message-ID: <20260325211728.89204-5-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260325211728.89204-1-philmd@linaro.org>
References: <20260325211728.89204-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

Last use of VMSTATE_UINTTL_TEST() was removed in commit 445d3facffe
("ppc/spapr: remove deprecated machine pseries-2.7").

The following definitions were added in commit b6c4f71f508 ("Resurrect
the safe part of r5274") but never used:

 - qemu_put_sbetl qemu_put_sbe64
 - qemu_get_sbetl qemu_get_sbe64
 - qemu_put_sbetls qemu_put_sbe64s
 - qemu_get_sbetls qemu_get_sbe64s

Remove all as unused.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/migration/cpu.h | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/include/migration/cpu.h b/include/migration/cpu.h
index e3d6c06b7d4..bb8ecfbeea5 100644
--- a/include/migration/cpu.h
+++ b/include/migration/cpu.h
@@ -12,10 +12,6 @@
 #define qemu_get_betl qemu_get_be64
 #define qemu_put_betls qemu_put_be64s
 #define qemu_get_betls qemu_get_be64s
-#define qemu_put_sbetl qemu_put_sbe64
-#define qemu_get_sbetl qemu_get_sbe64
-#define qemu_put_sbetls qemu_put_sbe64s
-#define qemu_get_sbetls qemu_get_sbe64s
 
 #define VMSTATE_UINTTL_V(_f, _s, _v)                                  \
     VMSTATE_UINT64_V(_f, _s, _v)
@@ -23,18 +19,12 @@
     VMSTATE_UINT64_ARRAY_V(_f, _s, _n, _v)
 #define VMSTATE_UINTTL_SUB_ARRAY(_f, _s, _start, _num)                \
     VMSTATE_UINT64_SUB_ARRAY(_f, _s, _start, _num)
-#define VMSTATE_UINTTL_TEST(_f, _s, _t)                               \
-    VMSTATE_UINT64_TEST(_f, _s, _t)
 #define vmstate_info_uinttl vmstate_info_uint64
 #else
 #define qemu_put_betl qemu_put_be32
 #define qemu_get_betl qemu_get_be32
 #define qemu_put_betls qemu_put_be32s
 #define qemu_get_betls qemu_get_be32s
-#define qemu_put_sbetl qemu_put_sbe32
-#define qemu_get_sbetl qemu_get_sbe32
-#define qemu_put_sbetls qemu_put_sbe32s
-#define qemu_get_sbetls qemu_get_sbe32s
 
 #define VMSTATE_UINTTL_V(_f, _s, _v)                                  \
     VMSTATE_UINT32_V(_f, _s, _v)
@@ -42,8 +32,6 @@
     VMSTATE_UINT32_ARRAY_V(_f, _s, _n, _v)
 #define VMSTATE_UINTTL_SUB_ARRAY(_f, _s, _start, _num)                \
     VMSTATE_UINT32_SUB_ARRAY(_f, _s, _start, _num)
-#define VMSTATE_UINTTL_TEST(_f, _s, _t)                               \
-    VMSTATE_UINT32_TEST(_f, _s, _t)
 #define vmstate_info_uinttl vmstate_info_uint32
 #endif
 
@@ -52,5 +40,4 @@
 #define VMSTATE_UINTTL_ARRAY(_f, _s, _n)                              \
     VMSTATE_UINTTL_ARRAY_V(_f, _s, _n, 0)
 
-
 #endif
-- 
2.53.0


