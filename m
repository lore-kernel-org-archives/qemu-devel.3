Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0704EC25B74
	for <qemu-devel@archiver.kernel.org>; Sat, 18 May 2024 09:33:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s8GQe-0006Rf-U5; Sat, 18 May 2024 05:32:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1s8GQd-0006Qy-Ar; Sat, 18 May 2024 05:32:35 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1s8GQb-0005s2-TS; Sat, 18 May 2024 05:32:35 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1eeabda8590so29867055ad.0; 
 Sat, 18 May 2024 02:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716024748; x=1716629548; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YYCH+lR4/2YjvBqi8x4eaSiKCuZqVWo68SMXWjlp9FY=;
 b=KqLBVpWqR+d74aYd+2gKFEdk/qHlafNsqT0GC88u8cVnc1URQaxznDTVL1/k9A2Mld
 k48lT46wBSgW6sEgei2OTKXXJ3gViZKJQ0ZDXKfb8kxBfKHJD+dK7osUiXVQzp+jmBxD
 u5vRDOL+uPXeS2mOz5MM26aFOxHgL9GmrQq1Yk8PMul3pPC2OsIoymZ2zXIfpki6hPgt
 u2BTtQ4E6NKw47TjKIhKuoCdhPsY1JLGlyc4oa2umPBvDutqtu7kL9kX1/uo4b41cw4U
 ZdZQn2F7Zd+Pk/uUTImyO78UzWzzEbHIUZukFW1o4Ibj6Hn8w4CfLr79wAjz0k2kRwZB
 lkhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716024748; x=1716629548;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YYCH+lR4/2YjvBqi8x4eaSiKCuZqVWo68SMXWjlp9FY=;
 b=EhwEzHViB6Wm6TQsLKtp6cVJT3EM6xfRCc3yQ4PIR6PqnypaEhJ5vEJjrnQ+dtmS+2
 CMFIcelKki9jixIAoOpFbi/TPjFAPzA0tPO/JzCJ5H7RJP4KIdWetZ83Rn++UooQd+Lm
 Ej1YKLOVzZlQFBaNIPRRnGflNHfaWzpntXg++d19XDw+YC2YyEelyWbdqoIpHzS0N0Xg
 CkJuzuN1OEu04fxYb1ayiN1DzVd3XobL1YY0z5mdUgDjs8+pR0UozSXdGJhJyUOlfcZ9
 WqYEnFLYAgJ7Fqm4Cm2BksGmor0ev8tVbGhc4rKtCmMhc1w+rSubP22QzHojck+hc9Lh
 bPfQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUZqUB30iJpehLQjsFTIXfMSC0v3UNzxw+DxhhtkLENdR3Ltorja7OCnB+Bm8oJ2h/+yvBpaFrib42t+VjaMTP8u+lzGw0=
X-Gm-Message-State: AOJu0YximMdw2FlyHINppltq2fWx3UUj10Lxox7bVWlQQZ6wh0mvt2im
 zjF7PTWp2LlrN1QPqrMQ2LslFakbHdKAZyW+TioDijSGJ4YbpLO1zWzJ0A==
X-Google-Smtp-Source: AGHT+IGO3+dB57JnbLOBM9+84D9gqipt5uLIVcyMMnkPVVCqLrumIQceoDfphrI9/sHa9Ms5+H7UVQ==
X-Received: by 2002:a17:90b:695:b0:2ae:c8fe:a4a4 with SMTP id
 98e67ed59e1d1-2b6ccd8e060mr20860965a91.46.1716024747965; 
 Sat, 18 May 2024 02:32:27 -0700 (PDT)
Received: from wheely.local0.net (110-175-65-7.tpgi.com.au. [110.175.65.7])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2b628ea6a05sm18518901a91.52.2024.05.18.02.32.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 18 May 2024 02:32:27 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Glenn Miles <milesg@linux.vnet.ibm.com>
Subject: [PATCH 06/14] target/ppc: BookE DECAR SPR is 32-bit
Date: Sat, 18 May 2024 19:31:48 +1000
Message-ID: <20240518093157.407144-7-npiggin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240518093157.407144-1-npiggin@gmail.com>
References: <20240518093157.407144-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x636.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

The DECAR SPR is 32-bits width.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/cpu_init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index 71da8d4856..462246cb7d 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -792,7 +792,7 @@ static void register_BookE_sprs(CPUPPCState *env, uint64_t ivor_mask)
                  0x00000000);
     spr_register(env, SPR_BOOKE_DECAR, "DECAR",
                  SPR_NOACCESS, SPR_NOACCESS,
-                 SPR_NOACCESS, &spr_write_generic,
+                 SPR_NOACCESS, &spr_write_generic32,
                  0x00000000);
     /* SPRGs */
     spr_register(env, SPR_USPRG0, "USPRG0",
-- 
2.43.0


