Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 099A0C48BC4
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 19:28:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcVlK-0006Uo-Bf; Tue, 20 Feb 2024 14:26:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rcVl9-0006Re-29
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 14:26:31 -0500
Received: from mail-ot1-x32f.google.com ([2607:f8b0:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rcVl5-0006VD-1F
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 14:26:30 -0500
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-6e445b4f80bso2114208a34.0
 for <qemu-devel@nongnu.org>; Tue, 20 Feb 2024 11:26:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1708457184; x=1709061984; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XaRxf4QxF/RQQCFPfCuUqg+JQRy+ntcwvI04fnfpoXQ=;
 b=DZFE9aoSifay1b+Vxx7K6cuLNcJf2vOGQWbDxDuE7GCASpZNfKf0gsTA1M+LFPZh1R
 MdJK+qVC0Ra5cMZJCgXu5EW4dRw3boHLi5r5VdYgvONVFmWmwPnNb0fEcCd6F9Lk9ifH
 0JkfM+pjPlrTUyT4XIkHRs/CY5RhJbHl8twe6snx6nxbghyl8oi2Qo78SX11fCpxzmKY
 pcx8WCWzW9iecS87ulVC11iE1Rs/HwZbRqS20pLwkk9QSf9+KCNWUTjqYlMIqoTjV7jM
 az6dVwjaBgkOONSAYstKkDK2Iu+5DdHKdFHq1MwtUkH0QBXoWa8eVXb24Kk3VsMvIlym
 3nxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708457184; x=1709061984;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XaRxf4QxF/RQQCFPfCuUqg+JQRy+ntcwvI04fnfpoXQ=;
 b=xKgIADq+mY2g/qumup1ZwCxPewF6vDtM9A7E6Tzuvqxih7xiwt9s1i80Odge+p0A4C
 DajEhiuztxw3trPGgRTweG5RDr3tdrmVADf3iHbFZtbEK4fHHn6LqAMN7ZeZmhqqPk1N
 8Bx61DTVo1gvxIMm4rcjrrWO6RGio3vvdGz+sQjT9FMVjBk52mPrb+3384rrUh73NBXz
 +r71ncS/TwEPEDvzQF37oQSJMn+OO5eI459wx66YeZu/kKSkWD58XswkT4dJoRsTON6k
 1MTgYcBY5eZnpuDK21KrMPGgqoYsZhqKZA0Zvcd3ByFzq4Mt0FdembTzpUjQcy/H0bhC
 GoZg==
X-Gm-Message-State: AOJu0YxRVpktEBtwb5lPUmgNljW27975Ecv/uOjdDsgRmUUxHSeXMVqm
 H2qGpKAaRgxM4P0Czs2aoAy/ndqQJX695Bq8ng2mXcuXhs28YNb27x5oRU0nFekh2XmIn4Fopgl
 m
X-Google-Smtp-Source: AGHT+IHBOLxTgS7aS/BQYrTVPTnoKynzQBx9YOH+qNBXRXhaAkYZnK+Bgs90VxBnFLB0EAJxzBV+vg==
X-Received: by 2002:a9d:4d19:0:b0:6e2:d8ec:a23c with SMTP id
 n25-20020a9d4d19000000b006e2d8eca23cmr17373672otf.13.1708457184072; 
 Tue, 20 Feb 2024 11:26:24 -0800 (PST)
Received: from grind.dc1.ventanamicro.com ([177.94.15.159])
 by smtp.gmail.com with ESMTPSA id
 i73-20020a636d4c000000b005b458aa0541sm6943005pgc.15.2024.02.20.11.26.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Feb 2024 11:26:23 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 richard.henderson@linaro.org, max.chou@sifive.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v3 3/5] target/riscv/vector_helper.c: set vstart = 0 in
 GEN_VEXT_VSLIDEUP_VX()
Date: Tue, 20 Feb 2024 16:26:05 -0300
Message-ID: <20240220192607.141880-4-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240220192607.141880-1-dbarboza@ventanamicro.com>
References: <20240220192607.141880-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32f;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-ot1-x32f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

The helper isn't setting env->vstart = 0 after its execution, as it is
expected from every vector instruction that completes successfully.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 target/riscv/vector_helper.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index 84cec73eb2..cc7290a1bb 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -4782,6 +4782,7 @@ void HELPER(NAME)(void *vd, void *v0, target_ulong s1, void *vs2,         \
         }                                                                 \
         *((ETYPE *)vd + H(i)) = *((ETYPE *)vs2 + H(i - offset));          \
     }                                                                     \
+    env->vstart = 0;                                                      \
     /* set tail elements to 1s */                                         \
     vext_set_elems_1s(vd, vta, vl * esz, total_elems * esz);              \
 }
-- 
2.43.2


