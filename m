Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3479FF8864
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 04:54:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHwqo-000128-95; Wed, 29 Apr 2026 00:48:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wHwql-000115-KS
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 00:48:39 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wHwqk-0008GT-6u
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 00:48:39 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2b45cb89f7eso75746755ad.0
 for <qemu-devel@nongnu.org>; Tue, 28 Apr 2026 21:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777438117; x=1778042917; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zjUGp6dpPz69NZeEvuc53ZXnGIq/CvkiZTgMTbPhfg8=;
 b=D8RGp0y2LO/j54XcRFRv4S6a6Vpeyb7GWpVnXTClpxh+gZfcm2WpkYoCmQonm8zrdO
 Bc49bAed/ByhNCTrngxn6Q7mqUZ3vNbW594Dl2u6KH0YIN+FrwjCVXkffyStB3uJo5zN
 lkqeRkJRSmwY304Vwy9Q+UWljIKr7B6rHf0guGkfFp1GJ7J7f8KDBvQrwjcWCsrS/c81
 v22bTSX61PnGdqD92BnOYsNa7luqcviudBLN705qMyIkpZgQLqv8suj3IywuuaemTCSQ
 1eGeKMVKgMJwcR+feS3t5df8Rk0vCe7NZe8HOW9Vg1BaudUh8Kk4CuM4Iqlx1SOzv4q3
 7f6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777438117; x=1778042917;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zjUGp6dpPz69NZeEvuc53ZXnGIq/CvkiZTgMTbPhfg8=;
 b=lX6fvDCm8mRtKX3iI3SJtJBc0CagMq5YwLk+gqmAKdy0FqqrsKkrYyeXGaI+AFg9WV
 7JTyYMdeQtG9yWS5nnUevSYXJbmWfg8PaMxWo7REPgf9pykqEAho0nVuatoQRb1qy9Z1
 X3pu5zsXGnO3oXR7RGvaSToM4CQubl32SGg3NAAMfabmun2qFmE09ytsyupwZLjMEpyd
 dNsbZAtaiCeVimZhEsozBYQOOcPrfsFkf0VYdEsoxeb/j1bBOjdujwIIcv6czg9Gx7fS
 0uuT5RI5Fs9Qzs+QCJQHhtmnHicKgRlAqR8kfSrGrSwbVHKMTcv2tTrXcJG2Ojj6aPR0
 bryg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/RSePIpyMZand6kdbyjrPRb8utQyuXUV7oAhu3sFDsBftrnIozrfC+FqhBsUOuv3AXm94axUse2dWq@nongnu.org
X-Gm-Message-State: AOJu0Yy3BFBg61bNLDogGKrJ3wO91sJuxdHPXIcvF8s2gfsEMHVHWbyn
 eoux7aJpzL6FEp4tEA2L0AX7YHNfasNlQazvz29nv6nYs2gU5JG5qqcg
X-Gm-Gg: AeBDieujNXDchNFrvWVF91DWGjB7RyT36THp/LLJvWErlkDB+6sbRqdU/G2jLgml73n
 sv5hXbWBGE4+n7X+jhTNhiQuy9657Fh/at2YtA3EJ7YDULqFc60A/7NtgceGQneeovYdK3ST3OW
 h8sXdjUsqBmH76LquTCBQdC3abv8cI197E1woVSpz2HcZ2KOOTCzey5YWMq+se4ctETjoaqwlY0
 eb4GD0baH+bFQ7O+ah2WVG6CcyObruGsab5TMRgRKw3ISOe6YyxNbnoobKiik7mELhi/ua4IJqg
 YCWjyOMj0uUDya6zob+lw9/WIUAErOcOxUtrl4qkBTkQ+yi25JrCzO10UYvFWskfHooCKqIDDD6
 eGbt00/CC43j/UhRicFYboQw8MDb/vyaWhwGI3x6O7JjoTuWD0wXaaW/JzGxQK3Ia8iApwUtSJy
 gTRQYkUrtjztBSsCzeV6l0GHb0jOg59lz4qYuVc/r9wpmuGY8i4Ss5
X-Received: by 2002:a17:902:be02:b0:2b0:61c2:8e83 with SMTP id
 d9443c01a7336-2b97c4b28eemr45625505ad.20.1777438116908; 
 Tue, 28 Apr 2026 21:48:36 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:6209:4521:6813:45b7])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b988772ae8sm7756145ad.7.2026.04.28.21.48.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2026 21:48:36 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: palmer@dabbelt.com, liwei1518@gmail.com, daniel.barboza@oss.qualcomm.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Cc: alistair23@gmail.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 05/51] target/riscv: Use explicit little-endian LD/ST API
Date: Wed, 29 Apr 2026 14:47:06 +1000
Message-ID: <20260429044752.4176397-6-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260429044752.4176397-1-alistair.francis@wdc.com>
References: <20260429044752.4176397-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x629.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

We only build our RISC-V targets as little-endian, therefore
the LD/ST API expands to its little-endian variant. Directly
use the latter.

Mechanical change running:

  $ for a in uw w l q; do \
      sed -i -e "s/ld${a}_p(/ld${a}_le_p(/" \
        $(git grep -wlE '(ld|st)u?[wlq]_p' target/riscv);
    done

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20260318103122.97244-3-philmd@linaro.org>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu_helper.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index dd6c861a90..c28832e0e3 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -1365,9 +1365,9 @@ static int get_physical_address(CPURISCVState *env, hwaddr *physical,
         }
 
         if (riscv_cpu_mxl(env) == MXL_RV32) {
-            pte = address_space_ldl(cs->as, pte_addr, attrs, &res);
+            pte = address_space_ldl_le(cs->as, pte_addr, attrs, &res);
         } else {
-            pte = address_space_ldq(cs->as, pte_addr, attrs, &res);
+            pte = address_space_ldq_le(cs->as, pte_addr, attrs, &res);
         }
 
         if (res != MEMTX_OK) {
-- 
2.53.0


