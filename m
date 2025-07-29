Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D93D9C87FCA
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Jul 2025 00:42:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugup8-000300-NA; Tue, 29 Jul 2025 20:37:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uguMX-0006oy-Ah
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 20:08:05 -0400
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uguMV-00057v-BR
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 20:08:04 -0400
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-31f3b54da19so240222a91.1
 for <qemu-devel@nongnu.org>; Tue, 29 Jul 2025 17:08:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753834082; x=1754438882; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=h3mKJMqydLY1W9tyxTMyrwndX6R0yQFewWeiuoVpWn4=;
 b=fflX9kun3DC20O5AczpSznhGF42/h+C4v9MOcTb6WQhgTRB1FSmtw0Fn5S83lmzAjT
 7kc3XdRkSZQuhnRhy389PK/f5B/qpXbxmFT3oM812rS5HcvH9GkzbymbFWe5+qzNTC7w
 WFizfr1OipplWVU4cm4wO3TnG6V8BHKQOLUaVfOo1Y3q6tdE0NBXBDhYwZyg19jzco/D
 4EBVfifxtpQHIGJ9Y/JKj/AkjDTX/XXmLfp/Jtk7RpkD7sCLLcnlGf5gTo52mZ3TcdLx
 JwSQd1XmPlz+IOhVAkxsOyjOE0lXzv2D2/dpLnh6kYCdPPzQbSQC27/qrEiB+TkLRMZT
 BoyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753834082; x=1754438882;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=h3mKJMqydLY1W9tyxTMyrwndX6R0yQFewWeiuoVpWn4=;
 b=tSURQBJOtF/ocdtD/rFmcWlBrZq/M1Fjv9dI6b3uRqMMBb77hB7havSxI0A9pFhSOH
 1znGNPyv6gxZixU+dK8cMAK8wBrLqsx6dqcBqPQ+0l20isHtRWVJrWHdiRJhcNENgFos
 jEASuWbnIQg078r/Jj2pGBlKZI0ykN+EUINRO07/q0bVZYROqd0+mADuAGC3phvlsfQZ
 S7fWRRgRZp9q/iuD/vTdbXFzM8eHgp+Ktp+SFpzrnfqmLCEURehyXjeOF4Un/Kuq3ryD
 MHWXoK9OKJ1YVlPMpSxIaOhJwSwujO11DDp78alJe04gxmQW7CtHDnF+9P8BAnFdz8B+
 u5zg==
X-Gm-Message-State: AOJu0YzALnptgy1WjvJrAyiSanfgGzokMgUbxL/cxDQ33Wdb2MGElI3z
 oC6Q2wUmR1+fZ8al0TGi8MKok8aNZ+QnqUVFgo45TThraVsqEXVLzIfn9jwoVYxv9jmodW5H0kI
 h5Bel
X-Gm-Gg: ASbGncvi5l1UXACXjHGOo857g/8Zw38z8Gw5gGAQGDf+SeAXQYrZ0Nwt9ixuXun5gB2
 1GoBaRxguobvWiMK/zjJO+hn7FeDBTWDTTMcFYCdEzU1mk4qhOAuzRMdh5/oEAwRxwaX26Zt5Io
 F9fFUFxsRGpus7omjYH1uwK+ttXZKKj5FbBwiACMiVx7rbwjl3bpwE4fHNEIkeGPm0AUX1imEdB
 JcfZ8A3SuaAQee3HVMlHHxm0mcdLBUb4N/qxrHqeKWKK8CZFIoH5n9sSH4bumiL0P1wzhwVhln3
 E1yYOj2Xtz1lRv6uZ+N6kFtlb9Qj3d4wCpCE5gQtO/1IdHTY5OuT5gBM15y5TxCXU+wy4rFB9Jb
 17V8wwdfxcy9OBBdR7zFFCEoMHsxL3ejHJGDkYdp3odV/RZhcNUPVxlSrW0hlnnXctbB5FFIZxP
 tJ6IaJ5WZbjA==
X-Google-Smtp-Source: AGHT+IGns91RM/ual+Mb5+t2Q5mLPpmKA9IhlA7e+rG8zjK3wN1UlxnfVW0/mO8ALwl3T2QIpFHPIg==
X-Received: by 2002:a17:90b:2683:b0:313:1c7b:fc62 with SMTP id
 98e67ed59e1d1-31f5de4bffamr1472573a91.22.1753834081591; 
 Tue, 29 Jul 2025 17:08:01 -0700 (PDT)
Received: from localhost.localdomain (syn-098-150-199-049.res.spectrum.com.
 [98.150.199.49]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-31f63ddfb2asm281868a91.22.2025.07.29.17.08.00
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Jul 2025 17:08:01 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 82/89] linux-user: Remove MAP_DENYWRITE from elfload.c
Date: Tue, 29 Jul 2025 13:59:55 -1000
Message-ID: <20250730000003.599084-83-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250730000003.599084-1-richard.henderson@linaro.org>
References: <20250730000003.599084-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1032.google.com
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

The last use of this fallback was removed in bf858897b769.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/elfload.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 6eb4e31bdb..14d4502b3c 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -105,11 +105,6 @@ int info_is_fdpic(struct image_info *info)
     return info->personality == PER_LINUX_FDPIC;
 }
 
-/* this flag is uneffective under linux too, should be deleted */
-#ifndef MAP_DENYWRITE
-#define MAP_DENYWRITE 0
-#endif
-
 #if TARGET_BIG_ENDIAN
 #define ELF_DATA        ELFDATA2MSB
 #else
-- 
2.43.0


