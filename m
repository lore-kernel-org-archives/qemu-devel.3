Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B81E2D1489F
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 05:37:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdieZ-0001Lb-2w; Thu, 08 Jan 2026 00:33:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vdicW-00086Z-CN
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 00:31:50 -0500
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vdicU-0005eN-VH
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 00:31:40 -0500
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-b6ce6d1d3dcso1399696a12.3
 for <qemu-devel@nongnu.org>; Wed, 07 Jan 2026 21:31:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767850298; x=1768455098; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=QSvSmwU9u2bwYxytywsrfABtfwUSb5K0ZRbLt7j0Qic=;
 b=E6HvMzvDLLO2Z5+CTHVpuKCxk1hJaIyodZ0/rp+kNgEE5U68Y1pdwQVAN93mILlISb
 a+pe4JI+TsicKPIJ85kaZCHdqFif8/rCKH6p3QYxCX/+sdxMZ/GQuVcN7GybC2l7X/Xx
 JC01kmBP+L9+SAg2crLs0lzQ9L4gu2mU8FZBMFRN4tcVDgUY/l2mULC++uoRUs4emh2n
 Jpp4OEaYIiJBpKqQyYLARCCYB8aQk6mgBj+kGgxSgvXH1ZbSdpouQ3NOd5qK4monO4v7
 4TQ9a2gE+eLC6T2yxh7+Oe77qGgvj307nOzcGbCFRNSkJ6PWdKTQsk43iTyQhu1PIMIm
 t0Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767850298; x=1768455098;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=QSvSmwU9u2bwYxytywsrfABtfwUSb5K0ZRbLt7j0Qic=;
 b=rL4tuD5BQ/ItYFOyFAvf9zzN6X/cnE4lbG1V/WHYdW05ADNOlrQnF7pYMYmsrbqXX4
 jeox+h+QSYJMGpjcCAPgRAR7DNaV3GUM07EO3mhzyH07DQkSIYn1hCmKqzBnu4PGLfQn
 tdhG57zdNx+SmUdfA9JJdoyXqW4+yaQguruQEdxqfgvJEIW89Tt9227KgZvdOvek6h5T
 ehXgrfleeA2zShbsWuDhG/68SL97fcna0dYZZcR+16Utmd5Sd5eSqzm3lKz9ZsSCSD8q
 Ayug7nyr1u3M5OPO/+Azn3scdYXrS+org42eUcOaNUYTP7r3mo+i1Rsf23A670BMgccz
 4DbA==
X-Gm-Message-State: AOJu0YxlobMuv5qz6mfBvO7VBpGOUTceiRG3lUUHOtE/M6amc+tdGiV5
 OH1phJXQ52ShhhX8IcNuTiOM6YyL48gNaxAeSHXTGGVorXcN5ub69Z66OKPnI7W7NizR1S/y5nm
 EkI/4LoY=
X-Gm-Gg: AY/fxX7DtjysaPscED4AxnW8mDT9lV76nY+Npv/i+CIaczcJT4XLJoBQw61/5T+bFG7
 35mo+oUqxMKp9kSV0sioV58/ST+6C7+OAHXEzdkrUAqRAPTP+GmQWABdWcWRETPjrqN+YBgD92q
 8TwcUikh+4G8knzToYlQ3/Z3G17Bf+0BtoQRgoUyA6JC8YWDqn7KZ322IkjSn+iKjp+GNGJm4yG
 XLR+XfPad5f3URYjCP6twDeEOKocJBy+DBHJK8elW3Sv9CChDIDOWrKZdzm6JyhtDCGgOJ3JCoD
 Bl94SjPS8j4PIO3MGVP2nxboin+0Xw3YFqxMilwQxHgz0S9PGEIMVzkWkQHTqNm/CU3vJupwyZ4
 gil/+THBOIj7L6apPyv2nVaURA4HC1zKHIlvfG68XsY/SMg1R5wfZf2y38fDP6nIuayaCQhpf0+
 7L7Ixv6B5jirn08n4Wiw==
X-Google-Smtp-Source: AGHT+IGUsSSMMdRdEpcDAGS8y7Dz1eUhLxYCw4oTCjcipkxNVJsROy68DGEL172dGjsZLxWEH9CcNg==
X-Received: by 2002:a05:6a21:339f:b0:35e:11ff:45b4 with SMTP id
 adf61e73a8af0-3898f91d225mr5143170637.21.1767850297551; 
 Wed, 07 Jan 2026 21:31:37 -0800 (PST)
Received: from stoup.. ([180.233.125.201]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c4cc05cd9d9sm7036552a12.16.2026.01.07.21.31.36
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Jan 2026 21:31:37 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 38/50] accel/tcg: Drop CONFIG_ATOMIC64 test from translator.c
Date: Thu,  8 Jan 2026 16:30:06 +1100
Message-ID: <20260108053018.626690-39-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260108053018.626690-1-richard.henderson@linaro.org>
References: <20260108053018.626690-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x532.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/translator.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/accel/tcg/translator.c b/accel/tcg/translator.c
index 034f2f359e..f3eddcbb2e 100644
--- a/accel/tcg/translator.c
+++ b/accel/tcg/translator.c
@@ -352,15 +352,13 @@ static bool translator_ld(CPUArchState *env, DisasContextBase *db,
             return true;
         }
         break;
-#ifdef CONFIG_ATOMIC64
     case 8:
         if (QEMU_IS_ALIGNED(pc, 8)) {
-            uint64_t t = qatomic_read__nocheck((uint64_t *)host);
+            uint64_t t = qatomic_read((uint64_t *)host);
             stq_he_p(dest, t);
             return true;
         }
         break;
-#endif
     }
     /* Unaligned or partial read from the second page is not atomic. */
     memcpy(dest, host, len);
-- 
2.43.0


